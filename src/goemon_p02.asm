; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX1 - MegaROM RC-748 de 128 KB (Konami4) - banco 02 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l906ch:	equ 0x0906c

; ======================================================================
; CODIGO 0x8000..0x80d6  (214 bytes)
; ======================================================================


L_8000:
	rra			;8000
	ret c			;8001
	inc d			;8002
	djnz L_8000		;8003
	ret			;8005
L_8006:
	xor a			;8006
	call 00141h		;8007   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;800a
	ld d,a			;800b
	ld a,001h		;800c
	call 00141h		;800e   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8011
	and 003h		;8012
	ld e,a			;8014
	ld a,d			;8015
	ld hl,0ef08h		;8016
	ld c,(hl)			;8019
	ld (hl),a			;801a
	xor c			;801b
	and (hl)			;801c
	ld d,a			;801d
	ld a,e			;801e
	inc hl			;801f
	ld c,(hl)			;8020
	ld (hl),a			;8021
	xor c			;8022
	and (hl)			;8023
	ld e,a			;8024
	or d			;8025
	ret			;8026
L_8027:
	ld hl,0ef0fh		;8027
	ld a,(hl)			;802a
	ld c,a			;802b
	rrca			;802c
	rrca			;802d
	rrca			;802e
	rrca			;802f
	and 00fh		;8030
	add a,a			;8032
	ld b,a			;8033
	add a,a			;8034
	add a,a			;8035
	add a,b			;8036
	ld b,a			;8037
	ld a,c			;8038
	and 00fh		;8039
	add a,b			;803b
	ld (0ef0eh),a		;803c
	ret			;803f
L_8040:
	ld a,007h		;8040
	call 00141h		;8042   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8045
	and 080h		;8046
	ld hl,0ef0ah		;8048
	ld c,(hl)			;804b
	ld (hl),a			;804c
	xor c			;804d
	and (hl)			;804e
	ret			;804f
L_8050:
	push af			;8050
	call L_8071		;8051
	pop af			;8054
	ld b,a			;8055
	ld a,(0c002h)		;8056
	and 020h		;8059
	ret z			;805b
	push bc			;805c
	call L_8065		;805d
	pop bc			;8060
	ld a,b			;8061
	call L_8071		;8062
L_8065:
	ld hl,0c260h		;8065
	ld de,0c360h		;8068
	ld bc,00100h		;806b
	jp 04449h		;806e
L_8071:
	rra			;8071
	push af			;8072
	jr nc,L_808C		;8073
	ld a,(0ef06h)		;8075
	dec a			;8078
	cp 007h		;8079
	jr c,L_807E		;807b
	xor a			;807d
L_807E:
	ld (0c280h),a		;807e
	ld a,(0ef05h)		;8081
	cp 008h		;8084
	jr c,L_8089		;8086
	xor a			;8088
L_8089:
	ld (0c261h),a		;8089
L_808C:
	pop af			;808c
	rra			;808d
	ret nc			;808e
	ld a,(0ef07h)		;808f
	ld (0c260h),a		;8092
	ret			;8095
L_8096:
	rra			;8096
	ld a,001h		;8097
	jr nc,L_809D		;8099
	ld a,0ffh		;809b
L_809D:
	ld b,a			;809d
	ld hl,0ef0bh		;809e
	add a,(hl)			;80a1
	and 003h		;80a2
	cp 003h		;80a4
	jr nz,L_80AF		;80a6
	ld a,b			;80a8
	add a,a			;80a9
	ld a,002h		;80aa
	jr c,L_80AF		;80ac
	xor a			;80ae
L_80AF:
	push af			;80af
	push hl			;80b0
	ld a,(hl)			;80b1
	call L_80BB		;80b2
	pop hl			;80b5
	pop af			;80b6
	ld (hl),a			;80b7
	jp L_80C0		;80b8
L_80BB:
	ld bc,00000h		;80bb
	jr L_80C3		;80be
L_80C0:
	ld bc,0bcbdh		;80c0
L_80C3:
	ld hl,080d6h		;80c3
	call 04083h		;80c6
	ld e,(hl)			;80c9
	ld d,024h		;80ca
	ld a,b			;80cc
	call 0491ch		;80cd
	ld d,02ch		;80d0
	ld a,c			;80d2
	jp 0491ch		;80d3

; ----------------------------------------------------------------------
; DATOS sin identificar  0x80d6..0x80d9  (3 bytes)
DATA_80D6:
	defb 0a8h,0b0h,0b8h	; 80d6

; ======================================================================
; CODIGO 0x80d9..0x8177  (158 bytes)
; ======================================================================


L_80D9:
	ld a,001h		;80d9
	ld (0cd15h),a		;80db
	call L_80EE		;80de
	call L_8123		;80e1
	call L_813F		;80e4
	call L_81F0		;80e7
	call 05b61h		;80ea
	ret			;80ed
L_80EE:
	ld hl,0a099h		;80ee
	ld de,00010h		;80f1
	ld b,003h		;80f4
L_80F6:
	push bc			;80f6
	ld b,01ch		;80f7
L_80F9:
	ld a,(hl)			;80f9
	inc hl			;80fa
	push de			;80fb
	exx			;80fc
	pop de			;80fd
	ld l,a			;80fe
	ld h,000h		;80ff
	add hl,hl			;8101
	add hl,hl			;8102
	add hl,hl			;8103
	ld a,h			;8104
	add a,a			;8105
	add a,a			;8106
	add a,a			;8107
	ld h,l			;8108
	ld l,a			;8109
	ld a,005h		;810a
	ld bc,00808h		;810c
	call 0476eh		;810f
	exx			;8112
	ld a,008h		;8113
	add a,d			;8115
	ld d,a			;8116
	djnz L_80F9		;8117
	ld d,000h		;8119
	ld a,008h		;811b
	add a,e			;811d
	ld e,a			;811e
	pop bc			;811f
	djnz L_80F6		;8120
	ret			;8122
L_8123:
	ld a,00ch		;8123
	call 04280h		;8125
	ld hl,07040h		;8128
	ld de,01f4fh		;812b
	ld c,00fh		;812e
	call 04704h		;8130
	ld hl,07242h		;8133
	ld de,01b4bh		;8136
	ld c,00fh		;8139
	call 04704h		;813b
	ret			;813e
L_813F:
	call L_81D0		;813f
	call L_8192		;8142
	ld a,(0c288h)		;8145
	ld b,a			;8148
	add a,a			;8149
	add a,b			;814a
	ld de,0817dh		;814b
	call 04088h		;814e
	exx			;8151
	ld hl,08177h		;8152
	exx			;8155
	ld hl,0ee08h		;8156
	ld b,003h		;8159
L_815B:
	exx			;815b
	ld a,(hl)			;815c
	inc hl			;815d
	exx			;815e
	ld (hl),a			;815f
	inc hl			;8160
	exx			;8161
	ld a,(hl)			;8162
	inc hl			;8163
	exx			;8164
	ld (hl),a			;8165
	inc hl			;8166
	ld a,(de)			;8167
	inc de			;8168
	cp 0ffh		;8169
	jr z,L_8173		;816b
	ld (hl),a			;816d
	inc hl			;816e
	inc hl			;816f
L_8170:
	djnz L_815B		;8170
	ret			;8172
L_8173:
	dec hl			;8173
	dec hl			;8174
	jr L_8170		;8175

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8177..0x8192  (27 bytes)
DATA_8177:
	defb 048h,078h,060h,078h,078h,078h,000h,004h,034h,008h,00ch,034h,010h,014h,034h,018h	; 8177  Hx`xxx..4..4..4.
	defb 01ch,034h,020h,024h,034h,028h,02ch,034h,01ch,0ffh,030h	; 8187  .4 $4(,4..0

; ======================================================================
; CODIGO 0x8192..0x81c2  (48 bytes)
; ======================================================================


L_8192:
	ld a,(0c280h)		;8192
	add a,a			;8195
	ld hl,081c2h		;8196
	call 04083h		;8199
	ld b,002h		;819c
	ld de,0ee00h		;819e
L_81A1:
	ld a,(hl)			;81a1
	ld (0cd0eh),a		;81a2
	ld (de),a			;81a5
	inc hl			;81a6
	inc de			;81a7
	ld a,(hl)			;81a8
	ld (de),a			;81a9
	inc hl			;81aa
	inc de			;81ab
	ld a,(0c002h)		;81ac
	rla			;81af
	ld a,034h		;81b0
	jr nc,L_81B6		;81b2
	ld a,03ch		;81b4
L_81B6:
	add a,b			;81b6
	add a,b			;81b7
	add a,b			;81b8
	add a,b			;81b9
	ld (de),a			;81ba
	inc de			;81bb
	inc de			;81bc
	dec hl			;81bd
	dec hl			;81be
	djnz L_81A1		;81bf
	ret			;81c1

; ----------------------------------------------------------------------
; DATOS sin identificar  0x81c2..0x81d0  (14 bytes)
DATA_81C2:
	defb 040h,020h,078h,020h,0a8h,070h,078h,0b8h,040h,0b8h,010h,090h,008h,050h	; 81c2  @ x .px.@....P

; ======================================================================
; CODIGO 0x81d0..0x8294  (196 bytes)
; ======================================================================


L_81D0:
	ld hl,0ec00h		;81d0
	ld a,002h		;81d3
	ld b,010h		;81d5
	call L_81EB		;81d7
	ld hl,0ec10h		;81da
	ld a,041h		;81dd
	ld b,010h		;81df
	call L_81EB		;81e1
	ld hl,0ec20h		;81e4
	ld a,00eh		;81e7
	ld b,030h		;81e9
L_81EB:
	ld (hl),a			;81eb
	inc hl			;81ec
	djnz L_81EB		;81ed
	ret			;81ef
L_81F0:
	di			;81f0
	ld a,009h		;81f1
	ld (0a000h),a		;81f3
	ld (0f0f3h),a		;81f6
	ei			;81f9
	ld a,(0c288h)		;81fa
	ld de,0b8ech		;81fd
	ld b,a			;8200
	add a,a			;8201
	add a,a			;8202
	add a,a			;8203
	sub b			;8204
	call 04088h		;8205
	ld b,007h		;8208
	ld hl,081c2h		;820a
L_820D:
	ld a,(de)			;820d
	inc de			;820e
	push hl			;820f
	exx			;8210
	pop hl			;8211
	ld c,(hl)			;8212
	inc hl			;8213
	ld h,(hl)			;8214
	ld l,c			;8215
	call L_822A		;8216
	exx			;8219
	inc hl			;821a
	inc hl			;821b
	djnz L_820D		;821c
	ld de,05020h		;821e
	ld hl,0c010h		;8221
	call L_8233		;8224
	jp 04206h		;8227
L_822A:
	ex de,hl			;822a
	add a,a			;822b
	add a,a			;822c
	add a,a			;822d
	add a,a			;822e
	add a,a			;822f
	ld h,a			;8230
	ld l,010h		;8231
L_8233:
	ld a,001h		;8233
	ld bc,02018h		;8235
	jp 0476eh		;8238
L_823B:
	ld a,(0c003h)		;823b
	ld b,a			;823e
	and 007h		;823f
	ret nz			;8241
	ld a,b			;8242
	and 008h		;8243
	ld a,(0cd0eh)		;8245
	jr z,L_824C		;8248
	ld a,0e0h		;824a
L_824C:
	ld (0ee00h),a		;824c
	ld (0ee04h),a		;824f
	jp 05b61h		;8252
L_8255:
	ld a,(0c490h)		;8255
	cp 002h		;8258
	ret nc			;825a
	ld a,(0c483h)		;825b
	or a			;825e
	ret nz			;825f
	ld a,(0c482h)		;8260
	or a			;8263
	ret nz			;8264
	ld a,(0cd11h)		;8265
	or a			;8268
	ret nz			;8269
	call L_861F		;826a
	call L_8302		;826d
	ld hl,0cd16h		;8270
	dec (hl)			;8273
	ret nz			;8274
	call L_82F2		;8275
	call 05b6dh		;8278
	ld hl,0cd17h		;827b
	ld c,(hl)			;827e
	ld a,(de)			;827f
	inc de			;8280
	inc de			;8281
	cp c			;8282
	jr nz,L_8289		;8283
	xor a			;8285
	ld (hl),a			;8286
	ld c,000h		;8287
L_8289:
	inc (hl)			;8289
	ld l,c			;828a
	ld h,000h		;828b
	add hl,de			;828d
	ld a,(hl)			;828e
L_828F:
	ld b,a			;828f
	dec a			;8290
	call 0408dh		;8291

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8294..0x82f2  (94 bytes)
DATA_8294:
	defb 034h,083h,034h,083h,04eh,0a1h,060h,0a3h,034h,083h,034h,083h,0c9h,0b5h,034h,083h	; 8294  4.4.N.`.4.4...4.
	defb 034h,083h,034h,083h,034h,083h,034h,083h,0c9h,0b5h,034h,083h,034h,083h,034h,083h	; 82a4  4.4.4.4...4.4.4.
	defb 034h,083h,0d7h,09ch,034h,083h,034h,083h,034h,083h,034h,083h,034h,083h,034h,083h	; 82b4  4...4.4.4.4.4.4.
	defb 034h,083h,034h,083h,034h,083h,034h,083h,0ddh,09bh,034h,083h,034h,083h,034h,083h	; 82c4  4.4.4.4...4.4.4.
	defb 034h,083h,0d6h,0ach,0deh,0ach,066h,0b1h,031h,0adh,080h,0b0h,008h,0afh,0f2h,0b0h	; 82d4  4.....f.1.......
	defb 09ah,0b2h,0a2h,0b2h,049h,0b5h,047h,0b3h,04ch,096h,00ah,097h,087h,0b6h	; 82e4  ....I.G.L.....

; ======================================================================
; CODIGO 0x82f2..0x8427  (309 bytes)
; ======================================================================


L_82F2:
	ld a,(0cd12h)		;82f2
	and 00ch		;82f5
	add a,a			;82f7
	add a,a			;82f8
	add a,a			;82f9
	ld c,a			;82fa
	ld a,0e0h		;82fb
	sub c			;82fd
	ld (0cd16h),a		;82fe
	ret			;8301
L_8302:
	ld hl,0c600h		;8302
	ld de,00080h		;8305
	ld b,008h		;8308
	ld c,000h		;830a
L_830C:
	ld a,(hl)			;830c
	or a			;830d
	jr z,L_8311		;830e
	inc c			;8310
L_8311:
	add hl,de			;8311
	djnz L_830C		;8312
	ld a,c			;8314
	or a			;8315
	jr nz,L_8324		;8316
	ld a,(0cd16h)		;8318
	cp 012h		;831b
	ret c			;831d
	ld a,010h		;831e
	ld (0cd16h),a		;8320
	ret			;8323
L_8324:
	ld a,(0cd12h)		;8324
	and 00ch		;8327
	rra			;8329
	rra			;832a
	add a,003h		;832b
	cp c			;832d
	ret nc			;832e
	ld hl,0cd16h		;832f
	inc (hl)			;8332
	ret			;8333
L_8334:
	ld a,b			;8334
	ld (0cd39h),a		;8335
	ld (0cd3ah),de		;8338
	ld hl,0c600h		;833c
	ld b,008h		;833f
	xor a			;8341
	ld de,00080h		;8342
L_8345:
	cp (hl)			;8345
	jr z,L_834C		;8346
	add hl,de			;8348
	djnz L_8345		;8349
	ret			;834b
L_834C:
	push hl			;834c
	pop ix		;834d
	ld (0cd3ch),hl		;834f
	ld a,(0cd39h)		;8352
	ld hl,084afh		;8355
	call 04083h		;8358
	ld a,(hl)			;835b
	ld (ix+020h),a		;835c
	ld c,a			;835f
	and a			;8360
	jp z,L_83E6		;8361
	ld de,00000h		;8364
	ld hl,0ee20h		;8367
	ld b,00ch		;836a
L_836C:
	ld a,(hl)			;836c
	cp 0e0h		;836d
	jr nz,L_8391		;836f
	ld (hl),0e1h		;8371
	call L_84A0		;8373
	inc e			;8376
	inc d			;8377
	ld a,004h		;8378
	call 04083h		;837a
	ld (hl),0e1h		;837d
	call L_84A0		;837f
	inc e			;8382
	inc d			;8383
	ld a,004h		;8384
	call 04083h		;8386
	dec c			;8389
	jr z,L_83E6		;838a
	dec c			;838c
	jr z,L_83E6		;838d
	jr L_839B		;838f
L_8391:
	inc d			;8391
	inc d			;8392
	inc hl			;8393
	inc hl			;8394
	inc hl			;8395
	inc hl			;8396
	inc hl			;8397
	inc hl			;8398
	inc hl			;8399
	inc hl			;839a
L_839B:
	djnz L_836C		;839b
	ld a,(ix+020h)		;839d
	sub c			;83a0
	ret z			;83a1
	ld hl,(0cd3ch)		;83a2
	ld de,00005h		;83a5
	ld b,a			;83a8
	ld a,021h		;83a9
	call 04083h		;83ab
L_83AE:
	ld a,(hl)			;83ae
	push hl			;83af
	ld hl,0ee20h		;83b0
	add a,a			;83b3
	add a,a			;83b4
	call 04083h		;83b5
	ld a,0e0h		;83b8
	ld (hl),a			;83ba
	pop hl			;83bb
	add hl,de			;83bc
	djnz L_83AE		;83bd
	ld a,(0cd39h)		;83bf
	cp 007h		;83c2
	ret nz			;83c4
	xor a			;83c5
	ld (0cd14h),a		;83c6
	ld (0cd31h),a		;83c9
	ld a,010h		;83cc
	ld (0cd30h),a		;83ce
	ret			;83d1
L_83D2:
	push hl			;83d2
	push bc			;83d3
	push de			;83d4
	ld hl,(0cd3ch)		;83d5
	ld d,h			;83d8
	ld e,l			;83d9
	inc de			;83da
	ld bc,0001fh		;83db
	xor a			;83de
	ld (hl),a			;83df
	ldir		;83e0
	pop de			;83e2
	pop bc			;83e3
	pop hl			;83e4
	ret			;83e5
L_83E6:
	call L_83D2		;83e6
	ld hl,(0cd3ch)		;83e9
	ld a,(0cd39h)		;83ec
	ld (hl),a			;83ef
	inc l			;83f0
	ld (hl),000h		;83f1
	ld de,(0cd3ah)		;83f3
	inc l			;83f7
	ld (hl),000h		;83f8
	inc l			;83fa
	ld (hl),e			;83fb
	inc l			;83fc
	ld (hl),000h		;83fd
	inc l			;83ff
	ld (hl),d			;8400
	inc l			;8401
	ld (hl),000h		;8402
	ld (ix+00ch),003h		;8404
	ld de,084ddh		;8408
	call L_8485		;840b
	ld hl,(0cd3ch)		;840e
	ld a,(ix+000h)		;8411
	ld (0cd37h),a		;8414
	call 054e6h		;8417
	call 0aa04h		;841a
	ld hl,(0cd3ch)		;841d
	ld a,(ix+000h)		;8420
	dec a			;8423
	call 0408dh		;8424

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8427..0x8485  (94 bytes)
DATA_8427:
	defb 0edh,0a0h,096h,0a2h,051h,0a1h,068h,0a3h,0f9h,0a3h,09eh,0a4h,0ech,0b5h,0d3h,0a4h	; 8427  ....Q.h.........
	defb 047h,0a7h,0d5h,0aah,0d3h,0abh,0d3h,0abh,0ech,0b5h,047h,0a7h,047h,0a7h,0d3h,0a4h	; 8437  G.........G.G...
	defb 047h,0a7h,0e9h,09ch,0d3h,0a4h,0d3h,0a4h,047h,0a7h,047h,0a7h,047h,0a7h,047h,0a7h	; 8447  G.......G.G.G.G.
	defb 047h,0a7h,047h,0a7h,0d3h,0a4h,0d3h,0a4h,0e3h,09bh,0d3h,0a4h,047h,0a7h,047h,0a7h	; 8457  G.G.........G.G.
	defb 0d3h,0a4h,0e6h,0ach,0e6h,0ach,06ch,0b1h,039h,0adh,086h,0b0h,010h,0afh,0fah,0b0h	; 8467  ......l.9.......
	defb 0aah,0b2h,0aah,0b2h,051h,0b5h,04fh,0b3h,053h,096h,012h,097h,08dh,0b6h	; 8477  ....Q.O.S.....

; ======================================================================
; CODIGO 0x8485..0x84b0  (43 bytes)
; ======================================================================


L_8485:
	ld a,(ix+020h)		;8485
	and a			;8488
	ret z			;8489
	ld a,(ix+000h)		;848a
	call 0447ch		;848d
	ld hl,(0cd3ch)		;8490
	set 5,l		;8493
	ld b,(hl)			;8495
L_8496:
	ld a,l			;8496
	add a,005h		;8497
	ld l,a			;8499
	ld a,(de)			;849a
	inc de			;849b
	ld (hl),a			;849c
	djnz L_8496		;849d
	ret			;849f
L_84A0:
	push hl			;84a0
	ld hl,(0cd3ch)		;84a1
	ld a,e			;84a4
	add a,a			;84a5
	add a,a			;84a6
	add a,e			;84a7
	add a,021h		;84a8
	call 04083h		;84aa
	ld (hl),d			;84ad
	pop hl			;84ae
	ret			;84af

; ----------------------------------------------------------------------
; DATOS sin identificar  0x84b0..0x8573  (195 bytes)
DATA_84B0:
	defb 002h,002h,008h,002h,004h,004h,002h,004h,004h,004h,004h,004h,006h,006h,002h,004h	; 84b0  ................
	defb 004h,004h,004h,006h,006h,006h,004h,004h,006h,006h,002h,002h,008h,006h,006h,006h	; 84c0  ................
	defb 004h,004h,004h,004h,001h,001h,001h,004h,002h,002h,002h,002h,008h,002h,004h,03dh	; 84d0  ...............=
	defb 085h,047h,085h,03dh,085h,03dh,085h,03dh,085h,047h,085h,04dh,085h,03dh,085h,03dh	; 84e0  .G.=.=.=.G.M.=.=
	defb 085h,03dh,085h,04dh,085h,04dh,085h,03dh,085h,03dh,085h,03dh,085h,04dh,085h,03dh	; 84f0  .=.M.M.=.=.=.M.=
	defb 085h,061h,085h,04dh,085h,04fh,085h,04dh,085h,04fh,085h,04dh,085h,04dh,085h,041h	; 8500  .a.M.O.M.O.M.M.A
	defb 085h,05bh,085h,04dh,085h,03dh,085h,04bh,085h,04dh,085h,061h,085h,061h,085h,03dh	; 8510  .[.M.=.K.M.a.a.=
	defb 085h,04dh,085h,03dh,085h,061h,085h,068h,085h,067h,085h,068h,085h,04dh,085h,067h	; 8520  .M.=.a.h.g.h.M.g
	defb 085h,067h,085h,055h,085h,03dh,085h,069h,085h,071h,085h,061h,085h,001h,042h,001h	; 8530  .g.U.=.i.q.a..B.
	defb 042h,001h,042h,001h,042h,002h,00eh,002h,045h,002h,045h,001h,002h,002h,044h,002h	; 8540  B.B.B...E.E...D.
	defb 044h,002h,044h,002h,00eh,001h,042h,004h,046h,004h,004h,001h,042h,001h,042h,002h	; 8550  D.D...B.F...B.B.
	defb 04ch,001h,042h,002h,044h,001h,042h,003h,00eh,001h,042h,001h,042h,007h,001h,042h	; 8560  L.B.D.B...B.B..B
	defb 007h,002h,008h	; 8570

; ======================================================================
; CODIGO 0x8573..0x871c  (425 bytes)
; ======================================================================


L_8573:
	ld a,(0cd15h)		;8573
	or a			;8576
	ld a,000h		;8577
	ld (0cd15h),a		;8579
	ret nz			;857c
	call L_86BC		;857d
	ld a,001h		;8580
	ld (0cd5bh),a		;8582
	call 05b6dh		;8585
	ld a,(0cd12h)		;8588
	and 00ch		;858b
	jr z,L_85AC		;858d
	rra			;858f
	rra			;8590
	ld c,a			;8591
L_8592:
	ld a,(de)			;8592
	ld b,a			;8593
	ld h,d			;8594
	ld l,e			;8595
	inc de			;8596
	inc de			;8597
L_8598:
	ld a,(de)			;8598
	push hl			;8599
	push de			;859a
	push bc			;859b
	call L_828F		;859c
	pop bc			;859f
	pop de			;85a0
	pop hl			;85a1
	inc de			;85a2
	dec c			;85a3
	jr z,L_85AC		;85a4
	djnz L_8598		;85a6
	ld d,h			;85a8
	ld e,l			;85a9
	jr L_8592		;85aa
L_85AC:
	xor a			;85ac
	ld (0cd5bh),a		;85ad
	ret			;85b0
L_85B1:
	push ix		;85b1
	pop hl			;85b3
	ld a,r		;85b4
	add a,l			;85b6
	rra			;85b7
	rra			;85b8
	ld b,a			;85b9
	ld a,(0cd2dh)		;85ba
	xor b			;85bd
	ld (0cd2dh),a		;85be
	and 07fh		;85c1
	add a,040h		;85c3
	ld (0cd5ch),a		;85c5
	sub 008h		;85c8
	ld d,a			;85ca
	ld e,058h		;85cb
L_85CD:
	call L_85E8		;85cd
	jr c,L_85DD		;85d0
	push de			;85d2
	call L_97B2		;85d3
	ld (0cd5dh),a		;85d6
	or a			;85d9
	pop de			;85da
	jr nz,L_85F7		;85db
L_85DD:
	ld a,010h		;85dd
	add a,d			;85df
	ld d,a			;85e0
	add a,008h		;85e1
	ld (0cd5ch),a		;85e3
	jr L_85CD		;85e6
L_85E8:
	ld a,d			;85e8
	cp 0c0h		;85e9
	jp nc,L_87B7		;85eb
	ld a,(0c496h)		;85ee
	sub d			;85f1
	add a,020h		;85f2
	cp 040h		;85f4
	ret			;85f6
L_85F7:
	ld a,(0cd48h)		;85f7
	push af			;85fa
	ld a,(0cd5dh)		;85fb
	ld (0cd48h),a		;85fe
	call L_97E4		;8601
	pop af			;8604
	ld (0cd48h),a		;8605
	ld a,(0cd5ch)		;8608
	ld (ix+005h),a		;860b
	ld a,(0c496h)		;860e
	ld b,(ix+005h)		;8611
	sub b			;8614
	ld a,001h		;8615
	jp nc,0a58ah		;8617
	ld a,002h		;861a
	jp 0a58ah		;861c
L_861F:
	ld a,(0c00dh)		;861f
	and 003h		;8622
	ret nz			;8624
	ld hl,0cd5eh		;8625
	dec (hl)			;8628
	ret nz			;8629
	call 05b6dh		;862a
	inc de			;862d
	ld a,(de)			;862e
	or a			;862f
	ret z			;8630
	push af			;8631
	call L_828F		;8632
	pop af			;8635
	cp 008h		;8636
	jr z,L_864E		;8638
	cp 021h		;863a
	jr z,L_864E		;863c
	cp 005h		;863e
	jr z,L_8652		;8640
	ld a,(0cd12h)		;8642
	add a,a			;8645
	ld b,a			;8646
	ld a,060h		;8647
	sub b			;8649
L_864A:
	ld (0cd5eh),a		;864a
	ret			;864d
L_864E:
	ld a,080h		;864e
	jr L_864A		;8650
L_8652:
	ld a,0e0h		;8652
	jr L_864A		;8654
L_8656:
	xor a			;8656
	ld (0cd17h),a		;8657
	ld (0cd31h),a		;865a
	ld (0cd14h),a		;865d
	ld (0cdb0h),a		;8660
	ld a,010h		;8663
	ld (0cd30h),a		;8665
	ld a,008h		;8668
	ld (0cd16h),a		;866a
	ld a,010h		;866d
	ld (0cd5eh),a		;866f
	call L_9785		;8672
	ld hl,0a090h		;8675
	ld bc,01010h		;8678
	ld a,099h		;867b
	ld d,001h		;867d
	call 04732h		;867f
	ld a,(0cd16h)		;8682
	cp 020h		;8685
	ret nc			;8687
	ld a,020h		;8688
	ld (0cd16h),a		;868a
	ret			;868d
L_868E:
	call L_86BC		;868e
	call L_8255		;8691
	ld ix,0c600h		;8694
	ld b,008h		;8698
L_869A:
	ld a,(ix+000h)		;869a
	and a			;869d
	jr z,L_86B4		;869e
	ld a,(ix+00dh)		;86a0
	or a			;86a3
	jr nz,L_86E6		;86a4
	push bc			;86a6
	call L_8715		;86a7
	call L_877A		;86aa
	call L_87A5		;86ad
	call L_87B1		;86b0
	pop bc			;86b3
L_86B4:
	ld de,00080h		;86b4
	add ix,de		;86b7
	djnz L_869A		;86b9
	ret			;86bb
L_86BC:
	ld hl,0c270h		;86bc
	ld b,008h		;86bf
	ld c,000h		;86c1
L_86C3:
	ld a,(hl)			;86c3
	or a			;86c4
	jr z,L_86C8		;86c5
	inc c			;86c7
L_86C8:
	inc hl			;86c8
	djnz L_86C3		;86c9
	ld a,c			;86cb
	srl a		;86cc
	srl a		;86ce
	ld c,a			;86d0
	ld a,(0c288h)		;86d1
	add a,c			;86d4
	ld c,a			;86d5
	ld a,(0c280h)		;86d6
	add a,c			;86d9
	cp 00fh		;86da
	jr c,L_86E0		;86dc
	ld a,00fh		;86de
L_86E0:
	and 00fh		;86e0
	ld (0cd12h),a		;86e2
	ret			;86e5
L_86E6:
	exx			;86e6
	dec a			;86e7
	call z,0a9d3h		;86e8
	call 0a9b3h		;86eb
	exx			;86ee
	jr L_86B4		;86ef
L_86F1:
	ld ix,0ca00h		;86f1
	ld b,00ch		;86f5
	ld de,00040h		;86f7
	jr L_8705		;86fa
L_86FC:
	ld ix,0c600h		;86fc
	ld b,008h		;8700
	ld de,00080h		;8702
L_8705:
	push bc			;8705
	ld a,(ix+000h)		;8706
	and a			;8709
	push de			;870a
	call nz,L_87F2		;870b
	pop de			;870e
	add ix,de		;870f
	pop bc			;8711
	djnz L_8705		;8712
	ret			;8714
L_8715:
	ld a,(ix+000h)		;8715
	dec a			;8718
	call 0408dh		;8719

; ----------------------------------------------------------------------
; DATOS sin identificar  0x871c..0x877a  (94 bytes)
DATA_871C:
	defb 0feh,0a0h,0cfh,0a2h,084h,0a1h,0e0h,0a3h,08dh,0a4h,0bch,0a4h,0ebh,0a4h,0ebh,0a4h	; 871c  ................
	defb 078h,0a7h,00ch,0abh,000h,0ach,000h,0ach,078h,0a7h,078h,0a7h,078h,0a7h,0ebh,0a4h	; 872c  x.......x.x.x...
	defb 078h,0a7h,032h,09dh,0ebh,0a4h,0ebh,0a4h,063h,0a7h,078h,0a7h,078h,0a7h,078h,0a7h	; 873c  x.2.....c.x.x.x.
	defb 078h,0a7h,078h,0a7h,0ebh,0a4h,0ebh,0a4h,0ffh,09bh,0ebh,0a4h,078h,0a7h,078h,0a7h	; 874c  x.x.........x.x.
	defb 0ebh,0a4h,0feh,0ach,0feh,0ach,0bah,0b1h,078h,0adh,09fh,0b0h,036h,0afh,02ah,0b1h	; 875c  ........x...6.*.
	defb 0d2h,0b2h,0d2h,0b2h,073h,0b5h,06ch,0b3h,078h,096h,027h,097h,092h,0b6h	; 876c  ....s.l.x.'...

; ======================================================================
; CODIGO 0x877a..0x88dc  (354 bytes)
; ======================================================================


L_877A:
	call L_8791		;877a
	ld e,(ix+008h)		;877d
	ld d,(ix+009h)		;8780
	ld l,(ix+004h)		;8783
	ld h,(ix+005h)		;8786
	add hl,de			;8789
	ld (ix+004h),l		;878a
	ld (ix+005h),h		;878d
	ret			;8790
L_8791:
	ld e,(ix+006h)		;8791
	ld d,(ix+007h)		;8794
	ld l,(ix+002h)		;8797
	ld h,(ix+003h)		;879a
	add hl,de			;879d
	ld (ix+002h),l		;879e
	ld (ix+003h),h		;87a1
	ret			;87a4
L_87A5:
	ld a,(ix+005h)		;87a5
	cp 0f8h		;87a8
	jr nc,L_87B7		;87aa
	cp 008h		;87ac
	ret nc			;87ae
	jr L_87B7		;87af
L_87B1:
	ld a,(ix+003h)		;87b1
	cp 0e4h		;87b4
	ret c			;87b6
L_87B7:
	xor a			;87b7
	ld (ix+000h),a		;87b8
	ld (ix+00ch),a		;87bb
	ld (ix+00dh),a		;87be
	ld (ix+011h),a		;87c1
	ld (ix+01fh),a		;87c4
	push ix		;87c7
	pop hl			;87c9
	set 5,l		;87ca
	ld c,(hl)			;87cc
	ld a,c			;87cd
	and a			;87ce
	ret z			;87cf
	inc l			;87d0
L_87D1:
	ld a,(hl)			;87d1
	ld de,0ee20h		;87d2
	add a,a			;87d5
	add a,a			;87d6
	add a,e			;87d7
	ld e,a			;87d8
	ld a,0e0h		;87d9
	ld (de),a			;87db
	ld a,l			;87dc
	add a,005h		;87dd
	ld l,a			;87df
	dec c			;87e0
	jr nz,L_87D1		;87e1
	ret			;87e3
L_87E4:
	ld (ix+008h),e		;87e4
	ld (ix+009h),d		;87e7
	ret			;87ea
L_87EB:
	ld (ix+006h),e		;87eb
	ld (ix+007h),d		;87ee
	ret			;87f1
L_87F2:
	di			;87f2
	ld a,00ch		;87f3
	ld (0a000h),a		;87f5
	ld (0f0f3h),a		;87f8
	ei			;87fb
	exx			;87fc
	ld a,(ix+00ah)		;87fd
	ld de,0b6d2h		;8800
	call 0447ch		;8803
	ld a,(de)			;8806
	inc de			;8807
	push de			;8808
	ld de,0baf3h		;8809
	call 0447ch		;880c
	exx			;880f
	pop de			;8810
	push ix		;8811
	pop hl			;8813
	set 5,l		;8814
	ld b,(hl)			;8816
	ld a,b			;8817
	or a			;8818
	jp z,04206h		;8819
	inc l			;881c
	inc l			;881d
L_881E:
	push hl			;881e
	exx			;881f
	pop hl			;8820
	ld a,(de)			;8821
	inc de			;8822
	add a,(ix+003h)		;8823
	ld (hl),a			;8826
	inc l			;8827
	call L_883C		;8828
	inc de			;882b
	ld (hl),a			;882c
	inc l			;882d
	push hl			;882e
	exx			;882f
	pop hl			;8830
	ld a,(de)			;8831
	ld (hl),a			;8832
	inc l			;8833
	inc de			;8834
	inc l			;8835
	inc l			;8836
	djnz L_881E		;8837
	jp 04206h		;8839
L_883C:
	ld a,(de)			;883c
	and 080h		;883d
	jr nz,L_8848		;883f
	ld a,(de)			;8841
	add a,(ix+005h)		;8842
	ret nc			;8845
	jr L_8851		;8846
L_8848:
	ld a,(de)			;8848
	neg		;8849
	ld c,a			;884b
	ld a,(ix+005h)		;884c
	sub c			;884f
	ret nc			;8850
L_8851:
	dec l			;8851
	ld a,0e1h		;8852
	ld (hl),a			;8854
	inc l			;8855
	ret			;8856
L_8857:
	ld hl,0ca00h		;8857
	ld b,00ch		;885a
	ld de,00040h		;885c
	jr L_8869		;885f
L_8861:
	ld hl,0c600h		;8861
	ld b,008h		;8864
	ld de,00080h		;8866
L_8869:
	push hl			;8869
	push de			;886a
	push bc			;886b
	call L_8879		;886c
	call nc,L_8893		;886f
	pop bc			;8872
	pop de			;8873
	pop hl			;8874
	add hl,de			;8875
	djnz L_8869		;8876
	ret			;8878
L_8879:
	ld a,(hl)			;8879
	or a			;887a
	jr z,L_8891		;887b
	push hl			;887d
	ld a,00eh		;887e
	add a,l			;8880
	ld l,a			;8881
	ld a,(hl)			;8882
	pop hl			;8883
	or a			;8884
	jr nz,L_8891		;8885
	push hl			;8887
	set 5,l		;8888
	ld a,(hl)			;888a
	pop hl			;888b
	or a			;888c
	jr z,L_8891		;888d
	or a			;888f
	ret			;8890
L_8891:
	scf			;8891
	ret			;8892
L_8893:
	set 5,l		;8893
	ld b,(hl)			;8895
	inc l			;8896
L_8897:
	ld a,(hl)			;8897
	inc l			;8898
	add a,a			;8899
	add a,a			;889a
	ld de,0ee20h		;889b
	add a,e			;889e
	ld e,a			;889f
	ld a,(hl)			;88a0
	ld (de),a			;88a1
	inc l			;88a2
	inc e			;88a3
	ld a,(hl)			;88a4
	ld (de),a			;88a5
	inc l			;88a6
	inc e			;88a7
	ld a,(hl)			;88a8
	ld (de),a			;88a9
	inc l			;88aa
	inc e			;88ab
	inc l			;88ac
	djnz L_8897		;88ad
	ret			;88af
L_88B0:
	ld ix,0ca00h		;88b0
	ld b,008h		;88b4
L_88B6:
	ld a,(ix+000h)		;88b6
	and a			;88b9
	jr z,L_88CD		;88ba
	push bc			;88bc
	call L_88D5		;88bd
	call L_877A		;88c0
	call L_87F2		;88c3
	call L_87A5		;88c6
	call L_87B1		;88c9
	pop bc			;88cc
L_88CD:
	ld de,00040h		;88cd
	add ix,de		;88d0
	djnz L_88B6		;88d2
	ret			;88d4
L_88D5:
	ld a,(ix+000h)		;88d5
	dec a			;88d8
	call 0408dh		;88d9

; ----------------------------------------------------------------------
; DATOS sin identificar  0x88dc..0x88ea  (14 bytes)
DATA_88DC:
	defb 0eah,088h,018h,089h,025h,089h,02ah,089h,026h,089h,025h,089h,081h,089h	; 88dc  ....%.*.&.%...

; ======================================================================
; CODIGO 0x88ea..0x8a94  (426 bytes)
; ======================================================================


L_88EA:
	ld a,(ix+001h)		;88ea
	or a			;88ed
	jr nz,L_8909		;88ee
	ld de,00010h		;88f0
	call 0a13bh		;88f3
	ld a,(0c494h)		;88f6
	cp (ix+003h)		;88f9
	ret nc			;88fc
L_88FD:
	inc (ix+001h)		;88fd
	ld de,00000h		;8900
	call L_87E4		;8903
	jp L_87EB		;8906
L_8909:
	ld (ix+00ah),03dh		;8909
L_890D:
	ld (ix+00ch),000h		;890d
	dec (ix+00bh)		;8911
	ret nz			;8914
	jp L_87B7		;8915
L_8918:
	ld b,058h		;8918
L_891A:
	ld a,(0c00dh)		;891a
	rrca			;891d
	rrca			;891e
	and 003h		;891f
	add a,b			;8921
	ld (ix+00ah),a		;8922
L_8925:
	ret			;8925
L_8926:
	ld b,093h		;8926
	jr L_892C		;8928
L_892A:
	ld b,05ah		;892a
L_892C:
	ld a,(0c00dh)		;892c
	rrca			;892f
	rrca			;8930
	and 001h		;8931
	add a,b			;8933
	ld (ix+00ah),a		;8934
	ret			;8937
L_8938:
	ld de,0c003h		;8938
	jr L_8953		;893b
L_893D:
	ld a,(ix+07eh)		;893d
	bit 0,(ix+00fh)		;8940
	jr z,L_8948		;8944
	add a,002h		;8946
L_8948:
	ld (ix+00ah),a		;8948
	jr L_8975		;894b
L_894D:
	ld a,(ix+07eh)		;894d
L_8950:
	ld de,0c00dh		;8950
L_8953:
	bit 0,(ix+00fh)		;8953
	jr z,L_895B		;8957
	add a,002h		;8959
L_895B:
	ld b,a			;895b
	push ix		;895c
	pop hl			;895e
	add hl,hl			;895f
	add hl,hl			;8960
	ld a,003h		;8961
	and h			;8963
	ld c,a			;8964
	ld a,(de)			;8965
	sub c			;8966
	ld c,a			;8967
	and 007h		;8968
	ret nz			;896a
	ld a,c			;896b
	rrca			;896c
	rrca			;896d
	rrca			;896e
	and 001h		;896f
	add a,b			;8971
	ld (ix+00ah),a		;8972
L_8975:
	push ix		;8975
	pop hl			;8977
	ld a,(ix+000h)		;8978
	ld (0cd37h),a		;897b
	jp 054e6h		;897e
L_8981:
	ld a,(ix+001h)		;8981
	or a			;8984
	jr nz,L_89B3		;8985
	ld de,00080h		;8987
	call 0a13bh		;898a
	ld a,(ix+010h)		;898d
	cp (ix+003h)		;8990
	ret nc			;8993
	ld a,003h		;8994
	call 04fe4h		;8996
	call L_88FD		;8999
	ld (ix+025h),003h		;899c
	ld (ix+02ah),008h		;89a0
	ld a,053h		;89a4
	push ix		;89a6
	pop hl			;89a8
	ld (ix+00ah),a		;89a9
	exx			;89ac
	ld de,0562ch		;89ad
	jp 05502h		;89b0
L_89B3:
	ld a,(ix+00bh)		;89b3
	rrca			;89b6
	rrca			;89b7
	and 001h		;89b8
	add a,052h		;89ba
	ld (ix+00ah),a		;89bc
	jp L_890D		;89bf
L_89C2:
	ld b,a			;89c2
	ld hl,08b6bh		;89c3
	add a,l			;89c6
	ld l,a			;89c7
	jr nc,L_89CB		;89c8
	inc h			;89ca
L_89CB:
	ld a,(ix+003h)		;89cb
	sub (hl)			;89ce
	ld c,a			;89cf
	ld a,b			;89d0
	ld b,(ix+005h)		;89d1
	ld (0cd18h),a		;89d4
	ld (0cd1bh),bc		;89d7
	push ix		;89db
	call L_89E9		;89dd
	call L_86F1		;89e0
	call L_8857		;89e3
	pop ix		;89e6
	ret			;89e8
L_89E9:
	ld a,(0cd18h)		;89e9
	ld hl,0ca00h		;89ec
	ld b,008h		;89ef
	xor a			;89f1
	ld de,00040h		;89f2
L_89F5:
	cp (hl)			;89f5
	jr z,L_89FC		;89f6
	add hl,de			;89f8
	djnz L_89F5		;89f9
	ret			;89fb
L_89FC:
	push hl			;89fc
	pop ix		;89fd
	ld (0cd3ch),hl		;89ff
	ld c,002h		;8a02
	ld (ix+020h),c		;8a04
	ld de,00000h		;8a07
	ld hl,0ee20h		;8a0a
	ld b,00ch		;8a0d
L_8A0F:
	ld a,(hl)			;8a0f
	cp 0e0h		;8a10
	jr nz,L_8A34		;8a12
	ld (hl),0e1h		;8a14
	call L_84A0		;8a16
	inc e			;8a19
	inc d			;8a1a
	ld a,004h		;8a1b
	call 04083h		;8a1d
	ld (hl),0e1h		;8a20
	call L_84A0		;8a22
	inc e			;8a25
	inc d			;8a26
	ld a,004h		;8a27
	call 04083h		;8a29
	dec c			;8a2c
	jr z,L_8A41		;8a2d
	dec c			;8a2f
	jr z,L_8A41		;8a30
	jr L_8A3E		;8a32
L_8A34:
	inc d			;8a34
	inc d			;8a35
	inc hl			;8a36
	inc hl			;8a37
	inc hl			;8a38
	inc hl			;8a39
	inc hl			;8a3a
	inc hl			;8a3b
	inc hl			;8a3c
	inc hl			;8a3d
L_8A3E:
	djnz L_8A0F		;8a3e
	ret			;8a40
L_8A41:
	ld hl,(0cd3ch)		;8a41
	ld a,(0cd18h)		;8a44
	ld (hl),a			;8a47
	inc l			;8a48
	ld (hl),000h		;8a49
	ld de,(0cd1bh)		;8a4b
	inc l			;8a4f
	ld (hl),000h		;8a50
	inc l			;8a52
	ld (hl),e			;8a53
	inc l			;8a54
	ld (hl),000h		;8a55
	inc l			;8a57
	ld (hl),d			;8a58
	ld (ix+00ch),001h		;8a59
	ld a,(ix+000h)		;8a5d
	ld de,08b52h		;8a60
	call 0447ch		;8a63
	ld hl,(0cd3ch)		;8a66
	set 5,l		;8a69
	ld b,(hl)			;8a6b
	ld a,005h		;8a6c
	add a,l			;8a6e
	ld l,a			;8a6f
L_8A70:
	ld a,(de)			;8a70
	ld (hl),a			;8a71
	inc de			;8a72
	ld a,l			;8a73
	add a,005h		;8a74
	ld l,a			;8a76
	djnz L_8A70		;8a77
	ld hl,(0cd3ch)		;8a79
	call L_8893		;8a7c
	ld hl,(0cd3ch)		;8a7f
	ld a,(ix+000h)		;8a82
	add a,02fh		;8a85
	ld (0cd37h),a		;8a87
	call 054e6h		;8a8a
	ld a,(ix+000h)		;8a8d
	dec a			;8a90
	call 0408dh		;8a91

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8a94..0x8aa2  (14 bytes)
DATA_8A94:
	defb 0a2h,08ah,0b9h,08ah,0cfh,08ah,0d8h,08ah,0e1h,08ah,002h,08bh,022h,08bh	; 8a94  ............".

; ======================================================================
; CODIGO 0x8aa2..0x8b54  (178 bytes)
; ======================================================================


L_8AA2:
	ld (ix+00ah),03ch		;8aa2
	ld (ix+00bh),020h		;8aa6
	ld de,00000h		;8aaa
	call L_87E4		;8aad
	ld de,00200h		;8ab0
	call L_8B48		;8ab3
	jp L_87EB		;8ab6
L_8AB9:
	ld a,006h		;8ab9
	call 04fe4h		;8abb
	ld a,058h		;8abe
L_8AC0:
	ld (ix+00ah),a		;8ac0
	ld a,040h		;8ac3
	call L_8B76		;8ac5
	call L_87E4		;8ac8
	ex de,hl			;8acb
	jp L_87EB		;8acc
L_8ACF:
	ld a,006h		;8acf
	call 04fe4h		;8ad1
	ld a,049h		;8ad4
	jr L_8AC0		;8ad6
L_8AD8:
	ld a,005h		;8ad8
	call 04fe4h		;8ada
	ld a,05ah		;8add
	jr L_8AC0		;8adf
L_8AE1:
	ld a,006h		;8ae1
	call 04fe4h		;8ae3
	ld b,093h		;8ae6
L_8AE8:
	ld (ix+00ah),b		;8ae8
	ld de,00000h		;8aeb
	call L_87EB		;8aee
	ld de,00280h		;8af1
	call L_8B48		;8af4
	ld hl,0cd38h		;8af7
	bit 0,(hl)		;8afa
	call z,L_8C0A		;8afc
	jp L_87E4		;8aff
L_8B02:
	ld a,007h		;8b02
	call 04fe4h		;8b04
	ld b,03ch		;8b07
	ld a,(ix+005h)		;8b09
	ld hl,0cd38h		;8b0c
	bit 0,(hl)		;8b0f
	jr z,L_8B1E		;8b11
	inc b			;8b13
	add a,010h		;8b14
L_8B16:
	jp c,L_87B7		;8b16
	ld (ix+005h),a		;8b19
	jr L_8AE8		;8b1c
L_8B1E:
	sub 010h		;8b1e
	jr L_8B16		;8b20
L_8B22:
	ld de,0fa00h		;8b22
	call L_87EB		;8b25
	ld de,00200h		;8b28
	call L_8B48		;8b2b
	ld hl,0cd38h		;8b2e
	bit 0,(hl)		;8b31
	call z,L_8C0A		;8b33
	call L_87E4		;8b36
	ld a,(ix+003h)		;8b39
	ld (ix+010h),a		;8b3c
	ld (ix+00bh),007h		;8b3f
	ld (ix+00ah),01bh		;8b43
	ret			;8b47
L_8B48:
	ld a,(0cd12h)		;8b48
	add a,a			;8b4b
	add a,a			;8b4c
	add a,a			;8b4d
	add a,a			;8b4e
	add a,e			;8b4f
	ld e,a			;8b50
	ret nc			;8b51
	inc d			;8b52
	ret			;8b53

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8b54..0x8b76  (34 bytes)
DATA_8B54:
	defb 062h,08bh,064h,08bh,066h,08bh,06ah,08bh,068h,08bh,062h,08bh,064h,08bh,002h,045h	; 8b54  b.d.f.j.h.b.d..E
	defb 001h,042h,002h,00eh,002h,006h,002h,04ch,000h,008h,000h,000h,008h,008h,00ch,000h	; 8b64  .B.....L........
	defb 03eh,080h	; 8b74

; ======================================================================
; CODIGO 0x8b76..0x8c30  (186 bytes)
; ======================================================================


L_8B76:
	ld e,(ix+003h)		;8b76
	ld d,(ix+005h)		;8b79
	ld c,a			;8b7c
	ld a,(0cd12h)		;8b7d
	add a,a			;8b80
	add a,a			;8b81
	add a,a			;8b82
	add a,c			;8b83
	ld (0cd1dh),a		;8b84
	call L_8BC2		;8b87
	ld a,(0cd1eh)		;8b8a
	ld e,a			;8b8d
	ld d,000h		;8b8e
	sub 03fh		;8b90
	neg		;8b92
	ld hl,08c70h		;8b94
	push hl			;8b97
	add hl,de			;8b98
	ld c,(hl)			;8b99
	pop hl			;8b9a
	ld e,a			;8b9b
	add hl,de			;8b9c
	ld a,(hl)			;8b9d
	ld (0cd1fh),a		;8b9e
	ld e,c			;8ba1
	call L_8C12		;8ba2
	ld a,(0cd20h)		;8ba5
	and a			;8ba8
	call nz,L_8C0A		;8ba9
	ld (0cd22h),de		;8bac
	ld a,(0cd1fh)		;8bb0
	ld e,a			;8bb3
	call L_8C12		;8bb4
	ld a,(0cd21h)		;8bb7
	and a			;8bba
	call nz,L_8C0A		;8bbb
	ld hl,(0cd22h)		;8bbe
	ret			;8bc1
L_8BC2:
	ld hl,0cd20h		;8bc2
	ld (hl),000h		;8bc5
	ld a,(0c494h)		;8bc7
	sub e			;8bca
	jr nc,L_8BD0		;8bcb
	neg		;8bcd
	inc (hl)			;8bcf
L_8BD0:
	inc hl			;8bd0
	ld (hl),000h		;8bd1
	rra			;8bd3
	rra			;8bd4
	and 038h		;8bd5
	ld e,a			;8bd7
	ld a,(0c496h)		;8bd8
	sub d			;8bdb
	jr nc,L_8BE1		;8bdc
	neg		;8bde
	inc (hl)			;8be0
L_8BE1:
	rra			;8be1
	rra			;8be2
	rra			;8be3
	rra			;8be4
	rra			;8be5
	and 007h		;8be6
	add a,e			;8be8
	ld hl,08c30h		;8be9
	call 04083h		;8bec
	ld a,(hl)			;8bef
	ld (0cd1eh),a		;8bf0
	ld c,a			;8bf3
	ld hl,(0cd20h)		;8bf4
	ld a,h			;8bf7
	ld b,000h		;8bf8
	and a			;8bfa
	jr z,L_8BFF		;8bfb
	ld b,080h		;8bfd
L_8BFF:
	cp l			;8bff
	ld a,c			;8c00
	jr z,L_8C05		;8c01
	neg		;8c03
L_8C05:
	add a,b			;8c05
	ld (0cd24h),a		;8c06
	ret			;8c09
L_8C0A:
	ld a,d			;8c0a
	cpl			;8c0b
	ld d,a			;8c0c
	ld a,e			;8c0d
	cpl			;8c0e
	ld e,a			;8c0f
	inc de			;8c10
	ret			;8c11
L_8C12:
	ld a,(0cd1dh)		;8c12
	ld h,a			;8c15
	call L_8C24		;8c16
	xor a			;8c19
	add hl,hl			;8c1a
	adc a,a			;8c1b
	add hl,hl			;8c1c
	adc a,a			;8c1d
	add hl,hl			;8c1e
	adc a,a			;8c1f
	ld l,h			;8c20
	ld h,a			;8c21
	ex de,hl			;8c22
	ret			;8c23
L_8C24:
	ld b,008h		;8c24
	ld l,000h		;8c26
	ld d,l			;8c28
L_8C29:
	add hl,hl			;8c29
	jr nc,L_8C2D		;8c2a
	add hl,de			;8c2c
L_8C2D:
	djnz L_8C29		;8c2d
	ret			;8c2f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8c30..0x8cb0  (128 bytes)
DATA_8C30:
	defb 020h,008h,004h,003h,002h,002h,001h,001h,038h,020h,015h,00fh,00ch,009h,008h,007h	; 8c30   .......8 ......
	defb 03bh,02bh,020h,019h,014h,010h,00eh,00ch,03dh,031h,027h,020h,01ah,016h,013h,011h	; 8c40  ;+ .....=1' ....
	defb 03dh,034h,02ch,025h,020h,01ch,018h,015h,03eh,036h,02fh,029h,024h,020h,01ch,019h	; 8c50  =4,% ...>6/)$ ..
	defb 03eh,038h,032h,02ch,028h,023h,020h,01dh,03eh,039h,034h,02fh,02ah,026h,023h,020h	; 8c60  >82,(# .>94/*&#
	defb 000h,006h,00ch,012h,019h,01fh,026h,02ch,032h,038h,03eh,044h,04ah,050h,056h,05ch	; 8c70  ......&,28>DJPV\
	defb 062h,068h,06dh,073h,079h,07eh,084h,089h,08eh,093h,099h,09eh,0a2h,0a7h,0ach,0b1h	; 8c80  bhmsy~..........
	defb 0b5h,0b9h,0beh,0c2h,0c6h,0cah,0ceh,0d1h,0d5h,0d8h,0dch,0dfh,0e2h,0e5h,0e7h,0eah	; 8c90  ................
	defb 0edh,0efh,0f1h,0f3h,0f5h,0f7h,0f8h,0fah,0fbh,0fch,0fdh,0feh,0feh,0ffh,0ffh,0ffh	; 8ca0  ................

; ======================================================================
; CODIGO 0x8cb0..0x8ce1  (49 bytes)
; ======================================================================


L_8CB0:
	ld ix,0cc00h		;8cb0
	ld b,004h		;8cb4
L_8CB6:
	ld a,(ix+000h)		;8cb6
	and a			;8cb9
	jr z,L_8CCA		;8cba
	push bc			;8cbc
	call L_8CD2		;8cbd
	call L_877A		;8cc0
	call L_87F2		;8cc3
	call L_87A5		;8cc6
	pop bc			;8cc9
L_8CCA:
	ld de,00040h		;8cca
	add ix,de		;8ccd
	djnz L_8CB6		;8ccf
	ret			;8cd1
L_8CD2:
	ld a,(ix+001h)		;8cd2
	cp 002h		;8cd5
	call z,07d7eh		;8cd7
	ld a,(ix+000h)		;8cda
	dec a			;8cdd
	call 0408dh		;8cde

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8ce1..0x8cff  (30 bytes)
DATA_8CE1:
	defb 0b3h,08dh,0b3h,08dh,0b3h,08dh,032h,08dh,07ch,08dh,04bh,08eh,06fh,08eh,0c0h,08eh	; 8ce1  ......2.|.K.o...
	defb 012h,08fh,0f4h,08eh,025h,08fh,043h,08fh,09ah,08fh,0a6h,08fh,0d5h,08eh	; 8cf1  ....%.C.......

; ======================================================================
; CODIGO 0x8cff..0x8d2c  (45 bytes)
; ======================================================================


L_8CFF:
	ld a,(ix+00dh)		;8cff
	or a			;8d02
	ret z			;8d03
	inc (ix+001h)		;8d04
	ld (ix+01fh),001h		;8d07
	jr L_8D1B		;8d0b
L_8D0D:
	ld a,(0c490h)		;8d0d
	or a			;8d10
	ret nz			;8d11
	inc (ix+001h)		;8d12
	ld a,(ix+000h)		;8d15
	cp 006h		;8d18
	ret z			;8d1a
L_8D1B:
	ld a,(ix+000h)		;8d1b
	or a			;8d1e
	ret z			;8d1f
	dec a			;8d20
	ld de,08d2ch		;8d21
	call 04088h		;8d24
	ld a,(de)			;8d27
	ld (ix+00ah),a		;8d28
	ret			;8d2b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8d2c..0x8d32  (6 bytes)
DATA_8D2C:
	defb 047h,048h,049h,012h,012h,012h	; 8d2c

; ======================================================================
; CODIGO 0x8d32..0x8d38  (6 bytes)
; ======================================================================


L_8D32:
	ld a,(ix+001h)		;8d32
	call 0408dh		;8d35

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8d38..0x8d40  (8 bytes)
DATA_8D38:
	defb 0ffh,08ch,00dh,08dh,040h,08dh,07ch,08dh	; 8d38  ....@.|.

; ======================================================================
; CODIGO 0x8d40..0x8db9  (121 bytes)
; ======================================================================


L_8D40:
	call L_8E99		;8d40
	call L_8D95		;8d43
	ld (ix+00bh),0f0h		;8d46
	call 07d7eh		;8d4a
	ld e,(ix+012h)		;8d4d
	call 05929h		;8d50
	ld (ix+00ch),000h		;8d53
	inc (ix+001h)		;8d57
	ld (ix+011h),001h		;8d5a
	ld a,(ix+003h)		;8d5e
	ld (ix+010h),a		;8d61
	sub 008h		;8d64
	ld (ix+003h),a		;8d66
	ld a,(ix+005h)		;8d69
	ld (ix+013h),a		;8d6c
	ld (ix+00eh),000h		;8d6f
	ld de,00000h		;8d73
	call L_87E4		;8d76
	jp L_8D8F		;8d79
L_8D7C:
	call L_8D89		;8d7c
	ld a,(ix+010h)		;8d7f
	cp (ix+003h)		;8d82
	ret nc			;8d85
	jp L_87B7		;8d86
L_8D89:
	ld de,00040h		;8d89
	jp 0a13bh		;8d8c
L_8D8F:
	ld de,0fc00h		;8d8f
	jp L_87EB		;8d92
L_8D95:
	ld hl,0c4b0h		;8d95
	ld b,005h		;8d98
	ld a,(hl)			;8d9a
	bit 0,a		;8d9b
	jr z,L_8DAF		;8d9d
	ld c,a			;8d9f
	and 00fh		;8da0
	srl c		;8da2
	srl c		;8da4
	srl c		;8da6
	srl c		;8da8
	cp c			;8daa
	jr nz,L_8DAF		;8dab
	ld b,050h		;8dad
L_8DAF:
	ld (ix+012h),b		;8daf
	ret			;8db2
L_8DB3:
	ld a,(ix+001h)		;8db3
	call 0408dh		;8db6

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8db9..0x8dc3  (10 bytes)
DATA_8DB9:
	defb 0ffh,08ch,00dh,08dh,0c3h,08dh,004h,08eh,027h,08eh	; 8db9  ........'.

; ======================================================================
; CODIGO 0x8dc3..0x8e59  (150 bytes)
; ======================================================================


L_8DC3:
	call L_8E99		;8dc3
	ld (ix+00ch),000h		;8dc6
	ld de,00080h		;8dca
	ld a,(0c49ah)		;8dcd
	cp (ix+005h)		;8dd0
	jr nc,L_8DFA		;8dd3
	ld a,(ix+005h)		;8dd5
	add a,008h		;8dd8
L_8DDA:
	ld (ix+005h),a		;8dda
	call L_87E4		;8ddd
	call L_8D8F		;8de0
	ld a,(ix+003h)		;8de3
	sub 00ch		;8de6
	ld (ix+003h),a		;8de8
	ld (ix+010h),a		;8deb
	ld (ix+00eh),000h		;8dee
	ld (ix+014h),058h		;8df2
	inc (ix+001h)		;8df6
	ret			;8df9
L_8DFA:
	call L_8C0A		;8dfa
	ld a,(ix+005h)		;8dfd
	sub 008h		;8e00
	jr L_8DDA		;8e02
L_8E04:
	ld de,00040h		;8e04
	call 0a13bh		;8e07
	ld a,(ix+010h)		;8e0a
	cp (ix+003h)		;8e0d
	ret nc			;8e10
	inc (ix+001h)		;8e11
	ld (ix+00ch),001h		;8e14
	ld de,00066h		;8e18
	ld (ix+012h),d		;8e1b
	ld (ix+013h),e		;8e1e
L_8E21:
	ld de,0fd00h		;8e21
	jp L_87EB		;8e24
L_8E27:
	dec (ix+014h)		;8e27
	jp z,L_87B7		;8e2a
	ld d,(ix+012h)		;8e2d
	ld a,(ix+013h)		;8e30
	add a,003h		;8e33
	ld e,a			;8e35
	jr nc,L_8E39		;8e36
	inc d			;8e38
L_8E39:
	ld (ix+012h),d		;8e39
	ld (ix+013h),e		;8e3c
	call 0a13bh		;8e3f
	ld a,(ix+010h)		;8e42
	cp (ix+003h)		;8e45
	ret nc			;8e48
	jr L_8E21		;8e49
L_8E4B:
	ld (ix+00eh),001h		;8e4b
	ld a,(ix+001h)		;8e4f
	or a			;8e52
	call z,L_8E65		;8e53
	call 0408dh		;8e56

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8e59..0x8e65  (12 bytes)
DATA_8E59:
	defb 0ffh,08ch,00dh,08dh,070h,08eh,06fh,08eh,070h,08eh,06fh,08eh	; 8e59  ....p.o.p.o.

; ======================================================================
; CODIGO 0x8e65..0x8fac  (327 bytes)
; ======================================================================


L_8E65:
	ld a,(0c278h)		;8e65
	or a			;8e68
	ret z			;8e69
	ld a,004h		;8e6a
	ld (ix+001h),a		;8e6c
L_8E6F:
	ret			;8e6f
L_8E70:
	xor a			;8e70
	ld (0cd2ah),a		;8e71
	jr L_8EA3		;8e74
L_8E76:
	ld bc,0a090h		;8e76
	ld a,0ffh		;8e79
	ld (0cd2ah),a		;8e7b
	call L_8EB1		;8e7e
	ld bc,0b090h		;8e81
	jr L_8EB1		;8e84
L_8E86:
	ld bc,0a090h		;8e86
	xor a			;8e89
	ld (0cd2ah),a		;8e8a
	jr L_8EB1		;8e8d
L_8E8F:
	ld bc,07090h		;8e8f
	ld a,000h		;8e92
	ld (0cd2ah),a		;8e94
	jr L_8EB1		;8e97
L_8E99:
	ld bc,00080h		;8e99
	ld a,0ffh		;8e9c
	ld (0cd2ah),a		;8e9e
	jr L_8EB1		;8ea1
L_8EA3:
	ld (ix+00dh),000h		;8ea3
	ld (ix+00ch),001h		;8ea7
	ld bc,04080h		;8eab
	inc (ix+001h)		;8eae
L_8EB1:
	ld a,(ix+003h)		;8eb1
	sub 00fh		;8eb4
	ld e,a			;8eb6
	ld a,(ix+005h)		;8eb7
	sub 008h		;8eba
	ld d,a			;8ebc
	jp 04e8eh		;8ebd
L_8EC0:
	ld a,(ix+00dh)		;8ec0
	or a			;8ec3
	ret z			;8ec4
	xor a			;8ec5
	ld de,00200h		;8ec6
	call 0592bh		;8ec9
	call L_8E8F		;8ecc
	call L_8F57		;8ecf
	jp L_87B7		;8ed2
L_8ED5:
	ld a,(ix+00dh)		;8ed5
	or a			;8ed8
	ret z			;8ed9
	call L_8E8F		;8eda
	call L_8F57		;8edd
	ld a,(0c480h)		;8ee0
	add a,004h		;8ee3
	cp 020h		;8ee5
	jr c,L_8EEB		;8ee7
	ld a,020h		;8ee9
L_8EEB:
	ld (0c480h),a		;8eeb
	call 05890h		;8eee
	jp L_87B7		;8ef1
L_8EF4:
	ld a,(ix+00dh)		;8ef4
	or a			;8ef7
	ret z			;8ef8
	ld a,(0c260h)		;8ef9
	cp 099h		;8efc
	jr z,L_8F06		;8efe
	add a,001h		;8f00
	daa			;8f02
	ld (0c260h),a		;8f03
L_8F06:
	call L_8E8F		;8f06
	call L_8F57		;8f09
	call 043e2h		;8f0c
	jp L_87B7		;8f0f
L_8F12:
	ld a,(ix+00dh)		;8f12
	or a			;8f15
	ret z			;8f16
	ld a,008h		;8f17
	call 05884h		;8f19
	call L_8E8F		;8f1c
	call L_8F57		;8f1f
	jp L_87B7		;8f22
L_8F25:
	ld a,(ix+00dh)		;8f25
	or a			;8f28
	ret z			;8f29
	ld a,(0c270h)		;8f2a
	inc a			;8f2d
	cp 004h		;8f2e
	jr nz,L_8F34		;8f30
	ld a,003h		;8f32
L_8F34:
	ld (0c270h),a		;8f34
L_8F37:
	call L_8F57		;8f37
	call L_8E8F		;8f3a
	call 05856h		;8f3d
	jp L_87B7		;8f40
L_8F43:
	ld a,(ix+00dh)		;8f43
	or a			;8f46
	ret z			;8f47
	ld a,(0c279h)		;8f48
	inc a			;8f4b
	cp 004h		;8f4c
	jr nz,L_8F52		;8f4e
	ld a,003h		;8f50
L_8F52:
	ld (0c279h),a		;8f52
	jr L_8F37		;8f55
L_8F57:
	ld hl,0cd4eh		;8f57
	ld a,(hl)			;8f5a
	cp 030h		;8f5b
	ret nc			;8f5d
	inc (hl)			;8f5e
	ld b,a			;8f5f
	add a,a			;8f60
	add a,b			;8f61
	ld hl,0c2b0h		;8f62
	call 04083h		;8f65
	ld a,(0c484h)		;8f68
	ld (hl),a			;8f6b
	inc hl			;8f6c
	ld a,(ix+005h)		;8f6d
	sub 008h		;8f70
	ld (hl),a			;8f72
	inc hl			;8f73
	ld a,(ix+003h)		;8f74
	sub 02fh		;8f77
	ld (hl),a			;8f79
	ret			;8f7a
L_8F7B:
	ld hl,0c2b0h		;8f7b
	ld d,h			;8f7e
	ld e,l			;8f7f
	inc de			;8f80
	xor a			;8f81
	ld (hl),a			;8f82
	ld bc,0008fh		;8f83
	ldir		;8f86
	ld hl,0cda0h		;8f88
	xor a			;8f8b
	ld b,010h		;8f8c
L_8F8E:
	ld (hl),a			;8f8e
	inc hl			;8f8f
	djnz L_8F8E		;8f90
	call 0bcf2h		;8f92
	xor a			;8f95
	ld (0cd4eh),a		;8f96
	ret			;8f99
L_8F9A:
	ld a,(ix+00dh)		;8f9a
	or a			;8f9d
	ret z			;8f9e
	ld a,001h		;8f9f
	ld (0c271h),a		;8fa1
	jr L_8F37		;8fa4
L_8FA6:
	ld a,(ix+001h)		;8fa6
	call 0408dh		;8fa9

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8fac..0x8fb0  (4 bytes)
DATA_8FAC:
	defb 0b0h,08fh,0cbh,08fh	; 8fac

; ======================================================================
; CODIGO 0x8fb0..0x906e  (190 bytes)
; ======================================================================


L_8FB0:
	xor a			;8fb0
	ld (ix+00ch),a		;8fb1
	ld a,(ix+00dh)		;8fb4
	or a			;8fb7
	ret z			;8fb8
	inc (ix+001h)		;8fb9
	call L_8E76		;8fbc
	ld (ix+00bh),010h		;8fbf
	call L_8F57		;8fc3
	ld a,016h		;8fc6
	jp 04fe4h		;8fc8
L_8FCB:
	dec (ix+00bh)		;8fcb
	ret nz			;8fce
	call L_8E86		;8fcf
	jp L_87B7		;8fd2
L_8FD5:
	ld ix,0cc00h		;8fd5
	ld b,004h		;8fd9
	ex de,hl			;8fdb
L_8FDC:
	ld a,(ix+000h)		;8fdc
	or a			;8fdf
	jr z,L_8FEA		;8fe0
	ld de,00040h		;8fe2
	add ix,de		;8fe5
	djnz L_8FDC		;8fe7
	ret			;8fe9
L_8FEA:
	ld c,000h		;8fea
	ld a,(0c483h)		;8fec
	or a			;8fef
	jr z,L_8FF4		;8ff0
	ld c,020h		;8ff2
L_8FF4:
	ld a,(hl)			;8ff4
	and 0f0h		;8ff5
	add a,c			;8ff7
	add a,00fh		;8ff8
	ld e,a			;8ffa
	inc hl			;8ffb
	ld a,(hl)			;8ffc
	and 0f0h		;8ffd
	add a,008h		;8fff
	ld d,a			;9001
	dec hl			;9002
	ld a,(hl)			;9003
	and 00fh		;9004
	cp 00eh		;9006
	call z,L_9066		;9008
	ld (0cd3fh),de		;900b
	ld (0cd3ch),ix		;900f
	ld (0cd3eh),a		;9013
	ld hl,0907ch		;9016
	call 04083h		;9019
	ld a,(hl)			;901c
	ld (ix+020h),a		;901d
	or a			;9020
	call nz,L_908C		;9021
	push ix		;9024
	pop hl			;9026
	ld a,(0cd3eh)		;9027
	ld (hl),a			;902a
	inc l			;902b
	ld (hl),000h		;902c
	ld de,(0cd3fh)		;902e
	inc l			;9032
	ld (hl),000h		;9033
	inc l			;9035
	ld (hl),e			;9036
	inc l			;9037
	ld (hl),000h		;9038
	inc l			;903a
	ld (hl),d			;903b
	inc l			;903c
	ld (hl),000h		;903d
	ld a,(ix+000h)		;903f
	cp 007h		;9042
	jr c,L_904A		;9044
	ld (ix+00ch),001h		;9046
L_904A:
	ld a,(ix+020h)		;904a
	or a			;904d
	ret z			;904e
	ld a,(ix+000h)		;904f
	ld de,l906ch		;9052
	call L_8485		;9055
	ld (ix+00eh),001h		;9058
	push ix		;905c
	pop hl			;905e
	xor a			;905f
	ld (0cd37h),a		;9060
	jp 05503h		;9063
L_9066:
	push af			;9066
	ld a,0ffh		;9067
	ld (0cd2ah),a		;9069
L_906C:
	pop af			;906c
	ret			;906d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x906e..0x908c  (30 bytes)
DATA_906E:
	defb 07bh,090h,07bh,090h,07bh,090h,07ah,090h,07ah,090h,07ah,090h,008h,001h,042h,002h	; 906e  {.{.{.z.z.z...B.
	defb 002h,002h,001h,001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 907e  ..............

; ======================================================================
; CODIGO 0x908c..0x9371  (741 bytes)
; ======================================================================


L_908C:
	ld b,a			;908c
	ld a,(0cd41h)		;908d
	ld l,a			;9090
	ld h,000h		;9091
	add hl,hl			;9093
	add hl,hl			;9094
	ld de,0ee20h		;9095
	add hl,de			;9098
	ld de,00004h		;9099
	ld c,0e1h		;909c
	exx			;909e
	ld de,00005h		;909f
	ld hl,(0cd3ch)		;90a2
	set 5,l		;90a5
	inc l			;90a7
	exx			;90a8
	call L_90AF		;90a9
	dec b			;90ac
	jr z,L_90B8		;90ad
L_90AF:
	ld (hl),c			;90af
	add hl,de			;90b0
	exx			;90b1
	ld a,(0cd41h)		;90b2
	ld (hl),a			;90b5
	add hl,de			;90b6
	exx			;90b7
L_90B8:
	ld a,(0cd41h)		;90b8
	inc a			;90bb
	ld (0cd41h),a		;90bc
	ret			;90bf
L_90C0:
	di			;90c0
	ld a,00fh		;90c1
	ld (0a000h),a		;90c3
	ld (0f0f3h),a		;90c6
	ei			;90c9
	xor a			;90ca
	ld (0cd41h),a		;90cb
	ld a,(0c483h)		;90ce
	or a			;90d1
	jp nz,L_916E		;90d2
	ld de,0a08eh		;90d5
	ld a,(0c288h)		;90d8
	ld b,a			;90db
	add a,a			;90dc
	add a,a			;90dd
	add a,a			;90de
	sub b			;90df
	ld b,a			;90e0
	ld a,(0c280h)		;90e1
	add a,b			;90e4
	call 0447ch		;90e5
	call L_911E		;90e8
	jp c,04206h		;90eb
L_90EE:
	ld a,(de)			;90ee
	ld c,a			;90ef
	ld a,(0c281h)		;90f0
	cp c			;90f3
	jr nz,L_911B		;90f4
	inc de			;90f6
	ld a,(de)			;90f7
	and 00fh		;90f8
	or a			;90fa
	push de			;90fb
	call nz,L_8FD5		;90fc
	pop de			;90ff
	ld a,(de)			;9100
	and 0f0h		;9101
	add a,000h		;9103
	ld (0cd27h),a		;9105
	inc de			;9108
	ld a,(de)			;9109
	ld b,a			;910a
	and 0f0h		;910b
	ld (0cd28h),a		;910d
	ld a,b			;9110
	and 00fh		;9111
	inc de			;9113
	push de			;9114
	call L_9132		;9115
	pop de			;9118
	jr L_90EE		;9119
L_911B:
	jp 04206h		;911b
L_911E:
	ld a,(de)			;911e
	or a			;911f
	jr z,L_9130		;9120
	inc de			;9122
	ld b,a			;9123
	ld a,(0c281h)		;9124
	ld c,a			;9127
L_9128:
	ld a,(de)			;9128
	cp c			;9129
	ret z			;912a
	inc de			;912b
	inc de			;912c
	inc de			;912d
	djnz L_9128		;912e
L_9130:
	scf			;9130
	ret			;9131
L_9132:
	ld de,0a02bh		;9132
	call 0447ch		;9135
	ex de,hl			;9138
	ld c,(hl)			;9139
	inc hl			;913a
	ld b,(hl)			;913b
	inc hl			;913c
	ld a,b			;913d
	cp 0ffh		;913e
	ret z			;9140
L_9141:
	ld a,0ffh		;9141
	ld e,(hl)			;9143
	cp e			;9144
	ret z			;9145
	inc hl			;9146
	ld d,(hl)			;9147
	inc hl			;9148
	push hl			;9149
	ld a,0ffh		;914a
	ld (0cd2ah),a		;914c
	call 04e84h		;914f
	pop hl			;9152
	jr L_9141		;9153
L_9155:
	ld de,0b36dh		;9155
	call 0447ch		;9158
	ex de,hl			;915b
L_915C:
	ld c,(hl)			;915c
	inc hl			;915d
	ld b,(hl)			;915e
	inc hl			;915f
	ld a,c			;9160
	cp 0ffh		;9161
	ret z			;9163
	ld de,00000h		;9164
	push hl			;9167
	call 04e84h		;9168
	pop hl			;916b
	jr L_915C		;916c
L_916E:
	ld a,001h		;916e
	ld (0cd15h),a		;9170
	call L_9221		;9173
	ld a,(0c484h)		;9176
	add a,a			;9179
	add a,a			;917a
	add a,a			;917b
	ld de,0cde0h		;917c
	call 04088h		;917f
	ld b,004h		;9182
L_9184:
	xor a			;9184
	ld (0cd2ah),a		;9185
	ld a,(de)			;9188
	inc a			;9189
	jp z,L_911B		;918a
	push bc			;918d
	push de			;918e
	exx			;918f
	pop de			;9190
	call L_91D8		;9191
	exx			;9194
	ld a,(0cd4fh)		;9195
	or a			;9198
	jr nz,L_91A3		;9199
	ld a,(de)			;919b
	and 00fh		;919c
	push de			;919e
	call nz,L_8FD5		;919f
	pop de			;91a2
L_91A3:
	ld a,(de)			;91a3
	ld b,a			;91a4
	and 0f0h		;91a5
	add a,020h		;91a7
	ld (0cd27h),a		;91a9
	inc de			;91ac
	ld a,(de)			;91ad
	and 0f0h		;91ae
	ld (0cd28h),a		;91b0
	ld a,(0cd4fh)		;91b3
	or a			;91b6
	jr nz,L_91CE		;91b7
	ld a,b			;91b9
	and 00fh		;91ba
	call z,L_91CB		;91bc
L_91BF:
	inc de			;91bf
	push de			;91c0
	call L_9155		;91c1
	pop de			;91c4
	pop bc			;91c5
	djnz L_9184		;91c6
	jp L_911B		;91c8
L_91CB:
	ld a,002h		;91cb
	ret			;91cd
L_91CE:
	cp 001h		;91ce
	ld a,000h		;91d0
	jr z,L_91BF		;91d2
	ld a,001h		;91d4
	jr L_91BF		;91d6
L_91D8:
	cp 008h		;91d8
	ld a,000h		;91da
	ld (0cd4fh),a		;91dc
	ret z			;91df
	ld hl,0c2b0h		;91e0
	ld a,(0cd4eh)		;91e3
	or a			;91e6
	ret z			;91e7
	ld b,a			;91e8
	ld a,(de)			;91e9
	ld c,a			;91ea
	inc de			;91eb
	ld a,(de)			;91ec
	and 0f0h		;91ed
	ld d,a			;91ef
	ld a,c			;91f0
	and 0f0h		;91f1
	ld e,a			;91f3
L_91F4:
	ld a,(0c484h)		;91f4
	cp (hl)			;91f7
	ld a,003h		;91f8
	jr nz,L_920A		;91fa
	inc hl			;91fc
	ld a,d			;91fd
	cp (hl)			;91fe
	ld a,002h		;91ff
	jr nz,L_920A		;9201
	inc hl			;9203
	ld a,e			;9204
	cp (hl)			;9205
	ld a,001h		;9206
	jr z,L_9210		;9208
L_920A:
	call 04083h		;920a
	djnz L_91F4		;920d
	ret			;920f
L_9210:
	ld a,001h		;9210
	ld (0cd4fh),a		;9212
	ld a,c			;9215
	and 00fh		;9216
	cp 00eh		;9218
	ret nz			;921a
	ld a,002h		;921b
	ld (0cd4fh),a		;921d
	ret			;9220
L_9221:
	ld a,(0c288h)		;9221
	ld b,a			;9224
	add a,a			;9225
	add a,a			;9226
	add a,a			;9227
	sub b			;9228
	ld b,a			;9229
	ld a,(0c280h)		;922a
	add a,b			;922d
	ld de,0b3beh		;922e
	call 0447ch		;9231
	ld hl,0cde0h		;9234
	ld c,004h		;9237
L_9239:
	ld a,(de)			;9239
	ld (hl),a			;923a
	inc de			;923b
	inc hl			;923c
	ld a,(de)			;923d
	ld (hl),a			;923e
	inc hl			;923f
	dec c			;9240
	ld a,(de)			;9241
	and 008h		;9242
	call nz,L_924E		;9244
	ld a,(de)			;9247
	and 004h		;9248
	ret nz			;924a
	inc de			;924b
	jr L_9239		;924c
L_924E:
	ld b,c			;924e
	ld c,004h		;924f
	ld a,b			;9251
	or a			;9252
	ret z			;9253
	ld a,0ffh		;9254
L_9256:
	ld (hl),a			;9256
	inc hl			;9257
	ld (hl),a			;9258
	inc hl			;9259
	djnz L_9256		;925a
	ret			;925c
L_925D:
	ld a,(0c002h)		;925d
	and 040h		;9260
	jr z,L_9269		;9262
	ld a,081h		;9264
	call 04fe4h		;9266
L_9269:
	xor a			;9269
	ld (0cd2eh),a		;926a
	ld hl,0c500h		;926d
	ld de,00010h		;9270
	ld b,003h		;9273
L_9275:
	ld a,(hl)			;9275
	and 080h		;9276
	jr nz,L_927E		;9278
	add hl,de			;927a
	djnz L_9275		;927b
	ret			;927d
L_927E:
	ld a,(hl)			;927e
	and 07fh		;927f
	push af			;9281
	call 053e3h		;9282
	pop af			;9285
	ld (0cd5fh),a		;9286
	ld de,09567h		;9289
	call 0447ch		;928c
L_928F:
	ld a,(de)			;928f
	inc de			;9290
	or a			;9291
	jr z,L_929B		;9292
	push de			;9294
	call L_828F		;9295
	pop de			;9298
	jr L_928F		;9299
L_929B:
	ld hl,0cd80h		;929b
	ex de,hl			;929e
	ldi		;929f
	ldi		;92a1
	ex de,hl			;92a3
	push de			;92a4
	call L_92B2		;92a5
	pop de			;92a8
	ld a,(de)			;92a9
	jp 04280h		;92aa
L_92AD:
	ld a,007h		;92ad
	jp 04280h		;92af
L_92B2:
	xor a			;92b2
	ld de,0cd84h		;92b3
	ld hl,0cd83h		;92b6
	ld bc,00008h		;92b9
	ld (hl),a			;92bc
	ldir		;92bd
	ld de,0cd83h		;92bf
	ld b,010h		;92c2
	ld hl,(0cd80h)		;92c4
	xor a			;92c7
	ld (0ee80h),a		;92c8
	inc a			;92cb
L_92CC:
	add hl,hl			;92cc
	push bc			;92cd
	push af			;92ce
	push hl			;92cf
	call c,L_92DA		;92d0
	pop hl			;92d3
	pop af			;92d4
	pop bc			;92d5
	inc a			;92d6
	djnz L_92CC		;92d7
	ret			;92d9
L_92DA:
	ld (de),a			;92da
	inc de			;92db
	push de			;92dc
	ld b,a			;92dd
	push bc			;92de
	call L_932A		;92df
	pop bc			;92e2
	ld a,(0c27eh)		;92e3
	or a			;92e6
	jr nz,L_92F4		;92e7
	ld a,b			;92e9
	dec a			;92ea
	cp 00eh		;92eb
	jr c,L_92F4		;92ed
	ld hl,00900h		;92ef
	jr L_92FF		;92f2
L_92F4:
	ld a,b			;92f4
	dec a			;92f5
	add a,a			;92f6
	call 04088h		;92f7
	ld a,(de)			;92fa
	ld l,a			;92fb
	inc de			;92fc
	ld a,(de)			;92fd
	ld h,a			;92fe
L_92FF:
	ld a,b			;92ff
	dec a			;9300
	ld de,0cda0h		;9301
	call 04088h		;9304
	ld a,(de)			;9307
	ld b,a			;9308
	or a			;9309
	jr z,L_9313		;930a
L_930C:
	ld e,l			;930c
	ld d,h			;930d
	call L_9364		;930e
	djnz L_930C		;9311
L_9313:
	ld a,(0ee80h)		;9313
	ld de,0cd86h		;9316
	call 04088h		;9319
	ld a,(0ee80h)		;931c
	inc a			;931f
	inc a			;9320
	ld (0ee80h),a		;9321
	ex de,hl			;9324
	ld (hl),e			;9325
	inc hl			;9326
	ld (hl),d			;9327
	pop de			;9328
	ret			;9329
L_932A:
	ld a,(0c289h)		;932a
	ld e,a			;932d
	and 001h		;932e
	srl e		;9330
	srl e		;9332
	add a,e			;9334
	ld de,09371h		;9335
	call 0447ch		;9338
	ld a,(0c288h)		;933b
	ld b,a			;933e
	add a,a			;933f
	add a,a			;9340
	add a,a			;9341
	sub b			;9342
	ld b,a			;9343
	ld a,(0c280h)		;9344
	add a,b			;9347
	inc a			;9348
	ld b,a			;9349
	cp 028h		;934a
	ld a,060h		;934c
	jr nc,L_9360		;934e
	ld a,b			;9350
	cp 014h		;9351
	ld a,040h		;9353
	jr nc,L_9360		;9355
	ld a,b			;9357
	cp 00ah		;9358
	ld a,020h		;935a
	jr nc,L_9360		;935c
	ld a,000h		;935e
L_9360:
	call 04088h		;9360
	ret			;9363
L_9364:
	ld a,l			;9364
	add a,e			;9365
	daa			;9366
	ld l,a			;9367
	ld a,h			;9368
	adc a,d			;9369
	daa			;936a
	ld h,a			;936b
	ret nc			;936c
	ld hl,09999h		;936d
	ret			;9370

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9371..0x94f7  (390 bytes)
DATA_9371:
	defb 077h,093h,0f7h,093h,077h,094h,030h,000h,020h,000h,050h,000h,050h,000h,050h,000h	; 9371  w...w.0. .P.P.P.
	defb 050h,000h,050h,000h,020h,001h,040h,000h,050h,001h,030h,000h,020h,000h,050h,000h	; 9381  P.P. .@.P.0. .P.
	defb 005h,000h,050h,000h,000h,001h,060h,000h,040h,000h,000h,001h,000h,001h,000h,001h	; 9391  ..P...`.@.......
	defb 000h,001h,000h,001h,050h,002h,080h,001h,000h,003h,060h,000h,040h,000h,000h,001h	; 93a1  ....P.....`.@...
	defb 000h,000h,050h,001h,040h,002h,090h,000h,060h,000h,080h,002h,080h,002h,000h,003h	; 93b1  ..P.@...`.......
	defb 000h,003h,000h,003h,000h,004h,040h,004h,000h,008h,090h,000h,060h,000h,080h,002h	; 93c1  ......@.....`...
	defb 000h,000h,000h,005h,020h,004h,020h,001h,000h,001h,000h,006h,000h,006h,000h,004h	; 93d1  .... . .........
	defb 000h,004h,000h,004h,000h,005h,000h,006h,000h,015h,020h,001h,000h,001h,000h,006h	; 93e1  .......... .....
	defb 000h,000h,000h,007h,020h,006h,030h,000h,020h,000h,040h,000h,040h,000h,050h,000h	; 93f1  .... .0. .@.@.P.
	defb 050h,000h,050h,000h,050h,001h,050h,000h,050h,001h,030h,000h,020h,000h,040h,000h	; 9401  P.P.P.P.P.0. .@.
	defb 000h,000h,050h,000h,000h,001h,060h,000h,040h,000h,080h,000h,080h,000h,050h,001h	; 9411  ..P...`.@.....P.
	defb 050h,001h,050h,001h,000h,003h,060h,001h,000h,004h,060h,000h,040h,000h,080h,000h	; 9421  P.P...`...`.@...
	defb 000h,000h,000h,002h,080h,002h,090h,000h,060h,000h,050h,002h,050h,002h,000h,004h	; 9431  ........`.P.P...
	defb 000h,004h,000h,004h,000h,005h,000h,012h,000h,007h,090h,000h,060h,000h,050h,002h	; 9441  ............`.P.
	defb 000h,000h,000h,005h,000h,004h,050h,001h,020h,001h,020h,004h,020h,004h,000h,006h	; 9451  ......P. . . ...
	defb 000h,006h,000h,006h,000h,008h,000h,012h,000h,012h,050h,001h,020h,001h,020h,004h	; 9461  ..........P. . .
	defb 000h,000h,000h,007h,020h,005h,050h,000h,030h,000h,080h,000h,080h,000h,050h,000h	; 9471  .... .P.0.....P.
	defb 050h,000h,050h,000h,000h,004h,000h,001h,000h,020h,050h,000h,030h,000h,080h,000h	; 9481  P.P...... P.0...
	defb 000h,000h,050h,000h,000h,001h,000h,001h,060h,000h,050h,001h,050h,001h,000h,001h	; 9491  ..P.....`.P.P...
	defb 000h,001h,000h,001h,000h,005h,050h,002h,000h,020h,000h,001h,060h,000h,050h,001h	; 94a1  ......P.. ..`.P.
	defb 000h,000h,000h,002h,080h,003h,050h,001h,000h,001h,000h,003h,000h,003h,050h,002h	; 94b1  ......P.......P.
	defb 050h,002h,050h,002h,000h,006h,000h,006h,000h,020h,050h,001h,000h,001h,000h,003h	; 94c1  P.P...... P.....
	defb 000h,000h,000h,006h,080h,005h,050h,002h,000h,002h,000h,007h,000h,007h,000h,005h	; 94d1  ......P.........
	defb 000h,005h,000h,005h,000h,010h,000h,015h,000h,020h,050h,002h,000h,002h,000h,007h	; 94e1  ......... P.....
	defb 000h,000h,000h,008h,080h,007h	; 94f1

; ======================================================================
; CODIGO 0x94f7..0x9556  (95 bytes)
; ======================================================================


L_94F7:
	ld de,0cd83h		;94f7
	ld hl,09556h		;94fa
	ld b,003h		;94fd
L_94FF:
	ld a,(de)			;94ff
	or a			;9500
	jr z,L_951A		;9501
	cp 010h		;9503
	ret z			;9505
	cp 00fh		;9506
	ret z			;9508
	dec a			;9509
	inc de			;950a
	push bc			;950b
	push de			;950c
	ld e,(hl)			;950d
	inc hl			;950e
	ld d,(hl)			;950f
	inc hl			;9510
	push hl			;9511
	call 04eb9h		;9512
	pop hl			;9515
	pop de			;9516
	pop bc			;9517
	djnz L_94FF		;9518
L_951A:
	ld de,0cd86h		;951a
	ld hl,09556h		;951d
	ld b,003h		;9520
L_9522:
	ld a,(de)			;9522
	inc de			;9523
	ld c,a			;9524
	ld a,(de)			;9525
	or c			;9526
	ret z			;9527
	dec de			;9528
	push bc			;9529
	ld c,e			;952a
	ld b,d			;952b
	inc de			;952c
	inc de			;952d
	push de			;952e
	ld e,(hl)			;952f
	inc hl			;9530
	ld d,(hl)			;9531
	inc hl			;9532
	ld a,010h		;9533
	add a,e			;9535
	ld e,a			;9536
	ld a,0f0h		;9537
	add a,d			;9539
	ld d,a			;953a
	push hl			;953b
	ld l,c			;953c
	ld h,b			;953d
	ld b,002h		;953e
	inc hl			;9540
	push de			;9541
	call 04420h		;9542
	pop de			;9545
	ld a,020h		;9546
	add a,d			;9548
	ld d,a			;9549
	ld hl,05050h		;954a
	call 04ef1h		;954d
	pop hl			;9550
	pop de			;9551
	pop bc			;9552
	djnz L_9522		;9553
	ret			;9555

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9556..0x955c  (6 bytes)
DATA_9556:
	defb 078h,070h,078h,098h,078h,048h	; 9556

; ======================================================================
; CODIGO 0x955c..0x9567  (11 bytes)
; ======================================================================


L_955C:
	ld hl,0cda0h		;955c
	xor a			;955f
	ld b,010h		;9560
L_9562:
	ld (hl),a			;9562
	inc hl			;9563
	djnz L_9562		;9564
	ret			;9566

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9567..0x960c  (165 bytes)
DATA_9567:
	defb 091h,095h,097h,095h,09dh,095h,0a3h,095h,0a9h,095h,0afh,095h,0b5h,095h,0bbh,095h	; 9567  ................
	defb 0c1h,095h,0c7h,095h,0cdh,095h,0d3h,095h,0d9h,095h,0dfh,095h,0e5h,095h,0ebh,095h	; 9577  ................
	defb 0f1h,095h,0f7h,095h,0fch,095h,002h,096h,007h,096h,022h,025h,000h,040h,018h,0ffh	; 9587  .........."%.@..
	defb 023h,025h,000h,008h,0c0h,0ffh,023h,025h,000h,000h,026h,0ffh,022h,025h,000h,080h	; 9597  #%....#%..&."%..
	defb 081h,0ffh,022h,025h,000h,000h,092h,0ffh,023h,025h,000h,000h,04ch,0ffh,023h,025h	; 95a7  .."%....#%..L.#%
	defb 000h,000h,0a1h,0ffh,022h,025h,000h,000h,046h,0ffh,022h,025h,000h,040h,001h,0ffh	; 95b7  ...."%..F."%.@..
	defb 023h,025h,000h,000h,048h,0ffh,023h,025h,000h,000h,030h,0ffh,022h,025h,000h,000h	; 95c7  #%..H.#%..0."%..
	defb 005h,0ffh,022h,025h,000h,030h,000h,0ffh,023h,025h,000h,000h,001h,0ffh,023h,025h	; 95d7  .."%.0..#%....#%
	defb 000h,040h,000h,0ffh,022h,025h,000h,080h,000h,0ffh,02bh,026h,000h,002h,000h,0ffh	; 95e7  .@.."%....+&....
	defb 024h,000h,000h,000h,0ffh,026h,02ch,000h,001h,000h,000h,028h,000h,000h,000h,0ffh	; 95f7  $....&,....(....
	defb 02fh,000h,000h,000h,0ffh	; 9607

; ======================================================================
; CODIGO 0x960c..0x96cb  (191 bytes)
; ======================================================================


L_960C:
	ld a,(0c288h)		;960c
	ld b,a			;960f
	add a,a			;9610
	add a,a			;9611
	add a,b			;9612
	ld b,a			;9613
	ld a,(0c280h)		;9614
	dec a			;9617
	add a,b			;9618
	push af			;9619
	di			;961a
	ld a,00fh		;961b
	ld (0a000h),a		;961d
	ld (0f0f3h),a		;9620
	ei			;9623
	pop af			;9624
	ld de,0bc16h		;9625
	call 0447ch		;9628
	ex de,hl			;962b
	ld de,020b0h		;962c
	call 042e1h		;962f
	call 04206h		;9632
	ld a,001h		;9635
	ld (0cd11h),a		;9637
	ld a,02dh		;963a
	jp L_828F		;963c
L_963F:
	call L_868E		;963f
	call L_86FC		;9642
	call L_8861		;9645
	call 05b61h		;9648
	ret			;964b
L_964C:
	ld de,04060h		;964c
	call L_8334		;964f
	ret			;9652
L_9653:
	ld a,(0c002h)		;9653
	rla			;9656
	ld a,081h		;9657
	jr nc,L_965D		;9659
	ld a,088h		;965b
L_965D:
	ld (ix+00ah),a		;965d
	ld de,00080h		;9660
	call L_87E4		;9663
	ld de,00000h		;9666
	call L_87EB		;9669
	xor a			;966c
	ld (ix+075h),a		;966d
	ld (ix+01fh),a		;9670
	ld (ix+00bh),0c0h		;9673
	ret			;9677
L_9678:
	dec (ix+00bh)		;9678
	call z,L_96D3		;967b
	call L_974C		;967e
	ld a,(ix+005h)		;9681
	cp 0e0h		;9684
	jr z,$+127		;9686
	ld a,(0c003h)		;9688
	and 007h		;968b
	ret nz			;968d
	call L_96A8		;968e
	cp 003h		;9691
	ret nz			;9693
	ld a,02eh		;9694
	ld d,(ix+005h)		;9696
	ld e,(ix+003h)		;9699
	ld (0cd0fh),de		;969c
	call L_828F		;96a0
	ld a,010h		;96a3
	jp 04fe4h		;96a5
L_96A8:
	ld a,(0c002h)		;96a8
	rla			;96ab
	ld hl,096cbh		;96ac
	jr nc,L_96B4		;96af
	ld hl,096cfh		;96b1
L_96B4:
	ld a,(ix+075h)		;96b4
	ld b,a			;96b7
	call 04083h		;96b8
	ld a,(hl)			;96bb
	ld (ix+00ah),a		;96bc
	ld a,b			;96bf
	inc a			;96c0
	cp 004h		;96c1
	jr nz,L_96C7		;96c3
	ld a,000h		;96c5
L_96C7:
	ld (ix+075h),a		;96c7
	ret			;96ca

; ----------------------------------------------------------------------
; DATOS sin identificar  0x96cb..0x96d3  (8 bytes)
DATA_96CB:
	defb 081h,082h,083h,082h,088h,089h,08ah,089h	; 96cb  ........

; ======================================================================
; CODIGO 0x96d3..0x9953  (640 bytes)
; ======================================================================


L_96D3:
	ld (ix+00bh),018h		;96d3
	ld a,(ix+01fh)		;96d7
	cp 008h		;96da
	ret z			;96dc
	inc (ix+01fh)		;96dd
	add a,a			;96e0
	add a,a			;96e1
	add a,a			;96e2
	add a,a			;96e3
	add a,a			;96e4
	add a,010h		;96e5
	ld d,a			;96e7
	ld e,038h		;96e8
	ld hl,000d0h		;96ea
	ld bc,01008h		;96ed
	ld a,001h		;96f0
	push de			;96f2
	call 0476eh		;96f3
	pop de			;96f6
	ld e,098h		;96f7
	ld hl,000d0h		;96f9
	ld bc,01008h		;96fc
	ld a,001h		;96ff
	call 0476eh		;9701
	ret			;9704
L_9705:
	xor a			;9705
	ld (0cd11h),a		;9706
	ret			;9709
L_970A:
	ld de,(0cd0fh)		;970a
	call L_8334		;970e
	ret			;9711
L_9712:
	ld (ix+00ah),084h		;9712
	ld de,0ff00h		;9716
	call L_87E4		;9719
	ld de,0fe00h		;971c
	call L_87EB		;971f
	ld (ix+00bh),030h		;9722
	ret			;9726
L_9727:
	ld de,00010h		;9727
	call 0a13bh		;972a
	dec (ix+00bh)		;972d
	jp z,L_87B7		;9730
	ld b,084h		;9733
	ld a,(ix+00bh)		;9735
	cp 018h		;9738
	jr nc,L_973E		;973a
	inc b			;973c
	inc b			;973d
L_973E:
	ld a,(0c003h)		;973e
	rr a		;9741
	rr a		;9743
	and 001h		;9745
	add a,b			;9747
	ld (ix+00ah),a		;9748
	ret			;974b
L_974C:
	ld a,(0c003h)		;974c
	and 00fh		;974f
	ret nz			;9751
	di			;9752
	ld a,00fh		;9753
	ld (0a000h),a		;9755
	ld (0f0f3h),a		;9758
	ei			;975b
	call 042f1h		;975c
	call 04206h		;975f
	ret			;9762
L_9763:
	ld hl,0cd48h		;9763
	ld c,(hl)			;9766
	inc hl			;9767
	ld b,(hl)			;9768
	ld a,c			;9769
	or b			;976a
	jp z,L_87B7		;976b
	ld a,c			;976e
	or a			;976f
	jr z,L_97EF		;9770
	ld a,b			;9772
	or a			;9773
	jr z,L_97E4		;9774
	ld a,r		;9776
	ld b,a			;9778
	ld a,(0c00dh)		;9779
	rra			;977c
	rra			;977d
	xor b			;977e
	and 001h		;977f
	jr z,L_97EF		;9781
	jr L_97E4		;9783
L_9785:
	ld de,01858h		;9785
	call L_97B2		;9788
	ld (0cd49h),a		;978b
	ld de,00858h		;978e
	call L_97B2		;9791
	ld a,(0cd49h)		;9794
	and c			;9797
	ld (0cd49h),a		;9798
	ld de,0e858h		;979b
	call L_97B2		;979e
	ld (0cd48h),a		;97a1
	ld de,0d858h		;97a4
	call L_97B2		;97a7
	ld a,(0cd48h)		;97aa
	and c			;97ad
	ld (0cd48h),a		;97ae
	ret			;97b1
L_97B2:
	ld b,008h		;97b2
	ld c,000h		;97b4
L_97B6:
	push bc			;97b6
	push de			;97b7
	call 0781fh		;97b8
	pop de			;97bb
	jr c,L_97D8		;97bc
	push de			;97be
	ld a,e			;97bf
	sub 003h		;97c0
	ld e,a			;97c2
	call 0781fh		;97c3
	pop de			;97c6
	jr c,L_97D8		;97c7
	ld a,(0cd5bh)		;97c9
	or a			;97cc
	jr z,L_97D8		;97cd
	push de			;97cf
	ld a,d			;97d0
	add a,014h		;97d1
	ld d,a			;97d3
	call 0781fh		;97d4
	pop de			;97d7
L_97D8:
	pop bc			;97d8
	ccf			;97d9
	rr c		;97da
	ld a,010h		;97dc
	add a,e			;97de
	ld e,a			;97df
	djnz L_97B6		;97e0
	ld a,c			;97e2
	ret			;97e3
L_97E4:
	ld hl,0cd48h		;97e4
	ld (ix+005h),0f7h		;97e7
	ld d,002h		;97eb
	jr L_97F8		;97ed
L_97EF:
	ld hl,0cd49h		;97ef
	ld (ix+005h),008h		;97f2
	ld d,001h		;97f6
L_97F8:
	push de			;97f8
	call L_9833		;97f9
	pop de			;97fc
	ld (ix+003h),a		;97fd
	ld a,d			;9800
	call 0a58ah		;9801
	ld a,(0cd5bh)		;9804
	or a			;9807
	ret nz			;9808
	ld a,(ix+005h)		;9809
	cp 008h		;980c
	jr nz,L_9818		;980e
	ld a,(0c496h)		;9810
	sub 020h		;9813
	ret nc			;9815
	jr L_981E		;9816
L_9818:
	ld a,(0c496h)		;9818
	sub 0e0h		;981b
	ret c			;981d
L_981E:
	ld a,(0c494h)		;981e
	sub 020h		;9821
	ld b,a			;9823
	ld a,(ix+003h)		;9824
	sub b			;9827
	cp 040h		;9828
	ret nc			;982a
	ld a,001h		;982b
	ld (0cd14h),a		;982d
	jp L_87B7		;9830
L_9833:
	call L_9858		;9833
	ld d,a			;9836
	ld a,r		;9837
	ld c,a			;9839
	ld a,(0c00dh)		;983a
	rr a		;983d
	xor c			;983f
	and 00fh		;9840
	inc a			;9842
	ld b,a			;9843
	ld c,000h		;9844
L_9846:
	inc c			;9846
	ld a,c			;9847
	cp d			;9848
	jr nz,L_984D		;9849
	ld c,000h		;984b
L_984D:
	djnz L_9846		;984d
	ld a,c			;984f
	ld hl,0cd00h		;9850
	call 04083h		;9853
	ld a,(hl)			;9856
	ret			;9857
L_9858:
	ld a,(hl)			;9858
	ld b,008h		;9859
	exx			;985b
	ld hl,0cd00h		;985c
	ld d,000h		;985f
	ld c,058h		;9861
	exx			;9863
L_9864:
	rra			;9864
	push af			;9865
	exx			;9866
	call c,L_9876		;9867
	ld a,010h		;986a
	add a,c			;986c
	ld c,a			;986d
	exx			;986e
	pop af			;986f
	djnz L_9864		;9870
	exx			;9872
	ld a,d			;9873
	exx			;9874
	ret			;9875
L_9876:
	ld (hl),c			;9876
	inc hl			;9877
	inc d			;9878
	ret			;9879
L_987A:
	call L_9881		;987a
	call 05b1dh		;987d
	ret			;9880
L_9881:
	ld a,(0cdcdh)		;9881
	or a			;9884
	jp nz,0bd06h		;9885
	ld a,(0cdc8h)		;9888
	or a			;988b
	jp nz,0bc27h		;988c
	call 0b8c3h		;988f
	call 0bc5ch		;9892
	ld a,(0cdc5h)		;9895
	or a			;9898
	ret z			;9899
	call L_98AF		;989a
	call 045eeh		;989d
	call 0460ah		;98a0
	call 0b9cbh		;98a3
	call L_98BE		;98a6
	call L_98E3		;98a9
	jp 045e1h		;98ac
L_98AF:
	ld hl,0ee08h		;98af
	ld de,0ee09h		;98b2
	ld bc,00077h		;98b5
	ld a,0e0h		;98b8
	ld (hl),a			;98ba
	ldir		;98bb
	ret			;98bd
L_98BE:
	ld hl,0cdbbh		;98be
	ld b,008h		;98c1
L_98C3:
	ld a,(hl)			;98c3
	inc hl			;98c4
	exx			;98c5
	or a			;98c6
	call nz,L_99FB		;98c7
	exx			;98ca
	djnz L_98C3		;98cb
	ld a,(0cdb2h)		;98cd
	or a			;98d0
	jp z,L_99FB		;98d1
	ld c,a			;98d4
	ld a,(0cdcch)		;98d5
	or a			;98d8
	ld a,000h		;98d9
	jr z,L_98DF		;98db
	ld a,01ch		;98dd
L_98DF:
	add a,c			;98df
	jp L_99FB		;98e0
L_98E3:
	ld b,003h		;98e3
	ld hl,0cdc9h		;98e5
	ld c,000h		;98e8
L_98EA:
	ld a,(hl)			;98ea
	or a			;98eb
	push hl			;98ec
	push bc			;98ed
	call nz,L_98F8		;98ee
	pop bc			;98f1
	pop hl			;98f2
	inc c			;98f3
	inc hl			;98f4
	djnz L_98EA		;98f5
	ret			;98f7
L_98F8:
	cp 006h		;98f8
	ret z			;98fa
	dec a			;98fb
	ret z			;98fc
	dec a			;98fd
	ld de,09953h		;98fe
	call 0447ch		;9901
	ld a,c			;9904
	call 0447ch		;9905
	ex de,hl			;9908
	ld e,(hl)			;9909
	inc hl			;990a
	ld d,(hl)			;990b
	inc hl			;990c
	ex de,hl			;990d
	ld (0cdcfh),hl		;990e
	ld a,(de)			;9911
	inc de			;9912
	ld (0cdd1h),a		;9913
	ld hl,0ee00h		;9916
	call 04083h		;9919
	ld a,(de)			;991c
	inc de			;991d
	ld b,a			;991e
L_991F:
	ld a,(0cdcfh)		;991f
	ld (hl),a			;9922
	inc hl			;9923
	ld a,(0cdd0h)		;9924
	ld (hl),a			;9927
	inc hl			;9928
	ld a,(de)			;9929
	inc de			;992a
	ld (hl),a			;992b
	inc hl			;992c
	inc hl			;992d
	push hl			;992e
	ld a,(0cdd1h)		;992f
	ld l,a			;9932
	ld h,000h		;9933
	add hl,hl			;9935
	add hl,hl			;9936
	push de			;9937
	ld de,0ec00h		;9938
	add hl,de			;993b
	pop de			;993c
	ld a,(de)			;993d
	inc de			;993e
	push bc			;993f
	ld b,010h		;9940
L_9942:
	ld (hl),a			;9942
	inc hl			;9943
	djnz L_9942		;9944
	pop bc			;9946
	pop hl			;9947
	ld a,(0cdd1h)		;9948
	add a,004h		;994b
	ld (0cdd1h),a		;994d
	djnz L_991F		;9950
	ret			;9952

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9953..0x99fb  (168 bytes)
DATA_9953:
	defb 05bh,099h,061h,099h,067h,099h,06dh,099h,089h,099h,07dh,099h,073h,099h,0afh,099h	; 9953  [.a.g.m...}.s...
	defb 0a1h,099h,095h,099h,0d7h,099h,0cbh,099h,0bfh,099h,0f3h,099h,0ebh,099h,0e5h,099h	; 9963  ................
	defb 070h,080h,048h,003h,088h,002h,08ch,008h,090h,007h,078h,080h,028h,004h,094h,002h	; 9973  p.H.......x.(...
	defb 098h,008h,09ch,007h,0a0h,00ch,088h,080h,008h,004h,0a4h,002h,0a8h,008h,0ach,007h	; 9983  ................
	defb 0b0h,00ch,070h,080h,048h,004h,038h,002h,03ch,008h,040h,003h,044h,00ch,078h,080h	; 9993  ..p.H.8.<.@.D.x.
	defb 028h,005h,048h,002h,04ch,008h,050h,003h,054h,00ch,058h,00eh,088h,080h,008h,006h	; 99a3  (.H.L.P.T.X.....
	defb 05ch,002h,060h,008h,064h,003h,068h,00ch,06ch,007h,070h,00eh,070h,080h,048h,004h	; 99b3  \.`.d.h.l.p.p.H.
	defb 0b4h,003h,0b8h,008h,0bch,00ch,0c0h,00eh,078h,080h,028h,004h,0c4h,003h,0c8h,008h	; 99c3  ........x.(.....
	defb 0cch,00ch,0d0h,00eh,088h,080h,008h,005h,0d4h,003h,0d8h,008h,0dch,00ch,0e0h,00eh	; 99d3  ................
	defb 0e4h,002h,070h,080h,048h,001h,074h,003h,078h,080h,028h,002h,078h,003h,07ch,00eh	; 99e3  ..p.H.t.x.(.x.|.
	defb 088h,080h,028h,002h,080h,003h,084h,00eh	; 99f3  ..(.....

; ======================================================================
; CODIGO 0x99fb..0x9af4  (249 bytes)
; ======================================================================


L_99FB:
	push af			;99fb
	di			;99fc
	ld a,009h		;99fd
	ld (0a000h),a		;99ff
	ld (0f0f3h),a		;9a02
	ei			;9a05
	pop af			;9a06
	ld de,0b91dh		;9a07
	call 0447ch		;9a0a
	ex de,hl			;9a0d
	ld a,(hl)			;9a0e
	ld (0ee80h),a		;9a0f
	inc hl			;9a12
	ld e,(hl)			;9a13
	inc hl			;9a14
	ld d,(hl)			;9a15
	inc hl			;9a16
	ld c,00eh		;9a17
L_9A19:
	ld a,(0ee80h)		;9a19
	ld b,a			;9a1c
	push de			;9a1d
L_9A1E:
	push hl			;9a1e
	ld a,(hl)			;9a1f
	ld l,a			;9a20
	add a,a			;9a21
	add a,a			;9a22
	add a,a			;9a23
	ld h,a			;9a24
	ld a,l			;9a25
	and 0e0h		;9a26
	srl a		;9a28
	srl a		;9a2a
	ld l,a			;9a2c
	push bc			;9a2d
	call 04ef1h		;9a2e
	pop bc			;9a31
	pop hl			;9a32
	inc hl			;9a33
	ld a,008h		;9a34
	add a,d			;9a36
	ld d,a			;9a37
	djnz L_9A1E		;9a38
	pop de			;9a3a
	ld a,008h		;9a3b
	add a,e			;9a3d
	ld e,a			;9a3e
	dec c			;9a3f
	jr nz,L_9A19		;9a40
	call 04206h		;9a42
	ret			;9a45
L_9A46:
	call 067b3h		;9a46
	call 067dah		;9a49
	xor a			;9a4c
	ld (0cd54h),a		;9a4d
	inc a			;9a50
	ld (0cd11h),a		;9a51
	ld a,010h		;9a54
	ld (0cd30h),a		;9a56
	ld de,09d26h		;9a59
	ld (0cd50h),de		;9a5c
	ld a,004h		;9a60
	ld (0cd55h),a		;9a62
	call L_9AB0		;9a65
	call L_9AC9		;9a68
	ld de,09b14h		;9a6b
	ld a,(0c002h)		;9a6e
	add a,a			;9a71
	jr nc,L_9A77		;9a72
	ld de,09b24h		;9a74
L_9A77:
	ld hl,0ee00h		;9a77
	ld b,010h		;9a7a
L_9A7C:
	ld a,(de)			;9a7c
	inc de			;9a7d
	ld (hl),a			;9a7e
	inc hl			;9a7f
	djnz L_9A7C		;9a80
	ld hl,000c0h		;9a82
	ld de,06070h		;9a85
	ld bc,00c10h		;9a88
	call L_9AAB		;9a8b
	ld hl,010c0h		;9a8e
	ld de,09070h		;9a91
	ld bc,00810h		;9a94
	call L_9AAB		;9a97
	ld hl,018c0h		;9a9a
	ld de,07070h		;9a9d
	ld bc,02010h		;9aa0
	call L_9AAB		;9aa3
	ld a,012h		;9aa6
	jp L_828F		;9aa8
L_9AAB:
	ld a,048h		;9aab
	jp 04803h		;9aad
L_9AB0:
	ld hl,0ee20h		;9ab0
	ld de,09af4h		;9ab3
	ld b,020h		;9ab6
L_9AB8:
	ld a,(de)			;9ab8
	inc de			;9ab9
	ld (hl),a			;9aba
	inc hl			;9abb
	djnz L_9AB8		;9abc
	ret			;9abe
L_9ABF:
	ld hl,0ee10h		;9abf
	ld de,09b04h		;9ac2
	ld b,010h		;9ac5
	jr L_9AB8		;9ac7
L_9AC9:
	ld hl,0ec80h		;9ac9
	ld b,040h		;9acc
L_9ACE:
	ld de,00d0eh		;9ace
L_9AD1:
	ld (hl),d			;9ad1
	inc hl			;9ad2
	ld (hl),e			;9ad3
	inc hl			;9ad4
	djnz L_9AD1		;9ad5
	ret			;9ad7
L_9AD8:
	ld hl,0ec40h		;9ad8
	ld b,020h		;9adb
	jr L_9ACE		;9add
L_9ADF:
	ld hl,0ee20h		;9adf
	ld b,008h		;9ae2
L_9AE4:
	ld (hl),0e0h		;9ae4
	inc hl			;9ae6
	inc hl			;9ae7
	inc hl			;9ae8
	inc hl			;9ae9
	djnz L_9AE4		;9aea
	ret			;9aec
L_9AED:
	ld hl,0ee10h		;9aed
	ld b,004h		;9af0
	jr L_9AE4		;9af2

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9af4..0x9b34  (64 bytes)
DATA_9AF4:
	defb 057h,0b8h,0d0h,000h,057h,0c8h,0d0h,000h,067h,0b8h,0d0h,000h,067h,0c8h,0d0h,000h	; 9af4  W...W...g...g...
	defb 057h,028h,0d0h,000h,057h,038h,0d0h,000h,067h,028h,0d0h,000h,067h,038h,0d0h,000h	; 9b04  W(..W8..g(..g8..
	defb 0b0h,078h,000h,000h,0c0h,078h,004h,000h,0c0h,078h,008h,000h,0c0h,078h,00ch,000h	; 9b14  .x...x...x...x..
	defb 0b0h,078h,000h,000h,0c0h,078h,004h,000h,0b8h,078h,008h,000h,0c0h,078h,00ch,000h	; 9b24  .x...x...x...x..

; ======================================================================
; CODIGO 0x9b34..0x9b3a  (6 bytes)
; ======================================================================


L_9B34:
	ld a,(0cd54h)		;9b34
	call 0408dh		;9b37

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9b3a..0x9b46  (12 bytes)
DATA_9B3A:
	defb 046h,09bh,052h,09bh,066h,09bh,075h,09bh,0a1h,09bh,0b2h,09bh	; 9b3a  F.R.f.u.....

; ======================================================================
; CODIGO 0x9b46..0x9c05  (191 bytes)
; ======================================================================


L_9B46:
	ld a,(0cd55h)		;9b46
	or a			;9b49
	ret nz			;9b4a
	ld a,020h		;9b4b
	ld (0cd56h),a		;9b4d
	jr L_9B61		;9b50
L_9B52:
	ld hl,0cd56h		;9b52
	dec (hl)			;9b55
	ret nz			;9b56
	ld a,040h		;9b57
	ld (hl),a			;9b59
	call L_9ADF		;9b5a
L_9B5D:
	ld hl,0cd55h		;9b5d
	inc (hl)			;9b60
L_9B61:
	ld hl,0cd54h		;9b61
	inc (hl)			;9b64
	ret			;9b65
L_9B66:
	ld hl,0cd56h		;9b66
	dec (hl)			;9b69
	ret nz			;9b6a
	ld a,0c0h		;9b6b
	ld (hl),a			;9b6d
	ld a,01dh		;9b6e
	call L_828F		;9b70
	jr L_9B5D		;9b73
L_9B75:
	ld hl,0cd56h		;9b75
	dec (hl)			;9b78
	ret nz			;9b79
	ld a,0a0h		;9b7a
	ld (hl),a			;9b7c
	ld hl,0cd54h		;9b7d
	inc (hl)			;9b80
	ld a,00dh		;9b81
	call 04280h		;9b83
	ld hl,03030h		;9b86
	ld a,022h		;9b89
	ld d,000h		;9b8b
	ld bc,0a018h		;9b8d
	call 04732h		;9b90
	ld hl,0cd57h		;9b93
	ld (hl),007h		;9b96
	call L_9BBF		;9b98
	ld de,03030h		;9b9b
	jp 042e1h		;9b9e
L_9BA1:
	ld hl,0cd57h		;9ba1
	dec (hl)			;9ba4
	ret nz			;9ba5
	ld (hl),007h		;9ba6
	call 042f1h		;9ba8
	ld a,(0cd67h)		;9bab
	or a			;9bae
	ret z			;9baf
	jr L_9B61		;9bb0
L_9BB2:
	ld hl,0cd56h		;9bb2
	dec (hl)			;9bb5
	ret nz			;9bb6
	xor a			;9bb7
	ld (0cd11h),a		;9bb8
	ld (0cd60h),a		;9bbb
	ret			;9bbe
L_9BBF:
	ld a,(0c288h)		;9bbf
	cp 006h		;9bc2
	jr z,L_9BD1		;9bc4
	ld b,a			;9bc6
	ld a,(0cd60h)		;9bc7
	cp 008h		;9bca
	ld hl,09f92h		;9bcc
	ret nc			;9bcf
	ld a,b			;9bd0
L_9BD1:
	add a,a			;9bd1
	ld hl,09e0bh		;9bd2
	call 04083h		;9bd5
	ld a,(hl)			;9bd8
	inc hl			;9bd9
	ld h,(hl)			;9bda
	ld l,a			;9bdb
	ret			;9bdc
L_9BDD:
	ld de,03878h		;9bdd
	jp L_8334		;9be0
L_9BE3:
	call L_9ABF		;9be3
	call L_9AD8		;9be6
	xor a			;9be9
	ld (ix+00ch),a		;9bea
	ld (ix+00fh),a		;9bed
	ld de,00080h		;9bf0
	call L_87E4		;9bf3
	ld de,00000h		;9bf6
	call L_87EB		;9bf9
	jp L_893D		;9bfc
L_9BFF:
	ld a,(ix+001h)		;9bff
	call 0408dh		;9c02

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9c05..0x9c0d  (8 bytes)
DATA_9C05:
	defb 00dh,09ch,03dh,09ch,0a2h,09ch,0c8h,09ch	; 9c05  ..=.....

; ======================================================================
; CODIGO 0x9c0d..0x9d26  (281 bytes)
; ======================================================================


L_9C0D:
	ld b,072h		;9c0d
	call L_9DFC		;9c0f
	ld a,(ix+005h)		;9c12
	cp 080h		;9c15
	ret c			;9c17
	inc (ix+001h)		;9c18
	ld (ix+00bh),020h		;9c1b
	ld de,00000h		;9c1f
	call L_87E4		;9c22
	call L_87EB		;9c25
L_9C28:
	ld (ix+00ah),074h		;9c28
L_9C2C:
	exx			;9c2c
	ld de,057c8h		;9c2d
L_9C30:
	exx			;9c30
	push ix		;9c31
	pop hl			;9c33
	ld a,(ix+000h)		;9c34
	ld (0cd37h),a		;9c37
	jp 05503h		;9c3a
L_9C3D:
	ld a,(0c288h)		;9c3d
	cp 006h		;9c40
	jr z,L_9C65		;9c42
	ld a,(0cd60h)		;9c44
	cp 008h		;9c47
	jr c,L_9C65		;9c49
	dec (ix+00bh)		;9c4b
	ret nz			;9c4e
	ld (ix+00bh),00dh		;9c4f
	ld a,020h		;9c53
	call 04fe4h		;9c55
	call L_9AED		;9c58
	ld (ix+001h),003h		;9c5b
	ld (ix+00ah),095h		;9c5f
	jr L_9C2C		;9c63
L_9C65:
	dec (ix+00bh)		;9c65
	ret nz			;9c68
	ld (ix+00bh),020h		;9c69
	ld a,00ah		;9c6d
	call 04fe4h		;9c6f
	call L_9AED		;9c72
	inc (ix+001h)		;9c75
	ld (ix+00ah),075h		;9c78
	ld (ix+025h),002h		;9c7c
	ld (ix+02ah),044h		;9c80
	ld (ix+02fh),001h		;9c84
	ld (ix+034h),042h		;9c88
	ld (ix+039h),001h		;9c8c
	ld (ix+03eh),042h		;9c90
	ld (ix+043h),041h		;9c94
	ld (ix+048h),042h		;9c98
	exx			;9c9c
	ld de,057d6h		;9c9d
	jr L_9C30		;9ca0
L_9CA2:
	dec (ix+00bh)		;9ca2
	ret nz			;9ca5
	ld (ix+00bh),020h		;9ca6
	dec (ix+001h)		;9caa
	ld (ix+025h),001h		;9cad
	ld (ix+02ah),042h		;9cb1
	ld (ix+02fh),002h		;9cb5
	ld (ix+034h),044h		;9cb9
	ld (ix+039h),002h		;9cbd
	ld (ix+03eh),044h		;9cc1
	jp L_9C28		;9cc5
L_9CC8:
	dec (ix+00bh)		;9cc8
	ret nz			;9ccb
	ld (ix+00bh),00dh		;9ccc
	ld (ix+001h),001h		;9cd0
	jp L_9C28		;9cd4
L_9CD7:
	push bc			;9cd7
	call L_8334		;9cd8
	pop bc			;9cdb
	push bc			;9cdc
	call L_8334		;9cdd
	pop bc			;9ce0
	push bc			;9ce1
	call L_8334		;9ce2
	pop bc			;9ce5
	jp L_8334		;9ce6
L_9CE9:
	ld a,(0cd30h)		;9ce9
	ld (ix+00bh),a		;9cec
	add a,040h		;9cef
	ld (0cd30h),a		;9cf1
	ld (ix+00eh),001h		;9cf4
	ld (ix+00ch),000h		;9cf8
	ld de,(0cd50h)		;9cfc
	ld a,(de)			;9d00
	ld (ix+010h),a		;9d01
	inc de			;9d04
	push de			;9d05
	ld a,(de)			;9d06
	ld (ix+00fh),a		;9d07
	call L_893D		;9d0a
	ld de,00000h		;9d0d
	call L_87E4		;9d10
	call L_87EB		;9d13
	pop de			;9d16
	inc de			;9d17
	ld a,(de)			;9d18
	ld (ix+005h),a		;9d19
	ld (ix+003h),078h		;9d1c
	inc de			;9d20
	ld (0cd50h),de		;9d21
	ret			;9d25

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9d26..0x9d32  (12 bytes)
DATA_9D26:
	defb 0b0h,000h,0c8h,0b0h,001h,038h,090h,000h,0c8h,090h,001h,038h	; 9d26  .....8.....8

; ======================================================================
; CODIGO 0x9d32..0x9d38  (6 bytes)
; ======================================================================


L_9D32:
	ld a,(ix+001h)		;9d32
	call 0408dh		;9d35

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9d38..0x9d46  (14 bytes)
DATA_9D38:
	defb 046h,09dh,067h,09dh,084h,09dh,0a5h,09dh,0aeh,09dh,0d1h,09dh,0adh,09dh	; 9d38  F.g...........

; ======================================================================
; CODIGO 0x9d46..0x9e0b  (197 bytes)
; ======================================================================


L_9D46:
	dec (ix+00bh)		;9d46
	ret nz			;9d49
	inc (ix+001h)		;9d4a
	dec (ix+00eh)		;9d4d
	ld (ix+00bh),034h		;9d50
	ld de,00080h		;9d54
	bit 0,(ix+00fh)		;9d57
	call z,L_8C0A		;9d5b
	call L_87E4		;9d5e
	ld de,00000h		;9d61
	jp L_87EB		;9d64
L_9D67:
	call L_9DF0		;9d67
	dec (ix+00bh)		;9d6a
	ret nz			;9d6d
	inc (ix+001h)		;9d6e
	ld de,00080h		;9d71
	call L_87EB		;9d74
	ld de,00020h		;9d77
	bit 0,(ix+00fh)		;9d7a
	call nz,L_8C0A		;9d7e
	jp L_87E4		;9d81
L_9D84:
	ld a,(0cd55h)		;9d84
	or a			;9d87
	jr z,L_9D98		;9d88
	call L_9DF0		;9d8a
	ld a,(ix+003h)		;9d8d
	cp (ix+010h)		;9d90
	ret c			;9d93
	ld hl,0cd55h		;9d94
	dec (hl)			;9d97
L_9D98:
	ld de,00000h		;9d98
	call L_87E4		;9d9b
	call L_87EB		;9d9e
	inc (ix+001h)		;9da1
	ret			;9da4
L_9DA5:
	ld a,(0cd55h)		;9da5
	or a			;9da8
	ret nz			;9da9
	inc (ix+001h)		;9daa
L_9DAD:
	ret			;9dad
L_9DAE:
	ld a,(0cd55h)		;9dae
	dec a			;9db1
	ret nz			;9db2
	inc (ix+001h)		;9db3
	ld (ix+025h),001h		;9db6
	ld (ix+02ah),042h		;9dba
	ld a,076h		;9dbe
	add a,(ix+00fh)		;9dc0
	ld (ix+00ah),a		;9dc3
	exx			;9dc6
	ld de,057edh		;9dc7
L_9DCA:
	exx			;9dca
	push ix		;9dcb
	pop hl			;9dcd
	jp 05503h		;9dce
L_9DD1:
	ld a,(0cd55h)		;9dd1
	cp 002h		;9dd4
	ret nz			;9dd6
	inc (ix+001h)		;9dd7
	ld (ix+025h),002h		;9dda
	ld (ix+02ah),044h		;9dde
	ld a,078h		;9de2
	add a,(ix+00fh)		;9de4
	ld (ix+00ah),a		;9de7
	exx			;9dea
	ld de,057f3h		;9deb
	jr L_9DCA		;9dee
L_9DF0:
	ld a,(ix+07eh)		;9df0
	bit 0,(ix+00fh)		;9df3
	jr z,L_9DFB		;9df7
	add a,002h		;9df9
L_9DFB:
	ld b,a			;9dfb
L_9DFC:
	ld a,(0c003h)		;9dfc
	rrca			;9dff
	rrca			;9e00
	rrca			;9e01
	and 001h		;9e02
	add a,b			;9e04
	ld (ix+00ah),a		;9e05
	jp L_8975		;9e08

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9e0b..0x9fca  (447 bytes)
DATA_9E0B:
	defb 019h,09eh,049h,09eh,082h,09eh,0c0h,09eh,0e8h,09eh,022h,09fh,05ah,09fh,034h,046h	; 9e0b  ..I.......".Z.4F
	defb 03bh,048h,000h,031h,05bh,05dh,043h,000h,03ch,058h,039h,043h,049h,0feh,055h,066h	; 9e1b  ;H.1[]C.<X9CI.Uf
	defb 037h,000h,05bh,035h,05eh,03fh,064h,000h,039h,039h,05ah,000h,030h,056h,03fh,051h	; 9e2b  7.[5^?d.99Z.0V?Q
	defb 0feh,055h,031h,000h,043h,048h,045h,000h,044h,058h,03eh,063h,064h,0ffh,044h,058h	; 9e3b  .U1.CHE.DX>cd.DX
	defb 04dh,043h,063h,000h,034h,046h,03bh,049h,000h,033h,056h,031h,064h,0feh,04fh,030h	; 9e4b  MCc.4F;I.3V1d.O0
	defb 038h,063h,03fh,000h,052h,05dh,03bh,063h,05fh,064h,000h,04dh,032h,04ah,063h,045h	; 9e5b  8c?.R];c_d.M2JcE
	defb 0feh,03fh,05dh,049h,063h,048h,000h,042h,042h,032h,040h,037h,063h,057h,05ch,000h	; 9e6b  .?]IcH.BB2@7cW\.
	defb 043h,056h,03dh,058h,03eh,063h,0ffh,044h,058h,04dh,043h,063h,03ah,063h,000h,05bh	; 9e7b  CV=X>c.DXMCc:c.[
	defb 058h,035h,05eh,03fh,043h,063h,064h,030h,053h,04eh,058h,064h,0feh,047h,05dh,037h	; 9e8b  X5^?Ccd0SNXd.G]7
	defb 063h,049h,000h,04bh,053h,03ah,05dh,064h,04dh,063h,032h,033h,031h,04ah,000h,052h	; 9e9b  cI.KS:]dMc231J.R
	defb 0feh,038h,03ch,063h,058h,064h,000h,039h,032h,053h,037h,000h,049h,000h,04eh,052h	; 9eab  .8<cXd.92S7.I.NR
	defb 058h,03eh,063h,064h,0ffh,031h,04eh,048h,000h,034h,046h,03bh,048h,039h,043h,049h	; 9ebb  X>cd.1NH.4F;H9CI
	defb 063h,042h,063h,0feh,05bh,03bh,052h,000h,051h,035h,063h,03ah,051h,03fh,064h,0feh	; 9ecb  cBc.[;R.Q5c:Q?d.
	defb 034h,049h,055h,032h,000h,044h,05dh,040h,05fh,05eh,042h,064h,0ffh,031h,04eh,04eh	; 9edb  4IU2.D]@_^Bd.1NN
	defb 042h,063h,048h,05bh,03bh,049h,000h,031h,048h,044h,035h,048h,000h,034h,035h,03ch	; 9eeb  BcH[;I.1HD5H.45<
	defb 063h,0feh,031h,053h,000h,035h,05bh,03ch,063h,042h,063h,000h,030h,05eh,03fh,064h	; 9efb  c.1S.5[<cBc.0^?d
	defb 0feh,052h,05eh,043h,03bh,061h,04fh,05dh,048h,03fh,051h,048h,03dh,031h,03bh,063h	; 9f0b  .R^C;aO]H?QH=1;c
	defb 05ch,03ch,058h,03eh,063h,064h,0ffh,03bh,061h,04fh,05dh,048h,000h,037h,058h,03bh	; 9f1b  \<X>cd.;aO]H.7X;
	defb 04fh,000h,055h,066h,037h,000h,05bh,035h,05eh,03fh,064h,0feh,052h,032h,000h,044h	; 9f2b  O.Uf7.[5^?d.R2.D
	defb 045h,052h,000h,031h,032h,042h,063h,044h,031h,064h,0feh,055h,031h,000h,03dh,031h	; 9f3b  ER.12BcD1d.U1.=1
	defb 03bh,063h,05ch,000h,053h,037h,03eh,037h,000h,03ch,058h,03eh,063h,064h,0ffh,04ah	; 9f4b  ;c\.S7>7.<X>cd.J
	defb 03ah,03bh,031h,048h,032h,064h,041h,031h,045h,039h,039h,04eh,042h,063h,036h,034h	; 9f5b  :;1H2dA1E99NBc64
	defb 05eh,03fh,035h,0feh,034h,046h,03bh,052h,000h,03dh,031h,040h,061h,032h,03bh,03fh	; 9f6b  ^?5.4F;R.=1@a2;?
	defb 064h,0feh,034h,046h,03bh,048h,000h,03bh,05dh,038h,063h,05dh,000h,036h,036h,031h	; 9f7b  d.4F;H.;]8c].661
	defb 059h,055h,032h,03eh,063h,064h,0ffh,034h,046h,03bh,000h,05bh,03bh,048h,03dh,031h	; 9f8b  YU2>cd.4F;.[;H=1
	defb 03bh,063h,045h,038h,040h,05ch,041h,038h,058h,035h,064h,0feh,031h,031h,000h,043h	; 9f9b  ;cE8@\A8X5d.11.C
	defb 063h,036h,061h,032h,03fh,063h,064h,0feh,041h,036h,063h,048h,03ch,042h,066h,03bh	; 9fab  c6a2?cd.A6cH<Bf;
	defb 063h,000h,034h,04dh,063h,033h,042h,034h,037h,035h,063h,031h,031h,064h,0ffh	; 9fbb  c.4Mc3B475c11d.

; ======================================================================
; CODIGO 0x9fca..0xa000  (54 bytes)
; ======================================================================


L_9FCA:
	xor a			;9fca
	ld (ix+07fh),a		;9fcb
	inc a			;9fce
	ld (ix+01dh),a		;9fcf
	call 0a067h		;9fd2
	call 0a028h		;9fd5
	call 0a954h		;9fd8
	jp L_893D		;9fdb
L_9FDE:
	ld de,0a008h		;9fde
	ld a,(ix+07fh)		;9fe1
	inc (ix+07fh)		;9fe4
	cp 020h		;9fe7
	jr nc,$+23		;9fe9
	call 04088h		;9feb
	ld a,(de)			;9fee
	add a,(ix+003h)		;9fef
	ld (ix+003h),a		;9ff2
	dec (ix+078h)		;9ff5
	ret nz			;9ff8
	ld a,(ix+077h)		;9ff9
	ld (ix+078h),a		;9ffc
	ret			;9fff
