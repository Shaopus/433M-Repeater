#ifndef USART_H
#define USART_H

#include "main.h"
void USART_Config(void);
void USART_SendStr(char * str);
void uart_sendmultchar(int n,char * ch);

#endif