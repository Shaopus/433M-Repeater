#include "yy.h"
#define GPIO_BUSY		GPIO_Pin_0
#define GPIO_DAT		GPIO_Pin_2
#define GPIO_RST		GPIO_Pin_3
#define GPIO_KEY		GPIO_Pin_1


#define YY_BUSY			(GPIO_ReadInputDataBit(GPIOB,GPIO_BUSY) == 0)//PB0
#define YY_NOTBUSY	(GPIO_ReadInputDataBit(GPIOB,GPIO_BUSY) != 0)//PB0
#define YY_DAT_H		GPIO_SetBits(GPIOB,GPIO_DAT)//PB1
#define YY_DAT_L		GPIO_ResetBits(GPIOB,GPIO_DAT)
#define YY_RST_H		GPIO_SetBits(GPIOB,GPIO_RST)//PB2
#define YY_RST_L		GPIO_ResetBits(GPIOB,GPIO_RST)//PB2

volatile u8 yy_stats = IDLE;
volatile u8 op = STOP;
volatile u8 yy = 0;
volatile u8 s_cnt = 0;
volatile u8 yy_nr[20]={0};
volatile u8 yy_cnt = 0;
volatile u8 nr_cnt = 0;

static void TIM4_Config(void)
{
  /* Enable TIM4 CLK */
  CLK_PeripheralClockConfig(CLK_Peripheral_TIM4, ENABLE);
  
  TIM4_DeInit();
  
  /* Time base configuration */ 
  TIM4_TimeBaseInit(TIM4_Prescaler_64, 0xFF);
  TIM4_ITConfig(TIM4_IT_Update, ENABLE);
  
  enableInterrupts();

  /* Enable TIM4 */
  TIM4_Cmd(ENABLE);
	TIM4_SetCounter(0);
}
void key_work(void);
void time4_handle(void)
{
	//disableInterrupts();
	
	key_work();
	switch (yy_stats)
	{
		case IDLE:
			if(op == START || op == RUNNING)
			{
				yy = yy_nr[yy_cnt]+yy_nr[yy_cnt];
				s_cnt = 0;
				if(yy_cnt+1 < nr_cnt)
					op = RUNNING;
				else
					op = STOP;
				yy_cnt ++;
				YY_RST_H;
				YY_DAT_L;
				yy_stats = S1;
				//printf("S\r\n");
			}
		break;
		case S1:
			YY_RST_L;
			yy_stats =  WT;
	
		break;			
		case WT:
			if(s_cnt&0x01)//奇数
			{
				YY_DAT_L;
			}
			else//偶数次
			{
				YY_DAT_H;
			}
			//yy--;
			s_cnt ++;
			if(yy==s_cnt+1)
			{			
				yy_stats = BUSY;
			}
			break;		
		case BUSY:
			if(YY_NOTBUSY || op == START)
			{
				yy_stats = IDLE;
				yy = 0;
				s_cnt = 0;
				YY_RST_L;
				YY_DAT_L;
				//printf("T\r\n");
			}	
			
		break;	
	}
	
	//enableInterrupts();	
}
void key_init(void)
{
	GPIO_Init( GPIOB, GPIO_Pin_1, GPIO_Mode_In_PU_No_IT );
	GPIO_Init( GPIOA, GPIO_Pin_3, GPIO_Mode_In_PU_No_IT );
}
void yy_init(void)
{
	//定时器
	TIM4_Config();
	//管脚
	GPIO_Init( GPIOB, GPIO_BUSY, GPIO_Mode_In_FL_No_IT );
	GPIO_Init( GPIOB, GPIO_DAT|GPIO_RST, GPIO_Mode_Out_PP_High_Fast );
	
	//GPIO_Init( GPIOB, GPIO_Pin_3, GPIO_Mode_Out_PP_High_Slow );
	YY_RST_L;
	YY_DAT_L;
	
	key_init();
}

void yy_start(u8 cnt,u8 * nr)
{
	u8 i;

	for(i=0;i<cnt;i++)
	{
		yy_nr[i]=nr[i];
		if(yy_nr[i] > MAX_NUM || yy_nr[i] <MIN_NUM)
			return;
	}	
	op = START;
	nr_cnt = cnt;
	yy_cnt = 0;
	//yy_nr = nr[0];
	//printf("yystart %x\n",cnt);	
}

u8 get_key2(u8 Trg,u8 Count)
{
	static u8 key2_cnt = 0;
	static u8 s1 = 0;
	u8 key = NOKEY;
	if(Trg & 1<<1)
	{
		s1 = 1;
		//printf("Trg\r\n");
	}
	if(Count & 1<<1)
	{
		key2_cnt++;
	}
	else if((Count & 1<<1)==0 && s1 == 1)
	{
		key2_cnt=0;
		s1 = 0;
		key = KEY1;
		//printf("KEY\r\n");
	}
	else
	{
		key2_cnt=0;
		s1 = 0;
	}	
	if(key2_cnt>100 && s1 == 1)
	{
		s1 = 0;
		key2_cnt = 0;
		key = LONGKEY;
		//return LONGKEY;
		//printf("long key\r\n");
	}
	return key;
}

u8 get_key1(u8 Trg,u8 Count)
{
	static u8 key1_cnt = 0;
	static u8 s1 = 0;
	u8 key = NOKEY;
	if(Trg & 1<<0)
	{
		s1 = 1;
		//printf("Trg\r\n");
	}
	if(Count & 1<<0)
	{
		key1_cnt++;
	}
	else if((Count & 1<<0)==0 && s1 == 1)
	{
		key1_cnt=0;
		s1 = 0;
		key = KEY1;
		//printf("KEY\r\n");
	}
	else
	{
		key1_cnt=0;
		s1 = 0;
	}	
	if(key1_cnt>100 && s1 == 1)
	{
		s1 = 0;
		key1_cnt = 0;
		key = LONGKEY;
		//return LONGKEY;
		//printf("long key\r\n");
	}
	return key;
}
volatile unsigned char Trg	= 0x00;
volatile unsigned char Count	= 0x00;
u8 key_scan(void)
{
	u8 key = 0;
	u8 ReadData = 0;
	u8 buf[3] = {0x55,1,0};
	ReadData = (GPIOB->IDR & GPIO_Pin_1)>>1;
	ReadData |= (GPIOA->IDR & GPIO_Pin_3)>>2;
	ReadData |= 0xfc;	//只有2个KEY
	
	//以上还都是读KEY开始处理
	ReadData = ReadData^0xff;
	Trg = (ReadData^Count)&ReadData;
	Count = ReadData;
	key = get_key1(Trg,Count);
	if(key == LONGKEY)
	{
		buf[2] = 0x01;
		uart_sendmultchar(3,&buf[0]);
	}	
		//printf("LONGKEY EVENT\r\n");
	else if(key == KEY1)
	{
		buf[2] = 0x02;
		uart_sendmultchar(3,&buf[0]);
	}
	key = get_key2(Trg,Count);
	if(key == LONGKEY)
	{
		buf[2] = 0x03;
		uart_sendmultchar(3,&buf[0]);
	}	
		//printf("LONGKEY EVENT\r\n");
	else if(key == KEY1)
	{
		buf[2] = 0x04;
		uart_sendmultchar(3,&buf[0]);
	}	

	key = NOKEY;
}

u16 scan_cnt = 0;
void key_work(void)
{
	scan_cnt++;
	if(scan_cnt == 20)
	{
		key_scan();
		scan_cnt = 0;
	}

}

