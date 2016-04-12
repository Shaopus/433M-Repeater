/*
by ysh
*/
#include "usart.h"
#define CLI
#define SEI
#ifdef _RAISONANCE_
 #define PUTCHAR_PROTOTYPE int putchar (char c)
 #define GETCHAR_PROTOTYPE int getchar (void)
#elif defined (_COSMIC_)
 #define PUTCHAR_PROTOTYPE char putchar (char c)
 #define GETCHAR_PROTOTYPE char getchar (void)
#else /* _IAR_ */
 #define PUTCHAR_PROTOTYPE int putchar (int c)
 #define GETCHAR_PROTOTYPE int getchar (void)
#endif

#define TX_BUFFER_SIZE 32
u8 tx_buffer[TX_BUFFER_SIZE];
volatile u8 tx_wr_index=0;
volatile u8 tx_rd_index=0;
volatile u8 tx_auto=0;

char txbuf_getchar(char *ch)
{
	if(tx_rd_index%TX_BUFFER_SIZE == tx_wr_index%TX_BUFFER_SIZE)//Пе
       return 0;   	
	   	
	*ch = tx_buffer[tx_rd_index];
	tx_rd_index += 1;
	tx_rd_index %= TX_BUFFER_SIZE;
    return 1;	  
}

void put_txbuff(char c)
{
	while((tx_wr_index+1)%TX_BUFFER_SIZE == tx_rd_index%TX_BUFFER_SIZE)//Тњ
	{}	
	tx_buffer[tx_wr_index]=c;
	tx_wr_index += 1;
	tx_wr_index %= TX_BUFFER_SIZE;
}
void UART1_process(void)
{
	char tmp;
	if (txbuf_getchar(&tmp))
	{
		//UDR=tx_buffer[tx_rd_index];
		//USART_SendData(USART1,tmp);	
		USART_SendData8(tmp);
	}
	else
	{ 		
		//USART_ITConfig(USART1, USART_IT_TC, DISABLE);
		USART_ITConfig(USART_IT_TXE, DISABLE);	
		tx_auto=0;
	}
		
}

void uart0_putchar(char c)
{	
	if (tx_auto == 0/* || ((USART->SR & (1<<7))==0)*/) 
	{
		/*USART_ITConfig(USART_IT_TXE, ENABLE);	
		if(USART_GetFlagStatus(USART_IT_TXE) == SET)
			USART_SendData8(c);
		else*/
		{
			while(USART_GetFlagStatus(USART_IT_TXE) == RESET);
			USART_SendData8(c);
			USART_ITConfig(USART_IT_TXE, ENABLE);	
			tx_auto = 1;
			//put_txbuff(c);
		}
	}
	else
	{
		//
		put_txbuff(c);
		
	}
}
void uart0_putstr(char *s)
{
	while (*s)
	{
		uart0_putchar(*s);
		s++;
	}
}

void USART_Config(void)
{
    /* High speed internal clock prescaler: 1*/
    CLK_MasterPrescalerConfig(CLK_MasterPrescaler_HSIDiv1);
 
     /*Set the USART RX and USART TX at high level*/
    GPIO_ExternalPullUpConfig(GPIOC,GPIO_Pin_2|GPIO_Pin_3, ENABLE);
    
    /* Enable USART clock */
    CLK_PeripheralClockConfig(CLK_Peripheral_USART, ENABLE);
    
    USART_DeInit();
    /* USART configuration ------------------------------------------------------*/
    /* USART configured as follow:
          - BaudRate = 115200 baud  
          - Word Length = 8 Bits
          - One Stop Bit
          - No parity
          - Receive and transmit enabled
    */
     USART_Init((uint32_t)115200, USART_WordLength_8D, USART_StopBits_1,
                USART_Parity_No, (USART_Mode_TypeDef)(USART_Mode_Rx | USART_Mode_Tx));
								
		USART_ITConfig(USART_IT_RXNE, ENABLE);	

}
void uart_sendchar(char c)
{
  USART_SendData8(c);
  while (USART_GetFlagStatus(USART_FLAG_TXE) == RESET);	
}
void uart_sendmultchar(int n,char * ch)
{
	int i = 0;
	while(i<n)
	{
		uart0_putchar(ch[i++]);
	}
}
void USART_SendStr(char * str)
{
	while((*str)!='\0')
	{
	  USART_SendData8(*str++);
		while (USART_GetFlagStatus(USART_FLAG_TXE) == RESET);	
	}
}
PUTCHAR_PROTOTYPE
{
  /* Write a character to the USART */
  //USART_SendData8(c);
  uart0_putchar(c);
  /* Loop until the end of transmission */
	
  //while (USART_GetFlagStatus(USART_FLAG_TXE) == RESET);

  return (c);
}

#define MAX_LEN	20
enum
{
	RX_IDLE=0,
	RX_S1,
	RX_S2,
	RX_S3
};

volatile u8 len;
u8 buf[MAX_LEN];

u8 rx_stats = RX_IDLE;

extern void yy_start(u8 cnt,u8 * nr);
void usart_rx_handler(u8 data)
{
	static u8 cnt=0;
	switch (rx_stats)
	{
		case RX_IDLE:
			if(data == 0x55)
				rx_stats = RX_S1;
		break;		
		case RX_S1:
			if(data > MAX_LEN)
			{
				rx_stats = RX_IDLE;
				len = 0;				
			}
			else
			{
				rx_stats = RX_S2;		
				len = data;
				cnt = 0;
			}
		break;		
		case RX_S2:
		buf[cnt++] = data;
		if(cnt == len)
		{
			
			yy_start(len,buf);
			rx_stats = RX_IDLE;
			len = 0;
			cnt = 0;
		}		
		break;
	}

}



