; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX2 - MegaROM RC-748 de 128 KB (Konami4) - banco 02 (se ejecuta en 0x8000)
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
	rra			;8000   ; D = el numero del primer bit puesto de A (B bits): carry si lo hay
	ret c			;8001   ; encontrado
	inc d			;8002   ; el bit siguiente
	djnz L_8000		;8003
	ret			;8005
L_8006:
	xor a			;8006   ; las teclas 0-7 (fila 0)...
	call 00141h		;8007   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;800a   ; apretadas a uno
	ld d,a			;800b   ; D = 0-7
	ld a,001h		;800c   ; ... y 8 y 9 (fila 1)
	call 00141h		;800e   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8011   ; apretadas a uno
	and 003h		;8012   ; solo el 8 y el 9
	ld e,a			;8014
	ld a,d			;8015   ; lo de la fila 0...
	ld hl,0ef08h		;8016   ; 0xEF08/0xEF09: lo apretado; D y E, lo nuevo
	ld c,(hl)			;8019   ; ... lo de antes...
	ld (hl),a			;801a
	xor c			;801b   ; ... y lo nuevo
	and (hl)			;801c
	ld d,a			;801d
	ld a,e			;801e   ; lo de la fila 1, igual (0xEF09)
	inc hl			;801f
	ld c,(hl)			;8020
	ld (hl),a			;8021
	xor c			;8022
	and (hl)			;8023
	ld e,a			;8024
	or d			;8025   ; NZ si hay alguna nueva
	ret			;8026
L_8027:
	ld hl,0ef0fh		;8027   ; el numero de 0xEF0F, de BCD a binario, a 0xEF0E
	ld a,(hl)			;802a   ; el numero, en BCD
	ld c,a			;802b
	rrca			;802c   ; las decenas...
	rrca			;802d
	rrca			;802e
	rrca			;802f
	and 00fh		;8030   ; de 0 a 9
	add a,a			;8032   ; ... por 10 (2 + 8)
	ld b,a			;8033
	add a,a			;8034   ; * 8
	add a,a			;8035
	add a,b			;8036   ; + * 2
	ld b,a			;8037
	ld a,c			;8038   ; mas las unidades
	and 00fh		;8039
	add a,b			;803b
	ld (0ef0eh),a		;803c   ; a 0xEF0E
	ret			;803f
L_8040:
	ld a,007h		;8040   ; RETURN (fila 7, bit 7) recien apretada
	call 00141h		;8042   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8045   ; apretada a uno
	and 080h		;8046
	ld hl,0ef0ah		;8048   ; 0xEF0A: la de antes
	ld c,(hl)			;804b
	ld (hl),a			;804c
	xor c			;804d   ; NZ si es nueva
	and (hl)			;804e
	ret			;804f
L_8050:
	push af			;8050   ; lo que se eligio en el menu del vecino, al jugador que juega...
	call aplica_el_menu		;8051   ; al que juega
	pop af			;8054
	ld b,a			;8055   ; B = lo que se aplica
	ld a,(0c002h)		;8056   ; ... y al otro en la partida de dos
	and 020h		;8059
	ret z			;805b
	push bc			;805c   ; se cambian los dos jugadores...
	call cambia_de_jugador		;805d   ; cambia_de_jugador: los 256 bytes de un jugador por los del otro
	pop bc			;8060
	ld a,b			;8061   ; ... se le aplica al otro...
	call aplica_el_menu		;8062   ; aplica_el_menu: la zona, la fase y las vidas del menu del vecino
cambia_de_jugador:		; los 256 bytes de un jugador por los del otro
	ld hl,0c260h		;8065   ; ... y se vuelven a cambiar
	ld de,0c360h		;8068
	ld bc,00100h		;806b
	jp 04449h		;806e   ; intercambia: intercambia los bytes de (HL) y (DE)
aplica_el_menu:		; la zona, la fase y las vidas del menu del vecino
	rra			;8071   ; bit 0: la zona (0xEF06 - 1, 0-6) y 0xC261 (0xEF05, hasta 7)
	push af			;8072
	jr nc,L_808C		;8073   ; sin el bit 0, solo las vidas
	ld a,(0ef06h)		;8075
	dec a			;8078
	cp 007h		;8079   ; de 1 a 7; si no, la 0
	jr c,L_807E		;807b
	xor a			;807d
L_807E:
	ld (0c280h),a		;807e   ; guarda la ZONA (0-6)
	ld a,(0ef05h)		;8081
	cp 008h		;8084   ; hasta 7; si no, 0
	jr c,L_8089		;8086
	xor a			;8088
L_8089:
	ld (0c261h),a		;8089   ; 0xC261 = lo elegido
L_808C:
	pop af			;808c   ; bit 1: las vidas (0xEF07)
	rra			;808d
	ret nc			;808e
	ld a,(0ef07h)		;808f
	ld (0c260h),a		;8092   ; guarda las vidas
	ret			;8095
L_8096:
	rra			;8096   ; arriba o abajo en el menu: la opcion de 0xEF0B, de 0 a 2
	ld a,001h		;8097   ; abajo: + 1
	jr nc,L_809D		;8099
	ld a,0ffh		;809b   ; arriba: - 1
L_809D:
	ld b,a			;809d
	ld hl,0ef0bh		;809e
	add a,(hl)			;80a1
	and 003h		;80a2
	cp 003h		;80a4   ; se pasa por arriba (3)...
	jr nz,L_80AF		;80a6
	ld a,b			;80a8   ; ... o por abajo
	add a,a			;80a9
	ld a,002h		;80aa   ; ... a la 2
	jr c,L_80AF		;80ac
	xor a			;80ae   ; ... a la 0
L_80AF:
	push af			;80af
	push hl			;80b0
	ld a,(hl)			;80b1   ; se borra la marca de la que habia...
	call marca_de_opcion_borrada		;80b2   ; marca_de_opcion_borrada: C y B = 0: sin marca
	pop hl			;80b5
	pop af			;80b6
	ld (hl),a			;80b7   ; la nueva opcion
	jp L_80C0		;80b8   ; ... y se pinta en la nueva (letras 0xBC y 0xBD)
marca_de_opcion_borrada:		; C y B = 0: sin marca
	ld bc,00000h		;80bb   ; letras 0: borrar
	jr L_80C3		;80be
L_80C0:
	ld bc,0bcbdh		;80c0   ; las letras 0xBC y 0xBD
L_80C3:
	ld hl,080d6h		;80c3   ; la y de cada opcion (0x80D6); x 0x24 y 0x2C
	call 04083h		;80c6   ; hl_mas_a: HL += A
	ld e,(hl)			;80c9   ; E = la y de la opcion
	ld d,024h		;80ca   ; en x 0x24...
	ld a,b			;80cc
	call 0491ch		;80cd   ; letra: pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco
	ld d,02ch		;80d0   ; ... y 0x2C
	ld a,c			;80d2
	jp 0491ch		;80d3   ; letra: pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco

; ----------------------------------------------------------------------
; DATOS tres_x: tres x (0xA8, 0xB0 y 0xB8) donde p02:80C9 escribe un caracter
;   en la fila 0x24 (3 bytes)
;   0x80d6..0x80d9  (3 bytes)
DATA_tres_x:
	defb 0a8h,0b0h,0b8h	; 80d6

; ======================================================================
; CODIGO 0x80d9..0x8177  (158 bytes)
; ======================================================================


L_80D9:
	ld a,001h		;80d9   ; la pantalla de antes de entrar en la zona: el plano de la fase con sus siete zonas
	ld (0cd15h),a		;80db   ; 0xCD15 = 1: al entrar, la primera tanda de figuras
	call plano_de_la_fase		;80de   ; plano_de_la_fase: 3 filas de 28 caracteres de 0xA099
	call marcos_de_la_fase		;80e1   ; marcos_de_la_fase: el rotulo 0x0C y los dos marcos
	call sprites_de_la_fase		;80e4   ; sprites_de_la_fase: los colores y los sprites de la pantalla de la fase
	call zonas_de_la_fase		;80e7   ; zonas_de_la_fase: los dibujos de las siete zonas
	call 05b61h		;80ea   ; sube_colores_de_sprite: la copia de 0xEC00-0xEE7F (colores y atributos de los sprites) a 0xF400
	ret			;80ed
plano_de_la_fase:		; 3 filas de 28 caracteres de 0xA099
	ld hl,0a099h		;80ee   ; 3 filas de 28 caracteres de 0xA099, desde y 0x10
	ld de,00010h		;80f1
	ld b,003h		;80f4
L_80F6:
	push bc			;80f6   ; 28 caracteres por fila
	ld b,01ch		;80f7
L_80F9:
	ld a,(hl)			;80f9   ; el caracter
	inc hl			;80fa
	push de			;80fb   ; DE' = donde va
	exx			;80fc
	pop de			;80fd
	ld l,a			;80fe   ; el caracter n: en la pagina 1, x = (n mod 32) * 8, y = (n / 32) * 8
	ld h,000h		;80ff
	add hl,hl			;8101
	add hl,hl			;8102
	add hl,hl			;8103
	ld a,h			;8104   ; L = (n / 32) * 8
	add a,a			;8105
	add a,a			;8106
	add a,a			;8107
	ld h,l			;8108   ; H = (n mod 32) * 8
	ld l,a			;8109
	ld a,005h		;810a   ; de la pagina 1 a la 1
	ld bc,00808h		;810c   ; 8 x 8
	call 0476eh		;810f   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
	exx			;8112
	ld a,008h		;8113   ; el siguiente, 8 a la derecha
	add a,d			;8115
	ld d,a			;8116
	djnz L_80F9		;8117
	ld d,000h		;8119   ; la fila siguiente, desde x 0
	ld a,008h		;811b
	add a,e			;811d
	ld e,a			;811e
	pop bc			;811f
	djnz L_80F6		;8120
	ret			;8122
marcos_de_la_fase:		; el rotulo 0x0C y los dos marcos
	ld a,00ch		;8123   ; el rotulo 0x0C y dos marcos del color 0x0F
	call 04280h		;8125   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ld hl,07040h		;8128
	ld de,01f4fh		;812b
	ld c,00fh		;812e
	call 04704h		;8130   ; marco: pinta un marco: (H, L), D de ancho, E de alto, color C
	ld hl,07242h		;8133
	ld de,01b4bh		;8136
	ld c,00fh		;8139
	call 04704h		;813b   ; marco: pinta un marco: (H, L), D de ancho, E de alto, color C
	ret			;813e
sprites_de_la_fase:		; los colores y los sprites de la pantalla de la fase
	call colores_de_la_fase		;813f   ; los colores y los sprites
	call marca_de_la_zona		;8142   ; marca_de_la_zona: los dos sprites que marcan la zona
	ld a,(0c288h)		;8145   ; tres por fase (0x817D)
	ld b,a			;8148
	add a,a			;8149
	add a,b			;814a
	ld de,0817dh		;814b
	call 04088h		;814e   ; de_mas_a: DE += A
	exx			;8151
	ld hl,08177h		;8152
	exx			;8155
	ld hl,0ee08h		;8156   ; tres sprites desde el 2 (0xEE08), con su y y su x de 0x8177
	ld b,003h		;8159
L_815B:
	exx			;815b   ; [y]...
	ld a,(hl)			;815c
	inc hl			;815d
	exx			;815e
	ld (hl),a			;815f
	inc hl			;8160
	exx			;8161
	ld a,(hl)			;8162   ; ... [x]...
	inc hl			;8163
	exx			;8164
	ld (hl),a			;8165
	inc hl			;8166
	ld a,(de)			;8167   ; ... y el patron de 0x817D
	inc de			;8168
	cp 0ffh		;8169   ; 0xFF: no hay
	jr z,L_8173		;816b
	ld (hl),a			;816d   ; el patron
	inc hl			;816e
	inc hl			;816f
L_8170:
	djnz L_815B		;8170   ; los tres sprites
	ret			;8172
L_8173:
	dec hl			;8173   ; sin patron, el sprite no se cuenta
	dec hl			;8174
	jr L_8170		;8175

; ----------------------------------------------------------------------
; DATOS seis_8177: seis bytes que p02:8152 reparte de dos en dos por los
;   sprites de 0xEE08 (6 bytes)
;   0x8177..0x817d  (6 bytes)
DATA_seis_8177:
	defb 048h,078h,060h,078h,078h,078h	; 8177

; ----------------------------------------------------------------------
; DATOS tres_por_fase: tres bytes por fase (0xC288 x 3) que lee p02:814B (21
;   bytes)
;   0x817d..0x8192  (21 bytes)
DATA_tres_por_fase:
	defb 000h,004h,034h	; 817d
	defb 008h,00ch,034h	; 8180
	defb 010h,014h,034h	; 8183
	defb 018h,01ch,034h	; 8186
	defb 020h,024h,034h	; 8189
	defb 028h,02ch,034h	; 818c
	defb 01ch,0ffh,030h	; 818f

; ======================================================================
; CODIGO 0x8192..0x81c2  (48 bytes)
; ======================================================================


marca_de_la_zona:		; los dos sprites que marcan la zona
	ld a,(0c280h)		;8192   ; la marca de la zona: dos sprites en el sitio de 0x81C2
	add a,a			;8195
	ld hl,081c2h		;8196
	call 04083h		;8199   ; hl_mas_a: HL += A
	ld b,002h		;819c
	ld de,0ee00h		;819e
L_81A1:
	ld a,(hl)			;81a1
	ld (0cd0eh),a		;81a2   ; la y, guardada en 0xCD0E para el parpadeo
	ld (de),a			;81a5   ; la y
	inc hl			;81a6
	inc de			;81a7
	ld a,(hl)			;81a8   ; la x
	ld (de),a			;81a9
	inc hl			;81aa
	inc de			;81ab
	ld a,(0c002h)		;81ac   ; patron 0x34 (Goemon) o 0x3C (Ebisumaru), mas 4 por sprite
	rla			;81af
	ld a,034h		;81b0
	jr nc,L_81B6		;81b2
	ld a,03ch		;81b4
L_81B6:
	add a,b			;81b6   ; + 4 * B: el patron de cada sprite
	add a,b			;81b7
	add a,b			;81b8
	add a,b			;81b9
	ld (de),a			;81ba   ; el patron
	inc de			;81bb   ; el siguiente sprite (4 bytes)
	inc de			;81bc
	dec hl			;81bd   ; los dos en el mismo sitio
	dec hl			;81be
	djnz L_81A1		;81bf
	ret			;81c1

; ----------------------------------------------------------------------
; DATOS puntos_de_las_zonas: 7 parejas [y][x], una por zona: p02:8196 pone ahi
;   el sprite de la zona 0xC280 y p02:820A pinta las siete (14 bytes)
;   0x81c2..0x81d0  (14 bytes)
DATA_puntos_de_las_zonas:
	defb 040h,020h	; 81c2
	defb 078h,020h	; 81c4
	defb 0a8h,070h	; 81c6
	defb 078h,0b8h	; 81c8
	defb 040h,0b8h	; 81ca
	defb 010h,090h	; 81cc
	defb 008h,050h	; 81ce

; ======================================================================
; CODIGO 0x81d0..0x8294  (196 bytes)
; ======================================================================


colores_de_la_fase:		; los colores de los sprites de la pantalla de la fase
	ld hl,0ec00h		;81d0   ; colores: 16 lineas del 2, 16 del 0x41 y 48 del 0x0E
	ld a,002h		;81d3
	ld b,010h		;81d5
	call rellena_b		;81d7   ; 16 lineas del 2
	ld hl,0ec10h		;81da
	ld a,041h		;81dd
	ld b,010h		;81df
	call rellena_b		;81e1   ; 16 del 0x41
	ld hl,0ec20h		;81e4
	ld a,00eh		;81e7
	ld b,030h		;81e9
rellena_b:		; B veces A desde HL
	ld (hl),a			;81eb   ; B veces A desde HL
	inc hl			;81ec
	djnz rellena_b		;81ed
	ret			;81ef
zonas_de_la_fase:		; los dibujos de las siete zonas
	di			;81f0   ; los dibujos de las siete zonas, segun su juego de graficos (0xB8EC)
	ld a,009h		;81f1
	ld (0a000h),a		;81f3   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;81f6   ; guarda la copia del banco de 0xA000
	ei			;81f9
	ld a,(0c288h)		;81fa   ; lee la FASE (0-6)
	ld de,0b8ech		;81fd
	ld b,a			;8200
	add a,a			;8201
	add a,a			;8202
	add a,a			;8203
	sub b			;8204
	call 04088h		;8205   ; de_mas_a: DE += A
	ld b,007h		;8208
	ld hl,081c2h		;820a
L_820D:
	ld a,(de)			;820d   ; el juego de graficos de la zona
	inc de			;820e
	push hl			;820f
	exx			;8210
	pop hl			;8211
	ld c,(hl)			;8212   ; su sitio en el plano de la fase
	inc hl			;8213
	ld h,(hl)			;8214
	ld l,c			;8215
	call dibujo_del_juego		;8216   ; cada uno en el sitio de su zona (0x81C2)
	exx			;8219
	inc hl			;821a
	inc hl			;821b
	djnz L_820D		;821c   ; las siete
	ld de,05020h		;821e   ; y uno mas en (0x50, 0x20)
	ld hl,0c010h		;8221   ; HL = (0xC0, 0x10) de la pagina 1: el dibujo que va en (0x50, 0x20)
	call copia_32x24		;8224   ; copia_32x24: HMMM de 32 x 24 de la pagina 1 a la 0
	jp 04206h		;8227   ; bancos_1_2_3: pone los bancos 1, 2 y 3
dibujo_del_juego:		; el dibujo del juego de graficos A en DE
	ex de,hl			;822a   ; el dibujo del juego A: 32 x 24 de (A * 32, 0x10) de la pagina 1
	add a,a			;822b   ; el juego * 32: su x en la pagina 1
	add a,a			;822c
	add a,a			;822d
	add a,a			;822e
	add a,a			;822f
	ld h,a			;8230
	ld l,010h		;8231   ; y 0x10
copia_32x24:		; HMMM de 32 x 24 de la pagina 1 a la 0
	ld a,001h		;8233   ; de la pagina 1 a la 0, 32 x 24
	ld bc,02018h		;8235
	jp 0476eh		;8238   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
L_823B:
	ld a,(0c003h)		;823b   ; cada 8 cuadros, la marca de la zona aparece o desaparece
	ld b,a			;823e
	and 007h		;823f
	ret nz			;8241
	ld a,b			;8242
	and 008h		;8243   ; la mitad del tiempo...
	ld a,(0cd0eh)		;8245   ; ... en su y...
	jr z,L_824C		;8248
	ld a,0e0h		;824a   ; ... y la otra mitad fuera (0xE0)
L_824C:
	ld (0ee00h),a		;824c   ; los dos sprites de la marca
	ld (0ee04h),a		;824f
	jp 05b61h		;8252   ; sube_colores_de_sprite: la copia de 0xEC00-0xEE7F (colores y atributos de los sprites) a 0xF400
figuras_que_salen:		; las figuras que van saliendo
	ld a,(0c490h)		;8255   ; las figuras que van saliendo: en el suelo o saltando, en una casilla normal
	cp 002h		;8258   ; solo en el suelo o saltando...
	ret nc			;825a
	ld a,(0c483h)		;825b   ; ... fuera de los pasadizos...
	or a			;825e
	ret nz			;825f
	ld a,(0c482h)		;8260   ; ... fuera de los interiores...
	or a			;8263
	ret nz			;8264
	ld a,(0cd11h)		;8265   ; ... y sin texto en marcha
	or a			;8268
	ret nz			;8269
	call la_que_vuelve		;826a   ; la que sale cada tanto (p02:861F)
	call cuantas_figuras		;826d   ; cuantas hay y si se espera mas
	ld hl,0cd16h		;8270   ; 0xCD16: cuando llega a 0, sale otra
	dec (hl)			;8273
	ret nz			;8274
	call espera_de_figura		;8275   ; la espera siguiente
	call 05b6dh		;8278   ; la lista de la casilla: [cuantas - 1] y los tipos
	ld hl,0cd17h		;827b   ; 0xCD17: la que toca, en rueda
	ld c,(hl)			;827e
	ld a,(de)			;827f   ; cuantas tiene la lista
	inc de			;8280
	inc de			;8281
	cp c			;8282   ; dada la vuelta, desde la 0
	jr nz,L_8289		;8283
	xor a			;8285
	ld (hl),a			;8286
	ld c,000h		;8287
L_8289:
	inc (hl)			;8289   ; la siguiente
	ld l,c			;828a
	ld h,000h		;828b
	add hl,de			;828d
	ld a,(hl)			;828e   ; y se crea segun su tipo (tabla de 0x8294)
crea_por_tipo:		; crea la figura de tipo A segun su tabla
	ld b,a			;828f   ; B = el tipo
	dec a			;8290   ; su arranque (tabla de 0x8294)
	call 0408dh		;8291   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8294: 47 destinos del despachador de 0x408D (call en p02:8291):
;   0x8334, 0x8334, 0xA14E, 0xA360, 0x8334, 0x8334, 0xB5C9, 0x8334 ...; lo
;   leen p02:8291 (94 bytes)
;   0x8294..0x82f2  (94 bytes)
DATA_tabla_8294:
	defb 034h,083h	; 8294
	defb 034h,083h	; 8296
	defb 04eh,0a1h	; 8298
	defb 060h,0a3h	; 829a
	defb 034h,083h	; 829c
	defb 034h,083h	; 829e
	defb 0c9h,0b5h	; 82a0
	defb 034h,083h	; 82a2
	defb 034h,083h	; 82a4
	defb 034h,083h	; 82a6
	defb 034h,083h	; 82a8
	defb 034h,083h	; 82aa
	defb 0c9h,0b5h	; 82ac
	defb 034h,083h	; 82ae
	defb 034h,083h	; 82b0
	defb 034h,083h	; 82b2
	defb 034h,083h	; 82b4
	defb 0d7h,09ch	; 82b6
	defb 034h,083h	; 82b8
	defb 034h,083h	; 82ba
	defb 034h,083h	; 82bc
	defb 034h,083h	; 82be
	defb 034h,083h	; 82c0
	defb 034h,083h	; 82c2
	defb 034h,083h	; 82c4
	defb 034h,083h	; 82c6
	defb 034h,083h	; 82c8
	defb 034h,083h	; 82ca
	defb 0ddh,09bh	; 82cc
	defb 034h,083h	; 82ce
	defb 034h,083h	; 82d0
	defb 034h,083h	; 82d2
	defb 034h,083h	; 82d4
	defb 0d6h,0ach	; 82d6
	defb 0deh,0ach	; 82d8
	defb 066h,0b1h	; 82da
	defb 031h,0adh	; 82dc
	defb 080h,0b0h	; 82de
	defb 008h,0afh	; 82e0
	defb 0f2h,0b0h	; 82e2
	defb 09ah,0b2h	; 82e4
	defb 0a2h,0b2h	; 82e6
	defb 049h,0b5h	; 82e8
	defb 047h,0b3h	; 82ea
	defb 04ch,096h	; 82ec
	defb 00ah,097h	; 82ee
	defb 087h,0b6h	; 82f0

; ======================================================================
; CODIGO 0x82f2..0x8427  (309 bytes)
; ======================================================================


espera_de_figura:		; la espera hasta la figura siguiente
	ld a,(0cd12h)		;82f2   ; la espera: 0xE0 - (los bits 2-3 de 0xCD12) * 8
	and 00ch		;82f5   ; los bits 2-3
	add a,a			;82f7   ; * 8
	add a,a			;82f8
	add a,a			;82f9
	ld c,a			;82fa
	ld a,0e0h		;82fb
	sub c			;82fd   ; menos que 0xE0
	ld (0cd16h),a		;82fe   ; la espera
	ret			;8301
cuantas_figuras:		; cuantas figuras hay y si hay que esperar
	ld hl,0c600h		;8302   ; cuantas figuras hay en 0xC600
	ld de,00080h		;8305   ; de 0x80 en 0x80
	ld b,008h		;8308
	ld c,000h		;830a   ; C = cuantas
L_830C:
	ld a,(hl)			;830c   ; una con tipo...
	or a			;830d
	jr z,L_8311		;830e
	inc c			;8310   ; ... una mas
L_8311:
	add hl,de			;8311   ; la siguiente
	djnz L_830C		;8312
	ld a,c			;8314   ; ninguna: la siguiente sale enseguida (16 cuadros)
	or a			;8315
	jr nz,L_8324		;8316
	ld a,(0cd16h)		;8318   ; si faltaba mucho, se acorta a 16
	cp 012h		;831b
	ret c			;831d   ; si ya falta poco, se deja
	ld a,010h		;831e
	ld (0cd16h),a		;8320
	ret			;8323
L_8324:
	ld a,(0cd12h)		;8324   ; mas de 3 + (los bits 2-3 de 0xCD12) / 4: espera
	and 00ch		;8327
	rra			;8329
	rra			;832a
	add a,003h		;832b
	cp c			;832d   ; si no hay tantas, no se espera
	ret nc			;832e
	ld hl,0cd16h		;832f   ; espera un cuadro mas
	inc (hl)			;8332
	ret			;8333
crea_figura:		; crea una figura en el primer hueco libre de 0xC600
	ld a,b			;8334   ; B = el tipo, DE = el sitio
	ld (0cd39h),a		;8335   ; 0xCD39 = el tipo
	ld (0cd3ah),de		;8338   ; 0xCD3A/0xCD3B = el sitio
	ld hl,0c600h		;833c   ; el primer hueco libre de los ocho
	ld b,008h		;833f
	xor a			;8341
	ld de,00080h		;8342
L_8345:
	cp (hl)			;8345   ; un hueco: tipo 0
	jr z,L_834C		;8346
	add hl,de			;8348
	djnz L_8345		;8349
	ret			;834b   ; ninguno libre: no sale
L_834C:
	push hl			;834c   ; IX = la figura
	pop ix		;834d
	ld (0cd3ch),hl		;834f
	ld a,(0cd39h)		;8352   ; cuantos sprites lleva su tipo (0x84AF)
	ld hl,084afh		;8355
	call 04083h		;8358   ; hl_mas_a: HL += A
	ld a,(hl)			;835b
	ld (ix+020h),a		;835c   ; guarda cuantos sprites lleva la figura
	ld c,a			;835f
	and a			;8360
	jp z,L_83E6		;8361
	ld de,00000h		;8364   ; sus huecos de sprite: los libres de 0xEE20 (y = 0xE0), doce
	ld hl,0ee20h		;8367
	ld b,00ch		;836a
L_836C:
	ld a,(hl)			;836c   ; un hueco de sprite libre (y = 0xE0)
	cp 0e0h		;836d
	jr nz,L_8391		;836f
	ld (hl),0e1h		;8371   ; 0xE1: cogido
	call hueco_del_sprite		;8373   ; a la figura, con el numero de hueco D
	inc e			;8376   ; el sprite siguiente de la figura, y el hueco siguiente
	inc d			;8377
	ld a,004h		;8378
	call 04083h		;837a   ; hl_mas_a: HL += A
	ld (hl),0e1h		;837d   ; el siguiente tambien se coge: van de dos en dos
	call hueco_del_sprite		;837f   ; hueco_del_sprite: el sprite E de la figura usa el hueco D
	inc e			;8382
	inc d			;8383
	ld a,004h		;8384
	call 04083h		;8386   ; hl_mas_a: HL += A
	dec c			;8389   ; dos menos
	jr z,L_83E6		;838a   ; todos los que pide: a crearla
	dec c			;838c
	jr z,L_83E6		;838d
	jr L_839B		;838f
L_8391:
	inc d			;8391   ; ocupado: dos huecos mas alla
	inc d			;8392
	inc hl			;8393   ; 8 bytes de la copia: dos sprites
	inc hl			;8394
	inc hl			;8395
	inc hl			;8396
	inc hl			;8397
	inc hl			;8398
	inc hl			;8399
	inc hl			;839a
L_839B:
	djnz L_836C		;839b   ; los doce
	ld a,(ix+020h)		;839d   ; si no hubo huecos para todos, se sueltan los que se cogieron
	sub c			;83a0   ; los que si se cogieron
	ret z			;83a1
	ld hl,(0cd3ch)		;83a2   ; se sueltan
	ld de,00005h		;83a5   ; de cinco en cinco bytes, desde (ix+0x21)
	ld b,a			;83a8
	ld a,021h		;83a9
	call 04083h		;83ab   ; hl_mas_a: HL += A
L_83AE:
	ld a,(hl)			;83ae   ; el numero de hueco
	push hl			;83af
	ld hl,0ee20h		;83b0
	add a,a			;83b3   ; * 4
	add a,a			;83b4
	call 04083h		;83b5   ; hl_mas_a: HL += A
	ld a,0e0h		;83b8   ; libre otra vez
	ld (hl),a			;83ba
	pop hl			;83bb
	add hl,de			;83bc   ; el siguiente sprite de la figura
	djnz L_83AE		;83bd
	ld a,(0cd39h)		;83bf   ; el tipo 7: 0xCD14 = 0, 0xCD31 = 0 y 0xCD30 = 16
	cp 007h		;83c2   ; el tipo 7
	ret nz			;83c4
	xor a			;83c5
	ld (0cd14h),a		;83c6
	ld (0cd31h),a		;83c9
	ld a,010h		;83cc
	ld (0cd30h),a		;83ce
	ret			;83d1
figura_a_cero:		; los 32 primeros bytes de la figura a cero
	push hl			;83d2   ; los 32 primeros bytes de la figura a cero
	push bc			;83d3
	push de			;83d4
	ld hl,(0cd3ch)		;83d5   ; la figura nueva (0xCD3C)
	ld d,h			;83d8
	ld e,l			;83d9
	inc de			;83da
	ld bc,0001fh		;83db   ; 32 bytes
	xor a			;83de
	ld (hl),a			;83df   ; el primero, a 0
	ldir		;83e0   ; y el resto
	pop de			;83e2
	pop bc			;83e3
	pop hl			;83e4
	ret			;83e5
L_83E6:
	call figura_a_cero		;83e6   ; la figura: [0] el tipo, [1] el paso 0...
	ld hl,(0cd3ch)		;83e9
	ld a,(0cd39h)		;83ec
	ld (hl),a			;83ef
	inc l			;83f0
	ld (hl),000h		;83f1
	ld de,(0cd3ah)		;83f3   ; ... [3] la y y [5] la x (de DE), sin fracciones
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
	ld (ix+00ch),003h		;8404   ; (ix+0x0C) = 3: hace dano y se le puede dar
	ld de,084ddh		;8408   ; los patrones de sus sprites (0x84DD)
	call patrones_de_la_figura		;840b   ; patrones_de_la_figura: los patrones de sus sprites, de la lista de DE
	ld hl,(0cd3ch)		;840e
	ld a,(ix+000h)		;8411   ; lee el tipo de la figura
	ld (0cd37h),a		;8414   ; los colores segun su tipo
	call 054e6h		;8417   ; colores_de_la_figura: los 16 colores de cada sprite de la figura, con la lista de su pose (0x554E)
	call 0aa04h		;841a   ; y lo de p03:AA04
	ld hl,(0cd3ch)		;841d
	ld a,(ix+000h)		;8420   ; el arranque de cada tipo (tabla de 0x8427)
	dec a			;8423
	call 0408dh		;8424   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8427: 47 destinos del despachador de 0x408D (call en p02:8424):
;   0xA0ED, 0xA296, 0xA151, 0xA368, 0xA3F9, 0xA49E, 0xB5EC, 0xA4D3 ...; lo
;   leen p02:8424 (94 bytes)
;   0x8427..0x8485  (94 bytes)
DATA_tabla_8427:
	defb 0edh,0a0h	; 8427
	defb 096h,0a2h	; 8429
	defb 051h,0a1h	; 842b
	defb 068h,0a3h	; 842d
	defb 0f9h,0a3h	; 842f
	defb 09eh,0a4h	; 8431
	defb 0ech,0b5h	; 8433
	defb 0d3h,0a4h	; 8435
	defb 047h,0a7h	; 8437
	defb 0d5h,0aah	; 8439
	defb 0d3h,0abh	; 843b
	defb 0d3h,0abh	; 843d
	defb 0ech,0b5h	; 843f
	defb 047h,0a7h	; 8441
	defb 047h,0a7h	; 8443
	defb 0d3h,0a4h	; 8445
	defb 047h,0a7h	; 8447
	defb 0e9h,09ch	; 8449
	defb 0d3h,0a4h	; 844b
	defb 0d3h,0a4h	; 844d
	defb 047h,0a7h	; 844f
	defb 047h,0a7h	; 8451
	defb 047h,0a7h	; 8453
	defb 047h,0a7h	; 8455
	defb 047h,0a7h	; 8457
	defb 047h,0a7h	; 8459
	defb 0d3h,0a4h	; 845b
	defb 0d3h,0a4h	; 845d
	defb 0e3h,09bh	; 845f
	defb 0d3h,0a4h	; 8461
	defb 047h,0a7h	; 8463
	defb 047h,0a7h	; 8465
	defb 0d3h,0a4h	; 8467
	defb 0e6h,0ach	; 8469
	defb 0e6h,0ach	; 846b
	defb 06ch,0b1h	; 846d
	defb 039h,0adh	; 846f
	defb 086h,0b0h	; 8471
	defb 010h,0afh	; 8473
	defb 0fah,0b0h	; 8475
	defb 0aah,0b2h	; 8477
	defb 0aah,0b2h	; 8479
	defb 051h,0b5h	; 847b
	defb 04fh,0b3h	; 847d
	defb 053h,096h	; 847f
	defb 012h,097h	; 8481
	defb 08dh,0b6h	; 8483

; ======================================================================
; CODIGO 0x8485..0x84b0  (43 bytes)
; ======================================================================


patrones_de_la_figura:		; los patrones de sus sprites, de la lista de DE
	ld a,(ix+020h)		;8485   ; a cada sprite de la figura, su patron de la lista de DE
	and a			;8488
	ret z			;8489
	ld a,(ix+000h)		;848a   ; lee el tipo de la figura
	call 0447ch		;848d   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,(0cd3ch)		;8490
	set 5,l		;8493   ; (ix+0x20): cuantos
	ld b,(hl)			;8495
L_8496:
	ld a,l			;8496   ; el byte del sprite siguiente
	add a,005h		;8497
	ld l,a			;8499
	ld a,(de)			;849a   ; el patron de la lista
	inc de			;849b
	ld (hl),a			;849c
	djnz L_8496		;849d
	ret			;849f
hueco_del_sprite:		; el sprite E de la figura usa el hueco D
	push hl			;84a0   ; el sprite E de la figura usa el hueco D: (ix + 0x21 + E * 5) = D
	ld hl,(0cd3ch)		;84a1
	ld a,e			;84a4   ; E * 5...
	add a,a			;84a5
	add a,a			;84a6
	add a,e			;84a7
	add a,021h		;84a8   ; ... + 0x21
	call 04083h		;84aa   ; hl_mas_a: HL += A
	ld (hl),d			;84ad   ; el hueco
	pop hl			;84ae
	ret			;84af

; ----------------------------------------------------------------------
; DATOS sprites_de_cada_figura: cuantos sprites lleva cada figura 1-47
;   (p02:8355 suma el numero a 0x84AF, asi que la 0 seria el `ret` de
;   p02:84AF); p02:835C lo deja en (ix+0x20) (47 bytes)
;   0x84b0..0x84df  (47 bytes)
DATA_sprites_de_cada_figura:
	defb 002h,002h,008h,002h,004h,004h,002h,004h,004h,004h,004h,004h,006h,006h,002h,004h	; 84b0  ................
	defb 004h,004h,004h,006h,006h,006h,004h,004h,006h,006h,002h,002h,008h,006h,006h,006h	; 84c0  ................
	defb 004h,004h,004h,004h,001h,001h,001h,004h,002h,002h,002h,002h,008h,002h,004h	; 84d0  ...............

; ----------------------------------------------------------------------
; DATOS dibujos_de_cada_figura: 47 punteros, uno por figura 1-47 (p02:8408
;   suma el doble a 0x84DD): la lista que p02:8496 reparte por sus sprites, un
;   byte cada uno (94 bytes)
;   0x84df..0x853d  (94 bytes)
DATA_dibujos_de_cada_figura:
	defb 03dh,085h	; 84df
	defb 047h,085h	; 84e1
	defb 03dh,085h	; 84e3
	defb 03dh,085h	; 84e5
	defb 03dh,085h	; 84e7
	defb 047h,085h	; 84e9
	defb 04dh,085h	; 84eb
	defb 03dh,085h	; 84ed
	defb 03dh,085h	; 84ef
	defb 03dh,085h	; 84f1
	defb 04dh,085h	; 84f3
	defb 04dh,085h	; 84f5
	defb 03dh,085h	; 84f7
	defb 03dh,085h	; 84f9
	defb 03dh,085h	; 84fb
	defb 04dh,085h	; 84fd
	defb 03dh,085h	; 84ff
	defb 061h,085h	; 8501
	defb 04dh,085h	; 8503
	defb 04fh,085h	; 8505
	defb 04dh,085h	; 8507
	defb 04fh,085h	; 8509
	defb 04dh,085h	; 850b
	defb 04dh,085h	; 850d
	defb 041h,085h	; 850f
	defb 05bh,085h	; 8511
	defb 04dh,085h	; 8513
	defb 03dh,085h	; 8515
	defb 04bh,085h	; 8517
	defb 04dh,085h	; 8519
	defb 061h,085h	; 851b
	defb 061h,085h	; 851d
	defb 03dh,085h	; 851f
	defb 04dh,085h	; 8521
	defb 03dh,085h	; 8523
	defb 061h,085h	; 8525
	defb 068h,085h	; 8527
	defb 067h,085h	; 8529
	defb 068h,085h	; 852b
	defb 04dh,085h	; 852d
	defb 067h,085h	; 852f
	defb 067h,085h	; 8531
	defb 055h,085h	; 8533
	defb 03dh,085h	; 8535
	defb 069h,085h	; 8537
	defb 071h,085h	; 8539
	defb 061h,085h	; 853b

; ----------------------------------------------------------------------
; DATOS listas_853D: las listas de 0x84DF: tantos bytes como sprites tiene la
;   figura (0x84B0); unas figuras comparten la suya (54 bytes)
;   0x853d..0x8573  (54 bytes)
DATA_listas_853D:
	defb 001h,042h,001h,042h,001h,042h,001h,042h,002h,00eh,002h,045h,002h,045h,001h,002h	; 853d  .B.B.B.B...E.E..
	defb 002h,044h,002h,044h,002h,044h,002h,00eh,001h,042h,004h,046h,004h,004h,001h,042h	; 854d  .D.D.D...B.F...B
	defb 001h,042h,002h,04ch,001h,042h,002h,044h,001h,042h,003h,00eh,001h,042h,001h,042h	; 855d  .B.L.B.D.B...B.B
	defb 007h,001h,042h,007h,002h,008h	; 856d

; ======================================================================
; CODIGO 0x8573..0x871c  (425 bytes)
; ======================================================================


L_8573:
	ld a,(0cd15h)		;8573   ; una vez: 0xCD15 lo pide (p02:80DB) y aqui se borra
	or a			;8576   ; una vez
	ld a,000h		;8577
	ld (0cd15h),a		;8579
	ret nz			;857c
	call calcula_la_dificultad		;857d   ; la dificultad
	ld a,001h		;8580   ; 0xCD5B = 1 mientras se crean
	ld (0cd5bh),a		;8582
	call 05b6dh		;8585   ; figuras_de_la_casilla: DE = la lista de figuras de la casilla (conjunto de 0x9BF0, banco 14)
	ld a,(0cd12h)		;8588   ; tantas como (los bits 2-3 de 0xCD12) / 4, de la lista de la casilla en rueda
	and 00ch		;858b
	jr z,L_85AC		;858d   ; con dificultad menor de 4, ninguna
	rra			;858f
	rra			;8590
	ld c,a			;8591   ; C = cuantas
L_8592:
	ld a,(de)			;8592   ; la lista: cuantas tiene...
	ld b,a			;8593
	ld h,d			;8594   ; ... (HL vuelve a su principio para dar la vuelta)
	ld l,e			;8595
	inc de			;8596
	inc de			;8597
L_8598:
	ld a,(de)			;8598   ; el tipo
	push hl			;8599
	push de			;859a
	push bc			;859b
	call crea_por_tipo		;859c   ; se crea
	pop bc			;859f
	pop de			;85a0
	pop hl			;85a1
	inc de			;85a2
	dec c			;85a3   ; una menos
	jr z,L_85AC		;85a4
	djnz L_8598		;85a6   ; la siguiente de la lista
	ld d,h			;85a8   ; al final de la lista, otra vez desde el principio
	ld e,l			;85a9
	jr L_8592		;85aa
L_85AC:
	xor a			;85ac   ; ya no es la primera tanda
	ld (0cd5bh),a		;85ad
	ret			;85b0
L_85B1:
	push ix		;85b1   ; un sitio al azar (registro R) para la figura, en la fila de y 0x58
	pop hl			;85b3
	ld a,r		;85b4   ; un numero al azar: R, la direccion de la figura...
	add a,l			;85b6
	rra			;85b7
	rra			;85b8
	ld b,a			;85b9
	ld a,(0cd2dh)		;85ba   ; ... y lo de la vez anterior (0xCD2D)
	xor b			;85bd
	ld (0cd2dh),a		;85be
	and 07fh		;85c1
	add a,040h		;85c3   ; x entre 0x40 y 0xBF
	ld (0cd5ch),a		;85c5
	sub 008h		;85c8   ; D = la x - 8, E = 0x58
	ld d,a			;85ca
	ld e,058h		;85cb
L_85CD:
	call cerca_del_jugador		;85cd   ; cerca del jugador (a menos de 32), no
	jr c,L_85DD		;85d0
	push de			;85d2
	call filas_libres		;85d3   ; ni donde p02:97B2 de 0
	ld (0cd5dh),a		;85d6   ; las filas en las que se puede estar alli
	or a			;85d9
	pop de			;85da
	jr nz,L_85F7		;85db
L_85DD:
	ld a,010h		;85dd   ; 16 puntos a la derecha
	add a,d			;85df
	ld d,a			;85e0
	add a,008h		;85e1   ; la x del sitio siguiente
	ld (0cd5ch),a		;85e3
	jr L_85CD		;85e6
cerca_del_jugador:		; carry si el jugador esta a menos de 32; pasado 0xC0, se borra
	ld a,d			;85e8   ; a la derecha de 0xC0 no se busca: se borra
	cp 0c0h		;85e9
	jp nc,borra_la_figura		;85eb   ; borra_la_figura: borra la figura
	ld a,(0c496h)		;85ee   ; carry si el jugador esta a menos de 32
	sub d			;85f1
	add a,020h		;85f2
	cp 040h		;85f4
	ret			;85f6
L_85F7:
	ld a,(0cd48h)		;85f7   ; la fila, con las filas libres de ese sitio en vez de las del borde derecho
	push af			;85fa
	ld a,(0cd5dh)		;85fb
	ld (0cd48h),a		;85fe
	call sale_por_la_derecha		;8601   ; (p02:97E4)
	pop af			;8604
	ld (0cd48h),a		;8605   ; y vuelve lo del borde derecho
	ld a,(0cd5ch)		;8608   ; la x
	ld (ix+005h),a		;860b   ; guarda la x de la figura
	ld a,(0c496h)		;860e   ; ... y mira hacia el jugador: 1 si esta a su derecha, 2 si a su izquierda
	ld b,(ix+005h)		;8611   ; lee la x de la figura
	sub b			;8614
	ld a,001h		;8615
	jp nc,0a58ah		;8617   ; el rumbo (p03:A58A)
	ld a,002h		;861a
	jp 0a58ah		;861c   ; pon_rumbo: la direccion A y su velocidad
la_que_vuelve:		; la primera de la lista sale otra vez cada tanto
	ld a,(0c00dh)		;861f   ; cada 4 cuadros, 0xCD5E cuenta hacia atras
	and 003h		;8622
	ret nz			;8624
	ld hl,0cd5eh		;8625
	dec (hl)			;8628
	ret nz			;8629
	call 05b6dh		;862a   ; al acabar, la primera de la lista sale otra vez
	inc de			;862d   ; la primera de la lista
	ld a,(de)			;862e
	or a			;862f   ; 0: ninguna
	ret z			;8630
	push af			;8631
	call crea_por_tipo		;8632   ; se crea
	pop af			;8635
	cp 008h		;8636   ; la espera hasta la siguiente vez, segun el tipo
	jr z,L_864E		;8638
	cp 021h		;863a
	jr z,L_864E		;863c
	cp 005h		;863e
	jr z,L_8652		;8640
	ld a,(0cd12h)		;8642   ; la espera, 0x60 - 0xCD12 * 2...
	add a,a			;8645
	ld b,a			;8646
	ld a,060h		;8647
	sub b			;8649
L_864A:
	ld (0cd5eh),a		;864a   ; la espera hasta la siguiente
	ret			;864d
L_864E:
	ld a,080h		;864e   ; ... 128 para los tipos 8 y 0x21...
	jr L_864A		;8650
L_8652:
	ld a,0e0h		;8652   ; ... y 224 para el 5
	jr L_864A		;8654
L_8656:
	xor a			;8656   ; al entrar en la casilla, las cuentas de las figuras a su valor de partida
	ld (0cd17h),a		;8657   ; la lista desde el principio...
	ld (0cd31h),a		;865a   ; ... sin tandas...
	ld (0cd14h),a		;865d
	ld (0cdb0h),a		;8660   ; ... sin entrada al pasadizo secreto...
	ld a,010h		;8663   ; ... 16 para la tanda del tipo 7...
	ld (0cd30h),a		;8665
	ld a,008h		;8668   ; ... 8 para la siguiente...
	ld (0cd16h),a		;866a
	ld a,010h		;866d   ; ... y 16 para la de la lista
	ld (0cd5eh),a		;866f
	call filas_de_los_bordes		;8672   ; las filas libres de los bordes
	ld hl,0a090h		;8675   ; (0xA0, 0x90) de la pagina 1, 16 x 16 del color 0x99
	ld bc,01010h		;8678
	ld a,099h		;867b
	ld d,001h		;867d
	call 04732h		;867f   ; hmmv: orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)
	ld a,(0cd16h)		;8682   ; la primera figura no sale antes de 32 cuadros
	cp 020h		;8685
	ret nc			;8687
	ld a,020h		;8688
	ld (0cd16h),a		;868a
	ret			;868d
las_figuras:		; un cuadro de todas las figuras
	call calcula_la_dificultad		;868e   ; las figuras, un cuadro: la dificultad, las que salen y las ocho de 0xC600
	call figuras_que_salen		;8691   ; figuras_que_salen: las figuras que van saliendo
	ld ix,0c600h		;8694   ; las ocho figuras
	ld b,008h		;8698
L_869A:
	ld a,(ix+000h)		;869a   ; lee el tipo de la figura
	and a			;869d
	jr z,L_86B4		;869e   ; sin tipo, nada
	ld a,(ix+00dh)		;86a0   ; con (ix+0x0D) puesto, le han dado (p02:86E6)
	or a			;86a3
	jr nz,L_86E6		;86a4
	push bc			;86a6   ; su tipo, su movimiento, y se borra si se sale por los lados o por abajo
	call cuadro_del_tipo		;86a7   ; cuadro_del_tipo: lo que hace cada tipo, por la tabla de 0x871C
	call mueve_la_figura		;86aa   ; mueve_la_figura: x += velocidad horizontal e y += la vertical
	call fuera_por_los_lados		;86ad   ; fuera_por_los_lados: se borra si x < 8 o x >= 0xF8
	call fuera_por_abajo		;86b0   ; fuera_por_abajo: se borra si y >= 0xE4
	pop bc			;86b3
L_86B4:
	ld de,00080h		;86b4   ; la siguiente, 0x80 mas alla
	add ix,de		;86b7
	djnz L_869A		;86b9
	ret			;86bb
calcula_la_dificultad:		; 0xCD12 = fase + zona + cosas / 4
	ld hl,0c270h		;86bc   ; ocho cosas del marcador
	ld b,008h		;86bf
	ld c,000h		;86c1
L_86C3:
	ld a,(hl)			;86c3   ; cuantas se tienen
	or a			;86c4
	jr z,L_86C8		;86c5
	inc c			;86c7
L_86C8:
	inc hl			;86c8
	djnz L_86C3		;86c9
	ld a,c			;86cb   ; / 4
	srl a		;86cc
	srl a		;86ce
	ld c,a			;86d0
	ld a,(0c288h)		;86d1   ; ... + la fase + la zona, hasta 15
	add a,c			;86d4
	ld c,a			;86d5
	ld a,(0c280h)		;86d6   ; lee la ZONA (0-6)
	add a,c			;86d9
	cp 00fh		;86da   ; hasta 15
	jr c,L_86E0		;86dc
	ld a,00fh		;86de
L_86E0:
	and 00fh		;86e0
	ld (0cd12h),a		;86e2   ; la dificultad
	ret			;86e5
L_86E6:
	exx			;86e6   ; le han dado: (ix+0x0D) = 1 la primera vez (p03:A9D3), y p03:A9B3
	dec a			;86e7   ; (ix+0x0D) = 1: la primera vez
	call z,0a9d3h		;86e8
	call 0a9b3h		;86eb
	exx			;86ee
	jr L_86B4		;86ef
sprites_de_los_disparos:		; los sprites de las doce de 0xCA00
	ld ix,0ca00h		;86f1   ; los sprites de las doce de 0xCA00...
	ld b,00ch		;86f5
	ld de,00040h		;86f7
	jr L_8705		;86fa
sprites_de_las_figuras:		; los sprites de las ocho de 0xC600
	ld ix,0c600h		;86fc   ; con 0x80 de una a otra
	ld b,008h		;8700
	ld de,00080h		;8702
L_8705:
	push bc			;8705   ; cada figura con tipo...
	ld a,(ix+000h)		;8706   ; lee el tipo de la figura
	and a			;8709
	push de			;870a
	call nz,sprites_segun_la_pose		;870b   ; ... sus sprites segun su pose
	pop de			;870e
	add ix,de		;870f
	pop bc			;8711
	djnz L_8705		;8712
	ret			;8714
cuadro_del_tipo:		; lo que hace cada tipo, por la tabla de 0x871C
	ld a,(ix+000h)		;8715   ; lo que hace cada tipo (tabla de 0x871C)
	dec a			;8718
	call 0408dh		;8719   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_871C: 47 destinos del despachador de 0x408D (call en p02:8719):
;   0xA0FE, 0xA2CF, 0xA184, 0xA3E0, 0xA48D, 0xA4BC, 0xA4EB, 0xA4EB ...; lo
;   leen p02:8719 (94 bytes)
;   0x871c..0x877a  (94 bytes)
DATA_tabla_871C:
	defb 0feh,0a0h	; 871c
	defb 0cfh,0a2h	; 871e
	defb 084h,0a1h	; 8720
	defb 0e0h,0a3h	; 8722
	defb 08dh,0a4h	; 8724
	defb 0bch,0a4h	; 8726
	defb 0ebh,0a4h	; 8728
	defb 0ebh,0a4h	; 872a
	defb 078h,0a7h	; 872c
	defb 00ch,0abh	; 872e
	defb 000h,0ach	; 8730
	defb 000h,0ach	; 8732
	defb 078h,0a7h	; 8734
	defb 078h,0a7h	; 8736
	defb 078h,0a7h	; 8738
	defb 0ebh,0a4h	; 873a
	defb 078h,0a7h	; 873c
	defb 032h,09dh	; 873e
	defb 0ebh,0a4h	; 8740
	defb 0ebh,0a4h	; 8742
	defb 063h,0a7h	; 8744
	defb 078h,0a7h	; 8746
	defb 078h,0a7h	; 8748
	defb 078h,0a7h	; 874a
	defb 078h,0a7h	; 874c
	defb 078h,0a7h	; 874e
	defb 0ebh,0a4h	; 8750
	defb 0ebh,0a4h	; 8752
	defb 0ffh,09bh	; 8754
	defb 0ebh,0a4h	; 8756
	defb 078h,0a7h	; 8758
	defb 078h,0a7h	; 875a
	defb 0ebh,0a4h	; 875c
	defb 0feh,0ach	; 875e
	defb 0feh,0ach	; 8760
	defb 0bah,0b1h	; 8762
	defb 078h,0adh	; 8764
	defb 09fh,0b0h	; 8766
	defb 036h,0afh	; 8768
	defb 02ah,0b1h	; 876a
	defb 0d2h,0b2h	; 876c
	defb 0d2h,0b2h	; 876e
	defb 073h,0b5h	; 8770
	defb 06ch,0b3h	; 8772
	defb 078h,096h	; 8774
	defb 027h,097h	; 8776
	defb 092h,0b6h	; 8778

; ======================================================================
; CODIGO 0x877a..0x88dc  (354 bytes)
; ======================================================================


mueve_la_figura:		; x += velocidad horizontal e y += la vertical
	call mueve_en_vertical		;877a   ; la x (con su fraccion) += la velocidad horizontal
	ld e,(ix+008h)		;877d   ; lee la velocidad horizontal (parte baja)
	ld d,(ix+009h)		;8780   ; lee la velocidad horizontal
	ld l,(ix+004h)		;8783   ; lee la fraccion de la x de la figura
	ld h,(ix+005h)		;8786   ; lee la x de la figura
	add hl,de			;8789
	ld (ix+004h),l		;878a   ; guarda la fraccion de la x de la figura
	ld (ix+005h),h		;878d   ; guarda la x de la figura
	ret			;8790
mueve_en_vertical:		; y += la velocidad vertical
	ld e,(ix+006h)		;8791   ; la y += la vertical
	ld d,(ix+007h)		;8794   ; lee la velocidad vertical
	ld l,(ix+002h)		;8797   ; lee la fraccion de la y de la figura
	ld h,(ix+003h)		;879a   ; lee la y de la figura
	add hl,de			;879d
	ld (ix+002h),l		;879e   ; guarda la fraccion de la y de la figura
	ld (ix+003h),h		;87a1   ; guarda la y de la figura
	ret			;87a4
fuera_por_los_lados:		; se borra si x < 8 o x >= 0xF8
	ld a,(ix+005h)		;87a5   ; fuera por los lados (x < 8 o x >= 0xF8): se borra
	cp 0f8h		;87a8   ; por la derecha
	jr nc,borra_la_figura		;87aa
	cp 008h		;87ac   ; por la izquierda
	ret nc			;87ae
	jr borra_la_figura		;87af
fuera_por_abajo:		; se borra si y >= 0xE4
	ld a,(ix+003h)		;87b1   ; por abajo (y >= 0xE4)
	cp 0e4h		;87b4
	ret c			;87b6
borra_la_figura:		; borra la figura
	xor a			;87b7   ; el tipo y las marcas a cero...
	ld (ix+000h),a		;87b8   ; guarda el tipo de la figura
	ld (ix+00ch),a		;87bb
	ld (ix+00dh),a		;87be
	ld (ix+011h),a		;87c1
	ld (ix+01fh),a		;87c4
	push ix		;87c7   ; ... y sus huecos de sprite, libres (y = 0xE0 en 0xEE20)
	pop hl			;87c9
	set 5,l		;87ca   ; (ix+0x20): cuantos sprites
	ld c,(hl)			;87cc
	ld a,c			;87cd
	and a			;87ce
	ret z			;87cf
	inc l			;87d0
L_87D1:
	ld a,(hl)			;87d1   ; el hueco
	ld de,0ee20h		;87d2
	add a,a			;87d5   ; su y en la copia (0xEE20 + 4 * n)
	add a,a			;87d6
	add a,e			;87d7
	ld e,a			;87d8
	ld a,0e0h		;87d9   ; fuera
	ld (de),a			;87db
	ld a,l			;87dc   ; el sprite siguiente, 5 bytes mas alla
	add a,005h		;87dd
	ld l,a			;87df
	dec c			;87e0
	jr nz,L_87D1		;87e1
	ret			;87e3
pon_velocidad_x:		; velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld (ix+008h),e		;87e4   ; guarda la velocidad horizontal (parte baja)
	ld (ix+009h),d		;87e7   ; guarda la velocidad horizontal
	ret			;87ea
pon_velocidad_y:		; velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld (ix+006h),e		;87eb   ; guarda la velocidad vertical (parte baja)
	ld (ix+007h),d		;87ee   ; guarda la velocidad vertical
	ret			;87f1
sprites_segun_la_pose:		; la y, la x y el patron de cada sprite segun la pose
	di			;87f2   ; los sprites de la figura segun su pose: el banco 12
	ld a,00ch		;87f3
	ld (0a000h),a		;87f5   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;87f8   ; guarda la copia del banco de 0xA000
	ei			;87fb
	exx			;87fc
	ld a,(ix+00ah)		;87fd   ; la pose: su composicion en 0xB6D2...
	ld de,0b6d2h		;8800
	call 0447ch		;8803   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld a,(de)			;8806   ; ... cuyo primer byte elige los desplazamientos de 0xBAF3
	inc de			;8807
	push de			;8808
	ld de,0baf3h		;8809
	call 0447ch		;880c   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	exx			;880f
	pop de			;8810
	push ix		;8811
	pop hl			;8813
	set 5,l		;8814   ; los cinco bytes de cada sprite: [hueco][y][x][patron][color]
	ld b,(hl)			;8816
	ld a,b			;8817
	or a			;8818
	jp z,04206h		;8819   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	inc l			;881c
	inc l			;881d
L_881E:
	push hl			;881e   ; HL' = el sprite de la figura
	exx			;881f
	pop hl			;8820
	ld a,(de)			;8821   ; y = la de la figura + dy
	inc de			;8822
	add a,(ix+003h)		;8823   ; le suma la y de la figura
	ld (hl),a			;8826   ; (+1) la y
	inc l			;8827
	call x_del_sprite		;8828   ; x = la de la figura + dx (con signo)
	inc de			;882b
	ld (hl),a			;882c   ; (+2) la x
	inc l			;882d
	push hl			;882e
	exx			;882f
	pop hl			;8830
	ld a,(de)			;8831   ; el patron
	ld (hl),a			;8832   ; (+3) el patron
	inc l			;8833
	inc de			;8834
	inc l			;8835   ; el siguiente, 5 bytes mas alla
	inc l			;8836
	djnz L_881E		;8837
	jp 04206h		;8839   ; bancos_1_2_3: pone los bancos 1, 2 y 3
x_del_sprite:		; x + dx con signo; si se sale, el sprite no se ve
	ld a,(de)			;883c   ; dx positivo: si se pasa de 255...
	and 080h		;883d   ; el bit 7: negativo
	jr nz,L_8848		;883f
	ld a,(de)			;8841
	add a,(ix+005h)		;8842   ; le suma la x de la figura
	ret nc			;8845
	jr L_8851		;8846
L_8848:
	ld a,(de)			;8848   ; x - |dx|
	neg		;8849
	ld c,a			;884b
	ld a,(ix+005h)		;884c   ; lee la x de la figura
	sub c			;884f
	ret nc			;8850
L_8851:
	dec l			;8851   ; ... ese sprite no se ve (0xE1 en su y)
	ld a,0e1h		;8852   ; 0xE1
	ld (hl),a			;8854
	inc l			;8855
	ret			;8856
copia_los_disparos:		; sprites de las doce de 0xCA00 a la copia de 0xEE20
	ld hl,0ca00h		;8857   ; los sprites de las doce de 0xCA00...
	ld b,00ch		;885a
	ld de,00040h		;885c
	jr L_8869		;885f
copia_las_figuras:		; sprites de las ocho de 0xC600 a la copia de 0xEE20
	ld hl,0c600h		;8861   ; ... o de las ocho de 0xC600, a la copia de 0xEE20
	ld b,008h		;8864
	ld de,00080h		;8866
L_8869:
	push hl			;8869   ; cada una...
	push de			;886a
	push bc			;886b
	call se_ve		;886c   ; ... si se ve, sus sprites a la copia
	call nc,copia_sus_sprites		;886f   ; copia_sus_sprites: la y, la x y el patron de cada sprite a 0xEE20
	pop bc			;8872
	pop de			;8873
	pop hl			;8874
	add hl,de			;8875   ; la siguiente
	djnz L_8869		;8876
	ret			;8878
se_ve:		; NC si la figura existe, se ve y lleva sprites
	ld a,(hl)			;8879   ; NC si la figura existe, (+0x0E) es cero y lleva sprites
	or a			;887a   ; sin tipo: carry
	jr z,L_8891		;887b
	push hl			;887d
	ld a,00eh		;887e   ; (+0x0E) puesto: no se ve
	add a,l			;8880
	ld l,a			;8881
	ld a,(hl)			;8882
	pop hl			;8883
	or a			;8884
	jr nz,L_8891		;8885
	push hl			;8887
	set 5,l		;8888   ; (+0x20): sin sprites, nada
	ld a,(hl)			;888a
	pop hl			;888b
	or a			;888c
	jr z,L_8891		;888d
	or a			;888f   ; NC
	ret			;8890
L_8891:
	scf			;8891   ; carry: nada que subir
	ret			;8892
copia_sus_sprites:		; la y, la x y el patron de cada sprite a 0xEE20
	set 5,l		;8893   ; de cada sprite, la y, la x y el patron a su hueco de 0xEE20
	ld b,(hl)			;8895
	inc l			;8896
L_8897:
	ld a,(hl)			;8897   ; el hueco: su sitio en 0xEE20
	inc l			;8898   ; al byte siguiente del sprite
	add a,a			;8899
	add a,a			;889a
	ld de,0ee20h		;889b   ; la copia de los sprites de las figuras
	add a,e			;889e
	ld e,a			;889f
	ld a,(hl)			;88a0   ; la y
	ld (de),a			;88a1
	inc l			;88a2
	inc e			;88a3
	ld a,(hl)			;88a4   ; la x
	ld (de),a			;88a5
	inc l			;88a6
	inc e			;88a7
	ld a,(hl)			;88a8   ; el patron
	ld (de),a			;88a9
	inc l			;88aa
	inc e			;88ab
	inc l			;88ac   ; el sprite siguiente de la figura
	djnz L_8897		;88ad
	ret			;88af
L_88B0:
	ld ix,0ca00h		;88b0   ; las ocho de 0xCA00 (los disparos), un cuadro
	ld b,008h		;88b4
L_88B6:
	ld a,(ix+000h)		;88b6   ; lee el tipo de la figura
	and a			;88b9
	jr z,L_88CD		;88ba
	push bc			;88bc
	call cuadro_del_disparo		;88bd   ; lo que hace cada tipo (tabla de 0x88DC), se mueve, sus sprites, y fuera si se sale
	call mueve_la_figura		;88c0   ; mueve_la_figura: x += velocidad horizontal e y += la vertical
	call sprites_segun_la_pose		;88c3   ; sprites_segun_la_pose: la y, la x y el patron de cada sprite segun la pose
	call fuera_por_los_lados		;88c6   ; fuera_por_los_lados: se borra si x < 8 o x >= 0xF8
	call fuera_por_abajo		;88c9   ; fuera_por_abajo: se borra si y >= 0xE4
	pop bc			;88cc
L_88CD:
	ld de,00040h		;88cd   ; la siguiente, de 0x40 en 0x40
	add ix,de		;88d0
	djnz L_88B6		;88d2
	ret			;88d4
cuadro_del_disparo:		; lo que hace cada disparo, por la tabla de 0x88DC
	ld a,(ix+000h)		;88d5   ; lee el tipo de la figura
	dec a			;88d8
	call 0408dh		;88d9   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_88DC: 7 destinos del despachador de 0x408D (call en p02:88D9):
;   0x88EA, 0x8918, 0x8925, 0x892A, 0x8926, 0x8925, 0x8981; lo leen p02:88D9
;   (14 bytes)
;   0x88dc..0x88ea  (14 bytes)
DATA_tabla_88DC:
	defb 0eah,088h	; 88dc
	defb 018h,089h	; 88de
	defb 025h,089h	; 88e0
	defb 02ah,089h	; 88e2
	defb 026h,089h	; 88e4
	defb 025h,089h	; 88e6
	defb 081h,089h	; 88e8

; ======================================================================
; CODIGO 0x88ea..0x8a94  (426 bytes)
; ======================================================================


disparo_1:		; el disparo 1, un cuadro
	ld a,(ix+001h)		;88ea   ; el disparo 1: baja (velocidad 0x10) hasta la y del jugador...
	or a			;88ed
	jr nz,L_8909		;88ee
	ld de,00010h		;88f0
	call 0a13bh		;88f3   ; mas_vertical: la velocidad vertical += DE
	ld a,(0c494h)		;88f6   ; lee la y del jugador
	cp (ix+003h)		;88f9   ; compara con la y de la figura
	ret nc			;88fc
se_para:		; velocidad 0
	inc (ix+001h)		;88fd   ; ... y se para
	ld de,00000h		;8900   ; parado
	call pon_velocidad_x		;8903   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	jp pon_velocidad_y		;8906   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_8909:
	ld (ix+00ah),03dh		;8909   ; parado: la pose 0x3D, ya no hace dano, y se borra al acabar la cuenta de (ix+0x0B)
L_890D:
	ld (ix+00ch),000h		;890d   ; ya no hace dano...
	dec (ix+00bh)		;8911   ; ... y al acabar la cuenta, fuera
	ret nz			;8914
	jp borra_la_figura		;8915   ; borra_la_figura: borra la figura
disparo_2:		; el disparo 2, un cuadro
	ld b,058h		;8918   ; pose 0x58 + (0xC00D / 4) mod 4: cuatro poses en rueda
L_891A:
	ld a,(0c00dh)		;891a   ; cada 4 cuadros...
	rrca			;891d   ; / 4
	rrca			;891e
	and 003h		;891f   ; ... una de cuatro poses
	add a,b			;8921
	ld (ix+00ah),a		;8922   ; guarda la pose de la figura
L_8925:
	ret			;8925
disparo_5:		; el disparo 5, un cuadro
	ld b,093h		;8926   ; pose 0x93 o 0x94...
	jr L_892C		;8928
disparo_4:		; el disparo 4, un cuadro
	ld b,05ah		;892a   ; ... o 0x5A o 0x5B, cambiando cada 4 cuadros
L_892C:
	ld a,(0c00dh)		;892c   ; cada 4 cuadros, una de dos
	rrca			;892f
	rrca			;8930
	and 001h		;8931
	add a,b			;8933
	ld (ix+00ah),a		;8934   ; guarda la pose de la figura
	ret			;8937
L_8938:
	ld de,0c003h		;8938   ; apunta a el contador de cuadros
	jr L_8953		;893b
pon_la_pose:		; pone la pose de la figura
	ld a,(ix+07eh)		;893d   ; la pose de (ix+0x7E), dos mas si mira al otro lado (bit 0 de (ix+0x0F))
	bit 0,(ix+00fh)		;8940   ; mirando al otro lado...
	jr z,L_8948		;8944
	add a,002h		;8946   ; ... dos poses mas alla
L_8948:
	ld (ix+00ah),a		;8948   ; guarda la pose de la figura
	jr L_8975		;894b
L_894D:
	ld a,(ix+07eh)		;894d   ; la pose base, con la cuenta de 0xC00D
L_8950:
	ld de,0c00dh		;8950   ; la cuenta de 0xC00D
L_8953:
	bit 0,(ix+00fh)		;8953   ; la pose cambia cada 8 cuadros, cada figura a destiempo (segun su direccion)
	jr z,L_895B		;8957
	add a,002h		;8959
L_895B:
	ld b,a			;895b   ; B = la pose base
	push ix		;895c   ; los bits 8-9 de la direccion de la figura (0, 1, 2 o 3)...
	pop hl			;895e
	add hl,hl			;895f
	add hl,hl			;8960
	ld a,003h		;8961
	and h			;8963
	ld c,a			;8964
	ld a,(de)			;8965   ; ... se restan de la cuenta: cada figura cambia en otro cuadro
	sub c			;8966
	ld c,a			;8967
	and 007h		;8968   ; solo cada 8 cuadros
	ret nz			;896a
	ld a,c			;896b   ; el bit 3 de la cuenta: una pose u otra
	rrca			;896c
	rrca			;896d
	rrca			;896e
	and 001h		;896f
	add a,b			;8971
	ld (ix+00ah),a		;8972   ; guarda la pose de la figura
L_8975:
	push ix		;8975   ; y sus colores
	pop hl			;8977
	ld a,(ix+000h)		;8978   ; lee el tipo de la figura
	ld (0cd37h),a		;897b
	jp 054e6h		;897e   ; colores_de_la_figura: los 16 colores de cada sprite de la figura, con la lista de su pose (0x554E)
disparo_7:		; el disparo 7, un cuadro
	ld a,(ix+001h)		;8981   ; el disparo 7: baja (0x80) hasta la y de (ix+0x10)...
	or a			;8984
	jr nz,L_89B3		;8985   ; ya parado
	ld de,00080h		;8987
	call 0a13bh		;898a   ; cae
	ld a,(ix+010h)		;898d
	cp (ix+003h)		;8990   ; compara con la y de la figura
	ret nc			;8993
	ld a,003h		;8994   ; ... al llegar, el efecto 3, se para, y cambian dos sprites y sus colores
	call 04fe4h		;8996   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call se_para		;8999   ; parado
	ld (ix+025h),003h		;899c   ; dos sprites cambian de patron
	ld (ix+02ah),008h		;89a0
	ld a,053h		;89a4
	push ix		;89a6
	pop hl			;89a8
	ld (ix+00ah),a		;89a9   ; guarda la pose de la figura
	exx			;89ac
	ld de,0562ch		;89ad   ; y de colores (0x562C)
	jp 05502h		;89b0
L_89B3:
	ld a,(ix+00bh)		;89b3   ; luego, las poses 0x52 y 0x53 hasta acabar la cuenta
	rrca			;89b6   ; cada 4 cuadros de la cuenta, una de dos
	rrca			;89b7
	and 001h		;89b8
	add a,052h		;89ba
	ld (ix+00ah),a		;89bc   ; guarda la pose de la figura
	jp L_890D		;89bf
dispara:		; crea el disparo A (tabla de 0x8B6B)
	ld b,a			;89c2   ; A = el disparo; su y, la de la figura menos lo de 0x8B6B
	ld hl,08b6bh		;89c3
	add a,l			;89c6   ; HL = 0x8B6B + A
	ld l,a			;89c7
	jr nc,L_89CB		;89c8
	inc h			;89ca
L_89CB:
	ld a,(ix+003h)		;89cb   ; lee la y de la figura
	sub (hl)			;89ce
	ld c,a			;89cf
	ld a,b			;89d0
	ld b,(ix+005h)		;89d1   ; lee la x de la figura
	ld (0cd18h),a		;89d4   ; 0xCD18 el disparo, 0xCD1B/0xCD1C la y y la x
	ld (0cd1bh),bc		;89d7
	push ix		;89db
	call crea_el_disparo		;89dd   ; se crea y se le ponen los sprites enseguida
	call sprites_de_los_disparos		;89e0   ; sprites_de_los_disparos: los sprites de las doce de 0xCA00
	call copia_los_disparos		;89e3   ; copia_los_disparos: sprites de las doce de 0xCA00 a la copia de 0xEE20
	pop ix		;89e6
	ret			;89e8
crea_el_disparo:		; el disparo en el primer hueco de 0xCA00
	ld a,(0cd18h)		;89e9   ; el primer hueco libre de las ocho de 0xCA00
	ld hl,0ca00h		;89ec
	ld b,008h		;89ef
	xor a			;89f1
	ld de,00040h		;89f2
L_89F5:
	cp (hl)			;89f5   ; tipo 0: libre
	jr z,L_89FC		;89f6
	add hl,de			;89f8
	djnz L_89F5		;89f9
	ret			;89fb   ; ninguna libre: no hay disparo
L_89FC:
	push hl			;89fc
	pop ix		;89fd
	ld (0cd3ch),hl		;89ff   ; 0xCD3C = el disparo
	ld c,002h		;8a02   ; dos sprites
	ld (ix+020h),c		;8a04   ; guarda cuantos sprites lleva la figura
	ld de,00000h		;8a07
	ld hl,0ee20h		;8a0a   ; sus dos huecos de sprite, entre los doce de 0xEE20
	ld b,00ch		;8a0d
L_8A0F:
	ld a,(hl)			;8a0f   ; libre (0xE0)...
	cp 0e0h		;8a10
	jr nz,L_8A34		;8a12
	ld (hl),0e1h		;8a14   ; ... cogido
	call hueco_del_sprite		;8a16   ; hueco_del_sprite: el sprite E de la figura usa el hueco D
	inc e			;8a19
	inc d			;8a1a
	ld a,004h		;8a1b
	call 04083h		;8a1d   ; hl_mas_a: HL += A
	ld (hl),0e1h		;8a20   ; y el siguiente
	call hueco_del_sprite		;8a22   ; hueco_del_sprite: el sprite E de la figura usa el hueco D
	inc e			;8a25
	inc d			;8a26
	ld a,004h		;8a27
	call 04083h		;8a29   ; hl_mas_a: HL += A
	dec c			;8a2c   ; los dos: a crearlo
	jr z,L_8A41		;8a2d
	dec c			;8a2f
	jr z,L_8A41		;8a30
	jr L_8A3E		;8a32
L_8A34:
	inc d			;8a34   ; ocupado: dos mas alla
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
	djnz L_8A0F		;8a3e   ; los doce
	ret			;8a40
L_8A41:
	ld hl,(0cd3ch)		;8a41   ; [0] el tipo de disparo, [3] y, [5] x
	ld a,(0cd18h)		;8a44   ; [0] el tipo
	ld (hl),a			;8a47
	inc l			;8a48
	ld (hl),000h		;8a49
	ld de,(0cd1bh)		;8a4b   ; [3] y, [5] x, sin fracciones
	inc l			;8a4f
	ld (hl),000h		;8a50
	inc l			;8a52
	ld (hl),e			;8a53
	inc l			;8a54
	ld (hl),000h		;8a55
	inc l			;8a57
	ld (hl),d			;8a58
	ld (ix+00ch),001h		;8a59   ; (ix+0x0C) = 1: hace dano
	ld a,(ix+000h)		;8a5d   ; los patrones de sus sprites (0x8B52)
	ld de,08b52h		;8a60
	call 0447ch		;8a63   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,(0cd3ch)		;8a66   ; (+0x20) cuantos sprites
	set 5,l		;8a69
	ld b,(hl)			;8a6b
	ld a,005h		;8a6c   ; desde el patron del primero
	add a,l			;8a6e
	ld l,a			;8a6f
L_8A70:
	ld a,(de)			;8a70   ; el patron
	ld (hl),a			;8a71
	inc de			;8a72
	ld a,l			;8a73   ; el sprite siguiente
	add a,005h		;8a74
	ld l,a			;8a76
	djnz L_8A70		;8a77
	ld hl,(0cd3ch)		;8a79
	call copia_sus_sprites		;8a7c   ; sus sprites a la copia
	ld hl,(0cd3ch)		;8a7f
	ld a,(ix+000h)		;8a82   ; los colores: el tipo + 0x2F en la tabla de poses
	add a,02fh		;8a85
	ld (0cd37h),a		;8a87
	call 054e6h		;8a8a   ; colores_de_la_figura: los 16 colores de cada sprite de la figura, con la lista de su pose (0x554E)
	ld a,(ix+000h)		;8a8d   ; el arranque de cada disparo (tabla de 0x8A94)
	dec a			;8a90
	call 0408dh		;8a91   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8A94: 7 destinos del despachador de 0x408D (call en p02:8A91):
;   0x8AA2, 0x8AB9, 0x8ACF, 0x8AD8, 0x8AE1, 0x8B02, 0x8B22; lo leen p02:8A91
;   (14 bytes)
;   0x8a94..0x8aa2  (14 bytes)
DATA_tabla_8A94:
	defb 0a2h,08ah	; 8a94
	defb 0b9h,08ah	; 8a96
	defb 0cfh,08ah	; 8a98
	defb 0d8h,08ah	; 8a9a
	defb 0e1h,08ah	; 8a9c
	defb 002h,08bh	; 8a9e
	defb 022h,08bh	; 8aa0

; ======================================================================
; CODIGO 0x8aa2..0x8b54  (178 bytes)
; ======================================================================


disparo_1_sale:		; el disparo 1: cae
	ld (ix+00ah),03ch		;8aa2   ; el 1: cae (0x200 + la dificultad * 16), pose 0x3C, 32 cuadros
	ld (ix+00bh),020h		;8aa6
	ld de,00000h		;8aaa
	call pon_velocidad_x		;8aad   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00200h		;8ab0
	call mas_dificultad		;8ab3   ; mas_dificultad: DE += la dificultad * 16
	jp pon_velocidad_y		;8ab6   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
disparo_2_sale:		; el disparo 2: hacia el jugador
	ld a,006h		;8ab9   ; el 2: efecto 6, pose 0x58, y hacia el jugador a 0x40 + dificultad * 8
	call 04fe4h		;8abb   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,058h		;8abe
L_8AC0:
	ld (ix+00ah),a		;8ac0   ; guarda la pose de la figura
	ld a,040h		;8ac3
	call hacia_el_jugador		;8ac5   ; hacia_el_jugador: la velocidad hacia el jugador, de modulo A + dificultad * 8
	call pon_velocidad_x		;8ac8   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ex de,hl			;8acb
	jp pon_velocidad_y		;8acc   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
disparo_3_sale:		; el disparo 3: hacia el jugador
	ld a,006h		;8acf   ; el 3: igual con la pose 0x49
	call 04fe4h		;8ad1   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,049h		;8ad4
	jr L_8AC0		;8ad6
disparo_4_sale:		; el disparo 4: hacia el jugador
	ld a,005h		;8ad8   ; el 4: efecto 5, pose 0x5A
	call 04fe4h		;8ada   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,05ah		;8add
	jr L_8AC0		;8adf
disparo_5_sale:		; el disparo 5: en horizontal
	ld a,006h		;8ae1   ; el 5: efecto 6, pose 0x93, en horizontal (0x280 + dificultad * 16) hacia donde mira (0xCD38)
	call 04fe4h		;8ae3   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld b,093h		;8ae6
L_8AE8:
	ld (ix+00ah),b		;8ae8   ; guarda la pose de la figura
	ld de,00000h		;8aeb
	call pon_velocidad_y		;8aee   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld de,00280h		;8af1
	call mas_dificultad		;8af4   ; mas_dificultad: DE += la dificultad * 16
	ld hl,0cd38h		;8af7
	bit 0,(hl)		;8afa
	call z,niega_de		;8afc   ; niega_de: DE = -DE
	jp pon_velocidad_x		;8aff   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
disparo_6_sale:		; el disparo 6: en horizontal, por delante
	ld a,007h		;8b02   ; el 6: efecto 7, pose 0x3C (0x3D a la derecha), sale 16 puntos por delante
	call 04fe4h		;8b04   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld b,03ch		;8b07
	ld a,(ix+005h)		;8b09   ; lee la x de la figura
	ld hl,0cd38h		;8b0c
	bit 0,(hl)		;8b0f
	jr z,L_8B1E		;8b11
	inc b			;8b13
	add a,010h		;8b14
L_8B16:
	jp c,borra_la_figura		;8b16   ; borra_la_figura: borra la figura
	ld (ix+005h),a		;8b19   ; guarda la x de la figura
	jr L_8AE8		;8b1c
L_8B1E:
	sub 010h		;8b1e   ; a la izquierda, 16 por detras
	jr L_8B16		;8b20
disparo_7_sale:		; el disparo 7: sube y cae
	ld de,0fa00h		;8b22   ; el 7: sube deprisa (0xFA00) y de lado (0x200 +...), pose 0x1B; recuerda su y en (ix+0x10)
	call pon_velocidad_y		;8b25   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld de,00200h		;8b28
	call mas_dificultad		;8b2b   ; mas_dificultad: DE += la dificultad * 16
	ld hl,0cd38h		;8b2e
	bit 0,(hl)		;8b31
	call z,niega_de		;8b33   ; niega_de: DE = -DE
	call pon_velocidad_x		;8b36   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld a,(ix+003h)		;8b39   ; lee la y de la figura
	ld (ix+010h),a		;8b3c
	ld (ix+00bh),007h		;8b3f
	ld (ix+00ah),01bh		;8b43   ; la pose de la figura = 0x1B
	ret			;8b47
mas_dificultad:		; DE += la dificultad * 16
	ld a,(0cd12h)		;8b48   ; DE += la dificultad * 16
	add a,a			;8b4b   ; * 16
	add a,a			;8b4c
	add a,a			;8b4d
	add a,a			;8b4e
	add a,e			;8b4f
	ld e,a			;8b50
	ret nc			;8b51
	inc d			;8b52
	ret			;8b53

; ----------------------------------------------------------------------
; DATOS dibujos_de_cada_cosa: 7 punteros, uno por cosa 1-7 (p02:8A60 suma el
;   doble a 0x8B52), a la lista que p02:8A70 reparte por sus sprites (14
;   bytes)
;   0x8b54..0x8b62  (14 bytes)
DATA_dibujos_de_cada_cosa:
	defb 062h,08bh	; 8b54
	defb 064h,08bh	; 8b56
	defb 066h,08bh	; 8b58
	defb 06ah,08bh	; 8b5a
	defb 068h,08bh	; 8b5c
	defb 062h,08bh	; 8b5e
	defb 064h,08bh	; 8b60

; ----------------------------------------------------------------------
; DATOS listas_8B62: las listas de 0x8B54 (cosas 1-7, a 0x8B62, 0x8B64,
;   0x8B66, 0x8B68 y 0x8B6A): un byte por sprite, tantos como diga (ix+0x20)
;   de la cosa (10 bytes)
;   0x8b62..0x8b6c  (10 bytes)
DATA_listas_8B62:
	defb 002h,045h,001h,042h,002h,00eh,002h,006h,002h,04ch	; 8b62  .E.B.....L

; ----------------------------------------------------------------------
; DATOS y_de_cada_disparo: la y que p02:89CB resta a (ix+3) para el disparo A
;   (p02:89C3 suma A a 0x8B6B): se piden el 2, el 4 y el 5 (p03:A291,
;   p03:ABA1, p03:ACB2) y los de (ix+0x7D), que da la ficha de 0xAA51: 2, 10 y
;   16; el 16 cae en 0x8B7B, el byte 0x05 de `ld d,(ix+5)` de p02:8B79, que se
;   lee como dato (10 bytes)
;   0x8b6c..0x8b76  (10 bytes)
DATA_y_de_cada_disparo:
	defb 000h,008h,000h,000h,008h,008h,00ch,000h,03eh,080h	; 8b6c  ........>.

; ======================================================================
; CODIGO 0x8b76..0x8c30  (186 bytes)
; ======================================================================


hacia_el_jugador:		; la velocidad hacia el jugador, de modulo A + dificultad * 8
	ld e,(ix+003h)		;8b76   ; la velocidad hacia el jugador: el modulo es A + la dificultad * 8
	ld d,(ix+005h)		;8b79   ; la x
	ld c,a			;8b7c   ; C = la velocidad
	ld a,(0cd12h)		;8b7d
	add a,a			;8b80   ; la dificultad * 8
	add a,a			;8b81
	add a,a			;8b82
	add a,c			;8b83
	ld (0cd1dh),a		;8b84   ; 0xCD1D = el modulo
	call angulo_al_jugador		;8b87   ; el angulo, de la tabla de 0x8C30
	ld a,(0cd1eh)		;8b8a   ; el angulo...
	ld e,a			;8b8d
	ld d,000h		;8b8e   ; D = 0
	sub 03fh		;8b90   ; ... y su complementario (0x3F - angulo)
	neg		;8b92
	ld hl,08c70h		;8b94   ; el seno y el coseno, de 0x8C70
	push hl			;8b97
	add hl,de			;8b98
	ld c,(hl)			;8b99   ; C = el seno
	pop hl			;8b9a
	ld e,a			;8b9b   ; E = el angulo complementario
	add hl,de			;8b9c
	ld a,(hl)			;8b9d   ; el coseno, a 0xCD1F
	ld (0cd1fh),a		;8b9e
	ld e,c			;8ba1
	call componente		;8ba2   ; la componente vertical...
	ld a,(0cd20h)		;8ba5   ; con el signo de dy
	and a			;8ba8
	call nz,niega_de		;8ba9   ; niega_de: DE = -DE
	ld (0cd22h),de		;8bac   ; 0xCD22 = la vertical
	ld a,(0cd1fh)		;8bb0
	ld e,a			;8bb3   ; E = el coseno
	call componente		;8bb4   ; ... y la horizontal; HL = la vertical, DE = la horizontal
	ld a,(0cd21h)		;8bb7   ; con el signo de dx
	and a			;8bba
	call nz,niega_de		;8bbb   ; niega_de: DE = -DE
	ld hl,(0cd22h)		;8bbe   ; HL = la vertical
	ret			;8bc1
angulo_al_jugador:		; el angulo hacia el jugador, de la tabla de 0x8C30
	ld hl,0cd20h		;8bc2   ; |dy| / 32 y |dx| / 32, con su signo en 0xCD20 y 0xCD21
	ld (hl),000h		;8bc5   ; 0xCD20 = 0: hacia abajo
	ld a,(0c494h)		;8bc7   ; lee la y del jugador
	sub e			;8bca   ; dy
	jr nc,L_8BD0		;8bcb
	neg		;8bcd
	inc (hl)			;8bcf   ; hacia arriba: 0xCD20 = 1
L_8BD0:
	inc hl			;8bd0
	ld (hl),000h		;8bd1   ; 0xCD21 = 0
	rra			;8bd3   ; |dy| / 32, por 8: la fila
	rra			;8bd4
	and 038h		;8bd5
	ld e,a			;8bd7
	ld a,(0c496h)		;8bd8   ; dx
	sub d			;8bdb
	jr nc,L_8BE1		;8bdc
	neg		;8bde
	inc (hl)			;8be0   ; hacia la izquierda: 0xCD21 = 1
L_8BE1:
	rra			;8be1   ; |dx| / 32: la columna
	rra			;8be2
	rra			;8be3
	rra			;8be4
	rra			;8be5
	and 007h		;8be6
	add a,e			;8be8
	ld hl,08c30h		;8be9   ; 8 x 8 casos: el angulo (0-0x3F) en 0xCD1E
	call 04083h		;8bec   ; hl_mas_a: HL += A
	ld a,(hl)			;8bef
	ld (0cd1eh),a		;8bf0   ; el angulo
	ld c,a			;8bf3
	ld hl,(0cd20h)		;8bf4   ; H = signo de x, L = signo de y
	ld a,h			;8bf7
	ld b,000h		;8bf8
	and a			;8bfa
	jr z,L_8BFF		;8bfb
	ld b,080h		;8bfd   ; hacia la izquierda, + 0x80
L_8BFF:
	cp l			;8bff   ; y el rumbo completo, con el cuadrante, en 0xCD24
	ld a,c			;8c00
	jr z,L_8C05		;8c01   ; con los signos distintos, el angulo al reves
	neg		;8c03
L_8C05:
	add a,b			;8c05
	ld (0cd24h),a		;8c06   ; el rumbo
	ret			;8c09
niega_de:		; DE = -DE
	ld a,d			;8c0a   ; el complemento a uno...
	cpl			;8c0b
	ld d,a			;8c0c
	ld a,e			;8c0d
	cpl			;8c0e
	ld e,a			;8c0f
	inc de			;8c10   ; ... y + 1
	ret			;8c11
componente:		; DE = (0xCD1D * E) / 32
	ld a,(0cd1dh)		;8c12   ; DE = (0xCD1D * E) / 32: la componente
	ld h,a			;8c15   ; H = el modulo
	call multiplica		;8c16   ; HL = modulo * E
	xor a			;8c19   ; / 32: A:H
	add hl,hl			;8c1a   ; * 8 (con lo que sale de H en A)
	adc a,a			;8c1b
	add hl,hl			;8c1c
	adc a,a			;8c1d
	add hl,hl			;8c1e
	adc a,a			;8c1f
	ld l,h			;8c20   ; DE = el resultado
	ld h,a			;8c21
	ex de,hl			;8c22
	ret			;8c23
multiplica:		; HL = H * E
	ld b,008h		;8c24   ; 8 bits
	ld l,000h		;8c26   ; L = 0, D = 0
	ld d,l			;8c28
L_8C29:
	add hl,hl			;8c29   ; HL * 2...
	jr nc,L_8C2D		;8c2a
	add hl,de			;8c2c   ; ... y + DE si el bit que sale es 1
L_8C2D:
	djnz L_8C29		;8c2d
	ret			;8c2f

; ----------------------------------------------------------------------
; DATOS arcotangente: 8 x 8 bytes: el angulo (0x20 son 45 grados) segun la
;   distancia en y y en x al jugador, que p02:8BE9 lee para apuntarle (64
;   bytes)
;   0x8c30..0x8c70  (64 bytes)
DATA_arcotangente:
	defb 020h,008h,004h,003h,002h,002h,001h,001h,038h,020h,015h,00fh,00ch,009h,008h,007h	; 8c30   .......8 ......
	defb 03bh,02bh,020h,019h,014h,010h,00eh,00ch,03dh,031h,027h,020h,01ah,016h,013h,011h	; 8c40  ;+ .....=1' ....
	defb 03dh,034h,02ch,025h,020h,01ch,018h,015h,03eh,036h,02fh,029h,024h,020h,01ch,019h	; 8c50  =4,% ...>6/)$ ..
	defb 03eh,038h,032h,02ch,028h,023h,020h,01dh,03eh,039h,034h,02fh,02ah,026h,023h,020h	; 8c60  >82,(# .>94/*&#

; ----------------------------------------------------------------------
; DATOS seno: el cuarto de onda del seno en 64 pasos (0 a 0xFF) que p02:8B94
;   lee para sacar el paso en x y en y de lo que se dispara (64 bytes)
;   0x8c70..0x8cb0  (64 bytes)
DATA_seno:
	defb 000h,006h,00ch,012h,019h,01fh,026h,02ch,032h,038h,03eh,044h,04ah,050h,056h,05ch	; 8c70  ......&,28>DJPV\
	defb 062h,068h,06dh,073h,079h,07eh,084h,089h,08eh,093h,099h,09eh,0a2h,0a7h,0ach,0b1h	; 8c80  bhmsy~..........
	defb 0b5h,0b9h,0beh,0c2h,0c6h,0cah,0ceh,0d1h,0d5h,0d8h,0dch,0dfh,0e2h,0e5h,0e7h,0eah	; 8c90  ................
	defb 0edh,0efh,0f1h,0f3h,0f5h,0f7h,0f8h,0fah,0fbh,0fch,0fdh,0feh,0feh,0ffh,0ffh,0ffh	; 8ca0  ................

; ======================================================================
; CODIGO 0x8cb0..0x8ce1  (49 bytes)
; ======================================================================


L_8CB0:
	ld ix,0cc00h		;8cb0   ; las cuatro cosas del suelo de 0xCC00, un cuadro
	ld b,004h		;8cb4
L_8CB6:
	ld a,(ix+000h)		;8cb6   ; lee el tipo de la figura
	and a			;8cb9   ; sin tipo, nada
	jr z,L_8CCA		;8cba
	push bc			;8cbc
	call cuadro_de_lo_del_suelo		;8cbd   ; lo que hace su tipo, se mueve, sus sprites, y fuera si se sale
	call mueve_la_figura		;8cc0   ; mueve_la_figura: x += velocidad horizontal e y += la vertical
	call sprites_segun_la_pose		;8cc3   ; sprites_segun_la_pose: la y, la x y el patron de cada sprite segun la pose
	call fuera_por_los_lados		;8cc6   ; fuera_por_los_lados: se borra si x < 8 o x >= 0xF8
	pop bc			;8cc9
L_8CCA:
	ld de,00040h		;8cca   ; la siguiente, de 0x40 en 0x40
	add ix,de		;8ccd
	djnz L_8CB6		;8ccf
	ret			;8cd1
cuadro_de_lo_del_suelo:		; lo que hace cada cosa del suelo, por la tabla de 0x8CE1
	ld a,(ix+001h)		;8cd2   ; en el paso 2, su efecto de sonido
	cp 002h		;8cd5
	call z,07d7eh		;8cd7   ; efecto_del_tipo: el efecto de sonido del tipo (0x7D98)
	ld a,(ix+000h)		;8cda   ; lo que hace cada tipo (tabla de 0x8CE1)
	dec a			;8cdd
	call 0408dh		;8cde   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8CE1: 15 destinos del despachador de 0x408D (call en p02:8CDE):
;   0x8DB3, 0x8DB3, 0x8DB3, 0x8D32, 0x8D7C, 0x8E4B, 0x8E6F, 0x8EC0 ...; lo
;   leen p02:8CDE (30 bytes)
;   0x8ce1..0x8cff  (30 bytes)
DATA_tabla_8CE1:
	defb 0b3h,08dh	; 8ce1
	defb 0b3h,08dh	; 8ce3
	defb 0b3h,08dh	; 8ce5
	defb 032h,08dh	; 8ce7
	defb 07ch,08dh	; 8ce9
	defb 04bh,08eh	; 8ceb
	defb 06fh,08eh	; 8ced
	defb 0c0h,08eh	; 8cef
	defb 012h,08fh	; 8cf1
	defb 0f4h,08eh	; 8cf3
	defb 025h,08fh	; 8cf5
	defb 043h,08fh	; 8cf7
	defb 09ah,08fh	; 8cf9
	defb 0a6h,08fh	; 8cfb
	defb 0d5h,08eh	; 8cfd

; ======================================================================
; CODIGO 0x8cff..0x8d2c  (45 bytes)
; ======================================================================


L_8CFF:
	ld a,(ix+00dh)		;8cff   ; esperando a que le den (ix+0x0D): el paso siguiente
	or a			;8d02
	ret z			;8d03
	inc (ix+001h)		;8d04   ; sube el paso en que va la figura
	ld (ix+01fh),001h		;8d07
	jr L_8D1B		;8d0b
L_8D0D:
	ld a,(0c490h)		;8d0d   ; esperando a que el jugador este en el suelo
	or a			;8d10
	ret nz			;8d11
	inc (ix+001h)		;8d12   ; sube el paso en que va la figura
	ld a,(ix+000h)		;8d15   ; lee el tipo de la figura
	cp 006h		;8d18
	ret z			;8d1a
L_8D1B:
	ld a,(ix+000h)		;8d1b   ; la pose de cada tipo (0x8D2C)
	or a			;8d1e
	ret z			;8d1f
	dec a			;8d20
	ld de,08d2ch		;8d21
	call 04088h		;8d24   ; de_mas_a: DE += A
	ld a,(de)			;8d27
	ld (ix+00ah),a		;8d28   ; guarda la pose de la figura
	ret			;8d2b

; ----------------------------------------------------------------------
; DATOS pose_de_cada_cosa: la pose (ix+0x0A) de cada cosa 1-6 (p02:8D21) (6
;   bytes)
;   0x8d2c..0x8d32  (6 bytes)
DATA_pose_de_cada_cosa:
	defb 047h,048h,049h,012h,012h,012h	; 8d2c

; ======================================================================
; CODIGO 0x8d32..0x8d38  (6 bytes)
; ======================================================================


bloque_de_dinero:		; la cosa del suelo 4: el bloque que da dinero
	ld a,(ix+001h)		;8d32   ; un bloque que da dinero, segun su paso (0x8D38)
	call 0408dh		;8d35   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8D38: 4 destinos del despachador de 0x408D (call en p02:8D35):
;   0x8CFF, 0x8D0D, 0x8D40, 0x8D7C; lo leen p02:8D35 (8 bytes)
;   0x8d38..0x8d40  (8 bytes)
DATA_tabla_8D38:
	defb 0ffh,08ch	; 8d38
	defb 00dh,08dh	; 8d3a
	defb 040h,08dh	; 8d3c
	defb 07ch,08dh	; 8d3e

; ======================================================================
; CODIGO 0x8d40..0x8db9  (121 bytes)
; ======================================================================


L_8D40:
	call pieza_rota		;8d40   ; se rompe: la pieza de (0x00, 0x80) en su sitio...
	call cuanto_da_el_bloque		;8d43   ; ... lo que da...
	ld (ix+00bh),0f0h		;8d46
	call 07d7eh		;8d4a   ; efecto_del_tipo: el efecto de sonido del tipo (0x7D98)
	ld e,(ix+012h)		;8d4d   ; ... el dinero, ya no hace dano...
	call 05929h		;8d50   ; suma_dinero: suma E ryo (BCD) al dinero, hasta 9999
	ld (ix+00ch),000h		;8d53
	inc (ix+001h)		;8d57   ; sube el paso en que va la figura
	ld (ix+011h),001h		;8d5a
	ld a,(ix+003h)		;8d5e   ; ... y la moneda salta: 8 mas arriba, recordando su y
	ld (ix+010h),a		;8d61
	sub 008h		;8d64
	ld (ix+003h),a		;8d66   ; guarda la y de la figura
	ld a,(ix+005h)		;8d69   ; lee la x de la figura
	ld (ix+013h),a		;8d6c
	ld (ix+00eh),000h		;8d6f
	ld de,00000h		;8d73
	call pon_velocidad_x		;8d76   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	jp salta_arriba		;8d79   ; salta_arriba: la velocidad vertical = 0xFC00
L_8D7C:
	call gravedad_de_la_moneda		;8d7c   ; cae (0x40) hasta su y de partida y se borra
	ld a,(ix+010h)		;8d7f   ; su y de partida
	cp (ix+003h)		;8d82   ; compara con la y de la figura
	ret nc			;8d85
	jp borra_la_figura		;8d86   ; alli: se va
gravedad_de_la_moneda:		; la velocidad vertical += 0x40
	ld de,00040h		;8d89   ; la gravedad de la moneda: 0x40
	jp 0a13bh		;8d8c   ; la gravedad
salta_arriba:		; la velocidad vertical = 0xFC00
	ld de,0fc00h		;8d8f   ; hacia arriba: 0xFC00
	jp pon_velocidad_y		;8d92   ; la velocidad
cuanto_da_el_bloque:		; 5 ryo, o 50 si el tiempo acaba en dos cifras iguales e impares
	ld hl,0c4b0h		;8d95   ; 5 ryo...
	ld b,005h		;8d98   ; B = 5 ryo (BCD)
	ld a,(hl)			;8d9a   ; ... o 50 si las dos ultimas cifras del tiempo son iguales e impares (11, 33, 55, 77, 99)
	bit 0,a		;8d9b   ; las unidades impares...
	jr z,L_8DAF		;8d9d
	ld c,a			;8d9f   ; ... y las decenas...
	and 00fh		;8da0
	srl c		;8da2
	srl c		;8da4
	srl c		;8da6
	srl c		;8da8
	cp c			;8daa   ; ... iguales a las unidades
	jr nz,L_8DAF		;8dab
	ld b,050h		;8dad   ; B = 50 ryo
L_8DAF:
	ld (ix+012h),b		;8daf   ; (ix+0x12) = lo que da
	ret			;8db2
bloque_que_suelta:		; las cosas del suelo 1-3: el bloque que al romperse suelta algo que rebota
	ld a,(ix+001h)		;8db3   ; otro bloque, segun su paso (0x8DB9)
	call 0408dh		;8db6   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8DB9: 5 destinos del despachador de 0x408D (call en p02:8DB6):
;   0x8CFF, 0x8D0D, 0x8DC3, 0x8E04, 0x8E27; lo leen p02:8DB6 (10 bytes)
;   0x8db9..0x8dc3  (10 bytes)
DATA_tabla_8DB9:
	defb 0ffh,08ch	; 8db9
	defb 00dh,08dh	; 8dbb
	defb 0c3h,08dh	; 8dbd
	defb 004h,08eh	; 8dbf
	defb 027h,08eh	; 8dc1

; ======================================================================
; CODIGO 0x8dc3..0x8e59  (150 bytes)
; ======================================================================


L_8DC3:
	call pieza_rota		;8dc3   ; se rompe: sale algo que va hacia el lado contrario al jugador...
	ld (ix+00ch),000h		;8dc6   ; ya no se le puede dar
	ld de,00080h		;8dca   ; 0x80 hacia...
	ld a,(0c49ah)		;8dcd   ; lee la x de los sprites del jugador
	cp (ix+005h)		;8dd0   ; ... el lado contrario al jugador
	jr nc,L_8DFA		;8dd3
	ld a,(ix+005h)		;8dd5   ; 8 a la derecha
	add a,008h		;8dd8
L_8DDA:
	ld (ix+005h),a		;8dda   ; guarda la x de la figura
	call pon_velocidad_x		;8ddd   ; la velocidad horizontal
	call salta_arriba		;8de0   ; hacia arriba
	ld a,(ix+003h)		;8de3   ; ... 12 mas arriba, 88 cuadros
	sub 00ch		;8de6
	ld (ix+003h),a		;8de8   ; guarda la y de la figura
	ld (ix+010h),a		;8deb
	ld (ix+00eh),000h		;8dee
	ld (ix+014h),058h		;8df2   ; 88 cuadros
	inc (ix+001h)		;8df6   ; sube el paso en que va la figura
	ret			;8df9
L_8DFA:
	call niega_de		;8dfa   ; a la izquierda
	ld a,(ix+005h)		;8dfd   ; lee la x de la figura
	sub 008h		;8e00
	jr L_8DDA		;8e02
L_8E04:
	ld de,00040h		;8e04   ; cae hasta su y; luego hace dano y rebota
	call 0a13bh		;8e07   ; mas_vertical: la velocidad vertical += DE
	ld a,(ix+010h)		;8e0a
	cp (ix+003h)		;8e0d   ; al llegar a su y...
	ret nc			;8e10
	inc (ix+001h)		;8e11   ; sube el paso en que va la figura
	ld (ix+00ch),001h		;8e14   ; ... hace dano
	ld de,00066h		;8e18   ; la gravedad del rebote: 0x66
	ld (ix+012h),d		;8e1b
	ld (ix+013h),e		;8e1e
L_8E21:
	ld de,0fd00h		;8e21   ; hacia arriba (0xFD00)
	jp pon_velocidad_y		;8e24   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_8E27:
	dec (ix+014h)		;8e27   ; rebota cada vez mas bajo (+3 a la gravedad) hasta acabar la cuenta
	jp z,borra_la_figura		;8e2a   ; borra_la_figura: borra la figura
	ld d,(ix+012h)		;8e2d   ; la gravedad del rebote...
	ld a,(ix+013h)		;8e30   ; ... 3 mas cada vez
	add a,003h		;8e33
	ld e,a			;8e35
	jr nc,L_8E39		;8e36
	inc d			;8e38
L_8E39:
	ld (ix+012h),d		;8e39
	ld (ix+013h),e		;8e3c
	call 0a13bh		;8e3f   ; se suma a la velocidad
	ld a,(ix+010h)		;8e42   ; al volver a su y, otro rebote
	cp (ix+003h)		;8e45   ; compara con la y de la figura
	ret nc			;8e48
	jr L_8E21		;8e49
boca_de_pasadizo:		; la cosa del suelo 6: la boca de un pasadizo
	ld (ix+00eh),001h		;8e4b   ; (ix+0x0E) = 1; con la cosa 8 (0xC278), empieza en el paso 4
	ld a,(ix+001h)		;8e4f   ; lee el paso en que va la figura
	or a			;8e52
	call z,con_la_cosa_8		;8e53   ; con_la_cosa_8: con la cosa 8, el paso 4
	call 0408dh		;8e56   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8E59: 6 destinos del despachador de 0x408D (call en p02:8E56):
;   0x8CFF, 0x8D0D, 0x8E70, 0x8E6F, 0x8E70, 0x8E6F; lo leen p02:8E56 (12
;   bytes)
;   0x8e59..0x8e65  (12 bytes)
DATA_tabla_8E59:
	defb 0ffh,08ch	; 8e59
	defb 00dh,08dh	; 8e5b
	defb 070h,08eh	; 8e5d
	defb 06fh,08eh	; 8e5f
	defb 070h,08eh	; 8e61
	defb 06fh,08eh	; 8e63

; ======================================================================
; CODIGO 0x8e65..0x8fac  (327 bytes)
; ======================================================================


con_la_cosa_8:		; con la cosa 8, el paso 4
	ld a,(0c278h)		;8e65   ; con la cosa 8 puesta...
	or a			;8e68
	ret z			;8e69
	ld a,004h		;8e6a   ; ... paso 4
	ld (ix+001h),a		;8e6c   ; guarda el paso en que va la figura
L_8E6F:
	ret			;8e6f
L_8E70:
	xor a			;8e70   ; pieza vacia (marca 0)
	ld (0cd2ah),a		;8e71   ; guarda la marca que se pone en 0xD800
	jr L_8EA3		;8e74
pared_abierta:		; dos piezas de pared
	ld bc,0a090h		;8e76   ; dos piezas de pared (marca 0xFF): (0xA0, 0x90) y (0xB0, 0x90)
	ld a,0ffh		;8e79
	ld (0cd2ah),a		;8e7b   ; guarda la marca que se pone en 0xD800
	call pieza_en_la_figura		;8e7e   ; pieza_en_la_figura: la pieza de BC donde esta la figura
	ld bc,0b090h		;8e81
	jr pieza_en_la_figura		;8e84
pieza_a0:		; la pieza de (0xA0, 0x90) sin marca
	ld bc,0a090h		;8e86   ; (0xA0, 0x90) sin marca
	xor a			;8e89
	ld (0cd2ah),a		;8e8a   ; guarda la marca que se pone en 0xD800
	jr pieza_en_la_figura		;8e8d
pieza_vacia:		; la pieza de (0x70, 0x90) sin marca
	ld bc,07090h		;8e8f   ; (0x70, 0x90) sin marca
	ld a,000h		;8e92
	ld (0cd2ah),a		;8e94   ; guarda la marca que se pone en 0xD800
	jr pieza_en_la_figura		;8e97
pieza_rota:		; la pieza de (0x00, 0x80) con marca de pared
	ld bc,00080h		;8e99   ; la pieza de (0x00, 0x80) con marca 0xFF
	ld a,0ffh		;8e9c
	ld (0cd2ah),a		;8e9e   ; guarda la marca que se pone en 0xD800
	jr pieza_en_la_figura		;8ea1
L_8EA3:
	ld (ix+00dh),000h		;8ea3   ; le pueden dar otra vez: (ix+0x0C) = 1, y la pieza (0x40, 0x80)
	ld (ix+00ch),001h		;8ea7
	ld bc,04080h		;8eab
	inc (ix+001h)		;8eae   ; sube el paso en que va la figura
pieza_en_la_figura:		; la pieza de BC donde esta la figura
	ld a,(ix+003h)		;8eb1   ; la pieza, en la y - 15 y la x - 8 de la figura
	sub 00fh		;8eb4   ; E = y - 15
	ld e,a			;8eb6
	ld a,(ix+005h)		;8eb7   ; lee la x de la figura
	sub 008h		;8eba   ; D = x - 8
	ld d,a			;8ebc
	jp 04e8eh		;8ebd   ; y la pieza (p00:4E8E)
bloque_200_ryo:		; la cosa del suelo 8: 200 ryo
	ld a,(ix+00dh)		;8ec0   ; al darle: 200 ryo, la pieza vacia, y se va
	or a			;8ec3   ; sin darle, nada
	ret z			;8ec4
	xor a			;8ec5
	ld de,00200h		;8ec6   ; 200 ryo (p00:592B con D)
	call 0592bh		;8ec9
	call pieza_vacia		;8ecc   ; la pieza vacia...
	call apunta_lo_roto		;8ecf   ; ... y se apunta como roto
	jp borra_la_figura		;8ed2   ; borra_la_figura: borra la figura
bloque_vida_maxima:		; la cosa del suelo 15: 4 de vida maxima
	ld a,(ix+00dh)		;8ed5   ; al darle: la VIDA MAXIMA + 4, hasta 0x20
	or a			;8ed8
	ret z			;8ed9
	call pieza_vacia		;8eda   ; la pieza vacia y se apunta
	call apunta_lo_roto		;8edd   ; apunta_lo_roto: lo roto a la lista de 0xC2B0
	ld a,(0c480h)		;8ee0   ; lee la vida maxima
	add a,004h		;8ee3
	cp 020h		;8ee5   ; hasta 0x20
	jr c,L_8EEB		;8ee7
	ld a,020h		;8ee9
L_8EEB:
	ld (0c480h),a		;8eeb   ; guarda la vida maxima
	call 05890h		;8eee   ; pinta_la_vida: pinta la barra de vida
	jp borra_la_figura		;8ef1   ; borra_la_figura: borra la figura
bloque_vida_extra:		; la cosa del suelo 10: una vida
	ld a,(ix+00dh)		;8ef4   ; al darle: una VIDA mas, hasta 99
	or a			;8ef7
	ret z			;8ef8
	ld a,(0c260h)		;8ef9   ; lee las vidas
	cp 099h		;8efc
	jr z,L_8F06		;8efe
	add a,001h		;8f00
	daa			;8f02
	ld (0c260h),a		;8f03   ; guarda las vidas
L_8F06:
	call pieza_vacia		;8f06   ; pieza_vacia: la pieza de (0x70, 0x90) sin marca
	call apunta_lo_roto		;8f09   ; apunta_lo_roto: lo roto a la lista de 0xC2B0
	call 043e2h		;8f0c   ; pinta_el_marcador: pinta el marcador entero
	jp borra_la_figura		;8f0f   ; borra_la_figura: borra la figura
bloque_de_vida:		; la cosa del suelo 9: 8 de vida
	ld a,(ix+00dh)		;8f12   ; al darle: 8 de vida
	or a			;8f15
	ret z			;8f16
	ld a,008h		;8f17
	call 05884h		;8f19   ; suma_vida: suma A a la vida, hasta la maxima, y la pinta
	call pieza_vacia		;8f1c   ; pieza_vacia: la pieza de (0x70, 0x90) sin marca
	call apunta_lo_roto		;8f1f   ; apunta_lo_roto: lo roto a la lista de 0xC2B0
	jp borra_la_figura		;8f22   ; borra_la_figura: borra la figura
bloque_cosa_0:		; la cosa del suelo 11: una cosa 0
	ld a,(ix+00dh)		;8f25   ; al darle: una cosa 0 mas, hasta 3
	or a			;8f28
	ret z			;8f29
	ld a,(0c270h)		;8f2a   ; lee las 10 cosas del marcador
	inc a			;8f2d   ; una mas...
	cp 004h		;8f2e   ; ... hasta 3
	jr nz,L_8F34		;8f30
	ld a,003h		;8f32
L_8F34:
	ld (0c270h),a		;8f34   ; guarda las 10 cosas del marcador
L_8F37:
	call apunta_lo_roto		;8f37   ; apunta_lo_roto: lo roto a la lista de 0xC2B0
	call pieza_vacia		;8f3a   ; pieza_vacia: la pieza de (0x70, 0x90) sin marca
	call 05856h		;8f3d   ; pinta_las_cosas: pinta las cosas del marcador
	jp borra_la_figura		;8f40   ; borra_la_figura: borra la figura
bloque_cosa_9:		; la cosa del suelo 12: una cosa 9
	ld a,(ix+00dh)		;8f43   ; al darle: una cosa 9 mas, hasta 3
	or a			;8f46
	ret z			;8f47
	ld a,(0c279h)		;8f48
	inc a			;8f4b   ; una mas, hasta 3
	cp 004h		;8f4c
	jr nz,L_8F52		;8f4e
	ld a,003h		;8f50
L_8F52:
	ld (0c279h),a		;8f52
	jr L_8F37		;8f55
apunta_lo_roto:		; lo roto a la lista de 0xC2B0
	ld hl,0cd4eh		;8f57   ; apunta lo que ya se rompio en 0xC2B0 (hasta 48, tres bytes): el tramo, la x - 8 y la y - 0x2F
	ld a,(hl)			;8f5a   ; cuantas van
	cp 030h		;8f5b   ; ya 48: no se apuntan mas
	ret nc			;8f5d
	inc (hl)			;8f5e   ; una mas
	ld b,a			;8f5f   ; tres bytes por entrada
	add a,a			;8f60   ; * 3
	add a,b			;8f61
	ld hl,0c2b0h		;8f62
	call 04083h		;8f65   ; hl_mas_a: HL += A
	ld a,(0c484h)		;8f68   ; [0] el tramo de pasadizo (0xC484)
	ld (hl),a			;8f6b
	inc hl			;8f6c
	ld a,(ix+005h)		;8f6d   ; [1] la x - 8
	sub 008h		;8f70
	ld (hl),a			;8f72
	inc hl			;8f73
	ld a,(ix+003h)		;8f74   ; [2] la y - 0x2F
	sub 02fh		;8f77
	ld (hl),a			;8f79
	ret			;8f7a
L_8F7B:
	ld hl,0c2b0h		;8f7b   ; al entrar en la zona, la lista de lo roto (0xC2B0, 0x90 bytes) y 0xCDA0-0xCDAF a cero
	ld d,h			;8f7e   ; DE = HL + 1
	ld e,l			;8f7f
	inc de			;8f80
	xor a			;8f81
	ld (hl),a			;8f82
	ld bc,0008fh		;8f83   ; 0x90 bytes: las 48 entradas
	ldir		;8f86   ; 0xC2B0-0xC33F a cero
	ld hl,0cda0h		;8f88   ; las compras de la zona (0xCDA0, 16) a cero
	xor a			;8f8b
	ld b,010h		;8f8c
L_8F8E:
	ld (hl),a			;8f8e   ; las 16 compras
	inc hl			;8f8f
	djnz L_8F8E		;8f90
	call 0bcf2h		;8f92   ; pasadizo_secreto_a_cero: lo cogido y el mapa, a cero
	xor a			;8f95   ; 0xCD4E = 0, ninguna rota
	ld (0cd4eh),a		;8f96
	ret			;8f99
bloque_cosa_1:		; la cosa del suelo 13: la cosa 1
	ld a,(ix+00dh)		;8f9a   ; al darle: la cosa 1
	or a			;8f9d
	ret z			;8f9e
	ld a,001h		;8f9f   ; la cosa 1 = 1
	ld (0c271h),a		;8fa1
	jr L_8F37		;8fa4
pared_que_se_rompe:		; la cosa del suelo 14: la pared que se rompe
	ld a,(ix+001h)		;8fa6   ; lee el paso en que va la figura
	call 0408dh		;8fa9   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8FAC: 2 destinos del despachador de 0x408D (call en p02:8FA9):
;   0x8FB0, 0x8FCB; lo leen p02:8FA9 (4 bytes)
;   0x8fac..0x8fb0  (4 bytes)
DATA_tabla_8FAC:
	defb 0b0h,08fh	; 8fac
	defb 0cbh,08fh	; 8fae

; ======================================================================
; CODIGO 0x8fb0..0x906e  (190 bytes)
; ======================================================================


L_8FB0:
	xor a			;8fb0   ; la pared que se rompe: al darle...
	ld (ix+00ch),a		;8fb1
	ld a,(ix+00dh)		;8fb4
	or a			;8fb7
	ret z			;8fb8
	inc (ix+001h)		;8fb9   ; sube el paso en que va la figura
	call pared_abierta		;8fbc   ; ... se abre un hueco, se apunta y el efecto 0x16
	ld (ix+00bh),010h		;8fbf
	call apunta_lo_roto		;8fc3   ; apunta_lo_roto: lo roto a la lista de 0xC2B0
	ld a,016h		;8fc6
	jp 04fe4h		;8fc8   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_8FCB:
	dec (ix+00bh)		;8fcb   ; y a los 16 cuadros queda vacio
	ret nz			;8fce
	call pieza_a0		;8fcf   ; pieza_a0: la pieza de (0xA0, 0x90) sin marca
	jp borra_la_figura		;8fd2   ; borra_la_figura: borra la figura
crea_lo_del_suelo:		; una cosa del suelo en 0xCC00, de los dos bytes de HL
	ld ix,0cc00h		;8fd5   ; crea una cosa del suelo en el primer hueco de 0xCC00, con los dos bytes de HL
	ld b,004h		;8fd9
	ex de,hl			;8fdb
L_8FDC:
	ld a,(ix+000h)		;8fdc   ; lee el tipo de la figura
	or a			;8fdf   ; un hueco: tipo 0
	jr z,L_8FEA		;8fe0
	ld de,00040h		;8fe2   ; el siguiente, de 0x40 en 0x40
	add ix,de		;8fe5
	djnz L_8FDC		;8fe7
	ret			;8fe9   ; ninguno libre: nada
L_8FEA:
	ld c,000h		;8fea   ; en los pasadizos, 32 mas abajo
	ld a,(0c483h)		;8fec   ; lee si esta en un pasadizo
	or a			;8fef
	jr z,L_8FF4		;8ff0
	ld c,020h		;8ff2
L_8FF4:
	ld a,(hl)			;8ff4   ; la y: el nibble de arriba del primero, + 15
	and 0f0h		;8ff5   ; la y del nibble...
	add a,c			;8ff7   ; ... + 32 en el pasadizo
	add a,00fh		;8ff8
	ld e,a			;8ffa
	inc hl			;8ffb
	ld a,(hl)			;8ffc   ; la x: el nibble de arriba del segundo, + 8
	and 0f0h		;8ffd
	add a,008h		;8fff
	ld d,a			;9001
	dec hl			;9002
	ld a,(hl)			;9003   ; el tipo: el nibble de abajo del primero; el 0x0E pone la marca 0xFF
	and 00fh		;9004   ; el tipo
	cp 00eh		;9006
	call z,marca_de_pared		;9008   ; marca_de_pared: 0xCD2A = 0xFF
	ld (0cd3fh),de		;900b   ; 0xCD3F/0xCD40 el sitio, 0xCD3C la ficha, 0xCD3E el tipo
	ld (0cd3ch),ix		;900f
	ld (0cd3eh),a		;9013   ; el tipo, aparte
	ld hl,0907ch		;9016   ; cuantos sprites (0x907C)
	call 04083h		;9019   ; hl_mas_a: HL += A
	ld a,(hl)			;901c   ; (+0x20) los sprites
	ld (ix+020h),a		;901d   ; guarda cuantos sprites lleva la figura
	or a			;9020
	call nz,huecos_seguidos		;9021   ; si lleva, sus huecos
	push ix		;9024
	pop hl			;9026
	ld a,(0cd3eh)		;9027   ; [0] tipo, [3] y, [5] x
	ld (hl),a			;902a
	inc l			;902b
	ld (hl),000h		;902c   ; [1] el paso 0
	ld de,(0cd3fh)		;902e
	inc l			;9032
	ld (hl),000h		;9033   ; [2] la fraccion de la y
	inc l			;9035
	ld (hl),e			;9036   ; [3] la y
	inc l			;9037
	ld (hl),000h		;9038   ; [4] la fraccion de la x
	inc l			;903a
	ld (hl),d			;903b   ; [5] la x
	inc l			;903c
	ld (hl),000h		;903d
	ld a,(ix+000h)		;903f   ; los tipos 7 y mas hacen algo al tocarlos
	cp 007h		;9042
	jr c,L_904A		;9044   ; los tipos 1-6, no
	ld (ix+00ch),001h		;9046   ; (ix+0x0C) = 1
L_904A:
	ld a,(ix+020h)		;904a   ; lee cuantos sprites lleva la figura
	or a			;904d
	ret z			;904e   ; sin sprites, ya esta
	ld a,(ix+000h)		;904f   ; sus patrones (0x906C) y sus colores
	ld de,l906ch		;9052   ; de la tabla de 0x906C
	call patrones_de_la_figura		;9055   ; patrones_de_la_figura: los patrones de sus sprites, de la lista de DE
	ld (ix+00eh),001h		;9058   ; (+0x0E) = 1: no se ve hasta que le toque
	push ix		;905c
	pop hl			;905e
	xor a			;905f   ; colores sin pose
	ld (0cd37h),a		;9060
	jp 05503h		;9063
marca_de_pared:		; 0xCD2A = 0xFF
	push af			;9066   ; el 0x0E: la pieza lleva marca de pared
	ld a,0ffh		;9067
	ld (0cd2ah),a		;9069   ; guarda la marca que se pone en 0xD800
L_906C:
	pop af			;906c
	ret			;906d

; ----------------------------------------------------------------------
; DATOS dibujos_de_cada_objeto: 6 punteros, uno por objeto 1-6 (p02:9052 pasa
;   0x906C a p02:8485): los tres primeros a 0x907B y los otros a 0x907A (12
;   bytes)
;   0x906e..0x907a  (12 bytes)
DATA_dibujos_de_cada_objeto:
	defb 07bh,090h	; 906e
	defb 07bh,090h	; 9070
	defb 07bh,090h	; 9072
	defb 07ah,090h	; 9074
	defb 07ah,090h	; 9076
	defb 07ah,090h	; 9078

; ----------------------------------------------------------------------
; DATOS listas_907A: las listas de 0x906E: 0x907A es [0x08] y 0x907B es [0x01,
;   0x42], que sigue en el primer byte de la tabla de 0x907C (2 bytes)
;   0x907a..0x907c  (2 bytes)
DATA_listas_907A:
	defb 008h,001h	; 907a

; ----------------------------------------------------------------------
; DATOS sprites_de_cada_objeto: cuantos sprites lleva cada objeto 0-15
;   (p02:9016), que p02:901D deja en (ix+0x20) (16 bytes)
;   0x907c..0x908c  (16 bytes)
DATA_sprites_de_cada_objeto:
	defb 042h,002h,002h,002h,001h,001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 907c  B...............

; ======================================================================
; CODIGO 0x908c..0x9371  (741 bytes)
; ======================================================================


huecos_seguidos:		; los huecos de sprite, seguidos desde 0xCD41
	ld b,a			;908c   ; los huecos de sprite: seguidos desde 0xCD41
	ld a,(0cd41h)		;908d   ; el primer hueco libre: 0xCD41
	ld l,a			;9090
	ld h,000h		;9091
	add hl,hl			;9093   ; * 4
	add hl,hl			;9094
	ld de,0ee20h		;9095
	add hl,de			;9098
	ld de,00004h		;9099   ; 4 bytes por sprite en la copia
	ld c,0e1h		;909c   ; 0xE1: cogido
	exx			;909e
	ld de,00005h		;909f   ; HL' = (ix+0x21), el hueco del primer sprite
	ld hl,(0cd3ch)		;90a2
	set 5,l		;90a5   ; (+0x20)
	inc l			;90a7   ; (+0x21): el hueco del primero
	exx			;90a8
	call coge_un_hueco		;90a9   ; el primero...
	dec b			;90ac   ; ... y el segundo si lleva dos
	jr z,L_90B8		;90ad
coge_un_hueco:		; el hueco a la copia y a la figura
	ld (hl),c			;90af   ; cogido
	add hl,de			;90b0   ; el siguiente hueco en la copia
	exx			;90b1
	ld a,(0cd41h)		;90b2   ; el hueco...
	ld (hl),a			;90b5   ; ... en la figura
	add hl,de			;90b6   ; el sprite siguiente de la figura
	exx			;90b7
L_90B8:
	ld a,(0cd41h)		;90b8   ; el hueco siguiente para la proxima
	inc a			;90bb   ; uno mas
	ld (0cd41h),a		;90bc
	ret			;90bf
cosas_fijas:		; pinta las cosas fijas de la casilla
	di			;90c0   ; las cosas fijas estan en el banco 15
	ld a,00fh		;90c1   ; el banco 15 en 0xA000
	ld (0a000h),a		;90c3   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;90c6   ; guarda la copia del banco de 0xA000
	ei			;90c9
	xor a			;90ca   ; los huecos de sprite, desde el 0
	ld (0cd41h),a		;90cb
	ld a,(0c483h)		;90ce   ; en un pasadizo, aparte (p02:916E)
	or a			;90d1
	jp nz,L_916E		;90d2
	ld de,0a08eh		;90d5   ; la lista de la zona (0xA08E, fase * 7 + zona)
	ld a,(0c288h)		;90d8   ; lee la FASE (0-6)
	ld b,a			;90db
	add a,a			;90dc   ; fase * 7
	add a,a			;90dd
	add a,a			;90de
	sub b			;90df
	ld b,a			;90e0
	ld a,(0c280h)		;90e1   ; lee la ZONA (0-6)
	add a,b			;90e4   ; + zona
	call 0447ch		;90e5   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	call busca_la_casilla		;90e8   ; si la casilla no tiene, nada
	jp c,04206h		;90eb   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_90EE:
	ld a,(de)			;90ee   ; tres bytes por cosa: [casilla][y | tipo][x | dibujo]
	ld c,a			;90ef   ; C = la casilla de la entrada
	ld a,(0c281h)		;90f0   ; lee la CASILLA de la zona
	cp c			;90f3
	jr nz,L_911B		;90f4   ; de otra casilla: se acabo (van seguidas)
	inc de			;90f6
	ld a,(de)			;90f7   ; un tipo distinto de 0 es una cosa del suelo
	and 00fh		;90f8
	or a			;90fa
	push de			;90fb   ; en (y, x) de la entrada
	call nz,crea_lo_del_suelo		;90fc   ; crea_lo_del_suelo: una cosa del suelo en 0xCC00, de los dos bytes de HL
	pop de			;90ff
	ld a,(de)			;9100   ; la y (nibble de arriba)...
	and 0f0h		;9101
	add a,000h		;9103
	ld (0cd27h),a		;9105   ; guarda lo que se baja la pieza
	inc de			;9108
	ld a,(de)			;9109   ; ... la x...
	ld b,a			;910a
	and 0f0h		;910b
	ld (0cd28h),a		;910d   ; guarda lo que se corre la pieza
	ld a,b			;9110   ; ... y el dibujo de piezas (nibble de abajo)
	and 00fh		;9111
	inc de			;9113   ; la entrada siguiente
	push de			;9114
	call pinta_dibujo_fijo		;9115   ; el dibujo
	pop de			;9118
	jr L_90EE		;9119
L_911B:
	jp 04206h		;911b   ; bancos_1_2_3: pone los bancos 1, 2 y 3
busca_la_casilla:		; carry si la casilla no tiene cosas fijas
	ld a,(de)			;911e   ; busca la primera entrada de la casilla: [cuantas] y de tres en tres; carry si no hay
	or a			;911f
	jr z,L_9130		;9120   ; 0: ninguna
	inc de			;9122
	ld b,a			;9123   ; B = cuantas
	ld a,(0c281h)		;9124   ; lee la CASILLA de la zona
	ld c,a			;9127
L_9128:
	ld a,(de)			;9128   ; la primera de esta casilla
	cp c			;9129
	ret z			;912a
	inc de			;912b   ; tres bytes mas alla
	inc de			;912c
	inc de			;912d
	djnz L_9128		;912e
L_9130:
	scf			;9130   ; carry: ninguna
	ret			;9131
pinta_dibujo_fijo:		; el dibujo A de 0xA02B
	ld de,0a02bh		;9132   ; el dibujo A (0xA02B): [x][y] de la pieza en la pagina 1, y una lista de sitios
	call 0447ch		;9135   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;9138
	ld c,(hl)			;9139
	inc hl			;913a
	ld b,(hl)			;913b
	inc hl			;913c
	ld a,b			;913d   ; 0xFF: ninguna
	cp 0ffh		;913e
	ret z			;9140
L_9141:
	ld a,0ffh		;9141   ; cada sitio [x][y], hasta 0xFF; con marca 0xFF (pared)
	ld e,(hl)			;9143   ; E = la x
	cp e			;9144
	ret z			;9145   ; 0xFF: se acabo
	inc hl			;9146
	ld d,(hl)			;9147   ; D = la y
	inc hl			;9148
	push hl			;9149
	ld a,0ffh		;914a
	ld (0cd2ah),a		;914c   ; guarda la marca que se pone en 0xD800
	call 04e84h		;914f   ; la pieza de BC en (D, E)
	pop hl			;9152
	jr L_9141		;9153
pinta_dibujo_del_tramo:		; el dibujo A de 0xB36D
	ld de,0b36dh		;9155   ; otro dibujo (0xB36D): parejas [pieza][sitio], sin marca, hasta 0xFF
	call 0447ch		;9158   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;915b
L_915C:
	ld c,(hl)			;915c   ; C y B: la pieza en la pagina 1
	inc hl			;915d
	ld b,(hl)			;915e
	inc hl			;915f
	ld a,c			;9160
	cp 0ffh		;9161   ; 0xFF: se acabo
	ret z			;9163
	ld de,00000h		;9164   ; sin desplazar
	push hl			;9167
	call 04e84h		;9168   ; pinta_pieza: pinta la pieza de 16x16 de (B, C) de la pagina 1 en (D, E) + (0xCD28, 0xCD27) y la marca en 0xD800
	pop hl			;916b
	jr L_915C		;916c
L_916E:
	ld a,001h		;916e   ; en un pasadizo: lo de su tramo (0xCDE0, 8 bytes por tramo, hasta cuatro)
	ld (0cd15h),a		;9170   ; 0xCD15 = 1: la primera tanda de figuras
	call tramos_de_la_zona		;9173   ; tramos_de_la_zona: lo de los tramos de la zona a 0xCDE0
	ld a,(0c484h)		;9176   ; 8 bytes por tramo
	add a,a			;9179
	add a,a			;917a
	add a,a			;917b
	ld de,0cde0h		;917c
	call 04088h		;917f   ; de_mas_a: DE += A
	ld b,004h		;9182   ; hasta cuatro cosas
L_9184:
	xor a			;9184   ; sin marca
	ld (0cd2ah),a		;9185   ; guarda la marca que se pone en 0xD800
	ld a,(de)			;9188   ; 0xFF: se acabo
	inc a			;9189
	jp z,L_911B		;918a
	push bc			;918d
	push de			;918e
	exx			;918f
	pop de			;9190
	call esta_roto		;9191   ; si ya se rompio (0xC2B0), 0xCD4F lo dice
	exx			;9194
	ld a,(0cd4fh)		;9195   ; sin romper: la cosa del suelo
	or a			;9198
	jr nz,L_91A3		;9199
	ld a,(de)			;919b
	and 00fh		;919c
	push de			;919e
	call nz,crea_lo_del_suelo		;919f   ; crea_lo_del_suelo: una cosa del suelo en 0xCC00, de los dos bytes de HL
	pop de			;91a2
L_91A3:
	ld a,(de)			;91a3   ; la y (+ 32) y la x
	ld b,a			;91a4   ; B = [y | tipo]
	and 0f0h		;91a5
	add a,020h		;91a7
	ld (0cd27h),a		;91a9   ; guarda lo que se baja la pieza
	inc de			;91ac
	ld a,(de)			;91ad
	and 0f0h		;91ae
	ld (0cd28h),a		;91b0   ; guarda lo que se corre la pieza
	ld a,(0cd4fh)		;91b3   ; el dibujo: 2 sin tipo, o segun este roto (0xCD4F)
	or a			;91b6
	jr nz,L_91CE		;91b7
	ld a,b			;91b9   ; sin tipo, el dibujo 2
	and 00fh		;91ba
	call z,a_dos		;91bc   ; a_dos: A = 2
L_91BF:
	inc de			;91bf   ; el dibujo de 0xB36D
	push de			;91c0
	call pinta_dibujo_del_tramo		;91c1   ; pinta_dibujo_del_tramo: el dibujo A de 0xB36D
	pop de			;91c4
	pop bc			;91c5
	djnz L_9184		;91c6
	jp L_911B		;91c8
a_dos:		; A = 2
	ld a,002h		;91cb   ; A = 2
	ret			;91cd
L_91CE:
	cp 001h		;91ce   ; roto (1): el dibujo 0
	ld a,000h		;91d0
	jr z,L_91BF		;91d2
	ld a,001h		;91d4   ; pared rota (2): el dibujo 1
	jr L_91BF		;91d6
esta_roto:		; 0xCD4F = si esto ya se rompio
	cp 008h		;91d8   ; el tipo 8 no se mira; los demas se buscan en la lista de lo roto
	ld a,000h		;91da
	ld (0cd4fh),a		;91dc
	ret z			;91df
	ld hl,0c2b0h		;91e0
	ld a,(0cd4eh)		;91e3   ; cuantas rotas
	or a			;91e6   ; ninguna: sin romper
	ret z			;91e7
	ld b,a			;91e8
	ld a,(de)			;91e9   ; la y y la x de la cosa, en sus nibbles de arriba
	ld c,a			;91ea
	inc de			;91eb
	ld a,(de)			;91ec
	and 0f0h		;91ed
	ld d,a			;91ef
	ld a,c			;91f0
	and 0f0h		;91f1
	ld e,a			;91f3
L_91F4:
	ld a,(0c484h)		;91f4   ; [tramo][x][y]
	cp (hl)			;91f7
	ld a,003h		;91f8   ; otro tramo: 3 bytes mas alla
	jr nz,L_920A		;91fa
	inc hl			;91fc
	ld a,d			;91fd   ; la x
	cp (hl)			;91fe
	ld a,002h		;91ff
	jr nz,L_920A		;9201
	inc hl			;9203
	ld a,e			;9204   ; la y
	cp (hl)			;9205
	ld a,001h		;9206
	jr z,L_9210		;9208
L_920A:
	call 04083h		;920a   ; la entrada siguiente
	djnz L_91F4		;920d
	ret			;920f
L_9210:
	ld a,001h		;9210   ; roto: 0xCD4F = 1 (2 si era pared, tipo 0x0E)
	ld (0cd4fh),a		;9212
	ld a,c			;9215   ; el tipo de la cosa
	and 00fh		;9216
	cp 00eh		;9218
	ret nz			;921a
	ld a,002h		;921b
	ld (0cd4fh),a		;921d
	ret			;9220
tramos_de_la_zona:		; lo de los tramos de la zona a 0xCDE0
	ld a,(0c288h)		;9221   ; lo de los tramos de la zona (0xB3BE) a 0xCDE0
	ld b,a			;9224   ; fase * 7 + zona
	add a,a			;9225
	add a,a			;9226
	add a,a			;9227
	sub b			;9228
	ld b,a			;9229
	ld a,(0c280h)		;922a   ; lee la ZONA (0-6)
	add a,b			;922d
	ld de,0b3beh		;922e
	call 0447ch		;9231   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,0cde0h		;9234
	ld c,004h		;9237
L_9239:
	ld a,(de)			;9239   ; dos bytes cada uno...
	ld (hl),a			;923a   ; el primero
	inc de			;923b
	inc hl			;923c
	ld a,(de)			;923d   ; el segundo
	ld (hl),a			;923e
	inc hl			;923f
	dec c			;9240   ; uno menos de cuatro
	ld a,(de)			;9241   ; ... el bit 3, otro tramo...
	and 008h		;9242
	call nz,tramos_que_faltan		;9244   ; tramos_que_faltan: los tramos que faltan, a 0xFF
	ld a,(de)			;9247
	and 004h		;9248   ; ... el bit 2, el ultimo
	ret nz			;924a
	inc de			;924b   ; el siguiente tramo
	jr L_9239		;924c
tramos_que_faltan:		; los tramos que faltan, a 0xFF
	ld b,c			;924e   ; los tramos que faltan hasta cuatro, a 0xFF
	ld c,004h		;924f   ; (C = 4 otra vez)
	ld a,b			;9251
	or a			;9252
	ret z			;9253
	ld a,0ffh		;9254
L_9256:
	ld (hl),a			;9256   ; 0xFF, 0xFF
	inc hl			;9257
	ld (hl),a			;9258
	inc hl			;9259
	djnz L_9256		;925a
	ret			;925c
L_925D:
	ld a,(0c002h)		;925d   ; al entrar en un interior: en partida, la musica 0x01
	and 040h		;9260
	jr z,L_9269		;9262
	ld a,081h		;9264
	call 04fe4h		;9266   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_9269:
	xor a			;9269   ; 0xCD2E = 0
	ld (0cd2eh),a		;926a
	ld hl,0c500h		;926d   ; la puerta por la que se entro (bit 7) entre las tres primeras de 0xC500
	ld de,00010h		;9270
	ld b,003h		;9273
L_9275:
	ld a,(hl)			;9275   ; el bit 7: por esta se entro
	and 080h		;9276
	jr nz,L_927E		;9278
	add hl,de			;927a   ; la siguiente, de 16 en 16
	djnz L_9275		;927b
	ret			;927d
L_927E:
	ld a,(hl)			;927e   ; su numero: que interior es
	and 07fh		;927f
	push af			;9281
	call 053e3h		;9282   ; los sprites del interior
	pop af			;9285
	ld (0cd5fh),a		;9286   ; 0xCD5F = el interior
	ld de,09567h		;9289   ; su lista (0x9567): las figuras que hay, hasta 0...
	call 0447ch		;928c   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
L_928F:
	ld a,(de)			;928f   ; el tipo
	inc de			;9290
	or a			;9291
	jr z,L_929B		;9292   ; 0: se acabo la lista
	push de			;9294
	call crea_por_tipo		;9295   ; se crea la figura
	pop de			;9298
	jr L_928F		;9299
L_929B:
	ld hl,0cd80h		;929b   ; ... dos bytes, lo que se vende (un bit por cosa, 16), a 0xCD80...
	ex de,hl			;929e
	ldi		;929f
	ldi		;92a1
	ex de,hl			;92a3
	push de			;92a4
	call lo_que_se_vende		;92a5   ; lo_que_se_vende: la lista y los precios de lo que se vende
	pop de			;92a8
	ld a,(de)			;92a9   ; ... y el numero de su rotulo
	jp 04280h		;92aa   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
L_92AD:
	ld a,007h		;92ad
	jp 04280h		;92af   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
lo_que_se_vende:		; la lista y los precios de lo que se vende
	xor a			;92b2   ; lo que se vende: 0xCD83-0xCD8B a cero
	ld de,0cd84h		;92b3
	ld hl,0cd83h		;92b6
	ld bc,00008h		;92b9   ; 9 bytes
	ld (hl),a			;92bc
	ldir		;92bd
	ld de,0cd83h		;92bf
	ld b,010h		;92c2
	ld hl,(0cd80h)		;92c4   ; de los 16 bits de 0xCD80, el de arriba es la cosa 1
	xor a			;92c7   ; 0xEE80 = 0: el primer precio
	ld (0ee80h),a		;92c8
	inc a			;92cb   ; A = la cosa 1
L_92CC:
	add hl,hl			;92cc   ; el bit de arriba: se vende la cosa A
	push bc			;92cd
	push af			;92ce
	push hl			;92cf
	call c,precio_de_la_cosa		;92d0   ; cada cosa que se vende...
	pop hl			;92d3
	pop af			;92d4
	pop bc			;92d5
	inc a			;92d6   ; la siguiente cosa
	djnz L_92CC		;92d7
	ret			;92d9
precio_de_la_cosa:		; el precio de la cosa B, doblado por cada compra
	ld (de),a			;92da   ; ... su numero en la lista de 0xCD83
	inc de			;92db
	push de			;92dc
	ld b,a			;92dd   ; B = la cosa
	push bc			;92de
	call tabla_de_precios		;92df   ; la tabla de precios que toca
	pop bc			;92e2
	ld a,(0c27eh)		;92e3   ; sin la cosa 0x0A, las cosas 15 y 16 cuestan 900 ryo
	or a			;92e6
	jr nz,L_92F4		;92e7
	ld a,b			;92e9
	dec a			;92ea
	cp 00eh		;92eb
	jr c,L_92F4		;92ed
	ld hl,00900h		;92ef
	jr L_92FF		;92f2
L_92F4:
	ld a,b			;92f4   ; el precio de la cosa, de la tabla (dos bytes en BCD)
	dec a			;92f5   ; 2 bytes por cosa
	add a,a			;92f6
	call 04088h		;92f7   ; de_mas_a: DE += A
	ld a,(de)			;92fa
	ld l,a			;92fb
	inc de			;92fc
	ld a,(de)			;92fd
	ld h,a			;92fe
L_92FF:
	ld a,b			;92ff   ; las veces que ya se ha comprado en esta zona (0xCDA0 + n)...
	dec a			;9300   ; una por cosa
	ld de,0cda0h		;9301
	call 04088h		;9304   ; de_mas_a: DE += A
	ld a,(de)			;9307
	ld b,a			;9308
	or a			;9309
	jr z,L_9313		;930a   ; nunca: el precio tal cual
L_930C:
	ld e,l			;930c   ; HL += HL
	ld d,h			;930d
	call suma_bcd_9999		;930e   ; suma_bcd_9999: HL += DE en BCD, hasta 9999
	djnz L_930C		;9311
L_9313:
	ld a,(0ee80h)		;9313   ; 0xEE80: 2 por cada cosa ya puesta
	ld de,0cd86h		;9316
	call 04088h		;9319   ; de_mas_a: DE += A
	ld a,(0ee80h)		;931c
	inc a			;931f
	inc a			;9320
	ld (0ee80h),a		;9321
	ex de,hl			;9324   ; el precio
	ld (hl),e			;9325
	inc hl			;9326
	ld (hl),d			;9327
	pop de			;9328
	ret			;9329
tabla_de_precios:		; DE = la tabla de precios del juego y del avance
	ld a,(0c289h)		;932a   ; la tabla de precios: segun el juego de graficos, una de tres (0x9371)
	ld e,a			;932d   ; el juego...
	and 001h		;932e   ; ... mod 2...
	srl e		;9330   ; ... + juego / 4: los juegos 0 y 2 la tabla 0, el 1, 3 y 4 la 1, el 5 la 2
	srl e		;9332
	add a,e			;9334
	ld de,09371h		;9335
	call 0447ch		;9338   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld a,(0c288h)		;933b   ; y segun lo avanzado (fase * 7 + zona + 1): hasta 9, de 10 a 19, de 20 a 39, de 40 en adelante
	ld b,a			;933e
	add a,a			;933f
	add a,a			;9340
	add a,a			;9341
	sub b			;9342
	ld b,a			;9343
	ld a,(0c280h)		;9344   ; lee la ZONA (0-6)
	add a,b			;9347
	inc a			;9348   ; + 1
	ld b,a			;9349
	cp 028h		;934a   ; 40 o mas: el tramo de 0x60
	ld a,060h		;934c
	jr nc,L_9360		;934e
	ld a,b			;9350
	cp 014h		;9351   ; 20 o mas: 0x40
	ld a,040h		;9353
	jr nc,L_9360		;9355
	ld a,b			;9357
	cp 00ah		;9358   ; 10 o mas: 0x20
	ld a,020h		;935a
	jr nc,L_9360		;935c
	ld a,000h		;935e   ; menos: 0
L_9360:
	call 04088h		;9360   ; de_mas_a: DE += A
	ret			;9363
suma_bcd_9999:		; HL += DE en BCD, hasta 9999
	ld a,l			;9364   ; HL += DE en BCD; pasado de 9999, 9999
	add a,e			;9365   ; las dos cifras de abajo
	daa			;9366
	ld l,a			;9367
	ld a,h			;9368
	adc a,d			;9369   ; las de arriba
	daa			;936a
	ld h,a			;936b
	ret nc			;936c
	ld hl,09999h		;936d   ; desborda: 9999
	ret			;9370

; ----------------------------------------------------------------------
; DATOS precios_de_cada_tienda: 3 punteros, uno por clase de tienda (0xC289 y
;   1 + 0xC289 / 4, p02:932A), a sus precios (6 bytes)
;   0x9371..0x9377  (6 bytes)
DATA_precios_de_cada_tienda:
	defb 077h,093h	; 9371
	defb 0f7h,093h	; 9373
	defb 077h,094h	; 9375

; ----------------------------------------------------------------------
; DATOS precios: tres tablas de 128 bytes, una por clase de tienda; cada una
;   son cuatro tramos de 16 palabras en BCD y p02:9344 escoge el tramo por lo
;   avanzado de la partida (fase x 7 + zona + 1: menos de 10, de 20, de 40, o
;   mas) (384 bytes)
;   0x9377..0x94f7  (384 bytes)
DATA_precios:
	defb 030h,000h	; 9377
	defb 020h,000h	; 9379
	defb 050h,000h	; 937b
	defb 050h,000h	; 937d
	defb 050h,000h	; 937f
	defb 050h,000h	; 9381
	defb 050h,000h	; 9383
	defb 020h,001h	; 9385
	defb 040h,000h	; 9387
	defb 050h,001h	; 9389
	defb 030h,000h	; 938b
	defb 020h,000h	; 938d
	defb 050h,000h	; 938f
	defb 005h,000h	; 9391
	defb 050h,000h	; 9393
	defb 000h,001h	; 9395
	defb 060h,000h	; 9397
	defb 040h,000h	; 9399
	defb 000h,001h	; 939b
	defb 000h,001h	; 939d
	defb 000h,001h	; 939f
	defb 000h,001h	; 93a1
	defb 000h,001h	; 93a3
	defb 050h,002h	; 93a5
	defb 080h,001h	; 93a7
	defb 000h,003h	; 93a9
	defb 060h,000h	; 93ab
	defb 040h,000h	; 93ad
	defb 000h,001h	; 93af
	defb 000h,000h	; 93b1
	defb 050h,001h	; 93b3
	defb 040h,002h	; 93b5
	defb 090h,000h	; 93b7
	defb 060h,000h	; 93b9
	defb 080h,002h	; 93bb
	defb 080h,002h	; 93bd
	defb 000h,003h	; 93bf
	defb 000h,003h	; 93c1
	defb 000h,003h	; 93c3
	defb 000h,004h	; 93c5
	defb 040h,004h	; 93c7
	defb 000h,008h	; 93c9
	defb 090h,000h	; 93cb
	defb 060h,000h	; 93cd
	defb 080h,002h	; 93cf
	defb 000h,000h	; 93d1
	defb 000h,005h	; 93d3
	defb 020h,004h	; 93d5
	defb 020h,001h	; 93d7
	defb 000h,001h	; 93d9
	defb 000h,006h	; 93db
	defb 000h,006h	; 93dd
	defb 000h,004h	; 93df
	defb 000h,004h	; 93e1
	defb 000h,004h	; 93e3
	defb 000h,005h	; 93e5
	defb 000h,006h	; 93e7
	defb 000h,015h	; 93e9
	defb 020h,001h	; 93eb
	defb 000h,001h	; 93ed
	defb 000h,006h	; 93ef
	defb 000h,000h	; 93f1
	defb 000h,007h	; 93f3
	defb 020h,006h	; 93f5
	defb 030h,000h	; 93f7
	defb 020h,000h	; 93f9
	defb 040h,000h	; 93fb
	defb 040h,000h	; 93fd
	defb 050h,000h	; 93ff
	defb 050h,000h	; 9401
	defb 050h,000h	; 9403
	defb 050h,001h	; 9405
	defb 050h,000h	; 9407
	defb 050h,001h	; 9409
	defb 030h,000h	; 940b
	defb 020h,000h	; 940d
	defb 040h,000h	; 940f
	defb 000h,000h	; 9411
	defb 050h,000h	; 9413
	defb 000h,001h	; 9415
	defb 060h,000h	; 9417
	defb 040h,000h	; 9419
	defb 080h,000h	; 941b
	defb 080h,000h	; 941d
	defb 050h,001h	; 941f
	defb 050h,001h	; 9421
	defb 050h,001h	; 9423
	defb 000h,003h	; 9425
	defb 060h,001h	; 9427
	defb 000h,004h	; 9429
	defb 060h,000h	; 942b
	defb 040h,000h	; 942d
	defb 080h,000h	; 942f
	defb 000h,000h	; 9431
	defb 000h,002h	; 9433
	defb 080h,002h	; 9435
	defb 090h,000h	; 9437
	defb 060h,000h	; 9439
	defb 050h,002h	; 943b
	defb 050h,002h	; 943d
	defb 000h,004h	; 943f
	defb 000h,004h	; 9441
	defb 000h,004h	; 9443
	defb 000h,005h	; 9445
	defb 000h,012h	; 9447
	defb 000h,007h	; 9449
	defb 090h,000h	; 944b
	defb 060h,000h	; 944d
	defb 050h,002h	; 944f
	defb 000h,000h	; 9451
	defb 000h,005h	; 9453
	defb 000h,004h	; 9455
	defb 050h,001h	; 9457
	defb 020h,001h	; 9459
	defb 020h,004h	; 945b
	defb 020h,004h	; 945d
	defb 000h,006h	; 945f
	defb 000h,006h	; 9461
	defb 000h,006h	; 9463
	defb 000h,008h	; 9465
	defb 000h,012h	; 9467
	defb 000h,012h	; 9469
	defb 050h,001h	; 946b
	defb 020h,001h	; 946d
	defb 020h,004h	; 946f
	defb 000h,000h	; 9471
	defb 000h,007h	; 9473
	defb 020h,005h	; 9475
	defb 050h,000h	; 9477
	defb 030h,000h	; 9479
	defb 080h,000h	; 947b
	defb 080h,000h	; 947d
	defb 050h,000h	; 947f
	defb 050h,000h	; 9481
	defb 050h,000h	; 9483
	defb 000h,004h	; 9485
	defb 000h,001h	; 9487
	defb 000h,020h	; 9489
	defb 050h,000h	; 948b
	defb 030h,000h	; 948d
	defb 080h,000h	; 948f
	defb 000h,000h	; 9491
	defb 050h,000h	; 9493
	defb 000h,001h	; 9495
	defb 000h,001h	; 9497
	defb 060h,000h	; 9499
	defb 050h,001h	; 949b
	defb 050h,001h	; 949d
	defb 000h,001h	; 949f
	defb 000h,001h	; 94a1
	defb 000h,001h	; 94a3
	defb 000h,005h	; 94a5
	defb 050h,002h	; 94a7
	defb 000h,020h	; 94a9
	defb 000h,001h	; 94ab
	defb 060h,000h	; 94ad
	defb 050h,001h	; 94af
	defb 000h,000h	; 94b1
	defb 000h,002h	; 94b3
	defb 080h,003h	; 94b5
	defb 050h,001h	; 94b7
	defb 000h,001h	; 94b9
	defb 000h,003h	; 94bb
	defb 000h,003h	; 94bd
	defb 050h,002h	; 94bf
	defb 050h,002h	; 94c1
	defb 050h,002h	; 94c3
	defb 000h,006h	; 94c5
	defb 000h,006h	; 94c7
	defb 000h,020h	; 94c9
	defb 050h,001h	; 94cb
	defb 000h,001h	; 94cd
	defb 000h,003h	; 94cf
	defb 000h,000h	; 94d1
	defb 000h,006h	; 94d3
	defb 080h,005h	; 94d5
	defb 050h,002h	; 94d7
	defb 000h,002h	; 94d9
	defb 000h,007h	; 94db
	defb 000h,007h	; 94dd
	defb 000h,005h	; 94df
	defb 000h,005h	; 94e1
	defb 000h,005h	; 94e3
	defb 000h,010h	; 94e5
	defb 000h,015h	; 94e7
	defb 000h,020h	; 94e9
	defb 050h,002h	; 94eb
	defb 000h,002h	; 94ed
	defb 000h,007h	; 94ef
	defb 000h,000h	; 94f1
	defb 000h,008h	; 94f3
	defb 080h,007h	; 94f5

; ======================================================================
; CODIGO 0x94f7..0x9556  (95 bytes)
; ======================================================================


L_94F7:
	ld de,0cd83h		;94f7   ; la tienda en pantalla: los iconos de lo que se vende (hasta tres)...
	ld hl,09556h		;94fa
	ld b,003h		;94fd
L_94FF:
	ld a,(de)			;94ff   ; la cosa (0, ninguna)
	or a			;9500
	jr z,L_951A		;9501
	cp 010h		;9503   ; ... salvo las cosas 15 y 16
	ret z			;9505
	cp 00fh		;9506
	ret z			;9508
	dec a			;9509   ; el icono es la cosa - 1
	inc de			;950a
	push bc			;950b
	push de			;950c
	ld e,(hl)			;950d   ; el sitio, de 0x9556
	inc hl			;950e
	ld d,(hl)			;950f
	inc hl			;9510
	push hl			;9511
	call 04eb9h		;9512   ; pinta_icono: pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra
	pop hl			;9515
	pop de			;9516
	pop bc			;9517
	djnz L_94FF		;9518
L_951A:
	ld de,0cd86h		;951a   ; ... y sus precios, debajo
	ld hl,09556h		;951d
	ld b,003h		;9520
L_9522:
	ld a,(de)			;9522   ; el precio (0, ninguno)
	inc de			;9523
	ld c,a			;9524
	ld a,(de)			;9525
	or c			;9526
	ret z			;9527
	dec de			;9528
	push bc			;9529
	ld c,e			;952a   ; BC = donde esta
	ld b,d			;952b
	inc de			;952c
	inc de			;952d
	push de			;952e
	ld e,(hl)			;952f   ; el sitio del icono...
	inc hl			;9530
	ld d,(hl)			;9531
	inc hl			;9532
	ld a,010h		;9533   ; ... 16 mas abajo...
	add a,e			;9535
	ld e,a			;9536
	ld a,0f0h		;9537   ; ... y 16 mas a la izquierda
	add a,d			;9539
	ld d,a			;953a
	push hl			;953b
	ld l,c			;953c
	ld h,b			;953d
	ld b,002h		;953e   ; las 4 cifras
	inc hl			;9540
	push de			;9541
	call 04420h		;9542   ; pinta_bcd: pinta cifras en BCD
	pop de			;9545
	ld a,020h		;9546   ; 32 a la derecha
	add a,d			;9548
	ld d,a			;9549
	ld hl,05050h		;954a   ; la moneda de (0x50, 0x50) de la pagina 1 al lado del precio
	call 04ef1h		;954d   ; copia_caracter: el caracter de (H, L) de la pagina 1 en (D, E) de la 0 (LMMM IMP)
	pop hl			;9550
	pop de			;9551
	pop bc			;9552
	djnz L_9522		;9553
	ret			;9555

; ----------------------------------------------------------------------
; DATOS sitios_de_lo_que_se_vende: tres parejas [y][x], una por cosa a la
;   venta, que recorre p02:94FA (6 bytes)
;   0x9556..0x955c  (6 bytes)
DATA_sitios_de_lo_que_se_vende:
	defb 078h,070h	; 9556
	defb 078h,098h	; 9558
	defb 078h,048h	; 955a

; ======================================================================
; CODIGO 0x955c..0x9567  (11 bytes)
; ======================================================================


L_955C:
	ld hl,0cda0h		;955c   ; al entrar en la zona: las veces que se ha comprado cada cosa, a cero
	xor a			;955f
	ld b,010h		;9560
L_9562:
	ld (hl),a			;9562   ; 16 a cero
	inc hl			;9563
	djnz L_9562		;9564
	ret			;9566

; ----------------------------------------------------------------------
; DATOS sitios_de_cada_interior: 21 punteros, uno por interior (0xCD5F,
;   p02:9289), a su ficha (42 bytes)
;   0x9567..0x9591  (42 bytes)
DATA_sitios_de_cada_interior:
	defb 091h,095h	; 9567
	defb 097h,095h	; 9569
	defb 09dh,095h	; 956b
	defb 0a3h,095h	; 956d
	defb 0a9h,095h	; 956f
	defb 0afh,095h	; 9571
	defb 0b5h,095h	; 9573
	defb 0bbh,095h	; 9575
	defb 0c1h,095h	; 9577
	defb 0c7h,095h	; 9579
	defb 0cdh,095h	; 957b
	defb 0d3h,095h	; 957d
	defb 0d9h,095h	; 957f
	defb 0dfh,095h	; 9581
	defb 0e5h,095h	; 9583
	defb 0ebh,095h	; 9585
	defb 0f1h,095h	; 9587
	defb 0f7h,095h	; 9589
	defb 0fch,095h	; 958b
	defb 002h,096h	; 958d
	defb 007h,096h	; 958f

; ----------------------------------------------------------------------
; DATOS fichas_de_interior: las 21 fichas: lo que se crea dentro (p02:828F por
;   cada byte hasta un 0), dos bytes que p02:929F copia a 0xCD80 y el numero
;   de rotulo que escribe p00:4280 (123 bytes)
;   0x9591..0x960c  (123 bytes)
DATA_fichas_de_interior:
	defb 022h,025h,000h,040h,018h,0ffh,023h,025h,000h,008h,0c0h,0ffh,023h,025h,000h,000h	; 9591  "%.@..#%....#%..
	defb 026h,0ffh,022h,025h,000h,080h,081h,0ffh,022h,025h,000h,000h,092h,0ffh,023h,025h	; 95a1  &."%...."%....#%
	defb 000h,000h,04ch,0ffh,023h,025h,000h,000h,0a1h,0ffh,022h,025h,000h,000h,046h,0ffh	; 95b1  ..L.#%...."%..F.
	defb 022h,025h,000h,040h,001h,0ffh,023h,025h,000h,000h,048h,0ffh,023h,025h,000h,000h	; 95c1  "%.@..#%..H.#%..
	defb 030h,0ffh,022h,025h,000h,000h,005h,0ffh,022h,025h,000h,030h,000h,0ffh,023h,025h	; 95d1  0."%...."%.0..#%
	defb 000h,000h,001h,0ffh,023h,025h,000h,040h,000h,0ffh,022h,025h,000h,080h,000h,0ffh	; 95e1  ....#%.@.."%....
	defb 02bh,026h,000h,002h,000h,0ffh,024h,000h,000h,000h,0ffh,026h,02ch,000h,001h,000h	; 95f1  +&....$....&,...
	defb 000h,028h,000h,000h,000h,0ffh,02fh,000h,000h,000h,0ffh	; 9601  .(..../....

; ======================================================================
; CODIGO 0x960c..0x96cb  (191 bytes)
; ======================================================================


texto_de_la_zona:		; el texto de la zona
	ld a,(0c288h)		;960c   ; el texto de la pantalla de la zona pasada: fase * 5 + zona - 1
	ld b,a			;960f
	add a,a			;9610
	add a,a			;9611
	add a,b			;9612
	ld b,a			;9613
	ld a,(0c280h)		;9614   ; lee la ZONA (0-6)
	dec a			;9617
	add a,b			;9618
	push af			;9619
	di			;961a
	ld a,00fh		;961b   ; el banco 15: los textos de 0xBC16
	ld (0a000h),a		;961d   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;9620   ; guarda la copia del banco de 0xA000
	ei			;9623
	pop af			;9624
	ld de,0bc16h		;9625
	call 0447ch		;9628   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;962b
	ld de,020b0h		;962c   ; se escribe letra a letra desde (0x20, 0xB0)
	call 042e1h		;962f   ; empieza_texto: empieza un texto letra a letra: HL el texto, DE el sitio (0xCD61-0xCD67)
	call 04206h		;9632   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ld a,001h		;9635   ; 0xCD11 = 1 mientras dure
	ld (0cd11h),a		;9637
	ld a,02dh		;963a   ; y la figura 0x2D, la que lo acompana
	jp crea_por_tipo		;963c   ; crea_por_tipo: crea la figura de tipo A segun su tabla
L_963F:
	call las_figuras		;963f   ; las figuras, un cuadro, y sus sprites a la VRAM
	call sprites_de_las_figuras		;9642   ; sprites_de_las_figuras: los sprites de las ocho de 0xC600
	call copia_las_figuras		;9645   ; copia_las_figuras: sprites de las ocho de 0xC600 a la copia de 0xEE20
	call 05b61h		;9648   ; sube_colores_de_sprite: la copia de 0xEC00-0xEE7F (colores y atributos de los sprites) a 0xF400
	ret			;964b
L_964C:
	ld de,04060h		;964c   ; crea la figura B en (0x60, 0x40)
	call crea_figura		;964f   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
	ret			;9652
tipo_45_sale:		; la figura de tipo 45 (0x2D): su arranque (tabla de p02:8427)
	ld a,(0c002h)		;9653   ; la 0x2D: pose 0x81 (0x88 con Ebisumaru), anda a la derecha (0x80)
	rla			;9656   ; el bit 7: Ebisumaru
	ld a,081h		;9657
	jr nc,L_965D		;9659
	ld a,088h		;965b
L_965D:
	ld (ix+00ah),a		;965d   ; guarda la pose de la figura
	ld de,00080h		;9660
	call pon_velocidad_x		;9663   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00000h		;9666
	call pon_velocidad_y		;9669   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	xor a			;966c
	ld (ix+075h),a		;966d
	ld (ix+01fh),a		;9670
	ld (ix+00bh),0c0h		;9673
	ret			;9677
tipo_45:		; la figura de tipo 45 (0x2D), un cuadro (tabla de p02:871C)
	dec (ix+00bh)		;9678   ; cada 0xC0 cuadros, un trozo mas del dibujo (p02:96D3)
	call z,trozo_del_dibujo		;967b   ; trozo_del_dibujo: un trozo mas del dibujo de la zona pasada
	call letra_cada_16		;967e   ; una letra del texto cada 16 cuadros
	ld a,(ix+005h)		;9681   ; lee la x de la figura
	cp 0e0h		;9684   ; en x 0xE0, acaba
	jr z,$+127		;9686
	ld a,(0c003h)		;9688   ; cada 8 cuadros, la pose siguiente; con la cuarta, sale la figura 0x2E (efecto 0x10)
	and 007h		;968b
	ret nz			;968d
	call pose_del_2d		;968e   ; pose_del_2d: las poses de la figura 0x2D
	cp 003h		;9691
	ret nz			;9693
	ld a,02eh		;9694
	ld d,(ix+005h)		;9696   ; lee la x de la figura
	ld e,(ix+003h)		;9699   ; lee la y de la figura
	ld (0cd0fh),de		;969c
	call crea_por_tipo		;96a0   ; crea_por_tipo: crea la figura de tipo A segun su tabla
	ld a,010h		;96a3
	jp 04fe4h		;96a5   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
pose_del_2d:		; las poses de la figura 0x2D
	ld a,(0c002h)		;96a8   ; cuatro poses en rueda (0x96CB Goemon, 0x96CF Ebisumaru)
	rla			;96ab
	ld hl,096cbh		;96ac
	jr nc,L_96B4		;96af
	ld hl,096cfh		;96b1
L_96B4:
	ld a,(ix+075h)		;96b4   ; la que toca (0-3)...
	ld b,a			;96b7
	call 04083h		;96b8   ; hl_mas_a: HL += A
	ld a,(hl)			;96bb
	ld (ix+00ah),a		;96bc   ; ... su pose
	ld a,b			;96bf   ; la siguiente, en rueda
	inc a			;96c0
	cp 004h		;96c1
	jr nz,L_96C7		;96c3
	ld a,000h		;96c5
L_96C7:
	ld (ix+075h),a		;96c7
	ret			;96ca

; ----------------------------------------------------------------------
; DATOS poses_del_96CB: dos tandas de cuatro poses (ix+0x0A) que p02:96B4
;   recorre en bucle con (ix+0x75): 0x96CB para el jugador 1 y 0x96CF para el
;   2 (8 bytes)
;   0x96cb..0x96d3  (8 bytes)
DATA_poses_del_96CB:
	defb 081h,082h,083h,082h,088h,089h,08ah,089h	; 96cb  ........

; ======================================================================
; CODIGO 0x96d3..0x9953  (640 bytes)
; ======================================================================


trozo_del_dibujo:		; un trozo mas del dibujo de la zona pasada
	ld (ix+00bh),018h		;96d3   ; hasta 8 veces: 16 x 8 de (0x00, 0xD0) de la pagina 1 en dos sitios (y 0x38 y 0x98), 32 mas a la derecha cada vez
	ld a,(ix+01fh)		;96d7   ; (ix+0x1F): cuantos trozos van
	cp 008h		;96da
	ret z			;96dc
	inc (ix+01fh)		;96dd   ; uno mas
	add a,a			;96e0   ; x = trozo * 32 + 0x10
	add a,a			;96e1
	add a,a			;96e2
	add a,a			;96e3
	add a,a			;96e4
	add a,010h		;96e5
	ld d,a			;96e7
	ld e,038h		;96e8   ; en y 0x38...
	ld hl,000d0h		;96ea   ; ... el trozo de (0x00, 0xD0), 16 x 8, de la pagina 1 a la 0
	ld bc,01008h		;96ed
	ld a,001h		;96f0
	push de			;96f2
	call 0476eh		;96f3   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
	pop de			;96f6
	ld e,098h		;96f7   ; ... y otro en y 0x98
	ld hl,000d0h		;96f9
	ld bc,01008h		;96fc
	ld a,001h		;96ff
	call 0476eh		;9701   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
	ret			;9704
L_9705:
	xor a			;9705   ; el texto se acabo (0xCD11 = 0)
	ld (0cd11h),a		;9706
	ret			;9709
L_970A:
	ld de,(0cd0fh)		;970a   ; crea la figura B donde se guardo (0xCD0F)
	call crea_figura		;970e   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
	ret			;9711
tipo_46_sale:		; la figura de tipo 46 (0x2E): su arranque (tabla de p02:8427)
	ld (ix+00ah),084h		;9712   ; la 0x2E: pose 0x84, sale hacia arriba y a la izquierda, 48 cuadros
	ld de,0ff00h		;9716
	call pon_velocidad_x		;9719   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,0fe00h		;971c
	call pon_velocidad_y		;971f   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld (ix+00bh),030h		;9722
	ret			;9726
tipo_46:		; la figura de tipo 46 (0x2E), un cuadro (tabla de p02:871C)
	ld de,00010h		;9727   ; cae despacio (0x10) y cambia de pose cada 2 cuadros
	call 0a13bh		;972a   ; cae
	dec (ix+00bh)		;972d   ; al acabar la cuenta, se va
	jp z,borra_la_figura		;9730   ; borra_la_figura: borra la figura
	ld b,084h		;9733
	ld a,(ix+00bh)		;9735   ; la segunda mitad, dos poses mas alla
	cp 018h		;9738
	jr nc,L_973E		;973a
	inc b			;973c
	inc b			;973d
L_973E:
	ld a,(0c003h)		;973e   ; cada 4 cuadros, una de dos
	rr a		;9741
	rr a		;9743
	and 001h		;9745
	add a,b			;9747
	ld (ix+00ah),a		;9748   ; guarda la pose de la figura
	ret			;974b
letra_cada_16:		; una letra del texto cada 16 cuadros
	ld a,(0c003h)		;974c   ; cada 16 cuadros, una letra del texto
	and 00fh		;974f
	ret nz			;9751
	di			;9752
	ld a,00fh		;9753
	ld (0a000h),a		;9755   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;9758   ; guarda la copia del banco de 0xA000
	ei			;975b
	call 042f1h		;975c   ; sigue_texto: saca la letra siguiente del texto de 0xCD65 (0xFF acaba)
	call 04206h		;975f   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ret			;9762
L_9763:
	ld hl,0cd48h		;9763   ; sale por un lado: el que este libre (0xCD48 la derecha, 0xCD49 la izquierda); si los dos, al azar
	ld c,(hl)			;9766   ; C = las de la derecha, B = las de la izquierda
	inc hl			;9767
	ld b,(hl)			;9768
	ld a,c			;9769
	or b			;976a
	jp z,borra_la_figura		;976b   ; ninguna: no sale
	ld a,c			;976e
	or a			;976f   ; solo a la izquierda
	jr z,L_97EF		;9770
	ld a,b			;9772
	or a			;9773   ; solo a la derecha
	jr z,sale_por_la_derecha		;9774
	ld a,r		;9776   ; las dos: al azar
	ld b,a			;9778
	ld a,(0c00dh)		;9779
	rra			;977c
	rra			;977d
	xor b			;977e
	and 001h		;977f
	jr z,L_97EF		;9781
	jr sale_por_la_derecha		;9783
filas_de_los_bordes:		; las filas libres de los bordes
	ld de,01858h		;9785   ; que filas estan libres en los bordes: a la izquierda (x 0x18 y 0x08)...
	call filas_libres		;9788   ; x 0x18
	ld (0cd49h),a		;978b
	ld de,00858h		;978e   ; y x 0x08: las dos libres
	call filas_libres		;9791   ; filas_libres: las 8 filas en las que se puede estar desde (D, E)
	ld a,(0cd49h)		;9794
	and c			;9797
	ld (0cd49h),a		;9798
	ld de,0e858h		;979b   ; ... y a la derecha (x 0xE8 y 0xD8)
	call filas_libres		;979e   ; x 0xE8
	ld (0cd48h),a		;97a1
	ld de,0d858h		;97a4   ; y x 0xD8
	call filas_libres		;97a7   ; filas_libres: las 8 filas en las que se puede estar desde (D, E)
	ld a,(0cd48h)		;97aa
	and c			;97ad
	ld (0cd48h),a		;97ae
	ret			;97b1
filas_libres:		; las 8 filas en las que se puede estar desde (D, E)
	ld b,008h		;97b2   ; 8 filas desde la y de E: un bit por fila donde se puede estar
	ld c,000h		;97b4
L_97B6:
	push bc			;97b6   ; en (D, E)...
	push de			;97b7
	call 0781fh		;97b8   ; no_se_puede_estar: carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
	pop de			;97bb
	jr c,L_97D8		;97bc
	push de			;97be
	ld a,e			;97bf   ; ... y 3 mas arriba...
	sub 003h		;97c0
	ld e,a			;97c2
	call 0781fh		;97c3   ; no_se_puede_estar: carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
	pop de			;97c6
	jr c,L_97D8		;97c7
	ld a,(0cd5bh)		;97c9   ; ... y en la primera tanda, 20 mas a la derecha
	or a			;97cc
	jr z,L_97D8		;97cd
	push de			;97cf
	ld a,d			;97d0
	add a,014h		;97d1
	ld d,a			;97d3
	call 0781fh		;97d4   ; no_se_puede_estar: carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
	pop de			;97d7
L_97D8:
	pop bc			;97d8
	ccf			;97d9   ; se puede: el bit a 1
	rr c		;97da
	ld a,010h		;97dc   ; la fila siguiente, 16 mas abajo
	add a,e			;97de
	ld e,a			;97df
	djnz L_97B6		;97e0
	ld a,c			;97e2   ; A = los 8 bits
	ret			;97e3
sale_por_la_derecha:		; x 0xF7, mirando a la izquierda
	ld hl,0cd48h		;97e4   ; por la derecha: x 0xF7, mirando a la izquierda (2)
	ld (ix+005h),0f7h		;97e7   ; la x de la figura = 0xF7
	ld d,002h		;97eb
	jr L_97F8		;97ed
L_97EF:
	ld hl,0cd49h		;97ef   ; por la izquierda: x 0x08, mirando a la derecha (1)
	ld (ix+005h),008h		;97f2   ; la x de la figura = 0x08
	ld d,001h		;97f6
L_97F8:
	push de			;97f8
	call fila_al_azar		;97f9   ; una fila libre al azar
	pop de			;97fc
	ld (ix+003h),a		;97fd   ; guarda la y de la figura
	ld a,d			;9800   ; el rumbo: 1 (derecha) o 2 (izquierda)
	call 0a58ah		;9801   ; pon_rumbo: la direccion A y su velocidad
	ld a,(0cd5bh)		;9804   ; en la primera tanda, sin mas
	or a			;9807
	ret nz			;9808
	ld a,(ix+005h)		;9809   ; si el jugador esta a menos de 32 de ese borde y de 64 en vertical, no sale (0xCD14 = 1)
	cp 008h		;980c   ; por la izquierda: el jugador a menos de 32 del borde?
	jr nz,L_9818		;980e
	ld a,(0c496h)		;9810   ; lee la x del jugador
	sub 020h		;9813
	ret nc			;9815
	jr L_981E		;9816
L_9818:
	ld a,(0c496h)		;9818   ; lee la x del jugador
	sub 0e0h		;981b
	ret c			;981d
L_981E:
	ld a,(0c494h)		;981e   ; lee la y del jugador
	sub 020h		;9821
	ld b,a			;9823
	ld a,(ix+003h)		;9824   ; lee la y de la figura
	sub b			;9827
	cp 040h		;9828
	ret nc			;982a
	ld a,001h		;982b
	ld (0cd14h),a		;982d
	jp borra_la_figura		;9830   ; borra_la_figura: borra la figura
fila_al_azar:		; una fila libre al azar
	call lista_de_filas		;9833   ; una de las filas libres al azar (registro R y 0xC00D)
	ld d,a			;9836   ; D = cuantas filas libres
	ld a,r		;9837
	ld c,a			;9839
	ld a,(0c00dh)		;983a
	rr a		;983d
	xor c			;983f
	and 00fh		;9840   ; un numero de 1 a 16...
	inc a			;9842
	ld b,a			;9843
	ld c,000h		;9844
L_9846:
	inc c			;9846   ; ... vueltas por las libres
	ld a,c			;9847
	cp d			;9848
	jr nz,L_984D		;9849
	ld c,000h		;984b
L_984D:
	djnz L_9846		;984d
	ld a,c			;984f
	ld hl,0cd00h		;9850   ; la y de esa fila
	call 04083h		;9853   ; hl_mas_a: HL += A
	ld a,(hl)			;9856
	ret			;9857
lista_de_filas:		; las y de las filas libres a 0xCD00
	ld a,(hl)			;9858   ; las filas libres de (HL), sus y (desde 0x58, de 16 en 16) a 0xCD00; D = cuantas
	ld b,008h		;9859   ; 8 filas
	exx			;985b
	ld hl,0cd00h		;985c
	ld d,000h		;985f
	ld c,058h		;9861   ; desde y 0x58
	exx			;9863
L_9864:
	rra			;9864   ; la fila libre...
	push af			;9865
	exx			;9866
	call c,apunta_fila		;9867   ; ... se apunta
	ld a,010h		;986a   ; la siguiente, 16 mas abajo
	add a,c			;986c
	ld c,a			;986d
	exx			;986e
	pop af			;986f
	djnz L_9864		;9870
	exx			;9872   ; A = cuantas
	ld a,d			;9873
	exx			;9874
	ret			;9875
apunta_fila:		; la y a la lista y una mas
	ld (hl),c			;9876   ; su y, y una mas
	inc hl			;9877
	inc d			;9878
	ret			;9879
L_987A:
	call cuadro_del_pasadizo_secreto		;987a   ; dentro del pasadizo secreto, un cuadro
	call 05b1dh		;987d   ; gira_los_sprites: gira el orden de los sprites (0xC25F) y los sube a 0x7400/0x7600
	ret			;9880
cuadro_del_pasadizo_secreto:		; un cuadro del pasadizo secreto
	ld a,(0cdcdh)		;9881   ; segun 0xCDCD, 0xCDC8 o lo normal (p03:B8C3 y p03:BC5C)
	or a			;9884
	jp nz,0bd06h		;9885   ; salida_del_pasadizo_secreto: la puerta, el premio y fuera
	ld a,(0cdc8h)		;9888
	or a			;988b
	jp nz,0bc27h		;988c   ; sale_del_mapa: el boton vuelve a la vista
	call 0b8c3h		;988f   ; anda_por_el_pasadizo_secreto: arriba avanza, izquierda y derecha giran, abajo da media vuelta, el boton el mapa
	call 0bc5ch		;9892   ; coge_en_el_pasadizo_secreto: lo que hay en la casilla, una vez
	ld a,(0cdc5h)		;9895   ; con 0xCDC5, se repinta todo
	or a			;9898
	ret z			;9899
	call sprites_fuera_desde_2		;989a   ; sprites_fuera_desde_2: fuera los sprites desde el 2
	call 045eeh		;989d   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 0460ah		;98a0   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	call 0b9cbh		;98a3   ; flecha_de_direccion: los sprites de la flecha hacia donde se mira
	call pinta_la_vista		;98a6   ; pinta_la_vista: las paredes de la vista del pasadizo secreto
	call sprites_de_la_vista		;98a9   ; sprites_de_la_vista: los sprites de lo que hay delante
	jp 045e1h		;98ac   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
sprites_fuera_desde_2:		; fuera los sprites desde el 2
	ld hl,0ee08h		;98af   ; los sprites desde el 2 (0xEE08), fuera
	ld de,0ee09h		;98b2
	ld bc,00077h		;98b5   ; 30 sprites (0x78 bytes)
	ld a,0e0h		;98b8
	ld (hl),a			;98ba
	ldir		;98bb
	ret			;98bd
pinta_la_vista:		; las paredes de la vista del pasadizo secreto
	ld hl,0cdbbh		;98be   ; los ocho dibujos de 0xCDBB y el de 0xCDB2 (0x1C mas con 0xCDCC)
	ld b,008h		;98c1
L_98C3:
	ld a,(hl)			;98c3   ; los ocho de la vista de los lados...
	inc hl			;98c4
	exx			;98c5
	or a			;98c6
	call nz,dibujo_de_caracteres		;98c7   ; dibujo_de_caracteres: pinta un dibujo hecho de caracteres
	exx			;98ca
	djnz L_98C3		;98cb
	ld a,(0cdb2h)		;98cd   ; ... y el de delante: segun a cuantas casillas este la pared (0xCDB2)
	or a			;98d0
	jp z,dibujo_de_caracteres		;98d1   ; dibujo_de_caracteres: pinta un dibujo hecho de caracteres
	ld c,a			;98d4
	ld a,(0cdcch)		;98d5   ; con una salida, los dibujos 0x1C mas alla
	or a			;98d8
	ld a,000h		;98d9
	jr z,L_98DF		;98db
	ld a,01ch		;98dd
L_98DF:
	add a,c			;98df
	jp dibujo_de_caracteres		;98e0   ; dibujo_de_caracteres: pinta un dibujo hecho de caracteres
sprites_de_la_vista:		; los sprites de lo que hay delante
	ld b,003h		;98e3   ; las tres cosas de 0xCDC9: sus sprites
	ld hl,0cdc9h		;98e5
	ld c,000h		;98e8
L_98EA:
	ld a,(hl)			;98ea   ; las tres casillas de delante
	or a			;98eb
	push hl			;98ec
	push bc			;98ed
	call nz,sprite_de_lo_de_delante		;98ee   ; sprite_de_lo_de_delante: el sprite de lo que hay en la casilla C
	pop bc			;98f1
	pop hl			;98f2
	inc c			;98f3   ; C = cual
	inc hl			;98f4
	djnz L_98EA		;98f5
	ret			;98f7
sprite_de_lo_de_delante:		; el sprite de lo que hay en la casilla C
	cp 006h		;98f8   ; la 1 y la 6 no llevan
	ret z			;98fa
	dec a			;98fb   ; 2-5: lo que hay
	ret z			;98fc
	dec a			;98fd
	ld de,09953h		;98fe   ; su ficha (0x9953, por cosa y por sitio): [y][x], el primer sprite, cuantos...
	call 0447ch		;9901   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld a,c			;9904   ; y segun lo lejos que este
	call 0447ch		;9905   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;9908
	ld e,(hl)			;9909
	inc hl			;990a
	ld d,(hl)			;990b
	inc hl			;990c
	ex de,hl			;990d
	ld (0cdcfh),hl		;990e   ; 0xCDCF/0xCDD0: [y][x]
	ld a,(de)			;9911
	inc de			;9912
	ld (0cdd1h),a		;9913   ; el primer sprite
	ld hl,0ee00h		;9916
	call 04083h		;9919   ; hl_mas_a: HL += A
	ld a,(de)			;991c   ; cuantos
	inc de			;991d
	ld b,a			;991e
L_991F:
	ld a,(0cdcfh)		;991f   ; la y
	ld (hl),a			;9922
	inc hl			;9923
	ld a,(0cdd0h)		;9924   ; la x
	ld (hl),a			;9927
	inc hl			;9928
	ld a,(de)			;9929   ; el patron
	inc de			;992a
	ld (hl),a			;992b
	inc hl			;992c
	inc hl			;992d
	push hl			;992e
	ld a,(0cdd1h)		;992f   ; sus 16 lineas de color, en 0xEC00 + 4 * hueco...
	ld l,a			;9932
	ld h,000h		;9933
	add hl,hl			;9935
	add hl,hl			;9936
	push de			;9937
	ld de,0ec00h		;9938
	add hl,de			;993b
	pop de			;993c
	ld a,(de)			;993d   ; ... del color de la ficha
	inc de			;993e
	push bc			;993f
	ld b,010h		;9940
L_9942:
	ld (hl),a			;9942
	inc hl			;9943
	djnz L_9942		;9944
	pop bc			;9946
	pop hl			;9947
	ld a,(0cdd1h)		;9948   ; el sprite siguiente
	add a,004h		;994b
	ld (0cdd1h),a		;994d
	djnz L_991F		;9950
	ret			;9952

; ----------------------------------------------------------------------
; DATOS dibujos_de_lo_que_se_vende: tabla en dos niveles: 4 punteros (tienda
;   2-5, p02:98FE) a grupos de 3 punteros de la misma tabla (una por cosa a la
;   venta, p02:9904), que apuntan a su ficha de sprites (32 bytes)
;   0x9953..0x9973  (32 bytes)
DATA_dibujos_de_lo_que_se_vende:
	defb 05bh,099h	; 9953
	defb 061h,099h	; 9955
	defb 067h,099h	; 9957
	defb 06dh,099h	; 9959
	defb 089h,099h	; 995b
	defb 07dh,099h	; 995d
	defb 073h,099h	; 995f
	defb 0afh,099h	; 9961
	defb 0a1h,099h	; 9963
	defb 095h,099h	; 9965
	defb 0d7h,099h	; 9967
	defb 0cbh,099h	; 9969
	defb 0bfh,099h	; 996b
	defb 0f3h,099h	; 996d
	defb 0ebh,099h	; 996f
	defb 0e5h,099h	; 9971

; ----------------------------------------------------------------------
; DATOS fichas_de_lo_que_se_vende: 12 fichas: [y][x] de partida, el primer
;   sprite, [n] y n parejas [dibujo][color] (p02:990E-9950) (136 bytes)
;   0x9973..0x99fb  (136 bytes)
DATA_fichas_de_lo_que_se_vende:
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


dibujo_de_caracteres:		; pinta un dibujo hecho de caracteres
	push af			;99fb   ; el dibujo A (0xB91D, banco 9): [ancho], la posicion y los caracteres, del color 0x0E
	di			;99fc
	ld a,009h		;99fd
	ld (0a000h),a		;99ff   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;9a02   ; guarda la copia del banco de 0xA000
	ei			;9a05
	pop af			;9a06
	ld de,0b91dh		;9a07
	call 0447ch		;9a0a   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ex de,hl			;9a0d
	ld a,(hl)			;9a0e   ; [0] el ancho, a 0xEE80
	ld (0ee80h),a		;9a0f
	inc hl			;9a12
	ld e,(hl)			;9a13   ; [1-2] la posicion
	inc hl			;9a14
	ld d,(hl)			;9a15
	inc hl			;9a16
	ld c,00eh		;9a17   ; 14 filas
L_9A19:
	ld a,(0ee80h)		;9a19   ; B = el ancho
	ld b,a			;9a1c
	push de			;9a1d
L_9A1E:
	push hl			;9a1e
	ld a,(hl)			;9a1f   ; el caracter n de la pagina 1: x = (n mod 32) * 8, y = (n / 32) * 8
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
	call 04ef1h		;9a2e   ; el caracter, de la pagina 1 a la 0 (LMMM IMP)
	pop bc			;9a31
	pop hl			;9a32
	inc hl			;9a33
	ld a,008h		;9a34   ; 8 a la derecha
	add a,d			;9a36
	ld d,a			;9a37
	djnz L_9A1E		;9a38
	pop de			;9a3a
	ld a,008h		;9a3b   ; la fila siguiente; 14 filas
	add a,e			;9a3d
	ld e,a			;9a3e
	dec c			;9a3f
	jr nz,L_9A19		;9a40
	call 04206h		;9a42   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ret			;9a45
L_9A46:
	call 067b3h		;9a46   ; la pantalla del final de la fase: fuera las figuras
	call 067dah		;9a49   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	xor a			;9a4c   ; 0xCD54 = 0, el paso; 0xCD11 = 1 mientras dure
	ld (0cd54h),a		;9a4d
	inc a			;9a50
	ld (0cd11h),a		;9a51
	ld a,010h		;9a54
	ld (0cd30h),a		;9a56
	ld de,09d26h		;9a59   ; 0xCD50 = 0x9D26 y 0xCD55 = 4
	ld (0cd50h),de		;9a5c
	ld a,004h		;9a60
	ld (0cd55h),a		;9a62
	call sprites_del_final_de_fase		;9a65   ; sprites y colores
	call colores_del_final_de_fase		;9a68   ; colores_del_final_de_fase: los colores de 0xEC80
	ld de,09b14h		;9a6b   ; los 4 sprites del jugador: Goemon (0x9B14) o Ebisumaru (0x9B24)
	ld a,(0c002h)		;9a6e   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	add a,a			;9a71
	jr nc,L_9A77		;9a72
	ld de,09b24h		;9a74
L_9A77:
	ld hl,0ee00h		;9a77   ; 16 bytes de sprites a la copia
	ld b,010h		;9a7a
L_9A7C:
	ld a,(de)			;9a7c
	inc de			;9a7d
	ld (hl),a			;9a7e
	inc hl			;9a7f
	djnz L_9A7C		;9a80
	ld hl,000c0h		;9a82   ; tres trozos del dibujo de (x, 0xC0) de la pagina 1 a la 0, con TIMP
	ld de,06070h		;9a85
	ld bc,00c10h		;9a88
	call timp_de_la_pagina_1		;9a8b   ; timp_de_la_pagina_1: LMMM con TIMP de la pagina 1 a la 0
	ld hl,010c0h		;9a8e
	ld de,09070h		;9a91
	ld bc,00810h		;9a94
	call timp_de_la_pagina_1		;9a97   ; timp_de_la_pagina_1: LMMM con TIMP de la pagina 1 a la 0
	ld hl,018c0h		;9a9a
	ld de,07070h		;9a9d
	ld bc,02010h		;9aa0
	call timp_de_la_pagina_1		;9aa3   ; timp_de_la_pagina_1: LMMM con TIMP de la pagina 1 a la 0
	ld a,012h		;9aa6   ; y la figura 0x12
	jp crea_por_tipo		;9aa8   ; crea_por_tipo: crea la figura de tipo A segun su tabla
timp_de_la_pagina_1:		; LMMM con TIMP de la pagina 1 a la 0
	ld a,048h		;9aab
	jp 04803h		;9aad   ; lmmm: orden LMMM del V9938: copia un rectangulo con operacion logica
sprites_del_final_de_fase:		; 8 sprites de 0x9AF4
	ld hl,0ee20h		;9ab0   ; 8 sprites de 0x9AF4 a la copia (desde el 8)
	ld de,09af4h		;9ab3
	ld b,020h		;9ab6
L_9AB8:
	ld a,(de)			;9ab8   ; B bytes de DE a HL
	inc de			;9ab9
	ld (hl),a			;9aba
	inc hl			;9abb
	djnz L_9AB8		;9abc
	ret			;9abe
cuatro_sprites:		; 4 sprites de 0x9B04
	ld hl,0ee10h		;9abf   ; 4 sprites de 0x9B04 (desde el 4)
	ld de,09b04h		;9ac2
	ld b,010h		;9ac5
	jr L_9AB8		;9ac7
colores_del_final_de_fase:		; los colores de 0xEC80
	ld hl,0ec80h		;9ac9   ; 64 x 2 lineas de color, 0x0D y 0x0E, desde 0xEC80
	ld b,040h		;9acc
L_9ACE:
	ld de,00d0eh		;9ace   ; dos colores: 0x0D y 0x0E
L_9AD1:
	ld (hl),d			;9ad1   ; D...
	inc hl			;9ad2
	ld (hl),e			;9ad3   ; ... y E
	inc hl			;9ad4
	djnz L_9AD1		;9ad5   ; B veces
	ret			;9ad7
colores_de_0xec40:		; los colores de 0xEC40
	ld hl,0ec40h		;9ad8   ; 32 x 2 desde 0xEC40
	ld b,020h		;9adb
	jr L_9ACE		;9add
fuera_ocho:		; fuera los 8 sprites desde el 8
	ld hl,0ee20h		;9adf   ; fuera los 8 sprites desde el 8
	ld b,008h		;9ae2
L_9AE4:
	ld (hl),0e0h		;9ae4   ; y = 0xE0: fuera
	inc hl			;9ae6
	inc hl			;9ae7
	inc hl			;9ae8
	inc hl			;9ae9
	djnz L_9AE4		;9aea
	ret			;9aec
fuera_cuatro:		; fuera los 4 sprites desde el 4
	ld hl,0ee10h		;9aed   ; fuera los 4 desde el 4
	ld b,004h		;9af0
	jr L_9AE4		;9af2

; ----------------------------------------------------------------------
; DATOS sprites_9AF4: 8 sprites [y][x][dibujo][color] que p02:9AB0 copia a
;   0xEE20 (32 bytes)
;   0x9af4..0x9b14  (32 bytes)
DATA_sprites_9AF4:
	defb 057h,0b8h,0d0h,000h	; 9af4
	defb 057h,0c8h,0d0h,000h	; 9af8
	defb 067h,0b8h,0d0h,000h	; 9afc
	defb 067h,0c8h,0d0h,000h	; 9b00
	defb 057h,028h,0d0h,000h	; 9b04
	defb 057h,038h,0d0h,000h	; 9b08
	defb 067h,028h,0d0h,000h	; 9b0c
	defb 067h,038h,0d0h,000h	; 9b10

; ----------------------------------------------------------------------
; DATOS sprites_9B14: dos tandas de 16 bytes (4 sprites [y][x][dibujo][color])
;   que p02:9A7C copia a 0xEE00: 0x9B14 para el jugador 1 y 0x9B24 para el 2
;   (p02:9A6B-9A74) (32 bytes)
;   0x9b14..0x9b34  (32 bytes)
DATA_sprites_9B14:
	defb 0b0h,078h,000h,000h	; 9b14
	defb 0c0h,078h,004h,000h	; 9b18
	defb 0c0h,078h,008h,000h	; 9b1c
	defb 0c0h,078h,00ch,000h	; 9b20
	defb 0b0h,078h,000h,000h	; 9b24
	defb 0c0h,078h,004h,000h	; 9b28
	defb 0b8h,078h,008h,000h	; 9b2c
	defb 0c0h,078h,00ch,000h	; 9b30

; ======================================================================
; CODIGO 0x9b34..0x9b3a  (6 bytes)
; ======================================================================


L_9B34:
	ld a,(0cd54h)		;9b34   ; el final de la fase, paso a paso (0xCD54, tabla de 0x9B3A)
	call 0408dh		;9b37   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9B3A: 6 destinos del despachador de 0x408D (call en p02:9B37):
;   0x9B46, 0x9B52, 0x9B66, 0x9B75, 0x9BA1, 0x9BB2; lo leen p02:9B37 (12
;   bytes)
;   0x9b3a..0x9b46  (12 bytes)
DATA_tabla_9B3A:
	defb 046h,09bh	; 9b3a
	defb 052h,09bh	; 9b3c
	defb 066h,09bh	; 9b3e
	defb 075h,09bh	; 9b40
	defb 0a1h,09bh	; 9b42
	defb 0b2h,09bh	; 9b44

; ======================================================================
; CODIGO 0x9b46..0x9c05  (191 bytes)
; ======================================================================


L_9B46:
	ld a,(0cd55h)		;9b46   ; paso 0: cuando 0xCD55 llega a 0, 32 cuadros
	or a			;9b49   ; espera
	ret nz			;9b4a
	ld a,020h		;9b4b
	ld (0cd56h),a		;9b4d
	jr L_9B61		;9b50
L_9B52:
	ld hl,0cd56h		;9b52   ; paso 1: al acabar, 64 cuadros, fuera los sprites y 0xCD55 + 1
	dec (hl)			;9b55
	ret nz			;9b56
	ld a,040h		;9b57   ; 64 cuadros
	ld (hl),a			;9b59
	call fuera_ocho		;9b5a   ; fuera_ocho: fuera los 8 sprites desde el 8
L_9B5D:
	ld hl,0cd55h		;9b5d   ; 0xCD55 + 1...
	inc (hl)			;9b60
L_9B61:
	ld hl,0cd54h		;9b61   ; ... y el paso siguiente
	inc (hl)			;9b64
	ret			;9b65
L_9B66:
	ld hl,0cd56h		;9b66   ; paso 2: 192 cuadros y la figura 0x1D
	dec (hl)			;9b69
	ret nz			;9b6a
	ld a,0c0h		;9b6b   ; 192 cuadros
	ld (hl),a			;9b6d
	ld a,01dh		;9b6e
	call crea_por_tipo		;9b70   ; crea_por_tipo: crea la figura de tipo A segun su tabla
	jr L_9B5D		;9b73
L_9B75:
	ld hl,0cd56h		;9b75   ; paso 3: 160 cuadros, el rotulo 0x0D...
	dec (hl)			;9b78
	ret nz			;9b79
	ld a,0a0h		;9b7a
	ld (hl),a			;9b7c
	ld hl,0cd54h		;9b7d
	inc (hl)			;9b80
	ld a,00dh		;9b81
	call 04280h		;9b83   ; rotulo_numero: pinta el rotulo A de la tabla de 0xA9C0 (banco 12)
	ld hl,03030h		;9b86   ; ... la caja del texto, (0x30, 0x30), 0xA0 x 0x18, del color 0x22...
	ld a,022h		;9b89
	ld d,000h		;9b8b
	ld bc,0a018h		;9b8d
	call 04732h		;9b90   ; hmmv: orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)
	ld hl,0cd57h		;9b93   ; ... y el texto, una letra cada 7 cuadros
	ld (hl),007h		;9b96
	call texto_de_la_fase		;9b98   ; texto_de_la_fase: HL = el texto del final de la fase
	ld de,03030h		;9b9b
	jp 042e1h		;9b9e   ; empieza_texto: empieza un texto letra a letra: HL el texto, DE el sitio (0xCD61-0xCD67)
L_9BA1:
	ld hl,0cd57h		;9ba1   ; paso 4: el texto, hasta que acaba (0xCD67)
	dec (hl)			;9ba4
	ret nz			;9ba5
	ld (hl),007h		;9ba6   ; 7 cuadros por letra
	call 042f1h		;9ba8   ; sigue_texto: saca la letra siguiente del texto de 0xCD65 (0xFF acaba)
	ld a,(0cd67h)		;9bab   ; 0xCD67 puesto: acabado
	or a			;9bae
	ret z			;9baf
	jr L_9B61		;9bb0
L_9BB2:
	ld hl,0cd56h		;9bb2   ; paso 5: la espera, y se acabo; 0xCD60 a cero
	dec (hl)			;9bb5
	ret nz			;9bb6
	xor a			;9bb7
	ld (0cd11h),a		;9bb8   ; sin texto en marcha
	ld (0cd60h),a		;9bbb
	ret			;9bbe
texto_de_la_fase:		; HL = el texto del final de la fase
	ld a,(0c288h)		;9bbf   ; el texto de la fase (0x9E0B): en la ultima, siempre el suyo...
	cp 006h		;9bc2   ; la fase 6, la ultima
	jr z,L_9BD1		;9bc4
	ld b,a			;9bc6
	ld a,(0cd60h)		;9bc7   ; ... y en las demas, si se le ha dado 8 veces o mas al tipo 0x21 (0xCD60, p03:A9D3), el de 0x9F92
	cp 008h		;9bca
	ld hl,09f92h		;9bcc
	ret nc			;9bcf   ; 8 o mas: HL = 0x9F92
	ld a,b			;9bd0
L_9BD1:
	add a,a			;9bd1   ; dos bytes por fase
	ld hl,09e0bh		;9bd2
	call 04083h		;9bd5   ; hl_mas_a: HL += A
	ld a,(hl)			;9bd8
	inc hl			;9bd9
	ld h,(hl)			;9bda   ; HL = el texto
	ld l,a			;9bdb
	ret			;9bdc
L_9BDD:
	ld de,03878h		;9bdd   ; crea la figura B en (0x78, 0x38)
	jp crea_figura		;9be0   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_29_sale:		; la figura de tipo 29 (0x1D): su arranque (tabla de p02:8427)
	call cuatro_sprites		;9be3   ; la figura del final: quieta, anda despacio a la derecha (0x80)
	call colores_de_0xec40		;9be6   ; colores_de_0xec40: los colores de 0xEC40
	xor a			;9be9
	ld (ix+00ch),a		;9bea
	ld (ix+00fh),a		;9bed
	ld de,00080h		;9bf0
	call pon_velocidad_x		;9bf3   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00000h		;9bf6
	call pon_velocidad_y		;9bf9   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	jp pon_la_pose		;9bfc   ; pon_la_pose: pone la pose de la figura
tipo_29:		; la figura de tipo 29 (0x1D), un cuadro (tabla de p02:871C)
	ld a,(ix+001h)		;9bff   ; segun su paso (0x9C05)
	call 0408dh		;9c02   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9C05: 4 destinos del despachador de 0x408D (call en p02:9C02):
;   0x9C0D, 0x9C3D, 0x9CA2, 0x9CC8; lo leen p02:9C02 (8 bytes)
;   0x9c05..0x9c0d  (8 bytes)
DATA_tabla_9C05:
	defb 00dh,09ch	; 9c05
	defb 03dh,09ch	; 9c07
	defb 0a2h,09ch	; 9c09
	defb 0c8h,09ch	; 9c0b

; ======================================================================
; CODIGO 0x9c0d..0x9d26  (281 bytes)
; ======================================================================


L_9C0D:
	ld b,072h		;9c0d   ; anda hasta x 0x80; alli se para, pose 0x74
	call pose_cada_8		;9c0f   ; pose_cada_8: la pose B o B + 1, cada 8 cuadros
	ld a,(ix+005h)		;9c12   ; lee la x de la figura
	cp 080h		;9c15
	ret c			;9c17
	inc (ix+001h)		;9c18   ; sube el paso en que va la figura
	ld (ix+00bh),020h		;9c1b
	ld de,00000h		;9c1f
	call pon_velocidad_x		;9c22   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	call pon_velocidad_y		;9c25   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_9C28:
	ld (ix+00ah),074h		;9c28   ; la pose de la figura = 0x74
L_9C2C:
	exx			;9c2c
	ld de,057c8h		;9c2d   ; la lista de colores de 0x57C8
L_9C30:
	exx			;9c30
	push ix		;9c31   ; HL = la figura
	pop hl			;9c33
	ld a,(ix+000h)		;9c34   ; lee el tipo de la figura
	ld (0cd37h),a		;9c37
	jp 05503h		;9c3a   ; los colores de sus sprites
L_9C3D:
	ld a,(0c288h)		;9c3d   ; parada: en la ultima fase, o sin haber dado 8 veces al tipo 0x21...
	cp 006h		;9c40
	jr z,L_9C65		;9c42
	ld a,(0cd60h)		;9c44
	cp 008h		;9c47
	jr c,L_9C65		;9c49
	dec (ix+00bh)		;9c4b   ; ... con 8 o mas: el efecto 0x20 y la pose 0x95, cada 13 cuadros
	ret nz			;9c4e
	ld (ix+00bh),00dh		;9c4f
	ld a,020h		;9c53
	call 04fe4h		;9c55   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call fuera_cuatro		;9c58   ; fuera_cuatro: fuera los 4 sprites desde el 4
	ld (ix+001h),003h		;9c5b   ; el paso en que va la figura = 0x03
	ld (ix+00ah),095h		;9c5f   ; la pose de la figura = 0x95
	jr L_9C2C		;9c63
L_9C65:
	dec (ix+00bh)		;9c65   ; si no, el efecto 0x0A y la pose 0x75, con otros patrones y colores, cada 32 cuadros
	ret nz			;9c68
	ld (ix+00bh),020h		;9c69   ; 32 cuadros
	ld a,00ah		;9c6d
	call 04fe4h		;9c6f   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call fuera_cuatro		;9c72   ; fuera los 4 sprites desde el 4
	inc (ix+001h)		;9c75   ; sube el paso en que va la figura
	ld (ix+00ah),075h		;9c78   ; la pose de la figura = 0x75
	ld (ix+025h),002h		;9c7c   ; los patrones de sus seis sprites (+0x25, +0x2A...)
	ld (ix+02ah),044h		;9c80
	ld (ix+02fh),001h		;9c84
	ld (ix+034h),042h		;9c88
	ld (ix+039h),001h		;9c8c
	ld (ix+03eh),042h		;9c90
	ld (ix+043h),041h		;9c94   ; y el de 0x43
	ld (ix+048h),042h		;9c98
	exx			;9c9c
	ld de,057d6h		;9c9d   ; la lista de colores de 0x57D6
	jr L_9C30		;9ca0
L_9CA2:
	dec (ix+00bh)		;9ca2   ; y vuelve a la pose de antes
	ret nz			;9ca5
	ld (ix+00bh),020h		;9ca6   ; 32 cuadros
	dec (ix+001h)		;9caa   ; baja el paso en que va la figura
	ld (ix+025h),001h		;9cad   ; los patrones de antes
	ld (ix+02ah),042h		;9cb1
	ld (ix+02fh),002h		;9cb5
	ld (ix+034h),044h		;9cb9
	ld (ix+039h),002h		;9cbd
	ld (ix+03eh),044h		;9cc1
	jp L_9C28		;9cc5
L_9CC8:
	dec (ix+00bh)		;9cc8   ; 13 cuadros y al paso 1
	ret nz			;9ccb
	ld (ix+00bh),00dh		;9ccc
	ld (ix+001h),001h		;9cd0   ; el paso en que va la figura = 0x01
	jp L_9C28		;9cd4
L_9CD7:
	push bc			;9cd7   ; crea cuatro figuras del tipo B
	call crea_figura		;9cd8   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
	pop bc			;9cdb
	push bc			;9cdc
	call crea_figura		;9cdd   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
	pop bc			;9ce0
	push bc			;9ce1
	call crea_figura		;9ce2   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
	pop bc			;9ce5
	jp crea_figura		;9ce6   ; crea_figura: crea una figura en el primer hueco libre de 0xC600
tipo_18_sale:		; la figura de tipo 18 (0x12): su arranque (tabla de p02:8427)
	ld a,(0cd30h)		;9ce9   ; cada una sale 64 cuadros despues que la anterior (0xCD30)
	ld (ix+00bh),a		;9cec   ; su espera
	add a,040h		;9cef
	ld (0cd30h),a		;9cf1
	ld (ix+00eh),001h		;9cf4   ; no se ve, no hace dano
	ld (ix+00ch),000h		;9cf8
	ld de,(0cd50h)		;9cfc   ; tres bytes de 0x9D26 para cada una: [y de llegada][lado][x]
	ld a,(de)			;9d00
	ld (ix+010h),a		;9d01   ; (ix+0x10) la y de llegada
	inc de			;9d04
	push de			;9d05
	ld a,(de)			;9d06
	ld (ix+00fh),a		;9d07   ; (ix+0x0F) el lado
	call pon_la_pose		;9d0a   ; pon_la_pose: pone la pose de la figura
	ld de,00000h		;9d0d   ; quieta
	call pon_velocidad_x		;9d10   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	call pon_velocidad_y		;9d13   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	pop de			;9d16
	inc de			;9d17
	ld a,(de)			;9d18   ; la x
	ld (ix+005h),a		;9d19   ; guarda la x de la figura
	ld (ix+003h),078h		;9d1c   ; todas en y 0x78
	inc de			;9d20
	ld (0cd50h),de		;9d21   ; la siguiente ficha, para la siguiente figura
	ret			;9d25

; ----------------------------------------------------------------------
; DATOS tres_por_cosa_9D26: cuatro tripletes que p02:9CFC va leyendo con
;   0xCD50 (p02:9A59 lo pone a 0x9D26 y 0xCD55 a 4): (ix+0x10), (ix+0x0F) y la
;   x (ix+5) (12 bytes)
;   0x9d26..0x9d32  (12 bytes)
DATA_tres_por_cosa_9D26:
	defb 0b0h,000h,0c8h	; 9d26
	defb 0b0h,001h,038h	; 9d29
	defb 090h,000h,0c8h	; 9d2c
	defb 090h,001h,038h	; 9d2f

; ======================================================================
; CODIGO 0x9d32..0x9d38  (6 bytes)
; ======================================================================


tipo_18:		; la figura de tipo 18 (0x12), un cuadro (tabla de p02:871C)
	ld a,(ix+001h)		;9d32   ; segun su paso (0x9D38)
	call 0408dh		;9d35   ; despacha: salta a la entrada A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9D38: 7 destinos del despachador de 0x408D (call en p02:9D35):
;   0x9D46, 0x9D67, 0x9D84, 0x9DA5, 0x9DAE, 0x9DD1, 0x9DAD; lo leen p02:9D35
;   (14 bytes)
;   0x9d38..0x9d46  (14 bytes)
DATA_tabla_9D38:
	defb 046h,09dh	; 9d38
	defb 067h,09dh	; 9d3a
	defb 084h,09dh	; 9d3c
	defb 0a5h,09dh	; 9d3e
	defb 0aeh,09dh	; 9d40
	defb 0d1h,09dh	; 9d42
	defb 0adh,09dh	; 9d44

; ======================================================================
; CODIGO 0x9d46..0x9e0b  (197 bytes)
; ======================================================================


L_9D46:
	dec (ix+00bh)		;9d46   ; al acabar la espera, anda (0x80) hacia su lado
	ret nz			;9d49
	inc (ix+001h)		;9d4a   ; sube el paso en que va la figura
	dec (ix+00eh)		;9d4d
	ld (ix+00bh),034h		;9d50
	ld de,00080h		;9d54
	bit 0,(ix+00fh)		;9d57
	call z,niega_de		;9d5b   ; niega_de: DE = -DE
	call pon_velocidad_x		;9d5e   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	ld de,00000h		;9d61
	jp pon_velocidad_y		;9d64   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
L_9D67:
	call pose_de_la_7e		;9d67   ; 52 cuadros; luego baja (0x80) y se arrima (0x20)
	dec (ix+00bh)		;9d6a
	ret nz			;9d6d
	inc (ix+001h)		;9d6e   ; sube el paso en que va la figura
	ld de,00080h		;9d71
	call pon_velocidad_y		;9d74   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	ld de,00020h		;9d77
	bit 0,(ix+00fh)		;9d7a
	call nz,niega_de		;9d7e   ; niega_de: DE = -DE
	jp pon_velocidad_x		;9d81   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
L_9D84:
	ld a,(0cd55h)		;9d84   ; hasta su y de llegada; entonces 0xCD55 - 1
	or a			;9d87
	jr z,L_9D98		;9d88   ; ya llegaron todas: quieta
	call pose_de_la_7e		;9d8a   ; anda
	ld a,(ix+003h)		;9d8d   ; lee la y de la figura
	cp (ix+010h)		;9d90
	ret c			;9d93
	ld hl,0cd55h		;9d94   ; llego
	dec (hl)			;9d97
L_9D98:
	ld de,00000h		;9d98
	call pon_velocidad_x		;9d9b   ; pon_velocidad_x: velocidad horizontal de la figura ((ix+8), (ix+9)) = DE
	call pon_velocidad_y		;9d9e   ; pon_velocidad_y: velocidad vertical de la figura ((ix+6), (ix+7)) = DE
	inc (ix+001h)		;9da1   ; sube el paso en que va la figura
	ret			;9da4
L_9DA5:
	ld a,(0cd55h)		;9da5   ; espera a que lleguen todas (0xCD55 = 0)
	or a			;9da8
	ret nz			;9da9
	inc (ix+001h)		;9daa   ; sube el paso en que va la figura
L_9DAD:
	ret			;9dad
L_9DAE:
	ld a,(0cd55h)		;9dae   ; con 0xCD55 = 1, la pose 0x76 + el lado
	dec a			;9db1   ; la ultima en llegar
	ret nz			;9db2
	inc (ix+001h)		;9db3   ; sube el paso en que va la figura
	ld (ix+025h),001h		;9db6   ; otros patrones
	ld (ix+02ah),042h		;9dba
	ld a,076h		;9dbe
	add a,(ix+00fh)		;9dc0
	ld (ix+00ah),a		;9dc3   ; guarda la pose de la figura
	exx			;9dc6
	ld de,057edh		;9dc7   ; y la lista de colores de 0x57ED
L_9DCA:
	exx			;9dca
	push ix		;9dcb   ; HL = la figura
	pop hl			;9dcd
	jp 05503h		;9dce
L_9DD1:
	ld a,(0cd55h)		;9dd1   ; con 0xCD55 = 2, la 0x78 + el lado
	cp 002h		;9dd4
	ret nz			;9dd6
	inc (ix+001h)		;9dd7   ; sube el paso en que va la figura
	ld (ix+025h),002h		;9dda   ; otros patrones
	ld (ix+02ah),044h		;9dde
	ld a,078h		;9de2
	add a,(ix+00fh)		;9de4
	ld (ix+00ah),a		;9de7   ; guarda la pose de la figura
	exx			;9dea
	ld de,057f3h		;9deb   ; y la lista de colores de 0x57F3
	jr L_9DCA		;9dee
pose_de_la_7e:		; la pose de (ix+0x7E), segun el lado
	ld a,(ix+07eh)		;9df0   ; la pose de (ix+0x7E) (2 mas si mira al otro lado), cambiando cada 8 cuadros
	bit 0,(ix+00fh)		;9df3
	jr z,L_9DFB		;9df7
	add a,002h		;9df9
L_9DFB:
	ld b,a			;9dfb
pose_cada_8:		; la pose B o B + 1, cada 8 cuadros
	ld a,(0c003h)		;9dfc   ; lee el contador de cuadros
	rrca			;9dff
	rrca			;9e00
	rrca			;9e01
	and 001h		;9e02
	add a,b			;9e04
	ld (ix+00ah),a		;9e05   ; guarda la pose de la figura
	jp L_8975		;9e08

; ----------------------------------------------------------------------
; DATOS textos_9E0B: 7 punteros, uno por fase (p02:9BD1), a textos que se
;   escriben con p00:42F1; con 0xCD60 a 8 o mas sale el de 0x9F92 (14 bytes)
;   0x9e0b..0x9e19  (14 bytes)
DATA_textos_9E0B:
	defb 019h,09eh	; 9e0b
	defb 049h,09eh	; 9e0d
	defb 082h,09eh	; 9e0f
	defb 0c0h,09eh	; 9e11
	defb 0e8h,09eh	; 9e13
	defb 022h,09fh	; 9e15
	defb 05ah,09fh	; 9e17

; ----------------------------------------------------------------------
; DATOS textos: los 8 textos de 0x9E0B y 0x9F92: caracteres, 0xFE baja una
;   fila, 0xE1-0xFD dejan hueco y 0xFF o 0xE0 acaban (433 bytes)
;   0x9e19..0x9fca  (433 bytes)
DATA_textos:
	defb 034h,046h,03bh,048h,000h,031h,05bh,05dh,043h,000h,03ch,058h,039h,043h,049h,0feh	; 9e19  4F;H.1[]C.<X9CI.
	defb 055h,066h,037h,000h,05bh,035h,05eh,03fh,064h,000h,039h,039h,05ah,000h,030h,056h	; 9e29  Uf7.[5^?d.99Z.0V
	defb 03fh,051h,0feh,055h,031h,000h,043h,048h,045h,000h,044h,058h,03eh,063h,064h,0ffh	; 9e39  ?Q.U1.CHE.DX>cd.
	defb 044h,058h,04dh,043h,063h,000h,034h,046h,03bh,049h,000h,033h,056h,031h,064h,0feh	; 9e49  DXMCc.4F;I.3V1d.
	defb 04fh,030h,038h,063h,03fh,000h,052h,05dh,03bh,063h,05fh,064h,000h,04dh,032h,04ah	; 9e59  O08c?.R];c_d.M2J
	defb 063h,045h,0feh,03fh,05dh,049h,063h,048h,000h,042h,042h,032h,040h,037h,063h,057h	; 9e69  cE.?]IcH.BB2@7cW
	defb 05ch,000h,043h,056h,03dh,058h,03eh,063h,0ffh,044h,058h,04dh,043h,063h,03ah,063h	; 9e79  \.CV=X>c.DXMCc:c
	defb 000h,05bh,058h,035h,05eh,03fh,043h,063h,064h,030h,053h,04eh,058h,064h,0feh,047h	; 9e89  .[X5^?Ccd0SNXd.G
	defb 05dh,037h,063h,049h,000h,04bh,053h,03ah,05dh,064h,04dh,063h,032h,033h,031h,04ah	; 9e99  ]7cI.KS:]dMc231J
	defb 000h,052h,0feh,038h,03ch,063h,058h,064h,000h,039h,032h,053h,037h,000h,049h,000h	; 9ea9  .R.8<cXd.92S7.I.
	defb 04eh,052h,058h,03eh,063h,064h,0ffh,031h,04eh,048h,000h,034h,046h,03bh,048h,039h	; 9eb9  NRX>cd.1NH.4F;H9
	defb 043h,049h,063h,042h,063h,0feh,05bh,03bh,052h,000h,051h,035h,063h,03ah,051h,03fh	; 9ec9  CIcBc.[;R.Q5c:Q?
	defb 064h,0feh,034h,049h,055h,032h,000h,044h,05dh,040h,05fh,05eh,042h,064h,0ffh,031h	; 9ed9  d.4IU2.D]@_^Bd.1
	defb 04eh,04eh,042h,063h,048h,05bh,03bh,049h,000h,031h,048h,044h,035h,048h,000h,034h	; 9ee9  NNBcH[;I.1HD5H.4
	defb 035h,03ch,063h,0feh,031h,053h,000h,035h,05bh,03ch,063h,042h,063h,000h,030h,05eh	; 9ef9  5<c.1S.5[<cBc.0^
	defb 03fh,064h,0feh,052h,05eh,043h,03bh,061h,04fh,05dh,048h,03fh,051h,048h,03dh,031h	; 9f09  ?d.R^C;aO]H?QH=1
	defb 03bh,063h,05ch,03ch,058h,03eh,063h,064h,0ffh,03bh,061h,04fh,05dh,048h,000h,037h	; 9f19  ;c\<X>cd.;aO]H.7
	defb 058h,03bh,04fh,000h,055h,066h,037h,000h,05bh,035h,05eh,03fh,064h,0feh,052h,032h	; 9f29  X;O.Uf7.[5^?d.R2
	defb 000h,044h,045h,052h,000h,031h,032h,042h,063h,044h,031h,064h,0feh,055h,031h,000h	; 9f39  .DER.12BcD1d.U1.
	defb 03dh,031h,03bh,063h,05ch,000h,053h,037h,03eh,037h,000h,03ch,058h,03eh,063h,064h	; 9f49  =1;c\.S7>7.<X>cd
	defb 0ffh,04ah,03ah,03bh,031h,048h,032h,064h,041h,031h,045h,039h,039h,04eh,042h,063h	; 9f59  .J:;1H2dA1E99NBc
	defb 036h,034h,05eh,03fh,035h,0feh,034h,046h,03bh,052h,000h,03dh,031h,040h,061h,032h	; 9f69  64^?5.4F;R.=1@a2
	defb 03bh,03fh,064h,0feh,034h,046h,03bh,048h,000h,03bh,05dh,038h,063h,05dh,000h,036h	; 9f79  ;?d.4F;H.;]8c].6
	defb 036h,031h,059h,055h,032h,03eh,063h,064h,0ffh,034h,046h,03bh,000h,05bh,03bh,048h	; 9f89  61YU2>cd.4F;.[;H
	defb 03dh,031h,03bh,063h,045h,038h,040h,05ch,041h,038h,058h,035h,064h,0feh,031h,031h	; 9f99  =1;cE8@\A8X5d.11
	defb 000h,043h,063h,036h,061h,032h,03fh,063h,064h,0feh,041h,036h,063h,048h,03ch,042h	; 9fa9  .Cc6a2?cd.A6cH<B
	defb 066h,03bh,063h,000h,034h,04dh,063h,033h,042h,034h,037h,035h,063h,031h,031h,064h	; 9fb9  f;c.4Mc3B475c11d
	defb 0ffh	; 9fc9

; ======================================================================
; CODIGO 0x9fca..0xa000  (54 bytes)
; ======================================================================


L_9FCA:
	xor a			;9fca   ; un tipo de figura: (ix+0x7F) = 0, (ix+0x1D) = 1 y su arranque
	ld (ix+07fh),a		;9fcb
	inc a			;9fce
	ld (ix+01dh),a		;9fcf
	call 0a067h		;9fd2   ; guarda_la_velocidad: la velocidad a (ix+0x79)-(ix+0x7C)
	call 0a028h		;9fd5
	call 0a954h		;9fd8   ; lado_segun_rumbo: el lado segun hacia donde anda
	jp pon_la_pose		;9fdb   ; pon_la_pose: pone la pose de la figura
L_9FDE:
	ld de,0a008h		;9fde   ; la curva de 0xA008: 32 cuadros, lo que se suma a la y en cada uno
	ld a,(ix+07fh)		;9fe1
	inc (ix+07fh)		;9fe4
	cp 020h		;9fe7
	jr nc,$+23		;9fe9
	call 04088h		;9feb   ; de_mas_a: DE += A
	ld a,(de)			;9fee
	add a,(ix+003h)		;9fef   ; le suma la y de la figura
	ld (ix+003h),a		;9ff2   ; guarda la y de la figura
	dec (ix+078h)		;9ff5
	ret nz			;9ff8
	ld a,(ix+077h)		;9ff9
	ld (ix+078h),a		;9ffc
	ret			;9fff
