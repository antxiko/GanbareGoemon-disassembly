; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX2 - MegaROM RC-748 de 128 KB (Konami4) - banco 00 (se ejecuta en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; DATOS cabecera_ab: la cabecera del cartucho: 'AB', INIT (0x4097) y
;   STATEMENT, DEVICE y TEXT a cero; lo leen la BIOS (16 bytes)
;   0x4000..0x4010  (16 bytes)
DATA_cabecera_ab:
	defb 041h,042h,097h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  AB.@............

; ----------------------------------------------------------------------
; DATOS cabecera_de_konami: la cabecera de Konami que lee el Game Master desde
;   la otra ranura: 'CD', 0x07 0x48 (RC-748) y, detras, direcciones de la RAM
;   del juego (0xC004, 0xC280, 0xC260...); el propio cartucho no la lee; lo
;   leen el Game Master (53 bytes)
;   0x4010..0x4045  (53 bytes)
DATA_cabecera_de_konami:
	defb 043h,044h,007h,048h,0ffh,000h,0c0h,004h	; 4010  CD.H....
	defb 080h,0c2h,007h,060h,0c2h,057h,0c2h,05ah	; 4018  ...`.W.Z
	defb 0c2h,054h,0c2h,002h,0c0h,0b2h,0c0h,0adh	; 4020  .T......
	defb 0c0h,0adh,0c0h,0adh,0c0h,01ah,0c0h,01bh	; 4028  ........
	defb 0c0h,034h,0c0h,035h,0c0h,04eh,0c0h,04fh	; 4030  .4.5.N.O
	defb 0c0h,092h,065h,0a0h,0c0h,0b3h,0c0h,09eh	; 4038  ..e.....
	defb 0c0h,074h,0c0h,075h,0c0h	; 4040

; ======================================================================
; CODIGO 0x4045..0x4182  (317 bytes)
; ======================================================================


interrupcion:		; cada cuadro, por H.TIMI: el sonido (banco 10 en 0x6000) y el juego
	di			;4045
	ld a,(0ef00h)		;4046   ; lee el VECINO: 0xFF con el Game Master o Q*bert en otra ranura
	or a			;4049
	jp nz,L_40E7		;404a
L_404D:
	ld a,00ah		;404d
	ld (06000h),a		;404f   ; el mapper: pone en 0x6000 el banco de A
	inc a			;4052
	ld (08000h),a		;4053   ; el mapper: pone en 0x8000 el banco de A
	inc a			;4056
	ld (0a000h),a		;4057   ; el mapper: pone en 0xA000 el banco de A
	call 06000h		;405a
	di			;405d
	ld a,(0f0f1h)		;405e   ; lee la copia del banco de 0x6000
	ld (06000h),a		;4061   ; el mapper: pone en 0x6000 el banco de A
	ld a,(0f0f2h)		;4064   ; lee la copia del banco de 0x8000
	ld (08000h),a		;4067   ; el mapper: pone en 0x8000 el banco de A
	ld a,(0f0f3h)		;406a   ; lee la copia del banco de 0xA000
	ld (0a000h),a		;406d   ; el mapper: pone en 0xA000 el banco de A
	ld hl,0c005h		;4070   ; apunta a el semaforo de la interrupcion
	bit 0,(hl)		;4073
	jp nz,L_4081		;4075
	inc (hl)			;4078
	ei			;4079
	call maquina_de_estados		;407a   ; maquina_de_estados: despacha por el estado de 0xC000
	xor a			;407d
	ld (0c005h),a		;407e   ; guarda el semaforo de la interrupcion
L_4081:
	ei			;4081
	ret			;4082
hl_mas_a:		; HL += A
	add a,l			;4083
	ld l,a			;4084
	ret nc			;4085
	inc h			;4086
	ret			;4087
de_mas_a:		; DE += A
	add a,e			;4088
	ld e,a			;4089
	ret nc			;408a
	inc d			;408b
	ret			;408c
despacha:		; salta a la entrada A de la tabla que va detras del call
	pop hl			;408d
	add a,a			;408e
	call hl_mas_a		;408f   ; hl_mas_a: HL += A
	ld e,(hl)			;4092
	inc hl			;4093
	ld d,(hl)			;4094
	ex de,hl			;4095
	jp (hl)			;4096
init:		; arranque del cartucho
	di			;4097
	ld sp,0f0f0h		;4098
	call 00138h		;409b   ; BIOS RSLREG - Reads the primary slot register
	rrca			;409e
	rrca			;409f
	and 003h		;40a0
	ld c,a			;40a2
	ld b,000h		;40a3
	ld hl,0fcc1h		;40a5
	add hl,bc			;40a8
	ld a,(hl)			;40a9
	and 080h		;40aa
	or c			;40ac
	ld c,a			;40ad
	inc hl			;40ae
	inc hl			;40af
	inc hl			;40b0
	inc hl			;40b1
	ld a,(hl)			;40b2
	and 00ch		;40b3
	or c			;40b5
	ld h,080h		;40b6
	call 00024h		;40b8   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,0c000h		;40bb   ; apunta a el ESTADO del juego
	ld de,0c001h		;40be   ; apunta a el paso del estado
	ld bc,030efh		;40c1
	ld (hl),000h		;40c4
	ldir		;40c6
	call bancos_1_2_3		;40c8   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call 07eabh		;40cb   ; busca_al_vecino: busca el Game Master o Q*bert en otra ranura (0xEF00)
	call bancos_1_2_3		;40ce   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call prepara_el_vdp		;40d1   ; prepara_el_vdp: pasa a SCREEN 5 y pone los registros del V9938
	di			;40d4
	ld a,0c3h		;40d5
	ld (0fd9fh),a		;40d7
	ld hl,interrupcion		;40da
	ld (0fda0h),hl		;40dd
	xor a			;40e0
	ld (0f3dbh),a		;40e1
	ei			;40e4
L_40E5:
	jr L_40E5		;40e5
L_40E7:
	ld a,007h		;40e7
	call 00141h		;40e9   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;40ec
	and 010h		;40ed
	ld b,a			;40ef
	ld a,001h		;40f0
	call 00141h		;40f2   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;40f5
	and 080h		;40f6
	or b			;40f8
	ld hl,0ef10h		;40f9
	ld c,(hl)			;40fc
	ld (hl),a			;40fd
	xor c			;40fe
	and (hl)			;40ff
	ld c,a			;4100
	ld hl,0ef01h		;4101
	ld a,(hl)			;4104
	or a			;4105
	jr nz,L_4113		;4106
	bit 4,c		;4108
	jp z,L_404D		;410a
	ld (hl),c			;410d
	call calla_y_guarda		;410e   ; calla_y_guarda: guarda los volumenes del PSG (registros 8-10) en 0xEF11-0xEF13 y los pone a cero
	ei			;4111
	ret			;4112
L_4113:
	bit 7,c		;4113
	jp nz,L_411E		;4115
	bit 4,c		;4118
	jr z,L_4124		;411a
	xor a			;411c
	ld (hl),a			;411d
L_411E:
	call devuelve_volumen		;411e   ; devuelve_volumen: vuelve a poner los volumenes guardados en 0xEF11-0xEF13
	jp L_404D		;4121
L_4124:
	call calla_el_psg		;4124   ; calla_el_psg: los tres volumenes del PSG a cero
	ei			;4127
	ret			;4128
calla_y_guarda:		; guarda los volumenes del PSG (registros 8-10) en 0xEF11-0xEF13 y los pone a cero
	ld a,008h		;4129
	call 00096h		;412b   ; BIOS RDPSG - Reads value from PSG-register
	ld (0ef11h),a		;412e
	ld a,009h		;4131
	call 00096h		;4133   ; BIOS RDPSG - Reads value from PSG-register
	ld (0ef12h),a		;4136
	ld a,00ah		;4139
	call 00096h		;413b   ; BIOS RDPSG - Reads value from PSG-register
	ld (0ef13h),a		;413e
calla_el_psg:		; los tres volumenes del PSG a cero
	ld e,000h		;4141
	ld a,008h		;4143
	call 00093h		;4145   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,000h		;4148
	inc a			;414a
	call 00093h		;414b   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,000h		;414e
	inc a			;4150
	jp 00093h		;4151   ; BIOS WRTPSG - Writes data to PSG-register
devuelve_volumen:		; vuelve a poner los volumenes guardados en 0xEF11-0xEF13
	ld a,(0ef11h)		;4154
	ld e,a			;4157
	ld a,008h		;4158
	call 00093h		;415a   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0ef12h)		;415d
	ld e,a			;4160
	ld a,009h		;4161
	call 00093h		;4163   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0ef13h)		;4166
	ld e,a			;4169
	ld a,00ah		;416a
	jp 00093h		;416c   ; BIOS WRTPSG - Writes data to PSG-register
musica_de_la_zona:		; la musica del juego de graficos de la zona (tabla 0x4182)
	ld a,(0c002h)		;416f   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	and 040h		;4172
	ret z			;4174
	ld hl,04182h		;4175
	ld a,(0c289h)		;4178   ; lee el juego de graficos de la zona
	call hl_mas_a		;417b   ; hl_mas_a: HL += A
	ld a,(hl)			;417e
	jp sonido		;417f   ; sonido: arranca la musica o el efecto A

; ----------------------------------------------------------------------
; DATOS musica_de_cada_juego: la musica de cada juego de graficos (0xC289):
;   0x82, 0x83, 0x86, 0x84, 0x85 y 0x87; p00:416F la pide con p00:4FE4 si el
;   bit 6 de 0xC002 esta puesto (6 bytes)
;   0x4182..0x4188  (6 bytes)
DATA_musica_de_cada_juego:
	defb 082h,083h,086h,084h,085h,087h	; 4182

; ======================================================================
; CODIGO 0x4188..0x437b  (499 bytes)
; ======================================================================


enlaces_de_la_zona:		; copia los enlaces entre casillas de la zona a 0xE780
	call bancos_4_5_6		;4188   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	call indice_de_la_zona		;418b   ; indice_de_la_zona: A = (fase * 7 + zona) * 2
	ld hl,0b7d0h		;418e
	call palabra_de_tabla		;4191   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	push hl			;4194
	ld a,(hl)			;4195
	push af			;4196
	add a,a			;4197
	ld h,000h		;4198
	ld l,a			;419a
	add hl,hl			;419b
	dec hl			;419c
	ld b,h			;419d
	ld c,l			;419e
	ld hl,0e780h		;419f
	ld de,0e781h		;41a2
	ld (hl),0ffh		;41a5
	ldir		;41a7
	pop af			;41a9
	dec a			;41aa
	ld b,a			;41ab
	ld hl,0e783h		;41ac
	ld a,001h		;41af
	ld (hl),a			;41b1
L_41B2:
	inc hl			;41b2
	inc hl			;41b3
	inc hl			;41b4
	dec a			;41b5
	ld (hl),a			;41b6
	inc hl			;41b7
	inc a			;41b8
	inc a			;41b9
	ld (hl),a			;41ba
	djnz L_41B2		;41bb
	ld (hl),0ffh		;41bd
	pop hl			;41bf
	inc hl			;41c0
	ld a,(hl)			;41c1
	and a			;41c2
	jp z,bancos_1_2_3		;41c3   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ld b,a			;41c6
	inc hl			;41c7
L_41C8:
	push hl			;41c8
	ld a,(hl)			;41c9
	and 07fh		;41ca
	add a,a			;41cc
	ld h,000h		;41cd
	ld l,a			;41cf
	add hl,hl			;41d0
	ld de,0e780h		;41d1
	add hl,de			;41d4
	ex de,hl			;41d5
	pop hl			;41d6
	ld a,(hl)			;41d7
	ld c,000h		;41d8
	rla			;41da
	rl c		;41db
	inc hl			;41dd
	ld a,(hl)			;41de
	rla			;41df
	rl c		;41e0
	ld a,c			;41e2
	call de_mas_a		;41e3   ; de_mas_a: DE += A
	ld a,(hl)			;41e6
	and 07fh		;41e7
	cp 07fh		;41e9
	jr nz,L_41EF		;41eb
	ld a,0ffh		;41ed
L_41EF:
	ld (de),a			;41ef
	inc hl			;41f0
	djnz L_41C8		;41f1
	jp bancos_1_2_3		;41f3   ; bancos_1_2_3: pone los bancos 1, 2 y 3
indice_de_la_zona:		; A = (fase * 7 + zona) * 2
	ld a,(0c288h)		;41f6   ; lee la FASE (0-6)
	ld b,a			;41f9
	add a,a			;41fa
	ld c,a			;41fb
	add a,a			;41fc
	add a,b			;41fd
	add a,c			;41fe
	ld c,a			;41ff
	ld a,(0c280h)		;4200   ; lee la ZONA (0-6)
	add a,c			;4203
	add a,a			;4204
	ret			;4205
bancos_1_2_3:		; pone los bancos 1, 2 y 3
	di			;4206
	push hl			;4207
	ld hl,0f0f1h		;4208   ; apunta a la copia del banco de 0x6000
	ld a,001h		;420b
	ld (06000h),a		;420d   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4210
	inc a			;4211
	ld (08000h),a		;4212   ; el mapper: pone en 0x8000 el banco de A
	inc hl			;4215
	ld (hl),a			;4216
	inc a			;4217
	ld (0a000h),a		;4218   ; el mapper: pone en 0xA000 el banco de A
	inc hl			;421b
	ld (hl),a			;421c
	pop hl			;421d
	ei			;421e
	ret			;421f
bancos_4_5_6:		; pone los bancos 4, 5 y 6
	di			;4220
	ld hl,0f0f1h		;4221   ; apunta a la copia del banco de 0x6000
	ld a,004h		;4224
	ld (06000h),a		;4226   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4229
	inc l			;422a
	inc a			;422b
	ld (08000h),a		;422c   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;422f
	inc l			;4230
	inc a			;4231
	ld (0a000h),a		;4232   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;4235
	ei			;4236
	ret			;4237
bancos_7_8_9:		; pone los bancos 7, 8 y 9
	di			;4238
	ld hl,0f0f1h		;4239   ; apunta a la copia del banco de 0x6000
	ld a,007h		;423c
	ld (06000h),a		;423e   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4241
	inc l			;4242
	inc a			;4243
	ld (08000h),a		;4244   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;4247
	inc l			;4248
	inc a			;4249
	ld (0a000h),a		;424a   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;424d
	ei			;424e
	ret			;424f
bancos_10_11_12:		; pone los bancos 10, 11 y 12
	di			;4250
	ld hl,0f0f1h		;4251   ; apunta a la copia del banco de 0x6000
	ld a,00ah		;4254
	ld (06000h),a		;4256   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4259
	inc l			;425a
	inc a			;425b
	ld (08000h),a		;425c   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;425f
	inc l			;4260
	inc a			;4261
	ld (0a000h),a		;4262   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;4265
	ei			;4266
	ret			;4267
bancos_13_14_15:		; pone los bancos 13, 14 y 15
	di			;4268
	ld hl,0f0f1h		;4269   ; apunta a la copia del banco de 0x6000
	ld a,00dh		;426c
	ld (06000h),a		;426e   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4271
	inc l			;4272
	inc a			;4273
	ld (08000h),a		;4274   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;4277
	inc l			;4278
	inc a			;4279
	ld (0a000h),a		;427a   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;427d
	ei			;427e
	ret			;427f
rotulo_numero:		; pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	cp 0ffh		;4280
	ret z			;4282
	push af			;4283
	call bancos_10_11_12		;4284   ; bancos_10_11_12: pone los bancos 10, 11 y 12
	pop af			;4287
	ld de,0a9c0h		;4288
	call palabra_de_tabla_de		;428b   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;428e
	call rotulo		;428f   ; rotulo: pinta un rotulo
	jp bancos_1_2_3		;4292   ; bancos_1_2_3: pone los bancos 1, 2 y 3
pantallas_de_la_zona:		; descomprime las pantallas de la zona a 0xD000
	call bancos_13_14_15		;4295   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld a,(0c289h)		;4298   ; lee el juego de graficos de la zona
	add a,a			;429b
	ld hl,06000h		;429c
	call palabra_de_tabla		;429f   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ex de,hl			;42a2
	ld hl,0d000h		;42a3
	call rle_a_la_ram		;42a6   ; rle_a_la_ram: descomprime un rle a la RAM
	jp bancos_1_2_3		;42a9   ; bancos_1_2_3: pone los bancos 1, 2 y 3
bloques_de_la_zona:		; descomprime los bloques de la zona a 0xE100
	call bancos_13_14_15		;42ac   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld a,(0c289h)		;42af   ; lee el juego de graficos de la zona
	add a,a			;42b2
	ld hl,075b9h		;42b3
	call palabra_de_tabla		;42b6   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ex de,hl			;42b9
	ld hl,0e100h		;42ba
	call rle_a_la_ram		;42bd   ; rle_a_la_ram: descomprime un rle a la RAM
	jp bancos_1_2_3		;42c0   ; bancos_1_2_3: pone los bancos 1, 2 y 3
rle_a_la_ram:		; descomprime un rle a la RAM
	ld a,(de)			;42c3
	and a			;42c4
	ret z			;42c5
	inc de			;42c6
	ld b,a			;42c7
	and 07fh		;42c8
	cp b			;42ca
	jr z,L_42D9		;42cb
	and a			;42cd
	jr z,rle_a_la_ram		;42ce
	ex de,hl			;42d0
	ld b,000h		;42d1
	ld c,a			;42d3
	ldir		;42d4
	ex de,hl			;42d6
	jr rle_a_la_ram		;42d7
L_42D9:
	ld a,(de)			;42d9
	inc de			;42da
L_42DB:
	ld (hl),a			;42db
	inc hl			;42dc
	djnz L_42DB		;42dd
	jr rle_a_la_ram		;42df
empieza_texto:		; empieza un texto letra a letra: HL el texto, DE el sitio (0xCD61-0xCD67)
	ld (0cd61h),de		;42e1
	ld (0cd63h),de		;42e5
	ld (0cd65h),hl		;42e9
	xor a			;42ec
	ld (0cd67h),a		;42ed
	ret			;42f0
sigue_texto:		; saca la letra siguiente del texto de 0xCD65 (0xFF acaba)
	ld a,(0cd67h)		;42f1
	or a			;42f4
	ret nz			;42f5
	ld hl,(0cd65h)		;42f6
	ld a,(hl)			;42f9
	inc hl			;42fa
	ld (0cd65h),hl		;42fb
	cp 0ffh		;42fe
	jr z,L_432D		;4300
	cp 0feh		;4302
	jr z,L_4333		;4304
	cp 0e0h		;4306
	jr nc,L_4345		;4308
	ld de,(0cd61h)		;430a
	push af			;430e
	call letra		;430f   ; letra: pinta una letra
	pop af			;4312
	cp 062h		;4313
	jr c,L_431B		;4315
	cp 064h		;4317
	jr c,L_431F		;4319
L_431B:
	ld a,008h		;431b
	jr L_4321		;431d
L_431F:
	ld a,004h		;431f
L_4321:
	ld de,(0cd61h)		;4321
	add a,d			;4325
	ld d,a			;4326
	ld (0cd61h),de		;4327
	or a			;432b
	ret			;432c
L_432D:
	ld a,001h		;432d
	ld (0cd67h),a		;432f
	ret			;4332
L_4333:
	ld de,(0cd63h)		;4333
	ld a,008h		;4337
	add a,e			;4339
	ld e,a			;433a
	ld (0cd63h),de		;433b
	ld (0cd61h),de		;433f
	jr sigue_texto		;4343
L_4345:
	sub 0e0h		;4345
	jr z,L_432D		;4347
	add a,a			;4349
	add a,a			;434a
	add a,a			;434b
	call L_4321		;434c
	jr sigue_texto		;434f
empieza_la_partida:		; la RAM de la partida a cero desde 0xC25A, y vidas de 0x437B
	ld hl,0c25ah		;4351   ; apunta a los puntos del jugador 2 (BCD)
	ld bc,00da6h		;4354
	ld d,h			;4357
	ld e,l			;4358
	inc e			;4359
	ld (hl),000h		;435a
	ldir		;435c
	ld hl,0437bh		;435e
	ld de,0c260h		;4361   ; apunta a las vidas
	ld bc,00003h		;4364
	ldir		;4367
	ld a,(0c002h)		;4369   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	and 020h		;436c
	ret z			;436e
	ld hl,0c260h		;436f   ; apunta a las vidas
	ld de,0c360h		;4372
	ld bc,00100h		;4375
	ldir		;4378
	ret			;437a

; ----------------------------------------------------------------------
; DATOS al_empezar_la_partida: los tres bytes que p00:435E copia a
;   0xC260-0xC262 al empezar: 3 vidas (0xC260, que p00:5F00 resta), 0xC261 = 1
;   y 0xC262 = 0x10, los puntos (en BCD, x 10.000) de la proxima vida que mira
;   p00:43AA (3 bytes)
;   0x437b..0x437e  (3 bytes)
DATA_al_empezar_la_partida:
	defb 003h,001h,010h	; 437b

; ======================================================================
; CODIGO 0x437e..0x49ca  (1612 bytes)
; ======================================================================


suma_puntos:		; suma puntos en BCD al jugador que juega
	ld c,000h		;437e
L_4380:
	ld a,(0c002h)		;4380   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	add a,a			;4383
	ld hl,0c257h		;4384   ; apunta a los puntos del jugador 1 (BCD)
	jr nc,L_438C		;4387
	ld hl,0c25ah		;4389   ; apunta a los puntos del jugador 2 (BCD)
L_438C:
	ld a,(hl)			;438c
	add a,e			;438d
	daa			;438e
	ld (hl),a			;438f
	inc l			;4390
	ld a,(hl)			;4391
	adc a,d			;4392
	daa			;4393
	ld (hl),a			;4394
	inc hl			;4395
	ld a,(hl)			;4396
	adc a,c			;4397
	daa			;4398
	ld (hl),a			;4399
	jr nc,L_43A9		;439a
	ld bc,09999h		;439c
	ld (0c254h),bc		;439f
	ld (0c255h),bc		;43a3
	jr pinta_los_puntos		;43a7
L_43A9:
	ex de,hl			;43a9
	ld hl,0c262h		;43aa   ; apunta a los puntos de la proxima vida
	cp (hl)			;43ad
	jr c,L_43C7		;43ae
	ld a,(hl)			;43b0
	add a,010h		;43b1
	daa			;43b3
	jr nc,L_43B8		;43b4
	ld a,0ffh		;43b6
L_43B8:
	ld (hl),a			;43b8
	push de			;43b9
	ld hl,0c260h		;43ba   ; apunta a las vidas
	inc (hl)			;43bd
	ld a,014h		;43be
	call sonido		;43c0   ; sonido: arranca la musica o el efecto A
	call pinta_las_vidas		;43c3   ; pinta_las_vidas: pinta las vidas
	pop de			;43c6
L_43C7:
	ex de,hl			;43c7
	ld b,003h		;43c8
	ld de,0c256h		;43ca
L_43CD:
	ld a,(de)			;43cd
	sub (hl)			;43ce
	jr c,L_43D7		;43cf
	jr nz,pinta_los_puntos		;43d1
	dec l			;43d3
	dec e			;43d4
	djnz L_43CD		;43d5
L_43D7:
	ld bc,00003h		;43d7
	ld e,056h		;43da
	ld l,059h		;43dc
	lddr		;43de
	jr pinta_los_puntos		;43e0
pinta_el_marcador:		; pinta el marcador entero
	ld a,(0c002h)		;43e2   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	ld hl,0642dh		;43e5
	add a,a			;43e8
	jr nc,L_43EE		;43e9
	ld hl,06435h		;43eb
L_43EE:
	call rotulo		;43ee   ; rotulo: pinta un rotulo
	ld hl,063f0h		;43f1
	call rotulo		;43f4   ; rotulo: pinta un rotulo
	call pinta_las_cosas		;43f7   ; pinta_las_cosas: pinta las cosas del marcador
	call pinta_el_dinero		;43fa   ; pinta_el_dinero: pinta el dinero
	call pinta_el_tiempo		;43fd   ; pinta_el_tiempo: pinta el tiempo
	call pinta_la_vida		;4400   ; pinta_la_vida: pinta la barra de vida
	call pinta_las_vidas		;4403   ; pinta_las_vidas: pinta las vidas
pinta_los_puntos:		; pinta los puntos
	ld a,(0c002h)		;4406   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	ld de,01008h		;4409
	ld hl,0c259h		;440c
	add a,a			;440f
	jr nc,L_4414		;4410
	ld l,05ch		;4412
L_4414:
	ld b,003h		;4414
	jr pinta_bcd		;4416
pinta_las_vidas:		; pinta las vidas
	ld hl,0c260h		;4418   ; apunta a las vidas
	ld de,0e808h		;441b
	ld b,001h		;441e
pinta_bcd:		; pinta cifras en BCD
	ld c,000h		;4420
L_4422:
	dec b			;4422
	jr nz,L_4427		;4423
	ld c,0ffh		;4425
L_4427:
	inc b			;4427
	ld a,(hl)			;4428
	rra			;4429
	rra			;442a
	rra			;442b
	rra			;442c
	call L_4438		;442d
	ld a,(hl)			;4430
	call L_4438		;4431
	dec hl			;4434
	djnz L_4422		;4435
	ret			;4437
L_4438:
	and 00fh		;4438
	jr z,L_443E		;443a
	ld c,0ffh		;443c
L_443E:
	add a,020h		;443e
	and c			;4440
	call letra		;4441   ; letra: pinta una letra
	ld a,d			;4444
	add a,008h		;4445
	ld d,a			;4447
	ret			;4448
intercambia:		; intercambia los bytes de (HL) y (DE)
	push bc			;4449
	ld c,(hl)			;444a
	ld a,(de)			;444b
	ld (hl),a			;444c
	ld a,c			;444d
	ld (de),a			;444e
	inc hl			;444f
	inc de			;4450
	pop bc			;4451
	dec bc			;4452
	ld a,b			;4453
	or c			;4454
	jr nz,intercambia		;4455
	ret			;4457
L_4458:
	ld hl,0c004h		;4458   ; apunta a la espera del estado, en cuadros
	bit 3,(hl)		;445b
	ld c,0ffh		;445d
	jr nz,L_4462		;445f
	inc c			;4461
L_4462:
	ld hl,048a8h		;4462
	ld de,048b0h		;4465
	ld a,(0c252h)		;4468
	or a			;446b
	jr nz,L_446F		;446c
	ex de,hl			;446e
L_446F:
	push hl			;446f
	call L_4476		;4470
	pop de			;4473
	ld c,000h		;4474
L_4476:
	ld hl,063d8h		;4476
	jp rotulo_sin_posicion		;4479   ; rotulo_sin_posicion: pinta un rotulo donde se quedo el anterior
palabra_de_tabla_de:		; DE = la palabra A de la tabla de DE
	ld l,a			;447c
	ld h,000h		;447d
	add hl,hl			;447f
	add hl,de			;4480
	ld e,(hl)			;4481
	inc hl			;4482
	ld d,(hl)			;4483
	ret			;4484
L_4485:
	ld hl,09f09h		;4485
	ld c,00eh		;4488
	ld a,(0c480h)		;448a   ; lee la vida maxima
	add a,a			;448d
	inc a			;448e
	inc a			;448f
	ld d,a			;4490
	ld e,007h		;4491
	jp marco		;4493   ; marco: pinta un marco
L_4496:
	call L_4516		;4496
	call L_44A9		;4499
	ex af,af'			;449c
	ld a,(00006h)		;449d
	ld c,a			;44a0
	ex af,af'			;44a1
L_44A2:
	inir		;44a2
	dec a			;44a4
	jr nz,L_44A2		;44a5
	ex de,hl			;44a7
	ret			;44a8
L_44A9:
	ex de,hl			;44a9
	ld a,c			;44aa
	or a			;44ab
	ld a,b			;44ac
	ld b,c			;44ad
	ret z			;44ae
	inc a			;44af
	ret			;44b0
copia_a_la_vram:		; copia bytes de la RAM a la VRAM
	ex de,hl			;44b1
	call vram_para_escribir		;44b2   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	call L_44A9		;44b5
	ex af,af'			;44b8
	ld a,(00007h)		;44b9
	ld c,a			;44bc
	ex af,af'			;44bd
L_44BE:
	otir		;44be
	dec a			;44c0
	jr nz,L_44BE		;44c1
	ret			;44c3
rellena_la_vram:		; llena un tramo de la VRAM con un byte
	push de			;44c4
	push af			;44c5
	call vram_para_escribir		;44c6   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	ld d,c			;44c9
	ld a,c			;44ca
	or a			;44cb
	jr z,L_44CF		;44cc
	inc b			;44ce
L_44CF:
	ld a,(00007h)		;44cf
	ld c,a			;44d2
	pop af			;44d3
L_44D4:
	out (c),a		;44d4
	dec d			;44d6
	jr nz,L_44D4		;44d7
	djnz L_44D4		;44d9
	pop de			;44db
	ret			;44dc
L_44DD:
	push bc			;44dd
	call L_4516		;44de
	ld a,(00006h)		;44e1
	ld c,a			;44e4
	in a,(c)		;44e5
	pop bc			;44e7
	ret			;44e8
L_44E9:
	push bc			;44e9
	push af			;44ea
	call vram_para_escribir		;44eb   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	ld a,(00007h)		;44ee
	ld c,a			;44f1
	pop af			;44f2
	out (c),a		;44f3
	pop bc			;44f5
	ret			;44f6
vram_para_escribir:		; prepara el V9938 para escribir en la VRAM
	push bc			;44f7
	ld a,(00007h)		;44f8
	inc a			;44fb
	ld c,a			;44fc
	ld a,h			;44fd
	rlca			;44fe
	rlca			;44ff
	and 003h		;4500
	di			;4502
	out (c),a		;4503
	ld a,08eh		;4505
	out (c),a		;4507
	ld a,l			;4509
	out (c),a		;450a
	ld a,h			;450c
	and 03fh		;450d
	or 040h		;450f
	out (c),a		;4511
	pop bc			;4513
	ei			;4514
	ret			;4515
L_4516:
	push bc			;4516
	ld a,(00007h)		;4517
	inc a			;451a
	ld c,a			;451b
	ld a,h			;451c
	rlca			;451d
	rlca			;451e
	and 003h		;451f
	di			;4521
	out (c),a		;4522
	ld a,08eh		;4524
	out (c),a		;4526
	ld a,l			;4528
	out (c),a		;4529
	ld a,h			;452b
	and 03fh		;452c
	out (c),a		;452e
	pop bc			;4530
	ei			;4531
	ret			;4532
rle_con_destino:		; descomprime a la VRAM un rle que lleva el destino delante
	ex de,hl			;4533
	ld e,(hl)			;4534
	inc hl			;4535
	ld d,(hl)			;4536
	inc hl			;4537
	ex de,hl			;4538
rle_a_la_vram:		; descomprime un rle a la VRAM
	call vram_para_escribir		;4539   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	ld a,(00007h)		;453c
	ld c,a			;453f
L_4540:
	ld a,(de)			;4540
	and a			;4541
	ret z			;4542
	inc de			;4543
	ld b,a			;4544
	and 07fh		;4545
	cp b			;4547
	jr z,L_4554		;4548
	and a			;454a
	jr z,rle_con_destino		;454b
	ex de,hl			;454d
	ld b,a			;454e
	otir		;454f
	ex de,hl			;4551
	jr L_4540		;4552
L_4554:
	ld a,(de)			;4554
	inc de			;4555
L_4556:
	out (c),a		;4556
	djnz L_4556		;4558
	jr L_4540		;455a
rle_vuelto_con_destino:		; como 0x4562, con el destino delante del rle
	ex de,hl			;455c
	ld e,(hl)			;455d
	inc hl			;455e
	ld d,(hl)			;455f
	inc hl			;4560
	ex de,hl			;4561
rle_vuelto:		; descomprime un rle a la VRAM de HL pasando por 0xDD10
	ld (0ee80h),hl		;4562
	ld hl,0dd10h		;4565
	exx			;4568
	ld hl,00000h		;4569
	exx			;456c
L_456D:
	ld a,(de)			;456d
	and a			;456e
	jr z,L_45B2		;456f
	inc de			;4571
	ld b,a			;4572
	and 07fh		;4573
	cp b			;4575
	jr z,L_458A		;4576
	and a			;4578
	jr z,rle_vuelto_con_destino		;4579
	ld b,a			;457b
L_457C:
	ld a,(de)			;457c
	call bits_al_reves		;457d   ; bits_al_reves: da la vuelta a los bits de A
	ld (hl),a			;4580
	inc hl			;4581
	inc de			;4582
	call L_4598		;4583
	djnz L_457C		;4586
	jr L_456D		;4588
L_458A:
	ld a,(de)			;458a
	call bits_al_reves		;458b   ; bits_al_reves: da la vuelta a los bits de A
L_458E:
	ld (hl),a			;458e
	inc hl			;458f
	call L_4598		;4590
	djnz L_458E		;4593
	inc de			;4595
	jr L_456D		;4596
L_4598:
	push af			;4598
	push bc			;4599
	exx			;459a
	inc hl			;459b
	ld a,l			;459c
	and 01fh		;459d
	exx			;459f
	ld bc,00020h		;45a0
	jr nz,L_45A8		;45a3
	add hl,bc			;45a5
	jr L_45AF		;45a6
L_45A8:
	cp 010h		;45a8
	jr nz,L_45AF		;45aa
	xor a			;45ac
	sbc hl,bc		;45ad
L_45AF:
	pop bc			;45af
	pop af			;45b0
	ret			;45b1
L_45B2:
	exx			;45b2
	push hl			;45b3
	exx			;45b4
	pop bc			;45b5
	ld hl,0dd00h		;45b6
	ld de,(0ee80h)		;45b9
	jp copia_a_la_vram		;45bd   ; copia_a_la_vram: copia bytes de la RAM a la VRAM
bits_al_reves:		; da la vuelta a los bits de A
	push bc			;45c0
	ld c,a			;45c1
	ld b,008h		;45c2
L_45C4:
	rr c		;45c4
	rla			;45c6
	djnz L_45C4		;45c7
	pop bc			;45c9
	ret			;45ca
L_45CB:
	call esconde_los_sprites		;45cb   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	ld bc,00000h		;45ce
	jr L_45D9		;45d1
borra_la_pantalla:		; borra la pantalla
	call esconde_los_sprites		;45d3   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	ld bc,000d4h		;45d6
L_45D9:
	push bc			;45d9
	call apaga_la_pantalla		;45da   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	pop bc			;45dd
	call L_45FB		;45de
enciende_la_pantalla:		; bit 6 del registro 1 del VDP a uno
	ld a,(0f3e0h)		;45e1
	or 040h		;45e4
	ld b,a			;45e6
	ld c,001h		;45e7
	call 00047h		;45e9   ; BIOS WRTVDP - Writes data in the VDP-register
	jr sprites_dentro		;45ec
apaga_la_pantalla:		; bit 6 del registro 1 del VDP a cero
	ld a,(0f3e0h)		;45ee
	and 0bfh		;45f1
	ld b,a			;45f3
	ld c,001h		;45f4
	call 00047h		;45f6   ; BIOS WRTVDP - Writes data in the VDP-register
	jr sprites_fuera		;45f9
L_45FB:
	ld hl,00000h		;45fb
	xor a			;45fe
	ld d,a			;45ff
	call hmmv		;4600   ; hmmv: orden HMMV del V9938: rellena un rectangulo
	ld b,000h		;4603
	ld c,017h		;4605
	jp 00047h		;4607   ; BIOS WRTVDP - Writes data in the VDP-register
esconde_los_sprites:		; y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	ld hl,0f600h		;460a
	ld a,0e0h		;460d
	ld bc,00080h		;460f
	call rellena_la_vram		;4612   ; rellena_la_vram: llena un tramo de la VRAM con un byte
	call 067dah		;4615   ; esconde_los_sprites_de_ram: saca de la pantalla los sprites de la copia en RAM
	ld hl,07600h		;4618
	ld a,0e0h		;461b
	ld bc,00080h		;461d
	call rellena_la_vram		;4620   ; rellena_la_vram: llena un tramo de la VRAM con un byte
	jp 067dah		;4623   ; esconde_los_sprites_de_ram: saca de la pantalla los sprites de la copia en RAM
sprites_fuera:		; apaga los sprites (bit 1 del registro 8 del VDP)
	ld a,(0ffe7h)		;4626
	or 002h		;4629
	ld b,a			;462b
	ld c,008h		;462c
	jp 00047h		;462e   ; BIOS WRTVDP - Writes data in the VDP-register
sprites_dentro:		; enciende los sprites (bit 1 del registro 8 del VDP a cero)
	ld a,(0ffe7h)		;4631
	and 0fdh		;4634
	ld b,a			;4636
	ld c,008h		;4637
	jp 00047h		;4639   ; BIOS WRTVDP - Writes data in the VDP-register
pon_un_color:		; color A de la paleta = DE
	push bc			;463c
	push hl			;463d
	ld b,a			;463e
	ld a,(00007h)		;463f
	inc a			;4642
	ld c,a			;4643
	di			;4644
	out (c),b		;4645
	ld a,090h		;4647
	out (c),a		;4649
	inc c			;464b
	out (c),d		;464c
	push af			;464e
	pop af			;464f
	out (c),e		;4650
	dec c			;4652
	ld hl,0f680h		;4653
	ld a,b			;4656
	add a,a			;4657
	add a,l			;4658
	ld l,a			;4659
	call vram_para_escribir		;465a   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	dec c			;465d
	out (c),d		;465e
	out (c),e		;4660
	pop hl			;4662
	pop bc			;4663
	ei			;4664
	ret			;4665
pon_paleta:		; pone una lista de colores en la paleta
	ld a,(hl)			;4666
	inc hl			;4667
	inc a			;4668
	ret z			;4669
	dec a			;466a
	ld d,(hl)			;466b
	inc hl			;466c
	ld e,(hl)			;466d
	inc hl			;466e
	call pon_un_color		;466f   ; pon_un_color: color A de la paleta = DE
	jr pon_paleta		;4672
espera_al_vdp:		; espera a que el V9938 acabe la orden
	ld a,002h		;4674
	call lee_estado_del_vdp		;4676   ; lee_estado_del_vdp: lee un registro de estado del V9938
	rra			;4679
	jr c,espera_al_vdp		;467a
	ret			;467c
lee_estado_del_vdp:		; lee un registro de estado del V9938
	push bc			;467d
	push hl			;467e
	ld hl,(00006h)		;467f
	inc h			;4682
	inc l			;4683
	ld c,h			;4684
	di			;4685
	out (c),a		;4686
	ld a,08fh		;4688
	out (c),a		;468a
	ld c,l			;468c
	in a,(c)		;468d
	push af			;468f
	xor a			;4690
	ld c,h			;4691
	out (c),a		;4692
	ld a,08fh		;4694
	out (c),a		;4696
	pop af			;4698
	pop hl			;4699
	pop bc			;469a
	ei			;469b
	ret			;469c
linea_horizontal:		; pinta una linea horizontal
	call espera_al_vdp		;469d   ; espera_al_vdp: espera a que el V9938 acabe la orden
	push bc			;46a0
	ld a,(00007h)		;46a1
	inc a			;46a4
	ld c,a			;46a5
	ld a,024h		;46a6
	di			;46a8
	out (c),a		;46a9
	ld a,091h		;46ab
	out (c),a		;46ad
	inc c			;46af
	inc c			;46b0
	out (c),h		;46b1
	xor a			;46b3
	out (c),a		;46b4
	out (c),l		;46b6
	out (c),a		;46b8
	pop hl			;46ba
	dec h			;46bb
	out (c),h		;46bc
	xor a			;46be
	out (c),a		;46bf
	xor a			;46c1
	out (c),a		;46c2
	out (c),a		;46c4
	out (c),l		;46c6
	out (c),a		;46c8
	ld a,070h		;46ca
	out (c),a		;46cc
	ei			;46ce
	ret			;46cf
linea_vertical:		; pinta una linea vertical
	call espera_al_vdp		;46d0   ; espera_al_vdp: espera a que el V9938 acabe la orden
	push bc			;46d3
	ld a,(00007h)		;46d4
	inc a			;46d7
	ld c,a			;46d8
	ld a,024h		;46d9
	di			;46db
	out (c),a		;46dc
	ld a,091h		;46de
	out (c),a		;46e0
	inc c			;46e2
	inc c			;46e3
	out (c),h		;46e4
	xor a			;46e6
	out (c),a		;46e7
	out (c),l		;46e9
	out (c),a		;46eb
	pop hl			;46ed
	dec h			;46ee
	out (c),h		;46ef
	xor a			;46f1
	out (c),a		;46f2
	xor a			;46f4
	out (c),a		;46f5
	out (c),a		;46f7
	out (c),l		;46f9
	inc a			;46fb
	out (c),a		;46fc
	ld a,070h		;46fe
	out (c),a		;4700
	ei			;4702
	ret			;4703
marco:		; pinta un marco
	ld b,e			;4704
	call L_471E		;4705
	ld b,d			;4708
	call L_4728		;4709
	push hl			;470c
	ld a,l			;470d
	dec a			;470e
	add a,e			;470f
	ld l,a			;4710
	ld b,d			;4711
	call L_4728		;4712
	pop hl			;4715
	ld a,h			;4716
	dec a			;4717
	add a,d			;4718
	ld h,a			;4719
	ld b,e			;471a
	jp L_471E		;471b
L_471E:
	push hl			;471e
	push de			;471f
	push bc			;4720
	call linea_vertical		;4721   ; linea_vertical: pinta una linea vertical
	pop bc			;4724
	pop de			;4725
	pop hl			;4726
	ret			;4727
L_4728:
	push hl			;4728
	push de			;4729
	push bc			;472a
	call linea_horizontal		;472b   ; linea_horizontal: pinta una linea horizontal
	pop bc			;472e
	pop de			;472f
	pop hl			;4730
	ret			;4731
hmmv:		; orden HMMV del V9938: rellena un rectangulo
	ex af,af'			;4732
	call espera_al_vdp		;4733   ; espera_al_vdp: espera a que el V9938 acabe la orden
	push bc			;4736
	ld a,(00007h)		;4737
	inc a			;473a
	ld c,a			;473b
	ld a,024h		;473c
	di			;473e
	out (c),a		;473f
	ld a,091h		;4741
	out (c),a		;4743
	inc c			;4745
	inc c			;4746
	out (c),h		;4747
	xor a			;4749
	out (c),a		;474a
	out (c),l		;474c
	out (c),d		;474e
	pop hl			;4750
	out (c),h		;4751
	cp h			;4753
	jr nz,L_4757		;4754
	inc a			;4756
L_4757:
	out (c),a		;4757
	xor a			;4759
	out (c),l		;475a
	cp l			;475c
	jr nz,L_4760		;475d
	inc a			;475f
L_4760:
	out (c),a		;4760
	ex af,af'			;4762
	out (c),a		;4763
	xor a			;4765
	out (c),a		;4766
	ld a,0c0h		;4768
	out (c),a		;476a
	ei			;476c
	ret			;476d
hmmm:		; orden HMMM del V9938: copia un rectangulo de VRAM a VRAM
	ex af,af'			;476e
	call espera_al_vdp		;476f   ; espera_al_vdp: espera a que el V9938 acabe la orden
	push bc			;4772
	ld a,(00007h)		;4773
	inc a			;4776
	ld c,a			;4777
	ld a,020h		;4778
	di			;477a
	out (c),a		;477b
	ld a,091h		;477d
	out (c),a		;477f
	inc c			;4781
	inc c			;4782
	out (c),h		;4783
	xor a			;4785
	out (c),a		;4786
	out (c),l		;4788
	ex af,af'			;478a
	ld l,a			;478b
	and 003h		;478c
	out (c),a		;478e
	out (c),d		;4790
	xor a			;4792
	out (c),a		;4793
	out (c),e		;4795
	ld a,l			;4797
	rra			;4798
	rra			;4799
	and 003h		;479a
	out (c),a		;479c
	pop hl			;479e
	out (c),h		;479f
	xor a			;47a1
	out (c),a		;47a2
	out (c),l		;47a4
	out (c),a		;47a6
	out (c),a		;47a8
	out (c),a		;47aa
	ld a,0d0h		;47ac
	out (c),a		;47ae
	ei			;47b0
	ret			;47b1
hmmc:		; orden HMMC del V9938: puntos de la RAM a la VRAM
	ex af,af'			;47b2
	call espera_al_vdp		;47b3   ; espera_al_vdp: espera a que el V9938 acabe la orden
	push bc			;47b6
	ld a,(00007h)		;47b7
	inc a			;47ba
	ld c,a			;47bb
	ld a,024h		;47bc
	di			;47be
	out (c),a		;47bf
	ld a,091h		;47c1
	out (c),a		;47c3
	inc c			;47c5
	inc c			;47c6
	out (c),d		;47c7
	xor a			;47c9
	out (c),a		;47ca
	out (c),e		;47cc
	ex af,af'			;47ce
	out (c),a		;47cf
	pop de			;47d1
	out (c),d		;47d2
	xor a			;47d4
	out (c),a		;47d5
	out (c),e		;47d7
	out (c),a		;47d9
	ld a,(hl)			;47db
	inc hl			;47dc
	out (c),a		;47dd
	xor a			;47df
	out (c),a		;47e0
	ld a,0f0h		;47e2
	out (c),a		;47e4
	dec c			;47e6
	dec c			;47e7
	ld a,0ach		;47e8
	out (c),a		;47ea
	ld a,091h		;47ec
	out (c),a		;47ee
	inc c			;47f0
	inc c			;47f1
L_47F2:
	ld a,002h		;47f2
	call lee_estado_del_vdp		;47f4   ; lee_estado_del_vdp: lee un registro de estado del V9938
	rra			;47f7
	ret nc			;47f8
	add a,a			;47f9
	add a,a			;47fa
	jr nc,L_47F2		;47fb
	ld a,(hl)			;47fd
	inc hl			;47fe
	out (c),a		;47ff
	jr L_47F2		;4801
lmmm:		; orden LMMM del V9938: copia un rectangulo con operacion logica
	ex af,af'			;4803
	call espera_al_vdp		;4804   ; espera_al_vdp: espera a que el V9938 acabe la orden
	push bc			;4807
	ld a,(00007h)		;4808
	inc a			;480b
	ld c,a			;480c
	ld a,020h		;480d
	di			;480f
	out (c),a		;4810
	ld a,091h		;4812
	out (c),a		;4814
	inc c			;4816
	inc c			;4817
	out (c),h		;4818
	xor a			;481a
	out (c),a		;481b
	out (c),l		;481d
	ex af,af'			;481f
	rlca			;4820
	rlca			;4821
	ld l,a			;4822
	and 003h		;4823
	out (c),a		;4825
	out (c),d		;4827
	xor a			;4829
	out (c),a		;482a
	out (c),e		;482c
	ld a,l			;482e
	ld e,a			;482f
	rlca			;4830
	rlca			;4831
	and 003h		;4832
	out (c),a		;4834
	pop hl			;4836
	out (c),h		;4837
	xor a			;4839
	out (c),a		;483a
	out (c),l		;483c
	out (c),a		;483e
	out (c),a		;4840
	out (c),a		;4842
	ld a,e			;4844
	rra			;4845
	rra			;4846
	and 00fh		;4847
	or 090h		;4849
	out (c),a		;484b
	ei			;484d
	ret			;484e
sube_letras:		; sube B letras a la VRAM
	call sube_una_letra		;484f   ; sube_una_letra: sube una letra a la VRAM
	call siguiente_sitio		;4852   ; siguiente_sitio: pasa al sitio del caracter siguiente
	djnz sube_letras		;4855
	ret			;4857
sube_una_letra:		; sube una letra a la VRAM
	push bc			;4858
	push de			;4859
	push hl			;485a
	push de			;485b
	call letra_a_4_bits		;485c   ; letra_a_4_bits: pasa una letra de 1 bit a 4 bits por punto
	pop de			;485f
	ld b,d			;4860
	ld d,e			;4861
	ld e,b			;4862
	srl d		;4863
	rr e		;4865
	ld a,d			;4867
	add a,080h		;4868
	ld d,a			;486a
	ld hl,0c210h		;486b
	call sube_un_dibujo		;486e   ; sube_un_dibujo: sube un dibujo de 8x8 a la VRAM
	pop hl			;4871
	ld bc,00008h		;4872
	add hl,bc			;4875
	pop de			;4876
	pop bc			;4877
	ret			;4878
sube_un_dibujo:		; sube un dibujo de 8x8 a la VRAM
	push de			;4879
	ld b,008h		;487a
L_487C:
	push bc			;487c
	ld bc,00004h		;487d
	call copia_a_la_vram		;4880   ; copia_a_la_vram: copia bytes de la RAM a la VRAM
	ex de,hl			;4883
	ld bc,00080h		;4884
	add hl,bc			;4887
	ex de,hl			;4888
	pop bc			;4889
	djnz L_487C		;488a
	pop de			;488c
	ret			;488d
sube_dibujos:		; sube B dibujos de 8x8 a la VRAM
	push bc			;488e
	call sube_un_dibujo		;488f   ; sube_un_dibujo: sube un dibujo de 8x8 a la VRAM
	ld a,004h		;4892
	add a,e			;4894
	cp 080h		;4895
	jr nz,L_489E		;4897
	ld a,004h		;4899
	add a,d			;489b
	ld d,a			;489c
	xor a			;489d
L_489E:
	ld e,a			;489e
	pop bc			;489f
	djnz sube_dibujos		;48a0
	ret			;48a2
sube_dibujos_de_16:		; sube dibujos de 16x16 a la VRAM
	push de			;48a3
	ld b,010h		;48a4
L_48A6:
	push bc			;48a6
	ld bc,00008h		;48a7
	call copia_a_la_vram		;48aa   ; copia_a_la_vram: copia bytes de la RAM a la VRAM
	ex de,hl			;48ad
	ld bc,00080h		;48ae
	add hl,bc			;48b1
	ex de,hl			;48b2
	pop bc			;48b3
	djnz L_48A6		;48b4
	pop de			;48b6
	ret			;48b7
sube_dibujos_de_16_vueltos:		; sube dibujos de 16x16 a la VRAM, vueltos
	push bc			;48b8
	call sube_dibujos_de_16		;48b9   ; sube_dibujos_de_16: sube dibujos de 16x16 a la VRAM
	ld a,008h		;48bc
	add a,e			;48be
	cp 080h		;48bf
	jr nz,L_48C8		;48c1
	ld a,008h		;48c3
	add a,d			;48c5
	ld d,a			;48c6
	xor a			;48c7
L_48C8:
	ld e,a			;48c8
	pop bc			;48c9
	djnz sube_dibujos_de_16_vueltos		;48ca
	ret			;48cc
letra_a_4_bits:		; pasa una letra de 1 bit a 4 bits por punto
	ld b,008h		;48cd
	ld de,0c210h		;48cf
L_48D2:
	push bc			;48d2
	push hl			;48d3
	ex de,hl			;48d4
	ld a,(de)			;48d5
	ld d,a			;48d6
	ld b,004h		;48d7
L_48D9:
	ld a,c			;48d9
	rl d		;48da
	jr c,L_48DF		;48dc
	xor a			;48de
L_48DF:
	rld		;48df
	ld a,c			;48e1
	rl d		;48e2
	jr c,L_48E7		;48e4
	xor a			;48e6
L_48E7:
	rld		;48e7
	inc hl			;48e9
	djnz L_48D9		;48ea
	ex de,hl			;48ec
	pop hl			;48ed
	inc hl			;48ee
	pop bc			;48ef
	djnz L_48D2		;48f0
	ret			;48f2
rotulo:		; pinta un rotulo
	ld c,0ffh		;48f3
	jr L_48F9		;48f5
borra_rotulo:		; borra un rotulo
	ld c,000h		;48f7
L_48F9:
	ld d,(hl)			;48f9
	inc hl			;48fa
	ld e,(hl)			;48fb
	inc hl			;48fc
rotulo_sin_posicion:		; pinta un rotulo donde se quedo el anterior
	ld a,(hl)			;48fd
	inc hl			;48fe
	ld b,a			;48ff
	inc b			;4900
	ret z			;4901
	inc b			;4902
	jr z,rotulo		;4903
	push af			;4905
	and c			;4906
	call letra		;4907   ; letra: pinta una letra
	pop af			;490a
	push bc			;490b
	sub 062h		;490c
	cp 002h		;490e
	ld b,008h		;4910
	jr nc,L_4916		;4912
	ld b,004h		;4914
L_4916:
	ld a,d			;4916
	add a,b			;4917
	ld d,a			;4918
	pop bc			;4919
	jr rotulo_sin_posicion		;491a
letra:		; pinta una letra
	push bc			;491c
	push hl			;491d
	push de			;491e
	or a			;491f
	ld h,a			;4920
	jr z,L_4928		;4921
	call sitio_del_caracter		;4923   ; sitio_del_caracter: la direccion en la VRAM de un caracter
	add a,038h		;4926
L_4928:
	ld l,a			;4928
	ld bc,00808h		;4929
	ld a,001h		;492c
	call hmmm		;492e   ; hmmm: orden HMMM del V9938: copia un rectangulo de VRAM a VRAM
	pop de			;4931
	pop hl			;4932
	pop bc			;4933
	ret			;4934
L_4935:
	push af			;4935
	call letra		;4936   ; letra: pinta una letra
	call siguiente_sitio		;4939   ; siguiente_sitio: pasa al sitio del caracter siguiente
	pop af			;493c
	djnz L_4935		;493d
	ret			;493f
caracter:		; pinta un caracter
	push bc			;4940
	push hl			;4941
	push de			;4942
	call sitio_del_caracter		;4943   ; sitio_del_caracter: la direccion en la VRAM de un caracter
	ld bc,00808h		;4946
	ld a,001h		;4949
	call hmmm		;494b   ; hmmm: orden HMMM del V9938: copia un rectangulo de VRAM a VRAM
	pop de			;494e
	pop hl			;494f
	pop bc			;4950
	ret			;4951
L_4952:
	push bc			;4952
	push hl			;4953
	push de			;4954
	call sitio_del_caracter		;4955   ; sitio_del_caracter: la direccion en la VRAM de un caracter
	ld bc,00808h		;4958
	ld a,048h		;495b
	call lmmm		;495d   ; lmmm: orden LMMM del V9938: copia un rectangulo con operacion logica
	pop de			;4960
	pop hl			;4961
	pop bc			;4962
	ret			;4963
caracter_en_la_pagina_1:		; pinta un caracter en la pagina 1 de la VRAM
	push bc			;4964
	push hl			;4965
	push de			;4966
	call sitio_del_caracter		;4967   ; sitio_del_caracter: la direccion en la VRAM de un caracter
	ld bc,00808h		;496a
	ld a,005h		;496d
	call hmmm		;496f   ; hmmm: orden HMMM del V9938: copia un rectangulo de VRAM a VRAM
	pop de			;4972
	pop hl			;4973
	pop bc			;4974
	ret			;4975
sitio_del_caracter:		; la direccion en la VRAM de un caracter
	ld b,a			;4976
	and 01fh		;4977
	add a,a			;4979
	add a,a			;497a
	add a,a			;497b
	ld h,a			;497c
	ld a,b			;497d
	and 0e0h		;497e
	rrca			;4980
	rrca			;4981
	ld l,a			;4982
	ret			;4983
siguiente_sitio:		; pasa al sitio del caracter siguiente
	ld a,d			;4984
	add a,008h		;4985
	ld d,a			;4987
	ret nz			;4988
	ld a,e			;4989
	add a,008h		;498a
	ld e,a			;498c
	ret			;498d
prepara_el_vdp:		; pasa a SCREEN 5 y pone los registros del V9938
	call sonido_a_cero		;498e   ; sonido_a_cero: para la musica y los efectos
	call sprites_fuera		;4991   ; sprites_fuera: apaga los sprites (bit 1 del registro 8 del VDP)
	ld a,005h		;4994
	call 0005fh		;4996   ; BIOS CHGMOD - Switches to given screen mode
	call apaga_la_pantalla		;4999   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	xor a			;499c
	ld h,a			;499d
	ld l,a			;499e
	ld b,a			;499f
	ld c,a			;49a0
	ld d,a			;49a1
	call hmmv		;49a2   ; hmmv: orden HMMV del V9938: rellena un rectangulo
	xor a			;49a5
	ld h,a			;49a6
	ld l,a			;49a7
	ld b,a			;49a8
	ld c,a			;49a9
	ld d,001h		;49aa
	call hmmv		;49ac   ; hmmv: orden HMMV del V9938: rellena un rectangulo
	call espera_al_vdp		;49af   ; espera_al_vdp: espera a que el V9938 acabe la orden
	ld b,004h		;49b2
	ld hl,049cah		;49b4
L_49B7:
	push bc			;49b7
	ld c,(hl)			;49b8
	inc hl			;49b9
	ld b,(hl)			;49ba
	inc hl			;49bb
	push hl			;49bc
	call 00047h		;49bd   ; BIOS WRTVDP - Writes data in the VDP-register
	pop hl			;49c0
	pop bc			;49c1
	djnz L_49B7		;49c2
	call esconde_los_sprites		;49c4   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	jp enciende_la_pantalla		;49c7   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno

; ----------------------------------------------------------------------
; DATOS registros_del_vdp: cuatro parejas [registro][valor] que p00:49B7
;   escribe con WRTVDP tras pasar a SCREEN 5: R1 = 0x62, R5 = 0xEF, R6 = 0x1F
;   y R11 = 0x01 (8 bytes)
;   0x49ca..0x49d2  (8 bytes)
DATA_registros_del_vdp:
	defb 001h,062h	; 49ca
	defb 005h,0efh	; 49cc
	defb 006h,01fh	; 49ce
	defb 00bh,001h	; 49d0

; ======================================================================
; CODIGO 0x49d2..0x4c4b  (633 bytes)
; ======================================================================


lee_los_mandos:		; teclado y mandos: 0xC00C lo apretado, 0xC00B lo nuevo
	ld a,(0c002h)		;49d2   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	and 040h		;49d5
	ret z			;49d7
	call L_4A37		;49d8
	ld hl,0c00ch		;49db   ; apunta a lo que esta apretado
	call L_49E7		;49de
	call L_49EE		;49e1
L_49E4:
	ld hl,0c007h		;49e4
L_49E7:
	ld c,(hl)			;49e7
	ld (hl),a			;49e8
	xor c			;49e9
	and (hl)			;49ea
	dec hl			;49eb
	ld (hl),a			;49ec
	ret			;49ed
L_49EE:
	ld e,08fh		;49ee
	ld a,00fh		;49f0
	call 00093h		;49f2   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;49f5
	di			;49f7
	call 00096h		;49f8   ; BIOS RDPSG - Reads value from PSG-register
	ei			;49fb
	cpl			;49fc
	and 03fh		;49fd
	push af			;49ff
	ld a,006h		;4a00
	call 00141h		;4a02   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4a05
	rlca			;4a06
	rlca			;4a07
	rlca			;4a08
	rlca			;4a09
	and 020h		;4a0a
	ld e,a			;4a0c
	ld a,008h		;4a0d
	call 00141h		;4a0f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4a12
	rrca			;4a13
	rrca			;4a14
	ld b,a			;4a15
	and 004h		;4a16
	or e			;4a18
	ld c,a			;4a19
	ld a,b			;4a1a
	rrca			;4a1b
	rrca			;4a1c
	ld b,a			;4a1d
	and 018h		;4a1e
	or c			;4a20
	ld c,a			;4a21
	ld a,b			;4a22
	rrca			;4a23
	and 003h		;4a24
	or c			;4a26
	ld e,a			;4a27
	ld a,002h		;4a28
	call 00141h		;4a2a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4a2d
	rrca			;4a2e
	rrca			;4a2f
	ld b,a			;4a30
	and 010h		;4a31
	or e			;4a33
	pop bc			;4a34
	or b			;4a35
	ret			;4a36
L_4A37:
	ld a,006h		;4a37
	call 00141h		;4a39   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4a3c
	rlca			;4a3d
	rlca			;4a3e
	rlca			;4a3f
	and 007h		;4a40
	ret			;4a42
dibujos_de_konami:		; sube los dibujos del logotipo de Konami
	call bancos_4_5_6		;4a43   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld hl,0bc92h		;4a46
	ld de,00800h		;4a49
	ld bc,00d01h		;4a4c
	call sube_letras		;4a4f   ; sube_letras: sube B letras a la VRAM
	ld hl,0bcfah		;4a52
	ld de,07000h		;4a55
	ld bc,00d02h		;4a58
	call sube_letras		;4a5b   ; sube_letras: sube B letras a la VRAM
	ld hl,0bd62h		;4a5e
	ld de,0d800h		;4a61
	ld bc,01a03h		;4a64
	call sube_letras		;4a67   ; sube_letras: sube B letras a la VRAM
	jp bancos_1_2_3		;4a6a   ; bancos_1_2_3: pone los bancos 1, 2 y 3
letras_del_texto:		; sube las letras de los textos
	call bancos_13_14_15		;4a6d   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld de,00040h		;4a70
	ld hl,0929dh		;4a73
	ld bc,0910eh		;4a76
	call sube_letras		;4a79   ; sube_letras: sube B letras a la VRAM
	ld de,08860h		;4a7c
	ld hl,09725h		;4a7f
	ld bc,00a03h		;4a82
	call sube_letras		;4a85   ; sube_letras: sube B letras a la VRAM
	ld hl,09775h		;4a88
	ld de,0b06ch		;4a8b
	ld b,003h		;4a8e
	call sube_dibujos		;4a90   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	jp bancos_1_2_3		;4a93   ; bancos_1_2_3: pone los bancos 1, 2 y 3
caracteres_del_juego:		; sube los caracteres del juego de graficos de la zona
	call bancos_4_5_6		;4a96   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld a,(0c289h)		;4a99   ; lee el juego de graficos de la zona
	add a,a			;4a9c
	ld hl,04c4bh		;4a9d
	call palabra_de_tabla		;4aa0   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ex de,hl			;4aa3
	ld hl,0d000h		;4aa4
	call rle_a_la_ram		;4aa7   ; rle_a_la_ram: descomprime un rle a la RAM
	ld a,(0c289h)		;4aaa   ; lee el juego de graficos de la zona
	cp 003h		;4aad
	jp z,L_4B15		;4aaf
	ld hl,0d000h		;4ab2
	ld de,08004h		;4ab5
	ld b,08ah		;4ab8
	call sube_dibujos		;4aba   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	call L_4C0E		;4abd
	ld a,(0c289h)		;4ac0   ; lee el juego de graficos de la zona
	cp 002h		;4ac3
	jr z,L_4ACA		;4ac5
	call sube_dibujos_vueltos		;4ac7   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
L_4ACA:
	call bancos_7_8_9		;4aca   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,06000h		;4acd
	ld de,09400h		;4ad0
	ld b,01eh		;4ad3
	call sube_dibujos		;4ad5   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	ld hl,061a0h		;4ad8
	ld de,09478h		;4adb
	ld b,011h		;4ade
	call sube_dibujos_vueltos		;4ae0   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	ld hl,063c0h		;4ae3
	ld de,0983ch		;4ae6
	ld b,02ah		;4ae9
	call sube_dibujos		;4aeb   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	ld a,(0c289h)		;4aee   ; lee el juego de graficos de la zona
	cp 005h		;4af1
	jr nz,L_4B12		;4af3
	ld b,004h		;4af5
	ld de,0941ch		;4af7
L_4AFA:
	push bc			;4afa
	ld hl,092d9h		;4afb
	ld a,b			;4afe
	cp 003h		;4aff
	jr nc,L_4B06		;4b01
	ld hl,092f9h		;4b03
L_4B06:
	push de			;4b06
	call sube_un_dibujo		;4b07   ; sube_un_dibujo: sube un dibujo de 8x8 a la VRAM
	pop de			;4b0a
	inc de			;4b0b
	inc de			;4b0c
	inc de			;4b0d
	inc de			;4b0e
	pop bc			;4b0f
	djnz L_4AFA		;4b10
L_4B12:
	jp bancos_1_2_3		;4b12   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4B15:
	ld hl,0d000h		;4b15
	ld de,08004h		;4b18
	ld b,00dh		;4b1b
	call sube_dibujos		;4b1d   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	ld hl,0d040h		;4b20
	ld de,08038h		;4b23
	ld b,00bh		;4b26
	call sube_dibujos_vueltos		;4b28   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	ld hl,0d1a0h		;4b2b
	ld de,08064h		;4b2e
	ld b,016h		;4b31
	call sube_dibujos		;4b33   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	ld hl,0d380h		;4b36
	ld de,0843ch		;4b39
	ld b,007h		;4b3c
	call sube_dibujos_vueltos		;4b3e   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	ld hl,0d460h		;4b41
	ld de,08458h		;4b44
	ld b,057h		;4b47
	call sube_dibujos		;4b49   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	ld hl,0dd60h		;4b4c
	ld de,09034h		;4b4f
	ld b,00fh		;4b52
	call sube_dibujos_vueltos		;4b54   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	call bancos_1_2_3		;4b57   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	jp L_4ACA		;4b5a
L_4B5D:
	call bancos_7_8_9		;4b5d   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,06820h		;4b60
	ld de,08004h		;4b63
	ld b,03bh		;4b66
	call sube_dibujos		;4b68   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	ld hl,06ac0h		;4b6b
	ld de,08800h		;4b6e
	ld b,025h		;4b71
	call sube_dibujos_vueltos		;4b73   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	call paleta_base		;4b76   ; paleta_base: pone la paleta base
	call bancos_7_8_9		;4b79   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a438h		;4b7c
	call pon_paleta		;4b7f   ; pon_paleta: pone una lista de colores en la paleta
	call bancos_10_11_12		;4b82   ; bancos_10_11_12: pone los bancos 10, 11 y 12
	ld hl,0f9c0h		;4b85
	ld de,084aah		;4b88
	call rle_a_la_vram		;4b8b   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4b8e   ; bancos_1_2_3: pone los bancos 1, 2 y 3
caracteres_del_titulo:		; sube los caracteres del titulo
	call bancos_4_5_6		;4b91   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld hl,0ae7ch		;4b94
	ld de,08004h		;4b97
	ld b,02eh		;4b9a
	call sube_dibujos		;4b9c   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	ld hl,0f800h		;4b9f
	ld de,0b43ch		;4ba2
	call rle_a_la_vram		;4ba5   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4ba8   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4BAB:
	call bancos_7_8_9		;4bab   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,08acch		;4bae
	ld de,08004h		;4bb1
	ld b,02eh		;4bb4
	call sube_dibujos		;4bb6   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	ld hl,0f800h		;4bb9
	ld de,08f4ch		;4bbc
	call rle_a_la_vram		;4bbf   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4bc2   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4BC5:
	call bancos_7_8_9		;4bc5   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0858ch		;4bc8
	ld de,08004h		;4bcb
	ld b,02eh		;4bce
	call sube_dibujos		;4bd0   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	ld hl,086ech		;4bd3
	ld de,0842ch		;4bd6
	ld b,01fh		;4bd9
	call sube_dibujos_vueltos		;4bdb   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	ld hl,0f800h		;4bde
	ld de,09810h		;4be1
	ld a,(0c002h)		;4be4   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	add a,a			;4be7
	jr nc,L_4BED		;4be8
	ld de,09df6h		;4bea
L_4BED:
	call rle_a_la_vram		;4bed   ; rle_a_la_vram: descomprime un rle a la VRAM
	ld hl,0f880h		;4bf0
	ld de,09fb0h		;4bf3
	call rle_a_la_vram		;4bf6   ; rle_a_la_vram: descomprime un rle a la VRAM
	ld hl,0fa00h		;4bf9
	ld de,09fb0h		;4bfc
	call rle_vuelto		;4bff   ; rle_vuelto: descomprime un rle a la VRAM de HL pasando por 0xDD10
	ld hl,0fb80h		;4c02
	ld de,0a10eh		;4c05
	call rle_a_la_vram		;4c08   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4c0b   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4C0E:
	ld a,(0c289h)		;4c0e   ; lee el juego de graficos de la zona
	ld b,a			;4c11
	add a,a			;4c12
	add a,a			;4c13
	add a,b			;4c14
	ld hl,04c57h		;4c15
	call hl_mas_a		;4c18   ; hl_mas_a: HL += A
	ld e,(hl)			;4c1b
	inc hl			;4c1c
	ld d,(hl)			;4c1d
	inc hl			;4c1e
	ld b,(hl)			;4c1f
	inc hl			;4c20
	ld a,(hl)			;4c21
	inc hl			;4c22
	ld h,(hl)			;4c23
	ld l,a			;4c24
	ret			;4c25
L_4C26:
	call bancos_4_5_6		;4c26   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld hl,0a7e0h		;4c29
	ld de,08004h		;4c2c
	ld b,01fh		;4c2f
	call sube_dibujos		;4c31   ; sube_dibujos: sube B dibujos de 8x8 a la VRAM
	ld hl,0a9c0h		;4c34
	ld de,08400h		;4c37
	ld b,010h		;4c3a
	call sube_dibujos_vueltos		;4c3c   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	ld hl,0f800h		;4c3f
	ld de,0abc0h		;4c42
	call rle_a_la_vram		;4c45   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4c48   ; bancos_1_2_3: pone los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; DATOS caracteres_de_cada_juego: 6 punteros, uno por juego de graficos
;   (0xC289), a sus caracteres de 8x8 en rle; p00:4AA7 los descomprime en
;   0xD000 (con los bancos 4-5-6); lo leen p00:4A9D (12 bytes)
;   0x4c4b..0x4c57  (12 bytes)
DATA_caracteres_de_cada_juego:
	defb 000h,060h,00eh,06bh,026h,078h,03ah,083h,05ah,08fh,0f3h,09bh	; 4c4b  .`.k&x:.Z...

; ----------------------------------------------------------------------
; DATOS caracteres_vueltos_de_cada_juego: 6 fichas de 5 bytes, una por juego
;   de graficos: [VRAM][n][fuente en 0xD000] de los caracteres que p00:4AC7
;   sube dados la vuelta (0x4C75); los juegos 2 y 3 van a cero; lo leen
;   p00:4C15 (30 bytes)
;   0x4c57..0x4c75  (30 bytes)
DATA_caracteres_vueltos_de_cada_juego:
	defb 050h,08ch,026h,0a0h,0d9h,07ch,08ch,006h,000h,0dfh,000h,000h,000h,000h,000h,000h	; 4c57  P.&..|..........
	defb 000h,000h,000h,000h,07ch,08ch,021h,0a0h,0dbh,000h,090h,015h,040h,0ddh	; 4c67  ....|.!.....@.

; ======================================================================
; CODIGO 0x4c75..0x4efc  (647 bytes)
; ======================================================================


sube_dibujos_vueltos:		; sube dibujos dados la vuelta
	push bc			;4c75
	push de			;4c76
	ld de,0ee83h		;4c77
	ld c,008h		;4c7a
L_4C7C:
	ld b,004h		;4c7c
L_4C7E:
	ld a,(hl)			;4c7e
	rrca			;4c7f
	rrca			;4c80
	rrca			;4c81
	rrca			;4c82
	ld (de),a			;4c83
	inc hl			;4c84
	dec de			;4c85
	djnz L_4C7E		;4c86
	ld a,008h		;4c88
	call de_mas_a		;4c8a   ; de_mas_a: DE += A
	dec c			;4c8d
	jr nz,L_4C7C		;4c8e
	pop de			;4c90
	push hl			;4c91
	ld hl,0ee80h		;4c92
	call sube_un_dibujo		;4c95   ; sube_un_dibujo: sube un dibujo de 8x8 a la VRAM
	pop hl			;4c98
	ld a,e			;4c99
	add a,004h		;4c9a
	ld e,a			;4c9c
	cp 080h		;4c9d
	jr nz,L_4CA7		;4c9f
	ld e,000h		;4ca1
	ld a,d			;4ca3
	add a,004h		;4ca4
	ld d,a			;4ca6
L_4CA7:
	pop bc			;4ca7
	djnz sube_dibujos_vueltos		;4ca8
	ret			;4caa
sprites_del_jugador:		; sube los sprites del jugador
	call bancos_7_8_9		;4cab   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld a,(0c002h)		;4cae   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	rla			;4cb1
	ld hl,09319h		;4cb2
	jr nc,L_4CBA		;4cb5
	ld hl,09341h		;4cb7
L_4CBA:
	ld a,(0c49fh)		;4cba   ; lee la accion del jugador
	add a,a			;4cbd
	add a,a			;4cbe
	ld b,a			;4cbf
	ld a,(0c4a2h)		;4cc0   ; lee el lado al que mira el jugador
	add a,b			;4cc3
	add a,a			;4cc4
	call hl_mas_a		;4cc5   ; hl_mas_a: HL += A
	ld e,(hl)			;4cc8
	inc hl			;4cc9
	ld d,(hl)			;4cca
	ld hl,0f800h		;4ccb
	call rle_a_la_vram		;4cce   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4cd1   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4CD4:
	call bancos_4_5_6		;4cd4   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld hl,0f800h		;4cd7
	ld de,0be32h		;4cda
	call rle_a_la_vram		;4cdd   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4ce0   ; bancos_1_2_3: pone los bancos 1, 2 y 3
paleta_de_la_zona:		; pone la paleta del juego de graficos de la zona
	call paleta_base		;4ce3   ; paleta_base: pone la paleta base
	call bancos_7_8_9		;4ce6   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a37ah		;4ce9
	ld a,(0c289h)		;4cec   ; lee el juego de graficos de la zona
	add a,a			;4cef
	call palabra_de_tabla		;4cf0   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	call pon_paleta		;4cf3   ; pon_paleta: pone una lista de colores en la paleta
	call bancos_1_2_3		;4cf6   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	jp colores_del_sitio		;4cf9   ; colores_del_sitio: cambia los colores del sitio (0xC267)
paleta_base:		; pone la paleta base
	call bancos_7_8_9		;4cfc   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a3e6h		;4cff
	call pon_paleta		;4d02   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d05   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4D08:
	call bancos_7_8_9		;4d08   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a3ffh		;4d0b
	call pon_paleta		;4d0e   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d11   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4D14:
	call bancos_7_8_9		;4d14   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	call pantalla_de_la_casilla		;4d17   ; pantalla_de_la_casilla: A = la pantalla de la casilla de 0xC281 (tabla de 0xE700)
	ld b,a			;4d1a
	call bancos_1_2_3		;4d1b   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	inc b			;4d1e
	ret nz			;4d1f
	call bancos_7_8_9		;4d20   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a42bh		;4d23
	call pon_paleta		;4d26   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d29   ; bancos_1_2_3: pone los bancos 1, 2 y 3
colores_del_sitio:		; cambia los colores del sitio (0xC267)
	call bancos_7_8_9		;4d2c   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld a,(0c289h)		;4d2f   ; lee el juego de graficos de la zona
	add a,a			;4d32
	ld hl,0a4c5h		;4d33
	call palabra_de_tabla		;4d36   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld a,(0c267h)		;4d39   ; lee los colores del sitio
	add a,a			;4d3c
	call palabra_de_tabla		;4d3d   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld a,(hl)			;4d40
	inc a			;4d41
	call nz,pon_paleta		;4d42   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d45   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4D48:
	call bancos_7_8_9		;4d48   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a44eh		;4d4b
	call pon_paleta		;4d4e   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d51   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4D54:
	call paleta_base		;4d54   ; paleta_base: pone la paleta base
	call bancos_7_8_9		;4d57   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a476h		;4d5a
	call pon_paleta		;4d5d   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d60   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4D63:
	call paleta_base		;4d63   ; paleta_base: pone la paleta base
	call bancos_7_8_9		;4d66   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a4b8h		;4d69
	call pon_paleta		;4d6c   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d6f   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4D72:
	call paleta_base		;4d72   ; paleta_base: pone la paleta base
	call bancos_7_8_9		;4d75   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a48fh		;4d78
	call pon_paleta		;4d7b   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d7e   ; bancos_1_2_3: pone los bancos 1, 2 y 3
palabra_de_tabla:		; HL = la palabra A de la tabla de HL
	call hl_mas_a		;4d81   ; hl_mas_a: HL += A
	ld a,(hl)			;4d84
	inc hl			;4d85
	ld h,(hl)			;4d86
	ld l,a			;4d87
	ret			;4d88
L_4D89:
	call bancos_7_8_9		;4d89   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0f8c0h		;4d8c
	ld de,09369h		;4d8f
	call rle_a_la_vram		;4d92   ; rle_a_la_vram: descomprime un rle a la VRAM
	call bancos_10_11_12		;4d95   ; bancos_10_11_12: pone los bancos 10, 11 y 12
	ld hl,0f900h		;4d98
	ld de,087d1h		;4d9b
	call rle_a_la_vram		;4d9e   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4da1   ; bancos_1_2_3: pone los bancos 1, 2 y 3
dibujos_de_siempre:		; sube los dibujos que estan en todas las zonas
	call bancos_7_8_9		;4da4   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,06f60h		;4da7
	ld de,0c000h		;4daa   ; apunta a el ESTADO del juego
	ld b,015h		;4dad
	call sube_dibujos_de_16_vueltos		;4daf   ; sube_dibujos_de_16_vueltos: sube dibujos de 16x16 a la VRAM, vueltos
	ld hl,079e0h		;4db2
	ld de,0c830h		;4db5
	ld b,004h		;4db8
	call sube_dibujos_de_16_vueltos		;4dba   ; sube_dibujos_de_16_vueltos: sube dibujos de 16x16 a la VRAM, vueltos
	ld hl,07be0h		;4dbd
	ld de,0c858h		;4dc0
	ld b,003h		;4dc3
	call sube_dibujos_de_16_vueltos		;4dc5   ; sube_dibujos_de_16_vueltos: sube dibujos de 16x16 a la VRAM, vueltos
	ld hl,07d60h		;4dc8
	ld de,000a0h		;4dcb
	ld bc,02003h		;4dce
	call hmmc_a_la_pagina_1		;4dd1   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,07d90h		;4dd4
	ld de,000a4h		;4dd7
	ld bc,00814h		;4dda
	call hmmc_a_la_pagina_1		;4ddd   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,07de0h		;4de0
	ld de,018a4h		;4de3
	ld bc,00814h		;4de6
	call hmmc_a_la_pagina_1		;4de9   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,07e30h		;4dec
	ld de,000b8h		;4def
	ld bc,02008h		;4df2
	call hmmc_a_la_pagina_1		;4df5   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,07eb0h		;4df8
	ld de,020a0h		;4dfb
	ld bc,02010h		;4dfe
	call hmmc_a_la_pagina_1		;4e01   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,07fb0h		;4e04
	ld de,020b0h		;4e07
	ld bc,0060fh		;4e0a
	call hmmc_a_la_pagina_1		;4e0d   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,07fddh		;4e10
	ld de,03ab0h		;4e13
	ld bc,0060fh		;4e16
	call hmmc_a_la_pagina_1		;4e19   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,0800ah		;4e1c
	ld bc,0161bh		;4e1f
	ld de,090a0h		;4e22
	call hmmc_a_la_pagina_1		;4e25   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,08413h		;4e28
	ld bc,01a1dh		;4e2b
	ld de,0c8a0h		;4e2e
	call hmmc_a_la_pagina_1		;4e31   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,08133h		;4e34
	ld de,0a8a0h		;4e37
	ld bc,00820h		;4e3a
	call hmmc_a_la_pagina_1		;4e3d   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,08233h		;4e40
	ld de,000c0h		;4e43
	ld bc,00c10h		;4e46
	call hmmc_a_la_pagina_1		;4e49   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,08293h		;4e4c
	ld de,010c0h		;4e4f
	ld bc,00810h		;4e52
	call hmmc_a_la_pagina_1		;4e55   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,082d3h		;4e58
	ld de,018c0h		;4e5b
	ld bc,02010h		;4e5e
	call hmmc_a_la_pagina_1		;4e61   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,083d3h		;4e64
	ld de,000d0h		;4e67
	ld bc,01008h		;4e6a
	call hmmc_a_la_pagina_1		;4e6d   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	ld hl,081b3h		;4e70
	ld de,0c0a0h		;4e73
	ld bc,00820h		;4e76
	call hmmc_a_la_pagina_1		;4e79   ; hmmc_a_la_pagina_1: HMMC a la pagina 1 de la VRAM
	jp bancos_1_2_3		;4e7c   ; bancos_1_2_3: pone los bancos 1, 2 y 3
hmmc_a_la_pagina_1:		; HMMC a la pagina 1 de la VRAM
	ld a,001h		;4e7f
	jp hmmc		;4e81   ; hmmc: orden HMMC del V9938: puntos de la RAM a la VRAM
pinta_bloque:		; pinta un bloque de 4x4 caracteres
	ld a,(0cd27h)		;4e84   ; lee la y de la pieza
	add a,e			;4e87
	ld e,a			;4e88
	ld a,(0cd28h)		;4e89   ; lee la x de la pieza
	add a,d			;4e8c
	ld d,a			;4e8d
L_4E8E:
	push bc			;4e8e
	pop hl			;4e8f
	push bc			;4e90
	ld bc,01010h		;4e91
	push de			;4e94
	ld a,048h		;4e95
	call lmmm		;4e97   ; lmmm: orden LMMM del V9938: copia un rectangulo con operacion logica
	pop de			;4e9a
	pop bc			;4e9b
	call marca_casilla		;4e9c   ; marca_casilla: marca una casilla en el plano
	ld a,008h		;4e9f
	add a,d			;4ea1
	ld d,a			;4ea2
	call marca_casilla		;4ea3   ; marca_casilla: marca una casilla en el plano
	ld a,0f8h		;4ea6
	add a,d			;4ea8
	ld d,a			;4ea9
	ld a,008h		;4eaa
	add a,e			;4eac
	ld e,a			;4ead
	call marca_casilla		;4eae   ; marca_casilla: marca una casilla en el plano
	ld a,008h		;4eb1
	add a,d			;4eb3
	ld d,a			;4eb4
	call marca_casilla		;4eb5   ; marca_casilla: marca una casilla en el plano
	ret			;4eb8
pinta_icono:		; copia un icono del marcador desde la pagina 1 (HMMM)
	inc a			;4eb9
	jr z,L_4ED7		;4eba
	dec a			;4ebc
	push af			;4ebd
	push de			;4ebe
	ld de,04efch		;4ebf
	call palabra_de_tabla_de		;4ec2   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;4ec5
	pop de			;4ec6
	pop af			;4ec7
	cp 00eh		;4ec8
	ld bc,02020h		;4eca
	jr z,L_4ED2		;4ecd
	ld bc,01010h		;4ecf
L_4ED2:
	ld a,001h		;4ed2
	jp hmmm		;4ed4   ; hmmm: orden HMMM del V9938: copia un rectangulo de VRAM a VRAM
L_4ED7:
	ld hl,00000h		;4ed7
	call L_4EEC		;4eda
	ld hl,00800h		;4edd
	call L_4EEC		;4ee0
	ld hl,0f808h		;4ee3
	call L_4EEC		;4ee6
	ld hl,00800h		;4ee9
L_4EEC:
	add hl,de			;4eec
	ex de,hl			;4eed
	ld hl,00000h		;4eee
L_4EF1:
	push de			;4ef1
	ld bc,00808h		;4ef2
	ld a,040h		;4ef5
	call lmmm		;4ef7   ; lmmm: orden LMMM del V9938: copia un rectangulo con operacion logica
	pop de			;4efa
	ret			;4efb

; ----------------------------------------------------------------------
; DATOS iconos_del_marcador: 21 parejas [x][y] en la pagina 1 de la VRAM de
;   los dibujos que p00:4EB9 copia con HMMM (0x476E): el 0x0E de 32x32 y el
;   resto de 16x16 (42 bytes)
;   0x4efc..0x4f26  (42 bytes)
DATA_iconos_del_marcador:
	defb 080h,050h	; 4efc
	defb 080h,0e0h	; 4efe
	defb 080h,0a0h	; 4f00
	defb 080h,0c0h	; 4f02
	defb 080h,0d0h	; 4f04
	defb 080h,060h	; 4f06
	defb 080h,0b0h	; 4f08
	defb 080h,070h	; 4f0a
	defb 080h,0f0h	; 4f0c
	defb 090h,000h	; 4f0e
	defb 090h,040h	; 4f10
	defb 080h,080h	; 4f12
	defb 080h,090h	; 4f14
	defb 000h,000h	; 4f16
	defb 0a0h,020h	; 4f18
	defb 000h,000h	; 4f1a
	defb 090h,020h	; 4f1c
	defb 090h,030h	; 4f1e
	defb 090h,010h	; 4f20
	defb 090h,080h	; 4f22
	defb 090h,090h	; 4f24

; ======================================================================
; CODIGO 0x4f26..0x50a3  (381 bytes)
; ======================================================================


marca_casilla:		; marca una casilla en el plano
	push de			;4f26
	push bc			;4f27
	ex de,hl			;4f28
	ld c,h			;4f29
	ld a,l			;4f2a
	sub 020h		;4f2b
	and 0f8h		;4f2d
	ld l,a			;4f2f
	ld h,000h		;4f30
	ld b,h			;4f32
	add hl,hl			;4f33
	add hl,hl			;4f34
	srl c		;4f35
	srl c		;4f37
	srl c		;4f39
	add hl,bc			;4f3b
	ld bc,0d800h		;4f3c
	add hl,bc			;4f3f
	ld a,(0cd2ah)		;4f40   ; lee la marca de 0xD800
	ld (hl),a			;4f43
	pop bc			;4f44
	pop de			;4f45
	ret			;4f46
pinta_pasadizo:		; pinta un pasadizo
	push af			;4f47
	call bancos_7_8_9		;4f48   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	xor a			;4f4b
	ld (0cd27h),a		;4f4c   ; guarda la y de la pieza
	ld (0cd28h),a		;4f4f   ; guarda la x de la pieza
	ld de,00020h		;4f52
	ld a,0ffh		;4f55
	call L_4F94		;4f57
	ld a,0ffh		;4f5a
	call L_4F94		;4f5c
	ld de,000c0h		;4f5f
	ld a,0ffh		;4f62
	call L_4F94		;4f64
	ld a,0ffh		;4f67
	call L_4F94		;4f69
	pop af			;4f6c
	add a,a			;4f6d
	ld l,a			;4f6e
	ld h,000h		;4f6f
	ld e,a			;4f71
	ld d,000h		;4f72
	add hl,hl			;4f74
	add hl,hl			;4f75
	add hl,hl			;4f76
	add hl,de			;4f77
	ld de,0ab18h		;4f78
	add hl,de			;4f7b
	ld de,00030h		;4f7c
	ld b,009h		;4f7f
L_4F81:
	ld a,(hl)			;4f81
	inc hl			;4f82
	call L_4F94		;4f83
	ld a,(hl)			;4f86
	inc hl			;4f87
	call L_4F94		;4f88
	ld a,010h		;4f8b
	add a,e			;4f8d
	ld e,a			;4f8e
	djnz L_4F81		;4f8f
	jp bancos_1_2_3		;4f91   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4F94:
	ld c,b			;4f94
	ld b,008h		;4f95
L_4F97:
	rla			;4f97
	push af			;4f98
	jr nc,L_4FAC		;4f99
	push de			;4f9b
	push hl			;4f9c
	push bc			;4f9d
	ld bc,00080h		;4f9e
	ld a,0ffh		;4fa1
	ld (0cd2ah),a		;4fa3   ; guarda la marca de 0xD800
	call pinta_bloque		;4fa6   ; pinta_bloque: pinta un bloque de 4x4 caracteres
	pop bc			;4fa9
	pop hl			;4faa
	pop de			;4fab
L_4FAC:
	ld a,010h		;4fac
	add a,d			;4fae
	ld d,a			;4faf
	pop af			;4fb0
	djnz L_4F97		;4fb1
	ld b,c			;4fb3
	ret			;4fb4
sonido_a_cero:		; para la musica y los efectos
	ld a,0bch		;4fb5
	ld (0c09fh),a		;4fb7   ; guarda la copia del registro 7 del PSG (el mezclador)
	xor a			;4fba
	ld (0c0a9h),a		;4fbb
	ld (0c0aah),a		;4fbe
	ld (0c0abh),a		;4fc1   ; guarda los canales que suenan
	ld (0c0b2h),a		;4fc4
L_4FC7:
	xor a			;4fc7
	ld (0c09eh),a		;4fc8
	ld (0c0adh),a		;4fcb   ; guarda la musica que suena
	ld (0c0a0h),a		;4fce
	ld (0c0ach),a		;4fd1
	ld hl,06067h		;4fd4
	ld (0c010h),hl		;4fd7   ; guarda el manejador del canal A del sonido
	ld (0c012h),hl		;4fda   ; guarda el manejador del canal B del sonido
	ld (0c014h),hl		;4fdd   ; guarda el manejador del canal C del sonido
	ld (0c016h),hl		;4fe0   ; guarda el manejador del efecto de sonido
	ret			;4fe3
sonido:		; arranca la musica o el efecto A
	push hl			;4fe4
	push de			;4fe5
	push bc			;4fe6
	push af			;4fe7
	di			;4fe8
	ld a,00ah		;4fe9
	ld (06000h),a		;4feb   ; el mapper: pone en 0x6000 el banco de A
	ld (0f0f1h),a		;4fee   ; guarda la copia del banco de 0x6000
	ei			;4ff1
	di			;4ff2
	ld a,00bh		;4ff3
	ld (08000h),a		;4ff5   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;4ff8   ; guarda la copia del banco de 0x8000
	ei			;4ffb
	di			;4ffc
	ld a,00ch		;4ffd
	ld (0a000h),a		;4fff   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;5002   ; guarda la copia del banco de 0xA000
	ei			;5005
	pop af			;5006
	di			;5007
	or a			;5008
	jp z,L_50F7		;5009
	cp 0fdh		;500c
	jp nc,L_50FD		;500e
	or a			;5011
	jp p,L_50BD		;5012
	ld (0c0adh),a		;5015   ; guarda la musica que suena
	ld a,(0c0afh)		;5018
	or a			;501b
	jr z,L_5031		;501c
	ld a,(0c0adh)		;501e   ; lee la musica que suena
	cp 082h		;5021
	jr c,L_5031		;5023
	cp 088h		;5025
	jr nc,L_5031		;5027
	ld a,001h		;5029
	ld (0c0b0h),a		;502b
	xor a			;502e
	jr L_5035		;502f
L_5031:
	xor a			;5031
	ld (0c0b0h),a		;5032
L_5035:
	ld (0c0b1h),a		;5035
	ld a,(0c0adh)		;5038   ; lee la musica que suena
	ld de,0c01ah		;503b
	ld hl,050a3h		;503e
	ld bc,0001ah		;5041
	ldir		;5044
	ld hl,050a3h		;5046
	ld bc,0001ah		;5049
	ldir		;504c
	ld hl,050a3h		;504e
	ld bc,0001ah		;5051
	ldir		;5054
	and 07fh		;5056
	rlca			;5058
	ld e,a			;5059
	rlca			;505a
	add a,e			;505b
	ld hl,06592h		;505c
	add a,l			;505f
	ld l,a			;5060
	jr nc,L_5064		;5061
	inc h			;5063
L_5064:
	ld e,(hl)			;5064
	inc hl			;5065
	ld d,(hl)			;5066
	inc hl			;5067
	ld (0c01ah),de		;5068
	ld e,(hl)			;506c
	inc hl			;506d
	ld d,(hl)			;506e
	inc hl			;506f
	ld (0c034h),de		;5070
	ld e,(hl)			;5074
	inc hl			;5075
	ld d,(hl)			;5076
	ld (0c04eh),de		;5077
	ld hl,060f4h		;507b
	ld (0c010h),hl		;507e   ; guarda el manejador del canal A del sonido
	ld hl,060fbh		;5081
	ld (0c012h),hl		;5084   ; guarda el manejador del canal B del sonido
	ld hl,06102h		;5087
	ld (0c014h),hl		;508a   ; guarda el manejador del canal C del sonido
L_508D:
	xor a			;508d
	ld (0c0a9h),a		;508e
	ld (0c0aah),a		;5091
	ld (0c0ach),a		;5094
	ld a,007h		;5097
	ld (0c0abh),a		;5099   ; guarda los canales que suenan
L_509C:
	call bancos_1_2_3		;509c   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	pop bc			;509f
	pop de			;50a0
	pop hl			;50a1
	ret			;50a2

; ----------------------------------------------------------------------
; DATOS canal_en_blanco: los 26 bytes con los que p00:5038-5054 y p00:50D3
;   ponen a cero la ficha de cada canal del sonido (0xC01A, 0xC034, 0xC04E,
;   0xC068 y 0xC082) antes de arrancar una musica o un efecto (26 bytes)
;   0x50a3..0x50bd  (26 bytes)
DATA_canal_en_blanco:
	defb 000h,000h,001h,000h,000h,000h,000h,000h,000h,001h,000h,000h,000h,000h,001h,001h	; 50a3  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 50b3  ..........

; ======================================================================
; CODIGO 0x50bd..0x54b8  (1019 bytes)
; ======================================================================


L_50BD:
	ld c,a			;50bd
	ld a,(0c0ach)		;50be
	or a			;50c1
	jp nz,L_509C		;50c2
	ld a,(0c09eh)		;50c5
	cp c			;50c8
	jp z,L_50CF		;50c9
	jp nc,L_509C		;50cc
L_50CF:
	ld a,c			;50cf
	ld (0c09eh),a		;50d0
	ld de,0c068h		;50d3
	ld hl,050a3h		;50d6
	ld bc,0001ah		;50d9
	ldir		;50dc
	rlca			;50de
	ld hl,06550h		;50df
	add a,l			;50e2
	ld l,a			;50e3
	jr nc,L_50E7		;50e4
	inc h			;50e6
L_50E7:
	ld e,(hl)			;50e7
	inc hl			;50e8
	ld d,(hl)			;50e9
	ld (0c074h),de		;50ea
	ld hl,06449h		;50ee
	ld (0c016h),hl		;50f1   ; guarda el manejador del efecto de sonido
	jp L_509C		;50f4
L_50F7:
	call L_4FC7		;50f7
	jp L_509C		;50fa
L_50FD:
	jp z,L_510D		;50fd
	cp 0feh		;5100
	jp z,L_518B		;5102
	ld a,03ah		;5105
	ld (0c0a9h),a		;5107
	jp L_509C		;510a
L_510D:
	ld a,001h		;510d
	ld (0c0a0h),a		;510f
	ld a,(0c0a9h)		;5112
	ld (0c0a1h),a		;5115
	ld a,(0c0aah)		;5118
	ld (0c0a2h),a		;511b
	ld a,(0c09fh)		;511e   ; lee la copia del registro 7 del PSG (el mezclador)
	ld (0c0a3h),a		;5121
	ld a,(0c0abh)		;5124   ; lee los canales que suenan
	ld (0c0aeh),a		;5127
	xor a			;512a
	ld (0c0abh),a		;512b   ; guarda los canales que suenan
	ld a,0bfh		;512e
	ld (0c09fh),a		;5130   ; guarda la copia del registro 7 del PSG (el mezclador)
	xor a			;5133
	call 00096h		;5134   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a4h),a		;5137
	ld a,001h		;513a
	call 00096h		;513c   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a5h),a		;513f
	ld a,008h		;5142
	call 00096h		;5144   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a6h),a		;5147
	ld a,009h		;514a
	call 00096h		;514c   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a7h),a		;514f
	ld a,00ah		;5152
	call 00096h		;5154   ; BIOS RDPSG - Reads value from PSG-register
	ld (0c0a8h),a		;5157
	ld a,009h		;515a
	ld e,000h		;515c
	call 00093h		;515e   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00ah		;5161
	ld e,000h		;5163
	call 00093h		;5165   ; BIOS WRTPSG - Writes data to PSG-register
	xor a			;5168
	ld (0c09ch),a		;5169
	ld a,004h		;516c
	ld (0c09dh),a		;516e
	ld hl,060edh		;5171
	ld (0c018h),hl		;5174   ; guarda el manejador del segundo efecto
	ld de,0c082h		;5177
	ld hl,050a3h		;517a
	ld bc,0001ah		;517d
	ldir		;5180
	ld hl,06b74h		;5182
	ld (0c082h),hl		;5185
	jp L_508D		;5188
L_518B:
	xor a			;518b
	ld (0c0a0h),a		;518c
	ld a,(0c0a1h)		;518f
	ld (0c0a9h),a		;5192
	ld a,(0c0a2h)		;5195
	ld (0c0aah),a		;5198
	ld a,(0c0a3h)		;519b
	ld (0c09fh),a		;519e   ; guarda la copia del registro 7 del PSG (el mezclador)
	ld a,(0c0aeh)		;51a1
	ld (0c0abh),a		;51a4   ; guarda los canales que suenan
	ld a,(0c0a4h)		;51a7
	ld e,a			;51aa
	xor a			;51ab
	call 00093h		;51ac   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a5h)		;51af
	ld e,a			;51b2
	ld a,001h		;51b3
	call 00093h		;51b5   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a6h)		;51b8
	ld e,a			;51bb
	ld a,008h		;51bc
	call 00093h		;51be   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a7h)		;51c1
	ld e,a			;51c4
	ld a,009h		;51c5
	call 00093h		;51c7   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a8h)		;51ca
	ld e,a			;51cd
	ld a,00ah		;51ce
	call 00093h		;51d0   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_509C		;51d3
suena_algo:		; lo que esta sonando (0xC0A9-0xC0AD)
	ld a,(0c0a9h)		;51d6
	or a			;51d9
	jr nz,L_51E4		;51da
	ld a,(0c0abh)		;51dc   ; lee los canales que suenan
	or a			;51df
	ld a,(0c0adh)		;51e0   ; lee la musica que suena
	ret			;51e3
L_51E4:
	ld a,(0c0aah)		;51e4
	cp 0f8h		;51e7
	ld a,(0c0adh)		;51e9   ; lee la musica que suena
	ret			;51ec
monta_la_pantalla:		; monta la pantalla de 8x6 bloques de la casilla
	call bancos_13_14_15		;51ed   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld a,(0c000h)		;51f0   ; lee el ESTADO del juego
	cp 008h		;51f3
	jp z,L_526D		;51f5
	cp 00bh		;51f8
	jp z,L_5272		;51fa
	ld a,(0c482h)		;51fd   ; lee la pantalla especial
	and a			;5200
	jr nz,L_525D		;5201
	xor a			;5203
	ld (0c28ah),a		;5204
	ld hl,0c500h		;5207
	ld de,0c501h		;520a
	ld (hl),a			;520d
	ld bc,0001fh		;520e
	ldir		;5211
	call pantalla_de_la_casilla		;5213   ; pantalla_de_la_casilla: A = la pantalla de la casilla de 0xC281 (tabla de 0xE700)
	ld hl,0ee80h		;5216
	ld (hl),000h		;5219
	cp 0ffh		;521b
	jr z,L_5262		;521d
	cp 017h		;521f
	push af			;5221
	jr nz,L_5232		;5222
	ld a,(0c289h)		;5224   ; lee el juego de graficos de la zona
	cp 004h		;5227
	jr nz,L_5232		;5229
	ld a,002h		;522b
	ld (0c28ah),a		;522d
	jr L_524B		;5230
L_5232:
	pop af			;5232
	push af			;5233
	cp 024h		;5234
	jr nz,L_5246		;5236
	ld a,(0c289h)		;5238   ; lee el juego de graficos de la zona
	cp 005h		;523b
	jr nz,L_5246		;523d
	ld a,003h		;523f
	ld (0c28ah),a		;5241
	jr L_524B		;5244
L_5246:
	pop af			;5246
	push af			;5247
	call L_5382		;5248
L_524B:
	pop af			;524b
	ld de,0d000h		;524c
	add a,a			;524f
	add a,a			;5250
	ld h,000h		;5251
	ld l,a			;5253
	add hl,hl			;5254
	add hl,hl			;5255
	ld b,h			;5256
	ld c,l			;5257
	add hl,hl			;5258
	add hl,bc			;5259
	add hl,de			;525a
	jr L_5275		;525b
L_525D:
	ld hl,07239h		;525d
	jr L_5275		;5260
L_5262:
	ld a,001h		;5262
	ld (hl),a			;5264
	ld (0c28ah),a		;5265
	ld hl,07419h		;5268
	jr L_5275		;526b
L_526D:
	ld hl,07549h		;526d
	jr L_5275		;5270
L_5272:
	ld hl,07581h		;5272
L_5275:
	ld de,0d800h		;5275
	ld a,(0c000h)		;5278   ; lee el ESTADO del juego
	cp 00bh		;527b
	ld a,006h		;527d
	jr nz,L_5283		;527f
	ld a,008h		;5281
L_5283:
	ex af,af'			;5283
	ld b,008h		;5284
L_5286:
	ld a,(hl)			;5286
	push de			;5287
	exx			;5288
	push af			;5289
	ld a,(0c000h)		;528a   ; lee el ESTADO del juego
	cp 008h		;528d
	jr z,L_52AB		;528f
	cp 00bh		;5291
	jr z,L_52B0		;5293
	ld a,(0c482h)		;5295   ; lee la pantalla especial
	and a			;5298
	jr nz,L_52A6		;5299
	ld a,(0ee80h)		;529b
	and a			;529e
	jr nz,L_52B5		;529f
	ld bc,0e100h		;52a1
	jr L_52B8		;52a4
L_52A6:
	ld bc,07269h		;52a6
	jr L_52B8		;52a9
L_52AB:
	ld bc,08eddh		;52ab
	jr L_52B8		;52ae
L_52B0:
	ld bc,08f9dh		;52b0
	jr L_52B8		;52b3
L_52B5:
	ld bc,07449h		;52b5
L_52B8:
	pop af			;52b8
	ld h,000h		;52b9
	ld l,a			;52bb
	add hl,hl			;52bc
	add hl,hl			;52bd
	add hl,hl			;52be
	add hl,hl			;52bf
	add hl,bc			;52c0
	ld bc,01cffh		;52c1
	pop de			;52c4
	ldi		;52c5
	ldi		;52c7
	ldi		;52c9
	ldi		;52cb
	ld a,b			;52cd
	add a,e			;52ce
	ld e,a			;52cf
	ldi		;52d0
	ldi		;52d2
	ldi		;52d4
	ldi		;52d6
	ld a,b			;52d8
	add a,e			;52d9
	ld e,a			;52da
	ldi		;52db
	ldi		;52dd
	ldi		;52df
	ldi		;52e1
	ld a,b			;52e3
	add a,e			;52e4
	ld e,a			;52e5
	ldi		;52e6
	ldi		;52e8
	ldi		;52ea
	ldi		;52ec
	exx			;52ee
	inc hl			;52ef
	inc de			;52f0
	inc de			;52f1
	inc de			;52f2
	inc de			;52f3
	dec b			;52f4
	jp nz,L_5286		;52f5
	ex de,hl			;52f8
	ld bc,00060h		;52f9
	add hl,bc			;52fc
	ex de,hl			;52fd
	ex af,af'			;52fe
	dec a			;52ff
	jp nz,L_5283		;5300
	jp bancos_1_2_3		;5303   ; bancos_1_2_3: pone los bancos 1, 2 y 3
pantalla_de_la_casilla:		; A = la pantalla de la casilla de 0xC281 (tabla de 0xE700)
	ld hl,0e700h		;5306
	ld a,(0c281h)		;5309   ; lee la CASILLA de la zona
	call hl_mas_a		;530c   ; hl_mas_a: HL += A
	ld a,(hl)			;530f
	ret			;5310
rejilla_de_la_zona:		; la rejilla de casillas de la zona
	call bancos_13_14_15		;5311   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	call indice_de_la_zona		;5314   ; indice_de_la_zona: A = (fase * 7 + zona) * 2
	ld hl,0600ch		;5317
	call palabra_de_tabla		;531a   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld de,0e700h		;531d
	ld a,(0c289h)		;5320   ; lee el juego de graficos de la zona
	sub 004h		;5323
	jr nc,L_5346		;5325
	ld b,040h		;5327
L_5329:
	ld a,(hl)			;5329
	and 0f0h		;532a
	rrca			;532c
	rrca			;532d
	rrca			;532e
	rrca			;532f
	cp 00fh		;5330
	jr nz,L_5336		;5332
	ld a,0ffh		;5334
L_5336:
	ld (de),a			;5336
	inc e			;5337
	ld a,(hl)			;5338
	and 00fh		;5339
	cp 00fh		;533b
	jr nz,L_5341		;533d
	ld a,0ffh		;533f
L_5341:
	ld (de),a			;5341
	inc e			;5342
	inc hl			;5343
	djnz L_5329		;5344
L_5346:
	ld bc,00080h		;5346
	ldir		;5349
	jp bancos_1_2_3		;534b   ; bancos_1_2_3: pone los bancos 1, 2 y 3
pinta_la_pantalla:		; pinta la pantalla montada
	ld hl,0d800h		;534e
	ld a,(0c000h)		;5351   ; lee el ESTADO del juego
	ld de,00000h		;5354
	cp 008h		;5357
	jr z,L_5361		;5359
	cp 00bh		;535b
	jr z,L_5361		;535d
	ld e,020h		;535f
L_5361:
	ld a,(0c000h)		;5361   ; lee el ESTADO del juego
	cp 00bh		;5364
	ld b,016h		;5366
	jr nz,L_536C		;5368
	ld b,01ah		;536a
L_536C:
	push bc			;536c
	ld b,020h		;536d
L_536F:
	ld a,(hl)			;536f
	call caracter		;5370   ; caracter: pinta un caracter
	inc hl			;5373
	ld a,d			;5374
	add a,008h		;5375
	ld d,a			;5377
	djnz L_536F		;5378
	pop bc			;537a
	ld a,e			;537b
	add a,008h		;537c
	ld e,a			;537e
	djnz L_536C		;537f
	ret			;5381
L_5382:
	ex af,af'			;5382
	ld hl,097d5h		;5383
	ld a,(0c289h)		;5386   ; lee el juego de graficos de la zona
	add a,a			;5389
	call palabra_de_tabla		;538a   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld de,0c500h		;538d
	ld b,(hl)			;5390
	ld a,b			;5391
	and a			;5392
	ret z			;5393
	inc hl			;5394
	ex af,af'			;5395
L_5396:
	push af			;5396
	cp (hl)			;5397
	jr nz,L_53B2		;5398
	push hl			;539a
	push de			;539b
	inc hl			;539c
	inc e			;539d
	ld a,(hl)			;539e
	and 0f0h		;539f
	ld (de),a			;53a1
	inc e			;53a2
	ld a,(hl)			;53a3
	rla			;53a4
	rla			;53a5
	rla			;53a6
	rla			;53a7
	and 0f0h		;53a8
	ld (de),a			;53aa
	pop de			;53ab
	ld hl,00010h		;53ac
	add hl,de			;53af
	ex de,hl			;53b0
	pop hl			;53b1
L_53B2:
	inc hl			;53b2
	inc hl			;53b3
	pop af			;53b4
	djnz L_5396		;53b5
	call indice_de_la_zona		;53b7   ; indice_de_la_zona: A = (fase * 7 + zona) * 2
	ld hl,0981dh		;53ba
	call palabra_de_tabla		;53bd   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld de,0c500h		;53c0
	ld b,(hl)			;53c3
	inc hl			;53c4
L_53C5:
	ld a,(0c281h)		;53c5   ; lee la CASILLA de la zona
	cp (hl)			;53c8
	jr nz,L_53DE		;53c9
	inc hl			;53cb
	ld a,(hl)			;53cc
	rla			;53cd
	jr nc,L_53D7		;53ce
	push hl			;53d0
	ld hl,00010h		;53d1
	add hl,de			;53d4
	ex de,hl			;53d5
	pop hl			;53d6
L_53D7:
	ld a,(hl)			;53d7
	and 07fh		;53d8
	ld (de),a			;53da
	inc hl			;53db
	jr L_53E0		;53dc
L_53DE:
	inc hl			;53de
	inc hl			;53df
L_53E0:
	djnz L_53C5		;53e0
	ret			;53e2
figura_del_interior:		; la figura de un interior (tipos 0x22-0x24)
	push af			;53e3
	call bancos_10_11_12		;53e4   ; bancos_10_11_12: pone los bancos 10, 11 y 12
	ld a,(0c002h)		;53e7   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	add a,a			;53ea
	ld de,0a783h		;53eb
	jr nc,L_53F3		;53ee
	ld de,0a7ddh		;53f0
L_53F3:
	ld hl,0f9c0h		;53f3
	call rle_a_la_vram		;53f6   ; rle_a_la_vram: descomprime un rle a la VRAM
	call bancos_13_14_15		;53f9   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld de,09f76h		;53fc
	ld hl,0fac0h		;53ff
	call rle_a_la_vram		;5402   ; rle_a_la_vram: descomprime un rle a la VRAM
	call bancos_10_11_12		;5405   ; bancos_10_11_12: pone los bancos 10, 11 y 12
	pop af			;5408
	ld de,054b8h		;5409
	call palabra_de_tabla_de		;540c   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld b,001h		;540f
	jr L_542E		;5411
dibujos_de_las_figuras:		; sube los dibujos de las figuras (fichas de 0xA830, banco 12)
	call figuras_de_la_casilla		;5413   ; figuras_de_la_casilla: crea las figuras de la casilla
	ld a,(de)			;5416
	inc a			;5417
	ld b,a			;5418
	inc de			;5419
	di			;541a
	ld a,00bh		;541b
	ld (08000h),a		;541d   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;5420   ; guarda la copia del banco de 0x8000
	ei			;5423
	di			;5424
	ld a,00ch		;5425
	ld (0a000h),a		;5427   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;542a   ; guarda la copia del banco de 0xA000
	ei			;542d
L_542E:
	push bc			;542e
	ld a,(de)			;542f
	or a			;5430
	jp z,L_54AF		;5431
	push de			;5434
	push af			;5435
	ld hl,0a998h		;5436
	ld b,008h		;5439
	ld d,a			;543b
L_543C:
	ld a,(hl)			;543c
	cp d			;543d
	jr z,L_544B		;543e
	ld a,005h		;5440
	add a,l			;5442
	ld l,a			;5443
	jr nc,L_5447		;5444
	inc h			;5446
L_5447:
	djnz L_543C		;5447
	jr L_5457		;5449
L_544B:
	inc hl			;544b
	ld e,(hl)			;544c
	inc hl			;544d
	ld d,(hl)			;544e
	inc hl			;544f
	ld a,(hl)			;5450
	inc hl			;5451
	ld h,(hl)			;5452
	ld l,a			;5453
	call rle_a_la_vram		;5454   ; rle_a_la_vram: descomprime un rle a la VRAM
L_5457:
	pop af			;5457
	pop de			;5458
	push de			;5459
	dec a			;545a
	ld l,a			;545b
	ld h,000h		;545c
	add hl,hl			;545e
	ld e,l			;545f
	ld d,h			;5460
	add hl,hl			;5461
	add hl,hl			;5462
	add hl,de			;5463
	ex de,hl			;5464
	ld hl,0a830h		;5465
	add hl,de			;5468
	push hl			;5469
	pop ix		;546a
	ld e,(ix+000h)		;546c
	ld d,(ix+001h)		;546f
	ld (0cd42h),de		;5472
	ld l,(ix+002h)		;5476
	ld h,(ix+003h)		;5479
	call rle_a_la_vram		;547c   ; rle_a_la_vram: descomprime un rle a la VRAM
	ld a,004h		;547f
	ld d,(ix+004h)		;5481
	ld e,a			;5484
	ld a,d			;5485
	cp 0ffh		;5486
	jr z,L_549C		;5488
	ld a,e			;548a
	ld e,(ix+005h)		;548b
	call pon_un_color		;548e   ; pon_un_color: color A de la paleta = DE
	ld a,006h		;5491
	ld d,(ix+006h)		;5493
	ld e,(ix+007h)		;5496
	call pon_un_color		;5499   ; pon_un_color: color A de la paleta = DE
L_549C:
	ld de,(0cd42h)		;549c
	ld a,(ix+008h)		;54a0
	cp 0ffh		;54a3
	jr z,L_54AE		;54a5
	ld l,a			;54a7
	ld h,(ix+009h)		;54a8
	call rle_vuelto		;54ab   ; rle_vuelto: descomprime un rle a la VRAM de HL pasando por 0xDD10
L_54AE:
	pop de			;54ae
L_54AF:
	inc de			;54af
	pop bc			;54b0
	dec b			;54b1
	jp nz,L_542E		;54b2
	jp bancos_1_2_3		;54b5   ; bancos_1_2_3: pone los bancos 1, 2 y 3

; ----------------------------------------------------------------------
; DATOS jefe_de_cada_fase: 21 punteros (p00:5409, el numero lo da p02:9282) a
;   la figura del jefe: un solo tipo; lo leen p00:540C (42 bytes)
;   0x54b8..0x54e2  (42 bytes)
DATA_jefe_de_cada_fase:
	defb 0e2h,054h,0e3h,054h,0e3h,054h,0e2h,054h,0e2h,054h,0e3h,054h,0e3h,054h,0e2h,054h	; 54b8  .T.T.T.T.T.T.T.T
	defb 0e2h,054h,0e3h,054h,0e3h,054h,0e2h,054h,0e2h,054h,0e3h,054h,0e3h,054h,0e2h,054h	; 54c8  .T.T.T.T.T.T.T.T
	defb 0e5h,054h,0e4h,054h,0e5h,054h,0e2h,054h,0e4h,054h	; 54d8  .T.T.T.T.T

; ----------------------------------------------------------------------
; DATOS jefes: los cuatro tipos a los que apunta 0x54B8: 0x22, 0x23, 0x24 y 0
;   (ninguno); lo leen p00:542F (4 bytes)
;   0x54e2..0x54e6  (4 bytes)
DATA_jefes:
	defb 022h,023h,024h,000h	; 54e2

; ======================================================================
; CODIGO 0x54e6..0x554e  (104 bytes)
; ======================================================================


colores_de_la_figura:		; pinta los colores de los sprites de la figura
	exx			;54e6
	ld de,0554eh		;54e7
	ld a,(0cd37h)		;54ea
	dec a			;54ed
	add a,a			;54ee
	bit 0,(ix+00ah)		;54ef
	jr z,L_54F6		;54f3
	inc a			;54f5
L_54F6:
	ex de,hl			;54f6
	add a,a			;54f7
	add a,l			;54f8
	ld l,a			;54f9
	jr nc,L_54FD		;54fa
	inc h			;54fc
L_54FD:
	ld a,(hl)			;54fd
	inc hl			;54fe
	ld h,(hl)			;54ff
	ld l,a			;5500
	ex de,hl			;5501
L_5502:
	exx			;5502
L_5503:
	set 5,l		;5503
	ld b,(hl)			;5505
	ld a,b			;5506
	and a			;5507
	ret z			;5508
	inc l			;5509
L_550A:
	push bc			;550a
	ld b,(hl)			;550b
	inc l			;550c
	inc l			;550d
	inc l			;550e
	inc l			;550f
	ex de,hl			;5510
	ld hl,07640h		;5511
	ld a,b			;5514
	add a,a			;5515
	add a,a			;5516
	add a,a			;5517
	ld c,a			;5518
	ld b,000h		;5519
	add hl,bc			;551b
	add hl,hl			;551c
	ld (0cd34h),hl		;551d
	ex de,hl			;5520
	ld a,(hl)			;5521
	ld b,010h		;5522
L_5524:
	ld (de),a			;5524
	inc e			;5525
	djnz L_5524		;5526
	exx			;5528
	call L_5532		;5529
	exx			;552c
	pop bc			;552d
	inc l			;552e
	djnz L_550A		;552f
	ret			;5531
L_5532:
	ld a,(0cd37h)		;5532
	or a			;5535
	ret z			;5536
L_5537:
	ld a,(de)			;5537
	inc de			;5538
	or a			;5539
	ret z			;553a
	ld b,a			;553b
	ld hl,(0cd34h)		;553c
	ld a,(de)			;553f
	inc de			;5540
	add a,l			;5541
	ld l,a			;5542
	jr nc,L_5546		;5543
	inc h			;5545
L_5546:
	ld a,(de)			;5546
L_5547:
	ld (hl),a			;5547
	inc hl			;5548
	djnz L_5547		;5549
	inc de			;554b
	jr L_5537		;554c

; ----------------------------------------------------------------------
; DATOS colores_de_cada_pose: 108 punteros, dos por cada uno de los 54 juegos
;   de color (0xCD37 - 1), el segundo para la figura mirando al otro lado (bit
;   0 de ix+0x0A) (p00:54E7); lo leen p00:54E7 (216 bytes)
;   0x554e..0x5626  (216 bytes)
DATA_colores_de_cada_pose:
	defb 02ch,056h,02ch,056h,02ch,056h,02eh,056h,026h,056h,026h,056h,02ch,056h,02ch,056h	; 554e  ,V,V,V.V&V&V,V,V
	defb 033h,056h,040h,056h,02ah,056h,02ah,056h,02ch,056h,02ch,056h,04bh,056h,04bh,056h	; 555e  3V@V*V*V,V,VKVKV
	defb 055h,056h,062h,056h,02ah,056h,02ah,056h,02ah,056h,02ah,056h,02ah,056h,02ah,056h	; 556e  UVbV*V*V*V*V*V*V
	defb 06fh,056h,06fh,056h,06fh,056h,06fh,056h,02ch,056h,02ch,056h,07ah,056h,07ah,056h	; 557e  oVoVoVoV,V,VzVzV
	defb 087h,056h,087h,056h,0a5h,057h,0a5h,057h,02ah,056h,02ah,056h,092h,056h,092h,056h	; 558e  .V.V.W.W*V*V.V.V
	defb 098h,056h,098h,056h,0a3h,056h,0b1h,056h,02ah,056h,02ah,056h,0bfh,056h,0cbh,056h	; 559e  .V.V.V.V*V*V.V.V
	defb 0d8h,056h,0eah,056h,0fch,056h,008h,057h,02ch,056h,02ch,056h,02ch,056h,02ch,056h	; 55ae  .V.V.V.W,V,V,V,V
	defb 0ach,057h,0bah,057h,013h,057h,024h,057h,036h,057h,04ah,057h,05fh,057h,06eh,057h	; 55be  .W.W.W$W6WJW_WnW
	defb 07dh,057h,07dh,057h,084h,057h,084h,057h,08bh,057h,08bh,057h,02ah,056h,02ah,056h	; 55ce  }W}W.W.W.W.W*V*V
	defb 02dh,056h,02dh,056h,02dh,056h,02dh,056h,02dh,056h,02dh,056h,02ch,056h,02ch,056h	; 55de  -V-V-V-V-V-V,V,V
	defb 02ch,056h,02ch,056h,02ch,056h,02ch,056h,02ch,056h,02ch,056h,095h,057h,095h,057h	; 55ee  ,V,V,V,V,V,V.W.W
	defb 026h,056h,026h,056h,026h,056h,026h,056h,02ah,056h,02ah,056h,02ch,056h,02ch,056h	; 55fe  &V&V&V&V*V*V,V,V
	defb 02ch,056h,02ch,056h,02ch,056h,02ch,056h,02ch,056h,02ch,056h,02ch,056h,02ch,056h	; 560e  ,V,V,V,V,V,V,V,V
	defb 02ch,056h,02ch,056h,09ah,057h,09ah,057h	; 561e  ,V,V.W.W

; ----------------------------------------------------------------------
; DATOS listas_de_color: las listas de color de las poses: cada entrada de
;   0x554E apunta a tantas listas seguidas como sprites tiene la figura
;   (ix+0x20, que pone p02:835C), y cada lista son tripletes [n][desde][color]
;   que p00:5537 pinta sobre los 16 bytes de color del sprite, con un 0 al
;   final; unas entradas empiezan dentro de las listas de otras. Lo ultimo
;   (desde 0x57BE, donde acaba la primera lista de la ultima entrada) solo lo
;   lee una pose con mas sprites; eso no esta medido; lo leen p00:5537 (468
;   bytes)
;   0x5626..0x57fa  (468 bytes)
DATA_listas_de_color:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,00ch,001h,000h,004h,001h,007h	; 5626  ................
	defb 001h,005h,00eh,000h,000h,001h,007h,00eh,000h,000h,005h,001h,007h,001h,006h,00eh	; 5636  ................
	defb 000h,000h,001h,008h,00eh,000h,000h,002h,003h,008h,003h,007h,008h,000h,000h,001h	; 5646  ................
	defb 005h,00eh,000h,000h,008h,001h,005h,001h,00eh,008h,000h,000h,001h,004h,00eh,000h	; 5656  ................
	defb 000h,008h,000h,005h,001h,00eh,008h,000h,000h,002h,001h,008h,000h,000h,001h,00ch	; 5666  ................
	defb 008h,000h,000h,000h,000h,001h,005h,00eh,000h,000h,002h,006h,00eh,002h,00ah,00eh	; 5676  ................
	defb 000h,001h,002h,00eh,001h,00fh,007h,000h,000h,00dh,000h,007h,000h,000h,000h,002h	; 5686  ................
	defb 006h,00eh,000h,000h,000h,000h,000h,001h,001h,003h,002h,002h,005h,000h,001h,005h	; 5696  ................
	defb 00eh,000h,000h,001h,005h,00eh,002h,00dh,00eh,000h,000h,000h,001h,006h,00eh,000h	; 56a6  ................
	defb 000h,004h,00bh,00eh,000h,000h,001h,006h,004h,000h,001h,005h,007h,000h,000h,002h	; 56b6  ................
	defb 008h,00eh,002h,00ch,00eh,000h,001h,005h,007h,000h,000h,002h,008h,00eh,002h,00dh	; 56c6  ................
	defb 00eh,000h,001h,004h,00eh,002h,00eh,005h,000h,000h,009h,000h,005h,001h,00eh,00eh	; 56d6  ................
	defb 000h,000h,000h,000h,001h,005h,00eh,000h,000h,006h,001h,005h,001h,009h,005h,001h	; 56e6  ................
	defb 00eh,00eh,000h,000h,000h,000h,002h,004h,007h,000h,000h,000h,000h,000h,003h,003h	; 56f6  ................
	defb 001h,000h,002h,003h,007h,000h,000h,000h,000h,000h,003h,004h,001h,000h,001h,006h	; 5706  ................
	defb 00ch,003h,00dh,00ch,000h,000h,001h,006h,007h,000h,000h,001h,008h,007h,000h,001h	; 5716  ................
	defb 005h,00ch,003h,00ch,00ch,000h,000h,001h,005h,007h,000h,000h,001h,008h,007h,000h	; 5726  ................
	defb 005h,000h,00eh,001h,008h,00eh,000h,000h,000h,003h,00ah,00eh,000h,002h,003h,008h	; 5736  ................
	defb 003h,005h,00eh,000h,005h,000h,00eh,001h,008h,00eh,000h,000h,000h,001h,00dh,00eh	; 5746  ................
	defb 000h,009h,001h,00eh,003h,00ah,008h,000h,000h,001h,004h,00eh,000h,000h,000h,001h	; 5756  ................
	defb 000h,00ch,000h,005h,004h,00eh,000h,000h,001h,005h,00eh,000h,000h,000h,002h,002h	; 5766  ................
	defb 00ch,000h,006h,001h,00eh,000h,000h,002h,004h,008h,001h,008h,00eh,000h,000h,000h	; 5776  ................
	defb 000h,002h,00dh,00eh,000h,002h,004h,008h,000h,000h,002h,00dh,00eh,000h,000h,004h	; 5786  ................
	defb 001h,00eh,000h,000h,002h,003h,00eh,001h,009h,00eh,003h,00bh,00eh,000h,000h,001h	; 5796  ................
	defb 003h,004h,000h,000h,000h,000h,002h,002h,004h,000h,000h,000h,006h,009h,008h,000h	; 57a6  ................
	defb 000h,000h,000h,000h,002h,002h,004h,000h,000h,000h,005h,009h,008h,000h,000h,000h	; 57b6  ................
	defb 000h,000h,001h,002h,004h,000h,000h,000h,004h,007h,008h,000h,000h,004h,007h,008h	; 57c6  ................
	defb 000h,000h,001h,008h,004h,000h,000h,001h,004h,006h,003h,006h,008h,000h,000h,001h	; 57d6  ................
	defb 004h,006h,003h,006h,008h,000h,000h,001h,003h,004h,000h,000h,000h,000h,00bh,001h	; 57e6  ................
	defb 001h,000h,000h,000h	; 57f6

; ======================================================================
; CODIGO 0x57fa..0x582a  (48 bytes)
; ======================================================================


pinta_cosa_del_marcador:		; pinta una de las 10 cosas del marcador
	cp 00ah		;57fa
	jr z,$+103		;57fc
	ld de,0582ah		;57fe
	ld hl,0c270h		;5801   ; apunta a las 10 cosas del marcador
	ld b,a			;5804
	call hl_mas_a		;5805   ; hl_mas_a: HL += A
	ld a,b			;5808
	call de_mas_a		;5809   ; de_mas_a: DE += A
	call L_5825		;580c
	ld a,b			;580f
	or a			;5810
	jr z,$+35		;5811
	cp 009h		;5813
	jr z,$+31		;5815
	ld c,a			;5817
	ld a,(hl)			;5818
	or a			;5819
	ld a,c			;581a
	jr z,L_5820		;581b
	jp pinta_icono		;581d   ; pinta_icono: copia un icono del marcador desde la pagina 1 (HMMM)
L_5820:
	ld a,0ffh		;5820
	jp pinta_icono		;5822   ; pinta_icono: copia un icono del marcador desde la pagina 1 (HMMM)
L_5825:
	ld a,(de)			;5825
	ld d,a			;5826
	ld e,010h		;5827
	ret			;5829

; ----------------------------------------------------------------------
; DATOS sitios_del_marcador: la x de cada una de las 10 cosas del marcador
;   (p00:57FE: 0xC270 + n dice si se tiene y p00:5825 pone esta x con y =
;   0x10) (10 bytes)
;   0x582a..0x5834  (10 bytes)
DATA_sitios_del_marcador:
	defb 008h,038h,048h,058h,068h,078h,088h,098h,0a8h,0c8h	; 582a  .8HXhx....

; ======================================================================
; CODIGO 0x5834..0x5bb2  (894 bytes)
; ======================================================================


L_5834:
	ld (0cd29h),a		;5834
	ld a,(hl)			;5837
	ld b,003h		;5838
	ld c,a			;583a
L_583B:
	dec c			;583b
	jp m,L_5852		;583c
	ld a,(0cd29h)		;583f
L_5842:
	push bc			;5842
	push hl			;5843
	push de			;5844
	call pinta_icono		;5845   ; pinta_icono: copia un icono del marcador desde la pagina 1 (HMMM)
	pop de			;5848
	pop hl			;5849
	pop bc			;584a
	ld a,010h		;584b
	add a,d			;584d
	ld d,a			;584e
	djnz L_583B		;584f
	ret			;5851
L_5852:
	ld a,0ffh		;5852
	jr L_5842		;5854
pinta_las_cosas:		; pinta las cosas del marcador
	xor a			;5856
	ld b,00ah		;5857
L_5859:
	push af			;5859
	push bc			;585a
	call pinta_cosa_del_marcador		;585b   ; pinta_cosa_del_marcador: pinta una de las 10 cosas del marcador
	pop bc			;585e
	pop af			;585f
	inc a			;5860
	djnz L_5859		;5861
L_5863:
	ld de,0b810h		;5863
	ld hl,0c27eh		;5866
	ld a,(hl)			;5869
	or a			;586a
	jr z,$-75		;586b
	ld hl,0c090h		;586d
	ld bc,01010h		;5870
	ld a,001h		;5873
	jp hmmm		;5875   ; hmmm: orden HMMM del V9938: copia un rectangulo de VRAM a VRAM
L_5878:
	ld hl,0c481h		;5878   ; apunta a la VIDA del jugador
	ld b,a			;587b
	ld a,(hl)			;587c
	dec hl			;587d
	sub b			;587e
	jr nc,L_588E		;587f
	xor a			;5881
	jr L_588E		;5882
suma_vida:		; suma vida al jugador
	ld hl,0c481h		;5884   ; apunta a la VIDA del jugador
	ld b,(hl)			;5887
	add a,b			;5888
	dec hl			;5889
	cp (hl)			;588a
	jr c,L_588E		;588b
	ld a,(hl)			;588d
L_588E:
	inc hl			;588e
	ld (hl),a			;588f
pinta_la_vida:		; pinta la barra de vida
	ld hl,0c480h		;5890   ; apunta a la vida maxima
	ld a,(0c002h)		;5893   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	add a,a			;5896
	jp m,L_589C		;5897
	ld (hl),010h		;589a
L_589C:
	ld b,(hl)			;589c
	ld hl,0c481h		;589d   ; apunta a la VIDA del jugador
	ld c,(hl)			;58a0
	ld de,0a008h		;58a1
L_58A4:
	dec c			;58a4
	jp m,L_58C0		;58a5
	ld hl,0d860h		;58a8
L_58AB:
	push bc			;58ab
	push de			;58ac
	ld bc,00208h		;58ad
	ld a,040h		;58b0
	call lmmm		;58b2   ; lmmm: orden LMMM del V9938: copia un rectangulo con operacion logica
	pop de			;58b5
	pop bc			;58b6
	ld a,002h		;58b7
	add a,d			;58b9
	ld d,a			;58ba
	djnz L_58A4		;58bb
	jp L_4485		;58bd
L_58C0:
	ld hl,0dc60h		;58c0
	jr L_58AB		;58c3
L_58C5:
	ld a,(0cd32h)		;58c5
	or a			;58c8
	ret nz			;58c9
	ld hl,0c482h		;58ca   ; apunta a la pantalla especial
	bit 0,(hl)		;58cd
	jr nz,pinta_el_tiempo		;58cf
	ld a,(0c490h)		;58d1   ; lee el estado del jugador
	cp 002h		;58d4
	jr nc,pinta_el_tiempo		;58d6
	ld hl,0c4b2h		;58d8
	dec (hl)			;58db
	ret nz			;58dc
	ld a,(0c288h)		;58dd   ; lee la FASE (0-6)
	ld b,a			;58e0
	add a,a			;58e1
	add a,a			;58e2
	add a,b			;58e3
	ld b,a			;58e4
	ld a,03ch		;58e5
	sub b			;58e7
	ld (hl),a			;58e8
	ld hl,0c4b0h		;58e9   ; apunta a el TIEMPO (BCD)
	ld de,00001h		;58ec
	call resta_bcd		;58ef   ; resta_bcd: resta en BCD
	call L_5900		;58f2
pinta_el_tiempo:		; pinta el tiempo
	ld hl,0c4b1h		;58f5
	ld de,04808h		;58f8
	ld b,002h		;58fb
	jp pinta_bcd		;58fd   ; pinta_bcd: pinta cifras en BCD
L_5900:
	ld hl,0c278h		;5900
	ld a,(hl)			;5903
	or a			;5904
	ret z			;5905
	ld hl,0c27ch		;5906
	dec (hl)			;5909
	ret nz			;590a
	ld hl,0c278h		;590b
	xor a			;590e
	ld (hl),a			;590f
	ld a,008h		;5910
	jp pinta_cosa_del_marcador		;5912   ; pinta_cosa_del_marcador: pinta una de las 10 cosas del marcador
resta_bcd:		; resta en BCD
	ld a,(hl)			;5915
	sub e			;5916
	daa			;5917
	ld (hl),a			;5918
	inc hl			;5919
	ld a,(hl)			;591a
	sbc a,d			;591b
	daa			;591c
	ld (hl),a			;591d
	ret			;591e
suma_bcd:		; suma en BCD
	ld a,(hl)			;591f
	add a,e			;5920
	daa			;5921
	ld (hl),a			;5922
	inc hl			;5923
	ld a,(hl)			;5924
	adc a,d			;5925
	daa			;5926
	ld (hl),a			;5927
	ret			;5928
suma_dinero:		; suma ryo al dinero
	ld d,000h		;5929
L_592B:
	ld hl,0c265h		;592b   ; apunta a el DINERO (ryo, BCD)
	call suma_bcd		;592e   ; suma_bcd: suma en BCD
	jr nc,pinta_el_dinero		;5931
	ld de,09999h		;5933
	ld (0c265h),de		;5936   ; guarda el DINERO (ryo, BCD)
pinta_el_dinero:		; pinta el dinero
	ld hl,0c266h		;593a
	ld de,07008h		;593d
	ld b,002h		;5940
	jp pinta_bcd		;5942   ; pinta_bcd: pinta cifras en BCD
L_5945:
	ld hl,0c4b0h		;5945   ; apunta a el TIEMPO (BCD)
	call suma_bcd		;5948   ; suma_bcd: suma en BCD
	cp 050h		;594b
	jr c,pinta_el_tiempo		;594d
	ld de,05000h		;594f
	ld (0c4b0h),de		;5952   ; guarda el TIEMPO (BCD)
	jr pinta_el_tiempo		;5956
resta_dinero:		; resta ryo al dinero
	ld hl,0c265h		;5958   ; apunta a el DINERO (ryo, BCD)
	call resta_bcd		;595b   ; resta_bcd: resta en BCD
	jr nc,pinta_el_dinero		;595e
	ld de,00000h		;5960
	ld (0c265h),de		;5963   ; guarda el DINERO (ryo, BCD)
	jr pinta_el_dinero		;5967
ensena_el_plano:		; ensena el plano de la zona
	ld a,001h		;5969
	ld (0cdb1h),a		;596b   ; guarda si se esta viendo el plano
	call 067dah		;596e   ; esconde_los_sprites_de_ram: saca de la pantalla los sprites de la copia en RAM
	di			;5971
	ld a,009h		;5972
	ld (0a000h),a		;5974   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;5977   ; guarda la copia del banco de 0xA000
	ei			;597a
	call dibuja_el_plano		;597b   ; dibuja_el_plano: dibuja el plano de la zona
	call bancos_1_2_3		;597e   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call apaga_la_pantalla		;5981   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call L_4B5D		;5984
	call L_598D		;5987
	jp enciende_la_pantalla		;598a   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
L_598D:
	call 0b936h		;598d
	call 0bc3ah		;5990
	call pinta_las_cosas		;5993   ; pinta_las_cosas: pinta las cosas del marcador
	call pinta_el_marcador		;5996   ; pinta_el_marcador: pinta el marcador entero
	call pinta_la_vida		;5999   ; pinta_la_vida: pinta la barra de vida
	call 098beh		;599c
	call 0b9cbh		;599f
	call 0b843h		;59a2
	call 098e3h		;59a5
	ret			;59a8
dibuja_el_plano:		; dibuja el plano de la zona
	ld a,(0c288h)		;59a9   ; lee la FASE (0-6)
	ld b,a			;59ac
	add a,a			;59ad
	add a,a			;59ae
	add a,a			;59af
	sub b			;59b0
	ld b,a			;59b1
	ld a,(0c280h)		;59b2   ; lee la ZONA (0-6)
	add a,b			;59b5
	ld de,0a575h		;59b6
	call palabra_de_tabla_de		;59b9   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld a,(de)			;59bc
	inc de			;59bd
	push de			;59be
	ld de,0a86dh		;59bf
	call palabra_de_tabla_de		;59c2   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld a,(de)			;59c5
	ld (0cdd3h),a		;59c6
	ld b,a			;59c9
	inc de			;59ca
	ld a,(de)			;59cb
	ld (0cdd4h),a		;59cc
	inc de			;59cf
	call L_59D7		;59d0
	pop de			;59d3
	jp L_5A10		;59d4
L_59D7:
	ld (0ee80h),a		;59d7
	add a,007h		;59da
	srl a		;59dc
	srl a		;59de
	srl a		;59e0
	ld (0ee81h),a		;59e2
	ld hl,0d800h		;59e5
L_59E8:
	push bc			;59e8
	ld a,(0ee81h)		;59e9
	ld b,a			;59ec
	ld a,(0ee80h)		;59ed
	ld c,a			;59f0
	push hl			;59f1
L_59F2:
	ld a,(de)			;59f2
	inc de			;59f3
	push bc			;59f4
	push de			;59f5
	call L_5A59		;59f6
	pop de			;59f9
	pop bc			;59fa
	ld c,a			;59fb
	djnz L_59F2		;59fc
	pop hl			;59fe
	ld a,01ch		;59ff
	call hl_mas_a		;5a01   ; hl_mas_a: HL += A
	pop bc			;5a04
	djnz L_59E8		;5a05
	ld a,001h		;5a07
	ld (0cdc6h),a		;5a09
	ld (0cdc7h),a		;5a0c
	ret			;5a0f
L_5A10:
	ld a,(de)			;5a10
	inc de			;5a11
	or a			;5a12
	ret z			;5a13
	ld c,a			;5a14
	and 01fh		;5a15
	ld l,a			;5a17
	ld a,(de)			;5a18
	inc de			;5a19
	ld h,a			;5a1a
	push bc			;5a1b
	push de			;5a1c
	call L_5A6A		;5a1d
	pop de			;5a20
	pop bc			;5a21
	ld a,c			;5a22
	srl a		;5a23
	srl a		;5a25
	srl a		;5a27
	srl a		;5a29
	srl a		;5a2b
	ld c,a			;5a2d
	push de			;5a2e
	call L_5A35		;5a2f
	pop de			;5a32
	jr L_5A10		;5a33
L_5A35:
	ld de,0c290h		;5a35
	ld b,00bh		;5a38
L_5A3A:
	push de			;5a3a
	push hl			;5a3b
	ex de,hl			;5a3c
	ld e,(hl)			;5a3d
	inc hl			;5a3e
	ld d,(hl)			;5a3f
	pop hl			;5a40
	push bc			;5a41
	rst 20h			;5a42
	pop bc			;5a43
	pop de			;5a44
	ret z			;5a45
	inc de			;5a46
	inc de			;5a47
	djnz L_5A3A		;5a48
	ld (hl),c			;5a4a
	ret			;5a4b
L_5A4C:
	ld b,a			;5a4c
	ld hl,00000h		;5a4d
	or a			;5a50
	ret z			;5a51
	ld de,0001ch		;5a52
L_5A55:
	add hl,de			;5a55
	djnz L_5A55		;5a56
	ret			;5a58
L_5A59:
	ld b,008h		;5a59
L_5A5B:
	rla			;5a5b
	ld d,001h		;5a5c
	jr c,L_5A62		;5a5e
	ld d,000h		;5a60
L_5A62:
	ld (hl),d			;5a62
	inc hl			;5a63
	dec c			;5a64
	ret z			;5a65
	djnz L_5A5B		;5a66
	ld a,c			;5a68
	ret			;5a69
L_5A6A:
	ld b,h			;5a6a
	ld a,b			;5a6b
	or a			;5a6c
	ld a,l			;5a6d
	ld hl,00000h		;5a6e
	jr z,L_5A79		;5a71
	ld de,0001ch		;5a73
L_5A76:
	add hl,de			;5a76
	djnz L_5A76		;5a77
L_5A79:
	call hl_mas_a		;5a79   ; hl_mas_a: HL += A
	ld de,0d800h		;5a7c
	add hl,de			;5a7f
	ret			;5a80
L_5A81:
	call borra_la_pantalla		;5a81   ; borra_la_pantalla: borra la pantalla
	ld bc,00007h		;5a84
	call 00047h		;5a87   ; BIOS WRTVDP - Writes data in the VDP-register
	call letras_del_texto		;5a8a   ; letras_del_texto: sube las letras de los textos
	call caracteres_del_titulo		;5a8d   ; caracteres_del_titulo: sube los caracteres del titulo
	jp L_4D48		;5a90
pantalla_del_titulo:		; monta la pantalla del titulo
	call L_5A81		;5a93
	call bancos_4_5_6		;5a96   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	call apaga_la_pantalla		;5a99   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	ld de,03020h		;5a9c
	ld hl,0b6b2h		;5a9f
	ld b,00ch		;5aa2
L_5AA4:
	push bc			;5aa4
	push de			;5aa5
	ld b,014h		;5aa6
L_5AA8:
	ld a,(hl)			;5aa8
	call caracter		;5aa9   ; caracter: pinta un caracter
	inc hl			;5aac
	ld a,d			;5aad
	add a,008h		;5aae
	ld d,a			;5ab0
	djnz L_5AA8		;5ab1
	pop de			;5ab3
	pop bc			;5ab4
	ld a,e			;5ab5
	add a,008h		;5ab6
	ld e,a			;5ab8
	djnz L_5AA4		;5ab9
	ld hl,0b7a2h		;5abb
	ld de,0ee00h		;5abe
	ld bc,01700h		;5ac1
L_5AC4:
	ld a,(hl)			;5ac4
	ld (de),a			;5ac5
	inc hl			;5ac6
	inc de			;5ac7
	ld a,(hl)			;5ac8
	ld (de),a			;5ac9
	inc hl			;5aca
	inc de			;5acb
	ld a,c			;5acc
	add a,a			;5acd
	add a,a			;5ace
	ld (de),a			;5acf
	inc c			;5ad0
	inc de			;5ad1
	inc de			;5ad2
	djnz L_5AC4		;5ad3
	ld hl,0ec00h		;5ad5
	ld de,0ec01h		;5ad8
	ld bc,00080h		;5adb
	ld (hl),005h		;5ade
	ldir		;5ae0
	ld hl,0ec70h		;5ae2
	ld de,0ec71h		;5ae5
	ld bc,00100h		;5ae8
	ld (hl),004h		;5aeb
	ldir		;5aed
	call sube_colores_de_sprite		;5aef   ; sube_colores_de_sprite: sube los colores de los sprites
	call enciende_la_pantalla		;5af2   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	call bancos_1_2_3		;5af5   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ld hl,04490h		;5af8
	ld c,00eh		;5afb
	ld de,07430h		;5afd
	call marco		;5b00   ; marco: pinta un marco
	ld hl,0639bh		;5b03
	jp rotulo		;5b06   ; rotulo: pinta un rotulo
L_5B09:
	ld a,(0c490h)		;5b09   ; lee el estado del jugador
	cp 002h		;5b0c
	jr nc,sube_colores_de_sprite		;5b0e
	ld hl,000e8h		;5b10
	ld d,h			;5b13
	ld e,l			;5b14
	ld bc,00005h		;5b15
	ld a,004h		;5b18
	jp hmmm		;5b1a   ; hmmm: orden HMMM del V9938: copia un rectangulo de VRAM a VRAM
L_5B1D:
	ld hl,0c25fh		;5b1d
	ld a,(hl)			;5b20
	add a,068h		;5b21
	and 078h		;5b23
	ld (hl),a			;5b25
	ld a,(00007h)		;5b26
	ld c,a			;5b29
	call L_5B47		;5b2a
	ld hl,07600h		;5b2d
	call vram_para_escribir		;5b30   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	ld a,(0c25fh)		;5b33
	ld d,010h		;5b36
	ld h,0eeh		;5b38
L_5B3A:
	ld b,008h		;5b3a
	ld l,a			;5b3c
	otir		;5b3d
	add a,048h		;5b3f
	and 078h		;5b41
	dec d			;5b43
	jr nz,L_5B3A		;5b44
	ret			;5b46
L_5B47:
	ld hl,07400h		;5b47
	call vram_para_escribir		;5b4a   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	ld a,(0c25fh)		;5b4d
	ld d,010h		;5b50
	add a,a			;5b52
L_5B53:
	ld h,076h		;5b53
	ld l,a			;5b55
	add hl,hl			;5b56
	ld b,020h		;5b57
	otir		;5b59
	add a,090h		;5b5b
	dec d			;5b5d
	jr nz,L_5B53		;5b5e
	ret			;5b60
sube_colores_de_sprite:		; sube los colores de los sprites
	ld hl,0ec00h		;5b61
	ld de,0f400h		;5b64
	ld bc,00280h		;5b67
	jp copia_a_la_vram		;5b6a   ; copia_a_la_vram: copia bytes de la RAM a la VRAM
figuras_de_la_casilla:		; crea las figuras de la casilla
	call bancos_13_14_15		;5b6d   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld de,09bf0h		;5b70
	ld a,(0c288h)		;5b73   ; lee la FASE (0-6)
	ld b,a			;5b76
	add a,a			;5b77
	ld c,a			;5b78
	add a,a			;5b79
	add a,c			;5b7a
	add a,b			;5b7b
	add a,a			;5b7c
	add a,e			;5b7d
	ld e,a			;5b7e
	jr nc,L_5B82		;5b7f
	inc d			;5b81
L_5B82:
	ld a,(0c280h)		;5b82   ; lee la ZONA (0-6)
	call palabra_de_tabla_de		;5b85   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld a,(0c281h)		;5b88   ; lee la CASILLA de la zona
	srl a		;5b8b
	call de_mas_a		;5b8d   ; de_mas_a: DE += A
	ld a,(0c281h)		;5b90   ; lee la CASILLA de la zona
	and 001h		;5b93
	ld a,(de)			;5b95
	jr nz,L_5B9C		;5b96
	rra			;5b98
	rra			;5b99
	rra			;5b9a
	rra			;5b9b
L_5B9C:
	and 00fh		;5b9c
	ld (0cd2ch),a		;5b9e
	push af			;5ba1
	call bancos_1_2_3		;5ba2   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ld a,(0c289h)		;5ba5   ; lee el juego de graficos de la zona
	ld de,05bb2h		;5ba8
	call palabra_de_tabla_de		;5bab   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	pop af			;5bae
	jp palabra_de_tabla_de		;5baf   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE

; ----------------------------------------------------------------------
; DATOS conjuntos_de_cada_juego: 6 punteros, uno por juego de graficos
;   (0xC289), a sus conjuntos de figuras (p00:5BA8); lo leen p00:5BA8 (12
;   bytes)
;   0x5bb2..0x5bbe  (12 bytes)
DATA_conjuntos_de_cada_juego:
	defb 0beh,05bh,0deh,05bh,0f6h,05bh,014h,05ch,02ch,05ch,048h,05ch	; 5bb2  .[.[.[.\,\H\

; ----------------------------------------------------------------------
; DATOS conjuntos_juego_0: 16 punteros, uno por conjunto de figuras del juego
;   0, a su lista (p00:5BAF); lo leen p00:5BAF (32 bytes)
;   0x5bbe..0x5bde  (32 bytes)
DATA_conjuntos_juego_0:
	defb 066h,05ch,06ah,05ch,06eh,05ch,073h,05ch,077h,05ch,07bh,05ch,07fh,05ch,084h,05ch	; 5bbe  f\j\n\s\w\{\.\.\
	defb 088h,05ch,08ch,05ch,090h,05ch,095h,05ch,099h,05ch,09dh,05ch,0a1h,05ch,0a7h,05ch	; 5bce  .\.\.\.\.\.\.\.\

; ----------------------------------------------------------------------
; DATOS conjuntos_juego_1: 12 punteros, uno por conjunto de figuras del juego
;   1, a su lista (p00:5BAF); lo leen p00:5BAF (24 bytes)
;   0x5bde..0x5bf6  (24 bytes)
DATA_conjuntos_juego_1:
	defb 0abh,05ch,0aeh,05ch,0b2h,05ch,0b6h,05ch,0bah,05ch,0beh,05ch,0c2h,05ch,0c6h,05ch	; 5bde  .\.\.\.\.\.\.\.\
	defb 0cah,05ch,0ceh,05ch,0d3h,05ch,0d8h,05ch	; 5bee  .\.\.\.\

; ----------------------------------------------------------------------
; DATOS conjuntos_juego_2: 15 punteros, uno por conjunto de figuras del juego
;   2, a su lista (p00:5BAF); lo leen p00:5BAF (30 bytes)
;   0x5bf6..0x5c14  (30 bytes)
DATA_conjuntos_juego_2:
	defb 0dch,05ch,0e0h,05ch,0e4h,05ch,0e8h,05ch,0ech,05ch,0f0h,05ch,0f4h,05ch,0f9h,05ch	; 5bf6  .\.\.\.\.\.\.\.\
	defb 0fdh,05ch,001h,05dh,006h,05dh,00ah,05dh,00eh,05dh,013h,05dh,017h,05dh	; 5c06  .\.].].].].].]

; ----------------------------------------------------------------------
; DATOS conjuntos_juego_3: 12 punteros, uno por conjunto de figuras del juego
;   3, a su lista (p00:5BAF); lo leen p00:5BAF (24 bytes)
;   0x5c14..0x5c2c  (24 bytes)
DATA_conjuntos_juego_3:
	defb 01dh,05dh,021h,05dh,025h,05dh,029h,05dh,02dh,05dh,031h,05dh,035h,05dh,039h,05dh	; 5c14  .]!]%])]-]1]5]9]
	defb 03dh,05dh,041h,05dh,045h,05dh,048h,05dh	; 5c24  =]A]E]H]

; ----------------------------------------------------------------------
; DATOS conjuntos_juego_4: 13 punteros, uno por conjunto de figuras del juego
;   4, a su lista (p00:5BAF); lo leen p00:5BAF (26 bytes)
;   0x5c2c..0x5c46  (26 bytes)
DATA_conjuntos_juego_4:
	defb 04bh,05dh,04fh,05dh,054h,05dh,058h,05dh,05ch,05dh,061h,05dh,065h,05dh,069h,05dh	; 5c2c  K]O]T]X]\]a]e]i]
	defb 06dh,05dh,071h,05dh,075h,05dh,079h,05dh,07dh,05dh	; 5c3c  m]q]u]y]}]

; ----------------------------------------------------------------------
; DATOS conjunto_13_juego_4: un decimocuarto puntero de los conjuntos del
;   juego 4 (0x5D81); ninguna casilla de las zonas de ese juego pide el 13 (2
;   bytes)
;   0x5c46..0x5c48  (2 bytes)
DATA_conjunto_13_juego_4:
	defb 081h,05dh	; 5c46

; ----------------------------------------------------------------------
; DATOS conjuntos_juego_5: 15 punteros, uno por conjunto de figuras del juego
;   5, a su lista (p00:5BAF); lo leen p00:5BAF (30 bytes)
;   0x5c48..0x5c66  (30 bytes)
DATA_conjuntos_juego_5:
	defb 085h,05dh,088h,05dh,08bh,05dh,08fh,05dh,093h,05dh,096h,05dh,099h,05dh,09dh,05dh	; 5c48  .].].].].].].].]
	defb 0a0h,05dh,0a4h,05dh,0a7h,05dh,0abh,05dh,0afh,05dh,0b3h,05dh,0b7h,05dh	; 5c58  .].].].].].].]

; ----------------------------------------------------------------------
; DATOS figuras_5C66: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c66..0x5c6a  (4 bytes)
DATA_figuras_5C66:
	defb 002h,002h,011h,00bh	; 5c66

; ----------------------------------------------------------------------
; DATOS figuras_5C6A: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c6a..0x5c6e  (4 bytes)
DATA_figuras_5C6A:
	defb 002h,006h,005h,00bh	; 5c6a

; ----------------------------------------------------------------------
; DATOS figuras_5C6E: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (5 bytes)
;   0x5c6e..0x5c73  (5 bytes)
DATA_figuras_5C6E:
	defb 003h,000h,009h,011h,00bh	; 5c6e

; ----------------------------------------------------------------------
; DATOS figuras_5C73: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c73..0x5c77  (4 bytes)
DATA_figuras_5C73:
	defb 002h,008h,005h,00ch	; 5c73

; ----------------------------------------------------------------------
; DATOS figuras_5C77: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c77..0x5c7b  (4 bytes)
DATA_figuras_5C77:
	defb 002h,005h,011h,00ch	; 5c77

; ----------------------------------------------------------------------
; DATOS figuras_5C7B: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c7b..0x5c7f  (4 bytes)
DATA_figuras_5C7B:
	defb 002h,006h,009h,00ch	; 5c7b

; ----------------------------------------------------------------------
; DATOS figuras_5C7F: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (5 bytes)
;   0x5c7f..0x5c84  (5 bytes)
DATA_figuras_5C7F:
	defb 003h,005h,011h,010h,018h	; 5c7f

; ----------------------------------------------------------------------
; DATOS figuras_5C84: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c84..0x5c88  (4 bytes)
DATA_figuras_5C84:
	defb 002h,002h,011h,010h	; 5c84

; ----------------------------------------------------------------------
; DATOS figuras_5C88: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c88..0x5c8c  (4 bytes)
DATA_figuras_5C88:
	defb 002h,006h,009h,010h	; 5c88

; ----------------------------------------------------------------------
; DATOS figuras_5C8C: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c8c..0x5c90  (4 bytes)
DATA_figuras_5C8C:
	defb 002h,008h,010h,013h	; 5c8c

; ----------------------------------------------------------------------
; DATOS figuras_5C90: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (5 bytes)
;   0x5c90..0x5c95  (5 bytes)
DATA_figuras_5C90:
	defb 003h,000h,009h,011h,019h	; 5c90

; ----------------------------------------------------------------------
; DATOS figuras_5C95: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c95..0x5c99  (4 bytes)
DATA_figuras_5C95:
	defb 002h,008h,019h,013h	; 5c95

; ----------------------------------------------------------------------
; DATOS figuras_5C99: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c99..0x5c9d  (4 bytes)
DATA_figuras_5C99:
	defb 002h,005h,011h,019h	; 5c99

; ----------------------------------------------------------------------
; DATOS figuras_5C9D: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5c9d..0x5ca1  (4 bytes)
DATA_figuras_5C9D:
	defb 002h,002h,011h,019h	; 5c9d

; ----------------------------------------------------------------------
; DATOS figuras_5CA1: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (6 bytes)
;   0x5ca1..0x5ca7  (6 bytes)
DATA_figuras_5CA1:
	defb 004h,000h,007h,010h,013h,018h	; 5ca1

; ----------------------------------------------------------------------
; DATOS figuras_5CA7: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5ca7..0x5cab  (4 bytes)
DATA_figuras_5CA7:
	defb 002h,005h,019h,007h	; 5ca7

; ----------------------------------------------------------------------
; DATOS figuras_5CAB: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (3 bytes)
;   0x5cab..0x5cae  (3 bytes)
DATA_figuras_5CAB:
	defb 001h,001h,003h	; 5cab

; ----------------------------------------------------------------------
; DATOS figuras_5CAE: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cae..0x5cb2  (4 bytes)
DATA_figuras_5CAE:
	defb 002h,001h,009h,00bh	; 5cae

; ----------------------------------------------------------------------
; DATOS figuras_5CB2: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cb2..0x5cb6  (4 bytes)
DATA_figuras_5CB2:
	defb 002h,000h,003h,007h	; 5cb2

; ----------------------------------------------------------------------
; DATOS figuras_5CB6: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cb6..0x5cba  (4 bytes)
DATA_figuras_5CB6:
	defb 002h,000h,003h,011h	; 5cb6

; ----------------------------------------------------------------------
; DATOS figuras_5CBA: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cba..0x5cbe  (4 bytes)
DATA_figuras_5CBA:
	defb 002h,001h,013h,01ah	; 5cba

; ----------------------------------------------------------------------
; DATOS figuras_5CBE: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cbe..0x5cc2  (4 bytes)
DATA_figuras_5CBE:
	defb 002h,001h,005h,01ah	; 5cbe

; ----------------------------------------------------------------------
; DATOS figuras_5CC2: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cc2..0x5cc6  (4 bytes)
DATA_figuras_5CC2:
	defb 002h,001h,01ah,009h	; 5cc2

; ----------------------------------------------------------------------
; DATOS figuras_5CC6: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cc6..0x5cca  (4 bytes)
DATA_figuras_5CC6:
	defb 002h,005h,007h,01ah	; 5cc6

; ----------------------------------------------------------------------
; DATOS figuras_5CCA: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cca..0x5cce  (4 bytes)
DATA_figuras_5CCA:
	defb 002h,000h,007h,010h	; 5cca

; ----------------------------------------------------------------------
; DATOS figuras_5CCE: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (5 bytes)
;   0x5cce..0x5cd3  (5 bytes)
DATA_figuras_5CCE:
	defb 003h,000h,007h,013h,018h	; 5cce

; ----------------------------------------------------------------------
; DATOS figuras_5CD3: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (5 bytes)
;   0x5cd3..0x5cd8  (5 bytes)
DATA_figuras_5CD3:
	defb 003h,000h,007h,010h,018h	; 5cd3

; ----------------------------------------------------------------------
; DATOS figuras_5CD8: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cd8..0x5cdc  (4 bytes)
DATA_figuras_5CD8:
	defb 002h,001h,005h,00bh	; 5cd8

; ----------------------------------------------------------------------
; DATOS figuras_5CDC: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cdc..0x5ce0  (4 bytes)
DATA_figuras_5CDC:
	defb 002h,002h,011h,00bh	; 5cdc

; ----------------------------------------------------------------------
; DATOS figuras_5CE0: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5ce0..0x5ce4  (4 bytes)
DATA_figuras_5CE0:
	defb 002h,006h,005h,00bh	; 5ce0

; ----------------------------------------------------------------------
; DATOS figuras_5CE4: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5ce4..0x5ce8  (4 bytes)
DATA_figuras_5CE4:
	defb 002h,002h,006h,01eh	; 5ce4

; ----------------------------------------------------------------------
; DATOS figuras_5CE8: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5ce8..0x5cec  (4 bytes)
DATA_figuras_5CE8:
	defb 002h,002h,01ch,01eh	; 5ce8

; ----------------------------------------------------------------------
; DATOS figuras_5CEC: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cec..0x5cf0  (4 bytes)
DATA_figuras_5CEC:
	defb 002h,008h,013h,01eh	; 5cec

; ----------------------------------------------------------------------
; DATOS figuras_5CF0: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cf0..0x5cf4  (4 bytes)
DATA_figuras_5CF0:
	defb 002h,005h,007h,01eh	; 5cf0

; ----------------------------------------------------------------------
; DATOS figuras_5CF4: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (5 bytes)
;   0x5cf4..0x5cf9  (5 bytes)
DATA_figuras_5CF4:
	defb 003h,000h,009h,007h,01eh	; 5cf4

; ----------------------------------------------------------------------
; DATOS figuras_5CF9: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cf9..0x5cfd  (4 bytes)
DATA_figuras_5CF9:
	defb 002h,002h,006h,014h	; 5cf9

; ----------------------------------------------------------------------
; DATOS figuras_5CFD: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5cfd..0x5d01  (4 bytes)
DATA_figuras_5CFD:
	defb 002h,002h,01ch,014h	; 5cfd

; ----------------------------------------------------------------------
; DATOS figuras_5D01: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (5 bytes)
;   0x5d01..0x5d06  (5 bytes)
DATA_figuras_5D01:
	defb 003h,000h,009h,011h,014h	; 5d01

; ----------------------------------------------------------------------
; DATOS figuras_5D06: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d06..0x5d0a  (4 bytes)
DATA_figuras_5D06:
	defb 002h,008h,005h,014h	; 5d06

; ----------------------------------------------------------------------
; DATOS figuras_5D0A: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d0a..0x5d0e  (4 bytes)
DATA_figuras_5D0A:
	defb 002h,002h,01ch,00ch	; 5d0a

; ----------------------------------------------------------------------
; DATOS figuras_5D0E: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (5 bytes)
;   0x5d0e..0x5d13  (5 bytes)
DATA_figuras_5D0E:
	defb 003h,000h,009h,01ch,00ch	; 5d0e

; ----------------------------------------------------------------------
; DATOS figuras_5D13: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d13..0x5d17  (4 bytes)
DATA_figuras_5D13:
	defb 002h,002h,007h,01eh	; 5d13

; ----------------------------------------------------------------------
; DATOS figuras_5D17: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (6 bytes)
;   0x5d17..0x5d1d  (6 bytes)
DATA_figuras_5D17:
	defb 004h,000h,007h,010h,013h,018h	; 5d17

; ----------------------------------------------------------------------
; DATOS figuras_5D1D: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d1d..0x5d21  (4 bytes)
DATA_figuras_5D1D:
	defb 002h,004h,005h,00bh	; 5d1d

; ----------------------------------------------------------------------
; DATOS figuras_5D21: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d21..0x5d25  (4 bytes)
DATA_figuras_5D21:
	defb 002h,004h,009h,00bh	; 5d21

; ----------------------------------------------------------------------
; DATOS figuras_5D25: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d25..0x5d29  (4 bytes)
DATA_figuras_5D25:
	defb 002h,004h,00dh,005h	; 5d25

; ----------------------------------------------------------------------
; DATOS figuras_5D29: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d29..0x5d2d  (4 bytes)
DATA_figuras_5D29:
	defb 002h,004h,009h,00eh	; 5d29

; ----------------------------------------------------------------------
; DATOS figuras_5D2D: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d2d..0x5d31  (4 bytes)
DATA_figuras_5D2D:
	defb 002h,004h,005h,00fh	; 5d2d

; ----------------------------------------------------------------------
; DATOS figuras_5D31: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d31..0x5d35  (4 bytes)
DATA_figuras_5D31:
	defb 002h,004h,009h,00fh	; 5d31

; ----------------------------------------------------------------------
; DATOS figuras_5D35: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d35..0x5d39  (4 bytes)
DATA_figuras_5D35:
	defb 002h,004h,00dh,00fh	; 5d35

; ----------------------------------------------------------------------
; DATOS figuras_5D39: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d39..0x5d3d  (4 bytes)
DATA_figuras_5D39:
	defb 002h,004h,00eh,00fh	; 5d39

; ----------------------------------------------------------------------
; DATOS figuras_5D3D: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d3d..0x5d41  (4 bytes)
DATA_figuras_5D3D:
	defb 002h,004h,00fh,010h	; 5d3d

; ----------------------------------------------------------------------
; DATOS figuras_5D41: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d41..0x5d45  (4 bytes)
DATA_figuras_5D41:
	defb 002h,004h,00fh,013h	; 5d41

; ----------------------------------------------------------------------
; DATOS figuras_5D45: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (3 bytes)
;   0x5d45..0x5d48  (3 bytes)
DATA_figuras_5D45:
	defb 001h,004h,00fh	; 5d45

; ----------------------------------------------------------------------
; DATOS figuras_5D48: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (3 bytes)
;   0x5d48..0x5d4b  (3 bytes)
DATA_figuras_5D48:
	defb 001h,005h,010h	; 5d48

; ----------------------------------------------------------------------
; DATOS figuras_5D4B: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d4b..0x5d4f  (4 bytes)
DATA_figuras_5D4B:
	defb 002h,000h,015h,019h	; 5d4b

; ----------------------------------------------------------------------
; DATOS figuras_5D4F: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (5 bytes)
;   0x5d4f..0x5d54  (5 bytes)
DATA_figuras_5D4F:
	defb 003h,000h,010h,015h,018h	; 5d4f

; ----------------------------------------------------------------------
; DATOS figuras_5D54: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d54..0x5d58  (4 bytes)
DATA_figuras_5D54:
	defb 002h,000h,00ah,015h	; 5d54

; ----------------------------------------------------------------------
; DATOS figuras_5D58: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d58..0x5d5c  (4 bytes)
DATA_figuras_5D58:
	defb 002h,000h,013h,00ah	; 5d58

; ----------------------------------------------------------------------
; DATOS figuras_5D5C: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (5 bytes)
;   0x5d5c..0x5d61  (5 bytes)
DATA_figuras_5D5C:
	defb 003h,000h,009h,00ah,011h	; 5d5c

; ----------------------------------------------------------------------
; DATOS figuras_5D61: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d61..0x5d65  (4 bytes)
DATA_figuras_5D61:
	defb 002h,002h,006h,00ah	; 5d61

; ----------------------------------------------------------------------
; DATOS figuras_5D65: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d65..0x5d69  (4 bytes)
DATA_figuras_5D65:
	defb 002h,000h,00ah,020h	; 5d65

; ----------------------------------------------------------------------
; DATOS figuras_5D69: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d69..0x5d6d  (4 bytes)
DATA_figuras_5D69:
	defb 002h,000h,020h,019h	; 5d69

; ----------------------------------------------------------------------
; DATOS figuras_5D6D: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d6d..0x5d71  (4 bytes)
DATA_figuras_5D6D:
	defb 002h,005h,011h,00bh	; 5d6d

; ----------------------------------------------------------------------
; DATOS figuras_5D71: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d71..0x5d75  (4 bytes)
DATA_figuras_5D71:
	defb 002h,002h,011h,00bh	; 5d71

; ----------------------------------------------------------------------
; DATOS figuras_5D75: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d75..0x5d79  (4 bytes)
DATA_figuras_5D75:
	defb 002h,002h,011h,017h	; 5d75

; ----------------------------------------------------------------------
; DATOS figuras_5D79: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d79..0x5d7d  (4 bytes)
DATA_figuras_5D79:
	defb 002h,006h,009h,017h	; 5d79

; ----------------------------------------------------------------------
; DATOS figuras_5D7D: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d7d..0x5d81  (4 bytes)
DATA_figuras_5D7D:
	defb 002h,002h,00ah,007h	; 5d7d

; ----------------------------------------------------------------------
; DATOS figuras_5D81: el conjunto al que apunta 0x5C46: [2] y los tipos 0,
;   0x16 y 0x15; no lo pide nadie (4 bytes)
;   0x5d81..0x5d85  (4 bytes)
DATA_figuras_5D81:
	defb 002h,000h,016h,015h	; 5d81

; ----------------------------------------------------------------------
; DATOS figuras_5D85: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (3 bytes)
;   0x5d85..0x5d88  (3 bytes)
DATA_figuras_5D85:
	defb 001h,000h,020h	; 5d85

; ----------------------------------------------------------------------
; DATOS figuras_5D88: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (3 bytes)
;   0x5d88..0x5d8b  (3 bytes)
DATA_figuras_5D88:
	defb 001h,000h,01fh	; 5d88

; ----------------------------------------------------------------------
; DATOS figuras_5D8B: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d8b..0x5d8f  (4 bytes)
DATA_figuras_5D8B:
	defb 002h,000h,00ah,020h	; 5d8b

; ----------------------------------------------------------------------
; DATOS figuras_5D8F: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d8f..0x5d93  (4 bytes)
DATA_figuras_5D8F:
	defb 002h,000h,00ah,01fh	; 5d8f

; ----------------------------------------------------------------------
; DATOS figuras_5D93: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (3 bytes)
;   0x5d93..0x5d96  (3 bytes)
DATA_figuras_5D93:
	defb 001h,021h,020h	; 5d93

; ----------------------------------------------------------------------
; DATOS figuras_5D96: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (3 bytes)
;   0x5d96..0x5d99  (3 bytes)
DATA_figuras_5D96:
	defb 001h,021h,01fh	; 5d96

; ----------------------------------------------------------------------
; DATOS figuras_5D99: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5d99..0x5d9d  (4 bytes)
DATA_figuras_5D99:
	defb 002h,000h,009h,017h	; 5d99

; ----------------------------------------------------------------------
; DATOS figuras_5D9D: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (3 bytes)
;   0x5d9d..0x5da0  (3 bytes)
DATA_figuras_5D9D:
	defb 001h,006h,017h	; 5d9d

; ----------------------------------------------------------------------
; DATOS figuras_5DA0: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5da0..0x5da4  (4 bytes)
DATA_figuras_5DA0:
	defb 002h,000h,009h,00bh	; 5da0

; ----------------------------------------------------------------------
; DATOS figuras_5DA4: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (3 bytes)
;   0x5da4..0x5da7  (3 bytes)
DATA_figuras_5DA4:
	defb 001h,006h,00bh	; 5da4

; ----------------------------------------------------------------------
; DATOS figuras_5DA7: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5da7..0x5dab  (4 bytes)
DATA_figuras_5DA7:
	defb 002h,000h,016h,015h	; 5da7

; ----------------------------------------------------------------------
; DATOS figuras_5DAB: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5dab..0x5daf  (4 bytes)
DATA_figuras_5DAB:
	defb 002h,000h,00ah,015h	; 5dab

; ----------------------------------------------------------------------
; DATOS figuras_5DAF: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5daf..0x5db3  (4 bytes)
DATA_figuras_5DAF:
	defb 002h,000h,010h,015h	; 5daf

; ----------------------------------------------------------------------
; DATOS figuras_5DB3: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5db3..0x5db7  (4 bytes)
DATA_figuras_5DB3:
	defb 002h,000h,007h,010h	; 5db3

; ----------------------------------------------------------------------
; DATOS figuras_5DB7: un conjunto de figuras: [n] y n+1 tipos (0 es ninguno)
;   que p00:5413 sube a la VRAM; lo leen p00:5416 (4 bytes)
;   0x5db7..0x5dbb  (4 bytes)
DATA_figuras_5DB7:
	defb 002h,000h,007h,00ah	; 5db7

; ======================================================================
; CODIGO 0x5dbb..0x5dcf  (20 bytes)
; ======================================================================


maquina_de_estados:		; despacha por el estado de 0xC000
	ld hl,0c003h		;5dbb   ; apunta a el contador de cuadros
	inc (hl)			;5dbe
	ld bc,(0c000h)		;5dbf   ; lee el estado (0xC000) y el paso (0xC001) de un tiron
	ld a,c			;5dc3
	cp 003h		;5dc4
	jr nc,L_5DCC		;5dc6
	ld hl,062feh		;5dc8
	push hl			;5dcb
L_5DCC:
	call despacha		;5dcc   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_5DCF: 16 destinos del despachador de 0x408D (call en p00:5DCC):
;   0x5DEF, 0x5E15, 0x5E1F, 0x5E48, 0x5EA3, 0x5F17, 0x5F57, 0x5F86 ...; lo
;   leen p00:5DCC (32 bytes)
;   0x5dcf..0x5def  (32 bytes)
DATA_tabla_5DCF:
	defb 0efh,05dh	; 5dcf
	defb 015h,05eh	; 5dd1
	defb 01fh,05eh	; 5dd3
	defb 048h,05eh	; 5dd5
	defb 0a3h,05eh	; 5dd7
	defb 017h,05fh	; 5dd9
	defb 057h,05fh	; 5ddb
	defb 086h,05fh	; 5ddd
	defb 034h,060h	; 5ddf
	defb 09ch,060h	; 5de1
	defb 0d4h,060h	; 5de3
	defb 00ah,061h	; 5de5
	defb 0afh,061h	; 5de7
	defb 032h,062h	; 5de9
	defb 056h,062h	; 5deb
	defb 092h,062h	; 5ded

; ======================================================================
; CODIGO 0x5def..0x6000  (529 bytes)
; ======================================================================


L_5DEF:
	djnz L_5DFF		;5def
	call 06486h		;5df1
	ld a,(0c482h)		;5df4   ; lee la pantalla especial
	or a			;5df7
	ret z			;5df8
	call letras_del_texto		;5df9   ; letras_del_texto: sube las letras de los textos
	xor a			;5dfc
	jr espera_y_sigue		;5dfd
L_5DFF:
	djnz L_5E0D		;5dff
	ld hl,0c004h		;5e01   ; apunta a la espera del estado, en cuadros
	dec (hl)			;5e04
	ret nz			;5e05
	call pantalla_del_titulo		;5e06   ; pantalla_del_titulo: monta la pantalla del titulo
	xor a			;5e09
	jp L_5EF1		;5e0a
L_5E0D:
	call borra_la_pantalla		;5e0d   ; borra_la_pantalla: borra la pantalla
	call 0643fh		;5e10
	jr siguiente_paso		;5e13
L_5E15:
	ld hl,0c004h		;5e15   ; apunta a la espera del estado, en cuadros
	dec (hl)			;5e18
	jp nz,L_4458		;5e19
	jp siguiente_estado		;5e1c   ; siguiente_estado: pasa al estado siguiente
L_5E1F:
	djnz L_5E38		;5e1f
	call 06923h		;5e21
	call 068f3h		;5e24
	ld a,(0c263h)		;5e27
	or a			;5e2a
	ret nz			;5e2b
L_5E2C:
	xor a			;5e2c
cambia_de_estado:		; pasa al estado A
	ld (0c000h),a		;5e2d   ; guarda el ESTADO del juego
	ld a,020h		;5e30
	ld (0c004h),a		;5e32   ; guarda la espera del estado, en cuadros
	jp L_5EF8		;5e35
L_5E38:
	call borra_la_pantalla		;5e38   ; borra_la_pantalla: borra la pantalla
	call 0688bh		;5e3b
	ld a,020h		;5e3e
espera_y_sigue:		; espera y pasa al paso siguiente
	ld (0c004h),a		;5e40   ; guarda la espera del estado, en cuadros
siguiente_paso:		; pasa al paso siguiente (0xC001)
	ld hl,0c001h		;5e43   ; apunta a el paso del estado
	inc (hl)			;5e46
	ret			;5e47
L_5E48:
	djnz L_5E73		;5e48
	ld a,(0c002h)		;5e4a   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	bit 5,a		;5e4d
	ld hl,063bch		;5e4f
	jr z,L_5E57		;5e52
	ld hl,063cbh		;5e54
L_5E57:
	ld a,(0c004h)		;5e57   ; lee la espera del estado, en cuadros
	bit 2,a		;5e5a
	jr z,L_5E63		;5e5c
	call borra_rotulo		;5e5e   ; borra_rotulo: borra un rotulo
	jr L_5E66		;5e61
L_5E63:
	call rotulo		;5e63   ; rotulo: pinta un rotulo
L_5E66:
	ld hl,0c004h		;5e66   ; apunta a la espera del estado, en cuadros
	dec (hl)			;5e69
	ret nz			;5e6a
	ld a,(0ef00h)		;5e6b   ; lee el VECINO: 0xFF con el Game Master o Q*bert en otra ranura
	or a			;5e6e
	jr nz,L_5E8D		;5e6f
	jr siguiente_paso		;5e71
L_5E73:
	djnz L_5E89		;5e73
	call empieza_la_partida		;5e75   ; empieza_la_partida: la RAM de la partida a cero desde 0xC25A, y vidas de 0x437B
	call 0662ch		;5e78
	ld hl,0ef04h		;5e7b
	ld a,(hl)			;5e7e
	or a			;5e7f
	jr z,L_5E87		;5e80
	ld (hl),000h		;5e82
	call 08050h		;5e84
L_5E87:
	jr siguiente_estado		;5e87
L_5E89:
	ld a,03ch		;5e89
	jr espera_y_sigue		;5e8b
L_5E8D:
	xor a			;5e8d
	ld (0ef04h),a		;5e8e
	ld a,001h		;5e91
	ld (0ef05h),a		;5e93
	ld (0ef06h),a		;5e96
	ld a,003h		;5e99
	ld (0ef07h),a		;5e9b
	ld a,00ch		;5e9e
	jp cambia_de_estado		;5ea0   ; cambia_de_estado: pasa al estado A
L_5EA3:
	djnz L_5EE6		;5ea3
	call 0823bh		;5ea5
	ld hl,0c004h		;5ea8   ; apunta a la espera del estado, en cuadros
	dec (hl)			;5eab
	ret nz			;5eac
	call borra_la_pantalla		;5ead   ; borra_la_pantalla: borra la pantalla
	call 0663ah		;5eb0   ; carga_la_zona: carga la zona de 0xC280
	call pinta_el_marcador		;5eb3   ; pinta_el_marcador: pinta el marcador entero
	ld a,(0ef81h)		;5eb6
	sub 006h		;5eb9
	cp 002h		;5ebb
	call c,0beddh		;5ebd
	ld hl,0c263h		;5ec0
	ld (hl),001h		;5ec3
	ld a,095h		;5ec5
	call sonido		;5ec7   ; sonido: arranca la musica o el efecto A
	call sprites_del_jugador		;5eca   ; sprites_del_jugador: sube los sprites del jugador
	di			;5ecd
	ld a,009h		;5ece
	ld (0a000h),a		;5ed0   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;5ed3   ; guarda la copia del banco de 0xA000
	ei			;5ed6
	call 074a6h		;5ed7
	call bancos_1_2_3		;5eda   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call L_5B1D		;5edd
	call L_5B09		;5ee0
	jp siguiente_paso		;5ee3   ; siguiente_paso: pasa al paso siguiente (0xC001)
L_5EE6:
	djnz L_5EFD		;5ee6
	call suena_algo		;5ee8   ; suena_algo: lo que esta sonando (0xC0A9-0xC0AD)
	ret nz			;5eeb
	call musica_de_la_zona		;5eec   ; musica_de_la_zona: la musica del juego de graficos de la zona (tabla 0x4182)
siguiente_estado:		; pasa al estado siguiente
	ld a,020h		;5eef
L_5EF1:
	ld (0c004h),a		;5ef1   ; guarda la espera del estado, en cuadros
	ld hl,0c000h		;5ef4   ; apunta a el ESTADO del juego
	inc (hl)			;5ef7
L_5EF8:
	xor a			;5ef8
	ld (0c001h),a		;5ef9   ; guarda el paso del estado
	ret			;5efc
L_5EFD:
	call borra_la_pantalla		;5efd   ; borra_la_pantalla: borra la pantalla
	ld a,(0c260h)		;5f00   ; lee las vidas
	sub 001h		;5f03
	daa			;5f05
	ld (0c260h),a		;5f06   ; guarda las vidas
	call L_4C26		;5f09
	call L_4D54		;5f0c
	call 080d9h		;5f0f
	ld a,078h		;5f12
	jp espera_y_sigue		;5f14   ; espera_y_sigue: espera y pasa al paso siguiente
L_5F17:
	call 06802h		;5f17
	ld a,(0c282h)		;5f1a
	and a			;5f1d
	ld a,008h		;5f1e
	jp nz,cambia_de_estado		;5f20   ; cambia_de_estado: pasa al estado A
	ld a,(0c283h)		;5f23   ; lee el lado por el que se sale (0 arriba, 1 abajo, 2 izquierda, 3 derecha)
	and a			;5f26
	ld a,009h		;5f27
	jp nz,cambia_de_estado		;5f29   ; cambia_de_estado: pasa al estado A
	ld a,(0c008h)		;5f2c
	and a			;5f2f
	jr nz,L_5F42		;5f30
	ld a,(0c28bh)		;5f32
	and a			;5f35
	ld a,00bh		;5f36
	jp nz,cambia_de_estado		;5f38   ; cambia_de_estado: pasa al estado A
	ld a,(0c263h)		;5f3b
	or a			;5f3e
	ret nz			;5f3f
	jr siguiente_estado		;5f40
L_5F42:
	ld hl,0c580h		;5f42   ; apunta a lo tecleado en la pausa
	ld de,0c581h		;5f45
	ld bc,0001fh		;5f48
	ld (hl),000h		;5f4b
	ldir		;5f4d
	call 0635ah		;5f4f
	ld a,00ah		;5f52
	jp cambia_de_estado		;5f54   ; cambia_de_estado: pasa al estado A
L_5F57:
	call 07e9dh		;5f57
	ld a,(0c260h)		;5f5a   ; lee las vidas
	or a			;5f5d
	jr z,L_5F7E		;5f5e
L_5F60:
	ld a,(0c360h)		;5f60
	or a			;5f63
	jr z,L_5F79		;5f64
L_5F66:
	ld hl,0c260h		;5f66   ; apunta a las vidas
	ld de,0c360h		;5f69
	ld bc,00100h		;5f6c
	call intercambia		;5f6f   ; intercambia: intercambia los bytes de (HL) y (DE)
	ld hl,0c002h		;5f72   ; apunta a las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	ld a,(hl)			;5f75
	xor 080h		;5f76
	ld (hl),a			;5f78
L_5F79:
	ld a,004h		;5f79
	jp cambia_de_estado		;5f7b   ; cambia_de_estado: pasa al estado A
L_5F7E:
	ld a,08eh		;5f7e
	call sonido		;5f80   ; sonido: arranca la musica o el efecto A
	jp siguiente_estado		;5f83   ; siguiente_estado: pasa al estado siguiente
L_5F86:
	djnz L_5FCC		;5f86
	ld a,(0c27fh)		;5f88   ; lee si se puede continuar
	and a			;5f8b
	jr z,L_5F9E		;5f8c
	call L_5FE9		;5f8e
	jr c,L_5F9E		;5f91
	ld a,001h		;5f93
	ld (0c486h),a		;5f95
	ld hl,063e3h		;5f98
	call borra_rotulo		;5f9b   ; borra_rotulo: borra un rotulo
L_5F9E:
	ld a,(0c0abh)		;5f9e   ; lee los canales que suenan
	or a			;5fa1
	ret nz			;5fa2
	ld a,(0c27fh)		;5fa3   ; lee si se puede continuar
	and a			;5fa6
	jr z,L_5FAF		;5fa7
	ld a,(0c486h)		;5fa9
	and a			;5fac
	jr nz,L_5FF1		;5fad
L_5FAF:
	ld a,(0c360h)		;5faf
	and a			;5fb2
	jr nz,L_5F66		;5fb3
	ld hl,0c002h		;5fb5   ; apunta a las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	ld a,(hl)			;5fb8
	and 0bfh		;5fb9
	ld (hl),a			;5fbb
	xor a			;5fbc
	ld (0cd2fh),a		;5fbd
	ld (0ef80h),a		;5fc0   ; guarda los SECRETOS que ponen las claves
	ld (0ef81h),a		;5fc3
	ld (0cd60h),a		;5fc6
	jp L_5E2C		;5fc9
L_5FCC:
	call borra_la_pantalla		;5fcc   ; borra_la_pantalla: borra la pantalla
	ld hl,063dbh		;5fcf
	call rotulo		;5fd2   ; rotulo: pinta un rotulo
	ld a,(0c27fh)		;5fd5   ; lee si se puede continuar
	and a			;5fd8
	jr z,L_5FE1		;5fd9
	ld hl,063e3h		;5fdb
	call rotulo		;5fde   ; rotulo: pinta un rotulo
L_5FE1:
	call pinta_el_marcador		;5fe1   ; pinta_el_marcador: pinta el marcador entero
	ld a,078h		;5fe4
	jp espera_y_sigue		;5fe6   ; espera_y_sigue: espera y pasa al paso siguiente
L_5FE9:
	ld a,007h		;5fe9
	call 00141h		;5feb   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;5fee
	rra			;5fef
	ret			;5ff0
L_5FF1:
	ld a,003h		;5ff1
	ld (0c260h),a		;5ff3   ; guarda las vidas
	ld a,(0c002h)		;5ff6   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	ld hl,0c257h		;5ff9   ; apunta a los puntos del jugador 1 (BCD)
	bit 5,a		;5ffc
	jr nz,$+8		;5ffe
