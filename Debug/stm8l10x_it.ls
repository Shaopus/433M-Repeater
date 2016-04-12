   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     	bsct
  16  0000               _b_Enter:
  17  0000 01            	dc.b	1
  46                     ; 63 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  46                     ; 64 {
  47                     	switch	.text
  48  0000               f_TRAP_IRQHandler:
  52                     ; 68 }
  55  0000 80            	iret
  77                     ; 75 INTERRUPT_HANDLER(FLASH_IRQHandler,1)
  77                     ; 76 {
  78                     	switch	.text
  79  0001               f_FLASH_IRQHandler:
  83                     ; 80 }
  86  0001 80            	iret
 108                     ; 87 INTERRUPT_HANDLER(AWU_IRQHandler,4)
 108                     ; 88 {
 109                     	switch	.text
 110  0002               f_AWU_IRQHandler:
 114                     ; 92 }
 117  0002 80            	iret
 139                     ; 99 INTERRUPT_HANDLER(EXTIB_IRQHandler, 6)
 139                     ; 100 {
 140                     	switch	.text
 141  0003               f_EXTIB_IRQHandler:
 145                     ; 104 }
 148  0003 80            	iret
 170                     ; 111 INTERRUPT_HANDLER(EXTID_IRQHandler, 7)
 170                     ; 112 {
 171                     	switch	.text
 172  0004               f_EXTID_IRQHandler:
 176                     ; 116 }
 179  0004 80            	iret
 201                     ; 123 INTERRUPT_HANDLER(EXTI0_IRQHandler, 8)
 201                     ; 124 {
 202                     	switch	.text
 203  0005               f_EXTI0_IRQHandler:
 207                     ; 128 }
 210  0005 80            	iret
 234                     ; 135 INTERRUPT_HANDLER(EXTI1_IRQHandler, 9)
 234                     ; 136 {
 235                     	switch	.text
 236  0006               f_EXTI1_IRQHandler:
 238  0006 3b0002        	push	c_x+2
 239  0009 be00          	ldw	x,c_x
 240  000b 89            	pushw	x
 241  000c 3b0002        	push	c_y+2
 242  000f be00          	ldw	x,c_y
 243  0011 89            	pushw	x
 246                     ; 145 	disableInterrupts();
 249  0012 9b            sim
 251                     ; 151   EXTI_ClearITPendingBit(EXTI_IT_Pin1);
 254  0013 a602          	ld	a,#2
 255  0015 cd0000        	call	_EXTI_ClearITPendingBit
 257                     ; 152 }
 260  0018 85            	popw	x
 261  0019 bf00          	ldw	c_y,x
 262  001b 320002        	pop	c_y+2
 263  001e 85            	popw	x
 264  001f bf00          	ldw	c_x,x
 265  0021 320002        	pop	c_x+2
 266  0024 80            	iret
 290                     ; 159 INTERRUPT_HANDLER(EXTI2_IRQHandler, 10)
 290                     ; 160 {
 291                     	switch	.text
 292  0025               f_EXTI2_IRQHandler:
 294  0025 3b0002        	push	c_x+2
 295  0028 be00          	ldw	x,c_x
 296  002a 89            	pushw	x
 297  002b 3b0002        	push	c_y+2
 298  002e be00          	ldw	x,c_y
 299  0030 89            	pushw	x
 302                     ; 171 	disableInterrupts();
 305  0031 9b            sim
 307                     ; 172   EXTI_ClearITPendingBit(EXTI_IT_Pin2);
 310  0032 a604          	ld	a,#4
 311  0034 cd0000        	call	_EXTI_ClearITPendingBit
 313                     ; 173 }
 316  0037 85            	popw	x
 317  0038 bf00          	ldw	c_y,x
 318  003a 320002        	pop	c_y+2
 319  003d 85            	popw	x
 320  003e bf00          	ldw	c_x,x
 321  0040 320002        	pop	c_x+2
 322  0043 80            	iret
 344                     ; 180 INTERRUPT_HANDLER(EXTI3_IRQHandler, 11)
 344                     ; 181 {
 345                     	switch	.text
 346  0044               f_EXTI3_IRQHandler:
 350                     ; 185 }
 353  0044 80            	iret
 375                     ; 192 INTERRUPT_HANDLER(EXTI4_IRQHandler, 12)
 375                     ; 193 {
 376                     	switch	.text
 377  0045               f_EXTI4_IRQHandler:
 381                     ; 197 }
 384  0045 80            	iret
 406                     ; 204 INTERRUPT_HANDLER(EXTI5_IRQHandler, 13)
 406                     ; 205 {
 407                     	switch	.text
 408  0046               f_EXTI5_IRQHandler:
 412                     ; 209 }
 415  0046 80            	iret
 437                     ; 216 INTERRUPT_HANDLER(EXTI6_IRQHandler, 14)
 437                     ; 217 {
 438                     	switch	.text
 439  0047               f_EXTI6_IRQHandler:
 443                     ; 221 }
 446  0047 80            	iret
 468                     ; 228 INTERRUPT_HANDLER(EXTI7_IRQHandler, 15)
 468                     ; 229 {
 469                     	switch	.text
 470  0048               f_EXTI7_IRQHandler:
 474                     ; 233 }
 477  0048 80            	iret
 499                     ; 240 INTERRUPT_HANDLER(COMP_IRQHandler, 18)
 499                     ; 241 {
 500                     	switch	.text
 501  0049               f_COMP_IRQHandler:
 505                     ; 245 }
 508  0049 80            	iret
 531                     ; 252 INTERRUPT_HANDLER(TIM2_UPD_OVF_TRG_BRK_IRQHandler, 19)
 531                     ; 253 {
 532                     	switch	.text
 533  004a               f_TIM2_UPD_OVF_TRG_BRK_IRQHandler:
 537                     ; 257 }
 540  004a 80            	iret
 563                     ; 264 INTERRUPT_HANDLER(TIM2_CAP_IRQHandler, 20)
 563                     ; 265 {
 564                     	switch	.text
 565  004b               f_TIM2_CAP_IRQHandler:
 569                     ; 269 }
 572  004b 80            	iret
 595                     ; 277 INTERRUPT_HANDLER(TIM3_UPD_OVF_TRG_BRK_IRQHandler, 21)
 595                     ; 278 {
 596                     	switch	.text
 597  004c               f_TIM3_UPD_OVF_TRG_BRK_IRQHandler:
 601                     ; 282 }
 604  004c 80            	iret
 627                     ; 288 INTERRUPT_HANDLER(TIM3_CAP_IRQHandler, 22)
 627                     ; 289 {
 628                     	switch	.text
 629  004d               f_TIM3_CAP_IRQHandler:
 633                     ; 293 }
 636  004d 80            	iret
 661                     ; 300 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 25)
 661                     ; 301 {
 662                     	switch	.text
 663  004e               f_TIM4_UPD_OVF_IRQHandler:
 665  004e 3b0002        	push	c_x+2
 666  0051 be00          	ldw	x,c_x
 667  0053 89            	pushw	x
 668  0054 3b0002        	push	c_y+2
 669  0057 be00          	ldw	x,c_y
 670  0059 89            	pushw	x
 673                     ; 306 		time4_handle();
 675  005a cd0000        	call	_time4_handle
 677                     ; 308 		TIM4_ClearITPendingBit(TIM4_IT_Update);
 679  005d a601          	ld	a,#1
 680  005f cd0000        	call	_TIM4_ClearITPendingBit
 682                     ; 310 }
 685  0062 85            	popw	x
 686  0063 bf00          	ldw	c_y,x
 687  0065 320002        	pop	c_y+2
 688  0068 85            	popw	x
 689  0069 bf00          	ldw	c_x,x
 690  006b 320002        	pop	c_x+2
 691  006e 80            	iret
 713                     ; 317 INTERRUPT_HANDLER(SPI_IRQHandler, 26)
 713                     ; 318 {
 714                     	switch	.text
 715  006f               f_SPI_IRQHandler:
 719                     ; 322 }
 722  006f 80            	iret
 746                     ; 331 INTERRUPT_HANDLER(USART_TX_IRQHandler, 27)
 746                     ; 332 {
 747                     	switch	.text
 748  0070               f_USART_TX_IRQHandler:
 750  0070 3b0002        	push	c_x+2
 751  0073 be00          	ldw	x,c_x
 752  0075 89            	pushw	x
 753  0076 3b0002        	push	c_y+2
 754  0079 be00          	ldw	x,c_y
 755  007b 89            	pushw	x
 758                     ; 338 		UART1_process();
 760  007c cd0000        	call	_UART1_process
 762                     ; 340 }
 765  007f 85            	popw	x
 766  0080 bf00          	ldw	c_y,x
 767  0082 320002        	pop	c_y+2
 768  0085 85            	popw	x
 769  0086 bf00          	ldw	c_x,x
 770  0088 320002        	pop	c_x+2
 771  008b 80            	iret
 796                     ; 348 INTERRUPT_HANDLER(USART_RX_IRQHandler, 28)
 796                     ; 349 {
 797                     	switch	.text
 798  008c               f_USART_RX_IRQHandler:
 800  008c 3b0002        	push	c_x+2
 801  008f be00          	ldw	x,c_x
 802  0091 89            	pushw	x
 803  0092 3b0002        	push	c_y+2
 804  0095 be00          	ldw	x,c_y
 805  0097 89            	pushw	x
 808                     ; 355 		usart_rx_handler(USART_ReceiveData8());
 810  0098 cd0000        	call	_USART_ReceiveData8
 812  009b cd0000        	call	_usart_rx_handler
 814                     ; 357 }
 817  009e 85            	popw	x
 818  009f bf00          	ldw	c_y,x
 819  00a1 320002        	pop	c_y+2
 820  00a4 85            	popw	x
 821  00a5 bf00          	ldw	c_x,x
 822  00a7 320002        	pop	c_x+2
 823  00aa 80            	iret
 845                     ; 364 INTERRUPT_HANDLER(I2C_IRQHandler, 29)
 845                     ; 365 {
 846                     	switch	.text
 847  00ab               f_I2C_IRQHandler:
 851                     ; 369 }
 854  00ab 80            	iret
 877                     	xref	_usart_rx_handler
 878                     	xref	_UART1_process
 879                     	xref	_time4_handle
 880                     	xdef	_b_Enter
 881                     	xdef	f_I2C_IRQHandler
 882                     	xdef	f_USART_RX_IRQHandler
 883                     	xdef	f_USART_TX_IRQHandler
 884                     	xdef	f_SPI_IRQHandler
 885                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 886                     	xdef	f_TIM3_CAP_IRQHandler
 887                     	xdef	f_TIM3_UPD_OVF_TRG_BRK_IRQHandler
 888                     	xdef	f_TIM2_CAP_IRQHandler
 889                     	xdef	f_TIM2_UPD_OVF_TRG_BRK_IRQHandler
 890                     	xdef	f_COMP_IRQHandler
 891                     	xdef	f_EXTI7_IRQHandler
 892                     	xdef	f_EXTI6_IRQHandler
 893                     	xdef	f_EXTI5_IRQHandler
 894                     	xdef	f_EXTI4_IRQHandler
 895                     	xdef	f_EXTI3_IRQHandler
 896                     	xdef	f_EXTI2_IRQHandler
 897                     	xdef	f_EXTI1_IRQHandler
 898                     	xdef	f_EXTI0_IRQHandler
 899                     	xdef	f_EXTID_IRQHandler
 900                     	xdef	f_EXTIB_IRQHandler
 901                     	xdef	f_AWU_IRQHandler
 902                     	xdef	f_FLASH_IRQHandler
 903                     	xdef	f_TRAP_IRQHandler
 904                     	xref	_USART_ReceiveData8
 905                     	xref	_TIM4_ClearITPendingBit
 906                     	xref	_EXTI_ClearITPendingBit
 907                     	xref.b	c_x
 908                     	xref.b	c_y
 927                     	end
