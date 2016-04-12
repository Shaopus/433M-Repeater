/*
================================================================================
Copyright   : Ebyte electronic co.,LTD
Website     : http://yh-ebyte.taobao.com
              http://yiheliyong.cn.alibaba.com
Description : This module contains the low level operations for CC1101
================================================================================
*/
#ifndef _CC1101_H_
#define _CC1101_H_

#include "mytypedef.h"		//DO NOT modify
#include "CC1101_REG.h"		//DO NOT modify

/*
================================================================================
------------------------------Internal IMPORT functions-------------------------
you must offer the following functions for this module
1. INT8U SPI_ExchangeByte( INT8U input ); //SPI Send and Receive function
2. CC_CSN_LOW( );                        //Pull down the CSN line
3. CC_CSN_HIGH( );                       //Pull up the CSN Line
================================================================================
*/
#include "main.h"     //import SPI_ExchangeByte( );

#include "STM8l10x_conf.h"
#define CC_CSN_LOW( )   GPIO_ResetBits( GPIOB, GPIO_Pin_4 );\
						while( GPIO_ReadInputDataBit( GPIOB, GPIO_Pin_7 ) != 0 );
#define CC_CSN_HIGH( )  GPIO_SetBits( GPIOB, GPIO_Pin_4 )


/*
================================================================================
-----------------------------------macro definitions----------------------------
================================================================================
*/
typedef enum { TX_MODE, RX_MODE }TRMODE;
typedef enum { BROAD_ALL, BROAD_NO, BROAD_0, BROAD_0AND255 }ADDR_MODE;
typedef enum { BROADCAST, ADDRESS_CHECK} TX_DATA_MODE;

/*
================================================================================
-------------------------------------exported APIs------------------------------
================================================================================
*/

/*read a byte from the specified register*/
INT8U CC1101ReadReg( INT8U addr );

/*Read a status register*/
INT8U CC1101ReadStatus( INT8U addr );

/*Set the device as TX mode or RX mode*/
void CC1101SetTRMode( TRMODE mode );

/*Write a command byte to the device*/
void CC1101WriteCmd( INT8U command );

/*Set the CC1101 into IDLE mode*/
void CC1101SetIdle( void );

/*Send a packet*/
void CC1101SendPacket( INT8U *txbuffer, INT8U size, TX_DATA_MODE mode );

/*Set the address and address mode of the CC1101*/
void CC1101SetAddress( INT8U address, ADDR_MODE AddressMode);

/*Set the SYNC bytes of the CC1101*/
void CC1101SetSYNC( INT16U sync );

/*Receive a packet*/
INT8U CC1101RecPacket( INT8U *rxBuffer );

/*Initialize the WOR function of CC1101*/
void  CC1101WORInit( void );

/*Initialize the CC1101, User can modify it*/
void CC1101Init( void );

void CC1101Sleep(void);

#endif // _CC1101_H_
/*
================================================================================
------------------------------------THE END-------------------------------------
================================================================================
*/
