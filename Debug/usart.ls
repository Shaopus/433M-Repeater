   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     	bsct
  16  0000               _tx_wr_index:
  17  0000 00            	dc.b	0
  18  0001               _tx_rd_index:
  19  0001 00            	dc.b	0
  20  0002               _tx_auto:
  21  0002 00            	dc.b	0
  65                     ; 24 char txbuf_getchar(char *ch)
  65                     ; 25 {
  67                     	switch	.text
  68  0000               _txbuf_getchar:
  70  0000 89            	pushw	x
  71  0001 88            	push	a
  72       00000001      OFST:	set	1
  75                     ; 26 	if(tx_rd_index%TX_BUFFER_SIZE == tx_wr_index%TX_BUFFER_SIZE)//Пе
  77  0002 b600          	ld	a,_tx_wr_index
  78  0004 a41f          	and	a,#31
  79  0006 6b01          	ld	(OFST+0,sp),a
  80  0008 b601          	ld	a,_tx_rd_index
  81  000a a41f          	and	a,#31
  82  000c 1101          	cp	a,(OFST+0,sp)
  83  000e 2603          	jrne	L72
  84                     ; 27        return 0;   	
  86  0010 4f            	clr	a
  88  0011 2013          	jra	L6
  89  0013               L72:
  90                     ; 29 	*ch = tx_buffer[tx_rd_index];
  92  0013 b601          	ld	a,_tx_rd_index
  93  0015 5f            	clrw	x
  94  0016 97            	ld	xl,a
  95  0017 e615          	ld	a,(_tx_buffer,x)
  96  0019 1e02          	ldw	x,(OFST+1,sp)
  97  001b f7            	ld	(x),a
  98                     ; 30 	tx_rd_index += 1;
 100  001c 3c01          	inc	_tx_rd_index
 101                     ; 31 	tx_rd_index %= TX_BUFFER_SIZE;
 103  001e b601          	ld	a,_tx_rd_index
 104  0020 a41f          	and	a,#31
 105  0022 b701          	ld	_tx_rd_index,a
 106                     ; 32     return 1;	  
 108  0024 a601          	ld	a,#1
 110  0026               L6:
 112  0026 5b03          	addw	sp,#3
 113  0028 81            	ret
 150                     ; 35 void put_txbuff(char c)
 150                     ; 36 {
 151                     	switch	.text
 152  0029               _put_txbuff:
 154  0029 88            	push	a
 155       00000000      OFST:	set	0
 158  002a               L15:
 159                     ; 37 	while((tx_wr_index+1)%TX_BUFFER_SIZE == tx_rd_index%TX_BUFFER_SIZE)//Тњ
 161  002a b600          	ld	a,_tx_wr_index
 162  002c 5f            	clrw	x
 163  002d 97            	ld	xl,a
 164  002e 5c            	incw	x
 165  002f a620          	ld	a,#32
 166  0031 cd0000        	call	c_smodx
 168  0034 b601          	ld	a,_tx_rd_index
 169  0036 a41f          	and	a,#31
 170  0038 905f          	clrw	y
 171  003a 9097          	ld	yl,a
 172  003c 90bf00        	ldw	c_y,y
 173  003f b300          	cpw	x,c_y
 174  0041 27e7          	jreq	L15
 175                     ; 39 	tx_buffer[tx_wr_index]=c;
 177  0043 b600          	ld	a,_tx_wr_index
 178  0045 5f            	clrw	x
 179  0046 97            	ld	xl,a
 180  0047 7b01          	ld	a,(OFST+1,sp)
 181  0049 e715          	ld	(_tx_buffer,x),a
 182                     ; 40 	tx_wr_index += 1;
 184  004b 3c00          	inc	_tx_wr_index
 185                     ; 41 	tx_wr_index %= TX_BUFFER_SIZE;
 187  004d b600          	ld	a,_tx_wr_index
 188  004f a41f          	and	a,#31
 189  0051 b700          	ld	_tx_wr_index,a
 190                     ; 42 }
 193  0053 84            	pop	a
 194  0054 81            	ret
 232                     ; 43 void UART1_process(void)
 232                     ; 44 {
 233                     	switch	.text
 234  0055               _UART1_process:
 236  0055 88            	push	a
 237       00000001      OFST:	set	1
 240                     ; 46 	if (txbuf_getchar(&tmp))
 242  0056 96            	ldw	x,sp
 243  0057 1c0001        	addw	x,#OFST+0
 244  005a ada4          	call	_txbuf_getchar
 246  005c 4d            	tnz	a
 247  005d 2707          	jreq	L37
 248                     ; 50 		USART_SendData8(tmp);
 250  005f 7b01          	ld	a,(OFST+0,sp)
 251  0061 cd0000        	call	_USART_SendData8
 254  0064 200b          	jra	L57
 255  0066               L37:
 256                     ; 55 		USART_ITConfig(USART_IT_TXE, DISABLE);	
 258  0066 4b00          	push	#0
 259  0068 ae0277        	ldw	x,#631
 260  006b cd0000        	call	_USART_ITConfig
 262  006e 84            	pop	a
 263                     ; 56 		tx_auto=0;
 265  006f 3f02          	clr	_tx_auto
 266  0071               L57:
 267                     ; 59 }
 270  0071 84            	pop	a
 271  0072 81            	ret
 310                     ; 61 void uart0_putchar(char c)
 310                     ; 62 {	
 311                     	switch	.text
 312  0073               _uart0_putchar:
 314  0073 88            	push	a
 315       00000000      OFST:	set	0
 318                     ; 63 	if (tx_auto == 0/* || ((USART->SR & (1<<7))==0)*/) 
 320  0074 3d02          	tnz	_tx_auto
 321  0076 261d          	jrne	L511
 323  0078               L121:
 324                     ; 70 			while(USART_GetFlagStatus(USART_IT_TXE) == RESET);
 326  0078 ae0277        	ldw	x,#631
 327  007b cd0000        	call	_USART_GetFlagStatus
 329  007e 4d            	tnz	a
 330  007f 27f7          	jreq	L121
 331                     ; 71 			USART_SendData8(c);
 333  0081 7b01          	ld	a,(OFST+1,sp)
 334  0083 cd0000        	call	_USART_SendData8
 336                     ; 72 			USART_ITConfig(USART_IT_TXE, ENABLE);	
 338  0086 4b01          	push	#1
 339  0088 ae0277        	ldw	x,#631
 340  008b cd0000        	call	_USART_ITConfig
 342  008e 84            	pop	a
 343                     ; 73 			tx_auto = 1;
 345  008f 35010002      	mov	_tx_auto,#1
 347  0093 2004          	jra	L521
 348  0095               L511:
 349                     ; 80 		put_txbuff(c);
 351  0095 7b01          	ld	a,(OFST+1,sp)
 352  0097 ad90          	call	_put_txbuff
 354  0099               L521:
 355                     ; 83 }
 358  0099 84            	pop	a
 359  009a 81            	ret
 395                     ; 84 void uart0_putstr(char *s)
 395                     ; 85 {
 396                     	switch	.text
 397  009b               _uart0_putstr:
 399  009b 89            	pushw	x
 400       00000000      OFST:	set	0
 403  009c 200c          	jra	L741
 404  009e               L541:
 405                     ; 88 		uart0_putchar(*s);
 407  009e 1e01          	ldw	x,(OFST+1,sp)
 408  00a0 f6            	ld	a,(x)
 409  00a1 add0          	call	_uart0_putchar
 411                     ; 89 		s++;
 413  00a3 1e01          	ldw	x,(OFST+1,sp)
 414  00a5 1c0001        	addw	x,#1
 415  00a8 1f01          	ldw	(OFST+1,sp),x
 416  00aa               L741:
 417                     ; 86 	while (*s)
 419  00aa 1e01          	ldw	x,(OFST+1,sp)
 420  00ac 7d            	tnz	(x)
 421  00ad 26ef          	jrne	L541
 422                     ; 91 }
 425  00af 85            	popw	x
 426  00b0 81            	ret
 455                     ; 93 void USART_Config(void)
 455                     ; 94 {
 456                     	switch	.text
 457  00b1               _USART_Config:
 461                     ; 96     CLK_MasterPrescalerConfig(CLK_MasterPrescaler_HSIDiv1);
 463  00b1 4f            	clr	a
 464  00b2 cd0000        	call	_CLK_MasterPrescalerConfig
 466                     ; 99     GPIO_ExternalPullUpConfig(GPIOC,GPIO_Pin_2|GPIO_Pin_3, ENABLE);
 468  00b5 4b01          	push	#1
 469  00b7 4b0c          	push	#12
 470  00b9 ae500a        	ldw	x,#20490
 471  00bc cd0000        	call	_GPIO_ExternalPullUpConfig
 473  00bf 85            	popw	x
 474                     ; 102     CLK_PeripheralClockConfig(CLK_Peripheral_USART, ENABLE);
 476  00c0 ae0001        	ldw	x,#1
 477  00c3 a620          	ld	a,#32
 478  00c5 95            	ld	xh,a
 479  00c6 cd0000        	call	_CLK_PeripheralClockConfig
 481                     ; 104     USART_DeInit();
 483  00c9 cd0000        	call	_USART_DeInit
 485                     ; 113      USART_Init((uint32_t)115200, USART_WordLength_8D, USART_StopBits_1,
 485                     ; 114                 USART_Parity_No, (USART_Mode_TypeDef)(USART_Mode_Rx | USART_Mode_Tx));
 487  00cc 4b0c          	push	#12
 488  00ce 4b00          	push	#0
 489  00d0 4b00          	push	#0
 490  00d2 4b00          	push	#0
 491  00d4 aec200        	ldw	x,#49664
 492  00d7 89            	pushw	x
 493  00d8 ae0001        	ldw	x,#1
 494  00db 89            	pushw	x
 495  00dc cd0000        	call	_USART_Init
 497  00df 5b08          	addw	sp,#8
 498                     ; 116 		USART_ITConfig(USART_IT_RXNE, ENABLE);	
 500  00e1 4b01          	push	#1
 501  00e3 ae0255        	ldw	x,#597
 502  00e6 cd0000        	call	_USART_ITConfig
 504  00e9 84            	pop	a
 505                     ; 118 }
 508  00ea 81            	ret
 544                     ; 119 void uart_sendchar(char c)
 544                     ; 120 {
 545                     	switch	.text
 546  00eb               _uart_sendchar:
 550                     ; 121   USART_SendData8(c);
 552  00eb cd0000        	call	_USART_SendData8
 555  00ee               L302:
 556                     ; 122   while (USART_GetFlagStatus(USART_FLAG_TXE) == RESET);	
 558  00ee ae0080        	ldw	x,#128
 559  00f1 cd0000        	call	_USART_GetFlagStatus
 561  00f4 4d            	tnz	a
 562  00f5 27f7          	jreq	L302
 563                     ; 123 }
 566  00f7 81            	ret
 620                     ; 124 void uart_sendmultchar(int n,char * ch)
 620                     ; 125 {
 621                     	switch	.text
 622  00f8               _uart_sendmultchar:
 624  00f8 89            	pushw	x
 625  00f9 89            	pushw	x
 626       00000002      OFST:	set	2
 629                     ; 126 	int i = 0;
 631  00fa 5f            	clrw	x
 632  00fb 1f01          	ldw	(OFST-1,sp),x
 634  00fd 2011          	jra	L142
 635  00ff               L532:
 636                     ; 129 		uart0_putchar(ch[i++]);
 638  00ff 1e01          	ldw	x,(OFST-1,sp)
 639  0101 1c0001        	addw	x,#1
 640  0104 1f01          	ldw	(OFST-1,sp),x
 641  0106 1d0001        	subw	x,#1
 642  0109 72fb07        	addw	x,(OFST+5,sp)
 643  010c f6            	ld	a,(x)
 644  010d cd0073        	call	_uart0_putchar
 646  0110               L142:
 647                     ; 127 	while(i<n)
 649  0110 9c            	rvf
 650  0111 1e01          	ldw	x,(OFST-1,sp)
 651  0113 1303          	cpw	x,(OFST+1,sp)
 652  0115 2fe8          	jrslt	L532
 653                     ; 131 }
 656  0117 5b04          	addw	sp,#4
 657  0119 81            	ret
 694                     ; 132 void USART_SendStr(char * str)
 694                     ; 133 {
 695                     	switch	.text
 696  011a               _USART_SendStr:
 698  011a 89            	pushw	x
 699       00000000      OFST:	set	0
 702  011b 2017          	jra	L562
 703  011d               L362:
 704                     ; 136 	  USART_SendData8(*str++);
 706  011d 1e01          	ldw	x,(OFST+1,sp)
 707  011f 1c0001        	addw	x,#1
 708  0122 1f01          	ldw	(OFST+1,sp),x
 709  0124 1d0001        	subw	x,#1
 710  0127 f6            	ld	a,(x)
 711  0128 cd0000        	call	_USART_SendData8
 714  012b               L372:
 715                     ; 137 		while (USART_GetFlagStatus(USART_FLAG_TXE) == RESET);	
 717  012b ae0080        	ldw	x,#128
 718  012e cd0000        	call	_USART_GetFlagStatus
 720  0131 4d            	tnz	a
 721  0132 27f7          	jreq	L372
 722  0134               L562:
 723                     ; 134 	while((*str)!='\0')
 725  0134 1e01          	ldw	x,(OFST+1,sp)
 726  0136 7d            	tnz	(x)
 727  0137 26e4          	jrne	L362
 728                     ; 139 }
 731  0139 85            	popw	x
 732  013a 81            	ret
 767                     ; 140 PUTCHAR_PROTOTYPE
 767                     ; 141 {
 768                     	switch	.text
 769  013b               _putchar:
 771  013b 88            	push	a
 772       00000000      OFST:	set	0
 775                     ; 144   uart0_putchar(c);
 777  013c cd0073        	call	_uart0_putchar
 779                     ; 149   return (c);
 781  013f 7b01          	ld	a,(OFST+1,sp)
 784  0141 5b01          	addw	sp,#1
 785  0143 81            	ret
 788                     	bsct
 789  0003               _rx_stats:
 790  0003 00            	dc.b	0
 791  0004               L513_cnt:
 792  0004 00            	dc.b	0
 837                     ; 167 void usart_rx_handler(u8 data)
 837                     ; 168 {
 838                     	switch	.text
 839  0144               _usart_rx_handler:
 841  0144 88            	push	a
 842       00000000      OFST:	set	0
 845                     ; 170 	switch (rx_stats)
 847  0145 b603          	ld	a,_rx_stats
 849                     ; 199 		break;
 850  0147 4d            	tnz	a
 851  0148 2708          	jreq	L713
 852  014a 4a            	dec	a
 853  014b 2711          	jreq	L123
 854  014d 4a            	dec	a
 855  014e 2726          	jreq	L323
 856  0150 2046          	jra	L153
 857  0152               L713:
 858                     ; 172 		case RX_IDLE:
 858                     ; 173 			if(data == 0x55)
 860  0152 7b01          	ld	a,(OFST+1,sp)
 861  0154 a155          	cp	a,#85
 862  0156 2640          	jrne	L153
 863                     ; 174 				rx_stats = RX_S1;
 865  0158 35010003      	mov	_rx_stats,#1
 866  015c 203a          	jra	L153
 867  015e               L123:
 868                     ; 176 		case RX_S1:
 868                     ; 177 			if(data > MAX_LEN)
 870  015e 7b01          	ld	a,(OFST+1,sp)
 871  0160 a115          	cp	a,#21
 872  0162 2506          	jrult	L553
 873                     ; 179 				rx_stats = RX_IDLE;
 875  0164 3f03          	clr	_rx_stats
 876                     ; 180 				len = 0;				
 878  0166 3f14          	clr	_len
 880  0168 202e          	jra	L153
 881  016a               L553:
 882                     ; 184 				rx_stats = RX_S2;		
 884  016a 35020003      	mov	_rx_stats,#2
 885                     ; 185 				len = data;
 887  016e 7b01          	ld	a,(OFST+1,sp)
 888  0170 b714          	ld	_len,a
 889                     ; 186 				cnt = 0;
 891  0172 3f04          	clr	L513_cnt
 892  0174 2022          	jra	L153
 893  0176               L323:
 894                     ; 189 		case RX_S2:
 894                     ; 190 		buf[cnt++] = data;
 896  0176 b604          	ld	a,L513_cnt
 897  0178 97            	ld	xl,a
 898  0179 3c04          	inc	L513_cnt
 899  017b 9f            	ld	a,xl
 900  017c 5f            	clrw	x
 901  017d 97            	ld	xl,a
 902  017e 7b01          	ld	a,(OFST+1,sp)
 903  0180 e700          	ld	(_buf,x),a
 904                     ; 191 		if(cnt == len)
 906  0182 b604          	ld	a,L513_cnt
 907  0184 b114          	cp	a,_len
 908  0186 2610          	jrne	L153
 909                     ; 194 			yy_start(len,buf);
 911  0188 ae0000        	ldw	x,#_buf
 912  018b 89            	pushw	x
 913  018c b614          	ld	a,_len
 914  018e cd0000        	call	_yy_start
 916  0191 85            	popw	x
 917                     ; 195 			rx_stats = RX_IDLE;
 919  0192 3f03          	clr	_rx_stats
 920                     ; 196 			len = 0;
 922  0194 3f14          	clr	_len
 923                     ; 197 			cnt = 0;
 925  0196 3f04          	clr	L513_cnt
 926  0198               L153:
 927                     ; 202 }
 930  0198 84            	pop	a
 931  0199 81            	ret
1011                     	xdef	_usart_rx_handler
1012                     	xdef	_rx_stats
1013                     	switch	.ubsct
1014  0000               _buf:
1015  0000 000000000000  	ds.b	20
1016                     	xdef	_buf
1017  0014               _len:
1018  0014 00            	ds.b	1
1019                     	xdef	_len
1020                     	xdef	_uart_sendchar
1021                     	xdef	_uart0_putstr
1022                     	xdef	_uart0_putchar
1023                     	xdef	_UART1_process
1024                     	xdef	_put_txbuff
1025                     	xdef	_txbuf_getchar
1026                     	xdef	_tx_auto
1027                     	xdef	_tx_rd_index
1028                     	xdef	_tx_wr_index
1029  0015               _tx_buffer:
1030  0015 000000000000  	ds.b	32
1031                     	xdef	_tx_buffer
1032                     	xdef	_uart_sendmultchar
1033                     	xdef	_USART_SendStr
1034                     	xdef	_USART_Config
1035                     	xref	_yy_start
1036                     	xdef	_putchar
1037                     	xref	_USART_GetFlagStatus
1038                     	xref	_USART_SendData8
1039                     	xref	_USART_ITConfig
1040                     	xref	_USART_Init
1041                     	xref	_USART_DeInit
1042                     	xref	_GPIO_ExternalPullUpConfig
1043                     	xref	_CLK_MasterPrescalerConfig
1044                     	xref	_CLK_PeripheralClockConfig
1045                     	xref.b	c_x
1046                     	xref.b	c_y
1066                     	xref	c_smodx
1067                     	end
