/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */

#include "main.h"
#define start_add 0x9ff0

void SPI_Initial( void )
{
    //enable clock for SPI bus
	CLK_PeripheralClockConfig(CLK_Peripheral_SPI, ENABLE);
	//Set as default
	SPI_DeInit( );
	//Set the priority of the SPI
	SPI_Init( SPI_FirstBit_MSB, SPI_BaudRatePrescaler_2,
            SPI_Mode_Master, SPI_CPOL_Low, SPI_CPHA_1Edge,
            SPI_Direction_2Lines_FullDuplex, SPI_NSS_Soft );
    //Enable SPi
	SPI_Cmd( ENABLE );
    //Config the GPIOs for SPI bus
	GPIO_Init( GPIOB, GPIO_Pin_7,GPIO_Mode_In_PU_No_IT );
	GPIO_Init( GPIOB, GPIO_Pin_5 | GPIO_Pin_6, GPIO_Mode_Out_PP_High_Slow );
	GPIO_Init( GPIOB, GPIO_Pin_4, GPIO_Mode_Out_PP_High_Slow );
	GPIO_Init( GPIOA, GPIO_Pin_3 | GPIO_Pin_2, GPIO_Mode_In_PU_No_IT );
}

INT8U SPI_ExchangeByte( INT8U input )
{
    //wait for last transmitt finishing
	while (SPI_GetFlagStatus(SPI_FLAG_TXE) == RESET);
	SPI_SendData( input );
	//wait for receiving a byte
	while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
	return SPI_ReceiveData( );
}

void get_serial(void)
{
	uint8_t i;
	uint8_t val[4];
	for(i=0;i<4;i++)
		val[i]	= FLASH_ReadByte(start_add+i);
	printf("0x%x,0x%x,0x%x,0x%x\r\n",(uint8_t)val[0],(uint8_t)val[1],(uint8_t)val[2],(uint8_t)val[3]);
}

void set_serial(void)
{
	uint32_t new_val = 0x01234567;
	/*Define FLASH programming time*/
   FLASH_SetProgrammingTime(FLASH_ProgramTime_Standard);
  /* Unlock flash program memory */
	FLASH_Unlock(FLASH_MemType_Program);

  /* Program word at addres 0x9000*/
  FLASH_ProgramWord(start_add, new_val);	
	printf("set serial number ok\r\n");
}

void LEDInit(void)
{
	GPIO_Init(GPIOB, GPIO_Pin_0, GPIO_Mode_Out_PP_High_Slow);
}

void EXTI_Init(void)
{
	GPIO_Init(GPIOB,  GPIO_Pin_1, GPIO_Mode_In_PU_IT);
	EXTI_SetPinSensitivity(EXTI_Pin_1, EXTI_Trigger_Falling_Low);
}

void rf_exti(void)
{
	GPIO_Init(GPIOA,  GPIO_Pin_2, GPIO_Mode_In_PU_IT);
	EXTI_SetPinSensitivity(EXTI_Pin_2, EXTI_Trigger_Falling_Low);
	
}

void Delay(uint16_t nCount)
{
    /* Decrement nCount value */
    while (nCount != 0)
    {
        nCount--;
    }
}

void AllDeInit(void)
{
	GPIO_DeInit(GPIOA);
	GPIO_DeInit(GPIOB);
	GPIO_DeInit(GPIOC);
	GPIO_DeInit(GPIOD);
	
	GPIO_Init(GPIOA,  GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3, GPIO_Mode_Out_OD_Low_Slow);
	GPIO_Init(GPIOB,  GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3|GPIO_Pin_4|GPIO_Pin_5|GPIO_Pin_6|GPIO_Pin_7, GPIO_Mode_Out_OD_Low_Slow);
	GPIO_Init(GPIOC,  GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3|GPIO_Pin_4, GPIO_Mode_Out_OD_Low_Slow);	
	GPIO_Init(GPIOD,  GPIO_Pin_0, GPIO_Mode_Out_OD_Low_Slow);	
	
	GPIOA->ODR = 0x00;
	GPIOB->ODR = 0x00;
	GPIOC->ODR = 0x00;
	GPIOD->ODR = 0x00;
	//PWR_FastWakeUpCmd(DISABLE);
	//PWR_UltraLowPowerCmd(ENABLE);
}
#define RELOAD_VALUE   254
void IWDG_Config(void)
{
#if 0
	IWDG->KR=0xCC;//启动IWDG?
	IWDG->KR=0x55;//解除?PR?及?RLR?的写保护?
	IWDG->RLR=0xff;//看门狗计数器重装载数值??????????
	IWDG->PR=0x06;//分频系数为64?1.02s?
	IWDG->KR=0xAA;//刷新IDDG，避免产生看门狗复位，同时恢复?PR?及?RLR?的写保护状态?
#else
	//需要先启动才能操作
  /* Enable IWDG (the LSI oscillator will be enabled by hardware) */
  IWDG_Enable();
	
	/* IWDG timeout equal to 214 ms (the timeout may varies due to LSI frequency
     dispersion) */
  /* Enable write access to IWDG_PR and IWDG_RLR registers */
  IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
  
  /* IWDG configuration: IWDG is clocked by LSI = 38KHz */
  IWDG_SetPrescaler(IWDG_Prescaler_32);
  
  /* IWDG timeout equal to 214.7 ms (the timeout may varies due to LSI frequency dispersion) */
  /* IWDG timeout = (RELOAD_VALUE + 1) * Prescaler / LSI 
                  = (254 + 1) * 32 / 38 000 
                  = 214.7 ms */
  IWDG_SetReload((uint8_t)RELOAD_VALUE);
  
  /* Reload IWDG counter */
  IWDG_ReloadCounter();
  

#endif
}
u8 wait_rf_low(void)
{
	u16 cnt=0;
	while(GPIO_ReadInputDataBit(GPIOA,GPIO_Pin_2) != 0 )
	{
		cnt++;
		if(cnt>10000)
			return 0;
	}
	return 1;
}
u8 wait_rf_hight(void)
{
	u16 cnt=0;
	while(GPIO_ReadInputDataBit(GPIOA,GPIO_Pin_2) == 0 )
	{
		cnt++;
		if(cnt>10000)
			return 0;
	}
	return 1;
}

u8 wait_rf(void)
{
	u8 re = wait_rf_low();
	if(re)
	{
		re = wait_rf_hight();
	}	
	return re;		
}
int rf_get_rssi(u8 buf)
{
	u8 db = buf;
	int t;
	if(db>=128)
	{
		t = db-256;
		t = t/2;
		t = t-74;
	}
	else if(db<128)
	{
		t = db/2;
		t = t-74;
	}
	return t;
}
void HexToString(u8* buf,u8 size,u8 len)
{
	int i;
	char *data;
	data = (u8*)malloc(size);
	for(i=0;i<len;i++)
	{
		sprintf(data+2*i,"%x%x",(buf[i]&0xF0)>>4,(buf[i]&0xF));
	}
	USART_SendStr("ID:");
	USART_SendStr(data);
	USART_SendStr(" ");
}
void RfType(u8* buf,u8 size,u8 len)
{
	u8 type;
	USART_SendStr("设备:");
	type = (buf[2]&0xf0)>>4;
	switch(type)
	{
		case 0x01:
				USART_SendStr("遥控器 ");
		break;
		
		case 0x02:
				USART_SendStr("门磁   ");
		break;
		
		case 0x03:
				USART_SendStr("红外   ");
		break;
		
		case 0x04:
				USART_SendStr("烟感   ");
		break;
		
		default:
			  USART_SendStr("未知   ");
		break;
	}
	HexToString(buf,size,len);	
}
extern void CC1101ClrRXBuff( void );
volatile u8 rev_flag;
u8 sys_cnt=0;
void main(void)
{
	u8 stats = 0;
	u8 buf[12] = {0,0,0,0,0};
	u8 len;
	CLK_MasterPrescalerConfig(CLK_MasterPrescaler_HSIDiv1);
	USART_Config();
	SPI_Initial();

	CC1101Init();
	CC1101ClrRXBuff();
	CC1101SetTRMode(RX_MODE);	
	yy_init();
	IWDG_Config();
	//rf_exti();
	enableInterrupts();
	//printf("sys init success\r\n");
	sys_cnt=0;
	while(1)
	{
		
		//Wait_Low(GPIOA,GPIO_Pin_2);
		//Wait_High(GPIOA,GPIO_Pin_2);
		IWDG_ReloadCounter(); 		
		if(wait_rf()!=0)
		{
			sys_cnt=0;
			len = CC1101RecPacket(&buf[0]);
			if(len==9)
			{		
				//buf[0] = 0x55;
				//buf[0] += 1;
				buf[9] = CC1101ReadStatus(CC1101_RSSI);
				CC1101SetTRMode(TX_MODE);			
				CC1101SendPacket(buf,9, ADDRESS_CHECK);
				disableInterrupts();
				//uart_sendmultchar(len,&buf[0]);
				RfType(buf,16,9);
				printf("DB:%d dBm",rf_get_rssi(buf[9]));
				enableInterrupts();
	
			}	
			CC1101Init();
			CC1101ClrRXBuff();
			CC1101SetTRMode(RX_MODE);
	
			Delay(10000);
		}
		else
		{
			//待测
			sys_cnt++;
			if(sys_cnt>=0xff)
			{
				sys_cnt = 0;
				CC1101Init();
				CC1101ClrRXBuff();
				CC1101SetTRMode(RX_MODE);

				Delay(10000);			
			}	
		}

	}
}
