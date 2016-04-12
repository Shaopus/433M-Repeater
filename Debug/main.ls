   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  48                     ; 9 void SPI_Initial( void )
  48                     ; 10 {
  50                     	switch	.text
  51  0000               _SPI_Initial:
  55                     ; 12 	CLK_PeripheralClockConfig(CLK_Peripheral_SPI, ENABLE);
  57  0000 ae0001        	ldw	x,#1
  58  0003 a610          	ld	a,#16
  59  0005 95            	ld	xh,a
  60  0006 cd0000        	call	_CLK_PeripheralClockConfig
  62                     ; 14 	SPI_DeInit( );
  64  0009 cd0000        	call	_SPI_DeInit
  66                     ; 16 	SPI_Init( SPI_FirstBit_MSB, SPI_BaudRatePrescaler_2,
  66                     ; 17             SPI_Mode_Master, SPI_CPOL_Low, SPI_CPHA_1Edge,
  66                     ; 18             SPI_Direction_2Lines_FullDuplex, SPI_NSS_Soft );
  68  000c 4b02          	push	#2
  69  000e 4b00          	push	#0
  70  0010 4b00          	push	#0
  71  0012 4b00          	push	#0
  72  0014 4b04          	push	#4
  73  0016 5f            	clrw	x
  74  0017 4f            	clr	a
  75  0018 95            	ld	xh,a
  76  0019 cd0000        	call	_SPI_Init
  78  001c 5b05          	addw	sp,#5
  79                     ; 20 	SPI_Cmd( ENABLE );
  81  001e a601          	ld	a,#1
  82  0020 cd0000        	call	_SPI_Cmd
  84                     ; 22 	GPIO_Init( GPIOB, GPIO_Pin_7,GPIO_Mode_In_PU_No_IT );
  86  0023 4b40          	push	#64
  87  0025 4b80          	push	#128
  88  0027 ae5005        	ldw	x,#20485
  89  002a cd0000        	call	_GPIO_Init
  91  002d 85            	popw	x
  92                     ; 23 	GPIO_Init( GPIOB, GPIO_Pin_5 | GPIO_Pin_6, GPIO_Mode_Out_PP_High_Slow );
  94  002e 4bd0          	push	#208
  95  0030 4b60          	push	#96
  96  0032 ae5005        	ldw	x,#20485
  97  0035 cd0000        	call	_GPIO_Init
  99  0038 85            	popw	x
 100                     ; 24 	GPIO_Init( GPIOB, GPIO_Pin_4, GPIO_Mode_Out_PP_High_Slow );
 102  0039 4bd0          	push	#208
 103  003b 4b10          	push	#16
 104  003d ae5005        	ldw	x,#20485
 105  0040 cd0000        	call	_GPIO_Init
 107  0043 85            	popw	x
 108                     ; 25 	GPIO_Init( GPIOA, GPIO_Pin_3 | GPIO_Pin_2, GPIO_Mode_In_PU_No_IT );
 110  0044 4b40          	push	#64
 111  0046 4b0c          	push	#12
 112  0048 ae5000        	ldw	x,#20480
 113  004b cd0000        	call	_GPIO_Init
 115  004e 85            	popw	x
 116                     ; 26 }
 119  004f 81            	ret
 156                     ; 28 INT8U SPI_ExchangeByte( INT8U input )
 156                     ; 29 {
 157                     	switch	.text
 158  0050               _SPI_ExchangeByte:
 160  0050 88            	push	a
 161       00000000      OFST:	set	0
 164  0051               L14:
 165                     ; 31 	while (SPI_GetFlagStatus(SPI_FLAG_TXE) == RESET);
 167  0051 a602          	ld	a,#2
 168  0053 cd0000        	call	_SPI_GetFlagStatus
 170  0056 4d            	tnz	a
 171  0057 27f8          	jreq	L14
 172                     ; 32 	SPI_SendData( input );
 174  0059 7b01          	ld	a,(OFST+1,sp)
 175  005b cd0000        	call	_SPI_SendData
 178  005e               L74:
 179                     ; 34 	while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
 181  005e a601          	ld	a,#1
 182  0060 cd0000        	call	_SPI_GetFlagStatus
 184  0063 4d            	tnz	a
 185  0064 27f8          	jreq	L74
 186                     ; 35 	return SPI_ReceiveData( );
 188  0066 cd0000        	call	_SPI_ReceiveData
 192  0069 5b01          	addw	sp,#1
 193  006b 81            	ret
 239                     ; 38 void get_serial(void)
 239                     ; 39 {
 240                     	switch	.text
 241  006c               _get_serial:
 243  006c 5205          	subw	sp,#5
 244       00000005      OFST:	set	5
 247                     ; 42 	for(i=0;i<4;i++)
 249  006e 0f05          	clr	(OFST+0,sp)
 250  0070               L57:
 251                     ; 43 		val[i]	= FLASH_ReadByte(start_add+i);
 253  0070 96            	ldw	x,sp
 254  0071 1c0001        	addw	x,#OFST-4
 255  0074 9f            	ld	a,xl
 256  0075 5e            	swapw	x
 257  0076 1b05          	add	a,(OFST+0,sp)
 258  0078 2401          	jrnc	L21
 259  007a 5c            	incw	x
 260  007b               L21:
 261  007b 02            	rlwa	x,a
 262  007c 89            	pushw	x
 263  007d 7b07          	ld	a,(OFST+2,sp)
 264  007f 5f            	clrw	x
 265  0080 97            	ld	xl,a
 266  0081 1c9ff0        	addw	x,#40944
 267  0084 cd0000        	call	_FLASH_ReadByte
 269  0087 85            	popw	x
 270  0088 f7            	ld	(x),a
 271                     ; 42 	for(i=0;i<4;i++)
 273  0089 0c05          	inc	(OFST+0,sp)
 276  008b 7b05          	ld	a,(OFST+0,sp)
 277  008d a104          	cp	a,#4
 278  008f 25df          	jrult	L57
 279                     ; 44 	printf("0x%x,0x%x,0x%x,0x%x\r\n",(uint8_t)val[0],(uint8_t)val[1],(uint8_t)val[2],(uint8_t)val[3]);
 281  0091 7b04          	ld	a,(OFST-1,sp)
 282  0093 88            	push	a
 283  0094 7b04          	ld	a,(OFST-1,sp)
 284  0096 88            	push	a
 285  0097 7b04          	ld	a,(OFST-1,sp)
 286  0099 88            	push	a
 287  009a 7b04          	ld	a,(OFST-1,sp)
 288  009c 88            	push	a
 289  009d ae0066        	ldw	x,#L301
 290  00a0 cd0000        	call	_printf
 292  00a3 5b04          	addw	sp,#4
 293                     ; 45 }
 296  00a5 5b05          	addw	sp,#5
 297  00a7 81            	ret
 335                     ; 47 void set_serial(void)
 335                     ; 48 {
 336                     	switch	.text
 337  00a8               _set_serial:
 339  00a8 5204          	subw	sp,#4
 340       00000004      OFST:	set	4
 343                     ; 49 	uint32_t new_val = 0x01234567;
 345  00aa ae4567        	ldw	x,#17767
 346  00ad 1f03          	ldw	(OFST-1,sp),x
 347  00af ae0123        	ldw	x,#291
 348  00b2 1f01          	ldw	(OFST-3,sp),x
 349                     ; 51    FLASH_SetProgrammingTime(FLASH_ProgramTime_Standard);
 351  00b4 4f            	clr	a
 352  00b5 cd0000        	call	_FLASH_SetProgrammingTime
 354                     ; 53 	FLASH_Unlock(FLASH_MemType_Program);
 356  00b8 a6fd          	ld	a,#253
 357  00ba cd0000        	call	_FLASH_Unlock
 359                     ; 56   FLASH_ProgramWord(start_add, new_val);	
 361  00bd 1e03          	ldw	x,(OFST-1,sp)
 362  00bf 89            	pushw	x
 363  00c0 1e03          	ldw	x,(OFST-1,sp)
 364  00c2 89            	pushw	x
 365  00c3 ae9ff0        	ldw	x,#40944
 366  00c6 cd0000        	call	_FLASH_ProgramWord
 368  00c9 5b04          	addw	sp,#4
 369                     ; 57 	printf("set serial number ok\r\n");
 371  00cb ae004f        	ldw	x,#L321
 372  00ce cd0000        	call	_printf
 374                     ; 58 }
 377  00d1 5b04          	addw	sp,#4
 378  00d3 81            	ret
 402                     ; 60 void LEDInit(void)
 402                     ; 61 {
 403                     	switch	.text
 404  00d4               _LEDInit:
 408                     ; 62 	GPIO_Init(GPIOB, GPIO_Pin_0, GPIO_Mode_Out_PP_High_Slow);
 410  00d4 4bd0          	push	#208
 411  00d6 4b01          	push	#1
 412  00d8 ae5005        	ldw	x,#20485
 413  00db cd0000        	call	_GPIO_Init
 415  00de 85            	popw	x
 416                     ; 63 }
 419  00df 81            	ret
 444                     ; 65 void EXTI_Init(void)
 444                     ; 66 {
 445                     	switch	.text
 446  00e0               _EXTI_Init:
 450                     ; 67 	GPIO_Init(GPIOB,  GPIO_Pin_1, GPIO_Mode_In_PU_IT);
 452  00e0 4b60          	push	#96
 453  00e2 4b02          	push	#2
 454  00e4 ae5005        	ldw	x,#20485
 455  00e7 cd0000        	call	_GPIO_Init
 457  00ea 85            	popw	x
 458                     ; 68 	EXTI_SetPinSensitivity(EXTI_Pin_1, EXTI_Trigger_Falling_Low);
 460  00eb 5f            	clrw	x
 461  00ec a602          	ld	a,#2
 462  00ee 95            	ld	xh,a
 463  00ef cd0000        	call	_EXTI_SetPinSensitivity
 465                     ; 69 }
 468  00f2 81            	ret
 493                     ; 71 void rf_exti(void)
 493                     ; 72 {
 494                     	switch	.text
 495  00f3               _rf_exti:
 499                     ; 73 	GPIO_Init(GPIOA,  GPIO_Pin_2, GPIO_Mode_In_PU_IT);
 501  00f3 4b60          	push	#96
 502  00f5 4b04          	push	#4
 503  00f7 ae5000        	ldw	x,#20480
 504  00fa cd0000        	call	_GPIO_Init
 506  00fd 85            	popw	x
 507                     ; 74 	EXTI_SetPinSensitivity(EXTI_Pin_2, EXTI_Trigger_Falling_Low);
 509  00fe 5f            	clrw	x
 510  00ff a604          	ld	a,#4
 511  0101 95            	ld	xh,a
 512  0102 cd0000        	call	_EXTI_SetPinSensitivity
 514                     ; 76 }
 517  0105 81            	ret
 551                     ; 78 void Delay(uint16_t nCount)
 551                     ; 79 {
 552                     	switch	.text
 553  0106               _Delay:
 555  0106 89            	pushw	x
 556       00000000      OFST:	set	0
 559  0107 2007          	jra	L571
 560  0109               L371:
 561                     ; 83         nCount--;
 563  0109 1e01          	ldw	x,(OFST+1,sp)
 564  010b 1d0001        	subw	x,#1
 565  010e 1f01          	ldw	(OFST+1,sp),x
 566  0110               L571:
 567                     ; 81     while (nCount != 0)
 569  0110 1e01          	ldw	x,(OFST+1,sp)
 570  0112 26f5          	jrne	L371
 571                     ; 85 }
 574  0114 85            	popw	x
 575  0115 81            	ret
 600                     ; 87 void AllDeInit(void)
 600                     ; 88 {
 601                     	switch	.text
 602  0116               _AllDeInit:
 606                     ; 89 	GPIO_DeInit(GPIOA);
 608  0116 ae5000        	ldw	x,#20480
 609  0119 cd0000        	call	_GPIO_DeInit
 611                     ; 90 	GPIO_DeInit(GPIOB);
 613  011c ae5005        	ldw	x,#20485
 614  011f cd0000        	call	_GPIO_DeInit
 616                     ; 91 	GPIO_DeInit(GPIOC);
 618  0122 ae500a        	ldw	x,#20490
 619  0125 cd0000        	call	_GPIO_DeInit
 621                     ; 92 	GPIO_DeInit(GPIOD);
 623  0128 ae500f        	ldw	x,#20495
 624  012b cd0000        	call	_GPIO_DeInit
 626                     ; 94 	GPIO_Init(GPIOA,  GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3, GPIO_Mode_Out_OD_Low_Slow);
 628  012e 4b80          	push	#128
 629  0130 4b0f          	push	#15
 630  0132 ae5000        	ldw	x,#20480
 631  0135 cd0000        	call	_GPIO_Init
 633  0138 85            	popw	x
 634                     ; 95 	GPIO_Init(GPIOB,  GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3|GPIO_Pin_4|GPIO_Pin_5|GPIO_Pin_6|GPIO_Pin_7, GPIO_Mode_Out_OD_Low_Slow);
 636  0139 4b80          	push	#128
 637  013b 4bff          	push	#255
 638  013d ae5005        	ldw	x,#20485
 639  0140 cd0000        	call	_GPIO_Init
 641  0143 85            	popw	x
 642                     ; 96 	GPIO_Init(GPIOC,  GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3|GPIO_Pin_4, GPIO_Mode_Out_OD_Low_Slow);	
 644  0144 4b80          	push	#128
 645  0146 4b1f          	push	#31
 646  0148 ae500a        	ldw	x,#20490
 647  014b cd0000        	call	_GPIO_Init
 649  014e 85            	popw	x
 650                     ; 97 	GPIO_Init(GPIOD,  GPIO_Pin_0, GPIO_Mode_Out_OD_Low_Slow);	
 652  014f 4b80          	push	#128
 653  0151 4b01          	push	#1
 654  0153 ae500f        	ldw	x,#20495
 655  0156 cd0000        	call	_GPIO_Init
 657  0159 85            	popw	x
 658                     ; 99 	GPIOA->ODR = 0x00;
 660  015a 725f5000      	clr	20480
 661                     ; 100 	GPIOB->ODR = 0x00;
 663  015e 725f5005      	clr	20485
 664                     ; 101 	GPIOC->ODR = 0x00;
 666  0162 725f500a      	clr	20490
 667                     ; 102 	GPIOD->ODR = 0x00;
 669  0166 725f500f      	clr	20495
 670                     ; 105 }
 673  016a 81            	ret
 701                     ; 107 void IWDG_Config(void)
 701                     ; 108 {
 702                     	switch	.text
 703  016b               _IWDG_Config:
 707                     ; 118   IWDG_Enable();
 709  016b cd0000        	call	_IWDG_Enable
 711                     ; 123   IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
 713  016e a655          	ld	a,#85
 714  0170 cd0000        	call	_IWDG_WriteAccessCmd
 716                     ; 126   IWDG_SetPrescaler(IWDG_Prescaler_32);
 718  0173 a603          	ld	a,#3
 719  0175 cd0000        	call	_IWDG_SetPrescaler
 721                     ; 132   IWDG_SetReload((uint8_t)RELOAD_VALUE);
 723  0178 a6fe          	ld	a,#254
 724  017a cd0000        	call	_IWDG_SetReload
 726                     ; 135   IWDG_ReloadCounter();
 728  017d cd0000        	call	_IWDG_ReloadCounter
 730                     ; 139 }
 733  0180 81            	ret
 768                     ; 140 u8 wait_rf_low(void)
 768                     ; 141 {
 769                     	switch	.text
 770  0181               _wait_rf_low:
 772  0181 89            	pushw	x
 773       00000002      OFST:	set	2
 776                     ; 142 	u16 cnt=0;
 778  0182 5f            	clrw	x
 779  0183 1f01          	ldw	(OFST-1,sp),x
 781  0185 2011          	jra	L342
 782  0187               L732:
 783                     ; 145 		cnt++;
 785  0187 1e01          	ldw	x,(OFST-1,sp)
 786  0189 1c0001        	addw	x,#1
 787  018c 1f01          	ldw	(OFST-1,sp),x
 788                     ; 146 		if(cnt>10000)
 790  018e 1e01          	ldw	x,(OFST-1,sp)
 791  0190 a32711        	cpw	x,#10001
 792  0193 2503          	jrult	L342
 793                     ; 147 			return 0;
 795  0195 4f            	clr	a
 797  0196 200f          	jra	L43
 798  0198               L342:
 799                     ; 143 	while(GPIO_ReadInputDataBit(GPIOA,GPIO_Pin_2) != 0 )
 801  0198 4b04          	push	#4
 802  019a ae5000        	ldw	x,#20480
 803  019d cd0000        	call	_GPIO_ReadInputDataBit
 805  01a0 5b01          	addw	sp,#1
 806  01a2 4d            	tnz	a
 807  01a3 26e2          	jrne	L732
 808                     ; 149 	return 1;
 810  01a5 a601          	ld	a,#1
 812  01a7               L43:
 814  01a7 85            	popw	x
 815  01a8 81            	ret
 850                     ; 151 u8 wait_rf_hight(void)
 850                     ; 152 {
 851                     	switch	.text
 852  01a9               _wait_rf_hight:
 854  01a9 89            	pushw	x
 855       00000002      OFST:	set	2
 858                     ; 153 	u16 cnt=0;
 860  01aa 5f            	clrw	x
 861  01ab 1f01          	ldw	(OFST-1,sp),x
 863  01ad 2011          	jra	L372
 864  01af               L762:
 865                     ; 156 		cnt++;
 867  01af 1e01          	ldw	x,(OFST-1,sp)
 868  01b1 1c0001        	addw	x,#1
 869  01b4 1f01          	ldw	(OFST-1,sp),x
 870                     ; 157 		if(cnt>10000)
 872  01b6 1e01          	ldw	x,(OFST-1,sp)
 873  01b8 a32711        	cpw	x,#10001
 874  01bb 2503          	jrult	L372
 875                     ; 158 			return 0;
 877  01bd 4f            	clr	a
 879  01be 200f          	jra	L04
 880  01c0               L372:
 881                     ; 154 	while(GPIO_ReadInputDataBit(GPIOA,GPIO_Pin_2) == 0 )
 883  01c0 4b04          	push	#4
 884  01c2 ae5000        	ldw	x,#20480
 885  01c5 cd0000        	call	_GPIO_ReadInputDataBit
 887  01c8 5b01          	addw	sp,#1
 888  01ca 4d            	tnz	a
 889  01cb 27e2          	jreq	L762
 890                     ; 160 	return 1;
 892  01cd a601          	ld	a,#1
 894  01cf               L04:
 896  01cf 85            	popw	x
 897  01d0 81            	ret
 933                     ; 163 u8 wait_rf(void)
 933                     ; 164 {
 934                     	switch	.text
 935  01d1               _wait_rf:
 937  01d1 88            	push	a
 938       00000001      OFST:	set	1
 941                     ; 165 	u8 re = wait_rf_low();
 943  01d2 adad          	call	_wait_rf_low
 945  01d4 6b01          	ld	(OFST+0,sp),a
 946                     ; 166 	if(re)
 948  01d6 0d01          	tnz	(OFST+0,sp)
 949  01d8 2704          	jreq	L713
 950                     ; 168 		re = wait_rf_hight();
 952  01da adcd          	call	_wait_rf_hight
 954  01dc 6b01          	ld	(OFST+0,sp),a
 955  01de               L713:
 956                     ; 170 	return re;		
 958  01de 7b01          	ld	a,(OFST+0,sp)
 961  01e0 5b01          	addw	sp,#1
 962  01e2 81            	ret
1014                     ; 172 int rf_get_rssi(u8 buf)
1014                     ; 173 {
1015                     	switch	.text
1016  01e3               _rf_get_rssi:
1018  01e3 5203          	subw	sp,#3
1019       00000003      OFST:	set	3
1022                     ; 174 	u8 db = buf;
1024  01e5 6b01          	ld	(OFST-2,sp),a
1025                     ; 176 	if(db>=128)
1027  01e7 7b01          	ld	a,(OFST-2,sp)
1028  01e9 a180          	cp	a,#128
1029  01eb 251b          	jrult	L743
1030                     ; 178 		t = db-256;
1032  01ed 7b01          	ld	a,(OFST-2,sp)
1033  01ef 5f            	clrw	x
1034  01f0 97            	ld	xl,a
1035  01f1 1d0100        	subw	x,#256
1036  01f4 1f02          	ldw	(OFST-1,sp),x
1037                     ; 179 		t = t/2;
1039  01f6 1e02          	ldw	x,(OFST-1,sp)
1040  01f8 a602          	ld	a,#2
1041  01fa cd0000        	call	c_sdivx
1043  01fd 1f02          	ldw	(OFST-1,sp),x
1044                     ; 180 		t = t-74;
1046  01ff 1e02          	ldw	x,(OFST-1,sp)
1047  0201 1d004a        	subw	x,#74
1048  0204 1f02          	ldw	(OFST-1,sp),x
1050  0206 2014          	jra	L153
1051  0208               L743:
1052                     ; 182 	else if(db<128)
1054  0208 7b01          	ld	a,(OFST-2,sp)
1055  020a a180          	cp	a,#128
1056  020c 240e          	jruge	L153
1057                     ; 184 		t = db/2;
1059  020e 7b01          	ld	a,(OFST-2,sp)
1060  0210 44            	srl	a
1061  0211 5f            	clrw	x
1062  0212 97            	ld	xl,a
1063  0213 1f02          	ldw	(OFST-1,sp),x
1064                     ; 185 		t = t-74;
1066  0215 1e02          	ldw	x,(OFST-1,sp)
1067  0217 1d004a        	subw	x,#74
1068  021a 1f02          	ldw	(OFST-1,sp),x
1069  021c               L153:
1070                     ; 187 	return t;
1072  021c 1e02          	ldw	x,(OFST-1,sp)
1075  021e 5b03          	addw	sp,#3
1076  0220 81            	ret
1151                     ; 189 void HexToString(u8* buf,u8 size,u8 len)
1151                     ; 190 {
1152                     	switch	.text
1153  0221               _HexToString:
1155  0221 89            	pushw	x
1156  0222 5204          	subw	sp,#4
1157       00000004      OFST:	set	4
1160                     ; 193 	data = (u8*)malloc(size);
1162  0224 7b09          	ld	a,(OFST+5,sp)
1163  0226 5f            	clrw	x
1164  0227 97            	ld	xl,a
1165  0228 cd0000        	call	_malloc
1167  022b 1f01          	ldw	(OFST-3,sp),x
1168                     ; 194 	for(i=0;i<len;i++)
1170  022d 5f            	clrw	x
1171  022e 1f03          	ldw	(OFST-1,sp),x
1173  0230 2031          	jra	L714
1174  0232               L314:
1175                     ; 196 		sprintf(data+2*i,"%x%x",(buf[i]&0xF0)>>4,(buf[i]&0xF));
1177  0232 1e03          	ldw	x,(OFST-1,sp)
1178  0234 72fb05        	addw	x,(OFST+1,sp)
1179  0237 f6            	ld	a,(x)
1180  0238 5f            	clrw	x
1181  0239 a40f          	and	a,#15
1182  023b 5f            	clrw	x
1183  023c 02            	rlwa	x,a
1184  023d 89            	pushw	x
1185  023e 01            	rrwa	x,a
1186  023f 1e05          	ldw	x,(OFST+1,sp)
1187  0241 72fb07        	addw	x,(OFST+3,sp)
1188  0244 f6            	ld	a,(x)
1189  0245 a4f0          	and	a,#240
1190  0247 4e            	swap	a
1191  0248 a40f          	and	a,#15
1192  024a 5f            	clrw	x
1193  024b 97            	ld	xl,a
1194  024c 89            	pushw	x
1195  024d ae004a        	ldw	x,#L324
1196  0250 89            	pushw	x
1197  0251 1e09          	ldw	x,(OFST+5,sp)
1198  0253 58            	sllw	x
1199  0254 72fb07        	addw	x,(OFST+3,sp)
1200  0257 cd0000        	call	_sprintf
1202  025a 5b06          	addw	sp,#6
1203                     ; 194 	for(i=0;i<len;i++)
1205  025c 1e03          	ldw	x,(OFST-1,sp)
1206  025e 1c0001        	addw	x,#1
1207  0261 1f03          	ldw	(OFST-1,sp),x
1208  0263               L714:
1211  0263 9c            	rvf
1212  0264 7b0a          	ld	a,(OFST+6,sp)
1213  0266 5f            	clrw	x
1214  0267 97            	ld	xl,a
1215  0268 bf00          	ldw	c_x,x
1216  026a 1e03          	ldw	x,(OFST-1,sp)
1217  026c b300          	cpw	x,c_x
1218  026e 2fc2          	jrslt	L314
1219                     ; 198 	USART_SendStr("ID:");
1221  0270 ae0046        	ldw	x,#L524
1222  0273 cd0000        	call	_USART_SendStr
1224                     ; 199 	USART_SendStr(data);
1226  0276 1e01          	ldw	x,(OFST-3,sp)
1227  0278 cd0000        	call	_USART_SendStr
1229                     ; 200 	USART_SendStr(" ");
1231  027b ae0044        	ldw	x,#L724
1232  027e cd0000        	call	_USART_SendStr
1234                     ; 201 }
1237  0281 5b06          	addw	sp,#6
1238  0283 81            	ret
1302                     ; 202 void RfType(u8* buf,u8 size,u8 len)
1302                     ; 203 {
1303                     	switch	.text
1304  0284               _RfType:
1306  0284 89            	pushw	x
1307  0285 88            	push	a
1308       00000001      OFST:	set	1
1311                     ; 205 	USART_SendStr("设备:");
1313  0286 ae003e        	ldw	x,#L574
1314  0289 cd0000        	call	_USART_SendStr
1316                     ; 206 	type = (buf[2]&0xf0)>>4;
1318  028c 1e02          	ldw	x,(OFST+1,sp)
1319  028e e602          	ld	a,(2,x)
1320  0290 a4f0          	and	a,#240
1321  0292 4e            	swap	a
1322  0293 a40f          	and	a,#15
1323  0295 6b01          	ld	(OFST+0,sp),a
1324                     ; 207 	switch(type)
1326  0297 7b01          	ld	a,(OFST+0,sp)
1328                     ; 227 		break;
1329  0299 4a            	dec	a
1330  029a 2711          	jreq	L134
1331  029c 4a            	dec	a
1332  029d 2716          	jreq	L334
1333  029f 4a            	dec	a
1334  02a0 271b          	jreq	L534
1335  02a2 4a            	dec	a
1336  02a3 2720          	jreq	L734
1337  02a5               L144:
1338                     ; 225 		default:
1338                     ; 226 			  USART_SendStr("未知   ");
1340  02a5 ae0016        	ldw	x,#L315
1341  02a8 cd0000        	call	_USART_SendStr
1343                     ; 227 		break;
1345  02ab 201e          	jra	L105
1346  02ad               L134:
1347                     ; 209 		case 0x01:
1347                     ; 210 				USART_SendStr("遥控器 ");
1349  02ad ae0036        	ldw	x,#L305
1350  02b0 cd0000        	call	_USART_SendStr
1352                     ; 211 		break;
1354  02b3 2016          	jra	L105
1355  02b5               L334:
1356                     ; 213 		case 0x02:
1356                     ; 214 				USART_SendStr("门磁   ");
1358  02b5 ae002e        	ldw	x,#L505
1359  02b8 cd0000        	call	_USART_SendStr
1361                     ; 215 		break;
1363  02bb 200e          	jra	L105
1364  02bd               L534:
1365                     ; 217 		case 0x03:
1365                     ; 218 				USART_SendStr("红外   ");
1367  02bd ae0026        	ldw	x,#L705
1368  02c0 cd0000        	call	_USART_SendStr
1370                     ; 219 		break;
1372  02c3 2006          	jra	L105
1373  02c5               L734:
1374                     ; 221 		case 0x04:
1374                     ; 222 				USART_SendStr("烟感   ");
1376  02c5 ae001e        	ldw	x,#L115
1377  02c8 cd0000        	call	_USART_SendStr
1379                     ; 223 		break;
1381  02cb               L105:
1382                     ; 229 	HexToString(buf,size,len);	
1384  02cb 7b07          	ld	a,(OFST+6,sp)
1385  02cd 88            	push	a
1386  02ce 7b07          	ld	a,(OFST+6,sp)
1387  02d0 88            	push	a
1388  02d1 1e04          	ldw	x,(OFST+3,sp)
1389  02d3 cd0221        	call	_HexToString
1391  02d6 85            	popw	x
1392                     ; 230 }
1395  02d7 5b03          	addw	sp,#3
1396  02d9 81            	ret
1399                     	bsct
1400  0000               _sys_cnt:
1401  0000 00            	dc.b	0
1402                     .const:	section	.text
1403  0000               L515_buf:
1404  0000 00            	dc.b	0
1405  0001 00            	dc.b	0
1406  0002 00            	dc.b	0
1407  0003 00            	dc.b	0
1408  0004 00            	dc.b	0
1409  0005 000000000000  	ds.b	7
1481                     ; 234 void main(void)
1481                     ; 235 {
1482                     	switch	.text
1483  02da               _main:
1485  02da 520e          	subw	sp,#14
1486       0000000e      OFST:	set	14
1489                     ; 236 	u8 stats = 0;
1491  02dc 0f01          	clr	(OFST-13,sp)
1492                     ; 237 	u8 buf[12] = {0,0,0,0,0};
1494  02de 96            	ldw	x,sp
1495  02df 1c0003        	addw	x,#OFST-11
1496  02e2 90ae0000      	ldw	y,#L515_buf
1497  02e6 a60c          	ld	a,#12
1498  02e8 cd0000        	call	c_xymvx
1500                     ; 239 	CLK_MasterPrescalerConfig(CLK_MasterPrescaler_HSIDiv1);
1502  02eb 4f            	clr	a
1503  02ec cd0000        	call	_CLK_MasterPrescalerConfig
1505                     ; 240 	USART_Config();
1507  02ef cd0000        	call	_USART_Config
1509                     ; 241 	SPI_Initial();
1511  02f2 cd0000        	call	_SPI_Initial
1513                     ; 243 	CC1101Init();
1515  02f5 cd0000        	call	_CC1101Init
1517                     ; 244 	CC1101ClrRXBuff();
1519  02f8 cd0000        	call	_CC1101ClrRXBuff
1521                     ; 245 	CC1101SetTRMode(RX_MODE);	
1523  02fb a601          	ld	a,#1
1524  02fd cd0000        	call	_CC1101SetTRMode
1526                     ; 246 	yy_init();
1528  0300 cd0000        	call	_yy_init
1530                     ; 247 	IWDG_Config();
1532  0303 cd016b        	call	_IWDG_Config
1534                     ; 249 	enableInterrupts();
1537  0306 9a            rim
1539                     ; 251 	sys_cnt=0;
1542  0307 3f00          	clr	_sys_cnt
1543  0309               L545:
1544                     ; 257 		IWDG_ReloadCounter(); 		
1546  0309 cd0000        	call	_IWDG_ReloadCounter
1548                     ; 258 		if(wait_rf()!=0)
1550  030c cd01d1        	call	_wait_rf
1552  030f 4d            	tnz	a
1553  0310 2756          	jreq	L155
1554                     ; 260 			sys_cnt=0;
1556  0312 3f00          	clr	_sys_cnt
1557                     ; 261 			len = CC1101RecPacket(&buf[0]);
1559  0314 96            	ldw	x,sp
1560  0315 1c0003        	addw	x,#OFST-11
1561  0318 cd0000        	call	_CC1101RecPacket
1563  031b 6b02          	ld	(OFST-12,sp),a
1564                     ; 262 			if(len==9)
1566  031d 7b02          	ld	a,(OFST-12,sp)
1567  031f a109          	cp	a,#9
1568  0321 2632          	jrne	L355
1569                     ; 266 				buf[9] = CC1101ReadStatus(CC1101_RSSI);
1571  0323 a634          	ld	a,#52
1572  0325 cd0000        	call	_CC1101ReadStatus
1574  0328 6b0c          	ld	(OFST-2,sp),a
1575                     ; 267 				CC1101SetTRMode(TX_MODE);			
1577  032a 4f            	clr	a
1578  032b cd0000        	call	_CC1101SetTRMode
1580                     ; 268 				CC1101SendPacket(buf,9, ADDRESS_CHECK);
1582  032e 4b01          	push	#1
1583  0330 4b09          	push	#9
1584  0332 96            	ldw	x,sp
1585  0333 1c0005        	addw	x,#OFST-9
1586  0336 cd0000        	call	_CC1101SendPacket
1588  0339 85            	popw	x
1589                     ; 269 				disableInterrupts();
1592  033a 9b            sim
1594                     ; 271 				RfType(buf,16,9);
1597  033b 4b09          	push	#9
1598  033d 4b10          	push	#16
1599  033f 96            	ldw	x,sp
1600  0340 1c0005        	addw	x,#OFST-9
1601  0343 cd0284        	call	_RfType
1603  0346 85            	popw	x
1604                     ; 272 				printf("DB:%d dBm",rf_get_rssi(buf[9]));
1606  0347 7b0c          	ld	a,(OFST-2,sp)
1607  0349 cd01e3        	call	_rf_get_rssi
1609  034c 89            	pushw	x
1610  034d ae000c        	ldw	x,#L555
1611  0350 cd0000        	call	_printf
1613  0353 85            	popw	x
1614                     ; 273 				enableInterrupts();
1617  0354 9a            rim
1620  0355               L355:
1621                     ; 276 			CC1101Init();
1623  0355 cd0000        	call	_CC1101Init
1625                     ; 277 			CC1101ClrRXBuff();
1627  0358 cd0000        	call	_CC1101ClrRXBuff
1629                     ; 278 			CC1101SetTRMode(RX_MODE);
1631  035b a601          	ld	a,#1
1632  035d cd0000        	call	_CC1101SetTRMode
1634                     ; 280 			Delay(10000);
1636  0360 ae2710        	ldw	x,#10000
1637  0363 cd0106        	call	_Delay
1640  0366 20a1          	jra	L545
1641  0368               L155:
1642                     ; 285 			sys_cnt++;
1644  0368 3c00          	inc	_sys_cnt
1645                     ; 286 			if(sys_cnt>=0xff)
1647  036a b600          	ld	a,_sys_cnt
1648  036c a1ff          	cp	a,#255
1649  036e 2599          	jrult	L545
1650                     ; 288 				sys_cnt = 0;
1652  0370 3f00          	clr	_sys_cnt
1653                     ; 289 				CC1101Init();
1655  0372 cd0000        	call	_CC1101Init
1657                     ; 290 				CC1101ClrRXBuff();
1659  0375 cd0000        	call	_CC1101ClrRXBuff
1661                     ; 291 				CC1101SetTRMode(RX_MODE);
1663  0378 a601          	ld	a,#1
1664  037a cd0000        	call	_CC1101SetTRMode
1666                     ; 293 				Delay(10000);			
1668  037d ae2710        	ldw	x,#10000
1669  0380 cd0106        	call	_Delay
1671  0383 2084          	jra	L545
1704                     	xdef	_main
1705                     	xdef	_sys_cnt
1706                     	switch	.ubsct
1707  0000               _rev_flag:
1708  0000 00            	ds.b	1
1709                     	xdef	_rev_flag
1710                     	xref	_CC1101ClrRXBuff
1711                     	xdef	_RfType
1712                     	xdef	_HexToString
1713                     	xdef	_rf_get_rssi
1714                     	xdef	_wait_rf
1715                     	xdef	_wait_rf_hight
1716                     	xdef	_wait_rf_low
1717                     	xdef	_IWDG_Config
1718                     	xdef	_AllDeInit
1719                     	xdef	_Delay
1720                     	xdef	_rf_exti
1721                     	xdef	_EXTI_Init
1722                     	xdef	_LEDInit
1723                     	xdef	_set_serial
1724                     	xdef	_get_serial
1725                     	xdef	_SPI_Initial
1726                     	xdef	_SPI_ExchangeByte
1727                     	xref	_yy_init
1728                     	xref	_CC1101Init
1729                     	xref	_CC1101RecPacket
1730                     	xref	_CC1101SendPacket
1731                     	xref	_CC1101SetTRMode
1732                     	xref	_CC1101ReadStatus
1733                     	xref	_malloc
1734                     	xref	_USART_SendStr
1735                     	xref	_USART_Config
1736                     	xref	_sprintf
1737                     	xref	_printf
1738                     	xref	_SPI_GetFlagStatus
1739                     	xref	_SPI_ReceiveData
1740                     	xref	_SPI_SendData
1741                     	xref	_SPI_Cmd
1742                     	xref	_SPI_Init
1743                     	xref	_SPI_DeInit
1744                     	xref	_IWDG_Enable
1745                     	xref	_IWDG_ReloadCounter
1746                     	xref	_IWDG_SetReload
1747                     	xref	_IWDG_SetPrescaler
1748                     	xref	_IWDG_WriteAccessCmd
1749                     	xref	_GPIO_ReadInputDataBit
1750                     	xref	_GPIO_Init
1751                     	xref	_GPIO_DeInit
1752                     	xref	_FLASH_ReadByte
1753                     	xref	_FLASH_ProgramWord
1754                     	xref	_FLASH_Unlock
1755                     	xref	_FLASH_SetProgrammingTime
1756                     	xref	_EXTI_SetPinSensitivity
1757                     	xref	_CLK_MasterPrescalerConfig
1758                     	xref	_CLK_PeripheralClockConfig
1759                     	switch	.const
1760  000c               L555:
1761  000c 44423a256420  	dc.b	"DB:%d dBm",0
1762  0016               L315:
1763  0016 ceb4d6aa2020  	dc.b	206,180,214,170,32,32
1764  001c 2000          	dc.b	" ",0
1765  001e               L115:
1766  001e d1ccb8d02020  	dc.b	209,204,184,208,32,32
1767  0024 2000          	dc.b	" ",0
1768  0026               L705:
1769  0026 baeccde22020  	dc.b	186,236,205,226,32,32
1770  002c 2000          	dc.b	" ",0
1771  002e               L505:
1772  002e c3c5b4c52020  	dc.b	195,197,180,197,32,32
1773  0034 2000          	dc.b	" ",0
1774  0036               L305:
1775  0036 d2a3bfd8c6f7  	dc.b	210,163,191,216,198,247
1776  003c 2000          	dc.b	" ",0
1777  003e               L574:
1778  003e c9e8b1b83a00  	dc.b	201,232,177,184,58,0
1779  0044               L724:
1780  0044 2000          	dc.b	" ",0
1781  0046               L524:
1782  0046 49443a00      	dc.b	"ID:",0
1783  004a               L324:
1784  004a 2578257800    	dc.b	"%x%x",0
1785  004f               L321:
1786  004f 736574207365  	dc.b	"set serial number "
1787  0061 6f6b0d        	dc.b	"ok",13
1788  0064 0a00          	dc.b	10,0
1789  0066               L301:
1790  0066 307825782c30  	dc.b	"0x%x,0x%x,0x%x,0x%"
1791  0078 780d          	dc.b	"x",13
1792  007a 0a00          	dc.b	10,0
1793                     	xref.b	c_x
1813                     	xref	c_xymvx
1814                     	xref	c_sdivx
1815                     	end
