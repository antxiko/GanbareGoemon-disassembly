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
	rla			;6000   ; sigue continuar (p00:5FF1): los puntos del jugador que juega
	jr nc,L_6006		;6001
	ld hl,0c25ah		;6003   ; apunta a los puntos del jugador 2 (BCD)
L_6006:
	xor a			;6006   ; a cero
	ld (hl),a			;6007
	inc l			;6008
	ld (hl),a			;6009
	inc l			;600a
	ld (hl),a			;600b
	ld (0c486h),a		;600c   ; y desde el principio de la zona: casilla 0, sin dinero...
	ld (0c281h),a		;600f   ; guarda la CASILLA de la zona
	ld (0c265h),a		;6012   ; guarda el DINERO (ryo, BCD)
	ld (0c266h),a		;6015
	ld (0c268h),a		;6018   ; guarda si ya entro en la zona
	ld hl,0c270h		;601b   ; ... sin ninguna de las cosas del marcador...
	ld b,00bh		;601e
L_6020:
	ld (hl),a			;6020
	inc l			;6021
	djnz L_6020		;6022
	inc l			;6024
	ld (hl),a			;6025
	call 08f7bh		;6026
	ld a,010h		;6029   ; ... y con la vida entera (0x10)
	ld (0c480h),a		;602b   ; guarda la vida maxima
	ld (0c481h),a		;602e   ; guarda la VIDA del jugador
	jp 05f60h		;6031   ; y al estado 4 por p00:5F60
estado_8:		; la zona pasada: su pantalla, el tiempo a puntos y la zona siguiente
	djnz L_605D		;6034   ; estado 8 (0xC282 puesto), paso 1
	ld a,(0c289h)		;6036   ; lee el juego de graficos de la zona
	cp 004h		;6039   ; en el juego de graficos 4, directo a entrar otra vez
	jr z,L_606B		;603b
	call 045d3h		;603d   ; la pantalla fija: dibujos, paleta, pantalla y texto
	call 045eeh		;6040   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 04babh		;6043
	call 04d63h		;6046
	call 051edh		;6049   ; monta_la_pantalla: monta en 0xD800 la pantalla de la casilla: 8 x 6 bloques de 4 x 4 caracteres
	call 0534eh		;604c   ; pinta_la_pantalla: pinta los caracteres de 0xD800 en la pantalla
	call 045e1h		;604f   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	call 0960ch		;6052   ; texto_de_la_zona: el texto de la zona
	ld a,08ch		;6055   ; la musica 0x0C
	call 04fe4h		;6057   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	jp 05e43h		;605a   ; siguiente_paso: pasa al paso siguiente (0xC001)
L_605D:
	djnz L_6073		;605d   ; paso 2: el texto...
	call 0963fh		;605f
	ld a,(0cd11h)		;6062   ; ... hasta que acaba (0xCD11) y no suena nada
	ld b,a			;6065
	ld a,(0c0abh)		;6066   ; lee los canales que suenan
	or b			;6069
	ret nz			;606a
L_606B:
	call 08f7bh		;606b
	ld a,004h		;606e   ; y vuelta al estado 4
	jp 05e2dh		;6070   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
L_6073:
	ld hl,(0c4b0h)		;6073   ; paso 0: la zona esta pasada; mientras quede tiempo, pasa a puntos (p01:650A)
	ld a,h			;6076   ; tiempo 0?
	or l			;6077
	jp nz,tiempo_a_puntos		;6078   ; tiempo_a_puntos: el tiempo que queda, a puntos: 10 por segundo
	ld hl,0c260h		;607b   ; a cero: una vida mas (el estado 4 quita una al entrar)...
	ld a,(hl)			;607e   ; las vidas + 1 en BCD
	add a,001h		;607f
	daa			;6081
	ld (hl),a			;6082
	ld hl,0c261h		;6083   ; ... 0xC261 + 1...
	ld a,(hl)			;6086   ; 0xC261 + 1 en BCD
	add a,001h		;6087
	daa			;6089
	ld (hl),a			;608a
	ld hl,0c280h		;608b   ; ... y la zona siguiente, desde la casilla 0
	inc (hl)			;608e   ; zona + 1
	inc hl			;608f
	xor a			;6090
	inc hl			;6091   ; 0xC282 = 0: ya no esta pasada
	ld (hl),a			;6092
	ld (0c28ah),a		;6093   ; sin salidas especiales
	ld (0c28ch),a		;6096
	jp 05e43h		;6099   ; siguiente_paso: pasa al paso siguiente (0xC001)
estado_9:		; se sale de la casilla
	ld a,(0c483h)		;609c   ; estado 9: se sale de la casilla
	and a			;609f
	jr nz,L_60CF		;60a0
	ld a,(0c283h)		;60a2   ; lado 5: p01:672F
	cp 005h		;60a5
	jr z,L_60B5		;60a7
	cp 006h		;60a9   ; lado 6: otra vez la paleta, las pantallas y la musica de la zona
	jr z,L_60BA		;60ab
	call sale_de_la_casilla		;60ad   ; lados 0-3: la casilla vecina
	call entra_en_la_casilla		;60b0   ; entra_en_la_casilla: monta y pinta la casilla con sus figuras
	jr L_60C6		;60b3
L_60B5:
	call entra_por_el_lado_5		;60b5   ; entra_por_el_lado_5: la casilla sin cosas fijas, con el jugador abajo en medio
	jr L_60C6		;60b8
L_60BA:
	call 04ce3h		;60ba   ; paleta_de_la_zona: pone la paleta del juego de graficos de la zona
	call 04295h		;60bd   ; pantallas_de_la_zona: descomprime las pantallas de la zona a 0xD000
	call entra_en_la_casilla		;60c0   ; entra_en_la_casilla: monta y pinta la casilla con sus figuras
	call 0416fh		;60c3   ; musica_de_la_zona: la musica del juego de graficos de la zona (tabla 0x4182)
L_60C6:
	xor a			;60c6   ; y vuelta al estado 5
	ld (0c283h),a		;60c7   ; guarda por donde se sale de la casilla (1-4 arriba, abajo, izquierda, derecha; 5 y 6 otros; 0 nada)
	ld a,005h		;60ca
	jp 05e2dh		;60cc   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
L_60CF:
	call tramo_siguiente		;60cf   ; desde un pasadizo
	jr L_60C6		;60d2
estado_0a:		; la pausa: F1 la quita, F2 al estado 0x0D, y se teclean las palabras
	ld a,(0c00eh)		;60d4   ; estado 0x0A: la pausa
	inc a			;60d7
	cp 02eh		;60d8   ; 0xC00E cuenta de 0 a 0x2D
	jr c,L_60DD		;60da
	xor a			;60dc
L_60DD:
	ld (0c00eh),a		;60dd
	call 049d2h		;60e0   ; lee_los_mandos: en partida: F1-F3 a 0xC00C/0xC00B y el mando 1 con el teclado a 0xC007/0xC006
	ld a,(0c00bh)		;60e3   ; F1 quita la pausa
	rra			;60e6
	jr c,L_60F9		;60e7
	rra			;60e9   ; sin F2, a teclear (las palabras de la pausa)
	jp nc,0bdf6h		;60ea   ; teclea_palabra: las palabras de la pausa: 5 letras, comparadas con las de 0xBE44 y 0xBE49
	ld a,(0c28ch)		;60ed   ; F2 con 0xC28C a cero: al estado 0x0D
	and a			;60f0
	jp nz,0bdf6h		;60f1   ; teclea_palabra: las palabras de la pausa: 5 letras, comparadas con las de 0xBE44 y 0xBE49
	ld a,00dh		;60f4
	jp 05e2dh		;60f6   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
L_60F9:
	xor a			;60f9   ; fuera la pausa: la musica sigue y al estado 5
	ld (0c008h),a		;60fa
	call quita_la_ventana		;60fd   ; quita_la_ventana: devuelve lo que tapaba la ventana de la pausa
	ld a,0feh		;6100
	call 04fe4h		;6102   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,005h		;6105
	jp 05e2dh		;6107   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
estado_0b:		; la fase pasada
	djnz L_6120		;610a   ; estado 0x0B, paso 1: la espera, con p03:BD57 cada 8 cuadros
	ld hl,0c004h		;610c   ; apunta a la espera del estado, en cuadros
	dec (hl)			;610f
	ld a,(hl)			;6110
	push af			;6111
	ld a,(0c003h)		;6112   ; lee el contador de cuadros
	and 007h		;6115
	call z,0bd57h		;6117   ; abre_la_puerta: un paso de la puerta que se abre
	pop af			;611a
	and a			;611b
	ret nz			;611c
	jp 05e43h		;611d   ; siguiente_paso: pasa al paso siguiente (0xC001)
L_6120:
	djnz L_6145		;6120   ; paso 2: la pantalla del final de la fase
	call 045d3h		;6122   ; borra_la_pantalla: borra la pantalla
	call 045eeh		;6125   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 08f7bh		;6128
	call 04bc5h		;612b
	call 04d72h		;612e
	call 051edh		;6131   ; monta_la_pantalla: monta en 0xD800 la pantalla de la casilla: 8 x 6 bloques de 4 x 4 caracteres
	call 0534eh		;6134   ; pinta_la_pantalla: pinta los caracteres de 0xD800 en la pantalla
	call 09a46h		;6137
	call 045e1h		;613a   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	ld a,08ah		;613d   ; la musica 0x0A
	call 04fe4h		;613f   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	jp 05e43h		;6142   ; siguiente_paso: pasa al paso siguiente (0xC001)
L_6145:
	djnz L_6168		;6145   ; paso 3: las figuras, hasta que acaba (0xCD11) y no suena nada
	call 09b34h		;6147
	call 0868eh		;614a   ; las_figuras: un cuadro de todas las figuras
	call 086fch		;614d   ; sprites_de_las_figuras: los sprites de las ocho de 0xC600
	call 08861h		;6150   ; copia_las_figuras: sprites de las ocho de 0xC600 a la copia de 0xEE20
	call 05b61h		;6153   ; sube_colores_de_sprite: la copia de 0xEC00-0xEE7F (colores y atributos de los sprites) a 0xF400
	ld a,(0cd11h)		;6156
	or a			;6159
	ret nz			;615a
	ld a,(0c0abh)		;615b   ; lee los canales que suenan
	and a			;615e
	ret nz			;615f
	ld a,0b4h		;6160   ; 180 cuadros de espera
	ld (0c004h),a		;6162   ; guarda la espera del estado, en cuadros
	jp 05e43h		;6165   ; siguiente_paso: pasa al paso siguiente (0xC001)
L_6168:
	djnz L_6192		;6168   ; paso 4: la fase siguiente
	ld hl,0c26ah		;616a   ; 0xC26A cuenta las fases pasadas
	inc (hl)			;616d
	ld hl,0c288h		;616e   ; apunta a la FASE (0-6)
	inc (hl)			;6171
	xor a			;6172   ; desde la zona 0
	ld (0c280h),a		;6173   ; guarda la ZONA (0-6)
	ld (0c28bh),a		;6176
	ld (0c28ch),a		;6179
	ld a,(hl)			;617c   ; con la 7 se acabo el juego: al estado 0x0F
	cp 007h		;617d
	jr nc,L_6186		;617f
	ld a,004h		;6181   ; si no, al 4
	jp 05e2dh		;6183   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
L_6186:
	ld hl,0c002h		;6186   ; sin el bit 6: fuera de partida
	ld a,(hl)			;6189
	and 0bfh		;618a
	ld (hl),a			;618c
	ld a,00fh		;618d
	jp 05e2dh		;618f   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
L_6192:
	call 05b61h		;6192   ; paso 0: un texto de p03:BD48 en (0x38, 0x80)...
	ld de,08038h		;6195
	ld hl,01e28h		;6198
	ld a,002h		;619b
	ld c,00fh		;619d
	call 0bd48h		;619f   ; prepara_la_puerta: los datos de la puerta que se abre
	ld a,004h		;61a2   ; ... el efecto 4 y 80 cuadros
	call 04fe4h		;61a4   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,050h		;61a7
	ld (0c004h),a		;61a9   ; guarda la espera del estado, en cuadros
	jp 05e43h		;61ac   ; siguiente_paso: pasa al paso siguiente (0xC001)
estado_0c:		; el menu del vecino (Game Master o Q*bert en la otra ranura)
	push bc			;61af   ; estado 0x0C: el menu del vecino
	call 049d2h		;61b0   ; lee_los_mandos: en partida: F1-F3 a 0xC00C/0xC00B y el mando 1 con el teclado a 0xC007/0xC006
	pop bc			;61b3
	djnz L_61E9		;61b4   ; paso 1
	ld a,(0c006h)		;61b6   ; los dos botones y arriba/abajo
	and 033h		;61b9
	ret z			;61bb
	and 003h		;61bc   ; arriba o abajo: p02:8096
	jp nz,08096h		;61be
	ld a,(0ef0bh)		;61c1   ; un boton: segun la opcion (0xEF0B)
	or a			;61c4
	jp nz,L_61CF		;61c5
	ld hl,00203h		;61c8   ; la 0: estado 3, paso 2 (la partida)
	ld (0c000h),hl		;61cb   ; guarda el estado (0xC000) y el paso (0xC001) de un tiron
	ret			;61ce
L_61CF:
	dec a			;61cf   ; la 1 y la 2, cada una con su texto en 0xEF02
	jr z,L_61DD		;61d0
	ld hl,0b8a8h		;61d2
	ld (0ef02h),hl		;61d5
	call opcion_2		;61d8   ; opcion_2: texto y numero (0xEF07) de la opcion 2
	jr L_61E6		;61db
L_61DD:
	ld hl,0b0a8h		;61dd
	ld (0ef02h),hl		;61e0
	call opcion_1		;61e3   ; opcion_1: texto y numero (0xEF05) de la opcion 1
L_61E6:
	jp 05e43h		;61e6   ; siguiente_paso: pasa al paso siguiente (0xC001)
L_61E9:
	djnz L_621E		;61e9   ; paso 2
	call 08040h		;61eb
	jr nz,L_61F3		;61ee
	jp cifra_del_menu		;61f0   ; cifra_del_menu: la cifra tecleada en el menu del vecino
L_61F3:
	ld a,(0ef0bh)		;61f3   ; la opcion...
	ld b,a			;61f6
	ld hl,0ef04h		;61f7   ; ... se apunta en 0xEF04
	or (hl)			;61fa
	ld (hl),a			;61fb
	ld a,(0ef15h)		;61fc   ; con una cifra tecleada (0xEF15)...
	or a			;61ff
	jr z,L_6214		;6200
	ld a,(0ef0eh)		;6202   ; ... D = el numero, A = la cifra
	ld d,a			;6205
	ld a,(0ef0fh)		;6206
	bit 0,b		;6209
	jr z,L_6219		;620b
	ld (0ef05h),a		;620d   ; el boton 1 en la opcion: 0xEF05 y 0xEF06
	ld a,d			;6210
	ld (0ef06h),a		;6211
L_6214:
	xor a			;6214   ; vuelta al paso 0
	ld (0c001h),a		;6215   ; guarda el paso del estado
	ret			;6218
L_6219:
	ld (0ef07h),a		;6219   ; si no, 0xEF07
	jr L_6214		;621c
L_621E:
	call menu_del_vecino		;621e   ; paso 0: el menu (p01:7F1A) y 0xEF08-0xEF16 a cero
	xor a			;6221
	ld hl,0ef08h		;6222   ; 0xEF08-0xEF16 a cero
	ld de,0ef09h		;6225
	ld bc,0000eh		;6228
	ld (hl),000h		;622b
	ldir		;622d
	jp 05e43h		;622f   ; siguiente_paso: pasa al paso siguiente (0xC001)
estado_0d:		; F2 en la pausa
	djnz L_6248		;6232   ; estado 0x0D (F2 en la pausa), paso 1: hasta que se vuelve a apretar F2
	call 049d2h		;6234   ; lee_los_mandos: en partida: F1-F3 a 0xC00C/0xC00B y el mando 1 con el teclado a 0xC007/0xC006
	ld a,(0c00bh)		;6237   ; lee F1-F3 recien apretadas (bits 0-2)
	rra			;623a
	rra			;623b
	ret nc			;623c
	call quita_la_contrasena		;623d   ; se quita y vuelta a la pausa
	call 04631h		;6240   ; sprites_dentro: enciende los sprites (bit 1 del registro 8 del VDP a cero)
	ld a,00ah		;6243
	jp 05e2dh		;6245   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
L_6248:
	call 04626h		;6248   ; paso 0: sin sprites, p01:6B5F y 0xC28C = 1 (F2 no vuelve a valer en esta pausa)
	call ensena_la_contrasena		;624b   ; ensena_la_contrasena: F2 en la pausa: la contrasena del sitio donde se esta
	ld a,001h		;624e
	ld (0c28ch),a		;6250
	jp 05e43h		;6253   ; siguiente_paso: pasa al paso siguiente (0xC001)
estado_0e:		; la contrasena
	djnz L_6276		;6256   ; estado 0x0E: la contrasena, paso 1
	call teclea_la_contrasena		;6258   ; teclea_la_contrasena: una letra mas de la contrasena; con 9, la deshace y mira la suma: carry al acabar, 0xEB82 = 1 si vale
	ret nc			;625b   ; hasta que se da por acabada (carry)
	ld a,(0eb82h)		;625c   ; 0xEB82 = 0: no es una contrasena normal; se mira si es una de las claves
	and a			;625f
	jp z,0be4eh		;6260   ; claves_secretas: las cuatro claves de 9 letras (0xBE8A) en vez de la contrasena
	ld a,040h		;6263   ; una contrasena buena: partida de un jugador...
	ld (0c002h),a		;6265   ; guarda las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	call 04351h		;6268   ; empieza_la_partida: la RAM de la partida a cero desde 0xC25A, y vidas de 0x437B
	call prepara_la_partida		;626b   ; prepara_la_partida: letras, dibujos de siempre y la vida a 0x10
	call aplica_la_contrasena		;626e   ; ... con lo que dice la contrasena, y al estado 4
	ld a,004h		;6271
	jp 05e2dh		;6273   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
L_6276:
	call contrasena_en_blanco		;6276   ; paso 0: la pantalla de la contrasena y su rotulo en (0x60, 0x60)
	call 045d3h		;6279   ; borra_la_pantalla: borra la pantalla
	ld c,0ffh		;627c
	ld hl,0628ah		;627e
	ld de,06060h		;6281
	call 048fdh		;6284   ; rotulo_sin_posicion: pinta el texto de HL en DE (D = x, E = y), sin [x][y] delante; C = 0 borra
	jp 05e43h		;6287   ; siguiente_paso: pasa al paso siguiente (0xC001)

; ----------------------------------------------------------------------
; DATOS rotulo_628A: rotulo sin posicion delante (0x48FD); lo leen p01:6284 (8
;   bytes)
;   0x628a..0x6292  (8 bytes)
DATA_rotulo_628A:
	defb 030h,05dh,039h,063h,032h,049h,067h,0ffh	; 628a  0]9c2Ig.

; ======================================================================
; CODIGO 0x6292..0x636c  (218 bytes)
; ======================================================================


estado_0f:		; el final del juego
	djnz L_62CA		;6292   ; estado 0x0F: el final del juego, paso 1
	di			;6294
	ld a,00ch		;6295   ; el banco 12: el texto del final
	ld (0a000h),a		;6297   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;629a   ; guarda la copia del banco de 0xA000
	ei			;629d
	ld a,(0c003h)		;629e   ; una letra cada 4 cuadros
	and 003h		;62a1
	call z,042f1h		;62a3   ; sigue_texto: saca la letra siguiente del texto de 0xCD65 (0xFF acaba)
	call 04206h		;62a6   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ld a,(0c0abh)		;62a9   ; al acabar la musica, la ultima pantalla: sprites y la musica 0x0F
	and a			;62ac
	ret nz			;62ad
	call 045eeh		;62ae   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 045d3h		;62b1   ; borra_la_pantalla: borra la pantalla
	call 04cd4h		;62b4   ; patrones_del_final: los patrones de sprite de 0xBE32 (banco 6) a 0xF800
	call sprites_del_final		;62b7   ; sprites_del_final: los 16 sprites de la ultima pantalla
	call 05b61h		;62ba   ; sube_colores_de_sprite: la copia de 0xEC00-0xEE7F (colores y atributos de los sprites) a 0xF400
	call 045e1h		;62bd   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	ld a,08fh		;62c0
	call 04fe4h		;62c2   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,03ch		;62c5   ; 60 cuadros
	jp 05e40h		;62c7   ; espera_y_sigue: A cuadros de espera y el paso siguiente
L_62CA:
	djnz L_62E5		;62ca   ; paso 2: cuando acaba la musica y la espera...
	ld a,(0c0abh)		;62cc   ; lee los canales que suenan
	and a			;62cf
	ret nz			;62d0
	ld hl,0c004h		;62d1   ; apunta a la espera del estado, en cuadros
	dec (hl)			;62d4
	ret nz			;62d5
	call 045d3h		;62d6   ; borra_la_pantalla: borra la pantalla
	ld hl,0c002h		;62d9   ; ... fuera de partida, y al estado 0
	res 6,(hl)		;62dc
	ld hl,00000h		;62de
	ld (0c000h),hl		;62e1   ; guarda el estado (0xC000) y el paso (0xC001) de un tiron
	ret			;62e4
L_62E5:
	call texto_del_final		;62e5   ; paso 0: el texto del final, montado en 0xD800...
	call 045d3h		;62e8   ; borra_la_pantalla: borra la pantalla
	ld de,02010h		;62eb   ; ... se escribe desde (0x20, 0x10)...
	ld hl,0d800h		;62ee
	call 042e1h		;62f1   ; empieza_texto: empieza un texto letra a letra: HL el texto, DE el sitio (0xCD61-0xCD67)
	ld a,08dh		;62f4   ; ... con la musica 0x0D; 240 cuadros
	call 04fe4h		;62f6   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,0f0h		;62f9
	jp 05e40h		;62fb   ; espera_y_sigue: A cuadros de espera y el paso siguiente
tras_el_titulo:		; en los estados 0-2: una tecla salta al titulo, o en el menu elige
	call 049eeh		;62fe   ; despues de los estados 0-2: el mando y el teclado a 0xC251/0xC250
	ld hl,0c251h		;6301
	call 049e7h		;6304   ; apretado_y_nuevo: guarda A en (HL) y en (HL-1) lo que no estaba apretado antes
	or a			;6307   ; sin nada nuevo apretado, nada
	ret z			;6308
	ld hl,0c004h		;6309   ; algo apretado: fuera la espera
	ld (hl),000h		;630c
	ld l,(hl)			;630e   ; HL = 0xC000, B = el estado
	ld de,0c252h		;630f
	ld b,(hl)			;6312
	djnz L_6341		;6313   ; en el estado 1 (el menu del titulo)...
	and 030h		;6315   ; ... sin boton: arriba o abajo cambian la opcion
	jr z,L_634B		;6317
	and 020h		;6319   ; el segundo boton: a la contrasena (estado 0x0E)
	jr nz,L_6355		;631b
	ld a,(de)			;631d   ; el primero: la partida; con la opcion 1, la de dos jugadores (bit 5)
	or a			;631e
	ld a,040h		;631f
	jr z,L_6325		;6321
	ld a,060h		;6323
L_6325:
	ld (0c002h),a		;6325   ; guarda las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	push hl			;6328   ; dos jugadores: los dos
	ld hl,0c257h		;6329   ; los puntos de los dos a cero
	ld de,0c258h		;632c
	ld bc,00005h		;632f
	ld (hl),000h		;6332
	ldir		;6334
	pop hl			;6336
	ld (hl),003h		;6337   ; estado 3, paso 0
	inc hl			;6339   ; C = 0: borrar
	ld c,000h		;633a   ; y la marca de la opcion, fija
	ld (hl),c			;633c
	dec c			;633d   ; C = 0xFF: pintar
	jp 04462h		;633e
L_6341:
	ld (hl),001h		;6341   ; en los estados 0 y 2, se salta al titulo (estado 1)
	ld a,000h		;6343
	call 04fe4h		;6345   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	jp 05a93h		;6348   ; pantalla_del_titulo: pinta el titulo: dibujo de 20 x 12, 23 sprites, el marco y el menu
L_634B:
	ld a,(de)			;634b   ; la otra opcion
	xor 001h		;634c
	ld (de),a			;634e   ; la opcion escogida
	ld hl,0ef81h		;634f   ; y 0xEF81 cuenta las veces que se cambia (p00:5EB6 la mira al entrar en la zona)
	ld a,(hl)			;6352   ; A = las de antes
	inc (hl)			;6353
	ret			;6354
L_6355:
	ld a,00eh		;6355
	jp 05e2dh		;6357   ; cambia_de_estado: pasa al estado A, paso 0, con 0x20 cuadros de espera
ventana_de_la_pausa:		; la ventana con el texto de la pausa
	ld hl,06a54h		;635a   ; la ventana de la pausa en (0x6A, 0x54), de 44 x 16...
	ld bc,02c10h		;635d
	ld de,0d070h		;6360
	call ventana		;6363   ; ventana: guarda en la pagina 1 el rectangulo de (H, L), B x C, lo borra y le pone marco
	ld hl,0636ch		;6366   ; ... y su texto
	jp 048f3h		;6369   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba

; ----------------------------------------------------------------------
; DATOS rotulo_636C: rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p01:6369 (8 bytes)
;   0x636c..0x6374  (8 bytes)
DATA_rotulo_636C:
	defb 06eh,058h,031h,05eh,04bh,062h,037h,0ffh	; 636c  nX1^Kb7.

; ======================================================================
; CODIGO 0x6374..0x639b  (39 bytes)
; ======================================================================


quita_la_ventana:		; devuelve lo que tapaba la ventana de la pausa
	ld de,06a54h		;6374   ; quita la ventana: vuelve lo que habia debajo, de (0xD0, 0x70) de la pagina 1
	ld bc,02c10h		;6377
	ld hl,0d070h		;637a
	ld a,001h		;637d
	jp 0476eh		;637f   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
ventana:		; guarda en la pagina 1 el rectangulo de (H, L), B x C, lo borra y le pone marco
	ld a,004h		;6382   ; guarda el fondo en la pagina 1 (pagina 0 a la 1)...
	push hl			;6384
	push bc			;6385
	call 0476eh		;6386   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
	pop bc			;6389
	pop hl			;638a
	push hl			;638b
	push bc			;638c
	xor a			;638d   ; ... lo borra...
	ld d,a			;638e
	call 04732h		;638f   ; hmmv: orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)
	pop bc			;6392
	pop hl			;6393
	ld d,b			;6394   ; ... y le pone el marco, del color 0x0E
	ld e,c			;6395
	ld c,00eh		;6396
	jp 04704h		;6398   ; marco: pinta un marco: (H, L), D de ancho, E de alto, color C

; ----------------------------------------------------------------------
; DATOS rotulo_639B: rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); se solapan 2 bloques (0x639B-0x63D8, 0x63CB-0x63D8); lo
;   leen p00:5B06, p00:5E5E (61 bytes)
;   0x639b..0x63d8  (61 bytes)
DATA_rotulo_639B:
	defb 050h,010h,069h,02ah,02bh,02ch,02dh,02eh,02fh,000h,021h,029h,028h,027h,0feh,048h	; 639b  P.i*+,-./.!)('.H
	defb 098h,043h,063h,05eh,040h,042h,063h,000h,030h,03eh,04ah,063h,04eh,05eh,035h,067h	; 63ab  .Cc^@Bc.0>JcN^5g
	defb 0feh,058h,0a8h,04ah,043h,057h,042h,063h,000h,035h,063h,05dh,049h,063h,058h,0feh	; 63bb  .X.JCWBc.5c]IcX.
	defb 058h,0b0h,04bh,03fh,057h,042h,063h,000h,03fh,048h,03bh,050h,0ffh	; 63cb  X.K?WBc.?H.P.

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


logotipo_de_konami:		; prepara el logotipo de Konami en la pagina 1
	call 045eeh		;643f   ; estado 0, paso 0: el logotipo de Konami
	ld hl,06476h		;6442   ; su paleta
	call 04666h		;6445   ; pon_paleta: pone una lista de colores en la paleta
	ld b,00fh		;6448   ; el registro 7 (el borde) a 0x0F
	ld c,007h		;644a
	call 00047h		;644c   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,02840h		;644f   ; (0x28, 0x40) de la pagina 1, 0xA8 x 0x48, a cero...
	ld bc,0a848h		;6452
	xor a			;6455
	ld d,001h		;6456
	call 04732h		;6458   ; hmmv: orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)
	call 04a43h		;645b   ; ... y alli se monta el logotipo
	ld de,04040h		;645e
	ld hl,064c9h		;6461
	call cartel		;6464   ; cartel: caracteres de HL en DE de la pagina 1; 0xFE [dx] baja, 0xFF acaba
	call 045e1h		;6467   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	ld hl,0c480h		;646a   ; las variables de la vida valen aqui de cuentas: 0xC480 los cuadros...
	ld (hl),03ch		;646d   ; ... 0xC481 las lineas que faltan (49)...
	inc hl			;646f
	ld (hl),031h		;6470   ; ... y 0xC482 = 0, aun no se acabo
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


destapa_el_logotipo:		; una linea mas del logotipo cada dos cuadros; al acabar, 0xC482 = 1
	ld hl,0c480h		;6486   ; estado 0, paso 1: cada dos cuadros...
	dec (hl)			;6489
	ld a,(hl)			;648a
	and 001h		;648b
	ret nz			;648d
	inc hl			;648e
	dec (hl)			;648f   ; ... una linea mas del logotipo
	jr nz,L_6498		;6490
	ld a,001h		;6492   ; todas: 0xC482 = 1, acabado
	ld (0c482h),a		;6494   ; guarda la pantalla especial
	ret			;6497
L_6498:
	ld a,031h		;6498   ; las lineas que ya se ven...
	sub (hl)			;649a
	ld c,a			;649b
	ld b,0a8h		;649c
	ld hl,02840h		;649e   ; ... se copian de la pagina 1 a la 0: el logotipo sale de arriba abajo
	ld de,02840h		;64a1
	ld a,001h		;64a4
	jp 0476eh		;64a6   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
cartel:		; caracteres de HL en DE de la pagina 1; 0xFE [dx] baja, 0xFF acaba
	push de			;64a9   ; un cartel de caracteres: 0xFF acaba, 0xFE [dx] la fila siguiente
L_64AA:
	ld a,(hl)			;64aa   ; el caracter
	inc hl			;64ab
	ld c,a			;64ac
	inc a			;64ad   ; 0xFF: acaba
	jr z,L_64C7		;64ae
	inc a			;64b0   ; 0xFE: la fila siguiente
	jr nz,L_64BE		;64b1
	pop de			;64b3
	ld a,(hl)			;64b4   ; [dx]...
	inc hl			;64b5
	add a,d			;64b6
	ld d,a			;64b7
	ld a,008h		;64b8   ; ... y 8 mas abajo
	add a,e			;64ba
	ld e,a			;64bb
	jr cartel		;64bc
L_64BE:
	ld a,c			;64be   ; el caracter, en la pagina 1
	call 04964h		;64bf   ; caracter_en_la_pagina_1: pinta el caracter A de la pagina 1 en DE de la misma pagina
	call 04984h		;64c2   ; siguiente_sitio: D 8 puntos a la derecha; al dar la vuelta, E 8 mas abajo
	jr L_64AA		;64c5
L_64C7:
	pop de			;64c7   ; acabado
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


tiempo_a_puntos:		; el tiempo que queda, a puntos: 10 por segundo
	ld hl,0c4b1h		;650a   ; el tiempo que queda pasa a puntos: con centenas...
	ld a,(hl)			;650d   ; las centenas
	and a			;650e
	jr z,L_651E		;650f
	ld a,(0c003h)		;6511   ; ... cada 16 cuadros, 100 segundos menos y 1000 puntos (efecto 0x1D)
	and 00fh		;6514
	ret nz			;6516
	ld de,01000h		;6517   ; 1000 puntos (BCD: 10 en el byte del medio)
	ld b,01dh		;651a
	jr L_652A		;651c
L_651E:
	ld a,(0c003h)		;651e   ; sin centenas, cada 2 cuadros, 1 segundo menos y 10 puntos (efecto 0x1C)
	and 001h		;6521
	ret nz			;6523
	dec hl			;6524   ; las unidades y decenas
	ld de,00010h		;6525   ; 10 puntos
	ld b,01ch		;6528
L_652A:
	ld a,(hl)			;652a   ; un segundo (o 100) menos
	dec a			;652b
	daa			;652c
	ld (hl),a			;652d
	push bc			;652e
	push de			;652f
	call 058f5h		;6530   ; el tiempo...
	pop de			;6533
	call 0437eh		;6534   ; ... los puntos...
	pop bc			;6537
	ld a,b			;6538   ; ... y el efecto
	jp 04fe4h		;6539   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
texto_del_final:		; monta en 0xD800 el texto del final, uno de cuatro
	di			;653c
	ld a,00ch		;653d
	ld (0a000h),a		;653f   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6542   ; guarda la copia del banco de 0xA000
	ei			;6545
	ld a,(0ef00h)		;6546   ; el texto del final: uno de cuatro
	and a			;6549
	ld b,000h		;654a
	jr z,L_6550		;654c
	ld b,002h		;654e   ; con el vecino en la otra ranura, los dos de abajo
L_6550:
	ld a,(0c26ah)		;6550   ; con las 7 fases pasadas una a una (0xC26A = 7), el segundo de la pareja
	cp 007h		;6553
	ld a,000h		;6555
	jr nz,L_655A		;6557
	inc a			;6559   ; 1
L_655A:
	or b			;655a
	add a,a			;655b
	ld hl,06589h		;655c   ; la lista de frases (tabla de 0x6589)
	call 04d81h		;655f   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld b,(hl)			;6562   ; cuantas
	ld de,0d800h		;6563
	inc hl			;6566
L_6567:
	ld a,(hl)			;6567   ; cada frase, de la tabla de 0xBCD3 (banco 12): [largo] y las letras
	add a,a			;6568   ; 2 bytes por frase
	push bc			;6569
	push hl			;656a
	ld hl,0bcd3h		;656b
	call 04d81h		;656e   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld b,000h		;6571
	ld c,(hl)			;6573   ; C = el largo
	inc hl			;6574
	ldir		;6575   ; la frase, a 0xD800
	pop hl			;6577
	pop bc			;6578
	ld a,0feh		;6579   ; dos saltos de renglon detras de cada una
	ld (de),a			;657b
	inc de			;657c
	ld (de),a			;657d
	inc de			;657e
	inc hl			;657f   ; la siguiente
	djnz L_6567		;6580
	ld a,0ffh		;6582   ; y 0xFF al final
	dec de			;6584   ; el ultimo 0xFE se cambia por 0xFF
	ld (de),a			;6585
	jp 04206h		;6586   ; bancos_1_2_3: pone los bancos 1, 2 y 3

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


sprites_del_final:		; los 16 sprites de la ultima pantalla
	ld hl,065c7h		;65a2   ; los 16 sprites del final: [y][x][patron] de 0x65C7
	ld de,0ee00h		;65a5
	ld b,010h		;65a8
L_65AA:
	ld a,(hl)			;65aa   ; y
	ld (de),a			;65ab
	inc hl			;65ac
	inc de			;65ad
	ld a,(hl)			;65ae   ; x
	ld (de),a			;65af
	inc hl			;65b0
	inc de			;65b1
	ld a,(hl)			;65b2   ; patron
	ld (de),a			;65b3
	inc hl			;65b4
	inc de			;65b5
	inc de			;65b6   ; el color no
	djnz L_65AA		;65b7
	ld hl,0ec00h		;65b9   ; los 256 bytes de color, del 3
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


sale_de_la_casilla:		; 0xC281 = la casilla vecina por el lado de 0xC283 (enlaces de 0xE780)
	ld de,0e780h		;65f7   ; los cuatro enlaces de la casilla, en 0xE780 + casilla * 4
	ld a,(0c281h)		;65fa   ; lee la CASILLA de la zona
	add a,a			;65fd
	ld h,000h		;65fe
	ld l,a			;6600
	add hl,hl			;6601
	add hl,de			;6602
	ld de,0c283h		;6603   ; el lado (1-4), y se pone a cero
	ld a,(de)			;6606
	ld b,a			;6607
	xor a			;6608
	ld (de),a			;6609
	dec b			;660a   ; el enlace de ese lado
	ld a,b			;660b
	call 04083h		;660c   ; hl_mas_a: HL += A
	ld a,(hl)			;660f
	cp 0ffh		;6610   ; 0xFF: no hay casilla, se queda
	ret z			;6612
	ld (0c281h),a		;6613   ; guarda la CASILLA de la zona
	ret			;6616
enlaces_de_la_casilla:		; los cuatro enlaces de la casilla a 0xC284-0xC287
	ld de,0e780h		;6617
	ld a,(0c281h)		;661a   ; lee la CASILLA de la zona
	add a,a			;661d   ; 4 bytes por casilla
	ld h,000h		;661e
	ld l,a			;6620
	add hl,hl			;6621
	add hl,de			;6622
	ld de,0c284h		;6623   ; los cuatro enlaces de la casilla, a 0xC284-0xC287
	ld bc,00004h		;6626   ; los cuatro
	ldir		;6629
	ret			;662b
prepara_la_partida:		; letras, dibujos de siempre y la vida a 0x10
	call 04a6dh		;662c   ; letras_del_texto: sube las letras de los textos
	call 04da4h		;662f   ; dibujos_de_siempre: los dibujos de la pagina 1 que estan en todas las zonas (bancos 7 y 8)
	ld de,01010h		;6632   ; la vida y la vida maxima, 0x10
	ld (0c480h),de		;6635   ; guarda la vida maxima y el byte siguiente (16 bits)
	ret			;6639
carga_la_zona:		; carga la zona de 0xC280: graficos, pantallas, bloques, casillas, vida y tiempo, y entra en la casilla
	di			;663a
	ld a,009h		;663b   ; el banco 9
	ld (0a000h),a		;663d   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6640   ; guarda la copia del banco de 0xA000
	ei			;6643
	call 041f6h		;6644   ; indice_de_la_zona: A = (fase * 7 + zona) * 2
	srl a		;6647
	ld hl,0b8ech		;6649   ; el juego de graficos de la zona, de 0xB8EC
	call 04083h		;664c   ; hl_mas_a: HL += A
	ld a,(hl)			;664f
	ld (0c289h),a		;6650   ; guarda el juego de graficos de la zona
	call 04206h		;6653   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call 04da4h		;6656   ; dibujos_de_siempre: los dibujos de la pagina 1 que estan en todas las zonas (bancos 7 y 8)
	call 04a96h		;6659   ; caracteres_del_juego: sube los caracteres del juego de graficos de la zona
	ld hl,0d000h		;665c   ; 0xD000-0xE7FF a cero
	ld de,0d001h		;665f
	ld bc,017ffh		;6662
	ld (hl),000h		;6665
	ldir		;6667
	call 04d89h		;6669   ; sprites_de_0xF8C0: patrones de sprite de 0x9369 (banco 8) a 0xF8C0 y de 0x87D1 (banco 11) a 0xF900
	call 04295h		;666c   ; pantallas_de_la_zona: descomprime las pantallas de la zona a 0xD000
	call 042ach		;666f   ; bloques_de_la_zona: descomprime los bloques de la zona a 0xE100
	di			;6672
	ld a,009h		;6673
	ld (0a000h),a		;6675   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6678   ; guarda la copia del banco de 0xA000
	ei			;667b
	call pasadizos_de_la_zona		;667c   ; pasadizos_de_la_zona: los tramos y las puertas de los pasadizos de la zona, a 0xEA00, 0xEA80 y 0xEB00
	call 04206h		;667f   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call esconde_los_sprites_de_ram		;6682   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	call borra_al_jugador		;6685   ; borra_al_jugador: los 0x60 bytes del jugador (0xC490) a cero
	call borra_las_figuras		;6688   ; borra_las_figuras: el tipo a 0 en las ocho fichas de 0xC600 y las ocho de 0xCA00
	ld hl,0c268h		;668b   ; la primera vez en la zona...
	ld a,(hl)			;668e
	and a			;668f
	jr nz,L_66BC		;6690
	inc (hl)			;6692
	di			;6693
	ld a,009h		;6694
	ld (0a000h),a		;6696   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6699   ; guarda la copia del banco de 0xA000
	ei			;669c
	call 041f6h		;669d   ; indice_de_la_zona: A = (fase * 7 + zona) * 2
	srl a		;66a0
	ld hl,0b8afh		;66a2   ; ... la casilla de entrada, de 0xB8AF...
	call 04083h		;66a5   ; hl_mas_a: HL += A
	ld a,(hl)			;66a8
	exx			;66a9
	ld hl,0c002h		;66aa   ; ... si se esta jugando (no en la demostracion)
	bit 6,(hl)		;66ad
	exx			;66af
	jr z,L_66B9		;66b0
	ld (0c281h),a		;66b2   ; guarda la CASILLA de la zona
	xor a			;66b5
	ld (0c267h),a		;66b6   ; guarda los colores del sitio
L_66B9:
	call 04206h		;66b9   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_66BC:
	call topes_del_juego		;66bc   ; topes_del_juego: pared y hoyos del juego de graficos, a 0xC4F0
	ld a,(0c480h)		;66bf   ; la vida llena
	ld (0c481h),a		;66c2   ; guarda la VIDA del jugador
	ld de,00700h		;66c5   ; 700 segundos
	ld (0c4b0h),de		;66c8   ; guarda el TIEMPO (BCD) y el byte siguiente (16 bits)
	ld a,001h		;66cc   ; el primero se cuenta enseguida
	ld (0c4b2h),a		;66ce
	ld a,(0c280h)		;66d1   ; en la zona 6, el dibujo de (0x00, 0x80) de la pagina 1 se copia a (0x30, 0x80)
	cp 006h		;66d4
	jr nz,L_66E6		;66d6
	ld de,03080h		;66d8
	ld hl,00080h		;66db
	ld bc,01010h		;66de
	ld a,005h		;66e1
	call 0476eh		;66e3   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
L_66E6:
	xor a			;66e6   ; 0xC0AF = 0
	ld (0c0afh),a		;66e7
	call 05311h		;66ea   ; las casillas y sus enlaces
	call 04188h		;66ed   ; enlaces_de_la_zona: copia los enlaces entre casillas de la zona a 0xE780
	call 0955ch		;66f0
	call las_del_tipo_14		;66f3   ; las_del_tipo_14: las cosas de tipo 0x14 de la zona a 0xC340; una al azar marcada
entra_en_la_casilla:		; monta y pinta la casilla con sus figuras
	call enlaces_de_la_casilla		;66f6   ; entra en la casilla: sus enlaces...
	call salidas_de_la_casilla		;66f9   ; salidas_de_la_casilla: 0xC520: la salida especial de la casilla (tabla 0xB5D6)
	call esconde_los_sprites_de_ram		;66fc   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	call borra_las_figuras		;66ff   ; borra_las_figuras: el tipo a 0 en las ocho fichas de 0xC600 y las ocho de 0xCA00
	call borra_las_de_0xcc00		;6702   ; borra_las_de_0xcc00: 0xCC00-0xCCFF a cero
	call las_dos_de_0xc4d3		;6705   ; las_dos_de_0xc4d3: p01:76AC con 0xC4D3 y con 0xC4E3
	call 045eeh		;6708   ; ... la pantalla...
	call 0460ah		;670b   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	call 051edh		;670e   ; monta_la_pantalla: monta en 0xD800 la pantalla de la casilla: 8 x 6 bloques de 4 x 4 caracteres
	call 0534eh		;6711   ; pinta_la_pantalla: pinta los caracteres de 0xD800 en la pantalla
	call 090c0h		;6714   ; ... las cosas fijas...
	call punto_de_entrada		;6717   ; punto_de_entrada: la primera vez en la zona, el jugador en el primer sitio de 0xB8E0 donde se puede pisar
	call 05413h		;671a   ; ... los dibujos de las figuras...
	call 05856h		;671d   ; pinta_las_cosas: pinta las cosas del marcador
	call 04ce3h		;6720   ; ... y los colores
	call 04d14h		;6723
	call 08656h		;6726
	call 08573h		;6729
	jp 045e1h		;672c   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
entra_por_el_lado_5:		; la casilla sin cosas fijas, con el jugador abajo en medio
	call esconde_los_sprites_de_ram		;672f   ; por el lado 5: la casilla de otra manera (sin las cosas fijas ni el marcador)
	call borra_las_figuras		;6732   ; borra_las_figuras: el tipo a 0 en las ocho fichas de 0xC600 y las ocho de 0xCA00
	call borra_las_de_0xcc00		;6735   ; borra_las_de_0xcc00: 0xCC00-0xCCFF a cero
	call las_dos_de_0xc4d3		;6738   ; las_dos_de_0xc4d3: p01:76AC con 0xC4D3 y con 0xC4E3
	call 045eeh		;673b   ; apaga_la_pantalla: bit 6 del registro 1 del VDP a cero
	call 0460ah		;673e   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	call 051edh		;6741   ; monta_la_pantalla: monta en 0xD800 la pantalla de la casilla: 8 x 6 bloques de 4 x 4 caracteres
	call 0534eh		;6744   ; pinta_la_pantalla: pinta los caracteres de 0xD800 en la pantalla
	call jugador_abajo_en_medio		;6747   ; el jugador en su sitio
	call 04d08h		;674a   ; la paleta de 0xA3FF
	call 0925dh		;674d
	call 045e1h		;6750   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
	jp 094f7h		;6753
punto_de_entrada:		; la primera vez en la zona, el jugador en el primer sitio de 0xB8E0 donde se puede pisar
	ld a,(0c268h)		;6756   ; solo la primera vez en la zona: el jugador en su punto de entrada
	and a			;6759
	ret z			;675a
	di			;675b   ; el banco 9
	ld a,009h		;675c
	ld (0a000h),a		;675e   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6761   ; guarda la copia del banco de 0xA000
	ei			;6764
	ld a,003h		;6765   ; mirando a la derecha (lado 3)
	ld (0c4a2h),a		;6767   ; guarda el lado al que mira el jugador
	ld b,006h		;676a   ; seis sitios posibles en 0xB8E0, [y][x]
L_676C:
	ld hl,0b8e0h		;676c
	ld a,b			;676f
	dec a			;6770   ; 2 bytes por sitio
	add a,a			;6771
	call 04083h		;6772   ; hl_mas_a: HL += A
	ld e,(hl)			;6775   ; E = y, D = x
	inc hl			;6776
	ld d,(hl)			;6777
	push bc			;6778
	push de			;6779
	call no_se_puede_estar		;677a   ; el primero (empezando por el ultimo) donde se puede pisar
	pop de			;677d
	pop bc			;677e
	jr nc,L_6783		;677f
	djnz L_676C		;6781   ; el anterior
L_6783:
	ld a,e			;6783   ; alli, el jugador y sus sprites
	ld (0c498h),a		;6784   ; guarda la y de los sprites del jugador
	ld (0c494h),a		;6787   ; guarda la y del jugador
	ld a,d			;678a
	ld (0c49ah),a		;678b   ; guarda la x de los sprites del jugador
	ld (0c496h),a		;678e   ; guarda la x del jugador
	xor a			;6791   ; ya ha entrado
	ld (0c268h),a		;6792   ; guarda si ya entro en la zona
	jp 04206h		;6795   ; bancos_1_2_3: pone los bancos 1, 2 y 3
jugador_abajo_en_medio:		; el jugador en (0x80, 0xB0); por el lado 6, solo la musica
	ld a,(0c283h)		;6798   ; por el lado 6, solo la musica
	cp 006h		;679b
	jr z,L_67B0		;679d
	ld a,0b0h		;679f   ; si no, el jugador en (0x80, 0xB0)
	ld (0c498h),a		;67a1   ; guarda la y de los sprites del jugador
	ld (0c494h),a		;67a4   ; guarda la y del jugador
	ld a,080h		;67a7
	ld (0c49ah),a		;67a9   ; guarda la x de los sprites del jugador
	ld (0c496h),a		;67ac   ; guarda la x del jugador
	ret			;67af
L_67B0:
	jp 0416fh		;67b0   ; musica_de_la_zona: la musica del juego de graficos de la zona (tabla 0x4182)
borra_las_figuras:		; el tipo a 0 en las ocho fichas de 0xC600 y las ocho de 0xCA00
	ld hl,0c600h		;67b3   ; las ocho fichas de 0xC600 (de 0x80)...
	ld de,00080h		;67b6
	ld b,008h		;67b9
	call tipo_a_cero		;67bb   ; las de 0xC600
	ld hl,0ca00h		;67be   ; ... y las ocho de 0xCA00 (de 0x40): el tipo a 0
	ld b,008h		;67c1
	ld de,00040h		;67c3
tipo_a_cero:		; el tipo a 0 en B fichas de DE en DE
	ld (hl),000h		;67c6   ; el tipo a 0
	add hl,de			;67c8   ; la siguiente
	djnz tipo_a_cero		;67c9
	ret			;67cb
borra_al_jugador:		; los 0x60 bytes del jugador (0xC490) a cero
	ld hl,0c490h		;67cc   ; los 0x60 bytes del jugador (0xC490-0xC4EF) a cero
	ld d,h			;67cf
	ld e,l			;67d0
	inc de			;67d1
	ld (hl),000h		;67d2
	ld bc,0005fh		;67d4   ; 0x60 bytes
	ldir		;67d7
	ret			;67d9
esconde_los_sprites_de_ram:		; y = 0xE0 en los 32 sprites de la copia de 0xEE00
	ld hl,0ee00h		;67da   ; la copia de los atributos de sprite (0xEE00): y = 0xE0 en los 32
	ld b,020h		;67dd
L_67DF:
	ld (hl),0e0h		;67df   ; y = 0xE0
	inc l			;67e1   ; 4 bytes por sprite
	inc l			;67e2
	inc l			;67e3
	inc l			;67e4
	djnz L_67DF		;67e5
	ret			;67e7
las_dos_de_0xc4d3:		; p01:76AC con 0xC4D3 y con 0xC4E3
	ld hl,0c4d3h		;67e8   ; las dos de 0xC4D3 y 0xC4E3
	call borra_lo_lanzado		;67eb   ; borra_lo_lanzado: sus 16 bytes a cero y su sprite fuera
	ld hl,0c4e3h		;67ee
	jp borra_lo_lanzado		;67f1   ; borra_lo_lanzado: sus 16 bytes a cero y su sprite fuera
borra_las_de_0xcc00:		; 0xCC00-0xCCFF a cero
	ld hl,0cc00h		;67f4   ; 0xCC00-0xCCFF a cero: las cuatro fichas de 0x40
	ld de,0cc01h		;67f7
	ld (hl),000h		;67fa
	ld bc,000ffh		;67fc   ; 256 bytes
	ldir		;67ff
	ret			;6801
cuadro_del_juego:		; un cuadro del juego: el jugador en los pares, las figuras en los impares
	call 05b09h		;6802   ; un cuadro del juego (estado 5) y de la demostracion
	ld a,(0cdb1h)		;6805   ; dentro del pasadizo secreto, solo F1 y p02:987A
	or a			;6808
	jr z,L_6815		;6809
	call 049d2h		;680b   ; lee_los_mandos: en partida: F1-F3 a 0xC00C/0xC00B y el mando 1 con el teclado a 0xC007/0xC006
	call f1_pausa		;680e   ; f1_pausa: F1 recien apretada: la pausa (0xC008 = 1) y carry
	ret c			;6811
	jp 0987ah		;6812
L_6815:
	ld a,(0c003h)		;6815   ; los cuadros pares, una mitad; los impares, la otra
	rra			;6818
	jr c,L_685F		;6819
	ld hl,0c00dh		;681b   ; 0xC00D cuenta los cuadros pares
	inc (hl)			;681e
	call 049d2h		;681f   ; lee_los_mandos: en partida: F1-F3 a 0xC00C/0xC00B y el mando 1 con el teclado a 0xC007/0xC006
	ld a,(0c490h)		;6822   ; en el estado 3 del jugador F1 no vale
	cp 003h		;6825
	jr z,L_682D		;6827
	call f1_pausa		;6829   ; F1: la pausa
	ret c			;682c
L_682D:
	call 04cabh		;682d   ; el jugador: sus sprites, sus mandos y su movimiento
	call el_jugador		;6830   ; el_jugador: el jugador, un cuadro: mandos y su estado (tabla de 0x6D4C)
	call bordes		;6833   ; bordes: por los lados se sale de la casilla; puertas e interiores
	ld a,(0cdb1h)		;6836   ; en el pasadizo secreto o saliendo de la casilla, nada mas
	or a			;6839
	ret nz			;683a
	ld a,(0c283h)		;683b   ; lee por donde se sale de la casilla (1-4 arriba, abajo, izquierda, derecha; 5 y 6 otros; 0 nada)
	and a			;683e
	ret nz			;683f
	call el_golpe		;6840   ; el_golpe: el golpe del primer boton, o lanza algo con la cosa 1
	call mueve_al_jugador		;6843   ; mueve_al_jugador: posicion += velocidad
	di			;6846   ; el banco 9
	ld a,009h		;6847
	ld (0a000h),a		;6849   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;684c   ; guarda la copia del banco de 0xA000
	ei			;684f
	call sprites_del_jugador_de_ram		;6850   ; sprites_del_jugador_de_ram: la posicion y los patrones de sus sprites en la copia de 0xEE00
	call 04206h		;6853   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	call lo_lanzado		;6856   ; y las figuras
	call 08cb0h		;6859
	jp 0868eh		;685c   ; las_figuras: un cuadro de todas las figuras
L_685F:
	call 086fch		;685f   ; los cuadros impares: las figuras, el tiempo y el orden de los sprites
	call 08861h		;6862   ; copia_las_figuras: sprites de las ocho de 0xC600 a la copia de 0xEE20
	call 088b0h		;6865
	call 086f1h		;6868   ; sprites_de_los_disparos: los sprites de las doce de 0xCA00
	call 08857h		;686b   ; copia_los_disparos: sprites de las doce de 0xCA00 a la copia de 0xEE20
	call choques		;686e   ; choques: los choques del jugador con las figuras, sus disparos, su golpe y lo lanzado
	call 058c5h		;6871   ; cuenta_el_tiempo: cada 60 - fase * 5 cuadros, un segundo menos
	jp 05b1dh		;6874   ; gira_los_sprites: gira el orden de los sprites (0xC25F) y los sube a 0x7400/0x7600
f1_pausa:		; F1 recien apretada: la pausa (0xC008 = 1) y carry
	ld a,(0c00bh)		;6877   ; F1 recien apretada...
	rra			;687a
	ret nc			;687b
	ld a,001h		;687c   ; ... 0xC008 = 1 (p00:5F2C pasa a la pausa)...
	ld (0c008h),a		;687e
	call 04cabh		;6881   ; sprites_del_jugador: sube los sprites del jugador
	ld a,0fdh		;6884   ; ... el sonido en pausa, y carry
	call 04fe4h		;6886   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	scf			;6889
	ret			;688a
empieza_la_demo:		; la demostracion: el otro jugador, zona 0, casilla 12, 99 vidas y 999 ryo
	ld hl,0c002h		;688b   ; la demostracion: cada vez, el otro jugador
	ld a,(hl)			;688e   ; B = las banderas
	ld b,a			;688f
	ld a,(0cd2fh)		;6890   ; la primera vez (0xCD2F = 0), Goemon
	or a			;6893
	jr nz,L_689E		;6894
	inc a			;6896   ; 0xCD2F = 1
	ld (0cd2fh),a		;6897
	ld a,b			;689a
	or 080h		;689b   ; con el bit 7, para que el xor lo quite
	ld b,a			;689d
L_689E:
	ld a,b			;689e
	xor 080h		;689f
	ld (hl),a			;68a1
	ld a,(0cd2fh)		;68a2
	ex af,af'			;68a5
	call 04351h		;68a6   ; una partida nueva sin perder 0xCD2F
	ex af,af'			;68a9
	ld (0cd2fh),a		;68aa
	call prepara_la_partida		;68ad   ; prepara_la_partida: letras, dibujos de siempre y la vida a 0x10
	xor a			;68b0   ; en la fase 0, zona 0...
	ld (0c280h),a		;68b1   ; guarda la ZONA (0-6)
	ld (0c288h),a		;68b4   ; guarda la FASE (0-6)
	ld (0c009h),a		;68b7
	ld (0c007h),a		;68ba   ; guarda lo apretado: bits 0-3 arriba, abajo, izquierda, derecha; 4 y 5 los botones
	inc a			;68bd   ; ... 0xC263 = 1, la primera tecla dura 1...
	ld (0c263h),a		;68be
	ld (0c00ah),a		;68c1   ; guarda los cuadros que le quedan a la tecla de la demostracion
	ld (0c267h),a		;68c4   ; guarda los colores del sitio
	ld a,00ch		;68c7   ; ... desde la casilla 12
	ld (0c281h),a		;68c9   ; guarda la CASILLA de la zona
	call carga_la_zona		;68cc   ; carga_la_zona: carga la zona de 0xC280: graficos, pantallas, bloques, casillas, vida y tiempo, y entra en la casilla
	ld a,099h		;68cf   ; con 99 vidas...
	ld (0c260h),a		;68d1   ; guarda las vidas
	ld de,00999h		;68d4   ; ... 999 ryo...
	ld (0c265h),de		;68d7   ; guarda el DINERO (ryo, BCD) y el byte siguiente (16 bits)
	ld hl,068e9h		;68db   ; ... y las cosas del marcador de 0x68E9
	ld de,0c270h		;68de   ; apunta a las 10 cosas del marcador
	ld bc,0000ah		;68e1
	ldir		;68e4
	jp 043e2h		;68e6   ; pinta_el_marcador: pinta el marcador entero

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


cuadro_de_la_demo:		; un cuadro de la demostracion
	call cuadro_del_juego		;68f3   ; un cuadro de la demostracion
	ld a,(0c283h)		;68f6   ; si sale de la casilla, lo mismo que el estado 9
	and a			;68f9
	ret z			;68fa
	cp 005h		;68fb
	jr z,L_6919		;68fd
	cp 006h		;68ff
	jr z,L_691E		;6901
	ld a,(0c483h)		;6903   ; lee si esta en un pasadizo
	and a			;6906
	jr nz,L_6914		;6907
	call sale_de_la_casilla		;6909   ; sale_de_la_casilla: 0xC281 = la casilla vecina por el lado de 0xC283 (enlaces de 0xE780)
L_690C:
	call entra_en_la_casilla		;690c   ; entra_en_la_casilla: monta y pinta la casilla con sus figuras
L_690F:
	xor a			;690f
	ld (0c283h),a		;6910   ; guarda por donde se sale de la casilla (1-4 arriba, abajo, izquierda, derecha; 5 y 6 otros; 0 nada)
	ret			;6913
L_6914:
	call tramo_siguiente		;6914   ; tramo_siguiente: al tramo siguiente o al anterior del pasadizo
	jr L_690F		;6917
L_6919:
	call entra_por_el_lado_5		;6919   ; entra_por_el_lado_5: la casilla sin cosas fijas, con el jugador abajo en medio
	jr L_690F		;691c
L_691E:
	call 04ce3h		;691e   ; paleta_de_la_zona: pone la paleta del juego de graficos de la zona
	jr L_690C		;6921
teclas_de_la_demo:		; la tecla de la demostracion, cada dos cuadros
	ld a,(0c003h)		;6923   ; la demostracion, cada dos cuadros: la tecla siguiente
	rra			;6926
	ret c			;6927
	ld hl,0c00ah		;6928   ; apunta a los cuadros que le quedan a la tecla de la demostracion
	dec (hl)			;692b
	jr z,tecla_de_la_demo		;692c
L_692E:
	ld a,(0cd54h)		;692e   ; 0xCD54: la tecla que se pulsa; 0xFF acaba
	cp 0ffh		;6931
	jr z,L_6938		;6933
	jp 049e4h		;6935   ; como si se pulsara (p00:49E4)
L_6938:
	xor a			;6938   ; se acabo: 0xC263 = 0 (p00:5E27 vuelve al estado 0)
	ld (0c263h),a		;6939
	jp 04d48h		;693c   ; paleta_del_titulo: pone la paleta de 0xA44E (banco 9)
tecla_de_la_demo:		; la tecla siguiente del guion de 0x6955
	dec hl			;693f   ; la tecla siguiente del guion de la demostracion (0x6955)
	ld c,(hl)			;6940   ; C = cual toca
	inc (hl)			;6941   ; la siguiente para la proxima vez
	ld de,06955h		;6942
	ld l,c			;6945   ; dos bytes por tecla: [cuadros][tecla]
	ld h,000h		;6946
	add hl,hl			;6948
	add hl,de			;6949
	ld a,(hl)			;694a
	ld (0c00ah),a		;694b   ; guarda los cuadros que le quedan a la tecla de la demostracion
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


pasadizo:		; se entra o se sale de un pasadizo
	di			;69d1   ; se entra o se sale de un pasadizo
	ld a,009h		;69d2
	ld (0a000h),a		;69d4   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;69d7   ; guarda la copia del banco de 0xA000
	ei			;69da
	call destino_del_pasadizo		;69db   ; a donde lleva (tablas de 0xEA80 y 0xEB00)
	call 04206h		;69de   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ld a,001h		;69e1   ; 0xC4AF = 1: el jugador se pone en la puerta
	ld (0c4afh),a		;69e3
	ld a,(0c483h)		;69e6   ; dentro del pasadizo: su pantalla y, en partida, la musica 0x08
	and a			;69e9
	jr z,L_69FD		;69ea
	call esconde_los_sprites_de_ram		;69ec   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	call pinta_el_tramo		;69ef   ; pinta_el_tramo: la pantalla del tramo de pasadizo 0xC484
	ld a,(0c002h)		;69f2   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	and 040h		;69f5
	ret z			;69f7
	ld a,088h		;69f8
	jp 04fe4h		;69fa   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_69FD:
	call entra_en_la_casilla		;69fd   ; fuera: la casilla, el jugador en la puerta y la musica de la zona
	call en_la_puerta		;6a00   ; en_la_puerta: pone al jugador junto a la puerta (figura 6 o 7)
	jp 0416fh		;6a03   ; musica_de_la_zona: la musica del juego de graficos de la zona (tabla 0x4182)
tramo_siguiente:		; al tramo siguiente o al anterior del pasadizo
	ld hl,0c484h		;6a06   ; por un pasadizo, de tramo en tramo: el lado 4 (derecha) al siguiente...
	ld a,(0c283h)		;6a09   ; lee por donde se sale de la casilla (1-4 arriba, abajo, izquierda, derecha; 5 y 6 otros; 0 nada)
	cp 004h		;6a0c
	jr nz,L_6A13		;6a0e
	inc (hl)			;6a10
	jr pinta_el_tramo		;6a11
L_6A13:
	dec (hl)			;6a13   ; ... y el 3 al anterior
pinta_el_tramo:		; la pantalla del tramo de pasadizo 0xC484
	call 045eeh		;6a14   ; la pantalla del pasadizo
	call 0460ah		;6a17   ; esconde_los_sprites: y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM
	call las_dos_de_0xc4d3		;6a1a   ; las_dos_de_0xc4d3: p01:76AC con 0xC4D3 y con 0xC4E3
	xor a			;6a1d   ; sin colores del sitio, y la lista de 0xC500 (48 bytes) a cero
	ld (0c267h),a		;6a1e   ; guarda los colores del sitio
	ld hl,0c500h		;6a21
	ld de,0c501h		;6a24
	ld (hl),a			;6a27
	ld bc,0002fh		;6a28
	ldir		;6a2b
	call 04d2ch		;6a2d   ; colores_del_sitio: cambia los colores del sitio (0xC267)
	ld hl,0d800h		;6a30   ; el mapa de 0xD800 entero del caracter 1
	ld de,0d801h		;6a33
	ld (hl),001h		;6a36
	ld bc,002ffh		;6a38
	ldir		;6a3b
	call 0534eh		;6a3d   ; pinta_la_pantalla: pinta los caracteres de 0xD800 en la pantalla
	ld a,(0c484h)		;6a40   ; el dibujo del tramo: 0xEA00 + el tramo
	ld hl,0ea00h		;6a43
	call 04083h		;6a46   ; hl_mas_a: HL += A
	ld a,(hl)			;6a49
	call 04f47h		;6a4a   ; pinta_pasadizo: pinta el pasadizo A con la pieza de (0x00, 0x80): 9 filas de bits de 0xAB18 (banco 9)
	call borra_las_de_0xcc00		;6a4d   ; borra_las_de_0xcc00: 0xCC00-0xCCFF a cero
	call 090c0h		;6a50   ; cosas_fijas: pinta las cosas fijas de la casilla
	call en_la_puerta		;6a53   ; en_la_puerta: pone al jugador junto a la puerta (figura 6 o 7)
	jp 045e1h		;6a56   ; enciende_la_pantalla: bit 6 del registro 1 del VDP a uno
destino_del_pasadizo:		; el tramo al entrar (0xEA80) o la casilla al salir (0xEB00)
	ld a,(0c483h)		;6a59   ; al entrar en el pasadizo, la lista de 0xEA80: [casilla][tramo]
	and a			;6a5c
	ld hl,0ea80h		;6a5d
	jr nz,L_6A65		;6a60
	ld hl,0eb00h		;6a62   ; al salir, la de 0xEB00: [tramo][casilla][colores]
L_6A65:
	ld b,(hl)			;6a65   ; cuantas entradas
	ld a,(0c483h)		;6a66   ; lee si esta en un pasadizo
	and a			;6a69
	ld a,(0c281h)		;6a6a   ; C = la casilla de la que se viene, o el tramo
	jr nz,L_6A72		;6a6d
	ld a,(0c484h)		;6a6f
L_6A72:
	ld c,a			;6a72   ; C = lo que se busca
	inc hl			;6a73   ; desde la primera entrada
L_6A74:
	ld a,(hl)			;6a74   ; la entrada que le toca
	cp c			;6a75
	jr nz,L_6A90		;6a76
	inc hl			;6a78
	ld a,(0c483h)		;6a79   ; lee si esta en un pasadizo
	and a			;6a7c
	push af			;6a7d
	ld a,(hl)			;6a7e   ; el tramo, a 0xC484; o la casilla, a 0xC281
	ld de,0c281h		;6a7f   ; apunta a la CASILLA de la zona
	jr z,L_6A87		;6a82
	ld de,0c484h		;6a84
L_6A87:
	ld (de),a			;6a87   ; alli
	pop af			;6a88
	ret nz			;6a89   ; al entrar, ya esta
	inc hl			;6a8a   ; al salir, tambien los colores del sitio
	ld a,(hl)			;6a8b
	ld (0c267h),a		;6a8c   ; guarda los colores del sitio
	ret			;6a8f
L_6A90:
	ld a,(0c483h)		;6a90   ; lee si esta en un pasadizo
	and a			;6a93
	jr nz,L_6A97		;6a94   ; las de 0xEA80 son de 2 bytes...
	inc hl			;6a96   ; ... las de 0xEB00, de 3
L_6A97:
	inc hl			;6a97   ; la siguiente
	inc hl			;6a98
	djnz L_6A74		;6a99
	ret			;6a9b
en_la_puerta:		; pone al jugador junto a la puerta (figura 6 o 7)
	ld hl,0c4afh		;6a9c   ; con 0xC4AF puesto, una vez...
	ld a,(hl)			;6a9f
	and a			;6aa0
	ret z			;6aa1   ; sin ella, nada
	ld (hl),000h		;6aa2   ; solo una vez
	ld a,(0c483h)		;6aa4   ; ... la puerta: la figura 6 fuera del pasadizo, la 7 dentro
	and a			;6aa7
	ld c,006h		;6aa8
	jr z,L_6AAD		;6aaa
	inc c			;6aac   ; dentro: la 7
L_6AAD:
	ld b,004h		;6aad   ; entre las cuatro fichas de 0xCC00
	ld hl,0cc00h		;6aaf
L_6AB2:
	ld a,(hl)			;6ab2   ; entre las cuatro de 0xCC00
	cp c			;6ab3
	jr z,L_6ABD		;6ab4
	ld de,00040h		;6ab6   ; de 0x40 en 0x40
	add hl,de			;6ab9
	djnz L_6AB2		;6aba
	ret			;6abc
L_6ABD:
	inc hl			;6abd   ; HL = su (y, x)
	inc hl			;6abe
	inc hl			;6abf
	ld a,(hl)			;6ac0   ; la y (+3)...
	inc hl			;6ac1
	inc hl			;6ac2
	ld h,(hl)			;6ac3   ; ... y la x (+5)
	ld l,a			;6ac4
	exx			;6ac5
	ld b,004h		;6ac6   ; cuatro sitios alrededor (0x6AF4, [dy][dx])...
	ld hl,06af4h		;6ac8
L_6ACB:
	ld a,(hl)			;6acb   ; y + dy
	exx			;6acc
	add a,l			;6acd
	ld e,a			;6ace
	exx			;6acf
	inc hl			;6ad0
	ld a,(hl)			;6ad1   ; x + dx
	exx			;6ad2
	add a,h			;6ad3
	ld d,a			;6ad4
	push hl			;6ad5
	call no_se_puede_estar		;6ad6   ; ... el primero donde se puede pisar
	pop hl			;6ad9
	jr nc,L_6AE0		;6ada
	exx			;6adc   ; el sitio siguiente
	inc hl			;6add
	djnz L_6ACB		;6ade
L_6AE0:
	ld a,e			;6ae0   ; alli el jugador...
	ld (0c498h),a		;6ae1   ; guarda la y de los sprites del jugador
	ld (0c494h),a		;6ae4   ; guarda la y del jugador
	ld a,d			;6ae7
	ld (0c49ah),a		;6ae8   ; guarda la x de los sprites del jugador
	ld (0c496h),a		;6aeb   ; guarda la x del jugador
	ld a,003h		;6aee   ; ... mirando a la derecha
	ld (0c4a2h),a		;6af0   ; guarda el lado al que mira el jugador
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


pasadizos_de_la_zona:		; los tramos y las puertas de los pasadizos de la zona, a 0xEA00, 0xEA80 y 0xEB00
	call 041f6h		;6afc   ; los pasadizos de la zona (banco 9): 15 tramos, de 0xAF08...
	ld hl,0af08h		;6aff
	call 04d81h		;6b02   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld de,0ea00h		;6b05   ; ... a 0xEA00
	ld b,00fh		;6b08
L_6B0A:
	ld a,(hl)			;6b0a   ; el numero del tramo
	push bc			;6b0b
	push hl			;6b0c
	ld h,000h		;6b0d   ; ... cada uno es un numero de la tabla de 0xB04F, dos bytes...
	ld l,a			;6b0f
	add hl,hl			;6b10
	ld bc,0b04fh		;6b11
	add hl,bc			;6b14
	ld a,(hl)			;6b15   ; dos bytes...
	ld (de),a			;6b16
	inc hl			;6b17
	inc de			;6b18
	ld a,(hl)			;6b19   ; ... a 0xEA00
	ld (de),a			;6b1a
	inc de			;6b1b
	pop hl			;6b1c
	pop bc			;6b1d
	inc hl			;6b1e
	djnz L_6B0A		;6b1f   ; 15 tramos
	call 041f6h		;6b21   ; y las entradas y salidas, de 0xB21B
	ld hl,0b21bh		;6b24
	call 04d81h		;6b27   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	push hl			;6b2a
	ld de,0ea80h		;6b2b   ; a 0xEA80: [cuantas] y [casilla][tramo] (el tramo, 5 bits)
	ld a,(hl)			;6b2e   ; cuantas
	ld (de),a			;6b2f
	ld b,a			;6b30
	inc hl			;6b31
	inc de			;6b32
L_6B33:
	ld a,(hl)			;6b33   ; la casilla
	ld (de),a			;6b34
	inc hl			;6b35
	inc de			;6b36
	ld a,(hl)			;6b37   ; el tramo
	and 01fh		;6b38
	ld (de),a			;6b3a
	inc hl			;6b3b
	inc de			;6b3c
	djnz L_6B33		;6b3d   ; todas
	pop hl			;6b3f
	ld de,0eb00h		;6b40   ; a 0xEB00, cada una al reves: [tramo][casilla] y un byte mas
	ld a,(hl)			;6b43   ; cuantas otra vez
	ld (de),a			;6b44
	ld b,a			;6b45
	inc hl			;6b46
	inc de			;6b47
L_6B48:
	inc de			;6b48   ; [1] la casilla...
	ld a,(hl)			;6b49
	ld (de),a			;6b4a
	inc hl			;6b4b
	dec de			;6b4c
	ld a,(hl)			;6b4d   ; ... [0] el tramo...
	and 01fh		;6b4e
	ld (de),a			;6b50
	inc de			;6b51
	inc de			;6b52
	ld a,(hl)			;6b53   ; los 3 bits de arriba, aparte
	rlca			;6b54
	rlca			;6b55
	rlca			;6b56
	and 007h		;6b57
	ld (de),a			;6b59   ; ... [2] los colores del sitio
	inc hl			;6b5a
	inc de			;6b5b
	djnz L_6B48		;6b5c
	ret			;6b5e
ensena_la_contrasena:		; F2 en la pausa: la contrasena del sitio donde se esta
	ld hl,0eb90h		;6b5f   ; F2 en la pausa ensena la CONTRASENA del sitio donde se esta: 9 valores en 0xEB90
	ld a,(0c002h)		;6b62   ; [0] la fase, con el bit 4 si juega el jugador 2
	rrca			;6b65
	rrca			;6b66
	rrca			;6b67
	and 010h		;6b68
	ld b,a			;6b6a
	ld a,(0c288h)		;6b6b   ; lee la FASE (0-6)
	or b			;6b6e
	ld (hl),a			;6b6f
	inc hl			;6b70
	ld a,(0c280h)		;6b71   ; [1-2] la zona, en dos nibbles
	call en_dos_nibbles		;6b74   ; en_dos_nibbles: A en (HL) y (HL+1): el nibble de arriba y el de abajo
	inc hl			;6b77
	ld a,(0c281h)		;6b78   ; [3-4] la casilla
	call en_dos_nibbles		;6b7b   ; en_dos_nibbles: A en (HL) y (HL+1): el nibble de arriba y el de abajo
	inc hl			;6b7e
	ld a,(0c267h)		;6b7f   ; [5] los colores del sitio
	ld (hl),a			;6b82
	inc hl			;6b83
	ld a,(0c00eh)		;6b84   ; [6] la clave: lo que marque 0xC00E (0-0x2D, sube cada cuadro de la pausa)
	ld (hl),a			;6b87
	inc hl			;6b88
	ex de,hl			;6b89   ; [7-8] la suma de los siete primeros, en dos nibbles
	ld hl,0eb90h		;6b8a
	ld b,007h		;6b8d
	xor a			;6b8f
L_6B90:
	ld c,(hl)			;6b90   ; la suma de los siete
	add a,c			;6b91
	inc hl			;6b92
	djnz L_6B90		;6b93
	ex de,hl			;6b95   ; a [7] y [8]
	call en_dos_nibbles		;6b96   ; en_dos_nibbles: A en (HL) y (HL+1): el nibble de arriba y el de abajo
	ld a,(0eb96h)		;6b99   ; se revuelven con la clave
	ld c,a			;6b9c   ; C = la clave
	ld hl,0eb90h		;6b9d
	ld de,0eba0h		;6ba0   ; a 0xEBA0, las letras
	ld b,009h		;6ba3   ; 9
L_6BA5:
	ld a,(hl)			;6ba5
	push de			;6ba6
	ld d,a			;6ba7
	ld a,b			;6ba8
	cp 004h		;6ba9   ; los tres ultimos (la clave y la suma) van tal cual
	jr nc,L_6BB0		;6bab
	ld a,d			;6bad   ; tal cual
	jr L_6BC1		;6bae
L_6BB0:
	ld e,a			;6bb0   ; B par o impar
	rr e		;6bb1
	jr c,L_6BB6		;6bb3
	add a,a			;6bb5   ; par: * 4
L_6BB6:
	add a,a			;6bb6   ; impar: * 2
	add a,c			;6bb7   ; + clave + valor
	add a,d			;6bb8
L_6BB9:
	cp 02eh		;6bb9   ; ... modulo 46
	jr c,L_6BC1		;6bbb
	sub 02eh		;6bbd
	jr L_6BB9		;6bbf
L_6BC1:
	add a,030h		;6bc1   ; + 0x30: una de las 46 letras desde la 0x30
	pop de			;6bc3
	ld (de),a			;6bc4
	inc hl			;6bc5
	inc de			;6bc6
	djnz L_6BA5		;6bc7
	ld a,0ffh		;6bc9
	ld (de),a			;6bcb
	ld hl,05070h		;6bcc   ; la ventana, en (0x50, 0x70), 0x60 x 0x1C
	ld bc,0601ch		;6bcf
	ld de,0a0c0h		;6bd2
	call ventana		;6bd5   ; ventana: guarda en la pagina 1 el rectangulo de (H, L), B x C, lo borra y le pone marco
	ld hl,06ccch		;6bd8   ; su rotulo
	call 048f3h		;6bdb   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba
	ld hl,0eba0h		;6bde   ; y la contrasena en (0x60, 0x80)
	ld de,06080h		;6be1
	jp 048fdh		;6be4   ; rotulo_sin_posicion: pinta el texto de HL en DE (D = x, E = y), sin [x][y] delante; C = 0 borra
quita_la_contrasena:		; devuelve lo que tapaba la ventana de la contrasena
	ld de,05070h		;6be7   ; quita la ventana: vuelve lo de (0xA0, 0xC0) de la pagina 1
	ld bc,0601ch		;6bea
	ld hl,0a0c0h		;6bed
	ld a,001h		;6bf0
	jp 0476eh		;6bf2   ; hmmm: orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A
en_dos_nibbles:		; A en (HL) y (HL+1): el nibble de arriba y el de abajo
	ld b,a			;6bf5   ; A en dos bytes: el nibble de arriba y el de abajo
	rra			;6bf6   ; el nibble de arriba
	rra			;6bf7
	rra			;6bf8
	rra			;6bf9
	and 00fh		;6bfa
	ld (hl),a			;6bfc
	inc hl			;6bfd
	ld a,b			;6bfe
	and 00fh		;6bff   ; el de abajo
	ld (hl),a			;6c01
	ret			;6c02
teclea_la_contrasena:		; una letra mas de la contrasena; con 9, la deshace y mira la suma: carry al acabar, 0xEB82 = 1 si vale
	call lee_el_teclado		;6c03   ; cada vez que se aprieta una tecla, una letra mas; con 9, se mira
	xor a			;6c06   ; 0xEB82 = 0
	ld (0eb82h),a		;6c07
	ld de,0ebb0h		;6c0a   ; las letras en 0xEBB0, la cuenta en 0xEB83
	ld hl,0eb83h		;6c0d   ; apunta a los caracteres de la contrasena
	ld a,(hl)			;6c10   ; cuantas van
	cp 009h		;6c11
	jr nc,L_6C31		;6c13   ; nueve: a mirarla
	ld a,(0eb81h)		;6c15   ; la tecla (0xEB81)
	and a			;6c18
	ret z			;6c19   ; ninguna tecla
	push af			;6c1a
	ld a,(hl)			;6c1b   ; la letra n...
	add a,e			;6c1c
	ld e,a			;6c1d
	pop af			;6c1e
	ld (de),a			;6c1f   ; ... en 0xEBB0 + n
	exx			;6c20
	ld c,0ffh		;6c21   ; se pinta lo que va tecleado en (0x60, 0x80)
	ld hl,0ebb0h		;6c23
	ld de,06080h		;6c26
	call 048fdh		;6c29   ; rotulo_sin_posicion: pinta el texto de HL en DE (D = x, E = y), sin [x][y] delante; C = 0 borra
	exx			;6c2c
	inc de			;6c2d
	inc (hl)			;6c2e   ; una mas
	xor a			;6c2f   ; NC: aun no
	ret			;6c30
L_6C31:
	ex de,hl			;6c31   ; las 9: menos 0x30, a 0xEBC0
	ld de,0ebc0h		;6c32
	ld b,009h		;6c35
L_6C37:
	ld a,(hl)			;6c37   ; la letra - 0x30
	sub 030h		;6c38
	ld (de),a			;6c3a
	inc hl			;6c3b
	inc de			;6c3c
	djnz L_6C37		;6c3d
	ld hl,0ebc0h		;6c3f   ; las 9 numeros en 0xEBC0
	ld bc,00609h		;6c42   ; se deshace el revuelto: B = 6 letras, C = la posicion (9, 8...)
	ld a,(0ebc6h)		;6c45   ; la clave es la letra 6
	ld e,a			;6c48
L_6C49:
	ld a,b			;6c49   ; la posicion por 2 (impar) o por 4 (par)...
	rra			;6c4a
	ld a,c			;6c4b
	jr nc,L_6C4F		;6c4c
	add a,a			;6c4e   ; impar: * 2
L_6C4F:
	add a,a			;6c4f   ; par: * 4
	ld d,a			;6c50
	ld a,(hl)			;6c51   ; ... y la clave, se restan...
	sub d			;6c52
	sub e			;6c53
	ld d,a			;6c54
	rl d		;6c55   ; el signo
	jr nc,L_6C5B		;6c57   ; ... y si queda negativo, + 46
	add a,02eh		;6c59
L_6C5B:
	ld (hl),a			;6c5b   ; el valor
	dec c			;6c5c   ; la posicion anterior
	inc hl			;6c5d
	djnz L_6C49		;6c5e
	ld hl,0ebc0h		;6c60   ; la suma de los siete primeros...
	ld b,007h		;6c63
	xor a			;6c65
L_6C66:
	add a,(hl)			;6c66
	inc hl			;6c67
	djnz L_6C66		;6c68
	ld d,a			;6c6a
	ld hl,(0ebc7h)		;6c6b   ; ... contra la de las letras 7 y 8
	call junta_nibbles		;6c6e   ; junta_nibbles: A = L * 16 + H
	cp d			;6c71
	scf			;6c72   ; mal: carry y 0xEB82 = 0
	ret nz			;6c73
	ld a,001h		;6c74   ; buena: carry y 0xEB82 = 1
	ld (0eb82h),a		;6c76
	ret			;6c79
aplica_la_contrasena:		; la fase, el jugador, la zona, la casilla y los colores de la contrasena de 0xEBC0
	ld a,(0ebc0h)		;6c7a   ; [0]: la fase y el bit 4, el jugador 2
	ld b,a			;6c7d
	and 00fh		;6c7e
	ld (0c288h),a		;6c80   ; guarda la FASE (0-6)
	ld a,b			;6c83
	and 010h		;6c84
	ld hl,0c002h		;6c86   ; apunta a las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	jr z,L_6C8D		;6c89
	set 7,(hl)		;6c8b
L_6C8D:
	ld hl,(0ebc1h)		;6c8d   ; [1-2]: la zona
	call junta_nibbles		;6c90   ; junta_nibbles: A = L * 16 + H
	ld (0c280h),a		;6c93   ; guarda la ZONA (0-6)
	ld hl,(0ebc3h)		;6c96   ; [3-4]: la casilla
	call junta_nibbles		;6c99   ; junta_nibbles: A = L * 16 + H
	ld (0c281h),a		;6c9c   ; guarda la CASILLA de la zona
	ld a,(0ebc5h)		;6c9f   ; [5]: los colores del sitio
	ld (0c267h),a		;6ca2   ; guarda los colores del sitio
	ld a,001h		;6ca5   ; 0xC268 = 1: no se busca la casilla de entrada de la zona
	ld (0c268h),a		;6ca7   ; guarda si ya entro en la zona
	ret			;6caa
junta_nibbles:		; A = L * 16 + H
	rl l		;6cab   ; L * 16
	rl l		;6cad
	rl l		;6caf
	rl l		;6cb1
	ld a,l			;6cb3
	and 0f0h		;6cb4
	or h			;6cb6   ; + H
	ret			;6cb7
contrasena_en_blanco:		; nada tecleado
	xor a			;6cb8   ; nada tecleado: las 9 letras a 0...
	ld (0eb83h),a		;6cb9   ; guarda los caracteres de la contrasena
	ld hl,0ebb0h		;6cbc
	ld de,0ebb1h		;6cbf
	ld bc,00008h		;6cc2
	ld (hl),a			;6cc5
	ldir		;6cc6
	inc hl			;6cc8   ; ... y 0xFF detras
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


lee_el_teclado:		; lee una tecla
	di			;6cd8
	ld a,006h		;6cd9   ; el banco 6: las tablas de las teclas
	ld (0a000h),a		;6cdb   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;6cde   ; guarda la copia del banco de 0xA000
	ei			;6ce1
	ld b,009h		;6ce2   ; las filas 0-8 del teclado, hasta encontrar una tecla apretada
	ld e,000h		;6ce4
L_6CE6:
	ld a,e			;6ce6   ; la fila E
	call 00141h		;6ce7   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;6cea   ; apretadas a uno
	and a			;6ceb
	jr nz,L_6CFB		;6cec   ; alguna: esa
	inc e			;6cee   ; la siguiente fila
	djnz L_6CE6		;6cef
	xor a			;6cf1   ; ninguna: 0xEB80 y 0xEB81 a cero
	ld hl,0eb80h		;6cf2
	ld (hl),a			;6cf5
	inc hl			;6cf6
	ld (hl),a			;6cf7
	jp 04206h		;6cf8   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_6CFB:
	ld b,a			;6cfb   ; B = la fila
	ld a,(0fcadh)		;6cfc   ; 0xFCAD (la BIOS) distinto de cero: el teclado en kana, otra tabla
	and a			;6cff
	ld hl,0adech		;6d00
	jr z,L_6D08		;6d03
	ld hl,0ae34h		;6d05
L_6D08:
	ld a,e			;6d08   ; 8 bytes por fila, uno por tecla
	add a,a			;6d09
	add a,a			;6d0a
	add a,a			;6d0b
	call 04083h		;6d0c   ; hl_mas_a: HL += A
	ld a,b			;6d0f
L_6D10:
	rra			;6d10   ; el primer bit apretado de la fila
	jr c,L_6D16		;6d11
	inc hl			;6d13
	jr L_6D10		;6d14
L_6D16:
	ld a,(0fcadh)		;6d16
	and a			;6d19
	ld a,(hl)			;6d1a   ; la tecla de la tabla
	jr z,L_6D2C		;6d1b
	ld a,006h		;6d1d   ; en kana, sin SHIFT, la 0x5B es la 0x5C
	call 00141h		;6d1f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;6d22   ; el bit 0 de la fila 6: SHIFT
	ld a,(hl)			;6d23
	jr c,L_6D2C		;6d24
	cp 05bh		;6d26
	jr nz,L_6D2C		;6d28
	ld a,05ch		;6d2a
L_6D2C:
	ld hl,0eb80h		;6d2c   ; 0xEB80 la tecla apretada, 0xEB81 si es nueva
	ld c,(hl)			;6d2f   ; la de antes
	ld (hl),a			;6d30
	xor c			;6d31   ; nueva?
	and (hl)			;6d32
	inc hl			;6d33
	ld (hl),a			;6d34
	jp 04206h		;6d35   ; bancos_1_2_3: pone los bancos 1, 2 y 3
el_jugador:		; el jugador, un cuadro: mandos y su estado (tabla de 0x6D4C)
	ld a,(0cd32h)		;6d38   ; el jugador, un cuadro (con 0xCD32 puesto, quieto)
	and a			;6d3b
	ret nz			;6d3c
	call baja_0xc4a7		;6d3d   ; baja_0xc4a7: 0xC4A7 cuenta hasta 0
	call direccion_que_vale		;6d40   ; direccion_que_vale: 0xC485 = la direccion apretada
	call prisas		;6d43   ; prisas: por debajo de 50 segundos, su musica
	ld a,(0c490h)		;6d46   ; por su estado (0x6D4C): 0 en el suelo, 1 saltando, 2 muriendo, 3, 4 y 5
	call 0408dh		;6d49   ; despacha: salta a la entrada A de la tabla que va detras del call

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


jugador_en_el_suelo:		; estado 0: andar, saltar, el golpe, los hoyos
	call velocidad_del_jugador		;6d58   ; estado 0: la velocidad, segun lo que lleve
	ld a,(0c492h)		;6d5b   ; con 0xC492 puesto (el primer boton), nada mas
	and a			;6d5e
	ret nz			;6d5f
	ld a,(0cdb0h)		;6d60
	and a			;6d63
	call nz,entrada_del_pasadizo_secreto		;6d64   ; entrada_del_pasadizo_secreto: con 0xCDB0, arriba en (0x30-0x50, 0x40) se entra en el pasadizo secreto
	call en_un_hoyo		;6d67   ; con carry de p01:7763 (los dos caracteres bajo los pies), a morir (estado 2)
	jr c,cae_al_hoyo		;6d6a
	call sin_vida_o_tiempo		;6d6c   ; sin_vida_o_tiempo: sin vida (y sin la cosa 7) o sin tiempo: estado 3
	ld a,(0c490h)		;6d6f   ; lee el estado del jugador
	cp 003h		;6d72
	ret z			;6d74
	call salidas_especiales		;6d75   ; salidas_especiales: las puertas de 0xC28A: la de la zona (3 cosas 9) y la de la fase
	ld a,(0c482h)		;6d78   ; lee la pantalla especial
	and a			;6d7b
	jr nz,L_6D89		;6d7c
	ld a,(0c006h)		;6d7e   ; el primer boton: 0xC492 = 1
	bit 4,a		;6d81
	jr nz,pide_el_golpe		;6d83
	bit 5,a		;6d85   ; el segundo: el salto
	jr nz,salta		;6d87
L_6D89:
	ld de,0c485h		;6d89   ; 0xC485: la direccion apretada; andando, la pose cambia cada 4 cuadros
	ld a,(de)			;6d8c   ; alguna?
	and a			;6d8d
	jr z,L_6D9E		;6d8e
	ld a,(0c00dh)		;6d90   ; cada 4 cuadros
	and 003h		;6d93
	jr nz,L_6D9E		;6d95
	ld hl,0c49fh		;6d97   ; apunta a la accion del jugador
	ld a,(hl)			;6d9a   ; la otra pose de andar
	xor 001h		;6d9b
	ld (hl),a			;6d9d
L_6D9E:
	ld a,(de)			;6d9e   ; la direccion
anda:		; segun la direccion de A: velocidad y lado
	rra			;6d9f   ; la direccion: arriba...
	jp c,L_6E04		;6da0
	rra			;6da3   ; ... abajo...
	jp c,L_6E18		;6da4
	rra			;6da7   ; ... izquierda...
	jp c,L_6E30		;6da8
	rra			;6dab   ; ... derecha
	jp c,L_6E57		;6dac
	ld a,(0c490h)		;6daf   ; quieto: la accion 0, salvo en el salto
	dec a			;6db2
	ret z			;6db3
	xor a			;6db4
	ld (0c49fh),a		;6db5   ; guarda la accion del jugador
	ret			;6db8
pide_el_golpe:		; 0xC492 = 1
	ld a,001h		;6db9
	ld (0c492h),a		;6dbb   ; 0xC492 = 1
	ret			;6dbe
salta:		; el salto: estado 1 y el efecto 1
	ld a,(0c485h)		;6dbf   ; el salto: guarda la direccion, estado 1 y accion 2, y el efecto 1
	ld (0c4a5h),a		;6dc2
	ld a,001h		;6dc5
	ld (0c490h),a		;6dc7   ; guarda el estado del jugador
	inc a			;6dca
	ld (0c49fh),a		;6dcb   ; guarda la accion del jugador
	call donde_para_el_salto		;6dce   ; donde_para_el_salto: 0xC4A6: los pasos del salto en los que hay pared
	ld a,001h		;6dd1
	jp 04fe4h		;6dd3   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
cae_al_hoyo:		; estado 2 y la musica 0x0B
	call borra_las_figuras		;6dd6   ; se muere: fuera las figuras...
	call esconde_los_sprites_de_ram		;6dd9   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	call borra_las_de_0xcc00		;6ddc   ; borra_las_de_0xcc00: 0xCC00-0xCCFF a cero
	ld hl,0c4d3h		;6ddf
	call borra_lo_lanzado		;6de2   ; borra_lo_lanzado: sus 16 bytes a cero y su sprite fuera
	ld hl,0c4e3h		;6de5
	call borra_lo_lanzado		;6de8   ; borra_lo_lanzado: sus 16 bytes a cero y su sprite fuera
	call sprites_en_la_y_del_jugador		;6deb   ; sprites_en_la_y_del_jugador: los 16 sprites de la copia en la y del jugador
	ld a,002h		;6dee   ; ... estado 2, 15 cuadros de caida...
	ld (0c490h),a		;6df0   ; guarda el estado del jugador
	ld a,00fh		;6df3
	ld (0c4a8h),a		;6df5
	xor a			;6df8
	ld (0c49fh),a		;6df9   ; guarda la accion del jugador
	ld (0c4a9h),a		;6dfc
	ld a,08bh		;6dff   ; ... y la musica 0x0B
	jp 04fe4h		;6e01   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_6E04:
	xor a			;6e04   ; arriba: lado 0, si no choca, velocidad vertical negativa
	ld (0c4a2h),a		;6e05   ; guarda el lado al que mira el jugador
	call choca_arriba		;6e08   ; choca_arriba: carry si hay pared encima
	ret c			;6e0b
	ld de,(0c4a3h)		;6e0c
	call 08c0ah		;6e10   ; niega_de: DE = -DE
	ld (0c49bh),de		;6e13
	ret			;6e17
L_6E18:
	ld a,001h		;6e18   ; abajo: lado 1, hasta la y 0xC9
	ld (0c4a2h),a		;6e1a   ; guarda el lado al que mira el jugador
	ld a,(0c494h)		;6e1d   ; lee la y del jugador
	cp 0c9h		;6e20
	ret nc			;6e22
	call choca_abajo		;6e23   ; choca_abajo: carry si hay pared debajo
	ret c			;6e26
	ld de,(0c4a3h)		;6e27
	ld (0c49bh),de		;6e2b
	ret			;6e2f
L_6E30:
	ld a,002h		;6e30   ; izquierda: lado 2; sin casilla a la izquierda, no pasa de x 0x10
	ld (0c4a2h),a		;6e32   ; guarda el lado al que mira el jugador
	ld a,(0c483h)		;6e35   ; lee si esta en un pasadizo
	and a			;6e38
	jr nz,L_6E47		;6e39
	ld a,(0c286h)		;6e3b
	inc a			;6e3e
	jr nz,L_6E47		;6e3f
	ld a,(0c496h)		;6e41   ; lee la x del jugador
	cp 010h		;6e44
	ret c			;6e46
L_6E47:
	call choca_izquierda		;6e47   ; choca_izquierda: carry si hay pared a la izquierda
	ret c			;6e4a
	ld de,(0c4a3h)		;6e4b
	call 08c0ah		;6e4f   ; niega_de: DE = -DE
	ld (0c49dh),de		;6e52
	ret			;6e56
L_6E57:
	ld a,003h		;6e57   ; derecha: lado 3; sin casilla a la derecha, no pasa de x 0xF0
	ld (0c4a2h),a		;6e59   ; guarda el lado al que mira el jugador
	ld a,(0c483h)		;6e5c   ; lee si esta en un pasadizo
	and a			;6e5f
	jr nz,L_6E6E		;6e60
	ld a,(0c287h)		;6e62
	inc a			;6e65
	jr nz,L_6E6E		;6e66
	ld a,(0c496h)		;6e68   ; lee la x del jugador
	cp 0f1h		;6e6b
	ret nc			;6e6d
L_6E6E:
	call choca_derecha		;6e6e   ; choca_derecha: carry si hay pared a la derecha
	ret c			;6e71   ; si choca, no se mueve
	ld de,(0c4a3h)		;6e72   ; la velocidad hacia la derecha
	ld (0c49dh),de		;6e76
	ret			;6e7a
velocidad_del_jugador:		; 0xC4A3 segun las cosas 0 (0x6E92) y parado
	ld a,(0c270h)		;6e7b   ; la velocidad, segun cuantas cosas 0 lleve (0x6E92: 1, 1,5, 2 y 2,5 puntos por cuadro)
	add a,a			;6e7e
	ld hl,06e92h		;6e7f
	call 04d81h		;6e82   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld (0c4a3h),hl		;6e85
	ld hl,00000h		;6e88   ; parado
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


jugador_saltando:		; estado 1: la curva del salto
	ld a,(0c492h)		;6e9a   ; estado 1: el salto (el primer boton tambien vale en el aire)
	and a			;6e9d
	jr nz,L_6EA8		;6e9e
	ld a,(0c006h)		;6ea0   ; lee lo que se acaba de apretar (mando y cursores)
	bit 4,a		;6ea3
	call nz,pide_el_golpe		;6ea5   ; pide_el_golpe: 0xC492 = 1
L_6EA8:
	call velocidad_del_jugador		;6ea8   ; velocidad_del_jugador: 0xC4A3 segun las cosas 0 (0x6E92) y parado
	ld a,(0c4a5h)		;6eab   ; la direccion de cuando empezo
	ld h,a			;6eae   ; H = la direccion
	and 00ch		;6eaf   ; en vertical, los dos puntos de los pies; en horizontal, uno
	ld bc,00000h		;6eb1
	jr z,L_6EB9		;6eb4
	ld bc,0060ch		;6eb6
L_6EB9:
	ld a,(0c496h)		;6eb9   ; mira los dos caracteres del suelo
	sub b			;6ebc
	ld d,a			;6ebd
	ld b,h			;6ebe
	ld a,(0c494h)		;6ebf   ; lee la y del jugador
	ld e,a			;6ec2
	call caracter_bajo		;6ec3   ; el caracter de la izquierda...
	inc a			;6ec6   ; ... 0xFF es el borde
	ld a,b			;6ec7
	jr z,L_6EEF		;6ec8
	ld a,d			;6eca
	add a,c			;6ecb
	ld d,a			;6ecc
	call caracter_bajo		;6ecd   ; el de la derecha
	inc a			;6ed0
	ld a,b			;6ed1
	jr z,L_6EEF		;6ed2
	ld a,(0c4aah)		;6ed4   ; 0xC4AA puesto: ya da igual la direccion
	and a			;6ed7
	jr nz,L_6EF2		;6ed8
	ld a,(0c006h)		;6eda   ; lo apretado ahora
	ld c,a			;6edd
	ld a,b			;6ede
	rr b		;6edf   ; segun la direccion del salto...
	jr c,L_6F1D		;6ee1
	rr b		;6ee3
	jr c,L_6F1F		;6ee5
	rr b		;6ee7
	jr c,L_6F19		;6ee9
	rr b		;6eeb
	jr c,L_6F1B		;6eed
L_6EEF:
	call anda		;6eef   ; anda: segun la direccion de A: velocidad y lado
L_6EF2:
	ld de,06f2ah		;6ef2   ; la curva de 0x6F2A, 30 cuadros: lo que sube o baja el sprite
	ld hl,0c4a0h		;6ef5   ; 0xC4A0: el cuadro del salto
	ld a,(hl)			;6ef8
	inc (hl)			;6ef9
	cp 01eh		;6efa   ; 30
	jr nc,L_6F08		;6efc
	call 04088h		;6efe   ; de_mas_a: DE += A
	ld a,(de)			;6f01
	ld hl,0c498h		;6f02   ; a la y de los sprites (el jugador no se mueve; el dibujo si)
	add a,(hl)			;6f05
	ld (hl),a			;6f06
	ret			;6f07
L_6F08:
	xor a			;6f08   ; acabado: estado 0, todo a cero
	ld (0c490h),a		;6f09   ; guarda el estado del jugador
	ld (0c4a0h),a		;6f0c
	ld (0c49fh),a		;6f0f   ; guarda la accion del jugador
	ld (0c4aah),a		;6f12
	ld (0c4a5h),a		;6f15
	ret			;6f18
L_6F19:
	rr c		;6f19   ; la direccion del salto...
L_6F1B:
	rr c		;6f1b
L_6F1D:
	rr c		;6f1d
L_6F1F:
	rr c		;6f1f   ; ... apretada otra vez:
	jr nc,L_6EEF		;6f21
	ld a,001h		;6f23   ; 0xC4AA = 1
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


jugador_cayendo:		; estado 2: baja y, al acabar la musica, pierde
	ld hl,0c4a8h		;6f48   ; estado 2, muriendo: 15 cuadros bajando 2 puntos...
	ld a,(hl)			;6f4b   ; la cuenta
	and a			;6f4c
	jr z,L_6F58		;6f4d
	ex de,hl			;6f4f
	ld hl,0c498h		;6f50   ; apunta a la y de los sprites del jugador
	inc (hl)			;6f53   ; 2 mas abajo
	inc (hl)			;6f54
	ex de,hl			;6f55
	dec (hl)			;6f56   ; un cuadro menos
	ret			;6f57
L_6F58:
	ld a,(0c0abh)		;6f58   ; ... y cuando acaba la musica, lo que se pierde
	and a			;6f5b
	ret nz			;6f5c
	jp pierde		;6f5d   ; pierde: fuera las cosas 0 y 1, a la entrada de la zona y el dinero a la mitad
sprites_en_la_y:		; los 16 sprites de la copia en la y del jugador + C
	ld c,006h		;6f60   ; los 16 sprites de la copia, en la y del jugador + 6...
	jr L_6F66		;6f62
sprites_en_la_y_del_jugador:		; los 16 sprites de la copia en la y del jugador
	ld c,000h		;6f64   ; ... o en su y
L_6F66:
	ld hl,0ee00h		;6f66   ; la copia de los atributos
	ld b,010h		;6f69   ; 16 sprites
L_6F6B:
	ld a,b			;6f6b   ; los 8 primeros, 16 puntos mas abajo
	cp 009h		;6f6c
	ld a,(0c494h)		;6f6e   ; lee la y del jugador
	jr nc,L_6F75		;6f71
	add a,010h		;6f73
L_6F75:
	add a,c			;6f75
	ld (hl),a			;6f76   ; la y
	inc hl			;6f77
	ld (hl),000h		;6f78   ; x 0, patron 0x1C
	inc hl			;6f7a
	ld (hl),01ch		;6f7b
	inc hl			;6f7d
	inc hl			;6f7e
	djnz L_6F6B		;6f7f   ; 4 bytes por sprite
	ld hl,0ec00h		;6f81   ; y los colores, a 0
	ld de,0ec01h		;6f84
	ld (hl),000h		;6f87
	ld bc,000ffh		;6f89
	ldir		;6f8c
	ret			;6f8e
jugador_despedido:		; estado 3: sin vida o sin tiempo, sale despedido
	ld a,(0c491h)		;6f8f   ; estado 3: sin vida o sin tiempo (p01:7193, p03:B7C4); el paso en 0xC491
	ld b,a			;6f92
	ld hl,0c4a8h		;6f93
	djnz L_6FBD		;6f96   ; paso 1: al acabar la cuenta, sale despedido...
	dec (hl)			;6f98
	ret nz			;6f99
	ld hl,0fe80h		;6f9a   ; ... hacia arriba...
	ld (0c49bh),hl		;6f9d
	ld a,(0c49ah)		;6fa0   ; ... y hacia el lado contrario al que esta (0x200)
	rla			;6fa3
	ld de,00200h		;6fa4
	call c,08c0ah		;6fa7   ; niega_de: DE = -DE
	ld (0c49dh),de		;6faa
	ld a,(0c49ah)		;6fae   ; cerca del borde, sin paso 2
	sub 0e0h		;6fb1
	cp 040h		;6fb3
	jp c,L_7064		;6fb5
	call paso_siguiente_del_jugador		;6fb8   ; paso_siguiente_del_jugador: 0xC491 + 1
	jr L_6FC1		;6fbb
L_6FBD:
	djnz L_6FD6		;6fbd   ; paso 2
	dec (hl)			;6fbf
	ret nz			;6fc0
L_6FC1:
	ld a,(0c49ah)		;6fc1   ; frena (0x40 por cuadro)
	rla			;6fc4   ; el bit 7 de la x: en que mitad
	ld de,00040h		;6fc5
	call nc,08c0ah		;6fc8   ; niega_de: DE = -DE
	ld (0c4abh),de		;6fcb   ; 0xC4AB: lo que frena
	xor a			;6fcf
	ld (0c4adh),a		;6fd0
	jp paso_siguiente_del_jugador		;6fd3   ; paso_siguiente_del_jugador: 0xC491 + 1
L_6FD6:
	djnz L_704E		;6fd6   ; paso 3: el vaiven
	ld hl,(0c49dh)		;6fd8   ; la velocidad horizontal...
	ld de,(0c4abh)		;6fdb
	ld a,(0c4adh)		;6fdf   ; ... frena o acelera (0xC4AD)...
	and a			;6fe2
	call nz,08c0ah		;6fe3   ; niega_de: DE = -DE
	add hl,de			;6fe6
	ld (0c49dh),hl		;6fe7
	ld a,h			;6fea   ; ... y cuando pasa de 2 puntos por cuadro, cambia
	inc a			;6feb
	inc a			;6fec
	cp 004h		;6fed
	ld hl,0c4adh		;6fef
	jr c,L_6FF8		;6ff2
	ld a,(hl)			;6ff4
	xor 001h		;6ff5
	ld (hl),a			;6ff7
L_6FF8:
	ld hl,0c498h		;6ff8   ; por abajo de la pantalla...
	ld a,(hl)			;6ffb   ; la y
	cp 0f0h		;6ffc
	ld b,001h		;6ffe
	jr c,L_7005		;7000
	dec b			;7002
	ld (hl),0f8h		;7003   ; fuera, en 0xF8
L_7005:
	ld a,(0c0abh)		;7005   ; ... y sin musica: lo que se pierde
	or b			;7008
	ret nz			;7009
pierde:		; fuera las cosas 0 y 1, a la entrada de la zona y el dinero a la mitad
	xor a			;700a   ; al perder una vida: fuera 0xC263, la cosa 0x0A, las cosas 0 y 1 y el pasadizo...
	ld (0c263h),a		;700b
	ld (0c27eh),a		;700e
	ld hl,0c270h		;7011   ; apunta a las 10 cosas del marcador
	ld (hl),a			;7014
	inc hl			;7015
	ld (hl),a			;7016
	ld (0c483h),a		;7017   ; guarda si esta en un pasadizo
	inc a			;701a   ; ... a la zona por su entrada...
	ld (0c268h),a		;701b   ; guarda si ya entro en la zona
dinero_a_la_mitad:		; el dinero (BCD) entre dos
	ld hl,0c266h		;701e   ; ... y el DINERO a la mitad (en BCD)
	xor a			;7021
	rrd		;7022   ; las cifras de arriba: cada una a la mitad...
	srl (hl)		;7024
	ld c,000h		;7026
	jr nc,L_702C		;7028
	ld c,005h		;702a   ; ... y si era impar, 5 a la de al lado
L_702C:
	srl a		;702c   ; la cifra de abajo / 2
	rld		;702e
	ld b,000h		;7030
	jr nc,L_7036		;7032
	ld b,050h		;7034   ; si era impar, 50 para el byte de abajo
L_7036:
	ld a,(hl)			;7036   ; + 5 si la de arriba era impar
	add a,c			;7037
	ld (hl),a			;7038
	dec l			;7039   ; las de abajo, igual
	xor a			;703a
	rrd		;703b   ; el byte de abajo...
	srl (hl)		;703d   ; ... la cifra de arriba / 2
	ld c,000h		;703f
	jr nc,L_7045		;7041
	ld c,005h		;7043
L_7045:
	srl a		;7045   ; la de abajo / 2
	rld		;7047
	ld a,(hl)			;7049
	add a,b			;704a   ; + lo que baja del byte de arriba y de su cifra
	add a,c			;704b
	ld (hl),a			;704c
	ret			;704d
L_704E:
	ld hl,00000h		;704e   ; paso 4: quieto...
	ld (0c49bh),hl		;7051
	ld (0c49dh),hl		;7054
	ld a,(0c4a7h)		;7057
	and a			;705a
	ret nz			;705b
	ld a,004h		;705c   ; ... y parpadeando
	ld (0c49fh),a		;705e   ; guarda la accion del jugador
	ld (0c4aeh),a		;7061   ; guarda el parpadeo del jugador
L_7064:
	ld a,010h		;7064   ; 16 cuadros
	ld (0c4a8h),a		;7066
paso_siguiente_del_jugador:		; 0xC491 + 1
	ld hl,0c491h		;7069   ; el paso siguiente
	inc (hl)			;706c
	ret			;706d
jugador_al_pasadizo:		; estado 4: baja dando vueltas y entra o sale del pasadizo
	ld a,(0c00dh)		;706e   ; estado 4: bajando a un pasadizo; da vueltas (el lado cambia cada 2 cuadros)
	rra			;7071   ; la cuenta / 2, de 0 a 3...
	and 003h		;7072
	ld b,a			;7074
	jr z,L_7083		;7075   ; ... 0 y 3: lado 0 (arriba)...
	cp 003h		;7077
	jr z,L_7083		;7079
	ld b,002h		;707b   ; ... 1: lado 2, 2: lado 1
	cp 001h		;707d
	jr z,L_7083		;707f
	ld b,001h		;7081
L_7083:
	ld a,b			;7083
	ld (0c4a2h),a		;7084   ; guarda el lado al que mira el jugador
	ex de,hl			;7087
	ld hl,0c498h		;7088   ; un punto mas abajo cada cuadro
	inc (hl)			;708b
	ex de,hl			;708c
	ld hl,0c4a8h		;708d   ; hasta acabar la cuenta de 0xC4A8
	dec (hl)			;7090
	ret nz			;7091
	xor a			;7092
	ld hl,00000h		;7093
	ld (0c490h),a		;7096   ; estado 0 y quieto
	ld (0c4a3h),hl		;7099
	ld hl,0c483h		;709c   ; dentro o fuera del pasadizo, al reves que antes
	ld a,(hl)			;709f
	xor 001h		;70a0
	ld (hl),a			;70a2
	call borra_las_de_0xcc00		;70a3   ; borra_las_de_0xcc00: 0xCC00-0xCCFF a cero
	jp pasadizo		;70a6   ; pasadizo: se entra o se sale de un pasadizo
jugador_sale_de_la_zona:		; estado 5: la puerta y sube; al acabar, 0xC282 = 1
	ld hl,0c49bh		;70a9   ; estado 5: la salida de la zona; quieto
	xor a			;70ac   ; las dos velocidades a cero
	ld (hl),a			;70ad
	inc hl			;70ae
	ld (hl),a			;70af
	inc hl			;70b0
	ld (hl),a			;70b1
	inc hl			;70b2
	ld (hl),a			;70b3
	ld hl,0c4a8h		;70b4   ; 0xC4A8 cuenta hacia atras
	ld a,(hl)			;70b7
	and a			;70b8
	jr z,L_70E0		;70b9   ; a cero: fuera
	dec (hl)			;70bb
	ld a,(hl)			;70bc
	cp 03dh		;70bd   ; los primeros cuadros, quieto
	ret nc			;70bf
	cp 03ch		;70c0
	jr z,pinta_la_puerta		;70c2   ; a 0x3C, se pinta la puerta
	ld a,(0c00dh)		;70c4   ; la pose cambia cada 4 cuadros
	push af			;70c7
	and 003h		;70c8
	jr nz,L_70D3		;70ca
	ld hl,0c49fh		;70cc   ; la otra pose
	ld a,(hl)			;70cf
	xor 001h		;70d0
	ld (hl),a			;70d2
L_70D3:
	pop af			;70d3   ; y sube un punto cada 8
	and 007h		;70d4
	ret nz			;70d6
	ld hl,0c494h		;70d7   ; apunta a la y del jugador
	dec (hl)			;70da
	ld hl,0c498h		;70db   ; apunta a la y de los sprites del jugador
	dec (hl)			;70de
	ret			;70df
L_70E0:
	ld a,0e0h		;70e0   ; a cero: el jugador fuera de la pantalla...
	ld (0c494h),a		;70e2   ; guarda la y del jugador
	ld a,0f0h		;70e5
	ld (0c498h),a		;70e7   ; guarda la y de los sprites del jugador
	ld a,(0c0abh)		;70ea   ; ... y al acabar la musica, 0xC282 = 1: la zona pasada (estado 8)
	and a			;70ed
	ret nz			;70ee
	ld a,001h		;70ef
	ld (0c282h),a		;70f1
	ret			;70f4
pinta_la_puerta:		; la puerta de salida de la zona, 32 x 32
	ld a,(0c289h)		;70f5   ; la puerta: 32 x 32 de (0x00, 0xA0) de la pagina 1 a (0x70, 0x40)...
	cp 004h		;70f8   ; el juego 4 tiene la puerta en otro sitio
	ld hl,000a0h		;70fa
	ld de,07040h		;70fd
	jr nz,L_7106		;7100
	ld h,0a8h		;7102   ; ... en el juego 4, de (0xA8, 0xA0) a (0x80, 0x40)
	ld d,080h		;7104
L_7106:
	ld bc,02020h		;7106
	ld a,040h		;7109
	jp 04803h		;710b   ; lmmm: orden LMMM del V9938: copia un rectangulo con operacion logica
baja_0xc4a7:		; 0xC4A7 cuenta hasta 0
	ld hl,0c4a7h		;710e   ; 0xC4A7 cuenta hacia atras hasta 0
	ld a,(hl)			;7111   ; ya a cero
	and a			;7112
	ret z			;7113
	dec (hl)			;7114   ; uno menos
	ret			;7115
prisas:		; por debajo de 50 segundos, su musica
	ld a,(0c490h)		;7116   ; la musica de las prisas
	cp 003h		;7119   ; despedido: nada
	ret z			;711b
	call justo_en_50		;711c   ; la primera vez
	ld de,(0c4b0h)		;711f   ; por debajo de 50 segundos...
	ld a,d			;7123   ; cien o mas: nada
	and a			;7124
	ret nz			;7125
	ld a,e			;7126   ; 50 o mas: nada
	cp 050h		;7127
	ret nc			;7129
	ld a,(0c0abh)		;712a   ; suena algo: nada
	and a			;712d
	ret nz			;712e
	jp 0416fh		;712f   ; musica_de_la_zona: la musica del juego de graficos de la zona (tabla 0x4182)
justo_en_50:		; si el tiempo esta justo en 50 segundos, la musica de las prisas una vez
	ld b,000h		;7132   ; justo en 50 segundos...
	ld de,(0c4b0h)		;7134   ; lee el TIEMPO (BCD) y el byte siguiente (16 bits)
	ld a,d			;7138   ; las centenas a 0...
	and a			;7139
	jr nz,L_7143		;713a
	ld a,e			;713c   ; ... y 50 justos
	cp 050h		;713d
	jr nz,L_7143		;713f
	ld b,001h		;7141   ; B = 1
L_7143:
	ld hl,0c269h		;7143   ; ... la primera vez (0xC269)...
	ld a,(hl)			;7146
	xor b			;7147   ; si antes no lo era...
	and b			;7148
	call nz,musica_de_las_prisas		;7149   ; musica_de_las_prisas: 0xC0AF = 1 y la musica 0x12
	ld (hl),b			;714c   ; se apunta como esta
	ret			;714d
musica_de_las_prisas:		; 0xC0AF = 1 y la musica 0x12
	ld a,001h		;714e   ; ... 0xC0AF = 1 y, fuera de los pasadizos, la musica 0x12
	ld (0c0afh),a		;7150
	ld a,(0c483h)		;7153   ; lee si esta en un pasadizo
	and a			;7156
	ret nz			;7157
	ld a,092h		;7158
	jp 04fe4h		;715a   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
sin_vida_o_tiempo:		; sin vida (y sin la cosa 7) o sin tiempo: estado 3
	ld a,(0c481h)		;715d   ; sin vida...
	and a			;7160   ; sin vida
	jr z,L_716C		;7161
	ld bc,(0c4b0h)		;7163   ; ... o sin tiempo, estado 3
	ld a,b			;7167   ; tiempo 0?
	or c			;7168
	ret nz			;7169
	jr L_7183		;716a
L_716C:
	ld hl,0c277h		;716c   ; sin vida y con la cosa 7: se gasta y la vida vuelve entera
	ld a,(hl)			;716f
	and a			;7170
	jr z,L_7183		;7171
	ld (hl),000h		;7173
	ld a,(0c480h)		;7175   ; lee la vida maxima
	ld (0c481h),a		;7178   ; guarda la VIDA del jugador
	call 05890h		;717b   ; pinta_la_vida: pinta la barra de vida
	ld a,007h		;717e
	jp 057fah		;7180   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
L_7183:
	call borra_las_figuras		;7183   ; estado 3: fuera las figuras...
	call esconde_los_sprites_de_ram		;7186   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	xor a			;7189
	ld (0c492h),a		;718a
	ld (0c4d0h),a		;718d
	ld (0c4e0h),a		;7190
	ld a,003h		;7193
	ld (0c490h),a		;7195   ; guarda el estado del jugador
	ld a,020h		;7198   ; ... 32 cuadros...
	ld (0c4a7h),a		;719a
	ld a,08bh		;719d   ; ... y la musica 0x0B
	jp 04fe4h		;719f   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
direccion_que_vale:		; 0xC485 = la direccion apretada
	ld hl,0c485h		;71a2   ; 0xC485: la direccion que vale
	ld a,(0c007h)		;71a5   ; lo apretado...
	and 00fh		;71a8   ; las direcciones
	ld b,a			;71aa
	jr z,L_71B9		;71ab   ; nada: 0
	ld a,(0c006h)		;71ad   ; ... si no es nuevo y no esta lo de antes, todo
	and 00fh		;71b0   ; algo nuevo: todo
	jr nz,L_71B9		;71b2
	ld a,b			;71b4   ; lo de antes sigue apretado: se queda
	and (hl)			;71b5
	jr nz,L_71B9		;71b6
	ld a,b			;71b8   ; si no, todo
L_71B9:
	ld (hl),a			;71b9   ; 0xC485
	ret			;71ba
bordes:		; por los lados se sale de la casilla; puertas e interiores
	ld a,(0c490h)		;71bb   ; el jugador en los bordes
	cp 003h		;71be
	ret z			;71c0
	ld a,(0c483h)		;71c1   ; lee si esta en un pasadizo
	and a			;71c4
	jr nz,L_71D1		;71c5
	ld a,(0c482h)		;71c7   ; en la pantalla especial, p01:729D
	and a			;71ca
	jp nz,salida_del_interior		;71cb   ; salida_del_interior: con abajo en la salida, fuera del interior
	call puertas		;71ce   ; puertas: con arriba ante una puerta, se entra en el interior
L_71D1:
	ld hl,0c283h		;71d1   ; por los lados de la pantalla se sale de la casilla
	ld de,0c496h		;71d4   ; apunta a la x del jugador
	ld a,(de)			;71d7
	cp 0f7h		;71d8   ; x 0xF7 o mas: por la derecha (4), y aparece en x 0x0A
	jr nc,L_71E7		;71da
	cp 00ah		;71dc   ; menos de x 0x0A: por la izquierda (3), y aparece en x 0xF6
	jr nc,L_71F2		;71de
	ld (hl),003h		;71e0
	ld a,0f6h		;71e2
	ld (de),a			;71e4
	jr L_71EC		;71e5
L_71E7:
	ld (hl),004h		;71e7   ; por la derecha (4), y aparece en x 0x0A
	ld a,00ah		;71e9
	ld (de),a			;71eb
L_71EC:
	inc de			;71ec   ; la x de los sprites, igual
	inc de			;71ed
	inc de			;71ee
	inc de			;71ef
	ld (de),a			;71f0
	ret			;71f1
L_71F2:
	ld hl,0c520h		;71f2   ; la primera cosa de la pantalla (0xC520): 1 o 2...
	ld a,(hl)			;71f5   ; C = la salida
	ld c,a			;71f6
	and a			;71f7
	ret z			;71f8   ; ninguna
	ld d,050h		;71f9   ; ... su y, 0x50 o 0xC8
	dec a			;71fb   ; la 1 en y 0x50
	jr z,L_7200		;71fc
	ld d,0c8h		;71fe
L_7200:
	ld a,(0c494h)		;7200   ; el jugador a menos de 8 de esa y...
	sub d			;7203
	cp 008h		;7204
	ret nc			;7206
	ld a,(0c496h)		;7207   ; ... y entre x 0x40 y 0x60...
	sub 040h		;720a
	cp 020h		;720c
	ret nc			;720e
	ld a,(0c007h)		;720f   ; ... con la direccion que toca apretada
	ld b,a			;7212
	ld a,(0c4a5h)		;7213   ; y la del salto
	or b			;7216
	ld b,a			;7217
	ld a,c			;7218   ; la 1...
	dec a			;7219
	ld a,b			;721a
	jr nz,L_7221		;721b
	rra			;721d   ; ... con arriba
	ret nc			;721e
	jr L_7224		;721f
L_7221:
	rra			;7221   ; la 2, con abajo
	rra			;7222
	ret nc			;7223
L_7224:
	inc hl			;7224   ; por esa salida: los colores del sitio que toquen...
	ld a,(hl)			;7225
	ld (0c267h),a		;7226   ; guarda los colores del sitio
	xor a			;7229   ; ... quieto...
	ld (0c490h),a		;722a   ; guarda el estado del jugador
	ld (0c4a0h),a		;722d
	ld (0c49fh),a		;7230   ; guarda la accion del jugador
	ld (0c4a5h),a		;7233
	ld a,050h		;7236   ; ... en x 0x50...
	ld (0c49ah),a		;7238   ; guarda la x de los sprites del jugador
	ld (0c496h),a		;723b   ; guarda la x del jugador
	dec hl			;723e   ; ... y se sale por el lado de la tabla
	ld a,(hl)			;723f
	ld (0c283h),a		;7240   ; guarda por donde se sale de la casilla (1-4 arriba, abajo, izquierda, derecha; 5 y 6 otros; 0 nada)
	dec a			;7243   ; por arriba (1) aparece en y 0xC4; si no, en y 0x54
	jr z,L_724F		;7244
	ld a,054h		;7246
	ld (0c498h),a		;7248   ; guarda la y de los sprites del jugador
	ld (0c494h),a		;724b   ; guarda la y del jugador
	ret			;724e
L_724F:
	ld a,0c4h		;724f
	ld (0c498h),a		;7251   ; guarda la y de los sprites del jugador
	ld (0c494h),a		;7254   ; guarda la y del jugador
	ret			;7257
puertas:		; con arriba ante una puerta, se entra en el interior
	ld a,(0c490h)		;7258   ; las puertas: las dos primeras cosas de la pantalla (0xC500, de 16 en 16)
	and a			;725b   ; en el suelo
	ret nz			;725c
	ld hl,0c500h		;725d
	ld b,002h		;7260   ; dos puertas
L_7262:
	push hl			;7262
	inc l			;7263   ; [1] la y de la puerta (0, no hay)
	ld a,(hl)			;7264
	and a			;7265
	jr z,L_7295		;7266
	ld a,(0c494h)		;7268   ; el jugador a menos de 6 de ella...
	sub (hl)			;726b
	cp 006h		;726c
	jr nc,L_7295		;726e
	inc l			;7270   ; ... y [2] entre x - 8 y x + 8...
	ld a,(hl)			;7271
	sub 008h		;7272
	ld c,a			;7274
	ld a,(0c496h)		;7275   ; lee la x del jugador
	sub c			;7278
	cp 010h		;7279
	jr nc,L_7295		;727b
	ld a,(0c007h)		;727d   ; ... con arriba apretado:
	rra			;7280
	jr nc,L_7295		;7281
	pop hl			;7283
	set 7,(hl)		;7284   ; se entra: el bit 7 de la puerta, para volver a salir por ella...
	xor a			;7286
	ld (0c4a7h),a		;7287
	ld a,001h		;728a   ; ... 0xC482 = 1 (dentro de un interior) y se sale por el lado 5
	ld (0c482h),a		;728c   ; guarda la pantalla especial
	ld a,005h		;728f
	ld (0c283h),a		;7291   ; guarda por donde se sale de la casilla (1-4 arriba, abajo, izquierda, derecha; 5 y 6 otros; 0 nada)
	ret			;7294
L_7295:
	pop hl			;7295
	ld de,00010h		;7296   ; la siguiente
	add hl,de			;7299
	djnz L_7262		;729a
	ret			;729c
salida_del_interior:		; con abajo en la salida, fuera del interior
	ld a,(0cd2eh)		;729d   ; dentro de un interior: la salida esta abajo en medio (0x78-0x88, 0xBC-0xCC)
	and a			;72a0   ; 0xCD2E puesto: no se puede salir
	ret nz			;72a1
	ld a,(0c494h)		;72a2   ; lee la y del jugador
	sub 0bch		;72a5
	cp 010h		;72a7
	ret nc			;72a9
	ld a,(0c496h)		;72aa   ; lee la x del jugador
	sub 078h		;72ad
	cp 010h		;72af
	ret nc			;72b1
	ld a,(0c007h)		;72b2   ; con abajo apretado...
	rra			;72b5
	rra			;72b6
	ret nc			;72b7
L_72B8:
	xor a			;72b8   ; ... fuera del interior, por el lado 6
	ld (0c482h),a		;72b9   ; guarda la pantalla especial
	ld a,006h		;72bc
	ld (0c283h),a		;72be   ; guarda por donde se sale de la casilla (1-4 arriba, abajo, izquierda, derecha; 5 y 6 otros; 0 nada)
	ld hl,0c500h		;72c1   ; la puerta por la que se entro (bit 7)...
	ld b,003h		;72c4
L_72C6:
	ld a,(hl)			;72c6
	rla			;72c7
	jr nc,L_72DF		;72c8
	res 7,(hl)		;72ca
	inc hl			;72cc
	ld a,(hl)			;72cd   ; ... y el jugador delante de ella, 8 mas abajo
	add a,008h		;72ce
	ld (0c498h),a		;72d0   ; guarda la y de los sprites del jugador
	ld (0c494h),a		;72d3   ; guarda la y del jugador
	inc hl			;72d6
	ld a,(hl)			;72d7
	ld (0c49ah),a		;72d8   ; guarda la x de los sprites del jugador
	ld (0c496h),a		;72db   ; guarda la x del jugador
	ret			;72de
L_72DF:
	ld de,00010h		;72df   ; la siguiente de las tres
	add hl,de			;72e2
	djnz L_72C6		;72e3
	ret			;72e5
salidas_especiales:		; las puertas de 0xC28A: la de la zona (3 cosas 9) y la de la fase
	ld a,(0c28ah)		;72e6   ; las salidas de 0xC28A (lo pone p00:5262 segun la pantalla): 1, 2 o 3
	and a			;72e9
	ret z			;72ea   ; ninguna
	dec a			;72eb   ; la 2
	dec a			;72ec
	jr z,L_7366		;72ed
	dec a			;72ef   ; la 3
	jr z,L_7332		;72f0
	ld a,(0c279h)		;72f2   ; la 1: hacen falta 3 de la cosa 9 (0xC279)
	cp 003h		;72f5
	ret c			;72f7
	ld a,(0c496h)		;72f8   ; x 0x70-0x90
	sub 070h		;72fb
	cp 020h		;72fd
	ret nc			;72ff
L_7300:
	ld a,(0c494h)		;7300   ; y 0x60-0x68, con arriba apretado:
	sub 060h		;7303
	cp 008h		;7305
	ret nc			;7307
	ld a,(0c007h)		;7308   ; lee lo apretado: bits 0-3 arriba, abajo, izquierda, derecha; 4 y 5 los botones
	rra			;730b
	ret nc			;730c
	call borra_las_figuras		;730d   ; fuera las figuras...
	call esconde_los_sprites_de_ram		;7310   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	call las_dos_de_0xc4d3		;7313   ; las_dos_de_0xc4d3: p01:76AC con 0xC4D3 y con 0xC4E3
	ld a,05ah		;7316   ; ... 90 cuadros de estado 5 (la salida de la zona)...
	ld (0c4a8h),a		;7318
	ld a,005h		;731b
	ld (0c490h),a		;731d   ; guarda el estado del jugador
	xor a			;7320
	ld (0c4a2h),a		;7321   ; guarda el lado al que mira el jugador
	ld (0c49fh),a		;7324   ; guarda la accion del jugador
	ld (0c4a7h),a		;7327   ; ... se gastan las cosas 9...
	ld (0c279h),a		;732a
	ld a,08fh		;732d   ; ... y la musica 0x0F
	jp 04fe4h		;732f   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_7332:
	ld a,(0c496h)		;7332   ; la 3: x 0x98-0xA8, y 0x60-0x68, con arriba...
	sub 098h		;7335
	cp 010h		;7337
	ret nc			;7339
	ld a,(0c494h)		;733a   ; lee la y del jugador
	sub 060h		;733d
	cp 008h		;733f
	ret nc			;7341
	ld a,(0c007h)		;7342   ; lee lo apretado: bits 0-3 arriba, abajo, izquierda, derecha; 4 y 5 los botones
	rra			;7345
	ret nc			;7346
	call borra_las_figuras		;7347   ; borra_las_figuras: el tipo a 0 en las ocho fichas de 0xC600 y las ocho de 0xCA00
	call esconde_los_sprites_de_ram		;734a   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	call las_dos_de_0xc4d3		;734d   ; las_dos_de_0xc4d3: p01:76AC con 0xC4D3 y con 0xC4E3
	xor a			;7350
	ld (0c4a2h),a		;7351   ; guarda el lado al que mira el jugador
	ld (0c49fh),a		;7354   ; guarda la accion del jugador
	ld (0c4a7h),a		;7357   ; ... 0xC28B = 1: la fase pasada (estado 0x0B)...
	inc a			;735a
	ld (0c28bh),a		;735b
	call 04cabh		;735e   ; sprites_del_jugador: sube los sprites del jugador
	ld a,000h		;7361   ; ... y fuera la musica
	jp 04fe4h		;7363   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_7366:
	ld a,(0c496h)		;7366   ; la 2: x 0x80-0xA0, sin mirar la cosa 9
	sub 080h		;7369   ; x 0x80-0xA0
	cp 020h		;736b
	ret nc			;736d
	jr L_7300		;736e
mueve_al_jugador:		; posicion += velocidad
	ld hl,(0c493h)		;7370   ; la y del jugador y la de sus sprites += la velocidad vertical (con su fraccion)
	ld de,(0c49bh)		;7373   ; la velocidad vertical
	add hl,de			;7377
	ld (0c493h),hl		;7378
	ld hl,(0c497h)		;737b   ; la de los sprites, igual
	add hl,de			;737e
	ld (0c497h),hl		;737f
	ld hl,(0c495h)		;7382   ; la x += la horizontal
	ld de,(0c49dh)		;7385   ; la horizontal
	add hl,de			;7389
	ld (0c495h),hl		;738a
	ld hl,(0c499h)		;738d   ; la de los sprites
	add hl,de			;7390
	ld (0c499h),hl		;7391
	ret			;7394
donde_para_el_salto:		; 0xC4A6: los pasos del salto en los que hay pared
	ld a,(0c494h)		;7395   ; al saltar: el caracter de delante, en la direccion del salto
	sub 002h		;7398   ; la fila de la cabeza
	and 0f8h		;739a
	ld e,a			;739c
	ld a,(0c496h)		;739d   ; lee la x del jugador
	and 0f8h		;73a0   ; la columna
	ld d,a			;73a2
	ld a,(0c4a5h)		;73a3   ; la direccion del salto: arriba, abajo, izquierda o derecha, de 8 en 8
	ld c,a			;73a6
	rr c		;73a7
	call c,e_8_arriba		;73a9   ; e_8_arriba: E -= 8
	rr c		;73ac
	call c,e_8_abajo		;73ae   ; e_8_abajo: E += 8
	rr c		;73b1
	call c,d_8_izquierda		;73b3   ; d_8_izquierda: D -= 8
	rr c		;73b6
	call c,d_8_derecha		;73b8   ; d_8_derecha: D += 8
	xor a			;73bb   ; 0xC4A6: un bit por paso en el que el salto se para
	ld (0c4a6h),a		;73bc
	ld (0ee80h),a		;73bf
	ld a,(0c270h)		;73c2   ; tantos pasos como cosas 0 lleve, mas 2
	inc a			;73c5
	inc a			;73c6
	ld b,a			;73c7
	ld c,001h		;73c8
L_73CA:
	push bc			;73ca
	call caracter_bajo		;73cb   ; el caracter de ese paso...
	ld a,h			;73ce   ; ... dentro del mapa (0xD800-0xDABF)
	sub 0d8h		;73cf   ; las filas 0xD8, 0xD9 y 0xDA hasta 0xDABF
	cp 003h		;73d1
	jr nc,L_73EE		;73d3
	cp 002h		;73d5
	jr nz,L_73DE		;73d7
	ld a,l			;73d9
	cp 0c0h		;73da
	jr nc,L_73EE		;73dc
L_73DE:
	ld a,(0ee80h)		;73de   ; fuera de la pantalla: pared
	and a			;73e1
	jr nz,L_73EE		;73e2
	ld a,(0c4f1h)		;73e4   ; por debajo de 0xC4F1, se puede
	ld b,a			;73e7
	ld a,(hl)			;73e8   ; el caracter
	cp b			;73e9
	ld c,000h		;73ea   ; C = 0: se puede
	jr c,L_73F0		;73ec
L_73EE:
	ld c,001h		;73ee   ; C = 1: ahi se para
L_73F0:
	xor a			;73f0   ; el bit del paso
	ld a,c			;73f1   ; C = 1: pared
	pop bc			;73f2
	push bc			;73f3
	ld b,c			;73f4   ; B = el numero del paso
	rra			;73f5
L_73F6:
	rla			;73f6   ; el bit, en su sitio
	djnz L_73F6		;73f7
	ld hl,0c4a6h		;73f9   ; a 0xC4A6
	or (hl)			;73fc
	ld (hl),a			;73fd
	ld a,(0c4a5h)		;73fe   ; el paso siguiente, 16 puntos mas alla
	ld c,a			;7401
	rr c		;7402
	call c,e_16_arriba		;7404   ; e_16_arriba: E -= 16
	rr c		;7407
	call c,e_16_abajo		;7409   ; e_16_abajo: E += 16
	rr c		;740c
	call c,d_16_izquierda		;740e   ; d_16_izquierda: D -= 16, y si se sale, 0xEE80 = 1
	rr c		;7411
	call c,d_16_derecha		;7413   ; d_16_derecha: D += 16, y si se sale, 0xEE80 = 1
	pop bc			;7416
	inc c			;7417   ; el paso siguiente
	djnz L_73CA		;7418
	ret			;741a
hasta_donde_salta:		; segun las cosas 0, A = 0 sigue o compara con los cuadros del salto
	ld a,(0c4a6h)		;741b   ; hasta donde llega el salto: segun cuantas cosas 0 lleve (tabla de 0x7425)
	ld c,a			;741e
	ld a,(0c270h)		;741f   ; lee las 10 cosas del marcador
	call 0408dh		;7422   ; despacha: salta a la entrada A de la tabla que va detras del call

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
	ld a,c			;742d   ; con ninguna...
	rra			;742e   ; el primer paso, pared: se para ya
	jr nc,L_7475		;742f
	ld b,020h		;7431   ; el segundo, a los 32 cuadros
	rra			;7433
	jr nc,L_7470		;7434
	jr L_7475		;7436
L_7438:
	ld a,c			;7438   ; con una...
	rra			;7439
	jr nc,L_7475		;743a
	rra			;743c
	ld b,016h		;743d   ; el segundo, a los 22; el tercero, a los 36
	jr nc,L_7470		;743f
	rra			;7441
	ld b,024h		;7442
	jr nc,L_7470		;7444
	jr L_7475		;7446
L_7448:
	ld a,c			;7448   ; con dos...
	rra			;7449
	jr nc,L_7475		;744a
	rra			;744c
	ld b,010h		;744d   ; a los 16, 24 o 32
	jr nc,L_7470		;744f
	rra			;7451
	ld b,018h		;7452
	jr nc,L_7470		;7454
	rra			;7456
	ld b,020h		;7457
	jr nc,L_7470		;7459
	jr L_7475		;745b
L_745D:
	ld a,c			;745d   ; con tres...
	rra			;745e
	jr nc,L_7475		;745f
	rra			;7461
	ld b,00dh		;7462   ; a los 13, 19 o 26
	jr nc,L_7470		;7464
	rra			;7466
	ld b,013h		;7467
	jr nc,L_7470		;7469
	rra			;746b
	ld b,01ah		;746c
	jr c,L_7475		;746e
L_7470:
	ld a,(0c4a0h)		;7470   ; ... se para al llegar a B cuadros (0xC4A0)
	cp b			;7473
	ret			;7474
L_7475:
	xor a			;7475   ; A = 0: sigue
	ret			;7476
e_8_arriba:		; E -= 8
	ld a,e			;7477   ; E 8 arriba
	sub 008h		;7478   ; - 8
	ld e,a			;747a
	ret			;747b
e_8_abajo:		; E += 8
	ld a,e			;747c   ; E 8 abajo
	add a,008h		;747d   ; + 8
	ld e,a			;747f
	ret			;7480
d_8_izquierda:		; D -= 8
	ld a,d			;7481   ; D 8 a la izquierda
	sub 008h		;7482   ; - 8
	ld d,a			;7484
	ret			;7485
d_8_derecha:		; D += 8
	ld a,d			;7486   ; D 8 a la derecha
	add a,008h		;7487   ; + 8
	ld d,a			;7489
	ret			;748a
e_16_abajo:		; E += 16
	ld a,e			;748b   ; E 16 abajo
	add a,010h		;748c   ; + 16
	ld e,a			;748e
	ret			;748f
e_16_arriba:		; E -= 16
	ld a,e			;7490   ; E 16 arriba
	sub 010h		;7491   ; - 16
	ld e,a			;7493
	ret			;7494
d_16_derecha:		; D += 16, y si se sale, 0xEE80 = 1
	ld a,d			;7495   ; D 16 a la derecha
	add a,010h		;7496   ; + 16
	ld d,a			;7498
	jr L_749F		;7499
d_16_izquierda:		; D -= 16, y si se sale, 0xEE80 = 1
	ld a,d			;749b   ; D 16 a la izquierda
	sub 010h		;749c
	ld d,a			;749e
L_749F:
	ret nc			;749f   ; si se sale de la pantalla, 0xEE80 = 1
	ld a,001h		;74a0
	ld (0ee80h),a		;74a2
	ret			;74a5
sprites_del_jugador_de_ram:		; la posicion y los patrones de sus sprites en la copia de 0xEE00
	ld a,(0c002h)		;74a6   ; los sprites del jugador: Goemon (0xAA56, banco 9)...
	rla			;74a9
	ld hl,0aa56h		;74aa
	jr nc,L_74B2		;74ad
	ld hl,0aa7eh		;74af   ; ... o Ebisumaru (0xAA7E)
L_74B2:
	ld a,(0c49fh)		;74b2   ; una entrada por accion y lado
	add a,a			;74b5
	add a,a			;74b6
	ld b,a			;74b7
	ld a,(0c4a2h)		;74b8   ; lee el lado al que mira el jugador
	add a,b			;74bb
	add a,a			;74bc
	call 04d81h		;74bd   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld a,(0c490h)		;74c0   ; lee el estado del jugador
	cp 002h		;74c3   ; en los estados 0 y 1, desde el sprite 0; en los demas, desde el 16 (0xEE40)
	ld de,0ee00h		;74c5
	jr c,L_74CD		;74c8
	ld de,0ee40h		;74ca
L_74CD:
	ld b,(hl)			;74cd   ; [cuantos] y [dy][dx] por sprite
	ld c,000h		;74ce
	inc hl			;74d0
L_74D1:
	push bc			;74d1
	ld a,(0c498h)		;74d2   ; y = la del jugador + dy...
	add a,(hl)			;74d5
	ld c,a			;74d6
	ld a,(0c4a7h)		;74d7   ; ... parpadeando: en los cuadros impares de 0xC4A7, fuera (0xE0)
	and a			;74da
	jr z,L_74E2		;74db
	rra			;74dd
	jr nc,L_74E2		;74de
	ld c,0e0h		;74e0
L_74E2:
	ld a,c			;74e2
	ld (de),a			;74e3   ; la y
	inc hl			;74e4
	inc e			;74e5
	ld a,(0c492h)		;74e6   ; con el primer boton, mirando a la izquierda, los que se salen por la izquierda no se ven
	and a			;74e9
	jr z,L_750C		;74ea
	push bc			;74ec
	call hay_algo_lanzado		;74ed   ; si hay algo lanzado, no
	pop bc			;74f0
	jr nz,L_750C		;74f1
	ld a,b			;74f3   ; los tres primeros sprites (el arma)
	cp 003h		;74f4
	jr nc,L_750C		;74f6
	ld a,(0c4a2h)		;74f8   ; mirando a la izquierda
	cp 002h		;74fb
	jr nz,L_750C		;74fd
	ld a,(0c49ah)		;74ff   ; lee la x de los sprites del jugador
	add a,(hl)			;7502
	jr c,L_7510		;7503   ; sin pasar de 0, se ve
	dec e			;7505   ; si no, fuera
	ld a,0e0h		;7506
	ld (de),a			;7508
	inc e			;7509
	jr L_7511		;750a
L_750C:
	ld a,(0c49ah)		;750c   ; x = la del jugador + dx
	add a,(hl)			;750f
L_7510:
	ld (de),a			;7510   ; la x
L_7511:
	pop bc			;7511
	inc hl			;7512
	inc e			;7513
	ld a,c			;7514   ; el patron: n * 4
	add a,a			;7515
	add a,a			;7516
	ld (de),a			;7517
	inc c			;7518   ; el sprite siguiente
	inc e			;7519
	inc e			;751a
	djnz L_74D1		;751b
	ld a,(0c490h)		;751d   ; lee el estado del jugador
	sub 002h		;7520   ; estados 2, 3 y 4
	cp 003h		;7522
	jr c,L_7538		;7524
	ld de,0ee18h		;7526   ; en los estados 2-4, un sprite mas: patron 0x18 en (x - 8, y)
	ld a,(0c494h)		;7529   ; lee la y del jugador
	ld (de),a			;752c   ; la y
	inc e			;752d
	ld a,(0c496h)		;752e   ; lee la x del jugador
	sub 008h		;7531
	ld (de),a			;7533   ; la x - 8
	inc e			;7534
	ld a,018h		;7535
	ld (de),a			;7537   ; patron 0x18
L_7538:
	ld b,040h		;7538   ; los colores: 64 lineas (cuatro sprites) en 0xEC00, o en 0xED00 en los estados 2 o mas
	ld a,(0c490h)		;753a   ; lee el estado del jugador
	cp 002h		;753d
	ld hl,0ec00h		;753f
	jr c,L_7547		;7542
	ld hl,0ed00h		;7544
L_7547:
	ld a,(0c4aeh)		;7547   ; parpadeando, todo 0x0E y 2 alternando cada 2 cuadros
	and a			;754a
	jr nz,L_7575		;754b
	ld a,b			;754d   ; el cuarto sprite, del color 2; el tercero, del 1
	cp 021h		;754e   ; de la linea 33 en adelante
	ld c,002h		;7550
	jr nc,L_7580		;7552
	cp 011h		;7554   ; de la 17 a la 32
	ld c,001h		;7556
	jr nc,L_7580		;7558
	ld a,(0c002h)		;755a   ; los dos primeros: Goemon del 3 (0x0E con la cosa 1)...
	rla			;755d
	ld a,(0c271h)		;755e   ; la cosa 1
	jr c,L_756C		;7561
	and a			;7563
	ld c,003h		;7564
	jr z,L_7580		;7566
	ld c,00eh		;7568
	jr L_7580		;756a
L_756C:
	and a			;756c   ; ... Ebisumaru del 2 (3 con la cosa 1)
	ld c,002h		;756d
	jr z,L_7580		;756f
	ld c,003h		;7571
	jr L_7580		;7573
L_7575:
	ld a,(0c00dh)		;7575
	and 002h		;7578   ; cada 2 cuadros
	ld c,00eh		;757a
	jr z,L_7580		;757c
	ld c,002h		;757e
L_7580:
	ld (hl),c			;7580   ; una linea
	inc l			;7581
	djnz L_7547		;7582
	ld a,(0c490h)		;7584   ; lee el estado del jugador
	cp 002h		;7587
	ret nc			;7589   ; en el suelo o saltando
	ld a,(0c492h)		;758a   ; sin golpe, sin la cosa 1 y sin nada lanzado: los sprites del arma
	and a			;758d
	jr nz,L_75D4		;758e
	ld a,(0c271h)		;7590
	and a			;7593
	jr nz,L_75D4		;7594
	call hay_algo_lanzado		;7596   ; hay_algo_lanzado: NZ si 0xC4D0 o 0xC4E0 estan en uso
	jr nz,L_75D4		;7599
	ld hl,0ec40h		;759b   ; 32 lineas: 8 y 2 (0x0E y 2 para Ebisumaru)
	ld b,020h		;759e
L_75A0:
	ld a,b			;75a0   ; las lineas 17-32: el 2...
	dec a			;75a1
	and 010h		;75a2
	ld c,002h		;75a4
	jr nz,L_75B2		;75a6
	ld c,008h		;75a8   ; ... y las 1-16: el 8 (o 0x0E)
	ld a,(0c002h)		;75aa   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	rla			;75ad
	jr nc,L_75B2		;75ae
	ld c,00eh		;75b0
L_75B2:
	ld (hl),c			;75b2   ; una linea
	inc l			;75b3
	djnz L_75A0		;75b4
	ld a,(0c002h)		;75b6   ; lee las banderas de la partida (bit 7 jugador 2, bit 6 en juego)
	rla			;75b9   ; Ebisumaru no
	jr c,L_75D4		;75ba
	ld a,(0c4a2h)		;75bc   ; Goemon, segun el lado (0x75E0): dos lineas del color 7
	ld hl,075e0h		;75bf
	call 04083h		;75c2   ; hl_mas_a: HL += A
	ld a,(hl)			;75c5   ; 0: ninguna
	and a			;75c6
	jr z,L_75D4		;75c7
	ld hl,0ec50h		;75c9   ; en las lineas de 0xEC50 + n
	call 04083h		;75cc   ; hl_mas_a: HL += A
	ld a,007h		;75cf
	ld (hl),a			;75d1
	inc l			;75d2
	ld (hl),a			;75d3
L_75D4:
	ld hl,0ec60h		;75d4   ; 16 lineas del color 2
	ld b,010h		;75d7
	ld a,002h		;75d9
L_75DB:
	ld (hl),a			;75db   ; del color 2
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


el_golpe:		; el golpe del primer boton, o lanza algo con la cosa 1
	ld a,(0c492h)		;75e4   ; el golpe del primer boton (0xC492)
	and a			;75e7
	ret z			;75e8
	dec a			;75e9   ; 0xC492 = 1, empieza
	jr nz,L_7608		;75ea
	ld a,(0c271h)		;75ec   ; con la cosa 1, lanza algo (p01:762B)
	and a			;75ef
	jr nz,lanza		;75f0
	call hay_algo_lanzado		;75f2   ; si ya hay algo lanzado, nada
	ret nz			;75f5
	ld a,003h		;75f6   ; accion 3, 0xC492 = 2 y el efecto 8
	ld (0c49fh),a		;75f8   ; guarda la accion del jugador
	xor a			;75fb
	ld (0c4a1h),a		;75fc
	ld hl,0c492h		;75ff
	inc (hl)			;7602
	ld a,008h		;7603
	jp 04fe4h		;7605   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_7608:
	ld hl,0c4a1h		;7608   ; 0xC492 = 2: dura 5 cuadros...
	inc (hl)			;760b   ; un cuadro mas
	ld a,(hl)			;760c
	cp 005h		;760d
	ret c			;760f
	xor a			;7610   ; a cero
	ld (hl),a			;7611
	ld a,0e0h		;7612   ; ... y se esconden los sprites 4 y 5
	ld (0ee10h),a		;7614
	ld (0ee14h),a		;7617
L_761A:
	xor a			;761a   ; acabado: la accion 2 en el aire, 0 en el suelo
	ld (0c492h),a		;761b
	ld a,(0c490h)		;761e   ; lee el estado del jugador
	dec a			;7621   ; en el aire (estado 1)?
	ld a,002h		;7622
	jr z,L_7627		;7624
	xor a			;7626   ; en el suelo: 0
L_7627:
	ld (0c49fh),a		;7627   ; guarda la accion del jugador
	ret			;762a
lanza:		; en un hueco libre de 0xC4D0 o 0xC4E0, con el efecto 9
	ld hl,0c4d0h		;762b   ; lo lanzado: dos huecos de 16 bytes (0xC4D0 y 0xC4E0)
	ld b,002h		;762e
L_7630:
	ld a,(hl)			;7630   ; hueco libre?
	and a			;7631
	jr z,L_763C		;7632
	ld de,00010h		;7634   ; el otro
	add hl,de			;7637
	djnz L_7630		;7638
	jr L_761A		;763a   ; ninguno: no se lanza
L_763C:
	call velocidad_de_lo_lanzado		;763c   ; [1-2] la velocidad, [3] y, [4] x
	inc (hl)			;763f
	inc hl			;7640
	inc hl			;7641
	inc hl			;7642
	ld a,(0c498h)		;7643   ; desde 12 puntos por encima del jugador
	sub 00ch		;7646
	ld (hl),a			;7648
	inc hl			;7649
	ld a,(0c49ah)		;764a   ; lee la x de los sprites del jugador
	ld (hl),a			;764d
	ld a,009h		;764e   ; y el efecto 9
	call 04fe4h		;7650   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	jr L_761A		;7653
velocidad_de_lo_lanzado:		; 4 puntos por cuadro hacia donde mira
	push hl			;7655   ; 4 puntos por cuadro hacia donde mira: lado 0 y 2 en negativo; 0 y 1 en vertical
	inc hl			;7656   ; [1] la vertical
	ld a,(0c4a2h)		;7657   ; lee el lado al que mira el jugador
	ld c,a			;765a
	rra			;765b   ; el bit 0 del lado: 1 y 3 en positivo
	ld a,004h		;765c
	jr c,L_7662		;765e
	neg		;7660
L_7662:
	ld b,a			;7662
	ld a,c			;7663
	cp 002h		;7664   ; lados 2 y 3: en [2], la horizontal
	jr c,L_7669		;7666
	inc hl			;7668
L_7669:
	ld (hl),b			;7669   ; la velocidad
	pop hl			;766a
	ret			;766b
hay_algo_lanzado:		; NZ si 0xC4D0 o 0xC4E0 estan en uso
	ld a,(0c4d0h)		;766c   ; NZ si hay algo lanzado
	ld b,a			;766f
	ld a,(0c4e0h)		;7670
	or b			;7673
	ret			;7674
mueve_lo_lanzado:		; posicion += velocidad de los dos
	ld hl,0c4d0h		;7675   ; mueve los dos: y += [1], x += [2]
	call mueve_un_lanzado		;7678   ; mueve_un_lanzado: posicion += velocidad del lanzado HL
	ld hl,0c4e0h		;767b
mueve_un_lanzado:		; posicion += velocidad del lanzado HL
	ld a,(hl)			;767e   ; si esta en uso...
	and a			;767f
	ret z			;7680
	inc hl			;7681
	ld b,(hl)			;7682   ; B = dy, C = dx
	inc hl			;7683
	ld c,(hl)			;7684
	inc hl			;7685
	ld a,(hl)			;7686   ; y += dy
	add a,b			;7687
	ld (hl),a			;7688
	inc hl			;7689
	ld a,(hl)			;768a   ; x += dx
	add a,c			;768b
	ld (hl),a			;768c
	ret			;768d
lanzado_fuera:		; borra los que se salen de la pantalla
	ld hl,0c4d0h		;768e   ; fuera de la pantalla, se borra
	call lanzado_que_se_sale		;7691   ; lanzado_que_se_sale: borra el lanzado HL si sale de la pantalla
	ld hl,0c4e0h		;7694
lanzado_que_se_sale:		; borra el lanzado HL si sale de la pantalla
	ld a,(hl)			;7697
	and a			;7698
	ret z			;7699
	inc hl			;769a
	inc hl			;769b
	inc hl			;769c
	ld a,(hl)			;769d   ; por arriba o por abajo (y 0xE0-0xFF)...
	sub 0e0h		;769e
	cp 020h		;76a0
	jr c,borra_lo_lanzado		;76a2
	inc hl			;76a4
	ld a,(hl)			;76a5   ; ... o por los lados (x 0xF8-0x07)
	sub 0f8h		;76a6
	cp 010h		;76a8
	ret nc			;76aa
	dec hl			;76ab
borra_lo_lanzado:		; sus 16 bytes a cero y su sprite fuera
	push hl			;76ac   ; borra lo lanzado: sus 16 bytes a cero...
	ld a,l			;76ad   ; al principio de su hueco
	and 0f0h		;76ae
	ld l,a			;76b0
	ld d,h			;76b1
	ld e,l			;76b2
	inc de			;76b3
	ld (hl),000h		;76b4
	ld bc,0000fh		;76b6   ; 16 bytes
	ldir		;76b9
	pop hl			;76bb
	ld (hl),0e0h		;76bc   ; ... y su sprite fuera (0xEE10 el de 0xC4D0, 0xEE14 el de 0xC4E0)
	ld a,l			;76be   ; cual de los dos
	and 0f0h		;76bf
	cp 0d0h		;76c1
	ld hl,0ee10h		;76c3
	jr z,L_76CB		;76c6
	ld hl,0ee14h		;76c8
L_76CB:
	ld a,0e0h		;76cb
	ld (hl),a			;76cd   ; la y de sus dos sprites
	inc hl			;76ce
	ld (hl),a			;76cf
	ret			;76d0
lo_lanzado:		; un cuadro de lo lanzado
	call mueve_lo_lanzado		;76d1   ; lo lanzado, un cuadro: se mueve, se borra si sale, y sus sprites
	call lanzado_fuera		;76d4   ; lanzado_fuera: borra los que se salen de la pantalla
	call hay_algo_lanzado		;76d7   ; hay_algo_lanzado: NZ si 0xC4D0 o 0xC4E0 estan en uso
	ret z			;76da
	ld de,0c4d0h		;76db
	ld hl,0ee10h		;76de
	call sprite_del_lanzado		;76e1   ; sprite_del_lanzado: el sprite y los colores del lanzado DE en HL
	ld de,0c4e0h		;76e4
	ld hl,0ee14h		;76e7
sprite_del_lanzado:		; el sprite y los colores del lanzado DE en HL
	ld a,(de)			;76ea   ; el sprite: y - 4, x - 4, patron 0x1C
	and a			;76eb   ; sin uso: nada
	ret z			;76ec
	inc de			;76ed
	inc de			;76ee
	inc de			;76ef
	ld a,(de)			;76f0   ; la y
	sub 004h		;76f1
	ld (hl),a			;76f3
	inc hl			;76f4
	inc de			;76f5
	ld a,(de)			;76f6   ; la x
	sub 004h		;76f7
	ld (hl),a			;76f9
	inc hl			;76fa
	ld (hl),01ch		;76fb
	ld de,0ec40h		;76fd   ; y sus colores, de 0x770F
	call colores_del_lanzado		;7700   ; 16 lineas de cada sprite
	ld de,0ec50h		;7703
colores_del_lanzado:		; los 16 colores de 0x770F en DE
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


choca_arriba:		; carry si hay pared encima
	ld a,(0c494h)		;771f   ; choca por arriba: dos puntos, 5 por encima de los pies
	sub 005h		;7722
	ld e,a			;7724
	ld a,(0c496h)		;7725   ; lee la x del jugador
	ld d,a			;7728
	ld b,002h		;7729
	ld a,d			;772b
	add a,b			;772c
	ld d,a			;772d
	call caracter_bajo		;772e   ; el de la derecha
	call es_pared		;7731   ; es_pared: carry si el caracter A es pared
	ret c			;7734
	ld a,b			;7735   ; y el de la izquierda
	add a,a			;7736
	ld b,a			;7737
	ld a,d			;7738
	sub b			;7739
	ld d,a			;773a
	call caracter_bajo		;773b   ; caracter_bajo: A = el caracter de 0xD800 en el punto (D, E)
	jp es_pared		;773e   ; es_pared: carry si el caracter A es pared
choca_abajo:		; carry si hay pared debajo
	ld a,(0c494h)		;7741   ; por abajo: 3 por debajo
	add a,003h		;7744
	ld e,a			;7746
	ld a,(0c496h)		;7747   ; lee la x del jugador
	ld d,a			;774a
	ld b,002h		;774b
	ld a,d			;774d
	add a,b			;774e
	ld d,a			;774f
	call caracter_bajo		;7750   ; caracter_bajo: A = el caracter de 0xD800 en el punto (D, E)
	call es_pared		;7753   ; es_pared: carry si el caracter A es pared
	ret c			;7756
	ld a,b			;7757
	add a,a			;7758
	ld b,a			;7759
	ld a,d			;775a
	sub b			;775b
	ld d,a			;775c
	call caracter_bajo		;775d   ; caracter_bajo: A = el caracter de 0xD800 en el punto (D, E)
	jp es_pared		;7760   ; es_pared: carry si el caracter A es pared
en_un_hoyo:		; carry si bajo los dos pies hay hoyo
	ld a,(0c494h)		;7763   ; los dos caracteres bajo los pies (x - 5 y x + 5): carry si los dos son hoyo
	ld e,a			;7766
	ld a,(0c496h)		;7767   ; lee la x del jugador
	sub 005h		;776a
	ld d,a			;776c
	call caracter_bajo		;776d   ; caracter_bajo: A = el caracter de 0xD800 en el punto (D, E)
	call es_hoyo		;7770   ; es_hoyo: carry si el caracter A es hoyo
	ret nc			;7773
	ld a,d			;7774
	add a,00ah		;7775
	ld d,a			;7777
	call caracter_bajo		;7778   ; caracter_bajo: A = el caracter de 0xD800 en el punto (D, E)
	jp es_hoyo		;777b   ; es_hoyo: carry si el caracter A es hoyo
choca_derecha:		; carry si hay pared a la derecha
	ld a,(0c494h)		;777e   ; por la derecha: 8 a la derecha, 2 por encima
	ld e,a			;7781   ; E = y - 2
	ld a,(0c496h)		;7782   ; lee la x del jugador
	ld d,a			;7785   ; D = x + 8
	ld b,008h		;7786
	ld a,e			;7788
	sub 002h		;7789
	ld e,a			;778b
	ld a,d			;778c
	add a,b			;778d
	ld d,a			;778e
	call caracter_bajo		;778f   ; caracter_bajo: A = el caracter de 0xD800 en el punto (D, E)
	jr $+63		;7792   ; y si es pared (p01:77D1)
choca_izquierda:		; carry si hay pared a la izquierda
	ld a,(0c494h)		;7794   ; por la izquierda
	ld e,a			;7797
	ld a,(0c496h)		;7798   ; lee la x del jugador
	ld d,a			;779b
	ld b,008h		;779c
	ld a,e			;779e
	sub 002h		;779f
	ld e,a			;77a1
	ld a,d			;77a2
	sub b			;77a3   ; D = x - 8
	ld d,a			;77a4
	call caracter_bajo		;77a5   ; caracter_bajo: A = el caracter de 0xD800 en el punto (D, E)
	jr $+41		;77a8   ; y si es pared
topes_del_juego:		; pared y hoyos del juego de graficos, a 0xC4F0
	ld a,(0c289h)		;77aa   ; tres bytes por juego de graficos (0x77BF) a 0xC4F0: [pared desde][hoyo desde][cuantos hoyos]
	ld b,a			;77ad
	add a,a			;77ae   ; 3 bytes por juego
	add a,b			;77af
	ld hl,077bfh		;77b0
	call 04083h		;77b3   ; hl_mas_a: HL += A
	ld de,0c4f0h		;77b6
	ld bc,00003h		;77b9   ; 0xC4F0-0xC4F2
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


es_pared:		; carry si el caracter A es pared
	push af			;77d1   ; carry si el caracter A es pared
	ld a,(0c490h)		;77d2   ; saltando, segun hasta donde llega el salto (p01:741B)
	dec a			;77d5
	jr nz,L_77E5		;77d6
	push de			;77d8
	call hasta_donde_salta		;77d9   ; hasta_donde_salta: segun las cosas 0, A = 0 sigue o compara con los cuadros del salto
	pop de			;77dc
	jr nc,L_77E5		;77dd
	pop af			;77df
	cp 0ffh		;77e0   ; 0xFF no para el salto
	ret z			;77e2
	jr L_77E6		;77e3
L_77E5:
	pop af			;77e5
L_77E6:
	ld c,a			;77e6
	ld a,(0c289h)		;77e7   ; en el juego 0, los caracteres 0x6C y 0x92 tampoco son pared
	and a			;77ea
	jr z,L_77F2		;77eb
L_77ED:
	ld a,(0c4f0h)		;77ed   ; los de mas alla de 0xC4F0 son pared
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
es_hoyo:		; carry si el caracter A es hoyo
	ld hl,0c4f1h		;77fd   ; carry si A es hoyo: entre 0xC4F1 y 0xC4F1 + 0xC4F2
	sub (hl)			;7800
	inc hl			;7801
	cp (hl)			;7802
	ret			;7803
caracter_bajo:		; A = el caracter de 0xD800 en el punto (D, E)
	push de			;7804
	ld a,e			;7805   ; la fila: (y - 0x20) / 8, por 32
	sub 020h		;7806
	and 0f8h		;7808
	ld h,000h		;780a
	ld l,a			;780c
	add hl,hl			;780d
	add hl,hl			;780e
	ld a,d			;780f   ; la columna: x / 8
	and 0f8h		;7810
	rrca			;7812
	rrca			;7813
	rrca			;7814
	call 04083h		;7815   ; hl_mas_a: HL += A
	ld de,0d800h		;7818   ; en el mapa de 0xD800
	add hl,de			;781b
	ld a,(hl)			;781c
	pop de			;781d
	ret			;781e
no_se_puede_estar:		; carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)
	call caracter_bajo		;781f   ; caracter_bajo: A = el caracter de 0xD800 en el punto (D, E)
	ld b,a			;7822
	ld hl,0c4f1h		;7823   ; de 0xC4F1 en adelante no se puede estar...
	ld a,(hl)			;7826
	cp 0f0h		;7827   ; ... o, si 0xC4F1 es 0xF0, de mas alla de 0xC4F0
	jr nz,L_7830		;7829
	dec l			;782b
	ld a,(hl)			;782c
	inc a			;782d
	jr L_7830		;782e
L_7830:
	dec a			;7830
	cp b			;7831
	ret			;7832
choques:		; los choques del jugador con las figuras, sus disparos, su golpe y lo lanzado
	ld a,(0c490h)		;7833   ; los choques del jugador, en el suelo o saltando, fuera de los interiores
	cp 002h		;7836
	ret nc			;7838
	ld a,(0c482h)		;7839   ; lee la pantalla especial
	and a			;783c
	ret nz			;783d
	call lo_del_suelo		;783e   ; lo_del_suelo: las cosas de 0xCC00: se cogen, o una boca de pasadizo
	call golpe_al_0e		;7841   ; golpe_al_0e: el golpe contra el tipo 0x0E de 0xCC00
	call golpe_contra_las_figuras		;7844   ; su golpe contra las figuras
	call lanzado_contra_las_figuras		;7847   ; lo lanzado contra las figuras
	call figuras_contra_el_jugador		;784a   ; las figuras contra el jugador
	ld a,(0c4a7h)		;784d   ; sin parpadear, tambien las de 0xCA00
	and a			;7850
	ret nz			;7851
	jp disparos_contra_el_jugador		;7852   ; disparos_contra_el_jugador: si le toca un disparo de 0xCA00: 2 de vida o lo que lo pare
figuras_contra_el_jugador:		; si le toca una figura que hace dano: parpadeo, efecto y lo que pierde
	ld ix,0c600h		;7855   ; las ocho figuras de 0xC600
	ld b,008h		;7859
L_785B:
	ld a,(ix+00ch)		;785b   ; el bit 0 de (ix+0x0C): la figura hace dano
	rra			;785e
	jr nc,L_78BC		;785f
	ld a,(ix+01dh)		;7861   ; (ix+0x1D) puesto, no
	and a			;7864
	jr nz,L_78BC		;7865
	ld a,(ix+000h)		;7867   ; solo los tipos 1-0x21
	dec a			;786a
	cp 021h		;786b
	jr nc,L_78BC		;786d
	dec a			;786f   ; los tipos 2 y 3 no tocan al jugador del cuadro 4 al 0x19 del salto: se saltan
	cp 002h		;7870
	jr c,L_787D		;7872
	ld a,(0c4a0h)		;7874
	sub 004h		;7877
	cp 016h		;7879
	jr c,L_78BC		;787b
L_787D:
	push bc			;787d
	call toca_la_figura		;787e   ; carry si se tocan
	pop bc			;7881
	jr nc,L_78BC		;7882
	ld a,(ix+000h)		;7884   ; los tipos 8 y 0x21 no hacen dano: dan puntos (p01:79C8)
	cp 008h		;7887
	jp z,toca_la_buena		;7889   ; toca_la_buena: tocar un tipo 8 o 0x21: 1000 puntos (y 10 ryo con el bit 1 de 0xEF80)
	cp 021h		;788c
	jp z,toca_la_buena		;788e   ; toca_la_buena: tocar un tipo 8 o 0x21: 1000 puntos (y 10 ryo con el bit 1 de 0xEF80)
	ld hl,0c4a7h		;7891   ; ya parpadeando, nada
	ld a,(hl)			;7894
	and a			;7895
	jr nz,L_78BC		;7896
	ld a,03ch		;7898   ; 60 cuadros parpadeando...
	ld (hl),a			;789a
	ld a,00bh		;789b   ; ... y el efecto 0x0B
	call 04fe4h		;789d   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call lo_para		;78a0   ; si lleva lo que para a ese tipo (p01:7A08), se gasta eso y nada mas
	ret c			;78a3
	xor a			;78a4   ; si no, pierde la cosa 1
	ld (0c271h),a		;78a5
	inc a			;78a8
	call 057fah		;78a9   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
	ld a,(ix+000h)		;78ac   ; el tipo 5 le quita la cosa 0x0A (o 20 ryo si no la tiene)...
	cp 005h		;78af
	jp z,quita_la_cosa_0a		;78b1   ; quita_la_cosa_0a: pierde la cosa 0x0A; sin ella, 20 ryo
	cp 009h		;78b4   ; ... el 9, 20 ryo...
	jp z,quita_20_ryo		;78b6   ; quita_20_ryo: 20 ryo menos
	jp quita_4_de_vida		;78b9   ; ... y los demas, 4 de vida
L_78BC:
	ld de,00080h		;78bc
	add ix,de		;78bf
	djnz L_785B		;78c1
	ret			;78c3
disparos_contra_el_jugador:		; si le toca un disparo de 0xCA00: 2 de vida o lo que lo pare
	ld ix,0ca00h		;78c4   ; las de 0xCA00 (los disparos)
	ld b,008h		;78c8
L_78CA:
	ld a,(ix+000h)		;78ca   ; lee el tipo de la figura
	dec a			;78cd
	cp 021h		;78ce
	jr nc,L_78F2		;78d0
	push bc			;78d2
	call toca_el_disparo		;78d3   ; toca_el_disparo: carry si el disparo IX toca al jugador
	pop bc			;78d6
	jr nc,L_78F2		;78d7
	ld a,03ch		;78d9   ; 60 cuadros parpadeando y el efecto 0x0B
	ld (0c4a7h),a		;78db
	ld a,00bh		;78de
	call 04fe4h		;78e0   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	call lo_para_del_disparo		;78e3   ; si lleva lo que lo para, se gasta
	ret c			;78e6
	xor a			;78e7   ; si no, pierde la cosa 1 y 2 de vida
	ld (0c271h),a		;78e8
	inc a			;78eb
	call 057fah		;78ec   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
	jp quita_2_de_vida		;78ef   ; quita_2_de_vida: 2 de vida menos
L_78F2:
	ld de,00040h		;78f2
	add ix,de		;78f5
	djnz L_78CA		;78f7
	ret			;78f9
golpe_contra_las_figuras:		; si el golpe da a una figura: puntos y dinero
	ld a,(0c492h)		;78fa   ; el golpe del primer boton contra las figuras
	and a			;78fd
	ret z			;78fe
	ld ix,0c600h		;78ff
	ld b,008h		;7903
L_7905:
	ld a,(ix+000h)		;7905   ; lee el tipo de la figura
	dec a			;7908
	cp 021h		;7909
	jr nc,L_7934		;790b
	ld a,(ix+00ch)		;790d   ; el bit 1 de (ix+0x0C): se le puede dar
	rra			;7910
	rra			;7911
	jr nc,L_7934		;7912
	push bc			;7914
	call le_da_el_golpe		;7915   ; carry si le da
	pop bc			;7918
	jr nc,L_7934		;7919
	call puntos_del_tipo		;791b   ; los puntos y el dinero que da
	call dinero_del_tipo		;791e   ; dinero_del_tipo: suma el dinero del tipo (0xB86D); los tipos 8 y 0x21 quitan 50
	ld a,001h		;7921   ; (ix+0x0D) = 1: le han dado
	ld (ix+00dh),a		;7923
efecto_del_golpe:		; el efecto 0x0D (0x0C con el tipo 3)
	ld a,(ix+000h)		;7926   ; el efecto 0x0D (0x0C para el tipo 3)
	cp 003h		;7929
	ld a,00dh		;792b
	jr nz,L_7931		;792d
	ld a,00ch		;792f
L_7931:
	jp 04fe4h		;7931   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_7934:
	ld de,00080h		;7934
	add ix,de		;7937
	djnz L_7905		;7939
	ret			;793b
lanzado_contra_las_figuras:		; si lo lanzado da a una figura: puntos y dinero, y se borra
	ld a,(0c4d0h)		;793c   ; lo lanzado contra las figuras
	ld b,a			;793f
	ld a,(0c4e0h)		;7940
	or b			;7943
	ret z			;7944
	ld ix,0c600h		;7945
	ld b,008h		;7949
L_794B:
	ld a,(ix+000h)		;794b   ; lee el tipo de la figura
	dec a			;794e
	cp 021h		;794f
	jr nc,L_7978		;7951
	ld a,(ix+00ch)		;7953
	rra			;7956
	rra			;7957
	jr nc,L_7978		;7958
	push bc			;795a
	call le_da_lo_lanzado		;795b   ; carry si le da
	pop bc			;795e
	jr nc,L_7978		;795f
	call puntos_del_tipo		;7961   ; puntos_del_tipo: suma los puntos del tipo de la figura (0xB84C, en centenas)
	call dinero_del_tipo		;7964   ; dinero_del_tipo: suma el dinero del tipo (0xB86D); los tipos 8 y 0x21 quitan 50
	ld a,001h		;7967
	ld (ix+00dh),a		;7969
	call efecto_del_golpe		;796c   ; efecto_del_golpe: el efecto 0x0D (0x0C con el tipo 3)
	push iy		;796f   ; y lo lanzado se borra (IY apunta a el)
	pop hl			;7971
	inc hl			;7972
	inc hl			;7973
	inc hl			;7974
	jp borra_lo_lanzado		;7975   ; borra_lo_lanzado: sus 16 bytes a cero y su sprite fuera
L_7978:
	ld de,00080h		;7978
	add ix,de		;797b
	djnz L_794B		;797d
	ret			;797f
puntos_del_tipo:		; suma los puntos del tipo de la figura (0xB84C, en centenas)
	di			;7980   ; los puntos de cada tipo, en centenas: 0xB84C (banco 9)
	ld a,009h		;7981
	ld (0a000h),a		;7983   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;7986   ; guarda la copia del banco de 0xA000
	ei			;7989
	ld a,(ix+000h)		;798a   ; lee el tipo de la figura
	dec a			;798d
	ld hl,0b84ch		;798e
	call 04083h		;7991   ; hl_mas_a: HL += A
	ld e,000h		;7994
	ld d,(hl)			;7996
	call 0437eh		;7997   ; suma_puntos: suma puntos en BCD al jugador que juega
	jp 04206h		;799a   ; bancos_1_2_3: pone los bancos 1, 2 y 3
dinero_del_tipo:		; suma el dinero del tipo (0xB86D); los tipos 8 y 0x21 quitan 50
	di			;799d   ; el dinero que da cada tipo: 0xB86D
	ld a,009h		;799e
	ld (0a000h),a		;79a0   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;79a3   ; guarda la copia del banco de 0xA000
	ei			;79a6
	ld a,(ix+000h)		;79a7   ; lee el tipo de la figura
	cp 008h		;79aa   ; dar a los tipos 8 y 0x21 cuesta 50 ryo
	jr z,L_79BF		;79ac
	cp 021h		;79ae
	jr z,L_79BF		;79b0
	dec a			;79b2
	ld hl,0b86dh		;79b3
	call 04083h		;79b6   ; hl_mas_a: HL += A
	ld e,(hl)			;79b9
	call 05929h		;79ba   ; suma_dinero: suma E ryo (BCD) al dinero, hasta 9999
	jr L_79C5		;79bd
L_79BF:
	ld de,00050h		;79bf
	call 05958h		;79c2   ; resta_dinero: resta DE ryo (BCD) al dinero, hasta 0
L_79C5:
	jp 04206h		;79c5   ; bancos_1_2_3: pone los bancos 1, 2 y 3
toca_la_buena:		; tocar un tipo 8 o 0x21: 1000 puntos (y 10 ryo con el bit 1 de 0xEF80)
	call 087b7h		;79c8   ; tocar a un tipo 8 o 0x21: se va, 1000 puntos...
	ld de,01000h		;79cb
	call 0437eh		;79ce   ; suma_puntos: suma puntos en BCD al jugador que juega
	ld a,(0ef80h)		;79d1   ; ... con el bit 1 de 0xEF80 (una de las palabras de la pausa), 10 ryo mas...
	and 002h		;79d4
	jr z,L_79DD		;79d6
	ld e,010h		;79d8
	call 05929h		;79da   ; suma_dinero: suma E ryo (BCD) al dinero, hasta 9999
L_79DD:
	ld a,012h		;79dd   ; ... y el efecto 0x12
	jp 04fe4h		;79df   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
quita_la_cosa_0a:		; pierde la cosa 0x0A; sin ella, 20 ryo
	ld hl,0c27eh		;79e2   ; el tipo 5: si se tiene la cosa 0x0A, se pierde
	ld a,(hl)			;79e5
	and a			;79e6
	jr z,quita_20_ryo		;79e7
	xor a			;79e9
	ld (hl),a			;79ea
	ld a,00ah		;79eb
	jp 057fah		;79ed   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
quita_20_ryo:		; 20 ryo menos
	ld de,00020h		;79f0   ; 20 ryo menos
	jp 05958h		;79f3   ; resta_dinero: resta DE ryo (BCD) al dinero, hasta 0
quita_4_de_vida:		; 4 de vida menos
	ld b,004h		;79f6   ; 4 de vida menos...
quita_vida:		; B de vida menos, hasta 0
	ld hl,0c481h		;79f8   ; apunta a la VIDA del jugador
	ld a,(hl)			;79fb
	sub b			;79fc
	jr nc,L_7A00		;79fd   ; ... hasta 0
	xor a			;79ff
L_7A00:
	ld (hl),a			;7a00
	jp 05890h		;7a01   ; pinta_la_vida: pinta la barra de vida
quita_2_de_vida:		; 2 de vida menos
	ld b,002h		;7a04   ; 2 de vida menos
	jr quita_vida		;7a06
lo_para:		; carry si lleva lo que para a ese tipo, y se gasta uno
	ld a,(ix+000h)		;7a08   ; lo que para el golpe de cada tipo: los tipos 1 y 6, la cosa 6...
	ld hl,0c276h		;7a0b
	cp 001h		;7a0e
	jr z,gasta_una		;7a10
	cp 006h		;7a12
	jr z,gasta_una		;7a14
	ld hl,0c273h		;7a16   ; ... el 5, la cosa 3...
	cp 005h		;7a19
	jr z,gasta_una		;7a1b
	ld hl,0c274h		;7a1d   ; ... y los demas, la cosa 4
gasta_una:		; si (HL) no es cero, una menos y carry
	ld a,(hl)			;7a20   ; sin ella, NC: hace dano
	and a			;7a21
	ret z			;7a22
	dec (hl)			;7a23   ; con ella, una menos (si se acaba, fuera su icono) y carry
	call z,repinta_la_cosa		;7a24   ; repinta_la_cosa: pinta la cosa de la direccion L (0xC270 + n)
	scf			;7a27
	ret			;7a28
repinta_la_cosa:		; pinta la cosa de la direccion L (0xC270 + n)
	ld a,l			;7a29   ; A = el numero de la cosa (0xC270 + n)
	sub 070h		;7a2a
	jp 057fah		;7a2c   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
lo_para_del_disparo:		; como lo_para, para los disparos
	ld a,(ix+000h)		;7a2f   ; los disparos: de los tipos 1 y 2 para la cosa 5, de los demas la cosa 2
	ld hl,0c275h		;7a32
	cp 003h		;7a35
	jr c,gasta_una		;7a37
	ld hl,0c272h		;7a39
	jr gasta_una		;7a3c
toca_el_disparo:		; carry si el disparo IX toca al jugador
	call caja_del_disparo		;7a3e   ; un disparo contra el jugador: carry si se tocan, segun la caja de su tipo
	call 0408dh		;7a41   ; despacha: salta a la entrada A de la tabla que va detras del call

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


toca_la_figura:		; carry si la figura IX toca al jugador
	ld a,001h		;7a4e   ; una figura contra el jugador
	ld (0ee80h),a		;7a50
	call caja_del_tipo		;7a53   ; caja_del_tipo: A = la clase de caja del tipo, B y C su centro
	call 0408dh		;7a56   ; despacha: salta a la entrada A de la tabla que va detras del call

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


le_da_el_golpe:		; carry si el golpe da a la figura IX
	xor a			;7a61   ; el golpe contra una figura
	ld (0ee80h),a		;7a62
	call caja_del_tipo		;7a65   ; caja_del_tipo: A = la clase de caja del tipo, B y C su centro
	call 0408dh		;7a68   ; despacha: salta a la entrada A de la tabla que va detras del call

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


le_da_lo_lanzado:		; carry si lo lanzado da a la figura IX
	xor a			;7a73   ; lo lanzado contra una figura
	ld (0ee80h),a		;7a74
	call caja_del_tipo		;7a77   ; caja_del_tipo: A = la clase de caja del tipo, B y C su centro
	call 0408dh		;7a7a   ; despacha: salta a la entrada A de la tabla que va detras del call

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


caja_del_tipo:		; A = la clase de caja del tipo, B y C su centro
	di			;7a85   ; la caja de cada tipo (0xB88E, banco 9): A = la clase - 1, B = x, C = y - D
	ld a,009h		;7a86
	ld (0a000h),a		;7a88   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;7a8b   ; guarda la copia del banco de 0xA000
	ei			;7a8e
	ld a,(ix+000h)		;7a8f   ; lee el tipo de la figura
	dec a			;7a92
	ld hl,0b88eh		;7a93
	call 04083h		;7a96   ; hl_mas_a: HL += A
	ld a,(hl)			;7a99
	ld h,a			;7a9a
	cp 003h		;7a9b   ; la clase 3: 7 puntos por encima
	ld de,00700h		;7a9d
	jr z,L_7ABB		;7aa0
	ld de,00f00h		;7aa2   ; las demas, 15
	cp 002h		;7aa5
	jr nz,L_7ABB		;7aa7
	ld a,(0ee80h)		;7aa9   ; la 2 contra el jugador: la clase 3, corrida 8 hacia donde mira la figura
	and a			;7aac
	jr z,L_7ABB		;7aad
	ld h,003h		;7aaf
	ld e,008h		;7ab1
	ld a,(ix+00fh)		;7ab3
	and a			;7ab6
	jr z,L_7ABB		;7ab7
	ld e,0f8h		;7ab9
L_7ABB:
	ld a,(ix+005h)		;7abb   ; lee la x de la figura
	sub e			;7abe
	ld b,a			;7abf
	ld a,(ix+003h)		;7ac0   ; lee la y de la figura
	sub d			;7ac3
	ld c,a			;7ac4
	ld a,h			;7ac5
	dec a			;7ac6
	jp 04206h		;7ac7   ; bancos_1_2_3: pone los bancos 1, 2 y 3
caja_del_disparo:		; A = la clase de caja del disparo, B y C su centro
	ld a,(ix+000h)		;7aca   ; la caja de los disparos: 0x7AE8 la clase y 0x7AF0 lo que se resta a la y
	dec a			;7acd
	ld hl,07ae8h		;7ace
	call 04083h		;7ad1   ; hl_mas_a: HL += A
	ld a,(hl)			;7ad4
	dec a			;7ad5
	ld d,a			;7ad6
	ld b,(ix+005h)		;7ad7   ; lee la x de la figura
	ld hl,07af0h		;7ada
	call 04083h		;7add   ; hl_mas_a: HL += A
	ld c,(hl)			;7ae0
	ld a,(ix+003h)		;7ae1   ; lee la y de la figura
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
	ld hl,00202h		;7af5   ; las cajas de cada clase: H = medio alto, L = medio ancho...
	jp toca_al_jugador		;7af8   ; toca_al_jugador: carry si la caja (H, L) en (B, C) toca al jugador
L_7AFB:
	ld hl,00302h		;7afb
	jp toca_al_jugador		;7afe   ; toca_al_jugador: carry si la caja (H, L) en (B, C) toca al jugador
L_7B01:
	ld hl,00404h		;7b01
	jp toca_al_jugador		;7b04   ; toca_al_jugador: carry si la caja (H, L) en (B, C) toca al jugador
L_7B07:
	ld hl,00102h		;7b07
	jp toca_al_jugador		;7b0a   ; toca_al_jugador: carry si la caja (H, L) en (B, C) toca al jugador
L_7B0D:
	ld hl,00404h		;7b0d
	jp toca_al_jugador		;7b10   ; toca_al_jugador: carry si la caja (H, L) en (B, C) toca al jugador
L_7B13:
	ld hl,00b04h		;7b13
	jp toca_al_golpe		;7b16   ; toca_al_golpe: carry si la caja toca el golpe, delante del jugador
L_7B19:
	ld hl,00b04h		;7b19
	jp toca_lo_lanzado		;7b1c   ; toca_lo_lanzado: carry si la caja toca alguno de los dos lanzados
L_7B1F:
	ld hl,0040ch		;7b1f
	jp toca_al_jugador		;7b22   ; toca_al_jugador: carry si la caja (H, L) en (B, C) toca al jugador
L_7B25:
	ld hl,00404h		;7b25
	jp toca_al_jugador		;7b28   ; toca_al_jugador: carry si la caja (H, L) en (B, C) toca al jugador
L_7B2B:
	ld hl,00404h		;7b2b
	jp toca_al_golpe		;7b2e   ; toca_al_golpe: carry si la caja toca el golpe, delante del jugador
L_7B31:
	ld hl,00404h		;7b31
	jp toca_lo_lanzado		;7b34   ; toca_lo_lanzado: carry si la caja toca alguno de los dos lanzados
L_7B37:
	ld hl,00808h		;7b37
	jp toca_al_jugador		;7b3a   ; toca_al_jugador: carry si la caja (H, L) en (B, C) toca al jugador
L_7B3D:
	ld hl,00808h		;7b3d
	jp toca_al_golpe		;7b40   ; toca_al_golpe: carry si la caja toca el golpe, delante del jugador
L_7B43:
	ld hl,00808h		;7b43
	jp toca_lo_lanzado		;7b46   ; toca_lo_lanzado: carry si la caja toca alguno de los dos lanzados
toca_al_jugador:		; carry si la caja (H, L) en (B, C) toca al jugador
	ld a,004h		;7b49   ; contra el jugador: |x - B| < L + 4...
	add a,l			;7b4b
	ld l,a			;7b4c
	ld a,(0c49ah)		;7b4d   ; lee la x de los sprites del jugador
	sub b			;7b50
	jr nc,L_7B55		;7b51
	neg		;7b53
L_7B55:
	cp l			;7b55
	ret nc			;7b56
	ld a,004h		;7b57   ; ... y |y - 12 - C| < H + 4: carry si se tocan
	add a,h			;7b59
	ld h,a			;7b5a
	ld a,(0c498h)		;7b5b   ; lee la y de los sprites del jugador
	sub 00ch		;7b5e
	sub c			;7b60
	jr nc,L_7B65		;7b61
	neg		;7b63
L_7B65:
	cp h			;7b65
	ret			;7b66
toca_al_golpe:		; carry si la caja toca el golpe, delante del jugador
	push hl			;7b67   ; contra el golpe: delante del jugador (0x7BA2, [dx][dy] por lado)
	ld a,(0c4a2h)		;7b68   ; lee el lado al que mira el jugador
	add a,a			;7b6b
	ld hl,07ba2h		;7b6c
	call 04083h		;7b6f   ; hl_mas_a: HL += A
	ld e,(hl)			;7b72
	inc hl			;7b73
	ld d,(hl)			;7b74
	pop hl			;7b75
	ld a,004h		;7b76
	add a,l			;7b78
	ld l,a			;7b79
	ld a,(0c4a2h)		;7b7a   ; lee el lado al que mira el jugador
	cp 002h		;7b7d   ; mirando a la izquierda se resta
	ld a,(0c49ah)		;7b7f   ; lee la x de los sprites del jugador
	jr z,L_7B87		;7b82
	add a,e			;7b84
	jr L_7B88		;7b85
L_7B87:
	sub e			;7b87
L_7B88:
	jr nc,L_7B8C		;7b88
	xor a			;7b8a   ; por el borde, no
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
	ld a,(0c498h)		;7b97   ; lee la y de los sprites del jugador
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


toca_lo_lanzado:		; carry si la caja toca alguno de los dos lanzados
	ld iy,0c4d0h		;7baa   ; contra lo lanzado: los dos huecos (IY)
	push hl			;7bae
	call toca_al_lanzado		;7baf   ; toca_al_lanzado: carry si la caja toca el lanzado IY
	pop hl			;7bb2
	ret c			;7bb3
	ld iy,0c4e0h		;7bb4
	call toca_al_lanzado		;7bb8   ; toca_al_lanzado: carry si la caja toca el lanzado IY
	ret			;7bbb
toca_al_lanzado:		; carry si la caja toca el lanzado IY
	ld a,003h		;7bbc   ; |x - B| < L + 3 y |y - 3 - C| < H + 3
	add a,l			;7bbe
	ld l,a			;7bbf
	ld a,(iy+004h)		;7bc0
	sub b			;7bc3
	jr nc,L_7BC8		;7bc4
	neg		;7bc6
L_7BC8:
	cp l			;7bc8
	ret nc			;7bc9
	ld a,003h		;7bca   ; |y - 3 - C| < H + 3?
	add a,h			;7bcc
	ld h,a			;7bcd
	ld a,(iy+003h)		;7bce   ; la y del lanzado
	sub 003h		;7bd1
	sub c			;7bd3
	jr nc,L_7BD8		;7bd4
	neg		;7bd6
L_7BD8:
	cp h			;7bd8   ; carry si se tocan
	ret			;7bd9
lo_del_suelo:		; las cosas de 0xCC00: se cogen, o una boca de pasadizo
	ld ix,0cc00h		;7bda   ; las cuatro cosas de 0xCC00 (de 0x40): lo que hay en el suelo
	ld b,004h		;7bde
L_7BE0:
	ld a,(ix+000h)		;7be0   ; lee el tipo de la figura
	and a			;7be3
	jr z,L_7C1D		;7be4
	cp 008h		;7be6   ; los tipos 8 y mas, aparte (p01:7C9C)
	jp nc,L_7C9C		;7be8
	ld a,(ix+00ch)		;7beb   ; sin el bit 0 de (ix+0x0C): solo saltando cerca (32 x 32), (ix+0x0D) = 1
	rra			;7bee
	jr c,L_7C02		;7bef
	ld a,(0c490h)		;7bf1   ; lee el estado del jugador
	dec a			;7bf4
	jr nz,L_7C1D		;7bf5
	call cerca_de_la_figura		;7bf7   ; cerca_de_la_figura: carry si el jugador esta a menos de 32 de la figura
	jr nc,L_7C1D		;7bfa
	ld (ix+00dh),001h		;7bfc
	jr L_7C1D		;7c00
L_7C02:
	ld a,(ix+000h)		;7c02   ; los tipos 6 y 7, las bocas de los pasadizos
	sub 006h		;7c05
	cp 002h		;7c07
	jr c,L_7C25		;7c09
	push bc			;7c0b
	call toca_de_8		;7c0c   ; las demas se cogen al tocarlas (caja de 8 x 8)...
	pop bc			;7c0f
	jr nc,L_7C1D		;7c10
	call coge		;7c12   ; ... lo que dan, se borran y el efecto 0x12
	call 087b7h		;7c15   ; borra_la_figura: borra la figura
	ld a,012h		;7c18
	jp 04fe4h		;7c1a   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_7C1D:
	ld de,00040h		;7c1d
	add ix,de		;7c20
	djnz L_7BE0		;7c22
	ret			;7c24
L_7C25:
	ld a,(0c490h)		;7c25   ; una boca de pasadizo: en el suelo...
	and a			;7c28
	jr nz,L_7C1D		;7c29
	ld a,(ix+003h)		;7c2b   ; ... a menos de 8 de (x - 4, y - 12)...
	sub 00ch		;7c2e
	ld c,a			;7c30
	ld a,(0c494h)		;7c31   ; lee la y del jugador
	sub c			;7c34
	cp 008h		;7c35
	jr nc,L_7C1D		;7c37
	ld a,(ix+005h)		;7c39   ; lee la x de la figura
	sub 004h		;7c3c
	ld c,a			;7c3e
	ld a,(0c496h)		;7c3f   ; lee la x del jugador
	sub c			;7c42
	cp 008h		;7c43
	jr nc,L_7C1D		;7c45
	xor a			;7c47   ; ... se baja: fuera todo...
	ld (0c492h),a		;7c48
	ld (0c49fh),a		;7c4b   ; guarda la accion del jugador
	call borra_las_figuras		;7c4e   ; borra_las_figuras: el tipo a 0 en las ocho fichas de 0xC600 y las ocho de 0xCA00
	call borra_las_de_0xcc00		;7c51   ; borra_las_de_0xcc00: 0xCC00-0xCCFF a cero
	ld hl,0c4d3h		;7c54
	call borra_lo_lanzado		;7c57   ; borra_lo_lanzado: sus 16 bytes a cero y su sprite fuera
	ld hl,0c4e3h		;7c5a
	call borra_lo_lanzado		;7c5d   ; borra_lo_lanzado: sus 16 bytes a cero y su sprite fuera
	call esconde_los_sprites_de_ram		;7c60   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	ld a,004h		;7c63   ; ... estado 4, 32 cuadros...
	ld (0c490h),a		;7c65   ; guarda el estado del jugador
	ld a,020h		;7c68
	ld (0c4a8h),a		;7c6a
	ld a,(0c494h)		;7c6d   ; ... el jugador en el centro de su cuadro de 16...
	and 0f0h		;7c70
	add a,008h		;7c72
	ld (0c494h),a		;7c74   ; guarda la y del jugador
	ld (0c498h),a		;7c77   ; guarda la y de los sprites del jugador
	ld a,(0c496h)		;7c7a   ; lee la x del jugador
	and 0f0h		;7c7d
	add a,008h		;7c7f
	ld (0c496h),a		;7c81   ; guarda la x del jugador
	ld (0c49ah),a		;7c84   ; guarda la x de los sprites del jugador
	ld hl,00000h		;7c87   ; ... quieto...
	ld (0c49bh),hl		;7c8a
	ld (0c49dh),hl		;7c8d
	xor a			;7c90
	ld (0c4a7h),a		;7c91
	call sprites_en_la_y		;7c94   ; sprites_en_la_y: los 16 sprites de la copia en la y del jugador + C
	ld a,090h		;7c97   ; ... y la musica 0x10
	jp 04fe4h		;7c99   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
L_7C9C:
	ld a,(ix+00ch)		;7c9c   ; los tipos 8 y mas: con el bit 0 y en el suelo, a menos de 12...
	rra			;7c9f
	jp nc,L_7C1D		;7ca0
	ld a,(0c490h)		;7ca3   ; lee el estado del jugador
	and a			;7ca6
	jp nz,L_7C1D		;7ca7
	ld a,(0c494h)		;7caa   ; lee la y del jugador
	ld c,a			;7cad
	ld a,(ix+003h)		;7cae   ; lee la y de la figura
	sub 002h		;7cb1
	sub c			;7cb3
	cp 00ch		;7cb4
	jp nc,L_7C1D		;7cb6
	ld a,(ix+005h)		;7cb9   ; lee la x de la figura
	sub 006h		;7cbc
	ld c,a			;7cbe
	ld a,(0c496h)		;7cbf   ; lee la x del jugador
	sub c			;7cc2
	cp 00ch		;7cc3
	jp nc,L_7C1D		;7cc5
	ld (ix+00dh),001h		;7cc8   ; ... (ix+0x0D) = 1 y el efecto 0x1E (0x14 el tipo 0x0A)
	ld a,(ix+000h)		;7ccc   ; lee el tipo de la figura
	cp 00ah		;7ccf
	ld a,01eh		;7cd1
	jp nz,04fe4h		;7cd3   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
	ld a,014h		;7cd6
	jp 04fe4h		;7cd8   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
golpe_al_0e:		; el golpe contra el tipo 0x0E de 0xCC00
	ld a,(0c492h)		;7cdb   ; el golpe contra el tipo 0x0E de 0xCC00: (ix+0x0D) = 1
	and a			;7cde
	ret z			;7cdf
	ld ix,0cc00h		;7ce0
	ld b,004h		;7ce4
L_7CE6:
	ld a,(ix+000h)		;7ce6   ; lee el tipo de la figura
	cp 00eh		;7ce9
	jr nz,L_7D00		;7ceb
	push bc			;7ced
	ld hl,00a0ah		;7cee
	ld b,(ix+005h)		;7cf1   ; lee la x de la figura
	ld a,(ix+003h)		;7cf4   ; lee la y de la figura
	sub 008h		;7cf7
	ld c,a			;7cf9
	call toca_al_golpe		;7cfa   ; toca_al_golpe: carry si la caja toca el golpe, delante del jugador
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
entrada_del_pasadizo_secreto:		; con 0xCDB0, arriba en (0x30-0x50, 0x40) se entra en el pasadizo secreto
	ld a,(0c494h)		;7d0d   ; con 0xCDB0 puesto: en (0x30-0x50, 0x40-0x46) con arriba, se entra en el pasadizo secreto de la zona
	sub 040h		;7d10
	cp 006h		;7d12
	ret nc			;7d14
	ld a,(0c496h)		;7d15   ; lee la x del jugador
	sub 030h		;7d18
	cp 020h		;7d1a
	ret nc			;7d1c
	ld a,(0c007h)		;7d1d   ; lee lo apretado: bits 0-3 arriba, abajo, izquierda, derecha; 4 y 5 los botones
	rra			;7d20
	ret nc			;7d21
	call esconde_los_sprites_de_ram		;7d22   ; esconde_los_sprites_de_ram: y = 0xE0 en los 32 sprites de la copia de 0xEE00
	call 05b1dh		;7d25   ; gira_los_sprites: gira el orden de los sprites (0xC25F) y los sube a 0x7400/0x7600
	call 05969h		;7d28   ; entra_en_el_pasadizo_secreto: pasa al pasadizo secreto de la zona, en primera persona
	ld a,088h		;7d2b   ; con la musica 0x08
	jp 04fe4h		;7d2d   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido
cerca_de_la_figura:		; carry si el jugador esta a menos de 32 de la figura
	ld a,(ix+005h)		;7d30   ; NC si el jugador esta a menos de 32 de (x - 16, y - 24)
	sub 010h		;7d33
	ld c,a			;7d35
	ld a,(0c496h)		;7d36   ; lee la x del jugador
	sub c			;7d39
	cp 020h		;7d3a
	ret nc			;7d3c
	ld a,(ix+003h)		;7d3d   ; lee la y de la figura
	sub 018h		;7d40
	ld c,a			;7d42
	ld a,(0c494h)		;7d43   ; lee la y del jugador
	sub c			;7d46
	cp 020h		;7d47
	ret			;7d49
toca_de_8:		; carry si el jugador toca la caja de 8 x 8 de la figura
	ld b,(ix+005h)		;7d4a   ; una caja de 8 x 8 en la figura
	ld c,(ix+003h)		;7d4d   ; lee la y de la figura
	ld hl,00808h		;7d50
	jp toca_al_jugador		;7d53   ; toca_al_jugador: carry si la caja (H, L) en (B, C) toca al jugador
coge:		; lo que da el tipo 1 (la cosa 1) o el 2 (la cosa 0), o 10 ryo
	ld a,(ix+000h)		;7d56   ; lo que da cada tipo: el 1, la cosa 1; el 2, la cosa 0
	dec a			;7d59
	jr z,L_7D71		;7d5a
	dec a			;7d5c
	ret nz			;7d5d
	ld hl,0c270h		;7d5e   ; la cosa 0, hasta 3...
	inc (hl)			;7d61
	ld a,(hl)			;7d62
	cp 004h		;7d63
	jr nc,L_7D6B		;7d65
	xor a			;7d67
	jp 057fah		;7d68   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
L_7D6B:
	dec (hl)			;7d6b   ; ... y con 3, 10 ryo
L_7D6C:
	ld e,010h		;7d6c
	jp 05929h		;7d6e   ; suma_dinero: suma E ryo (BCD) al dinero, hasta 9999
L_7D71:
	ld hl,0c271h		;7d71   ; la cosa 1, si no se tiene; si se tiene, 10 ryo
	ld a,(hl)			;7d74
	and a			;7d75
	jr nz,L_7D6C		;7d76
	inc (hl)			;7d78
	ld a,001h		;7d79
	jp 057fah		;7d7b   ; pinta_cosa_del_marcador: pinta la cosa A del marcador (0-9; la 0x0A va aparte)
efecto_del_tipo:		; el efecto de sonido del tipo (0x7D98)
	ld a,(ix+000h)		;7d7e   ; el efecto de cada tipo (0x7D98)
	ld b,a			;7d81
	cp 006h		;7d82
	jr nz,L_7D8C		;7d84
	ld a,(0c278h)		;7d86   ; el 6, con la cosa 8 puesta (0xC278 = 8), ninguno
	cp 008h		;7d89
	ret z			;7d8b
L_7D8C:
	ld a,b			;7d8c
	dec a			;7d8d
	ld hl,07d98h		;7d8e
	call 04083h		;7d91   ; hl_mas_a: HL += A
	ld a,(hl)			;7d94
	jp 04fe4h		;7d95   ; sonido: A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido

; ----------------------------------------------------------------------
; DATOS sonido_por_tipo: el efecto de sonido de cada tipo de figura 1-6
;   (p01:7D8E): 0x11, 0x11, 0x11, 0x10, 0x10 y 0x13 (6 bytes)
;   0x7d98..0x7d9e  (6 bytes)
DATA_sonido_por_tipo:
	defb 011h,011h,011h,010h,010h,013h	; 7d98

; ======================================================================
; CODIGO 0x7d9e..0x7f0e  (368 bytes)
; ======================================================================


salidas_de_la_casilla:		; 0xC520: la salida especial de la casilla (tabla 0xB5D6)
	di			;7d9e   ; las salidas de la casilla, de la tabla de 0xB5D6 (banco 9) por zona
	ld a,009h		;7d9f
	ld (0a000h),a		;7da1   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;7da4   ; guarda la copia del banco de 0xA000
	ei			;7da7
	call 041f6h		;7da8   ; indice_de_la_zona: A = (fase * 7 + zona) * 2
	ld hl,0b5d6h		;7dab
	call 04d81h		;7dae   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld a,(hl)			;7db1   ; cuantas
	and a			;7db2
	ret z			;7db3
	ld b,a			;7db4
	inc hl			;7db5
	ld de,0c520h		;7db6
L_7DB9:
	ld c,(hl)			;7db9   ; [casilla, con el bit 7] y un byte mas
	ld a,c			;7dba
	exx			;7dbb
	and 07fh		;7dbc
	ld b,a			;7dbe
	ld a,(0c281h)		;7dbf   ; lee la CASILLA de la zona
	cp b			;7dc2
	exx			;7dc3
	jr z,L_7DDA		;7dc4
	inc hl			;7dc6
	inc hl			;7dc7
	djnz L_7DB9		;7dc8
	ld hl,0c520h		;7dca   ; ninguna: 0xC520-0xC52F a cero
	ld de,0c521h		;7dcd
	ld (hl),000h		;7dd0
	ld bc,0000fh		;7dd2
	ldir		;7dd5
	jp 04206h		;7dd7   ; bancos_1_2_3: pone los bancos 1, 2 y 3
L_7DDA:
	rl c		;7dda   ; con el bit 7, la salida 2; sin el, la 1
	ld a,001h		;7ddc
	jr nc,L_7DE1		;7dde
	inc a			;7de0
L_7DE1:
	ld (de),a			;7de1
	inc de			;7de2
	inc hl			;7de3
	ld a,(hl)			;7de4   ; y el byte que la acompana
	ld (de),a			;7de5
	jp 04206h		;7de6   ; bancos_1_2_3: pone los bancos 1, 2 y 3
cosas_de_la_casilla:		; la lista de 0xC500 de la casilla (tabla 0x981D)
	di			;7de9   ; las cosas de la casilla, de la tabla de 0x981D (banco 14) por zona...
	ld a,00eh		;7dea
	ld (0a000h),a		;7dec   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;7def   ; guarda la copia del banco de 0xA000
	ei			;7df2
	call vacia_0xc500		;7df3   ; ... a la lista de 0xC500, que se vacia antes
	ld a,(0c280h)		;7df6   ; lee la ZONA (0-6)
	add a,a			;7df9
	ld hl,0981dh		;7dfa
	call 04d81h		;7dfd   ; palabra_de_tabla: HL = la palabra A de la tabla de HL
	ld b,(hl)			;7e00
	inc hl			;7e01
	ld de,0c500h		;7e02
L_7E05:
	ld a,(0c281h)		;7e05   ; las de esta casilla: [casilla][tipo][dos nibbles][un byte]
	cp (hl)			;7e08   ; la casilla de la entrada
	jr nz,L_7E2C		;7e09
	push hl			;7e0b
	inc hl			;7e0c
	ld a,(hl)			;7e0d   ; [1] el tipo, a [0]
	ld (de),a			;7e0e
	ld c,000h		;7e0f
	push de			;7e11
	inc hl			;7e12
	inc e			;7e13
	ld a,(hl)			;7e14   ; [2] el nibble de arriba, a [1]
	and 0f0h		;7e15
	ld (de),a			;7e17
	inc e			;7e18
	ld a,(hl)			;7e19   ; el de abajo, a [2]
	rla			;7e1a
	rla			;7e1b
	rla			;7e1c
	rla			;7e1d
	and 0f0h		;7e1e
	ld (de),a			;7e20
	inc e			;7e21
	inc hl			;7e22
	ld a,(hl)			;7e23   ; [3] tal cual, a [3]
	ld (de),a			;7e24
	pop de			;7e25
	ld hl,00010h		;7e26   ; la siguiente de 0xC500, 16 bytes mas alla
	add hl,de			;7e29
	ex de,hl			;7e2a
	pop hl			;7e2b
L_7E2C:
	inc hl			;7e2c   ; la entrada siguiente, 3 bytes mas alla
	inc hl			;7e2d
	inc hl			;7e2e
	djnz L_7E05		;7e2f
	jp 04206h		;7e31   ; bancos_1_2_3: pone los bancos 1, 2 y 3
vacia_0xc500:		; 0xC500-0xC52F a cero
	ld hl,0c500h		;7e34
	ld de,0c501h		;7e37   ; DE = HL + 1
	ld (hl),000h		;7e3a
	ld bc,0002fh		;7e3c   ; 48 bytes
	ldir		;7e3f
	ret			;7e41
las_del_tipo_14:		; las cosas de tipo 0x14 de la zona a 0xC340; una al azar marcada
	di			;7e42   ; al cargar la zona: las cosas de tipo 0x14 de la zona, a 0xC340
	ld a,00eh		;7e43
	ld (08000h),a		;7e45   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;7e48   ; guarda la copia del banco de 0x8000
	ei			;7e4b
	ld a,(0c288h)		;7e4c   ; lee la FASE (0-6)
	ld b,a			;7e4f
	add a,a			;7e50
	add a,a			;7e51
	add a,a			;7e52
	sub b			;7e53
	ld b,a			;7e54
	ld a,(0c280h)		;7e55   ; lee la ZONA (0-6)
	add a,b			;7e58
	ld de,0981dh		;7e59
	call 0447ch		;7e5c   ; palabra_de_tabla_de: DE = la palabra A de la tabla de DE
	ld hl,0c340h		;7e5f   ; dos bytes por cosa: la casilla y la marca
	ld a,(de)			;7e62
	inc de			;7e63
	ld b,a			;7e64
	ld c,000h		;7e65
L_7E67:
	inc de			;7e67
	ld a,(de)			;7e68
	and 07fh		;7e69
	cp 014h		;7e6b
	call z,apunta_la_del_tipo_14		;7e6d   ; apunta_la_del_tipo_14: la casilla y la marca de una cosa de tipo 0x14
	inc de			;7e70
	djnz L_7E67		;7e71
	ld a,c			;7e73   ; 0xC28D = cuantas hay
	ld (0c28dh),a		;7e74
	or a			;7e77
	jp z,04206h		;7e78   ; bancos_1_2_3: pone los bancos 1, 2 y 3
	ld a,r		;7e7b   ; una de ellas, al azar (registro R), lleva la marca 0x80
	dec c			;7e7d
	and c			;7e7e
	add a,a			;7e7f
	ld hl,0c341h		;7e80
	call 04083h		;7e83   ; hl_mas_a: HL += A
	ld a,080h		;7e86
	ld (hl),a			;7e88
	jp 04206h		;7e89   ; bancos_1_2_3: pone los bancos 1, 2 y 3
apunta_la_del_tipo_14:		; la casilla y la marca de una cosa de tipo 0x14
	dec de			;7e8c   ; la casilla, y la marca 0x80 cada cuatro (segun la cuenta del bucle)
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
limpia_0xc340:		; deja solo el bit 7 de cada marca de 0xC340
	ld hl,0c341h		;7e9d   ; en las 16 de 0xC340, se deja solo el bit 7 de la marca
	ld b,010h		;7ea0
L_7EA2:
	ld a,(hl)			;7ea2
	and 080h		;7ea3   ; solo el bit 7
	ld (hl),a			;7ea5
	inc hl			;7ea6   ; la siguiente, 2 bytes mas alla
	inc hl			;7ea7
	djnz L_7EA2		;7ea8
	ret			;7eaa
busca_al_vecino:		; 0xEF00 = 0xFF si hay un Game Master (firma en 0x7FFA) o un Q*bert (0xBFFA) en otra ranura
	ld bc,00400h		;7eab   ; en las cuatro ranuras primarias...
	ld hl,0fcc1h		;7eae
L_7EB1:
	push bc			;7eb1
	push hl			;7eb2
	ld a,(hl)			;7eb3
	bit 7,a		;7eb4   ; ... expandida, en sus cuatro subranuras
	jr nz,L_7ECC		;7eb6
	call es_el_vecino		;7eb8   ; es_el_vecino: carry si en la ranura C esta la firma de Q*bert o la del Game Master
L_7EBB:
	pop hl			;7ebb
	pop bc			;7ebc
	jr c,L_7EC6		;7ebd   ; encontrado
	inc hl			;7ebf   ; la ranura siguiente
	inc c			;7ec0
	djnz L_7EB1		;7ec1
	xor a			;7ec3   ; no: 0xEF00 = 0
	jr L_7EC8		;7ec4
L_7EC6:
	ld a,0ffh		;7ec6   ; encontrado: 0xEF00 = 0xFF
L_7EC8:
	ld (0ef00h),a		;7ec8   ; guarda el VECINO: 0xFF con el Game Master o Q*bert en otra ranura
	ret			;7ecb
L_7ECC:
	call busca_en_subranuras		;7ecc   ; una ranura expandida: sus subranuras
	jr L_7EBB		;7ecf
busca_en_subranuras:		; las cuatro subranuras de la ranura C
	and 080h		;7ed1
	or c			;7ed3
	ld c,a			;7ed4
	ld b,004h		;7ed5
L_7ED7:
	push bc			;7ed7
	call es_el_vecino		;7ed8   ; es_el_vecino: carry si en la ranura C esta la firma de Q*bert o la del Game Master
	pop bc			;7edb
	ret c			;7edc
	ld a,c			;7edd
	add a,004h		;7ede
	ld c,a			;7ee0
	djnz L_7ED7		;7ee1
	and a			;7ee3
	ret			;7ee4
es_el_vecino:		; carry si en la ranura C esta la firma de Q*bert o la del Game Master
	ld de,07f14h		;7ee5   ; los 6 bytes de 0xBFFA contra la firma de Q*bert (0x7F14)...
	ld hl,0bffah		;7ee8
	ld b,006h		;7eeb
	call compara_en_ranura		;7eed   ; compara_en_ranura: carry si los B bytes de HL en la ranura C son los de DE
	ret c			;7ef0
	ld de,07f0eh		;7ef1   ; ... y los de 0x7FFA contra la del Game Master (0x7F0E)
	ld hl,07ffah		;7ef4
	ld b,006h		;7ef7
compara_en_ranura:		; carry si los B bytes de HL en la ranura C son los de DE
	push bc			;7ef9
	push de			;7efa
	ld a,c			;7efb
	call 0000ch		;7efc   ; BIOS RDSLT - Reads the value of an address in another slot | RDSLT: el byte de la otra ranura
	pop de			;7eff
	pop bc			;7f00
	ex de,hl			;7f01
	cp (hl)			;7f02
	ex de,hl			;7f03
	jr nz,L_7F0C		;7f04
	inc hl			;7f06
	inc de			;7f07
	djnz compara_en_ranura		;7f08
	scf			;7f0a   ; los 6 iguales: carry
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


menu_del_vecino:		; la ventana, el marco y el texto del menu
	call ventana_del_menu		;7f1a   ; el menu del vecino: (0x20, 0x90), 0xC0 x 0x38, marco y texto
	ld c,00eh		;7f1d
	call 04704h		;7f1f   ; marco: pinta un marco: (H, L), D de ancho, E de alto, color C
	ld hl,07f41h		;7f22
	jp 048f3h		;7f25   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba
ventana_del_menu:		; borra (0x20, 0x90), 0xC0 x 0x38
	ld hl,02090h		;7f28
	ld bc,0c038h		;7f2b
rellena_y_mide:		; rellena (H, L) B x C del color 0; DE = el tamano
	xor a			;7f2e   ; rellena del color 0 y deja DE = el tamano para el marco
	ld d,000h		;7f2f
	push bc			;7f31
	push hl			;7f32
	call 04732h		;7f33   ; hmmv: orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)
	pop hl			;7f36
	pop de			;7f37
	ret			;7f38
ventana_con_marco:		; rellena y le pone marco
	call rellena_y_mide		;7f39   ; rellena_y_mide: rellena (H, L) B x C del color 0; DE = el tamano
	ld c,00eh		;7f3c
	jp 04704h		;7f3e   ; marco: pinta un marco: (H, L), D de ancho, E de alto, color C

; ----------------------------------------------------------------------
; DATOS rotulo_7F41: rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p01:7F25 (66 bytes)
;   0x7f41..0x7f83  (66 bytes)
DATA_rotulo_7F41:
	defb 058h,098h,066h,066h,066h,03dh,05dh,03fh,037h,066h,066h,066h,0feh,024h,0a8h,0bch	; 7f41  X.fff=]?7fff.$..
	defb 0bdh,0feh,040h,0a8h,055h,044h,034h,03bh,000h,049h,03bh,063h,051h,058h,0feh,040h	; 7f51  ..@.UD4..I.cQX.@
	defb 0b0h,037h,045h,048h,000h,049h,063h,05dh,039h,063h,032h,05ch,000h,035h,033h,058h	; 7f61  .7EH.Ic]9c2\.53X
	defb 0feh,040h,0b8h,039h,063h,033h,052h,05dh,048h,035h,03ch,063h,05ch,000h,035h,033h	; 7f71  .@.9c3R]H5<c\.53
	defb 058h,0ffh	; 7f81

; ======================================================================
; CODIGO 0x7f83..0x7f94  (17 bytes)
; ======================================================================


opcion_1:		; texto y numero (0xEF05) de la opcion 1
	ld hl,07f94h		;7f83   ; la opcion 1: su texto y el numero de 0xEF05 en (0xB0, 0xA8)
	call texto_de_opcion		;7f86   ; texto_de_opcion: borra la linea y pinta el rotulo de HL
	ld hl,0ef05h		;7f89
	ld de,0b0a8h		;7f8c
L_7F8F:
	ld b,001h		;7f8f
	jp 04420h		;7f91   ; pinta_bcd: pinta cifras en BCD

; ----------------------------------------------------------------------
; DATOS rotulo_7F94: rotulo en (0x48, 0xA8) que p01:7F83 escribe con 0x48F3
;   (p01:7FB1) (15 bytes)
;   0x7f94..0x7fa3  (15 bytes)
DATA_rotulo_7F94:
	defb 048h,0a8h,037h,045h,048h,049h,063h,05dh,039h,063h,032h,049h,000h,067h,0ffh	; 7f94  H.7EHIc]9c2I.g.

; ======================================================================
; CODIGO 0x7fa3..0x7fb9  (22 bytes)
; ======================================================================


opcion_2:		; texto y numero (0xEF07) de la opcion 2
	ld hl,07fb9h		;7fa3   ; la opcion 2: su texto y el numero de 0xEF07 en (0xB8, 0xA8)
	call texto_de_opcion		;7fa6   ; texto_de_opcion: borra la linea y pinta el rotulo de HL
	ld hl,0ef07h		;7fa9
	ld de,0b8a8h		;7fac
	jr $-32		;7faf
texto_de_opcion:		; borra la linea y pinta el rotulo de HL
	push hl			;7fb1
	call borra_las_opciones		;7fb2   ; borra_las_opciones: borra (0x24, 0xA0), 0xB8 x 0x20
	pop hl			;7fb5
	jp 048f3h		;7fb6   ; rotulo: pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba

; ----------------------------------------------------------------------
; DATOS rotulo_7FB9: rotulo en (0x48, 0xA8) que p01:7FA3 escribe con 0x48F3
;   (p01:7FB1) (15 bytes)
;   0x7fb9..0x7fc8  (15 bytes)
DATA_rotulo_7FB9:
	defb 048h,0a8h,039h,063h,033h,052h,05dh,048h,035h,03ch,063h,049h,000h,067h,0ffh	; 7fb9  H.9c3R]H5<cI.g.

; ======================================================================
; CODIGO 0x7fc8..0x8000  (56 bytes)
; ======================================================================


borra_las_opciones:		; borra (0x24, 0xA0), 0xB8 x 0x20
	ld hl,024a0h		;7fc8   ; borra la linea de las opciones: (0x24, 0xA0), 0xB8 x 0x20
	ld bc,0b820h		;7fcb
	jp rellena_y_mide		;7fce   ; rellena_y_mide: rellena (H, L) B x C del color 0; DE = el tamano
cifra_del_menu:		; la cifra tecleada en el menu del vecino
	call 08006h		;7fd1   ; la tecla que se aprieta en el menu (p02:8006)
	ret z			;7fd4   ; ninguna: nada
	ld hl,(0ef08h)		;7fd5   ; L = las teclas 0-7, H = 8 y 9
	ld d,000h		;7fd8
	ld b,008h		;7fda   ; D = la cifra de las 0-7
	ld a,l			;7fdc
	call 08000h		;7fdd
	jr c,L_7FE9		;7fe0
	ld a,h			;7fe2   ; o de las 8 y 9
	ld b,002h		;7fe3
	call 08000h		;7fe5
	ret nc			;7fe8
L_7FE9:
	ld hl,0ef15h		;7fe9   ; 0xEF15 = 0xFF y la cifra a 0xEF0F
	ld (hl),0ffh		;7fec
	ld hl,0ef0fh		;7fee
	ld a,d			;7ff1   ; la cifra entra por abajo en 0xEF0F (rld)
	rld		;7ff2
	ld de,(0ef02h)		;7ff4   ; y se pinta donde dice 0xEF02
	ld b,001h		;7ff8
	call 04420h		;7ffa   ; pinta_bcd: pinta cifras en BCD
	jp 08027h		;7ffd
