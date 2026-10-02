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
	call L_A080		;a000   ; vuelve la velocidad guardada...
	xor a			;a003   ; ... y (ix+0x1D) = 0
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
	ld a,(ix+01eh)		;a028   ; la velocidad segun la direccion de (ix+0x1F): (ix+0x1E) * 0x80
	or a			;a02b
	ret z			;a02c
	ld hl,00000h		;a02d   ; HL = (ix+0x1E) * 0x80
	ld de,00080h		;a030
	ld b,a			;a033
L_A034:
	add hl,de			;a034   ; + 0x80 cada vez
	djnz L_A034		;a035
	ld a,(ix+01fh)		;a037   ; con los bits 0-1 de (ix+0x1F), 0x80 mas
	and 003h		;a03a
	jr z,L_A03F		;a03c
	add hl,de			;a03e   ; en horizontal, 0x80 mas
L_A03F:
	ex de,hl			;a03f
	ld a,(ix+01fh)		;a040   ; el bit 1, hacia la izquierda...
	bit 1,a		;a043
	push af			;a045
	call nz,08c0ah		;a046   ; niega_de: DE = -DE
	pop af			;a049
	bit 3,a		;a04a   ; ... y el bit 3, hacia arriba
	push af			;a04c
	call nz,08c0ah		;a04d   ; niega_de: DE = -DE
	pop af			;a050
	and 003h		;a051   ; bits 0-1: en horizontal...
	jr z,L_A05E		;a053
	call 087e4h		;a055   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00000h		;a058
	jp 087ebh		;a05b   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_A05E:
	call 087ebh		;a05e   ; ... si no, en vertical
	ld de,00000h		;a061
	jp 087e4h		;a064   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
L_A067:
	ld d,(ix+006h)		;a067   ; guarda la velocidad en (ix+0x79)-(ix+0x7C)
	ld e,(ix+007h)		;a06a   ; lee la velocidad vertical
	ld h,(ix+008h)		;a06d   ; lee la velocidad horizontal (parte baja)
	ld l,(ix+009h)		;a070   ; lee la velocidad horizontal
	ld (ix+07ch),d		;a073
	ld (ix+07bh),e		;a076
	ld (ix+07ah),h		;a079
	ld (ix+079h),l		;a07c
	ret			;a07f
L_A080:
	ld d,(ix+07ch)		;a080   ; y la recupera
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


tipo_01_sale:		; la figura de tipo 1 (0x01): su arranque (tabla de p02:8427)
	call L_A3A1		;a0ed   ; tipo 1: en y 0x30, hace dano, pose 0x6A
	ld (ix+003h),030h		;a0f0   ; la y de la figura = 0x30
	ld (ix+00ch),001h		;a0f4
	ld a,06ah		;a0f8
	ld (ix+00ah),a		;a0fa   ; guarda la pose de la figura
	ret			;a0fd
tipo_01:		; la figura de tipo 1 (0x01), un cuadro (tabla de p02:871C)
	ld b,06ah		;a0fe   ; tipo 1: aletea (poses 0x6A, 0x6B) y segun su paso (0xA109)
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
	ld de,0ff00h		;a10d   ; paso 0: sube un poco (0xFF00) hacia el lado del jugador (0x100)...
	call 087ebh		;a110   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld de,00100h		;a113
	ld a,(0c49ah)		;a116   ; lee la x de los sprites del jugador
	cp (ix+005h)		;a119   ; compara con la x de la figura
	jr nc,L_A121		;a11c
	call 08c0ah		;a11e   ; niega_de: DE = -DE
L_A121:
	call 087e4h		;a121   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld a,(ix+003h)		;a124   ; ... y apunta 64 mas abajo
	add a,040h		;a127
	ld (ix+010h),a		;a129
	inc (ix+001h)		;a12c   ; sube el paso en que va la figura
	ret			;a12f
L_A130:
	ld a,(ix+003h)		;a130   ; paso 1: cae cada vez mas deprisa (0x30) hasta esa y, y vuelta al paso 0
	cp (ix+010h)		;a133   ; hasta su y de llegada
	jr nc,L_A149		;a136
	ld de,00030h		;a138
L_A13B:
	ld h,(ix+007h)		;a13b   ; la velocidad vertical += DE
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
tipo_03_sale:		; la figura de tipo 3 (0x03): su arranque (tabla de p02:8427)
	ld a,04eh		;a151   ; tipo 3: pose 0x4E, sobre el jugador (x entre 0x28 y 0x98)...
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
	ld (ix+07ch),b		;a166   ; ... (ix+0x7C) y (ix+0x7C) + 64: los dos extremos de su vuelta
	ld a,b			;a169
	add a,040h		;a16a
	ld (ix+07bh),a		;a16c
	dec b			;a16f   ; en y 0x10, bajando (0x200)
	ld (ix+005h),b		;a170   ; guarda la x de la figura
	ld (ix+003h),010h		;a173   ; la y de la figura = 0x10
	ld de,00200h		;a177
	call 087ebh		;a17a   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld de,00000h		;a17d
	call 087e4h		;a180   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ret			;a183
tipo_03:		; la figura de tipo 3 (0x03), un cuadro (tabla de p02:871C)
	ld a,(ix+009h)		;a184   ; tipo 3: la pose cambia cada 16 cuadros (0x4E-0x51, segun hacia donde va)
	and 050h		;a187   ; hacia la izquierda (bits de la velocidad), las poses 0x4E-0x4F; a la derecha, 0x50-0x51
	ld b,000h		;a189
	jr nz,L_A18F		;a18b
	ld b,002h		;a18d
L_A18F:
	ld a,(0c00dh)		;a18f   ; cada 16 cuadros...
	and 00fh		;a192
	jr nz,L_A1A5		;a194
	ld a,(0c00dh)		;a196   ; ... una de dos
	and 010h		;a199
	rra			;a19b
	rra			;a19c
	rra			;a19d
	rra			;a19e
	add a,b			;a19f
	add a,04eh		;a1a0
	ld (ix+00ah),a		;a1a2   ; guarda la pose de la figura
L_A1A5:
	call L_A27A		;a1a5   ; y segun su paso (0xA1AE)
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
	ld a,(ix+003h)		;a1ba   ; paso 0: al llegar a y 0x30, en diagonal hacia la izquierda
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
	ld de,00020h		;a1d7   ; paso 1: frena; en el extremo izquierdo, hacia la derecha y arriba
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
	ld a,(ix+005h)		;a1f6   ; paso 2: hasta el extremo derecho, y baja
	cp (ix+07bh)		;a1f9
	ret c			;a1fc
	inc (ix+001h)		;a1fd   ; sube el paso en que va la figura
	ld de,00200h		;a200
	call 087e4h		;a203   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00100h		;a206
	jp 087ebh		;a209   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_A20C:
	ld de,00020h		;a20c   ; paso 3: frena hacia el otro lado
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
	ld a,(ix+005h)		;a231   ; paso 4: en el extremo izquierdo, otra vuelta desde y 0x30
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
	ld a,(ix+012h)		;a256   ; con (ix+0x12) puesto, sube deprisa y se va (paso 5)
	or a			;a259
	ret z			;a25a
	ld de,0fd00h		;a25b
	call 087ebh		;a25e   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld d,000h		;a261
	call 087e4h		;a263   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld (ix+001h),005h		;a266   ; el paso en que va la figura = 0x05
	ret			;a26a
L_A26B:
	ret			;a26b   ; el paso 5: nada
L_A26C:
	ld h,(ix+009h)		;a26c   ; la velocidad horizontal += DE
	ld l,(ix+008h)		;a26f   ; lee la velocidad horizontal (parte baja)
	add hl,de			;a272
	ld (ix+009h),h		;a273   ; guarda la velocidad horizontal
	ld (ix+008h),l		;a276   ; guarda la velocidad horizontal (parte baja)
	ret			;a279
L_A27A:
	dec (ix+011h)		;a27a   ; (ix+0x11) cuenta hasta que se va: entonces (ix+0x12) = 1
	jr nz,L_A283		;a27d
	ld (ix+012h),001h		;a27f
L_A283:
	ld a,(0c00dh)		;a283   ; cada 4 cuadros, (ix+0x10) cuenta 8...
	and 003h		;a286
	ret nz			;a288
	dec (ix+010h)		;a289
	ret nz			;a28c
	ld (ix+010h),008h		;a28d   ; ... y dispara el 2
	ld a,002h		;a291
	jp 089c2h		;a293   ; dispara: crea el disparo A (tabla de 0x8B6B)
tipo_02_sale:		; la figura de tipo 2 (0x02): su arranque (tabla de p02:8427)
	ld (ix+071h),000h		;a296   ; tipo 2: sale por un lado (p03:A420), en y 0x30, saltando hacia arriba (0xFD00)
	call L_A420		;a29a
	call 0893dh		;a29d   ; pon_la_pose: pone la pose de la figura
	ld (ix+003h),030h		;a2a0   ; la y de la figura = 0x30
	ld de,0fd00h		;a2a4
	call 087ebh		;a2a7   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	call 08c0ah		;a2aa   ; niega_de: DE = -DE
	call L_A344		;a2ad
	ld de,00200h		;a2b0   ; hacia el jugador, 0x200
	bit 0,(ix+00fh)		;a2b3
	call z,08c0ah		;a2b7   ; niega_de: DE = -DE
	call 087e4h		;a2ba   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld a,(0cd12h)		;a2bd   ; dispara cada 24 - dificultad cuadros
	ld b,a			;a2c0
	ld a,018h		;a2c1
	sub b			;a2c3
	ld (ix+078h),a		;a2c4
	ld (ix+077h),a		;a2c7
	ld de,00080h		;a2ca
	jr L_A34B		;a2cd
tipo_02:		; la figura de tipo 2 (0x02), un cuadro (tabla de p02:871C)
	ld a,(0c00dh)		;a2cf   ; tipo 2: el efecto 2 cada 32 cuadros
	and 01fh		;a2d2
	ld a,002h		;a2d4
	call z,04fe4h		;a2d6   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call L_A31F		;a2d9   ; rebota
	bit 0,(ix+071h)		;a2dc   ; si pasa por encima del jugador, empieza a disparar
	jr nz,L_A2ED		;a2e0
	ld a,(0c496h)		;a2e2   ; lee la x del jugador
	sub (ix+005h)		;a2e5   ; le resta la x de la figura
	inc a			;a2e8
	cp 003h		;a2e9
	jr c,L_A309		;a2eb
L_A2ED:
	dec (ix+078h)		;a2ed   ; cada (ix+0x77) cuadros...
	ret nz			;a2f0
L_A2F1:
	ld a,(ix+077h)		;a2f1
	ld (ix+078h),a		;a2f4
	bit 0,(ix+00fh)		;a2f7   ; ... si el jugador esta delante, a menos de 80...
	jr z,L_A30F		;a2fb
	ld a,(0c49ah)		;a2fd   ; lee la x de los sprites del jugador
	sub (ix+005h)		;a300   ; le resta la x de la figura
	ret c			;a303
	cp 050h		;a304
	ret nc			;a306
	jr L_A319		;a307
L_A309:
	ld (ix+071h),001h		;a309   ; (ix+0x71) = 1: ya ha pasado por encima del jugador
	jr L_A2F1		;a30d
L_A30F:
	ld a,(0c49ah)		;a30f   ; lee la x de los sprites del jugador
	sub (ix+005h)		;a312   ; le resta la x de la figura
	ret nc			;a315
	cp 0b0h		;a316
	ret c			;a318
L_A319:
	ld a,(ix+07dh)		;a319   ; ... dispara el de (ix+0x7D)
	jp 089c2h		;a31c   ; dispara: crea el disparo A (tabla de 0x8B6B)
L_A31F:
	call 0894dh		;a31f   ; rebota: la gravedad de (ix+0x10) y, al volver a la velocidad de salida, la invierte
	call L_A352		;a322   ; DE = la gravedad
	call L_A13B		;a325   ; se suma a la velocidad
	call L_A359		;a328
	ld l,(ix+012h)		;a32b   ; la velocidad de salida
	ld h,(ix+013h)		;a32e
	rst 20h			;a331   ; RST 0x20: HL contra DE
	ret nz			;a332   ; aun no: sigue
	call L_A352		;a333   ; la gravedad al reves
	call 08c0ah		;a336   ; niega_de: DE = -DE
	call L_A34B		;a339
	call L_A359		;a33c   ; y la velocidad de salida tambien
	call 08c0ah		;a33f   ; niega_de: DE = -DE
	jr L_A344		;a342
L_A344:
	ld (ix+012h),e		;a344   ; (ix+0x12, 0x13) = DE
	ld (ix+013h),d		;a347
	ret			;a34a
L_A34B:
	ld (ix+010h),e		;a34b   ; (ix+0x10, 0x11) = DE
	ld (ix+011h),d		;a34e
	ret			;a351
L_A352:
	ld e,(ix+010h)		;a352   ; DE = (ix+0x10, 0x11)
	ld d,(ix+011h)		;a355
	ret			;a358
L_A359:
	ld e,(ix+006h)		;a359   ; DE = la velocidad vertical
	ld d,(ix+007h)		;a35c   ; lee la velocidad vertical
	ret			;a35f
L_A360:
	ld a,(0cd5bh)		;a360   ; crea la figura, salvo en la primera tanda
	or a			;a363
	ret nz			;a364
	jp 08334h		;a365   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_04_sale:		; la figura de tipo 4 (0x04): su arranque (tabla de p02:8427)
	call L_A3A1		;a368   ; tipo 4: sale de abajo (y 0xC8), cerca del jugador
	ld de,0a3c6h		;a36b   ; una de cuatro fichas al azar (0xA3C6): velocidad x, y, gravedad y su pose
	call L_A398		;a36e   ; un numero al azar...
	and 003h		;a371   ; ... de 0 a 3
	call 0447ch		;a373   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;a376
	ld e,(hl)			;a377   ; la velocidad horizontal...
	inc hl			;a378
	ld d,(hl)			;a379
	bit 0,(ix+00fh)		;a37a   ; ... hacia el lado del jugador
	call z,08c0ah		;a37e   ; niega_de: DE = -DE
	inc hl			;a381
	call 087e4h		;a382   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld e,(hl)			;a385   ; la vertical
	inc hl			;a386
	ld d,(hl)			;a387
	inc hl			;a388
	call 087ebh		;a389   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld a,(hl)			;a38c   ; (ix+0x11) la gravedad
	ld (ix+011h),a		;a38d
	inc hl			;a390
	ld a,(hl)			;a391   ; (ix+0x12) la parte alta
	ld (ix+012h),a		;a392
	jp 0893dh		;a395   ; pon_la_pose: pone la pose de la figura
L_A398:
	ld a,r		;a398   ; A = un numero al azar (registro R y 0xC00D)
	ld hl,0c00dh		;a39a   ; R xor la cuenta de 0xC00D
	xor (hl)			;a39d
	rra			;a39e
	rra			;a39f
	ret			;a3a0
L_A3A1:
	ld b,038h		;a3a1   ; en x a 0x38 del jugador, del lado donde haya mas sitio; en y 0xC8
	ld d,000h		;a3a3
	ld a,(0c496h)		;a3a5   ; lee la x del jugador
	ld c,a			;a3a8
	cp 080h		;a3a9   ; el jugador a la derecha (x >= 0x80): sale a su izquierda
	jr c,L_A3B2		;a3ab
	inc d			;a3ad
	ld a,c			;a3ae
	sub b			;a3af
	jr L_A3B4		;a3b0
L_A3B2:
	ld a,c			;a3b2   ; a la izquierda: sale a su derecha
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


tipo_04:		; la figura de tipo 4 (0x04), un cuadro (tabla de p02:871C)
	call 0894dh		;a3e0   ; tipo 4: sube con su gravedad; al volver a su y de salida, se va
	call 087b1h		;a3e3
	ld e,(ix+011h)		;a3e6
	ld d,(ix+012h)		;a3e9
	call L_A13B		;a3ec
	ld a,(ix+010h)		;a3ef
	cp (ix+003h)		;a3f2   ; compara con la y de la figura
	ret nc			;a3f5
	jp 087b7h		;a3f6   ; borra_la_figura: borra la figura
tipo_05_sale:		; la figura de tipo 5 (0x05): su arranque (tabla de p02:8427)
	call L_A420		;a3f9   ; tipo 5: sale por un lado, quieto en vertical...
	call 0893dh		;a3fc   ; pon_la_pose: pone la pose de la figura
	ld de,00000h		;a3ff
	call 087ebh		;a402   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	call L_A46B		;a405   ; ... y en horizontal segun la dificultad (0xA481)
	bit 0,(ix+00fh)		;a408
	call nz,08c0ah		;a40c   ; niega_de: DE = -DE
	call 087e4h		;a40f   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld a,(ix+00fh)		;a412   ; la direccion en (ix+0x1F): 1 a la derecha, 2 a la izquierda
	or a			;a415
	ld a,001h		;a416
	jr nz,L_A41C		;a418
	ld a,002h		;a41a
L_A41C:
	ld (ix+01fh),a		;a41c   ; (ix+0x1F) la direccion
	ret			;a41f
L_A420:
	ld a,(0cd5bh)		;a420   ; sale por un lado, si el jugador esta lejos de el
	or a			;a423
	jp nz,087b7h		;a424   ; borra_la_figura: borra la figura
	ld a,(0c496h)		;a427   ; lee la x del jugador
	add a,040h		;a42a
	cp 080h		;a42c
	jp c,087b7h		;a42e   ; borra_la_figura: borra la figura
	ld bc,00801h		;a431   ; por la izquierda (x 8) o la derecha (x 0xF8), al azar
	ld a,r		;a434
	ld hl,0c00dh		;a436
	xor (hl)			;a439
	bit 4,a		;a43a
	jr z,L_A441		;a43c
	ld b,0f8h		;a43e
	dec c			;a440
L_A441:
	ld d,b			;a441
	ld (ix+005h),b		;a442   ; la x (8 o 0xF8)
	ld a,(0c494h)		;a445   ; la y: la del jugador, o 0x68 o 0xBE si esta muy arriba o muy abajo
	ld b,a			;a448
	add a,043h		;a449   ; el jugador muy arriba...
	cp 0abh		;a44b
	jr nc,L_A458		;a44d
	ld a,b			;a44f   ; ... o muy abajo: la fila de en medio (0x68 o 0xBE)
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
	call 0781fh		;a464   ; si ahi no se puede estar, no sale
	ret nc			;a467
	jp 087b7h		;a468   ; borra_la_figura: borra la figura
L_A46B:
	ld a,(0cd12h)		;a46b   ; tres bytes de 0xA481 segun la dificultad / 4: DE la velocidad y A otro dato
	srl a		;a46e   ; / 4
	srl a		;a470
	ld b,a			;a472
	add a,a			;a473   ; * 3
	add a,b			;a474
	ld hl,0a481h		;a475
	call 04083h		;a478   ; hl_mas_a: HL += A
	ld e,(hl)			;a47b   ; DE = la velocidad
	inc hl			;a47c
	ld d,(hl)			;a47d
	inc hl			;a47e
	ld a,(hl)			;a47f   ; A = el tercer byte
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


tipo_05:		; la figura de tipo 5 (0x05), un cuadro (tabla de p02:871C)
	call 0894dh		;a48d   ; tipo 5: con (ix+0x1D) puesto, la curva de caida...
	ld a,(ix+01dh)		;a490
	or a			;a493
	jp nz,09fdeh		;a494
	call L_A699		;a497   ; ... si no, anda; al chocar, se para y salta (p02:9FCA)
	ret nc			;a49a
	jp 09fcah		;a49b
tipo_06_sale:		; la figura de tipo 6 (0x06): su arranque (tabla de p02:8427)
	call L_A420		;a49e   ; tipo 6: sale por un lado, pose 0x41, hace dano
	ld (ix+00ah),041h		;a4a1   ; la pose de la figura = 0x41
	ld (ix+00ch),001h		;a4a5
L_A4A9:
	ld de,0fe00h		;a4a9   ; salta hacia el centro (0x200, 0xFC80)
	bit 0,(ix+00fh)		;a4ac
	call nz,08c0ah		;a4b0   ; niega_de: DE = -DE
	call 087e4h		;a4b3   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,0fc80h		;a4b6
	jp 087ebh		;a4b9   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
tipo_06:		; la figura de tipo 6 (0x06), un cuadro (tabla de p02:871C)
	ld a,041h		;a4bc   ; tipo 6: dos poses, y cae con gravedad 0x66
	ld de,0c00dh		;a4be
	call 0895bh		;a4c1
	ld de,00066h		;a4c4
	call L_A13B		;a4c7
	ld a,(ix+010h)		;a4ca   ; al volver a su y, otro salto
	cp (ix+003h)		;a4cd   ; compara con la y de la figura
	ret nc			;a4d0
	jr L_A4A9		;a4d1
andador_sale:		; el arranque de los tipos 8, 16, 19, 20, 27, 28, 30 y 33
	call L_ABF6		;a4d3   ; el que anda: entra por un lado o sale en un sitio al azar (p02:85B1)...
L_A4D6:
	call L_A954		;a4d6   ; ... su ficha (p03:A954), su pose, y hacia el jugador en vertical
	call 0893dh		;a4d9   ; pon_la_pose: pone la pose de la figura
	call L_A567		;a4dc
	ld a,(ix+01fh)		;a4df   ; (ix+0x19): la direccion horizontal que prefiere
	ld (ix+019h),a		;a4e2
	ret			;a4e5
L_A4E6:
	call 085b1h		;a4e6   ; sale en un sitio al azar y su ficha
	jr L_A4D6		;a4e9
andador:		; un cuadro de los tipos 7, 8, 16, 19, 20, 27, 28, 30 y 33
	ld a,(ix+001h)		;a4eb   ; el que anda, segun su paso (0xA4F1)
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
	ld a,(ix+01dh)		;a4f5   ; con (ix+0x1D) puesto, la curva de caida
	or a			;a4f8
	jp nz,09fdeh		;a4f9
	call L_A954		;a4fc
	call 0894dh		;a4ff
	call L_A699		;a502   ; si choca con algo...
	jr c,L_A52D		;a505
	ld a,(ix+01fh)		;a507   ; ... si no, sigue mientras vaya hacia donde prefiere
	and (ix+019h)		;a50a
	ret nz			;a50d
L_A50E:
	ld a,(ix+01fh)		;a50e   ; andando en vertical: prueba la horizontal que prefiere...
	and 003h		;a511   ; en horizontal...
	jr nz,L_A521		;a513
	ld b,(ix+019h)		;a515   ; en vertical: la horizontal que prefiere
	call L_A683		;a518
	ld a,(ix+019h)		;a51b
	jr nc,L_A58A		;a51e   ; no choca: por ahi
	ret			;a520   ; carry: choca tambien
L_A521:
	ld b,(ix+01ah)		;a521   ; ... y en horizontal, la vertical que prefiere (ix+0x1A)
	call L_A683		;a524   ; choca?
	ld a,(ix+01ah)		;a527
	jr nc,L_A58A		;a52a   ; no: por ahi
	ret			;a52c
L_A52D:
	call L_A625		;a52d   ; chocado: si puede, salta por encima (p03:A625); si no, se para y salta (p02:9FCA)
	jp nc,09fcah		;a530   ; se puede saltar: salta (p02:9FCA)
	call L_A50E		;a533   ; si no, prueba la otra direccion
	ret nc			;a536   ; sin choque: ya esta
	ld d,(ix+019h)		;a537   ; si no puede saltar, prueba las direcciones contrarias
	ld e,(ix+01ah)		;a53a
	push de			;a53d
	ld a,003h		;a53e   ; la horizontal al reves...
	xor d			;a540
	ld (ix+019h),a		;a541
	ld a,00ch		;a544   ; ... y la vertical al reves
	xor e			;a546
	ld (ix+01ah),a		;a547
	ld a,(ix+01fh)		;a54a   ; guarda la direccion
	ld (0cd58h),a		;a54d
	call L_A50E		;a550   ; y prueba
	pop de			;a553
	call c,L_A560		;a554   ; choca tambien: vuelven las preferencias y da media vuelta
	jp c,L_A611		;a557
	ld a,(0cd58h)		;a55a   ; iba en horizontal: se quedan las nuevas
	and 003h		;a55d
	ret nz			;a55f
L_A560:
	ld (ix+019h),d		;a560   ; las preferencias de antes
	ld (ix+01ah),e		;a563
	ret			;a566
L_A567:
	ex af,af'			;a567   ; (ix+0x1A): 8 (arriba) si el jugador esta mas arriba, 4 (abajo) si no
	ld a,(0c498h)		;a568   ; lee la y de los sprites del jugador
	cp (ix+003h)		;a56b   ; compara con la y de la figura
	ld a,008h		;a56e
	jr c,L_A574		;a570
	srl a		;a572
L_A574:
	ld (ix+01ah),a		;a574   ; (ix+0x1A) la vertical que prefiere
	ex af,af'			;a577
	ret			;a578
L_A579:
	ld a,(ix+01ah)		;a579   ; las dos direcciones que prefiere, al reves
	xor 00ch		;a57c   ; arriba y abajo cambiados
	ld (ix+01ah),a		;a57e
	ld a,(ix+019h)		;a581
	xor 003h		;a584   ; derecha e izquierda cambiadas
	ld (ix+019h),a		;a586
	ret			;a589
L_A58A:
	or a			;a58a   ; A = la direccion (0: hacia el jugador en vertical)
	call z,L_A5B8		;a58b
L_A58E:
	ld (ix+01fh),a		;a58e   ; la direccion
	push af			;a591
	ld a,(0cd12h)		;a592   ; la velocidad segun la dificultad: cuatro tandas de 0xA5D1...
	and 00ch		;a595
	add a,a			;a597   ; 16 bytes por tanda
	add a,a			;a598
	ld hl,0a5d1h		;a599
	call 04083h		;a59c   ; hl_mas_a: HL += A
	pop af			;a59f
L_A5A0:
	rra			;a5a0   ; el bit de la direccion...
	jr c,L_A5A9		;a5a1
	inc hl			;a5a3   ; ... 4 bytes por direccion
	inc hl			;a5a4
	inc hl			;a5a5
	inc hl			;a5a6
	jr L_A5A0		;a5a7
L_A5A9:
	ld e,(hl)			;a5a9   ; la vertical
	inc hl			;a5aa
	ld d,(hl)			;a5ab
	inc hl			;a5ac
	call 087ebh		;a5ad   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld e,(hl)			;a5b0   ; la horizontal
	inc hl			;a5b1
	ld d,(hl)			;a5b2
	call 087e4h		;a5b3   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	or a			;a5b6   ; NC
	ret			;a5b7
L_A5B8:
	ld a,(ix+003h)		;a5b8   ; hacia el jugador: arriba (8) si esta mas arriba, abajo (4) si mas abajo, 2 si a su altura
	ld hl,(0c494h)		;a5bb   ; FALLO: quiere apuntar a la y del jugador (ld hl,0xC494) pero lee la palabra de 0xC494 (su y y la fraccion de su x)...
	cp (hl)			;a5be   ; ... y compara con el byte de esa direccion: la decision es casi al azar
	ld a,008h		;a5bf
	ret c			;a5c1   ; menor: arriba (8)
	ld a,004h		;a5c2
	ret nz			;a5c4   ; mayor: abajo (4)
	ld a,002h		;a5c5   ; igual: 2
	ret			;a5c7
L_A5C8:
	and 003h		;a5c8   ; el lado al que mira: el bit 0 de la direccion horizontal
	ret z			;a5ca   ; vertical: nada
	and 001h		;a5cb
	ld (ix+00fh),a		;a5cd   ; 1 derecha, 0 izquierda
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
	ld a,(ix+01fh)		;a611   ; la direccion contraria
	and 00ch		;a614   ; iba en vertical...
	jr nz,L_A620		;a616
	ld a,(ix+01fh)		;a618   ; en horizontal: al reves
	xor 003h		;a61b
	jp L_A58A		;a61d
L_A620:
	xor 00ch		;a620   ; iba en vertical: al reves
	jp L_A58A		;a622
L_A625:
	ld a,(ix+01eh)		;a625   ; saltar por encima: (ix+0x1E) pasos de los de 0xA67B segun la direccion...
	or a			;a628   ; sin salto (0), no puede
	jr z,L_A679		;a629
	ld hl,0a67bh		;a62b
	ld a,(ix+01fh)		;a62e
L_A631:
	rra			;a631   ; el bit de la direccion: 2 bytes por direccion
	jr c,L_A638		;a632
	inc hl			;a634   ; la direccion siguiente
	inc hl			;a635
	jr L_A631		;a636
L_A638:
	ld a,(hl)			;a638   ; H = dx, L = dy del paso
	inc hl			;a639
	ld l,(hl)			;a63a
	ld h,a			;a63b
	ld d,(ix+005h)		;a63c   ; la x y la y de ahora, guardadas
	ld e,(ix+003h)		;a63f   ; lee la y de la figura
	push de			;a642
	ex de,hl			;a643
	ld b,(ix+01eh)		;a644   ; (ix+0x1E) pasos
L_A647:
	push af			;a647   ; ... sin salirse de la pantalla
	ld a,h			;a648   ; x + dx...
	add a,d			;a649
	ld h,a			;a64a
	add a,020h		;a64b   ; ... sin acercarse a los bordes (16 puntos)
	cp 030h		;a64d
	jr c,L_A671		;a64f
	ld a,l			;a651   ; y + dy...
	add a,e			;a652
	ld l,a			;a653
	add a,030h		;a654   ; ... entre 0x50 y 0xD0
	cp 080h		;a656
	jr c,L_A671		;a658
	pop af			;a65a
	djnz L_A647		;a65b
	ld (ix+005h),h		;a65d   ; se mira si al otro lado se puede estar
	ld (ix+003h),l		;a660   ; guarda la y de la figura
	call 0877ah		;a663   ; un paso mas alla y se mira si choca
	call L_A6BC		;a666
	pop de			;a669   ; y vuelve donde estaba
	ld (ix+005h),d		;a66a   ; guarda la x de la figura
	ld (ix+003h),e		;a66d   ; guarda la y de la figura
	ret			;a670
L_A671:
	pop af			;a671   ; se sale: carry, no puede
	pop de			;a672
	ld (ix+005h),d		;a673   ; guarda la x de la figura
	ld (ix+003h),e		;a676   ; guarda la y de la figura
L_A679:
	scf			;a679   ; carry: no puede saltar
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
	ld a,(ix+01fh)		;a683   ; carry si en la direccion B choca (sin cambiar la que lleva)
	ld (0cd5ah),a		;a686   ; la direccion de ahora
	ld a,b			;a689
	call L_A58A		;a68a   ; la de B...
	call L_A699		;a68d   ; ... se prueba...
	push af			;a690
	ld a,(0cd5ah)		;a691   ; ... y vuelve la de antes
	call L_A58A		;a694
	pop af			;a697
	ret			;a698
L_A699:
	ld e,(ix+002h)		;a699   ; carry si el paso siguiente choca: se mueve, se mira y se vuelve atras
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
	ld a,(ix+01fh)		;a6bc   ; segun la direccion de (ix+0x1F): el primer bit puesto
	ld d,000h		;a6bf
L_A6C1:
	rra			;a6c1   ; D = el numero del bit (0 derecha, 1 izquierda, 2 abajo, 3 arriba)
	jr c,L_A6C7		;a6c2
	inc d			;a6c4
	jr L_A6C1		;a6c5
L_A6C7:
	ld a,d			;a6c7
	ld d,(ix+005h)		;a6c8   ; lee la x de la figura
	ld e,(ix+003h)		;a6cb   ; lee la y de la figura
	cp 001h		;a6ce   ; segun cual
	jr c,L_A6DA		;a6d0
	jr z,L_A6ED		;a6d2
	cp 002h		;a6d4
	jr z,L_A715		;a6d6
	jr L_A700		;a6d8
L_A6DA:
	ld a,d			;a6da   ; derecha: 8 mas alla...
	add a,008h		;a6db
	ccf			;a6dd
	ret nc			;a6de
	ld d,a			;a6df
	push de			;a6e0
	call 0781fh		;a6e1   ; no_se_puede_estar: carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
	pop de			;a6e4
	ret c			;a6e5
	ld a,e			;a6e6   ; ... y 3 mas arriba
	sub 003h		;a6e7
	ld e,a			;a6e9
	jp 0781fh		;a6ea   ; no_se_puede_estar: carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
L_A6ED:
	ld a,d			;a6ed   ; izquierda
	sub 008h		;a6ee   ; 8 a la izquierda, sin salir de la pantalla
	ccf			;a6f0
	ret nc			;a6f1
	ld d,a			;a6f2
	push de			;a6f3
	call 0781fh		;a6f4   ; en el suelo...
	pop de			;a6f7
	ret c			;a6f8
	ld a,e			;a6f9   ; ... y 3 mas arriba
	sub 003h		;a6fa
	ld e,a			;a6fc
	jp 0781fh		;a6fd   ; no_se_puede_estar: carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
L_A700:
	ld a,e			;a700   ; arriba: 3 mas arriba, a 8 a cada lado
	sub 003h		;a701
	ld e,a			;a703
	push de			;a704   ; a la izquierda...
	ld a,d			;a705
	sub 008h		;a706
	ld d,a			;a708
	call 0781fh		;a709   ; no_se_puede_estar: carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
	pop de			;a70c
	ret c			;a70d
	ld a,d			;a70e   ; ... y a la derecha
	add a,008h		;a70f
	ld d,a			;a711
	jp 0781fh		;a712   ; no_se_puede_estar: carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
L_A715:
	ld a,0c8h		;a715   ; abajo: hasta y 0xC8, a 8 a cada lado
	cp e			;a717   ; pasado de 0xC8, choca
	ret c			;a718
	push de			;a719
	ld a,d			;a71a
	sub 008h		;a71b
	ld d,a			;a71d
	call 0781fh		;a71e   ; no_se_puede_estar: carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
	pop de			;a721
	ret c			;a722
	ld a,d			;a723
	add a,008h		;a724
	ld d,a			;a726
	jp 0781fh		;a727   ; no_se_puede_estar: carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
L_A72A:
	dec (ix+00bh)		;a72a   ; al acabar la espera, sigue andando: pose 0x43, hace dano otra vez
	ret nz			;a72d
	ld a,(ix+01fh)		;a72e   ; sigue en su direccion
	call L_A58A		;a731
	ld a,043h		;a734
	ld (ix+00ah),a		;a736   ; guarda la pose de la figura
	dec (ix+00eh)		;a739   ; se ve otra vez
	dec (ix+001h)		;a73c   ; vuelve al paso de antes
	ld (ix+00ch),003h		;a73f
	call L_A4D6		;a743   ; y su ficha otra vez
	ret			;a746
perseguidor_sale:		; el arranque de los tipos 9, 14, 15, 17, 21-26, 31 y 32: los que persiguen al jugador
	call L_ABF6		;a747   ; el que persigue: su ficha, su pose...
	call L_A954		;a74a
	call 0893dh		;a74d   ; pon_la_pose: pone la pose de la figura
L_A750:
	ld a,(ix+00bh)		;a750   ; ... cada cuanto cambia de rumbo ((ix+0x15) = (ix+0x0B)), 0x70 en (ix+0x13)...
	ld (ix+015h),a		;a753
	ld (ix+013h),070h		;a756
	ld (ix+072h),003h		;a75a   ; tres disparos (ix+0x72)
	ld (ix+070h),001h		;a75e   ; (ix+0x70) = 1
	ret			;a762
tipo_21:		; la figura de tipo 21 (0x15), un cuadro
	ld a,(ix+01dh)		;a763   ; el tipo 21: con (ix+0x1D), la curva de caida; si no, segun su paso (0xA770)
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


perseguidor:		; un cuadro de los tipos 9, 13-15, 17, 22-26, 31 y 32: persiguen al jugador
	ld a,(ix+01dh)		;a778   ; el que persigue: con (ix+0x1D), la curva de caida; si no, segun su paso (0xA785)
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
	ld a,(ix+00fh)		;a78d   ; carry si el jugador esta delante (a menos de 32) y a su altura (16)
	or a			;a790
	jr z,L_A7AB		;a791
	ld a,(0c496h)		;a793   ; lee la x del jugador
	sub (ix+005h)		;a796   ; le resta la x de la figura
L_A799:
	ccf			;a799
	ret nc			;a79a   ; el jugador detras: no
	cp 020h		;a79b   ; a 32 o mas: no
	ret nc			;a79d
	ld a,(0c494h)		;a79e   ; lee la y del jugador
	sub (ix+003h)		;a7a1   ; le resta la y de la figura
	jr nc,L_A7A8		;a7a4   ; |dy|
	neg		;a7a6
L_A7A8:
	cp 010h		;a7a8   ; menos de 16: carry
	ret			;a7aa
L_A7AB:
	ld a,(ix+005h)		;a7ab   ; lee la x de la figura
	ld hl,0c496h		;a7ae   ; apunta a la x del jugador
	sub (hl)			;a7b1
	jr L_A799		;a7b2
L_A7B4:
	call L_A78D		;a7b4   ; los tipos 0x19 y 0x20, con el jugador delante: una figura de ocho pasos (0xA800, 0xA808)
	jr nc,L_A7FA		;a7b7
	ld a,(ix+07eh)		;a7b9   ; su pose
	call 08938h		;a7bc
	ld a,(ix+073h)		;a7bf   ; el paso de la figura (ix+0x73), de la tabla del lado
	ld de,0a800h		;a7c2
	bit 0,(ix+00fh)		;a7c5
	jr z,L_A7CE		;a7c9
	ld de,0a808h		;a7cb
L_A7CE:
	add a,e			;a7ce   ; DE += el paso
	ld e,a			;a7cf
	jr nc,L_A7D3		;a7d0
	inc d			;a7d2
L_A7D3:
	ld a,(de)			;a7d3   ; la direccion de ese paso
	call L_A58E		;a7d4
	ld a,(ix+073h)		;a7d7   ; el siguiente, de 8 en rueda
	inc a			;a7da
	cp 008h		;a7db
	jr nz,L_A7E0		;a7dd
	xor a			;a7df
L_A7E0:
	ld (ix+073h),a		;a7e0
	bit 0,(ix+074h)		;a7e3   ; la primera vez, 18 cuadros y su pose
	jr nz,L_A7F4		;a7e7
	ld (ix+00bh),012h		;a7e9
	ld (ix+073h),000h		;a7ed
	call 0893dh		;a7f1   ; pon_la_pose: pone la pose de la figura
L_A7F4:
	ld (ix+074h),001h		;a7f4   ; (ix+0x74) = 1: haciendo la figura
	jr $+47		;a7f8
L_A7FA:
	ld (ix+074h),000h		;a7fa   ; (ix+0x74) = 0: no
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
	call L_A966		;a810   ; con p03:A966 (carry) no hace nada mas
	ret c			;a813
L_A814:
	ld a,(ix+000h)		;a814   ; los tipos 0x19 y 0x20 mirando
	cp 019h		;a817
	jp z,L_A7B4		;a819
	cp 020h		;a81c
	jp z,L_A7B4		;a81e
L_A821:
	call L_A954		;a821   ; el lado y la pose
	call 0894dh		;a824
L_A827:
	ld a,(ix+001h)		;a827   ; cada 4 cuadros, (ix+0x13) cuenta: al acabar, el paso siguiente
	dec a			;a82a
	jr z,L_A83C		;a82b   ; en el paso 1, no se cuenta
	ld a,(0c00dh)		;a82d
	and 003h		;a830
	jr nz,L_A83C		;a832
	dec (ix+013h)		;a834
	jr nz,L_A83C		;a837
	inc (ix+001h)		;a839   ; sube el paso en que va la figura
L_A83C:
	call L_A699		;a83c   ; si choca, salta por encima o se para
	jr nc,L_A84A		;a83f
	call L_A625		;a841   ; puede saltar?
	jp c,L_A8A2		;a844
	jp 09fcah		;a847   ; no: se para y salta
L_A84A:
	ld (ix+076h),000h		;a84a   ; (ix+0x76) = 0: no ha chocado
	call L_A917		;a84e   ; dispara cuando le toca
	dec (ix+00bh)		;a851   ; al acabar la espera, otra al azar (hasta 31 mas)...
	ret nz			;a854
	ld hl,0c00dh		;a855   ; la espera: 0-31 al azar...
	ld a,r		;a858
	xor (hl)			;a85a
	and 01fh		;a85b
	add a,(ix+015h)		;a85d   ; ... + la de su ficha
	ld (ix+00bh),a		;a860
	call L_A8B3		;a863   ; ... y un rumbo nuevo hacia el jugador: por el eje en que este mas lejos
	ld a,(ix+070h)		;a866   ; ya iba hacia el jugador?
	and 003h		;a869
	jr nz,L_A894		;a86b
	ld (ix+070h),001h		;a86d   ; (ix+0x70) = 1
	ld a,(ix+016h)		;a871   ; mas lejos en horizontal o en vertical?
	cp (ix+017h)		;a874
	jr nc,L_A887		;a877
L_A879:
	ld hl,0cd20h		;a879   ; en vertical: arriba (8) o abajo (4)
	ld a,004h		;a87c
	bit 0,(hl)		;a87e   ; 0xCD20 = 1: el jugador esta arriba
	jr z,L_A884		;a880
	add a,004h		;a882
L_A884:
	jp L_A58E		;a884   ; su velocidad
L_A887:
	ld hl,0cd21h		;a887   ; en horizontal: derecha (1) o izquierda (2)
	ld a,001h		;a88a
	bit 0,(hl)		;a88c   ; 0xCD21 = 1: el jugador esta a la izquierda
	jr z,L_A891		;a88e
	inc a			;a890
L_A891:
	jp L_A58E		;a891   ; su velocidad
L_A894:
	inc (ix+070h)		;a894   ; si ya iba, cambia de eje
	ld a,(ix+01fh)		;a897   ; parado: nada
	or a			;a89a
	ret z			;a89b
	and 003h		;a89c   ; iba en vertical: ahora en horizontal
	jr z,L_A887		;a89e
	jr L_A879		;a8a0   ; iba en horizontal: ahora en vertical
L_A8A2:
	call L_A8B3		;a8a2   ; chocado dos veces seguidas, cambia de eje; si no, da la vuelta
	ld a,(ix+076h)		;a8a5   ; los choques seguidos
	inc a			;a8a8
	ld (ix+076h),a		;a8a9
	cp 002h		;a8ac
	jr nc,L_A894		;a8ae
	jp L_A611		;a8b0   ; la primera vez, media vuelta
L_A8B3:
	ld a,(ix+001h)		;a8b3   ; (ix+0x17) = |dy| y (ix+0x16) = |dx| hasta el jugador, con el signo en 0xCD20 y 0xCD21
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
	inc hl			;a8cc   ; 0xCD21 = 0: a la derecha
	ld (hl),000h		;a8cd
	ld a,(0c496h)		;a8cf   ; lee la x del jugador
	sub (ix+005h)		;a8d2   ; le resta la x de la figura
	jr nc,L_A8DA		;a8d5
	neg		;a8d7
	inc (hl)			;a8d9   ; a la izquierda: 0xCD21 = 1
L_A8DA:
	ld (ix+016h),a		;a8da   ; (ix+0x16) = |dx|
	ret			;a8dd
L_A8DE:
	xor a			;a8de   ; en el paso 1, como si estuviera encima
	ld (0cd20h),a		;a8df
	ld (0cd21h),a		;a8e2
	ld (ix+017h),a		;a8e5
	jr L_A8DA		;a8e8
L_A8EA:
	dec (ix+00bh)		;a8ea   ; al acabar la espera, baja, hace dano otra vez y el paso siguiente
	ret nz			;a8ed
	ld a,004h		;a8ee   ; hacia abajo
	call L_A58E		;a8f0
	dec (ix+00eh)		;a8f3   ; se ve
	ld (ix+00ch),003h		;a8f6   ; hace dano y se le puede dar
	inc (ix+001h)		;a8fa   ; sube el paso en que va la figura
	ret			;a8fd
L_A8FE:
	call L_A954		;a8fe   ; baja con la pose 0x4A hasta y 0x60; alli, otra vez desde el paso 0
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
	ld a,(ix+001h)		;a917   ; cuando dispara: cada (ix+0x77) cuadros (el 0x15 no dispara)
	dec a			;a91a
	ret z			;a91b   ; en el paso 1, no
	ld a,(ix+000h)		;a91c   ; lee el tipo de la figura
	ld b,a			;a91f
	cp 015h		;a920
	ret z			;a922
	dec (ix+078h)		;a923   ; la cuenta
	ret nz			;a926
	ld a,b			;a927
	cp 00fh		;a928   ; el tipo 0x0F: segun la dificultad, y solo (ix+0x72) veces
	jr nz,L_A93A		;a92a
	ld a,(ix+072h)		;a92c   ; los que le quedan
	dec a			;a92f
	jr z,L_A94E		;a930
	ld (ix+072h),a		;a932
	call L_A46B		;a935   ; la espera, segun la dificultad
	jr L_A93D		;a938
L_A93A:
	ld a,(ix+077h)		;a93a   ; la espera de su ficha
L_A93D:
	ld (ix+078h),a		;a93d
	ld a,(ix+00fh)		;a940
	ld (0cd38h),a		;a943   ; 0xCD38 = el lado al que mira, para el disparo
	ld a,(ix+07dh)		;a946   ; (ix+0x7D): el disparo de su tipo (0, ninguno)
	or a			;a949
	ret z			;a94a
	jp 089c2h		;a94b   ; dispara: crea el disparo A (tabla de 0x8B6B)
L_A94E:
	ld (ix+072h),003h		;a94e   ; y vuelve a empezar la cuenta de tres
	jr L_A93A		;a952
L_A954:
	ld a,(ix+001h)		;a954   ; el lado al que mira, segun hacia donde anda (salvo en el paso 2)
	cp 002h		;a957   ; en el paso 2 no cambia
	ret z			;a959
	ld a,(ix+01fh)		;a95a
	and 003h		;a95d
	ret z			;a95f   ; en vertical tampoco
	and 001h		;a960
	ld (ix+00fh),a		;a962
	ret			;a965
L_A966:
	dec (ix+078h)		;a966   ; cada (ix+0x78) cuadros se para: guarda la velocidad...
	ret nz			;a969
	call L_A067		;a96a
	ld de,00000h		;a96d
	call 087e4h		;a970   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	call 087ebh		;a973   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld (ix+078h),014h		;a976   ; ... 20 cuadros, la pose 0x68 + el lado, paso 2 y carry
	ld a,068h		;a97a
	add a,(ix+00fh)		;a97c
	ld (ix+00ah),a		;a97f   ; guarda la pose de la figura
	ld (ix+001h),002h		;a982   ; el paso en que va la figura = 0x02
	scf			;a986
	ret			;a987
L_A988:
	dec (ix+078h)		;a988   ; parado: al acabar, dispara y el paso siguiente
	ret nz			;a98b
	ld (ix+078h),014h		;a98c
	ld a,(ix+00fh)		;a990
	ld (0cd38h),a		;a993
	inc (ix+001h)		;a996   ; sube el paso en que va la figura
	ld a,(ix+07dh)		;a999
	jp 089c2h		;a99c   ; dispara: crea el disparo A (tabla de 0x8B6B)
L_A99F:
	dec (ix+078h)		;a99f   ; y al acabar otra vez, sigue con la velocidad guardada
	ret nz			;a9a2
	ld a,(ix+077h)		;a9a3
	ld (ix+078h),a		;a9a6
	ld (ix+001h),000h		;a9a9   ; el paso en que va la figura = 0x00
	call 0893dh		;a9ad   ; pon_la_pose: pone la pose de la figura
	jp L_A080		;a9b0
L_A9B3:
	dec (ix+012h)		;a9b3   ; le han dado: tiembla (un punto a cada lado) 32 cuadros y se va
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
	ld a,(ix+000h)		;a9d3   ; la primera vez que le dan: si es el tipo 0x21, 0xCD60 + 1 (hasta 8 se queda en 8)
	cp 021h		;a9d6
	jr nz,L_A9E5		;a9d8
	ld hl,0cd60h		;a9da
	ld a,(hl)			;a9dd
	add a,001h		;a9de   ; una mas...
	jr nc,L_A9E4		;a9e0
	ld a,008h		;a9e2   ; ... sin pasar de 255
L_A9E4:
	ld (hl),a			;a9e4   ; 0xCD60
L_A9E5:
	ld a,(ix+003h)		;a9e5   ; quieto, ya no hace dano, 32 cuadros
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
	ld a,(ix+000h)		;aa04   ; la ficha de su tipo (0xAA51, cuatro bytes, solo los tipos 1-0x21)
	cp 022h		;aa07   ; de 0x22 en adelante no lleva ficha
	ret nc			;aa09
	dec a			;aa0a   ; 4 bytes por tipo
	add a,a			;aa0b
	add a,a			;aa0c
	ld de,0aa51h		;aa0d
	call 04088h		;aa10   ; de_mas_a: DE += A
	ld a,(de)			;aa13   ; [0] su pose base (ix+0x7E)
	ld (ix+07eh),a		;aa14
	inc de			;aa17
	ld a,(de)			;aa18   ; [1] cada cuanto cambia de rumbo, menos la dificultad * 6, minimo 16
	ld h,010h		;aa19
	call L_AA40		;aa1b
	ld (ix+00bh),a		;aa1e
	inc de			;aa21
	ld a,(de)			;aa22   ; [2] bits 0-4: su disparo (ix+0x7D); bits 6-7: lo que salta (ix+0x1E)
	ld c,a			;aa23
	and 01fh		;aa24
	ld (ix+07dh),a		;aa26
	ld a,c			;aa29
	rlca			;aa2a   ; los bits 6-7, a 0-3
	rlca			;aa2b
	and 003h		;aa2c
	ld (ix+01eh),a		;aa2e
	inc de			;aa31
	ld a,(de)			;aa32   ; [3] cada cuanto dispara, menos la dificultad * 6, minimo 32
	ld h,020h		;aa33
	call L_AA40		;aa35
	ld (ix+078h),008h		;aa38   ; el primer disparo a los 8 cuadros
	ld (ix+077h),a		;aa3c
	ret			;aa3f
L_AA40:
	ld c,a			;aa40   ; A - la dificultad * 6, y no menos de H
	ld a,(0cd12h)		;aa41   ; la dificultad * 6
	add a,a			;aa44
	ld b,a			;aa45
	add a,a			;aa46
	add a,b			;aa47
	ld b,a			;aa48
	ld a,c			;aa49
	sub b			;aa4a
	jr c,L_AA4F		;aa4b   ; si no llega, el minimo
	cp h			;aa4d
	ret nc			;aa4e
L_AA4F:
	ld a,h			;aa4f   ; el minimo
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


tipo_10_sale:		; la figura de tipo 10 (0x0A): su arranque (tabla de p02:8427)
	ld (ix+00ah),038h		;aad5   ; tipo 10: pose 0x38, hacia arriba, 64 cuadros hasta el primer disparo
	ld (ix+01fh),008h		;aad9
	ld (ix+018h),040h		;aadd
	ld (ix+00bh),020h		;aae1
	ld a,r		;aae5   ; en un sitio al azar: x cualquiera, y 0x50 o 0xD0
	ld b,a			;aae7
	ld a,(0c00dh)		;aae8
	add a,b			;aaeb
	ld (ix+005h),a		;aaec   ; guarda la x de la figura
	ld a,(0c00dh)		;aaef
	add a,(ix+005h)		;aaf2   ; le suma la x de la figura
	and 080h		;aaf5
	add a,050h		;aaf7
	ld (ix+003h),a		;aaf9   ; guarda la y de la figura
	ld a,0e0h		;aafc   ; FALLO: quiere poner (ix+0x75) = 0xE0, pero escribe en 0x0075, ROM de la BIOS; la cuenta de p03:ABC4 empieza con lo que dejo en ese hueco la figura anterior
	ld (00075h),a		;aafe
	ld a,(0cd5bh)		;ab01   ; en la primera tanda, sale donde p02:85B1
	or a			;ab04
	jr z,$+58		;ab05
	call 085b1h		;ab07
	jr $+53		;ab0a
tipo_10:		; la figura de tipo 10 (0x0A), un cuadro (tabla de p02:871C)
	call L_ABC4		;ab0c   ; tipo 10: la cuenta de (ix+0x75), el disparo, la pose y segun su paso (0xAB1D)
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
	call L_A699		;ab25   ; paso 0: anda 32 cuadros; si choca, salta hacia el jugador
	jr c,L_AB3F		;ab28   ; chocado
	dec (ix+00bh)		;ab2a
	ret nz			;ab2d
L_AB2E:
	ld (ix+00bh),020h		;ab2e   ; quieto 32 cuadros, y el paso siguiente
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
	ld a,(0c00dh)		;ab53   ; paso 1: se da la vuelta cada 4 cuadros...
	and 003h		;ab56
	jr nz,L_AB62		;ab58
	ld a,(ix+00fh)		;ab5a   ; media vuelta
	xor 001h		;ab5d
	ld (ix+00fh),a		;ab5f
L_AB62:
	dec (ix+00bh)		;ab62   ; ... y al acabar, va hacia el jugador (8 + dificultad / 2)
	ret nz			;ab65
	ld a,(0cd12h)		;ab66
	and 00ch		;ab69
	rra			;ab6b
	add a,008h		;ab6c
	call 08b76h		;ab6e   ; la velocidad hacia el jugador
	call 087e4h		;ab71   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ex de,hl			;ab74
	call 087ebh		;ab75   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld a,080h		;ab78   ; mirando hacia donde va
	cp h			;ab7a
	ld a,000h		;ab7b
	jr nc,L_AB80		;ab7d
	inc a			;ab7f
L_AB80:
	ld (ix+00fh),a		;ab80   ; el lado
	ld (ix+00bh),020h		;ab83   ; 32 cuadros, y al paso 0
	ld (ix+001h),000h		;ab87   ; el paso en que va la figura = 0x00
	ret			;ab8b
L_AB8C:
	dec (ix+018h)		;ab8c   ; cada 64 - dificultad * 4 cuadros...
	ret nz			;ab8f
	ld a,(0cd12h)		;ab90
	add a,a			;ab93
	add a,a			;ab94
	ld b,a			;ab95
	ld a,040h		;ab96
	sub b			;ab98
	ld (ix+018h),a		;ab99
	ld a,(ix+01dh)		;ab9c   ; saltando, no dispara
	or a			;ab9f
	ret nz			;aba0
	ld a,004h		;aba1   ; ... el disparo 4 y el efecto 5
	call 089c2h		;aba3   ; dispara: crea el disparo A (tabla de 0x8B6B)
	ld a,005h		;aba6
	call 04fe4h		;aba8   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld (ix+001h),000h		;abab   ; el paso en que va la figura = 0x00
	jp L_AB2E		;abaf
L_ABB2:
	call 09fdeh		;abb2   ; paso 2: el salto; al caer, paso 1
	ld a,(ix+01dh)		;abb5   ; aun en el aire
	or a			;abb8
	ret nz			;abb9
	ld (ix+00bh),020h		;abba   ; 32 cuadros
	ld (ix+001h),001h		;abbe   ; el paso en que va la figura = 0x01
	ret			;abc2
L_ABC3:
	ret			;abc3   ; el paso 3: nada
L_ABC4:
	dec (ix+075h)		;abc4   ; al acabar la cuenta de (ix+0x75), cae (paso 3)
	ret nz			;abc7
	ld a,001h		;abc8
	ld (ix+007h),a		;abca   ; guarda la velocidad vertical
	ld a,003h		;abcd
	ld (ix+001h),a		;abcf   ; guarda el paso en que va la figura
	ret			;abd2
tipos_11_12_sale:		; los tipos 11 y 12: su arranque
	call L_ABF6		;abd3   ; tipos 11 y 12: su ficha, su pose...
	call L_A954		;abd6
	call 0893dh		;abd9   ; pon_la_pose: pone la pose de la figura
	ld a,(ix+000h)		;abdc   ; ... el 11 cada 48 cuadros, el 12 cada 24 (se lanza); 64 en (ix+0x75)
	cp 00bh		;abdf
	ld a,030h		;abe1
	jr z,L_ABE7		;abe3
	ld a,018h		;abe5
L_ABE7:
	ld (ix+018h),a		;abe7   ; cada cuanto se lanza
	ld (ix+077h),a		;abea
	ld (ix+00bh),03fh		;abed   ; 63 cuadros de espera
	ld (ix+075h),040h		;abf1   ; 64 en (ix+0x75)
	ret			;abf5
L_ABF6:
	ld a,(0cd5bh)		;abf6   ; sale como los demas: por un lado, o en la primera tanda donde p02:85B1
	or a			;abf9
	jp z,09763h		;abfa   ; sale por un lado
	jp 085b1h		;abfd   ; en la primera tanda, en un sitio al azar
tipos_11_12:		; los tipos 11 y 12, un cuadro
	call L_A954		;ac00   ; tipos 11 y 12: pose 0x8B y segun su paso (0xAC0E)
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
	call L_ACB7		;ac12   ; paso 0: la cuenta, mira al jugador, anda (si choca, da la vuelta), y se lanza
	call L_AC6D		;ac15   ; mira al jugador
	call L_A699		;ac18   ; si choca...
	call c,L_A611		;ac1b   ; ... media vuelta
	call L_AC83		;ac1e   ; lanzarse
	call L_AC98		;ac21
	dec (ix+00bh)		;ac24   ; cada 8-39 cuadros (al azar) un rumbo nuevo:
	ret nz			;ac27
	ld a,r		;ac28   ; 8-39 cuadros
	and 01fh		;ac2a
	add a,008h		;ac2c
	ld (ix+00bh),a		;ac2e
	ld a,r		;ac31
	ld b,a			;ac33
	ld a,(0c00dh)		;ac34
	xor b			;ac37
	and 007h		;ac38
	cp 004h		;ac3a   ; la mitad de las veces uno de cuatro (0xAC69)...
	jr nc,L_AC49		;ac3c
	ld de,0ac69h		;ac3e
	call 04088h		;ac41   ; de_mas_a: DE += A
	ld a,(de)			;ac44
	call L_A58A		;ac45
	ret			;ac48
L_AC49:
	cp 006h		;ac49   ; ... o hacia donde mira...
	jr nc,L_AC5A		;ac4b
	ld a,(ix+00fh)		;ac4d   ; mira a la izquierda: 2
	or a			;ac50
	ld a,002h		;ac51
	jp z,L_A58A		;ac53
	rra			;ac56   ; a la derecha: 1
	jp L_A58A		;ac57
L_AC5A:
	ld a,(0c494h)		;ac5a   ; ... o hacia el jugador en vertical
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
	ld a,(ix+01fh)		;ac6d   ; andando en vertical, mira hacia el jugador
	and 00ch		;ac70
	ret z			;ac72
	ld a,(ix+005h)		;ac73   ; lee la x de la figura
	ld hl,0c496h		;ac76   ; apunta a la x del jugador
	cp (hl)			;ac79
	ld a,000h		;ac7a
	jr nc,L_AC7F		;ac7c
	inc a			;ac7e
L_AC7F:
	ld (ix+00fh),a		;ac7f   ; el lado
	ret			;ac82
L_AC83:
	ld a,(0c00dh)		;ac83   ; cada 4 cuadros, (ix+0x18) cuenta: al acabar, (ix+0x1D) = 1, listo para lanzarse
	and 003h		;ac86
	ret nz			;ac88
	dec (ix+018h)		;ac89   ; la cuenta
	ret nz			;ac8c
	ld (ix+01dh),001h		;ac8d
	ld a,(ix+077h)		;ac91   ; otra vez
	ld (ix+018h),a		;ac94
	ret			;ac97
L_AC98:
	ld a,(ix+01dh)		;ac98   ; listo y a la altura del jugador (32): el disparo 5 hacia donde mira
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
	ld a,(0c00dh)		;acb7   ; cada 4 cuadros, (ix+0x75) cuenta: al acabar, el paso siguiente
	and 003h		;acba
	ret nz			;acbc
	dec (ix+075h)		;acbd   ; la cuenta
	ret nz			;acc0
	inc (ix+001h)		;acc1   ; sube el paso en que va la figura
	ret			;acc4
L_ACC5:
	call L_A699		;acc5   ; si choca, a la izquierda o hacia arriba
	ret nc			;acc8
	or a			;acc9
	ld a,(ix+01fh)		;acca   ; iba a la derecha?
	rr a		;accd
	jr nc,L_ACD3		;accf
	ld a,008h		;acd1   ; si no, hacia arriba
L_ACD3:
	jp L_A58A		;acd3   ; el rumbo nuevo
L_ACD6:
	ld de,0806dh		;acd6   ; crea la figura 0x22 en (0x6D, 0x80)
	ld a,022h		;acd9
	jp 08334h		;acdb   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_ACDE:
	ld de,0806dh		;acde   ; crea la 0x23 en (0x6D, 0x80)
	ld a,023h		;ace1
	jp 08334h		;ace3   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipos_34_35_sale:		; los tipos 34 y 35 (0x22, 0x23): su arranque
	ld (ix+00ah),010h		;ace6   ; tipos 34 y 35 (las de los interiores): pose 0x10, no hacen dano, andan a la derecha
	xor a			;acea
	ld (ix+00ch),a		;aceb
	ld (ix+006h),a		;acee   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;acf1   ; guarda la velocidad vertical
	ld de,00100h		;acf4
	ld (ix+008h),e		;acf7   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),d		;acfa   ; guarda la velocidad horizontal
	ret			;acfd
tipos_34_35:		; los tipos 34 y 35, un cuadro
	ld a,010h		;acfe   ; van y vienen entre x 0x50 y 0xA0
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
	ld de,07887h		;ad31   ; crea la 0x25 (el cursor de la tienda) en (0x87, 0x78)
	ld a,025h		;ad34
	jp 08334h		;ad36   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_37_sale:		; la figura de tipo 37 (0x25): su arranque (tabla de p02:8427)
	ld (ix+00ah),019h		;ad39   ; el tipo 37, la tienda: pose 0x19, quieto, la cosa elegida 0
	xor a			;ad3d
	ld (ix+00ch),a		;ad3e
	ld (ix+006h),a		;ad41   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;ad44   ; guarda la velocidad vertical
	ld (ix+008h),a		;ad47   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),a		;ad4a   ; guarda la velocidad horizontal
	ld (0cd8ch),a		;ad4d
	ld a,(0c27eh)		;ad50   ; con la cosa 0x0A, siempre abierta
	or a			;ad53
	jp nz,L_AED5		;ad54
	ld a,(0cd5fh)		;ad57   ; si no: los interiores 0-7 abren con la cifra de las decenas del tiempo impar, los 8-15 con ella par...
	and 008h		;ad5a
	add a,a			;ad5c
	ld b,a			;ad5d
	ld a,(0c4b0h)		;ad5e   ; lee el TIEMPO (BCD)
	and 010h		;ad61
	xor b			;ad63
	jp nz,L_AED5		;ad64
	ld a,(0cd5fh)		;ad67   ; ... y si no toca, el rotulo de cerrado (0x6F; 0x70 en los 8-15) y no hay tienda
	cp 008h		;ad6a
	ld a,06fh		;ad6c
	jr c,L_AD72		;ad6e
	ld a,070h		;ad70
L_AD72:
	call 04280h		;ad72   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	jp 087b7h		;ad75   ; borra_la_figura: borra la figura
tipo_37:		; la figura de tipo 37 (0x25), un cuadro (tabla de p02:871C)
	ld a,(ix+001h)		;ad78   ; la tienda, segun su paso (0xAD7E)
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
	ld a,(0c006h)		;ad84   ; paso 0: el primer boton pasa a la cosa siguiente; el segundo, compra
	ld b,a			;ad87
	and 010h		;ad88   ; el primer boton: paso 1
	jr nz,L_AD93		;ad8a
	ld a,020h		;ad8c   ; el segundo: paso 2
	and b			;ad8e
	ret z			;ad8f
	inc (ix+001h)		;ad90   ; sube el paso en que va la figura
L_AD93:
	inc (ix+001h)		;ad93   ; sube el paso en que va la figura
	ret			;ad96
L_AD97:
	ld (ix+001h),000h		;ad97   ; paso 1: la siguiente de las tres que tenga algo (0xCD8C, 0xCD83)
	ld b,003h		;ad9b
L_AD9D:
	ld hl,0cd8ch		;ad9d   ; la cosa siguiente...
	inc (hl)			;ada0
	ld a,(hl)			;ada1
	cp 003h		;ada2   ; ... de tres, en rueda
	jr nz,L_ADA8		;ada4
	xor a			;ada6
	ld (hl),a			;ada7
L_ADA8:
	ld hl,0cd83h		;ada8   ; si tiene algo a la venta...
	call 04083h		;adab   ; hl_mas_a: HL += A
	ld a,(hl)			;adae
	or a			;adaf
	jr nz,L_ADBA		;adb0
	djnz L_AD9D		;adb2   ; ... si no, la siguiente
L_ADB4:
	ld a,b			;adb4   ; los sitios de la marca ([y][x] por cosa); son datos, pero si no hay nada a la venta el djnz de 0xADB2 cae aqui y se EJECUTAN
	add a,a			;adb5
	and b			;adb6
	add a,a			;adb7
	ld d,b			;adb8
	add a,a			;adb9
L_ADBA:
	ld de,ladb4h		;adba   ; la marca, en el sitio de esa cosa (0xADB4)
	ld a,(0cd8ch)		;adbd
	call 0447ch		;adc0   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld (ix+003h),d		;adc3   ; guarda la y de la figura
	ld (ix+005h),e		;adc6   ; guarda la x de la figura
	call L_AED5		;adc9
	ret			;adcc
L_ADCD:
	cp 003h		;adcd   ; con la 3, vuelta a la 0
	ret nz			;adcf
	xor a			;add0   ; la primera...
	dec hl			;add1   ; ... HL atras
	dec hl			;add2
	ret			;add3
L_ADD4:
	ld (ix+001h),000h		;add4   ; paso 2: comprar lo elegido, segun lo que sea
	ld a,(0cd8ch)		;add8
	ld hl,0cd83h		;addb
	call 04083h		;adde   ; hl_mas_a: HL += A
	ld a,(hl)			;ade1
	or a			;ade2
	ret z			;ade3
	dec a			;ade4
	ld (0ee80h),a		;ade5   ; la cosa elegida - 1, y lo que hace al comprarla (tabla de 0xADEB)
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
	call L_AE38		;ae07   ; una cosa de las que se tienen hasta 3: se paga y una mas
	jp c,L_AED9		;ae0a   ; sin dinero, el texto
	call L_AE5B		;ae0d   ; una mas
	ret			;ae10
L_AE11:
	ld (0ee81h),a		;ae11   ; una cosa con valor: se paga y, si no se tenia, vale A
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
	ret			;ae37   ; ya tiene: nada
L_AE38:
	ld a,(0cd8ch)		;ae38   ; el precio de la elegida (0xCD86 + 2 * n) se paga: carry si no llega el dinero
	add a,a			;ae3b
	ld hl,0cd86h		;ae3c
	call 04083h		;ae3f   ; hl_mas_a: HL += A
	ld e,(hl)			;ae42
	inc hl			;ae43
	ld d,(hl)			;ae44
	call L_B539		;ae45
	ret c			;ae48
	ld a,(0cd8ch)		;ae49   ; vendida: fuera de la tienda...
	ld hl,0cd83h		;ae4c
	call 04083h		;ae4f   ; hl_mas_a: HL += A
	xor a			;ae52
	ld (hl),a			;ae53
	ld a,015h		;ae54   ; ... y el efecto 0x15
	call 04fe4h		;ae56   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	or a			;ae59
	ret			;ae5a
L_AE5B:
	call L_AE81		;ae5b   ; una mas de la cosa, salvo que ya tenga 3
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
	ld a,(0cd8ch)		;ae81   ; fuera su icono de la tienda
	ld hl,09556h		;ae84
	add a,a			;ae87
	call 04083h		;ae88   ; hl_mas_a: HL += A
	ld e,(hl)			;ae8b
	inc hl			;ae8c
	ld d,(hl)			;ae8d
	ld a,0ffh		;ae8e
	jp 04eb9h		;ae90   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
L_AE93:
	ld a,064h		;ae93   ; la cosa 8 dura 100 segundos (0xC27C)
	ld (0c27ch),a		;ae95
L_AE98:
	call L_AE38		;ae98   ; la cosa vale 1
	jr c,L_AED9		;ae9b   ; sin dinero, el texto
	ld a,001h		;ae9d
	call L_AE11		;ae9f
	ret			;aea2
L_AEA3:
	call L_AE38		;aea3   ; la cosa vale 5
	jr c,L_AED9		;aea6   ; sin dinero, el texto
	ld a,005h		;aea8
	call L_AE11		;aeaa
	ret			;aead
L_AEAE:
	ld b,010h		;aeae   ; 16 de vida...
L_AEB0:
	ld b,008h		;aeb0   ; ... u 8
L_AEB2:
	push bc			;aeb2   ; B = la vida
	call L_AE38		;aeb3
	pop bc			;aeb6
	jr c,L_AED9		;aeb7   ; sin dinero, el texto
	ld a,b			;aeb9
	call 05884h		;aeba   ; suma_vida: suma A a la vida, hasta la maxima, y la pinta
	call L_AE81		;aebd   ; fuera de la tienda...
	call L_AEF9		;aec0   ; ... y sube de precio
	ret			;aec3
L_AEC4:
	call L_AE38		;aec4   ; 200 segundos mas
	jr c,L_AED9		;aec7
	call L_AE81		;aec9
	call L_AEF9		;aecc
	ld de,00200h		;aecf
	jp 05945h		;aed2   ; suma_tiempo: suma DE (BCD) al tiempo, hasta 5000
L_AED5:
	ld c,000h		;aed5   ; el texto de la tienda (C = 0)...
	jr L_AEDB		;aed7
L_AED9:
	ld c,004h		;aed9   ; ... o el de que no llega el dinero (C = 4)
L_AEDB:
	ld a,(0cd5fh)		;aedb   ; segun el interior / 4 (0xAEF1)
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
	ld a,(0ee80h)		;aef9   ; una compra mas de esa cosa en esta zona (hasta 4): el precio se dobla
L_AEFC:
	ld hl,0cda0h		;aefc
	call 04083h		;aeff   ; las de esa cosa
	ld a,(hl)			;af02
	cp 004h		;af03   ; hasta 4
	ret z			;af05
	inc (hl)			;af06
	ret			;af07
L_AF08:
	ld de,0181eh		;af08   ; crea la 0x27 en (0x1E, 0x18)
	ld a,027h		;af0b
	jp 08334h		;af0d   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_39_sale:		; la figura de tipo 39 (0x27): su arranque (tabla de p02:8427)
	ld (ix+00ah),019h		;af10   ; el tipo 39: la casa de cambio de lo que se tiene; quieto, sin dano
	xor a			;af14
	ld (ix+00ch),a		;af15
	ld (ix+006h),a		;af18   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;af1b   ; guarda la velocidad vertical
	ld (ix+008h),a		;af1e   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),a		;af21   ; guarda la velocidad horizontal
	ld (ix+00fh),a		;af24
	ld c,0ffh		;af27   ; empieza buscando desde la cosa 0
	ld hl,0c26fh		;af29
	ld b,00bh		;af2c
	call L_AF6F		;af2e
	ld (ix+001h),000h		;af31   ; el paso en que va la figura = 0x00
	ret			;af35
tipo_39:		; la figura de tipo 39 (0x27), un cuadro (tabla de p02:871C)
	ld a,(ix+001h)		;af36   ; segun su paso (0xAF3C)
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
	ld a,(0c006h)		;af42   ; el primer boton, la siguiente; el segundo, cambiar; con el texto 0x16
	ld b,a			;af45
	and 010h		;af46   ; el primer boton: paso 1
	jr nz,L_AF51		;af48
	ld a,020h		;af4a   ; el segundo: paso 2
	and b			;af4c
	ret z			;af4d
	inc (ix+001h)		;af4e   ; sube el paso en que va la figura
L_AF51:
	inc (ix+001h)		;af51   ; sube el paso en que va la figura
	ld a,016h		;af54   ; y el texto 0x16
	call L_B836		;af56
	ret			;af59
L_AF5A:
	ld (ix+00fh),000h		;af5a   ; la siguiente cosa que se tenga, de las 10
	ld (ix+001h),000h		;af5e   ; el paso en que va la figura = 0x00
	ld b,009h		;af62
	ld hl,0cd8ch		;af64
	ld a,(hl)			;af67
	ld c,a			;af68
	ld hl,0c270h		;af69   ; apunta a las 10 cosas del marcador
	call 04083h		;af6c   ; hl_mas_a: HL += A
L_AF6F:
	inc hl			;af6f   ; la cosa siguiente
	inc c			;af70
	call L_B024		;af71   ; pasada la 8, vuelta a la 0
	ld a,(hl)			;af74   ; si se tiene...
	or a			;af75
	jr nz,L_AF7D		;af76
	djnz L_AF6F		;af78   ; ... si no, la siguiente
	jp L_B06B		;af7a   ; ninguna: paso 3
L_AF7D:
	ld a,c			;af7d   ; la marca, en su sitio del marcador (0xB010)
	ld (0cd8ch),a		;af7e   ; 0xCD8C = la elegida
	ld de,0b010h		;af81
	call 04088h		;af84   ; de_mas_a: DE += A
	ld a,c			;af87
	or a			;af88   ; la 0 y la 9 se cuentan: la marca en la ultima que se tiene
	ld c,000h		;af89
	push af			;af8b
	call z,L_B01A		;af8c
	pop af			;af8f
	cp 009h		;af90
	call z,L_B01A		;af92
	ld a,(de)			;af95   ; su x
	add a,c			;af96
	ld (ix+005h),a		;af97   ; guarda la x de la figura
	call 0932ah		;af9a   ; lo que vale, de la tabla de precios
	ld a,(0cd8ch)		;af9d   ; su precio en la tabla
	ld b,a			;afa0
	add a,a			;afa1
	call 04088h		;afa2   ; de_mas_a: DE += A
	ex de,hl			;afa5
	call L_AFBE		;afa6
	ld hl,0cd87h		;afa9   ; y se pinta en (0x87, 0x60), con la moneda al lado
	ld de,06087h		;afac
	ld b,002h		;afaf
	call 04420h		;afb1   ; pinta_bcd: pinta cifras en BCD
	ld de,08087h		;afb4
	ld hl,05050h		;afb7
	call 04ef1h		;afba   ; copia_caracter: el caracter de (H, L) de la pagina 1 en (D, E) de la 0 (LMMM IMP)
	ret			;afbd
L_AFBE:
	ld a,b			;afbe   ; el valor segun las veces que se ha comprado: 0 o 1, la mitad...
	ld de,0cda0h		;afbf
	call 04088h		;afc2   ; de_mas_a: DE += A
	ld a,(de)			;afc5   ; B = las veces que se ha comprado
	ld b,a			;afc6
	ld e,(hl)			;afc7   ; HL = el precio
	inc hl			;afc8
	ld d,(hl)			;afc9
	ex de,hl			;afca
	or a			;afcb
	jr z,L_AFE2		;afcc
	dec b			;afce   ; una vez: la mitad
	jr z,L_AFE2		;afcf
	dec b			;afd1   ; dos: tal cual
	jr z,L_AFDE		;afd2
L_AFD4:
	ld a,l			;afd4   ; ... 3 o mas, el doble por cada una de mas
	add a,a			;afd5   ; * 2 en BCD
	daa			;afd6
	ld l,a			;afd7
	ld a,h			;afd8
	adc a,a			;afd9   ; la parte alta con el acarreo
	daa			;afda
	ld h,a			;afdb
	djnz L_AFD4		;afdc
L_AFDE:
	ld (0cd86h),hl		;afde   ; el valor, a 0xCD86
	ret			;afe1
L_AFE2:
	ld de,00000h		;afe2   ; la mitad en BCD: cifra a cifra, con el 5 que baja de la de arriba si era impar
	ld a,h			;afe5   ; la cifra de los miles / 2
	and 0f0h		;afe6
	call L_B007		;afe8
	ld d,a			;afeb
	ld a,h			;afec   ; la de las centenas / 2...
	and 00fh		;afed
	rra			;afef
	jr nc,L_AFF4		;aff0
	ld e,050h		;aff2   ; ... si era impar, 50 para las decenas
L_AFF4:
	add a,d			;aff4   ; + el 5 de las centenas
	ld d,a			;aff5
	ld a,l			;aff6   ; las decenas / 2
	and 0f0h		;aff7
	call L_B007		;aff9
	add a,e			;affc
	ld e,a			;affd
	ld a,l			;affe   ; las unidades / 2
	and 00fh		;afff
	rra			;b001
	add a,e			;b002
	ld e,a			;b003
	ex de,hl			;b004
	jr L_AFDE		;b005   ; el resultado
L_B007:
	rra			;b007   ; A / 2 de un nibble BCD (el 8 que baja se corrige a 5)
	ld b,a			;b008   ; el bit que bajo de la cifra de arriba (8)...
	and 008h		;b009
	ld a,b			;b00b
	ret z			;b00c   ; ... se corrige a 5
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
	ld b,(hl)			;b01a   ; la x de la marca segun cuantas se tienen (16 por cada una)
	xor a			;b01b
L_B01C:
	add a,010h		;b01c   ; 16 por cada una que se tiene...
	djnz L_B01C		;b01e
	sub 010h		;b020   ; ... menos 16: el sitio de la ultima
	ld c,a			;b022
	ret			;b023
L_B024:
	ld a,008h		;b024   ; pasada la cosa 8, vuelta a la 0
	cp c			;b026
	ret nc			;b027
	ld c,000h		;b028
	ld hl,0c270h		;b02a   ; apunta a las 10 cosas del marcador
	ret			;b02d
L_B02E:
	ld (ix+001h),000h		;b02e   ; cambiar la elegida: si ya se cambio una, nada
	ld a,(ix+00fh)		;b032   ; (ix+0x0F) = ya se cambio
	or a			;b035
	ret nz			;b036
	ld a,(0cd8ch)		;b037   ; si no se tiene, el texto 0x1A
	ld hl,0c270h		;b03a   ; apunta a las 10 cosas del marcador
	call 04083h		;b03d   ; hl_mas_a: HL += A
	ld a,(hl)			;b040   ; cuantas tiene
	or a			;b041
	ld a,01ah		;b042
	jp z,L_B836		;b044
	ld a,(0cd8ch)		;b047   ; la cosa 3: ademas da CONTINUAR (p03:B070)
	cp 003h		;b04a   ; la cosa 3
	push hl			;b04c
	call z,L_B070		;b04d
	pop hl			;b050
	ld a,(0cd8ch)		;b051   ; las cosas 1-8 se pierden enteras; la 0 y la 9, una
	dec a			;b054   ; de 1 a 8...
	cp 008h		;b055
	ld a,000h		;b057   ; ... todas fuera
	jr c,L_B05D		;b059
	ld a,(hl)			;b05b   ; la 0 y la 9: una menos
	dec a			;b05c
L_B05D:
	ld (hl),a			;b05d
	ld de,(0cd86h)		;b05e   ; y se cobra lo que vale (0xCD86)
	call 0592bh		;b062
	inc (ix+00fh)		;b065   ; ya se cambio una: (ix+0x0F) = 1
	jp 05856h		;b068   ; pinta_las_cosas: pinta las cosas del marcador
L_B06B:
	ld (ix+001h),003h		;b06b   ; sin nada que cambiar, paso 3
	ret			;b06f
L_B070:
	ld a,(0c27fh)		;b070   ; si aun no lo tenia: el texto 0x1B y 0xC27F = 1, se puede CONTINUAR
	or a			;b073   ; ya podia: nada
	ret nz			;b074
	ld a,01bh		;b075
	call L_B836		;b077
	ld a,001h		;b07a
	ld (0c27fh),a		;b07c   ; guarda si se puede continuar
	ret			;b07f
L_B080:
	ld de,07058h		;b080   ; crea la figura B en (0x58, 0x70)
	jp 08334h		;b083   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_38_sale:		; la figura de tipo 38 (0x26): su arranque (tabla de p02:8427)
	ld (ix+00ah),01ah		;b086   ; el tipo 38: la marca de si o no; 0xCD82 = 0 (nada elegido); x 0x70 o 0x90 (0xCD93)
	xor a			;b08a   ; nada elegido
	ld (0cd82h),a		;b08b
	ld (ix+00ch),a		;b08e   ; no hace dano
	ld d,a			;b091   ; quieta
	ld e,a			;b092
	call 087ebh		;b093   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	call 087e4h		;b096   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld a,090h		;b099   ; la otra opcion, en x 0x90
	ld (0cd93h),a		;b09b
	ret			;b09e
tipo_38:		; la figura de tipo 38 (0x26), un cuadro (tabla de p02:871C)
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
	ld a,(0c006h)		;b0ad   ; el primer boton cambia de opcion; el segundo elige
	ld b,a			;b0b0
	and 010h		;b0b1   ; el primer boton: paso 2
	jr nz,L_B0BC		;b0b3
	ld a,020h		;b0b5   ; el segundo: paso 1
	and b			;b0b7
	ret z			;b0b8
	inc (ix+001h)		;b0b9   ; sube el paso en que va la figura
L_B0BC:
	inc (ix+001h)		;b0bc   ; sube el paso en que va la figura
	ret			;b0bf
L_B0C0:
	ld (ix+001h),000h		;b0c0   ; de una a la otra: x 0x70 o 0xCD93
	ld a,(ix+005h)		;b0c4   ; lee la x de la figura
	cp 070h		;b0c7
	ld a,(0cd93h)		;b0c9
	jr z,L_B0D0		;b0cc
	ld a,070h		;b0ce
L_B0D0:
	ld (ix+005h),a		;b0d0   ; guarda la x de la figura
	ret			;b0d3
L_B0D4:
	ld a,(ix+005h)		;b0d4   ; elegido: 0xCD82 = 1 (la de x 0x70) o 2
	cp 070h		;b0d7   ; en x 0x70: 1
	ld a,001h		;b0d9
	jr z,L_B0DF		;b0db
	ld a,002h		;b0dd   ; en la otra: 2
L_B0DF:
	ld (0cd82h),a		;b0df
	inc (ix+001h)		;b0e2   ; sube el paso en que va la figura
	ret			;b0e5
L_B0E6:
	ld a,(0cd91h)		;b0e6   ; con 0xCD91 puesto, se va
	or a			;b0e9
	ret z			;b0ea
	xor a			;b0eb
	ld (0cd91h),a		;b0ec
	jp 087b7h		;b0ef   ; borra_la_figura: borra la figura
L_B0F2:
	ld de,0806dh		;b0f2   ; crea la 0x28 en (0x6D, 0x80)
	ld a,028h		;b0f5
	jp 08334h		;b0f7   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_40_sale:		; la figura de tipo 40 (0x28): su arranque (tabla de p02:8427)
	ld (ix+00ah),010h		;b0fa   ; el tipo 40: quieto, sin dano
	xor a			;b0fe
	ld (ix+00ch),a		;b0ff
	ld (ix+006h),a		;b102   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;b105   ; guarda la velocidad vertical
	ld (ix+008h),a		;b108   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),a		;b10b   ; guarda la velocidad horizontal
	ld (0cd82h),a		;b10e
	ld a,(0c27eh)		;b111   ; con la cosa 0x0A: la marca de si o no (0x26) y los rotulos 0 y 0x19
	or a			;b114
	ld a,026h		;b115
	call nz,0828fh		;b117
	ld a,(0c27eh)		;b11a   ; sin ella, los rotulos 0x18 y 0x1C (0x1D en la zona 6)
	or a			;b11d
	jp z,L_B1A7		;b11e
	xor a			;b121
	call 04280h		;b122   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ld a,019h		;b125
	jp 04280h		;b127   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
tipo_40:		; la figura de tipo 40 (0x28), un cuadro (tabla de p02:871C)
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
	ld a,(0cd82h)		;b136   ; elegido: si (1), el texto 0x16 y la figura 0x27; no (2), el texto 0x1A
	or a			;b139   ; aun nada
	ret z			;b13a
	cp 002h		;b13b
	ld a,001h		;b13d
	ld (0cd91h),a		;b13f   ; 0xCD91 = 1: la marca se va
	jr z,L_B152		;b142
	inc (ix+001h)		;b144   ; si
	ld a,016h		;b147
	call L_B836		;b149
	ld a,027h		;b14c   ; la casa de cambio (0x27)
	call 0828fh		;b14e
	ret			;b151
L_B152:
	ld a,01ah		;b152   ; no: el texto 0x1A
	call L_B836		;b154
	ld (ix+001h),002h		;b157   ; el paso en que va la figura = 0x02
	ret			;b15b
L_B15C:
	ld a,(0cd92h)		;b15c   ; espera a 0xCD92
	or a			;b15f
	ret z			;b160
	inc (ix+001h)		;b161   ; sube el paso en que va la figura
	ret			;b164
L_B165:
	ret			;b165   ; el paso 2: nada
L_B166:
	ld de,08070h		;b166
	jp 08334h		;b169   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_36_sale:		; la figura de tipo 36 (0x24): su arranque (tabla de p02:8427)
	ld (ix+00ah),010h		;b16c   ; el tipo 36: quieto; con la cosa 0x0A, la marca de si o no y los rotulos 5 y 0
	xor a			;b170   ; quieto, sin dano
	ld (ix+00ch),a		;b171
	ld (ix+006h),a		;b174   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),a		;b177   ; guarda la velocidad vertical
	ld (ix+008h),a		;b17a   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),a		;b17d   ; guarda la velocidad horizontal
	ld (0cd90h),a		;b180   ; nada elegido, los dados a cero
	ld (0cd82h),a		;b183
	ld hl,0cd8dh		;b186
	ld (hl),a			;b189
	inc hl			;b18a
	ld (hl),a			;b18b
	ld a,(0c27eh)		;b18c   ; con la cosa 0x0A, la marca de si o no
	or a			;b18f
	ld a,026h		;b190
	call nz,0828fh		;b192
	call 092adh		;b195   ; la caja del texto
	ld a,(0c27eh)		;b198
	or a			;b19b
	jr z,L_B1A7		;b19c
	ld a,005h		;b19e
	call 04280h		;b1a0   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	xor a			;b1a3
	jp 04280h		;b1a4   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
L_B1A7:
	ld a,018h		;b1a7   ; sin ella: el rotulo 0x18...
	call 04280h		;b1a9   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ld a,(0c280h)		;b1ac   ; ... y el 0x1C (0x1D en la zona 6)
	cp 006h		;b1af
	ld a,01ch		;b1b1
	jr nz,L_B1B7		;b1b3
	ld a,01dh		;b1b5
L_B1B7:
	jp 04280h		;b1b7   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
tipo_36:		; la figura de tipo 36 (0x24), un cuadro (tabla de p02:871C)
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
	ld a,(0cd82h)		;b1c8   ; elegido: si (1) y se puede pagar (p03:B289)...
	or a			;b1cb   ; nada aun
	ret z			;b1cc
	cp 002h		;b1cd   ; no: paso 3
	jp z,L_B25A		;b1cf
	call L_B289		;b1d2   ; sin dinero: paso 3
	jp c,L_B25A		;b1d5
	ld a,006h		;b1d8   ; ... el texto 6, el rotulo 1, y las figuras 0x26, 0x29 y 0x2A
	call L_B836		;b1da
	ld a,001h		;b1dd
	call 04280h		;b1df   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ld a,001h		;b1e2
	ld (0cd91h),a		;b1e4   ; la marca se va
	inc (ix+001h)		;b1e7   ; sube el paso en que va la figura
	ld a,026h		;b1ea   ; otra marca (para par o impar)...
	call 0828fh		;b1ec
	ld a,090h		;b1ef   ; ... con la segunda opcion en x 0x90
	ld (0cd93h),a		;b1f1
	ld a,029h		;b1f4   ; y los dos dados
	call 0828fh		;b1f6
	ld a,02ah		;b1f9
	call 0828fh		;b1fb
	ret			;b1fe
L_B1FF:
	ld a,(0cd82h)		;b1ff   ; elegido: (0xCD8F) y la pose siguiente
	or a			;b202
	ret z			;b203
	ld (0cd8fh),a		;b204
	inc (ix+001h)		;b207   ; sube el paso en que va la figura
	inc (ix+00ah)		;b20a   ; sube la pose de la figura
	ld a,001h		;b20d
	ld (0cd90h),a		;b20f
	ret			;b212
L_B213:
	ld hl,0cd8dh		;b213   ; los dos dados parados (0xCD8D y 0xCD8E)...
	ld a,(hl)			;b216   ; el primero parado?
	or a			;b217
	ret z			;b218
	inc hl			;b219
	ld a,(hl)			;b21a   ; el segundo?
	or a			;b21b
	ret z			;b21c
	ld a,001h		;b21d
	ld (0cd91h),a		;b21f   ; la marca se va
	ld a,(hl)			;b222   ; ... la suma, par o impar...
	inc (ix+001h)		;b223   ; sube el paso en que va la figura
	dec hl			;b226   ; la suma...
	ld b,(hl)			;b227
	add a,b			;b228
	and 001h		;b229   ; ... par (0) o impar (1)
	ld b,a			;b22b
	ld a,(0cd8fh)		;b22c   ; ... contra lo elegido (0xCD8F: 1 par, 2 impar)
	dec a			;b22f
	xor b			;b230
	jr nz,L_B247		;b231
	ld de,(0c265h)		;b233   ; DE = todo el dinero, que se suma a si mismo
	call 0592bh		;b237
	ld a,008h		;b23a
	call L_B836		;b23c
	call L_B25F		;b23f
	ld a,019h		;b242
	jp 04fe4h		;b244   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_B247:
	call 0701eh		;b247   ; falla: el dinero se queda en la MITAD, el texto 9 y el efecto 0x18
	call 0593ah		;b24a   ; pinta_el_dinero: pinta el dinero (4 cifras) en (0x70, 8)
	ld a,009h		;b24d
	call L_B836		;b24f
	call L_B25F		;b252
	ld a,018h		;b255
	jp 04fe4h		;b257   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_B25A:
	ld (ix+001h),003h		;b25a   ; el paso en que va la figura = 0x03
L_B25E:
	ret			;b25e   ; el paso 3: nada
L_B25F:
	ld a,(0cd8eh)		;b25f   ; los dos dados: sus cifras en (0x70, 0x40) y (0x80, 0x40)...
	add a,020h		;b262   ; la cifra (letra 0x20 + n)
	ld de,07040h		;b264
	call 0491ch		;b267   ; letra: pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco
	ld a,(0cd8dh)		;b26a
	add a,020h		;b26d
	ld de,08040h		;b26f
	call 0491ch		;b272   ; letra: pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco
	ld a,(0cd8dh)		;b275   ; ... y el rotulo de par (0x0A) o impar (0x0B)
	ld b,a			;b278
	ld a,(0cd8eh)		;b279
	add a,b			;b27c   ; la suma: par o impar
	and 001h		;b27d
	ld a,00ah		;b27f
	jr z,L_B285		;b281
	ld a,00bh		;b283
L_B285:
	call 04280h		;b285   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ret			;b288
L_B289:
	ld de,(0c265h)		;b289   ; sin dinero no se juega: efecto 0x1B y carry
	ld a,e			;b28d   ; con algo de dinero, NC
	or d			;b28e
	ret nz			;b28f
	call 092adh		;b290   ; sin nada: la caja del texto...
	ld a,01bh		;b293
	call 04fe4h		;b295   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	scf			;b298
	ret			;b299
L_B29A:
	ld de,0a087h		;b29a   ; el dado 0x29 en (0x87, 0xA0)
	ld a,029h		;b29d
	jp 08334h		;b29f   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
L_B2A2:
	ld de,06087h		;b2a2   ; el dado 0x2A en (0x87, 0x60)
	ld a,02ah		;b2a5
	jp 08334h		;b2a7   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipos_41_42_sale:		; los tipos 41 y 42 (0x29, 0x2A): su arranque
	ld (ix+00ah),013h		;b2aa   ; los tipos 41 y 42, los dados: pose 0x13 (el 1)...
	ld b,(ix+000h)		;b2ae   ; ... y rueda 20-35 cuadros (al azar)
	ld a,(ix+005h)		;b2b1   ; una direccion cualquiera: x - tipo y la cuenta de cuadros...
	sub b			;b2b4
	ld h,a			;b2b5
	ld a,(0c00dh)		;b2b6
	ld l,a			;b2b9
	ld b,(hl)			;b2ba   ; ... y el byte que haya alli, mas R: al azar
	ld a,r		;b2bb
	add a,b			;b2bd
	rra			;b2be
	and 00fh		;b2bf
	add a,014h		;b2c1   ; 20-35 cuadros
	ld (ix+00bh),a		;b2c3
	xor a			;b2c6   ; sin dano, quieto
	ld (ix+00ch),a		;b2c7
	ld d,a			;b2ca
	ld e,a			;b2cb
	call 087e4h		;b2cc   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	jp 087ebh		;b2cf   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
tipos_41_42:		; los tipos 41 y 42, un cuadro
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
	ld a,(0cd90h)		;b2de   ; paso 0: espera a que se elija (0xCD90)
	or a			;b2e1
	ret z			;b2e2
	inc (ix+001h)		;b2e3   ; sube el paso en que va la figura
	ret			;b2e6
L_B2E7:
	ld a,(0c00dh)		;b2e7   ; paso 1: rueda, cada 2 cuadros una cara mas, con el efecto 0x0F
	and 001h		;b2ea   ; cada 2 cuadros
	ret nz			;b2ec
	ld a,(ix+000h)		;b2ed   ; el segundo no se para hasta que se pare el primero
	cp 02ah		;b2f0
	call z,L_B303		;b2f2
	dec (ix+00bh)		;b2f5
	jr z,L_B30C		;b2f8
	ld a,00fh		;b2fa
	call 04fe4h		;b2fc   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call L_B320		;b2ff
	ret			;b302
L_B303:
	ld a,(0cd8dh)		;b303   ; el primer dado (0x2A) espera a que el otro tenga cifra
	or a			;b306
	ret nz			;b307
	inc (ix+00bh)		;b308   ; un cuadro mas
	ret			;b30b
L_B30C:
	ld hl,0cd8dh		;b30c   ; parado: su cifra (la pose - 0x13 + 1) a 0xCD8D, o a 0xCD8E si ya estaba la otra
	ld a,(hl)			;b30f   ; el primero ya esta: a 0xCD8E
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
	ret			;b31f   ; el paso 2: nada
L_B320:
	ld b,013h		;b320   ; la cara siguiente, de 6
	inc (ix+00ah)		;b322   ; sube la pose de la figura
	ld a,(ix+00ah)		;b325   ; lee la pose de la figura
	sub b			;b328
	cp 006h		;b329
	jr c,L_B332		;b32b
	ld a,013h		;b32d
	ld (ix+00ah),a		;b32f   ; guarda la pose de la figura
L_B332:
	push ix		;b332   ; la cara del 1 lleva otro color
	pop hl			;b334
	ld a,(ix+00ah)		;b335   ; la cara
	ld b,002h		;b338   ; el color 2...
	cp 013h		;b33a
	jr nz,L_B340		;b33c
	ld b,003h		;b33e   ; ... o el 3 en la cara del 1
L_B340:
	ld a,b			;b340
	ld (ix+025h),a		;b341
	jp 054e6h		;b344   ; colores_de_la_figura: los 16 colores de cada sprite de la figura, con la lista de su pose (0x554E)
L_B347:
	ld de,0889ah		;b347   ; crea la 0x2C en (0x9A, 0x88)
	ld a,02ch		;b34a
	jp 08334h		;b34c   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_44_sale:		; la figura de tipo 44 (0x2C): su arranque (tabla de p02:8427)
	ld (ix+00ah),03eh		;b34f   ; el tipo 44: quieto, pose 0x3E, y el rotulo 2
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
tipo_44:		; la figura de tipo 44 (0x2C), un cuadro (tabla de p02:871C)
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
	ld a,(0cd82h)		;b37e   ; elegido si y se puede pagar (0xCD86):
	or a			;b381   ; nada aun
	ret z			;b382
	cp 002h		;b383   ; no: paso 3
	jr z,L_B3CB		;b385
	ld de,(0cd86h)		;b387   ; se paga lo que cuesta
	call L_B539		;b38b
	jr c,L_B3DA		;b38e
	ld a,007h		;b390   ; el texto 7, la musica fuera, el tiempo parado (0xCD32)...
	call L_B836		;b392
	inc (ix+001h)		;b395   ; el paso siguiente: la animacion desde 0
	ld (ix+00bh),000h		;b398
	ld (ix+075h),008h		;b39c
	ld a,000h		;b3a0
	call 04fe4h		;b3a2   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,001h		;b3a5   ; el tiempo parado...
	ld (0cd32h),a		;b3a7
	ld (0cd91h),a		;b3aa   ; ... y la marca se va
	ld a,(0c498h)		;b3ad   ; se guarda la y del jugador
	ld (0cd33h),a		;b3b0
	ld a,(0c494h)		;b3b3   ; lee la y del jugador
	ld (0cd34h),a		;b3b6
	ld a,0f0h		;b3b9
	ld (0c498h),a		;b3bb   ; guarda la y de los sprites del jugador
	ld (0c494h),a		;b3be   ; guarda la y del jugador
	ld hl,00000h		;b3c1   ; quieto
	ld (0c49bh),hl		;b3c4
	ld (0c49dh),hl		;b3c7
	ret			;b3ca
L_B3CB:
	ld a,007h		;b3cb   ; elegido no: el texto 7 y paso 3
	call L_B836		;b3cd
	ld a,001h		;b3d0
	ld (0cd91h),a		;b3d2
	ld (ix+001h),003h		;b3d5   ; el paso en que va la figura = 0x03
	ret			;b3d9
L_B3DA:
	ld a,001h		;b3da   ; sin dinero: el texto 4 y paso 3
	ld (0cd91h),a		;b3dc
	ld a,004h		;b3df
	call L_B836		;b3e1
	ld (ix+001h),003h		;b3e4   ; el paso en que va la figura = 0x03
	ret			;b3e8
L_B3E9:
	dec (ix+075h)		;b3e9   ; cada 8 cuadros, un paso de la animacion, 8 en total
	ret nz			;b3ec
	ld (ix+075h),008h		;b3ed   ; cada 8 cuadros
	call L_B43F		;b3f1   ; el fundido, un paso mas
	inc (ix+00bh)		;b3f4   ; 8 pasos
	ld a,(ix+00bh)		;b3f7
	cp 008h		;b3fa
	ret nz			;b3fc
	call 045eeh		;b3fd   ; y luego una pantalla aparte: el dibujo de Goemon (0x90, 0xA0) o de Ebisumaru (0xC8, 0xA0) de la pagina 1 en (0x80, 0x80)
	call 045cbh		;b400   ; borra_la_pagina: esconde los sprites y pinta del color 0 los 256 x 256 puntos
	ld a,(0c002h)		;b403   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	rla			;b406
	ld hl,090a0h		;b407
	ld bc,0161bh		;b40a
	jr nc,L_B415		;b40d
	ld hl,0c8a0h		;b40f
	ld bc,01a1dh		;b412
L_B415:
	ld de,08080h		;b415   ; en (0x80, 0x80) de la pagina 0
	ld a,001h		;b418
	call 0476eh		;b41a   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
	call 04cfch		;b41d   ; sus colores
	call 04d08h		;b420
	ld a,005h		;b423   ; el color 5, (7, 6, 3)
	ld de,07603h		;b425
	call 0463ch		;b428   ; pon_un_color: color A de la paleta = DE
	ld (ix+00eh),000h		;b42b   ; se ve
	ld (ix+00bh),005h		;b42f
	inc (ix+001h)		;b433   ; sube el paso en que va la figura
	ld (ix+075h),014h		;b436   ; 20 cuadros por pose
	ld (ix+018h),003h		;b43a   ; 3 poses
	ret			;b43e
L_B43F:
	ld c,(ix+00bh)		;b43f   ; el fundido: los 15 colores de 0xB470, menos el paso (0xC, hasta 0)
	ld b,00fh		;b442
L_B444:
	ld a,b			;b444   ; el color B: tres bytes en 0xB470 + (B - 1) * 3 - 1
	dec a			;b445
	add a,a			;b446
	add a,b			;b447
	dec a			;b448
	ld hl,0b470h		;b449
	call 04083h		;b44c   ; hl_mas_a: HL += A
	ld a,(hl)			;b44f   ; rojo - el paso, no menos de 0
	inc hl			;b450
	sub c			;b451
	jr nc,L_B455		;b452
	xor a			;b454
L_B455:
	add a,a			;b455   ; * 16
	add a,a			;b456
	add a,a			;b457
	add a,a			;b458
	ld d,a			;b459   ; en el nibble de arriba
	ld a,(hl)			;b45a   ; azul - el paso
	inc hl			;b45b
	sub c			;b45c
	jr nc,L_B460		;b45d
	xor a			;b45f
L_B460:
	or d			;b460
	ld d,a			;b461   ; D = rojo y azul
	ld a,(hl)			;b462   ; verde - el paso
	inc hl			;b463
	sub c			;b464
	jr nc,L_B468		;b465
	xor a			;b467
L_B468:
	ld e,a			;b468   ; E = verde
	ld a,b			;b469
	call 0463ch		;b46a   ; pon_un_color: color A de la paleta = DE
	djnz L_B444		;b46d   ; los 15 colores, del 15 al 1
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
	ld a,(0c002h)		;b49d   ; en la posada, las poses del jugador dormido (0x3E Goemon, 0x7E Ebisumaru, + 0xB535)
	rla			;b4a0   ; el bit 7: Ebisumaru
	ld c,03eh		;b4a1
	jr nc,L_B4A7		;b4a3
	ld c,07eh		;b4a5
L_B4A7:
	dec (ix+075h)		;b4a7   ; cada 20 cuadros
	ret nz			;b4aa
	ld (ix+075h),014h		;b4ab
	ld a,(ix+018h)		;b4af   ; la pose de este paso (0xB535)
	dec a			;b4b2
	ld de,0b535h		;b4b3
	call 04088h		;b4b6   ; de_mas_a: DE += A
	ld a,(de)			;b4b9
	add a,c			;b4ba
	ld (ix+00ah),a		;b4bb   ; guarda la pose de la figura
	ld a,(ix+018h)		;b4be   ; con el efecto 0x17
	cp 002h		;b4c1
	ld a,017h		;b4c3
	call z,04fe4h		;b4c5   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	dec (ix+018h)		;b4c8   ; 4 poses por vuelta
	ret nz			;b4cb
	ld (ix+018h),004h		;b4cc
	dec (ix+00bh)		;b4d0   ; y (ix+0x0B) vueltas
	ret nz			;b4d3
	ld (ix+00bh),00ah		;b4d4   ; 10 cuadros, y dos pasos mas alla
	inc (ix+001h)		;b4d8   ; sube el paso en que va la figura
	inc (ix+001h)		;b4db   ; sube el paso en que va la figura
	ret			;b4de
L_B4DF:
	dec (ix+00bh)		;b4df   ; al acabar: la musica 0x16, la casilla otra vez...
	ret nz			;b4e2
	call 045eeh		;b4e3   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	ld a,096h		;b4e6
	call 04fe4h		;b4e8   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call 051edh		;b4eb   ; monta_la_pantalla: monta en 0xD800 la pantalla de la casilla: 8 x 6 bloques de 4 x 4 caracteres
	call 0534eh		;b4ee   ; pinta_la_pantalla: pinta los caracteres de 0xD800 en la pantalla
	ld de,00020h		;b4f1   ; ... y la vida: suma_vida toma A, no DE; A vale 0xD0 (lo que deja pinta_la_pantalla), asi que se llena
	call 05884h		;b4f4   ; suma_vida: suma A a la vida, hasta la maxima, y la pinta
	call 043e2h		;b4f7   ; el marcador y la paleta
	call 04cfch		;b4fa   ; paleta_base: pone la paleta base
	call 04d08h		;b4fd
	inc (ix+001h)		;b500   ; sube el paso en que va la figura
	ld (ix+00bh),010h		;b503
	ret			;b507
L_B508:
	call 0460ah		;b508   ; 16 cuadros sin sprites, y vuelve el jugador a su sitio
	dec (ix+00bh)		;b50b
	ret nz			;b50e
	call 045e1h		;b50f   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	xor a			;b512
	ld (0cd32h),a		;b513
	ld a,(0cd33h)		;b516
	ld (0c498h),a		;b519   ; guarda la y de los sprites del jugador
	ld a,(0cd34h)		;b51c
	ld (0c494h),a		;b51f   ; guarda la y del jugador
	ld a,081h		;b522   ; la musica 0x01...
	call 04fe4h		;b524   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,00fh		;b527   ; ... la posada sube de precio (la cosa 15 de 0xCDA0)...
	call L_AEFC		;b529
	ld a,003h		;b52c   ; ... y el rotulo 3
	call 04280h		;b52e   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	jp 087b7h		;b531   ; borra_la_figura: borra la figura
L_B534:
	ret			;b534   ; el paso 3: nada

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
	ld hl,(0c265h)		;b539   ; paga DE ryo: si no llega, el efecto 0x1B y carry
	push de			;b53c
	rst 20h			;b53d
	pop de			;b53e
	jp nc,05958h		;b53f   ; resta_dinero: resta DE ryo (BCD) al dinero, hasta 0
	ld a,01bh		;b542
	call 04fe4h		;b544   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	scf			;b547
	ret			;b548
L_B549:
	ld de,08070h		;b549   ; crea la 0x2B en (0x70, 0x80)
	ld a,02bh		;b54c
	jp 08334h		;b54e   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_43_sale:		; la figura de tipo 43 (0x2B): su arranque (tabla de p02:8427)
	ld (ix+00ah),00eh		;b551   ; el tipo 43, el que cobra la entrada al LABERINTO: pose 0x0E, los rotulos 0 y 0x71
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
tipo_43:		; la figura de tipo 43 (0x2B), un cuadro (tabla de p02:871C)
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
	inc (ix+001h)		;b57f   ; su precio, en (0x88, 0x38)
	ld hl,0cd87h		;b582
	ld de,08838h		;b585
	ld b,002h		;b588
	call 04420h		;b58a   ; pinta_bcd: pinta cifras en BCD
	ret			;b58d
L_B58E:
	ld a,(0cd82h)		;b58e   ; elegido si y pagado: el icono 0x0E (32 x 32) en (0x30, 0x20)...
	or a			;b591   ; nada aun
	ret z			;b592
	ld a,001h		;b593
	ld (0cd91h),a		;b595   ; la marca se va
	ld a,(0cd82h)		;b598
	cp 002h		;b59b   ; no
	jr z,L_B5C0		;b59d
	ld de,(0cd86h)		;b59f   ; se paga
	call L_B539		;b5a3
	jr c,L_B5BC		;b5a6
	ld de,03020h		;b5a8
	ld a,00eh		;b5ab
	call 04eb9h		;b5ad   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
	ld a,001h		;b5b0   ; ... 0xCDB0 = 1 (ya se puede entrar en el laberinto, p01:7D0D) y la musica 0x11
	ld (0cdb0h),a		;b5b2
	ld a,091h		;b5b5
	call 04fe4h		;b5b7   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	jr L_B5C0		;b5ba
L_B5BC:
	ld a,06eh		;b5bc   ; sin dinero, el texto 0x6E; si no, el 7
	jr L_B5C2		;b5be
L_B5C0:
	ld a,007h		;b5c0   ; el texto 7
L_B5C2:
	call L_B836		;b5c2
	inc (ix+001h)		;b5c5   ; sube el paso en que va la figura
L_B5C8:
	ret			;b5c8   ; el paso 2: nada
L_B5C9:
	ld a,(0cd5bh)		;b5c9   ; los tipos 7 y 13 salen de tres en tres, en fila
	or a			;b5cc
	ret nz			;b5cd   ; en la primera tanda no
	ld a,(0cd31h)		;b5ce   ; ni si ya hay una fila
	or a			;b5d1
	ret nz			;b5d2
	call L_B67A		;b5d3   ; las cuentas a cero
	push bc			;b5d6
	call 08334h		;b5d7   ; tres del tipo B
	pop bc			;b5da
	push bc			;b5db
	call 08334h		;b5dc   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
	pop bc			;b5df
	push bc			;b5e0
	call 08334h		;b5e1   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
	pop bc			;b5e4
	ld a,007h		;b5e5   ; con el 7, las cuentas otra vez a cero
	cp b			;b5e7
	ret nz			;b5e8
	jp L_B67A		;b5e9
tipos_07_13_sale:		; los tipos 7 y 13: su arranque
	ld a,(0cd12h)		;b5ec   ; cada uno 24 - (los bits 2-3 de la dificultad) cuadros despues del anterior
	and 00ch		;b5ef
	ld b,a			;b5f1
	ld a,018h		;b5f2
	sub b			;b5f4
	ld b,a			;b5f5
	ld a,(0cd30h)		;b5f6   ; la espera, despues de la del anterior
	add a,b			;b5f9
	ld (ix+00bh),a		;b5fa
	ld (0cd30h),a		;b5fd
	ld hl,0cd31h		;b600   ; uno mas en la fila
	inc (hl)			;b603
	ld (ix+00eh),001h		;b604   ; no se ve ni hace dano hasta que le toca
	ld (ix+00ch),000h		;b608
	ld a,(ix+000h)		;b60c   ; el 13 sale en (0xB0, 0x58)
	cp 007h		;b60f
	jr z,L_B623		;b611
	ld de,0b058h		;b613
	ld (ix+005h),d		;b616   ; guarda la x de la figura
	ld (ix+003h),e		;b619   ; guarda la y de la figura
	ld (ix+001h),002h		;b61c   ; el paso en que va la figura = 0x02
	jp 0893dh		;b620   ; pon_la_pose: pone la pose de la figura
L_B623:
	ld (ix+001h),001h		;b623   ; el 7 sale donde salio el primero (0xCD4A), con su direccion (0xCD4C)
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
	ld a,(0cd14h)		;b645   ; si el primero no pudo salir (0xCD14), los demas tampoco
	or a			;b648
	call nz,087b7h		;b649   ; borra_la_figura: borra la figura
	ld a,(0cd31h)		;b64c   ; el primero elige por donde sale (p02:9763) y lo apunta para los otros
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
	ld (0cd31h),a		;b67b   ; ninguna fila, nadie fuera
	ld (0cd14h),a		;b67e
	ld a,010h		;b681   ; la espera desde 16
	ld (0cd30h),a		;b683
	ret			;b686
L_B687:
	ld de,08070h		;b687
	jp 08334h		;b68a   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_47_sale:		; la figura de tipo 47 (0x2F): su arranque (tabla de p02:8427)
	ld (ix+00ah),010h		;b68d   ; el tipo 47: la casa de las cosas de tipo 0x14 (0xC340), pose 0x10
	ret			;b691
tipo_47:		; la figura de tipo 47 (0x2F), un cuadro (tabla de p02:871C)
	ld a,(ix+001h)		;b692   ; segun su paso (0xB698)
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
	ld a,(0c27eh)		;b6a4   ; con la cosa 0x0A, el texto 0x0F
	or a			;b6a7
	jr nz,L_B6DD		;b6a8
	call L_B71D		;b6aa   ; si no: la marca de esta casilla en 0xC340...
	ld a,(hl)			;b6ad   ; la marcada (bit 7): los textos desde 0; las demas, desde 4
	and 080h		;b6ae
	ld b,004h		;b6b0
	jr z,L_B6B6		;b6b2
	ld b,000h		;b6b4
L_B6B6:
	ld a,(hl)			;b6b6   ; ... elige el texto (0xB716): la marcada (bit 7) y las demas, por lo que lleven
	and 07fh		;b6b7   ; + las visitas
	add a,b			;b6b9
	ld de,0b716h		;b6ba
	call 04088h		;b6bd   ; de_mas_a: DE += A
	ld a,(de)			;b6c0
	call L_B836		;b6c1   ; el texto
	call L_B71D		;b6c4   ; con 2 visitas:
	ld a,(hl)			;b6c7
	ld b,a			;b6c8
	and 07fh		;b6c9   ; las visitas
	cp 002h		;b6cb
	jr z,L_B6E4		;b6cd
L_B6CF:
	ld a,000h		;b6cf   ; el rotulo 0 y la marca de si o no
	call 04280h		;b6d1   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	inc (ix+001h)		;b6d4   ; sube el paso en que va la figura
	ld a,026h		;b6d7
	call 0828fh		;b6d9
	ret			;b6dc
L_B6DD:
	ld a,00fh		;b6dd   ; el texto 0x0F
	call L_B836		;b6df
	jr L_B6CF		;b6e2
L_B6E4:
	ld (ix+00bh),070h		;b6e4   ; 128 cuadros... (0x70)
	ld a,b			;b6e8
	and 080h		;b6e9   ; no es la marcada: se queda el dinero
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
	ld a,080h		;b6ff   ; marcada y vista: 0x80
	ld (hl),a			;b701
	ld a,001h		;b702   ; la cosa 0x0A
	ld (0c27eh),a		;b704
	jp L_B7AB		;b707   ; y fuera
L_B70A:
	xor a			;b70a   ; ... las demas: se queda con TODO el dinero
	ld (hl),a			;b70b
	ld de,(0c265h)		;b70c   ; lee el DINERO (ryo, BCD) y el byte siguiente (16 bits)
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
	ld a,(0c28dh)		;b71d   ; HL = la marca de esta casilla en la lista de 0xC340 (0xC28D entradas)
	ld b,a			;b720
	ld hl,0c340h		;b721
	ld a,(0c281h)		;b724   ; lee la CASILLA de la zona
L_B727:
	cp (hl)			;b727   ; la casilla...
	inc hl			;b728
	ret z			;b729   ; ... encontrada: HL = su marca
	inc hl			;b72a   ; la siguiente
	djnz L_B727		;b72b
	ret			;b72d
L_B72E:
	ld a,(0cd82h)		;b72e   ; elegido si: un texto al azar (p03:B75E), 128 cuadros...
	or a			;b731   ; nada aun
	ret z			;b732
	cp 002h		;b733   ; no: fuera
	jp z,L_B828		;b735
	ld a,001h		;b738
	ld (0cd91h),a		;b73a   ; la marca se va
	ld (0cd2eh),a		;b73d
	call L_B75E		;b740   ; el texto
	ld (ix+00bh),080h		;b743   ; 128 cuadros
	inc (ix+001h)		;b747   ; sube el paso en que va la figura
	ld a,(0c27eh)		;b74a   ; ... y sin la cosa 0x0A, una visita mas (hasta 3)
	or a			;b74d
	ret nz			;b74e
	call L_B71D		;b74f
	ld a,(hl)			;b752
	cp 083h		;b753   ; hasta 3
	ret z			;b755
	inc a			;b756   ; una visita mas
	ld (hl),a			;b757
	ret			;b758
L_B759:
	ld (ix+001h),004h		;b759   ; el paso en que va la figura = 0x04
	ret			;b75d
L_B75E:
	ld c,017h		;b75e   ; el texto al azar: de los 0x17 primeros; con las cosas 3 y 4, de 0x37; con ellas y la 0x0A, de 0x46
	ld a,(0c273h)		;b760   ; con la cosa 3...
	or a			;b763
	jr z,L_B776		;b764
	ld c,037h		;b766
	ld a,(0c274h)		;b768   ; ... y la 4...
	or a			;b76b
	jr z,L_B776		;b76c
	ld a,(0c27eh)		;b76e   ; ... y la 0x0A
	or a			;b771
	jr z,L_B776		;b772
	ld c,046h		;b774
L_B776:
	ld a,(0c28fh)		;b776   ; el anterior + 0-15 (registro R), dando la vuelta
	cp c			;b779   ; si se pasa, se recorta
	call nc,L_B7A6		;b77a
	ld b,a			;b77d
	ld a,r		;b77e   ; + 0-15 al azar
	and 00fh		;b780
	add a,b			;b782
	cp c			;b783
	jr c,L_B787		;b784   ; dando la vuelta
	sub c			;b786
L_B787:
	ld hl,0c28fh		;b787   ; apuntado en 0xC28F; el rotulo 0x20 + n
	ld (hl),a			;b78a
	add a,020h		;b78b
	jp L_B836		;b78d
L_B790:
	dec (ix+00bh)		;b790   ; al acabar la espera, el texto 0x11 y se cobra (p03:B7D3)
	ret nz			;b793
	ld a,011h		;b794
	call L_B836		;b796
	call L_B7D3		;b799
	jr nc,L_B7AB		;b79c   ; si no llega, otros 128 cuadros (y luego p03:B7B4)
	ld (ix+00bh),080h		;b79e
	inc (ix+001h)		;b7a2   ; sube el paso en que va la figura
	ret			;b7a5
L_B7A6:
	sub c			;b7a6   ; A mod C
	jr nc,L_B7A6		;b7a7
	add a,c			;b7a9
	ret			;b7aa
L_B7AB:
	ld (ix+00bh),060h		;b7ab
	ld (ix+001h),005h		;b7af   ; el paso en que va la figura = 0x05
L_B7B3:
	ret			;b7b3   ; el paso 6: nada
L_B7B4:
	dec (ix+00bh)		;b7b4   ; sin dinero para pagar: el texto 0x15, fuera del interior y el jugador al estado 3 (despedido)
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
	call 067dah		;b7ce   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	jr L_B759		;b7d1
L_B7D3:
	ld hl,(0c265h)		;b7d3   ; lo que se cobra: con el dinero acabado en 5, 300 ryo...
	ld a,l			;b7d6   ; las unidades: 5
	and 00fh		;b7d7
	cp 005h		;b7d9
	ld de,00300h		;b7db
	jr z,L_B803		;b7de
	ld de,01000h		;b7e0   ; ... con 1000 o mas, 990...
	rst 20h			;b7e3   ; RST 0x20: HL contra 1000
	ld de,00990h		;b7e4
	jr nc,L_B803		;b7e7
	ld hl,(0c265h)		;b7e9   ; ... con menos de 31, 100...
	ld de,00031h		;b7ec
	rst 20h			;b7ef   ; contra 31
	ld de,00100h		;b7f0
	jr c,L_B803		;b7f3
	ld de,(0c265h)		;b7f5   ; ... y si no, el dinero - 30
	ld a,e			;b7f9   ; dinero - 30 en BCD
	sub 030h		;b7fa
	daa			;b7fc
	ld e,a			;b7fd
	ld a,d			;b7fe
	sbc a,000h		;b7ff
	daa			;b801
	ld d,a			;b802
L_B803:
	ld (0ee80h),de		;b803   ; se pinta en (0x68, 0x40)
	ld hl,0ee81h		;b807
	ld de,06840h		;b80a
	ld b,002h		;b80d
	call 04420h		;b80f   ; pinta_bcd: pinta cifras en BCD
	ld de,(0ee80h)		;b812   ; y se cobra: carry si no llegaba
	ld hl,(0c265h)		;b816   ; lee el DINERO (ryo, BCD) y el byte siguiente (16 bits)
	rst 20h			;b819
	push af			;b81a
	ld de,(0ee80h)		;b81b
	call 05958h		;b81f   ; resta_dinero: resta DE ryo (BCD) al dinero, hasta 0
	pop af			;b822
	ret			;b823
L_B824:
	dec (ix+00bh)		;b824   ; espera
	ret nz			;b827
L_B828:
	xor a			;b828   ; se sale del interior (p01:72B8)
	ld (0cd2eh),a		;b829
	inc a			;b82c
	ld (0c4a2h),a		;b82d   ; guarda el lado al que mira el jugador
	call 045eeh		;b830   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	jp 072b8h		;b833
L_B836:
	push af			;b836   ; el texto A: la caja del texto y el rotulo 0x16 delante
	call 092adh		;b837
	ld a,016h		;b83a
	call 04280h		;b83c   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	pop af			;b83f
	jp 04280h		;b840   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
L_B843:
	ld de,04030h		;b843   ; el laberinto: el marco de alrededor, con los caracteres de la pagina 1
	ld hl,0a008h		;b846   ; el caracter de (0xA0, 0x08), hacia abajo desde (0x30, 0x40)
	call L_B8A2		;b849
	ld de,0c830h		;b84c
	ld hl,0f010h		;b84f   ; el de (0xF0, 0x10), hacia abajo desde (0x30, 0xC8)
	call L_B8A2		;b852
	ld de,04828h		;b855
	ld hl,07800h		;b858   ; el de (0x78, 0x00), a la derecha desde (0x28, 0x48)
	call L_B8B3		;b85b
	ld de,048a0h		;b85e
	ld hl,07000h		;b861   ; el de (0x70, 0x00), a la derecha desde (0xA0, 0x48)
	call L_B8B3		;b864
	ld hl,0b882h		;b867   ; y ocho trozos mas (0xB882): [x][y][x][y]
	ld b,008h		;b86a
L_B86C:
	push bc			;b86c
	ld e,(hl)			;b86d   ; el sitio
	inc hl			;b86e
	ld d,(hl)			;b86f
	inc hl			;b870
	ld c,(hl)			;b871   ; el caracter
	inc hl			;b872
	ld b,(hl)			;b873
	inc hl			;b874
	push hl			;b875
	ld l,c			;b876
	ld h,b			;b877
	call 04ef1h		;b878   ; copia_caracter: el caracter de (H, L) de la pagina 1 en (D, E) de la 0 (LMMM IMP)
	pop hl			;b87b
	pop bc			;b87c
	djnz L_B86C		;b87d
	jp iconos_del_laberinto		;b87f   ; y los iconos

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
	ld b,00eh		;b8a2   ; el caracter de HL, 14 veces hacia abajo
L_B8A4:
	push bc			;b8a4
	push hl			;b8a5
	call 04ef1h		;b8a6   ; copia el caracter
	pop hl			;b8a9
	pop bc			;b8aa
	ld a,008h		;b8ab   ; 8 mas abajo
	call 04088h		;b8ad   ; de_mas_a: DE += A
	djnz L_B8A4		;b8b0
	ret			;b8b2
L_B8B3:
	ld b,010h		;b8b3   ; el caracter de HL, 16 veces hacia la derecha
L_B8B5:
	push bc			;b8b5
	push hl			;b8b6
	call 04ef1h		;b8b7   ; copia_caracter: el caracter de (H, L) de la pagina 1 en (D, E) de la 0 (LMMM IMP)
	pop hl			;b8ba
	pop bc			;b8bb
	ld a,008h		;b8bc   ; 8 a la derecha
	add a,d			;b8be
	ld d,a			;b8bf
	djnz L_B8B5		;b8c0
	ret			;b8c2
anda_por_el_laberinto:		; arriba avanza, izquierda y derecha giran, abajo da media vuelta, el boton el mapa
	ld a,001h		;b8c3   ; el laberinto, un cuadro: 0xCDC5 = 1 si hay que repintar
	ld (0cdc5h),a		;b8c5
	ld a,(0c006h)		;b8c8   ; arriba: un paso adelante
	ld b,a			;b8cb
	and 001h		;b8cc
	jr nz,L_B8EA		;b8ce
	ld a,b			;b8d0   ; izquierda: gira a la izquierda
	and 004h		;b8d1
	jr nz,L_B92D		;b8d3
	ld a,b			;b8d5   ; derecha: gira a la derecha
	and 008h		;b8d6
	jr nz,L_B927		;b8d8
	ld a,b			;b8da   ; abajo: media vuelta
	and 002h		;b8db
	jr nz,L_B920		;b8dd
	ld a,b			;b8df   ; el primer boton: el mapa del laberinto (p03:BAF1)
	and 010h		;b8e0
	jp nz,mapa_del_laberinto		;b8e2   ; mapa_del_laberinto: el mapa entero, si se tiene (0xC27A)
L_B8E5:
	xor a			;b8e5   ; nada que repintar
	ld (0cdc5h),a		;b8e6
	ret			;b8e9
L_B8EA:
	ld a,(0cdcch)		;b8ea   ; con una salida delante (0xCDCC)...
	or a			;b8ed   ; con salida delante
	jr nz,L_B913		;b8ee
	ld hl,0cdb2h		;b8f0   ; ... si hay pared justo delante (0xCDB2 = 1), no se mueve
	ld a,(hl)			;b8f3
	cp 001h		;b8f4
	jr z,L_B8E5		;b8f6
L_B8F8:
	ld a,(0cdc4h)		;b8f8   ; un paso hacia donde mira (0xCDC4): el vector de 0xBAD9
	add a,a			;b8fb   ; dos bytes por direccion
	ld hl,0bad9h		;b8fc
	call 04083h		;b8ff   ; hl_mas_a: HL += A
	ld e,(hl)			;b902   ; [dx][dy]
	inc hl			;b903
	ld d,(hl)			;b904
	ld hl,(0cdc6h)		;b905   ; la casilla donde se esta (0xCDC6: x, 0xCDC7: y)
	ld a,l			;b908
	add a,e			;b909
	ld l,a			;b90a
	ld a,h			;b90b
	add a,d			;b90c
	ld h,a			;b90d
	ld (0cdc6h),hl		;b90e   ; un paso
	jr L_B936		;b911   ; y la vista nueva
L_B913:
	ld hl,0cdb2h		;b913   ; con la salida justo delante, se sale (p03:BC6F con 6)
	ld a,(hl)			;b916
	cp 001h		;b917
	jr nz,L_B8F8		;b919   ; si no esta pegada, se avanza
	ld a,006h		;b91b
	jp L_BC6F		;b91d
L_B920:
	ld a,(0cdc4h)		;b920   ; media vuelta: la direccion + 2
	inc a			;b923
	inc a			;b924
	jr L_B931		;b925
L_B927:
	ld a,(0cdc4h)		;b927   ; a la derecha: + 1
	inc a			;b92a
	jr L_B931		;b92b
L_B92D:
	ld a,(0cdc4h)		;b92d   ; a la izquierda: - 1
	dec a			;b930
L_B931:
	and 003h		;b931   ; de 0 a 3
	ld (0cdc4h),a		;b933
L_B936:
	ld hl,0cdb3h		;b936   ; la vista: 0xCDB3-0xCDC3 a cero, y lo de los lados (0xCDC9) tambien
	ld de,0cdb4h		;b939
	xor a			;b93c
	ld (hl),a			;b93d
	ld bc,00010h		;b93e   ; 17 bytes
	ldir		;b941
	ld hl,0cdc9h		;b943   ; las tres de delante
	xor a			;b946
	ld (hl),a			;b947
	inc hl			;b948
	ld (hl),a			;b949
	inc hl			;b94a
	ld (hl),a			;b94b
	call lo_de_delante		;b94c   ; lo de delante, el lado izquierdo y el derecho
	call lado_izquierdo		;b94f   ; lado_izquierdo: las paredes del lado izquierdo de la vista
	jp lado_derecho		;b952   ; lado_derecho: las paredes del lado derecho de la vista
lo_de_delante:		; hasta 4 casillas hacia delante: la pared y lo que hay
	xor a			;b955   ; lo de delante: si se esta sobre una salida (6) y detras no hay pared, 0xCDCC = 1
	ld (0cdcch),a		;b956
	ld hl,(0cdc6h)		;b959
	call 05a6ah		;b95c   ; sitio_en_el_laberinto: HL = 0xD800 + H * 28 + L
	ld a,(hl)			;b95f
	cp 006h		;b960
	call z,L_B9AB		;b962
	ld a,(0cdc4h)		;b965   ; hasta 4 casillas hacia delante...
	ld de,0bad9h		;b968
	call 0447ch		;b96b   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,(0cdc6h)		;b96e
	ld b,004h		;b971
	ld c,001h		;b973
L_B975:
	call hl_mas_de		;b975   ; hl_mas_de: HL += DE
	push hl			;b978   ; la casilla siguiente hacia delante
	exx			;b979
	pop hl			;b97a
	call 05a6ah		;b97b   ; sitio_en_el_laberinto: HL = 0xD800 + H * 28 + L
	ld a,(hl)			;b97e
	exx			;b97f
	cp 001h		;b980   ; ... hasta una pared (1)...
	jr z,L_B997		;b982
	cp 006h		;b984   ; ... o una salida (6)
	jr z,L_B99C		;b986
	or a			;b988   ; lo que haya en ellas, a 0xCDC9 (para pintarlo)
	push de			;b989
	push hl			;b98a
	push bc			;b98b
	call nz,L_BA33		;b98c   ; algo (2-5): se apunta
	pop bc			;b98f
	pop hl			;b990
	pop de			;b991
	inc c			;b992   ; C = la profundidad
	djnz L_B975		;b993
	ld c,000h		;b995   ; sin pared en 4: 0
L_B997:
	ld a,c			;b997   ; 0xCDB2 = a cuantas casillas esta la pared (0: ninguna en 4)
	ld (0cdb2h),a		;b998
	ret			;b99b
L_B99C:
	inc c			;b99c   ; la salida, como una pared mas alla...
	ld a,c			;b99d
	cp 005h		;b99e
	jr nz,L_B9A4		;b9a0
	ld c,000h		;b9a2   ; ... (la 5 es 0)
L_B9A4:
	ld a,001h		;b9a4   ; 0xCDCC = 1: hay salida
	ld (0cdcch),a		;b9a6
	jr L_B997		;b9a9
L_B9AB:
	ld a,(0cdc4h)		;b9ab   ; lo de detras (media vuelta)...
	add a,002h		;b9ae
	and 003h		;b9b0
	ld de,0bad9h		;b9b2
	call 0447ch		;b9b5   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,(0cdc6h)		;b9b8
	call hl_mas_de		;b9bb   ; hl_mas_de: HL += DE
	call 05a6ah		;b9be   ; sitio_en_el_laberinto: HL = 0xD800 + H * 28 + L
	ld a,(hl)			;b9c1
	cp 001h		;b9c2   ; ... si es pared, nada
	ret z			;b9c4
	ld a,001h		;b9c5   ; si no, 0xCDCC = 1
	ld (0cdcch),a		;b9c7
	ret			;b9ca
flecha_de_direccion:		; los sprites de la flecha hacia donde se mira
	ld a,(0cdc4h)		;b9cb   ; los dos sprites de la flecha que dice hacia donde se mira...
	rr a		;b9ce   ; mirando a izquierda o derecha (bit 0)...
	jr nc,L_BA09		;b9d0
	ld hl,0d830h		;b9d2   ; ... los dos sprites en (0x30, 0xD8)
	ld (0ee00h),hl		;b9d5
	ld (0ee04h),hl		;b9d8
	ld bc,00c03h		;b9db   ; patrones 0x0C y 0x03 (al reves segun el lado)
	rr a		;b9de
	jr c,L_B9E5		;b9e0
	ld a,c			;b9e2
	ld c,b			;b9e3
	ld b,a			;b9e4
L_B9E5:
	ld l,0ech		;b9e5   ; el primero con color 0xEC...
	ld h,c			;b9e7
	ld (0ee02h),hl		;b9e8
	ld l,0f0h		;b9eb   ; ... el segundo con 0xF0
	ld h,b			;b9ed
	ld (0ee06h),hl		;b9ee
	ld hl,0ec00h		;b9f1   ; ... y sus colores
	ld de,0ee03h		;b9f4
	ld c,002h		;b9f7
L_B9F9:
	ld b,010h		;b9f9   ; 16 lineas de color por sprite
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
	ld hl,0d830h		;ba09   ; arriba o abajo: un sprite en (0x30, 0xD8)
	ld (0ee00h),hl		;ba0c
	ld de,00c03h		;ba0f
	rr a		;ba12
	ld a,0e8h		;ba14   ; patron 0xE8; el segundo, fuera
	ld (0ee02h),a		;ba16
	ld a,0e0h		;ba19
	ld (0ee04h),a		;ba1b
	jr nc,L_BA23		;ba1e   ; los dos colores, al reves segun el lado
	ld a,e			;ba20
	ld e,d			;ba21
	ld d,a			;ba22
L_BA23:
	ld hl,0ec00h		;ba23
	ld b,008h		;ba26
L_BA28:
	ld (hl),e			;ba28   ; 8 lineas de un color
	inc hl			;ba29
	djnz L_BA28		;ba2a
	ld b,008h		;ba2c
L_BA2E:
	ld (hl),d			;ba2e   ; y 8 del otro
	inc hl			;ba2f
	djnz L_BA2E		;ba30
	ret			;ba32
L_BA33:
	ex af,af'			;ba33   ; lo de la casilla C de delante, a 0xCDC9 + C - 1 (la 4 no)
	ld a,004h		;ba34   ; la cuarta no se pinta
	cp c			;ba36
	ret z			;ba37
	ex af,af'			;ba38
	push hl			;ba39
	push de			;ba3a
	dec c			;ba3b   ; 0xCDC9 + C - 1
	ld e,c			;ba3c
	ld d,000h		;ba3d
	ld hl,0cdc9h		;ba3f
	add hl,de			;ba42
	ld (hl),a			;ba43
	pop de			;ba44
	pop hl			;ba45
	ret			;ba46
lado_izquierdo:		; las paredes del lado izquierdo de la vista
	ld a,(0cdc4h)		;ba47   ; el lado izquierdo (0xBAE1): 5 casillas, a 0xCDB3 y su dibujo a 0xCDBB
	ld de,0bae1h		;ba4a   ; la casilla de la izquierda, segun la direccion
	call 0447ch		;ba4d   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,(0cdc6h)		;ba50
	call hl_mas_de		;ba53   ; hl_mas_de: HL += DE
	ld c,005h		;ba56   ; 5 de profundidad
	exx			;ba58
	ld hl,0cdb3h		;ba59   ; a 0xCDB3 lo que hay, a 0xCDBB el dibujo
	ld de,0cdbbh		;ba5c
	exx			;ba5f
	jr L_BA7B		;ba60
lado_derecho:		; las paredes del lado derecho de la vista
	ld a,(0cdc4h)		;ba62   ; el derecho (0xBAE9), a 0xCDB7 y 0xCDBF
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
	ld a,(0cdc4h)		;ba7c   ; hacia delante, desde alli
	ld de,0bad9h		;ba7f
	call 0447ch		;ba82   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	pop hl			;ba85
	ld a,(0cdb2h)		;ba86
	or a			;ba89
	jr nz,L_BA8E		;ba8a
	ld a,004h		;ba8c
L_BA8E:
	ld b,a			;ba8e   ; tantas casillas como haya hasta la pared de delante (4 si no hay)
L_BA8F:
	push bc			;ba8f   ; la casilla
	push de			;ba90
	push hl			;ba91
	call 05a6ah		;ba92   ; sitio_en_el_laberinto: HL = 0xD800 + H * 28 + L
	ld a,(hl)			;ba95   ; lo que hay
	pop hl			;ba96
	pop de			;ba97
	pop bc			;ba98
	push bc			;ba99
	call L_BAA5		;ba9a   ; su dibujo
	pop bc			;ba9d
	call hl_mas_de		;ba9e   ; la siguiente hacia delante
	inc c			;baa1
	djnz L_BA8F		;baa2
	ret			;baa4
L_BAA5:
	ld b,a			;baa5   ; el dibujo de cada una: pared (1) o hueco, segun la profundidad
	cp 001h		;baa6   ; pared: el dibujo C
	ld a,000h		;baa8
	jr z,L_BAAE		;baaa
	ld a,004h		;baac   ; hueco: C + 4
L_BAAE:
	add a,c			;baae
	push bc			;baaf
	exx			;bab0
	pop bc			;bab1
	ld (hl),b			;bab2   ; lo que hay, a la vista
	push bc			;bab3
	ld c,a			;bab4
	ld a,001h		;bab5   ; si es pared...
	cp (hl)			;bab7
	ld a,c			;bab8
	pop bc			;bab9
	jr z,L_BACD		;baba
	push bc			;babc
	ld c,a			;babd
	dec a			;babe
	and 003h		;babf
	ld b,a			;bac1
	ld a,(0cdb2h)		;bac2   ; ... justo antes de la pared de delante...
	dec a			;bac5
	cp b			;bac6
	ld a,c			;bac7
	pop bc			;bac8
	jr nz,L_BACD		;bac9
	add a,004h		;bacb   ; ... la esquina, 4 mas
L_BACD:
	ld (de),a			;bacd   ; el dibujo
	inc hl			;bace
	inc de			;bacf
	exx			;bad0
	ret			;bad1
hl_mas_de:		; HL += DE
	ld a,l			;bad2   ; L + E
	add a,e			;bad3
	ld l,a			;bad4
	ld a,h			;bad5   ; H + D (sin acarreo entre ellos)
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


mapa_del_laberinto:		; el mapa entero, si se tiene (0xC27A)
	xor a			;baf1   ; el mapa del laberinto, solo con 0xC27A (la palabra de la pausa o lo que se coge)
	ld (0cdc5h),a		;baf2
	ld a,(0c27ah)		;baf5
	or a			;baf8
	ret z			;baf9
	inc a			;bafa   ; 0xCDC8 = mapa en pantalla; el efecto 0x1A
	ld (0cdc8h),a		;bafb
	ld a,01ah		;bafe
	call 04fe4h		;bb00   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call 045eeh		;bb03   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call L_BC3A		;bb06
	call 05856h		;bb09   ; pinta_las_cosas: pinta las cosas del marcador
	call 043e2h		;bb0c   ; pinta_el_marcador: pinta el marcador entero
	call 05890h		;bb0f   ; pinta_la_vida: pinta la barra de vida
	call pinta_el_mapa		;bb12   ; pinta_el_mapa: el laberinto en piezas de 8 x 8, centrado
	call donde_se_esta		;bb15   ; donde_se_esta: la marca del jugador en el mapa
	jp 045e1h		;bb18   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
pinta_el_mapa:		; el laberinto en piezas de 8 x 8, centrado
	ld a,(0cdd3h)		;bb1b   ; el mapa, centrado: y = (20 - alto) / 2 * 8 + 0x20 (0xCDD3, el alto)...
	ld b,a			;bb1e
	ld a,014h		;bb1f
	sub b			;bb21
	srl a		;bb22
	add a,a			;bb24
	add a,a			;bb25
	add a,a			;bb26
	add a,020h		;bb27
	ld l,a			;bb29
	ld a,(0cdd4h)		;bb2a   ; ... x = (28 - ancho) / 2 * 8 + 8 (0xCDD4, el ancho)
	ld b,a			;bb2d
	ld a,01ch		;bb2e
	sub b			;bb30
	srl a		;bb31
	add a,a			;bb33
	add a,a			;bb34
	add a,a			;bb35
	add a,008h		;bb36
	ld h,a			;bb38
	ld (0cdd5h),hl		;bb39   ; 0xCDD5 = y, 0xCDD6 = x: la esquina
	ld a,(0cdd4h)		;bb3c   ; el sprite de la marca, a la derecha del mapa
	add a,a			;bb3f
	add a,a			;bb40
	add a,a			;bb41
	add a,h			;bb42
	ld h,a			;bb43
	ld (0ee00h),hl		;bb44   ; un sprite marca donde se esta
	ld a,0f4h		;bb47   ; patron 0xF4
	ld (0ee02h),a		;bb49
	ld a,0e0h		;bb4c   ; el segundo, fuera
	ld (0ee04h),a		;bb4e
	ld hl,0ec00h		;bb51
	ld de,0ec01h		;bb54
	ld bc,0000fh		;bb57
	ld a,00eh		;bb5a   ; sus colores, 0x0E
	ld (hl),a			;bb5c
	ldir		;bb5d
	ld a,(0cdd3h)		;bb5f   ; cada casilla, su pieza de 8 x 8 (0xBC1B segun lo que sea)
	ld c,a			;bb62   ; C = las filas
	ld de,0d800h		;bb63
	ld hl,(0cdd5h)		;bb66
L_BB69:
	ld a,(0cdd4h)		;bb69   ; B = las columnas
	ld b,a			;bb6c
	push de			;bb6d
	push hl			;bb6e
L_BB6F:
	ld a,(de)			;bb6f   ; lo que hay en la casilla
	inc de			;bb70
	or a			;bb71
	push de			;bb72
	jr z,L_BB8E		;bb73   ; 0: nada
	push hl			;bb75
	cp 006h		;bb76   ; la salida (6), aparte
	jr z,L_BBCD		;bb78
	dec a			;bb7a   ; la pieza de lo que hay (1-5)
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
	call 04ef1h		;bb89   ; copia_caracter: el caracter de (H, L) de la pagina 1 en (D, E) de la 0 (LMMM IMP)
	pop bc			;bb8c
	ex de,hl			;bb8d
L_BB8E:
	ld de,00800h		;bb8e   ; 8 a la derecha
	call hl_mas_de		;bb91   ; hl_mas_de: HL += DE
	pop de			;bb94
	djnz L_BB6F		;bb95
	pop hl			;bb97
	pop de			;bb98
	ld a,01ch		;bb99   ; la fila siguiente del laberinto (28)
	call 04088h		;bb9b   ; de_mas_a: DE += A
	push de			;bb9e
	ld de,00008h		;bb9f   ; 8 mas abajo
	call hl_mas_de		;bba2   ; hl_mas_de: HL += DE
	pop de			;bba5
	dec c			;bba6
	jr nz,L_BB69		;bba7
	ret			;bba9
donde_se_esta:		; la marca del jugador en el mapa
	ld hl,(0cdc6h)		;bbaa   ; el sitio del jugador en el mapa
	sla h		;bbad   ; la x * 8
	sla h		;bbaf
	sla h		;bbb1
	sla l		;bbb3   ; la y * 8
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
	jp 04ef1h		;bbca   ; copia_caracter: el caracter de (H, L) de la pagina 1 en (D, E) de la 0 (LMMM IMP)
L_BBCD:
	ld a,(0ef80h)		;bbcd   ; la salida se ve en el mapa solo con el bit 6 de 0xEF80 y la cosa 0x0A...
	and 040h		;bbd0
	jr z,L_BC15		;bbd2
	ld a,(0c27eh)		;bbd4
	or a			;bbd7
	jr z,L_BC15		;bbd8
	dec de			;bbda   ; ... y entonces con una flecha hacia el lado abierto
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


sale_del_mapa:		; el boton vuelve a la vista
	ld a,(0c006h)		;bc27   ; en el mapa: el primer boton vuelve a la vista
	and 010h		;bc2a
	ret z			;bc2c
	xor a			;bc2d
	ld (0cdc8h),a		;bc2e
	call 045eeh		;bc31   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 0598dh		;bc34   ; pinta_el_laberinto: la vista del laberinto y el marcador
	jp 045e1h		;bc37   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
L_BC3A:
	ld bc,000d4h		;bc3a   ; borra la pantalla y los sprites
	call 045fbh		;bc3d   ; pinta_de_color_0: rellena del color 0 B x C puntos desde (0, 0) y pone el scroll a 0
	jp 0460ah		;bc40   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
iconos_del_laberinto:		; los iconos de lo cogido en el laberinto
	ld a,(0c27ah)		;bc43   ; los iconos de lo cogido en el laberinto: el mapa (0xC27A)...
	or a			;bc46
	call nz,L_BCA5		;bc47
	ld a,(0c27bh)		;bc4a   ; ... y uno por cada moneda (0xC27B)
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
coge_en_el_laberinto:		; lo que hay en la casilla, una vez
	ld hl,(0cdc6h)		;bc5c   ; al pisar una casilla con algo (2-5): se coge una vez (0xC290) y la casilla queda vacia
	call 05a6ah		;bc5f   ; sitio_en_el_laberinto: HL = 0xD800 + H * 28 + L
	ld a,(hl)			;bc62
	or a			;bc63
	ret z			;bc64
	cp 006h		;bc65
	ret z			;bc67
	call apunta_lo_cogido		;bc68   ; apunta_lo_cogido: la casilla, a la lista de 0xC290
	ld c,000h		;bc6b
	ld a,(hl)			;bc6d
	ld (hl),c			;bc6e
L_BC6F:
	dec a			;bc6f   ; segun lo que sea (tabla de 0xBC74)
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
	ld de,00200h		;bc7e   ; 2: 200 ryo y un icono mas
	call 0592bh		;bc81
	ld hl,0c27bh		;bc84
	ld a,(hl)			;bc87
	inc (hl)			;bc88
L_BC89:
	ld d,028h		;bc89   ; el icono 0x10 en (0x28, 0x40 + n * 16)
	add a,a			;bc8b
	add a,a			;bc8c
	add a,a			;bc8d
	add a,a			;bc8e
	add a,040h		;bc8f
	ld e,a			;bc91
	ld a,010h		;bc92
	jp 04eb9h		;bc94   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
L_BC97:
	ld hl,0c279h		;bc97   ; 3: una cosa 9 mas
	inc (hl)			;bc9a
	ld a,009h		;bc9b
	jp 057fah		;bc9d   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
L_BCA0:
	ld a,001h		;bca0   ; 4: el MAPA del laberinto (0xC27A = 1), y su icono
	ld (0c27ah),a		;bca2
L_BCA5:
	ld a,011h		;bca5
	ld de,02830h		;bca7
	jp 04eb9h		;bcaa   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
L_BCAD:
	ld hl,0c260h		;bcad   ; 5: una vida (hasta 99)
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
	xor a			;bcbe   ; 6: la salida: 0xCDCD = 1, 15 cuadros y la musica 0x00
	ld (0cdd2h),a		;bcbf
	ld (0cdc5h),a		;bcc2
	inc a			;bcc5
	ld (0cdcdh),a		;bcc6
	ld a,00fh		;bcc9
	ld (0cdceh),a		;bccb
	ld a,080h		;bcce
	jp 04fe4h		;bcd0   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
apunta_lo_cogido:		; la casilla, a la lista de 0xC290
	ld de,0c290h		;bcd3   ; apunta la casilla en el primer hueco de las 11 de 0xC290: ya no vuelve a salir
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
laberinto_a_cero:		; lo cogido y el mapa, a cero
	ld hl,0c290h		;bcf2   ; al entrar en la zona: lo cogido en el laberinto, el mapa y 0xC28E a cero
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
salida_del_laberinto:		; la puerta, el premio y fuera
	ld a,(0cdd2h)		;bd06   ; la salida del laberinto, paso a paso (0xCDD2)
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
	ld de,04c30h		;bd12   ; paso 0: se abre la puerta (p03:BD48 y p03:BD57) durante 15 cuadros
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
	ld de,07848h		;bd2e   ; y aparecen los iconos 0x13 y 0x14
	ld a,013h		;bd31
	call 04eb9h		;bd33   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
	ld de,08848h		;bd36
	ld a,014h		;bd39
	call 04eb9h		;bd3b   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
	ld a,(0c28eh)		;bd3e   ; si ya se salio una vez en esta zona (0xC28E), sin premio
	or a			;bd41
	ret z			;bd42
	ld hl,0cdd2h		;bd43
	inc (hl)			;bd46
	ret			;bd47
L_BD48:
	ld (0cd08h),de		;bd48   ; 0xCD08 el sitio, 0xCD0A el tamano, 0xCD0C el paso, 0xCD0D cuantos
	ld (0cd0ah),hl		;bd4c
	ld (0cd0ch),a		;bd4f
	ld a,c			;bd52
	ld (0cd0dh),a		;bd53
	ret			;bd56
L_BD57:
	ld de,(0cd08h)		;bd57   ; la puerta que se abre: trozos que se corren con HMMM y el hueco en negro
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
	ld hl,0cdceh		;bdb2   ; paso 1: el rotulo 0x0E, 10000 PUNTOS (C = 1)...
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
	ld a,001h		;bdcb   ; ... 0xC28E = 1 y la musica 0x13
	ld (0c28eh),a		;bdcd
	ld a,093h		;bdd0
	jp 04fe4h		;bdd2   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_BDD5:
	ld hl,0cdceh		;bdd5   ; paso 2: fuera del laberinto, la entrada se gasta (0xCDB0 = 0) y sube de precio
	dec (hl)			;bdd8
	ret nz			;bdd9
	call 045eeh		;bdda   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 072b8h		;bddd
	xor a			;bde0
	ld (0cdb0h),a		;bde1
	ld (0cdb1h),a		;bde4   ; guarda si se esta en el laberinto
	ld (0cdcdh),a		;bde7
	inc a			;bdea
	ld (0c4a2h),a		;bdeb   ; guarda el lado al que mira el jugador
	ld a,00eh		;bdee
	call L_AEFC		;bdf0
	jp 04a96h		;bdf3   ; caracteres_del_juego: sube los caracteres del juego de graficos de la zona
teclea_palabra:		; las palabras de la pausa: 5 letras, comparadas con las de 0xBE44 y 0xBE49
	call 06cd8h		;bdf6   ; en la pausa: las teclas, hasta 5, en 0xC580
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
	ld a,(0cdb1h)		;be13   ; con 5 tecleadas: dentro del laberinto, la primera palabra (0xBE44) pone el bit 0 de 0xEF80...
	and a			;be16
	jr z,L_BE2C		;be17
	ld de,0be44h		;be19
	ld c,001h		;be1c
	call L_BE31		;be1e
	ld a,(0ef80h)		;be21   ; ... y con el, el mapa (0xC27A = 1)
	rra			;be24
	ret nc			;be25
	ld a,001h		;be26
	ld (0c27ah),a		;be28
	ret			;be2b
L_BE2C:
	ld de,0be49h		;be2c   ; fuera, la segunda (0xBE49) pone el bit 1
	ld c,002h		;be2f
L_BE31:
	ld hl,0c580h		;be31   ; si las 5 letras son las de DE, el bit C en 0xEF80
	ld b,005h		;be34
L_BE36:
	ld a,(de)			;be36
	cp (hl)			;be37
	ret nz			;be38
	inc hl			;be39
	inc de			;be3a
	djnz L_BE36		;be3b
	ld hl,0ef80h		;be3d   ; apunta a los SECRETOS: bit 0 y 1 las palabras de la pausa, 2-5 las claves, 6 el menu
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


claves_secretas:		; las cuatro claves de 9 letras (0xBE8A) en vez de la contrasena
	ld bc,00420h		;be4e   ; las cuatro claves de 9 letras de la contrasena (0xBE8A): bits 5, 4, 3 y 2
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
	ld a,(0ef80h)		;be6c   ; ninguna: vuelta al titulo
	and 03ch		;be6f
	jr nz,L_BE7A		;be71
	ld hl,00000h		;be73
	ld (0c000h),hl		;be76   ; guarda el estado (0xC000) y el paso (0xC001) de un tiron
	ret			;be79
L_BE7A:
	call 04351h		;be7a   ; alguna: partida nueva con lo que de la clave, y al estado 4
	call 0662ch		;be7d   ; prepara_la_partida: letras, dibujos de siempre y la vida a 0x10
	call lo_que_da_la_clave		;be80   ; lo_que_da_la_clave: jugador 2, vida 0x20, 2000 ryo o continuar
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


lo_que_da_la_clave:		; jugador 2, vida 0x20, 2000 ryo o continuar
	ld a,040h		;beae   ; lo que da: el bit 2, jugar con Ebisumaru...
	ld (0c002h),a		;beb0   ; guarda las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	ld a,(0ef80h)		;beb3   ; lee los SECRETOS: bit 0 y 1 las palabras de la pausa, 2-5 las claves, 6 el menu
	rra			;beb6
	rra			;beb7
	rra			;beb8
	jr c,L_BEC4		;beb9
	rra			;bebb   ; ... el 3, la vida maxima a 0x20...
	jr c,L_BECA		;bebc
	rra			;bebe   ; ... el 4, 2000 ryo...
	jr c,L_BED0		;bebf
	rra			;bec1   ; ... el 5, continuar
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
	ld (0c265h),hl		;bed3   ; guarda el DINERO (ryo, BCD) y el byte siguiente (16 bits)
	ret			;bed6
L_BED7:
	ld a,001h		;bed7
	ld (0c27fh),a		;bed9   ; guarda si se puede continuar
	ret			;bedc
secreto_del_menu:		; el bit 6 de 0xEF80
	ld hl,0ef80h		;bedd   ; cambiar la opcion del menu del titulo 6 o 7 veces (p00:5EB6) pone el bit 6 de 0xEF80
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
