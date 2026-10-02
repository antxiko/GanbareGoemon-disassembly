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
	or a			;4049   ; con un vecino (Game Master o Q*bert) en otra ranura, antes se mira la pausa
	jp nz,L_40E7		;404a
L_404D:
	ld a,00ah		;404d   ; el sonido: bancos 10, 11 y 12 en 0x6000-0xBFFF, sin tocar las copias de 0xF0F1
	ld (06000h),a		;404f   ; el mapper: pone en 0x6000 el banco de A
	inc a			;4052
	ld (08000h),a		;4053   ; el mapper: pone en 0x8000 el banco de A
	inc a			;4056
	ld (0a000h),a		;4057   ; el mapper: pone en 0xA000 el banco de A
	call 06000h		;405a   ; sonido_del_cuadro (banco 10): la musica y los efectos de este cuadro
	di			;405d
	ld a,(0f0f1h)		;405e   ; y vuelven los bancos que tenia puestos el juego
	ld (06000h),a		;4061   ; el mapper: pone en 0x6000 el banco de A
	ld a,(0f0f2h)		;4064   ; lee la copia del banco de 0x8000
	ld (08000h),a		;4067   ; el mapper: pone en 0x8000 el banco de A
	ld a,(0f0f3h)		;406a   ; lee la copia del banco de 0xA000
	ld (0a000h),a		;406d   ; el mapper: pone en 0xA000 el banco de A
	ld hl,0c005h		;4070   ; apunta a el semaforo de la interrupcion
	bit 0,(hl)		;4073   ; si el cuadro anterior no ha acabado, este no corre el juego
	jp nz,L_4081		;4075
	inc (hl)			;4078   ; semaforo puesto
	ei			;4079   ; con las interrupciones abiertas: el sonido no espera al juego
	call maquina_de_estados		;407a   ; maquina_de_estados: un cuadro: despacha por el estado de 0xC000 (16, tabla de 0x5DCF)
	xor a			;407d   ; semaforo libre
	ld (0c005h),a		;407e   ; guarda el semaforo de la interrupcion
L_4081:
	ei			;4081   ; sin correr el juego
	ret			;4082
hl_mas_a:		; HL += A
	add a,l			;4083   ; suma A a la parte baja
	ld l,a			;4084
	ret nc			;4085   ; sin acarreo, ya esta
	inc h			;4086   ; con acarreo, sube la parte alta
	ret			;4087
de_mas_a:		; DE += A
	add a,e			;4088   ; suma A a la parte baja
	ld e,a			;4089
	ret nc			;408a   ; sin acarreo, ya esta
	inc d			;408b   ; con acarreo, sube la parte alta
	ret			;408c
despacha:		; salta a la entrada A de la tabla que va detras del call
	pop hl			;408d   ; HL = la direccion de vuelta: alli empieza la tabla
	add a,a			;408e   ; dos bytes por entrada
	call hl_mas_a		;408f   ; hl_mas_a: HL += A
	ld e,(hl)			;4092   ; DE = la entrada A
	inc hl			;4093
	ld d,(hl)			;4094
	ex de,hl			;4095
	jp (hl)			;4096   ; salta a ella: su ret vuelve directamente al que llamo antes del call a despacha
init:		; arranque del cartucho
	di			;4097
	ld sp,0f0f0h		;4098   ; la pila, debajo de las copias de los bancos (0xF0F1)
	call 00138h		;409b   ; BIOS RSLREG - Reads the primary slot register | la ranura primaria de la pagina 1, donde esta el cartucho
	rrca			;409e
	rrca			;409f
	and 003h		;40a0
	ld c,a			;40a2
	ld b,000h		;40a3
	ld hl,0fcc1h		;40a5   ; EXPTBL: si esa ranura esta expandida
	add hl,bc			;40a8
	ld a,(hl)			;40a9
	and 080h		;40aa
	or c			;40ac
	ld c,a			;40ad
	inc hl			;40ae   ; SLTTBL: la subranura
	inc hl			;40af
	inc hl			;40b0
	inc hl			;40b1
	ld a,(hl)			;40b2
	and 00ch		;40b3
	or c			;40b5
	ld h,080h		;40b6   ; pone el cartucho tambien en la pagina 2 (0x8000-0xBFFF)
	call 00024h		;40b8   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,0c000h		;40bb   ; apunta a el ESTADO del juego
	ld de,0c001h		;40be   ; apunta a el paso del estado
	ld bc,030efh		;40c1   ; 0x30F0 bytes a cero: la RAM del juego entera, 0xC000-0xF0EF
	ld (hl),000h		;40c4
	ldir		;40c6
	call bancos_1_2_3		;40c8   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call 07eabh		;40cb   ; busca_al_vecino: 0xEF00 = 0xFF si hay un Game Master (firma en 0x7FFA) o un Q*bert (0xBFFA) en otra ranura
	call bancos_1_2_3		;40ce   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call prepara_el_vdp		;40d1   ; prepara_el_vdp: pasa a SCREEN 5 y pone los registros del V9938
	di			;40d4
	ld a,0c3h		;40d5   ; H.TIMI = jp interrupcion: el juego corre desde la interrupcion de cada cuadro
	ld (0fd9fh),a		;40d7
	ld hl,interrupcion		;40da
	ld (0fda0h),hl		;40dd
	xor a			;40e0
	ld (0f3dbh),a		;40e1   ; 0xF3DB (CLIKSW) a cero: sin el clic de las teclas
	ei			;40e4
L_40E5:
	jr L_40E5		;40e5   ; el programa principal no hace nada mas: todo va por la interrupcion
L_40E7:
	ld a,007h		;40e7   ; fila 7 del teclado: el bit 4 es STOP
	call 00141h		;40e9   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;40ec
	and 010h		;40ed
	ld b,a			;40ef
	ld a,001h		;40f0   ; fila 1 del teclado: el bit 7
	call 00141h		;40f2   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;40f5
	and 080h		;40f6
	or b			;40f8
	ld hl,0ef10h		;40f9   ; 0xEF10: las dos teclas del cuadro anterior; C = las que se acaban de apretar
	ld c,(hl)			;40fc
	ld (hl),a			;40fd
	xor c			;40fe
	and (hl)			;40ff
	ld c,a			;4100
	ld hl,0ef01h		;4101   ; 0xEF01: la pausa del vecino puesta
	ld a,(hl)			;4104
	or a			;4105
	jr nz,L_4113		;4106
	bit 4,c		;4108   ; sin pausa: STOP la pone; si no, el cuadro normal
	jp z,L_404D		;410a
	ld (hl),c			;410d   ; la pausa puesta, con la tecla que la puso
	call calla_y_guarda		;410e   ; y el sonido callado; este cuadro no corre el juego
	ei			;4111
	ret			;4112
L_4113:
	bit 7,c		;4113   ; en pausa, la tecla de la fila 1 corre UN cuadro y vuelve a parar: cuadro a cuadro
	jp nz,L_411E		;4115
	bit 4,c		;4118   ; STOP otra vez quita la pausa
	jr z,L_4124		;411a
	xor a			;411c
	ld (hl),a			;411d
L_411E:
	call devuelve_volumen		;411e   ; vuelve el volumen y corre el cuadro
	jp L_404D		;4121
L_4124:
	call calla_el_psg		;4124   ; en pausa: el PSG callado y el juego quieto
	ei			;4127
	ret			;4128
calla_y_guarda:		; guarda los volumenes del PSG (registros 8-10) en 0xEF11-0xEF13 y los pone a cero
	ld a,008h		;4129   ; RDPSG del registro 8, el volumen del canal A
	call 00096h		;412b   ; BIOS RDPSG - Reads value from PSG-register
	ld (0ef11h),a		;412e
	ld a,009h		;4131   ; el registro 9, el del canal B
	call 00096h		;4133   ; BIOS RDPSG - Reads value from PSG-register
	ld (0ef12h),a		;4136
	ld a,00ah		;4139   ; el registro 10, el del canal C
	call 00096h		;413b   ; BIOS RDPSG - Reads value from PSG-register
	ld (0ef13h),a		;413e
calla_el_psg:		; los tres volumenes del PSG a cero
	ld e,000h		;4141   ; sigue: los tres a cero
	ld a,008h		;4143   ; el registro 8
	call 00093h		;4145   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,000h		;4148
	inc a			;414a   ; el 9
	call 00093h		;414b   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,000h		;414e
	inc a			;4150   ; el 10
	jp 00093h		;4151   ; BIOS WRTPSG - Writes data to PSG-register
devuelve_volumen:		; vuelve a poner los volumenes guardados en 0xEF11-0xEF13
	ld a,(0ef11h)		;4154   ; el volumen guardado del canal A
	ld e,a			;4157
	ld a,008h		;4158
	call 00093h		;415a   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0ef12h)		;415d   ; el del canal B
	ld e,a			;4160
	ld a,009h		;4161
	call 00093h		;4163   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0ef13h)		;4166   ; el del canal C
	ld e,a			;4169
	ld a,00ah		;416a
	jp 00093h		;416c   ; BIOS WRTPSG - Writes data to PSG-register
musica_de_la_zona:		; la musica del juego de graficos de la zona (tabla 0x4182)
	ld a,(0c002h)		;416f   ; el bit 6: solo con la partida en marcha
	and 040h		;4172
	ret z			;4174
	ld hl,04182h		;4175   ; una musica por juego de graficos
	ld a,(0c289h)		;4178   ; lee el juego de graficos de la zona
	call hl_mas_a		;417b   ; hl_mas_a: HL += A
	ld a,(hl)			;417e   ; la musica (0x82-0x87: el bit 7 dice musica)
	jp sonido		;417f   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido

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
	ld hl,0b7d0h		;418e   ; el puntero de la zona en la tabla de enlaces (banco 6)
	call palabra_de_tabla		;4191   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	push hl			;4194
	ld a,(hl)			;4195   ; el primer byte: cuantas casillas tiene la zona
	push af			;4196
	add a,a			;4197   ; 4 bytes por casilla: lo que hay arriba, abajo, a la izquierda y a la derecha
	ld h,000h		;4198
	ld l,a			;419a
	add hl,hl			;419b
	dec hl			;419c
	ld b,h			;419d
	ld c,l			;419e
	ld hl,0e780h		;419f   ; todo a 0xFF: ningun enlace
	ld de,0e781h		;41a2
	ld (hl),0ffh		;41a5
	ldir		;41a7
	pop af			;41a9
	dec a			;41aa
	ld b,a			;41ab
	ld hl,0e783h		;41ac   ; 0xE783: la casilla 0 tiene a la 1 a su derecha
	ld a,001h		;41af
	ld (hl),a			;41b1
L_41B2:
	inc hl			;41b2   ; por defecto las casillas van en fila, de izquierda a derecha
	inc hl			;41b3
	inc hl			;41b4
	dec a			;41b5
	ld (hl),a			;41b6   ; a la izquierda de la n esta la n-1
	inc hl			;41b7
	inc a			;41b8
	inc a			;41b9
	ld (hl),a			;41ba   ; y a su derecha la n+1
	djnz L_41B2		;41bb
	ld (hl),0ffh		;41bd   ; la ultima no tiene nada a la derecha
	pop hl			;41bf
	inc hl			;41c0
	ld a,(hl)			;41c1   ; despues, cuantas excepciones trae la zona
	and a			;41c2
	jp z,bancos_1_2_3		;41c3   ; ninguna: los bancos de siempre y fuera
	ld b,a			;41c6
	inc hl			;41c7
L_41C8:
	push hl			;41c8   ; cada excepcion, dos bytes: [casilla][destino], con el lado en los dos bits 7
	ld a,(hl)			;41c9
	and 07fh		;41ca   ; la casilla
	add a,a			;41cc   ; por 4: su fila de 0xE780
	ld h,000h		;41cd
	ld l,a			;41cf
	add hl,hl			;41d0
	ld de,0e780h		;41d1
	add hl,de			;41d4
	ex de,hl			;41d5
	pop hl			;41d6
	ld a,(hl)			;41d7   ; el bit 7 del primer byte
	ld c,000h		;41d8
	rla			;41da
	rl c		;41db
	inc hl			;41dd
	ld a,(hl)			;41de
	rla			;41df   ; y el del segundo: C = el lado (0 arriba, 1 abajo, 2 izquierda, 3 derecha)
	rl c		;41e0
	ld a,c			;41e2
	call de_mas_a		;41e3   ; DE = el byte de ese lado
	ld a,(hl)			;41e6   ; el destino
	and 07fh		;41e7
	cp 07fh		;41e9   ; 0x7F es no hay nada (0xFF)
	jr nz,L_41EF		;41eb
	ld a,0ffh		;41ed
L_41EF:
	ld (de),a			;41ef   ; el enlace
	inc hl			;41f0
	djnz L_41C8		;41f1
	jp bancos_1_2_3		;41f3   ; bancos_1_2_3: pone los bancos 1, 2 y 3
indice_de_la_zona:		; A = (fase * 7 + zona) * 2
	ld a,(0c288h)		;41f6   ; la fase por 7
	ld b,a			;41f9
	add a,a			;41fa   ; * 2
	ld c,a			;41fb
	add a,a			;41fc   ; * 4
	add a,b			;41fd   ; + 1 + 2: * 7
	add a,c			;41fe
	ld c,a			;41ff
	ld a,(0c280h)		;4200   ; mas la zona
	add a,c			;4203
	add a,a			;4204   ; por 2, el indice de una tabla de palabras
	ret			;4205
bancos_1_2_3:		; pone los bancos 1, 2 y 3
	di			;4206   ; sin interrupciones mientras se cambia: la interrupcion pone otros bancos
	push hl			;4207
	ld hl,0f0f1h		;4208   ; apunta a la copia del banco de 0x6000
	ld a,001h		;420b   ; el 1 en 0x6000
	ld (06000h),a		;420d   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4210   ; y en su copia, la que la interrupcion devuelve al acabar
	inc a			;4211   ; el 2 en 0x8000
	ld (08000h),a		;4212   ; el mapper: pone en 0x8000 el banco de A
	inc hl			;4215
	ld (hl),a			;4216
	inc a			;4217   ; el 3 en 0xA000
	ld (0a000h),a		;4218   ; el mapper: pone en 0xA000 el banco de A
	inc hl			;421b
	ld (hl),a			;421c
	pop hl			;421d
	ei			;421e
	ret			;421f
bancos_4_5_6:		; pone los bancos 4, 5 y 6
	di			;4220
	ld hl,0f0f1h		;4221   ; apunta a la copia del banco de 0x6000
	ld a,004h		;4224   ; el 4 en 0x6000
	ld (06000h),a		;4226   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4229
	inc l			;422a
	inc a			;422b   ; el 5 en 0x8000
	ld (08000h),a		;422c   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;422f
	inc l			;4230
	inc a			;4231   ; el 6 en 0xA000
	ld (0a000h),a		;4232   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;4235
	ei			;4236
	ret			;4237
bancos_7_8_9:		; pone los bancos 7, 8 y 9
	di			;4238
	ld hl,0f0f1h		;4239   ; apunta a la copia del banco de 0x6000
	ld a,007h		;423c   ; el 7 en 0x6000
	ld (06000h),a		;423e   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4241
	inc l			;4242
	inc a			;4243   ; el 8 en 0x8000
	ld (08000h),a		;4244   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;4247
	inc l			;4248
	inc a			;4249   ; el 9 en 0xA000
	ld (0a000h),a		;424a   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;424d
	ei			;424e
	ret			;424f
bancos_10_11_12:		; pone los bancos 10, 11 y 12
	di			;4250
	ld hl,0f0f1h		;4251   ; apunta a la copia del banco de 0x6000
	ld a,00ah		;4254   ; el 10 en 0x6000
	ld (06000h),a		;4256   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4259
	inc l			;425a
	inc a			;425b   ; el 11 en 0x8000
	ld (08000h),a		;425c   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;425f
	inc l			;4260
	inc a			;4261   ; el 12 en 0xA000
	ld (0a000h),a		;4262   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;4265
	ei			;4266
	ret			;4267
bancos_13_14_15:		; pone los bancos 13, 14 y 15
	di			;4268
	ld hl,0f0f1h		;4269   ; apunta a la copia del banco de 0x6000
	ld a,00dh		;426c   ; el 13 en 0x6000
	ld (06000h),a		;426e   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4271
	inc l			;4272
	inc a			;4273   ; el 14 en 0x8000
	ld (08000h),a		;4274   ; el mapper: pone en 0x8000 el banco de A
	ld (hl),a			;4277
	inc l			;4278
	inc a			;4279   ; el 15 en 0xA000
	ld (0a000h),a		;427a   ; el mapper: pone en 0xA000 el banco de A
	ld (hl),a			;427d
	ei			;427e
	ret			;427f
rotulo_numero:		; pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	cp 0ffh		;4280   ; 0xFF: no hay rotulo
	ret z			;4282
	push af			;4283
	call bancos_10_11_12		;4284   ; la tabla de rotulos esta en el banco 12 (0xA000)
	pop af			;4287
	ld de,0a9c0h		;4288
	call palabra_de_tabla_de		;428b   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;428e   ; HL = el rotulo: [x][y] y el texto
	call rotulo		;428f   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba
	jp bancos_1_2_3		;4292   ; bancos_1_2_3: pone los bancos 1, 2 y 3
pantallas_de_la_zona:		; descomprime las pantallas de la zona a 0xD000
	call bancos_13_14_15		;4295   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld a,(0c289h)		;4298   ; un juego de pantallas por juego de graficos
	add a,a			;429b
	ld hl,06000h		;429c   ; la tabla de punteros, al principio del banco 13
	call palabra_de_tabla		;429f   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ex de,hl			;42a2
	ld hl,0d000h		;42a3   ; a 0xD000: las pantallas de la zona, 8x6 bloques cada una
	call rle_a_la_ram		;42a6   ; rle_a_la_ram: descomprime un rle a la RAM
	jp bancos_1_2_3		;42a9   ; bancos_1_2_3: pone los bancos 1, 2 y 3
bloques_de_la_zona:		; descomprime los bloques de la zona a 0xE100
	call bancos_13_14_15		;42ac   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld a,(0c289h)		;42af   ; tambien por juego de graficos
	add a,a			;42b2
	ld hl,075b9h		;42b3   ; la tabla de punteros de los bloques, en el banco 13
	call palabra_de_tabla		;42b6   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ex de,hl			;42b9
	ld hl,0e100h		;42ba   ; a 0xE100: los bloques, 4x4 caracteres cada uno
	call rle_a_la_ram		;42bd   ; rle_a_la_ram: descomprime un rle a la RAM
	jp bancos_1_2_3		;42c0   ; bancos_1_2_3: pone los bancos 1, 2 y 3
rle_a_la_ram:		; descomprime un rle a la RAM
	ld a,(de)			;42c3   ; lee el byte de control
	and a			;42c4
	ret z			;42c5
	inc de			;42c6   ; el siguiente
	ld b,a			;42c7   ; sin el bit 7, una racha de B bytes iguales; con el, una tira de n - 0x80 bytes sueltos
	and 07fh		;42c8
	cp b			;42ca
	jr z,L_42D9		;42cb
	and a			;42cd   ; un 0x80 solo no copia nada
	jr z,rle_a_la_ram		;42ce
	ex de,hl			;42d0   ; copia A bytes tal cual
	ld b,000h		;42d1   ; BC = n
	ld c,a			;42d3
	ldir		;42d4
	ex de,hl			;42d6
	jr rle_a_la_ram		;42d7
L_42D9:
	ld a,(de)			;42d9   ; la racha: el byte que se repite
	inc de			;42da
L_42DB:
	ld (hl),a			;42db   ; repetido
	inc hl			;42dc
	djnz L_42DB		;42dd   ; B veces
	jr rle_a_la_ram		;42df
empieza_texto:		; empieza un texto letra a letra: HL el texto, DE el sitio (0xCD61-0xCD67)
	ld (0cd61h),de		;42e1   ; la posicion de la letra siguiente
	ld (0cd63h),de		;42e5   ; y el principio del renglon, para 0xFE
	ld (0cd65h),hl		;42e9   ; el texto
	xor a			;42ec
	ld (0cd67h),a		;42ed   ; 0xCD67 = 0: el texto no ha acabado
	ret			;42f0
sigue_texto:		; saca la letra siguiente del texto de 0xCD65 (0xFF acaba)
	ld a,(0cd67h)		;42f1   ; acabado: no hace nada
	or a			;42f4
	ret nz			;42f5
	ld hl,(0cd65h)		;42f6
	ld a,(hl)			;42f9   ; la letra siguiente
	inc hl			;42fa
	ld (0cd65h),hl		;42fb
	cp 0ffh		;42fe   ; 0xFF acaba el texto
	jr z,L_432D		;4300
	cp 0feh		;4302   ; 0xFE pasa al renglon siguiente
	jr z,L_4333		;4304
	cp 0e0h		;4306   ; 0xE0-0xFE: un hueco de (n - 0xE0) letras
	jr nc,L_4345		;4308
	ld de,(0cd61h)		;430a   ; DE = donde va la letra (D la x, E la y)
	push af			;430e
	call letra		;430f   ; letra: pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco
	pop af			;4312
	cp 062h		;4313   ; 0x62 y 0x63 son las marcas que van encima de la letra anterior (handakuten y dakuten)
	jr c,L_431B		;4315
	cp 064h		;4317
	jr c,L_431F		;4319
L_431B:
	ld a,008h		;431b   ; una letra: 8 puntos a la derecha
	jr avanza_la_x		;431d
L_431F:
	ld a,004h		;431f   ; una marca: solo 4
avanza_la_x:		; la x del texto (0xCD61) avanza A puntos
	ld de,(0cd61h)		;4321   ; la x avanza A puntos
	add a,d			;4325
	ld d,a			;4326
	ld (0cd61h),de		;4327
	or a			;432b   ; A distinto de cero y sin carry: se ha sacado una letra
	ret			;432c
L_432D:
	ld a,001h		;432d   ; se acabo el texto
	ld (0cd67h),a		;432f
	ret			;4332
L_4333:
	ld de,(0cd63h)		;4333   ; renglon nuevo: 8 puntos mas abajo que el principio del anterior
	ld a,008h		;4337   ; 8 mas abajo
	add a,e			;4339
	ld e,a			;433a
	ld (0cd63h),de		;433b
	ld (0cd61h),de		;433f   ; y la x vuelve al principio del renglon
	jr sigue_texto		;4343
L_4345:
	sub 0e0h		;4345   ; 0xE0 tambien acaba
	jr z,L_432D		;4347
	add a,a			;4349   ; por 8: los puntos del hueco
	add a,a			;434a
	add a,a			;434b
	call avanza_la_x		;434c   ; avanza_la_x: la x del texto (0xCD61) avanza A puntos
	jr sigue_texto		;434f
empieza_la_partida:		; la RAM de la partida a cero desde 0xC25A, y vidas de 0x437B
	ld hl,0c25ah		;4351   ; 0xDA7 bytes a cero, de 0xC25A a 0xD000: la partida entera
	ld bc,00da6h		;4354
	ld d,h			;4357   ; DE = HL + 1
	ld e,l			;4358
	inc e			;4359
	ld (hl),000h		;435a
	ldir		;435c
	ld hl,0437bh		;435e   ; 0x437B: 3 vidas, 0xC261 = 1 y la proxima vida a los 100.000 (0x10)
	ld de,0c260h		;4361   ; apunta a las vidas
	ld bc,00003h		;4364   ; 3 bytes
	ldir		;4367
	ld a,(0c002h)		;4369   ; el bit 5: partida de dos jugadores
	and 020h		;436c
	ret z			;436e
	ld hl,0c260h		;436f   ; la copia del jugador 2: los 256 bytes de 0xC260 a 0xC360
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
	ld c,000h		;437e   ; C = el byte alto de lo que se suma: DE trae los cuatro digitos de abajo
L_4380:
	ld a,(0c002h)		;4380   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	add a,a			;4383   ; el bit 7: el jugador 2
	ld hl,0c257h		;4384   ; apunta a los puntos del jugador 1 (BCD)
	jr nc,L_438C		;4387
	ld hl,0c25ah		;4389   ; apunta a los puntos del jugador 2 (BCD)
L_438C:
	ld a,(hl)			;438c   ; los puntos son tres bytes en BCD, el de abajo primero
	add a,e			;438d   ; los dos digitos de abajo
	daa			;438e
	ld (hl),a			;438f
	inc l			;4390   ; el byte del medio
	ld a,(hl)			;4391
	adc a,d			;4392   ; los dos del medio, con el acarreo
	daa			;4393
	ld (hl),a			;4394
	inc hl			;4395
	ld a,(hl)			;4396   ; el de arriba
	adc a,c			;4397   ; los dos de arriba
	daa			;4398
	ld (hl),a			;4399
	jr nc,L_43A9		;439a   ; se pasa de 999999: el record se queda en 999999
	ld bc,09999h		;439c
	ld (0c254h),bc		;439f
	ld (0c255h),bc		;43a3
	jr pinta_los_puntos		;43a7
L_43A9:
	ex de,hl			;43a9   ; A = los dos digitos de arriba de los puntos
	ld hl,0c262h		;43aa   ; con ellos a la altura de la proxima vida...
	cp (hl)			;43ad
	jr c,L_43C7		;43ae
	ld a,(hl)			;43b0   ; la siguiente, 100.000 mas alla
	add a,010h		;43b1
	daa			;43b3
	jr nc,L_43B8		;43b4   ; pasada de 99 se queda en 0xFF: ya no da mas
	ld a,0ffh		;43b6
L_43B8:
	ld (hl),a			;43b8
	push de			;43b9
	ld hl,0c260h		;43ba   ; apunta a las vidas
	inc (hl)			;43bd   ; ... una vida mas
	ld a,014h		;43be   ; con el efecto 0x14
	call sonido		;43c0   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call pinta_las_vidas		;43c3   ; pinta_las_vidas: pinta las vidas
	pop de			;43c6
L_43C7:
	ex de,hl			;43c7   ; HL = el byte de arriba de los puntos; DE = el de arriba del RECORD (0xC254-0xC256)
	ld b,003h		;43c8
	ld de,0c256h		;43ca
L_43CD:
	ld a,(de)			;43cd   ; compara de arriba abajo
	sub (hl)			;43ce
	jr c,L_43D7		;43cf   ; menos que el record: nada
	jr nz,pinta_los_puntos		;43d1   ; mas: los puntos son el record nuevo
	dec l			;43d3
	dec e			;43d4
	djnz L_43CD		;43d5
L_43D7:
	ld bc,00003h		;43d7   ; los tres bytes al record
	ld e,056h		;43da   ; DE = el record (0xC256 abajo)
	ld l,059h		;43dc   ; HL = los puntos (0xC259 abajo)
	lddr		;43de
	jr pinta_los_puntos		;43e0
pinta_el_marcador:		; pinta el marcador entero
	ld a,(0c002h)		;43e2   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	ld hl,0642dh		;43e5   ; el rotulo del jugador 1 (bit 7 de 0xC002 a cero)
	add a,a			;43e8
	jr nc,L_43EE		;43e9
	ld hl,06435h		;43eb   ; el del jugador 2
L_43EE:
	call rotulo		;43ee   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba
	ld hl,063f0h		;43f1   ; el resto del marcador fijo
	call rotulo		;43f4   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba
	call pinta_las_cosas		;43f7   ; pinta_las_cosas: pinta las cosas del marcador
	call pinta_el_dinero		;43fa   ; pinta_el_dinero: pinta el dinero (4 cifras) en (0x70, 8)
	call pinta_el_tiempo		;43fd   ; pinta_el_tiempo: pinta el tiempo (4 cifras) en (0x48, 8)
	call pinta_la_vida		;4400   ; pinta_la_vida: pinta la barra de vida
	call pinta_las_vidas		;4403   ; pinta_las_vidas: pinta las vidas
pinta_los_puntos:		; pinta los puntos
	ld a,(0c002h)		;4406   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	ld de,01008h		;4409   ; en x 0x10, y 8
	ld hl,0c259h		;440c   ; el byte de arriba de los puntos del jugador 1
	add a,a			;440f
	jr nc,L_4414		;4410
	ld l,05ch		;4412   ; 0xC25C: el del jugador 2
L_4414:
	ld b,003h		;4414   ; tres bytes, seis cifras
	jr pinta_bcd		;4416
pinta_las_vidas:		; pinta las vidas
	ld hl,0c260h		;4418   ; apunta a las vidas
	ld de,0e808h		;441b   ; en x 0xE8, y 8
	ld b,001h		;441e   ; un byte, dos cifras
pinta_bcd:		; pinta cifras en BCD
	ld c,000h		;4420   ; C = 0: los ceros de delante no se pintan
L_4422:
	dec b			;4422   ; en el ultimo byte se pintan los dos, aunque sean cero
	jr nz,L_4427		;4423
	ld c,0ffh		;4425
L_4427:
	inc b			;4427
	ld a,(hl)			;4428   ; la cifra de arriba
	rra			;4429
	rra			;442a
	rra			;442b
	rra			;442c
	call pinta_una_cifra		;442d   ; pinta_una_cifra: pinta la cifra de abajo de A (con C = 0, un cero sale en blanco)
	ld a,(hl)			;4430   ; la de abajo
	call pinta_una_cifra		;4431   ; pinta_una_cifra: pinta la cifra de abajo de A (con C = 0, un cero sale en blanco)
	dec hl			;4434   ; el byte siguiente esta DEBAJO: los numeros van del byte bajo al alto
	djnz L_4422		;4435
	ret			;4437
pinta_una_cifra:		; pinta la cifra de abajo de A (con C = 0, un cero sale en blanco)
	and 00fh		;4438   ; una cifra distinta de cero: desde aqui se pintan todas
	jr z,L_443E		;443a
	ld c,0ffh		;443c
L_443E:
	add a,020h		;443e   ; las cifras son las letras 0x20-0x29; con C = 0, la letra 0 (un hueco)
	and c			;4440
	call letra		;4441   ; letra: pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco
	ld a,d			;4444   ; 8 puntos a la derecha
	add a,008h		;4445
	ld d,a			;4447
	ret			;4448
intercambia:		; intercambia los bytes de (HL) y (DE)
	push bc			;4449   ; BC bytes
	ld c,(hl)			;444a   ; C = (HL)
	ld a,(de)			;444b
	ld (hl),a			;444c   ; (HL) = (DE)
	ld a,c			;444d
	ld (de),a			;444e   ; (DE) = C
	inc hl			;444f
	inc de			;4450
	pop bc			;4451
	dec bc			;4452   ; uno menos
	ld a,b			;4453
	or c			;4454
	jr nz,intercambia		;4455
	ret			;4457
parpadea_la_opcion:		; la marca de 0x63D8 parpadea en la opcion escogida (0xC252)
	ld hl,0c004h		;4458   ; el bit 3 de la cuenta: cambia cada 8 cuadros
	bit 3,(hl)		;445b
	ld c,0ffh		;445d   ; C = 0xFF pinta y C = 0 borra
	jr nz,L_4462		;445f
	inc c			;4461
L_4462:
	ld hl,048a8h		;4462   ; las dos posiciones: x 0x48, y 0xA8 y 0xB0
	ld de,048b0h		;4465
	ld a,(0c252h)		;4468   ; 0xC252: cual esta escogida
	or a			;446b
	jr nz,L_446F		;446c
	ex de,hl			;446e
L_446F:
	push hl			;446f   ; en la escogida, la marca que parpadea...
	call marca_de_opcion		;4470   ; marca_de_opcion: pinta (C = 0xFF) o borra (C = 0) la marca de 0x63D8 en DE
	pop de			;4473
	ld c,000h		;4474   ; ... y en la otra, borrada
marca_de_opcion:		; pinta (C = 0xFF) o borra (C = 0) la marca de 0x63D8 en DE
	ld hl,063d8h		;4476   ; la marca, el texto de 0x63D8
	jp rotulo_sin_posicion		;4479   ; rotulo_sin_posicion: pinta el texto de HL en DE (D = x, E = y), sin [x][y] delante; C = 0 borra
palabra_de_tabla_de:		; DE = la palabra A de la tabla de DE
	ld l,a			;447c   ; DE += A * 2
	ld h,000h		;447d
	add hl,hl			;447f   ; A * 2
	add hl,de			;4480
	ld e,(hl)			;4481   ; la palabra
	inc hl			;4482
	ld d,(hl)			;4483
	ret			;4484
marco_de_la_vida:		; el marco de la barra de vida, del ancho de la vida maxima
	ld hl,09f09h		;4485   ; en x 0x09, y 0x9F
	ld c,00eh		;4488
	ld a,(0c480h)		;448a   ; el ancho sale de la vida maxima: 2 puntos por punto de vida, y 2 de borde
	add a,a			;448d
	inc a			;448e
	inc a			;448f
	ld d,a			;4490
	ld e,007h		;4491   ; 7 de alto
	jp marco		;4493   ; marco: pinta un marco: (H, L), D de ancho, E de alto, color C
lee_de_la_vram:		; copia BC bytes de la VRAM de HL a DE
	call vram_para_leer		;4496   ; prepara el V9938 para leer
	call vueltas_de_bc		;4499   ; B y A: las vueltas de inir
	ex af,af'			;449c
	ld a,(00006h)		;449d   ; 0x0006: el puerto de lectura del VDP, el que dice la BIOS
	ld c,a			;44a0
	ex af,af'			;44a1
L_44A2:
	inir		;44a2   ; lee de la VRAM
	dec a			;44a4   ; otra vuelta de 256
	jr nz,L_44A2		;44a5
	ex de,hl			;44a7   ; HL = el destino al final
	ret			;44a8
vueltas_de_bc:		; de BC, las vueltas de un bucle de inir/otir (B y A); cambia HL y DE
	ex de,hl			;44a9   ; HL = el destino; de BC, B = lo que sobra de 256 y A = cuantas vueltas
	ld a,c			;44aa
	or a			;44ab
	ld a,b			;44ac
	ld b,c			;44ad
	ret z			;44ae   ; con C = 0, B (0) vale 256: B vueltas justas
	inc a			;44af   ; si no, una mas para lo que sobra
	ret			;44b0
copia_a_la_vram:		; copia BC bytes de HL a la VRAM de DE
	ex de,hl			;44b1   ; HL = lo que se copia, DE = la VRAM de destino
	call vram_para_escribir		;44b2   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	call vueltas_de_bc		;44b5   ; vueltas_de_bc: de BC, las vueltas de un bucle de inir/otir (B y A); cambia HL y DE
	ex af,af'			;44b8
	ld a,(00007h)		;44b9   ; 0x0007: el puerto de escritura del VDP, el que dice la BIOS
	ld c,a			;44bc
	ex af,af'			;44bd
L_44BE:
	otir		;44be   ; escribe en la VRAM
	dec a			;44c0   ; otra vuelta de 256
	jr nz,L_44BE		;44c1
	ret			;44c3
rellena_la_vram:		; llena BC bytes de la VRAM de HL con A
	push de			;44c4   ; HL = la VRAM, A = el byte, BC = cuantos
	push af			;44c5
	call vram_para_escribir		;44c6   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	ld d,c			;44c9   ; D = las vueltas cortas; con C distinto de cero, B lleva una mas
	ld a,c			;44ca
	or a			;44cb
	jr z,L_44CF		;44cc
	inc b			;44ce
L_44CF:
	ld a,(00007h)		;44cf   ; C = el puerto de escritura
	ld c,a			;44d2
	pop af			;44d3
L_44D4:
	out (c),a		;44d4   ; escribe el byte
	dec d			;44d6   ; la vuelta corta
	jr nz,L_44D4		;44d7
	djnz L_44D4		;44d9   ; y las largas
	pop de			;44db
	ret			;44dc
lee_un_byte_de_la_vram:		; A = el byte de la VRAM de HL
	push bc			;44dd   ; lee UN byte de la VRAM de HL
	call vram_para_leer		;44de   ; vram_para_leer: prepara el V9938 para leer de la VRAM de HL
	ld a,(00006h)		;44e1
	ld c,a			;44e4
	in a,(c)		;44e5   ; A = el byte
	pop bc			;44e7
	ret			;44e8
escribe_un_byte_en_la_vram:		; escribe A en la VRAM de HL
	push bc			;44e9   ; escribe UN byte (A) en la VRAM de HL
	push af			;44ea
	call vram_para_escribir		;44eb   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	ld a,(00007h)		;44ee   ; el puerto de escritura
	ld c,a			;44f1
	pop af			;44f2   ; el byte
	out (c),a		;44f3
	pop bc			;44f5
	ret			;44f6
vram_para_escribir:		; prepara el V9938 para escribir en la VRAM
	push bc			;44f7
	ld a,(00007h)		;44f8   ; 0x0007 + 1: el puerto de control del VDP
	inc a			;44fb   ; el de control es el siguiente
	ld c,a			;44fc
	ld a,h			;44fd   ; los dos bits de arriba de los 16 de la direccion...
	rlca			;44fe
	rlca			;44ff
	and 003h		;4500
	di			;4502   ; sin interrupciones mientras se escribe en el VDP
	out (c),a		;4503
	ld a,08eh		;4505   ; ... al registro 14 (la VRAM de 128 KB va por tramos de 16 KB)
	out (c),a		;4507
	ld a,l			;4509   ; los 8 bits de abajo
	out (c),a		;450a
	ld a,h			;450c
	and 03fh		;450d
	or 040h		;450f   ; y los 6 del medio con el bit 6: escribir
	out (c),a		;4511
	pop bc			;4513
	ei			;4514
	ret			;4515
vram_para_leer:		; prepara el V9938 para leer de la VRAM de HL
	push bc			;4516   ; igual que vram_para_escribir, para LEER
	ld a,(00007h)		;4517   ; el puerto de control
	inc a			;451a
	ld c,a			;451b
	ld a,h			;451c
	rlca			;451d   ; los dos bits de arriba...
	rlca			;451e
	and 003h		;451f
	di			;4521
	out (c),a		;4522
	ld a,08eh		;4524   ; ... al registro 14
	out (c),a		;4526
	ld a,l			;4528   ; los 8 de abajo
	out (c),a		;4529
	ld a,h			;452b
	and 03fh		;452c   ; los 6 del medio sin el bit 6: leer
	out (c),a		;452e
	pop bc			;4530
	ei			;4531
	ret			;4532
rle_con_destino:		; descomprime a la VRAM un rle que lleva el destino delante
	ex de,hl			;4533   ; los dos primeros bytes del rle: la VRAM de destino
	ld e,(hl)			;4534   ; E y D: el destino
	inc hl			;4535
	ld d,(hl)			;4536
	inc hl			;4537
	ex de,hl			;4538   ; HL = el destino, DE = el rle
rle_a_la_vram:		; descomprime un rle a la VRAM
	call vram_para_escribir		;4539   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	ld a,(00007h)		;453c
	ld c,a			;453f
L_4540:
	ld a,(de)			;4540   ; el mismo rle que rle_a_la_ram: 0 acaba
	and a			;4541
	ret z			;4542
	inc de			;4543
	ld b,a			;4544
	and 07fh		;4545
	cp b			;4547
	jr z,L_4554		;4548   ; sin el bit 7, una racha
	and a			;454a
	jr z,rle_con_destino		;454b   ; un 0x80 solo: lo siguiente es otro destino y otro rle
	ex de,hl			;454d
	ld b,a			;454e
	otir		;454f   ; la tira de bytes sueltos
	ex de,hl			;4551
	jr L_4540		;4552
L_4554:
	ld a,(de)			;4554   ; la racha: el byte
	inc de			;4555   ; el byte siguiente
L_4556:
	out (c),a		;4556   ; la racha
	djnz L_4556		;4558
	jr L_4540		;455a
rle_vuelto_con_destino:		; como rle_vuelto, con la VRAM de destino delante del rle
	ex de,hl			;455c
	ld e,(hl)			;455d   ; el destino
	inc hl			;455e
	ld d,(hl)			;455f
	inc hl			;4560
	ex de,hl			;4561
rle_vuelto:		; descomprime sprites de 16x16 dados la vuelta (espejo) y los sube a la VRAM de HL
	ld (0ee80h),hl		;4562   ; descomprime patrones de sprite de 16x16 dados la vuelta de izquierda a derecha: el destino, a 0xEE80
	ld hl,0dd10h		;4565   ; se montan en 0xDD00 empezando por la segunda mitad
	exx			;4568
	ld hl,00000h		;4569   ; HL' cuenta los bytes
	exx			;456c
L_456D:
	ld a,(de)			;456d   ; el byte de control
	and a			;456e
	jr z,L_45B2		;456f   ; 0 acaba: a la VRAM
	inc de			;4571
	ld b,a			;4572   ; B = n
	and 07fh		;4573
	cp b			;4575
	jr z,L_458A		;4576   ; sin el bit 7, una racha
	and a			;4578
	jr z,rle_vuelto_con_destino		;4579   ; 0x80: otro destino
	ld b,a			;457b   ; B = n - 0x80
L_457C:
	ld a,(de)			;457c
	call bits_al_reves		;457d   ; cada fila con los bits al reves: el espejo
	ld (hl),a			;4580
	inc hl			;4581
	inc de			;4582
	call sitio_del_byte_vuelto		;4583   ; y el sitio del byte siguiente
	djnz L_457C		;4586
	jr L_456D		;4588
L_458A:
	ld a,(de)			;458a
	call bits_al_reves		;458b   ; la racha, tambien al reves
L_458E:
	ld (hl),a			;458e   ; el byte (vuelto)
	inc hl			;458f
	call sitio_del_byte_vuelto		;4590   ; sitio_del_byte_vuelto: el sitio del byte siguiente al dar la vuelta a un sprite de 16x16
	djnz L_458E		;4593
	inc de			;4595   ; el byte siguiente del rle
	jr L_456D		;4596
sitio_del_byte_vuelto:		; el sitio del byte siguiente al dar la vuelta a un sprite de 16x16
	push af			;4598   ; un sprite de 16x16 son dos columnas de 16 bytes: al darle la vuelta se cambian
	push bc			;4599
	exx			;459a
	inc hl			;459b
	ld a,l			;459c   ; cada 32 bytes, el sprite siguiente
	and 01fh		;459d
	exx			;459f
	ld bc,00020h		;45a0
	jr nz,L_45A8		;45a3
	add hl,bc			;45a5   ; a los 32, salta a la segunda columna del sprite siguiente
	jr L_45AF		;45a6
L_45A8:
	cp 010h		;45a8   ; a los 16...
	jr nz,L_45AF		;45aa
	xor a			;45ac   ; ... vuelve a la primera columna de este
	sbc hl,bc		;45ad
L_45AF:
	pop bc			;45af
	pop af			;45b0
	ret			;45b1
L_45B2:
	exx			;45b2   ; BC = cuantos bytes salieron
	push hl			;45b3
	exx			;45b4
	pop bc			;45b5
	ld hl,0dd00h		;45b6   ; y se suben de 0xDD00 a la VRAM guardada en 0xEE80
	ld de,(0ee80h)		;45b9
	jp copia_a_la_vram		;45bd   ; copia_a_la_vram: copia BC bytes de HL a la VRAM de DE
bits_al_reves:		; da la vuelta a los bits de A
	push bc			;45c0
	ld c,a			;45c1   ; C = el byte
	ld b,008h		;45c2
L_45C4:
	rr c		;45c4   ; el bit de abajo de C pasa a ser el de abajo de A, que va subiendo
	rla			;45c6
	djnz L_45C4		;45c7
	pop bc			;45c9
	ret			;45ca
borra_la_pagina:		; esconde los sprites y pinta del color 0 los 256 x 256 puntos
	call esconde_los_sprites		;45cb   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	ld bc,00000h		;45ce   ; B = 0 y C = 0: 256 x 256 puntos, la pagina entera
	jr L_45D9		;45d1
borra_la_pantalla:		; borra la pantalla
	call esconde_los_sprites		;45d3   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	ld bc,000d4h		;45d6   ; 256 x 212: la pantalla
L_45D9:
	push bc			;45d9
	call apaga_la_pantalla		;45da   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	pop bc			;45dd
	call pinta_de_color_0		;45de   ; la pinta del color 0 y el scroll a cero
enciende_la_pantalla:		; bit 6 del registro 1 del VDP a uno
	ld a,(0f3e0h)		;45e1   ; RG1SAV: la copia del registro 1 que guarda la BIOS
	or 040h		;45e4   ; el bit 6: la pantalla encendida
	ld b,a			;45e6
	ld c,001h		;45e7
	call 00047h		;45e9   ; BIOS WRTVDP - Writes data in the VDP-register
	jr sprites_dentro		;45ec   ; y los sprites encendidos
apaga_la_pantalla:		; bit 6 del registro 1 del VDP a cero
	ld a,(0f3e0h)		;45ee
	and 0bfh		;45f1   ; el bit 6 a cero: la pantalla en negro
	ld b,a			;45f3
	ld c,001h		;45f4
	call 00047h		;45f6   ; BIOS WRTVDP - Writes data in the VDP-register
	jr sprites_fuera		;45f9   ; y los sprites apagados
pinta_de_color_0:		; rellena del color 0 B x C puntos desde (0, 0) y pone el scroll a 0
	ld hl,00000h		;45fb   ; desde x 0, y 0 de la pagina 0
	xor a			;45fe   ; del color 0
	ld d,a			;45ff
	call hmmv		;4600   ; hmmv: orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)
	ld b,000h		;4603   ; el registro 23 (el scroll vertical) a 0
	ld c,017h		;4605
	jp 00047h		;4607   ; BIOS WRTVDP - Writes data in the VDP-register
esconde_los_sprites:		; y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	ld hl,0f600h		;460a   ; la tabla de atributos de los sprites (y = 0xE0: fuera)
	ld a,0e0h		;460d
	ld bc,00080h		;460f
	call rellena_la_vram		;4612   ; rellena_la_vram: llena BC bytes de la VRAM de HL con A
	call 067dah		;4615   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	ld hl,07600h		;4618   ; y la de la otra pagina
	ld a,0e0h		;461b
	ld bc,00080h		;461d
	call rellena_la_vram		;4620   ; rellena_la_vram: llena BC bytes de la VRAM de HL con A
	jp 067dah		;4623   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
sprites_fuera:		; apaga los sprites (bit 1 del registro 8 del VDP)
	ld a,(0ffe7h)		;4626   ; RG8SAV: la copia del registro 8
	or 002h		;4629   ; el bit 1 (SPD) puesto: sin sprites
	ld b,a			;462b
	ld c,008h		;462c
	jp 00047h		;462e   ; BIOS WRTVDP - Writes data in the VDP-register
sprites_dentro:		; enciende los sprites (bit 1 del registro 8 del VDP a cero)
	ld a,(0ffe7h)		;4631
	and 0fdh		;4634   ; el bit 1 a cero: con sprites
	ld b,a			;4636
	ld c,008h		;4637
	jp 00047h		;4639   ; BIOS WRTVDP - Writes data in the VDP-register
pon_un_color:		; color A de la paleta = DE
	push bc			;463c
	push hl			;463d
	ld b,a			;463e   ; B = el color
	ld a,(00007h)		;463f   ; el puerto de control
	inc a			;4642
	ld c,a			;4643
	di			;4644
	out (c),b		;4645   ; el registro 16 = el color
	ld a,090h		;4647   ; al registro 16
	out (c),a		;4649
	inc c			;464b
	out (c),d		;464c   ; el puerto de la paleta: D (rojo y azul) y E (verde)
	push af			;464e   ; una espera entre las dos escrituras
	pop af			;464f
	out (c),e		;4650
	dec c			;4652
	ld hl,0f680h		;4653   ; la paleta tambien se guarda en la VRAM, en 0xF680 + color * 2
	ld a,b			;4656   ; color * 2
	add a,a			;4657
	add a,l			;4658
	ld l,a			;4659
	call vram_para_escribir		;465a   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	dec c			;465d   ; el puerto de datos
	out (c),d		;465e
	out (c),e		;4660
	pop hl			;4662
	pop bc			;4663
	ei			;4664
	ret			;4665
pon_paleta:		; pone una lista de colores en la paleta
	ld a,(hl)			;4666   ; lista de [color][RB][G]: 0xFF acaba
	inc hl			;4667
	inc a			;4668
	ret z			;4669
	dec a			;466a   ; el color
	ld d,(hl)			;466b   ; RB
	inc hl			;466c
	ld e,(hl)			;466d   ; G
	inc hl			;466e
	call pon_un_color		;466f   ; pon_un_color: color A de la paleta = DE
	jr pon_paleta		;4672
espera_al_vdp:		; espera a que el V9938 acabe la orden
	ld a,002h		;4674   ; el registro de estado 2
	call lee_estado_del_vdp		;4676   ; lee_estado_del_vdp: lee un registro de estado del V9938
	rra			;4679   ; el bit 0 (CE): la orden sigue en marcha
	jr c,espera_al_vdp		;467a
	ret			;467c
lee_estado_del_vdp:		; lee un registro de estado del V9938
	push bc			;467d
	push hl			;467e
	ld hl,(00006h)		;467f   ; H = el puerto de control, L = el de estado
	inc h			;4682   ; + 1: los de la BIOS son los de datos
	inc l			;4683
	ld c,h			;4684
	di			;4685
	out (c),a		;4686   ; el registro 15 = el estado que se quiere leer
	ld a,08fh		;4688
	out (c),a		;468a
	ld c,l			;468c
	in a,(c)		;468d   ; el estado
	push af			;468f
	xor a			;4690   ; y el registro 15 vuelve a 0, que es el que lee la BIOS
	ld c,h			;4691
	out (c),a		;4692
	ld a,08fh		;4694
	out (c),a		;4696
	pop af			;4698
	pop hl			;4699   ; A = el estado
	pop bc			;469a
	ei			;469b
	ret			;469c
linea_horizontal:		; orden LINE: B puntos desde (H, L) a la derecha, del color C
	call espera_al_vdp		;469d   ; la orden LINE: H = x, L = y, B = largo, C = el color
	push bc			;46a0
	ld a,(00007h)		;46a1
	inc a			;46a4
	ld c,a			;46a5
	ld a,024h		;46a6   ; el registro 17 a 36 (DX), con autoincremento
	di			;46a8
	out (c),a		;46a9
	ld a,091h		;46ab
	out (c),a		;46ad
	inc c			;46af   ; el puerto de los registros indirectos
	inc c			;46b0
	out (c),h		;46b1   ; DX = H
	xor a			;46b3
	out (c),a		;46b4
	out (c),l		;46b6   ; DY = L
	out (c),a		;46b8
	pop hl			;46ba
	dec h			;46bb
	out (c),h		;46bc   ; el lado largo (NX) = B - 1
	xor a			;46be
	out (c),a		;46bf
	xor a			;46c1   ; el corto (NY) = 0
	out (c),a		;46c2
	out (c),a		;46c4
	out (c),l		;46c6   ; CLR = el color
	out (c),a		;46c8   ; ARG = 0: el lado largo es el horizontal
	ld a,070h		;46ca   ; 0x70: LINE
	out (c),a		;46cc
	ei			;46ce
	ret			;46cf
linea_vertical:		; orden LINE: B puntos desde (H, L) hacia abajo, del color C
	call espera_al_vdp		;46d0   ; la orden LINE en vertical: H = x, L = y, B = largo, C = el color
	push bc			;46d3
	ld a,(00007h)		;46d4   ; el puerto de control
	inc a			;46d7
	ld c,a			;46d8
	ld a,024h		;46d9   ; desde el registro 36
	di			;46db
	out (c),a		;46dc
	ld a,091h		;46de
	out (c),a		;46e0
	inc c			;46e2   ; el de los registros indirectos
	inc c			;46e3
	out (c),h		;46e4   ; DX
	xor a			;46e6
	out (c),a		;46e7
	out (c),l		;46e9   ; DY
	out (c),a		;46eb
	pop hl			;46ed
	dec h			;46ee
	out (c),h		;46ef   ; NX = largo - 1
	xor a			;46f1
	out (c),a		;46f2
	xor a			;46f4   ; NY = 0
	out (c),a		;46f5
	out (c),a		;46f7
	out (c),l		;46f9   ; el color
	inc a			;46fb   ; ARG = 1: el lado largo es el vertical
	out (c),a		;46fc
	ld a,070h		;46fe   ; LINE
	out (c),a		;4700
	ei			;4702
	ret			;4703
marco:		; pinta un marco: (H, L), D de ancho, E de alto, color C
	ld b,e			;4704   ; H = x, L = y, D = ancho, E = alto, C = el color
	call linea_vertical_guardando		;4705   ; el lado izquierdo
	ld b,d			;4708
	call linea_horizontal_guardando		;4709   ; el de arriba
	push hl			;470c
	ld a,l			;470d   ; el de abajo, en y + alto - 1
	dec a			;470e
	add a,e			;470f
	ld l,a			;4710
	ld b,d			;4711
	call linea_horizontal_guardando		;4712   ; linea_horizontal_guardando: linea_horizontal sin perder HL, DE ni BC
	pop hl			;4715
	ld a,h			;4716   ; el derecho, en x + ancho - 1
	dec a			;4717
	add a,d			;4718
	ld h,a			;4719
	ld b,e			;471a
	jp linea_vertical_guardando		;471b   ; linea_vertical_guardando: linea_vertical sin perder HL, DE ni BC
linea_vertical_guardando:		; linea_vertical sin perder HL, DE ni BC
	push hl			;471e   ; guarda HL, DE y BC...
	push de			;471f
	push bc			;4720
	call linea_vertical		;4721   ; linea_vertical: orden LINE: B puntos desde (H, L) hacia abajo, del color C
	pop bc			;4724   ; ... y los devuelve
	pop de			;4725
	pop hl			;4726
	ret			;4727
linea_horizontal_guardando:		; linea_horizontal sin perder HL, DE ni BC
	push hl			;4728   ; guarda HL, DE y BC...
	push de			;4729
	push bc			;472a
	call linea_horizontal		;472b   ; linea_horizontal: orden LINE: B puntos desde (H, L) a la derecha, del color C
	pop bc			;472e   ; ... y los devuelve
	pop de			;472f
	pop hl			;4730
	ret			;4731
hmmv:		; orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)
	ex af,af'			;4732   ; H = x, L = y, D = pagina, B = ancho, C = alto (0 es 256), A = el color
	call espera_al_vdp		;4733   ; espera_al_vdp: espera a que el V9938 acabe la orden
	push bc			;4736
	ld a,(00007h)		;4737
	inc a			;473a
	ld c,a			;473b
	ld a,024h		;473c   ; desde el registro 36
	di			;473e
	out (c),a		;473f
	ld a,091h		;4741
	out (c),a		;4743
	inc c			;4745
	inc c			;4746
	out (c),h		;4747   ; DX = H
	xor a			;4749
	out (c),a		;474a
	out (c),l		;474c   ; DY = L, y su byte alto, la pagina
	out (c),d		;474e
	pop hl			;4750
	out (c),h		;4751   ; NX = B
	cp h			;4753
	jr nz,L_4757		;4754   ; 0 es 256
	inc a			;4756
L_4757:
	out (c),a		;4757   ; el byte alto de NX: 1 si es 256
	xor a			;4759
	out (c),l		;475a   ; NY = C
	cp l			;475c   ; el alto 0...
	jr nz,L_4760		;475d
	inc a			;475f   ; ... es 256
L_4760:
	out (c),a		;4760   ; el byte alto de NY
	ex af,af'			;4762
	out (c),a		;4763   ; CLR: en SCREEN 5, dos puntos por byte
	xor a			;4765
	out (c),a		;4766   ; ARG = 0
	ld a,0c0h		;4768   ; 0xC0: HMMV
	out (c),a		;476a
	ei			;476c   ; fin
	ret			;476d
hmmm:		; orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
	ex af,af'			;476e   ; H, L = origen; D, E = destino; B = ancho, C = alto; A: bits 0-1 pagina de origen, 2-3 de destino
	call espera_al_vdp		;476f   ; espera_al_vdp: espera a que el V9938 acabe la orden
	push bc			;4772
	ld a,(00007h)		;4773   ; el puerto de control
	inc a			;4776
	ld c,a			;4777
	ld a,020h		;4778   ; desde el registro 32 (SX)
	di			;477a
	out (c),a		;477b
	ld a,091h		;477d   ; al registro 17, con autoincremento
	out (c),a		;477f
	inc c			;4781   ; el de los registros indirectos
	inc c			;4782
	out (c),h		;4783   ; SX = H
	xor a			;4785
	out (c),a		;4786
	out (c),l		;4788   ; SY = L
	ex af,af'			;478a   ; las paginas
	ld l,a			;478b
	and 003h		;478c   ; y su pagina
	out (c),a		;478e
	out (c),d		;4790   ; DX = D
	xor a			;4792
	out (c),a		;4793
	out (c),e		;4795   ; DY = E
	ld a,l			;4797   ; y su pagina
	rra			;4798
	rra			;4799
	and 003h		;479a
	out (c),a		;479c
	pop hl			;479e
	out (c),h		;479f   ; NX = B
	xor a			;47a1
	out (c),a		;47a2
	out (c),l		;47a4   ; NY = C
	out (c),a		;47a6
	out (c),a		;47a8   ; CLR y ARG a 0
	out (c),a		;47aa
	ld a,0d0h		;47ac   ; 0xD0: HMMM
	out (c),a		;47ae
	ei			;47b0
	ret			;47b1
hmmc:		; orden HMMC del V9938: los puntos de HL a (D, E), B x C; pagina A
	ex af,af'			;47b2   ; D, E = destino, A = su pagina, B = ancho, C = alto, HL = los puntos
	call espera_al_vdp		;47b3   ; espera_al_vdp: espera a que el V9938 acabe la orden
	push bc			;47b6
	ld a,(00007h)		;47b7   ; el puerto de control
	inc a			;47ba
	ld c,a			;47bb
	ld a,024h		;47bc   ; desde el registro 36 (DX)
	di			;47be
	out (c),a		;47bf
	ld a,091h		;47c1   ; al registro 17
	out (c),a		;47c3
	inc c			;47c5
	inc c			;47c6
	out (c),d		;47c7   ; DX = D
	xor a			;47c9
	out (c),a		;47ca
	out (c),e		;47cc   ; DY = E y su pagina
	ex af,af'			;47ce
	out (c),a		;47cf
	pop de			;47d1
	out (c),d		;47d2   ; NX = B
	xor a			;47d4
	out (c),a		;47d5
	out (c),e		;47d7   ; NY = C
	out (c),a		;47d9
	ld a,(hl)			;47db   ; el primer byte va en CLR
	inc hl			;47dc
	out (c),a		;47dd
	xor a			;47df
	out (c),a		;47e0
	ld a,0f0h		;47e2   ; 0xF0: HMMC
	out (c),a		;47e4
	dec c			;47e6
	dec c			;47e7
	ld a,0ach		;47e8   ; el registro 17 a 44 (CLR), sin autoincremento: el resto por ahi
	out (c),a		;47ea
	ld a,091h		;47ec
	out (c),a		;47ee
	inc c			;47f0
	inc c			;47f1
L_47F2:
	ld a,002h		;47f2   ; el estado 2
	call lee_estado_del_vdp		;47f4   ; lee_estado_del_vdp: lee un registro de estado del V9938
	rra			;47f7
	ret nc			;47f8   ; el bit 0 (CE) a cero: acabo
	add a,a			;47f9   ; el bit 7 (TR): el VDP quiere el byte siguiente
	add a,a			;47fa
	jr nc,L_47F2		;47fb
	ld a,(hl)			;47fd   ; el byte siguiente
	inc hl			;47fe
	out (c),a		;47ff
	jr L_47F2		;4801
lmmm:		; orden LMMM del V9938: copia un rectangulo con operacion logica
	ex af,af'			;4803   ; H, L = origen; D, E = destino; B = ancho, C = alto; A: bits 6-7 pagina de origen, 4-5 de destino, 0-3 la operacion
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
	out (c),h		;4818   ; SX = H
	xor a			;481a
	out (c),a		;481b
	out (c),l		;481d   ; SY = L
	ex af,af'			;481f
	rlca			;4820
	rlca			;4821
	ld l,a			;4822
	and 003h		;4823
	out (c),a		;4825   ; la pagina de origen
	out (c),d		;4827   ; DX = D
	xor a			;4829
	out (c),a		;482a
	out (c),e		;482c   ; DY = E
	ld a,l			;482e
	ld e,a			;482f
	rlca			;4830
	rlca			;4831
	and 003h		;4832
	out (c),a		;4834   ; la pagina de destino
	pop hl			;4836
	out (c),h		;4837   ; NX = B
	xor a			;4839
	out (c),a		;483a
	out (c),l		;483c   ; NY = C
	out (c),a		;483e
	out (c),a		;4840
	out (c),a		;4842
	ld a,e			;4844   ; la operacion logica (bits 0-3)...
	rra			;4845
	rra			;4846
	and 00fh		;4847
	or 090h		;4849   ; ... con 0x90: LMMM
	out (c),a		;484b
	ei			;484d
	ret			;484e
sube_letras:		; sube B letras de 1 bit de HL a la VRAM, del color C
	call sube_una_letra		;484f   ; HL = las letras (8 bytes cada una), DE = el sitio de la primera
	call siguiente_sitio		;4852   ; siguiente_sitio: D 8 puntos a la derecha; al dar la vuelta, E 8 mas abajo
	djnz sube_letras		;4855
	ret			;4857
sube_una_letra:		; sube la letra de 1 bit de HL a (D, E) de la pagina 1, del color C
	push bc			;4858
	push de			;4859
	push hl			;485a
	push de			;485b
	call letra_a_4_bits		;485c   ; pasada a 4 bits en 0xC210
	pop de			;485f
	ld b,d			;4860   ; D = x, E = y: la direccion es y * 128 + x / 2
	ld d,e			;4861
	ld e,b			;4862
	srl d		;4863
	rr e		;4865
	ld a,d			;4867
	add a,080h		;4868   ; en la pagina 1 (0x8000)
	ld d,a			;486a
	ld hl,0c210h		;486b   ; y se sube
	call sube_un_dibujo		;486e   ; sube_un_dibujo: un dibujo de 8x8 a 4 bits (32 bytes) de HL a la VRAM de DE
	pop hl			;4871
	ld bc,00008h		;4872   ; HL a la letra siguiente
	add hl,bc			;4875
	pop de			;4876
	pop bc			;4877
	ret			;4878
sube_un_dibujo:		; un dibujo de 8x8 a 4 bits (32 bytes) de HL a la VRAM de DE
	push de			;4879   ; 8 filas
	ld b,008h		;487a
L_487C:
	push bc			;487c
	ld bc,00004h		;487d   ; de 4 bytes: 8 puntos a 4 bits
	call copia_a_la_vram		;4880   ; copia_a_la_vram: copia BC bytes de HL a la VRAM de DE
	ex de,hl			;4883
	ld bc,00080h		;4884   ; la fila siguiente, 128 bytes mas alla (256 puntos)
	add hl,bc			;4887
	ex de,hl			;4888
	pop bc			;4889
	djnz L_487C		;488a
	pop de			;488c
	ret			;488d
sube_dibujos:		; B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	push bc			;488e
	call sube_un_dibujo		;488f   ; HL = el dibujo, DE = su sitio en la VRAM
	ld a,004h		;4892   ; el siguiente, 4 bytes (8 puntos) a la derecha
	add a,e			;4894
	cp 080h		;4895   ; al llegar al final de la fila (128 bytes)...
	jr nz,L_489E		;4897
	ld a,004h		;4899   ; ... una fila de dibujos mas abajo (8 lineas de 128 bytes)
	add a,d			;489b
	ld d,a			;489c
	xor a			;489d
L_489E:
	ld e,a			;489e
	pop bc			;489f
	djnz sube_dibujos		;48a0
	ret			;48a2
sube_un_dibujo_de_16:		; un dibujo de 16x16 a 4 bits (128 bytes) de HL a la VRAM de DE
	push de			;48a3
	ld b,010h		;48a4   ; 16 lineas
L_48A6:
	push bc			;48a6
	ld bc,00008h		;48a7   ; de 8 bytes: 16 puntos a 4 bits
	call copia_a_la_vram		;48aa   ; copia_a_la_vram: copia BC bytes de HL a la VRAM de DE
	ex de,hl			;48ad
	ld bc,00080h		;48ae   ; la linea siguiente, 128 bytes mas alla
	add hl,bc			;48b1
	ex de,hl			;48b2
	pop bc			;48b3
	djnz L_48A6		;48b4
	pop de			;48b6
	ret			;48b7
sube_dibujos_de_16:		; B dibujos de 16x16 seguidos a la VRAM
	push bc			;48b8
	call sube_un_dibujo_de_16		;48b9   ; sube_un_dibujo_de_16: un dibujo de 16x16 a 4 bits (128 bytes) de HL a la VRAM de DE
	ld a,008h		;48bc   ; el siguiente, 8 bytes (16 puntos) a la derecha
	add a,e			;48be
	cp 080h		;48bf   ; al final de la fila...
	jr nz,L_48C8		;48c1
	ld a,008h		;48c3   ; ... 16 lineas mas abajo
	add a,d			;48c5
	ld d,a			;48c6
	xor a			;48c7
L_48C8:
	ld e,a			;48c8
	pop bc			;48c9
	djnz sube_dibujos_de_16		;48ca
	ret			;48cc
letra_a_4_bits:		; la letra de 1 bit de HL a 4 bits en 0xC210, del color C
	ld b,008h		;48cd   ; 8 filas
	ld de,0c210h		;48cf
L_48D2:
	push bc			;48d2
	push hl			;48d3
	ex de,hl			;48d4
	ld a,(de)			;48d5   ; D = la fila de la letra, 1 bit por punto
	ld d,a			;48d6
	ld b,004h		;48d7   ; 4 bytes de 2 puntos
L_48D9:
	ld a,c			;48d9   ; punto encendido: el color C
	rl d		;48da
	jr c,L_48DF		;48dc
	xor a			;48de   ; apagado: 0
L_48DF:
	rld		;48df   ; rld mete el nibble en (HL): el primer punto queda en el nibble alto
	ld a,c			;48e1   ; el segundo punto
	rl d		;48e2
	jr c,L_48E7		;48e4
	xor a			;48e6
L_48E7:
	rld		;48e7
	inc hl			;48e9   ; el byte siguiente de la fila de 4 bits
	djnz L_48D9		;48ea
	ex de,hl			;48ec
	pop hl			;48ed
	inc hl			;48ee   ; la fila siguiente de la letra
	pop bc			;48ef
	djnz L_48D2		;48f0
	ret			;48f2
rotulo:		; pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba
	ld c,0ffh		;48f3   ; C = 0xFF: las letras tal cual
	jr L_48F9		;48f5
borra_rotulo:		; borra un rotulo ([x][y] y el texto)
	ld c,000h		;48f7   ; C = 0: todo letra 0, un hueco
L_48F9:
	ld d,(hl)			;48f9   ; D = x, E = y
	inc hl			;48fa
	ld e,(hl)			;48fb
	inc hl			;48fc
rotulo_sin_posicion:		; pinta el texto de HL en DE (D = x, E = y), sin [x][y] delante; C = 0 borra
	ld a,(hl)			;48fd   ; la letra
	inc hl			;48fe
	ld b,a			;48ff
	inc b			;4900   ; 0xFF acaba
	ret z			;4901
	inc b			;4902   ; 0xFE: otra posicion detras
	jr z,rotulo		;4903
	push af			;4905
	and c			;4906   ; con C = 0 se pinta la 0: se borra
	call letra		;4907   ; letra: pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco
	pop af			;490a
	push bc			;490b
	sub 062h		;490c   ; 0x62 y 0x63, las marcas de encima, solo avanzan 4 puntos
	cp 002h		;490e
	ld b,008h		;4910   ; una letra, 8
	jr nc,L_4916		;4912
	ld b,004h		;4914
L_4916:
	ld a,d			;4916
	add a,b			;4917
	ld d,a			;4918
	pop bc			;4919
	jr rotulo_sin_posicion		;491a
letra:		; pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco
	push bc			;491c
	push hl			;491d
	push de			;491e
	or a			;491f   ; la letra 0 es el hueco de (0, 0) de la pagina 1
	ld h,a			;4920
	jr z,L_4928		;4921
	call sitio_del_caracter		;4923   ; las letras estan en la pagina 1...
	add a,038h		;4926   ; ... a partir de la y 0x38
L_4928:
	ld l,a			;4928
	ld bc,00808h		;4929   ; 8 x 8 puntos
	ld a,001h		;492c   ; de la pagina 1 a la 0
	call hmmm		;492e   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
	pop de			;4931
	pop hl			;4932
	pop bc			;4933
	ret			;4934
letra_repetida:		; pinta B veces la letra A seguidas
	push af			;4935
	call letra		;4936   ; letra: pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco
	call siguiente_sitio		;4939   ; siguiente_sitio: D 8 puntos a la derecha; al dar la vuelta, E 8 mas abajo
	pop af			;493c
	djnz letra_repetida		;493d
	ret			;493f
caracter:		; pinta el caracter A de la pagina 1 en DE de la pagina 0
	push bc			;4940
	push hl			;4941
	push de			;4942
	call sitio_del_caracter		;4943   ; sitio_del_caracter: H = x, L = y del caracter A en la pagina 1 (32 por fila)
	ld bc,00808h		;4946   ; 8 x 8 puntos
	ld a,001h		;4949   ; de la pagina 1 a la 0
	call hmmm		;494b   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
	pop de			;494e
	pop hl			;494f
	pop bc			;4950
	ret			;4951
caracter_transparente:		; como caracter, con LMMM y TIMP: el color 0 deja ver lo de debajo
	push bc			;4952
	push hl			;4953
	push de			;4954
	call sitio_del_caracter		;4955   ; sitio_del_caracter: H = x, L = y del caracter A en la pagina 1 (32 por fila)
	ld bc,00808h		;4958
	ld a,048h		;495b   ; de la pagina 1 a la 0, con TIMP (8): sin los puntos del color 0
	call lmmm		;495d   ; lmmm: orden LMMM del V9938: copia un rectangulo con operacion logica
	pop de			;4960
	pop hl			;4961
	pop bc			;4962
	ret			;4963
caracter_en_la_pagina_1:		; pinta el caracter A de la pagina 1 en DE de la misma pagina
	push bc			;4964
	push hl			;4965
	push de			;4966
	call sitio_del_caracter		;4967   ; sitio_del_caracter: H = x, L = y del caracter A en la pagina 1 (32 por fila)
	ld bc,00808h		;496a
	ld a,005h		;496d   ; de la pagina 1 a la 1
	call hmmm		;496f   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
	pop de			;4972
	pop hl			;4973
	pop bc			;4974
	ret			;4975
sitio_del_caracter:		; H = x, L = y del caracter A en la pagina 1 (32 por fila)
	ld b,a			;4976
	and 01fh		;4977   ; 32 caracteres por fila: x = (A mod 32) * 8
	add a,a			;4979
	add a,a			;497a
	add a,a			;497b
	ld h,a			;497c
	ld a,b			;497d
	and 0e0h		;497e   ; y = (A / 32) * 8
	rrca			;4980
	rrca			;4981
	ld l,a			;4982
	ret			;4983
siguiente_sitio:		; D 8 puntos a la derecha; al dar la vuelta, E 8 mas abajo
	ld a,d			;4984
	add a,008h		;4985   ; 8 puntos a la derecha
	ld d,a			;4987
	ret nz			;4988   ; si no ha dado la vuelta (256), ya esta
	ld a,e			;4989
	add a,008h		;498a   ; si la ha dado, una fila mas abajo
	ld e,a			;498c
	ret			;498d
prepara_el_vdp:		; pasa a SCREEN 5 y pone los registros del V9938
	call sonido_a_cero		;498e   ; sonido_a_cero: para la musica y los efectos y pone el mezclador del PSG
	call sprites_fuera		;4991   ; sprites_fuera: apaga los sprites (bit 1 del registro 8 del VDP)
	ld a,005h		;4994   ; SCREEN 5: 256 x 212 a 16 colores
	call 0005fh		;4996   ; BIOS CHGMOD - Switches to given screen mode
	call apaga_la_pantalla		;4999   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	xor a			;499c   ; la pagina 0 entera del color 0
	ld h,a			;499d
	ld l,a			;499e
	ld b,a			;499f
	ld c,a			;49a0
	ld d,a			;49a1
	call hmmv		;49a2   ; hmmv: orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)
	xor a			;49a5
	ld h,a			;49a6
	ld l,a			;49a7
	ld b,a			;49a8
	ld c,a			;49a9
	ld d,001h		;49aa   ; y la 1
	call hmmv		;49ac   ; hmmv: orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)
	call espera_al_vdp		;49af   ; espera_al_vdp: espera a que el V9938 acabe la orden
	ld b,004h		;49b2   ; cuatro registros de 0x49CA: R1 = 0x62, R5 = 0xEF, R6 = 0x1F y R11 = 0x01
	ld hl,049cah		;49b4
L_49B7:
	push bc			;49b7
	ld c,(hl)			;49b8   ; C = el registro, B = el valor
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


lee_los_mandos:		; en partida: F1-F3 a 0xC00C/0xC00B y el mando 1 con el teclado a 0xC007/0xC006
	ld a,(0c002h)		;49d2   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	and 040h		;49d5   ; solo con la partida en marcha (bit 6)
	ret z			;49d7
	call lee_f1_f3		;49d8   ; F1-F3...
	ld hl,0c00ch		;49db   ; ... a 0xC00C, y las recien apretadas a 0xC00B
	call apretado_y_nuevo		;49de   ; apretado_y_nuevo: guarda A en (HL) y en (HL-1) lo que no estaba apretado antes
	call lee_mando_y_teclado		;49e1   ; el mando y el teclado...
L_49E4:
	ld hl,0c007h		;49e4   ; ... a 0xC007, y lo recien apretado a 0xC006
apretado_y_nuevo:		; guarda A en (HL) y en (HL-1) lo que no estaba apretado antes
	ld c,(hl)			;49e7   ; C = lo de antes
	ld (hl),a			;49e8
	xor c			;49e9   ; lo que cambio y ahora esta apretado
	and (hl)			;49ea
	dec hl			;49eb
	ld (hl),a			;49ec
	ret			;49ed
lee_mando_y_teclado:		; A = el mando 1 y el teclado juntos: bits 0-3 direcciones, 4-5 botones
	ld e,08fh		;49ee   ; el registro 15 del PSG a 0x8F: lee el puerto del mando 1
	ld a,00fh		;49f0
	call 00093h		;49f2   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;49f5   ; el registro 14: el mando, con los bits a cero si estan apretados
	di			;49f7
	call 00096h		;49f8   ; BIOS RDPSG - Reads value from PSG-register
	ei			;49fb
	cpl			;49fc   ; bits 0-3 las direcciones, 4 y 5 los dos botones
	and 03fh		;49fd
	push af			;49ff
	ld a,006h		;4a00   ; la fila 6 del teclado
	call 00141h		;4a02   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4a05
	rlca			;4a06   ; el bit 1 (CTRL) pasa al 5: el segundo boton
	rlca			;4a07
	rlca			;4a08
	rlca			;4a09
	and 020h		;4a0a
	ld e,a			;4a0c
	ld a,008h		;4a0d   ; la fila 8: espacio y cursores
	call 00141h		;4a0f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4a12
	rrca			;4a13   ; el cursor izquierdo, al bit 2
	rrca			;4a14
	ld b,a			;4a15
	and 004h		;4a16
	or e			;4a18
	ld c,a			;4a19
	ld a,b			;4a1a
	rrca			;4a1b   ; la derecha al bit 3 y el espacio al 4: el primer boton
	rrca			;4a1c
	ld b,a			;4a1d
	and 018h		;4a1e
	or c			;4a20
	ld c,a			;4a21
	ld a,b			;4a22
	rrca			;4a23   ; arriba y abajo, a los bits 0 y 1
	and 003h		;4a24
	or c			;4a26
	ld e,a			;4a27
	ld a,002h		;4a28   ; la fila 2
	call 00141h		;4a2a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4a2d
	rrca			;4a2e   ; el bit 6 pasa al 4: otra tecla para el primer boton
	rrca			;4a2f
	ld b,a			;4a30
	and 010h		;4a31
	or e			;4a33
	pop bc			;4a34   ; y se junta con el mando
	or b			;4a35
	ret			;4a36
lee_f1_f3:		; A = F1, F2 y F3 en los bits 0-2
	ld a,006h		;4a37
	call 00141h		;4a39   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | la fila 6: F1, F2 y F3 son los bits 5, 6 y 7
	cpl			;4a3c
	rlca			;4a3d   ; a los bits 0, 1 y 2
	rlca			;4a3e
	rlca			;4a3f
	and 007h		;4a40
	ret			;4a42
dibujos_de_konami:		; sube los dibujos del logotipo de Konami
	call bancos_4_5_6		;4a43   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld hl,0bc92h		;4a46   ; las letras del logotipo de Konami, en tres tandas de tres colores
	ld de,00800h		;4a49
	ld bc,00d01h		;4a4c   ; 13 letras del color 1
	call sube_letras		;4a4f   ; sube_letras: sube B letras de 1 bit de HL a la VRAM, del color C
	ld hl,0bcfah		;4a52
	ld de,07000h		;4a55
	ld bc,00d02h		;4a58   ; 13 del color 2
	call sube_letras		;4a5b   ; sube_letras: sube B letras de 1 bit de HL a la VRAM, del color C
	ld hl,0bd62h		;4a5e
	ld de,0d800h		;4a61
	ld bc,01a03h		;4a64   ; 26 del color 3
	call sube_letras		;4a67   ; sube_letras: sube B letras de 1 bit de HL a la VRAM, del color C
	jp bancos_1_2_3		;4a6a   ; bancos_1_2_3: pone los bancos 1, 2 y 3
letras_del_texto:		; sube las letras de los textos
	call bancos_13_14_15		;4a6d   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld de,00040h		;4a70
	ld hl,0929dh		;4a73   ; las letras de los textos (banco 14): 0x91 letras del color 0x0E
	ld bc,0910eh		;4a76
	call sube_letras		;4a79   ; sube_letras: sube B letras de 1 bit de HL a la VRAM, del color C
	ld de,08860h		;4a7c
	ld hl,09725h		;4a7f
	ld bc,00a03h		;4a82   ; 10 del color 3
	call sube_letras		;4a85   ; sube_letras: sube B letras de 1 bit de HL a la VRAM, del color C
	ld hl,09775h		;4a88   ; y 3 dibujos de 8x8 a 4 bits
	ld de,0b06ch		;4a8b
	ld b,003h		;4a8e
	call sube_dibujos		;4a90   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	jp bancos_1_2_3		;4a93   ; bancos_1_2_3: pone los bancos 1, 2 y 3
caracteres_del_juego:		; sube los caracteres del juego de graficos de la zona
	call bancos_4_5_6		;4a96   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld a,(0c289h)		;4a99   ; un juego de caracteres por juego de graficos
	add a,a			;4a9c
	ld hl,04c4bh		;4a9d   ; la tabla de 0x4C4B, punteros al banco 4-5-6
	call palabra_de_tabla		;4aa0   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ex de,hl			;4aa3
	ld hl,0d000h		;4aa4   ; descomprimidos a 0xD000
	call rle_a_la_ram		;4aa7   ; rle_a_la_ram: descomprime un rle a la RAM
	ld a,(0c289h)		;4aaa   ; lee el juego de graficos de la zona
	cp 003h		;4aad   ; el juego 3 los reparte de otra manera
	jp z,L_4B15		;4aaf
	ld hl,0d000h		;4ab2   ; 0x8A dibujos de 8x8 a la pagina 1, desde x 8
	ld de,08004h		;4ab5
	ld b,08ah		;4ab8
	call sube_dibujos		;4aba   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	call vueltos_del_juego		;4abd   ; y los que van dados la vuelta, de la tabla de 0x4C57
	ld a,(0c289h)		;4ac0   ; lee el juego de graficos de la zona
	cp 002h		;4ac3   ; el juego 2 no lleva
	jr z,L_4ACA		;4ac5
	call sube_dibujos_vueltos		;4ac7   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
L_4ACA:
	call bancos_7_8_9		;4aca   ; lo comun a todos los juegos, del banco 7
	ld hl,06000h		;4acd
	ld de,09400h		;4ad0   ; 30 dibujos en y 0x28 de la pagina 1
	ld b,01eh		;4ad3
	call sube_dibujos		;4ad5   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	ld hl,061a0h		;4ad8   ; y 17 dados la vuelta detras
	ld de,09478h		;4adb
	ld b,011h		;4ade
	call sube_dibujos_vueltos		;4ae0   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	ld hl,063c0h		;4ae3   ; 42 mas, en y 0x30
	ld de,0983ch		;4ae6
	ld b,02ah		;4ae9
	call sube_dibujos		;4aeb   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	ld a,(0c289h)		;4aee   ; lee el juego de graficos de la zona
	cp 005h		;4af1   ; el juego 5 lleva cuatro dibujos mas
	jr nz,L_4B12		;4af3
	ld b,004h		;4af5   ; cuatro: dos de 0x92D9 y dos de 0x92F9
	ld de,0941ch		;4af7
L_4AFA:
	push bc			;4afa
	ld hl,092d9h		;4afb
	ld a,b			;4afe   ; los dos primeros (B = 4 y 3)...
	cp 003h		;4aff
	jr nc,L_4B06		;4b01
	ld hl,092f9h		;4b03   ; ... de 0x92D9, y los otros de 0x92F9
L_4B06:
	push de			;4b06
	call sube_un_dibujo		;4b07   ; sube el dibujo
	pop de			;4b0a
	inc de			;4b0b   ; el siguiente, 8 puntos a la derecha
	inc de			;4b0c
	inc de			;4b0d
	inc de			;4b0e
	pop bc			;4b0f
	djnz L_4AFA		;4b10
L_4B12:
	jp bancos_1_2_3		;4b12   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4B15:
	ld hl,0d000h		;4b15   ; el juego 3: seis tandas, unas tal cual y otras dadas la vuelta
	ld de,08004h		;4b18
	ld b,00dh		;4b1b
	call sube_dibujos		;4b1d   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	ld hl,0d040h		;4b20
	ld de,08038h		;4b23
	ld b,00bh		;4b26
	call sube_dibujos_vueltos		;4b28   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	ld hl,0d1a0h		;4b2b
	ld de,08064h		;4b2e
	ld b,016h		;4b31
	call sube_dibujos		;4b33   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	ld hl,0d380h		;4b36
	ld de,0843ch		;4b39
	ld b,007h		;4b3c
	call sube_dibujos_vueltos		;4b3e   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	ld hl,0d460h		;4b41
	ld de,08458h		;4b44
	ld b,057h		;4b47
	call sube_dibujos		;4b49   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	ld hl,0dd60h		;4b4c
	ld de,09034h		;4b4f
	ld b,00fh		;4b52
	call sube_dibujos_vueltos		;4b54   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	call bancos_1_2_3		;4b57   ; y lo comun a todos
	jp L_4ACA		;4b5a
dibujos_del_laberinto:		; los dibujos, la paleta y los sprites del laberinto
	call bancos_7_8_9		;4b5d   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,06820h		;4b60   ; los dibujos del laberinto, del banco 7
	ld de,08004h		;4b63
	ld b,03bh		;4b66
	call sube_dibujos		;4b68   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	ld hl,06ac0h		;4b6b   ; y los que van dados la vuelta
	ld de,08800h		;4b6e
	ld b,025h		;4b71
	call sube_dibujos_vueltos		;4b73   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	call paleta_base		;4b76   ; paleta_base: pone la paleta base
	call bancos_7_8_9		;4b79   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a438h		;4b7c   ; con su paleta
	call pon_paleta		;4b7f   ; pon_paleta: pone una lista de colores en la paleta
	call bancos_10_11_12		;4b82   ; bancos_10_11_12: pone los bancos 10, 11 y 12
	ld hl,0f9c0h		;4b85   ; y los patrones de sprite del laberinto, del banco 11, a 0xF9C0
	ld de,084aah		;4b88
	call rle_a_la_vram		;4b8b   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4b8e   ; bancos_1_2_3: pone los bancos 1, 2 y 3
caracteres_del_titulo:		; sube los caracteres del titulo
	call bancos_4_5_6		;4b91   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld hl,0ae7ch		;4b94   ; 46 dibujos del titulo, del banco 6
	ld de,08004h		;4b97
	ld b,02eh		;4b9a
	call sube_dibujos		;4b9c   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	ld hl,0f800h		;4b9f   ; y los patrones de sus sprites, a 0xF800
	ld de,0b43ch		;4ba2
	call rle_a_la_vram		;4ba5   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4ba8   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4BAB:
	call bancos_7_8_9		;4bab   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,08acch		;4bae
	ld de,08004h		;4bb1   ; 46 dibujos a la pagina 1, del banco 8
	ld b,02eh		;4bb4
	call sube_dibujos		;4bb6   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	ld hl,0f800h		;4bb9   ; y los patrones de sprite
	ld de,08f4ch		;4bbc
	call rle_a_la_vram		;4bbf   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4bc2   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4BC5:
	call bancos_7_8_9		;4bc5   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0858ch		;4bc8   ; 46 dibujos del banco 8
	ld de,08004h		;4bcb
	ld b,02eh		;4bce
	call sube_dibujos		;4bd0   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	ld hl,086ech		;4bd3   ; y 31 dados la vuelta
	ld de,0842ch		;4bd6
	ld b,01fh		;4bd9
	call sube_dibujos_vueltos		;4bdb   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	ld hl,0f800h		;4bde   ; los patrones de sprite: unos para el jugador 1 (Goemon)...
	ld de,09810h		;4be1
	ld a,(0c002h)		;4be4   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	add a,a			;4be7
	jr nc,L_4BED		;4be8
	ld de,09df6h		;4bea   ; ... y otros para el 2 (Ebisumaru)
L_4BED:
	call rle_a_la_vram		;4bed   ; rle_a_la_vram: descomprime un rle a la VRAM
	ld hl,0f880h		;4bf0   ; mas patrones, a 0xF880
	ld de,09fb0h		;4bf3
	call rle_a_la_vram		;4bf6   ; rle_a_la_vram: descomprime un rle a la VRAM
	ld hl,0fa00h		;4bf9   ; los mismos dados la vuelta, a 0xFA00
	ld de,09fb0h		;4bfc
	call rle_vuelto		;4bff   ; rle_vuelto: descomprime sprites de 16x16 dados la vuelta (espejo) y los sube a la VRAM de HL
	ld hl,0fb80h		;4c02   ; y otros a 0xFB80
	ld de,0a10eh		;4c05
	call rle_a_la_vram		;4c08   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4c0b   ; bancos_1_2_3: pone los bancos 1, 2 y 3
vueltos_del_juego:		; de la tabla de 0x4C57: DE el sitio, B cuantos y HL de donde, de los dibujos que van dados la vuelta
	ld a,(0c289h)		;4c0e   ; 5 bytes por juego: [VRAM][cuantos][de donde]
	ld b,a			;4c11
	add a,a			;4c12
	add a,a			;4c13
	add a,b			;4c14
	ld hl,04c57h		;4c15
	call hl_mas_a		;4c18   ; hl_mas_a: HL += A
	ld e,(hl)			;4c1b   ; DE = el sitio en la VRAM
	inc hl			;4c1c
	ld d,(hl)			;4c1d
	inc hl			;4c1e
	ld b,(hl)			;4c1f   ; B = cuantos dibujos
	inc hl			;4c20
	ld a,(hl)			;4c21   ; HL = de donde
	inc hl			;4c22
	ld h,(hl)			;4c23
	ld l,a			;4c24
	ret			;4c25
dibujos_tras_perder_una_vida:		; los dibujos y los patrones de sprite de la pantalla del estado 4, paso 0
	call bancos_4_5_6		;4c26   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld hl,0a7e0h		;4c29   ; 31 dibujos, del banco 6
	ld de,08004h		;4c2c
	ld b,01fh		;4c2f
	call sube_dibujos		;4c31   ; sube_dibujos: B dibujos de 8x8 seguidos a la VRAM, 32 por fila
	ld hl,0a9c0h		;4c34   ; y 16 dados la vuelta
	ld de,08400h		;4c37
	ld b,010h		;4c3a
	call sube_dibujos_vueltos		;4c3c   ; sube_dibujos_vueltos: sube dibujos dados la vuelta
	ld hl,0f800h		;4c3f   ; y los patrones de sprite
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
	ld de,0ee83h		;4c77   ; se montan en 0xEE80, cada fila de atras adelante
	ld c,008h		;4c7a   ; 8 filas
L_4C7C:
	ld b,004h		;4c7c   ; de 4 bytes
L_4C7E:
	ld a,(hl)			;4c7e
	rrca			;4c7f   ; los dos puntos del byte cambiados de sitio
	rrca			;4c80
	rrca			;4c81
	rrca			;4c82
	ld (de),a			;4c83
	inc hl			;4c84
	dec de			;4c85   ; y el byte va al otro extremo de la fila
	djnz L_4C7E		;4c86
	ld a,008h		;4c88   ; la fila siguiente
	call de_mas_a		;4c8a   ; de_mas_a: DE += A
	dec c			;4c8d
	jr nz,L_4C7C		;4c8e
	pop de			;4c90
	push hl			;4c91
	ld hl,0ee80h		;4c92   ; y se sube como un dibujo normal
	call sube_un_dibujo		;4c95   ; sube_un_dibujo: un dibujo de 8x8 a 4 bits (32 bytes) de HL a la VRAM de DE
	pop hl			;4c98
	ld a,e			;4c99   ; el siguiente, 8 puntos a la derecha
	add a,004h		;4c9a
	ld e,a			;4c9c
	cp 080h		;4c9d   ; al final de la fila, una fila de dibujos mas abajo
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
	rla			;4cb1   ; el bit 7: el jugador 2 tiene otros
	ld hl,09319h		;4cb2   ; los de Goemon
	jr nc,L_4CBA		;4cb5
	ld hl,09341h		;4cb7   ; los de Ebisumaru
L_4CBA:
	ld a,(0c49fh)		;4cba   ; 4 entradas por accion...
	add a,a			;4cbd
	add a,a			;4cbe
	ld b,a			;4cbf
	ld a,(0c4a2h)		;4cc0   ; ... una por lado
	add a,b			;4cc3
	add a,a			;4cc4
	call hl_mas_a		;4cc5   ; hl_mas_a: HL += A
	ld e,(hl)			;4cc8
	inc hl			;4cc9
	ld d,(hl)			;4cca
	ld hl,0f800h		;4ccb   ; a 0xF800, los patrones de sprite
	call rle_a_la_vram		;4cce   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4cd1   ; bancos_1_2_3: pone los bancos 1, 2 y 3
patrones_del_final:		; los patrones de sprite de 0xBE32 (banco 6) a 0xF800
	call bancos_4_5_6		;4cd4   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	ld hl,0f800h		;4cd7   ; los patrones de sprite de 0xBE32 (banco 6)
	ld de,0be32h		;4cda
	call rle_a_la_vram		;4cdd   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4ce0   ; bancos_1_2_3: pone los bancos 1, 2 y 3
paleta_de_la_zona:		; pone la paleta del juego de graficos de la zona
	call paleta_base		;4ce3   ; la base, y encima...
	call bancos_7_8_9		;4ce6   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a37ah		;4ce9   ; ... la del juego de graficos (tabla de 0xA37A, banco 9)
	ld a,(0c289h)		;4cec   ; lee el juego de graficos de la zona
	add a,a			;4cef
	call palabra_de_tabla		;4cf0   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	call pon_paleta		;4cf3   ; pon_paleta: pone una lista de colores en la paleta
	call bancos_1_2_3		;4cf6   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	jp colores_del_sitio		;4cf9   ; y lo que cambia el sitio
paleta_base:		; pone la paleta base
	call bancos_7_8_9		;4cfc   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a3e6h		;4cff   ; los 16 colores de 0xA3E6
	call pon_paleta		;4d02   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d05   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4D08:
	call bancos_7_8_9		;4d08   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a3ffh		;4d0b   ; otra lista, la de 0xA3FF
	call pon_paleta		;4d0e   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d11   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4D14:
	call bancos_7_8_9		;4d14   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	call pantalla_de_la_casilla		;4d17   ; la pantalla de esta casilla
	ld b,a			;4d1a
	call bancos_1_2_3		;4d1b   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	inc b			;4d1e   ; solo la 0xFF...
	ret nz			;4d1f
	call bancos_7_8_9		;4d20   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a42bh		;4d23   ; ... lleva los colores de 0xA42B
	call pon_paleta		;4d26   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d29   ; bancos_1_2_3: pone los bancos 1, 2 y 3
colores_del_sitio:		; cambia los colores del sitio (0xC267)
	call bancos_7_8_9		;4d2c   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld a,(0c289h)		;4d2f   ; lee el juego de graficos de la zona
	add a,a			;4d32
	ld hl,0a4c5h		;4d33   ; una tabla por juego de graficos (0xA4C5)...
	call palabra_de_tabla		;4d36   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld a,(0c267h)		;4d39   ; ... y en ella una lista por sitio
	add a,a			;4d3c
	call palabra_de_tabla		;4d3d   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld a,(hl)			;4d40   ; una lista que empieza por 0xFF esta vacia
	inc a			;4d41
	call nz,pon_paleta		;4d42   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d45   ; bancos_1_2_3: pone los bancos 1, 2 y 3
paleta_del_titulo:		; pone la paleta de 0xA44E (banco 9)
	call bancos_7_8_9		;4d48   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a44eh		;4d4b   ; la paleta de 0xA44E
	call pon_paleta		;4d4e   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d51   ; bancos_1_2_3: pone los bancos 1, 2 y 3
paleta_tras_perder_una_vida:		; la paleta base y la de 0xA476
	call paleta_base		;4d54   ; paleta_base: pone la paleta base
	call bancos_7_8_9		;4d57   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a476h		;4d5a   ; la base y la de 0xA476
	call pon_paleta		;4d5d   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d60   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4D63:
	call paleta_base		;4d63   ; paleta_base: pone la paleta base
	call bancos_7_8_9		;4d66   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a4b8h		;4d69   ; la base y la de 0xA4B8
	call pon_paleta		;4d6c   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d6f   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_4D72:
	call paleta_base		;4d72   ; paleta_base: pone la paleta base
	call bancos_7_8_9		;4d75   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0a48fh		;4d78   ; la base y la de 0xA48F
	call pon_paleta		;4d7b   ; pon_paleta: pone una lista de colores en la paleta
	jp bancos_1_2_3		;4d7e   ; bancos_1_2_3: pone los bancos 1, 2 y 3
palabra_de_tabla:		; HL = la palabra A de la tabla de HL
	call hl_mas_a		;4d81   ; hl_mas_a: HL += A
	ld a,(hl)			;4d84   ; la palabra, el byte bajo primero
	inc hl			;4d85
	ld h,(hl)			;4d86
	ld l,a			;4d87
	ret			;4d88
sprites_de_0xF8C0:		; patrones de sprite de 0x9369 (banco 8) a 0xF8C0 y de 0x87D1 (banco 11) a 0xF900
	call bancos_7_8_9		;4d89   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,0f8c0h		;4d8c   ; patrones de sprite de 0x9369 (banco 8) a 0xF8C0
	ld de,09369h		;4d8f
	call rle_a_la_vram		;4d92   ; rle_a_la_vram: descomprime un rle a la VRAM
	call bancos_10_11_12		;4d95   ; bancos_10_11_12: pone los bancos 10, 11 y 12
	ld hl,0f900h		;4d98   ; y de 0x87D1 (banco 11) a 0xF900
	ld de,087d1h		;4d9b
	call rle_a_la_vram		;4d9e   ; rle_a_la_vram: descomprime un rle a la VRAM
	jp bancos_1_2_3		;4da1   ; bancos_1_2_3: pone los bancos 1, 2 y 3
dibujos_de_siempre:		; los dibujos de la pagina 1 que estan en todas las zonas (bancos 7 y 8)
	call bancos_7_8_9		;4da4   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	ld hl,06f60h		;4da7   ; 21 dibujos de 16x16 del banco 7 a la pagina 1, en y 0x80
	ld de,0c000h		;4daa   ; DE = 0xC000 de la VRAM: la pagina 1, y 0x80
	ld b,015h		;4dad
	call sube_dibujos_de_16		;4daf   ; sube_dibujos_de_16: B dibujos de 16x16 seguidos a la VRAM
	ld hl,079e0h		;4db2   ; 4 mas, en (0x60, 0x90)
	ld de,0c830h		;4db5
	ld b,004h		;4db8
	call sube_dibujos_de_16		;4dba   ; sube_dibujos_de_16: B dibujos de 16x16 seguidos a la VRAM
	ld hl,07be0h		;4dbd   ; y 3 en (0xB0, 0x90)
	ld de,0c858h		;4dc0
	ld b,003h		;4dc3
	call sube_dibujos_de_16		;4dc5   ; sube_dibujos_de_16: B dibujos de 16x16 seguidos a la VRAM
	ld hl,07d60h		;4dc8   ; lo demas, rectangulos de la pagina 1 de muchos tamanos: D, E = x, y; B x C
	ld de,000a0h		;4dcb
	ld bc,02003h		;4dce
	call hmmc_a_la_pagina_1		;4dd1   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,07d90h		;4dd4
	ld de,000a4h		;4dd7
	ld bc,00814h		;4dda
	call hmmc_a_la_pagina_1		;4ddd   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,07de0h		;4de0
	ld de,018a4h		;4de3
	ld bc,00814h		;4de6
	call hmmc_a_la_pagina_1		;4de9   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,07e30h		;4dec
	ld de,000b8h		;4def
	ld bc,02008h		;4df2
	call hmmc_a_la_pagina_1		;4df5   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,07eb0h		;4df8
	ld de,020a0h		;4dfb
	ld bc,02010h		;4dfe
	call hmmc_a_la_pagina_1		;4e01   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,07fb0h		;4e04
	ld de,020b0h		;4e07
	ld bc,0060fh		;4e0a
	call hmmc_a_la_pagina_1		;4e0d   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,07fddh		;4e10
	ld de,03ab0h		;4e13
	ld bc,0060fh		;4e16
	call hmmc_a_la_pagina_1		;4e19   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,0800ah		;4e1c   ; desde aqui, del banco 8
	ld bc,0161bh		;4e1f
	ld de,090a0h		;4e22
	call hmmc_a_la_pagina_1		;4e25   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,08413h		;4e28
	ld bc,01a1dh		;4e2b
	ld de,0c8a0h		;4e2e
	call hmmc_a_la_pagina_1		;4e31   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,08133h		;4e34
	ld de,0a8a0h		;4e37
	ld bc,00820h		;4e3a
	call hmmc_a_la_pagina_1		;4e3d   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,08233h		;4e40
	ld de,000c0h		;4e43
	ld bc,00c10h		;4e46
	call hmmc_a_la_pagina_1		;4e49   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,08293h		;4e4c
	ld de,010c0h		;4e4f
	ld bc,00810h		;4e52
	call hmmc_a_la_pagina_1		;4e55   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,082d3h		;4e58
	ld de,018c0h		;4e5b
	ld bc,02010h		;4e5e
	call hmmc_a_la_pagina_1		;4e61   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,083d3h		;4e64
	ld de,000d0h		;4e67
	ld bc,01008h		;4e6a
	call hmmc_a_la_pagina_1		;4e6d   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld hl,081b3h		;4e70
	ld de,0c0a0h		;4e73
	ld bc,00820h		;4e76
	call hmmc_a_la_pagina_1		;4e79   ; hmmc_a_la_pagina_1: hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	jp bancos_1_2_3		;4e7c   ; bancos_1_2_3: pone los bancos 1, 2 y 3
hmmc_a_la_pagina_1:		; hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1
	ld a,001h		;4e7f   ; A = 1: la pagina 1
	jp hmmc		;4e81   ; hmmc: orden HMMC del V9938: los puntos de HL a (D, E), B x C; pagina A
pinta_pieza:		; pinta la pieza de 16x16 de (B, C) de la pagina 1 en (D, E) + (0xCD28, 0xCD27) y la marca en 0xD800
	ld a,(0cd27h)		;4e84   ; E += la y de la pieza (0xCD27)
	add a,e			;4e87
	ld e,a			;4e88
	ld a,(0cd28h)		;4e89   ; D += la x (0xCD28)
	add a,d			;4e8c
	ld d,a			;4e8d
L_4E8E:
	push bc			;4e8e   ; HL = la pieza en la pagina 1 (H = x, L = y)
	pop hl			;4e8f
	push bc			;4e90
	ld bc,01010h		;4e91   ; 16 x 16 puntos
	push de			;4e94
	ld a,048h		;4e95   ; de la pagina 1 a la 0 con TIMP: el color 0 es transparente
	call lmmm		;4e97   ; lmmm: orden LMMM del V9938: copia un rectangulo con operacion logica
	pop de			;4e9a
	pop bc			;4e9b
	call marca_el_caracter		;4e9c   ; y la marca de 0xCD2A en sus cuatro caracteres de 0xD800
	ld a,008h		;4e9f   ; el de arriba a la derecha
	add a,d			;4ea1
	ld d,a			;4ea2
	call marca_el_caracter		;4ea3   ; marca_el_caracter: pone la marca de 0xCD2A en el caracter (D, E) del mapa de 0xD800
	ld a,0f8h		;4ea6   ; el de abajo a la izquierda
	add a,d			;4ea8
	ld d,a			;4ea9
	ld a,008h		;4eaa
	add a,e			;4eac
	ld e,a			;4ead
	call marca_el_caracter		;4eae   ; marca_el_caracter: pone la marca de 0xCD2A en el caracter (D, E) del mapa de 0xD800
	ld a,008h		;4eb1   ; el de abajo a la derecha
	add a,d			;4eb3
	ld d,a			;4eb4
	call marca_el_caracter		;4eb5   ; marca_el_caracter: pone la marca de 0xCD2A en el caracter (D, E) del mapa de 0xD800
	ret			;4eb8
pinta_icono:		; pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
	inc a			;4eb9   ; 0xFF: borrar el icono
	jr z,borra_icono		;4eba
	dec a			;4ebc
	push af			;4ebd
	push de			;4ebe
	ld de,04efch		;4ebf   ; el sitio del icono A en la pagina 1, de la tabla de 0x4EFC
	call palabra_de_tabla_de		;4ec2   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;4ec5
	pop de			;4ec6
	pop af			;4ec7
	cp 00eh		;4ec8   ; el 0x0E es de 32 x 32
	ld bc,02020h		;4eca
	jr z,L_4ED2		;4ecd
	ld bc,01010h		;4ecf   ; los demas, de 16 x 16
L_4ED2:
	ld a,001h		;4ed2   ; de la pagina 1 a la 0
	jp hmmm		;4ed4   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
borra_icono:		; pinta en blanco los cuatro caracteres de 16x16 desde DE
	ld hl,00000h		;4ed7   ; cuatro caracteres en blanco: arriba a la izquierda
	call caracter_en_blanco		;4eda   ; caracter_en_blanco: DE += HL y pinta alli el caracter en blanco
	ld hl,00800h		;4edd   ; arriba a la derecha
	call caracter_en_blanco		;4ee0   ; caracter_en_blanco: DE += HL y pinta alli el caracter en blanco
	ld hl,0f808h		;4ee3   ; abajo a la izquierda
	call caracter_en_blanco		;4ee6   ; caracter_en_blanco: DE += HL y pinta alli el caracter en blanco
	ld hl,00800h		;4ee9   ; abajo a la derecha
caracter_en_blanco:		; DE += HL y pinta alli el caracter en blanco
	add hl,de			;4eec
	ex de,hl			;4eed
	ld hl,00000h		;4eee   ; el caracter (0, 0) de la pagina 1, en blanco
copia_caracter:		; el caracter de (H, L) de la pagina 1 en (D, E) de la 0 (LMMM IMP)
	push de			;4ef1
	ld bc,00808h		;4ef2
	ld a,040h		;4ef5   ; de la pagina 1 a la 0, IMP
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


marca_el_caracter:		; pone la marca de 0xCD2A en el caracter (D, E) del mapa de 0xD800
	push de			;4f26
	push bc			;4f27
	ex de,hl			;4f28   ; HL = (x, y)
	ld c,h			;4f29
	ld a,l			;4f2a   ; el mapa empieza en la y 0x20, debajo del marcador
	sub 020h		;4f2b
	and 0f8h		;4f2d   ; la fila de caracteres por 32
	ld l,a			;4f2f
	ld h,000h		;4f30
	ld b,h			;4f32
	add hl,hl			;4f33
	add hl,hl			;4f34
	srl c		;4f35   ; mas la columna (x / 8)
	srl c		;4f37
	srl c		;4f39
	add hl,bc			;4f3b
	ld bc,0d800h		;4f3c   ; 0xD800: un byte por caracter de la pantalla
	add hl,bc			;4f3f
	ld a,(0cd2ah)		;4f40   ; la marca
	ld (hl),a			;4f43
	pop bc			;4f44
	pop de			;4f45
	ret			;4f46
pinta_pasadizo:		; pinta el pasadizo A con la pieza de (0x00, 0x80): 9 filas de bits de 0xAB18 (banco 9)
	push af			;4f47
	call bancos_7_8_9		;4f48   ; bancos_7_8_9: pone los bancos 7, 8 y 9
	xor a			;4f4b   ; la pieza en su sitio, sin desplazar
	ld (0cd27h),a		;4f4c   ; guarda lo que se baja la pieza
	ld (0cd28h),a		;4f4f   ; guarda lo que se corre la pieza
	ld de,00020h		;4f52   ; la fila de arriba, en y 0x20: entera (16 piezas)
	ld a,0ffh		;4f55
	call ocho_piezas		;4f57   ; ocho_piezas: pinta la pieza de BC donde haya un bit a uno en A, de 16 en 16 puntos
	ld a,0ffh		;4f5a
	call ocho_piezas		;4f5c   ; ocho_piezas: pinta la pieza de BC donde haya un bit a uno en A, de 16 en 16 puntos
	ld de,000c0h		;4f5f   ; y la de abajo, en y 0xC0
	ld a,0ffh		;4f62
	call ocho_piezas		;4f64   ; ocho_piezas: pinta la pieza de BC donde haya un bit a uno en A, de 16 en 16 puntos
	ld a,0ffh		;4f67
	call ocho_piezas		;4f69   ; ocho_piezas: pinta la pieza de BC donde haya un bit a uno en A, de 16 en 16 puntos
	pop af			;4f6c
	add a,a			;4f6d   ; 18 bytes por pasadizo...
	ld l,a			;4f6e
	ld h,000h		;4f6f
	ld e,a			;4f71
	ld d,000h		;4f72
	add hl,hl			;4f74
	add hl,hl			;4f75
	add hl,hl			;4f76
	add hl,de			;4f77
	ld de,0ab18h		;4f78   ; ... en la tabla de 0xAB18 (banco 9)
	add hl,de			;4f7b
	ld de,00030h		;4f7c   ; las 9 filas de en medio, desde y 0x30
	ld b,009h		;4f7f
L_4F81:
	ld a,(hl)			;4f81   ; dos bytes por fila: un bit por pieza, de izquierda a derecha
	inc hl			;4f82
	call ocho_piezas		;4f83   ; ocho_piezas: pinta la pieza de BC donde haya un bit a uno en A, de 16 en 16 puntos
	ld a,(hl)			;4f86
	inc hl			;4f87
	call ocho_piezas		;4f88   ; ocho_piezas: pinta la pieza de BC donde haya un bit a uno en A, de 16 en 16 puntos
	ld a,010h		;4f8b   ; la fila siguiente, 16 puntos mas abajo
	add a,e			;4f8d
	ld e,a			;4f8e
	djnz L_4F81		;4f8f
	jp bancos_1_2_3		;4f91   ; bancos_1_2_3: pone los bancos 1, 2 y 3
ocho_piezas:		; pinta la pieza de BC donde haya un bit a uno en A, de 16 en 16 puntos
	ld c,b			;4f94   ; 8 bits: 8 piezas
	ld b,008h		;4f95
L_4F97:
	rla			;4f97   ; el bit de arriba primero
	push af			;4f98
	jr nc,L_4FAC		;4f99   ; a cero, no hay pieza
	push de			;4f9b
	push hl			;4f9c
	push bc			;4f9d
	ld bc,00080h		;4f9e   ; la pieza de (0x00, 0x80) de la pagina 1
	ld a,0ffh		;4fa1   ; y su marca en 0xD800: 0xFF
	ld (0cd2ah),a		;4fa3   ; guarda la marca que se pone en 0xD800
	call pinta_pieza		;4fa6   ; pinta_pieza: pinta la pieza de 16x16 de (B, C) de la pagina 1 en (D, E) + (0xCD28, 0xCD27) y la marca en 0xD800
	pop bc			;4fa9
	pop hl			;4faa
	pop de			;4fab
L_4FAC:
	ld a,010h		;4fac   ; 16 puntos a la derecha
	add a,d			;4fae
	ld d,a			;4faf
	pop af			;4fb0
	djnz L_4F97		;4fb1
	ld b,c			;4fb3
	ret			;4fb4
sonido_a_cero:		; para la musica y los efectos y pone el mezclador del PSG
	ld a,0bch		;4fb5   ; el mezclador a 0xBC: tono en los canales A y B; el C y los tres ruidos cerrados
	ld (0c09fh),a		;4fb7   ; guarda la copia del registro 7 del PSG (el mezclador)
	xor a			;4fba   ; sin fundido...
	ld (0c0a9h),a		;4fbb
	ld (0c0aah),a		;4fbe
	ld (0c0abh),a		;4fc1   ; ... y ningun canal sonando
	ld (0c0b2h),a		;4fc4
calla_la_musica:		; sin musica ni efecto: los cuatro manejadores a canal_en_reposo
	xor a			;4fc7   ; ni efecto (0xC09E) ni musica (0xC0AD)
	ld (0c09eh),a		;4fc8
	ld (0c0adh),a		;4fcb   ; guarda la musica que suena
	ld (0c0a0h),a		;4fce
	ld (0c0ach),a		;4fd1
	ld hl,06067h		;4fd4   ; los cuatro manejadores, a canal_en_reposo (p10:6067)
	ld (0c010h),hl		;4fd7   ; guarda el manejador del canal A del sonido y el byte siguiente (16 bits)
	ld (0c012h),hl		;4fda   ; guarda el manejador del canal B del sonido y el byte siguiente (16 bits)
	ld (0c014h),hl		;4fdd   ; guarda el manejador del canal C del sonido y el byte siguiente (16 bits)
	ld (0c016h),hl		;4fe0   ; guarda el manejador del efecto de sonido y el byte siguiente (16 bits)
	ret			;4fe3
sonido:		; A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	push hl			;4fe4
	push de			;4fe5
	push bc			;4fe6
	push af			;4fe7
	di			;4fe8
	ld a,00ah		;4fe9   ; el banco 10 en 0x6000, con su copia: las tablas del sonido
	ld (06000h),a		;4feb   ; el mapper: pone en 0x6000 el banco de A
	ld (0f0f1h),a		;4fee   ; guarda la copia del banco de 0x6000
	ei			;4ff1
	di			;4ff2
	ld a,00bh		;4ff3   ; el 11 en 0x8000
	ld (08000h),a		;4ff5   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;4ff8   ; guarda la copia del banco de 0x8000
	ei			;4ffb
	di			;4ffc
	ld a,00ch		;4ffd   ; el 12 en 0xA000
	ld (0a000h),a		;4fff   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;5002   ; guarda la copia del banco de 0xA000
	ei			;5005
	pop af			;5006
	di			;5007
	or a			;5008   ; 0: callar la musica
	jp z,L_50F7		;5009
	cp 0fdh		;500c   ; 0xFD, 0xFE y 0xFF: ordenes
	jp nc,L_50FD		;500e
	or a			;5011   ; sin el bit 7, un efecto
	jp p,L_50BD		;5012
	ld (0c0adh),a		;5015   ; una musica: 0x80 + su numero
	ld a,(0c0afh)		;5018   ; con 0xC0AF puesto, las musicas de las zonas (0x82-0x87)...
	or a			;501b
	jr z,L_5031		;501c
	ld a,(0c0adh)		;501e   ; lee la musica que suena
	cp 082h		;5021
	jr c,L_5031		;5023
	cp 088h		;5025
	jr nc,L_5031		;5027
	ld a,001h		;5029   ; ... llevan 0xC0B0 = 1
	ld (0c0b0h),a		;502b
	xor a			;502e
	jr L_5035		;502f
L_5031:
	xor a			;5031
	ld (0c0b0h),a		;5032
L_5035:
	ld (0c0b1h),a		;5035
	ld a,(0c0adh)		;5038   ; lee la musica que suena
	ld de,0c01ah		;503b   ; las fichas de los tres canales de la musica (0xC01A, 0xC034 y 0xC04E), en blanco
	ld hl,050a3h		;503e
	ld bc,0001ah		;5041
	ldir		;5044
	ld hl,050a3h		;5046
	ld bc,0001ah		;5049
	ldir		;504c
	ld hl,050a3h		;504e
	ld bc,0001ah		;5051
	ldir		;5054
	and 07fh		;5056   ; 6 bytes por musica en la tabla de 0x6592 (banco 10)
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
	ld e,(hl)			;5064   ; la partitura del canal A
	inc hl			;5065
	ld d,(hl)			;5066
	inc hl			;5067
	ld (0c01ah),de		;5068
	ld e,(hl)			;506c   ; la del B
	inc hl			;506d
	ld d,(hl)			;506e
	inc hl			;506f
	ld (0c034h),de		;5070
	ld e,(hl)			;5074   ; la del C
	inc hl			;5075
	ld d,(hl)			;5076
	ld (0c04eh),de		;5077
	ld hl,060f4h		;507b   ; y sus tres manejadores
	ld (0c010h),hl		;507e   ; guarda el manejador del canal A del sonido y el byte siguiente (16 bits)
	ld hl,060fbh		;5081
	ld (0c012h),hl		;5084   ; guarda el manejador del canal B del sonido y el byte siguiente (16 bits)
	ld hl,06102h		;5087
	ld (0c014h),hl		;508a   ; guarda el manejador del canal C del sonido y el byte siguiente (16 bits)
L_508D:
	xor a			;508d   ; sin fundido y sin pausa
	ld (0c0a9h),a		;508e
	ld (0c0aah),a		;5091
	ld (0c0ach),a		;5094
	ld a,007h		;5097   ; los tres canales sonando
	ld (0c0abh),a		;5099   ; guarda los canales que suenan
L_509C:
	call bancos_1_2_3		;509c   ; vuelven los bancos de siempre
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
	ld c,a			;50bd   ; un efecto: C = su numero
	ld a,(0c0ach)		;50be   ; con la musica de la pausa no suena ninguno
	or a			;50c1
	jp nz,L_509C		;50c2
	ld a,(0c09eh)		;50c5   ; solo si es de numero igual o mayor que el que suena: el numero es la prioridad
	cp c			;50c8
	jp z,L_50CF		;50c9
	jp nc,L_509C		;50cc
L_50CF:
	ld a,c			;50cf
	ld (0c09eh),a		;50d0
	ld de,0c068h		;50d3   ; la ficha del efecto (0xC068), en blanco
	ld hl,050a3h		;50d6
	ld bc,0001ah		;50d9
	ldir		;50dc
	rlca			;50de   ; 2 bytes por efecto en la tabla de 0x6550
	ld hl,06550h		;50df
	add a,l			;50e2
	ld l,a			;50e3
	jr nc,L_50E7		;50e4
	inc h			;50e6
L_50E7:
	ld e,(hl)			;50e7   ; su partitura
	inc hl			;50e8
	ld d,(hl)			;50e9
	ld (0c074h),de		;50ea
	ld hl,06449h		;50ee   ; y su manejador
	ld (0c016h),hl		;50f1   ; guarda el manejador del efecto de sonido y el byte siguiente (16 bits)
	jp L_509C		;50f4
L_50F7:
	call calla_la_musica		;50f7   ; calla_la_musica: sin musica ni efecto: los cuatro manejadores a canal_en_reposo
	jp L_509C		;50fa
L_50FD:
	jp z,L_510D		;50fd   ; 0xFD: la pausa
	cp 0feh		;5100   ; 0xFE: se quita la pausa
	jp z,L_518B		;5102
	ld a,03ah		;5105   ; 0xFF: el fundido de la musica (0x3A cuadros)
	ld (0c0a9h),a		;5107
	jp L_509C		;510a
L_510D:
	ld a,001h		;510d   ; la pausa: se guarda como esta todo el sonido...
	ld (0c0a0h),a		;510f
	ld a,(0c0a9h)		;5112
	ld (0c0a1h),a		;5115
	ld a,(0c0aah)		;5118
	ld (0c0a2h),a		;511b
	ld a,(0c09fh)		;511e   ; lee la copia del registro 7 del PSG (el mezclador)
	ld (0c0a3h),a		;5121
	ld a,(0c0abh)		;5124   ; lee los canales que suenan
	ld (0c0aeh),a		;5127
	xor a			;512a   ; ... los canales callados...
	ld (0c0abh),a		;512b   ; guarda los canales que suenan
	ld a,0bfh		;512e   ; ... el mezclador a 0xBF, todo cerrado...
	ld (0c09fh),a		;5130   ; guarda la copia del registro 7 del PSG (el mezclador)
	xor a			;5133   ; ... y el tono del canal A y los tres volumenes del PSG
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
	ld a,009h		;515a   ; los canales B y C, a cero
	ld e,000h		;515c
	call 00093h		;515e   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00ah		;5161
	ld e,000h		;5163
	call 00093h		;5165   ; BIOS WRTPSG - Writes data to PSG-register
	xor a			;5168
	ld (0c09ch),a		;5169
	ld a,004h		;516c   ; 0xC09D = 4
	ld (0c09dh),a		;516e
	ld hl,060edh		;5171   ; y suena la musica de la pausa, en la ficha 0xC082, con la partitura de 0x6B74
	ld (0c018h),hl		;5174   ; guarda el manejador del segundo efecto y el byte siguiente (16 bits)
	ld de,0c082h		;5177
	ld hl,050a3h		;517a
	ld bc,0001ah		;517d
	ldir		;5180
	ld hl,06b74h		;5182
	ld (0c082h),hl		;5185
	jp L_508D		;5188
L_518B:
	xor a			;518b   ; fuera la pausa: todo vuelve como estaba
	ld (0c0a0h),a		;518c
	ld a,(0c0a1h)		;518f
	ld (0c0a9h),a		;5192
	ld a,(0c0a2h)		;5195
	ld (0c0aah),a		;5198
	ld a,(0c0a3h)		;519b
	ld (0c09fh),a		;519e   ; guarda la copia del registro 7 del PSG (el mezclador)
	ld a,(0c0aeh)		;51a1
	ld (0c0abh),a		;51a4   ; guarda los canales que suenan
	ld a,(0c0a4h)		;51a7   ; el tono del canal A y los tres volumenes
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
suena_algo:		; Z si no suena nada; A = la musica que suena
	ld a,(0c0a9h)		;51d6   ; con el fundido en marcha...
	or a			;51d9
	jr nz,L_51E4		;51da
	ld a,(0c0abh)		;51dc   ; sin fundido: Z si no suena nada; A = la musica
	or a			;51df
	ld a,(0c0adh)		;51e0   ; lee la musica que suena
	ret			;51e3
L_51E4:
	ld a,(0c0aah)		;51e4   ; en el fundido, Z si va por 0xF8; A = la musica
	cp 0f8h		;51e7
	ld a,(0c0adh)		;51e9   ; lee la musica que suena
	ret			;51ec
monta_la_pantalla:		; monta en 0xD800 la pantalla de la casilla: 8 x 6 bloques de 4 x 4 caracteres
	call bancos_13_14_15		;51ed   ; las pantallas y los bloques estan en los bancos 13 y 14
	ld a,(0c000h)		;51f0   ; el estado 8 y el 0x0B tienen su pantalla fija
	cp 008h		;51f3
	jp z,L_526D		;51f5
	cp 00bh		;51f8
	jp z,L_5272		;51fa
	ld a,(0c482h)		;51fd   ; con la pantalla especial puesta, la de 0x7239
	and a			;5200
	jr nz,L_525D		;5201
	xor a			;5203   ; 0xC28A = 0 y la lista de 0xC500 (32 bytes) en blanco
	ld (0c28ah),a		;5204
	ld hl,0c500h		;5207
	ld de,0c501h		;520a
	ld (hl),a			;520d
	ld bc,0001fh		;520e
	ldir		;5211
	call pantalla_de_la_casilla		;5213   ; A = la pantalla de la casilla
	ld hl,0ee80h		;5216   ; 0xEE80 = 0: los bloques de la zona
	ld (hl),000h		;5219
	cp 0ffh		;521b   ; 0xFF: la pantalla de 0x7419, con sus propios bloques
	jr z,L_5262		;521d
	cp 017h		;521f   ; la 0x17 del juego 4 lleva 0xC28A = 2
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
	cp 024h		;5234   ; la 0x24 del juego 5 lleva 0xC28A = 3
	jr nz,L_5246		;5236
	ld a,(0c289h)		;5238   ; lee el juego de graficos de la zona
	cp 005h		;523b
	jr nz,L_5246		;523d
	ld a,003h		;523f
	ld (0c28ah),a		;5241
	jr L_524B		;5244
L_5246:
	pop af			;5246   ; las demas, las cosas de la pantalla a 0xC500
	push af			;5247
	call cosas_de_la_pantalla		;5248   ; cosas_de_la_pantalla: llena la lista de 0xC500 con lo de esta pantalla (0x97D5) y esta casilla (0x981D)
L_524B:
	pop af			;524b   ; A = la pantalla
	ld de,0d000h		;524c   ; 48 bytes por pantalla (8 x 6 bloques), desde 0xD000
	add a,a			;524f   ; * 4...
	add a,a			;5250
	ld h,000h		;5251
	ld l,a			;5253
	add hl,hl			;5254   ; ... * 16
	add hl,hl			;5255
	ld b,h			;5256
	ld c,l			;5257
	add hl,hl			;5258   ; * 32 + * 16: * 48
	add hl,bc			;5259
	add hl,de			;525a   ; desde 0xD000
	jr L_5275		;525b
L_525D:
	ld hl,07239h		;525d
	jr L_5275		;5260
L_5262:
	ld a,001h		;5262   ; 0xEE80 = 1: los bloques de 0x7449
	ld (hl),a			;5264
	ld (0c28ah),a		;5265
	ld hl,07419h		;5268
	jr L_5275		;526b
L_526D:
	ld hl,07549h		;526d   ; la del estado 8
	jr L_5275		;5270
L_5272:
	ld hl,07581h		;5272   ; la del estado 0x0B
L_5275:
	ld de,0d800h		;5275   ; se monta en 0xD800, un byte por caracter, 32 por fila
	ld a,(0c000h)		;5278   ; lee el ESTADO del juego
	cp 00bh		;527b   ; 6 filas de bloques; en el estado 0x0B, 8
	ld a,006h		;527d
	jr nz,L_5283		;527f
	ld a,008h		;5281
L_5283:
	ex af,af'			;5283
	ld b,008h		;5284   ; 8 bloques por fila
L_5286:
	ld a,(hl)			;5286   ; el bloque
	push de			;5287
	exx			;5288
	push af			;5289
	ld a,(0c000h)		;528a   ; de que tabla salen los bloques:
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
	ld bc,0e100h		;52a1   ; 0xE100, los de la zona
	jr L_52B8		;52a4
L_52A6:
	ld bc,07269h		;52a6   ; 0x7269, los de la pantalla especial
	jr L_52B8		;52a9
L_52AB:
	ld bc,08eddh		;52ab   ; 0x8EDD, los del estado 8
	jr L_52B8		;52ae
L_52B0:
	ld bc,08f9dh		;52b0   ; 0x8F9D, los del estado 0x0B
	jr L_52B8		;52b3
L_52B5:
	ld bc,07449h		;52b5   ; 0x7449, los de la pantalla 0xFF
L_52B8:
	pop af			;52b8
	ld h,000h		;52b9   ; 16 bytes por bloque: 4 x 4 caracteres
	ld l,a			;52bb
	add hl,hl			;52bc
	add hl,hl			;52bd
	add hl,hl			;52be
	add hl,hl			;52bf
	add hl,bc			;52c0
	ld bc,01cffh		;52c1   ; B = 0x1C: lo que se salta hasta la fila siguiente (32 - 4)
	pop de			;52c4
	ldi		;52c5   ; la primera fila del bloque
	ldi		;52c7
	ldi		;52c9
	ldi		;52cb
	ld a,b			;52cd   ; la segunda, una fila de caracteres mas abajo
	add a,e			;52ce
	ld e,a			;52cf
	ldi		;52d0
	ldi		;52d2
	ldi		;52d4
	ldi		;52d6
	ld a,b			;52d8   ; la tercera
	add a,e			;52d9
	ld e,a			;52da
	ldi		;52db
	ldi		;52dd
	ldi		;52df
	ldi		;52e1
	ld a,b			;52e3   ; la cuarta
	add a,e			;52e4
	ld e,a			;52e5
	ldi		;52e6
	ldi		;52e8
	ldi		;52ea
	ldi		;52ec
	exx			;52ee
	inc hl			;52ef   ; el bloque siguiente, 4 caracteres a la derecha
	inc de			;52f0
	inc de			;52f1
	inc de			;52f2
	inc de			;52f3
	dec b			;52f4
	jp nz,L_5286		;52f5
	ex de,hl			;52f8
	ld bc,00060h		;52f9   ; la fila de bloques siguiente: 4 filas de caracteres mas abajo
	add hl,bc			;52fc
	ex de,hl			;52fd
	ex af,af'			;52fe
	dec a			;52ff
	jp nz,L_5283		;5300
	jp bancos_1_2_3		;5303   ; bancos_1_2_3: pone los bancos 1, 2 y 3
pantalla_de_la_casilla:		; A = la pantalla de la casilla de 0xC281 (tabla de 0xE700)
	ld hl,0e700h		;5306   ; 0xE700: la pantalla de cada casilla de la zona
	ld a,(0c281h)		;5309   ; lee la CASILLA de la zona
	call hl_mas_a		;530c   ; hl_mas_a: HL += A
	ld a,(hl)			;530f
	ret			;5310
rejilla_de_la_zona:		; la pantalla de cada casilla de la zona, a 0xE700 (tabla 0x600C, banco 13)
	call bancos_13_14_15		;5311   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	call indice_de_la_zona		;5314   ; indice_de_la_zona: A = (fase * 7 + zona) * 2
	ld hl,0600ch		;5317   ; la tabla de 0x600C (banco 13), una entrada por zona
	call palabra_de_tabla		;531a   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld de,0e700h		;531d
	ld a,(0c289h)		;5320   ; los juegos 0-3 la traen en nibbles; el 4 y el 5, en bytes
	sub 004h		;5323
	jr nc,L_5346		;5325
	ld b,040h		;5327   ; 64 bytes: 128 casillas
L_5329:
	ld a,(hl)			;5329
	and 0f0h		;532a   ; el nibble de arriba, la casilla par
	rrca			;532c
	rrca			;532d
	rrca			;532e
	rrca			;532f
	cp 00fh		;5330   ; 0xF es que no hay casilla (0xFF)
	jr nz,L_5336		;5332
	ld a,0ffh		;5334
L_5336:
	ld (de),a			;5336
	inc e			;5337
	ld a,(hl)			;5338   ; el de abajo, la impar
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
	ld bc,00080h		;5346   ; 128 bytes tal cual (en los juegos 0-3, detras de los nibbles)
	ldir		;5349
	jp bancos_1_2_3		;534b   ; bancos_1_2_3: pone los bancos 1, 2 y 3
pinta_la_pantalla:		; pinta los caracteres de 0xD800 en la pantalla
	ld hl,0d800h		;534e   ; de 0xD800...
	ld a,(0c000h)		;5351   ; lee el ESTADO del juego
	ld de,00000h		;5354   ; ... a la pantalla desde y 0x20, debajo del marcador
	cp 008h		;5357   ; en los estados 8 y 0x0B, desde y 0
	jr z,L_5361		;5359
	cp 00bh		;535b
	jr z,L_5361		;535d
	ld e,020h		;535f
L_5361:
	ld a,(0c000h)		;5361   ; lee el ESTADO del juego
	cp 00bh		;5364
	ld b,016h		;5366   ; 22 filas de caracteres; en el estado 0x0B, 26
	jr nz,L_536C		;5368
	ld b,01ah		;536a
L_536C:
	push bc			;536c
	ld b,020h		;536d   ; 32 por fila
L_536F:
	ld a,(hl)			;536f
	call caracter		;5370   ; cada byte es un caracter de la pagina 1
	inc hl			;5373
	ld a,d			;5374   ; 8 puntos a la derecha
	add a,008h		;5375
	ld d,a			;5377
	djnz L_536F		;5378
	pop bc			;537a
	ld a,e			;537b   ; la fila siguiente
	add a,008h		;537c
	ld e,a			;537e
	djnz L_536C		;537f
	ret			;5381
cosas_de_la_pantalla:		; llena la lista de 0xC500 con lo de esta pantalla (0x97D5) y esta casilla (0x981D)
	ex af,af'			;5382
	ld hl,097d5h		;5383   ; la tabla de 0x97D5, una lista por juego de graficos
	ld a,(0c289h)		;5386   ; lee el juego de graficos de la zona
	add a,a			;5389
	call palabra_de_tabla		;538a   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld de,0c500h		;538d   ; la lista de 0xC500, de 16 en 16 bytes
	ld b,(hl)			;5390   ; cuantas entradas tiene
	ld a,b			;5391
	and a			;5392
	ret z			;5393
	inc hl			;5394
	ex af,af'			;5395
L_5396:
	push af			;5396   ; dos bytes por entrada: [pantalla][dos nibbles]
	cp (hl)			;5397   ; solo las de esta pantalla
	jr nz,L_53B2		;5398
	push hl			;539a
	push de			;539b
	inc hl			;539c
	inc e			;539d
	ld a,(hl)			;539e   ; el nibble de arriba...
	and 0f0h		;539f
	ld (de),a			;53a1
	inc e			;53a2
	ld a,(hl)			;53a3   ; ... y el de abajo, cada uno en el nibble de arriba de un byte
	rla			;53a4
	rla			;53a5
	rla			;53a6
	rla			;53a7
	and 0f0h		;53a8
	ld (de),a			;53aa
	pop de			;53ab
	ld hl,00010h		;53ac   ; la siguiente de 0xC500
	add hl,de			;53af
	ex de,hl			;53b0
	pop hl			;53b1
L_53B2:
	inc hl			;53b2
	inc hl			;53b3
	pop af			;53b4
	djnz L_5396		;53b5
	call indice_de_la_zona		;53b7   ; indice_de_la_zona: A = (fase * 7 + zona) * 2
	ld hl,0981dh		;53ba   ; y la de 0x981D, una lista por zona
	call palabra_de_tabla		;53bd   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld de,0c500h		;53c0
	ld b,(hl)			;53c3   ; cuantas entradas
	inc hl			;53c4
L_53C5:
	ld a,(0c281h)		;53c5   ; dos bytes por entrada: [casilla][byte]
	cp (hl)			;53c8   ; solo las de esta casilla
	jr nz,L_53DE		;53c9
	inc hl			;53cb
	ld a,(hl)			;53cc
	rla			;53cd   ; con el bit 7 puesto, en la entrada siguiente de 0xC500
	jr nc,L_53D7		;53ce
	push hl			;53d0
	ld hl,00010h		;53d1
	add hl,de			;53d4
	ex de,hl			;53d5
	pop hl			;53d6
L_53D7:
	ld a,(hl)			;53d7   ; el byte sin el bit 7, en el primero de la entrada
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
figura_del_interior:		; los sprites de un interior (figuras 0x22-0x24)
	push af			;53e3
	call bancos_10_11_12		;53e4   ; bancos_10_11_12: pone los bancos 10, 11 y 12
	ld a,(0c002h)		;53e7   ; los sprites del interior, de Goemon...
	add a,a			;53ea
	ld de,0a783h		;53eb
	jr nc,L_53F3		;53ee
	ld de,0a7ddh		;53f0   ; ... o de Ebisumaru (banco 12), a 0xF9C0
L_53F3:
	ld hl,0f9c0h		;53f3
	call rle_a_la_vram		;53f6   ; rle_a_la_vram: descomprime un rle a la VRAM
	call bancos_13_14_15		;53f9   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld de,09f76h		;53fc   ; y los de 0x9F76 (banco 14) a 0xFAC0
	ld hl,0fac0h		;53ff
	call rle_a_la_vram		;5402   ; rle_a_la_vram: descomprime un rle a la VRAM
	call bancos_10_11_12		;5405   ; bancos_10_11_12: pone los bancos 10, 11 y 12
	pop af			;5408
	ld de,054b8h		;5409   ; la figura A de la tabla de 0x54B8: se sube como una mas de la lista
	call palabra_de_tabla_de		;540c   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld b,001h		;540f   ; una sola
	jr L_542E		;5411
dibujos_de_las_figuras:		; los patrones y los colores 4 y 6 de las figuras de la casilla (fichas de 0xA830, banco 12)
	call figuras_de_la_casilla		;5413   ; DE = la lista de figuras de la casilla: [cuantas - 1] y un tipo por figura
	ld a,(de)			;5416
	inc a			;5417
	ld b,a			;5418
	inc de			;5419
	di			;541a
	ld a,00bh		;541b   ; las fichas de las figuras estan en los bancos 11 y 12
	ld (08000h),a		;541d   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;5420   ; guarda la copia del banco de 0x8000
	ei			;5423
	di			;5424
	ld a,00ch		;5425
	ld (0a000h),a		;5427   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;542a   ; guarda la copia del banco de 0xA000
	ei			;542d
L_542E:
	push bc			;542e   ; el tipo
	ld a,(de)			;542f
	or a			;5430
	jp z,L_54AF		;5431   ; 0: hueco
	push de			;5434
	push af			;5435
	ld hl,0a998h		;5436   ; algunos tipos llevan un dibujo mas: 8 entradas de 5 bytes en 0xA998, [tipo][rle][VRAM]
	ld b,008h		;5439
	ld d,a			;543b
L_543C:
	ld a,(hl)			;543c   ; el tipo de la entrada
	cp d			;543d
	jr z,L_544B		;543e
	ld a,005h		;5440   ; 5 bytes por entrada
	add a,l			;5442
	ld l,a			;5443
	jr nc,L_5447		;5444
	inc h			;5446
L_5447:
	djnz L_543C		;5447   ; las 8
	jr L_5457		;5449   ; ninguna
L_544B:
	inc hl			;544b   ; el rle
	ld e,(hl)			;544c
	inc hl			;544d
	ld d,(hl)			;544e
	inc hl			;544f   ; y la VRAM de destino
	ld a,(hl)			;5450
	inc hl			;5451
	ld h,(hl)			;5452
	ld l,a			;5453
	call rle_a_la_vram		;5454   ; rle_a_la_vram: descomprime un rle a la VRAM
L_5457:
	pop af			;5457
	pop de			;5458
	push de			;5459
	dec a			;545a   ; 10 bytes por tipo en la tabla de 0xA830
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
	ld e,(ix+000h)		;546c   ; [0-1] los dibujos, en rle (guardado en 0xCD42)
	ld d,(ix+001h)		;546f
	ld (0cd42h),de		;5472
	ld l,(ix+002h)		;5476   ; [2-3] su sitio en la VRAM
	ld h,(ix+003h)		;5479
	call rle_a_la_vram		;547c   ; rle_a_la_vram: descomprime un rle a la VRAM
	ld a,004h		;547f   ; [4-5] el color 4 de la paleta (RB, G); 0xFF, sin colores
	ld d,(ix+004h)		;5481
	ld e,a			;5484
	ld a,d			;5485
	cp 0ffh		;5486
	jr z,L_549C		;5488
	ld a,e			;548a
	ld e,(ix+005h)		;548b
	call pon_un_color		;548e   ; pon_un_color: color A de la paleta = DE
	ld a,006h		;5491   ; [6-7] el color 6
	ld d,(ix+006h)		;5493
	ld e,(ix+007h)		;5496
	call pon_un_color		;5499   ; pon_un_color: color A de la paleta = DE
L_549C:
	ld de,(0cd42h)		;549c   ; [8-9] donde va la copia dada la vuelta del mismo rle; 0xFF, ninguna
	ld a,(ix+008h)		;54a0
	cp 0ffh		;54a3
	jr z,L_54AE		;54a5
	ld l,a			;54a7
	ld h,(ix+009h)		;54a8
	call rle_vuelto		;54ab   ; rle_vuelto: descomprime sprites de 16x16 dados la vuelta (espejo) y los sube a la VRAM de HL
L_54AE:
	pop de			;54ae
L_54AF:
	inc de			;54af   ; el tipo siguiente
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


colores_de_la_figura:		; los 16 colores de cada sprite de la figura, con la lista de su pose (0x554E)
	exx			;54e6
	ld de,0554eh		;54e7   ; la tabla de 0x554E: dos listas por pose, una por lado
	ld a,(0cd37h)		;54ea   ; la pose de 0xCD37
	dec a			;54ed
	add a,a			;54ee
	bit 0,(ix+00ah)		;54ef   ; el bit 0 de (ix+0x0A): el lado
	jr z,L_54F6		;54f3
	inc a			;54f5
L_54F6:
	ex de,hl			;54f6
	add a,a			;54f7   ; 2 bytes por entrada
	add a,l			;54f8
	ld l,a			;54f9
	jr nc,L_54FD		;54fa
	inc h			;54fc
L_54FD:
	ld a,(hl)			;54fd   ; la palabra
	inc hl			;54fe
	ld h,(hl)			;54ff
	ld l,a			;5500
	ex de,hl			;5501   ; DE = la lista de color
L_5502:
	exx			;5502
L_5503:
	set 5,l		;5503   ; HL = (ix+0x20): cuantos sprites lleva la figura
	ld b,(hl)			;5505
	ld a,b			;5506
	and a			;5507
	ret z			;5508
	inc l			;5509   ; 5 bytes por sprite: [hueco][y][x][patron][color]
L_550A:
	push bc			;550a
	ld b,(hl)			;550b   ; el hueco de sprite
	inc l			;550c
	inc l			;550d
	inc l			;550e
	inc l			;550f
	ex de,hl			;5510
	ld hl,07640h		;5511   ; sus 16 colores, en 0xEC80 + hueco * 16
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
	ld a,(hl)			;5521   ; el color del sprite...
	ld b,010h		;5522   ; ... en sus 16 lineas
L_5524:
	ld (de),a			;5524
	inc e			;5525
	djnz L_5524		;5526
	exx			;5528
	call colores_de_la_pose		;5529   ; y encima, la lista de colores de la pose
	exx			;552c
	pop bc			;552d
	inc l			;552e
	djnz L_550A		;552f
	ret			;5531
colores_de_la_pose:		; sin pose, nada; con ella, la lista de tripletes de DE
	ld a,(0cd37h)		;5532   ; sin pose (0xCD37 = 0), un color para todo el sprite
	or a			;5535
	ret z			;5536
L_5537:
	ld a,(de)			;5537   ; tripletes [cuantas lineas][desde][color]; 0 acaba
	inc de			;5538
	or a			;5539
	ret z			;553a
	ld b,a			;553b   ; B = cuantas lineas
	ld hl,(0cd34h)		;553c   ; HL = el color del sprite
	ld a,(de)			;553f   ; + desde
	inc de			;5540
	add a,l			;5541
	ld l,a			;5542
	jr nc,L_5546		;5543
	inc h			;5545
L_5546:
	ld a,(de)			;5546   ; el color
L_5547:
	ld (hl),a			;5547   ; B lineas de ese color
	inc hl			;5548
	djnz L_5547		;5549
	inc de			;554b   ; el triplete siguiente
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


pinta_cosa_del_marcador:		; pinta la cosa A del marcador (0-9; la 0x0A va aparte)
	cp 00ah		;57fa   ; la 0x0A va aparte
	jr z,$+103		;57fc
	ld de,0582ah		;57fe   ; la x de cada cosa (0x582A) y si se tiene (0xC270 + n)
	ld hl,0c270h		;5801   ; apunta a las 10 cosas del marcador
	ld b,a			;5804
	call hl_mas_a		;5805   ; hl_mas_a: HL += A
	ld a,b			;5808
	call de_mas_a		;5809   ; de_mas_a: DE += A
	call x_de_la_cosa		;580c   ; D = la x, E = 0x10
	ld a,b			;580f
	or a			;5810   ; la 0 y la 9 se cuentan: se pintan tantas como se tengan
	jr z,$+35		;5811
	cp 009h		;5813
	jr z,$+31		;5815
	ld c,a			;5817   ; las demas: si se tiene, su icono (el numero de la cosa)...
	ld a,(hl)			;5818
	or a			;5819
	ld a,c			;581a
	jr z,L_5820		;581b
	jp pinta_icono		;581d   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
L_5820:
	ld a,0ffh		;5820   ; ... y si no, en blanco
	jp pinta_icono		;5822   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
x_de_la_cosa:		; D = el byte de DE (la x), E = 0x10
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


pinta_cuantas:		; el icono A tantas veces como diga (HL), en tres sitios; el resto en blanco
	ld (0cd29h),a		;5834   ; el icono
	ld a,(hl)			;5837
	ld b,003h		;5838   ; tres sitios
	ld c,a			;583a
L_583B:
	dec c			;583b   ; C = cuantas se tienen: las que pasen, en blanco
	jp m,L_5852		;583c
	ld a,(0cd29h)		;583f
L_5842:
	push bc			;5842
	push hl			;5843
	push de			;5844
	call pinta_icono		;5845   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
	pop de			;5848
	pop hl			;5849
	pop bc			;584a
	ld a,010h		;584b   ; el sitio siguiente, 16 puntos a la derecha
	add a,d			;584d
	ld d,a			;584e
	djnz L_583B		;584f
	ret			;5851
L_5852:
	ld a,0ffh		;5852
	jr L_5842		;5854
pinta_las_cosas:		; pinta las cosas del marcador
	xor a			;5856
	ld b,00ah		;5857   ; las 10 cosas
L_5859:
	push af			;5859
	push bc			;585a
	call pinta_cosa_del_marcador		;585b   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
	pop bc			;585e
	pop af			;585f
	inc a			;5860
	djnz L_5859		;5861
pinta_la_cosa_0a:		; la cosa 0x0A del marcador, en (0xB8, 0x10), si 0xC27E no es cero
	ld de,0b810h		;5863   ; la 0x0A: en (0xB8, 0x10)...
	ld hl,0c27eh		;5866   ; ... si 0xC27E no es cero...
	ld a,(hl)			;5869
	or a			;586a
	jr z,$-75		;586b
	ld hl,0c090h		;586d   ; ... el dibujo de (0xC0, 0x90) de la pagina 1, de 16 x 16
	ld bc,01010h		;5870
	ld a,001h		;5873
	jp hmmm		;5875   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
resta_vida:		; quita A de la vida, hasta 0, y la pinta
	ld hl,0c481h		;5878   ; apunta a la VIDA del jugador
	ld b,a			;587b
	ld a,(hl)			;587c   ; quita A de la vida, y se queda en 0 si no llega
	dec hl			;587d
	sub b			;587e
	jr nc,L_588E		;587f
	xor a			;5881
	jr L_588E		;5882
suma_vida:		; suma A a la vida, hasta la maxima, y la pinta
	ld hl,0c481h		;5884   ; apunta a la VIDA del jugador
	ld b,(hl)			;5887   ; suma A a la vida...
	add a,b			;5888
	dec hl			;5889
	cp (hl)			;588a   ; ... hasta la vida maxima
	jr c,L_588E		;588b
	ld a,(hl)			;588d
L_588E:
	inc hl			;588e
	ld (hl),a			;588f
pinta_la_vida:		; pinta la barra de vida
	ld hl,0c480h		;5890   ; apunta a la vida maxima
	ld a,(0c002h)		;5893   ; sin la partida en marcha, la maxima es 0x10
	add a,a			;5896
	jp m,L_589C		;5897
	ld (hl),010h		;589a
L_589C:
	ld b,(hl)			;589c   ; B = la maxima, C = la que hay
	ld hl,0c481h		;589d   ; apunta a la VIDA del jugador
	ld c,(hl)			;58a0
	ld de,0a008h		;58a1   ; la barra, en (0xA0, 8)
L_58A4:
	dec c			;58a4   ; mientras quede vida, el trozo lleno de (0xD8, 0x60) de la pagina 1
	jp m,L_58C0		;58a5
	ld hl,0d860h		;58a8
L_58AB:
	push bc			;58ab
	push de			;58ac
	ld bc,00208h		;58ad   ; 2 x 8 puntos
	ld a,040h		;58b0
	call lmmm		;58b2   ; lmmm: orden LMMM del V9938: copia un rectangulo con operacion logica
	pop de			;58b5
	pop bc			;58b6
	ld a,002h		;58b7   ; el trozo siguiente, 2 puntos a la derecha
	add a,d			;58b9
	ld d,a			;58ba
	djnz L_58A4		;58bb
	jp marco_de_la_vida		;58bd   ; y el marco
L_58C0:
	ld hl,0dc60h		;58c0   ; lo que pasa de la vida, el trozo vacio de (0xDC, 0x60)
	jr L_58AB		;58c3
cuenta_el_tiempo:		; cada 60 - fase * 5 cuadros, un segundo menos
	ld a,(0cd32h)		;58c5   ; con 0xCD32 puesto el tiempo no corre
	or a			;58c8
	ret nz			;58c9
	ld hl,0c482h		;58ca   ; apunta a la pantalla especial
	bit 0,(hl)		;58cd   ; ni en la pantalla especial
	jr nz,pinta_el_tiempo		;58cf
	ld a,(0c490h)		;58d1   ; ni con el jugador en el estado 2 o mas
	cp 002h		;58d4
	jr nc,pinta_el_tiempo		;58d6
	ld hl,0c4b2h		;58d8   ; la cuenta de cuadros del segundo
	dec (hl)			;58db
	ret nz			;58dc
	ld a,(0c288h)		;58dd   ; el segundo dura 60 - fase * 5 cuadros: corre mas deprisa en cada fase
	ld b,a			;58e0
	add a,a			;58e1
	add a,a			;58e2
	add a,b			;58e3
	ld b,a			;58e4
	ld a,03ch		;58e5
	sub b			;58e7
	ld (hl),a			;58e8
	ld hl,0c4b0h		;58e9   ; un segundo menos
	ld de,00001h		;58ec
	call resta_bcd		;58ef   ; resta_bcd: (HL) -= DE, dos bytes en BCD
	call gasta_la_cosa_8		;58f2   ; y lo que dura la cosa 8
pinta_el_tiempo:		; pinta el tiempo (4 cifras) en (0x48, 8)
	ld hl,0c4b1h		;58f5   ; cuatro cifras, en (0x48, 8)
	ld de,04808h		;58f8
	ld b,002h		;58fb
	jp pinta_bcd		;58fd   ; pinta_bcd: pinta cifras en BCD
gasta_la_cosa_8:		; un segundo menos de la cosa 8; a cero, se pierde
	ld hl,0c278h		;5900   ; 0xC278: la cosa 8, que dura un tiempo
	ld a,(hl)			;5903
	or a			;5904
	ret z			;5905
	ld hl,0c27ch		;5906   ; 0xC27C: los segundos que le quedan
	dec (hl)			;5909
	ret nz			;590a
	ld hl,0c278h		;590b   ; se acabo: fuera la cosa 8 y su icono
	xor a			;590e
	ld (hl),a			;590f
	ld a,008h		;5910
	jp pinta_cosa_del_marcador		;5912   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
resta_bcd:		; (HL) -= DE, dos bytes en BCD
	ld a,(hl)			;5915   ; (HL) -= DE, dos bytes en BCD
	sub e			;5916
	daa			;5917
	ld (hl),a			;5918
	inc hl			;5919
	ld a,(hl)			;591a
	sbc a,d			;591b
	daa			;591c
	ld (hl),a			;591d
	ret			;591e
suma_bcd:		; (HL) += DE, dos bytes en BCD
	ld a,(hl)			;591f   ; (HL) += DE, dos bytes en BCD
	add a,e			;5920
	daa			;5921
	ld (hl),a			;5922
	inc hl			;5923
	ld a,(hl)			;5924
	adc a,d			;5925
	daa			;5926
	ld (hl),a			;5927
	ret			;5928
suma_dinero:		; suma E ryo (BCD) al dinero, hasta 9999
	ld d,000h		;5929   ; E ryo, en BCD
L_592B:
	ld hl,0c265h		;592b   ; apunta a el DINERO (ryo, BCD)
	call suma_bcd		;592e   ; suma_bcd: (HL) += DE, dos bytes en BCD
	jr nc,pinta_el_dinero		;5931   ; pasado de 9999 se queda en 9999
	ld de,09999h		;5933
	ld (0c265h),de		;5936   ; guarda el DINERO (ryo, BCD) y el byte siguiente (16 bits)
pinta_el_dinero:		; pinta el dinero (4 cifras) en (0x70, 8)
	ld hl,0c266h		;593a   ; cuatro cifras, en (0x70, 8)
	ld de,07008h		;593d
	ld b,002h		;5940
	jp pinta_bcd		;5942   ; pinta_bcd: pinta cifras en BCD
suma_tiempo:		; suma DE (BCD) al tiempo, hasta 5000
	ld hl,0c4b0h		;5945   ; DE segundos mas, en BCD...
	call suma_bcd		;5948   ; suma_bcd: (HL) += DE, dos bytes en BCD
	cp 050h		;594b   ; ... hasta 5000
	jr c,pinta_el_tiempo		;594d
	ld de,05000h		;594f
	ld (0c4b0h),de		;5952   ; guarda el TIEMPO (BCD) y el byte siguiente (16 bits)
	jr pinta_el_tiempo		;5956
resta_dinero:		; resta DE ryo (BCD) al dinero, hasta 0
	ld hl,0c265h		;5958   ; apunta a el DINERO (ryo, BCD)
	call resta_bcd		;595b   ; por debajo de 0 se queda en 0
	jr nc,pinta_el_dinero		;595e
	ld de,00000h		;5960
	ld (0c265h),de		;5963   ; guarda el DINERO (ryo, BCD) y el byte siguiente (16 bits)
	jr pinta_el_dinero		;5967
entra_en_el_laberinto:		; pasa al laberinto de la zona, en primera persona
	ld a,001h		;5969
	ld (0cdb1h),a		;596b   ; guarda si se esta en el laberinto
	call 067dah		;596e   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	di			;5971
	ld a,009h		;5972   ; el banco 9 en 0xA000: los laberintos
	ld (0a000h),a		;5974   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;5977   ; guarda la copia del banco de 0xA000
	ei			;597a
	call monta_el_laberinto		;597b   ; monta_el_laberinto: monta en 0xD800 el laberinto de la zona (tablas 0xA575 y 0xA86D, banco 9)
	call bancos_1_2_3		;597e   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call apaga_la_pantalla		;5981   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call dibujos_del_laberinto		;5984   ; dibujos_del_laberinto: los dibujos, la paleta y los sprites del laberinto
	call pinta_el_laberinto		;5987   ; pinta_el_laberinto: la vista del laberinto y el marcador
	jp enciende_la_pantalla		;598a   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
pinta_el_laberinto:		; la vista del laberinto y el marcador
	call 0b936h		;598d
	call 0bc3ah		;5990   ; borra_todo: borra la pantalla y los sprites
	call pinta_las_cosas		;5993   ; pinta_las_cosas: pinta las cosas del marcador
	call pinta_el_marcador		;5996   ; pinta_el_marcador: pinta el marcador entero
	call pinta_la_vida		;5999   ; pinta_la_vida: pinta la barra de vida
	call 098beh		;599c   ; pinta_la_vista: las paredes de la vista del laberinto
	call 0b9cbh		;599f   ; flecha_de_direccion: los sprites de la flecha hacia donde se mira
	call 0b843h		;59a2
	call 098e3h		;59a5   ; sprites_de_la_vista: los sprites de lo que hay delante
	ret			;59a8
monta_el_laberinto:		; monta en 0xD800 el laberinto de la zona (tablas 0xA575 y 0xA86D, banco 9)
	ld a,(0c288h)		;59a9   ; fase * 7 + zona
	ld b,a			;59ac
	add a,a			;59ad
	add a,a			;59ae
	add a,a			;59af
	sub b			;59b0
	ld b,a			;59b1
	ld a,(0c280h)		;59b2   ; lee la ZONA (0-6)
	add a,b			;59b5
	ld de,0a575h		;59b6   ; la entrada de la zona en la tabla de 0xA575 (banco 9)
	call palabra_de_tabla_de		;59b9   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld a,(de)			;59bc   ; su primer byte: cual de los dibujos de 0xA86D
	inc de			;59bd
	push de			;59be
	ld de,0a86dh		;59bf
	call palabra_de_tabla_de		;59c2   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld a,(de)			;59c5   ; [ancho][alto] y los bits del laberinto (1 pared, 0 paso)
	ld (0cdd3h),a		;59c6
	ld b,a			;59c9
	inc de			;59ca
	ld a,(de)			;59cb
	ld (0cdd4h),a		;59cc
	inc de			;59cf
	call laberinto_de_bits		;59d0   ; el laberinto, un byte por casilla, en 0xD800
	pop de			;59d3
	jp marcas_del_laberinto		;59d4   ; y encima las marcas de la entrada de 0xA575
laberinto_de_bits:		; los bits del laberinto (A de ancho, B de alto), un byte por casilla en 0xD800
	ld (0ee80h),a		;59d7
	add a,007h		;59da   ; (ancho + 7) / 8 bytes por fila
	srl a		;59dc
	srl a		;59de
	srl a		;59e0
	ld (0ee81h),a		;59e2
	ld hl,0d800h		;59e5
L_59E8:
	push bc			;59e8
	ld a,(0ee81h)		;59e9   ; B = los bytes de la fila
	ld b,a			;59ec
	ld a,(0ee80h)		;59ed   ; C = el ancho
	ld c,a			;59f0
	push hl			;59f1
L_59F2:
	ld a,(de)			;59f2   ; el byte de bits
	inc de			;59f3
	push bc			;59f4
	push de			;59f5
	call ocho_bits_a_bytes		;59f6   ; cada bit, un byte (1 o 0)
	pop de			;59f9
	pop bc			;59fa
	ld c,a			;59fb   ; lo que queda de fila
	djnz L_59F2		;59fc
	pop hl			;59fe
	ld a,01ch		;59ff   ; 28 casillas por fila
	call hl_mas_a		;5a01   ; hl_mas_a: HL += A
	pop bc			;5a04
	djnz L_59E8		;5a05
	ld a,001h		;5a07
	ld (0cdc6h),a		;5a09
	ld (0cdc7h),a		;5a0c
	ret			;5a0f
marcas_del_laberinto:		; lo que hay en el laberinto (lista de DE), salvo lo ya cogido (0xC290)
	ld a,(de)			;5a10   ; dos bytes por marca: [lo que es (bits 5-7) y x (bits 0-4)][y]; 0 acaba
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
	call sitio_en_el_laberinto		;5a1d   ; HL = su sitio en 0xD800
	pop de			;5a20
	pop bc			;5a21
	ld a,c			;5a22   ; C = lo que es (0-7)
	srl a		;5a23
	srl a		;5a25
	srl a		;5a27
	srl a		;5a29
	srl a		;5a2b
	ld c,a			;5a2d
	push de			;5a2e
	call pon_si_no_esta		;5a2f   ; pon_si_no_esta: pone C en (HL) si HL no esta entre las 11 palabras de 0xC290
	pop de			;5a32
	jr marcas_del_laberinto		;5a33
pon_si_no_esta:		; pone C en (HL) si HL no esta entre las 11 palabras de 0xC290
	ld de,0c290h		;5a35   ; las 11 palabras de 0xC290
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
	rst 20h			;5a42   ; RST 0x20 (DCOMPR): HL contra DE
	pop bc			;5a43
	pop de			;5a44
	ret z			;5a45   ; si el sitio esta en la lista, no se pone
	inc de			;5a46
	inc de			;5a47
	djnz L_5A3A		;5a48
	ld (hl),c			;5a4a   ; si no, la marca
	ret			;5a4b
por_28:		; HL = A * 28
	ld b,a			;5a4c   ; HL = A * 28
	ld hl,00000h		;5a4d
	or a			;5a50
	ret z			;5a51
	ld de,0001ch		;5a52
L_5A55:
	add hl,de			;5a55
	djnz L_5A55		;5a56
	ret			;5a58
ocho_bits_a_bytes:		; hasta 8 bits de A a bytes 1/0 en HL; C cuenta lo que queda de fila
	ld b,008h		;5a59   ; hasta 8 bits de A, de arriba abajo, o hasta que C llegue a 0
L_5A5B:
	rla			;5a5b
	ld d,001h		;5a5c
	jr c,L_5A62		;5a5e
	ld d,000h		;5a60
L_5A62:
	ld (hl),d			;5a62   ; el byte: 1 o 0
	inc hl			;5a63
	dec c			;5a64   ; una casilla menos de la fila
	ret z			;5a65
	djnz L_5A5B		;5a66
	ld a,c			;5a68   ; A = las que quedan
	ret			;5a69
sitio_en_el_laberinto:		; HL = 0xD800 + H * 28 + L
	ld b,h			;5a6a   ; HL = 0xD800 + H * 28 + L
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
prepara_el_titulo:		; borra, letras, caracteres y paleta del titulo
	call borra_la_pantalla		;5a81   ; borra_la_pantalla: borra la pantalla
	ld bc,00007h		;5a84   ; el registro 7 (el color del borde) a 0
	call 00047h		;5a87   ; BIOS WRTVDP - Writes data in the VDP-register
	call letras_del_texto		;5a8a   ; letras_del_texto: sube las letras de los textos
	call caracteres_del_titulo		;5a8d   ; caracteres_del_titulo: sube los caracteres del titulo
	jp paleta_del_titulo		;5a90   ; paleta_del_titulo: pone la paleta de 0xA44E (banco 9)
pantalla_del_titulo:		; pinta el titulo: dibujo de 20 x 12, 23 sprites, el marco y el menu
	call prepara_el_titulo		;5a93   ; prepara_el_titulo: borra, letras, caracteres y paleta del titulo
	call bancos_4_5_6		;5a96   ; bancos_4_5_6: pone los bancos 4, 5 y 6
	call apaga_la_pantalla		;5a99   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	ld de,03020h		;5a9c   ; el dibujo del titulo: 20 x 12 caracteres de 0xB6B2 (banco 6) desde (0x30, 0x20)
	ld hl,0b6b2h		;5a9f
	ld b,00ch		;5aa2
L_5AA4:
	push bc			;5aa4
	push de			;5aa5
	ld b,014h		;5aa6   ; 20 por fila
L_5AA8:
	ld a,(hl)			;5aa8
	call caracter		;5aa9   ; caracter: pinta el caracter A de la pagina 1 en DE de la pagina 0
	inc hl			;5aac
	ld a,d			;5aad   ; 8 puntos a la derecha
	add a,008h		;5aae
	ld d,a			;5ab0
	djnz L_5AA8		;5ab1
	pop de			;5ab3
	pop bc			;5ab4
	ld a,e			;5ab5   ; la fila siguiente
	add a,008h		;5ab6
	ld e,a			;5ab8
	djnz L_5AA4		;5ab9
	ld hl,0b7a2h		;5abb   ; 23 sprites: [y][x] de 0xB7A2 a la copia de la tabla de atributos (0xEE00)
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
	ld a,c			;5acc   ; el patron, n * 4 (sprites de 16x16)
	add a,a			;5acd
	add a,a			;5ace
	ld (de),a			;5acf
	inc c			;5ad0
	inc de			;5ad1
	inc de			;5ad2   ; el cuarto byte (el color) no se toca
	djnz L_5AC4		;5ad3
	ld hl,0ec00h		;5ad5   ; la copia de los colores de los sprites (0xEC00): los 8 primeros, del color 5
	ld de,0ec01h		;5ad8
	ld bc,00080h		;5adb
	ld (hl),005h		;5ade
	ldir		;5ae0
	ld hl,0ec70h		;5ae2   ; y desde el 8, del color 4
	ld de,0ec71h		;5ae5
	ld bc,00100h		;5ae8
	ld (hl),004h		;5aeb
	ldir		;5aed
	call sube_colores_de_sprite		;5aef   ; los colores y los atributos, a la VRAM
	call enciende_la_pantalla		;5af2   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	call bancos_1_2_3		;5af5   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ld hl,04490h		;5af8   ; el marco del menu: (0x44, 0x90), 0x74 x 0x30, color 0x0E
	ld c,00eh		;5afb
	ld de,07430h		;5afd
	call marco		;5b00   ; marco: pinta un marco: (H, L), D de ancho, E de alto, color C
	ld hl,0639bh		;5b03   ; y su texto
	jp rotulo		;5b06   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba
franja_a_la_pagina_1:		; con el jugador en el estado 0-1, copia la franja de y 0xE8 a la pagina 1; si no, los colores de los sprites
	ld a,(0c490h)		;5b09   ; lee el estado del jugador
	cp 002h		;5b0c   ; con el jugador en el estado 2 o mas, solo los colores de los sprites
	jr nc,sube_colores_de_sprite		;5b0e
	ld hl,000e8h		;5b10   ; si no, la franja de 256 x 5 puntos de y 0xE8 de la pagina 0 a la 1
	ld d,h			;5b13
	ld e,l			;5b14
	ld bc,00005h		;5b15
	ld a,004h		;5b18
	jp hmmm		;5b1a   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
gira_los_sprites:		; gira el orden de los sprites (0xC25F) y los sube a 0x7400/0x7600
	ld hl,0c25fh		;5b1d   ; el orden de los sprites gira cada vez (0x68 mas, de 8 en 8)
	ld a,(hl)			;5b20
	add a,068h		;5b21
	and 078h		;5b23
	ld (hl),a			;5b25
	ld a,(00007h)		;5b26
	ld c,a			;5b29
	call colores_girados		;5b2a   ; los colores, en el mismo orden
	ld hl,07600h		;5b2d   ; los atributos a la tabla de 0x7600
	call vram_para_escribir		;5b30   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	ld a,(0c25fh)		;5b33
	ld d,010h		;5b36   ; 16 tandas de 8 bytes (dos sprites) de la copia de 0xEE00
	ld h,0eeh		;5b38
L_5B3A:
	ld b,008h		;5b3a
	ld l,a			;5b3c
	otir		;5b3d
	add a,048h		;5b3f   ; la tanda siguiente, 0x48 mas alla (en vueltas de 0x80)
	and 078h		;5b41
	dec d			;5b43
	jr nz,L_5B3A		;5b44
	ret			;5b46
colores_girados:		; los colores de los sprites a 0x7400, en el orden girado
	ld hl,07400h		;5b47   ; los colores a la tabla de 0x7400
	call vram_para_escribir		;5b4a   ; vram_para_escribir: prepara el V9938 para escribir en la VRAM
	ld a,(0c25fh)		;5b4d
	ld d,010h		;5b50
	add a,a			;5b52
L_5B53:
	ld h,076h		;5b53   ; HL = 0xEC00 + 2 * A: los 32 bytes de color de dos sprites
	ld l,a			;5b55
	add hl,hl			;5b56
	ld b,020h		;5b57
	otir		;5b59
	add a,090h		;5b5b
	dec d			;5b5d
	jr nz,L_5B53		;5b5e
	ret			;5b60
sube_colores_de_sprite:		; la copia de 0xEC00-0xEE7F (colores y atributos de los sprites) a 0xF400
	ld hl,0ec00h		;5b61
	ld de,0f400h		;5b64   ; 0xEC00-0xEE7F: la copia de los colores (0x200) y de los atributos (0x80)...
	ld bc,00280h		;5b67   ; ... a 0xF400-0xF67F de la VRAM
	jp copia_a_la_vram		;5b6a   ; copia_a_la_vram: copia BC bytes de HL a la VRAM de DE
figuras_de_la_casilla:		; DE = la lista de figuras de la casilla (conjunto de 0x9BF0, banco 14)
	call bancos_13_14_15		;5b6d   ; bancos_13_14_15: pone los bancos 13, 14 y 15
	ld de,09bf0h		;5b70   ; la tabla de 0x9BF0 (banco 14): 7 zonas por fase, una palabra por zona
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
	ld a,(0c281h)		;5b88   ; un nibble por casilla
	srl a		;5b8b
	call de_mas_a		;5b8d   ; de_mas_a: DE += A
	ld a,(0c281h)		;5b90   ; lee la CASILLA de la zona
	and 001h		;5b93   ; la casilla par lleva el nibble de arriba
	ld a,(de)			;5b95
	jr nz,L_5B9C		;5b96
	rra			;5b98
	rra			;5b99
	rra			;5b9a
	rra			;5b9b
L_5B9C:
	and 00fh		;5b9c   ; el conjunto de figuras de la casilla (0-15)
	ld (0cd2ch),a		;5b9e
	push af			;5ba1
	call bancos_1_2_3		;5ba2   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ld a,(0c289h)		;5ba5   ; DE = la lista del conjunto, en la tabla de su juego de graficos (0x5BB2)
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


maquina_de_estados:		; un cuadro: despacha por el estado de 0xC000 (16, tabla de 0x5DCF)
	ld hl,0c003h		;5dbb   ; un cuadro mas
	inc (hl)			;5dbe
	ld bc,(0c000h)		;5dbf   ; C = el estado, B = el paso
	ld a,c			;5dc3
	cp 003h		;5dc4   ; en los estados 0-2, al acabar se vuelve por p01:62FE
	jr nc,L_5DCC		;5dc6
	ld hl,062feh		;5dc8
	push hl			;5dcb
L_5DCC:
	call despacha		;5dcc   ; 16 estados (tabla de 0x5DCF); cada uno elige su paso con djnz: el paso 1 es el primer trozo y el 0, el ultimo

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


estado_0:		; el logotipo de Konami y el titulo
	djnz L_5DFF		;5def   ; estado 0, paso 1
	call 06486h		;5df1   ; destapa_el_logotipo: una linea mas del logotipo cada dos cuadros; al acabar, 0xC482 = 1
	ld a,(0c482h)		;5df4   ; con la pantalla especial puesta, las letras
	or a			;5df7
	ret z			;5df8
	call letras_del_texto		;5df9   ; letras_del_texto: sube las letras de los textos
	xor a			;5dfc
	jr espera_y_sigue		;5dfd
L_5DFF:
	djnz L_5E0D		;5dff   ; paso 2: la espera...
	ld hl,0c004h		;5e01   ; apunta a la espera del estado, en cuadros
	dec (hl)			;5e04
	ret nz			;5e05
	call pantalla_del_titulo		;5e06   ; ... y el titulo; al estado 1 sin espera
	xor a			;5e09
	jp L_5EF1		;5e0a
L_5E0D:
	call borra_la_pantalla		;5e0d   ; paso 0: pantalla en negro
	call 0643fh		;5e10   ; logotipo_de_konami: prepara el logotipo de Konami en la pagina 1
	jr siguiente_paso		;5e13
estado_1:		; el menu del titulo
	ld hl,0c004h		;5e15   ; estado 1: espera con la marca de la opcion parpadeando; luego el estado 2
	dec (hl)			;5e18
	jp nz,parpadea_la_opcion		;5e19   ; parpadea_la_opcion: la marca de 0x63D8 parpadea en la opcion escogida (0xC252)
	jp siguiente_estado		;5e1c   ; siguiente_estado: el estado siguiente, paso 0, con 0x20 cuadros de espera
estado_2:		; la demostracion
	djnz L_5E38		;5e1f   ; estado 2, paso 1
	call 06923h		;5e21   ; teclas_de_la_demo: la tecla de la demostracion, cada dos cuadros
	call 068f3h		;5e24   ; cuadro_de_la_demo: un cuadro de la demostracion
	ld a,(0c263h)		;5e27   ; mientras 0xC263 no sea cero sigue aqui...
	or a			;5e2a
	ret nz			;5e2b
L_5E2C:
	xor a			;5e2c   ; ... y luego al estado 0
cambia_de_estado:		; pasa al estado A, paso 0, con 0x20 cuadros de espera
	ld (0c000h),a		;5e2d   ; el estado nuevo, con 0x20 cuadros de espera y el paso a 0
	ld a,020h		;5e30
	ld (0c004h),a		;5e32   ; guarda la espera del estado, en cuadros
	jp L_5EF8		;5e35
L_5E38:
	call borra_la_pantalla		;5e38   ; estado 2, paso 0
	call 0688bh		;5e3b   ; empieza_la_demo: la demostracion: el otro jugador, zona 0, casilla 12, 99 vidas y 999 ryo
	ld a,020h		;5e3e
espera_y_sigue:		; A cuadros de espera y el paso siguiente
	ld (0c004h),a		;5e40   ; guarda la espera del estado, en cuadros
siguiente_paso:		; pasa al paso siguiente (0xC001)
	ld hl,0c001h		;5e43   ; apunta a el paso del estado
	inc (hl)			;5e46
	ret			;5e47
estado_3:		; empieza la partida
	djnz L_5E73		;5e48   ; estado 3, paso 1: el rotulo de 0x63BC parpadea (cada 4 cuadros)
	ld a,(0c002h)		;5e4a   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	bit 5,a		;5e4d   ; con el bit 5 (dos jugadores), el de 0x63CB
	ld hl,063bch		;5e4f
	jr z,L_5E57		;5e52
	ld hl,063cbh		;5e54
L_5E57:
	ld a,(0c004h)		;5e57   ; lee la espera del estado, en cuadros
	bit 2,a		;5e5a
	jr z,L_5E63		;5e5c
	call borra_rotulo		;5e5e   ; borra_rotulo: borra un rotulo ([x][y] y el texto)
	jr L_5E66		;5e61
L_5E63:
	call rotulo		;5e63   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba
L_5E66:
	ld hl,0c004h		;5e66   ; apunta a la espera del estado, en cuadros
	dec (hl)			;5e69
	ret nz			;5e6a
	ld a,(0ef00h)		;5e6b   ; al acabar la espera, con el vecino en la otra ranura, al menu del estado 0x0C
	or a			;5e6e
	jr nz,L_5E8D		;5e6f
	jr siguiente_paso		;5e71
L_5E73:
	djnz L_5E89		;5e73   ; estado 3, paso 2: la partida empieza
	call empieza_la_partida		;5e75   ; empieza_la_partida: la RAM de la partida a cero desde 0xC25A, y vidas de 0x437B
	call 0662ch		;5e78   ; prepara_la_partida: letras, dibujos de siempre y la vida a 0x10
	ld hl,0ef04h		;5e7b   ; con 0xEF04 puesto, se pone a cero y p02:8050
	ld a,(hl)			;5e7e
	or a			;5e7f
	jr z,L_5E87		;5e80
	ld (hl),000h		;5e82
	call 08050h		;5e84
L_5E87:
	jr siguiente_estado		;5e87
L_5E89:
	ld a,03ch		;5e89   ; estado 3, paso 0: 60 cuadros de espera
	jr espera_y_sigue		;5e8b
L_5E8D:
	xor a			;5e8d   ; el menu del vecino: 0xEF05 = 1, 0xEF06 = 1, 0xEF07 = 3
	ld (0ef04h),a		;5e8e
	ld a,001h		;5e91
	ld (0ef05h),a		;5e93
	ld (0ef06h),a		;5e96
	ld a,003h		;5e99
	ld (0ef07h),a		;5e9b
	ld a,00ch		;5e9e
	jp cambia_de_estado		;5ea0   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
estado_4:		; la entrada en la zona
	djnz L_5EE6		;5ea3   ; estado 4, paso 1: la entrada en la zona, al acabar la espera
	call 0823bh		;5ea5
	ld hl,0c004h		;5ea8   ; apunta a la espera del estado, en cuadros
	dec (hl)			;5eab
	ret nz			;5eac
	call borra_la_pantalla		;5ead   ; borra_la_pantalla: borra la pantalla
	call 0663ah		;5eb0   ; la zona
	call pinta_el_marcador		;5eb3   ; pinta_el_marcador: pinta el marcador entero
	ld a,(0ef81h)		;5eb6   ; con 0xEF81 a 6 o 7, p03:BEDD
	sub 006h		;5eb9
	cp 002h		;5ebb
	call c,0beddh		;5ebd   ; secreto_del_menu: el bit 6 de 0xEF80
	ld hl,0c263h		;5ec0   ; 0xC263 = 1
	ld (hl),001h		;5ec3
	ld a,095h		;5ec5   ; la musica 0x15
	call sonido		;5ec7   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call sprites_del_jugador		;5eca   ; sprites_del_jugador: sube los sprites del jugador
	di			;5ecd
	ld a,009h		;5ece   ; el banco 9 en 0xA000
	ld (0a000h),a		;5ed0   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;5ed3   ; guarda la copia del banco de 0xA000
	ei			;5ed6
	call 074a6h		;5ed7   ; sprites_del_jugador_de_ram: la posicion y los patrones de sus sprites en la copia de 0xEE00
	call bancos_1_2_3		;5eda   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call gira_los_sprites		;5edd   ; gira_los_sprites: gira el orden de los sprites (0xC25F) y los sube a 0x7400/0x7600
	call franja_a_la_pagina_1		;5ee0   ; franja_a_la_pagina_1: con el jugador en el estado 0-1, copia la franja de y 0xE8 a la pagina 1; si no, los colores de los sprites
	jp siguiente_paso		;5ee3   ; siguiente_paso: pasa al paso siguiente (0xC001)
L_5EE6:
	djnz L_5EFD		;5ee6   ; estado 4, paso 2: en cuanto acaba la musica de entrada...
	call suena_algo		;5ee8   ; suena_algo: Z si no suena nada; A = la musica que suena
	ret nz			;5eeb
	call musica_de_la_zona		;5eec   ; ... la de la zona, y al estado 5
siguiente_estado:		; el estado siguiente, paso 0, con 0x20 cuadros de espera
	ld a,020h		;5eef   ; 0x20 cuadros de espera...
L_5EF1:
	ld (0c004h),a		;5ef1   ; guarda la espera del estado, en cuadros
	ld hl,0c000h		;5ef4   ; ... el estado siguiente...
	inc (hl)			;5ef7
L_5EF8:
	xor a			;5ef8   ; ... desde el paso 0
	ld (0c001h),a		;5ef9   ; guarda el paso del estado
	ret			;5efc
L_5EFD:
	call borra_la_pantalla		;5efd   ; estado 4, paso 0: una vida menos
	ld a,(0c260h)		;5f00   ; lee las vidas
	sub 001h		;5f03
	daa			;5f05
	ld (0c260h),a		;5f06   ; guarda las vidas
	call dibujos_tras_perder_una_vida		;5f09   ; dibujos_tras_perder_una_vida: los dibujos y los patrones de sprite de la pantalla del estado 4, paso 0
	call paleta_tras_perder_una_vida		;5f0c   ; la paleta de la pantalla
	call 080d9h		;5f0f
	ld a,078h		;5f12   ; 120 cuadros
	jp espera_y_sigue		;5f14   ; espera_y_sigue: A cuadros de espera y el paso siguiente
estado_5:		; el juego
	call 06802h		;5f17   ; estado 5: el juego
	ld a,(0c282h)		;5f1a   ; con 0xC282 puesto, al estado 8
	and a			;5f1d
	ld a,008h		;5f1e
	jp nz,cambia_de_estado		;5f20   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
	ld a,(0c283h)		;5f23   ; saliendo de la casilla por un lado, al 9
	and a			;5f26
	ld a,009h		;5f27
	jp nz,cambia_de_estado		;5f29   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
	ld a,(0c008h)		;5f2c   ; con 0xC008 puesto, al 0x0A
	and a			;5f2f
	jr nz,L_5F42		;5f30
	ld a,(0c28bh)		;5f32   ; con 0xC28B puesto, al 0x0B
	and a			;5f35
	ld a,00bh		;5f36
	jp nz,cambia_de_estado		;5f38   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
	ld a,(0c263h)		;5f3b   ; y si 0xC263 es cero, al 6
	or a			;5f3e
	ret nz			;5f3f
	jr siguiente_estado		;5f40
L_5F42:
	ld hl,0c580h		;5f42   ; al 0x0A: lo tecleado en la pausa (32 bytes) a cero
	ld de,0c581h		;5f45
	ld bc,0001fh		;5f48
	ld (hl),000h		;5f4b
	ldir		;5f4d
	call 0635ah		;5f4f   ; ventana_de_la_pausa: la ventana con el texto de la pausa
	ld a,00ah		;5f52
	jp cambia_de_estado		;5f54   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
estado_6:		; se pierde una vida
	call 07e9dh		;5f57   ; estado 6
	ld a,(0c260h)		;5f5a   ; sin vidas, al estado 7
	or a			;5f5d
	jr z,L_5F7E		;5f5e
L_5F60:
	ld a,(0c360h)		;5f60   ; si el otro jugador tiene vidas (0xC360)...
	or a			;5f63
	jr z,L_5F79		;5f64
L_5F66:
	ld hl,0c260h		;5f66   ; ... se cambian los 256 bytes de un jugador por los del otro...
	ld de,0c360h		;5f69
	ld bc,00100h		;5f6c
	call intercambia		;5f6f   ; intercambia: intercambia los bytes de (HL) y (DE)
	ld hl,0c002h		;5f72   ; ... y el bit 7 de 0xC002
	ld a,(hl)			;5f75
	xor 080h		;5f76
	ld (hl),a			;5f78
L_5F79:
	ld a,004h		;5f79   ; y vuelta al estado 4
	jp cambia_de_estado		;5f7b   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
L_5F7E:
	ld a,08eh		;5f7e   ; la musica 0x0E y al estado 7
	call sonido		;5f80   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	jp siguiente_estado		;5f83   ; siguiente_estado: el estado siguiente, paso 0, con 0x20 cuadros de espera
estado_7:		; sin vidas: continuar o se acabo
	djnz L_5FCC		;5f86   ; estado 7 (sin vidas), paso 1
	ld a,(0c27fh)		;5f88   ; con continuar (0xC27F)...
	and a			;5f8b
	jr z,L_5F9E		;5f8c
	call f5_apretada		;5f8e   ; ... F5 lo pide
	jr c,L_5F9E		;5f91
	ld a,001h		;5f93
	ld (0c486h),a		;5f95   ; 0xC486 = 1 y fuera el rotulo de continuar
	ld hl,063e3h		;5f98
	call borra_rotulo		;5f9b   ; borra_rotulo: borra un rotulo ([x][y] y el texto)
L_5F9E:
	ld a,(0c0abh)		;5f9e   ; se espera a que acabe la musica
	or a			;5fa1
	ret nz			;5fa2
	ld a,(0c27fh)		;5fa3   ; lee si se puede continuar
	and a			;5fa6
	jr z,L_5FAF		;5fa7
	ld a,(0c486h)		;5fa9   ; si se pidio, a continuar
	and a			;5fac
	jr nz,L_5FF1		;5fad
L_5FAF:
	ld a,(0c360h)		;5faf   ; si el otro jugador tiene vidas, le toca
	and a			;5fb2
	jr nz,L_5F66		;5fb3
	ld hl,0c002h		;5fb5   ; si no, se acabo la partida: fuera el bit 6...
	ld a,(hl)			;5fb8
	and 0bfh		;5fb9
	ld (hl),a			;5fbb
	xor a			;5fbc   ; ... y los secretos de las claves a cero
	ld (0cd2fh),a		;5fbd
	ld (0ef80h),a		;5fc0   ; guarda los SECRETOS: bit 0 y 1 las palabras de la pausa, 2-5 las claves, 6 el menu
	ld (0ef81h),a		;5fc3
	ld (0cd60h),a		;5fc6
	jp L_5E2C		;5fc9
L_5FCC:
	call borra_la_pantalla		;5fcc   ; estado 7, paso 0: el rotulo de 0x63DB
	ld hl,063dbh		;5fcf
	call rotulo		;5fd2   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba
	ld a,(0c27fh)		;5fd5   ; con continuar puesto, tambien el de 0x63E3
	and a			;5fd8
	jr z,L_5FE1		;5fd9
	ld hl,063e3h		;5fdb
	call rotulo		;5fde   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba
L_5FE1:
	call pinta_el_marcador		;5fe1   ; pinta_el_marcador: pinta el marcador entero
	ld a,078h		;5fe4   ; 120 cuadros
	jp espera_y_sigue		;5fe6   ; espera_y_sigue: A cuadros de espera y el paso siguiente
f5_apretada:		; carry si F5 NO esta apretada
	ld a,007h		;5fe9   ; la fila 7 del teclado: el bit 1 es F5
	call 00141h		;5feb   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;5fee   ; carry si no esta apretada
	rra			;5fef
	ret			;5ff0
L_5FF1:
	ld a,003h		;5ff1   ; continuar: 3 vidas...
	ld (0c260h),a		;5ff3   ; guarda las vidas
	ld a,(0c002h)		;5ff6   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	ld hl,0c257h		;5ff9   ; ... y los puntos a cero
	bit 5,a		;5ffc
	jr nz,$+8		;5ffe
