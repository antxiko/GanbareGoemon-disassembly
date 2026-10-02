; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX2 - MegaROM RC-748 de 128 KB (Konami4) - banco 03 (se ejecuta en 0xa000)
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
; DATOS curva_de_caida: 32 bytes con signo que p02:9FDE suma a la y de una
;   figura (ix+3), uno por cuadro ((ix+0x7F) cuenta hasta 0x20): sube, se para
;   y cae (32 bytes)
;   0xa008..0xa028  (32 bytes)
DATA_curva_de_caida:
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
	call nz,08c0ah		;a046   ; niega_de: DE = -DE
	pop af			;a049
	bit 3,a		;a04a
	push af			;a04c
	call nz,08c0ah		;a04d   ; niega_de: DE = -DE
	pop af			;a050
	and 003h		;a051
	jr z,L_A05E		;a053
	call 087e4h		;a055   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00000h		;a058
	jp 087ebh		;a05b   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_A05E:
	call 087ebh		;a05e   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld de,00000h		;a061
	jp 087e4h		;a064   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
L_A067:
	ld d,(ix+006h)		;a067   ; lee la velocidad vertical (parte baja)
	ld e,(ix+007h)		;a06a   ; lee la velocidad vertical
	ld h,(ix+008h)		;a06d   ; lee la velocidad horizontal (parte baja)
	ld l,(ix+009h)		;a070   ; lee la velocidad horizontal
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
	ld (ix+006h),d		;a08c   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),e		;a08f   ; guarda la velocidad vertical
	ld (ix+008h),h		;a092   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),l		;a095   ; guarda la velocidad horizontal
	ret			;a098

; ----------------------------------------------------------------------
; DATOS tres_filas: 3 filas de 28 caracteres que p02:80EE pinta desde (0x00,
;   0x10) (84 bytes)
;   0xa099..0xa0ed  (84 bytes)
DATA_tres_filas:
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
	ld (ix+003h),030h		;a0f0   ; la y de la figura = 0x30
	ld (ix+00ch),001h		;a0f4
	ld a,06ah		;a0f8
	ld (ix+00ah),a		;a0fa   ; guarda la pose de la figura
	ret			;a0fd
L_A0FE:
	ld b,06ah		;a0fe
	call 0891ah		;a100
	ld a,(ix+001h)		;a103   ; lee el paso en que va la figura
	call 0408dh		;a106   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A109: 2 destinos del despachador de 0x408D (call en p03:A106):
;   0xA10D, 0xA130; lo leen p03:A106 (4 bytes)
;   0xa109..0xa10d  (4 bytes)
DATA_tabla_A109:
	defb 00dh,0a1h	; a109
	defb 030h,0a1h	; a10b

; ======================================================================
; CODIGO 0xa10d..0xa1ae  (161 bytes)
; ======================================================================


L_A10D:
	ld de,0ff00h		;a10d
	call 087ebh		;a110   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld de,00100h		;a113
	ld a,(0c49ah)		;a116   ; lee la x de los sprites del jugador
	cp (ix+005h)		;a119   ; compara con la x de la figura
	jr nc,L_A121		;a11c
	call 08c0ah		;a11e   ; niega_de: DE = -DE
L_A121:
	call 087e4h		;a121   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld a,(ix+003h)		;a124   ; lee la y de la figura
	add a,040h		;a127
	ld (ix+010h),a		;a129
	inc (ix+001h)		;a12c   ; sube el paso en que va la figura
	ret			;a12f
L_A130:
	ld a,(ix+003h)		;a130   ; lee la y de la figura
	cp (ix+010h)		;a133
	jr nc,L_A149		;a136
	ld de,00030h		;a138
L_A13B:
	ld h,(ix+007h)		;a13b   ; lee la velocidad vertical
	ld l,(ix+006h)		;a13e   ; lee la velocidad vertical (parte baja)
	add hl,de			;a141
	ld (ix+007h),h		;a142   ; guarda la velocidad vertical
	ld (ix+006h),l		;a145   ; guarda la velocidad vertical (parte baja)
	ret			;a148
L_A149:
	ld (ix+001h),000h		;a149   ; el paso en que va la figura = 0x00
	ret			;a14d
L_A14E:
	jp 08334h		;a14e   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_A151:
	ld a,04eh		;a151
	ld (ix+00ah),a		;a153   ; guarda la pose de la figura
	ld a,(0c496h)		;a156   ; lee la x del jugador
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
	ld (ix+005h),b		;a170   ; guarda la x de la figura
	ld (ix+003h),010h		;a173   ; la y de la figura = 0x10
	ld de,00200h		;a177
	call 087ebh		;a17a   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld de,00000h		;a17d
	call 087e4h		;a180   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ret			;a183
L_A184:
	ld a,(ix+009h)		;a184   ; lee la velocidad horizontal
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
	ld (ix+00ah),a		;a1a2   ; guarda la pose de la figura
L_A1A5:
	call L_A27A		;a1a5
	ld a,(ix+001h)		;a1a8   ; lee el paso en que va la figura
	call 0408dh		;a1ab   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A1AE: 6 destinos del despachador de 0x408D (call en p03:A1AB):
;   0xA1BA, 0xA1D7, 0xA1F6, 0xA20C, 0xA231, 0xA26B; lo leen p03:A1AB (12
;   bytes)
;   0xa1ae..0xa1ba  (12 bytes)
DATA_tabla_A1AE:
	defb 0bah,0a1h	; a1ae
	defb 0d7h,0a1h	; a1b0
	defb 0f6h,0a1h	; a1b2
	defb 00ch,0a2h	; a1b4
	defb 031h,0a2h	; a1b6
	defb 06bh,0a2h	; a1b8

; ======================================================================
; CODIGO 0xa1ba..0xa3c6  (524 bytes)
; ======================================================================


L_A1BA:
	ld a,(ix+003h)		;a1ba   ; lee la y de la figura
	cp 030h		;a1bd
	ret c			;a1bf
	ld de,00200h		;a1c0
	call 08c0ah		;a1c3   ; niega_de: DE = -DE
	call 087e4h		;a1c6   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00100h		;a1c9
	call 087ebh		;a1cc   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld (ix+010h),008h		;a1cf
	inc (ix+001h)		;a1d3   ; sube el paso en que va la figura
	ret			;a1d6
L_A1D7:
	ld de,00020h		;a1d7
	call L_A26C		;a1da
	ld a,(ix+005h)		;a1dd   ; lee la x de la figura
	cp (ix+07ch)		;a1e0
	ret c			;a1e3
	inc (ix+001h)		;a1e4   ; sube el paso en que va la figura
	ld de,00200h		;a1e7
	call 087e4h		;a1ea   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00100h		;a1ed
	call 08c0ah		;a1f0   ; niega_de: DE = -DE
	jp 087ebh		;a1f3   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_A1F6:
	ld a,(ix+005h)		;a1f6   ; lee la x de la figura
	cp (ix+07bh)		;a1f9
	ret c			;a1fc
	inc (ix+001h)		;a1fd   ; sube el paso en que va la figura
	ld de,00200h		;a200
	call 087e4h		;a203   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00100h		;a206
	jp 087ebh		;a209   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_A20C:
	ld de,00020h		;a20c
	call 08c0ah		;a20f   ; niega_de: DE = -DE
	call L_A26C		;a212
	ld a,(ix+005h)		;a215   ; lee la x de la figura
	cp (ix+07bh)		;a218
	ret nc			;a21b
	inc (ix+001h)		;a21c   ; sube el paso en que va la figura
	ld de,00200h		;a21f
	call 08c0ah		;a222   ; niega_de: DE = -DE
	call 087e4h		;a225   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00100h		;a228
	call 08c0ah		;a22b   ; niega_de: DE = -DE
	jp 087ebh		;a22e   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_A231:
	ld a,(ix+005h)		;a231   ; lee la x de la figura
	cp (ix+07ch)		;a234
	ret nc			;a237
	ld (ix+001h),001h		;a238   ; el paso en que va la figura = 0x01
	ld de,00200h		;a23c
	call 08c0ah		;a23f   ; niega_de: DE = -DE
	call 087e4h		;a242   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00100h		;a245
	call 087ebh		;a248   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld (ix+003h),030h		;a24b   ; la y de la figura = 0x30
	ld a,(ix+07ch)		;a24f
	dec a			;a252
	ld (ix+005h),a		;a253   ; guarda la x de la figura
	ld a,(ix+012h)		;a256
	or a			;a259
	ret z			;a25a
	ld de,0fd00h		;a25b
	call 087ebh		;a25e   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld d,000h		;a261
	call 087e4h		;a263   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld (ix+001h),005h		;a266   ; el paso en que va la figura = 0x05
	ret			;a26a
L_A26B:
	ret			;a26b
L_A26C:
	ld h,(ix+009h)		;a26c   ; lee la velocidad horizontal
	ld l,(ix+008h)		;a26f   ; lee la velocidad horizontal (parte baja)
	add hl,de			;a272
	ld (ix+009h),h		;a273   ; guarda la velocidad horizontal
	ld (ix+008h),l		;a276   ; guarda la velocidad horizontal (parte baja)
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
	jp 089c2h		;a293   ; dispara: crea el disparo A (tabla de 0x8B6B)
L_A296:
	ld (ix+071h),000h		;a296
	call L_A420		;a29a
	call 0893dh		;a29d   ; pon_la_pose: pone la pose de la figura
	ld (ix+003h),030h		;a2a0   ; la y de la figura = 0x30
	ld de,0fd00h		;a2a4
	call 087ebh		;a2a7   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	call 08c0ah		;a2aa   ; niega_de: DE = -DE
	call L_A344		;a2ad
	ld de,00200h		;a2b0
	bit 0,(ix+00fh)		;a2b3
	call z,08c0ah		;a2b7   ; niega_de: DE = -DE
	call 087e4h		;a2ba   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
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
	call z,04fe4h		;a2d6   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call L_A31F		;a2d9
	bit 0,(ix+071h)		;a2dc
	jr nz,L_A2ED		;a2e0
	ld a,(0c496h)		;a2e2   ; lee la x del jugador
	sub (ix+005h)		;a2e5   ; le resta la x de la figura
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
	ld a,(0c49ah)		;a2fd   ; lee la x de los sprites del jugador
	sub (ix+005h)		;a300   ; le resta la x de la figura
	ret c			;a303
	cp 050h		;a304
	ret nc			;a306
	jr L_A319		;a307
L_A309:
	ld (ix+071h),001h		;a309
	jr L_A2F1		;a30d
L_A30F:
	ld a,(0c49ah)		;a30f   ; lee la x de los sprites del jugador
	sub (ix+005h)		;a312   ; le resta la x de la figura
	ret nc			;a315
	cp 0b0h		;a316
	ret c			;a318
L_A319:
	ld a,(ix+07dh)		;a319
	jp 089c2h		;a31c   ; dispara: crea el disparo A (tabla de 0x8B6B)
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
	call 08c0ah		;a336   ; niega_de: DE = -DE
	call L_A34B		;a339
	call L_A359		;a33c
	call 08c0ah		;a33f   ; niega_de: DE = -DE
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
	ld e,(ix+006h)		;a359   ; lee la velocidad vertical (parte baja)
	ld d,(ix+007h)		;a35c   ; lee la velocidad vertical
	ret			;a35f
L_A360:
	ld a,(0cd5bh)		;a360
	or a			;a363
	ret nz			;a364
	jp 08334h		;a365   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_A368:
	call L_A3A1		;a368
	ld de,0a3c6h		;a36b
	call L_A398		;a36e
	and 003h		;a371
	call 0447ch		;a373   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;a376
	ld e,(hl)			;a377
	inc hl			;a378
	ld d,(hl)			;a379
	bit 0,(ix+00fh)		;a37a
	call z,08c0ah		;a37e   ; niega_de: DE = -DE
	inc hl			;a381
	call 087e4h		;a382   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld e,(hl)			;a385
	inc hl			;a386
	ld d,(hl)			;a387
	inc hl			;a388
	call 087ebh		;a389   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld a,(hl)			;a38c
	ld (ix+011h),a		;a38d
	inc hl			;a390
	ld a,(hl)			;a391
	ld (ix+012h),a		;a392
	jp 0893dh		;a395   ; pon_la_pose: pone la pose de la figura
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
	ld a,(0c496h)		;a3a5   ; lee la x del jugador
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
	jp c,087b7h		;a3b4   ; borra_la_figura: borra la figura
	ld (ix+00fh),d		;a3b7
	ld (ix+005h),a		;a3ba   ; guarda la x de la figura
	ld a,0c8h		;a3bd
	ld (ix+003h),a		;a3bf   ; guarda la y de la figura
	ld (ix+010h),a		;a3c2
	ret			;a3c5

; ----------------------------------------------------------------------
; DATOS cuatro_fichas_A3C6: 4 punteros (p03:A36B, por los dos bits bajos) a
;   fichas de 6 bytes (16 bytes)
;   0xa3c6..0xa3ce  (8 bytes)
DATA_cuatro_fichas_A3C6:
	defb 0ceh,0a3h	; a3c6
	defb 0d4h,0a3h	; a3c8
	defb 0d4h,0a3h	; a3ca
	defb 0dah,0a3h	; a3cc

; ----------------------------------------------------------------------
; DATOS fichas_A3CE: 3 fichas de 6 bytes: dos palabras que p03:A382 y p03:A389
;   dejan en la figura (la primera, en negativo si el bit 0 de ix+0x0F esta a
;   cero) y los bytes de ix+0x11 e ix+0x12 (18 bytes)
;   0xa3ce..0xa3e0  (18 bytes)
DATA_fichas_A3CE:
	defb 080h,001h,000h,0fah,020h,000h,000h,002h,000h,0fah,040h,000h,000h,002h,080h,0fah	; a3ce  .... .....@.....
	defb 066h,000h	; a3de

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
	cp (ix+003h)		;a3f2   ; compara con la y de la figura
	ret nc			;a3f5
	jp 087b7h		;a3f6   ; borra_la_figura: borra la figura
L_A3F9:
	call L_A420		;a3f9
	call 0893dh		;a3fc   ; pon_la_pose: pone la pose de la figura
	ld de,00000h		;a3ff
	call 087ebh		;a402   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	call L_A46B		;a405
	bit 0,(ix+00fh)		;a408
	call nz,08c0ah		;a40c   ; niega_de: DE = -DE
	call 087e4h		;a40f   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
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
	jp nz,087b7h		;a424   ; borra_la_figura: borra la figura
	ld a,(0c496h)		;a427   ; lee la x del jugador
	add a,040h		;a42a
	cp 080h		;a42c
	jp c,087b7h		;a42e   ; borra_la_figura: borra la figura
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
	ld (ix+005h),b		;a442   ; guarda la x de la figura
	ld a,(0c494h)		;a445   ; lee la y del jugador
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
	ld (ix+003h),a		;a459   ; guarda la y de la figura
	ld e,a			;a45c
	ld (ix+010h),a		;a45d
	ld (ix+00fh),c		;a460
	ld b,c			;a463
	call 0781fh		;a464   ; se_puede_pisar: carry si el caracter se puede pisar
	ret nc			;a467
	jp 087b7h		;a468   ; borra_la_figura: borra la figura
L_A46B:
	ld a,(0cd12h)		;a46b
	srl a		;a46e
	srl a		;a470
	ld b,a			;a472
	add a,a			;a473
	add a,b			;a474
	ld hl,0a481h		;a475
	call 04083h		;a478   ; hl_mas_a: HL += A
	ld e,(hl)			;a47b
	inc hl			;a47c
	ld d,(hl)			;a47d
	inc hl			;a47e
	ld a,(hl)			;a47f
	ret			;a480

; ----------------------------------------------------------------------
; DATOS cuatro_tripletes_A481: 4 tripletes (p03:A475: (A / 2) x 3) que
;   p03:A47B lee: una palabra y un byte (12 bytes)
;   0xa481..0xa48d  (12 bytes)
DATA_cuatro_tripletes_A481:
	defb 000h,0ffh,040h	; a481
	defb 080h,0fdh,038h	; a484
	defb 040h,0fdh,030h	; a487
	defb 000h,0fdh,018h	; a48a

; ======================================================================
; CODIGO 0xa48d..0xa4f1  (100 bytes)
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
	ld (ix+00ah),041h		;a4a1   ; la pose de la figura = 0x41
	ld (ix+00ch),001h		;a4a5
L_A4A9:
	ld de,0fe00h		;a4a9
	bit 0,(ix+00fh)		;a4ac
	call nz,08c0ah		;a4b0   ; niega_de: DE = -DE
	call 087e4h		;a4b3   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,0fc80h		;a4b6
	jp 087ebh		;a4b9   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_A4BC:
	ld a,041h		;a4bc
	ld de,0c00dh		;a4be
	call 0895bh		;a4c1
	ld de,00066h		;a4c4
	call L_A13B		;a4c7
	ld a,(ix+010h)		;a4ca
	cp (ix+003h)		;a4cd   ; compara con la y de la figura
	ret nc			;a4d0
	jr L_A4A9		;a4d1
L_A4D3:
	call L_ABF6		;a4d3
L_A4D6:
	call L_A954		;a4d6
	call 0893dh		;a4d9   ; pon_la_pose: pone la pose de la figura
	call L_A567		;a4dc
	ld a,(ix+01fh)		;a4df
	ld (ix+019h),a		;a4e2
	ret			;a4e5
L_A4E6:
	call 085b1h		;a4e6
	jr L_A4D6		;a4e9
L_A4EB:
	ld a,(ix+001h)		;a4eb   ; lee el paso en que va la figura
	call 0408dh		;a4ee   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A4F1: 2 destinos del despachador de 0x408D (call en p03:A4EE):
;   0xA4F5, 0xA72A; lo leen p03:A4EE (4 bytes)
;   0xa4f1..0xa4f5  (4 bytes)
DATA_tabla_A4F1:
	defb 0f5h,0a4h	; a4f1
	defb 02ah,0a7h	; a4f3

; ======================================================================
; CODIGO 0xa4f5..0xa5d1  (220 bytes)
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
	jr nc,L_A58A		;a51e
	ret			;a520
L_A521:
	ld b,(ix+01ah)		;a521
	call L_A683		;a524
	ld a,(ix+01ah)		;a527
	jr nc,L_A58A		;a52a
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
	ld a,(0c498h)		;a568   ; lee la y de los sprites del jugador
	cp (ix+003h)		;a56b   ; compara con la y de la figura
	ld a,008h		;a56e
	jr c,L_A574		;a570
	srl a		;a572
L_A574:
	ld (ix+01ah),a		;a574
	ex af,af'			;a577
	ret			;a578
L_A579:
	ld a,(ix+01ah)		;a579
	xor 00ch		;a57c
	ld (ix+01ah),a		;a57e
	ld a,(ix+019h)		;a581
	xor 003h		;a584
	ld (ix+019h),a		;a586
	ret			;a589
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
	call 04083h		;a59c   ; hl_mas_a: HL += A
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
	call 087ebh		;a5ad   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld e,(hl)			;a5b0
	inc hl			;a5b1
	ld d,(hl)			;a5b2
	call 087e4h		;a5b3   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	or a			;a5b6
	ret			;a5b7
L_A5B8:
	ld a,(ix+003h)		;a5b8   ; lee la y de la figura
	ld hl,(0c494h)		;a5bb   ; lee la y del jugador
	cp (hl)			;a5be
	ld a,008h		;a5bf
	ret c			;a5c1
	ld a,004h		;a5c2
	ret nz			;a5c4
	ld a,002h		;a5c5
	ret			;a5c7
L_A5C8:
	and 003h		;a5c8
	ret z			;a5ca
	and 001h		;a5cb
	ld (ix+00fh),a		;a5cd
	ret			;a5d0

; ----------------------------------------------------------------------
; DATOS cuatro_tandas_A5D1: cuatro tandas de 16 bytes; p03:A599 escoge por los
;   bits 2-3 de 0xCD12 (64 bytes)
;   0xa5d1..0xa611  (64 bytes)
DATA_cuatro_tandas_A5D1:
	defb 000h,000h,000h,001h,000h,000h,000h,0ffh,000h,001h,000h,000h,000h,0ffh,000h,000h	; a5d1  ................
	defb 000h,000h,040h,001h,000h,000h,0c0h,0feh,040h,001h,000h,000h,0c0h,0feh,000h,000h	; a5e1  ..@.....@.......
	defb 000h,000h,080h,001h,000h,000h,080h,0feh,080h,001h,000h,000h,080h,0feh,000h,000h	; a5f1  ................
	defb 000h,000h,000h,002h,000h,000h,000h,0feh,000h,002h,000h,000h,000h,0feh,000h,000h	; a601  ................

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
	ld d,(ix+005h)		;a63c   ; lee la x de la figura
	ld e,(ix+003h)		;a63f   ; lee la y de la figura
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
	ld (ix+005h),h		;a65d   ; guarda la x de la figura
	ld (ix+003h),l		;a660   ; guarda la y de la figura
	call 0877ah		;a663
	call L_A6BC		;a666
	pop de			;a669
	ld (ix+005h),d		;a66a   ; guarda la x de la figura
	ld (ix+003h),e		;a66d   ; guarda la y de la figura
	ret			;a670
L_A671:
	pop af			;a671
	pop de			;a672
	ld (ix+005h),d		;a673   ; guarda la x de la figura
	ld (ix+003h),e		;a676   ; guarda la y de la figura
L_A679:
	scf			;a679
	ret			;a67a

; ----------------------------------------------------------------------
; DATOS cuatro_parejas_A67B: 4 parejas [dy][dx] que p03:A631 escoge por el
;   primer bit puesto de (ix+0x1F) (8 bytes)
;   0xa67b..0xa683  (8 bytes)
DATA_cuatro_parejas_A67B:
	defb 010h,000h	; a67b
	defb 0f0h,000h	; a67d
	defb 000h,010h	; a67f
	defb 000h,0f0h	; a681

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
	ld e,(ix+002h)		;a699   ; lee la fraccion de la y de la figura
	ld d,(ix+003h)		;a69c   ; lee la y de la figura
	push de			;a69f
	ld e,(ix+004h)		;a6a0   ; lee la fraccion de la x de la figura
	ld d,(ix+005h)		;a6a3   ; lee la x de la figura
	push de			;a6a6
	call 0877ah		;a6a7
	call L_A6BC		;a6aa
	pop de			;a6ad
	ld (ix+004h),e		;a6ae   ; guarda la fraccion de la x de la figura
	ld (ix+005h),d		;a6b1   ; guarda la x de la figura
	pop de			;a6b4
	ld (ix+002h),e		;a6b5   ; guarda la fraccion de la y de la figura
	ld (ix+003h),d		;a6b8   ; guarda la y de la figura
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
	ld d,(ix+005h)		;a6c8   ; lee la x de la figura
	ld e,(ix+003h)		;a6cb   ; lee la y de la figura
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
	call 0781fh		;a6e1   ; se_puede_pisar: carry si el caracter se puede pisar
	pop de			;a6e4
	ret c			;a6e5
	ld a,e			;a6e6
	sub 003h		;a6e7
	ld e,a			;a6e9
	jp 0781fh		;a6ea   ; se_puede_pisar: carry si el caracter se puede pisar
L_A6ED:
	ld a,d			;a6ed
	sub 008h		;a6ee
	ccf			;a6f0
	ret nc			;a6f1
	ld d,a			;a6f2
	push de			;a6f3
	call 0781fh		;a6f4   ; se_puede_pisar: carry si el caracter se puede pisar
	pop de			;a6f7
	ret c			;a6f8
	ld a,e			;a6f9
	sub 003h		;a6fa
	ld e,a			;a6fc
	jp 0781fh		;a6fd   ; se_puede_pisar: carry si el caracter se puede pisar
L_A700:
	ld a,e			;a700
	sub 003h		;a701
	ld e,a			;a703
	push de			;a704
	ld a,d			;a705
	sub 008h		;a706
	ld d,a			;a708
	call 0781fh		;a709   ; se_puede_pisar: carry si el caracter se puede pisar
	pop de			;a70c
	ret c			;a70d
	ld a,d			;a70e
	add a,008h		;a70f
	ld d,a			;a711
	jp 0781fh		;a712   ; se_puede_pisar: carry si el caracter se puede pisar
L_A715:
	ld a,0c8h		;a715
	cp e			;a717
	ret c			;a718
	push de			;a719
	ld a,d			;a71a
	sub 008h		;a71b
	ld d,a			;a71d
	call 0781fh		;a71e   ; se_puede_pisar: carry si el caracter se puede pisar
	pop de			;a721
	ret c			;a722
	ld a,d			;a723
	add a,008h		;a724
	ld d,a			;a726
	jp 0781fh		;a727   ; se_puede_pisar: carry si el caracter se puede pisar
L_A72A:
	dec (ix+00bh)		;a72a
	ret nz			;a72d
	ld a,(ix+01fh)		;a72e
	call L_A58A		;a731
	ld a,043h		;a734
	ld (ix+00ah),a		;a736   ; guarda la pose de la figura
	dec (ix+00eh)		;a739
	dec (ix+001h)		;a73c   ; baja el paso en que va la figura
	ld (ix+00ch),003h		;a73f
	call L_A4D6		;a743
	ret			;a746
L_A747:
	call L_ABF6		;a747
	call L_A954		;a74a
	call 0893dh		;a74d   ; pon_la_pose: pone la pose de la figura
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
	ld a,(ix+001h)		;a76a   ; lee el paso en que va la figura
	call 0408dh		;a76d   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A770: 4 destinos del despachador de 0x408D (call en p03:A76D):
;   0xA810, 0xA814, 0xA988, 0xA99F; lo leen p03:A76D (8 bytes)
;   0xa770..0xa778  (8 bytes)
DATA_tabla_A770:
	defb 010h,0a8h	; a770
	defb 014h,0a8h	; a772
	defb 088h,0a9h	; a774
	defb 09fh,0a9h	; a776

; ======================================================================
; CODIGO 0xa778..0xa785  (13 bytes)
; ======================================================================


L_A778:
	ld a,(ix+01dh)		;a778
	or a			;a77b
	jp nz,09fdeh		;a77c
	ld a,(ix+001h)		;a77f   ; lee el paso en que va la figura
	call 0408dh		;a782   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A785: 4 destinos del despachador de 0x408D (call en p03:A782):
;   0xA814, 0xA814, 0xA8EA, 0xA8FE; lo leen p03:A782 (8 bytes)
;   0xa785..0xa78d  (8 bytes)
DATA_tabla_A785:
	defb 014h,0a8h	; a785
	defb 014h,0a8h	; a787
	defb 0eah,0a8h	; a789
	defb 0feh,0a8h	; a78b

; ======================================================================
; CODIGO 0xa78d..0xa800  (115 bytes)
; ======================================================================


L_A78D:
	ld a,(ix+00fh)		;a78d
	or a			;a790
	jr z,L_A7AB		;a791
	ld a,(0c496h)		;a793   ; lee la x del jugador
	sub (ix+005h)		;a796   ; le resta la x de la figura
L_A799:
	ccf			;a799
	ret nc			;a79a
	cp 020h		;a79b
	ret nc			;a79d
	ld a,(0c494h)		;a79e   ; lee la y del jugador
	sub (ix+003h)		;a7a1   ; le resta la y de la figura
	jr nc,L_A7A8		;a7a4
	neg		;a7a6
L_A7A8:
	cp 010h		;a7a8
	ret			;a7aa
L_A7AB:
	ld a,(ix+005h)		;a7ab   ; lee la x de la figura
	ld hl,0c496h		;a7ae   ; apunta a la x del jugador
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
	call 0893dh		;a7f1   ; pon_la_pose: pone la pose de la figura
L_A7F4:
	ld (ix+074h),001h		;a7f4
	jr $+47		;a7f8
L_A7FA:
	ld (ix+074h),000h		;a7fa
	jr $+35		;a7fe

; ----------------------------------------------------------------------
; DATOS dos_tandas_A800: dos tandas de 8 bytes que p03:A7CE recorre con
;   (ix+0x73): 0xA800 con el bit 0 de ix+0x0F a cero y 0xA808 si no (16 bytes)
;   0xa800..0xa810  (16 bytes)
DATA_dos_tandas_A800:
	defb 002h,002h,001h,008h,002h,002h,001h,004h,001h,001h,002h,008h,001h,001h,002h,004h	; a800  ................

; ======================================================================
; CODIGO 0xa810..0xaa51  (577 bytes)
; ======================================================================


L_A810:
	call L_A966		;a810
	ret c			;a813
L_A814:
	ld a,(ix+000h)		;a814   ; lee el tipo de la figura
	cp 019h		;a817
	jp z,L_A7B4		;a819
	cp 020h		;a81c
	jp z,L_A7B4		;a81e
L_A821:
	call L_A954		;a821
	call 0894dh		;a824
L_A827:
	ld a,(ix+001h)		;a827   ; lee el paso en que va la figura
	dec a			;a82a
	jr z,L_A83C		;a82b
	ld a,(0c00dh)		;a82d
	and 003h		;a830
	jr nz,L_A83C		;a832
	dec (ix+013h)		;a834
	jr nz,L_A83C		;a837
	inc (ix+001h)		;a839   ; sube el paso en que va la figura
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
	ld a,(ix+001h)		;a8b3   ; lee el paso en que va la figura
	dec a			;a8b6
	jr z,L_A8DE		;a8b7
	ld hl,0cd20h		;a8b9
	ld (hl),000h		;a8bc
	ld a,(0c494h)		;a8be   ; lee la y del jugador
	sub (ix+003h)		;a8c1   ; le resta la y de la figura
	jr nc,L_A8C9		;a8c4
	neg		;a8c6
	inc (hl)			;a8c8
L_A8C9:
	ld (ix+017h),a		;a8c9
	inc hl			;a8cc
	ld (hl),000h		;a8cd
	ld a,(0c496h)		;a8cf   ; lee la x del jugador
	sub (ix+005h)		;a8d2   ; le resta la x de la figura
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
	inc (ix+001h)		;a8fa   ; sube el paso en que va la figura
	ret			;a8fd
L_A8FE:
	call L_A954		;a8fe
	ld a,04ah		;a901
	call 08950h		;a903
	ld a,(ix+003h)		;a906   ; lee la y de la figura
	cp 060h		;a909
	ret c			;a90b
	call L_AA04		;a90c
	call L_A750		;a90f
	ld (ix+001h),000h		;a912   ; el paso en que va la figura = 0x00
	ret			;a916
L_A917:
	ld a,(ix+001h)		;a917   ; lee el paso en que va la figura
	dec a			;a91a
	ret z			;a91b
	ld a,(ix+000h)		;a91c   ; lee el tipo de la figura
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
	jp 089c2h		;a94b   ; dispara: crea el disparo A (tabla de 0x8B6B)
L_A94E:
	ld (ix+072h),003h		;a94e
	jr L_A93A		;a952
L_A954:
	ld a,(ix+001h)		;a954   ; lee el paso en que va la figura
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
	call 087e4h		;a970   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	call 087ebh		;a973   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld (ix+078h),014h		;a976
	ld a,068h		;a97a
	add a,(ix+00fh)		;a97c
	ld (ix+00ah),a		;a97f   ; guarda la pose de la figura
	ld (ix+001h),002h		;a982   ; el paso en que va la figura = 0x02
	scf			;a986
	ret			;a987
L_A988:
	dec (ix+078h)		;a988
	ret nz			;a98b
	ld (ix+078h),014h		;a98c
	ld a,(ix+00fh)		;a990
	ld (0cd38h),a		;a993
	inc (ix+001h)		;a996   ; sube el paso en que va la figura
	ld a,(ix+07dh)		;a999
	jp 089c2h		;a99c   ; dispara: crea el disparo A (tabla de 0x8B6B)
L_A99F:
	dec (ix+078h)		;a99f
	ret nz			;a9a2
	ld a,(ix+077h)		;a9a3
	ld (ix+078h),a		;a9a6
	ld (ix+001h),000h		;a9a9   ; el paso en que va la figura = 0x00
	call 0893dh		;a9ad   ; pon_la_pose: pone la pose de la figura
	jp L_A080		;a9b0
L_A9B3:
	dec (ix+012h)		;a9b3
	jp z,087b7h		;a9b6   ; borra_la_figura: borra la figura
	ld a,(ix+011h)		;a9b9
	xor 001h		;a9bc
	ld (ix+011h),a		;a9be
	jr z,L_A9CB		;a9c1
	ld a,(ix+005h)		;a9c3   ; lee la x de la figura
	inc a			;a9c6
	ld (ix+005h),a		;a9c7   ; guarda la x de la figura
	ret			;a9ca
L_A9CB:
	ld a,(ix+005h)		;a9cb   ; lee la x de la figura
	dec a			;a9ce
	ld (ix+005h),a		;a9cf   ; guarda la x de la figura
	ret			;a9d2
L_A9D3:
	ld a,(ix+000h)		;a9d3   ; lee el tipo de la figura
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
	ld a,(ix+003h)		;a9e5   ; lee la y de la figura
	ld (ix+010h),a		;a9e8
	ld (ix+011h),000h		;a9eb
	ld (ix+00ch),000h		;a9ef
	ld (ix+012h),020h		;a9f3
	ld de,00000h		;a9f7
	call 087e4h		;a9fa   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	call 087ebh		;a9fd   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	inc (ix+00dh)		;aa00
	ret			;aa03
L_AA04:
	ld a,(ix+000h)		;aa04   ; lee el tipo de la figura
	cp 022h		;aa07
	ret nc			;aa09
	dec a			;aa0a
	add a,a			;aa0b
	add a,a			;aa0c
	ld de,0aa51h		;aa0d
	call 04088h		;aa10   ; de_mas_a: DE += A
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
; DATOS fichas_AA51: 33 fichas de 4 bytes, una por tipo de figura 1-0x21
;   (p03:AA0D): (ix+0x7E), el byte que pasa por p03:AA40 hacia (ix+0x0B), y
;   (ix+0x7D) / (ix+0x1E) en los bits 0-4 y 6-7 del cuarto (132 bytes)
;   0xaa51..0xaad5  (132 bytes)
DATA_fichas_AA51:
	defb 06ah,000h,000h,000h	; aa51
	defb 08fh,000h,001h,00ah	; aa55
	defb 04eh,000h,002h,000h	; aa59
	defb 030h,000h,000h,000h	; aa5d
	defb 004h,000h,0c0h,000h	; aa61
	defb 041h,000h,000h,000h	; aa65
	defb 06eh,000h,080h,000h	; aa69
	defb 043h,000h,000h,000h	; aa6d
	defb 004h,014h,080h,000h	; aa71
	defb 038h,020h,084h,040h	; aa75
	defb 08bh,000h,005h,030h	; aa79
	defb 08bh,000h,005h,010h	; aa7d
	defb 04ah,030h,0c0h,000h	; aa81
	defb 04ah,040h,0c0h,000h	; aa85
	defb 034h,035h,0c3h,0a0h	; aa89
	defb 00ch,000h,040h,000h	; aa8d
	defb 008h,030h,080h,000h	; aa91
	defb 07ah,000h,080h,000h	; aa95
	defb 004h,000h,040h,000h	; aa99
	defb 01ch,000h,040h,000h	; aa9d
	defb 05ch,038h,0c6h,0c0h	; aaa1
	defb 060h,034h,080h,000h	; aaa5
	defb 08bh,027h,080h,000h	; aaa9
	defb 024h,032h,080h,000h	; aaad
	defb 020h,02dh,080h,000h	; aab1
	defb 064h,038h,080h,000h	; aab5
	defb 06eh,000h,080h,000h	; aab9
	defb 06eh,000h,040h,000h	; aabd
	defb 072h,000h,000h,000h	; aac1
	defb 054h,000h,080h,000h	; aac5
	defb 028h,03fh,007h,062h	; aac9
	defb 02ch,034h,080h,000h	; aacd
	defb 000h,000h,000h,000h	; aad1

; ======================================================================
; CODIGO 0xaad5..0xab1d  (72 bytes)
; ======================================================================


L_AAD5:
	ld (ix+00ah),038h		;aad5   ; la pose de la figura = 0x38
	ld (ix+01fh),008h		;aad9
	ld (ix+018h),040h		;aadd
	ld (ix+00bh),020h		;aae1
	ld a,r		;aae5
	ld b,a			;aae7
	ld a,(0c00dh)		;aae8
	add a,b			;aaeb
	ld (ix+005h),a		;aaec   ; guarda la x de la figura
	ld a,(0c00dh)		;aaef
	add a,(ix+005h)		;aaf2   ; le suma la x de la figura
	and 080h		;aaf5
	add a,050h		;aaf7
	ld (ix+003h),a		;aaf9   ; guarda la y de la figura
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
	ld a,(ix+001h)		;ab17   ; lee el paso en que va la figura
	call 0408dh		;ab1a   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_AB1D: 4 destinos del despachador de 0x408D (call en p03:AB1A):
;   0xAB25, 0xAB53, 0xABB2, 0xABC3; lo leen p03:AB1A (8 bytes)
;   0xab1d..0xab25  (8 bytes)
DATA_tabla_AB1D:
	defb 025h,0abh	; ab1d
	defb 053h,0abh	; ab1f
	defb 0b2h,0abh	; ab21
	defb 0c3h,0abh	; ab23

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
	call 087ebh		;ab35   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	call 087e4h		;ab38   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	inc (ix+001h)		;ab3b   ; sube el paso en que va la figura
	ret			;ab3e
L_AB3F:
	ld (ix+001h),002h		;ab3f   ; el paso en que va la figura = 0x02
	call 09fcah		;ab43
	ld a,010h		;ab46
	call 08b76h		;ab48
	call 087e4h		;ab4b   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ex de,hl			;ab4e
	call 087ebh		;ab4f   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
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
	call 087e4h		;ab71   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ex de,hl			;ab74
	call 087ebh		;ab75   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld a,080h		;ab78
	cp h			;ab7a
	ld a,000h		;ab7b
	jr nc,L_AB80		;ab7d
	inc a			;ab7f
L_AB80:
	ld (ix+00fh),a		;ab80
	ld (ix+00bh),020h		;ab83
	ld (ix+001h),000h		;ab87   ; el paso en que va la figura = 0x00
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
	call 089c2h		;aba3   ; dispara: crea el disparo A (tabla de 0x8B6B)
	ld a,005h		;aba6
	call 04fe4h		;aba8   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld (ix+001h),000h		;abab   ; el paso en que va la figura = 0x00
	jp L_AB2E		;abaf
L_ABB2:
	call 09fdeh		;abb2
	ld a,(ix+01dh)		;abb5
	or a			;abb8
	ret nz			;abb9
	ld (ix+00bh),020h		;abba
	ld (ix+001h),001h		;abbe   ; el paso en que va la figura = 0x01
	ret			;abc2
L_ABC3:
	ret			;abc3
L_ABC4:
	dec (ix+075h)		;abc4
	ret nz			;abc7
	ld a,001h		;abc8
	ld (ix+007h),a		;abca   ; guarda la velocidad vertical
	ld a,003h		;abcd
	ld (ix+001h),a		;abcf   ; guarda el paso en que va la figura
	ret			;abd2
L_ABD3:
	call L_ABF6		;abd3
	call L_A954		;abd6
	call 0893dh		;abd9   ; pon_la_pose: pone la pose de la figura
	ld a,(ix+000h)		;abdc   ; lee el tipo de la figura
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
	ld a,(ix+001h)		;ac08   ; lee el paso en que va la figura
	call 0408dh		;ac0b   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_AC0E: 2 destinos del despachador de 0x408D (call en p03:AC0B):
;   0xAC12, 0xACC5; lo leen p03:AC0B (4 bytes)
;   0xac0e..0xac12  (4 bytes)
DATA_tabla_AC0E:
	defb 012h,0ach	; ac0e
	defb 0c5h,0ach	; ac10

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
	call 04088h		;ac41   ; de_mas_a: DE += A
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
	ld a,(0c494h)		;ac5a   ; lee la y del jugador
	cp (ix+003h)		;ac5d   ; compara con la y de la figura
	ld a,008h		;ac60
	jp c,L_A58A		;ac62
	rra			;ac65
	jp L_A58A		;ac66

; ----------------------------------------------------------------------
; DATOS cuatro_bits: 0x08, 0x04, 0x02 y 0x01, uno por valor de 0 a 3
;   (p03:AC3E) (4 bytes)
;   0xac69..0xac6d  (4 bytes)
DATA_cuatro_bits:
	defb 008h,004h,002h,001h	; ac69

; ======================================================================
; CODIGO 0xac6d..0xad7e  (273 bytes)
; ======================================================================


L_AC6D:
	ld a,(ix+01fh)		;ac6d
	and 00ch		;ac70
	ret z			;ac72
	ld a,(ix+005h)		;ac73   ; lee la x de la figura
	ld hl,0c496h		;ac76   ; apunta a la x del jugador
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
	ld a,(0c494h)		;ac9d   ; lee la y del jugador
	add a,010h		;aca0
	sub (ix+003h)		;aca2   ; le resta la y de la figura
	cp 020h		;aca5
	ret nc			;aca7
	ld (ix+01dh),000h		;aca8
	ld a,(ix+00fh)		;acac
	ld (0cd38h),a		;acaf
	ld a,005h		;acb2
	jp 089c2h		;acb4   ; dispara: crea el disparo A (tabla de 0x8B6B)
L_ACB7:
	ld a,(0c00dh)		;acb7
	and 003h		;acba
	ret nz			;acbc
	dec (ix+075h)		;acbd
	ret nz			;acc0
	inc (ix+001h)		;acc1   ; sube el paso en que va la figura
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
	jp 08334h		;acdb   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_ACDE:
	ld de,0806dh		;acde
	ld a,023h		;ace1
	jp 08334h		;ace3   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_ACE6:
	ld (ix+00ah),010h		;ace6   ; la pose de la figura = 0x10
	xor a			;acea
	ld (ix+00ch),a		;aceb
	ld (ix+006h),a		;acee   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;acf1   ; guarda la velocidad vertical
	ld de,00100h		;acf4
	ld (ix+008h),e		;acf7   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),d		;acfa   ; guarda la velocidad horizontal
	ret			;acfd
L_ACFE:
	ld a,010h		;acfe
	ld de,0c00dh		;ad00
	call 0895bh		;ad03
	ld a,(ix+001h)		;ad06   ; lee el paso en que va la figura
	or a			;ad09
	jr nz,L_AD25		;ad0a
	ld a,(ix+005h)		;ad0c   ; lee la x de la figura
	cp 0a0h		;ad0f
	ret c			;ad11
	inc (ix+001h)		;ad12   ; sube el paso en que va la figura
L_AD15:
	ld e,(ix+008h)		;ad15   ; lee la velocidad horizontal (parte baja)
	ld d,(ix+009h)		;ad18   ; lee la velocidad horizontal
	call 08c0ah		;ad1b   ; niega_de: DE = -DE
	ld (ix+008h),e		;ad1e   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),d		;ad21   ; guarda la velocidad horizontal
	ret			;ad24
L_AD25:
	ld a,(ix+005h)		;ad25   ; lee la x de la figura
	cp 050h		;ad28
	ret nc			;ad2a
	ld (ix+001h),000h		;ad2b   ; el paso en que va la figura = 0x00
	jr L_AD15		;ad2f
L_AD31:
	ld de,07887h		;ad31
	ld a,025h		;ad34
	jp 08334h		;ad36   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_AD39:
	ld (ix+00ah),019h		;ad39   ; la pose de la figura = 0x19
	xor a			;ad3d
	ld (ix+00ch),a		;ad3e
	ld (ix+006h),a		;ad41   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;ad44   ; guarda la velocidad vertical
	ld (ix+008h),a		;ad47   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),a		;ad4a   ; guarda la velocidad horizontal
	ld (0cd8ch),a		;ad4d
	ld a,(0c27eh)		;ad50
	or a			;ad53
	jp nz,L_AED5		;ad54
	ld a,(0cd5fh)		;ad57
	and 008h		;ad5a
	add a,a			;ad5c
	ld b,a			;ad5d
	ld a,(0c4b0h)		;ad5e   ; lee el TIEMPO (BCD)
	and 010h		;ad61
	xor b			;ad63
	jp nz,L_AED5		;ad64
	ld a,(0cd5fh)		;ad67
	cp 008h		;ad6a
	ld a,06fh		;ad6c
	jr c,L_AD72		;ad6e
	ld a,070h		;ad70
L_AD72:
	call 04280h		;ad72   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	jp 087b7h		;ad75   ; borra_la_figura: borra la figura
L_AD78:
	ld a,(ix+001h)		;ad78   ; lee el paso en que va la figura
	call 0408dh		;ad7b   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_AD7E: 3 destinos del despachador de 0x408D (call en p03:AD7B):
;   0xAD84, 0xAD97, 0xADD4; lo leen p03:AD7B (6 bytes)
;   0xad7e..0xad84  (6 bytes)
DATA_tabla_AD7E:
	defb 084h,0adh	; ad7e
	defb 097h,0adh	; ad80
	defb 0d4h,0adh	; ad82

; ======================================================================
; CODIGO 0xad84..0xadeb  (103 bytes)
; ======================================================================


L_AD84:
	ld a,(0c006h)		;ad84   ; lee lo que se acaba de apretar (mando y cursores)
	ld b,a			;ad87
	and 010h		;ad88
	jr nz,L_AD93		;ad8a
	ld a,020h		;ad8c
	and b			;ad8e
	ret z			;ad8f
	inc (ix+001h)		;ad90   ; sube el paso en que va la figura
L_AD93:
	inc (ix+001h)		;ad93   ; sube el paso en que va la figura
	ret			;ad96
L_AD97:
	ld (ix+001h),000h		;ad97   ; el paso en que va la figura = 0x00
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
	call 04083h		;adab   ; hl_mas_a: HL += A
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
	call 0447ch		;adc0   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld (ix+003h),d		;adc3   ; guarda la y de la figura
	ld (ix+005h),e		;adc6   ; guarda la x de la figura
	call L_AED5		;adc9
	ret			;adcc
L_ADCD:
	cp 003h		;adcd
	ret nz			;adcf
	xor a			;add0
	dec hl			;add1
	dec hl			;add2
	ret			;add3
L_ADD4:
	ld (ix+001h),000h		;add4   ; el paso en que va la figura = 0x00
	ld a,(0cd8ch)		;add8
	ld hl,0cd83h		;addb
	call 04083h		;adde   ; hl_mas_a: HL += A
	ld a,(hl)			;ade1
	or a			;ade2
	ret z			;ade3
	dec a			;ade4
	ld (0ee80h),a		;ade5
	call 0408dh		;ade8   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_ADEB: 14 destinos del despachador de 0x408D (call en p03:ADE8):
;   0xAE07, 0xAE98, 0xAEA3, 0xAEA3, 0xAEA3, 0xAEA3, 0xAEA3, 0xAE98 ...; lo
;   leen p03:ADE8 (28 bytes)
;   0xadeb..0xae07  (28 bytes)
DATA_tabla_ADEB:
	defb 007h,0aeh	; adeb
	defb 098h,0aeh	; aded
	defb 0a3h,0aeh	; adef
	defb 0a3h,0aeh	; adf1
	defb 0a3h,0aeh	; adf3
	defb 0a3h,0aeh	; adf5
	defb 0a3h,0aeh	; adf7
	defb 098h,0aeh	; adf9
	defb 093h,0aeh	; adfb
	defb 007h,0aeh	; adfd
	defb 0aeh,0aeh	; adff
	defb 0b0h,0aeh	; ae01
	defb 0c4h,0aeh	; ae03
	defb 0b2h,0aeh	; ae05

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
	ld hl,0c270h		;ae1a   ; apunta a las 10 cosas del marcador
	call 04083h		;ae1d   ; hl_mas_a: HL += A
	ld a,(hl)			;ae20
	or a			;ae21
	jr nz,L_AE37		;ae22
	call L_AEF9		;ae24
	ld a,(0ee80h)		;ae27
	ld hl,0c270h		;ae2a   ; apunta a las 10 cosas del marcador
	call 04083h		;ae2d   ; hl_mas_a: HL += A
	ld a,(0ee81h)		;ae30
	ld (hl),a			;ae33
	call 05856h		;ae34   ; pinta_las_cosas: pinta las cosas del marcador
L_AE37:
	ret			;ae37
L_AE38:
	ld a,(0cd8ch)		;ae38
	add a,a			;ae3b
	ld hl,0cd86h		;ae3c
	call 04083h		;ae3f   ; hl_mas_a: HL += A
	ld e,(hl)			;ae42
	inc hl			;ae43
	ld d,(hl)			;ae44
	call L_B539		;ae45
	ret c			;ae48
	ld a,(0cd8ch)		;ae49
	ld hl,0cd83h		;ae4c
	call 04083h		;ae4f   ; hl_mas_a: HL += A
	xor a			;ae52
	ld (hl),a			;ae53
	ld a,015h		;ae54
	call 04fe4h		;ae56   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	or a			;ae59
	ret			;ae5a
L_AE5B:
	call L_AE81		;ae5b
	ld a,(0ee80h)		;ae5e
	ld hl,0c270h		;ae61   ; apunta a las 10 cosas del marcador
	call 04083h		;ae64   ; hl_mas_a: HL += A
	ld a,(hl)			;ae67
	cp 003h		;ae68
	jr z,L_AE37		;ae6a
	call L_AEF9		;ae6c
	ld a,(0ee80h)		;ae6f
	ld hl,0c270h		;ae72   ; apunta a las 10 cosas del marcador
	call 04083h		;ae75   ; hl_mas_a: HL += A
	ld a,(0ee81h)		;ae78
	inc (hl)			;ae7b
	call 05856h		;ae7c   ; pinta_las_cosas: pinta las cosas del marcador
	jr L_AE37		;ae7f
L_AE81:
	ld a,(0cd8ch)		;ae81
	ld hl,09556h		;ae84
	add a,a			;ae87
	call 04083h		;ae88   ; hl_mas_a: HL += A
	ld e,(hl)			;ae8b
	inc hl			;ae8c
	ld d,(hl)			;ae8d
	ld a,0ffh		;ae8e
	jp 04eb9h		;ae90   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
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
	call 05884h		;aeba   ; suma_vida: suma A a la vida, hasta la maxima, y la pinta
	call L_AE81		;aebd
	call L_AEF9		;aec0
	ret			;aec3
L_AEC4:
	call L_AE38		;aec4
	jr c,L_AED9		;aec7
	call L_AE81		;aec9
	call L_AEF9		;aecc
	ld de,00200h		;aecf
	jp 05945h		;aed2   ; suma_tiempo: suma DE (BCD) al tiempo, hasta 5000
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
	call 04088h		;aee5   ; de_mas_a: DE += A
	ld a,c			;aee8
	call 04088h		;aee9   ; de_mas_a: DE += A
	ld a,(de)			;aeec
	call L_B836		;aeed
	ret			;aef0

; ----------------------------------------------------------------------
; DATOS ocho_AEF1: ocho bytes (0x67-0x6E) que p03:AEE2 escoge por 0xCD5F / 4
;   mas C (8 bytes)
;   0xaef1..0xaef9  (8 bytes)
DATA_ocho_AEF1:
	defb 067h,068h,069h,06ah,06bh,06ch,06dh,06eh	; aef1  ghijklmn

; ======================================================================
; CODIGO 0xaef9..0xaf3c  (67 bytes)
; ======================================================================


L_AEF9:
	ld a,(0ee80h)		;aef9
L_AEFC:
	ld hl,0cda0h		;aefc
	call 04083h		;aeff   ; hl_mas_a: HL += A
	ld a,(hl)			;af02
	cp 004h		;af03
	ret z			;af05
	inc (hl)			;af06
	ret			;af07
L_AF08:
	ld de,0181eh		;af08
	ld a,027h		;af0b
	jp 08334h		;af0d   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_AF10:
	ld (ix+00ah),019h		;af10   ; la pose de la figura = 0x19
	xor a			;af14
	ld (ix+00ch),a		;af15
	ld (ix+006h),a		;af18   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;af1b   ; guarda la velocidad vertical
	ld (ix+008h),a		;af1e   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),a		;af21   ; guarda la velocidad horizontal
	ld (ix+00fh),a		;af24
	ld c,0ffh		;af27
	ld hl,0c26fh		;af29
	ld b,00bh		;af2c
	call L_AF6F		;af2e
	ld (ix+001h),000h		;af31   ; el paso en que va la figura = 0x00
	ret			;af35
L_AF36:
	ld a,(ix+001h)		;af36   ; lee el paso en que va la figura
	call 0408dh		;af39   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_AF3C: 3 destinos del despachador de 0x408D (call en p03:AF39):
;   0xAF42, 0xAF5A, 0xB02E; lo leen p03:AF39 (6 bytes)
;   0xaf3c..0xaf42  (6 bytes)
DATA_tabla_AF3C:
	defb 042h,0afh	; af3c
	defb 05ah,0afh	; af3e
	defb 02eh,0b0h	; af40

; ======================================================================
; CODIGO 0xaf42..0xb010  (206 bytes)
; ======================================================================


L_AF42:
	ld a,(0c006h)		;af42   ; lee lo que se acaba de apretar (mando y cursores)
	ld b,a			;af45
	and 010h		;af46
	jr nz,L_AF51		;af48
	ld a,020h		;af4a
	and b			;af4c
	ret z			;af4d
	inc (ix+001h)		;af4e   ; sube el paso en que va la figura
L_AF51:
	inc (ix+001h)		;af51   ; sube el paso en que va la figura
	ld a,016h		;af54
	call L_B836		;af56
	ret			;af59
L_AF5A:
	ld (ix+00fh),000h		;af5a
	ld (ix+001h),000h		;af5e   ; el paso en que va la figura = 0x00
	ld b,009h		;af62
	ld hl,0cd8ch		;af64
	ld a,(hl)			;af67
	ld c,a			;af68
	ld hl,0c270h		;af69   ; apunta a las 10 cosas del marcador
	call 04083h		;af6c   ; hl_mas_a: HL += A
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
	call 04088h		;af84   ; de_mas_a: DE += A
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
	ld (ix+005h),a		;af97   ; guarda la x de la figura
	call 0932ah		;af9a
	ld a,(0cd8ch)		;af9d
	ld b,a			;afa0
	add a,a			;afa1
	call 04088h		;afa2   ; de_mas_a: DE += A
	ex de,hl			;afa5
	call L_AFBE		;afa6
	ld hl,0cd87h		;afa9
	ld de,06087h		;afac
	ld b,002h		;afaf
	call 04420h		;afb1   ; pinta_bcd: pinta cifras en BCD
	ld de,08087h		;afb4
	ld hl,05050h		;afb7
	call 04ef1h		;afba
	ret			;afbd
L_AFBE:
	ld a,b			;afbe
	ld de,0cda0h		;afbf
	call 04088h		;afc2   ; de_mas_a: DE += A
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
; DATOS diez_B010: diez bytes que p03:AF81 escoge por 0xCD8C (10 bytes)
;   0xb010..0xb01a  (10 bytes)
DATA_diez_B010:
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
	ld hl,0c270h		;b02a   ; apunta a las 10 cosas del marcador
	ret			;b02d
L_B02E:
	ld (ix+001h),000h		;b02e   ; el paso en que va la figura = 0x00
	ld a,(ix+00fh)		;b032
	or a			;b035
	ret nz			;b036
	ld a,(0cd8ch)		;b037
	ld hl,0c270h		;b03a   ; apunta a las 10 cosas del marcador
	call 04083h		;b03d   ; hl_mas_a: HL += A
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
	jp 05856h		;b068   ; pinta_las_cosas: pinta las cosas del marcador
L_B06B:
	ld (ix+001h),003h		;b06b   ; el paso en que va la figura = 0x03
	ret			;b06f
L_B070:
	ld a,(0c27fh)		;b070   ; lee si se puede continuar
	or a			;b073
	ret nz			;b074
	ld a,01bh		;b075
	call L_B836		;b077
	ld a,001h		;b07a
	ld (0c27fh),a		;b07c   ; guarda si se puede continuar
	ret			;b07f
L_B080:
	ld de,07058h		;b080
	jp 08334h		;b083   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_B086:
	ld (ix+00ah),01ah		;b086   ; la pose de la figura = 0x1A
	xor a			;b08a
	ld (0cd82h),a		;b08b
	ld (ix+00ch),a		;b08e
	ld d,a			;b091
	ld e,a			;b092
	call 087ebh		;b093   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	call 087e4h		;b096   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld a,090h		;b099
	ld (0cd93h),a		;b09b
	ret			;b09e
L_B09F:
	ld a,(ix+001h)		;b09f   ; lee el paso en que va la figura
	call 0408dh		;b0a2   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B0A5: 4 destinos del despachador de 0x408D (call en p03:B0A2):
;   0xB0AD, 0xB0C0, 0xB0D4, 0xB0E6; lo leen p03:B0A2 (8 bytes)
;   0xb0a5..0xb0ad  (8 bytes)
DATA_tabla_B0A5:
	defb 0adh,0b0h	; b0a5
	defb 0c0h,0b0h	; b0a7
	defb 0d4h,0b0h	; b0a9
	defb 0e6h,0b0h	; b0ab

; ======================================================================
; CODIGO 0xb0ad..0xb130  (131 bytes)
; ======================================================================


L_B0AD:
	ld a,(0c006h)		;b0ad   ; lee lo que se acaba de apretar (mando y cursores)
	ld b,a			;b0b0
	and 010h		;b0b1
	jr nz,L_B0BC		;b0b3
	ld a,020h		;b0b5
	and b			;b0b7
	ret z			;b0b8
	inc (ix+001h)		;b0b9   ; sube el paso en que va la figura
L_B0BC:
	inc (ix+001h)		;b0bc   ; sube el paso en que va la figura
	ret			;b0bf
L_B0C0:
	ld (ix+001h),000h		;b0c0   ; el paso en que va la figura = 0x00
	ld a,(ix+005h)		;b0c4   ; lee la x de la figura
	cp 070h		;b0c7
	ld a,(0cd93h)		;b0c9
	jr z,L_B0D0		;b0cc
	ld a,070h		;b0ce
L_B0D0:
	ld (ix+005h),a		;b0d0   ; guarda la x de la figura
	ret			;b0d3
L_B0D4:
	ld a,(ix+005h)		;b0d4   ; lee la x de la figura
	cp 070h		;b0d7
	ld a,001h		;b0d9
	jr z,L_B0DF		;b0db
	ld a,002h		;b0dd
L_B0DF:
	ld (0cd82h),a		;b0df
	inc (ix+001h)		;b0e2   ; sube el paso en que va la figura
	ret			;b0e5
L_B0E6:
	ld a,(0cd91h)		;b0e6
	or a			;b0e9
	ret z			;b0ea
	xor a			;b0eb
	ld (0cd91h),a		;b0ec
	jp 087b7h		;b0ef   ; borra_la_figura: borra la figura
L_B0F2:
	ld de,0806dh		;b0f2
	ld a,028h		;b0f5
	jp 08334h		;b0f7   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_B0FA:
	ld (ix+00ah),010h		;b0fa   ; la pose de la figura = 0x10
	xor a			;b0fe
	ld (ix+00ch),a		;b0ff
	ld (ix+006h),a		;b102   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;b105   ; guarda la velocidad vertical
	ld (ix+008h),a		;b108   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),a		;b10b   ; guarda la velocidad horizontal
	ld (0cd82h),a		;b10e
	ld a,(0c27eh)		;b111
	or a			;b114
	ld a,026h		;b115
	call nz,0828fh		;b117
	ld a,(0c27eh)		;b11a
	or a			;b11d
	jp z,L_B1A7		;b11e
	xor a			;b121
	call 04280h		;b122   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ld a,019h		;b125
	jp 04280h		;b127   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
L_B12A:
	ld a,(ix+001h)		;b12a   ; lee el paso en que va la figura
	call 0408dh		;b12d   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B130: 3 destinos del despachador de 0x408D (call en p03:B12D):
;   0xB136, 0xB15C, 0xB165; lo leen p03:B12D (6 bytes)
;   0xb130..0xb136  (6 bytes)
DATA_tabla_B130:
	defb 036h,0b1h	; b130
	defb 05ch,0b1h	; b132
	defb 065h,0b1h	; b134

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
	inc (ix+001h)		;b144   ; sube el paso en que va la figura
	ld a,016h		;b147
	call L_B836		;b149
	ld a,027h		;b14c
	call 0828fh		;b14e
	ret			;b151
L_B152:
	ld a,01ah		;b152
	call L_B836		;b154
	ld (ix+001h),002h		;b157   ; el paso en que va la figura = 0x02
	ret			;b15b
L_B15C:
	ld a,(0cd92h)		;b15c
	or a			;b15f
	ret z			;b160
	inc (ix+001h)		;b161   ; sube el paso en que va la figura
	ret			;b164
L_B165:
	ret			;b165
L_B166:
	ld de,08070h		;b166
	jp 08334h		;b169   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_B16C:
	ld (ix+00ah),010h		;b16c   ; la pose de la figura = 0x10
	xor a			;b170
	ld (ix+00ch),a		;b171
	ld (ix+006h),a		;b174   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;b177   ; guarda la velocidad vertical
	ld (ix+008h),a		;b17a   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),a		;b17d   ; guarda la velocidad horizontal
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
	call 04280h		;b1a0   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	xor a			;b1a3
	jp 04280h		;b1a4   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
L_B1A7:
	ld a,018h		;b1a7
	call 04280h		;b1a9   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ld a,(0c280h)		;b1ac   ; lee la ZONA (0-6)
	cp 006h		;b1af
	ld a,01ch		;b1b1
	jr nz,L_B1B7		;b1b3
	ld a,01dh		;b1b5
L_B1B7:
	jp 04280h		;b1b7   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
L_B1BA:
	ld a,(ix+001h)		;b1ba   ; lee el paso en que va la figura
	call 0408dh		;b1bd   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B1C0: 4 destinos del despachador de 0x408D (call en p03:B1BD):
;   0xB1C8, 0xB1FF, 0xB213, 0xB25E; lo leen p03:B1BD (8 bytes)
;   0xb1c0..0xb1c8  (8 bytes)
DATA_tabla_B1C0:
	defb 0c8h,0b1h	; b1c0
	defb 0ffh,0b1h	; b1c2
	defb 013h,0b2h	; b1c4
	defb 05eh,0b2h	; b1c6

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
	call 04280h		;b1df   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ld a,001h		;b1e2
	ld (0cd91h),a		;b1e4
	inc (ix+001h)		;b1e7   ; sube el paso en que va la figura
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
	inc (ix+001h)		;b207   ; sube el paso en que va la figura
	inc (ix+00ah)		;b20a   ; sube la pose de la figura
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
	inc (ix+001h)		;b223   ; sube el paso en que va la figura
	dec hl			;b226
	ld b,(hl)			;b227
	add a,b			;b228
	and 001h		;b229
	ld b,a			;b22b
	ld a,(0cd8fh)		;b22c
	dec a			;b22f
	xor b			;b230
	jr nz,L_B247		;b231
	ld de,(0c265h)		;b233   ; lee el DINERO (ryo, BCD)
	call 0592bh		;b237
	ld a,008h		;b23a
	call L_B836		;b23c
	call L_B25F		;b23f
	ld a,019h		;b242
	jp 04fe4h		;b244   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_B247:
	call 0701eh		;b247
	call 0593ah		;b24a   ; pinta_el_dinero: pinta el dinero (4 cifras) en (0x70, 8)
	ld a,009h		;b24d
	call L_B836		;b24f
	call L_B25F		;b252
	ld a,018h		;b255
	jp 04fe4h		;b257   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_B25A:
	ld (ix+001h),003h		;b25a   ; el paso en que va la figura = 0x03
L_B25E:
	ret			;b25e
L_B25F:
	ld a,(0cd8eh)		;b25f
	add a,020h		;b262
	ld de,07040h		;b264
	call 0491ch		;b267   ; letra: pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco
	ld a,(0cd8dh)		;b26a
	add a,020h		;b26d
	ld de,08040h		;b26f
	call 0491ch		;b272   ; letra: pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco
	ld a,(0cd8dh)		;b275
	ld b,a			;b278
	ld a,(0cd8eh)		;b279
	add a,b			;b27c
	and 001h		;b27d
	ld a,00ah		;b27f
	jr z,L_B285		;b281
	ld a,00bh		;b283
L_B285:
	call 04280h		;b285   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ret			;b288
L_B289:
	ld de,(0c265h)		;b289   ; lee el DINERO (ryo, BCD)
	ld a,e			;b28d
	or d			;b28e
	ret nz			;b28f
	call 092adh		;b290
	ld a,01bh		;b293
	call 04fe4h		;b295   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	scf			;b298
	ret			;b299
L_B29A:
	ld de,0a087h		;b29a
	ld a,029h		;b29d
	jp 08334h		;b29f   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_B2A2:
	ld de,06087h		;b2a2
	ld a,02ah		;b2a5
	jp 08334h		;b2a7   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_B2AA:
	ld (ix+00ah),013h		;b2aa   ; la pose de la figura = 0x13
	ld b,(ix+000h)		;b2ae   ; lee el tipo de la figura
	ld a,(ix+005h)		;b2b1   ; lee la x de la figura
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
	call 087e4h		;b2cc   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	jp 087ebh		;b2cf   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_B2D2:
	ld a,(ix+001h)		;b2d2   ; lee el paso en que va la figura
	call 0408dh		;b2d5   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B2D8: 3 destinos del despachador de 0x408D (call en p03:B2D5):
;   0xB2DE, 0xB2E7, 0xB31F; lo leen p03:B2D5 (6 bytes)
;   0xb2d8..0xb2de  (6 bytes)
DATA_tabla_B2D8:
	defb 0deh,0b2h	; b2d8
	defb 0e7h,0b2h	; b2da
	defb 01fh,0b3h	; b2dc

; ======================================================================
; CODIGO 0xb2de..0xb372  (148 bytes)
; ======================================================================


L_B2DE:
	ld a,(0cd90h)		;b2de
	or a			;b2e1
	ret z			;b2e2
	inc (ix+001h)		;b2e3   ; sube el paso en que va la figura
	ret			;b2e6
L_B2E7:
	ld a,(0c00dh)		;b2e7
	and 001h		;b2ea
	ret nz			;b2ec
	ld a,(ix+000h)		;b2ed   ; lee el tipo de la figura
	cp 02ah		;b2f0
	call z,L_B303		;b2f2
	dec (ix+00bh)		;b2f5
	jr z,L_B30C		;b2f8
	ld a,00fh		;b2fa
	call 04fe4h		;b2fc   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
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
	ld a,(ix+00ah)		;b314   ; lee la pose de la figura
	sub 013h		;b317
	inc a			;b319
	ld (hl),a			;b31a
	inc (ix+001h)		;b31b   ; sube el paso en que va la figura
	ret			;b31e
L_B31F:
	ret			;b31f
L_B320:
	ld b,013h		;b320
	inc (ix+00ah)		;b322   ; sube la pose de la figura
	ld a,(ix+00ah)		;b325   ; lee la pose de la figura
	sub b			;b328
	cp 006h		;b329
	jr c,L_B332		;b32b
	ld a,013h		;b32d
	ld (ix+00ah),a		;b32f   ; guarda la pose de la figura
L_B332:
	push ix		;b332
	pop hl			;b334
	ld a,(ix+00ah)		;b335   ; lee la pose de la figura
	ld b,002h		;b338
	cp 013h		;b33a
	jr nz,L_B340		;b33c
	ld b,003h		;b33e
L_B340:
	ld a,b			;b340
	ld (ix+025h),a		;b341
	jp 054e6h		;b344   ; colores_de_la_figura: los 16 colores de cada sprite de la figura, con la lista de su pose (0x554E)
L_B347:
	ld de,0889ah		;b347
	ld a,02ch		;b34a
	jp 08334h		;b34c   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_B34F:
	ld (ix+00ah),03eh		;b34f   ; la pose de la figura = 0x3E
	xor a			;b353
	ld (ix+00ch),a		;b354
	ld (ix+006h),a		;b357   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;b35a   ; guarda la velocidad vertical
	ld (ix+008h),a		;b35d   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),a		;b360   ; guarda la velocidad horizontal
	inc a			;b363
	ld (ix+00eh),a		;b364
	ld a,002h		;b367
	jp 04280h		;b369   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
L_B36C:
	ld a,(ix+001h)		;b36c   ; lee el paso en que va la figura
	call 0408dh		;b36f   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B372: 6 destinos del despachador de 0x408D (call en p03:B36F):
;   0xB37E, 0xB3E9, 0xB49D, 0xB534, 0xB4DF, 0xB508; lo leen p03:B36F (12
;   bytes)
;   0xb372..0xb37e  (12 bytes)
DATA_tabla_B372:
	defb 07eh,0b3h	; b372
	defb 0e9h,0b3h	; b374
	defb 09dh,0b4h	; b376
	defb 034h,0b5h	; b378
	defb 0dfh,0b4h	; b37a
	defb 008h,0b5h	; b37c

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
	inc (ix+001h)		;b395   ; sube el paso en que va la figura
	ld (ix+00bh),000h		;b398
	ld (ix+075h),008h		;b39c
	ld a,000h		;b3a0
	call 04fe4h		;b3a2   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,001h		;b3a5
	ld (0cd32h),a		;b3a7
	ld (0cd91h),a		;b3aa
	ld a,(0c498h)		;b3ad   ; lee la y de los sprites del jugador
	ld (0cd33h),a		;b3b0
	ld a,(0c494h)		;b3b3   ; lee la y del jugador
	ld (0cd34h),a		;b3b6
	ld a,0f0h		;b3b9
	ld (0c498h),a		;b3bb   ; guarda la y de los sprites del jugador
	ld (0c494h),a		;b3be   ; guarda la y del jugador
	ld hl,00000h		;b3c1
	ld (0c49bh),hl		;b3c4
	ld (0c49dh),hl		;b3c7
	ret			;b3ca
L_B3CB:
	ld a,007h		;b3cb
	call L_B836		;b3cd
	ld a,001h		;b3d0
	ld (0cd91h),a		;b3d2
	ld (ix+001h),003h		;b3d5   ; el paso en que va la figura = 0x03
	ret			;b3d9
L_B3DA:
	ld a,001h		;b3da
	ld (0cd91h),a		;b3dc
	ld a,004h		;b3df
	call L_B836		;b3e1
	ld (ix+001h),003h		;b3e4   ; el paso en que va la figura = 0x03
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
	call 045eeh		;b3fd   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 045cbh		;b400   ; borra_la_pagina: esconde los sprites y pinta del color 0 los 256 x 256 puntos
	ld a,(0c002h)		;b403   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	rla			;b406
	ld hl,090a0h		;b407
	ld bc,0161bh		;b40a
	jr nc,L_B415		;b40d
	ld hl,0c8a0h		;b40f
	ld bc,01a1dh		;b412
L_B415:
	ld de,08080h		;b415
	ld a,001h		;b418
	call 0476eh		;b41a   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
	call 04cfch		;b41d   ; paleta_base: pone la paleta base
	call 04d08h		;b420
	ld a,005h		;b423
	ld de,07603h		;b425
	call 0463ch		;b428   ; pon_un_color: color A de la paleta = DE
	ld (ix+00eh),000h		;b42b
	ld (ix+00bh),005h		;b42f
	inc (ix+001h)		;b433   ; sube el paso en que va la figura
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
	call 04083h		;b44c   ; hl_mas_a: HL += A
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
	call 0463ch		;b46a   ; pon_un_color: color A de la paleta = DE
	djnz L_B444		;b46d
	ret			;b46f

; ----------------------------------------------------------------------
; DATOS quince_tripletes: 15 tripletes que p03:B444 recorre de atras adelante
;   (B de 15 a 1): dos bytes a los que resta C (nunca por debajo de 0) y un
;   tercero (45 bytes)
;   0xb470..0xb49d  (45 bytes)
DATA_quince_tripletes:
	defb 006h,003h,004h	; b470
	defb 000h,000h,000h	; b473
	defb 007h,000h,000h	; b476
	defb 007h,006h,006h	; b479
	defb 001h,006h,003h	; b47c
	defb 006h,003h,004h	; b47f
	defb 002h,000h,001h	; b482
	defb 007h,000h,005h	; b485
	defb 004h,001h,002h	; b488
	defb 004h,000h,002h	; b48b
	defb 003h,000h,001h	; b48e
	defb 004h,004h,004h	; b491
	defb 001h,000h,001h	; b494
	defb 007h,007h,007h	; b497
	defb 003h,001h,002h	; b49a

; ======================================================================
; CODIGO 0xb49d..0xb535  (152 bytes)
; ======================================================================


L_B49D:
	ld a,(0c002h)		;b49d   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
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
	call 04088h		;b4b6   ; de_mas_a: DE += A
	ld a,(de)			;b4b9
	add a,c			;b4ba
	ld (ix+00ah),a		;b4bb   ; guarda la pose de la figura
	ld a,(ix+018h)		;b4be
	cp 002h		;b4c1
	ld a,017h		;b4c3
	call z,04fe4h		;b4c5   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	dec (ix+018h)		;b4c8
	ret nz			;b4cb
	ld (ix+018h),004h		;b4cc
	dec (ix+00bh)		;b4d0
	ret nz			;b4d3
	ld (ix+00bh),00ah		;b4d4
	inc (ix+001h)		;b4d8   ; sube el paso en que va la figura
	inc (ix+001h)		;b4db   ; sube el paso en que va la figura
	ret			;b4de
L_B4DF:
	dec (ix+00bh)		;b4df
	ret nz			;b4e2
	call 045eeh		;b4e3   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	ld a,096h		;b4e6
	call 04fe4h		;b4e8   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call 051edh		;b4eb   ; monta_la_pantalla: monta en 0xD800 la pantalla de la casilla: 8 x 6 bloques de 4 x 4 caracteres
	call 0534eh		;b4ee   ; pinta_la_pantalla: pinta los caracteres de 0xD800 en la pantalla
	ld de,00020h		;b4f1
	call 05884h		;b4f4   ; suma_vida: suma A a la vida, hasta la maxima, y la pinta
	call 043e2h		;b4f7   ; pinta_el_marcador: pinta el marcador entero
	call 04cfch		;b4fa   ; paleta_base: pone la paleta base
	call 04d08h		;b4fd
	inc (ix+001h)		;b500   ; sube el paso en que va la figura
	ld (ix+00bh),010h		;b503
	ret			;b507
L_B508:
	call 0460ah		;b508   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	dec (ix+00bh)		;b50b
	ret nz			;b50e
	call 045e1h		;b50f   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	xor a			;b512
	ld (0cd32h),a		;b513
	ld a,(0cd33h)		;b516
	ld (0c498h),a		;b519   ; guarda la y de los sprites del jugador
	ld a,(0cd34h)		;b51c
	ld (0c494h),a		;b51f   ; guarda la y del jugador
	ld a,081h		;b522
	call 04fe4h		;b524   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,00fh		;b527
	call L_AEFC		;b529
	ld a,003h		;b52c
	call 04280h		;b52e   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	jp 087b7h		;b531   ; borra_la_figura: borra la figura
L_B534:
	ret			;b534

; ----------------------------------------------------------------------
; DATOS cuatro_B535: cuatro bytes que p03:B4B3 escoge por (ix+0x18) - 1 (4
;   bytes)
;   0xb535..0xb539  (4 bytes)
DATA_cuatro_B535:
	defb 002h,001h,000h,001h	; b535

; ======================================================================
; CODIGO 0xb539..0xb579  (64 bytes)
; ======================================================================


L_B539:
	ld hl,(0c265h)		;b539   ; lee el DINERO (ryo, BCD)
	push de			;b53c
	rst 20h			;b53d
	pop de			;b53e
	jp nc,05958h		;b53f   ; resta_dinero: resta DE ryo (BCD) al dinero, hasta 0
	ld a,01bh		;b542
	call 04fe4h		;b544   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	scf			;b547
	ret			;b548
L_B549:
	ld de,08070h		;b549
	ld a,02bh		;b54c
	jp 08334h		;b54e   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_B551:
	ld (ix+00ah),00eh		;b551   ; la pose de la figura = 0x0E
	xor a			;b555
	ld (ix+00ch),a		;b556
	ld (ix+006h),a		;b559   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;b55c   ; guarda la velocidad vertical
	ld (ix+008h),a		;b55f   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),a		;b562   ; guarda la velocidad horizontal
	inc a			;b565
	ld (ix+00eh),a		;b566
	xor a			;b569
	call 04280h		;b56a   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ld a,071h		;b56d
	call 04280h		;b56f   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ret			;b572
L_B573:
	ld a,(ix+001h)		;b573   ; lee el paso en que va la figura
	call 0408dh		;b576   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B579: 3 destinos del despachador de 0x408D (call en p03:B576):
;   0xB57F, 0xB58E, 0xB5C8; lo leen p03:B576 (6 bytes)
;   0xb579..0xb57f  (6 bytes)
DATA_tabla_B579:
	defb 07fh,0b5h	; b579
	defb 08eh,0b5h	; b57b
	defb 0c8h,0b5h	; b57d

; ======================================================================
; CODIGO 0xb57f..0xb698  (281 bytes)
; ======================================================================


L_B57F:
	inc (ix+001h)		;b57f   ; sube el paso en que va la figura
	ld hl,0cd87h		;b582
	ld de,08838h		;b585
	ld b,002h		;b588
	call 04420h		;b58a   ; pinta_bcd: pinta cifras en BCD
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
	call 04eb9h		;b5ad   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
	ld a,001h		;b5b0
	ld (0cdb0h),a		;b5b2
	ld a,091h		;b5b5
	call 04fe4h		;b5b7   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	jr L_B5C0		;b5ba
L_B5BC:
	ld a,06eh		;b5bc
	jr L_B5C2		;b5be
L_B5C0:
	ld a,007h		;b5c0
L_B5C2:
	call L_B836		;b5c2
	inc (ix+001h)		;b5c5   ; sube el paso en que va la figura
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
	call 08334h		;b5d7   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
	pop bc			;b5da
	push bc			;b5db
	call 08334h		;b5dc   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
	pop bc			;b5df
	push bc			;b5e0
	call 08334h		;b5e1   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
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
	ld a,(ix+000h)		;b60c   ; lee el tipo de la figura
	cp 007h		;b60f
	jr z,L_B623		;b611
	ld de,0b058h		;b613
	ld (ix+005h),d		;b616   ; guarda la x de la figura
	ld (ix+003h),e		;b619   ; guarda la y de la figura
	ld (ix+001h),002h		;b61c   ; el paso en que va la figura = 0x02
	jp 0893dh		;b620   ; pon_la_pose: pone la pose de la figura
L_B623:
	ld (ix+001h),001h		;b623   ; el paso en que va la figura = 0x01
	ld de,(0cd4ah)		;b627
	ld (ix+005h),d		;b62b   ; guarda la x de la figura
	ld (ix+003h),e		;b62e   ; guarda la y de la figura
	ld a,(0cd4ch)		;b631
	ld (ix+01fh),a		;b634
	and 001h		;b637
	ld (ix+00fh),a		;b639
	ld de,00000h		;b63c
	call 087e4h		;b63f   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	call 087ebh		;b642   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld a,(0cd14h)		;b645
	or a			;b648
	call nz,087b7h		;b649   ; borra_la_figura: borra la figura
	ld a,(0cd31h)		;b64c
	cp 001h		;b64f
	ret nz			;b651
	call 09763h		;b652
	ld d,(ix+005h)		;b655   ; lee la x de la figura
	ld e,(ix+003h)		;b658   ; lee la y de la figura
	ld (0cd4ah),de		;b65b
	ld a,(ix+01fh)		;b65f
	ld (0cd4ch),a		;b662
	ld a,(ix+01fh)		;b665
	and 001h		;b668
	ld (ix+00fh),a		;b66a
	call 0893dh		;b66d   ; pon_la_pose: pone la pose de la figura
	ld de,00000h		;b670
	call 087e4h		;b673   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	call 087ebh		;b676   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
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
	jp 08334h		;b68a   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_B68D:
	ld (ix+00ah),010h		;b68d   ; la pose de la figura = 0x10
	ret			;b691
L_B692:
	ld a,(ix+001h)		;b692   ; lee el paso en que va la figura
	call 0408dh		;b695   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B698: 6 destinos del despachador de 0x408D (call en p03:B695):
;   0xB6A4, 0xB72E, 0xB790, 0xB7B4, 0xB7B3, 0xB824; lo leen p03:B695 (12
;   bytes)
;   0xb698..0xb6a4  (12 bytes)
DATA_tabla_B698:
	defb 0a4h,0b6h	; b698
	defb 02eh,0b7h	; b69a
	defb 090h,0b7h	; b69c
	defb 0b4h,0b7h	; b69e
	defb 0b3h,0b7h	; b6a0
	defb 024h,0b8h	; b6a2

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
	call 04088h		;b6bd   ; de_mas_a: DE += A
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
	call 04280h		;b6d1   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	inc (ix+001h)		;b6d4   ; sube el paso en que va la figura
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
	ld a,(0c280h)		;b6ed   ; lee la ZONA (0-6)
	cp 006h		;b6f0
	ld a,01eh		;b6f2
	jr nz,L_B6F8		;b6f4
	ld a,01fh		;b6f6
L_B6F8:
	push hl			;b6f8
	push bc			;b6f9
	call 04280h		;b6fa   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
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
	ld de,(0c265h)		;b70c   ; lee el DINERO (ryo, BCD)
	call 05958h		;b710   ; resta_dinero: resta DE ryo (BCD) al dinero, hasta 0
	jp L_B7AB		;b713

; ----------------------------------------------------------------------
; DATOS siete_B716: siete bytes que p03:B6BA escoge por los bits 0-6 de (HL)
;   mas B (7 bytes)
;   0xb716..0xb71d  (7 bytes)
DATA_siete_B716:
	defb 00fh,012h,014h,00fh,00fh,066h,013h	; b716

; ======================================================================
; CODIGO 0xb71d..0xb882  (357 bytes)
; ======================================================================


L_B71D:
	ld a,(0c28dh)		;b71d
	ld b,a			;b720
	ld hl,0c340h		;b721
	ld a,(0c281h)		;b724   ; lee la CASILLA de la zona
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
	inc (ix+001h)		;b747   ; sube el paso en que va la figura
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
	ld (ix+001h),004h		;b759   ; el paso en que va la figura = 0x04
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
	inc (ix+001h)		;b7a2   ; sube el paso en que va la figura
	ret			;b7a5
L_B7A6:
	sub c			;b7a6
	jr nc,L_B7A6		;b7a7
	add a,c			;b7a9
	ret			;b7aa
L_B7AB:
	ld (ix+00bh),060h		;b7ab
	ld (ix+001h),005h		;b7af   ; el paso en que va la figura = 0x05
L_B7B3:
	ret			;b7b3
L_B7B4:
	dec (ix+00bh)		;b7b4
	ret nz			;b7b7
	ld a,015h		;b7b8
	call L_B836		;b7ba
	xor a			;b7bd
	ld (0c482h),a		;b7be   ; guarda la pantalla especial
	ld (0cd2eh),a		;b7c1
	ld a,003h		;b7c4
	ld (0c490h),a		;b7c6   ; guarda el estado del jugador
	ld a,08bh		;b7c9
	call 04fe4h		;b7cb   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call 067dah		;b7ce   ; esconde_los_sprites_de_ram: saca de la pantalla los sprites de la copia en RAM
	jr L_B759		;b7d1
L_B7D3:
	ld hl,(0c265h)		;b7d3   ; lee el DINERO (ryo, BCD)
	ld a,l			;b7d6
	and 00fh		;b7d7
	cp 005h		;b7d9
	ld de,00300h		;b7db
	jr z,L_B803		;b7de
	ld de,01000h		;b7e0
	rst 20h			;b7e3
	ld de,00990h		;b7e4
	jr nc,L_B803		;b7e7
	ld hl,(0c265h)		;b7e9   ; lee el DINERO (ryo, BCD)
	ld de,00031h		;b7ec
	rst 20h			;b7ef
	ld de,00100h		;b7f0
	jr c,L_B803		;b7f3
	ld de,(0c265h)		;b7f5   ; lee el DINERO (ryo, BCD)
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
	call 04420h		;b80f   ; pinta_bcd: pinta cifras en BCD
	ld de,(0ee80h)		;b812
	ld hl,(0c265h)		;b816   ; lee el DINERO (ryo, BCD)
	rst 20h			;b819
	push af			;b81a
	ld de,(0ee80h)		;b81b
	call 05958h		;b81f   ; resta_dinero: resta DE ryo (BCD) al dinero, hasta 0
	pop af			;b822
	ret			;b823
L_B824:
	dec (ix+00bh)		;b824
	ret nz			;b827
L_B828:
	xor a			;b828
	ld (0cd2eh),a		;b829
	inc a			;b82c
	ld (0c4a2h),a		;b82d   ; guarda el lado al que mira el jugador
	call 045eeh		;b830   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	jp 072b8h		;b833
L_B836:
	push af			;b836
	call 092adh		;b837
	ld a,016h		;b83a
	call 04280h		;b83c   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	pop af			;b83f
	jp 04280h		;b840   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
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
; DATOS ocho_B882: ocho fichas de 4 bytes [x][y][dibujo de dos bytes] que
;   p03:B86C pinta con p00:4EF1 (32 bytes)
;   0xb882..0xb8a2  (32 bytes)
DATA_ocho_B882:
	defb 028h,040h,008h,090h	; b882
	defb 0a0h,040h,008h,098h	; b886
	defb 028h,0c8h,010h,0e0h	; b88a
	defb 0a0h,0c8h,010h,0e8h	; b88e
	defb 028h,0dch,000h,090h	; b892
	defb 034h,0d0h,000h,0a0h	; b896
	defb 034h,0e8h,000h,098h	; b89a
	defb 040h,0dch,000h,0a8h	; b89e

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
	call 04088h		;b8ad   ; de_mas_a: DE += A
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
	ld a,(0c006h)		;b8c8   ; lee lo que se acaba de apretar (mando y cursores)
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
	call 04083h		;b8ff   ; hl_mas_a: HL += A
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
	call 05a6ah		;b95c   ; sitio_en_el_plano: HL = 0xD800 + H * 28 + L
	ld a,(hl)			;b95f
	cp 006h		;b960
	call z,L_B9AB		;b962
	ld a,(0cdc4h)		;b965
	ld de,0bad9h		;b968
	call 0447ch		;b96b   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,(0cdc6h)		;b96e
	ld b,004h		;b971
	ld c,001h		;b973
L_B975:
	call hl_mas_de		;b975   ; hl_mas_de: HL += DE
	push hl			;b978
	exx			;b979
	pop hl			;b97a
	call 05a6ah		;b97b   ; sitio_en_el_plano: HL = 0xD800 + H * 28 + L
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
	call 0447ch		;b9b5   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,(0cdc6h)		;b9b8
	call hl_mas_de		;b9bb   ; hl_mas_de: HL += DE
	call 05a6ah		;b9be   ; sitio_en_el_plano: HL = 0xD800 + H * 28 + L
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
	call 04088h		;ba02   ; de_mas_a: DE += A
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
	call 0447ch		;ba4d   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,(0cdc6h)		;ba50
	call hl_mas_de		;ba53   ; hl_mas_de: HL += DE
	ld c,005h		;ba56
	exx			;ba58
	ld hl,0cdb3h		;ba59
	ld de,0cdbbh		;ba5c
	exx			;ba5f
	jr L_BA7B		;ba60
L_BA62:
	ld a,(0cdc4h)		;ba62
	ld de,0bae9h		;ba65
	call 0447ch		;ba68   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,(0cdc6h)		;ba6b
	call hl_mas_de		;ba6e   ; hl_mas_de: HL += DE
	ld c,011h		;ba71
	exx			;ba73
	ld hl,0cdb7h		;ba74
	ld de,0cdbfh		;ba77
	exx			;ba7a
L_BA7B:
	push hl			;ba7b
	ld a,(0cdc4h)		;ba7c
	ld de,0bad9h		;ba7f
	call 0447ch		;ba82   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
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
	call 05a6ah		;ba92   ; sitio_en_el_plano: HL = 0xD800 + H * 28 + L
	ld a,(hl)			;ba95
	pop hl			;ba96
	pop de			;ba97
	pop bc			;ba98
	push bc			;ba99
	call L_BAA5		;ba9a
	pop bc			;ba9d
	call hl_mas_de		;ba9e   ; hl_mas_de: HL += DE
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
hl_mas_de:		; HL += DE
	ld a,l			;bad2
	add a,e			;bad3
	ld l,a			;bad4
	ld a,h			;bad5
	add a,d			;bad6
	ld h,a			;bad7
	ret			;bad8

; ----------------------------------------------------------------------
; DATOS tres_tablas_BAD9: tres tablas de 4 palabras que se escogen por 0xCDC4:
;   0xBAD9 (p03:B8FC, B968, B9B2, BA7F), 0xBAE1 (p03:BA4A) y 0xBAE9 (p03:BA65)
;   (24 bytes)
;   0xbad9..0xbaf1  (24 bytes)
DATA_tres_tablas_BAD9:
	defb 000h,0ffh	; bad9
	defb 001h,000h	; badb
	defb 000h,001h	; badd
	defb 0ffh,000h	; badf
	defb 0ffh,000h	; bae1
	defb 000h,0ffh	; bae3
	defb 001h,000h	; bae5
	defb 000h,001h	; bae7
	defb 001h,000h	; bae9
	defb 000h,001h	; baeb
	defb 0ffh,000h	; baed
	defb 000h,0ffh	; baef

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
	call 04fe4h		;bb00   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call 045eeh		;bb03   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call L_BC3A		;bb06
	call 05856h		;bb09   ; pinta_las_cosas: pinta las cosas del marcador
	call 043e2h		;bb0c   ; pinta_el_marcador: pinta el marcador entero
	call 05890h		;bb0f   ; pinta_la_vida: pinta la barra de vida
	call L_BB1B		;bb12
	call L_BBAA		;bb15
	jp 045e1h		;bb18   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
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
	call 04088h		;bb7f   ; de_mas_a: DE += A
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
	call hl_mas_de		;bb91   ; hl_mas_de: HL += DE
	pop de			;bb94
	djnz L_BB6F		;bb95
	pop hl			;bb97
	pop de			;bb98
	ld a,01ch		;bb99
	call 04088h		;bb9b   ; de_mas_a: DE += A
	push de			;bb9e
	ld de,00008h		;bb9f
	call hl_mas_de		;bba2   ; hl_mas_de: HL += DE
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
	ld a,(0ef80h)		;bbcd   ; lee los SECRETOS que ponen las claves
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
	call 04088h		;bbf8   ; de_mas_a: DE += A
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
; DATOS seis_BC1B: 6 palabras que p03:BB7C escoge por A - 1 y pasa a p00:4EF1
;   (12 bytes)
;   0xbc1b..0xbc27  (12 bytes)
DATA_seis_BC1B:
	defb 098h,068h	; bc1b
	defb 090h,068h	; bc1d
	defb 090h,060h	; bc1f
	defb 000h,000h	; bc21
	defb 000h,000h	; bc23
	defb 000h,000h	; bc25

; ======================================================================
; CODIGO 0xbc27..0xbc74  (77 bytes)
; ======================================================================


L_BC27:
	ld a,(0c006h)		;bc27   ; lee lo que se acaba de apretar (mando y cursores)
	and 010h		;bc2a
	ret z			;bc2c
	xor a			;bc2d
	ld (0cdc8h),a		;bc2e
	call 045eeh		;bc31   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 0598dh		;bc34   ; pinta_lo_del_plano: lo que va encima del plano y el marcador
	jp 045e1h		;bc37   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
L_BC3A:
	ld bc,000d4h		;bc3a
	call 045fbh		;bc3d   ; pinta_de_color_0: rellena del color 0 B x C puntos desde (0, 0) y pone el scroll a 0
	jp 0460ah		;bc40   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
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
	call 05a6ah		;bc5f   ; sitio_en_el_plano: HL = 0xD800 + H * 28 + L
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
	call 0408dh		;bc71   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BC74: 5 destinos del despachador de 0x408D (call en p03:BC71):
;   0xBC7E, 0xBC97, 0xBCA0, 0xBCAD, 0xBCBE; lo leen p03:BC71 (10 bytes)
;   0xbc74..0xbc7e  (10 bytes)
DATA_tabla_BC74:
	defb 07eh,0bch	; bc74
	defb 097h,0bch	; bc76
	defb 0a0h,0bch	; bc78
	defb 0adh,0bch	; bc7a
	defb 0beh,0bch	; bc7c

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
	jp 04eb9h		;bc94   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
L_BC97:
	ld hl,0c279h		;bc97
	inc (hl)			;bc9a
	ld a,009h		;bc9b
	jp 057fah		;bc9d   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
L_BCA0:
	ld a,001h		;bca0
	ld (0c27ah),a		;bca2
L_BCA5:
	ld a,011h		;bca5
	ld de,02830h		;bca7
	jp 04eb9h		;bcaa   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
L_BCAD:
	ld hl,0c260h		;bcad   ; apunta a las vidas
	ld a,(hl)			;bcb0
	add a,001h		;bcb1
	daa			;bcb3
	cp 09ah		;bcb4
	jr c,L_BCBA		;bcb6
	ld a,099h		;bcb8
L_BCBA:
	ld (hl),a			;bcba
	jp 043e2h		;bcbb   ; pinta_el_marcador: pinta el marcador entero
L_BCBE:
	xor a			;bcbe
	ld (0cdd2h),a		;bcbf
	ld (0cdc5h),a		;bcc2
	inc a			;bcc5
	ld (0cdcdh),a		;bcc6
	ld a,00fh		;bcc9
	ld (0cdceh),a		;bccb
	ld a,080h		;bcce
	jp 04fe4h		;bcd0   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
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
	call 04fe4h		;bced   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
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
	call 0408dh		;bd09   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BD0C: 3 destinos del despachador de 0x408D (call en p03:BD09):
;   0xBD12, 0xBDB2, 0xBDD5; lo leen p03:BD09 (6 bytes)
;   0xbd0c..0xbd12  (6 bytes)
DATA_tabla_BD0C:
	defb 012h,0bdh	; bd0c
	defb 0b2h,0bdh	; bd0e
	defb 0d5h,0bdh	; bd10

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
	call 04eb9h		;bd33   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
	ld de,08848h		;bd36
	ld a,014h		;bd39
	call 04eb9h		;bd3b   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
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
	call 0476eh		;bd67   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
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
	call 0476eh		;bd95   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
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
	jp 04732h		;bdaf   ; hmmv: orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)
L_BDB2:
	ld hl,0cdceh		;bdb2
	dec (hl)			;bdb5
	ret nz			;bdb6
	ld a,0a0h		;bdb7
	ld (hl),a			;bdb9
	ld a,00eh		;bdba
	call 04280h		;bdbc   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ld c,001h		;bdbf
	ld de,00000h		;bdc1
	call 04380h		;bdc4
	ld hl,0cdd2h		;bdc7
	inc (hl)			;bdca
	ld a,001h		;bdcb
	ld (0c28eh),a		;bdcd
	ld a,093h		;bdd0
	jp 04fe4h		;bdd2   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_BDD5:
	ld hl,0cdceh		;bdd5
	dec (hl)			;bdd8
	ret nz			;bdd9
	call 045eeh		;bdda   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 072b8h		;bddd
	xor a			;bde0
	ld (0cdb0h),a		;bde1
	ld (0cdb1h),a		;bde4   ; guarda si se esta viendo el plano
	ld (0cdcdh),a		;bde7
	inc a			;bdea
	ld (0c4a2h),a		;bdeb   ; guarda el lado al que mira el jugador
	ld a,00eh		;bdee
	call L_AEFC		;bdf0
	jp 04a96h		;bdf3   ; caracteres_del_juego: sube los caracteres del juego de graficos de la zona
teclea_palabra:		; lo que se teclea en la pausa
	call 06cd8h		;bdf6   ; lee_el_teclado: lee una tecla
	ld a,(0eb81h)		;bdf9   ; lee la tecla
	and a			;bdfc
	ret z			;bdfd
	ld b,a			;bdfe
	ld de,0c580h		;bdff   ; apunta a lo tecleado en la pausa
	ld hl,0c590h		;be02
	ld a,(hl)			;be05
	cp 005h		;be06
	ret nc			;be08
	call 04088h		;be09   ; de_mas_a: DE += A
	ld a,b			;be0c
	ld (de),a			;be0d
	inc (hl)			;be0e
	ld a,(hl)			;be0f
	cp 005h		;be10
	ret nz			;be12
	ld a,(0cdb1h)		;be13   ; lee si se esta viendo el plano
	and a			;be16
	jr z,L_BE2C		;be17
	ld de,0be44h		;be19
	ld c,001h		;be1c
	call L_BE31		;be1e
	ld a,(0ef80h)		;be21   ; lee los SECRETOS que ponen las claves
	rra			;be24
	ret nc			;be25
	ld a,001h		;be26
	ld (0c27ah),a		;be28
	ret			;be2b
L_BE2C:
	ld de,0be49h		;be2c
	ld c,002h		;be2f
L_BE31:
	ld hl,0c580h		;be31   ; apunta a lo tecleado en la pausa
	ld b,005h		;be34
L_BE36:
	ld a,(de)			;be36
	cp (hl)			;be37
	ret nz			;be38
	inc hl			;be39
	inc de			;be3a
	djnz L_BE36		;be3b
	ld hl,0ef80h		;be3d   ; apunta a los SECRETOS que ponen las claves
	ld a,(hl)			;be40
	or c			;be41
	ld (hl),a			;be42
	ret			;be43

; ----------------------------------------------------------------------
; DATOS dos_nombres: dos palabras de 5 caracteres que p03:BE19 y p03:BE2C
;   comparan con lo tecleado en 0xC580 (p03:BDF6): si sale la primera,
;   p03:BE3D pone el bit 0 de 0xEF80; si sale la segunda, el bit 1 (10 bytes)
;   0xbe44..0xbe4e  (10 bytes)
DATA_dos_nombres:
	defb 034h,053h,04bh,063h,05dh	; be44
	defb 03ch,036h,053h,047h,05dh	; be49

; ======================================================================
; CODIGO 0xbe4e..0xbe8a  (60 bytes)
; ======================================================================


claves_secretas:		; compara lo tecleado con las claves secretas (0xBE8A)
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
	call 04088h		;be5b   ; de_mas_a: DE += A
	push bc			;be5e
	ld hl,0ebb0h		;be5f
	ld b,009h		;be62
	call L_BE36		;be64
	pop bc			;be67
	rrc c		;be68
	djnz L_BE51		;be6a
	ld a,(0ef80h)		;be6c   ; lee los SECRETOS que ponen las claves
	and 03ch		;be6f
	jr nz,L_BE7A		;be71
	ld hl,00000h		;be73
	ld (0c000h),hl		;be76   ; guarda el estado (0xC000) y el paso (0xC001) de un tiron
	ret			;be79
L_BE7A:
	call 04351h		;be7a   ; empieza_la_partida: la RAM de la partida a cero desde 0xC25A, y vidas de 0x437B
	call 0662ch		;be7d
	call L_BEAE		;be80
	ld hl,00004h		;be83
	ld (0c000h),hl		;be86   ; guarda el estado (0xC000) y el paso (0xC001) de un tiron
	ret			;be89

; ----------------------------------------------------------------------
; DATOS cuatro_claves: cuatro claves de 9 caracteres que p03:BE51 compara con
;   0xEBB0; cada una pone su bit (2-5) en 0xEF80 (36 bytes)
;   0xbe8a..0xbeae  (36 bytes)
DATA_cuatro_claves:
	defb 037h,058h,037h,058h,042h,05dh,042h,05dh,01fh	; be8a  7X7XB]B].
	defb 036h,04fh,040h,053h,05dh,038h,063h,05dh,036h	; be93  6O@S]8c]6
	defb 030h,038h,04fh,03ah,05dh,048h,03ah,031h,04bh	; be9c  08O:]H:1K
	defb 041h,041h,063h,036h,035h,063h,03bh,03fh,031h	; bea5  AAc65c;?1

; ======================================================================
; CODIGO 0xbeae..0xbee5  (55 bytes)
; ======================================================================


L_BEAE:
	ld a,040h		;beae
	ld (0c002h),a		;beb0   ; guarda las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	ld a,(0ef80h)		;beb3   ; lee los SECRETOS que ponen las claves
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
	ld hl,0c002h		;bec4   ; apunta a las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	set 7,(hl)		;bec7
	ret			;bec9
L_BECA:
	ld a,020h		;beca
	ld (0c480h),a		;becc   ; guarda la vida maxima
	ret			;becf
L_BED0:
	ld hl,02000h		;bed0
	ld (0c265h),hl		;bed3   ; guarda el DINERO (ryo, BCD)
	ret			;bed6
L_BED7:
	ld a,001h		;bed7
	ld (0c27fh),a		;bed9   ; guarda si se puede continuar
	ret			;bedc
L_BEDD:
	ld hl,0ef80h		;bedd   ; apunta a los SECRETOS que ponen las claves
	ld a,(hl)			;bee0
	or 040h		;bee1
	ld (hl),a			;bee3
	ret			;bee4

; ----------------------------------------------------------------------
; DATOS relleno_03: 269 bytes 0xFF hasta el final del banco (o hasta la marca
;   de Konami): relleno, no lo lee nadie (269 bytes)
;   0xbee5..0xbff2  (269 bytes)
DATA_relleno_03:
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
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe5  .............

; ----------------------------------------------------------------------
; DATOS marca_de_konami: la marca que Konami escondio al final del banco: el
;   titulo al reves en 11 caracteres del propio juego (35 63 5D 49 63 59 39 63
;   33 52 5D, o sea ka-dakuten-n-ha-dakuten-re-ko-dakuten-e-mo-n: GANBARE
;   GOEMON), [11], [0x48] del RC-748 y [0xAA]; no la lee el cartucho (la
;   destapo Manuel Pazos) (14 bytes)
;   0xbff2..0xc000  (14 bytes)
DATA_marca_de_konami:
	defb 05dh,052h,033h,063h,039h,059h,063h,049h,05dh,063h,035h,00bh,048h,0aah	; bff2  ]R3c9YcI]c5.H.
