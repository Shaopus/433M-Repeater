   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     .const:	section	.text
  16  0000               _PaTabel:
  17  0000 c0            	dc.b	192
  18  0001 c8            	dc.b	200
  19  0002 84            	dc.b	132
  20  0003 60            	dc.b	96
  21  0004 68            	dc.b	104
  22  0005 34            	dc.b	52
  23  0006 1d            	dc.b	29
  24  0007 0e            	dc.b	14
  25  0008               L3_CC1101InitData:
  26  0008 02            	dc.b	2
  27  0009 06            	dc.b	6
  28  000a 03            	dc.b	3
  29  000b 47            	dc.b	71
  30  000c 08            	dc.b	8
  31  000d 05            	dc.b	5
  32  000e 0a            	dc.b	10
  33  000f 01            	dc.b	1
  34  0010 0b            	dc.b	11
  35  0011 06            	dc.b	6
  36  0012 0d            	dc.b	13
  37  0013 10            	dc.b	16
  38  0014 0e            	dc.b	14
  39  0015 ec            	dc.b	236
  40  0016 0f            	dc.b	15
  41  0017 4e            	dc.b	78
  42  0018 10            	dc.b	16
  43  0019 f6            	dc.b	246
  44  001a 11            	dc.b	17
  45  001b 43            	dc.b	67
  46  001c 12            	dc.b	18
  47  001d 13            	dc.b	19
  48  001e 15            	dc.b	21
  49  001f 15            	dc.b	21
  50  0020 18            	dc.b	24
  51  0021 18            	dc.b	24
  52  0022 19            	dc.b	25
  53  0023 16            	dc.b	22
  54  0024 20            	dc.b	32
  55  0025 fb            	dc.b	251
  56  0026 23            	dc.b	35
  57  0027 e9            	dc.b	233
  58  0028 24            	dc.b	36
  59  0029 2a            	dc.b	42
  60  002a 25            	dc.b	37
  61  002b 00            	dc.b	0
  62  002c 26            	dc.b	38
  63  002d 1f            	dc.b	31
  64  002e 2c            	dc.b	44
  65  002f 81            	dc.b	129
  66  0030 2d            	dc.b	45
  67  0031 35            	dc.b	53
  68  0032 2e            	dc.b	46
  69  0033 09            	dc.b	9
  70  0034 17            	dc.b	23
  71  0035 3b            	dc.b	59
 102                     ; 131 void  CC1101WORInit( void )
 102                     ; 132 {
 104                     	switch	.text
 105  0000               _CC1101WORInit:
 109                     ; 134     CC1101WriteReg(CC1101_MCSM0,0x18);
 111  0000 ae0018        	ldw	x,#24
 112  0003 a618          	ld	a,#24
 113  0005 95            	ld	xh,a
 114  0006 cd0118        	call	_CC1101WriteReg
 116                     ; 135     CC1101WriteReg(CC1101_WORCTRL,0x78); //Wake On Radio Control
 118  0009 ae0078        	ldw	x,#120
 119  000c a620          	ld	a,#32
 120  000e 95            	ld	xh,a
 121  000f cd0118        	call	_CC1101WriteReg
 123                     ; 136     CC1101WriteReg(CC1101_MCSM2,0x00);
 125  0012 5f            	clrw	x
 126  0013 a616          	ld	a,#22
 127  0015 95            	ld	xh,a
 128  0016 cd0118        	call	_CC1101WriteReg
 130                     ; 137     CC1101WriteReg(CC1101_WOREVT1,0x8C);
 132  0019 ae008c        	ldw	x,#140
 133  001c a61e          	ld	a,#30
 134  001e 95            	ld	xh,a
 135  001f cd0118        	call	_CC1101WriteReg
 137                     ; 138     CC1101WriteReg(CC1101_WOREVT0,0xA0);
 139  0022 ae00a0        	ldw	x,#160
 140  0025 a61f          	ld	a,#31
 141  0027 95            	ld	xh,a
 142  0028 cd0118        	call	_CC1101WriteReg
 144                     ; 140 	CC1101WriteCmd( CC1101_SWORRST );
 146  002b a63c          	ld	a,#60
 147  002d cd0189        	call	_CC1101WriteCmd
 149                     ; 141 }
 152  0030 81            	ret
 199                     ; 150 INT8U CC1101ReadReg( INT8U addr )
 199                     ; 151 {
 200                     	switch	.text
 201  0031               _CC1101ReadReg:
 203  0031 88            	push	a
 204  0032 88            	push	a
 205       00000001      OFST:	set	1
 208                     ; 153     CC_CSN_LOW( );
 210  0033 4b10          	push	#16
 211  0035 ae5005        	ldw	x,#20485
 212  0038 cd0000        	call	_GPIO_ResetBits
 214  003b 84            	pop	a
 216  003c               L74:
 219  003c 4b80          	push	#128
 220  003e ae5005        	ldw	x,#20485
 221  0041 cd0000        	call	_GPIO_ReadInputDataBit
 223  0044 5b01          	addw	sp,#1
 224  0046 4d            	tnz	a
 225  0047 26f3          	jrne	L74
 226                     ; 154     SPI_ExchangeByte( addr | READ_SINGLE);
 229  0049 7b02          	ld	a,(OFST+1,sp)
 230  004b aa80          	or	a,#128
 231  004d cd0000        	call	_SPI_ExchangeByte
 233                     ; 155     i = SPI_ExchangeByte( 0xFF );
 235  0050 a6ff          	ld	a,#255
 236  0052 cd0000        	call	_SPI_ExchangeByte
 238  0055 6b01          	ld	(OFST+0,sp),a
 239                     ; 156     CC_CSN_HIGH( );
 241  0057 4b10          	push	#16
 242  0059 ae5005        	ldw	x,#20485
 243  005c cd0000        	call	_GPIO_SetBits
 245  005f 84            	pop	a
 246                     ; 157     return i;
 248  0060 7b01          	ld	a,(OFST+0,sp)
 251  0062 85            	popw	x
 252  0063 81            	ret
 327                     ; 169 void CC1101ReadMultiReg( INT8U addr, INT8U *buff, INT8U size )
 327                     ; 170 {
 328                     	switch	.text
 329  0064               _CC1101ReadMultiReg:
 331  0064 88            	push	a
 332  0065 89            	pushw	x
 333       00000002      OFST:	set	2
 336                     ; 172     CC_CSN_LOW( );
 338  0066 4b10          	push	#16
 339  0068 ae5005        	ldw	x,#20485
 340  006b cd0000        	call	_GPIO_ResetBits
 342  006e 84            	pop	a
 344  006f               L311:
 347  006f 4b80          	push	#128
 348  0071 ae5005        	ldw	x,#20485
 349  0074 cd0000        	call	_GPIO_ReadInputDataBit
 351  0077 5b01          	addw	sp,#1
 352  0079 4d            	tnz	a
 353  007a 26f3          	jrne	L311
 354                     ; 173     SPI_ExchangeByte( addr | READ_BURST);
 357  007c 7b03          	ld	a,(OFST+1,sp)
 358  007e aac0          	or	a,#192
 359  0080 cd0000        	call	_SPI_ExchangeByte
 361                     ; 174     for( i = 0; i < size; i ++ )
 363  0083 0f01          	clr	(OFST-1,sp)
 365  0085 201f          	jra	L321
 366  0087               L711:
 367                     ; 176         for( j = 0; j < 20; j ++ );
 369  0087 0f02          	clr	(OFST+0,sp)
 370  0089               L721:
 374  0089 0c02          	inc	(OFST+0,sp)
 377  008b 7b02          	ld	a,(OFST+0,sp)
 378  008d a114          	cp	a,#20
 379  008f 25f8          	jrult	L721
 380                     ; 177         *( buff + i ) = SPI_ExchangeByte( 0xFF );
 382  0091 7b06          	ld	a,(OFST+4,sp)
 383  0093 97            	ld	xl,a
 384  0094 7b07          	ld	a,(OFST+5,sp)
 385  0096 1b01          	add	a,(OFST-1,sp)
 386  0098 2401          	jrnc	L21
 387  009a 5c            	incw	x
 388  009b               L21:
 389  009b 02            	rlwa	x,a
 390  009c 89            	pushw	x
 391  009d a6ff          	ld	a,#255
 392  009f cd0000        	call	_SPI_ExchangeByte
 394  00a2 85            	popw	x
 395  00a3 f7            	ld	(x),a
 396                     ; 174     for( i = 0; i < size; i ++ )
 398  00a4 0c01          	inc	(OFST-1,sp)
 399  00a6               L321:
 402  00a6 7b01          	ld	a,(OFST-1,sp)
 403  00a8 1108          	cp	a,(OFST+6,sp)
 404  00aa 25db          	jrult	L711
 405                     ; 179     CC_CSN_HIGH( );
 407  00ac 4b10          	push	#16
 408  00ae ae5005        	ldw	x,#20485
 409  00b1 cd0000        	call	_GPIO_SetBits
 411  00b4 84            	pop	a
 412                     ; 180 }
 415  00b5 5b03          	addw	sp,#3
 416  00b7 81            	ret
 463                     ; 189 INT8U CC1101ReadStatus( INT8U addr )
 463                     ; 190 {
 464                     	switch	.text
 465  00b8               _CC1101ReadStatus:
 467  00b8 88            	push	a
 468  00b9 88            	push	a
 469       00000001      OFST:	set	1
 472                     ; 192     CC_CSN_LOW( );
 474  00ba 4b10          	push	#16
 475  00bc ae5005        	ldw	x,#20485
 476  00bf cd0000        	call	_GPIO_ResetBits
 478  00c2 84            	pop	a
 480  00c3               L161:
 483  00c3 4b80          	push	#128
 484  00c5 ae5005        	ldw	x,#20485
 485  00c8 cd0000        	call	_GPIO_ReadInputDataBit
 487  00cb 5b01          	addw	sp,#1
 488  00cd 4d            	tnz	a
 489  00ce 26f3          	jrne	L161
 490                     ; 193     SPI_ExchangeByte( addr | READ_BURST);
 493  00d0 7b02          	ld	a,(OFST+1,sp)
 494  00d2 aac0          	or	a,#192
 495  00d4 cd0000        	call	_SPI_ExchangeByte
 497                     ; 194     i = SPI_ExchangeByte( 0xFF );
 499  00d7 a6ff          	ld	a,#255
 500  00d9 cd0000        	call	_SPI_ExchangeByte
 502  00dc 6b01          	ld	(OFST+0,sp),a
 503                     ; 195     CC_CSN_HIGH( );
 505  00de 4b10          	push	#16
 506  00e0 ae5005        	ldw	x,#20485
 507  00e3 cd0000        	call	_GPIO_SetBits
 509  00e6 84            	pop	a
 510                     ; 196     return i;
 512  00e7 7b01          	ld	a,(OFST+0,sp)
 515  00e9 85            	popw	x
 516  00ea 81            	ret
 540                     ; 208 void CC1101Sleep(void)
 540                     ; 209 {
 541                     	switch	.text
 542  00eb               _CC1101Sleep:
 546                     ; 210 	CC1101WriteCmd(CC1101_SPWD);
 548  00eb a639          	ld	a,#57
 549  00ed cd0189        	call	_CC1101WriteCmd
 551                     ; 211 }
 554  00f0 81            	ret
 611                     ; 220 void CC1101SetTRMode( TRMODE mode )
 611                     ; 221 {
 612                     	switch	.text
 613  00f1               _CC1101SetTRMode:
 615  00f1 88            	push	a
 616       00000000      OFST:	set	0
 619                     ; 222     if( mode == TX_MODE )
 621  00f2 4d            	tnz	a
 622  00f3 260f          	jrne	L322
 623                     ; 224         CC1101WriteReg(CC1101_IOCFG0,0x46);
 625  00f5 ae0046        	ldw	x,#70
 626  00f8 a602          	ld	a,#2
 627  00fa 95            	ld	xh,a
 628  00fb ad1b          	call	_CC1101WriteReg
 630                     ; 225         CC1101WriteCmd( CC1101_STX );
 632  00fd a635          	ld	a,#53
 633  00ff cd0189        	call	_CC1101WriteCmd
 636  0102 2012          	jra	L522
 637  0104               L322:
 638                     ; 227     else if( mode == RX_MODE )
 640  0104 7b01          	ld	a,(OFST+1,sp)
 641  0106 a101          	cp	a,#1
 642  0108 260c          	jrne	L522
 643                     ; 229         CC1101WriteReg(CC1101_IOCFG0,0x46);
 645  010a ae0046        	ldw	x,#70
 646  010d a602          	ld	a,#2
 647  010f 95            	ld	xh,a
 648  0110 ad06          	call	_CC1101WriteReg
 650                     ; 230         CC1101WriteCmd( CC1101_SRX );
 652  0112 a634          	ld	a,#52
 653  0114 ad73          	call	_CC1101WriteCmd
 655  0116               L522:
 656                     ; 232 }
 659  0116 84            	pop	a
 660  0117 81            	ret
 707                     ; 242 void CC1101WriteReg( INT8U addr, INT8U value )
 707                     ; 243 {
 708                     	switch	.text
 709  0118               _CC1101WriteReg:
 711  0118 89            	pushw	x
 712       00000000      OFST:	set	0
 715                     ; 244     CC_CSN_LOW( );
 717  0119 4b10          	push	#16
 718  011b ae5005        	ldw	x,#20485
 719  011e cd0000        	call	_GPIO_ResetBits
 721  0121 84            	pop	a
 723  0122               L552:
 726  0122 4b80          	push	#128
 727  0124 ae5005        	ldw	x,#20485
 728  0127 cd0000        	call	_GPIO_ReadInputDataBit
 730  012a 5b01          	addw	sp,#1
 731  012c 4d            	tnz	a
 732  012d 26f3          	jrne	L552
 733                     ; 245     SPI_ExchangeByte( addr );
 736  012f 7b01          	ld	a,(OFST+1,sp)
 737  0131 cd0000        	call	_SPI_ExchangeByte
 739                     ; 246     SPI_ExchangeByte( value );
 741  0134 7b02          	ld	a,(OFST+2,sp)
 742  0136 cd0000        	call	_SPI_ExchangeByte
 744                     ; 247     CC_CSN_HIGH( );
 746  0139 4b10          	push	#16
 747  013b ae5005        	ldw	x,#20485
 748  013e cd0000        	call	_GPIO_SetBits
 750  0141 84            	pop	a
 751                     ; 248 }
 754  0142 85            	popw	x
 755  0143 81            	ret
 822                     ; 259 void CC1101WriteMultiReg( INT8U addr, INT8U *buff, INT8U size )
 822                     ; 260 {
 823                     	switch	.text
 824  0144               _CC1101WriteMultiReg:
 826  0144 88            	push	a
 827  0145 88            	push	a
 828       00000001      OFST:	set	1
 831                     ; 262     CC_CSN_LOW( );
 833  0146 4b10          	push	#16
 834  0148 ae5005        	ldw	x,#20485
 835  014b cd0000        	call	_GPIO_ResetBits
 837  014e 84            	pop	a
 839  014f               L513:
 842  014f 4b80          	push	#128
 843  0151 ae5005        	ldw	x,#20485
 844  0154 cd0000        	call	_GPIO_ReadInputDataBit
 846  0157 5b01          	addw	sp,#1
 847  0159 4d            	tnz	a
 848  015a 26f3          	jrne	L513
 849                     ; 263     SPI_ExchangeByte( addr | WRITE_BURST );
 852  015c 7b02          	ld	a,(OFST+1,sp)
 853  015e aa40          	or	a,#64
 854  0160 cd0000        	call	_SPI_ExchangeByte
 856                     ; 264     for( i = 0; i < size; i ++ )
 858  0163 0f01          	clr	(OFST+0,sp)
 860  0165 2011          	jra	L523
 861  0167               L123:
 862                     ; 266         SPI_ExchangeByte( *( buff + i ) );
 864  0167 7b05          	ld	a,(OFST+4,sp)
 865  0169 97            	ld	xl,a
 866  016a 7b06          	ld	a,(OFST+5,sp)
 867  016c 1b01          	add	a,(OFST+0,sp)
 868  016e 2401          	jrnc	L62
 869  0170 5c            	incw	x
 870  0171               L62:
 871  0171 02            	rlwa	x,a
 872  0172 f6            	ld	a,(x)
 873  0173 cd0000        	call	_SPI_ExchangeByte
 875                     ; 264     for( i = 0; i < size; i ++ )
 877  0176 0c01          	inc	(OFST+0,sp)
 878  0178               L523:
 881  0178 7b01          	ld	a,(OFST+0,sp)
 882  017a 1107          	cp	a,(OFST+6,sp)
 883  017c 25e9          	jrult	L123
 884                     ; 268     CC_CSN_HIGH( );
 886  017e 4b10          	push	#16
 887  0180 ae5005        	ldw	x,#20485
 888  0183 cd0000        	call	_GPIO_SetBits
 890  0186 84            	pop	a
 891                     ; 269 }
 894  0187 85            	popw	x
 895  0188 81            	ret
 933                     ; 278 void CC1101WriteCmd( INT8U command )
 933                     ; 279 {
 934                     	switch	.text
 935  0189               _CC1101WriteCmd:
 937  0189 88            	push	a
 938       00000000      OFST:	set	0
 941                     ; 280     CC_CSN_LOW( );
 943  018a 4b10          	push	#16
 944  018c ae5005        	ldw	x,#20485
 945  018f cd0000        	call	_GPIO_ResetBits
 947  0192 84            	pop	a
 949  0193               L153:
 952  0193 4b80          	push	#128
 953  0195 ae5005        	ldw	x,#20485
 954  0198 cd0000        	call	_GPIO_ReadInputDataBit
 956  019b 5b01          	addw	sp,#1
 957  019d 4d            	tnz	a
 958  019e 26f3          	jrne	L153
 959                     ; 281     SPI_ExchangeByte( command );
 962  01a0 7b01          	ld	a,(OFST+1,sp)
 963  01a2 cd0000        	call	_SPI_ExchangeByte
 965                     ; 282     CC_CSN_HIGH( );
 967  01a5 4b10          	push	#16
 968  01a7 ae5005        	ldw	x,#20485
 969  01aa cd0000        	call	_GPIO_SetBits
 971  01ad 84            	pop	a
 972                     ; 283 }
 975  01ae 84            	pop	a
 976  01af 81            	ret
1014                     ; 292 void CC1101Reset( void )
1014                     ; 293 {
1015                     	switch	.text
1016  01b0               _CC1101Reset:
1018  01b0 88            	push	a
1019       00000001      OFST:	set	1
1022                     ; 296     CC_CSN_HIGH( );
1024  01b1 4b10          	push	#16
1025  01b3 ae5005        	ldw	x,#20485
1026  01b6 cd0000        	call	_GPIO_SetBits
1028  01b9 84            	pop	a
1029                     ; 297     CC_CSN_LOW( );
1031  01ba 4b10          	push	#16
1032  01bc ae5005        	ldw	x,#20485
1033  01bf cd0000        	call	_GPIO_ResetBits
1035  01c2 84            	pop	a
1037  01c3               L573:
1040  01c3 4b80          	push	#128
1041  01c5 ae5005        	ldw	x,#20485
1042  01c8 cd0000        	call	_GPIO_ReadInputDataBit
1044  01cb 5b01          	addw	sp,#1
1045  01cd 4d            	tnz	a
1046  01ce 26f3          	jrne	L573
1047                     ; 298     CC_CSN_HIGH( );
1050  01d0 4b10          	push	#16
1051  01d2 ae5005        	ldw	x,#20485
1052  01d5 cd0000        	call	_GPIO_SetBits
1054  01d8 84            	pop	a
1055                     ; 299     for( x = 0; x < 100; x ++ );
1057  01d9 0f01          	clr	(OFST+0,sp)
1058  01db               L104:
1062  01db 0c01          	inc	(OFST+0,sp)
1065  01dd 7b01          	ld	a,(OFST+0,sp)
1066  01df a164          	cp	a,#100
1067  01e1 25f8          	jrult	L104
1068                     ; 300     CC1101WriteCmd( CC1101_SRES );
1070  01e3 a630          	ld	a,#48
1071  01e5 ada2          	call	_CC1101WriteCmd
1073                     ; 301 }
1076  01e7 84            	pop	a
1077  01e8 81            	ret
1101                     ; 310 void CC1101SetIdle( void )
1101                     ; 311 {
1102                     	switch	.text
1103  01e9               _CC1101SetIdle:
1107                     ; 312     CC1101WriteCmd(CC1101_SIDLE);
1109  01e9 a636          	ld	a,#54
1110  01eb ad9c          	call	_CC1101WriteCmd
1112                     ; 313 }
1115  01ed 81            	ret
1140                     ; 322 void CC1101ClrTXBuff( void )
1140                     ; 323 {
1141                     	switch	.text
1142  01ee               _CC1101ClrTXBuff:
1146                     ; 324     CC1101SetIdle();//MUST BE IDLE MODE
1148  01ee adf9          	call	_CC1101SetIdle
1150                     ; 325     CC1101WriteCmd( CC1101_SFTX );
1152  01f0 a63b          	ld	a,#59
1153  01f2 ad95          	call	_CC1101WriteCmd
1155                     ; 326 }
1158  01f4 81            	ret
1183                     ; 335 void CC1101ClrRXBuff( void )
1183                     ; 336 {
1184                     	switch	.text
1185  01f5               _CC1101ClrRXBuff:
1189                     ; 337     CC1101SetIdle();//MUST BE IDLE MODE
1191  01f5 adf2          	call	_CC1101SetIdle
1193                     ; 338     CC1101WriteCmd( CC1101_SFRX );
1195  01f7 a63a          	ld	a,#58
1196  01f9 ad8e          	call	_CC1101WriteCmd
1198                     ; 339 }
1201  01fb 81            	ret
1290                     ; 350 void CC1101SendPacket( INT8U *txbuffer, INT8U size, TX_DATA_MODE mode )
1290                     ; 351 {
1291                     	switch	.text
1292  01fc               _CC1101SendPacket:
1294  01fc 89            	pushw	x
1295  01fd 88            	push	a
1296       00000001      OFST:	set	1
1299                     ; 353     if( mode == BROADCAST )             { address = 0; }
1301  01fe 0d07          	tnz	(OFST+6,sp)
1302  0200 2604          	jrne	L105
1305  0202 0f01          	clr	(OFST+0,sp)
1307  0204 200d          	jra	L305
1308  0206               L105:
1309                     ; 354     else if( mode == ADDRESS_CHECK )    { address = CC1101ReadReg( CC1101_ADDR ); }
1311  0206 7b07          	ld	a,(OFST+6,sp)
1312  0208 a101          	cp	a,#1
1313  020a 2607          	jrne	L305
1316  020c a609          	ld	a,#9
1317  020e cd0031        	call	_CC1101ReadReg
1319  0211 6b01          	ld	(OFST+0,sp),a
1320  0213               L305:
1321                     ; 356     CC1101ClrTXBuff( );
1323  0213 add9          	call	_CC1101ClrTXBuff
1325                     ; 358     if( ( CC1101ReadReg( CC1101_PKTCTRL1 ) & ~0x03 ) != 0 )
1327  0215 a607          	ld	a,#7
1328  0217 cd0031        	call	_CC1101ReadReg
1330  021a a5fc          	bcp	a,#252
1331  021c 2715          	jreq	L705
1332                     ; 360         CC1101WriteReg( CC1101_TXFIFO, size + 1 );
1334  021e 7b06          	ld	a,(OFST+5,sp)
1335  0220 4c            	inc	a
1336  0221 97            	ld	xl,a
1337  0222 a63f          	ld	a,#63
1338  0224 95            	ld	xh,a
1339  0225 cd0118        	call	_CC1101WriteReg
1341                     ; 361         CC1101WriteReg( CC1101_TXFIFO, address );
1343  0228 7b01          	ld	a,(OFST+0,sp)
1344  022a 97            	ld	xl,a
1345  022b a63f          	ld	a,#63
1346  022d 95            	ld	xh,a
1347  022e cd0118        	call	_CC1101WriteReg
1350  0231 2009          	jra	L115
1351  0233               L705:
1352                     ; 365         CC1101WriteReg( CC1101_TXFIFO, size );
1354  0233 7b06          	ld	a,(OFST+5,sp)
1355  0235 97            	ld	xl,a
1356  0236 a63f          	ld	a,#63
1357  0238 95            	ld	xh,a
1358  0239 cd0118        	call	_CC1101WriteReg
1360  023c               L115:
1361                     ; 368     CC1101WriteMultiReg( CC1101_TXFIFO, txbuffer, size );
1363  023c 7b06          	ld	a,(OFST+5,sp)
1364  023e 88            	push	a
1365  023f 1e03          	ldw	x,(OFST+2,sp)
1366  0241 89            	pushw	x
1367  0242 a63f          	ld	a,#63
1368  0244 cd0144        	call	_CC1101WriteMultiReg
1370  0247 5b03          	addw	sp,#3
1371                     ; 369     CC1101SetTRMode( TX_MODE );
1373  0249 4f            	clr	a
1374  024a cd00f1        	call	_CC1101SetTRMode
1377  024d               L515:
1378                     ; 370     while( GPIO_ReadInputDataBit( GPIOA, GPIO_Pin_2 ) != 0 );
1380  024d 4b04          	push	#4
1381  024f ae5000        	ldw	x,#20480
1382  0252 cd0000        	call	_GPIO_ReadInputDataBit
1384  0255 5b01          	addw	sp,#1
1385  0257 4d            	tnz	a
1386  0258 26f3          	jrne	L515
1388  025a               L325:
1389                     ; 371     while( GPIO_ReadInputDataBit( GPIOA, GPIO_Pin_2 ) == 0 );
1391  025a 4b04          	push	#4
1392  025c ae5000        	ldw	x,#20480
1393  025f cd0000        	call	_GPIO_ReadInputDataBit
1395  0262 5b01          	addw	sp,#1
1396  0264 4d            	tnz	a
1397  0265 27f3          	jreq	L325
1398                     ; 373     CC1101ClrTXBuff( );
1400  0267 ad85          	call	_CC1101ClrTXBuff
1402                     ; 374 }
1405  0269 5b03          	addw	sp,#3
1406  026b 81            	ret
1430                     ; 383 INT8U CC1101GetRXCnt( void )
1430                     ; 384 {
1431                     	switch	.text
1432  026c               _CC1101GetRXCnt:
1436                     ; 385     return ( CC1101ReadStatus( CC1101_RXBYTES )  & BYTES_IN_RXFIFO );
1438  026c a63b          	ld	a,#59
1439  026e cd00b8        	call	_CC1101ReadStatus
1441  0271 a47f          	and	a,#127
1444  0273 81            	ret
1533                     ; 396 void CC1101SetAddress( INT8U address, ADDR_MODE AddressMode)
1533                     ; 397 {
1534                     	switch	.text
1535  0274               _CC1101SetAddress:
1537  0274 89            	pushw	x
1538  0275 88            	push	a
1539       00000001      OFST:	set	1
1542                     ; 398     INT8U btmp = CC1101ReadReg( CC1101_PKTCTRL1 ) & ~0x03;
1544  0276 a607          	ld	a,#7
1545  0278 cd0031        	call	_CC1101ReadReg
1547  027b a4fc          	and	a,#252
1548  027d 6b01          	ld	(OFST+0,sp),a
1549                     ; 399     CC1101WriteReg(CC1101_ADDR, address);
1551  027f 7b02          	ld	a,(OFST+1,sp)
1552  0281 97            	ld	xl,a
1553  0282 a609          	ld	a,#9
1554  0284 95            	ld	xh,a
1555  0285 cd0118        	call	_CC1101WriteReg
1557                     ; 400     if     ( AddressMode == BROAD_ALL )     {}
1559  0288 0d03          	tnz	(OFST+2,sp)
1560  028a 2728          	jreq	L306
1562                     ; 401     else if( AddressMode == BROAD_NO  )     { btmp |= 0x01; }
1564  028c 7b03          	ld	a,(OFST+2,sp)
1565  028e a101          	cp	a,#1
1566  0290 2608          	jrne	L506
1569  0292 7b01          	ld	a,(OFST+0,sp)
1570  0294 aa01          	or	a,#1
1571  0296 6b01          	ld	(OFST+0,sp),a
1573  0298 201a          	jra	L306
1574  029a               L506:
1575                     ; 402     else if( AddressMode == BROAD_0   )     { btmp |= 0x02; }
1577  029a 7b03          	ld	a,(OFST+2,sp)
1578  029c a102          	cp	a,#2
1579  029e 2608          	jrne	L116
1582  02a0 7b01          	ld	a,(OFST+0,sp)
1583  02a2 aa02          	or	a,#2
1584  02a4 6b01          	ld	(OFST+0,sp),a
1586  02a6 200c          	jra	L306
1587  02a8               L116:
1588                     ; 403     else if( AddressMode == BROAD_0AND255 ) { btmp |= 0x03; }   
1590  02a8 7b03          	ld	a,(OFST+2,sp)
1591  02aa a103          	cp	a,#3
1592  02ac 2606          	jrne	L306
1595  02ae 7b01          	ld	a,(OFST+0,sp)
1596  02b0 aa03          	or	a,#3
1597  02b2 6b01          	ld	(OFST+0,sp),a
1598  02b4               L306:
1599                     ; 404 }
1602  02b4 5b03          	addw	sp,#3
1603  02b6 81            	ret
1638                     ; 413 void CC1101SetSYNC( INT16U sync )
1638                     ; 414 {
1639                     	switch	.text
1640  02b7               _CC1101SetSYNC:
1642  02b7 89            	pushw	x
1643       00000000      OFST:	set	0
1646                     ; 415     CC1101WriteReg(CC1101_SYNC1, 0xFF & ( sync>>8 ) );
1648  02b8 9e            	ld	a,xh
1649  02b9 97            	ld	xl,a
1650  02ba a604          	ld	a,#4
1651  02bc 95            	ld	xh,a
1652  02bd cd0118        	call	_CC1101WriteReg
1654                     ; 416     CC1101WriteReg(CC1101_SYNC0, 0xFF & sync ); 
1656  02c0 7b02          	ld	a,(OFST+2,sp)
1657  02c2 a4ff          	and	a,#255
1658  02c4 97            	ld	xl,a
1659  02c5 a605          	ld	a,#5
1660  02c7 95            	ld	xh,a
1661  02c8 cd0118        	call	_CC1101WriteReg
1663                     ; 417 }
1666  02cb 85            	popw	x
1667  02cc 81            	ret
1743                     ; 426 INT8U CC1101RecPacket( INT8U *rxBuffer )
1743                     ; 427 {
1744                     	switch	.text
1745  02cd               _CC1101RecPacket:
1747  02cd 89            	pushw	x
1748  02ce 5207          	subw	sp,#7
1749       00000007      OFST:	set	7
1752                     ; 430     INT16U x , j = 0;
1754  02d0 5f            	clrw	x
1755  02d1 1f01          	ldw	(OFST-6,sp),x
1756                     ; 432     if ( CC1101GetRXCnt( ) != 0 )
1758  02d3 ad97          	call	_CC1101GetRXCnt
1760  02d5 4d            	tnz	a
1761  02d6 274a          	jreq	L376
1762                     ; 434         pktLen = CC1101ReadReg(CC1101_RXFIFO);           // Read length byte
1764  02d8 a63f          	ld	a,#63
1765  02da cd0031        	call	_CC1101ReadReg
1767  02dd 6b07          	ld	(OFST+0,sp),a
1768                     ; 435         if( ( CC1101ReadReg( CC1101_PKTCTRL1 ) & ~0x03 ) != 0 )
1770  02df a607          	ld	a,#7
1771  02e1 cd0031        	call	_CC1101ReadReg
1773  02e4 a5fc          	bcp	a,#252
1774  02e6 2705          	jreq	L576
1775                     ; 437             x = CC1101ReadReg(CC1101_RXFIFO);
1777  02e8 a63f          	ld	a,#63
1778  02ea cd0031        	call	_CC1101ReadReg
1780  02ed               L576:
1781                     ; 439         if( pktLen == 0 )           { return 0; }
1783  02ed 0d07          	tnz	(OFST+0,sp)
1784  02ef 2603          	jrne	L776
1787  02f1 4f            	clr	a
1789  02f2 2028          	jra	L45
1790  02f4               L776:
1791                     ; 440         else                        { pktLen --; }
1793  02f4 0a07          	dec	(OFST+0,sp)
1794                     ; 441         CC1101ReadMultiReg(CC1101_RXFIFO, rxBuffer, pktLen); // Pull data
1796  02f6 7b07          	ld	a,(OFST+0,sp)
1797  02f8 88            	push	a
1798  02f9 1e09          	ldw	x,(OFST+2,sp)
1799  02fb 89            	pushw	x
1800  02fc a63f          	ld	a,#63
1801  02fe cd0064        	call	_CC1101ReadMultiReg
1803  0301 5b03          	addw	sp,#3
1804                     ; 442         CC1101ReadMultiReg(CC1101_RXFIFO, status, 2);   // Read  status bytes
1806  0303 4b02          	push	#2
1807  0305 96            	ldw	x,sp
1808  0306 1c0006        	addw	x,#OFST-1
1809  0309 89            	pushw	x
1810  030a a63f          	ld	a,#63
1811  030c cd0064        	call	_CC1101ReadMultiReg
1813  030f 5b03          	addw	sp,#3
1814                     ; 444         CC1101ClrRXBuff( );
1816  0311 cd01f5        	call	_CC1101ClrRXBuff
1818                     ; 446         if( status[1] & CRC_OK ) {   return pktLen; }
1820  0314 7b06          	ld	a,(OFST-1,sp)
1821  0316 a580          	bcp	a,#128
1822  0318 2705          	jreq	L307
1825  031a 7b07          	ld	a,(OFST+0,sp)
1827  031c               L45:
1829  031c 5b09          	addw	sp,#9
1830  031e 81            	ret
1831  031f               L307:
1832                     ; 447         else                     {   return 0; }
1834  031f 4f            	clr	a
1836  0320 20fa          	jra	L45
1837  0322               L376:
1838                     ; 449     else   {  return 0; }                               // Error
1840  0322 4f            	clr	a
1842  0323 20f7          	jra	L45
1884                     ; 459 void CC1101Init( void )
1884                     ; 460 {
1885                     	switch	.text
1886  0325               _CC1101Init:
1888  0325 88            	push	a
1889       00000001      OFST:	set	1
1892                     ; 463     CC1101Reset( );    
1894  0326 cd01b0        	call	_CC1101Reset
1896                     ; 465     for( i = 0; i < 23; i++ )
1898  0329 0f01          	clr	(OFST+0,sp)
1900  032b 201b          	jra	L337
1901  032d               L727:
1902                     ; 467         CC1101WriteReg( CC1101InitData[i][0], CC1101InitData[i][1] );
1904  032d 7b01          	ld	a,(OFST+0,sp)
1905  032f 5f            	clrw	x
1906  0330 97            	ld	xl,a
1907  0331 58            	sllw	x
1908  0332 d60009        	ld	a,(L3_CC1101InitData+1,x)
1909  0335 97            	ld	xl,a
1910  0336 7b01          	ld	a,(OFST+0,sp)
1911  0338 905f          	clrw	y
1912  033a 9097          	ld	yl,a
1913  033c 9058          	sllw	y
1914  033e 90d60008      	ld	a,(L3_CC1101InitData,y)
1915  0342 95            	ld	xh,a
1916  0343 cd0118        	call	_CC1101WriteReg
1918                     ; 465     for( i = 0; i < 23; i++ )
1920  0346 0c01          	inc	(OFST+0,sp)
1921  0348               L337:
1924  0348 7b01          	ld	a,(OFST+0,sp)
1925  034a a117          	cp	a,#23
1926  034c 25df          	jrult	L727
1927                     ; 469     CC1101SetAddress( 0x05, BROAD_0AND255 );
1929  034e ae0003        	ldw	x,#3
1930  0351 a605          	ld	a,#5
1931  0353 95            	ld	xh,a
1932  0354 cd0274        	call	_CC1101SetAddress
1934                     ; 470     CC1101SetSYNC( 0x8799 );
1936  0357 ae8799        	ldw	x,#34713
1937  035a cd02b7        	call	_CC1101SetSYNC
1939                     ; 473     CC1101WriteMultiReg(CC1101_PATABLE, PaTabel, 8 );
1941  035d 4b08          	push	#8
1942  035f ae0000        	ldw	x,#_PaTabel
1943  0362 89            	pushw	x
1944  0363 a63e          	ld	a,#62
1945  0365 cd0144        	call	_CC1101WriteMultiReg
1947  0368 5b03          	addw	sp,#3
1948                     ; 475     i = CC1101ReadStatus( CC1101_PARTNUM );//for test, must be 0x80
1950  036a a630          	ld	a,#48
1951  036c cd00b8        	call	_CC1101ReadStatus
1953  036f 6b01          	ld	(OFST+0,sp),a
1954                     ; 476     i = CC1101ReadStatus( CC1101_VERSION );//for test, refer to the datasheet
1956  0371 a631          	ld	a,#49
1957  0373 cd00b8        	call	_CC1101ReadStatus
1959  0376 6b01          	ld	(OFST+0,sp),a
1960                     ; 477 }
1963  0378 84            	pop	a
1964  0379 81            	ret
2000                     	xdef	_CC1101WriteMultiReg
2001                     	xdef	_CC1101Reset
2002                     	xdef	_CC1101GetRXCnt
2003                     	xdef	_CC1101ClrRXBuff
2004                     	xdef	_CC1101ClrTXBuff
2005                     	xdef	_CC1101WriteReg
2006                     	xdef	_CC1101ReadMultiReg
2007                     	xdef	_PaTabel
2008                     	xdef	_CC1101Sleep
2009                     	xdef	_CC1101Init
2010                     	xdef	_CC1101WORInit
2011                     	xdef	_CC1101RecPacket
2012                     	xdef	_CC1101SetSYNC
2013                     	xdef	_CC1101SetAddress
2014                     	xdef	_CC1101SendPacket
2015                     	xdef	_CC1101SetIdle
2016                     	xdef	_CC1101WriteCmd
2017                     	xdef	_CC1101SetTRMode
2018                     	xdef	_CC1101ReadStatus
2019                     	xdef	_CC1101ReadReg
2020                     	xref	_SPI_ExchangeByte
2021                     	xref	_GPIO_ReadInputDataBit
2022                     	xref	_GPIO_ResetBits
2023                     	xref	_GPIO_SetBits
2042                     	end
