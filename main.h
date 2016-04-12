#ifndef MAIN_H
#define MAIN_H

#include "stm8l10x_conf.h"
#include "stm8l10x.h"
#include "stdio.h"
#include "usart.h"
#include "cc1101.h"
#include "yy.h"

#include "mytypedef.h"

/*turn on the LED*/
#define LED_On( )       GPIO_ResetBits( GPIOB, GPIO_Pin_0 )

/*turn off the LED*/
#define LED_Off( )      GPIO_SetBits( GPIOB, GPIO_Pin_0 )

/*toggle the LED*/
#define LED_Toggle( )   GPIO_ToggleBits( GPIOB, GPIO_Pin_0 )

//等待某个GPIO口拉低
#define Wait_Low(GPIO,GPIO_Pin)	while(GPIO_ReadInputDataBit(GPIO,GPIO_Pin) != 0 )
#define Wait_High(GPIO,GPIO_Pin)	while(GPIO_ReadInputDataBit(GPIO,GPIO_Pin) == 0 )

INT8U SPI_ExchangeByte( INT8U input );



#endif