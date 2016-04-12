   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     	bsct
  16  0000               _yy_stats:
  17  0000 00            	dc.b	0
  18  0001               _op:
  19  0001 00            	dc.b	0
  20  0002               _yy:
  21  0002 00            	dc.b	0
  22  0003               _s_cnt:
  23  0003 00            	dc.b	0
  24  0004               _yy_nr:
  25  0004 00            	dc.b	0
  26  0005 000000000000  	ds.b	19
  27  0018               _yy_cnt:
  28  0018 00            	dc.b	0
  29  0019               _nr_cnt:
  30  0019 00            	dc.b	0
  66                     ; 23 static void TIM4_Config(void)
  66                     ; 24 {
  68                     	switch	.text
  69  0000               L3_TIM4_Config:
  73                     ; 26   CLK_PeripheralClockConfig(CLK_Peripheral_TIM4, ENABLE);
  75  0000 ae0001        	ldw	x,#1
  76  0003 a604          	ld	a,#4
  77  0005 95            	ld	xh,a
  78  0006 cd0000        	call	_CLK_PeripheralClockConfig
  80                     ; 28   TIM4_DeInit();
  82  0009 cd0000        	call	_TIM4_DeInit
  84                     ; 31   TIM4_TimeBaseInit(TIM4_Prescaler_64, 0xFF);
  86  000c ae00ff        	ldw	x,#255
  87  000f a606          	ld	a,#6
  88  0011 95            	ld	xh,a
  89  0012 cd0000        	call	_TIM4_TimeBaseInit
  91                     ; 32   TIM4_ITConfig(TIM4_IT_Update, ENABLE);
  93  0015 ae0001        	ldw	x,#1
  94  0018 a601          	ld	a,#1
  95  001a 95            	ld	xh,a
  96  001b cd0000        	call	_TIM4_ITConfig
  98                     ; 34   enableInterrupts();
 101  001e 9a            rim
 103                     ; 37   TIM4_Cmd(ENABLE);
 106  001f a601          	ld	a,#1
 107  0021 cd0000        	call	_TIM4_Cmd
 109                     ; 38 	TIM4_SetCounter(0);
 111  0024 4f            	clr	a
 112  0025 cd0000        	call	_TIM4_SetCounter
 114                     ; 39 }
 117  0028 81            	ret
 151                     ; 41 void time4_handle(void)
 151                     ; 42 {
 152                     	switch	.text
 153  0029               _time4_handle:
 157                     ; 45 	key_work();
 159  0029 cd02d5        	call	_key_work
 161                     ; 46 	switch (yy_stats)
 163  002c b600          	ld	a,_yy_stats
 165                     ; 96 		break;	
 166  002e 4d            	tnz	a
 167  002f 2710          	jreq	L32
 168  0031 4a            	dec	a
 169  0032 2765          	jreq	L52
 170  0034 4a            	dec	a
 171  0035 2771          	jreq	L72
 172  0037 4a            	dec	a
 173  0038 2603          	jrne	L01
 174  003a cc00dd        	jp	L13
 175  003d               L01:
 176  003d ac080108      	jpf	L54
 177  0041               L32:
 178                     ; 48 		case IDLE:
 178                     ; 49 			if(op == START || op == RUNNING)
 180  0041 b601          	ld	a,_op
 181  0043 a101          	cp	a,#1
 182  0045 2709          	jreq	L15
 184  0047 b601          	ld	a,_op
 185  0049 a102          	cp	a,#2
 186  004b 2703          	jreq	L21
 187  004d cc0108        	jp	L54
 188  0050               L21:
 189  0050               L15:
 190                     ; 51 				yy = yy_nr[yy_cnt]+yy_nr[yy_cnt];
 192  0050 b618          	ld	a,_yy_cnt
 193  0052 5f            	clrw	x
 194  0053 97            	ld	xl,a
 195  0054 b618          	ld	a,_yy_cnt
 196  0056 905f          	clrw	y
 197  0058 9097          	ld	yl,a
 198  005a 90e604        	ld	a,(_yy_nr,y)
 199  005d eb04          	add	a,(_yy_nr,x)
 200  005f b702          	ld	_yy,a
 201                     ; 52 				s_cnt = 0;
 203  0061 3f03          	clr	_s_cnt
 204                     ; 53 				if(yy_cnt+1 < nr_cnt)
 206  0063 9c            	rvf
 207  0064 b619          	ld	a,_nr_cnt
 208  0066 5f            	clrw	x
 209  0067 97            	ld	xl,a
 210  0068 b618          	ld	a,_yy_cnt
 211  006a 905f          	clrw	y
 212  006c 9097          	ld	yl,a
 213  006e 905c          	incw	y
 214  0070 bf00          	ldw	c_x,x
 215  0072 90b300        	cpw	y,c_x
 216  0075 2e06          	jrsge	L35
 217                     ; 54 					op = RUNNING;
 219  0077 35020001      	mov	_op,#2
 221  007b 2002          	jra	L55
 222  007d               L35:
 223                     ; 56 					op = STOP;
 225  007d 3f01          	clr	_op
 226  007f               L55:
 227                     ; 57 				yy_cnt ++;
 229  007f 3c18          	inc	_yy_cnt
 230                     ; 58 				YY_RST_H;
 232  0081 4b08          	push	#8
 233  0083 ae5005        	ldw	x,#20485
 234  0086 cd0000        	call	_GPIO_SetBits
 236  0089 84            	pop	a
 237                     ; 59 				YY_DAT_L;
 239  008a 4b04          	push	#4
 240  008c ae5005        	ldw	x,#20485
 241  008f cd0000        	call	_GPIO_ResetBits
 243  0092 84            	pop	a
 244                     ; 60 				yy_stats = S1;
 246  0093 35010000      	mov	_yy_stats,#1
 247  0097 206f          	jra	L54
 248  0099               L52:
 249                     ; 64 		case S1:
 249                     ; 65 			YY_RST_L;
 251  0099 4b08          	push	#8
 252  009b ae5005        	ldw	x,#20485
 253  009e cd0000        	call	_GPIO_ResetBits
 255  00a1 84            	pop	a
 256                     ; 66 			yy_stats =  WT;
 258  00a2 35020000      	mov	_yy_stats,#2
 259                     ; 68 		break;			
 261  00a6 2060          	jra	L54
 262  00a8               L72:
 263                     ; 69 		case WT:
 263                     ; 70 			if(s_cnt&0x01)//奇数
 265  00a8 b603          	ld	a,_s_cnt
 266  00aa a501          	bcp	a,#1
 267  00ac 270b          	jreq	L75
 268                     ; 72 				YY_DAT_L;
 270  00ae 4b04          	push	#4
 271  00b0 ae5005        	ldw	x,#20485
 272  00b3 cd0000        	call	_GPIO_ResetBits
 274  00b6 84            	pop	a
 276  00b7 2009          	jra	L16
 277  00b9               L75:
 278                     ; 76 				YY_DAT_H;
 280  00b9 4b04          	push	#4
 281  00bb ae5005        	ldw	x,#20485
 282  00be cd0000        	call	_GPIO_SetBits
 284  00c1 84            	pop	a
 285  00c2               L16:
 286                     ; 79 			s_cnt ++;
 288  00c2 3c03          	inc	_s_cnt
 289                     ; 80 			if(yy==s_cnt+1)
 291  00c4 b602          	ld	a,_yy
 292  00c6 5f            	clrw	x
 293  00c7 97            	ld	xl,a
 294  00c8 b603          	ld	a,_s_cnt
 295  00ca 905f          	clrw	y
 296  00cc 9097          	ld	yl,a
 297  00ce 905c          	incw	y
 298  00d0 bf00          	ldw	c_x,x
 299  00d2 90b300        	cpw	y,c_x
 300  00d5 2631          	jrne	L54
 301                     ; 82 				yy_stats = BUSY;
 303  00d7 35030000      	mov	_yy_stats,#3
 304  00db 202b          	jra	L54
 305  00dd               L13:
 306                     ; 85 		case BUSY:
 306                     ; 86 			if(YY_NOTBUSY || op == START)
 308  00dd 4b01          	push	#1
 309  00df ae5005        	ldw	x,#20485
 310  00e2 cd0000        	call	_GPIO_ReadInputDataBit
 312  00e5 5b01          	addw	sp,#1
 313  00e7 4d            	tnz	a
 314  00e8 2606          	jrne	L76
 316  00ea b601          	ld	a,_op
 317  00ec a101          	cp	a,#1
 318  00ee 2618          	jrne	L54
 319  00f0               L76:
 320                     ; 88 				yy_stats = IDLE;
 322  00f0 3f00          	clr	_yy_stats
 323                     ; 89 				yy = 0;
 325  00f2 3f02          	clr	_yy
 326                     ; 90 				s_cnt = 0;
 328  00f4 3f03          	clr	_s_cnt
 329                     ; 91 				YY_RST_L;
 331  00f6 4b08          	push	#8
 332  00f8 ae5005        	ldw	x,#20485
 333  00fb cd0000        	call	_GPIO_ResetBits
 335  00fe 84            	pop	a
 336                     ; 92 				YY_DAT_L;
 338  00ff 4b04          	push	#4
 339  0101 ae5005        	ldw	x,#20485
 340  0104 cd0000        	call	_GPIO_ResetBits
 342  0107 84            	pop	a
 343  0108               L54:
 344                     ; 100 }
 347  0108 81            	ret
 371                     ; 101 void key_init(void)
 371                     ; 102 {
 372                     	switch	.text
 373  0109               _key_init:
 377                     ; 103 	GPIO_Init( GPIOB, GPIO_Pin_1, GPIO_Mode_In_PU_No_IT );
 379  0109 4b40          	push	#64
 380  010b 4b02          	push	#2
 381  010d ae5005        	ldw	x,#20485
 382  0110 cd0000        	call	_GPIO_Init
 384  0113 85            	popw	x
 385                     ; 104 	GPIO_Init( GPIOA, GPIO_Pin_3, GPIO_Mode_In_PU_No_IT );
 387  0114 4b40          	push	#64
 388  0116 4b08          	push	#8
 389  0118 ae5000        	ldw	x,#20480
 390  011b cd0000        	call	_GPIO_Init
 392  011e 85            	popw	x
 393                     ; 105 }
 396  011f 81            	ret
 423                     ; 106 void yy_init(void)
 423                     ; 107 {
 424                     	switch	.text
 425  0120               _yy_init:
 429                     ; 109 	TIM4_Config();
 431  0120 cd0000        	call	L3_TIM4_Config
 433                     ; 111 	GPIO_Init( GPIOB, GPIO_BUSY, GPIO_Mode_In_FL_No_IT );
 435  0123 4b00          	push	#0
 436  0125 4b01          	push	#1
 437  0127 ae5005        	ldw	x,#20485
 438  012a cd0000        	call	_GPIO_Init
 440  012d 85            	popw	x
 441                     ; 112 	GPIO_Init( GPIOB, GPIO_DAT|GPIO_RST, GPIO_Mode_Out_PP_High_Fast );
 443  012e 4bf0          	push	#240
 444  0130 4b0c          	push	#12
 445  0132 ae5005        	ldw	x,#20485
 446  0135 cd0000        	call	_GPIO_Init
 448  0138 85            	popw	x
 449                     ; 115 	YY_RST_L;
 451  0139 4b08          	push	#8
 452  013b ae5005        	ldw	x,#20485
 453  013e cd0000        	call	_GPIO_ResetBits
 455  0141 84            	pop	a
 456                     ; 116 	YY_DAT_L;
 458  0142 4b04          	push	#4
 459  0144 ae5005        	ldw	x,#20485
 460  0147 cd0000        	call	_GPIO_ResetBits
 462  014a 84            	pop	a
 463                     ; 118 	key_init();
 465  014b adbc          	call	_key_init
 467                     ; 119 }
 470  014d 81            	ret
 527                     ; 121 void yy_start(u8 cnt,u8 * nr)
 527                     ; 122 {
 528                     	switch	.text
 529  014e               _yy_start:
 531  014e 88            	push	a
 532  014f 88            	push	a
 533       00000001      OFST:	set	1
 536                     ; 125 	for(i=0;i<cnt;i++)
 538  0150 0f01          	clr	(OFST+0,sp)
 540  0152 202c          	jra	L341
 541  0154               L731:
 542                     ; 127 		yy_nr[i]=nr[i];
 544  0154 7b01          	ld	a,(OFST+0,sp)
 545  0156 5f            	clrw	x
 546  0157 97            	ld	xl,a
 547  0158 89            	pushw	x
 548  0159 7b07          	ld	a,(OFST+6,sp)
 549  015b 97            	ld	xl,a
 550  015c 7b08          	ld	a,(OFST+7,sp)
 551  015e 1b03          	add	a,(OFST+2,sp)
 552  0160 2401          	jrnc	L22
 553  0162 5c            	incw	x
 554  0163               L22:
 555  0163 02            	rlwa	x,a
 556  0164 f6            	ld	a,(x)
 557  0165 85            	popw	x
 558  0166 e704          	ld	(_yy_nr,x),a
 559                     ; 128 		if(yy_nr[i] > MAX_NUM || yy_nr[i] <MIN_NUM)
 561  0168 7b01          	ld	a,(OFST+0,sp)
 562  016a 5f            	clrw	x
 563  016b 97            	ld	xl,a
 564  016c e604          	ld	a,(_yy_nr,x)
 565  016e a165          	cp	a,#101
 566  0170 240a          	jruge	L151
 568  0172 7b01          	ld	a,(OFST+0,sp)
 569  0174 5f            	clrw	x
 570  0175 97            	ld	xl,a
 571  0176 e604          	ld	a,(_yy_nr,x)
 572  0178 a103          	cp	a,#3
 573  017a 2402          	jruge	L741
 574  017c               L151:
 575                     ; 129 			return;
 577  017c 2012          	jra	L42
 578  017e               L741:
 579                     ; 125 	for(i=0;i<cnt;i++)
 581  017e 0c01          	inc	(OFST+0,sp)
 582  0180               L341:
 585  0180 7b01          	ld	a,(OFST+0,sp)
 586  0182 1102          	cp	a,(OFST+1,sp)
 587  0184 25ce          	jrult	L731
 588                     ; 131 	op = START;
 590  0186 35010001      	mov	_op,#1
 591                     ; 132 	nr_cnt = cnt;
 593  018a 7b02          	ld	a,(OFST+1,sp)
 594  018c b719          	ld	_nr_cnt,a
 595                     ; 133 	yy_cnt = 0;
 597  018e 3f18          	clr	_yy_cnt
 598                     ; 136 }
 599  0190               L42:
 602  0190 85            	popw	x
 603  0191 81            	ret
 606                     	bsct
 607  001a               L351_key2_cnt:
 608  001a 00            	dc.b	0
 609  001b               L551_s1:
 610  001b 00            	dc.b	0
 678                     ; 138 u8 get_key2(u8 Trg,u8 Count)
 678                     ; 139 {
 679                     	switch	.text
 680  0192               _get_key2:
 682  0192 89            	pushw	x
 683  0193 88            	push	a
 684       00000001      OFST:	set	1
 687                     ; 142 	u8 key = NOKEY;
 689  0194 0f01          	clr	(OFST+0,sp)
 690                     ; 143 	if(Trg & 1<<1)
 692  0196 9e            	ld	a,xh
 693  0197 a502          	bcp	a,#2
 694  0199 2704          	jreq	L512
 695                     ; 145 		s1 = 1;
 697  019b 3501001b      	mov	L551_s1,#1
 698  019f               L512:
 699                     ; 148 	if(Count & 1<<1)
 701  019f 7b03          	ld	a,(OFST+2,sp)
 702  01a1 a502          	bcp	a,#2
 703  01a3 2704          	jreq	L712
 704                     ; 150 		key2_cnt++;
 706  01a5 3c1a          	inc	L351_key2_cnt
 708  01a7 201a          	jra	L122
 709  01a9               L712:
 710                     ; 152 	else if((Count & 1<<1)==0 && s1 == 1)
 712  01a9 7b03          	ld	a,(OFST+2,sp)
 713  01ab a502          	bcp	a,#2
 714  01ad 2610          	jrne	L322
 716  01af b61b          	ld	a,L551_s1
 717  01b1 a101          	cp	a,#1
 718  01b3 260a          	jrne	L322
 719                     ; 154 		key2_cnt=0;
 721  01b5 3f1a          	clr	L351_key2_cnt
 722                     ; 155 		s1 = 0;
 724  01b7 3f1b          	clr	L551_s1
 725                     ; 156 		key = KEY1;
 727  01b9 a601          	ld	a,#1
 728  01bb 6b01          	ld	(OFST+0,sp),a
 730  01bd 2004          	jra	L122
 731  01bf               L322:
 732                     ; 161 		key2_cnt=0;
 734  01bf 3f1a          	clr	L351_key2_cnt
 735                     ; 162 		s1 = 0;
 737  01c1 3f1b          	clr	L551_s1
 738  01c3               L122:
 739                     ; 164 	if(key2_cnt>100 && s1 == 1)
 741  01c3 b61a          	ld	a,L351_key2_cnt
 742  01c5 a165          	cp	a,#101
 743  01c7 250e          	jrult	L722
 745  01c9 b61b          	ld	a,L551_s1
 746  01cb a101          	cp	a,#1
 747  01cd 2608          	jrne	L722
 748                     ; 166 		s1 = 0;
 750  01cf 3f1b          	clr	L551_s1
 751                     ; 167 		key2_cnt = 0;
 753  01d1 3f1a          	clr	L351_key2_cnt
 754                     ; 168 		key = LONGKEY;
 756  01d3 a602          	ld	a,#2
 757  01d5 6b01          	ld	(OFST+0,sp),a
 758  01d7               L722:
 759                     ; 172 	return key;
 761  01d7 7b01          	ld	a,(OFST+0,sp)
 764  01d9 5b03          	addw	sp,#3
 765  01db 81            	ret
 768                     	bsct
 769  001c               L132_key1_cnt:
 770  001c 00            	dc.b	0
 771  001d               L332_s1:
 772  001d 00            	dc.b	0
 840                     ; 175 u8 get_key1(u8 Trg,u8 Count)
 840                     ; 176 {
 841                     	switch	.text
 842  01dc               _get_key1:
 844  01dc 89            	pushw	x
 845  01dd 88            	push	a
 846       00000001      OFST:	set	1
 849                     ; 179 	u8 key = NOKEY;
 851  01de 0f01          	clr	(OFST+0,sp)
 852                     ; 180 	if(Trg & 1<<0)
 854  01e0 9e            	ld	a,xh
 855  01e1 a501          	bcp	a,#1
 856  01e3 2704          	jreq	L372
 857                     ; 182 		s1 = 1;
 859  01e5 3501001d      	mov	L332_s1,#1
 860  01e9               L372:
 861                     ; 185 	if(Count & 1<<0)
 863  01e9 7b03          	ld	a,(OFST+2,sp)
 864  01eb a501          	bcp	a,#1
 865  01ed 2704          	jreq	L572
 866                     ; 187 		key1_cnt++;
 868  01ef 3c1c          	inc	L132_key1_cnt
 870  01f1 201a          	jra	L772
 871  01f3               L572:
 872                     ; 189 	else if((Count & 1<<0)==0 && s1 == 1)
 874  01f3 7b03          	ld	a,(OFST+2,sp)
 875  01f5 a501          	bcp	a,#1
 876  01f7 2610          	jrne	L103
 878  01f9 b61d          	ld	a,L332_s1
 879  01fb a101          	cp	a,#1
 880  01fd 260a          	jrne	L103
 881                     ; 191 		key1_cnt=0;
 883  01ff 3f1c          	clr	L132_key1_cnt
 884                     ; 192 		s1 = 0;
 886  0201 3f1d          	clr	L332_s1
 887                     ; 193 		key = KEY1;
 889  0203 a601          	ld	a,#1
 890  0205 6b01          	ld	(OFST+0,sp),a
 892  0207 2004          	jra	L772
 893  0209               L103:
 894                     ; 198 		key1_cnt=0;
 896  0209 3f1c          	clr	L132_key1_cnt
 897                     ; 199 		s1 = 0;
 899  020b 3f1d          	clr	L332_s1
 900  020d               L772:
 901                     ; 201 	if(key1_cnt>100 && s1 == 1)
 903  020d b61c          	ld	a,L132_key1_cnt
 904  020f a165          	cp	a,#101
 905  0211 250e          	jrult	L503
 907  0213 b61d          	ld	a,L332_s1
 908  0215 a101          	cp	a,#1
 909  0217 2608          	jrne	L503
 910                     ; 203 		s1 = 0;
 912  0219 3f1d          	clr	L332_s1
 913                     ; 204 		key1_cnt = 0;
 915  021b 3f1c          	clr	L132_key1_cnt
 916                     ; 205 		key = LONGKEY;
 918  021d a602          	ld	a,#2
 919  021f 6b01          	ld	(OFST+0,sp),a
 920  0221               L503:
 921                     ; 209 	return key;
 923  0221 7b01          	ld	a,(OFST+0,sp)
 926  0223 5b03          	addw	sp,#3
 927  0225 81            	ret
 930                     	bsct
 931  001e               _Trg:
 932  001e 00            	dc.b	0
 933  001f               _Count:
 934  001f 00            	dc.b	0
 935                     .const:	section	.text
 936  0000               L703_buf:
 937  0000 55            	dc.b	85
 938  0001 01            	dc.b	1
 939  0002 00            	dc.b	0
 995                     ; 213 u8 key_scan(void)
 995                     ; 214 {
 996                     	switch	.text
 997  0226               _key_scan:
 999  0226 5204          	subw	sp,#4
1000       00000004      OFST:	set	4
1003                     ; 215 	u8 key = 0;
1005                     ; 216 	u8 ReadData = 0;
1007                     ; 217 	u8 buf[3] = {0x55,1,0};
1009  0228 96            	ldw	x,sp
1010  0229 1c0001        	addw	x,#OFST-3
1011  022c 90ae0000      	ldw	y,#L703_buf
1012  0230 a603          	ld	a,#3
1013  0232 cd0000        	call	c_xymvx
1015                     ; 218 	ReadData = (GPIOB->IDR & GPIO_Pin_1)>>1;
1017  0235 c65006        	ld	a,20486
1018  0238 a402          	and	a,#2
1019  023a 44            	srl	a
1020  023b 6b04          	ld	(OFST+0,sp),a
1021                     ; 219 	ReadData |= (GPIOA->IDR & GPIO_Pin_3)>>2;
1023  023d c65001        	ld	a,20481
1024  0240 a408          	and	a,#8
1025  0242 44            	srl	a
1026  0243 44            	srl	a
1027  0244 1a04          	or	a,(OFST+0,sp)
1028  0246 6b04          	ld	(OFST+0,sp),a
1029                     ; 220 	ReadData |= 0xfc;	//只有2个KEY
1031  0248 7b04          	ld	a,(OFST+0,sp)
1032  024a aafc          	or	a,#252
1033  024c 6b04          	ld	(OFST+0,sp),a
1034                     ; 223 	ReadData = ReadData^0xff;
1036  024e 7b04          	ld	a,(OFST+0,sp)
1037  0250 a8ff          	xor	a,	#255
1038  0252 6b04          	ld	(OFST+0,sp),a
1039                     ; 224 	Trg = (ReadData^Count)&ReadData;
1041  0254 7b04          	ld	a,(OFST+0,sp)
1042  0256 b81f          	xor	a,_Count
1043  0258 1404          	and	a,(OFST+0,sp)
1044  025a b71e          	ld	_Trg,a
1045                     ; 225 	Count = ReadData;
1047  025c 7b04          	ld	a,(OFST+0,sp)
1048  025e b71f          	ld	_Count,a
1049                     ; 226 	key = get_key1(Trg,Count);
1051  0260 b61f          	ld	a,_Count
1052  0262 97            	ld	xl,a
1053  0263 b61e          	ld	a,_Trg
1054  0265 95            	ld	xh,a
1055  0266 cd01dc        	call	_get_key1
1057  0269 6b04          	ld	(OFST+0,sp),a
1058                     ; 227 	if(key == LONGKEY)
1060  026b 7b04          	ld	a,(OFST+0,sp)
1061  026d a102          	cp	a,#2
1062  026f 2612          	jrne	L733
1063                     ; 229 		buf[2] = 0x01;
1065  0271 a601          	ld	a,#1
1066  0273 6b03          	ld	(OFST-1,sp),a
1067                     ; 230 		uart_sendmultchar(3,&buf[0]);
1069  0275 96            	ldw	x,sp
1070  0276 1c0001        	addw	x,#OFST-3
1071  0279 89            	pushw	x
1072  027a ae0003        	ldw	x,#3
1073  027d cd0000        	call	_uart_sendmultchar
1075  0280 85            	popw	x
1077  0281 2016          	jra	L143
1078  0283               L733:
1079                     ; 233 	else if(key == KEY1)
1081  0283 7b04          	ld	a,(OFST+0,sp)
1082  0285 a101          	cp	a,#1
1083  0287 2610          	jrne	L143
1084                     ; 235 		buf[2] = 0x02;
1086  0289 a602          	ld	a,#2
1087  028b 6b03          	ld	(OFST-1,sp),a
1088                     ; 236 		uart_sendmultchar(3,&buf[0]);
1090  028d 96            	ldw	x,sp
1091  028e 1c0001        	addw	x,#OFST-3
1092  0291 89            	pushw	x
1093  0292 ae0003        	ldw	x,#3
1094  0295 cd0000        	call	_uart_sendmultchar
1096  0298 85            	popw	x
1097  0299               L143:
1098                     ; 238 	key = get_key2(Trg,Count);
1100  0299 b61f          	ld	a,_Count
1101  029b 97            	ld	xl,a
1102  029c b61e          	ld	a,_Trg
1103  029e 95            	ld	xh,a
1104  029f cd0192        	call	_get_key2
1106  02a2 6b04          	ld	(OFST+0,sp),a
1107                     ; 239 	if(key == LONGKEY)
1109  02a4 7b04          	ld	a,(OFST+0,sp)
1110  02a6 a102          	cp	a,#2
1111  02a8 2612          	jrne	L543
1112                     ; 241 		buf[2] = 0x03;
1114  02aa a603          	ld	a,#3
1115  02ac 6b03          	ld	(OFST-1,sp),a
1116                     ; 242 		uart_sendmultchar(3,&buf[0]);
1118  02ae 96            	ldw	x,sp
1119  02af 1c0001        	addw	x,#OFST-3
1120  02b2 89            	pushw	x
1121  02b3 ae0003        	ldw	x,#3
1122  02b6 cd0000        	call	_uart_sendmultchar
1124  02b9 85            	popw	x
1126  02ba 2016          	jra	L743
1127  02bc               L543:
1128                     ; 245 	else if(key == KEY1)
1130  02bc 7b04          	ld	a,(OFST+0,sp)
1131  02be a101          	cp	a,#1
1132  02c0 2610          	jrne	L743
1133                     ; 247 		buf[2] = 0x04;
1135  02c2 a604          	ld	a,#4
1136  02c4 6b03          	ld	(OFST-1,sp),a
1137                     ; 248 		uart_sendmultchar(3,&buf[0]);
1139  02c6 96            	ldw	x,sp
1140  02c7 1c0001        	addw	x,#OFST-3
1141  02ca 89            	pushw	x
1142  02cb ae0003        	ldw	x,#3
1143  02ce cd0000        	call	_uart_sendmultchar
1145  02d1 85            	popw	x
1146  02d2               L743:
1147                     ; 251 	key = NOKEY;
1149                     ; 252 }
1152  02d2 5b04          	addw	sp,#4
1153  02d4 81            	ret
1156                     	bsct
1157  0020               _scan_cnt:
1158  0020 0000          	dc.w	0
1181                     ; 255 void key_work(void)
1181                     ; 256 {
1182                     	switch	.text
1183  02d5               _key_work:
1187                     ; 257 	scan_cnt++;
1189  02d5 be20          	ldw	x,_scan_cnt
1190  02d7 1c0001        	addw	x,#1
1191  02da bf20          	ldw	_scan_cnt,x
1192                     ; 258 	if(scan_cnt == 20)
1194  02dc be20          	ldw	x,_scan_cnt
1195  02de a30014        	cpw	x,#20
1196  02e1 2606          	jrne	L363
1197                     ; 260 		key_scan();
1199  02e3 cd0226        	call	_key_scan
1201                     ; 261 		scan_cnt = 0;
1203  02e6 5f            	clrw	x
1204  02e7 bf20          	ldw	_scan_cnt,x
1205  02e9               L363:
1206                     ; 264 }
1209  02e9 81            	ret
1315                     	xdef	_scan_cnt
1316                     	xdef	_key_scan
1317                     	xdef	_Count
1318                     	xdef	_Trg
1319                     	xdef	_get_key1
1320                     	xdef	_get_key2
1321                     	xdef	_key_init
1322                     	xdef	_time4_handle
1323                     	xdef	_key_work
1324                     	xdef	_nr_cnt
1325                     	xdef	_yy_cnt
1326                     	xdef	_yy_nr
1327                     	xdef	_s_cnt
1328                     	xdef	_yy
1329                     	xdef	_op
1330                     	xdef	_yy_stats
1331                     	xdef	_yy_start
1332                     	xdef	_yy_init
1333                     	xref	_uart_sendmultchar
1334                     	xref	_TIM4_SetCounter
1335                     	xref	_TIM4_ITConfig
1336                     	xref	_TIM4_Cmd
1337                     	xref	_TIM4_TimeBaseInit
1338                     	xref	_TIM4_DeInit
1339                     	xref	_GPIO_ReadInputDataBit
1340                     	xref	_GPIO_ResetBits
1341                     	xref	_GPIO_SetBits
1342                     	xref	_GPIO_Init
1343                     	xref	_CLK_PeripheralClockConfig
1344                     	xref.b	c_x
1363                     	xref	c_xymvx
1364                     	end
