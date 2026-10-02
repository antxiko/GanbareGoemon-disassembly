; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX1 - MegaROM RC-748 de 128 KB (Konami4) - banco 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
ladb4h:	equ 0x0adb4

; ======================================================================
; CODIGO 0xa000..0xa008  (8 bytes)
; ======================================================================


L_A000:
	call L_A080		;a000
	xor a			;a003
	ld (ix+01dh),a		;a004
	ret			;a007

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa008..0xa028  (32 bytes)
DATA_A008:
	defb 0fah,0fbh,0fch,0fdh,0fdh,0feh,0feh,0feh,0ffh,0ffh,000h,0ffh,000h,000h,000h,000h	; a008  ................
	defb 000h,000h,000h,000h,001h,000h,001h,001h,002h,002h,002h,003h,003h,004h,005h,006h	; a018  ................

; ======================================================================
; CODIGO 0xa028..0xa099  (113 bytes)
; ======================================================================


L_A028:
	ld a,(ix+01eh)		;a028
	or a			;a02b
	ret z			;a02c
	ld hl,00000h		;a02d
	ld de,00080h		;a030
	ld b,a			;a033
L_A034:
	add hl,de			;a034
	djnz L_A034		;a035
	ld a,(ix+01fh)		;a037
	and 003h		;a03a
	jr z,L_A03F		;a03c
	add hl,de			;a03e
L_A03F:
	ex de,hl			;a03f
	ld a,(ix+01fh)		;a040
	bit 1,a		;a043
	push af			;a045
	call nz,08c0ah		;a046
	pop af			;a049
	bit 3,a		;a04a
	push af			;a04c
	call nz,08c0ah		;a04d
	pop af			;a050
	and 003h		;a051
	jr z,L_A05E		;a053
	call 087e4h		;a055
	ld de,00000h		;a058
	jp 087ebh		;a05b
L_A05E:
	call 087ebh		;a05e
	ld de,00000h		;a061
	jp 087e4h		;a064
L_A067:
	ld d,(ix+006h)		;a067
	ld e,(ix+007h)		;a06a
	ld h,(ix+008h)		;a06d
	ld l,(ix+009h)		;a070
	ld (ix+07ch),d		;a073
	ld (ix+07bh),e		;a076
	ld (ix+07ah),h		;a079
	ld (ix+079h),l		;a07c
	ret			;a07f
L_A080:
	ld d,(ix+07ch)		;a080
	ld e,(ix+07bh)		;a083
	ld h,(ix+07ah)		;a086
	ld l,(ix+079h)		;a089
	ld (ix+006h),d		;a08c
	ld (ix+007h),e		;a08f
	ld (ix+008h),h		;a092
	ld (ix+009h),l		;a095
	ret			;a098

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa099..0xa0ed  (84 bytes)
DATA_A099:
	defb 001h,002h,001h,002h,008h,009h,008h,009h,00dh,00dh,00dh,00dh,010h,006h,006h,020h	; a099  ...............
	defb 019h,01ah,02ah,029h,000h,01bh,02bh,000h,015h,016h,026h,025h,003h,004h,003h,004h	; a0a9  ..*)..+...&%....
	defb 00ah,00ah,00ah,00ah,00eh,00eh,00eh,00eh,011h,007h,007h,021h,01eh,01fh,02fh,02eh	; a0b9  ...........!../.
	defb 01ch,01dh,02dh,02ch,017h,014h,024h,027h,005h,005h,005h,005h,00bh,00ch,00bh,00ch	; a0c9  ..-,..$'........
	defb 00fh,00fh,00fh,00fh,012h,007h,007h,022h,00ah,00ah,00ah,00ah,013h,014h,024h,023h	; a0d9  ......."......$#
	defb 018h,016h,026h,028h	; a0e9

; ======================================================================
; CODIGO 0xa0ed..0xa109  (28 bytes)
; ======================================================================


L_A0ED:
	call L_A3A1		;a0ed
	ld (ix+003h),030h		;a0f0
	ld (ix+00ch),001h		;a0f4
	ld a,06ah		;a0f8
	ld (ix+00ah),a		;a0fa
	ret			;a0fd
L_A0FE:
	ld b,06ah		;a0fe
	call 0891ah		;a100
	ld a,(ix+001h)		;a103
	call 0408dh		;a106

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa109..0xa10d  (4 bytes)
DATA_A109:
	defb 00dh,0a1h,030h,0a1h	; a109

; ======================================================================
; CODIGO 0xa10d..0xa1ae  (161 bytes)
; ======================================================================


L_A10D:
	ld de,0ff00h		;a10d
	call 087ebh		;a110
	ld de,00100h		;a113
	ld a,(0c49ah)		;a116
	cp (ix+005h)		;a119
	jr nc,L_A121		;a11c
	call 08c0ah		;a11e
L_A121:
	call 087e4h		;a121
	ld a,(ix+003h)		;a124
	add a,040h		;a127
	ld (ix+010h),a		;a129
	inc (ix+001h)		;a12c
	ret			;a12f
L_A130:
	ld a,(ix+003h)		;a130
	cp (ix+010h)		;a133
	jr nc,L_A149		;a136
	ld de,00030h		;a138
L_A13B:
	ld h,(ix+007h)		;a13b
	ld l,(ix+006h)		;a13e
	add hl,de			;a141
	ld (ix+007h),h		;a142
	ld (ix+006h),l		;a145
	ret			;a148
L_A149:
	ld (ix+001h),000h		;a149
	ret			;a14d
L_A14E:
	jp 08334h		;a14e
L_A151:
	ld a,04eh		;a151
	ld (ix+00ah),a		;a153
	ld a,(0c496h)		;a156
	cp 028h		;a159
	ld b,028h		;a15b
	jr c,L_A166		;a15d
	cp 098h		;a15f
	ld b,098h		;a161
	jr nc,L_A166		;a163
	ld b,a			;a165
L_A166:
	ld (ix+07ch),b		;a166
	ld a,b			;a169
	add a,040h		;a16a
	ld (ix+07bh),a		;a16c
	dec b			;a16f
	ld (ix+005h),b		;a170
	ld (ix+003h),010h		;a173
	ld de,00200h		;a177
	call 087ebh		;a17a
	ld de,00000h		;a17d
	call 087e4h		;a180
	ret			;a183
L_A184:
	ld a,(ix+009h)		;a184
	and 050h		;a187
	ld b,000h		;a189
	jr nz,L_A18F		;a18b
	ld b,002h		;a18d
L_A18F:
	ld a,(0c00dh)		;a18f
	and 00fh		;a192
	jr nz,L_A1A5		;a194
	ld a,(0c00dh)		;a196
	and 010h		;a199
	rra			;a19b
	rra			;a19c
	rra			;a19d
	rra			;a19e
	add a,b			;a19f
	add a,04eh		;a1a0
	ld (ix+00ah),a		;a1a2
L_A1A5:
	call L_A27A		;a1a5
	ld a,(ix+001h)		;a1a8
	call 0408dh		;a1ab

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa1ae..0xa1ba  (12 bytes)
DATA_A1AE:
	defb 0bah,0a1h,0d7h,0a1h,0f6h,0a1h,00ch,0a2h,031h,0a2h,06bh,0a2h	; a1ae  ........1.k.

; ======================================================================
; CODIGO 0xa1ba..0xa3c6  (524 bytes)
; ======================================================================


L_A1BA:
	ld a,(ix+003h)		;a1ba
	cp 030h		;a1bd
	ret c			;a1bf
	ld de,00200h		;a1c0
	call 08c0ah		;a1c3
	call 087e4h		;a1c6
	ld de,00100h		;a1c9
	call 087ebh		;a1cc
	ld (ix+010h),008h		;a1cf
	inc (ix+001h)		;a1d3
	ret			;a1d6
L_A1D7:
	ld de,00020h		;a1d7
	call L_A26C		;a1da
	ld a,(ix+005h)		;a1dd
	cp (ix+07ch)		;a1e0
	ret c			;a1e3
	inc (ix+001h)		;a1e4
	ld de,00200h		;a1e7
	call 087e4h		;a1ea
	ld de,00100h		;a1ed
	call 08c0ah		;a1f0
	jp 087ebh		;a1f3
L_A1F6:
	ld a,(ix+005h)		;a1f6
	cp (ix+07bh)		;a1f9
	ret c			;a1fc
	inc (ix+001h)		;a1fd
	ld de,00200h		;a200
	call 087e4h		;a203
	ld de,00100h		;a206
	jp 087ebh		;a209
L_A20C:
	ld de,00020h		;a20c
	call 08c0ah		;a20f
	call L_A26C		;a212
	ld a,(ix+005h)		;a215
	cp (ix+07bh)		;a218
	ret nc			;a21b
	inc (ix+001h)		;a21c
	ld de,00200h		;a21f
	call 08c0ah		;a222
	call 087e4h		;a225
	ld de,00100h		;a228
	call 08c0ah		;a22b
	jp 087ebh		;a22e
L_A231:
	ld a,(ix+005h)		;a231
	cp (ix+07ch)		;a234
	ret nc			;a237
	ld (ix+001h),001h		;a238
	ld de,00200h		;a23c
	call 08c0ah		;a23f
	call 087e4h		;a242
	ld de,00100h		;a245
	call 087ebh		;a248
	ld (ix+003h),030h		;a24b
	ld a,(ix+07ch)		;a24f
	dec a			;a252
	ld (ix+005h),a		;a253
	ld a,(ix+012h)		;a256
	or a			;a259
	ret z			;a25a
	ld de,0fd00h		;a25b
	call 087ebh		;a25e
	ld d,000h		;a261
	call 087e4h		;a263
	ld (ix+001h),005h		;a266
	ret			;a26a
L_A26B:
	ret			;a26b
L_A26C:
	ld h,(ix+009h)		;a26c
	ld l,(ix+008h)		;a26f
	add hl,de			;a272
	ld (ix+009h),h		;a273
	ld (ix+008h),l		;a276
	ret			;a279
L_A27A:
	dec (ix+011h)		;a27a
	jr nz,L_A283		;a27d
	ld (ix+012h),001h		;a27f
L_A283:
	ld a,(0c00dh)		;a283
	and 003h		;a286
	ret nz			;a288
	dec (ix+010h)		;a289
	ret nz			;a28c
	ld (ix+010h),008h		;a28d
	ld a,002h		;a291
	jp 089c2h		;a293
L_A296:
	ld (ix+071h),000h		;a296
	call L_A420		;a29a
	call 0893dh		;a29d
	ld (ix+003h),030h		;a2a0
	ld de,0fd00h		;a2a4
	call 087ebh		;a2a7
	call 08c0ah		;a2aa
	call L_A344		;a2ad
	ld de,00200h		;a2b0
	bit 0,(ix+00fh)		;a2b3
	call z,08c0ah		;a2b7
	call 087e4h		;a2ba
	ld a,(0cd12h)		;a2bd
	ld b,a			;a2c0
	ld a,018h		;a2c1
	sub b			;a2c3
	ld (ix+078h),a		;a2c4
	ld (ix+077h),a		;a2c7
	ld de,00080h		;a2ca
	jr L_A34B		;a2cd
L_A2CF:
	ld a,(0c00dh)		;a2cf
	and 01fh		;a2d2
	ld a,002h		;a2d4
	call z,04fe4h		;a2d6
	call L_A31F		;a2d9
	bit 0,(ix+071h)		;a2dc
	jr nz,L_A2ED		;a2e0
	ld a,(0c496h)		;a2e2
	sub (ix+005h)		;a2e5
	inc a			;a2e8
	cp 003h		;a2e9
	jr c,L_A309		;a2eb
L_A2ED:
	dec (ix+078h)		;a2ed
	ret nz			;a2f0
L_A2F1:
	ld a,(ix+077h)		;a2f1
	ld (ix+078h),a		;a2f4
	bit 0,(ix+00fh)		;a2f7
	jr z,L_A30F		;a2fb
	ld a,(0c49ah)		;a2fd
	sub (ix+005h)		;a300
	ret c			;a303
	cp 050h		;a304
	ret nc			;a306
	jr L_A319		;a307
L_A309:
	ld (ix+071h),001h		;a309
	jr L_A2F1		;a30d
L_A30F:
	ld a,(0c49ah)		;a30f
	sub (ix+005h)		;a312
	ret nc			;a315
	cp 0b0h		;a316
	ret c			;a318
L_A319:
	ld a,(ix+07dh)		;a319
	jp 089c2h		;a31c
L_A31F:
	call 0894dh		;a31f
	call L_A352		;a322
	call L_A13B		;a325
	call L_A359		;a328
	ld l,(ix+012h)		;a32b
	ld h,(ix+013h)		;a32e
	rst 20h			;a331
	ret nz			;a332
	call L_A352		;a333
	call 08c0ah		;a336
	call L_A34B		;a339
	call L_A359		;a33c
	call 08c0ah		;a33f
	jr L_A344		;a342
L_A344:
	ld (ix+012h),e		;a344
	ld (ix+013h),d		;a347
	ret			;a34a
L_A34B:
	ld (ix+010h),e		;a34b
	ld (ix+011h),d		;a34e
	ret			;a351
L_A352:
	ld e,(ix+010h)		;a352
	ld d,(ix+011h)		;a355
	ret			;a358
L_A359:
	ld e,(ix+006h)		;a359
	ld d,(ix+007h)		;a35c
	ret			;a35f
L_A360:
	ld a,(0cd5bh)		;a360
	or a			;a363
	ret nz			;a364
	jp 08334h		;a365
L_A368:
	call L_A3A1		;a368
	ld de,0a3c6h		;a36b
	call L_A398		;a36e
	and 003h		;a371
	call 0447ch		;a373
	ex de,hl			;a376
	ld e,(hl)			;a377
	inc hl			;a378
	ld d,(hl)			;a379
	bit 0,(ix+00fh)		;a37a
	call z,08c0ah		;a37e
	inc hl			;a381
	call 087e4h		;a382
	ld e,(hl)			;a385
	inc hl			;a386
	ld d,(hl)			;a387
	inc hl			;a388
	call 087ebh		;a389
	ld a,(hl)			;a38c
	ld (ix+011h),a		;a38d
	inc hl			;a390
	ld a,(hl)			;a391
	ld (ix+012h),a		;a392
	jp 0893dh		;a395
L_A398:
	ld a,r		;a398
	ld hl,0c00dh		;a39a
	xor (hl)			;a39d
	rra			;a39e
	rra			;a39f
	ret			;a3a0
L_A3A1:
	ld b,038h		;a3a1
	ld d,000h		;a3a3
	ld a,(0c496h)		;a3a5
	ld c,a			;a3a8
	cp 080h		;a3a9
	jr c,L_A3B2		;a3ab
	inc d			;a3ad
	ld a,c			;a3ae
	sub b			;a3af
	jr L_A3B4		;a3b0
L_A3B2:
	ld a,c			;a3b2
	add a,b			;a3b3
L_A3B4:
	jp c,087b7h		;a3b4
	ld (ix+00fh),d		;a3b7
	ld (ix+005h),a		;a3ba
	ld a,0c8h		;a3bd
	ld (ix+003h),a		;a3bf
	ld (ix+010h),a		;a3c2
	ret			;a3c5

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa3c6..0xa3e0  (26 bytes)
DATA_A3C6:
	defb 0ceh,0a3h,0d4h,0a3h,0d4h,0a3h,0dah,0a3h,080h,001h,000h,0fah,020h,000h,000h,002h	; a3c6  ............ ...
	defb 000h,0fah,040h,000h,000h,002h,080h,0fah,066h,000h	; a3d6  ..@.....f.

; ======================================================================
; CODIGO 0xa3e0..0xa481  (161 bytes)
; ======================================================================


L_A3E0:
	call 0894dh		;a3e0
	call 087b1h		;a3e3
	ld e,(ix+011h)		;a3e6
	ld d,(ix+012h)		;a3e9
	call L_A13B		;a3ec
	ld a,(ix+010h)		;a3ef
	cp (ix+003h)		;a3f2
	ret nc			;a3f5
	jp 087b7h		;a3f6
L_A3F9:
	call L_A420		;a3f9
	call 0893dh		;a3fc
	ld de,00000h		;a3ff
	call 087ebh		;a402
	call L_A46B		;a405
	bit 0,(ix+00fh)		;a408
	call nz,08c0ah		;a40c
	call 087e4h		;a40f
	ld a,(ix+00fh)		;a412
	or a			;a415
	ld a,001h		;a416
	jr nz,L_A41C		;a418
	ld a,002h		;a41a
L_A41C:
	ld (ix+01fh),a		;a41c
	ret			;a41f
L_A420:
	ld a,(0cd5bh)		;a420
	or a			;a423
	jp nz,087b7h		;a424
	ld a,(0c496h)		;a427
	add a,040h		;a42a
	cp 080h		;a42c
	jp c,087b7h		;a42e
	ld bc,00801h		;a431
	ld a,r		;a434
	ld hl,0c00dh		;a436
	xor (hl)			;a439
	bit 4,a		;a43a
	jr z,L_A441		;a43c
	ld b,0f8h		;a43e
	dec c			;a440
L_A441:
	ld d,b			;a441
	ld (ix+005h),b		;a442
	ld a,(0c494h)		;a445
	ld b,a			;a448
	add a,043h		;a449
	cp 0abh		;a44b
	jr nc,L_A458		;a44d
	ld a,b			;a44f
	ld b,068h		;a450
	cp 080h		;a452
	jr c,L_A458		;a454
	ld b,0beh		;a456
L_A458:
	ld a,b			;a458
	ld (ix+003h),a		;a459
	ld e,a			;a45c
	ld (ix+010h),a		;a45d
	ld (ix+00fh),c		;a460
	ld b,c			;a463
	call 0781fh		;a464
	ret nc			;a467
	jp 087b7h		;a468
L_A46B:
	ld a,(0cd12h)		;a46b
	srl a		;a46e
	srl a		;a470
	ld b,a			;a472
	add a,a			;a473
	add a,b			;a474
	ld hl,0a481h		;a475
	call 04083h		;a478
	ld e,(hl)			;a47b
	inc hl			;a47c
	ld d,(hl)			;a47d
	inc hl			;a47e
	ld a,(hl)			;a47f
	ret			;a480

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa481..0xa48d  (12 bytes)
DATA_A481:
	defb 000h,0ffh,040h,080h,0fdh,038h,040h,0fdh,030h,000h,0fdh,018h	; a481  ..@..8@.0...

; ======================================================================
; CODIGO 0xa48d..0xa4e6  (89 bytes)
; ======================================================================


L_A48D:
	call 0894dh		;a48d
	ld a,(ix+01dh)		;a490
	or a			;a493
	jp nz,09fdeh		;a494
	call L_A699		;a497
	ret nc			;a49a
	jp 09fcah		;a49b
L_A49E:
	call L_A420		;a49e
	ld (ix+00ah),041h		;a4a1
	ld (ix+00ch),001h		;a4a5
L_A4A9:
	ld de,0fe00h		;a4a9
	bit 0,(ix+00fh)		;a4ac
	call nz,08c0ah		;a4b0
	call 087e4h		;a4b3
	ld de,0fc80h		;a4b6
	jp 087ebh		;a4b9
L_A4BC:
	ld a,041h		;a4bc
	ld de,0c00dh		;a4be
	call 0895bh		;a4c1
	ld de,00066h		;a4c4
	call L_A13B		;a4c7
	ld a,(ix+010h)		;a4ca
	cp (ix+003h)		;a4cd
	ret nc			;a4d0
	jr L_A4A9		;a4d1
L_A4D3:
	call L_ABF6		;a4d3
L_A4D6:
	call L_A954		;a4d6
	call 0893dh		;a4d9
	call L_A567		;a4dc
	ld a,(ix+01fh)		;a4df
	ld (ix+019h),a		;a4e2
	ret			;a4e5

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa4e6..0xa4eb  (5 bytes)
DATA_A4E6:
	defb 0cdh,0b1h,085h,018h,0ebh	; a4e6

; ======================================================================
; CODIGO 0xa4eb..0xa4f1  (6 bytes)
; ======================================================================


L_A4EB:
	ld a,(ix+001h)		;a4eb
	call 0408dh		;a4ee

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa4f1..0xa4f5  (4 bytes)
DATA_A4F1:
	defb 0f5h,0a4h,02ah,0a7h	; a4f1

; ======================================================================
; CODIGO 0xa4f5..0xa579  (132 bytes)
; ======================================================================


L_A4F5:
	ld a,(ix+01dh)		;a4f5
	or a			;a4f8
	jp nz,09fdeh		;a4f9
	call L_A954		;a4fc
	call 0894dh		;a4ff
	call L_A699		;a502
	jr c,L_A52D		;a505
	ld a,(ix+01fh)		;a507
	and (ix+019h)		;a50a
	ret nz			;a50d
L_A50E:
	ld a,(ix+01fh)		;a50e
	and 003h		;a511
	jr nz,L_A521		;a513
	ld b,(ix+019h)		;a515
	call L_A683		;a518
	ld a,(ix+019h)		;a51b
	jr nc,$+108		;a51e
	ret			;a520
L_A521:
	ld b,(ix+01ah)		;a521
	call L_A683		;a524
	ld a,(ix+01ah)		;a527
	jr nc,$+96		;a52a
	ret			;a52c
L_A52D:
	call L_A625		;a52d
	jp nc,09fcah		;a530
	call L_A50E		;a533
	ret nc			;a536
	ld d,(ix+019h)		;a537
	ld e,(ix+01ah)		;a53a
	push de			;a53d
	ld a,003h		;a53e
	xor d			;a540
	ld (ix+019h),a		;a541
	ld a,00ch		;a544
	xor e			;a546
	ld (ix+01ah),a		;a547
	ld a,(ix+01fh)		;a54a
	ld (0cd58h),a		;a54d
	call L_A50E		;a550
	pop de			;a553
	call c,L_A560		;a554
	jp c,L_A611		;a557
	ld a,(0cd58h)		;a55a
	and 003h		;a55d
	ret nz			;a55f
L_A560:
	ld (ix+019h),d		;a560
	ld (ix+01ah),e		;a563
	ret			;a566
L_A567:
	ex af,af'			;a567
	ld a,(0c498h)		;a568
	cp (ix+003h)		;a56b
	ld a,008h		;a56e
	jr c,L_A574		;a570
	srl a		;a572
L_A574:
	ld (ix+01ah),a		;a574
	ex af,af'			;a577
	ret			;a578

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa579..0xa58a  (17 bytes)
DATA_A579:
	defb 0ddh,07eh,01ah,0eeh,00ch,0ddh,077h,01ah,0ddh,07eh,019h,0eeh,003h,0ddh,077h,019h	; a579  .~....w..~....w.
	defb 0c9h	; a589

; ======================================================================
; CODIGO 0xa58a..0xa5c8  (62 bytes)
; ======================================================================


L_A58A:
	or a			;a58a
	call z,L_A5B8		;a58b
L_A58E:
	ld (ix+01fh),a		;a58e
	push af			;a591
	ld a,(0cd12h)		;a592
	and 00ch		;a595
	add a,a			;a597
	add a,a			;a598
	ld hl,0a5d1h		;a599
	call 04083h		;a59c
	pop af			;a59f
L_A5A0:
	rra			;a5a0
	jr c,L_A5A9		;a5a1
	inc hl			;a5a3
	inc hl			;a5a4
	inc hl			;a5a5
	inc hl			;a5a6
	jr L_A5A0		;a5a7
L_A5A9:
	ld e,(hl)			;a5a9
	inc hl			;a5aa
	ld d,(hl)			;a5ab
	inc hl			;a5ac
	call 087ebh		;a5ad
	ld e,(hl)			;a5b0
	inc hl			;a5b1
	ld d,(hl)			;a5b2
	call 087e4h		;a5b3
	or a			;a5b6
	ret			;a5b7
L_A5B8:
	ld a,(ix+003h)		;a5b8
	ld hl,(0c494h)		;a5bb
	cp (hl)			;a5be
	ld a,008h		;a5bf
	ret c			;a5c1
	ld a,004h		;a5c2
	ret nz			;a5c4
	ld a,002h		;a5c5
	ret			;a5c7

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa5c8..0xa611  (73 bytes)
DATA_A5C8:
	defb 0e6h,003h,0c8h,0e6h,001h,0ddh,077h,00fh,0c9h,000h,000h,000h,001h,000h,000h,000h	; a5c8  ......w.........
	defb 0ffh,000h,001h,000h,000h,000h,0ffh,000h,000h,000h,000h,040h,001h,000h,000h,0c0h	; a5d8  ...........@....
	defb 0feh,040h,001h,000h,000h,0c0h,0feh,000h,000h,000h,000h,080h,001h,000h,000h,080h	; a5e8  .@..............
	defb 0feh,080h,001h,000h,000h,080h,0feh,000h,000h,000h,000h,000h,002h,000h,000h,000h	; a5f8  ................
	defb 0feh,000h,002h,000h,000h,000h,0feh,000h,000h	; a608  .........

; ======================================================================
; CODIGO 0xa611..0xa67b  (106 bytes)
; ======================================================================


L_A611:
	ld a,(ix+01fh)		;a611
	and 00ch		;a614
	jr nz,L_A620		;a616
	ld a,(ix+01fh)		;a618
	xor 003h		;a61b
	jp L_A58A		;a61d
L_A620:
	xor 00ch		;a620
	jp L_A58A		;a622
L_A625:
	ld a,(ix+01eh)		;a625
	or a			;a628
	jr z,L_A679		;a629
	ld hl,0a67bh		;a62b
	ld a,(ix+01fh)		;a62e
L_A631:
	rra			;a631
	jr c,L_A638		;a632
	inc hl			;a634
	inc hl			;a635
	jr L_A631		;a636
L_A638:
	ld a,(hl)			;a638
	inc hl			;a639
	ld l,(hl)			;a63a
	ld h,a			;a63b
	ld d,(ix+005h)		;a63c
	ld e,(ix+003h)		;a63f
	push de			;a642
	ex de,hl			;a643
	ld b,(ix+01eh)		;a644
L_A647:
	push af			;a647
	ld a,h			;a648
	add a,d			;a649
	ld h,a			;a64a
	add a,020h		;a64b
	cp 030h		;a64d
	jr c,L_A671		;a64f
	ld a,l			;a651
	add a,e			;a652
	ld l,a			;a653
	add a,030h		;a654
	cp 080h		;a656
	jr c,L_A671		;a658
	pop af			;a65a
	djnz L_A647		;a65b
	ld (ix+005h),h		;a65d
	ld (ix+003h),l		;a660
	call 0877ah		;a663
	call L_A6BC		;a666
	pop de			;a669
	ld (ix+005h),d		;a66a
	ld (ix+003h),e		;a66d
	ret			;a670
L_A671:
	pop af			;a671
	pop de			;a672
	ld (ix+005h),d		;a673
	ld (ix+003h),e		;a676
L_A679:
	scf			;a679
	ret			;a67a

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa67b..0xa683  (8 bytes)
DATA_A67B:
	defb 010h,000h,0f0h,000h,000h,010h,000h,0f0h	; a67b  ........

; ======================================================================
; CODIGO 0xa683..0xa770  (237 bytes)
; ======================================================================


L_A683:
	ld a,(ix+01fh)		;a683
	ld (0cd5ah),a		;a686
	ld a,b			;a689
	call L_A58A		;a68a
	call L_A699		;a68d
	push af			;a690
	ld a,(0cd5ah)		;a691
	call L_A58A		;a694
	pop af			;a697
	ret			;a698
L_A699:
	ld e,(ix+002h)		;a699
	ld d,(ix+003h)		;a69c
	push de			;a69f
	ld e,(ix+004h)		;a6a0
	ld d,(ix+005h)		;a6a3
	push de			;a6a6
	call 0877ah		;a6a7
	call L_A6BC		;a6aa
	pop de			;a6ad
	ld (ix+004h),e		;a6ae
	ld (ix+005h),d		;a6b1
	pop de			;a6b4
	ld (ix+002h),e		;a6b5
	ld (ix+003h),d		;a6b8
	ret			;a6bb
L_A6BC:
	ld a,(ix+01fh)		;a6bc
	ld d,000h		;a6bf
L_A6C1:
	rra			;a6c1
	jr c,L_A6C7		;a6c2
	inc d			;a6c4
	jr L_A6C1		;a6c5
L_A6C7:
	ld a,d			;a6c7
	ld d,(ix+005h)		;a6c8
	ld e,(ix+003h)		;a6cb
	cp 001h		;a6ce
	jr c,L_A6DA		;a6d0
	jr z,L_A6ED		;a6d2
	cp 002h		;a6d4
	jr z,L_A715		;a6d6
	jr L_A700		;a6d8
L_A6DA:
	ld a,d			;a6da
	add a,008h		;a6db
	ccf			;a6dd
	ret nc			;a6de
	ld d,a			;a6df
	push de			;a6e0
	call 0781fh		;a6e1
	pop de			;a6e4
	ret c			;a6e5
	ld a,e			;a6e6
	sub 003h		;a6e7
	ld e,a			;a6e9
	jp 0781fh		;a6ea
L_A6ED:
	ld a,d			;a6ed
	sub 008h		;a6ee
	ccf			;a6f0
	ret nc			;a6f1
	ld d,a			;a6f2
	push de			;a6f3
	call 0781fh		;a6f4
	pop de			;a6f7
	ret c			;a6f8
	ld a,e			;a6f9
	sub 003h		;a6fa
	ld e,a			;a6fc
	jp 0781fh		;a6fd
L_A700:
	ld a,e			;a700
	sub 003h		;a701
	ld e,a			;a703
	push de			;a704
	ld a,d			;a705
	sub 008h		;a706
	ld d,a			;a708
	call 0781fh		;a709
	pop de			;a70c
	ret c			;a70d
	ld a,d			;a70e
	add a,008h		;a70f
	ld d,a			;a711
	jp 0781fh		;a712
L_A715:
	ld a,0c8h		;a715
	cp e			;a717
	ret c			;a718
	push de			;a719
	ld a,d			;a71a
	sub 008h		;a71b
	ld d,a			;a71d
	call 0781fh		;a71e
	pop de			;a721
	ret c			;a722
	ld a,d			;a723
	add a,008h		;a724
	ld d,a			;a726
	jp 0781fh		;a727
L_A72A:
	dec (ix+00bh)		;a72a
	ret nz			;a72d
	ld a,(ix+01fh)		;a72e
	call L_A58A		;a731
	ld a,043h		;a734
	ld (ix+00ah),a		;a736
	dec (ix+00eh)		;a739
	dec (ix+001h)		;a73c
	ld (ix+00ch),003h		;a73f
	call L_A4D6		;a743
	ret			;a746
L_A747:
	call L_ABF6		;a747
	call L_A954		;a74a
	call 0893dh		;a74d
L_A750:
	ld a,(ix+00bh)		;a750
	ld (ix+015h),a		;a753
	ld (ix+013h),070h		;a756
	ld (ix+072h),003h		;a75a
	ld (ix+070h),001h		;a75e
	ret			;a762
L_A763:
	ld a,(ix+01dh)		;a763
	or a			;a766
	jp nz,09fdeh		;a767
	ld a,(ix+001h)		;a76a
	call 0408dh		;a76d

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa770..0xa778  (8 bytes)
DATA_A770:
	defb 010h,0a8h,014h,0a8h,088h,0a9h,09fh,0a9h	; a770  ........

; ======================================================================
; CODIGO 0xa778..0xa785  (13 bytes)
; ======================================================================


L_A778:
	ld a,(ix+01dh)		;a778
	or a			;a77b
	jp nz,09fdeh		;a77c
	ld a,(ix+001h)		;a77f
	call 0408dh		;a782

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa785..0xa78d  (8 bytes)
DATA_A785:
	defb 014h,0a8h,014h,0a8h,0eah,0a8h,0feh,0a8h	; a785  ........

; ======================================================================
; CODIGO 0xa78d..0xa800  (115 bytes)
; ======================================================================


L_A78D:
	ld a,(ix+00fh)		;a78d
	or a			;a790
	jr z,L_A7AB		;a791
	ld a,(0c496h)		;a793
	sub (ix+005h)		;a796
L_A799:
	ccf			;a799
	ret nc			;a79a
	cp 020h		;a79b
	ret nc			;a79d
	ld a,(0c494h)		;a79e
	sub (ix+003h)		;a7a1
	jr nc,L_A7A8		;a7a4
	neg		;a7a6
L_A7A8:
	cp 010h		;a7a8
	ret			;a7aa
L_A7AB:
	ld a,(ix+005h)		;a7ab
	ld hl,0c496h		;a7ae
	sub (hl)			;a7b1
	jr L_A799		;a7b2
L_A7B4:
	call L_A78D		;a7b4
	jr nc,L_A7FA		;a7b7
	ld a,(ix+07eh)		;a7b9
	call 08938h		;a7bc
	ld a,(ix+073h)		;a7bf
	ld de,0a800h		;a7c2
	bit 0,(ix+00fh)		;a7c5
	jr z,L_A7CE		;a7c9
	ld de,0a808h		;a7cb
L_A7CE:
	add a,e			;a7ce
	ld e,a			;a7cf
	jr nc,L_A7D3		;a7d0
	inc d			;a7d2
L_A7D3:
	ld a,(de)			;a7d3
	call L_A58E		;a7d4
	ld a,(ix+073h)		;a7d7
	inc a			;a7da
	cp 008h		;a7db
	jr nz,L_A7E0		;a7dd
	xor a			;a7df
L_A7E0:
	ld (ix+073h),a		;a7e0
	bit 0,(ix+074h)		;a7e3
	jr nz,L_A7F4		;a7e7
	ld (ix+00bh),012h		;a7e9
	ld (ix+073h),000h		;a7ed
	call 0893dh		;a7f1
L_A7F4:
	ld (ix+074h),001h		;a7f4
	jr $+47		;a7f8
L_A7FA:
	ld (ix+074h),000h		;a7fa
	jr $+35		;a7fe

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa800..0xa810  (16 bytes)
DATA_A800:
	defb 002h,002h,001h,008h,002h,002h,001h,004h,001h,001h,002h,008h,001h,001h,002h,004h	; a800  ................

; ======================================================================
; CODIGO 0xa810..0xaa51  (577 bytes)
; ======================================================================


L_A810:
	call L_A966		;a810
	ret c			;a813
L_A814:
	ld a,(ix+000h)		;a814
	cp 019h		;a817
	jp z,L_A7B4		;a819
	cp 020h		;a81c
	jp z,L_A7B4		;a81e
L_A821:
	call L_A954		;a821
	call 0894dh		;a824
L_A827:
	ld a,(ix+001h)		;a827
	dec a			;a82a
	jr z,L_A83C		;a82b
	ld a,(0c00dh)		;a82d
	and 003h		;a830
	jr nz,L_A83C		;a832
	dec (ix+013h)		;a834
	jr nz,L_A83C		;a837
	inc (ix+001h)		;a839
L_A83C:
	call L_A699		;a83c
	jr nc,L_A84A		;a83f
	call L_A625		;a841
	jp c,L_A8A2		;a844
	jp 09fcah		;a847
L_A84A:
	ld (ix+076h),000h		;a84a
	call L_A917		;a84e
	dec (ix+00bh)		;a851
	ret nz			;a854
	ld hl,0c00dh		;a855
	ld a,r		;a858
	xor (hl)			;a85a
	and 01fh		;a85b
	add a,(ix+015h)		;a85d
	ld (ix+00bh),a		;a860
	call L_A8B3		;a863
	ld a,(ix+070h)		;a866
	and 003h		;a869
	jr nz,L_A894		;a86b
	ld (ix+070h),001h		;a86d
	ld a,(ix+016h)		;a871
	cp (ix+017h)		;a874
	jr nc,L_A887		;a877
L_A879:
	ld hl,0cd20h		;a879
	ld a,004h		;a87c
	bit 0,(hl)		;a87e
	jr z,L_A884		;a880
	add a,004h		;a882
L_A884:
	jp L_A58E		;a884
L_A887:
	ld hl,0cd21h		;a887
	ld a,001h		;a88a
	bit 0,(hl)		;a88c
	jr z,L_A891		;a88e
	inc a			;a890
L_A891:
	jp L_A58E		;a891
L_A894:
	inc (ix+070h)		;a894
	ld a,(ix+01fh)		;a897
	or a			;a89a
	ret z			;a89b
	and 003h		;a89c
	jr z,L_A887		;a89e
	jr L_A879		;a8a0
L_A8A2:
	call L_A8B3		;a8a2
	ld a,(ix+076h)		;a8a5
	inc a			;a8a8
	ld (ix+076h),a		;a8a9
	cp 002h		;a8ac
	jr nc,L_A894		;a8ae
	jp L_A611		;a8b0
L_A8B3:
	ld a,(ix+001h)		;a8b3
	dec a			;a8b6
	jr z,L_A8DE		;a8b7
	ld hl,0cd20h		;a8b9
	ld (hl),000h		;a8bc
	ld a,(0c494h)		;a8be
	sub (ix+003h)		;a8c1
	jr nc,L_A8C9		;a8c4
	neg		;a8c6
	inc (hl)			;a8c8
L_A8C9:
	ld (ix+017h),a		;a8c9
	inc hl			;a8cc
	ld (hl),000h		;a8cd
	ld a,(0c496h)		;a8cf
	sub (ix+005h)		;a8d2
	jr nc,L_A8DA		;a8d5
	neg		;a8d7
	inc (hl)			;a8d9
L_A8DA:
	ld (ix+016h),a		;a8da
	ret			;a8dd
L_A8DE:
	xor a			;a8de
	ld (0cd20h),a		;a8df
	ld (0cd21h),a		;a8e2
	ld (ix+017h),a		;a8e5
	jr L_A8DA		;a8e8
L_A8EA:
	dec (ix+00bh)		;a8ea
	ret nz			;a8ed
	ld a,004h		;a8ee
	call L_A58E		;a8f0
	dec (ix+00eh)		;a8f3
	ld (ix+00ch),003h		;a8f6
	inc (ix+001h)		;a8fa
	ret			;a8fd
L_A8FE:
	call L_A954		;a8fe
	ld a,04ah		;a901
	call 08950h		;a903
	ld a,(ix+003h)		;a906
	cp 060h		;a909
	ret c			;a90b
	call L_AA04		;a90c
	call L_A750		;a90f
	ld (ix+001h),000h		;a912
	ret			;a916
L_A917:
	ld a,(ix+001h)		;a917
	dec a			;a91a
	ret z			;a91b
	ld a,(ix+000h)		;a91c
	ld b,a			;a91f
	cp 015h		;a920
	ret z			;a922
	dec (ix+078h)		;a923
	ret nz			;a926
	ld a,b			;a927
	cp 00fh		;a928
	jr nz,L_A93A		;a92a
	ld a,(ix+072h)		;a92c
	dec a			;a92f
	jr z,L_A94E		;a930
	ld (ix+072h),a		;a932
	call L_A46B		;a935
	jr L_A93D		;a938
L_A93A:
	ld a,(ix+077h)		;a93a
L_A93D:
	ld (ix+078h),a		;a93d
	ld a,(ix+00fh)		;a940
	ld (0cd38h),a		;a943
	ld a,(ix+07dh)		;a946
	or a			;a949
	ret z			;a94a
	jp 089c2h		;a94b
L_A94E:
	ld (ix+072h),003h		;a94e
	jr L_A93A		;a952
L_A954:
	ld a,(ix+001h)		;a954
	cp 002h		;a957
	ret z			;a959
	ld a,(ix+01fh)		;a95a
	and 003h		;a95d
	ret z			;a95f
	and 001h		;a960
	ld (ix+00fh),a		;a962
	ret			;a965
L_A966:
	dec (ix+078h)		;a966
	ret nz			;a969
	call L_A067		;a96a
	ld de,00000h		;a96d
	call 087e4h		;a970
	call 087ebh		;a973
	ld (ix+078h),014h		;a976
	ld a,068h		;a97a
	add a,(ix+00fh)		;a97c
	ld (ix+00ah),a		;a97f
	ld (ix+001h),002h		;a982
	scf			;a986
	ret			;a987
L_A988:
	dec (ix+078h)		;a988
	ret nz			;a98b
	ld (ix+078h),014h		;a98c
	ld a,(ix+00fh)		;a990
	ld (0cd38h),a		;a993
	inc (ix+001h)		;a996
	ld a,(ix+07dh)		;a999
	jp 089c2h		;a99c
L_A99F:
	dec (ix+078h)		;a99f
	ret nz			;a9a2
	ld a,(ix+077h)		;a9a3
	ld (ix+078h),a		;a9a6
	ld (ix+001h),000h		;a9a9
	call 0893dh		;a9ad
	jp L_A080		;a9b0
L_A9B3:
	dec (ix+012h)		;a9b3
	jp z,087b7h		;a9b6
	ld a,(ix+011h)		;a9b9
	xor 001h		;a9bc
	ld (ix+011h),a		;a9be
	jr z,L_A9CB		;a9c1
	ld a,(ix+005h)		;a9c3
	inc a			;a9c6
	ld (ix+005h),a		;a9c7
	ret			;a9ca
L_A9CB:
	ld a,(ix+005h)		;a9cb
	dec a			;a9ce
	ld (ix+005h),a		;a9cf
	ret			;a9d2
L_A9D3:
	ld a,(ix+000h)		;a9d3
	cp 021h		;a9d6
	jr nz,L_A9E5		;a9d8
	ld hl,0cd60h		;a9da
	ld a,(hl)			;a9dd
	add a,001h		;a9de
	jr nc,L_A9E4		;a9e0
	ld a,008h		;a9e2
L_A9E4:
	ld (hl),a			;a9e4
L_A9E5:
	ld a,(ix+003h)		;a9e5
	ld (ix+010h),a		;a9e8
	ld (ix+011h),000h		;a9eb
	ld (ix+00ch),000h		;a9ef
	ld (ix+012h),020h		;a9f3
	ld de,00000h		;a9f7
	call 087e4h		;a9fa
	call 087ebh		;a9fd
	inc (ix+00dh)		;aa00
	ret			;aa03
L_AA04:
	ld a,(ix+000h)		;aa04
	cp 022h		;aa07
	ret nc			;aa09
	dec a			;aa0a
	add a,a			;aa0b
	add a,a			;aa0c
	ld de,0aa51h		;aa0d
	call 04088h		;aa10
	ld a,(de)			;aa13
	ld (ix+07eh),a		;aa14
	inc de			;aa17
	ld a,(de)			;aa18
	ld h,010h		;aa19
	call L_AA40		;aa1b
	ld (ix+00bh),a		;aa1e
	inc de			;aa21
	ld a,(de)			;aa22
	ld c,a			;aa23
	and 01fh		;aa24
	ld (ix+07dh),a		;aa26
	ld a,c			;aa29
	rlca			;aa2a
	rlca			;aa2b
	and 003h		;aa2c
	ld (ix+01eh),a		;aa2e
	inc de			;aa31
	ld a,(de)			;aa32
	ld h,020h		;aa33
	call L_AA40		;aa35
	ld (ix+078h),008h		;aa38
	ld (ix+077h),a		;aa3c
	ret			;aa3f
L_AA40:
	ld c,a			;aa40
	ld a,(0cd12h)		;aa41
	add a,a			;aa44
	ld b,a			;aa45
	add a,a			;aa46
	add a,b			;aa47
	ld b,a			;aa48
	ld a,c			;aa49
	sub b			;aa4a
	jr c,L_AA4F		;aa4b
	cp h			;aa4d
	ret nc			;aa4e
L_AA4F:
	ld a,h			;aa4f
	ret			;aa50

; ----------------------------------------------------------------------
; DATOS sin identificar  0xaa51..0xaad5  (132 bytes)
DATA_AA51:
	defb 06ah,000h,000h,000h,08fh,000h,001h,00ah,04eh,000h,002h,000h,030h,000h,000h,000h	; aa51  j.......N...0...
	defb 004h,000h,0c0h,000h,041h,000h,000h,000h,06eh,000h,080h,000h,043h,000h,000h,000h	; aa61  ....A...n...C...
	defb 004h,014h,080h,000h,038h,020h,084h,040h,08bh,000h,005h,030h,08bh,000h,005h,010h	; aa71  ....8 .@...0....
	defb 04ah,030h,0c0h,000h,04ah,040h,0c0h,000h,034h,035h,0c3h,0a0h,00ch,000h,040h,000h	; aa81  J0..J@..45....@.
	defb 008h,030h,080h,000h,07ah,000h,080h,000h,004h,000h,040h,000h,01ch,000h,040h,000h	; aa91  .0..z.....@...@.
	defb 05ch,038h,0c6h,0c0h,060h,034h,080h,000h,08bh,027h,080h,000h,024h,032h,080h,000h	; aaa1  \8..`4...'..$2..
	defb 020h,02dh,080h,000h,064h,038h,080h,000h,06eh,000h,080h,000h,06eh,000h,040h,000h	; aab1   -..d8..n...n.@.
	defb 072h,000h,000h,000h,054h,000h,080h,000h,028h,03fh,007h,062h,02ch,034h,080h,000h	; aac1  r...T...(?.b,4..
	defb 000h,000h,000h,000h	; aad1

; ======================================================================
; CODIGO 0xaad5..0xab1d  (72 bytes)
; ======================================================================


L_AAD5:
	ld (ix+00ah),038h		;aad5
	ld (ix+01fh),008h		;aad9
	ld (ix+018h),040h		;aadd
	ld (ix+00bh),020h		;aae1
	ld a,r		;aae5
	ld b,a			;aae7
	ld a,(0c00dh)		;aae8
	add a,b			;aaeb
	ld (ix+005h),a		;aaec
	ld a,(0c00dh)		;aaef
	add a,(ix+005h)		;aaf2
	and 080h		;aaf5
	add a,050h		;aaf7
	ld (ix+003h),a		;aaf9
	ld a,0e0h		;aafc
	ld (00075h),a		;aafe
	ld a,(0cd5bh)		;ab01
	or a			;ab04
	jr z,$+58		;ab05
	call 085b1h		;ab07
	jr $+53		;ab0a
L_AB0C:
	call L_ABC4		;ab0c
	call L_AB8C		;ab0f
	ld a,038h		;ab12
	call 08950h		;ab14
	ld a,(ix+001h)		;ab17
	call 0408dh		;ab1a

; ----------------------------------------------------------------------
; DATOS sin identificar  0xab1d..0xab25  (8 bytes)
DATA_AB1D:
	defb 025h,0abh,053h,0abh,0b2h,0abh,0c3h,0abh	; ab1d  %.S.....

; ======================================================================
; CODIGO 0xab25..0xac0e  (233 bytes)
; ======================================================================


L_AB25:
	call L_A699		;ab25
	jr c,L_AB3F		;ab28
	dec (ix+00bh)		;ab2a
	ret nz			;ab2d
L_AB2E:
	ld (ix+00bh),020h		;ab2e
	ld de,00000h		;ab32
	call 087ebh		;ab35
	call 087e4h		;ab38
	inc (ix+001h)		;ab3b
	ret			;ab3e
L_AB3F:
	ld (ix+001h),002h		;ab3f
	call 09fcah		;ab43
	ld a,010h		;ab46
	call 08b76h		;ab48
	call 087e4h		;ab4b
	ex de,hl			;ab4e
	call 087ebh		;ab4f
	ret			;ab52
L_AB53:
	ld a,(0c00dh)		;ab53
	and 003h		;ab56
	jr nz,L_AB62		;ab58
	ld a,(ix+00fh)		;ab5a
	xor 001h		;ab5d
	ld (ix+00fh),a		;ab5f
L_AB62:
	dec (ix+00bh)		;ab62
	ret nz			;ab65
	ld a,(0cd12h)		;ab66
	and 00ch		;ab69
	rra			;ab6b
	add a,008h		;ab6c
	call 08b76h		;ab6e
	call 087e4h		;ab71
	ex de,hl			;ab74
	call 087ebh		;ab75
	ld a,080h		;ab78
	cp h			;ab7a
	ld a,000h		;ab7b
	jr nc,L_AB80		;ab7d
	inc a			;ab7f
L_AB80:
	ld (ix+00fh),a		;ab80
	ld (ix+00bh),020h		;ab83
	ld (ix+001h),000h		;ab87
	ret			;ab8b
L_AB8C:
	dec (ix+018h)		;ab8c
	ret nz			;ab8f
	ld a,(0cd12h)		;ab90
	add a,a			;ab93
	add a,a			;ab94
	ld b,a			;ab95
	ld a,040h		;ab96
	sub b			;ab98
	ld (ix+018h),a		;ab99
	ld a,(ix+01dh)		;ab9c
	or a			;ab9f
	ret nz			;aba0
	ld a,004h		;aba1
	call 089c2h		;aba3
	ld a,005h		;aba6
	call 04fe4h		;aba8
	ld (ix+001h),000h		;abab
	jp L_AB2E		;abaf
L_ABB2:
	call 09fdeh		;abb2
	ld a,(ix+01dh)		;abb5
	or a			;abb8
	ret nz			;abb9
	ld (ix+00bh),020h		;abba
	ld (ix+001h),001h		;abbe
	ret			;abc2
L_ABC3:
	ret			;abc3
L_ABC4:
	dec (ix+075h)		;abc4
	ret nz			;abc7
	ld a,001h		;abc8
	ld (ix+007h),a		;abca
	ld a,003h		;abcd
	ld (ix+001h),a		;abcf
	ret			;abd2
L_ABD3:
	call L_ABF6		;abd3
	call L_A954		;abd6
	call 0893dh		;abd9
	ld a,(ix+000h)		;abdc
	cp 00bh		;abdf
	ld a,030h		;abe1
	jr z,L_ABE7		;abe3
	ld a,018h		;abe5
L_ABE7:
	ld (ix+018h),a		;abe7
	ld (ix+077h),a		;abea
	ld (ix+00bh),03fh		;abed
	ld (ix+075h),040h		;abf1
	ret			;abf5
L_ABF6:
	ld a,(0cd5bh)		;abf6
	or a			;abf9
	jp z,09763h		;abfa
	jp 085b1h		;abfd
L_AC00:
	call L_A954		;ac00
	ld a,08bh		;ac03
	call 0894dh		;ac05
	ld a,(ix+001h)		;ac08
	call 0408dh		;ac0b

; ----------------------------------------------------------------------
; DATOS sin identificar  0xac0e..0xac12  (4 bytes)
DATA_AC0E:
	defb 012h,0ach,0c5h,0ach	; ac0e

; ======================================================================
; CODIGO 0xac12..0xac69  (87 bytes)
; ======================================================================


L_AC12:
	call L_ACB7		;ac12
	call L_AC6D		;ac15
	call L_A699		;ac18
	call c,L_A611		;ac1b
	call L_AC83		;ac1e
	call L_AC98		;ac21
	dec (ix+00bh)		;ac24
	ret nz			;ac27
	ld a,r		;ac28
	and 01fh		;ac2a
	add a,008h		;ac2c
	ld (ix+00bh),a		;ac2e
	ld a,r		;ac31
	ld b,a			;ac33
	ld a,(0c00dh)		;ac34
	xor b			;ac37
	and 007h		;ac38
	cp 004h		;ac3a
	jr nc,L_AC49		;ac3c
	ld de,0ac69h		;ac3e
	call 04088h		;ac41
	ld a,(de)			;ac44
	call L_A58A		;ac45
	ret			;ac48
L_AC49:
	cp 006h		;ac49
	jr nc,L_AC5A		;ac4b
	ld a,(ix+00fh)		;ac4d
	or a			;ac50
	ld a,002h		;ac51
	jp z,L_A58A		;ac53
	rra			;ac56
	jp L_A58A		;ac57
L_AC5A:
	ld a,(0c494h)		;ac5a
	cp (ix+003h)		;ac5d
	ld a,008h		;ac60
	jp c,L_A58A		;ac62
	rra			;ac65
	jp L_A58A		;ac66

; ----------------------------------------------------------------------
; DATOS sin identificar  0xac69..0xac6d  (4 bytes)
DATA_AC69:
	defb 008h,004h,002h,001h	; ac69

; ======================================================================
; CODIGO 0xac6d..0xad7e  (273 bytes)
; ======================================================================


L_AC6D:
	ld a,(ix+01fh)		;ac6d
	and 00ch		;ac70
	ret z			;ac72
	ld a,(ix+005h)		;ac73
	ld hl,0c496h		;ac76
	cp (hl)			;ac79
	ld a,000h		;ac7a
	jr nc,L_AC7F		;ac7c
	inc a			;ac7e
L_AC7F:
	ld (ix+00fh),a		;ac7f
	ret			;ac82
L_AC83:
	ld a,(0c00dh)		;ac83
	and 003h		;ac86
	ret nz			;ac88
	dec (ix+018h)		;ac89
	ret nz			;ac8c
	ld (ix+01dh),001h		;ac8d
	ld a,(ix+077h)		;ac91
	ld (ix+018h),a		;ac94
	ret			;ac97
L_AC98:
	ld a,(ix+01dh)		;ac98
	or a			;ac9b
	ret z			;ac9c
	ld a,(0c494h)		;ac9d
	add a,010h		;aca0
	sub (ix+003h)		;aca2
	cp 020h		;aca5
	ret nc			;aca7
	ld (ix+01dh),000h		;aca8
	ld a,(ix+00fh)		;acac
	ld (0cd38h),a		;acaf
	ld a,005h		;acb2
	jp 089c2h		;acb4
L_ACB7:
	ld a,(0c00dh)		;acb7
	and 003h		;acba
	ret nz			;acbc
	dec (ix+075h)		;acbd
	ret nz			;acc0
	inc (ix+001h)		;acc1
	ret			;acc4
L_ACC5:
	call L_A699		;acc5
	ret nc			;acc8
	or a			;acc9
	ld a,(ix+01fh)		;acca
	rr a		;accd
	jr nc,L_ACD3		;accf
	ld a,008h		;acd1
L_ACD3:
	jp L_A58A		;acd3
L_ACD6:
	ld de,0806dh		;acd6
	ld a,022h		;acd9
	jp 08334h		;acdb
L_ACDE:
	ld de,0806dh		;acde
	ld a,023h		;ace1
	jp 08334h		;ace3
L_ACE6:
	ld (ix+00ah),010h		;ace6
	xor a			;acea
	ld (ix+00ch),a		;aceb
	ld (ix+006h),a		;acee
	ld (ix+007h),a		;acf1
	ld de,00100h		;acf4
	ld (ix+008h),e		;acf7
	ld (ix+009h),d		;acfa
	ret			;acfd
L_ACFE:
	ld a,010h		;acfe
	ld de,0c00dh		;ad00
	call 0895bh		;ad03
	ld a,(ix+001h)		;ad06
	or a			;ad09
	jr nz,L_AD25		;ad0a
	ld a,(ix+005h)		;ad0c
	cp 0a0h		;ad0f
	ret c			;ad11
	inc (ix+001h)		;ad12
L_AD15:
	ld e,(ix+008h)		;ad15
	ld d,(ix+009h)		;ad18
	call 08c0ah		;ad1b
	ld (ix+008h),e		;ad1e
	ld (ix+009h),d		;ad21
	ret			;ad24
L_AD25:
	ld a,(ix+005h)		;ad25
	cp 050h		;ad28
	ret nc			;ad2a
	ld (ix+001h),000h		;ad2b
	jr L_AD15		;ad2f
L_AD31:
	ld de,07887h		;ad31
	ld a,025h		;ad34
	jp 08334h		;ad36
L_AD39:
	ld (ix+00ah),019h		;ad39
	xor a			;ad3d
	ld (ix+00ch),a		;ad3e
	ld (ix+006h),a		;ad41
	ld (ix+007h),a		;ad44
	ld (ix+008h),a		;ad47
	ld (ix+009h),a		;ad4a
	ld (0cd8ch),a		;ad4d
	ld a,(0c27eh)		;ad50
	or a			;ad53
	jp nz,L_AED5		;ad54
	ld a,(0cd5fh)		;ad57
	and 008h		;ad5a
	add a,a			;ad5c
	ld b,a			;ad5d
	ld a,(0c4b0h)		;ad5e
	and 010h		;ad61
	xor b			;ad63
	jp nz,L_AED5		;ad64
	ld a,(0cd5fh)		;ad67
	cp 008h		;ad6a
	ld a,06fh		;ad6c
	jr c,L_AD72		;ad6e
	ld a,070h		;ad70
L_AD72:
	call 04280h		;ad72
	jp 087b7h		;ad75
L_AD78:
	ld a,(ix+001h)		;ad78
	call 0408dh		;ad7b

; ----------------------------------------------------------------------
; DATOS sin identificar  0xad7e..0xad84  (6 bytes)
DATA_AD7E:
	defb 084h,0adh,097h,0adh,0d4h,0adh	; ad7e

; ======================================================================
; CODIGO 0xad84..0xadcd  (73 bytes)
; ======================================================================


L_AD84:
	ld a,(0c006h)		;ad84
	ld b,a			;ad87
	and 010h		;ad88
	jr nz,L_AD93		;ad8a
	ld a,020h		;ad8c
	and b			;ad8e
	ret z			;ad8f
	inc (ix+001h)		;ad90
L_AD93:
	inc (ix+001h)		;ad93
	ret			;ad96
L_AD97:
	ld (ix+001h),000h		;ad97
	ld b,003h		;ad9b
L_AD9D:
	ld hl,0cd8ch		;ad9d
	inc (hl)			;ada0
	ld a,(hl)			;ada1
	cp 003h		;ada2
	jr nz,L_ADA8		;ada4
	xor a			;ada6
	ld (hl),a			;ada7
L_ADA8:
	ld hl,0cd83h		;ada8
	call 04083h		;adab
	ld a,(hl)			;adae
	or a			;adaf
	jr nz,L_ADBA		;adb0
	djnz L_AD9D		;adb2
L_ADB4:
	ld a,b			;adb4
	add a,a			;adb5
	and b			;adb6
	add a,a			;adb7
	ld d,b			;adb8
	add a,a			;adb9
L_ADBA:
	ld de,ladb4h		;adba
	ld a,(0cd8ch)		;adbd
	call 0447ch		;adc0
	ld (ix+003h),d		;adc3
	ld (ix+005h),e		;adc6
	call L_AED5		;adc9
	ret			;adcc

; ----------------------------------------------------------------------
; DATOS sin identificar  0xadcd..0xadd4  (7 bytes)
DATA_ADCD:
	defb 0feh,003h,0c0h,0afh,02bh,02bh,0c9h	; adcd

; ======================================================================
; CODIGO 0xadd4..0xadeb  (23 bytes)
; ======================================================================


L_ADD4:
	ld (ix+001h),000h		;add4
	ld a,(0cd8ch)		;add8
	ld hl,0cd83h		;addb
	call 04083h		;adde
	ld a,(hl)			;ade1
	or a			;ade2
	ret z			;ade3
	dec a			;ade4
	ld (0ee80h),a		;ade5
	call 0408dh		;ade8

; ----------------------------------------------------------------------
; DATOS sin identificar  0xadeb..0xae07  (28 bytes)
DATA_ADEB:
	defb 007h,0aeh,098h,0aeh,0a3h,0aeh,0a3h,0aeh,0a3h,0aeh,0a3h,0aeh,0a3h,0aeh,098h,0aeh	; adeb  ................
	defb 093h,0aeh,007h,0aeh,0aeh,0aeh,0b0h,0aeh,0c4h,0aeh,0b2h,0aeh	; adfb  ............

; ======================================================================
; CODIGO 0xae07..0xaef1  (234 bytes)
; ======================================================================


L_AE07:
	call L_AE38		;ae07
	jp c,L_AED9		;ae0a
	call L_AE5B		;ae0d
	ret			;ae10
L_AE11:
	ld (0ee81h),a		;ae11
	call L_AE81		;ae14
	ld a,(0ee80h)		;ae17
	ld hl,0c270h		;ae1a
	call 04083h		;ae1d
	ld a,(hl)			;ae20
	or a			;ae21
	jr nz,L_AE37		;ae22
	call L_AEF9		;ae24
	ld a,(0ee80h)		;ae27
	ld hl,0c270h		;ae2a
	call 04083h		;ae2d
	ld a,(0ee81h)		;ae30
	ld (hl),a			;ae33
	call 05856h		;ae34
L_AE37:
	ret			;ae37
L_AE38:
	ld a,(0cd8ch)		;ae38
	add a,a			;ae3b
	ld hl,0cd86h		;ae3c
	call 04083h		;ae3f
	ld e,(hl)			;ae42
	inc hl			;ae43
	ld d,(hl)			;ae44
	call L_B539		;ae45
	ret c			;ae48
	ld a,(0cd8ch)		;ae49
	ld hl,0cd83h		;ae4c
	call 04083h		;ae4f
	xor a			;ae52
	ld (hl),a			;ae53
	ld a,015h		;ae54
	call 04fe4h		;ae56
	or a			;ae59
	ret			;ae5a
L_AE5B:
	call L_AE81		;ae5b
	ld a,(0ee80h)		;ae5e
	ld hl,0c270h		;ae61
	call 04083h		;ae64
	ld a,(hl)			;ae67
	cp 003h		;ae68
	jr z,L_AE37		;ae6a
	call L_AEF9		;ae6c
	ld a,(0ee80h)		;ae6f
	ld hl,0c270h		;ae72
	call 04083h		;ae75
	ld a,(0ee81h)		;ae78
	inc (hl)			;ae7b
	call 05856h		;ae7c
	jr L_AE37		;ae7f
L_AE81:
	ld a,(0cd8ch)		;ae81
	ld hl,09556h		;ae84
	add a,a			;ae87
	call 04083h		;ae88
	ld e,(hl)			;ae8b
	inc hl			;ae8c
	ld d,(hl)			;ae8d
	ld a,0ffh		;ae8e
	jp 04eb9h		;ae90
L_AE93:
	ld a,064h		;ae93
	ld (0c27ch),a		;ae95
L_AE98:
	call L_AE38		;ae98
	jr c,L_AED9		;ae9b
	ld a,001h		;ae9d
	call L_AE11		;ae9f
	ret			;aea2
L_AEA3:
	call L_AE38		;aea3
	jr c,L_AED9		;aea6
	ld a,005h		;aea8
	call L_AE11		;aeaa
	ret			;aead
L_AEAE:
	ld b,010h		;aeae
L_AEB0:
	ld b,008h		;aeb0
L_AEB2:
	push bc			;aeb2
	call L_AE38		;aeb3
	pop bc			;aeb6
	jr c,L_AED9		;aeb7
	ld a,b			;aeb9
	call 05884h		;aeba
	call L_AE81		;aebd
	call L_AEF9		;aec0
	ret			;aec3
L_AEC4:
	call L_AE38		;aec4
	jr c,L_AED9		;aec7
	call L_AE81		;aec9
	call L_AEF9		;aecc
	ld de,00200h		;aecf
	jp 05945h		;aed2
L_AED5:
	ld c,000h		;aed5
	jr L_AEDB		;aed7
L_AED9:
	ld c,004h		;aed9
L_AEDB:
	ld a,(0cd5fh)		;aedb
	srl a		;aede
	srl a		;aee0
	ld de,0aef1h		;aee2
	call 04088h		;aee5
	ld a,c			;aee8
	call 04088h		;aee9
	ld a,(de)			;aeec
	call L_B836		;aeed
	ret			;aef0

; ----------------------------------------------------------------------
; DATOS sin identificar  0xaef1..0xaef9  (8 bytes)
DATA_AEF1:
	defb 067h,068h,069h,06ah,06bh,06ch,06dh,06eh	; aef1  ghijklmn

; ======================================================================
; CODIGO 0xaef9..0xaf3c  (67 bytes)
; ======================================================================


L_AEF9:
	ld a,(0ee80h)		;aef9
L_AEFC:
	ld hl,0cda0h		;aefc
	call 04083h		;aeff
	ld a,(hl)			;af02
	cp 004h		;af03
	ret z			;af05
	inc (hl)			;af06
	ret			;af07
L_AF08:
	ld de,0181eh		;af08
	ld a,027h		;af0b
	jp 08334h		;af0d
L_AF10:
	ld (ix+00ah),019h		;af10
	xor a			;af14
	ld (ix+00ch),a		;af15
	ld (ix+006h),a		;af18
	ld (ix+007h),a		;af1b
	ld (ix+008h),a		;af1e
	ld (ix+009h),a		;af21
	ld (ix+00fh),a		;af24
	ld c,0ffh		;af27
	ld hl,0c26fh		;af29
	ld b,00bh		;af2c
	call L_AF6F		;af2e
	ld (ix+001h),000h		;af31
	ret			;af35
L_AF36:
	ld a,(ix+001h)		;af36
	call 0408dh		;af39

; ----------------------------------------------------------------------
; DATOS sin identificar  0xaf3c..0xaf42  (6 bytes)
DATA_AF3C:
	defb 042h,0afh,05ah,0afh,02eh,0b0h	; af3c

; ======================================================================
; CODIGO 0xaf42..0xb010  (206 bytes)
; ======================================================================


L_AF42:
	ld a,(0c006h)		;af42
	ld b,a			;af45
	and 010h		;af46
	jr nz,L_AF51		;af48
	ld a,020h		;af4a
	and b			;af4c
	ret z			;af4d
	inc (ix+001h)		;af4e
L_AF51:
	inc (ix+001h)		;af51
	ld a,016h		;af54
	call L_B836		;af56
	ret			;af59
L_AF5A:
	ld (ix+00fh),000h		;af5a
	ld (ix+001h),000h		;af5e
	ld b,009h		;af62
	ld hl,0cd8ch		;af64
	ld a,(hl)			;af67
	ld c,a			;af68
	ld hl,0c270h		;af69
	call 04083h		;af6c
L_AF6F:
	inc hl			;af6f
	inc c			;af70
	call L_B024		;af71
	ld a,(hl)			;af74
	or a			;af75
	jr nz,L_AF7D		;af76
	djnz L_AF6F		;af78
	jp L_B06B		;af7a
L_AF7D:
	ld a,c			;af7d
	ld (0cd8ch),a		;af7e
	ld de,0b010h		;af81
	call 04088h		;af84
	ld a,c			;af87
	or a			;af88
	ld c,000h		;af89
	push af			;af8b
	call z,L_B01A		;af8c
	pop af			;af8f
	cp 009h		;af90
	call z,L_B01A		;af92
	ld a,(de)			;af95
	add a,c			;af96
	ld (ix+005h),a		;af97
	call 0932ah		;af9a
	ld a,(0cd8ch)		;af9d
	ld b,a			;afa0
	add a,a			;afa1
	call 04088h		;afa2
	ex de,hl			;afa5
	call L_AFBE		;afa6
	ld hl,0cd87h		;afa9
	ld de,06087h		;afac
	ld b,002h		;afaf
	call 04420h		;afb1
	ld de,08087h		;afb4
	ld hl,05050h		;afb7
	call 04ef1h		;afba
	ret			;afbd
L_AFBE:
	ld a,b			;afbe
	ld de,0cda0h		;afbf
	call 04088h		;afc2
	ld a,(de)			;afc5
	ld b,a			;afc6
	ld e,(hl)			;afc7
	inc hl			;afc8
	ld d,(hl)			;afc9
	ex de,hl			;afca
	or a			;afcb
	jr z,L_AFE2		;afcc
	dec b			;afce
	jr z,L_AFE2		;afcf
	dec b			;afd1
	jr z,L_AFDE		;afd2
L_AFD4:
	ld a,l			;afd4
	add a,a			;afd5
	daa			;afd6
	ld l,a			;afd7
	ld a,h			;afd8
	adc a,a			;afd9
	daa			;afda
	ld h,a			;afdb
	djnz L_AFD4		;afdc
L_AFDE:
	ld (0cd86h),hl		;afde
	ret			;afe1
L_AFE2:
	ld de,00000h		;afe2
	ld a,h			;afe5
	and 0f0h		;afe6
	call L_B007		;afe8
	ld d,a			;afeb
	ld a,h			;afec
	and 00fh		;afed
	rra			;afef
	jr nc,L_AFF4		;aff0
	ld e,050h		;aff2
L_AFF4:
	add a,d			;aff4
	ld d,a			;aff5
	ld a,l			;aff6
	and 0f0h		;aff7
	call L_B007		;aff9
	add a,e			;affc
	ld e,a			;affd
	ld a,l			;affe
	and 00fh		;afff
	rra			;b001
	add a,e			;b002
	ld e,a			;b003
	ex de,hl			;b004
	jr L_AFDE		;b005
L_B007:
	rra			;b007
	ld b,a			;b008
	and 008h		;b009
	ld a,b			;b00b
	ret z			;b00c
	sub 003h		;b00d
	ret			;b00f

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb010..0xb01a  (10 bytes)
DATA_B010:
	defb 010h,040h,050h,060h,070h,080h,090h,0a0h,0b0h,0d0h	; b010  .@P`p.....

; ======================================================================
; CODIGO 0xb01a..0xb0a5  (139 bytes)
; ======================================================================


L_B01A:
	ld b,(hl)			;b01a
	xor a			;b01b
L_B01C:
	add a,010h		;b01c
	djnz L_B01C		;b01e
	sub 010h		;b020
	ld c,a			;b022
	ret			;b023
L_B024:
	ld a,008h		;b024
	cp c			;b026
	ret nc			;b027
	ld c,000h		;b028
	ld hl,0c270h		;b02a
	ret			;b02d
L_B02E:
	ld (ix+001h),000h		;b02e
	ld a,(ix+00fh)		;b032
	or a			;b035
	ret nz			;b036
	ld a,(0cd8ch)		;b037
	ld hl,0c270h		;b03a
	call 04083h		;b03d
	ld a,(hl)			;b040
	or a			;b041
	ld a,01ah		;b042
	jp z,L_B836		;b044
	ld a,(0cd8ch)		;b047
	cp 003h		;b04a
	push hl			;b04c
	call z,L_B070		;b04d
	pop hl			;b050
	ld a,(0cd8ch)		;b051
	dec a			;b054
	cp 008h		;b055
	ld a,000h		;b057
	jr c,L_B05D		;b059
	ld a,(hl)			;b05b
	dec a			;b05c
L_B05D:
	ld (hl),a			;b05d
	ld de,(0cd86h)		;b05e
	call 0592bh		;b062
	inc (ix+00fh)		;b065
	jp 05856h		;b068
L_B06B:
	ld (ix+001h),003h		;b06b
	ret			;b06f
L_B070:
	ld a,(0c27fh)		;b070
	or a			;b073
	ret nz			;b074
	ld a,01bh		;b075
	call L_B836		;b077
	ld a,001h		;b07a
	ld (0c27fh),a		;b07c
	ret			;b07f
L_B080:
	ld de,07058h		;b080
	jp 08334h		;b083
L_B086:
	ld (ix+00ah),01ah		;b086
	xor a			;b08a
	ld (0cd82h),a		;b08b
	ld (ix+00ch),a		;b08e
	ld d,a			;b091
	ld e,a			;b092
	call 087ebh		;b093
	call 087e4h		;b096
	ld a,090h		;b099
	ld (0cd93h),a		;b09b
	ret			;b09e
L_B09F:
	ld a,(ix+001h)		;b09f
	call 0408dh		;b0a2

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb0a5..0xb0ad  (8 bytes)
DATA_B0A5:
	defb 0adh,0b0h,0c0h,0b0h,0d4h,0b0h,0e6h,0b0h	; b0a5  ........

; ======================================================================
; CODIGO 0xb0ad..0xb130  (131 bytes)
; ======================================================================


L_B0AD:
	ld a,(0c006h)		;b0ad
	ld b,a			;b0b0
	and 010h		;b0b1
	jr nz,L_B0BC		;b0b3
	ld a,020h		;b0b5
	and b			;b0b7
	ret z			;b0b8
	inc (ix+001h)		;b0b9
L_B0BC:
	inc (ix+001h)		;b0bc
	ret			;b0bf
L_B0C0:
	ld (ix+001h),000h		;b0c0
	ld a,(ix+005h)		;b0c4
	cp 070h		;b0c7
	ld a,(0cd93h)		;b0c9
	jr z,L_B0D0		;b0cc
	ld a,070h		;b0ce
L_B0D0:
	ld (ix+005h),a		;b0d0
	ret			;b0d3
L_B0D4:
	ld a,(ix+005h)		;b0d4
	cp 070h		;b0d7
	ld a,001h		;b0d9
	jr z,L_B0DF		;b0db
	ld a,002h		;b0dd
L_B0DF:
	ld (0cd82h),a		;b0df
	inc (ix+001h)		;b0e2
	ret			;b0e5
L_B0E6:
	ld a,(0cd91h)		;b0e6
	or a			;b0e9
	ret z			;b0ea
	xor a			;b0eb
	ld (0cd91h),a		;b0ec
	jp 087b7h		;b0ef
L_B0F2:
	ld de,0806dh		;b0f2
	ld a,028h		;b0f5
	jp 08334h		;b0f7
L_B0FA:
	ld (ix+00ah),010h		;b0fa
	xor a			;b0fe
	ld (ix+00ch),a		;b0ff
	ld (ix+006h),a		;b102
	ld (ix+007h),a		;b105
	ld (ix+008h),a		;b108
	ld (ix+009h),a		;b10b
	ld (0cd82h),a		;b10e
	ld a,(0c27eh)		;b111
	or a			;b114
	ld a,026h		;b115
	call nz,0828fh		;b117
	ld a,(0c27eh)		;b11a
	or a			;b11d
	jp z,L_B1A7		;b11e
	xor a			;b121
	call 04280h		;b122
	ld a,019h		;b125
	jp 04280h		;b127
L_B12A:
	ld a,(ix+001h)		;b12a
	call 0408dh		;b12d

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb130..0xb136  (6 bytes)
DATA_B130:
	defb 036h,0b1h,05ch,0b1h,065h,0b1h	; b130

; ======================================================================
; CODIGO 0xb136..0xb1c0  (138 bytes)
; ======================================================================


L_B136:
	ld a,(0cd82h)		;b136
	or a			;b139
	ret z			;b13a
	cp 002h		;b13b
	ld a,001h		;b13d
	ld (0cd91h),a		;b13f
	jr z,L_B152		;b142
	inc (ix+001h)		;b144
	ld a,016h		;b147
	call L_B836		;b149
	ld a,027h		;b14c
	call 0828fh		;b14e
	ret			;b151
L_B152:
	ld a,01ah		;b152
	call L_B836		;b154
	ld (ix+001h),002h		;b157
	ret			;b15b
L_B15C:
	ld a,(0cd92h)		;b15c
	or a			;b15f
	ret z			;b160
	inc (ix+001h)		;b161
	ret			;b164
L_B165:
	ret			;b165
L_B166:
	ld de,08070h		;b166
	jp 08334h		;b169
L_B16C:
	ld (ix+00ah),010h		;b16c
	xor a			;b170
	ld (ix+00ch),a		;b171
	ld (ix+006h),a		;b174
	ld (ix+007h),a		;b177
	ld (ix+008h),a		;b17a
	ld (ix+009h),a		;b17d
	ld (0cd90h),a		;b180
	ld (0cd82h),a		;b183
	ld hl,0cd8dh		;b186
	ld (hl),a			;b189
	inc hl			;b18a
	ld (hl),a			;b18b
	ld a,(0c27eh)		;b18c
	or a			;b18f
	ld a,026h		;b190
	call nz,0828fh		;b192
	call 092adh		;b195
	ld a,(0c27eh)		;b198
	or a			;b19b
	jr z,L_B1A7		;b19c
	ld a,005h		;b19e
	call 04280h		;b1a0
	xor a			;b1a3
	jp 04280h		;b1a4
L_B1A7:
	ld a,018h		;b1a7
	call 04280h		;b1a9
	ld a,(0c280h)		;b1ac
	cp 006h		;b1af
	ld a,01ch		;b1b1
	jr nz,L_B1B7		;b1b3
	ld a,01dh		;b1b5
L_B1B7:
	jp 04280h		;b1b7
L_B1BA:
	ld a,(ix+001h)		;b1ba
	call 0408dh		;b1bd

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb1c0..0xb1c8  (8 bytes)
DATA_B1C0:
	defb 0c8h,0b1h,0ffh,0b1h,013h,0b2h,05eh,0b2h	; b1c0  ......^.

; ======================================================================
; CODIGO 0xb1c8..0xb2d8  (272 bytes)
; ======================================================================


L_B1C8:
	ld a,(0cd82h)		;b1c8
	or a			;b1cb
	ret z			;b1cc
	cp 002h		;b1cd
	jp z,L_B25A		;b1cf
	call L_B289		;b1d2
	jp c,L_B25A		;b1d5
	ld a,006h		;b1d8
	call L_B836		;b1da
	ld a,001h		;b1dd
	call 04280h		;b1df
	ld a,001h		;b1e2
	ld (0cd91h),a		;b1e4
	inc (ix+001h)		;b1e7
	ld a,026h		;b1ea
	call 0828fh		;b1ec
	ld a,090h		;b1ef
	ld (0cd93h),a		;b1f1
	ld a,029h		;b1f4
	call 0828fh		;b1f6
	ld a,02ah		;b1f9
	call 0828fh		;b1fb
	ret			;b1fe
L_B1FF:
	ld a,(0cd82h)		;b1ff
	or a			;b202
	ret z			;b203
	ld (0cd8fh),a		;b204
	inc (ix+001h)		;b207
	inc (ix+00ah)		;b20a
	ld a,001h		;b20d
	ld (0cd90h),a		;b20f
	ret			;b212
L_B213:
	ld hl,0cd8dh		;b213
	ld a,(hl)			;b216
	or a			;b217
	ret z			;b218
	inc hl			;b219
	ld a,(hl)			;b21a
	or a			;b21b
	ret z			;b21c
	ld a,001h		;b21d
	ld (0cd91h),a		;b21f
	ld a,(hl)			;b222
	inc (ix+001h)		;b223
	dec hl			;b226
	ld b,(hl)			;b227
	add a,b			;b228
	and 001h		;b229
	ld b,a			;b22b
	ld a,(0cd8fh)		;b22c
	dec a			;b22f
	xor b			;b230
	jr nz,L_B247		;b231
	ld de,(0c265h)		;b233
	call 0592bh		;b237
	ld a,008h		;b23a
	call L_B836		;b23c
	call L_B25F		;b23f
	ld a,019h		;b242
	jp 04fe4h		;b244
L_B247:
	call 0701eh		;b247
	call 0593ah		;b24a
	ld a,009h		;b24d
	call L_B836		;b24f
	call L_B25F		;b252
	ld a,018h		;b255
	jp 04fe4h		;b257
L_B25A:
	ld (ix+001h),003h		;b25a
L_B25E:
	ret			;b25e
L_B25F:
	ld a,(0cd8eh)		;b25f
	add a,020h		;b262
	ld de,07040h		;b264
	call 0491ch		;b267
	ld a,(0cd8dh)		;b26a
	add a,020h		;b26d
	ld de,08040h		;b26f
	call 0491ch		;b272
	ld a,(0cd8dh)		;b275
	ld b,a			;b278
	ld a,(0cd8eh)		;b279
	add a,b			;b27c
	and 001h		;b27d
	ld a,00ah		;b27f
	jr z,L_B285		;b281
	ld a,00bh		;b283
L_B285:
	call 04280h		;b285
	ret			;b288
L_B289:
	ld de,(0c265h)		;b289
	ld a,e			;b28d
	or d			;b28e
	ret nz			;b28f
	call 092adh		;b290
	ld a,01bh		;b293
	call 04fe4h		;b295
	scf			;b298
	ret			;b299
L_B29A:
	ld de,0a087h		;b29a
	ld a,029h		;b29d
	jp 08334h		;b29f
L_B2A2:
	ld de,06087h		;b2a2
	ld a,02ah		;b2a5
	jp 08334h		;b2a7
L_B2AA:
	ld (ix+00ah),013h		;b2aa
	ld b,(ix+000h)		;b2ae
	ld a,(ix+005h)		;b2b1
	sub b			;b2b4
	ld h,a			;b2b5
	ld a,(0c00dh)		;b2b6
	ld l,a			;b2b9
	ld b,(hl)			;b2ba
	ld a,r		;b2bb
	add a,b			;b2bd
	rra			;b2be
	and 00fh		;b2bf
	add a,014h		;b2c1
	ld (ix+00bh),a		;b2c3
	xor a			;b2c6
	ld (ix+00ch),a		;b2c7
	ld d,a			;b2ca
	ld e,a			;b2cb
	call 087e4h		;b2cc
	jp 087ebh		;b2cf
L_B2D2:
	ld a,(ix+001h)		;b2d2
	call 0408dh		;b2d5

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb2d8..0xb2de  (6 bytes)
DATA_B2D8:
	defb 0deh,0b2h,0e7h,0b2h,01fh,0b3h	; b2d8

; ======================================================================
; CODIGO 0xb2de..0xb372  (148 bytes)
; ======================================================================


L_B2DE:
	ld a,(0cd90h)		;b2de
	or a			;b2e1
	ret z			;b2e2
	inc (ix+001h)		;b2e3
	ret			;b2e6
L_B2E7:
	ld a,(0c00dh)		;b2e7
	and 001h		;b2ea
	ret nz			;b2ec
	ld a,(ix+000h)		;b2ed
	cp 02ah		;b2f0
	call z,L_B303		;b2f2
	dec (ix+00bh)		;b2f5
	jr z,L_B30C		;b2f8
	ld a,00fh		;b2fa
	call 04fe4h		;b2fc
	call L_B320		;b2ff
	ret			;b302
L_B303:
	ld a,(0cd8dh)		;b303
	or a			;b306
	ret nz			;b307
	inc (ix+00bh)		;b308
	ret			;b30b
L_B30C:
	ld hl,0cd8dh		;b30c
	ld a,(hl)			;b30f
	or a			;b310
	jr z,L_B314		;b311
	inc hl			;b313
L_B314:
	ld a,(ix+00ah)		;b314
	sub 013h		;b317
	inc a			;b319
	ld (hl),a			;b31a
	inc (ix+001h)		;b31b
	ret			;b31e
L_B31F:
	ret			;b31f
L_B320:
	ld b,013h		;b320
	inc (ix+00ah)		;b322
	ld a,(ix+00ah)		;b325
	sub b			;b328
	cp 006h		;b329
	jr c,L_B332		;b32b
	ld a,013h		;b32d
	ld (ix+00ah),a		;b32f
L_B332:
	push ix		;b332
	pop hl			;b334
	ld a,(ix+00ah)		;b335
	ld b,002h		;b338
	cp 013h		;b33a
	jr nz,L_B340		;b33c
	ld b,003h		;b33e
L_B340:
	ld a,b			;b340
	ld (ix+025h),a		;b341
	jp 054e6h		;b344
L_B347:
	ld de,0889ah		;b347
	ld a,02ch		;b34a
	jp 08334h		;b34c
L_B34F:
	ld (ix+00ah),03eh		;b34f
	xor a			;b353
	ld (ix+00ch),a		;b354
	ld (ix+006h),a		;b357
	ld (ix+007h),a		;b35a
	ld (ix+008h),a		;b35d
	ld (ix+009h),a		;b360
	inc a			;b363
	ld (ix+00eh),a		;b364
	ld a,002h		;b367
	jp 04280h		;b369
L_B36C:
	ld a,(ix+001h)		;b36c
	call 0408dh		;b36f

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb372..0xb37e  (12 bytes)
DATA_B372:
	defb 07eh,0b3h,0e9h,0b3h,09dh,0b4h,034h,0b5h,0dfh,0b4h,008h,0b5h	; b372  ~.....4.....

; ======================================================================
; CODIGO 0xb37e..0xb470  (242 bytes)
; ======================================================================


L_B37E:
	ld a,(0cd82h)		;b37e
	or a			;b381
	ret z			;b382
	cp 002h		;b383
	jr z,L_B3CB		;b385
	ld de,(0cd86h)		;b387
	call L_B539		;b38b
	jr c,L_B3DA		;b38e
	ld a,007h		;b390
	call L_B836		;b392
	inc (ix+001h)		;b395
	ld (ix+00bh),000h		;b398
	ld (ix+075h),008h		;b39c
	ld a,000h		;b3a0
	call 04fe4h		;b3a2
	ld a,001h		;b3a5
	ld (0cd32h),a		;b3a7
	ld (0cd91h),a		;b3aa
	ld a,(0c498h)		;b3ad
	ld (0cd33h),a		;b3b0
	ld a,(0c494h)		;b3b3
	ld (0cd34h),a		;b3b6
	ld a,0f0h		;b3b9
	ld (0c498h),a		;b3bb
	ld (0c494h),a		;b3be
	ld hl,00000h		;b3c1
	ld (0c49bh),hl		;b3c4
	ld (0c49dh),hl		;b3c7
	ret			;b3ca
L_B3CB:
	ld a,007h		;b3cb
	call L_B836		;b3cd
	ld a,001h		;b3d0
	ld (0cd91h),a		;b3d2
	ld (ix+001h),003h		;b3d5
	ret			;b3d9
L_B3DA:
	ld a,001h		;b3da
	ld (0cd91h),a		;b3dc
	ld a,004h		;b3df
	call L_B836		;b3e1
	ld (ix+001h),003h		;b3e4
	ret			;b3e8
L_B3E9:
	dec (ix+075h)		;b3e9
	ret nz			;b3ec
	ld (ix+075h),008h		;b3ed
	call L_B43F		;b3f1
	inc (ix+00bh)		;b3f4
	ld a,(ix+00bh)		;b3f7
	cp 008h		;b3fa
	ret nz			;b3fc
	call 045eeh		;b3fd
	call 045cbh		;b400
	ld a,(0c002h)		;b403
	rla			;b406
	ld hl,090a0h		;b407
	ld bc,0161bh		;b40a
	jr nc,L_B415		;b40d
	ld hl,0c8a0h		;b40f
	ld bc,01a1dh		;b412
L_B415:
	ld de,08080h		;b415
	ld a,001h		;b418
	call 0476eh		;b41a
	call 04cfch		;b41d
	call 04d08h		;b420
	ld a,005h		;b423
	ld de,07603h		;b425
	call 0463ch		;b428
	ld (ix+00eh),000h		;b42b
	ld (ix+00bh),005h		;b42f
	inc (ix+001h)		;b433
	ld (ix+075h),014h		;b436
	ld (ix+018h),003h		;b43a
	ret			;b43e
L_B43F:
	ld c,(ix+00bh)		;b43f
	ld b,00fh		;b442
L_B444:
	ld a,b			;b444
	dec a			;b445
	add a,a			;b446
	add a,b			;b447
	dec a			;b448
	ld hl,0b470h		;b449
	call 04083h		;b44c
	ld a,(hl)			;b44f
	inc hl			;b450
	sub c			;b451
	jr nc,L_B455		;b452
	xor a			;b454
L_B455:
	add a,a			;b455
	add a,a			;b456
	add a,a			;b457
	add a,a			;b458
	ld d,a			;b459
	ld a,(hl)			;b45a
	inc hl			;b45b
	sub c			;b45c
	jr nc,L_B460		;b45d
	xor a			;b45f
L_B460:
	or d			;b460
	ld d,a			;b461
	ld a,(hl)			;b462
	inc hl			;b463
	sub c			;b464
	jr nc,L_B468		;b465
	xor a			;b467
L_B468:
	ld e,a			;b468
	ld a,b			;b469
	call 0463ch		;b46a
	djnz L_B444		;b46d
	ret			;b46f

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb470..0xb49d  (45 bytes)
DATA_B470:
	defb 006h,003h,004h,000h,000h,000h,007h,000h,000h,007h,006h,006h,001h,006h,003h,006h	; b470  ................
	defb 003h,004h,002h,000h,001h,007h,000h,005h,004h,001h,002h,004h,000h,002h,003h,000h	; b480  ................
	defb 001h,004h,004h,004h,001h,000h,001h,007h,007h,007h,003h,001h,002h	; b490  .............

; ======================================================================
; CODIGO 0xb49d..0xb535  (152 bytes)
; ======================================================================


L_B49D:
	ld a,(0c002h)		;b49d
	rla			;b4a0
	ld c,03eh		;b4a1
	jr nc,L_B4A7		;b4a3
	ld c,07eh		;b4a5
L_B4A7:
	dec (ix+075h)		;b4a7
	ret nz			;b4aa
	ld (ix+075h),014h		;b4ab
	ld a,(ix+018h)		;b4af
	dec a			;b4b2
	ld de,0b535h		;b4b3
	call 04088h		;b4b6
	ld a,(de)			;b4b9
	add a,c			;b4ba
	ld (ix+00ah),a		;b4bb
	ld a,(ix+018h)		;b4be
	cp 002h		;b4c1
	ld a,017h		;b4c3
	call z,04fe4h		;b4c5
	dec (ix+018h)		;b4c8
	ret nz			;b4cb
	ld (ix+018h),004h		;b4cc
	dec (ix+00bh)		;b4d0
	ret nz			;b4d3
	ld (ix+00bh),00ah		;b4d4
	inc (ix+001h)		;b4d8
	inc (ix+001h)		;b4db
	ret			;b4de
L_B4DF:
	dec (ix+00bh)		;b4df
	ret nz			;b4e2
	call 045eeh		;b4e3
	ld a,096h		;b4e6
	call 04fe4h		;b4e8
	call 051edh		;b4eb
	call 0534eh		;b4ee
	ld de,00020h		;b4f1
	call 05884h		;b4f4
	call 043e2h		;b4f7
	call 04cfch		;b4fa
	call 04d08h		;b4fd
	inc (ix+001h)		;b500
	ld (ix+00bh),010h		;b503
	ret			;b507
L_B508:
	call 0460ah		;b508
	dec (ix+00bh)		;b50b
	ret nz			;b50e
	call 045e1h		;b50f
	xor a			;b512
	ld (0cd32h),a		;b513
	ld a,(0cd33h)		;b516
	ld (0c498h),a		;b519
	ld a,(0cd34h)		;b51c
	ld (0c494h),a		;b51f
	ld a,081h		;b522
	call 04fe4h		;b524
	ld a,00fh		;b527
	call L_AEFC		;b529
	ld a,003h		;b52c
	call 04280h		;b52e
	jp 087b7h		;b531
L_B534:
	ret			;b534

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb535..0xb539  (4 bytes)
DATA_B535:
	defb 002h,001h,000h,001h	; b535

; ======================================================================
; CODIGO 0xb539..0xb579  (64 bytes)
; ======================================================================


L_B539:
	ld hl,(0c265h)		;b539
	push de			;b53c
	rst 20h			;b53d
	pop de			;b53e
	jp nc,05958h		;b53f
	ld a,01bh		;b542
	call 04fe4h		;b544
	scf			;b547
	ret			;b548
L_B549:
	ld de,08070h		;b549
	ld a,02bh		;b54c
	jp 08334h		;b54e
L_B551:
	ld (ix+00ah),00eh		;b551
	xor a			;b555
	ld (ix+00ch),a		;b556
	ld (ix+006h),a		;b559
	ld (ix+007h),a		;b55c
	ld (ix+008h),a		;b55f
	ld (ix+009h),a		;b562
	inc a			;b565
	ld (ix+00eh),a		;b566
	xor a			;b569
	call 04280h		;b56a
	ld a,071h		;b56d
	call 04280h		;b56f
	ret			;b572
L_B573:
	ld a,(ix+001h)		;b573
	call 0408dh		;b576

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb579..0xb57f  (6 bytes)
DATA_B579:
	defb 07fh,0b5h,08eh,0b5h,0c8h,0b5h	; b579

; ======================================================================
; CODIGO 0xb57f..0xb698  (281 bytes)
; ======================================================================


L_B57F:
	inc (ix+001h)		;b57f
	ld hl,0cd87h		;b582
	ld de,08838h		;b585
	ld b,002h		;b588
	call 04420h		;b58a
	ret			;b58d
L_B58E:
	ld a,(0cd82h)		;b58e
	or a			;b591
	ret z			;b592
	ld a,001h		;b593
	ld (0cd91h),a		;b595
	ld a,(0cd82h)		;b598
	cp 002h		;b59b
	jr z,L_B5C0		;b59d
	ld de,(0cd86h)		;b59f
	call L_B539		;b5a3
	jr c,L_B5BC		;b5a6
	ld de,03020h		;b5a8
	ld a,00eh		;b5ab
	call 04eb9h		;b5ad
	ld a,001h		;b5b0
	ld (0cdb0h),a		;b5b2
	ld a,091h		;b5b5
	call 04fe4h		;b5b7
	jr L_B5C0		;b5ba
L_B5BC:
	ld a,06eh		;b5bc
	jr L_B5C2		;b5be
L_B5C0:
	ld a,007h		;b5c0
L_B5C2:
	call L_B836		;b5c2
	inc (ix+001h)		;b5c5
L_B5C8:
	ret			;b5c8
L_B5C9:
	ld a,(0cd5bh)		;b5c9
	or a			;b5cc
	ret nz			;b5cd
	ld a,(0cd31h)		;b5ce
	or a			;b5d1
	ret nz			;b5d2
	call L_B67A		;b5d3
	push bc			;b5d6
	call 08334h		;b5d7
	pop bc			;b5da
	push bc			;b5db
	call 08334h		;b5dc
	pop bc			;b5df
	push bc			;b5e0
	call 08334h		;b5e1
	pop bc			;b5e4
	ld a,007h		;b5e5
	cp b			;b5e7
	ret nz			;b5e8
	jp L_B67A		;b5e9
L_B5EC:
	ld a,(0cd12h)		;b5ec
	and 00ch		;b5ef
	ld b,a			;b5f1
	ld a,018h		;b5f2
	sub b			;b5f4
	ld b,a			;b5f5
	ld a,(0cd30h)		;b5f6
	add a,b			;b5f9
	ld (ix+00bh),a		;b5fa
	ld (0cd30h),a		;b5fd
	ld hl,0cd31h		;b600
	inc (hl)			;b603
	ld (ix+00eh),001h		;b604
	ld (ix+00ch),000h		;b608
	ld a,(ix+000h)		;b60c
	cp 007h		;b60f
	jr z,L_B623		;b611
	ld de,0b058h		;b613
	ld (ix+005h),d		;b616
	ld (ix+003h),e		;b619
	ld (ix+001h),002h		;b61c
	jp 0893dh		;b620
L_B623:
	ld (ix+001h),001h		;b623
	ld de,(0cd4ah)		;b627
	ld (ix+005h),d		;b62b
	ld (ix+003h),e		;b62e
	ld a,(0cd4ch)		;b631
	ld (ix+01fh),a		;b634
	and 001h		;b637
	ld (ix+00fh),a		;b639
	ld de,00000h		;b63c
	call 087e4h		;b63f
	call 087ebh		;b642
	ld a,(0cd14h)		;b645
	or a			;b648
	call nz,087b7h		;b649
	ld a,(0cd31h)		;b64c
	cp 001h		;b64f
	ret nz			;b651
	call 09763h		;b652
	ld d,(ix+005h)		;b655
	ld e,(ix+003h)		;b658
	ld (0cd4ah),de		;b65b
	ld a,(ix+01fh)		;b65f
	ld (0cd4ch),a		;b662
	ld a,(ix+01fh)		;b665
	and 001h		;b668
	ld (ix+00fh),a		;b66a
	call 0893dh		;b66d
	ld de,00000h		;b670
	call 087e4h		;b673
	call 087ebh		;b676
	ret			;b679
L_B67A:
	xor a			;b67a
	ld (0cd31h),a		;b67b
	ld (0cd14h),a		;b67e
	ld a,010h		;b681
	ld (0cd30h),a		;b683
	ret			;b686
L_B687:
	ld de,08070h		;b687
	jp 08334h		;b68a
L_B68D:
	ld (ix+00ah),010h		;b68d
	ret			;b691
L_B692:
	ld a,(ix+001h)		;b692
	call 0408dh		;b695

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb698..0xb6a4  (12 bytes)
DATA_B698:
	defb 0a4h,0b6h,02eh,0b7h,090h,0b7h,0b4h,0b7h,0b3h,0b7h,024h,0b8h	; b698  ..........$.

; ======================================================================
; CODIGO 0xb6a4..0xb716  (114 bytes)
; ======================================================================


L_B6A4:
	ld a,(0c27eh)		;b6a4
	or a			;b6a7
	jr nz,L_B6DD		;b6a8
	call L_B71D		;b6aa
	ld a,(hl)			;b6ad
	and 080h		;b6ae
	ld b,004h		;b6b0
	jr z,L_B6B6		;b6b2
	ld b,000h		;b6b4
L_B6B6:
	ld a,(hl)			;b6b6
	and 07fh		;b6b7
	add a,b			;b6b9
	ld de,0b716h		;b6ba
	call 04088h		;b6bd
	ld a,(de)			;b6c0
	call L_B836		;b6c1
	call L_B71D		;b6c4
	ld a,(hl)			;b6c7
	ld b,a			;b6c8
	and 07fh		;b6c9
	cp 002h		;b6cb
	jr z,L_B6E4		;b6cd
L_B6CF:
	ld a,000h		;b6cf
	call 04280h		;b6d1
	inc (ix+001h)		;b6d4
	ld a,026h		;b6d7
	call 0828fh		;b6d9
	ret			;b6dc
L_B6DD:
	ld a,00fh		;b6dd
	call L_B836		;b6df
	jr L_B6CF		;b6e2
L_B6E4:
	ld (ix+00bh),070h		;b6e4
	ld a,b			;b6e8
	and 080h		;b6e9
	jr z,L_B70A		;b6eb
	ld a,(0c280h)		;b6ed
	cp 006h		;b6f0
	ld a,01eh		;b6f2
	jr nz,L_B6F8		;b6f4
	ld a,01fh		;b6f6
L_B6F8:
	push hl			;b6f8
	push bc			;b6f9
	call 04280h		;b6fa
	pop bc			;b6fd
	pop hl			;b6fe
	ld a,080h		;b6ff
	ld (hl),a			;b701
	ld a,001h		;b702
	ld (0c27eh),a		;b704
	jp L_B7AB		;b707
L_B70A:
	xor a			;b70a
	ld (hl),a			;b70b
	ld de,(0c265h)		;b70c
	call 05958h		;b710
	jp L_B7AB		;b713

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb716..0xb71d  (7 bytes)
DATA_B716:
	defb 00fh,012h,014h,00fh,00fh,066h,013h	; b716

; ======================================================================
; CODIGO 0xb71d..0xb882  (357 bytes)
; ======================================================================


L_B71D:
	ld a,(0c28dh)		;b71d
	ld b,a			;b720
	ld hl,0c340h		;b721
	ld a,(0c281h)		;b724
L_B727:
	cp (hl)			;b727
	inc hl			;b728
	ret z			;b729
	inc hl			;b72a
	djnz L_B727		;b72b
	ret			;b72d
L_B72E:
	ld a,(0cd82h)		;b72e
	or a			;b731
	ret z			;b732
	cp 002h		;b733
	jp z,L_B828		;b735
	ld a,001h		;b738
	ld (0cd91h),a		;b73a
	ld (0cd2eh),a		;b73d
	call L_B75E		;b740
	ld (ix+00bh),080h		;b743
	inc (ix+001h)		;b747
	ld a,(0c27eh)		;b74a
	or a			;b74d
	ret nz			;b74e
	call L_B71D		;b74f
	ld a,(hl)			;b752
	cp 083h		;b753
	ret z			;b755
	inc a			;b756
	ld (hl),a			;b757
	ret			;b758
L_B759:
	ld (ix+001h),004h		;b759
	ret			;b75d
L_B75E:
	ld c,017h		;b75e
	ld a,(0c273h)		;b760
	or a			;b763
	jr z,L_B776		;b764
	ld c,037h		;b766
	ld a,(0c274h)		;b768
	or a			;b76b
	jr z,L_B776		;b76c
	ld a,(0c27eh)		;b76e
	or a			;b771
	jr z,L_B776		;b772
	ld c,046h		;b774
L_B776:
	ld a,(0c28fh)		;b776
	cp c			;b779
	call nc,L_B7A6		;b77a
	ld b,a			;b77d
	ld a,r		;b77e
	and 00fh		;b780
	add a,b			;b782
	cp c			;b783
	jr c,L_B787		;b784
	sub c			;b786
L_B787:
	ld hl,0c28fh		;b787
	ld (hl),a			;b78a
	add a,020h		;b78b
	jp L_B836		;b78d
L_B790:
	dec (ix+00bh)		;b790
	ret nz			;b793
	ld a,011h		;b794
	call L_B836		;b796
	call L_B7D3		;b799
	jr nc,L_B7AB		;b79c
	ld (ix+00bh),080h		;b79e
	inc (ix+001h)		;b7a2
	ret			;b7a5
L_B7A6:
	sub c			;b7a6
	jr nc,L_B7A6		;b7a7
	add a,c			;b7a9
	ret			;b7aa
L_B7AB:
	ld (ix+00bh),060h		;b7ab
	ld (ix+001h),005h		;b7af
L_B7B3:
	ret			;b7b3
L_B7B4:
	dec (ix+00bh)		;b7b4
	ret nz			;b7b7
	ld a,015h		;b7b8
	call L_B836		;b7ba
	xor a			;b7bd
	ld (0c482h),a		;b7be
	ld (0cd2eh),a		;b7c1
	ld a,003h		;b7c4
	ld (0c490h),a		;b7c6
	ld a,08bh		;b7c9
	call 04fe4h		;b7cb
	call 067dah		;b7ce
	jr L_B759		;b7d1
L_B7D3:
	ld hl,(0c265h)		;b7d3
	ld a,l			;b7d6
	and 00fh		;b7d7
	cp 005h		;b7d9
	ld de,00300h		;b7db
	jr z,L_B803		;b7de
	ld de,01000h		;b7e0
	rst 20h			;b7e3
	ld de,00990h		;b7e4
	jr nc,L_B803		;b7e7
	ld hl,(0c265h)		;b7e9
	ld de,00031h		;b7ec
	rst 20h			;b7ef
	ld de,00100h		;b7f0
	jr c,L_B803		;b7f3
	ld de,(0c265h)		;b7f5
	ld a,e			;b7f9
	sub 030h		;b7fa
	daa			;b7fc
	ld e,a			;b7fd
	ld a,d			;b7fe
	sbc a,000h		;b7ff
	daa			;b801
	ld d,a			;b802
L_B803:
	ld (0ee80h),de		;b803
	ld hl,0ee81h		;b807
	ld de,06840h		;b80a
	ld b,002h		;b80d
	call 04420h		;b80f
	ld de,(0ee80h)		;b812
	ld hl,(0c265h)		;b816
	rst 20h			;b819
	push af			;b81a
	ld de,(0ee80h)		;b81b
	call 05958h		;b81f
	pop af			;b822
	ret			;b823
L_B824:
	dec (ix+00bh)		;b824
	ret nz			;b827
L_B828:
	xor a			;b828
	ld (0cd2eh),a		;b829
	inc a			;b82c
	ld (0c4a2h),a		;b82d
	call 045eeh		;b830
	jp 072b8h		;b833
L_B836:
	push af			;b836
	call 092adh		;b837
	ld a,016h		;b83a
	call 04280h		;b83c
	pop af			;b83f
	jp 04280h		;b840
L_B843:
	ld de,04030h		;b843
	ld hl,0a008h		;b846
	call L_B8A2		;b849
	ld de,0c830h		;b84c
	ld hl,0f010h		;b84f
	call L_B8A2		;b852
	ld de,04828h		;b855
	ld hl,07800h		;b858
	call L_B8B3		;b85b
	ld de,048a0h		;b85e
	ld hl,07000h		;b861
	call L_B8B3		;b864
	ld hl,0b882h		;b867
	ld b,008h		;b86a
L_B86C:
	push bc			;b86c
	ld e,(hl)			;b86d
	inc hl			;b86e
	ld d,(hl)			;b86f
	inc hl			;b870
	ld c,(hl)			;b871
	inc hl			;b872
	ld b,(hl)			;b873
	inc hl			;b874
	push hl			;b875
	ld l,c			;b876
	ld h,b			;b877
	call 04ef1h		;b878
	pop hl			;b87b
	pop bc			;b87c
	djnz L_B86C		;b87d
	jp L_BC43		;b87f

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb882..0xb8a2  (32 bytes)
DATA_B882:
	defb 028h,040h,008h,090h,0a0h,040h,008h,098h,028h,0c8h,010h,0e0h,0a0h,0c8h,010h,0e8h	; b882  (@...@..(.......
	defb 028h,0dch,000h,090h,034h,0d0h,000h,0a0h,034h,0e8h,000h,098h,040h,0dch,000h,0a8h	; b892  (...4...4...@...

; ======================================================================
; CODIGO 0xb8a2..0xbad9  (567 bytes)
; ======================================================================


L_B8A2:
	ld b,00eh		;b8a2
L_B8A4:
	push bc			;b8a4
	push hl			;b8a5
	call 04ef1h		;b8a6
	pop hl			;b8a9
	pop bc			;b8aa
	ld a,008h		;b8ab
	call 04088h		;b8ad
	djnz L_B8A4		;b8b0
	ret			;b8b2
L_B8B3:
	ld b,010h		;b8b3
L_B8B5:
	push bc			;b8b5
	push hl			;b8b6
	call 04ef1h		;b8b7
	pop hl			;b8ba
	pop bc			;b8bb
	ld a,008h		;b8bc
	add a,d			;b8be
	ld d,a			;b8bf
	djnz L_B8B5		;b8c0
	ret			;b8c2
L_B8C3:
	ld a,001h		;b8c3
	ld (0cdc5h),a		;b8c5
	ld a,(0c006h)		;b8c8
	ld b,a			;b8cb
	and 001h		;b8cc
	jr nz,L_B8EA		;b8ce
	ld a,b			;b8d0
	and 004h		;b8d1
	jr nz,L_B92D		;b8d3
	ld a,b			;b8d5
	and 008h		;b8d6
	jr nz,L_B927		;b8d8
	ld a,b			;b8da
	and 002h		;b8db
	jr nz,L_B920		;b8dd
	ld a,b			;b8df
	and 010h		;b8e0
	jp nz,L_BAF1		;b8e2
L_B8E5:
	xor a			;b8e5
	ld (0cdc5h),a		;b8e6
	ret			;b8e9
L_B8EA:
	ld a,(0cdcch)		;b8ea
	or a			;b8ed
	jr nz,L_B913		;b8ee
	ld hl,0cdb2h		;b8f0
	ld a,(hl)			;b8f3
	cp 001h		;b8f4
	jr z,L_B8E5		;b8f6
L_B8F8:
	ld a,(0cdc4h)		;b8f8
	add a,a			;b8fb
	ld hl,0bad9h		;b8fc
	call 04083h		;b8ff
	ld e,(hl)			;b902
	inc hl			;b903
	ld d,(hl)			;b904
	ld hl,(0cdc6h)		;b905
	ld a,l			;b908
	add a,e			;b909
	ld l,a			;b90a
	ld a,h			;b90b
	add a,d			;b90c
	ld h,a			;b90d
	ld (0cdc6h),hl		;b90e
	jr L_B936		;b911
L_B913:
	ld hl,0cdb2h		;b913
	ld a,(hl)			;b916
	cp 001h		;b917
	jr nz,L_B8F8		;b919
	ld a,006h		;b91b
	jp L_BC6F		;b91d
L_B920:
	ld a,(0cdc4h)		;b920
	inc a			;b923
	inc a			;b924
	jr L_B931		;b925
L_B927:
	ld a,(0cdc4h)		;b927
	inc a			;b92a
	jr L_B931		;b92b
L_B92D:
	ld a,(0cdc4h)		;b92d
	dec a			;b930
L_B931:
	and 003h		;b931
	ld (0cdc4h),a		;b933
L_B936:
	ld hl,0cdb3h		;b936
	ld de,0cdb4h		;b939
	xor a			;b93c
	ld (hl),a			;b93d
	ld bc,00010h		;b93e
	ldir		;b941
	ld hl,0cdc9h		;b943
	xor a			;b946
	ld (hl),a			;b947
	inc hl			;b948
	ld (hl),a			;b949
	inc hl			;b94a
	ld (hl),a			;b94b
	call L_B955		;b94c
	call L_BA47		;b94f
	jp L_BA62		;b952
L_B955:
	xor a			;b955
	ld (0cdcch),a		;b956
	ld hl,(0cdc6h)		;b959
	call 05a6ah		;b95c
	ld a,(hl)			;b95f
	cp 006h		;b960
	call z,L_B9AB		;b962
	ld a,(0cdc4h)		;b965
	ld de,0bad9h		;b968
	call 0447ch		;b96b
	ld hl,(0cdc6h)		;b96e
	ld b,004h		;b971
	ld c,001h		;b973
L_B975:
	call L_BAD2		;b975
	push hl			;b978
	exx			;b979
	pop hl			;b97a
	call 05a6ah		;b97b
	ld a,(hl)			;b97e
	exx			;b97f
	cp 001h		;b980
	jr z,L_B997		;b982
	cp 006h		;b984
	jr z,L_B99C		;b986
	or a			;b988
	push de			;b989
	push hl			;b98a
	push bc			;b98b
	call nz,L_BA33		;b98c
	pop bc			;b98f
	pop hl			;b990
	pop de			;b991
	inc c			;b992
	djnz L_B975		;b993
	ld c,000h		;b995
L_B997:
	ld a,c			;b997
	ld (0cdb2h),a		;b998
	ret			;b99b
L_B99C:
	inc c			;b99c
	ld a,c			;b99d
	cp 005h		;b99e
	jr nz,L_B9A4		;b9a0
	ld c,000h		;b9a2
L_B9A4:
	ld a,001h		;b9a4
	ld (0cdcch),a		;b9a6
	jr L_B997		;b9a9
L_B9AB:
	ld a,(0cdc4h)		;b9ab
	add a,002h		;b9ae
	and 003h		;b9b0
	ld de,0bad9h		;b9b2
	call 0447ch		;b9b5
	ld hl,(0cdc6h)		;b9b8
	call L_BAD2		;b9bb
	call 05a6ah		;b9be
	ld a,(hl)			;b9c1
	cp 001h		;b9c2
	ret z			;b9c4
	ld a,001h		;b9c5
	ld (0cdcch),a		;b9c7
	ret			;b9ca
L_B9CB:
	ld a,(0cdc4h)		;b9cb
	rr a		;b9ce
	jr nc,L_BA09		;b9d0
	ld hl,0d830h		;b9d2
	ld (0ee00h),hl		;b9d5
	ld (0ee04h),hl		;b9d8
	ld bc,00c03h		;b9db
	rr a		;b9de
	jr c,L_B9E5		;b9e0
	ld a,c			;b9e2
	ld c,b			;b9e3
	ld b,a			;b9e4
L_B9E5:
	ld l,0ech		;b9e5
	ld h,c			;b9e7
	ld (0ee02h),hl		;b9e8
	ld l,0f0h		;b9eb
	ld h,b			;b9ed
	ld (0ee06h),hl		;b9ee
	ld hl,0ec00h		;b9f1
	ld de,0ee03h		;b9f4
	ld c,002h		;b9f7
L_B9F9:
	ld b,010h		;b9f9
	ld a,(de)			;b9fb
L_B9FC:
	ld (hl),a			;b9fc
	inc hl			;b9fd
	djnz L_B9FC		;b9fe
	ld a,004h		;ba00
	call 04088h		;ba02
	dec c			;ba05
	jr nz,L_B9F9		;ba06
	ret			;ba08
L_BA09:
	ld hl,0d830h		;ba09
	ld (0ee00h),hl		;ba0c
	ld de,00c03h		;ba0f
	rr a		;ba12
	ld a,0e8h		;ba14
	ld (0ee02h),a		;ba16
	ld a,0e0h		;ba19
	ld (0ee04h),a		;ba1b
	jr nc,L_BA23		;ba1e
	ld a,e			;ba20
	ld e,d			;ba21
	ld d,a			;ba22
L_BA23:
	ld hl,0ec00h		;ba23
	ld b,008h		;ba26
L_BA28:
	ld (hl),e			;ba28
	inc hl			;ba29
	djnz L_BA28		;ba2a
	ld b,008h		;ba2c
L_BA2E:
	ld (hl),d			;ba2e
	inc hl			;ba2f
	djnz L_BA2E		;ba30
	ret			;ba32
L_BA33:
	ex af,af'			;ba33
	ld a,004h		;ba34
	cp c			;ba36
	ret z			;ba37
	ex af,af'			;ba38
	push hl			;ba39
	push de			;ba3a
	dec c			;ba3b
	ld e,c			;ba3c
	ld d,000h		;ba3d
	ld hl,0cdc9h		;ba3f
	add hl,de			;ba42
	ld (hl),a			;ba43
	pop de			;ba44
	pop hl			;ba45
	ret			;ba46
L_BA47:
	ld a,(0cdc4h)		;ba47
	ld de,0bae1h		;ba4a
	call 0447ch		;ba4d
	ld hl,(0cdc6h)		;ba50
	call L_BAD2		;ba53
	ld c,005h		;ba56
	exx			;ba58
	ld hl,0cdb3h		;ba59
	ld de,0cdbbh		;ba5c
	exx			;ba5f
	jr L_BA7B		;ba60
L_BA62:
	ld a,(0cdc4h)		;ba62
	ld de,0bae9h		;ba65
	call 0447ch		;ba68
	ld hl,(0cdc6h)		;ba6b
	call L_BAD2		;ba6e
	ld c,011h		;ba71
	exx			;ba73
	ld hl,0cdb7h		;ba74
	ld de,0cdbfh		;ba77
	exx			;ba7a
L_BA7B:
	push hl			;ba7b
	ld a,(0cdc4h)		;ba7c
	ld de,0bad9h		;ba7f
	call 0447ch		;ba82
	pop hl			;ba85
	ld a,(0cdb2h)		;ba86
	or a			;ba89
	jr nz,L_BA8E		;ba8a
	ld a,004h		;ba8c
L_BA8E:
	ld b,a			;ba8e
L_BA8F:
	push bc			;ba8f
	push de			;ba90
	push hl			;ba91
	call 05a6ah		;ba92
	ld a,(hl)			;ba95
	pop hl			;ba96
	pop de			;ba97
	pop bc			;ba98
	push bc			;ba99
	call L_BAA5		;ba9a
	pop bc			;ba9d
	call L_BAD2		;ba9e
	inc c			;baa1
	djnz L_BA8F		;baa2
	ret			;baa4
L_BAA5:
	ld b,a			;baa5
	cp 001h		;baa6
	ld a,000h		;baa8
	jr z,L_BAAE		;baaa
	ld a,004h		;baac
L_BAAE:
	add a,c			;baae
	push bc			;baaf
	exx			;bab0
	pop bc			;bab1
	ld (hl),b			;bab2
	push bc			;bab3
	ld c,a			;bab4
	ld a,001h		;bab5
	cp (hl)			;bab7
	ld a,c			;bab8
	pop bc			;bab9
	jr z,L_BACD		;baba
	push bc			;babc
	ld c,a			;babd
	dec a			;babe
	and 003h		;babf
	ld b,a			;bac1
	ld a,(0cdb2h)		;bac2
	dec a			;bac5
	cp b			;bac6
	ld a,c			;bac7
	pop bc			;bac8
	jr nz,L_BACD		;bac9
	add a,004h		;bacb
L_BACD:
	ld (de),a			;bacd
	inc hl			;bace
	inc de			;bacf
	exx			;bad0
	ret			;bad1
L_BAD2:
	ld a,l			;bad2
	add a,e			;bad3
	ld l,a			;bad4
	ld a,h			;bad5
	add a,d			;bad6
	ld h,a			;bad7
	ret			;bad8

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbad9..0xbaf1  (24 bytes)
DATA_BAD9:
	defb 000h,0ffh,001h,000h,000h,001h,0ffh,000h,0ffh,000h,000h,0ffh,001h,000h,000h,001h	; bad9  ................
	defb 001h,000h,000h,001h,0ffh,000h,000h,0ffh	; bae9  ........

; ======================================================================
; CODIGO 0xbaf1..0xbc1b  (298 bytes)
; ======================================================================


L_BAF1:
	xor a			;baf1
	ld (0cdc5h),a		;baf2
	ld a,(0c27ah)		;baf5
	or a			;baf8
	ret z			;baf9
	inc a			;bafa
	ld (0cdc8h),a		;bafb
	ld a,01ah		;bafe
	call 04fe4h		;bb00
	call 045eeh		;bb03
	call L_BC3A		;bb06
	call 05856h		;bb09
	call 043e2h		;bb0c
	call 05890h		;bb0f
	call L_BB1B		;bb12
	call L_BBAA		;bb15
	jp 045e1h		;bb18
L_BB1B:
	ld a,(0cdd3h)		;bb1b
	ld b,a			;bb1e
	ld a,014h		;bb1f
	sub b			;bb21
	srl a		;bb22
	add a,a			;bb24
	add a,a			;bb25
	add a,a			;bb26
	add a,020h		;bb27
	ld l,a			;bb29
	ld a,(0cdd4h)		;bb2a
	ld b,a			;bb2d
	ld a,01ch		;bb2e
	sub b			;bb30
	srl a		;bb31
	add a,a			;bb33
	add a,a			;bb34
	add a,a			;bb35
	add a,008h		;bb36
	ld h,a			;bb38
	ld (0cdd5h),hl		;bb39
	ld a,(0cdd4h)		;bb3c
	add a,a			;bb3f
	add a,a			;bb40
	add a,a			;bb41
	add a,h			;bb42
	ld h,a			;bb43
	ld (0ee00h),hl		;bb44
	ld a,0f4h		;bb47
	ld (0ee02h),a		;bb49
	ld a,0e0h		;bb4c
	ld (0ee04h),a		;bb4e
	ld hl,0ec00h		;bb51
	ld de,0ec01h		;bb54
	ld bc,0000fh		;bb57
	ld a,00eh		;bb5a
	ld (hl),a			;bb5c
	ldir		;bb5d
	ld a,(0cdd3h)		;bb5f
	ld c,a			;bb62
	ld de,0d800h		;bb63
	ld hl,(0cdd5h)		;bb66
L_BB69:
	ld a,(0cdd4h)		;bb69
	ld b,a			;bb6c
	push de			;bb6d
	push hl			;bb6e
L_BB6F:
	ld a,(de)			;bb6f
	inc de			;bb70
	or a			;bb71
	push de			;bb72
	jr z,L_BB8E		;bb73
	push hl			;bb75
	cp 006h		;bb76
	jr z,L_BBCD		;bb78
	dec a			;bb7a
	add a,a			;bb7b
	ld de,0bc1bh		;bb7c
	call 04088h		;bb7f
	ex de,hl			;bb82
	ld e,(hl)			;bb83
	inc hl			;bb84
	ld d,(hl)			;bb85
L_BB86:
	pop hl			;bb86
	ex de,hl			;bb87
	push bc			;bb88
	call 04ef1h		;bb89
	pop bc			;bb8c
	ex de,hl			;bb8d
L_BB8E:
	ld de,00800h		;bb8e
	call L_BAD2		;bb91
	pop de			;bb94
	djnz L_BB6F		;bb95
	pop hl			;bb97
	pop de			;bb98
	ld a,01ch		;bb99
	call 04088h		;bb9b
	push de			;bb9e
	ld de,00008h		;bb9f
	call L_BAD2		;bba2
	pop de			;bba5
	dec c			;bba6
	jr nz,L_BB69		;bba7
	ret			;bba9
L_BBAA:
	ld hl,(0cdc6h)		;bbaa
	sla h		;bbad
	sla h		;bbaf
	sla h		;bbb1
	sla l		;bbb3
	sla l		;bbb5
	sla l		;bbb7
	ld d,l			;bbb9
	ld e,h			;bbba
	ex de,hl			;bbbb
	ld a,(0cdd5h)		;bbbc
	add a,l			;bbbf
	ld l,a			;bbc0
	ld a,(0cdd6h)		;bbc1
	add a,h			;bbc4
	ld h,a			;bbc5
	ex de,hl			;bbc6
	ld hl,06098h		;bbc7
	jp 04ef1h		;bbca
L_BBCD:
	ld a,(0ef80h)		;bbcd
	and 040h		;bbd0
	jr z,L_BC15		;bbd2
	ld a,(0c27eh)		;bbd4
	or a			;bbd7
	jr z,L_BC15		;bbd8
	dec de			;bbda
	ld h,d			;bbdb
	ld l,e			;bbdc
	dec de			;bbdd
	ld a,(de)			;bbde
	cp 000h		;bbdf
	ld de,0a060h		;bbe1
	jp z,L_BB86		;bbe4
	ld d,h			;bbe7
	ld e,l			;bbe8
	inc de			;bbe9
	ld a,(de)			;bbea
	cp 000h		;bbeb
	ld de,09860h		;bbed
	jp z,L_BB86		;bbf0
	ld d,h			;bbf3
	ld e,l			;bbf4
	ld a,(0cdd4h)		;bbf5
	call 04088h		;bbf8
	ld a,(de)			;bbfb
	cp 000h		;bbfc
	ld de,08860h		;bbfe
	jp z,L_BB86		;bc01
	ld a,(0cdd4h)		;bc04
	ld e,a			;bc07
	xor a			;bc08
	ld d,a			;bc09
	sbc hl,de		;bc0a
	ld a,(hl)			;bc0c
	cp 000h		;bc0d
	ld de,09060h		;bc0f
	jp z,L_BB86		;bc12
L_BC15:
	ld de,00000h		;bc15
	jp L_BB86		;bc18

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbc1b..0xbc27  (12 bytes)
DATA_BC1B:
	defb 098h,068h,090h,068h,090h,060h,000h,000h,000h,000h,000h,000h	; bc1b  .h.h.`......

; ======================================================================
; CODIGO 0xbc27..0xbc74  (77 bytes)
; ======================================================================


L_BC27:
	ld a,(0c006h)		;bc27
	and 010h		;bc2a
	ret z			;bc2c
	xor a			;bc2d
	ld (0cdc8h),a		;bc2e
	call 045eeh		;bc31
	call 0598dh		;bc34
	jp 045e1h		;bc37
L_BC3A:
	ld bc,000d4h		;bc3a
	call 045fbh		;bc3d
	jp 0460ah		;bc40
L_BC43:
	ld a,(0c27ah)		;bc43
	or a			;bc46
	call nz,L_BCA5		;bc47
	ld a,(0c27bh)		;bc4a
	or a			;bc4d
	ret z			;bc4e
	ld b,a			;bc4f
	xor a			;bc50
L_BC51:
	push af			;bc51
	push bc			;bc52
	call L_BC89		;bc53
	pop bc			;bc56
	pop af			;bc57
	inc a			;bc58
	djnz L_BC51		;bc59
	ret			;bc5b
L_BC5C:
	ld hl,(0cdc6h)		;bc5c
	call 05a6ah		;bc5f
	ld a,(hl)			;bc62
	or a			;bc63
	ret z			;bc64
	cp 006h		;bc65
	ret z			;bc67
	call L_BCD3		;bc68
	ld c,000h		;bc6b
	ld a,(hl)			;bc6d
	ld (hl),c			;bc6e
L_BC6F:
	dec a			;bc6f
	dec a			;bc70
	call 0408dh		;bc71

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbc74..0xbc7e  (10 bytes)
DATA_BC74:
	defb 07eh,0bch,097h,0bch,0a0h,0bch,0adh,0bch,0beh,0bch	; bc74  ~.........

; ======================================================================
; CODIGO 0xbc7e..0xbd0c  (142 bytes)
; ======================================================================


L_BC7E:
	ld de,00200h		;bc7e
	call 0592bh		;bc81
	ld hl,0c27bh		;bc84
	ld a,(hl)			;bc87
	inc (hl)			;bc88
L_BC89:
	ld d,028h		;bc89
	add a,a			;bc8b
	add a,a			;bc8c
	add a,a			;bc8d
	add a,a			;bc8e
	add a,040h		;bc8f
	ld e,a			;bc91
	ld a,010h		;bc92
	jp 04eb9h		;bc94
L_BC97:
	ld hl,0c279h		;bc97
	inc (hl)			;bc9a
	ld a,009h		;bc9b
	jp 057fah		;bc9d
L_BCA0:
	ld a,001h		;bca0
	ld (0c27ah),a		;bca2
L_BCA5:
	ld a,011h		;bca5
	ld de,02830h		;bca7
	jp 04eb9h		;bcaa
L_BCAD:
	ld hl,0c260h		;bcad
	ld a,(hl)			;bcb0
	add a,001h		;bcb1
	daa			;bcb3
	cp 09ah		;bcb4
	jr c,L_BCBA		;bcb6
	ld a,099h		;bcb8
L_BCBA:
	ld (hl),a			;bcba
	jp 043e2h		;bcbb
L_BCBE:
	xor a			;bcbe
	ld (0cdd2h),a		;bcbf
	ld (0cdc5h),a		;bcc2
	inc a			;bcc5
	ld (0cdcdh),a		;bcc6
	ld a,00fh		;bcc9
	ld (0cdceh),a		;bccb
	ld a,080h		;bcce
	jp 04fe4h		;bcd0
L_BCD3:
	ld de,0c290h		;bcd3
	ld b,00bh		;bcd6
L_BCD8:
	ld a,(de)			;bcd8
	ld c,a			;bcd9
	inc de			;bcda
	ld a,(de)			;bcdb
	inc de			;bcdc
	or c			;bcdd
	jr z,L_BCE3		;bcde
	djnz L_BCD8		;bce0
	ret			;bce2
L_BCE3:
	dec de			;bce3
	dec de			;bce4
	ex de,hl			;bce5
	ld (hl),e			;bce6
	inc hl			;bce7
	ld (hl),d			;bce8
	ex de,hl			;bce9
	push hl			;bcea
	ld a,012h		;bceb
	call 04fe4h		;bced
	pop hl			;bcf0
	ret			;bcf1
L_BCF2:
	ld hl,0c290h		;bcf2
	xor a			;bcf5
	ld b,016h		;bcf6
L_BCF8:
	ld (hl),a			;bcf8
	inc hl			;bcf9
	djnz L_BCF8		;bcfa
	ld hl,00000h		;bcfc
	ld (0c27ah),hl		;bcff
	ld (0c28eh),a		;bd02
	ret			;bd05
L_BD06:
	ld a,(0cdd2h)		;bd06
	call 0408dh		;bd09

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbd0c..0xbd12  (6 bytes)
DATA_BD0C:
	defb 012h,0bdh,0b2h,0bdh,0d5h,0bdh	; bd0c

; ======================================================================
; CODIGO 0xbd12..0xbe44  (306 bytes)
; ======================================================================


L_BD12:
	ld de,04c30h		;bd12
	ld hl,03870h		;bd15
	ld a,004h		;bd18
	ld c,00eh		;bd1a
	call L_BD48		;bd1c
	call L_BD57		;bd1f
	ld hl,0cdceh		;bd22
	dec (hl)			;bd25
	ret nz			;bd26
	ld a,080h		;bd27
	ld (hl),a			;bd29
	ld hl,0cdd2h		;bd2a
	inc (hl)			;bd2d
	ld de,07848h		;bd2e
	ld a,013h		;bd31
	call 04eb9h		;bd33
	ld de,08848h		;bd36
	ld a,014h		;bd39
	call 04eb9h		;bd3b
	ld a,(0c28eh)		;bd3e
	or a			;bd41
	ret z			;bd42
	ld hl,0cdd2h		;bd43
	inc (hl)			;bd46
	ret			;bd47
L_BD48:
	ld (0cd08h),de		;bd48
	ld (0cd0ah),hl		;bd4c
	ld (0cd0ch),a		;bd4f
	ld a,c			;bd52
	ld (0cd0dh),a		;bd53
	ret			;bd56
L_BD57:
	ld de,(0cd08h)		;bd57
	ld a,(0cd0ch)		;bd5b
	ld l,000h		;bd5e
	ld h,a			;bd60
	add hl,de			;bd61
	ld bc,(0cd0ah)		;bd62
	xor a			;bd66
	call 0476eh		;bd67
	ld a,(0cd0dh)		;bd6a
	ld b,a			;bd6d
	ld de,(0cd08h)		;bd6e
	ld a,(0cd0bh)		;bd72
	ld c,a			;bd75
	ld a,(0cd0ch)		;bd76
	add a,c			;bd79
	add a,c			;bd7a
	ld h,a			;bd7b
	ld l,000h		;bd7c
	add hl,de			;bd7e
L_BD7F:
	push bc			;bd7f
	push hl			;bd80
	ld a,(0cd0ch)		;bd81
	ld e,000h		;bd84
	ld d,a			;bd86
	or a			;bd87
	sbc hl,de		;bd88
	pop de			;bd8a
	push hl			;bd8b
	ld a,(0cd0ch)		;bd8c
	ld b,a			;bd8f
	ld a,(0cd0ah)		;bd90
	ld c,a			;bd93
	xor a			;bd94
	call 0476eh		;bd95
	pop hl			;bd98
	pop bc			;bd99
	djnz L_BD7F		;bd9a
	ld hl,(0cd08h)		;bd9c
	ld a,(0cd0bh)		;bd9f
	add a,h			;bda2
	ld h,a			;bda3
	ld a,(0cd0ch)		;bda4
	add a,a			;bda7
	ld b,a			;bda8
	ld a,(0cd0ah)		;bda9
	ld c,a			;bdac
	xor a			;bdad
	ld d,a			;bdae
	jp 04732h		;bdaf
L_BDB2:
	ld hl,0cdceh		;bdb2
	dec (hl)			;bdb5
	ret nz			;bdb6
	ld a,0a0h		;bdb7
	ld (hl),a			;bdb9
	ld a,00eh		;bdba
	call 04280h		;bdbc
	ld c,001h		;bdbf
	ld de,00000h		;bdc1
	call 04380h		;bdc4
	ld hl,0cdd2h		;bdc7
	inc (hl)			;bdca
	ld a,001h		;bdcb
	ld (0c28eh),a		;bdcd
	ld a,093h		;bdd0
	jp 04fe4h		;bdd2
L_BDD5:
	ld hl,0cdceh		;bdd5
	dec (hl)			;bdd8
	ret nz			;bdd9
	call 045eeh		;bdda
	call 072b8h		;bddd
	xor a			;bde0
	ld (0cdb0h),a		;bde1
	ld (0cdb1h),a		;bde4
	ld (0cdcdh),a		;bde7
	inc a			;bdea
	ld (0c4a2h),a		;bdeb
	ld a,00eh		;bdee
	call L_AEFC		;bdf0
	jp 04a96h		;bdf3
L_BDF6:
	call 06cd8h		;bdf6
	ld a,(0eb81h)		;bdf9
	and a			;bdfc
	ret z			;bdfd
	ld b,a			;bdfe
	ld de,0c580h		;bdff
	ld hl,0c590h		;be02
	ld a,(hl)			;be05
	cp 005h		;be06
	ret nc			;be08
	call 04088h		;be09
	ld a,b			;be0c
	ld (de),a			;be0d
	inc (hl)			;be0e
	ld a,(hl)			;be0f
	cp 005h		;be10
	ret nz			;be12
	ld a,(0cdb1h)		;be13
	and a			;be16
	jr z,L_BE2C		;be17
	ld de,0be44h		;be19
	ld c,001h		;be1c
	call L_BE31		;be1e
	ld a,(0ef80h)		;be21
	rra			;be24
	ret nc			;be25
	ld a,001h		;be26
	ld (0c27ah),a		;be28
	ret			;be2b
L_BE2C:
	ld de,0be49h		;be2c
	ld c,002h		;be2f
L_BE31:
	ld hl,0c580h		;be31
	ld b,005h		;be34
L_BE36:
	ld a,(de)			;be36
	cp (hl)			;be37
	ret nz			;be38
	inc hl			;be39
	inc de			;be3a
	djnz L_BE36		;be3b
	ld hl,0ef80h		;be3d
	ld a,(hl)			;be40
	or c			;be41
	ld (hl),a			;be42
	ret			;be43

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbe44..0xbe4e  (10 bytes)
DATA_BE44:
	defb 034h,053h,04bh,063h,05dh,03ch,036h,053h,047h,05dh	; be44  4SKc]<6SG]

; ======================================================================
; CODIGO 0xbe4e..0xbe8a  (60 bytes)
; ======================================================================


L_BE4E:
	ld bc,00420h		;be4e
L_BE51:
	ld a,b			;be51
	dec a			;be52
	ld d,a			;be53
	add a,a			;be54
	add a,a			;be55
	add a,a			;be56
	add a,d			;be57
	ld de,0be8ah		;be58
	call 04088h		;be5b
	push bc			;be5e
	ld hl,0ebb0h		;be5f
	ld b,009h		;be62
	call L_BE36		;be64
	pop bc			;be67
	rrc c		;be68
	djnz L_BE51		;be6a
	ld a,(0ef80h)		;be6c
	and 03ch		;be6f
	jr nz,L_BE7A		;be71
	ld hl,00000h		;be73
	ld (0c000h),hl		;be76
	ret			;be79
L_BE7A:
	call 04351h		;be7a
	call 0662ch		;be7d
	call L_BEAE		;be80
	ld hl,00004h		;be83
	ld (0c000h),hl		;be86
	ret			;be89

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbe8a..0xbeae  (36 bytes)
DATA_BE8A:
	defb 037h,058h,037h,058h,042h,05dh,042h,05dh,01fh,036h,04fh,040h,053h,05dh,038h,063h	; be8a  7X7XB]B].6O@S]8c
	defb 05dh,036h,030h,038h,04fh,03ah,05dh,048h,03ah,031h,04bh,041h,041h,063h,036h,035h	; be9a  ]608O:]H:1KAAc65
	defb 063h,03bh,03fh,031h	; beaa

; ======================================================================
; CODIGO 0xbeae..0xbee5  (55 bytes)
; ======================================================================


L_BEAE:
	ld a,040h		;beae
	ld (0c002h),a		;beb0
	ld a,(0ef80h)		;beb3
	rra			;beb6
	rra			;beb7
	rra			;beb8
	jr c,L_BEC4		;beb9
	rra			;bebb
	jr c,L_BECA		;bebc
	rra			;bebe
	jr c,L_BED0		;bebf
	rra			;bec1
	jr L_BED7		;bec2
L_BEC4:
	ld hl,0c002h		;bec4
	set 7,(hl)		;bec7
	ret			;bec9
L_BECA:
	ld a,020h		;beca
	ld (0c480h),a		;becc
	ret			;becf
L_BED0:
	ld hl,02000h		;bed0
	ld (0c265h),hl		;bed3
	ret			;bed6
L_BED7:
	ld a,001h		;bed7
	ld (0c27fh),a		;bed9
	ret			;bedc
L_BEDD:
	ld hl,0ef80h		;bedd
	ld a,(hl)			;bee0
	or 040h		;bee1
	ld (hl),a			;bee3
	ret			;bee4

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbee5..0xc000  (283 bytes)
DATA_BEE5:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bee5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bef5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf05  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf15  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf25  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf35  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf45  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf55  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf65  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf75  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf85  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf95  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfa5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfb5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,05dh,052h,033h	; bfe5  .............]R3
	defb 063h,039h,059h,063h,049h,05dh,063h,035h,00bh,048h,0aah	; bff5  c9YcI]c5.H.
