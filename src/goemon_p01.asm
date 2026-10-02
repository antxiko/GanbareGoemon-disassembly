; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX2 - MegaROM RC-748 de 128 KB (Konami4) - banco 01 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ======================================================================
; CODIGO 0x6000..0x628a  (650 bytes)
; ======================================================================


L_6000:
	rla			;6000
	jr nc,L_6006		;6001
	ld hl,0c25ah		;6003
L_6006:
	xor a			;6006
	ld (hl),a			;6007
	inc l			;6008
	ld (hl),a			;6009
	inc l			;600a
	ld (hl),a			;600b
	ld (0c486h),a		;600c
	ld (0c281h),a		;600f
	ld (0c265h),a		;6012
	ld (0c266h),a		;6015
	ld (0c268h),a		;6018
	ld hl,0c270h		;601b
	ld b,00bh		;601e
L_6020:
	ld (hl),a			;6020
	inc l			;6021
	djnz L_6020		;6022
	inc l			;6024
	ld (hl),a			;6025
	call 08f7bh		;6026
	ld a,010h		;6029
	ld (0c480h),a		;602b
	ld (0c481h),a		;602e
	jp 05f60h		;6031
L_6034:
	djnz L_605D		;6034
	ld a,(0c289h)		;6036
	cp 004h		;6039
	jr z,L_606B		;603b
	call 045d3h		;603d
	call 045eeh		;6040
	call 04babh		;6043
	call 04d63h		;6046
	call 051edh		;6049
	call 0534eh		;604c
	call 045e1h		;604f
	call 0960ch		;6052
	ld a,08ch		;6055
	call 04fe4h		;6057
	jp 05e43h		;605a
L_605D:
	djnz L_6073		;605d
	call 0963fh		;605f
	ld a,(0cd11h)		;6062
	ld b,a			;6065
	ld a,(0c0abh)		;6066
	or b			;6069
	ret nz			;606a
L_606B:
	call 08f7bh		;606b
	ld a,004h		;606e
	jp 05e2dh		;6070
L_6073:
	ld hl,(0c4b0h)		;6073
	ld a,h			;6076
	or l			;6077
	jp nz,L_650A		;6078
	ld hl,0c260h		;607b
	ld a,(hl)			;607e
	add a,001h		;607f
	daa			;6081
	ld (hl),a			;6082
	ld hl,0c261h		;6083
	ld a,(hl)			;6086
	add a,001h		;6087
	daa			;6089
	ld (hl),a			;608a
	ld hl,0c280h		;608b
	inc (hl)			;608e
	inc hl			;608f
	xor a			;6090
	inc hl			;6091
	ld (hl),a			;6092
	ld (0c28ah),a		;6093
	ld (0c28ch),a		;6096
	jp 05e43h		;6099
L_609C:
	ld a,(0c483h)		;609c
	and a			;609f
	jr nz,L_60CF		;60a0
	ld a,(0c283h)		;60a2
	cp 005h		;60a5
	jr z,L_60B5		;60a7
	cp 006h		;60a9
	jr z,L_60BA		;60ab
	call L_65F7		;60ad
	call L_66F6		;60b0
	jr L_60C6		;60b3
L_60B5:
	call L_672F		;60b5
	jr L_60C6		;60b8
L_60BA:
	call 04ce3h		;60ba
	call 04295h		;60bd
	call L_66F6		;60c0
	call 0416fh		;60c3
L_60C6:
	xor a			;60c6
	ld (0c283h),a		;60c7
	ld a,005h		;60ca
	jp 05e2dh		;60cc
L_60CF:
	call L_6A06		;60cf
	jr L_60C6		;60d2
L_60D4:
	ld a,(0c00eh)		;60d4
	inc a			;60d7
	cp 02eh		;60d8
	jr c,L_60DD		;60da
	xor a			;60dc
L_60DD:
	ld (0c00eh),a		;60dd
	call 049d2h		;60e0
	ld a,(0c00bh)		;60e3
	rra			;60e6
	jr c,L_60F9		;60e7
	rra			;60e9
	jp nc,0bdf6h		;60ea
	ld a,(0c28ch)		;60ed
	and a			;60f0
	jp nz,0bdf6h		;60f1
	ld a,00dh		;60f4
	jp 05e2dh		;60f6
L_60F9:
	xor a			;60f9
	ld (0c008h),a		;60fa
	call L_6374		;60fd
	ld a,0feh		;6100
	call 04fe4h		;6102
	ld a,005h		;6105
	jp 05e2dh		;6107
L_610A:
	djnz L_6120		;610a
	ld hl,0c004h		;610c
	dec (hl)			;610f
	ld a,(hl)			;6110
	push af			;6111
	ld a,(0c003h)		;6112
	and 007h		;6115
	call z,0bd57h		;6117
	pop af			;611a
	and a			;611b
	ret nz			;611c
	jp 05e43h		;611d
L_6120:
	djnz L_6145		;6120
	call 045d3h		;6122
	call 045eeh		;6125
	call 08f7bh		;6128
	call 04bc5h		;612b
	call 04d72h		;612e
	call 051edh		;6131
	call 0534eh		;6134
	call 09a46h		;6137
	call 045e1h		;613a
	ld a,08ah		;613d
	call 04fe4h		;613f
	jp 05e43h		;6142
L_6145:
	djnz L_6168		;6145
	call 09b34h		;6147
	call 0868eh		;614a
	call 086fch		;614d
	call 08861h		;6150
	call 05b61h		;6153
	ld a,(0cd11h)		;6156
	or a			;6159
	ret nz			;615a
	ld a,(0c0abh)		;615b
	and a			;615e
	ret nz			;615f
	ld a,0b4h		;6160
	ld (0c004h),a		;6162
	jp 05e43h		;6165
L_6168:
	djnz L_6192		;6168
	ld hl,0c26ah		;616a
	inc (hl)			;616d
	ld hl,0c288h		;616e
	inc (hl)			;6171
	xor a			;6172
	ld (0c280h),a		;6173
	ld (0c28bh),a		;6176
	ld (0c28ch),a		;6179
	ld a,(hl)			;617c
	cp 007h		;617d
	jr nc,L_6186		;617f
	ld a,004h		;6181
	jp 05e2dh		;6183
L_6186:
	ld hl,0c002h		;6186
	ld a,(hl)			;6189
	and 0bfh		;618a
	ld (hl),a			;618c
	ld a,00fh		;618d
	jp 05e2dh		;618f
L_6192:
	call 05b61h		;6192
	ld de,08038h		;6195
	ld hl,01e28h		;6198
	ld a,002h		;619b
	ld c,00fh		;619d
	call 0bd48h		;619f
	ld a,004h		;61a2
	call 04fe4h		;61a4
	ld a,050h		;61a7
	ld (0c004h),a		;61a9
	jp 05e43h		;61ac
L_61AF:
	push bc			;61af
	call 049d2h		;61b0
	pop bc			;61b3
	djnz L_61E9		;61b4
	ld a,(0c006h)		;61b6
	and 033h		;61b9
	ret z			;61bb
	and 003h		;61bc
	jp nz,08096h		;61be
	ld a,(0ef0bh)		;61c1
	or a			;61c4
	jp nz,L_61CF		;61c5
	ld hl,00203h		;61c8
	ld (0c000h),hl		;61cb
	ret			;61ce
L_61CF:
	dec a			;61cf
	jr z,L_61DD		;61d0
	ld hl,0b8a8h		;61d2
	ld (0ef02h),hl		;61d5
	call L_7FA3		;61d8
	jr L_61E6		;61db
L_61DD:
	ld hl,0b0a8h		;61dd
	ld (0ef02h),hl		;61e0
	call L_7F83		;61e3
L_61E6:
	jp 05e43h		;61e6
L_61E9:
	djnz L_621E		;61e9
	call 08040h		;61eb
	jr nz,L_61F3		;61ee
	jp L_7FD1		;61f0
L_61F3:
	ld a,(0ef0bh)		;61f3
	ld b,a			;61f6
	ld hl,0ef04h		;61f7
	or (hl)			;61fa
	ld (hl),a			;61fb
	ld a,(0ef15h)		;61fc
	or a			;61ff
	jr z,L_6214		;6200
	ld a,(0ef0eh)		;6202
	ld d,a			;6205
	ld a,(0ef0fh)		;6206
	bit 0,b		;6209
	jr z,L_6219		;620b
	ld (0ef05h),a		;620d
	ld a,d			;6210
	ld (0ef06h),a		;6211
L_6214:
	xor a			;6214
	ld (0c001h),a		;6215
	ret			;6218
L_6219:
	ld (0ef07h),a		;6219
	jr L_6214		;621c
L_621E:
	call L_7F1A		;621e
	xor a			;6221
	ld hl,0ef08h		;6222
	ld de,0ef09h		;6225
	ld bc,0000eh		;6228
	ld (hl),000h		;622b
	ldir		;622d
	jp 05e43h		;622f
L_6232:
	djnz L_6248		;6232
	call 049d2h		;6234
	ld a,(0c00bh)		;6237
	rra			;623a
	rra			;623b
	ret nc			;623c
	call L_6BE7		;623d
	call 04631h		;6240
	ld a,00ah		;6243
	jp 05e2dh		;6245
L_6248:
	call 04626h		;6248
	call L_6B5F		;624b
	ld a,001h		;624e
	ld (0c28ch),a		;6250
	jp 05e43h		;6253
L_6256:
	djnz L_6276		;6256
	call L_6C03		;6258
	ret nc			;625b
	ld a,(0eb82h)		;625c
	and a			;625f
	jp z,0be4eh		;6260
	ld a,040h		;6263
	ld (0c002h),a		;6265
	call 04351h		;6268
	call L_662C		;626b
	call L_6C7A		;626e
	ld a,004h		;6271
	jp 05e2dh		;6273
L_6276:
	call L_6CB8		;6276
	call 045d3h		;6279
	ld c,0ffh		;627c
	ld hl,0628ah		;627e
	ld de,06060h		;6281
	call 048fdh		;6284
	jp 05e43h		;6287

; ----------------------------------------------------------------------
; DATOS rotulo_628A: rotulo sin posicion delante (0x48FD); lo leen p01:6284 (8
;   bytes)
;   0x628a..0x6292  (8 bytes)
DATA_rotulo_628A:
	defb 030h,05dh,039h,063h,032h,049h,067h,0ffh	; 628a  0]9c2Ig.

; ======================================================================
; CODIGO 0x6292..0x636c  (218 bytes)
; ======================================================================


L_6292:
	djnz L_62CA		;6292
	di			;6294
	ld a,00ch		;6295
	ld (0a000h),a		;6297
	ld (0f0f3h),a		;629a
	ei			;629d
	ld a,(0c003h)		;629e
	and 003h		;62a1
	call z,042f1h		;62a3
	call 04206h		;62a6
	ld a,(0c0abh)		;62a9
	and a			;62ac
	ret nz			;62ad
	call 045eeh		;62ae
	call 045d3h		;62b1
	call 04cd4h		;62b4
	call L_65A2		;62b7
	call 05b61h		;62ba
	call 045e1h		;62bd
	ld a,08fh		;62c0
	call 04fe4h		;62c2
	ld a,03ch		;62c5
	jp 05e40h		;62c7
L_62CA:
	djnz L_62E5		;62ca
	ld a,(0c0abh)		;62cc
	and a			;62cf
	ret nz			;62d0
	ld hl,0c004h		;62d1
	dec (hl)			;62d4
	ret nz			;62d5
	call 045d3h		;62d6
	ld hl,0c002h		;62d9
	res 6,(hl)		;62dc
	ld hl,00000h		;62de
	ld (0c000h),hl		;62e1
	ret			;62e4
L_62E5:
	call L_653C		;62e5
	call 045d3h		;62e8
	ld de,02010h		;62eb
	ld hl,0d800h		;62ee
	call 042e1h		;62f1
	ld a,08dh		;62f4
	call 04fe4h		;62f6
	ld a,0f0h		;62f9
	jp 05e40h		;62fb
L_62FE:
	call 049eeh		;62fe
	ld hl,0c251h		;6301
	call 049e7h		;6304
	or a			;6307
	ret z			;6308
	ld hl,0c004h		;6309
	ld (hl),000h		;630c
	ld l,(hl)			;630e
	ld de,0c252h		;630f
	ld b,(hl)			;6312
	djnz L_6341		;6313
	and 030h		;6315
	jr z,L_634B		;6317
	and 020h		;6319
	jr nz,L_6355		;631b
	ld a,(de)			;631d
	or a			;631e
	ld a,040h		;631f
	jr z,L_6325		;6321
	ld a,060h		;6323
L_6325:
	ld (0c002h),a		;6325
	push hl			;6328
	ld hl,0c257h		;6329
	ld de,0c258h		;632c
	ld bc,00005h		;632f
	ld (hl),000h		;6332
	ldir		;6334
	pop hl			;6336
	ld (hl),003h		;6337
	inc hl			;6339
	ld c,000h		;633a
	ld (hl),c			;633c
	dec c			;633d
	jp 04462h		;633e
L_6341:
	ld (hl),001h		;6341
	ld a,000h		;6343
	call 04fe4h		;6345
	jp 05a93h		;6348
L_634B:
	ld a,(de)			;634b
	xor 001h		;634c
	ld (de),a			;634e
	ld hl,0ef81h		;634f
	ld a,(hl)			;6352
	inc (hl)			;6353
	ret			;6354
L_6355:
	ld a,00eh		;6355
	jp 05e2dh		;6357
L_635A:
	ld hl,06a54h		;635a
	ld bc,02c10h		;635d
	ld de,0d070h		;6360
	call L_6382		;6363
	ld hl,0636ch		;6366
	jp 048f3h		;6369

; ----------------------------------------------------------------------
; DATOS rotulo_636C: rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p01:6369 (8 bytes)
;   0x636c..0x6374  (8 bytes)
DATA_rotulo_636C:
	defb 06eh,058h,031h,05eh,04bh,062h,037h,0ffh	; 636c  nX1^Kb7.

; ======================================================================
; CODIGO 0x6374..0x639b  (39 bytes)
; ======================================================================


L_6374:
	ld de,06a54h		;6374
	ld bc,02c10h		;6377
	ld hl,0d070h		;637a
	ld a,001h		;637d
	jp 0476eh		;637f
L_6382:
	ld a,004h		;6382
	push hl			;6384
	push bc			;6385
	call 0476eh		;6386
	pop bc			;6389
	pop hl			;638a
	push hl			;638b
	push bc			;638c
	xor a			;638d
	ld d,a			;638e
	call 04732h		;638f
	pop bc			;6392
	pop hl			;6393
	ld d,b			;6394
	ld e,c			;6395
	ld c,00eh		;6396
	jp 04704h		;6398

; ----------------------------------------------------------------------
; DATOS rotulo_639B: rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); se solapan 2 bloques (0x639B-0x63D8, 0x63CB-0x63D8); lo
;   leen p00:5B06, p00:5E5E (61 bytes)
;   0x639b..0x63d8  (61 bytes)
DATA_rotulo_639B:
	defb 050h,010h,069h,02ah,02bh,02ch,02dh,02eh,02fh,000h,021h,029h,028h,027h,0feh,048h	; 639b  P.i*+,-./.!)('.H
	defb 098h,043h,063h,05eh,040h,042h,063h,000h,030h,03eh,04ah,063h,04eh,05eh,035h,067h	; 63ab  .Cc^@Bc.0>JcN^5g
	defb 0feh,058h,0a8h,04ah,043h,057h,042h,063h,000h,035h,063h,05dh,049h,063h,058h,0feh	; 63bb  .X.JCWBc.5c]IcX.
	defb 058h,0b0h,04bh,03fh,057h,042h,063h,000h,03fh,048h,03bh,050h,0ffh	; 63cb  X.K?WBc.?H;P.

; ----------------------------------------------------------------------
; DATOS rotulo_63D8: rotulo sin posicion delante (0x48FD); lo leen p00:4479 (3
;   bytes)
;   0x63d8..0x63db  (3 bytes)
DATA_rotulo_63D8:
	defb 0bch,0bdh,0ffh	; 63d8

; ----------------------------------------------------------------------
; DATOS rotulo_63DB: rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:5FD2 (8 bytes)
;   0x63db..0x63e3  (8 bytes)
DATA_rotulo_63DB:
	defb 070h,050h,07eh,07fh,080h,081h,082h,0ffh	; 63db  pP~.....

; ----------------------------------------------------------------------
; DATOS rotulo_63E3: rotulo en el otro color (0x48F7); lo leen p00:5F9B,
;   p00:5FDE (13 bytes)
;   0x63e3..0x63f0  (13 bytes)
DATA_rotulo_63E3:
	defb 060h,060h,078h,025h,000h,042h,063h,000h,041h,041h,063h,036h,0ffh	; 63e3  ``x%.Bc.AAc6.

; ----------------------------------------------------------------------
; DATOS rotulo_63F0: rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:43F4 (31 bytes)
;   0x63f0..0x640f  (31 bytes)
DATA_rotulo_63F0:
	defb 048h,000h,06fh,070h,071h,072h,0feh,070h,000h,06bh,06ch,06dh,06eh,0feh,090h,008h	; 63f0  H.opqr.p.klmn...
	defb 06ah,0feh,0a0h,000h,073h,074h,075h,076h,077h,0feh,0e8h,000h,0afh,0b0h,0ffh	; 6400  j...stuvw......

; ----------------------------------------------------------------------
; DATOS rotulo_640F: un rotulo con el formato de 0x48F3 en (0x54, 0x60): los
;   caracteres 0x83-0x87 (los mismos que el de 0x642D, el del jugador 1), un 0
;   y 0x79-0x7D; no lo escribe nadie (14 bytes)
;   0x640f..0x641d  (14 bytes)
DATA_rotulo_640F:
	defb 054h,060h,083h,084h,085h,086h,087h,000h,079h,07ah,07bh,07ch,07dh,0ffh	; 640f  T`......yz{|}.

; ----------------------------------------------------------------------
; DATOS rotulo_641D: lo mismo para el jugador 2 en (0x4C, 0x60), con 0x88-0x8E
;   (los del rotulo de 0x6435); no lo escribe nadie (16 bytes)
;   0x641d..0x642d  (16 bytes)
DATA_rotulo_641D:
	defb 04ch,060h,088h,089h,08ah,08bh,08ch,08dh,08eh,000h,079h,07ah,07bh,07ch,07dh,0ffh	; 641d  L`........yz{|}.

; ----------------------------------------------------------------------
; DATOS rotulo_642D: el rotulo del jugador 1 en (0x10, 0x00) que p00:43E5
;   escribe con 0x48F3 (el del 2 es 0x6435) (8 bytes)
;   0x642d..0x6435  (8 bytes)
DATA_rotulo_642D:
	defb 010h,000h,083h,084h,085h,086h,087h,0ffh	; 642d  ........

; ----------------------------------------------------------------------
; DATOS rotulo_6435: rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:43EE (10 bytes)
;   0x6435..0x643f  (10 bytes)
DATA_rotulo_6435:
	defb 008h,000h,088h,089h,08ah,08bh,08ch,08dh,08eh,0ffh	; 6435  ..........

; ======================================================================
; CODIGO 0x643f..0x6476  (55 bytes)
; ======================================================================


L_643F:
	call 045eeh		;643f
	ld hl,06476h		;6442
	call 04666h		;6445
	ld b,00fh		;6448
	ld c,007h		;644a
	call 00047h		;644c   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,02840h		;644f
	ld bc,0a848h		;6452
	xor a			;6455
	ld d,001h		;6456
	call 04732h		;6458
	call 04a43h		;645b
	ld de,04040h		;645e
	ld hl,064c9h		;6461
	call L_64A9		;6464
	call 045e1h		;6467
	ld hl,0c480h		;646a
	ld (hl),03ch		;646d
	inc hl			;646f
	ld (hl),031h		;6470
	inc hl			;6472
	ld (hl),000h		;6473
	ret			;6475

; ----------------------------------------------------------------------
; DATOS paleta_6476: colores de la paleta, [color][RB][G], 0xFF acaba
;   (0x4666); lo leen p01:6445 (16 bytes)
;   0x6476..0x6486  (16 bytes)
DATA_paleta_6476:
	defb 000h,000h,000h,001h,070h,003h,002h,060h,001h,003h,044h,004h,00fh,077h,007h,0ffh	; 6476  ....p..`..D..w..

; ======================================================================
; CODIGO 0x6486..0x64c9  (67 bytes)
; ======================================================================


L_6486:
	ld hl,0c480h		;6486
	dec (hl)			;6489
	ld a,(hl)			;648a
	and 001h		;648b
	ret nz			;648d
	inc hl			;648e
	dec (hl)			;648f
	jr nz,L_6498		;6490
	ld a,001h		;6492
	ld (0c482h),a		;6494
	ret			;6497
L_6498:
	ld a,031h		;6498
	sub (hl)			;649a
	ld c,a			;649b
	ld b,0a8h		;649c
	ld hl,02840h		;649e
	ld de,02840h		;64a1
	ld a,001h		;64a4
	jp 0476eh		;64a6
L_64A9:
	push de			;64a9
L_64AA:
	ld a,(hl)			;64aa
	inc hl			;64ab
	ld c,a			;64ac
	inc a			;64ad
	jr z,L_64C7		;64ae
	inc a			;64b0
	jr nz,L_64BE		;64b1
	pop de			;64b3
	ld a,(hl)			;64b4
	inc hl			;64b5
	add a,d			;64b6
	ld d,a			;64b7
	ld a,008h		;64b8
	add a,e			;64ba
	ld e,a			;64bb
	jr L_64A9		;64bc
L_64BE:
	ld a,c			;64be
	call 04964h		;64bf
	call 04984h		;64c2
	jr L_64AA		;64c5
L_64C7:
	pop de			;64c7
	ret			;64c8

; ----------------------------------------------------------------------
; DATOS cartel_64C9: los caracteres que p01:64A9 pinta desde (0x40, 0x40) con
;   p00:4964: 0xFE [dx] baja una fila y corre dx, 0xFF acaba (65 bytes)
;   0x64c9..0x650a  (65 bytes)
DATA_cartel_64C9:
	defb 001h,002h,003h,0feh,0f8h,004h,005h,006h,007h,0feh,0f0h,008h,009h,00ah,00bh,00eh	; 64c9  ................
	defb 00fh,010h,011h,01bh,01ch,01dh,01eh,01fh,020h,021h,022h,023h,024h,025h,026h,0feh	; 64d9  ........ !"#$%&.
	defb 000h,00ch,002h,00dh,012h,013h,014h,015h,027h,028h,029h,02ah,02bh,02ch,02dh,02eh	; 64e9  ........'()*+,-.
	defb 02fh,030h,031h,032h,033h,034h,0feh,010h,016h,019h,017h,0feh,0f8h,018h,019h,01ah	; 64f9  /01234..........
	defb 0ffh	; 6509

; ======================================================================
; CODIGO 0x650a..0x6589  (127 bytes)
; ======================================================================


L_650A:
	ld hl,0c4b1h		;650a
	ld a,(hl)			;650d
	and a			;650e
	jr z,L_651E		;650f
	ld a,(0c003h)		;6511
	and 00fh		;6514
	ret nz			;6516
	ld de,01000h		;6517
	ld b,01dh		;651a
	jr L_652A		;651c
L_651E:
	ld a,(0c003h)		;651e
	and 001h		;6521
	ret nz			;6523
	dec hl			;6524
	ld de,00010h		;6525
	ld b,01ch		;6528
L_652A:
	ld a,(hl)			;652a
	dec a			;652b
	daa			;652c
	ld (hl),a			;652d
	push bc			;652e
	push de			;652f
	call 058f5h		;6530
	pop de			;6533
	call 0437eh		;6534
	pop bc			;6537
	ld a,b			;6538
	jp 04fe4h		;6539
L_653C:
	di			;653c
	ld a,00ch		;653d
	ld (0a000h),a		;653f
	ld (0f0f3h),a		;6542
	ei			;6545
	ld a,(0ef00h)		;6546
	and a			;6549
	ld b,000h		;654a
	jr z,L_6550		;654c
	ld b,002h		;654e
L_6550:
	ld a,(0c26ah)		;6550
	cp 007h		;6553
	ld a,000h		;6555
	jr nz,L_655A		;6557
	inc a			;6559
L_655A:
	or b			;655a
	add a,a			;655b
	ld hl,06589h		;655c
	call 04d81h		;655f
	ld b,(hl)			;6562
	ld de,0d800h		;6563
	inc hl			;6566
L_6567:
	ld a,(hl)			;6567
	add a,a			;6568
	push bc			;6569
	push hl			;656a
	ld hl,0bcd3h		;656b
	call 04d81h		;656e
	ld b,000h		;6571
	ld c,(hl)			;6573
	inc hl			;6574
	ldir		;6575
	pop hl			;6577
	pop bc			;6578
	ld a,0feh		;6579
	ld (de),a			;657b
	inc de			;657c
	ld (de),a			;657d
	inc de			;657e
	inc hl			;657f
	djnz L_6567		;6580
	ld a,0ffh		;6582
	dec de			;6584
	ld (de),a			;6585
	jp 04206h		;6586

; ----------------------------------------------------------------------
; DATOS frases: 4 punteros (0xC26A = 7 y el bit de B, p01:655A) a las frases
;   de p01:6567; lo leen p01:655C (8 bytes)
;   0x6589..0x6591  (8 bytes)
DATA_frases:
	defb 091h,065h,094h,065h,099h,065h,09dh,065h	; 6589  .e.e.e.e

; ----------------------------------------------------------------------
; DATOS frase_6591: [n] y n numeros de trozo de texto (0xBCD3) que p01:6567
;   junta; lo leen p01:6562 (3 bytes)
;   0x6591..0x6594  (3 bytes)
DATA_frase_6591:
	defb 002h,001h,003h	; 6591

; ----------------------------------------------------------------------
; DATOS frase_6594: [n] y n numeros de trozo de texto (0xBCD3) que p01:6567
;   junta; lo leen p01:6562 (5 bytes)
;   0x6594..0x6599  (5 bytes)
DATA_frase_6594:
	defb 004h,000h,002h,004h,005h	; 6594

; ----------------------------------------------------------------------
; DATOS frase_6599: [n] y n numeros de trozo de texto (0xBCD3) que p01:6567
;   junta; lo leen p01:6562 (4 bytes)
;   0x6599..0x659d  (4 bytes)
DATA_frase_6599:
	defb 003h,001h,003h,006h	; 6599

; ----------------------------------------------------------------------
; DATOS frase_659D: [n] y n numeros de trozo de texto (0xBCD3) que p01:6567
;   junta; lo leen p01:6562 (5 bytes)
;   0x659d..0x65a2  (5 bytes)
DATA_frase_659D:
	defb 004h,000h,002h,004h,006h	; 659d

; ======================================================================
; CODIGO 0x65a2..0x65c7  (37 bytes)
; ======================================================================


L_65A2:
	ld hl,065c7h		;65a2
	ld de,0ee00h		;65a5
	ld b,010h		;65a8
L_65AA:
	ld a,(hl)			;65aa
	ld (de),a			;65ab
	inc hl			;65ac
	inc de			;65ad
	ld a,(hl)			;65ae
	ld (de),a			;65af
	inc hl			;65b0
	inc de			;65b1
	ld a,(hl)			;65b2
	ld (de),a			;65b3
	inc hl			;65b4
	inc de			;65b5
	inc de			;65b6
	djnz L_65AA		;65b7
	ld hl,0ec00h		;65b9
	ld de,0ec01h		;65bc
	ld bc,000ffh		;65bf
	ld (hl),003h		;65c2
	ldir		;65c4
	ret			;65c6

; ----------------------------------------------------------------------
; DATOS sprites_65C7: 16 sprites [y][x][dibujo] que p01:65AA copia a 0xEE00
;   (el color, 3, lo pone p01:65C2 en 0xEC00) (48 bytes)
;   0x65c7..0x65f7  (48 bytes)
DATA_sprites_65C7:
	defb 040h,060h,000h	; 65c7
	defb 040h,070h,004h	; 65ca
	defb 040h,080h,008h	; 65cd
	defb 040h,090h,00ch	; 65d0
	defb 050h,060h,010h	; 65d3
	defb 050h,070h,014h	; 65d6
	defb 050h,080h,018h	; 65d9
	defb 050h,090h,01ch	; 65dc
	defb 060h,060h,020h	; 65df
	defb 060h,070h,024h	; 65e2
	defb 060h,080h,028h	; 65e5
	defb 060h,090h,02ch	; 65e8
	defb 070h,060h,030h	; 65eb
	defb 070h,070h,034h	; 65ee
	defb 070h,080h,038h	; 65f1
	defb 070h,090h,03ch	; 65f4

; ======================================================================
; CODIGO 0x65f7..0x68e9  (754 bytes)
; ======================================================================


L_65F7:
	ld de,0e780h		;65f7
	ld a,(0c281h)		;65fa
	add a,a			;65fd
	ld h,000h		;65fe
	ld l,a			;6600
	add hl,hl			;6601
	add hl,de			;6602
	ld de,0c283h		;6603
	ld a,(de)			;6606
	ld b,a			;6607
	xor a			;6608
	ld (de),a			;6609
	dec b			;660a
	ld a,b			;660b
	call 04083h		;660c
	ld a,(hl)			;660f
	cp 0ffh		;6610
	ret z			;6612
	ld (0c281h),a		;6613
	ret			;6616
L_6617:
	ld de,0e780h		;6617
	ld a,(0c281h)		;661a
	add a,a			;661d
	ld h,000h		;661e
	ld l,a			;6620
	add hl,hl			;6621
	add hl,de			;6622
	ld de,0c284h		;6623
	ld bc,00004h		;6626
	ldir		;6629
	ret			;662b
L_662C:
	call 04a6dh		;662c
	call 04da4h		;662f
	ld de,01010h		;6632
	ld (0c480h),de		;6635
	ret			;6639
L_663A:
	di			;663a
	ld a,009h		;663b
	ld (0a000h),a		;663d
	ld (0f0f3h),a		;6640
	ei			;6643
	call 041f6h		;6644
	srl a		;6647
	ld hl,0b8ech		;6649
	call 04083h		;664c
	ld a,(hl)			;664f
	ld (0c289h),a		;6650
	call 04206h		;6653
	call 04da4h		;6656
	call 04a96h		;6659
	ld hl,0d000h		;665c
	ld de,0d001h		;665f
	ld bc,017ffh		;6662
	ld (hl),000h		;6665
	ldir		;6667
	call 04d89h		;6669
	call 04295h		;666c
	call 042ach		;666f
	di			;6672
	ld a,009h		;6673
	ld (0a000h),a		;6675
	ld (0f0f3h),a		;6678
	ei			;667b
	call L_6AFC		;667c
	call 04206h		;667f
	call L_67DA		;6682
	call L_67CC		;6685
	call L_67B3		;6688
	ld hl,0c268h		;668b
	ld a,(hl)			;668e
	and a			;668f
	jr nz,L_66BC		;6690
	inc (hl)			;6692
	di			;6693
	ld a,009h		;6694
	ld (0a000h),a		;6696
	ld (0f0f3h),a		;6699
	ei			;669c
	call 041f6h		;669d
	srl a		;66a0
	ld hl,0b8afh		;66a2
	call 04083h		;66a5
	ld a,(hl)			;66a8
	exx			;66a9
	ld hl,0c002h		;66aa
	bit 6,(hl)		;66ad
	exx			;66af
	jr z,L_66B9		;66b0
	ld (0c281h),a		;66b2
	xor a			;66b5
	ld (0c267h),a		;66b6
L_66B9:
	call 04206h		;66b9
L_66BC:
	call L_77AA		;66bc
	ld a,(0c480h)		;66bf
	ld (0c481h),a		;66c2
	ld de,00700h		;66c5
	ld (0c4b0h),de		;66c8
	ld a,001h		;66cc
	ld (0c4b2h),a		;66ce
	ld a,(0c280h)		;66d1
	cp 006h		;66d4
	jr nz,L_66E6		;66d6
	ld de,03080h		;66d8
	ld hl,00080h		;66db
	ld bc,01010h		;66de
	ld a,005h		;66e1
	call 0476eh		;66e3
L_66E6:
	xor a			;66e6
	ld (0c0afh),a		;66e7
	call 05311h		;66ea
	call 04188h		;66ed
	call 0955ch		;66f0
	call L_7E42		;66f3
L_66F6:
	call L_6617		;66f6
	call L_7D9E		;66f9
	call L_67DA		;66fc
	call L_67B3		;66ff
	call L_67F4		;6702
	call L_67E8		;6705
	call 045eeh		;6708
	call 0460ah		;670b
	call 051edh		;670e
	call 0534eh		;6711
	call 090c0h		;6714
	call L_6756		;6717
	call 05413h		;671a
	call 05856h		;671d
	call 04ce3h		;6720
	call 04d14h		;6723
	call 08656h		;6726
	call 08573h		;6729
	jp 045e1h		;672c
L_672F:
	call L_67DA		;672f
	call L_67B3		;6732
	call L_67F4		;6735
	call L_67E8		;6738
	call 045eeh		;673b
	call 0460ah		;673e
	call 051edh		;6741
	call 0534eh		;6744
	call L_6798		;6747
	call 04d08h		;674a
	call 0925dh		;674d
	call 045e1h		;6750
	jp 094f7h		;6753
L_6756:
	ld a,(0c268h)		;6756
	and a			;6759
	ret z			;675a
	di			;675b
	ld a,009h		;675c
	ld (0a000h),a		;675e
	ld (0f0f3h),a		;6761
	ei			;6764
	ld a,003h		;6765
	ld (0c4a2h),a		;6767
	ld b,006h		;676a
L_676C:
	ld hl,0b8e0h		;676c
	ld a,b			;676f
	dec a			;6770
	add a,a			;6771
	call 04083h		;6772
	ld e,(hl)			;6775
	inc hl			;6776
	ld d,(hl)			;6777
	push bc			;6778
	push de			;6779
	call L_781F		;677a
	pop de			;677d
	pop bc			;677e
	jr nc,L_6783		;677f
	djnz L_676C		;6781
L_6783:
	ld a,e			;6783
	ld (0c498h),a		;6784
	ld (0c494h),a		;6787
	ld a,d			;678a
	ld (0c49ah),a		;678b
	ld (0c496h),a		;678e
	xor a			;6791
	ld (0c268h),a		;6792
	jp 04206h		;6795
L_6798:
	ld a,(0c283h)		;6798
	cp 006h		;679b
	jr z,L_67B0		;679d
	ld a,0b0h		;679f
	ld (0c498h),a		;67a1
	ld (0c494h),a		;67a4
	ld a,080h		;67a7
	ld (0c49ah),a		;67a9
	ld (0c496h),a		;67ac
	ret			;67af
L_67B0:
	jp 0416fh		;67b0
L_67B3:
	ld hl,0c600h		;67b3
	ld de,00080h		;67b6
	ld b,008h		;67b9
	call L_67C6		;67bb
	ld hl,0ca00h		;67be
	ld b,008h		;67c1
	ld de,00040h		;67c3
L_67C6:
	ld (hl),000h		;67c6
	add hl,de			;67c8
	djnz L_67C6		;67c9
	ret			;67cb
L_67CC:
	ld hl,0c490h		;67cc
	ld d,h			;67cf
	ld e,l			;67d0
	inc de			;67d1
	ld (hl),000h		;67d2
	ld bc,0005fh		;67d4
	ldir		;67d7
	ret			;67d9
L_67DA:
	ld hl,0ee00h		;67da
	ld b,020h		;67dd
L_67DF:
	ld (hl),0e0h		;67df
	inc l			;67e1
	inc l			;67e2
	inc l			;67e3
	inc l			;67e4
	djnz L_67DF		;67e5
	ret			;67e7
L_67E8:
	ld hl,0c4d3h		;67e8
	call L_76AC		;67eb
	ld hl,0c4e3h		;67ee
	jp L_76AC		;67f1
L_67F4:
	ld hl,0cc00h		;67f4
	ld de,0cc01h		;67f7
	ld (hl),000h		;67fa
	ld bc,000ffh		;67fc
	ldir		;67ff
	ret			;6801
L_6802:
	call 05b09h		;6802
	ld a,(0cdb1h)		;6805
	or a			;6808
	jr z,L_6815		;6809
	call 049d2h		;680b
	call L_6877		;680e
	ret c			;6811
	jp 0987ah		;6812
L_6815:
	ld a,(0c003h)		;6815
	rra			;6818
	jr c,L_685F		;6819
	ld hl,0c00dh		;681b
	inc (hl)			;681e
	call 049d2h		;681f
	ld a,(0c490h)		;6822
	cp 003h		;6825
	jr z,L_682D		;6827
	call L_6877		;6829
	ret c			;682c
L_682D:
	call 04cabh		;682d
	call L_6D38		;6830
	call L_71BB		;6833
	ld a,(0cdb1h)		;6836
	or a			;6839
	ret nz			;683a
	ld a,(0c283h)		;683b
	and a			;683e
	ret nz			;683f
	call L_75E4		;6840
	call L_7370		;6843
	di			;6846
	ld a,009h		;6847
	ld (0a000h),a		;6849
	ld (0f0f3h),a		;684c
	ei			;684f
	call L_74A6		;6850
	call 04206h		;6853
	call L_76D1		;6856
	call 08cb0h		;6859
	jp 0868eh		;685c
L_685F:
	call 086fch		;685f
	call 08861h		;6862
	call 088b0h		;6865
	call 086f1h		;6868
	call 08857h		;686b
	call L_7833		;686e
	call 058c5h		;6871
	jp 05b1dh		;6874
L_6877:
	ld a,(0c00bh)		;6877
	rra			;687a
	ret nc			;687b
	ld a,001h		;687c
	ld (0c008h),a		;687e
	call 04cabh		;6881
	ld a,0fdh		;6884
	call 04fe4h		;6886
	scf			;6889
	ret			;688a
L_688B:
	ld hl,0c002h		;688b
	ld a,(hl)			;688e
	ld b,a			;688f
	ld a,(0cd2fh)		;6890
	or a			;6893
	jr nz,L_689E		;6894
	inc a			;6896
	ld (0cd2fh),a		;6897
	ld a,b			;689a
	or 080h		;689b
	ld b,a			;689d
L_689E:
	ld a,b			;689e
	xor 080h		;689f
	ld (hl),a			;68a1
	ld a,(0cd2fh)		;68a2
	ex af,af'			;68a5
	call 04351h		;68a6
	ex af,af'			;68a9
	ld (0cd2fh),a		;68aa
	call L_662C		;68ad
	xor a			;68b0
	ld (0c280h),a		;68b1
	ld (0c288h),a		;68b4
	ld (0c009h),a		;68b7
	ld (0c007h),a		;68ba
	inc a			;68bd
	ld (0c263h),a		;68be
	ld (0c00ah),a		;68c1
	ld (0c267h),a		;68c4
	ld a,00ch		;68c7
	ld (0c281h),a		;68c9
	call L_663A		;68cc
	ld a,099h		;68cf
	ld (0c260h),a		;68d1
	ld de,00999h		;68d4
	ld (0c265h),de		;68d7
	ld hl,068e9h		;68db
	ld de,0c270h		;68de
	ld bc,0000ah		;68e1
	ldir		;68e4
	jp 043e2h		;68e6

; ----------------------------------------------------------------------
; DATOS cosas_de_la_demo: las diez cosas con las que empieza la demo, que
;   p01:68DB copia a 0xC270-0xC279 (la demo empieza ademas con 99 vidas y 999
;   de dinero, p01:68CF-68D7) (10 bytes)
;   0x68e9..0x68f3  (10 bytes)
DATA_cosas_de_la_demo:
	defb 002h,000h,005h,005h,003h,005h,005h,001h,000h,002h	; 68e9  ..........

; ======================================================================
; CODIGO 0x68f3..0x6955  (98 bytes)
; ======================================================================


L_68F3:
	call L_6802		;68f3
	ld a,(0c283h)		;68f6
	and a			;68f9
	ret z			;68fa
	cp 005h		;68fb
	jr z,L_6919		;68fd
	cp 006h		;68ff
	jr z,L_691E		;6901
	ld a,(0c483h)		;6903
	and a			;6906
	jr nz,L_6914		;6907
	call L_65F7		;6909
L_690C:
	call L_66F6		;690c
L_690F:
	xor a			;690f
	ld (0c283h),a		;6910
	ret			;6913
L_6914:
	call L_6A06		;6914
	jr L_690F		;6917
L_6919:
	call L_672F		;6919
	jr L_690F		;691c
L_691E:
	call 04ce3h		;691e
	jr L_690C		;6921
L_6923:
	ld a,(0c003h)		;6923
	rra			;6926
	ret c			;6927
	ld hl,0c00ah		;6928
	dec (hl)			;692b
	jr z,L_693F		;692c
L_692E:
	ld a,(0cd54h)		;692e
	cp 0ffh		;6931
	jr z,L_6938		;6933
	jp 049e4h		;6935
L_6938:
	xor a			;6938
	ld (0c263h),a		;6939
	jp 04d48h		;693c
L_693F:
	dec hl			;693f
	ld c,(hl)			;6940
	inc (hl)			;6941
	ld de,06955h		;6942
	ld l,c			;6945
	ld h,000h		;6946
	add hl,hl			;6948
	add hl,de			;6949
	ld a,(hl)			;694a
	ld (0c00ah),a		;694b
	inc hl			;694e
	ld a,(hl)			;694f
	ld (0cd54h),a		;6950
	jr L_692E		;6953

; ----------------------------------------------------------------------
; DATOS guion_de_la_demo: 62 parejas [mando][cuadros]: p01:693F deja el mando
;   en 0xC00A y cuantos cuadros dura en 0xCD54; es lo que juega la demo (124
;   bytes)
;   0x6955..0x69d1  (124 bytes)
DATA_guion_de_la_demo:
	defb 016h,000h	; 6955
	defb 016h,008h	; 6957
	defb 002h,018h	; 6959
	defb 004h,001h	; 695b
	defb 010h,008h	; 695d
	defb 002h,018h	; 695f
	defb 026h,008h	; 6961
	defb 002h,018h	; 6963
	defb 016h,002h	; 6965
	defb 016h,008h	; 6967
	defb 016h,028h	; 6969
	defb 002h,008h	; 696b
	defb 002h,018h	; 696d
	defb 024h,004h	; 696f
	defb 016h,000h	; 6971
	defb 028h,008h	; 6973
	defb 010h,002h	; 6975
	defb 032h,022h	; 6977
	defb 010h,002h	; 6979
	defb 038h,008h	; 697b
	defb 016h,000h	; 697d
	defb 044h,004h	; 697f
	defb 032h,024h	; 6981
	defb 007h,008h	; 6983
	defb 044h,001h	; 6985
	defb 032h,000h	; 6987
	defb 01ch,008h	; 6989
	defb 048h,028h	; 698b
	defb 002h,018h	; 698d
	defb 016h,008h	; 698f
	defb 016h,020h	; 6991
	defb 008h,004h	; 6993
	defb 010h,002h	; 6995
	defb 016h,020h	; 6997
	defb 010h,004h	; 6999
	defb 020h,001h	; 699b
	defb 032h,000h	; 699d
	defb 010h,002h	; 699f
	defb 00ch,008h	; 69a1
	defb 016h,028h	; 69a3
	defb 010h,008h	; 69a5
	defb 002h,018h	; 69a7
	defb 016h,001h	; 69a9
	defb 002h,010h	; 69ab
	defb 010h,000h	; 69ad
	defb 002h,020h	; 69af
	defb 016h,000h	; 69b1
	defb 016h,002h	; 69b3
	defb 040h,008h	; 69b5
	defb 016h,002h	; 69b7
	defb 016h,020h	; 69b9
	defb 016h,008h	; 69bb
	defb 032h,000h	; 69bd
	defb 002h,018h	; 69bf
	defb 016h,008h	; 69c1
	defb 008h,002h	; 69c3
	defb 038h,008h	; 69c5
	defb 016h,001h	; 69c7
	defb 024h,008h	; 69c9
	defb 002h,018h	; 69cb
	defb 032h,000h	; 69cd
	defb 001h,0ffh	; 69cf

; ======================================================================
; CODIGO 0x69d1..0x6af4  (291 bytes)
; ======================================================================


L_69D1:
	di			;69d1
	ld a,009h		;69d2
	ld (0a000h),a		;69d4
	ld (0f0f3h),a		;69d7
	ei			;69da
	call L_6A59		;69db
	call 04206h		;69de
	ld a,001h		;69e1
	ld (0c4afh),a		;69e3
	ld a,(0c483h)		;69e6
	and a			;69e9
	jr z,L_69FD		;69ea
	call L_67DA		;69ec
	call L_6A14		;69ef
	ld a,(0c002h)		;69f2
	and 040h		;69f5
	ret z			;69f7
	ld a,088h		;69f8
	jp 04fe4h		;69fa
L_69FD:
	call L_66F6		;69fd
	call L_6A9C		;6a00
	jp 0416fh		;6a03
L_6A06:
	ld hl,0c484h		;6a06
	ld a,(0c283h)		;6a09
	cp 004h		;6a0c
	jr nz,L_6A13		;6a0e
	inc (hl)			;6a10
	jr L_6A14		;6a11
L_6A13:
	dec (hl)			;6a13
L_6A14:
	call 045eeh		;6a14
	call 0460ah		;6a17
	call L_67E8		;6a1a
	xor a			;6a1d
	ld (0c267h),a		;6a1e
	ld hl,0c500h		;6a21
	ld de,0c501h		;6a24
	ld (hl),a			;6a27
	ld bc,0002fh		;6a28
	ldir		;6a2b
	call 04d2ch		;6a2d
	ld hl,0d800h		;6a30
	ld de,0d801h		;6a33
	ld (hl),001h		;6a36
	ld bc,002ffh		;6a38
	ldir		;6a3b
	call 0534eh		;6a3d
	ld a,(0c484h)		;6a40
	ld hl,0ea00h		;6a43
	call 04083h		;6a46
	ld a,(hl)			;6a49
	call 04f47h		;6a4a
	call L_67F4		;6a4d
	call 090c0h		;6a50
	call L_6A9C		;6a53
	jp 045e1h		;6a56
L_6A59:
	ld a,(0c483h)		;6a59
	and a			;6a5c
	ld hl,0ea80h		;6a5d
	jr nz,L_6A65		;6a60
	ld hl,0eb00h		;6a62
L_6A65:
	ld b,(hl)			;6a65
	ld a,(0c483h)		;6a66
	and a			;6a69
	ld a,(0c281h)		;6a6a
	jr nz,L_6A72		;6a6d
	ld a,(0c484h)		;6a6f
L_6A72:
	ld c,a			;6a72
	inc hl			;6a73
L_6A74:
	ld a,(hl)			;6a74
	cp c			;6a75
	jr nz,L_6A90		;6a76
	inc hl			;6a78
	ld a,(0c483h)		;6a79
	and a			;6a7c
	push af			;6a7d
	ld a,(hl)			;6a7e
	ld de,0c281h		;6a7f
	jr z,L_6A87		;6a82
	ld de,0c484h		;6a84
L_6A87:
	ld (de),a			;6a87
	pop af			;6a88
	ret nz			;6a89
	inc hl			;6a8a
	ld a,(hl)			;6a8b
	ld (0c267h),a		;6a8c
	ret			;6a8f
L_6A90:
	ld a,(0c483h)		;6a90
	and a			;6a93
	jr nz,L_6A97		;6a94
	inc hl			;6a96
L_6A97:
	inc hl			;6a97
	inc hl			;6a98
	djnz L_6A74		;6a99
	ret			;6a9b
L_6A9C:
	ld hl,0c4afh		;6a9c
	ld a,(hl)			;6a9f
	and a			;6aa0
	ret z			;6aa1
	ld (hl),000h		;6aa2
	ld a,(0c483h)		;6aa4
	and a			;6aa7
	ld c,006h		;6aa8
	jr z,L_6AAD		;6aaa
	inc c			;6aac
L_6AAD:
	ld b,004h		;6aad
	ld hl,0cc00h		;6aaf
L_6AB2:
	ld a,(hl)			;6ab2
	cp c			;6ab3
	jr z,L_6ABD		;6ab4
	ld de,00040h		;6ab6
	add hl,de			;6ab9
	djnz L_6AB2		;6aba
	ret			;6abc
L_6ABD:
	inc hl			;6abd
	inc hl			;6abe
	inc hl			;6abf
	ld a,(hl)			;6ac0
	inc hl			;6ac1
	inc hl			;6ac2
	ld h,(hl)			;6ac3
	ld l,a			;6ac4
	exx			;6ac5
	ld b,004h		;6ac6
	ld hl,06af4h		;6ac8
L_6ACB:
	ld a,(hl)			;6acb
	exx			;6acc
	add a,l			;6acd
	ld e,a			;6ace
	exx			;6acf
	inc hl			;6ad0
	ld a,(hl)			;6ad1
	exx			;6ad2
	add a,h			;6ad3
	ld d,a			;6ad4
	push hl			;6ad5
	call L_781F		;6ad6
	pop hl			;6ad9
	jr nc,L_6AE0		;6ada
	exx			;6adc
	inc hl			;6add
	djnz L_6ACB		;6ade
L_6AE0:
	ld a,e			;6ae0
	ld (0c498h),a		;6ae1
	ld (0c494h),a		;6ae4
	ld a,d			;6ae7
	ld (0c49ah),a		;6ae8
	ld (0c496h),a		;6aeb
	ld a,003h		;6aee
	ld (0c4a2h),a		;6af0
	ret			;6af3

; ----------------------------------------------------------------------
; DATOS cuatro_puntos: cuatro parejas [dx][dy] con signo que p01:6ACB suma a
;   una posicion para mirar cuatro puntos con p01:781F (8 bytes)
;   0x6af4..0x6afc  (8 bytes)
DATA_cuatro_puntos:
	defb 0ech,000h	; 6af4
	defb 004h,000h	; 6af6
	defb 0f8h,0f4h	; 6af8
	defb 0f8h,00ch	; 6afa

; ======================================================================
; CODIGO 0x6afc..0x6ccc  (464 bytes)
; ======================================================================


L_6AFC:
	call 041f6h		;6afc
	ld hl,0af08h		;6aff
	call 04d81h		;6b02
	ld de,0ea00h		;6b05
	ld b,00fh		;6b08
L_6B0A:
	ld a,(hl)			;6b0a
	push bc			;6b0b
	push hl			;6b0c
	ld h,000h		;6b0d
	ld l,a			;6b0f
	add hl,hl			;6b10
	ld bc,0b04fh		;6b11
	add hl,bc			;6b14
	ld a,(hl)			;6b15
	ld (de),a			;6b16
	inc hl			;6b17
	inc de			;6b18
	ld a,(hl)			;6b19
	ld (de),a			;6b1a
	inc de			;6b1b
	pop hl			;6b1c
	pop bc			;6b1d
	inc hl			;6b1e
	djnz L_6B0A		;6b1f
	call 041f6h		;6b21
	ld hl,0b21bh		;6b24
	call 04d81h		;6b27
	push hl			;6b2a
	ld de,0ea80h		;6b2b
	ld a,(hl)			;6b2e
	ld (de),a			;6b2f
	ld b,a			;6b30
	inc hl			;6b31
	inc de			;6b32
L_6B33:
	ld a,(hl)			;6b33
	ld (de),a			;6b34
	inc hl			;6b35
	inc de			;6b36
	ld a,(hl)			;6b37
	and 01fh		;6b38
	ld (de),a			;6b3a
	inc hl			;6b3b
	inc de			;6b3c
	djnz L_6B33		;6b3d
	pop hl			;6b3f
	ld de,0eb00h		;6b40
	ld a,(hl)			;6b43
	ld (de),a			;6b44
	ld b,a			;6b45
	inc hl			;6b46
	inc de			;6b47
L_6B48:
	inc de			;6b48
	ld a,(hl)			;6b49
	ld (de),a			;6b4a
	inc hl			;6b4b
	dec de			;6b4c
	ld a,(hl)			;6b4d
	and 01fh		;6b4e
	ld (de),a			;6b50
	inc de			;6b51
	inc de			;6b52
	ld a,(hl)			;6b53
	rlca			;6b54
	rlca			;6b55
	rlca			;6b56
	and 007h		;6b57
	ld (de),a			;6b59
	inc hl			;6b5a
	inc de			;6b5b
	djnz L_6B48		;6b5c
	ret			;6b5e
L_6B5F:
	ld hl,0eb90h		;6b5f
	ld a,(0c002h)		;6b62
	rrca			;6b65
	rrca			;6b66
	rrca			;6b67
	and 010h		;6b68
	ld b,a			;6b6a
	ld a,(0c288h)		;6b6b
	or b			;6b6e
	ld (hl),a			;6b6f
	inc hl			;6b70
	ld a,(0c280h)		;6b71
	call L_6BF5		;6b74
	inc hl			;6b77
	ld a,(0c281h)		;6b78
	call L_6BF5		;6b7b
	inc hl			;6b7e
	ld a,(0c267h)		;6b7f
	ld (hl),a			;6b82
	inc hl			;6b83
	ld a,(0c00eh)		;6b84
	ld (hl),a			;6b87
	inc hl			;6b88
	ex de,hl			;6b89
	ld hl,0eb90h		;6b8a
	ld b,007h		;6b8d
	xor a			;6b8f
L_6B90:
	ld c,(hl)			;6b90
	add a,c			;6b91
	inc hl			;6b92
	djnz L_6B90		;6b93
	ex de,hl			;6b95
	call L_6BF5		;6b96
	ld a,(0eb96h)		;6b99
	ld c,a			;6b9c
	ld hl,0eb90h		;6b9d
	ld de,0eba0h		;6ba0
	ld b,009h		;6ba3
L_6BA5:
	ld a,(hl)			;6ba5
	push de			;6ba6
	ld d,a			;6ba7
	ld a,b			;6ba8
	cp 004h		;6ba9
	jr nc,L_6BB0		;6bab
	ld a,d			;6bad
	jr L_6BC1		;6bae
L_6BB0:
	ld e,a			;6bb0
	rr e		;6bb1
	jr c,L_6BB6		;6bb3
	add a,a			;6bb5
L_6BB6:
	add a,a			;6bb6
	add a,c			;6bb7
	add a,d			;6bb8
L_6BB9:
	cp 02eh		;6bb9
	jr c,L_6BC1		;6bbb
	sub 02eh		;6bbd
	jr L_6BB9		;6bbf
L_6BC1:
	add a,030h		;6bc1
	pop de			;6bc3
	ld (de),a			;6bc4
	inc hl			;6bc5
	inc de			;6bc6
	djnz L_6BA5		;6bc7
	ld a,0ffh		;6bc9
	ld (de),a			;6bcb
	ld hl,05070h		;6bcc
	ld bc,0601ch		;6bcf
	ld de,0a0c0h		;6bd2
	call L_6382		;6bd5
	ld hl,06ccch		;6bd8
	call 048f3h		;6bdb
	ld hl,0eba0h		;6bde
	ld de,06080h		;6be1
	jp 048fdh		;6be4
L_6BE7:
	ld de,05070h		;6be7
	ld bc,0601ch		;6bea
	ld hl,0a0c0h		;6bed
	ld a,001h		;6bf0
	jp 0476eh		;6bf2
L_6BF5:
	ld b,a			;6bf5
	rra			;6bf6
	rra			;6bf7
	rra			;6bf8
	rra			;6bf9
	and 00fh		;6bfa
	ld (hl),a			;6bfc
	inc hl			;6bfd
	ld a,b			;6bfe
	and 00fh		;6bff
	ld (hl),a			;6c01
	ret			;6c02
L_6C03:
	call L_6CD8		;6c03
	xor a			;6c06
	ld (0eb82h),a		;6c07
	ld de,0ebb0h		;6c0a
	ld hl,0eb83h		;6c0d
	ld a,(hl)			;6c10
	cp 009h		;6c11
	jr nc,L_6C31		;6c13
	ld a,(0eb81h)		;6c15
	and a			;6c18
	ret z			;6c19
	push af			;6c1a
	ld a,(hl)			;6c1b
	add a,e			;6c1c
	ld e,a			;6c1d
	pop af			;6c1e
	ld (de),a			;6c1f
	exx			;6c20
	ld c,0ffh		;6c21
	ld hl,0ebb0h		;6c23
	ld de,06080h		;6c26
	call 048fdh		;6c29
	exx			;6c2c
	inc de			;6c2d
	inc (hl)			;6c2e
	xor a			;6c2f
	ret			;6c30
L_6C31:
	ex de,hl			;6c31
	ld de,0ebc0h		;6c32
	ld b,009h		;6c35
L_6C37:
	ld a,(hl)			;6c37
	sub 030h		;6c38
	ld (de),a			;6c3a
	inc hl			;6c3b
	inc de			;6c3c
	djnz L_6C37		;6c3d
	ld hl,0ebc0h		;6c3f
	ld bc,00609h		;6c42
	ld a,(0ebc6h)		;6c45
	ld e,a			;6c48
L_6C49:
	ld a,b			;6c49
	rra			;6c4a
	ld a,c			;6c4b
	jr nc,L_6C4F		;6c4c
	add a,a			;6c4e
L_6C4F:
	add a,a			;6c4f
	ld d,a			;6c50
	ld a,(hl)			;6c51
	sub d			;6c52
	sub e			;6c53
	ld d,a			;6c54
	rl d		;6c55
	jr nc,L_6C5B		;6c57
	add a,02eh		;6c59
L_6C5B:
	ld (hl),a			;6c5b
	dec c			;6c5c
	inc hl			;6c5d
	djnz L_6C49		;6c5e
	ld hl,0ebc0h		;6c60
	ld b,007h		;6c63
	xor a			;6c65
L_6C66:
	add a,(hl)			;6c66
	inc hl			;6c67
	djnz L_6C66		;6c68
	ld d,a			;6c6a
	ld hl,(0ebc7h)		;6c6b
	call L_6CAB		;6c6e
	cp d			;6c71
	scf			;6c72
	ret nz			;6c73
	ld a,001h		;6c74
	ld (0eb82h),a		;6c76
	ret			;6c79
L_6C7A:
	ld a,(0ebc0h)		;6c7a
	ld b,a			;6c7d
	and 00fh		;6c7e
	ld (0c288h),a		;6c80
	ld a,b			;6c83
	and 010h		;6c84
	ld hl,0c002h		;6c86
	jr z,L_6C8D		;6c89
	set 7,(hl)		;6c8b
L_6C8D:
	ld hl,(0ebc1h)		;6c8d
	call L_6CAB		;6c90
	ld (0c280h),a		;6c93
	ld hl,(0ebc3h)		;6c96
	call L_6CAB		;6c99
	ld (0c281h),a		;6c9c
	ld a,(0ebc5h)		;6c9f
	ld (0c267h),a		;6ca2
	ld a,001h		;6ca5
	ld (0c268h),a		;6ca7
	ret			;6caa
L_6CAB:
	rl l		;6cab
	rl l		;6cad
	rl l		;6caf
	rl l		;6cb1
	ld a,l			;6cb3
	and 0f0h		;6cb4
	or h			;6cb6
	ret			;6cb7
L_6CB8:
	xor a			;6cb8
	ld (0eb83h),a		;6cb9
	ld hl,0ebb0h		;6cbc
	ld de,0ebb1h		;6cbf
	ld bc,00008h		;6cc2
	ld (hl),a			;6cc5
	ldir		;6cc6
	inc hl			;6cc8
	ld (hl),0ffh		;6cc9
	ret			;6ccb

; ----------------------------------------------------------------------
; DATOS rotulo_6CCC: rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p01:6BDB (12 bytes)
;   0x6ccc..0x6cd8  (12 bytes)
DATA_rotulo_6CCC:
	defb 058h,074h,04ah,04fh,041h,048h,030h,05dh,039h,063h,032h,0ffh	; 6ccc  XtJOAH0]9c2.

; ======================================================================
; CODIGO 0x6cd8..0x6d4c  (116 bytes)
; ======================================================================


L_6CD8:
	di			;6cd8
	ld a,006h		;6cd9
	ld (0a000h),a		;6cdb
	ld (0f0f3h),a		;6cde
	ei			;6ce1
	ld b,009h		;6ce2
	ld e,000h		;6ce4
L_6CE6:
	ld a,e			;6ce6
	call 00141h		;6ce7   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;6cea
	and a			;6ceb
	jr nz,L_6CFB		;6cec
	inc e			;6cee
	djnz L_6CE6		;6cef
	xor a			;6cf1
	ld hl,0eb80h		;6cf2
	ld (hl),a			;6cf5
	inc hl			;6cf6
	ld (hl),a			;6cf7
	jp 04206h		;6cf8
L_6CFB:
	ld b,a			;6cfb
	ld a,(0fcadh)		;6cfc
	and a			;6cff
	ld hl,0adech		;6d00
	jr z,L_6D08		;6d03
	ld hl,0ae34h		;6d05
L_6D08:
	ld a,e			;6d08
	add a,a			;6d09
	add a,a			;6d0a
	add a,a			;6d0b
	call 04083h		;6d0c
	ld a,b			;6d0f
L_6D10:
	rra			;6d10
	jr c,L_6D16		;6d11
	inc hl			;6d13
	jr L_6D10		;6d14
L_6D16:
	ld a,(0fcadh)		;6d16
	and a			;6d19
	ld a,(hl)			;6d1a
	jr z,L_6D2C		;6d1b
	ld a,006h		;6d1d
	call 00141h		;6d1f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;6d22
	ld a,(hl)			;6d23
	jr c,L_6D2C		;6d24
	cp 05bh		;6d26
	jr nz,L_6D2C		;6d28
	ld a,05ch		;6d2a
L_6D2C:
	ld hl,0eb80h		;6d2c
	ld c,(hl)			;6d2f
	ld (hl),a			;6d30
	xor c			;6d31
	and (hl)			;6d32
	inc hl			;6d33
	ld (hl),a			;6d34
	jp 04206h		;6d35
L_6D38:
	ld a,(0cd32h)		;6d38
	and a			;6d3b
	ret nz			;6d3c
	call L_710E		;6d3d
	call L_71A2		;6d40
	call L_7116		;6d43
	ld a,(0c490h)		;6d46
	call 0408dh		;6d49

; ----------------------------------------------------------------------
; DATOS tabla_6D4C: 6 destinos del despachador de 0x408D (call en p01:6D49):
;   0x6D58, 0x6E9A, 0x6F48, 0x6F8F, 0x706E, 0x70A9; lo leen p01:6D49 (12
;   bytes)
;   0x6d4c..0x6d58  (12 bytes)
DATA_tabla_6D4C:
	defb 058h,06dh	; 6d4c
	defb 09ah,06eh	; 6d4e
	defb 048h,06fh	; 6d50
	defb 08fh,06fh	; 6d52
	defb 06eh,070h	; 6d54
	defb 0a9h,070h	; 6d56

; ======================================================================
; CODIGO 0x6d58..0x6e92  (314 bytes)
; ======================================================================


L_6D58:
	call L_6E7B		;6d58
	ld a,(0c492h)		;6d5b
	and a			;6d5e
	ret nz			;6d5f
	ld a,(0cdb0h)		;6d60
	and a			;6d63
	call nz,L_7D0D		;6d64
	call L_7763		;6d67
	jr c,L_6DD6		;6d6a
	call L_715D		;6d6c
	ld a,(0c490h)		;6d6f
	cp 003h		;6d72
	ret z			;6d74
	call L_72E6		;6d75
	ld a,(0c482h)		;6d78
	and a			;6d7b
	jr nz,L_6D89		;6d7c
	ld a,(0c006h)		;6d7e
	bit 4,a		;6d81
	jr nz,L_6DB9		;6d83
	bit 5,a		;6d85
	jr nz,L_6DBF		;6d87
L_6D89:
	ld de,0c485h		;6d89
	ld a,(de)			;6d8c
	and a			;6d8d
	jr z,L_6D9E		;6d8e
	ld a,(0c00dh)		;6d90
	and 003h		;6d93
	jr nz,L_6D9E		;6d95
	ld hl,0c49fh		;6d97
	ld a,(hl)			;6d9a
	xor 001h		;6d9b
	ld (hl),a			;6d9d
L_6D9E:
	ld a,(de)			;6d9e
L_6D9F:
	rra			;6d9f
	jp c,L_6E04		;6da0
	rra			;6da3
	jp c,L_6E18		;6da4
	rra			;6da7
	jp c,L_6E30		;6da8
	rra			;6dab
	jp c,L_6E57		;6dac
	ld a,(0c490h)		;6daf
	dec a			;6db2
	ret z			;6db3
	xor a			;6db4
	ld (0c49fh),a		;6db5
	ret			;6db8
L_6DB9:
	ld a,001h		;6db9
	ld (0c492h),a		;6dbb
	ret			;6dbe
L_6DBF:
	ld a,(0c485h)		;6dbf
	ld (0c4a5h),a		;6dc2
	ld a,001h		;6dc5
	ld (0c490h),a		;6dc7
	inc a			;6dca
	ld (0c49fh),a		;6dcb
	call L_7395		;6dce
	ld a,001h		;6dd1
	jp 04fe4h		;6dd3
L_6DD6:
	call L_67B3		;6dd6
	call L_67DA		;6dd9
	call L_67F4		;6ddc
	ld hl,0c4d3h		;6ddf
	call L_76AC		;6de2
	ld hl,0c4e3h		;6de5
	call L_76AC		;6de8
	call L_6F64		;6deb
	ld a,002h		;6dee
	ld (0c490h),a		;6df0
	ld a,00fh		;6df3
	ld (0c4a8h),a		;6df5
	xor a			;6df8
	ld (0c49fh),a		;6df9
	ld (0c4a9h),a		;6dfc
	ld a,08bh		;6dff
	jp 04fe4h		;6e01
L_6E04:
	xor a			;6e04
	ld (0c4a2h),a		;6e05
	call L_771F		;6e08
	ret c			;6e0b
	ld de,(0c4a3h)		;6e0c
	call 08c0ah		;6e10
	ld (0c49bh),de		;6e13
	ret			;6e17
L_6E18:
	ld a,001h		;6e18
	ld (0c4a2h),a		;6e1a
	ld a,(0c494h)		;6e1d
	cp 0c9h		;6e20
	ret nc			;6e22
	call L_7741		;6e23
	ret c			;6e26
	ld de,(0c4a3h)		;6e27
	ld (0c49bh),de		;6e2b
	ret			;6e2f
L_6E30:
	ld a,002h		;6e30
	ld (0c4a2h),a		;6e32
	ld a,(0c483h)		;6e35
	and a			;6e38
	jr nz,L_6E47		;6e39
	ld a,(0c286h)		;6e3b
	inc a			;6e3e
	jr nz,L_6E47		;6e3f
	ld a,(0c496h)		;6e41
	cp 010h		;6e44
	ret c			;6e46
L_6E47:
	call L_7794		;6e47
	ret c			;6e4a
	ld de,(0c4a3h)		;6e4b
	call 08c0ah		;6e4f
	ld (0c49dh),de		;6e52
	ret			;6e56
L_6E57:
	ld a,003h		;6e57
	ld (0c4a2h),a		;6e59
	ld a,(0c483h)		;6e5c
	and a			;6e5f
	jr nz,L_6E6E		;6e60
	ld a,(0c287h)		;6e62
	inc a			;6e65
	jr nz,L_6E6E		;6e66
	ld a,(0c496h)		;6e68
	cp 0f1h		;6e6b
	ret nc			;6e6d
L_6E6E:
	call L_777E		;6e6e
	ret c			;6e71
	ld de,(0c4a3h)		;6e72
	ld (0c49dh),de		;6e76
	ret			;6e7a
L_6E7B:
	ld a,(0c270h)		;6e7b
	add a,a			;6e7e
	ld hl,06e92h		;6e7f
	call 04d81h		;6e82
	ld (0c4a3h),hl		;6e85
	ld hl,00000h		;6e88
	ld (0c49bh),hl		;6e8b
	ld (0c49dh),hl		;6e8e
	ret			;6e91

; ----------------------------------------------------------------------
; DATOS velocidades: cuatro palabras, una por cada valor de 0xC270, que
;   p01:6E85 deja en 0xC4A3: 0x0100, 0x0180, 0x0200 y 0x0280 (8 bytes)
;   0x6e92..0x6e9a  (8 bytes)
DATA_velocidades:
	defb 000h,001h	; 6e92
	defb 080h,001h	; 6e94
	defb 000h,002h	; 6e96
	defb 080h,002h	; 6e98

; ======================================================================
; CODIGO 0x6e9a..0x6f2a  (144 bytes)
; ======================================================================


L_6E9A:
	ld a,(0c492h)		;6e9a
	and a			;6e9d
	jr nz,L_6EA8		;6e9e
	ld a,(0c006h)		;6ea0
	bit 4,a		;6ea3
	call nz,L_6DB9		;6ea5
L_6EA8:
	call L_6E7B		;6ea8
	ld a,(0c4a5h)		;6eab
	ld h,a			;6eae
	and 00ch		;6eaf
	ld bc,00000h		;6eb1
	jr z,L_6EB9		;6eb4
	ld bc,0060ch		;6eb6
L_6EB9:
	ld a,(0c496h)		;6eb9
	sub b			;6ebc
	ld d,a			;6ebd
	ld b,h			;6ebe
	ld a,(0c494h)		;6ebf
	ld e,a			;6ec2
	call L_7804		;6ec3
	inc a			;6ec6
	ld a,b			;6ec7
	jr z,L_6EEF		;6ec8
	ld a,d			;6eca
	add a,c			;6ecb
	ld d,a			;6ecc
	call L_7804		;6ecd
	inc a			;6ed0
	ld a,b			;6ed1
	jr z,L_6EEF		;6ed2
	ld a,(0c4aah)		;6ed4
	and a			;6ed7
	jr nz,L_6EF2		;6ed8
	ld a,(0c006h)		;6eda
	ld c,a			;6edd
	ld a,b			;6ede
	rr b		;6edf
	jr c,L_6F1D		;6ee1
	rr b		;6ee3
	jr c,L_6F1F		;6ee5
	rr b		;6ee7
	jr c,L_6F19		;6ee9
	rr b		;6eeb
	jr c,L_6F1B		;6eed
L_6EEF:
	call L_6D9F		;6eef
L_6EF2:
	ld de,06f2ah		;6ef2
	ld hl,0c4a0h		;6ef5
	ld a,(hl)			;6ef8
	inc (hl)			;6ef9
	cp 01eh		;6efa
	jr nc,L_6F08		;6efc
	call 04088h		;6efe
	ld a,(de)			;6f01
	ld hl,0c498h		;6f02
	add a,(hl)			;6f05
	ld (hl),a			;6f06
	ret			;6f07
L_6F08:
	xor a			;6f08
	ld (0c490h),a		;6f09
	ld (0c4a0h),a		;6f0c
	ld (0c49fh),a		;6f0f
	ld (0c4aah),a		;6f12
	ld (0c4a5h),a		;6f15
	ret			;6f18
L_6F19:
	rr c		;6f19
L_6F1B:
	rr c		;6f1b
L_6F1D:
	rr c		;6f1d
L_6F1F:
	rr c		;6f1f
	jr nc,L_6EEF		;6f21
	ld a,001h		;6f23
	ld (0c4aah),a		;6f25
	jr L_6EF2		;6f28

; ----------------------------------------------------------------------
; DATOS curva_del_salto: 30 bytes con signo que p01:6EF2 suma a la y del
;   jugador (0xC498), uno por cuadro (0xC4A0 cuenta hasta 0x1E) (30 bytes)
;   0x6f2a..0x6f48  (30 bytes)
DATA_curva_del_salto:
	defb 0fbh,0fch,0fdh,0fdh,0feh,0feh,0feh,0ffh,0ffh,000h,0ffh,000h,000h,000h,000h,000h	; 6f2a  ................
	defb 000h,000h,000h,001h,000h,001h,001h,002h,002h,002h,003h,003h,004h,005h	; 6f3a  ..............

; ======================================================================
; CODIGO 0x6f48..0x7425  (1245 bytes)
; ======================================================================


L_6F48:
	ld hl,0c4a8h		;6f48
	ld a,(hl)			;6f4b
	and a			;6f4c
	jr z,L_6F58		;6f4d
	ex de,hl			;6f4f
	ld hl,0c498h		;6f50
	inc (hl)			;6f53
	inc (hl)			;6f54
	ex de,hl			;6f55
	dec (hl)			;6f56
	ret			;6f57
L_6F58:
	ld a,(0c0abh)		;6f58
	and a			;6f5b
	ret nz			;6f5c
	jp L_700A		;6f5d
L_6F60:
	ld c,006h		;6f60
	jr L_6F66		;6f62
L_6F64:
	ld c,000h		;6f64
L_6F66:
	ld hl,0ee00h		;6f66
	ld b,010h		;6f69
L_6F6B:
	ld a,b			;6f6b
	cp 009h		;6f6c
	ld a,(0c494h)		;6f6e
	jr nc,L_6F75		;6f71
	add a,010h		;6f73
L_6F75:
	add a,c			;6f75
	ld (hl),a			;6f76
	inc hl			;6f77
	ld (hl),000h		;6f78
	inc hl			;6f7a
	ld (hl),01ch		;6f7b
	inc hl			;6f7d
	inc hl			;6f7e
	djnz L_6F6B		;6f7f
	ld hl,0ec00h		;6f81
	ld de,0ec01h		;6f84
	ld (hl),000h		;6f87
	ld bc,000ffh		;6f89
	ldir		;6f8c
	ret			;6f8e
L_6F8F:
	ld a,(0c491h)		;6f8f
	ld b,a			;6f92
	ld hl,0c4a8h		;6f93
	djnz L_6FBD		;6f96
	dec (hl)			;6f98
	ret nz			;6f99
	ld hl,0fe80h		;6f9a
	ld (0c49bh),hl		;6f9d
	ld a,(0c49ah)		;6fa0
	rla			;6fa3
	ld de,00200h		;6fa4
	call c,08c0ah		;6fa7
	ld (0c49dh),de		;6faa
	ld a,(0c49ah)		;6fae
	sub 0e0h		;6fb1
	cp 040h		;6fb3
	jp c,L_7064		;6fb5
	call L_7069		;6fb8
	jr L_6FC1		;6fbb
L_6FBD:
	djnz L_6FD6		;6fbd
	dec (hl)			;6fbf
	ret nz			;6fc0
L_6FC1:
	ld a,(0c49ah)		;6fc1
	rla			;6fc4
	ld de,00040h		;6fc5
	call nc,08c0ah		;6fc8
	ld (0c4abh),de		;6fcb
	xor a			;6fcf
	ld (0c4adh),a		;6fd0
	jp L_7069		;6fd3
L_6FD6:
	djnz L_704E		;6fd6
	ld hl,(0c49dh)		;6fd8
	ld de,(0c4abh)		;6fdb
	ld a,(0c4adh)		;6fdf
	and a			;6fe2
	call nz,08c0ah		;6fe3
	add hl,de			;6fe6
	ld (0c49dh),hl		;6fe7
	ld a,h			;6fea
	inc a			;6feb
	inc a			;6fec
	cp 004h		;6fed
	ld hl,0c4adh		;6fef
	jr c,L_6FF8		;6ff2
	ld a,(hl)			;6ff4
	xor 001h		;6ff5
	ld (hl),a			;6ff7
L_6FF8:
	ld hl,0c498h		;6ff8
	ld a,(hl)			;6ffb
	cp 0f0h		;6ffc
	ld b,001h		;6ffe
	jr c,L_7005		;7000
	dec b			;7002
	ld (hl),0f8h		;7003
L_7005:
	ld a,(0c0abh)		;7005
	or b			;7008
	ret nz			;7009
L_700A:
	xor a			;700a
	ld (0c263h),a		;700b
	ld (0c27eh),a		;700e
	ld hl,0c270h		;7011
	ld (hl),a			;7014
	inc hl			;7015
	ld (hl),a			;7016
	ld (0c483h),a		;7017
	inc a			;701a
	ld (0c268h),a		;701b
L_701E:
	ld hl,0c266h		;701e
	xor a			;7021
	rrd		;7022
	srl (hl)		;7024
	ld c,000h		;7026
	jr nc,L_702C		;7028
	ld c,005h		;702a
L_702C:
	srl a		;702c
	rld		;702e
	ld b,000h		;7030
	jr nc,L_7036		;7032
	ld b,050h		;7034
L_7036:
	ld a,(hl)			;7036
	add a,c			;7037
	ld (hl),a			;7038
	dec l			;7039
	xor a			;703a
	rrd		;703b
	srl (hl)		;703d
	ld c,000h		;703f
	jr nc,L_7045		;7041
	ld c,005h		;7043
L_7045:
	srl a		;7045
	rld		;7047
	ld a,(hl)			;7049
	add a,b			;704a
	add a,c			;704b
	ld (hl),a			;704c
	ret			;704d
L_704E:
	ld hl,00000h		;704e
	ld (0c49bh),hl		;7051
	ld (0c49dh),hl		;7054
	ld a,(0c4a7h)		;7057
	and a			;705a
	ret nz			;705b
	ld a,004h		;705c
	ld (0c49fh),a		;705e
	ld (0c4aeh),a		;7061
L_7064:
	ld a,010h		;7064
	ld (0c4a8h),a		;7066
L_7069:
	ld hl,0c491h		;7069
	inc (hl)			;706c
	ret			;706d
L_706E:
	ld a,(0c00dh)		;706e
	rra			;7071
	and 003h		;7072
	ld b,a			;7074
	jr z,L_7083		;7075
	cp 003h		;7077
	jr z,L_7083		;7079
	ld b,002h		;707b
	cp 001h		;707d
	jr z,L_7083		;707f
	ld b,001h		;7081
L_7083:
	ld a,b			;7083
	ld (0c4a2h),a		;7084
	ex de,hl			;7087
	ld hl,0c498h		;7088
	inc (hl)			;708b
	ex de,hl			;708c
	ld hl,0c4a8h		;708d
	dec (hl)			;7090
	ret nz			;7091
	xor a			;7092
	ld hl,00000h		;7093
	ld (0c490h),a		;7096
	ld (0c4a3h),hl		;7099
	ld hl,0c483h		;709c
	ld a,(hl)			;709f
	xor 001h		;70a0
	ld (hl),a			;70a2
	call L_67F4		;70a3
	jp L_69D1		;70a6
L_70A9:
	ld hl,0c49bh		;70a9
	xor a			;70ac
	ld (hl),a			;70ad
	inc hl			;70ae
	ld (hl),a			;70af
	inc hl			;70b0
	ld (hl),a			;70b1
	inc hl			;70b2
	ld (hl),a			;70b3
	ld hl,0c4a8h		;70b4
	ld a,(hl)			;70b7
	and a			;70b8
	jr z,L_70E0		;70b9
	dec (hl)			;70bb
	ld a,(hl)			;70bc
	cp 03dh		;70bd
	ret nc			;70bf
	cp 03ch		;70c0
	jr z,L_70F5		;70c2
	ld a,(0c00dh)		;70c4
	push af			;70c7
	and 003h		;70c8
	jr nz,L_70D3		;70ca
	ld hl,0c49fh		;70cc
	ld a,(hl)			;70cf
	xor 001h		;70d0
	ld (hl),a			;70d2
L_70D3:
	pop af			;70d3
	and 007h		;70d4
	ret nz			;70d6
	ld hl,0c494h		;70d7
	dec (hl)			;70da
	ld hl,0c498h		;70db
	dec (hl)			;70de
	ret			;70df
L_70E0:
	ld a,0e0h		;70e0
	ld (0c494h),a		;70e2
	ld a,0f0h		;70e5
	ld (0c498h),a		;70e7
	ld a,(0c0abh)		;70ea
	and a			;70ed
	ret nz			;70ee
	ld a,001h		;70ef
	ld (0c282h),a		;70f1
	ret			;70f4
L_70F5:
	ld a,(0c289h)		;70f5
	cp 004h		;70f8
	ld hl,000a0h		;70fa
	ld de,07040h		;70fd
	jr nz,L_7106		;7100
	ld h,0a8h		;7102
	ld d,080h		;7104
L_7106:
	ld bc,02020h		;7106
	ld a,040h		;7109
	jp 04803h		;710b
L_710E:
	ld hl,0c4a7h		;710e
	ld a,(hl)			;7111
	and a			;7112
	ret z			;7113
	dec (hl)			;7114
	ret			;7115
L_7116:
	ld a,(0c490h)		;7116
	cp 003h		;7119
	ret z			;711b
	call L_7132		;711c
	ld de,(0c4b0h)		;711f
	ld a,d			;7123
	and a			;7124
	ret nz			;7125
	ld a,e			;7126
	cp 050h		;7127
	ret nc			;7129
	ld a,(0c0abh)		;712a
	and a			;712d
	ret nz			;712e
	jp 0416fh		;712f
L_7132:
	ld b,000h		;7132
	ld de,(0c4b0h)		;7134
	ld a,d			;7138
	and a			;7139
	jr nz,L_7143		;713a
	ld a,e			;713c
	cp 050h		;713d
	jr nz,L_7143		;713f
	ld b,001h		;7141
L_7143:
	ld hl,0c269h		;7143
	ld a,(hl)			;7146
	xor b			;7147
	and b			;7148
	call nz,L_714E		;7149
	ld (hl),b			;714c
	ret			;714d
L_714E:
	ld a,001h		;714e
	ld (0c0afh),a		;7150
	ld a,(0c483h)		;7153
	and a			;7156
	ret nz			;7157
	ld a,092h		;7158
	jp 04fe4h		;715a
L_715D:
	ld a,(0c481h)		;715d
	and a			;7160
	jr z,L_716C		;7161
	ld bc,(0c4b0h)		;7163
	ld a,b			;7167
	or c			;7168
	ret nz			;7169
	jr L_7183		;716a
L_716C:
	ld hl,0c277h		;716c
	ld a,(hl)			;716f
	and a			;7170
	jr z,L_7183		;7171
	ld (hl),000h		;7173
	ld a,(0c480h)		;7175
	ld (0c481h),a		;7178
	call 05890h		;717b
	ld a,007h		;717e
	jp 057fah		;7180
L_7183:
	call L_67B3		;7183
	call L_67DA		;7186
	xor a			;7189
	ld (0c492h),a		;718a
	ld (0c4d0h),a		;718d
	ld (0c4e0h),a		;7190
	ld a,003h		;7193
	ld (0c490h),a		;7195
	ld a,020h		;7198
	ld (0c4a7h),a		;719a
	ld a,08bh		;719d
	jp 04fe4h		;719f
L_71A2:
	ld hl,0c485h		;71a2
	ld a,(0c007h)		;71a5
	and 00fh		;71a8
	ld b,a			;71aa
	jr z,L_71B9		;71ab
	ld a,(0c006h)		;71ad
	and 00fh		;71b0
	jr nz,L_71B9		;71b2
	ld a,b			;71b4
	and (hl)			;71b5
	jr nz,L_71B9		;71b6
	ld a,b			;71b8
L_71B9:
	ld (hl),a			;71b9
	ret			;71ba
L_71BB:
	ld a,(0c490h)		;71bb
	cp 003h		;71be
	ret z			;71c0
	ld a,(0c483h)		;71c1
	and a			;71c4
	jr nz,L_71D1		;71c5
	ld a,(0c482h)		;71c7
	and a			;71ca
	jp nz,L_729D		;71cb
	call L_7258		;71ce
L_71D1:
	ld hl,0c283h		;71d1
	ld de,0c496h		;71d4
	ld a,(de)			;71d7
	cp 0f7h		;71d8
	jr nc,L_71E7		;71da
	cp 00ah		;71dc
	jr nc,L_71F2		;71de
	ld (hl),003h		;71e0
	ld a,0f6h		;71e2
	ld (de),a			;71e4
	jr L_71EC		;71e5
L_71E7:
	ld (hl),004h		;71e7
	ld a,00ah		;71e9
	ld (de),a			;71eb
L_71EC:
	inc de			;71ec
	inc de			;71ed
	inc de			;71ee
	inc de			;71ef
	ld (de),a			;71f0
	ret			;71f1
L_71F2:
	ld hl,0c520h		;71f2
	ld a,(hl)			;71f5
	ld c,a			;71f6
	and a			;71f7
	ret z			;71f8
	ld d,050h		;71f9
	dec a			;71fb
	jr z,L_7200		;71fc
	ld d,0c8h		;71fe
L_7200:
	ld a,(0c494h)		;7200
	sub d			;7203
	cp 008h		;7204
	ret nc			;7206
	ld a,(0c496h)		;7207
	sub 040h		;720a
	cp 020h		;720c
	ret nc			;720e
	ld a,(0c007h)		;720f
	ld b,a			;7212
	ld a,(0c4a5h)		;7213
	or b			;7216
	ld b,a			;7217
	ld a,c			;7218
	dec a			;7219
	ld a,b			;721a
	jr nz,L_7221		;721b
	rra			;721d
	ret nc			;721e
	jr L_7224		;721f
L_7221:
	rra			;7221
	rra			;7222
	ret nc			;7223
L_7224:
	inc hl			;7224
	ld a,(hl)			;7225
	ld (0c267h),a		;7226
	xor a			;7229
	ld (0c490h),a		;722a
	ld (0c4a0h),a		;722d
	ld (0c49fh),a		;7230
	ld (0c4a5h),a		;7233
	ld a,050h		;7236
	ld (0c49ah),a		;7238
	ld (0c496h),a		;723b
	dec hl			;723e
	ld a,(hl)			;723f
	ld (0c283h),a		;7240
	dec a			;7243
	jr z,L_724F		;7244
	ld a,054h		;7246
	ld (0c498h),a		;7248
	ld (0c494h),a		;724b
	ret			;724e
L_724F:
	ld a,0c4h		;724f
	ld (0c498h),a		;7251
	ld (0c494h),a		;7254
	ret			;7257
L_7258:
	ld a,(0c490h)		;7258
	and a			;725b
	ret nz			;725c
	ld hl,0c500h		;725d
	ld b,002h		;7260
L_7262:
	push hl			;7262
	inc l			;7263
	ld a,(hl)			;7264
	and a			;7265
	jr z,L_7295		;7266
	ld a,(0c494h)		;7268
	sub (hl)			;726b
	cp 006h		;726c
	jr nc,L_7295		;726e
	inc l			;7270
	ld a,(hl)			;7271
	sub 008h		;7272
	ld c,a			;7274
	ld a,(0c496h)		;7275
	sub c			;7278
	cp 010h		;7279
	jr nc,L_7295		;727b
	ld a,(0c007h)		;727d
	rra			;7280
	jr nc,L_7295		;7281
	pop hl			;7283
	set 7,(hl)		;7284
	xor a			;7286
	ld (0c4a7h),a		;7287
	ld a,001h		;728a
	ld (0c482h),a		;728c
	ld a,005h		;728f
	ld (0c283h),a		;7291
	ret			;7294
L_7295:
	pop hl			;7295
	ld de,00010h		;7296
	add hl,de			;7299
	djnz L_7262		;729a
	ret			;729c
L_729D:
	ld a,(0cd2eh)		;729d
	and a			;72a0
	ret nz			;72a1
	ld a,(0c494h)		;72a2
	sub 0bch		;72a5
	cp 010h		;72a7
	ret nc			;72a9
	ld a,(0c496h)		;72aa
	sub 078h		;72ad
	cp 010h		;72af
	ret nc			;72b1
	ld a,(0c007h)		;72b2
	rra			;72b5
	rra			;72b6
	ret nc			;72b7
L_72B8:
	xor a			;72b8
	ld (0c482h),a		;72b9
	ld a,006h		;72bc
	ld (0c283h),a		;72be
	ld hl,0c500h		;72c1
	ld b,003h		;72c4
L_72C6:
	ld a,(hl)			;72c6
	rla			;72c7
	jr nc,L_72DF		;72c8
	res 7,(hl)		;72ca
	inc hl			;72cc
	ld a,(hl)			;72cd
	add a,008h		;72ce
	ld (0c498h),a		;72d0
	ld (0c494h),a		;72d3
	inc hl			;72d6
	ld a,(hl)			;72d7
	ld (0c49ah),a		;72d8
	ld (0c496h),a		;72db
	ret			;72de
L_72DF:
	ld de,00010h		;72df
	add hl,de			;72e2
	djnz L_72C6		;72e3
	ret			;72e5
L_72E6:
	ld a,(0c28ah)		;72e6
	and a			;72e9
	ret z			;72ea
	dec a			;72eb
	dec a			;72ec
	jr z,L_7366		;72ed
	dec a			;72ef
	jr z,L_7332		;72f0
	ld a,(0c279h)		;72f2
	cp 003h		;72f5
	ret c			;72f7
	ld a,(0c496h)		;72f8
	sub 070h		;72fb
	cp 020h		;72fd
	ret nc			;72ff
L_7300:
	ld a,(0c494h)		;7300
	sub 060h		;7303
	cp 008h		;7305
	ret nc			;7307
	ld a,(0c007h)		;7308
	rra			;730b
	ret nc			;730c
	call L_67B3		;730d
	call L_67DA		;7310
	call L_67E8		;7313
	ld a,05ah		;7316
	ld (0c4a8h),a		;7318
	ld a,005h		;731b
	ld (0c490h),a		;731d
	xor a			;7320
	ld (0c4a2h),a		;7321
	ld (0c49fh),a		;7324
	ld (0c4a7h),a		;7327
	ld (0c279h),a		;732a
	ld a,08fh		;732d
	jp 04fe4h		;732f
L_7332:
	ld a,(0c496h)		;7332
	sub 098h		;7335
	cp 010h		;7337
	ret nc			;7339
	ld a,(0c494h)		;733a
	sub 060h		;733d
	cp 008h		;733f
	ret nc			;7341
	ld a,(0c007h)		;7342
	rra			;7345
	ret nc			;7346
	call L_67B3		;7347
	call L_67DA		;734a
	call L_67E8		;734d
	xor a			;7350
	ld (0c4a2h),a		;7351
	ld (0c49fh),a		;7354
	ld (0c4a7h),a		;7357
	inc a			;735a
	ld (0c28bh),a		;735b
	call 04cabh		;735e
	ld a,000h		;7361
	jp 04fe4h		;7363
L_7366:
	ld a,(0c496h)		;7366
	sub 080h		;7369
	cp 020h		;736b
	ret nc			;736d
	jr L_7300		;736e
L_7370:
	ld hl,(0c493h)		;7370
	ld de,(0c49bh)		;7373
	add hl,de			;7377
	ld (0c493h),hl		;7378
	ld hl,(0c497h)		;737b
	add hl,de			;737e
	ld (0c497h),hl		;737f
	ld hl,(0c495h)		;7382
	ld de,(0c49dh)		;7385
	add hl,de			;7389
	ld (0c495h),hl		;738a
	ld hl,(0c499h)		;738d
	add hl,de			;7390
	ld (0c499h),hl		;7391
	ret			;7394
L_7395:
	ld a,(0c494h)		;7395
	sub 002h		;7398
	and 0f8h		;739a
	ld e,a			;739c
	ld a,(0c496h)		;739d
	and 0f8h		;73a0
	ld d,a			;73a2
	ld a,(0c4a5h)		;73a3
	ld c,a			;73a6
	rr c		;73a7
	call c,L_7477		;73a9
	rr c		;73ac
	call c,L_747C		;73ae
	rr c		;73b1
	call c,L_7481		;73b3
	rr c		;73b6
	call c,L_7486		;73b8
	xor a			;73bb
	ld (0c4a6h),a		;73bc
	ld (0ee80h),a		;73bf
	ld a,(0c270h)		;73c2
	inc a			;73c5
	inc a			;73c6
	ld b,a			;73c7
	ld c,001h		;73c8
L_73CA:
	push bc			;73ca
	call L_7804		;73cb
	ld a,h			;73ce
	sub 0d8h		;73cf
	cp 003h		;73d1
	jr nc,L_73EE		;73d3
	cp 002h		;73d5
	jr nz,L_73DE		;73d7
	ld a,l			;73d9
	cp 0c0h		;73da
	jr nc,L_73EE		;73dc
L_73DE:
	ld a,(0ee80h)		;73de
	and a			;73e1
	jr nz,L_73EE		;73e2
	ld a,(0c4f1h)		;73e4
	ld b,a			;73e7
	ld a,(hl)			;73e8
	cp b			;73e9
	ld c,000h		;73ea
	jr c,L_73F0		;73ec
L_73EE:
	ld c,001h		;73ee
L_73F0:
	xor a			;73f0
	ld a,c			;73f1
	pop bc			;73f2
	push bc			;73f3
	ld b,c			;73f4
	rra			;73f5
L_73F6:
	rla			;73f6
	djnz L_73F6		;73f7
	ld hl,0c4a6h		;73f9
	or (hl)			;73fc
	ld (hl),a			;73fd
	ld a,(0c4a5h)		;73fe
	ld c,a			;7401
	rr c		;7402
	call c,L_7490		;7404
	rr c		;7407
	call c,L_748B		;7409
	rr c		;740c
	call c,L_749B		;740e
	rr c		;7411
	call c,L_7495		;7413
	pop bc			;7416
	inc c			;7417
	djnz L_73CA		;7418
	ret			;741a
L_741B:
	ld a,(0c4a6h)		;741b
	ld c,a			;741e
	ld a,(0c270h)		;741f
	call 0408dh		;7422

; ----------------------------------------------------------------------
; DATOS tabla_7425: 4 destinos del despachador de 0x408D (call en p01:7422):
;   0x742D, 0x7438, 0x7448, 0x745D; lo leen p01:7422 (8 bytes)
;   0x7425..0x742d  (8 bytes)
DATA_tabla_7425:
	defb 02dh,074h	; 7425
	defb 038h,074h	; 7427
	defb 048h,074h	; 7429
	defb 05dh,074h	; 742b

; ======================================================================
; CODIGO 0x742d..0x75e0  (435 bytes)
; ======================================================================


L_742D:
	ld a,c			;742d
	rra			;742e
	jr nc,L_7475		;742f
	ld b,020h		;7431
	rra			;7433
	jr nc,L_7470		;7434
	jr L_7475		;7436
L_7438:
	ld a,c			;7438
	rra			;7439
	jr nc,L_7475		;743a
	rra			;743c
	ld b,016h		;743d
	jr nc,L_7470		;743f
	rra			;7441
	ld b,024h		;7442
	jr nc,L_7470		;7444
	jr L_7475		;7446
L_7448:
	ld a,c			;7448
	rra			;7449
	jr nc,L_7475		;744a
	rra			;744c
	ld b,010h		;744d
	jr nc,L_7470		;744f
	rra			;7451
	ld b,018h		;7452
	jr nc,L_7470		;7454
	rra			;7456
	ld b,020h		;7457
	jr nc,L_7470		;7459
	jr L_7475		;745b
L_745D:
	ld a,c			;745d
	rra			;745e
	jr nc,L_7475		;745f
	rra			;7461
	ld b,00dh		;7462
	jr nc,L_7470		;7464
	rra			;7466
	ld b,013h		;7467
	jr nc,L_7470		;7469
	rra			;746b
	ld b,01ah		;746c
	jr c,L_7475		;746e
L_7470:
	ld a,(0c4a0h)		;7470
	cp b			;7473
	ret			;7474
L_7475:
	xor a			;7475
	ret			;7476
L_7477:
	ld a,e			;7477
	sub 008h		;7478
	ld e,a			;747a
	ret			;747b
L_747C:
	ld a,e			;747c
	add a,008h		;747d
	ld e,a			;747f
	ret			;7480
L_7481:
	ld a,d			;7481
	sub 008h		;7482
	ld d,a			;7484
	ret			;7485
L_7486:
	ld a,d			;7486
	add a,008h		;7487
	ld d,a			;7489
	ret			;748a
L_748B:
	ld a,e			;748b
	add a,010h		;748c
	ld e,a			;748e
	ret			;748f
L_7490:
	ld a,e			;7490
	sub 010h		;7491
	ld e,a			;7493
	ret			;7494
L_7495:
	ld a,d			;7495
	add a,010h		;7496
	ld d,a			;7498
	jr L_749F		;7499
L_749B:
	ld a,d			;749b
	sub 010h		;749c
	ld d,a			;749e
L_749F:
	ret nc			;749f
	ld a,001h		;74a0
	ld (0ee80h),a		;74a2
	ret			;74a5
L_74A6:
	ld a,(0c002h)		;74a6
	rla			;74a9
	ld hl,0aa56h		;74aa
	jr nc,L_74B2		;74ad
	ld hl,0aa7eh		;74af
L_74B2:
	ld a,(0c49fh)		;74b2
	add a,a			;74b5
	add a,a			;74b6
	ld b,a			;74b7
	ld a,(0c4a2h)		;74b8
	add a,b			;74bb
	add a,a			;74bc
	call 04d81h		;74bd
	ld a,(0c490h)		;74c0
	cp 002h		;74c3
	ld de,0ee00h		;74c5
	jr c,L_74CD		;74c8
	ld de,0ee40h		;74ca
L_74CD:
	ld b,(hl)			;74cd
	ld c,000h		;74ce
	inc hl			;74d0
L_74D1:
	push bc			;74d1
	ld a,(0c498h)		;74d2
	add a,(hl)			;74d5
	ld c,a			;74d6
	ld a,(0c4a7h)		;74d7
	and a			;74da
	jr z,L_74E2		;74db
	rra			;74dd
	jr nc,L_74E2		;74de
	ld c,0e0h		;74e0
L_74E2:
	ld a,c			;74e2
	ld (de),a			;74e3
	inc hl			;74e4
	inc e			;74e5
	ld a,(0c492h)		;74e6
	and a			;74e9
	jr z,L_750C		;74ea
	push bc			;74ec
	call L_766C		;74ed
	pop bc			;74f0
	jr nz,L_750C		;74f1
	ld a,b			;74f3
	cp 003h		;74f4
	jr nc,L_750C		;74f6
	ld a,(0c4a2h)		;74f8
	cp 002h		;74fb
	jr nz,L_750C		;74fd
	ld a,(0c49ah)		;74ff
	add a,(hl)			;7502
	jr c,L_7510		;7503
	dec e			;7505
	ld a,0e0h		;7506
	ld (de),a			;7508
	inc e			;7509
	jr L_7511		;750a
L_750C:
	ld a,(0c49ah)		;750c
	add a,(hl)			;750f
L_7510:
	ld (de),a			;7510
L_7511:
	pop bc			;7511
	inc hl			;7512
	inc e			;7513
	ld a,c			;7514
	add a,a			;7515
	add a,a			;7516
	ld (de),a			;7517
	inc c			;7518
	inc e			;7519
	inc e			;751a
	djnz L_74D1		;751b
	ld a,(0c490h)		;751d
	sub 002h		;7520
	cp 003h		;7522
	jr c,L_7538		;7524
	ld de,0ee18h		;7526
	ld a,(0c494h)		;7529
	ld (de),a			;752c
	inc e			;752d
	ld a,(0c496h)		;752e
	sub 008h		;7531
	ld (de),a			;7533
	inc e			;7534
	ld a,018h		;7535
	ld (de),a			;7537
L_7538:
	ld b,040h		;7538
	ld a,(0c490h)		;753a
	cp 002h		;753d
	ld hl,0ec00h		;753f
	jr c,L_7547		;7542
	ld hl,0ed00h		;7544
L_7547:
	ld a,(0c4aeh)		;7547
	and a			;754a
	jr nz,L_7575		;754b
	ld a,b			;754d
	cp 021h		;754e
	ld c,002h		;7550
	jr nc,L_7580		;7552
	cp 011h		;7554
	ld c,001h		;7556
	jr nc,L_7580		;7558
	ld a,(0c002h)		;755a
	rla			;755d
	ld a,(0c271h)		;755e
	jr c,L_756C		;7561
	and a			;7563
	ld c,003h		;7564
	jr z,L_7580		;7566
	ld c,00eh		;7568
	jr L_7580		;756a
L_756C:
	and a			;756c
	ld c,002h		;756d
	jr z,L_7580		;756f
	ld c,003h		;7571
	jr L_7580		;7573
L_7575:
	ld a,(0c00dh)		;7575
	and 002h		;7578
	ld c,00eh		;757a
	jr z,L_7580		;757c
	ld c,002h		;757e
L_7580:
	ld (hl),c			;7580
	inc l			;7581
	djnz L_7547		;7582
	ld a,(0c490h)		;7584
	cp 002h		;7587
	ret nc			;7589
	ld a,(0c492h)		;758a
	and a			;758d
	jr nz,L_75D4		;758e
	ld a,(0c271h)		;7590
	and a			;7593
	jr nz,L_75D4		;7594
	call L_766C		;7596
	jr nz,L_75D4		;7599
	ld hl,0ec40h		;759b
	ld b,020h		;759e
L_75A0:
	ld a,b			;75a0
	dec a			;75a1
	and 010h		;75a2
	ld c,002h		;75a4
	jr nz,L_75B2		;75a6
	ld c,008h		;75a8
	ld a,(0c002h)		;75aa
	rla			;75ad
	jr nc,L_75B2		;75ae
	ld c,00eh		;75b0
L_75B2:
	ld (hl),c			;75b2
	inc l			;75b3
	djnz L_75A0		;75b4
	ld a,(0c002h)		;75b6
	rla			;75b9
	jr c,L_75D4		;75ba
	ld a,(0c4a2h)		;75bc
	ld hl,075e0h		;75bf
	call 04083h		;75c2
	ld a,(hl)			;75c5
	and a			;75c6
	jr z,L_75D4		;75c7
	ld hl,0ec50h		;75c9
	call 04083h		;75cc
	ld a,007h		;75cf
	ld (hl),a			;75d1
	inc l			;75d2
	ld (hl),a			;75d3
L_75D4:
	ld hl,0ec60h		;75d4
	ld b,010h		;75d7
	ld a,002h		;75d9
L_75DB:
	ld (hl),a			;75db
	inc l			;75dc
	djnz L_75DB		;75dd
	ret			;75df

; ----------------------------------------------------------------------
; DATOS color_por_lado: un byte por lado al que mira el jugador (0xC4A2): el
;   sitio en 0xEC50 donde p01:75C9 cambia el color (0, ninguno) (4 bytes)
;   0x75e0..0x75e4  (4 bytes)
DATA_color_por_lado:
	defb 000h,006h,00ah,00ah	; 75e0

; ======================================================================
; CODIGO 0x75e4..0x770f  (299 bytes)
; ======================================================================


L_75E4:
	ld a,(0c492h)		;75e4
	and a			;75e7
	ret z			;75e8
	dec a			;75e9
	jr nz,L_7608		;75ea
	ld a,(0c271h)		;75ec
	and a			;75ef
	jr nz,L_762B		;75f0
	call L_766C		;75f2
	ret nz			;75f5
	ld a,003h		;75f6
	ld (0c49fh),a		;75f8
	xor a			;75fb
	ld (0c4a1h),a		;75fc
	ld hl,0c492h		;75ff
	inc (hl)			;7602
	ld a,008h		;7603
	jp 04fe4h		;7605
L_7608:
	ld hl,0c4a1h		;7608
	inc (hl)			;760b
	ld a,(hl)			;760c
	cp 005h		;760d
	ret c			;760f
	xor a			;7610
	ld (hl),a			;7611
	ld a,0e0h		;7612
	ld (0ee10h),a		;7614
	ld (0ee14h),a		;7617
L_761A:
	xor a			;761a
	ld (0c492h),a		;761b
	ld a,(0c490h)		;761e
	dec a			;7621
	ld a,002h		;7622
	jr z,L_7627		;7624
	xor a			;7626
L_7627:
	ld (0c49fh),a		;7627
	ret			;762a
L_762B:
	ld hl,0c4d0h		;762b
	ld b,002h		;762e
L_7630:
	ld a,(hl)			;7630
	and a			;7631
	jr z,L_763C		;7632
	ld de,00010h		;7634
	add hl,de			;7637
	djnz L_7630		;7638
	jr L_761A		;763a
L_763C:
	call L_7655		;763c
	inc (hl)			;763f
	inc hl			;7640
	inc hl			;7641
	inc hl			;7642
	ld a,(0c498h)		;7643
	sub 00ch		;7646
	ld (hl),a			;7648
	inc hl			;7649
	ld a,(0c49ah)		;764a
	ld (hl),a			;764d
	ld a,009h		;764e
	call 04fe4h		;7650
	jr L_761A		;7653
L_7655:
	push hl			;7655
	inc hl			;7656
	ld a,(0c4a2h)		;7657
	ld c,a			;765a
	rra			;765b
	ld a,004h		;765c
	jr c,L_7662		;765e
	neg		;7660
L_7662:
	ld b,a			;7662
	ld a,c			;7663
	cp 002h		;7664
	jr c,L_7669		;7666
	inc hl			;7668
L_7669:
	ld (hl),b			;7669
	pop hl			;766a
	ret			;766b
L_766C:
	ld a,(0c4d0h)		;766c
	ld b,a			;766f
	ld a,(0c4e0h)		;7670
	or b			;7673
	ret			;7674
L_7675:
	ld hl,0c4d0h		;7675
	call L_767E		;7678
	ld hl,0c4e0h		;767b
L_767E:
	ld a,(hl)			;767e
	and a			;767f
	ret z			;7680
	inc hl			;7681
	ld b,(hl)			;7682
	inc hl			;7683
	ld c,(hl)			;7684
	inc hl			;7685
	ld a,(hl)			;7686
	add a,b			;7687
	ld (hl),a			;7688
	inc hl			;7689
	ld a,(hl)			;768a
	add a,c			;768b
	ld (hl),a			;768c
	ret			;768d
L_768E:
	ld hl,0c4d0h		;768e
	call L_7697		;7691
	ld hl,0c4e0h		;7694
L_7697:
	ld a,(hl)			;7697
	and a			;7698
	ret z			;7699
	inc hl			;769a
	inc hl			;769b
	inc hl			;769c
	ld a,(hl)			;769d
	sub 0e0h		;769e
	cp 020h		;76a0
	jr c,L_76AC		;76a2
	inc hl			;76a4
	ld a,(hl)			;76a5
	sub 0f8h		;76a6
	cp 010h		;76a8
	ret nc			;76aa
	dec hl			;76ab
L_76AC:
	push hl			;76ac
	ld a,l			;76ad
	and 0f0h		;76ae
	ld l,a			;76b0
	ld d,h			;76b1
	ld e,l			;76b2
	inc de			;76b3
	ld (hl),000h		;76b4
	ld bc,0000fh		;76b6
	ldir		;76b9
	pop hl			;76bb
	ld (hl),0e0h		;76bc
	ld a,l			;76be
	and 0f0h		;76bf
	cp 0d0h		;76c1
	ld hl,0ee10h		;76c3
	jr z,L_76CB		;76c6
	ld hl,0ee14h		;76c8
L_76CB:
	ld a,0e0h		;76cb
	ld (hl),a			;76cd
	inc hl			;76ce
	ld (hl),a			;76cf
	ret			;76d0
L_76D1:
	call L_7675		;76d1
	call L_768E		;76d4
	call L_766C		;76d7
	ret z			;76da
	ld de,0c4d0h		;76db
	ld hl,0ee10h		;76de
	call L_76EA		;76e1
	ld de,0c4e0h		;76e4
	ld hl,0ee14h		;76e7
L_76EA:
	ld a,(de)			;76ea
	and a			;76eb
	ret z			;76ec
	inc de			;76ed
	inc de			;76ee
	inc de			;76ef
	ld a,(de)			;76f0
	sub 004h		;76f1
	ld (hl),a			;76f3
	inc hl			;76f4
	inc de			;76f5
	ld a,(de)			;76f6
	sub 004h		;76f7
	ld (hl),a			;76f9
	inc hl			;76fa
	ld (hl),01ch		;76fb
	ld de,0ec40h		;76fd
	call L_7706		;7700
	ld de,0ec50h		;7703
L_7706:
	ld hl,0770fh		;7706
	ld bc,00010h		;7709
	ldir		;770c
	ret			;770e

; ----------------------------------------------------------------------
; DATOS color_08: 16 veces 0x08: los colores de un sprite que p01:7706 copia a
;   0xEC40 y 0xEC50 (16 bytes)
;   0x770f..0x771f  (16 bytes)
DATA_color_08:
	defb 008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h	; 770f  ................

; ======================================================================
; CODIGO 0x771f..0x77bf  (160 bytes)
; ======================================================================


L_771F:
	ld a,(0c494h)		;771f
	sub 005h		;7722
	ld e,a			;7724
	ld a,(0c496h)		;7725
	ld d,a			;7728
	ld b,002h		;7729
	ld a,d			;772b
	add a,b			;772c
	ld d,a			;772d
	call L_7804		;772e
	call L_77D1		;7731
	ret c			;7734
	ld a,b			;7735
	add a,a			;7736
	ld b,a			;7737
	ld a,d			;7738
	sub b			;7739
	ld d,a			;773a
	call L_7804		;773b
	jp L_77D1		;773e
L_7741:
	ld a,(0c494h)		;7741
	add a,003h		;7744
	ld e,a			;7746
	ld a,(0c496h)		;7747
	ld d,a			;774a
	ld b,002h		;774b
	ld a,d			;774d
	add a,b			;774e
	ld d,a			;774f
	call L_7804		;7750
	call L_77D1		;7753
	ret c			;7756
	ld a,b			;7757
	add a,a			;7758
	ld b,a			;7759
	ld a,d			;775a
	sub b			;775b
	ld d,a			;775c
	call L_7804		;775d
	jp L_77D1		;7760
L_7763:
	ld a,(0c494h)		;7763
	ld e,a			;7766
	ld a,(0c496h)		;7767
	sub 005h		;776a
	ld d,a			;776c
	call L_7804		;776d
	call L_77FD		;7770
	ret nc			;7773
	ld a,d			;7774
	add a,00ah		;7775
	ld d,a			;7777
	call L_7804		;7778
	jp L_77FD		;777b
L_777E:
	ld a,(0c494h)		;777e
	ld e,a			;7781
	ld a,(0c496h)		;7782
	ld d,a			;7785
	ld b,008h		;7786
	ld a,e			;7788
	sub 002h		;7789
	ld e,a			;778b
	ld a,d			;778c
	add a,b			;778d
	ld d,a			;778e
	call L_7804		;778f
	jr $+63		;7792
L_7794:
	ld a,(0c494h)		;7794
	ld e,a			;7797
	ld a,(0c496h)		;7798
	ld d,a			;779b
	ld b,008h		;779c
	ld a,e			;779e
	sub 002h		;779f
	ld e,a			;77a1
	ld a,d			;77a2
	sub b			;77a3
	ld d,a			;77a4
	call L_7804		;77a5
	jr $+41		;77a8
L_77AA:
	ld a,(0c289h)		;77aa
	ld b,a			;77ad
	add a,a			;77ae
	add a,b			;77af
	ld hl,077bfh		;77b0
	call 04083h		;77b3
	ld de,0c4f0h		;77b6
	ld bc,00003h		;77b9
	ldir		;77bc
	ret			;77be

; ----------------------------------------------------------------------
; DATOS tres_por_juego: tres bytes por juego de graficos (0xC289) que p01:77B0
;   copia a 0xC4F0-0xC4F2 (18 bytes)
;   0x77bf..0x77d1  (18 bytes)
DATA_tres_por_juego:
	defb 00dh,006h,007h	; 77bf
	defb 026h,015h,012h	; 77c2
	defb 001h,0f0h,001h	; 77c5
	defb 035h,019h,01dh	; 77c8
	defb 01eh,00fh,010h	; 77cb
	defb 015h,007h,00fh	; 77ce

; ======================================================================
; CODIGO 0x77d1..0x7a44  (627 bytes)
; ======================================================================


L_77D1:
	push af			;77d1
	ld a,(0c490h)		;77d2
	dec a			;77d5
	jr nz,L_77E5		;77d6
	push de			;77d8
	call L_741B		;77d9
	pop de			;77dc
	jr nc,L_77E5		;77dd
	pop af			;77df
	cp 0ffh		;77e0
	ret z			;77e2
	jr L_77E6		;77e3
L_77E5:
	pop af			;77e5
L_77E6:
	ld c,a			;77e6
	ld a,(0c289h)		;77e7
	and a			;77ea
	jr z,L_77F2		;77eb
L_77ED:
	ld a,(0c4f0h)		;77ed
	cp c			;77f0
	ret			;77f1
L_77F2:
	ld a,c			;77f2
	cp 06ch		;77f3
	jr z,L_77FB		;77f5
	cp 092h		;77f7
	jr nz,L_77ED		;77f9
L_77FB:
	xor a			;77fb
	ret			;77fc
L_77FD:
	ld hl,0c4f1h		;77fd
	sub (hl)			;7800
	inc hl			;7801
	cp (hl)			;7802
	ret			;7803
L_7804:
	push de			;7804
	ld a,e			;7805
	sub 020h		;7806
	and 0f8h		;7808
	ld h,000h		;780a
	ld l,a			;780c
	add hl,hl			;780d
	add hl,hl			;780e
	ld a,d			;780f
	and 0f8h		;7810
	rrca			;7812
	rrca			;7813
	rrca			;7814
	call 04083h		;7815
	ld de,0d800h		;7818
	add hl,de			;781b
	ld a,(hl)			;781c
	pop de			;781d
	ret			;781e
L_781F:
	call L_7804		;781f
	ld b,a			;7822
	ld hl,0c4f1h		;7823
	ld a,(hl)			;7826
	cp 0f0h		;7827
	jr nz,L_7830		;7829
	dec l			;782b
	ld a,(hl)			;782c
	inc a			;782d
	jr L_7830		;782e
L_7830:
	dec a			;7830
	cp b			;7831
	ret			;7832
L_7833:
	ld a,(0c490h)		;7833
	cp 002h		;7836
	ret nc			;7838
	ld a,(0c482h)		;7839
	and a			;783c
	ret nz			;783d
	call L_7BDA		;783e
	call L_7CDB		;7841
	call L_78FA		;7844
	call L_793C		;7847
	call L_7855		;784a
	ld a,(0c4a7h)		;784d
	and a			;7850
	ret nz			;7851
	jp L_78C4		;7852
L_7855:
	ld ix,0c600h		;7855
	ld b,008h		;7859
L_785B:
	ld a,(ix+00ch)		;785b
	rra			;785e
	jr nc,L_78BC		;785f
	ld a,(ix+01dh)		;7861
	and a			;7864
	jr nz,L_78BC		;7865
	ld a,(ix+000h)		;7867
	dec a			;786a
	cp 021h		;786b
	jr nc,L_78BC		;786d
	dec a			;786f
	cp 002h		;7870
	jr c,L_787D		;7872
	ld a,(0c4a0h)		;7874
	sub 004h		;7877
	cp 016h		;7879
	jr c,L_78BC		;787b
L_787D:
	push bc			;787d
	call L_7A4E		;787e
	pop bc			;7881
	jr nc,L_78BC		;7882
	ld a,(ix+000h)		;7884
	cp 008h		;7887
	jp z,L_79C8		;7889
	cp 021h		;788c
	jp z,L_79C8		;788e
	ld hl,0c4a7h		;7891
	ld a,(hl)			;7894
	and a			;7895
	jr nz,L_78BC		;7896
	ld a,03ch		;7898
	ld (hl),a			;789a
	ld a,00bh		;789b
	call 04fe4h		;789d
	call L_7A08		;78a0
	ret c			;78a3
	xor a			;78a4
	ld (0c271h),a		;78a5
	inc a			;78a8
	call 057fah		;78a9
	ld a,(ix+000h)		;78ac
	cp 005h		;78af
	jp z,L_79E2		;78b1
	cp 009h		;78b4
	jp z,L_79F0		;78b6
	jp L_79F6		;78b9
L_78BC:
	ld de,00080h		;78bc
	add ix,de		;78bf
	djnz L_785B		;78c1
	ret			;78c3
L_78C4:
	ld ix,0ca00h		;78c4
	ld b,008h		;78c8
L_78CA:
	ld a,(ix+000h)		;78ca
	dec a			;78cd
	cp 021h		;78ce
	jr nc,L_78F2		;78d0
	push bc			;78d2
	call L_7A3E		;78d3
	pop bc			;78d6
	jr nc,L_78F2		;78d7
	ld a,03ch		;78d9
	ld (0c4a7h),a		;78db
	ld a,00bh		;78de
	call 04fe4h		;78e0
	call L_7A2F		;78e3
	ret c			;78e6
	xor a			;78e7
	ld (0c271h),a		;78e8
	inc a			;78eb
	call 057fah		;78ec
	jp L_7A04		;78ef
L_78F2:
	ld de,00040h		;78f2
	add ix,de		;78f5
	djnz L_78CA		;78f7
	ret			;78f9
L_78FA:
	ld a,(0c492h)		;78fa
	and a			;78fd
	ret z			;78fe
	ld ix,0c600h		;78ff
	ld b,008h		;7903
L_7905:
	ld a,(ix+000h)		;7905
	dec a			;7908
	cp 021h		;7909
	jr nc,L_7934		;790b
	ld a,(ix+00ch)		;790d
	rra			;7910
	rra			;7911
	jr nc,L_7934		;7912
	push bc			;7914
	call L_7A61		;7915
	pop bc			;7918
	jr nc,L_7934		;7919
	call L_7980		;791b
	call L_799D		;791e
	ld a,001h		;7921
	ld (ix+00dh),a		;7923
L_7926:
	ld a,(ix+000h)		;7926
	cp 003h		;7929
	ld a,00dh		;792b
	jr nz,L_7931		;792d
	ld a,00ch		;792f
L_7931:
	jp 04fe4h		;7931
L_7934:
	ld de,00080h		;7934
	add ix,de		;7937
	djnz L_7905		;7939
	ret			;793b
L_793C:
	ld a,(0c4d0h)		;793c
	ld b,a			;793f
	ld a,(0c4e0h)		;7940
	or b			;7943
	ret z			;7944
	ld ix,0c600h		;7945
	ld b,008h		;7949
L_794B:
	ld a,(ix+000h)		;794b
	dec a			;794e
	cp 021h		;794f
	jr nc,L_7978		;7951
	ld a,(ix+00ch)		;7953
	rra			;7956
	rra			;7957
	jr nc,L_7978		;7958
	push bc			;795a
	call L_7A73		;795b
	pop bc			;795e
	jr nc,L_7978		;795f
	call L_7980		;7961
	call L_799D		;7964
	ld a,001h		;7967
	ld (ix+00dh),a		;7969
	call L_7926		;796c
	push iy		;796f
	pop hl			;7971
	inc hl			;7972
	inc hl			;7973
	inc hl			;7974
	jp L_76AC		;7975
L_7978:
	ld de,00080h		;7978
	add ix,de		;797b
	djnz L_794B		;797d
	ret			;797f
L_7980:
	di			;7980
	ld a,009h		;7981
	ld (0a000h),a		;7983
	ld (0f0f3h),a		;7986
	ei			;7989
	ld a,(ix+000h)		;798a
	dec a			;798d
	ld hl,0b84ch		;798e
	call 04083h		;7991
	ld e,000h		;7994
	ld d,(hl)			;7996
	call 0437eh		;7997
	jp 04206h		;799a
L_799D:
	di			;799d
	ld a,009h		;799e
	ld (0a000h),a		;79a0
	ld (0f0f3h),a		;79a3
	ei			;79a6
	ld a,(ix+000h)		;79a7
	cp 008h		;79aa
	jr z,L_79BF		;79ac
	cp 021h		;79ae
	jr z,L_79BF		;79b0
	dec a			;79b2
	ld hl,0b86dh		;79b3
	call 04083h		;79b6
	ld e,(hl)			;79b9
	call 05929h		;79ba
	jr L_79C5		;79bd
L_79BF:
	ld de,00050h		;79bf
	call 05958h		;79c2
L_79C5:
	jp 04206h		;79c5
L_79C8:
	call 087b7h		;79c8
	ld de,01000h		;79cb
	call 0437eh		;79ce
	ld a,(0ef80h)		;79d1
	and 002h		;79d4
	jr z,L_79DD		;79d6
	ld e,010h		;79d8
	call 05929h		;79da
L_79DD:
	ld a,012h		;79dd
	jp 04fe4h		;79df
L_79E2:
	ld hl,0c27eh		;79e2
	ld a,(hl)			;79e5
	and a			;79e6
	jr z,L_79F0		;79e7
	xor a			;79e9
	ld (hl),a			;79ea
	ld a,00ah		;79eb
	jp 057fah		;79ed
L_79F0:
	ld de,00020h		;79f0
	jp 05958h		;79f3
L_79F6:
	ld b,004h		;79f6
L_79F8:
	ld hl,0c481h		;79f8
	ld a,(hl)			;79fb
	sub b			;79fc
	jr nc,L_7A00		;79fd
	xor a			;79ff
L_7A00:
	ld (hl),a			;7a00
	jp 05890h		;7a01
L_7A04:
	ld b,002h		;7a04
	jr L_79F8		;7a06
L_7A08:
	ld a,(ix+000h)		;7a08
	ld hl,0c276h		;7a0b
	cp 001h		;7a0e
	jr z,L_7A20		;7a10
	cp 006h		;7a12
	jr z,L_7A20		;7a14
	ld hl,0c273h		;7a16
	cp 005h		;7a19
	jr z,L_7A20		;7a1b
	ld hl,0c274h		;7a1d
L_7A20:
	ld a,(hl)			;7a20
	and a			;7a21
	ret z			;7a22
	dec (hl)			;7a23
	call z,L_7A29		;7a24
	scf			;7a27
	ret			;7a28
L_7A29:
	ld a,l			;7a29
	sub 070h		;7a2a
	jp 057fah		;7a2c
L_7A2F:
	ld a,(ix+000h)		;7a2f
	ld hl,0c275h		;7a32
	cp 003h		;7a35
	jr c,L_7A20		;7a37
	ld hl,0c272h		;7a39
	jr L_7A20		;7a3c
L_7A3E:
	call L_7ACA		;7a3e
	call 0408dh		;7a41

; ----------------------------------------------------------------------
; DATOS tabla_7A44: 5 destinos del despachador de 0x408D (call en p01:7A41):
;   0x7AF5, 0x7AFB, 0x7B01, 0x7B01, 0x7B07; lo leen p01:7A41 (10 bytes)
;   0x7a44..0x7a4e  (10 bytes)
DATA_tabla_7A44:
	defb 0f5h,07ah	; 7a44
	defb 0fbh,07ah	; 7a46
	defb 001h,07bh	; 7a48
	defb 001h,07bh	; 7a4a
	defb 007h,07bh	; 7a4c

; ======================================================================
; CODIGO 0x7a4e..0x7a59  (11 bytes)
; ======================================================================


L_7A4E:
	ld a,001h		;7a4e
	ld (0ee80h),a		;7a50
	call L_7A85		;7a53
	call 0408dh		;7a56

; ----------------------------------------------------------------------
; DATOS tabla_7A59: 4 destinos del despachador de 0x408D (call en p01:7A56):
;   0x7B0D, 0x7B1F, 0x7B25, 0x7B37; lo leen p01:7A56 (8 bytes)
;   0x7a59..0x7a61  (8 bytes)
DATA_tabla_7A59:
	defb 00dh,07bh	; 7a59
	defb 01fh,07bh	; 7a5b
	defb 025h,07bh	; 7a5d
	defb 037h,07bh	; 7a5f

; ======================================================================
; CODIGO 0x7a61..0x7a6b  (10 bytes)
; ======================================================================


L_7A61:
	xor a			;7a61
	ld (0ee80h),a		;7a62
	call L_7A85		;7a65
	call 0408dh		;7a68

; ----------------------------------------------------------------------
; DATOS tabla_7A6B: 4 destinos del despachador de 0x408D (call en p01:7A68):
;   0x7B13, 0x7B13, 0x7B2B, 0x7B3D; lo leen p01:7A68 (8 bytes)
;   0x7a6b..0x7a73  (8 bytes)
DATA_tabla_7A6B:
	defb 013h,07bh	; 7a6b
	defb 013h,07bh	; 7a6d
	defb 02bh,07bh	; 7a6f
	defb 03dh,07bh	; 7a71

; ======================================================================
; CODIGO 0x7a73..0x7a7d  (10 bytes)
; ======================================================================


L_7A73:
	xor a			;7a73
	ld (0ee80h),a		;7a74
	call L_7A85		;7a77
	call 0408dh		;7a7a

; ----------------------------------------------------------------------
; DATOS tabla_7A7D: 4 destinos del despachador de 0x408D (call en p01:7A7A):
;   0x7B19, 0x7B19, 0x7B31, 0x7B43; lo leen p01:7A7A (8 bytes)
;   0x7a7d..0x7a85  (8 bytes)
DATA_tabla_7A7D:
	defb 019h,07bh	; 7a7d
	defb 019h,07bh	; 7a7f
	defb 031h,07bh	; 7a81
	defb 043h,07bh	; 7a83

; ======================================================================
; CODIGO 0x7a85..0x7ae8  (99 bytes)
; ======================================================================


L_7A85:
	di			;7a85
	ld a,009h		;7a86
	ld (0a000h),a		;7a88
	ld (0f0f3h),a		;7a8b
	ei			;7a8e
	ld a,(ix+000h)		;7a8f
	dec a			;7a92
	ld hl,0b88eh		;7a93
	call 04083h		;7a96
	ld a,(hl)			;7a99
	ld h,a			;7a9a
	cp 003h		;7a9b
	ld de,00700h		;7a9d
	jr z,L_7ABB		;7aa0
	ld de,00f00h		;7aa2
	cp 002h		;7aa5
	jr nz,L_7ABB		;7aa7
	ld a,(0ee80h)		;7aa9
	and a			;7aac
	jr z,L_7ABB		;7aad
	ld h,003h		;7aaf
	ld e,008h		;7ab1
	ld a,(ix+00fh)		;7ab3
	and a			;7ab6
	jr z,L_7ABB		;7ab7
	ld e,0f8h		;7ab9
L_7ABB:
	ld a,(ix+005h)		;7abb
	sub e			;7abe
	ld b,a			;7abf
	ld a,(ix+003h)		;7ac0
	sub d			;7ac3
	ld c,a			;7ac4
	ld a,h			;7ac5
	dec a			;7ac6
	jp 04206h		;7ac7
L_7ACA:
	ld a,(ix+000h)		;7aca
	dec a			;7acd
	ld hl,07ae8h		;7ace
	call 04083h		;7ad1
	ld a,(hl)			;7ad4
	dec a			;7ad5
	ld d,a			;7ad6
	ld b,(ix+005h)		;7ad7
	ld hl,07af0h		;7ada
	call 04083h		;7add
	ld c,(hl)			;7ae0
	ld a,(ix+003h)		;7ae1
	sub c			;7ae4
	ld c,a			;7ae5
	ld a,d			;7ae6
	ret			;7ae7

; ----------------------------------------------------------------------
; DATOS caja_por_tipo: un byte por tipo de figura 1-8 (ix+0): la clase de su
;   caja de choque, 1-5, por la que despacha p01:7A41 en la tabla 0x7A44
;   (p01:7ACE) (8 bytes)
;   0x7ae8..0x7af0  (8 bytes)
DATA_caja_por_tipo:
	defb 001h,001h,004h,001h,003h,002h,005h,003h	; 7ae8  ........

; ----------------------------------------------------------------------
; DATOS y_de_la_caja: lo que p01:7ADA resta a la y de la figura (ix+3) en cada
;   clase de caja (5 bytes)
;   0x7af0..0x7af5  (5 bytes)
DATA_y_de_la_caja:
	defb 004h,006h,005h,007h,002h	; 7af0

; ======================================================================
; CODIGO 0x7af5..0x7ba2  (173 bytes)
; ======================================================================


L_7AF5:
	ld hl,00202h		;7af5
	jp L_7B49		;7af8
L_7AFB:
	ld hl,00302h		;7afb
	jp L_7B49		;7afe
L_7B01:
	ld hl,00404h		;7b01
	jp L_7B49		;7b04
L_7B07:
	ld hl,00102h		;7b07
	jp L_7B49		;7b0a
L_7B0D:
	ld hl,00404h		;7b0d
	jp L_7B49		;7b10
L_7B13:
	ld hl,00b04h		;7b13
	jp L_7B67		;7b16
L_7B19:
	ld hl,00b04h		;7b19
	jp L_7BAA		;7b1c
L_7B1F:
	ld hl,0040ch		;7b1f
	jp L_7B49		;7b22
L_7B25:
	ld hl,00404h		;7b25
	jp L_7B49		;7b28
L_7B2B:
	ld hl,00404h		;7b2b
	jp L_7B67		;7b2e
L_7B31:
	ld hl,00404h		;7b31
	jp L_7BAA		;7b34
L_7B37:
	ld hl,00808h		;7b37
	jp L_7B49		;7b3a
L_7B3D:
	ld hl,00808h		;7b3d
	jp L_7B67		;7b40
L_7B43:
	ld hl,00808h		;7b43
	jp L_7BAA		;7b46
L_7B49:
	ld a,004h		;7b49
	add a,l			;7b4b
	ld l,a			;7b4c
	ld a,(0c49ah)		;7b4d
	sub b			;7b50
	jr nc,L_7B55		;7b51
	neg		;7b53
L_7B55:
	cp l			;7b55
	ret nc			;7b56
	ld a,004h		;7b57
	add a,h			;7b59
	ld h,a			;7b5a
	ld a,(0c498h)		;7b5b
	sub 00ch		;7b5e
	sub c			;7b60
	jr nc,L_7B65		;7b61
	neg		;7b63
L_7B65:
	cp h			;7b65
	ret			;7b66
L_7B67:
	push hl			;7b67
	ld a,(0c4a2h)		;7b68
	add a,a			;7b6b
	ld hl,07ba2h		;7b6c
	call 04083h		;7b6f
	ld e,(hl)			;7b72
	inc hl			;7b73
	ld d,(hl)			;7b74
	pop hl			;7b75
	ld a,004h		;7b76
	add a,l			;7b78
	ld l,a			;7b79
	ld a,(0c4a2h)		;7b7a
	cp 002h		;7b7d
	ld a,(0c49ah)		;7b7f
	jr z,L_7B87		;7b82
	add a,e			;7b84
	jr L_7B88		;7b85
L_7B87:
	sub e			;7b87
L_7B88:
	jr nc,L_7B8C		;7b88
	xor a			;7b8a
	ret			;7b8b
L_7B8C:
	sub b			;7b8c
	jr nc,L_7B91		;7b8d
	neg		;7b8f
L_7B91:
	cp l			;7b91
	ret nc			;7b92
	ld a,004h		;7b93
	add a,h			;7b95
	ld h,a			;7b96
	ld a,(0c498h)		;7b97
	add a,d			;7b9a
	sub c			;7b9b
	jr nc,L_7BA0		;7b9c
	neg		;7b9e
L_7BA0:
	cp h			;7ba0
	ret			;7ba1

; ----------------------------------------------------------------------
; DATOS delante_por_lado: cuatro parejas [dx][dy], una por lado al que mira el
;   jugador (0xC4A2): el punto de delante que mira p01:7B67 (8 bytes)
;   0x7ba2..0x7baa  (8 bytes)
DATA_delante_por_lado:
	defb 000h,0e2h	; 7ba2
	defb 000h,0ffh	; 7ba4
	defb 010h,0f0h	; 7ba6
	defb 010h,0f0h	; 7ba8

; ======================================================================
; CODIGO 0x7baa..0x7d98  (494 bytes)
; ======================================================================


L_7BAA:
	ld iy,0c4d0h		;7baa
	push hl			;7bae
	call L_7BBC		;7baf
	pop hl			;7bb2
	ret c			;7bb3
	ld iy,0c4e0h		;7bb4
	call L_7BBC		;7bb8
	ret			;7bbb
L_7BBC:
	ld a,003h		;7bbc
	add a,l			;7bbe
	ld l,a			;7bbf
	ld a,(iy+004h)		;7bc0
	sub b			;7bc3
	jr nc,L_7BC8		;7bc4
	neg		;7bc6
L_7BC8:
	cp l			;7bc8
	ret nc			;7bc9
	ld a,003h		;7bca
	add a,h			;7bcc
	ld h,a			;7bcd
	ld a,(iy+003h)		;7bce
	sub 003h		;7bd1
	sub c			;7bd3
	jr nc,L_7BD8		;7bd4
	neg		;7bd6
L_7BD8:
	cp h			;7bd8
	ret			;7bd9
L_7BDA:
	ld ix,0cc00h		;7bda
	ld b,004h		;7bde
L_7BE0:
	ld a,(ix+000h)		;7be0
	and a			;7be3
	jr z,L_7C1D		;7be4
	cp 008h		;7be6
	jp nc,L_7C9C		;7be8
	ld a,(ix+00ch)		;7beb
	rra			;7bee
	jr c,L_7C02		;7bef
	ld a,(0c490h)		;7bf1
	dec a			;7bf4
	jr nz,L_7C1D		;7bf5
	call L_7D30		;7bf7
	jr nc,L_7C1D		;7bfa
	ld (ix+00dh),001h		;7bfc
	jr L_7C1D		;7c00
L_7C02:
	ld a,(ix+000h)		;7c02
	sub 006h		;7c05
	cp 002h		;7c07
	jr c,L_7C25		;7c09
	push bc			;7c0b
	call L_7D4A		;7c0c
	pop bc			;7c0f
	jr nc,L_7C1D		;7c10
	call L_7D56		;7c12
	call 087b7h		;7c15
	ld a,012h		;7c18
	jp 04fe4h		;7c1a
L_7C1D:
	ld de,00040h		;7c1d
	add ix,de		;7c20
	djnz L_7BE0		;7c22
	ret			;7c24
L_7C25:
	ld a,(0c490h)		;7c25
	and a			;7c28
	jr nz,L_7C1D		;7c29
	ld a,(ix+003h)		;7c2b
	sub 00ch		;7c2e
	ld c,a			;7c30
	ld a,(0c494h)		;7c31
	sub c			;7c34
	cp 008h		;7c35
	jr nc,L_7C1D		;7c37
	ld a,(ix+005h)		;7c39
	sub 004h		;7c3c
	ld c,a			;7c3e
	ld a,(0c496h)		;7c3f
	sub c			;7c42
	cp 008h		;7c43
	jr nc,L_7C1D		;7c45
	xor a			;7c47
	ld (0c492h),a		;7c48
	ld (0c49fh),a		;7c4b
	call L_67B3		;7c4e
	call L_67F4		;7c51
	ld hl,0c4d3h		;7c54
	call L_76AC		;7c57
	ld hl,0c4e3h		;7c5a
	call L_76AC		;7c5d
	call L_67DA		;7c60
	ld a,004h		;7c63
	ld (0c490h),a		;7c65
	ld a,020h		;7c68
	ld (0c4a8h),a		;7c6a
	ld a,(0c494h)		;7c6d
	and 0f0h		;7c70
	add a,008h		;7c72
	ld (0c494h),a		;7c74
	ld (0c498h),a		;7c77
	ld a,(0c496h)		;7c7a
	and 0f0h		;7c7d
	add a,008h		;7c7f
	ld (0c496h),a		;7c81
	ld (0c49ah),a		;7c84
	ld hl,00000h		;7c87
	ld (0c49bh),hl		;7c8a
	ld (0c49dh),hl		;7c8d
	xor a			;7c90
	ld (0c4a7h),a		;7c91
	call L_6F60		;7c94
	ld a,090h		;7c97
	jp 04fe4h		;7c99
L_7C9C:
	ld a,(ix+00ch)		;7c9c
	rra			;7c9f
	jp nc,L_7C1D		;7ca0
	ld a,(0c490h)		;7ca3
	and a			;7ca6
	jp nz,L_7C1D		;7ca7
	ld a,(0c494h)		;7caa
	ld c,a			;7cad
	ld a,(ix+003h)		;7cae
	sub 002h		;7cb1
	sub c			;7cb3
	cp 00ch		;7cb4
	jp nc,L_7C1D		;7cb6
	ld a,(ix+005h)		;7cb9
	sub 006h		;7cbc
	ld c,a			;7cbe
	ld a,(0c496h)		;7cbf
	sub c			;7cc2
	cp 00ch		;7cc3
	jp nc,L_7C1D		;7cc5
	ld (ix+00dh),001h		;7cc8
	ld a,(ix+000h)		;7ccc
	cp 00ah		;7ccf
	ld a,01eh		;7cd1
	jp nz,04fe4h		;7cd3
	ld a,014h		;7cd6
	jp 04fe4h		;7cd8
L_7CDB:
	ld a,(0c492h)		;7cdb
	and a			;7cde
	ret z			;7cdf
	ld ix,0cc00h		;7ce0
	ld b,004h		;7ce4
L_7CE6:
	ld a,(ix+000h)		;7ce6
	cp 00eh		;7ce9
	jr nz,L_7D00		;7ceb
	push bc			;7ced
	ld hl,00a0ah		;7cee
	ld b,(ix+005h)		;7cf1
	ld a,(ix+003h)		;7cf4
	sub 008h		;7cf7
	ld c,a			;7cf9
	call L_7B67		;7cfa
	pop bc			;7cfd
	jr c,L_7D08		;7cfe
L_7D00:
	ld de,00040h		;7d00
	add ix,de		;7d03
	djnz L_7CE6		;7d05
	ret			;7d07
L_7D08:
	ld (ix+00dh),001h		;7d08
	ret			;7d0c
L_7D0D:
	ld a,(0c494h)		;7d0d
	sub 040h		;7d10
	cp 006h		;7d12
	ret nc			;7d14
	ld a,(0c496h)		;7d15
	sub 030h		;7d18
	cp 020h		;7d1a
	ret nc			;7d1c
	ld a,(0c007h)		;7d1d
	rra			;7d20
	ret nc			;7d21
	call L_67DA		;7d22
	call 05b1dh		;7d25
	call 05969h		;7d28
	ld a,088h		;7d2b
	jp 04fe4h		;7d2d
L_7D30:
	ld a,(ix+005h)		;7d30
	sub 010h		;7d33
	ld c,a			;7d35
	ld a,(0c496h)		;7d36
	sub c			;7d39
	cp 020h		;7d3a
	ret nc			;7d3c
	ld a,(ix+003h)		;7d3d
	sub 018h		;7d40
	ld c,a			;7d42
	ld a,(0c494h)		;7d43
	sub c			;7d46
	cp 020h		;7d47
	ret			;7d49
L_7D4A:
	ld b,(ix+005h)		;7d4a
	ld c,(ix+003h)		;7d4d
	ld hl,00808h		;7d50
	jp L_7B49		;7d53
L_7D56:
	ld a,(ix+000h)		;7d56
	dec a			;7d59
	jr z,L_7D71		;7d5a
	dec a			;7d5c
	ret nz			;7d5d
	ld hl,0c270h		;7d5e
	inc (hl)			;7d61
	ld a,(hl)			;7d62
	cp 004h		;7d63
	jr nc,L_7D6B		;7d65
	xor a			;7d67
	jp 057fah		;7d68
L_7D6B:
	dec (hl)			;7d6b
L_7D6C:
	ld e,010h		;7d6c
	jp 05929h		;7d6e
L_7D71:
	ld hl,0c271h		;7d71
	ld a,(hl)			;7d74
	and a			;7d75
	jr nz,L_7D6C		;7d76
	inc (hl)			;7d78
	ld a,001h		;7d79
	jp 057fah		;7d7b
L_7D7E:
	ld a,(ix+000h)		;7d7e
	ld b,a			;7d81
	cp 006h		;7d82
	jr nz,L_7D8C		;7d84
	ld a,(0c278h)		;7d86
	cp 008h		;7d89
	ret z			;7d8b
L_7D8C:
	ld a,b			;7d8c
	dec a			;7d8d
	ld hl,07d98h		;7d8e
	call 04083h		;7d91
	ld a,(hl)			;7d94
	jp 04fe4h		;7d95

; ----------------------------------------------------------------------
; DATOS sonido_por_tipo: el efecto de sonido de cada tipo de figura 1-6
;   (p01:7D8E): 0x11, 0x11, 0x11, 0x10, 0x10 y 0x13 (6 bytes)
;   0x7d98..0x7d9e  (6 bytes)
DATA_sonido_por_tipo:
	defb 011h,011h,011h,010h,010h,013h	; 7d98

; ======================================================================
; CODIGO 0x7d9e..0x7f0e  (368 bytes)
; ======================================================================


L_7D9E:
	di			;7d9e
	ld a,009h		;7d9f
	ld (0a000h),a		;7da1
	ld (0f0f3h),a		;7da4
	ei			;7da7
	call 041f6h		;7da8
	ld hl,0b5d6h		;7dab
	call 04d81h		;7dae
	ld a,(hl)			;7db1
	and a			;7db2
	ret z			;7db3
	ld b,a			;7db4
	inc hl			;7db5
	ld de,0c520h		;7db6
L_7DB9:
	ld c,(hl)			;7db9
	ld a,c			;7dba
	exx			;7dbb
	and 07fh		;7dbc
	ld b,a			;7dbe
	ld a,(0c281h)		;7dbf
	cp b			;7dc2
	exx			;7dc3
	jr z,L_7DDA		;7dc4
	inc hl			;7dc6
	inc hl			;7dc7
	djnz L_7DB9		;7dc8
	ld hl,0c520h		;7dca
	ld de,0c521h		;7dcd
	ld (hl),000h		;7dd0
	ld bc,0000fh		;7dd2
	ldir		;7dd5
	jp 04206h		;7dd7
L_7DDA:
	rl c		;7dda
	ld a,001h		;7ddc
	jr nc,L_7DE1		;7dde
	inc a			;7de0
L_7DE1:
	ld (de),a			;7de1
	inc de			;7de2
	inc hl			;7de3
	ld a,(hl)			;7de4
	ld (de),a			;7de5
	jp 04206h		;7de6
L_7DE9:
	di			;7de9
	ld a,00eh		;7dea
	ld (0a000h),a		;7dec
	ld (0f0f3h),a		;7def
	ei			;7df2
	call L_7E34		;7df3
	ld a,(0c280h)		;7df6
	add a,a			;7df9
	ld hl,0981dh		;7dfa
	call 04d81h		;7dfd
	ld b,(hl)			;7e00
	inc hl			;7e01
	ld de,0c500h		;7e02
L_7E05:
	ld a,(0c281h)		;7e05
	cp (hl)			;7e08
	jr nz,L_7E2C		;7e09
	push hl			;7e0b
	inc hl			;7e0c
	ld a,(hl)			;7e0d
	ld (de),a			;7e0e
	ld c,000h		;7e0f
	push de			;7e11
	inc hl			;7e12
	inc e			;7e13
	ld a,(hl)			;7e14
	and 0f0h		;7e15
	ld (de),a			;7e17
	inc e			;7e18
	ld a,(hl)			;7e19
	rla			;7e1a
	rla			;7e1b
	rla			;7e1c
	rla			;7e1d
	and 0f0h		;7e1e
	ld (de),a			;7e20
	inc e			;7e21
	inc hl			;7e22
	ld a,(hl)			;7e23
	ld (de),a			;7e24
	pop de			;7e25
	ld hl,00010h		;7e26
	add hl,de			;7e29
	ex de,hl			;7e2a
	pop hl			;7e2b
L_7E2C:
	inc hl			;7e2c
	inc hl			;7e2d
	inc hl			;7e2e
	djnz L_7E05		;7e2f
	jp 04206h		;7e31
L_7E34:
	ld hl,0c500h		;7e34
	ld de,0c501h		;7e37
	ld (hl),000h		;7e3a
	ld bc,0002fh		;7e3c
	ldir		;7e3f
	ret			;7e41
L_7E42:
	di			;7e42
	ld a,00eh		;7e43
	ld (08000h),a		;7e45
	ld (0f0f2h),a		;7e48
	ei			;7e4b
	ld a,(0c288h)		;7e4c
	ld b,a			;7e4f
	add a,a			;7e50
	add a,a			;7e51
	add a,a			;7e52
	sub b			;7e53
	ld b,a			;7e54
	ld a,(0c280h)		;7e55
	add a,b			;7e58
	ld de,0981dh		;7e59
	call 0447ch		;7e5c
	ld hl,0c340h		;7e5f
	ld a,(de)			;7e62
	inc de			;7e63
	ld b,a			;7e64
	ld c,000h		;7e65
L_7E67:
	inc de			;7e67
	ld a,(de)			;7e68
	and 07fh		;7e69
	cp 014h		;7e6b
	call z,L_7E8C		;7e6d
	inc de			;7e70
	djnz L_7E67		;7e71
	ld a,c			;7e73
	ld (0c28dh),a		;7e74
	or a			;7e77
	jp z,04206h		;7e78
	ld a,r		;7e7b
	dec c			;7e7d
	and c			;7e7e
	add a,a			;7e7f
	ld hl,0c341h		;7e80
	call 04083h		;7e83
	ld a,080h		;7e86
	ld (hl),a			;7e88
	jp 04206h		;7e89
L_7E8C:
	dec de			;7e8c
	ld a,(de)			;7e8d
	ld (hl),a			;7e8e
	inc de			;7e8f
	inc hl			;7e90
	ld a,b			;7e91
	and 003h		;7e92
	ld a,080h		;7e94
	jr z,L_7E99		;7e96
	xor a			;7e98
L_7E99:
	inc c			;7e99
	ld (hl),a			;7e9a
	inc hl			;7e9b
	ret			;7e9c
L_7E9D:
	ld hl,0c341h		;7e9d
	ld b,010h		;7ea0
L_7EA2:
	ld a,(hl)			;7ea2
	and 080h		;7ea3
	ld (hl),a			;7ea5
	inc hl			;7ea6
	inc hl			;7ea7
	djnz L_7EA2		;7ea8
	ret			;7eaa
L_7EAB:
	ld bc,00400h		;7eab
	ld hl,0fcc1h		;7eae
L_7EB1:
	push bc			;7eb1
	push hl			;7eb2
	ld a,(hl)			;7eb3
	bit 7,a		;7eb4
	jr nz,L_7ECC		;7eb6
	call L_7EE5		;7eb8
L_7EBB:
	pop hl			;7ebb
	pop bc			;7ebc
	jr c,L_7EC6		;7ebd
	inc hl			;7ebf
	inc c			;7ec0
	djnz L_7EB1		;7ec1
	xor a			;7ec3
	jr L_7EC8		;7ec4
L_7EC6:
	ld a,0ffh		;7ec6
L_7EC8:
	ld (0ef00h),a		;7ec8
	ret			;7ecb
L_7ECC:
	call L_7ED1		;7ecc
	jr L_7EBB		;7ecf
L_7ED1:
	and 080h		;7ed1
	or c			;7ed3
	ld c,a			;7ed4
	ld b,004h		;7ed5
L_7ED7:
	push bc			;7ed7
	call L_7EE5		;7ed8
	pop bc			;7edb
	ret c			;7edc
	ld a,c			;7edd
	add a,004h		;7ede
	ld c,a			;7ee0
	djnz L_7ED7		;7ee1
	and a			;7ee3
	ret			;7ee4
L_7EE5:
	ld de,07f14h		;7ee5
	ld hl,0bffah		;7ee8
	ld b,006h		;7eeb
	call L_7EF9		;7eed
	ret c			;7ef0
	ld de,07f0eh		;7ef1
	ld hl,07ffah		;7ef4
	ld b,006h		;7ef7
L_7EF9:
	push bc			;7ef9
	push de			;7efa
	ld a,c			;7efb
	call 0000ch		;7efc   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;7eff
	pop bc			;7f00
	ex de,hl			;7f01
	cp (hl)			;7f02
	ex de,hl			;7f03
	jr nz,L_7F0C		;7f04
	inc hl			;7f06
	inc de			;7f07
	djnz L_7EF9		;7f08
	scf			;7f0a
	ret			;7f0b
L_7F0C:
	and a			;7f0c
	ret			;7f0d

; ----------------------------------------------------------------------
; DATOS marca_del_game_master: los seis ultimos bytes del Konami Game Master
;   (RC-735, 0x7FFA de su ranura): p01:7EF1 los busca en las otras ranuras con
;   RDSLT (6 bytes)
;   0x7f0e..0x7f14  (6 bytes)
DATA_marca_del_game_master:
	defb 000h,030h,031h,013h,035h,0aah	; 7f0e

; ----------------------------------------------------------------------
; DATOS marca_de_qbert: los seis ultimos bytes de Q*bert (RC-746, 0xBFFA de su
;   ranura), que p01:7EE5 busca igual; si sale una de las dos, p01:7EC6 pone
;   0xEF00 a 0xFF (6 bytes)
;   0x7f14..0x7f1a  (6 bytes)
DATA_marca_de_qbert:
	defb 0bah,0b2h,086h,007h,046h,0aah	; 7f14

; ======================================================================
; CODIGO 0x7f1a..0x7f41  (39 bytes)
; ======================================================================


L_7F1A:
	call L_7F28		;7f1a
	ld c,00eh		;7f1d
	call 04704h		;7f1f
	ld hl,07f41h		;7f22
	jp 048f3h		;7f25
L_7F28:
	ld hl,02090h		;7f28
	ld bc,0c038h		;7f2b
L_7F2E:
	xor a			;7f2e
	ld d,000h		;7f2f
	push bc			;7f31
	push hl			;7f32
	call 04732h		;7f33
	pop hl			;7f36
	pop de			;7f37
	ret			;7f38
L_7F39:
	call L_7F2E		;7f39
	ld c,00eh		;7f3c
	jp 04704h		;7f3e

; ----------------------------------------------------------------------
; DATOS rotulo_7F41: rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p01:7F25 (66 bytes)
;   0x7f41..0x7f83  (66 bytes)
DATA_rotulo_7F41:
	defb 058h,098h,066h,066h,066h,03dh,05dh,03fh,037h,066h,066h,066h,0feh,024h,0a8h,0bch	; 7f41  X.fff=]?7fff.$..
	defb 0bdh,0feh,040h,0a8h,055h,044h,034h,03bh,000h,049h,03bh,063h,051h,058h,0feh,040h	; 7f51  ..@.UD4;.I;cQX.@
	defb 0b0h,037h,045h,048h,000h,049h,063h,05dh,039h,063h,032h,05ch,000h,035h,033h,058h	; 7f61  .7EH.Ic]9c2\.53X
	defb 0feh,040h,0b8h,039h,063h,033h,052h,05dh,048h,035h,03ch,063h,05ch,000h,035h,033h	; 7f71  .@.9c3R]H5<c\.53
	defb 058h,0ffh	; 7f81

; ======================================================================
; CODIGO 0x7f83..0x7f94  (17 bytes)
; ======================================================================


L_7F83:
	ld hl,07f94h		;7f83
	call L_7FB1		;7f86
	ld hl,0ef05h		;7f89
	ld de,0b0a8h		;7f8c
L_7F8F:
	ld b,001h		;7f8f
	jp 04420h		;7f91

; ----------------------------------------------------------------------
; DATOS rotulo_7F94: rotulo en (0x48, 0xA8) que p01:7F83 escribe con 0x48F3
;   (p01:7FB1) (15 bytes)
;   0x7f94..0x7fa3  (15 bytes)
DATA_rotulo_7F94:
	defb 048h,0a8h,037h,045h,048h,049h,063h,05dh,039h,063h,032h,049h,000h,067h,0ffh	; 7f94  H.7EHIc]9c2I.g.

; ======================================================================
; CODIGO 0x7fa3..0x7fb9  (22 bytes)
; ======================================================================


L_7FA3:
	ld hl,07fb9h		;7fa3
	call L_7FB1		;7fa6
	ld hl,0ef07h		;7fa9
	ld de,0b8a8h		;7fac
	jr $-32		;7faf
L_7FB1:
	push hl			;7fb1
	call L_7FC8		;7fb2
	pop hl			;7fb5
	jp 048f3h		;7fb6

; ----------------------------------------------------------------------
; DATOS rotulo_7FB9: rotulo en (0x48, 0xA8) que p01:7FA3 escribe con 0x48F3
;   (p01:7FB1) (15 bytes)
;   0x7fb9..0x7fc8  (15 bytes)
DATA_rotulo_7FB9:
	defb 048h,0a8h,039h,063h,033h,052h,05dh,048h,035h,03ch,063h,049h,000h,067h,0ffh	; 7fb9  H.9c3R]H5<cI.g.

; ======================================================================
; CODIGO 0x7fc8..0x8000  (56 bytes)
; ======================================================================


L_7FC8:
	ld hl,024a0h		;7fc8
	ld bc,0b820h		;7fcb
	jp L_7F2E		;7fce
L_7FD1:
	call 08006h		;7fd1
	ret z			;7fd4
	ld hl,(0ef08h)		;7fd5
	ld d,000h		;7fd8
	ld b,008h		;7fda
	ld a,l			;7fdc
	call 08000h		;7fdd
	jr c,L_7FE9		;7fe0
	ld a,h			;7fe2
	ld b,002h		;7fe3
	call 08000h		;7fe5
	ret nc			;7fe8
L_7FE9:
	ld hl,0ef15h		;7fe9
	ld (hl),0ffh		;7fec
	ld hl,0ef0fh		;7fee
	ld a,d			;7ff1
	rld		;7ff2
	ld de,(0ef02h)		;7ff4
	ld b,001h		;7ff8
	call 04420h		;7ffa
	jp 08027h		;7ffd
