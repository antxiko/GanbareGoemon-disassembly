; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX2 - MegaROM RC-748 de 128 KB (Konami4) - banco 09 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS rle_9FB0_cola: rle dado la vuelta a un bufer y de ahi a la VRAM
;   (0x4562) (sigue del banco anterior, 0x9FB0); lo leen p00:4BF6, p00:4BFF
;   (270 bytes)
;   0xa000..0xa10e  (270 bytes)
DATA_rle_9FB0_cola:
	defb 09fh,03fh,003h,0ffh,084h,0feh,0fch,0feh,0feh,003h,0ffh,0aah,000h,020h,015h,057h	; a000  .?........... .W
	defb 06bh,06ah,042h,072h,074h,032h,005h,03fh,079h,07eh,07eh,000h,000h,05eh,0bch,056h	; a010  kjBrt2.?y~~..^.V
	defb 06eh,0ceh,006h,07ah,0feh,0fch,038h,0c4h,0fch,0feh,07eh,000h,000h,05fh,06fh,0efh	; a020  n..z..8...~.._o.
	defb 0f7h,0f7h,0ffh,0ffh,0fbh,07dh,004h,03fh,088h,01fh,03fh,0ffh,0e1h,0c2h,0afh,09fh	; a030  .....}.?..?.....
	defb 03fh,003h,0ffh,0a3h,0feh,0fch,0f8h,0fch,0fch,0feh,0ffh,0ffh,020h,015h,057h,06bh	; a040  ?........... .Wk
	defb 06ah,042h,072h,074h,032h,005h,01fh,01dh,01bh,00bh,01bh,000h,05eh,0bch,056h,06eh	; a050  jBrt2.......^.Vn
	defb 0ceh,006h,07ah,0feh,0fch,038h,0c0h,003h,0f8h,08bh,0feh,000h,05fh,06fh,0efh,0f7h	; a060  ..z..8......_o..
	defb 0f7h,0ffh,0ffh,0f5h,07fh,003h,0ffh,004h,000h,085h,0e1h,0c2h,0afh,01fh,03fh,004h	; a070  ..............?.
	defb 0ffh,083h,0feh,0ffh,0ffh,004h,000h,08bh,020h,015h,057h,06ah,06ah,042h,070h,06ah	; a080  ........ .WjjBpj
	defb 01fh,071h,077h,005h,000h,08bh,05eh,0bch,056h,0eeh,0ceh,006h,07ah,07eh,0beh,0c0h	; a090  .qw...^.V...z~..
	defb 0feh,008h,000h,002h,001h,004h,002h,003h,001h,003h,003h,084h,00fh,012h,07dh,0b8h	; a0a0  ..............}.
	defb 003h,070h,086h,071h,061h,061h,001h,000h,081h,004h,0ffh,005h,000h,004h,001h,003h	; a0b0  .p.qaa..........
	defb 000h,002h,001h,002h,000h,083h,00ch,002h,047h,003h,08fh,095h,08eh,09eh,09eh,0feh	; a0c0  ........G.......
	defb 0ffh,07eh,0c0h,0a7h,0efh,000h,000h,0fch,0c3h,0e0h,0f1h,0f3h,0f7h,0e7h,0eeh,0feh	; a0d0  .~..............
	defb 0fdh,005h,0ffh,003h,000h,09ch,080h,000h,080h,080h,0c0h,0e0h,0f0h,0f0h,0f8h,0fch	; a0e0  ................
	defb 0feh,0feh,0ffh,000h,000h,03ch,01fh,00eh,00dh,00bh,01ah,015h,02dh,07ah,0fdh,01dh	; a0f0  .....<......-z..
	defb 0edh,0fbh,009h,000h,088h,040h,060h,0e0h,060h,0e8h,09ch,0fch,000h,000h	; a100  .....@`.`.....

; ----------------------------------------------------------------------
; DATOS rle_A10E: rle a la VRAM (0x4539); lo leen p00:4C08 (620 bytes)
;   0xa10e..0xa37a  (620 bytes)
DATA_rle_A10E:
	defb 002h,000h,08eh,003h,002h,001h,007h,00fh,00eh,007h,004h,017h,017h,01fh,00ch,007h	; a10e  ................
	defb 003h,004h,000h,0aeh,0e0h,0f8h,0f8h,06ch,0fch,064h,06ch,0fch,00ch,0f4h,098h,0f0h	; a11e  .......l.dl.....
	defb 003h,003h,004h,005h,00eh,018h,030h,031h,038h,03bh,028h,028h,020h,013h,008h,004h	; a12e  ......018;(( ...
	defb 0c0h,0c0h,080h,0e0h,018h,004h,004h,092h,002h,09ah,092h,002h,0f2h,00ah,064h,008h	; a13e  ..............d.
	defb 00fh,03fh,003h,07fh,0bdh,0ffh,0feh,0fdh,0ffh,07eh,07eh,03ch,010h,010h,008h,03fh	; a14e  .?.......~~<...?
	defb 0f0h,09ch,0feh,0feh,09eh,03fh,07fh,08fh,0ffh,00fh,006h,046h,026h,028h,014h,0feh	; a15e  .....?.....F&(..
	defb 004h,007h,003h,001h,000h,000h,001h,002h,000h,001h,001h,003h,00fh,00fh,007h,000h	; a16e  ................
	defb 000h,060h,090h,090h,060h,0d0h,080h,070h,000h,0f0h,0f8h,0b8h,0d8h,0d0h,0e8h,000h	; a17e  .`..`..p........
	defb 00fh,03fh,003h,07eh,08fh,0fch,0fdh,0ffh,0ffh,07eh,07ch,040h,080h,080h,0ffh,000h	; a18e  .?.~.....~|@....
	defb 0f0h,098h,07ch,07eh,003h,0ffh,08bh,08fh,0ffh,00fh,007h,01ah,021h,041h,0ffh,000h	; a19e  ..|~........!A..
	defb 004h,006h,003h,001h,089h,003h,002h,000h,000h,001h,003h,03fh,07fh,07fh,003h,000h	; a1ae  ...........?....
	defb 08dh,060h,090h,090h,060h,060h,000h,070h,000h,0f0h,0f8h,0e4h,0deh,0beh,006h,000h	; a1be  .`..``.p........
	defb 0bdh,001h,007h,00fh,00ch,00fh,008h,01eh,01fh,00ch,009h,007h,003h,000h,000h,0c0h	; a1ce  ................
	defb 000h,0e0h,0f8h,0fch,0cch,0fch,0c4h,0deh,0feh,00ch,0e4h,038h,0f0h,003h,003h,001h	; a1de  ...........8....
	defb 001h,006h,008h,010h,013h,030h,037h,021h,020h,013h,016h,008h,0fch,0f0h,0f0h,020h	; a1ee  .....07! ......
	defb 0e0h,018h,004h,002h,032h,003h,03bh,021h,001h,0f2h,01ah,0c4h,00eh,001h,004h,000h	; a1fe  ....2.;!........
	defb 004h,001h,002h,002h,081h,001h,004h,000h,088h,007h,081h,080h,05eh,0feh,0fdh,0feh	; a20e  ............^...
	defb 0c3h,003h,000h,081h,0ffh,00dh,000h,002h,001h,005h,000h,088h,0f8h,07eh,07fh,021h	; a21e  .............~.!
	defb 001h,002h,001h,03ch,003h,0ffh,005h,000h,002h,0ffh,08ah,07fh,03fh,07fh,0ffh,01fh	; a22e  ...<........?...
	defb 0f0h,0c0h,000h,0c0h,0ffh,005h,000h,083h,0c0h,0e0h,0e0h,003h,0f0h,085h,0f8h,038h	; a23e  ...............8
	defb 018h,010h,0e0h,004h,000h,08bh,008h,018h,090h,0d0h,0a0h,000h,0e0h,00fh,03fh,0ffh	; a24e  ..............?.
	defb 03fh,00dh,000h,083h,0c0h,0e0h,0e0h,00fh,000h,086h,003h,00ch,010h,020h,010h,00ch	; a25e  ?............ ..
	defb 009h,000h,087h,001h,0c3h,037h,00fh,007h,01fh,0efh,00bh,000h,085h,003h,00fh,01fh	; a26e  .....7..........
	defb 00fh,003h,00bh,000h,084h,0c0h,0f0h,0f8h,0e0h,009h,000h,088h,018h,000h,000h,042h	; a27e  ...............B
	defb 042h,0e7h,0ffh,0ffh,017h,000h,087h,03ch,066h,0ffh,0ffh,0bdh,0bdh,018h,00bh,000h	; a28e  B......<f.......
	defb 08ah,080h,0c0h,0c0h,0e0h,0e0h,0a0h,0f8h,003h,007h,002h,00dh,000h,002h,00fh,087h	; a29e  ................
	defb 006h,001h,002h,001h,01eh,07fh,0ffh,007h,000h,089h,004h,008h,005h,00fh,00fh,007h	; a2ae  ................
	defb 003h,000h,001h,007h,000h,002h,0f0h,088h,0f9h,0feh,0fdh,0feh,0e1h,080h,000h,0ffh	; a2be  ................
	defb 006h,000h,002h,0ffh,087h,066h,0f8h,004h,0f8h,007h,0ffh,09fh,00dh,000h,083h,080h	; a2ce  .....f..........
	defb 0e0h,0f0h,009h,000h,088h,099h,007h,0fbh,003h,0f8h,000h,060h,0ffh,006h,000h,002h	; a2de  ...........`....
	defb 0f8h,004h,0feh,084h,077h,01fh,00fh,0feh,008h,000h,002h,002h,002h,001h,002h,000h	; a2ee  ....w...........
	defb 084h,001h,002h,002h,001h,004h,000h,088h,01fh,03fh,01fh,03fh,03fh,011h,0c0h,0ffh	; a2fe  .........?.??...
	defb 003h,000h,081h,0ffh,006h,000h,002h,001h,005h,000h,002h,001h,005h,000h,088h,004h	; a30e  ................
	defb 002h,0e3h,0c1h,0c0h,0eeh,03fh,000h,003h,0ffh,005h,000h,006h,0ffh,086h,09fh,0f0h	; a31e  .....?..........
	defb 0c0h,000h,0c0h,0ffh,005h,000h,083h,0c0h,0e0h,0e0h,003h,0f0h,085h,0f8h,038h,018h	; a32e  ..............8.
	defb 010h,0e0h,004h,000h,08bh,008h,018h,030h,060h,040h,000h,060h,00fh,03fh,0ffh,03fh	; a33e  .......0`@.`.?.?
	defb 00dh,000h,083h,0c0h,0e0h,0e0h,005h,000h,0a0h,008h,0e7h,008h,0e7h,008h,0e7h,008h	; a34e  ................
	defb 0e7h,008h,0e7h,008h,0e7h,008h,0e7h,008h,0e7h,008h,0e7h,008h,0e7h,008h,0e7h,008h	; a35e  ................
	defb 0e7h,008h,0e7h,008h,0e7h,008h,0e7h,008h,0e7h,020h,000h,000h	; a36e  ......... ..

; ----------------------------------------------------------------------
; DATOS paleta_de_cada_juego: 6 punteros, uno por juego de graficos (0xC289),
;   a su lista de colores (p00:4CF0); lo leen p00:4CE9 (12 bytes)
;   0xa37a..0xa386  (12 bytes)
DATA_paleta_de_cada_juego:
	defb 086h,0a3h,096h,0a3h,0c0h,0a3h,0d0h,0a3h,0ach,0a3h,0b9h,0a3h	; a37a  ............

; ----------------------------------------------------------------------
; DATOS paleta_juego_0: los colores del juego de graficos 0: [color][RB][G],
;   0xFF acaba (0x4666); lo leen p00:4CF3 (16 bytes)
;   0xa386..0xa396  (16 bytes)
DATA_paleta_juego_0:
	defb 005h,050h,003h,00ah,040h,002h,00bh,004h,002h,00dh,001h,004h,00fh,001h,002h,0ffh	; a386  .P..@...........

; ----------------------------------------------------------------------
; DATOS paleta_juego_1: los colores del juego de graficos 1: [color][RB][G],
;   0xFF acaba (0x4666); lo leen p00:4CF3 (22 bytes)
;   0xa396..0xa3ac  (22 bytes)
DATA_paleta_juego_1:
	defb 005h,056h,002h,007h,030h,001h,009h,063h,005h,00ah,040h,002h,00bh,027h,005h,00dh	; a396  .V..0..c..@..'..
	defb 001h,004h,00fh,000h,002h,0ffh	; a3a6

; ----------------------------------------------------------------------
; DATOS paleta_juego_4: los colores del juego de graficos 4: [color][RB][G],
;   0xFF acaba (0x4666); lo leen p00:4CF3 (13 bytes)
;   0xa3ac..0xa3b9  (13 bytes)
DATA_paleta_juego_4:
	defb 005h,050h,003h,00bh,022h,002h,00dh,000h,005h,00fh,000h,002h,0ffh	; a3ac  .P.."........

; ----------------------------------------------------------------------
; DATOS paleta_juego_5: los colores del juego de graficos 5: [color][RB][G],
;   0xFF acaba (0x4666); lo leen p00:4CF3 (7 bytes)
;   0xa3b9..0xa3c0  (7 bytes)
DATA_paleta_juego_5:
	defb 005h,060h,003h,00ah,050h,002h,0ffh	; a3b9

; ----------------------------------------------------------------------
; DATOS paleta_juego_2: los colores del juego de graficos 2: [color][RB][G],
;   0xFF acaba (0x4666); lo leen p00:4CF3 (16 bytes)
;   0xa3c0..0xa3d0  (16 bytes)
DATA_paleta_juego_2:
	defb 005h,040h,003h,00ah,072h,005h,00bh,051h,003h,00dh,001h,004h,00fh,000h,002h,0ffh	; a3c0  .@..r..Q........

; ----------------------------------------------------------------------
; DATOS paleta_juego_3: los colores del juego de graficos 3: [color][RB][G],
;   0xFF acaba (0x4666); lo leen p00:4CF3 (22 bytes)
;   0xa3d0..0xa3e6  (22 bytes)
DATA_paleta_juego_3:
	defb 005h,052h,004h,007h,041h,003h,009h,065h,006h,00ah,007h,005h,00bh,015h,002h,00dh	; a3d0  .R..A..e........
	defb 002h,005h,00fh,000h,002h,0ffh	; a3e0

; ----------------------------------------------------------------------
; DATOS paleta_A3E6: colores de la paleta, [color][RB][G], 0xFF acaba
;   (0x4666); lo leen p00:4D02 (25 bytes)
;   0xa3e6..0xa3ff  (25 bytes)
DATA_paleta_A3E6:
	defb 000h,000h,000h,001h,074h,005h,002h,000h,000h,003h,070h,000h,007h,030h,001h,008h	; a3e6  ....t.....p..0..
	defb 070h,005h,00ch,044h,004h,00eh,077h,007h,0ffh	; a3f6  p..D..w..

; ----------------------------------------------------------------------
; DATOS paleta_A3FF: colores de la paleta, [color][RB][G], 0xFF acaba
;   (0x4666); lo leen p00:4D0E (25 bytes)
;   0xa3ff..0xa418  (25 bytes)
DATA_paleta_A3FF:
	defb 004h,063h,004h,005h,016h,003h,007h,020h,001h,009h,041h,002h,00ah,040h,002h,00bh	; a3ff  .c..... ..A..@..
	defb 030h,001h,00dh,010h,001h,00fh,031h,002h,0ffh	; a40f  0.....1..

; ----------------------------------------------------------------------
; DATOS colores_A418: una lista de colores con el formato de 0x4666
;   ([color][RB][G], 0xFF acaba) a la que no apunta nadie: ni 0xA37A ni 0xA4D1
;   la nombran (19 bytes)
;   0xa418..0xa42b  (19 bytes)
DATA_colores_A418:
	defb 005h,007h,003h,009h,063h,005h,00ah,051h,003h,00bh,052h,004h,00dh,032h,005h,00fh	; a418  ....c..Q..R..2..
	defb 031h,002h,0ffh	; a428

; ----------------------------------------------------------------------
; DATOS paleta_A42B: colores de la paleta, [color][RB][G], 0xFF acaba
;   (0x4666); lo leen p00:4D26 (13 bytes)
;   0xa42b..0xa438  (13 bytes)
DATA_paleta_A42B:
	defb 005h,050h,003h,00bh,022h,002h,00dh,001h,006h,00fh,001h,003h,0ffh	; a42b  .P.."........

; ----------------------------------------------------------------------
; DATOS paleta_A438: colores de la paleta, [color][RB][G], 0xFF acaba
;   (0x4666); lo leen p00:4B7F (22 bytes)
;   0xa438..0xa44e  (22 bytes)
DATA_paleta_A438:
	defb 004h,060h,004h,006h,020h,001h,009h,002h,004h,00ah,011h,002h,00bh,050h,003h,00dh	; a438  .`.. ........P..
	defb 030h,002h,00fh,053h,004h,0ffh	; a448

; ----------------------------------------------------------------------
; DATOS paleta_A44E: colores de la paleta, [color][RB][G], 0xFF acaba
;   (0x4666); lo leen p00:4D4E (40 bytes)
;   0xa44e..0xa476  (40 bytes)
DATA_paleta_A44E:
	defb 000h,000h,000h,001h,060h,001h,002h,040h,001h,003h,020h,000h,004h,070h,004h,005h	; a44e  ....`..@.. ..p..
	defb 070h,001h,007h,006h,000h,008h,070h,005h,009h,060h,005h,00ah,040h,003h,00ch,012h	; a45e  p.....p..`..@...
	defb 001h,00dh,022h,002h,00eh,077h,007h,0ffh	; a46e  .."..w..

; ----------------------------------------------------------------------
; DATOS paleta_A476: colores de la paleta, [color][RB][G], 0xFF acaba
;   (0x4666); lo leen p00:4D5D (25 bytes)
;   0xa476..0xa48f  (25 bytes)
DATA_paleta_A476:
	defb 004h,061h,004h,005h,051h,003h,006h,041h,002h,009h,000h,006h,00ah,000h,003h,00bh	; a476  .a..Q..A........
	defb 022h,002h,00dh,016h,004h,00fh,007h,000h,0ffh	; a486  "........

; ----------------------------------------------------------------------
; DATOS paleta_A48F: colores de la paleta, [color][RB][G], 0xFF acaba
;   (0x4666); lo leen p00:4D7B (22 bytes)
;   0xa48f..0xa4a5  (22 bytes)
DATA_paleta_A48F:
	defb 009h,051h,003h,00ah,040h,002h,00bh,063h,004h,00dh,003h,005h,00fh,073h,005h,004h	; a48f  .Q..@..c.....s..
	defb 077h,007h,006h,047h,003h,0ffh	; a49f

; ----------------------------------------------------------------------
; DATOS colores_A4A5: otra lista de colores a la que no apunta nadie; es igual
;   que la de 0xA418 salvo el valor del color 0x0B (19 bytes)
;   0xa4a5..0xa4b8  (19 bytes)
DATA_colores_A4A5:
	defb 005h,007h,003h,009h,063h,005h,00ah,051h,003h,00bh,052h,003h,00dh,032h,005h,00fh	; a4a5  ....c..Q..R..2..
	defb 031h,002h,0ffh	; a4b5

; ----------------------------------------------------------------------
; DATOS paleta_A4B8: colores de la paleta, [color][RB][G], 0xFF acaba
;   (0x4666); lo leen p00:4D6C (13 bytes)
;   0xa4b8..0xa4c5  (13 bytes)
DATA_paleta_A4B8:
	defb 005h,050h,003h,009h,062h,004h,00ah,030h,002h,00bh,022h,002h,0ffh	; a4b8  .P..b..0.."..

; ----------------------------------------------------------------------
; DATOS colores_de_cada_sitio: 6 punteros, uno por juego de graficos, a una
;   ventana de la lista de 0xA4D1: el puntero de cada sitio (0xC267) a los
;   colores que se le cambian (p00:4D36); lo leen p00:4D33 (12 bytes)
;   0xa4c5..0xa4d1  (12 bytes)
DATA_colores_de_cada_sitio:
	defb 0d1h,0a4h,0d7h,0a4h,0d9h,0a4h,0d5h,0a4h,0dfh,0a4h,0e3h,0a4h	; a4c5  ............

; ----------------------------------------------------------------------
; DATOS colores_de_los_sitios: 16 punteros seguidos a listas de colores; cada
;   juego entra por un sitio distinto (0xA4C5) y p00:4D3D escoge por 0xC267;
;   lo leen p00:4D3D (32 bytes)
;   0xa4d1..0xa4f1  (32 bytes)
DATA_colores_de_los_sitios:
	defb 0f1h,0a4h,0f5h,0a4h,0f4h,0a4h,0f4h,0a4h,0fdh,0a4h,001h,0a5h,005h,0a5h,009h,0a5h	; a4d1  ................
	defb 010h,0a5h,01ah,0a5h,027h,0a5h,034h,0a5h,041h,0a5h,04eh,0a5h,05bh,0a5h,068h,0a5h	; a4e1  ....'.4.A.N.[.h.

; ----------------------------------------------------------------------
; DATOS colores_A4F1: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; se solapan 2
;   bloques (0xA4F1-0xA4F5, 0xA4F4-0xA4F5); lo leen p00:4D42 (4 bytes)
;   0xa4f1..0xa4f5  (4 bytes)
DATA_colores_A4F1:
	defb 009h,052h,003h,0ffh	; a4f1

; ----------------------------------------------------------------------
; DATOS colores_A4F5: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (4 bytes)
;   0xa4f5..0xa4f9  (4 bytes)
DATA_colores_A4F5:
	defb 009h,062h,004h,0ffh	; a4f5

; ----------------------------------------------------------------------
; DATOS colores_A4F9: una lista de un color ([0x09][0x31][0x02], 0xFF) entre
;   las de 0xA4F5 y 0xA4FD; la ventana de 0xA4D1 salta de 0xA4F5 a 0xA4F4 y no
;   la nombra (4 bytes)
;   0xa4f9..0xa4fd  (4 bytes)
DATA_colores_A4F9:
	defb 009h,031h,003h,0ffh	; a4f9

; ----------------------------------------------------------------------
; DATOS colores_A4FD: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (4 bytes)
;   0xa4fd..0xa501  (4 bytes)
DATA_colores_A4FD:
	defb 009h,042h,003h,0ffh	; a4fd

; ----------------------------------------------------------------------
; DATOS colores_A501: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (4 bytes)
;   0xa501..0xa505  (4 bytes)
DATA_colores_A501:
	defb 009h,031h,002h,0ffh	; a501

; ----------------------------------------------------------------------
; DATOS colores_A505: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (4 bytes)
;   0xa505..0xa509  (4 bytes)
DATA_colores_A505:
	defb 009h,051h,003h,0ffh	; a505

; ----------------------------------------------------------------------
; DATOS colores_A509: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (7 bytes)
;   0xa509..0xa510  (7 bytes)
DATA_colores_A509:
	defb 009h,063h,004h,00ah,003h,002h,0ffh	; a509

; ----------------------------------------------------------------------
; DATOS colores_A510: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (10 bytes)
;   0xa510..0xa51a  (10 bytes)
DATA_colores_A510:
	defb 009h,042h,003h,00ah,002h,002h,00bh,022h,002h,0ffh	; a510  .B....."..

; ----------------------------------------------------------------------
; DATOS colores_A51A: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (13 bytes)
;   0xa51a..0xa527  (13 bytes)
DATA_colores_A51A:
	defb 009h,062h,004h,00bh,003h,002h,00dh,022h,002h,00fh,021h,002h,0ffh	; a51a  .b....."..!..

; ----------------------------------------------------------------------
; DATOS colores_A527: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (13 bytes)
;   0xa527..0xa534  (13 bytes)
DATA_colores_A527:
	defb 009h,031h,003h,00bh,020h,001h,00dh,001h,005h,00fh,001h,003h,0ffh	; a527  .1.. ........

; ----------------------------------------------------------------------
; DATOS colores_A534: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (13 bytes)
;   0xa534..0xa541  (13 bytes)
DATA_colores_A534:
	defb 009h,042h,003h,00bh,020h,001h,00dh,007h,004h,00fh,005h,002h,0ffh	; a534  .B.. ........

; ----------------------------------------------------------------------
; DATOS colores_A541: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (13 bytes)
;   0xa541..0xa54e  (13 bytes)
DATA_colores_A541:
	defb 009h,022h,003h,00bh,020h,001h,00dh,001h,003h,00fh,022h,000h,0ffh	; a541  .".. ....."..

; ----------------------------------------------------------------------
; DATOS colores_A54E: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (13 bytes)
;   0xa54e..0xa55b  (13 bytes)
DATA_colores_A54E:
	defb 009h,042h,002h,00bh,020h,001h,00dh,007h,004h,00fh,005h,002h,0ffh	; a54e  .B.. ........

; ----------------------------------------------------------------------
; DATOS colores_A55B: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (13 bytes)
;   0xa55b..0xa568  (13 bytes)
DATA_colores_A55B:
	defb 009h,042h,003h,00bh,020h,001h,00dh,001h,005h,00fh,001h,002h,0ffh	; a55b  .B.. ........

; ----------------------------------------------------------------------
; DATOS colores_A568: colores de un sitio: [color][RB][G], 0xFF acaba
;   (0x4666); 0xA4F4 es el 0xFF de la de 0xA4F1, una lista vacia; lo leen
;   p00:4D42 (13 bytes)
;   0xa568..0xa575  (13 bytes)
DATA_colores_A568:
	defb 009h,032h,002h,00bh,020h,001h,00dh,001h,005h,00fh,001h,003h,0ffh	; a568  .2.. ........

; ----------------------------------------------------------------------
; DATOS plano_de_cada_zona: 49 punteros, uno por zona (fase x 7 + zona), a su
;   ficha de plano (p00:59B9); lo leen p00:59B6 (98 bytes)
;   0xa575..0xa5d7  (98 bytes)
DATA_plano_de_cada_zona:
	defb 0d7h,0a5h,0e1h,0a5h,0edh,0a5h,0f9h,0a5h,007h,0a6h,019h,0a6h,019h,0a6h,027h,0a6h	; a575  ..............'.
	defb 02dh,0a6h,039h,0a6h,047h,0a6h,051h,0a6h,05bh,0a6h,05bh,0a6h,071h,0a6h,07fh,0a6h	; a585  -.9.G.Q.[.[.q...
	defb 08dh,0a6h,09fh,0a6h,0abh,0a6h,0bfh,0a6h,0bfh,0a6h,0d3h,0a6h,0e3h,0a6h,0f3h,0a6h	; a595  ................
	defb 001h,0a7h,015h,0a7h,01dh,0a7h,01dh,0a7h,033h,0a7h,03bh,0a7h,045h,0a7h,053h,0a7h	; a5a5  ........3.;.E.S.
	defb 06bh,0a7h,083h,0a7h,083h,0a7h,099h,0a7h,0a5h,0a7h,0bfh,0a7h,0cfh,0a7h,0e1h,0a7h	; a5b5  k...............
	defb 0efh,0a7h,0efh,0a7h,005h,0a8h,00bh,0a8h,023h,0a8h,031h,0a8h,043h,0a8h,05bh,0a8h	; a5c5  ........#.1.C.[.
	defb 05bh,0a8h	; a5d5

; ----------------------------------------------------------------------
; DATOS plano_A5D7: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 1-0
;   (10 bytes)
;   0xa5d7..0xa5e1  (10 bytes)
DATA_plano_A5D7:
	defb 000h,065h,001h,04eh,001h,086h,004h,0ceh,004h,000h	; a5d7  .e.N......

; ----------------------------------------------------------------------
; DATOS plano_A5E1: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 1-1
;   (12 bytes)
;   0xa5e1..0xa5ed  (12 bytes)
DATA_plano_A5E1:
	defb 001h,061h,006h,084h,006h,047h,002h,04ch,005h,0cch,003h,000h	; a5e1  .a...G.L....

; ----------------------------------------------------------------------
; DATOS plano_A5ED: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 1-2
;   (12 bytes)
;   0xa5ed..0xa5f9  (12 bytes)
DATA_plano_A5ED:
	defb 003h,046h,002h,089h,005h,0aeh,001h,0ceh,003h,06eh,005h,000h	; a5ed  .F.......n..

; ----------------------------------------------------------------------
; DATOS plano_A5F9: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 1-3
;   (14 bytes)
;   0xa5f9..0xa607  (14 bytes)
DATA_plano_A5F9:
	defb 002h,081h,005h,065h,004h,047h,005h,0cbh,001h,04ch,006h,04eh,001h,000h	; a5f9  ...e.G...L.N..

; ----------------------------------------------------------------------
; DATOS plano_A607: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 1-4
;   (18 bytes)
;   0xa607..0xa619  (18 bytes)
DATA_plano_A607:
	defb 004h,041h,004h,083h,001h,043h,007h,069h,004h,04bh,007h,0ceh,001h,04eh,006h,04eh	; a607  .A...C.i.K...N.N
	defb 007h,000h	; a617

; ----------------------------------------------------------------------
; DATOS plano_A619: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 1-5,
;   zona 1-6 (14 bytes)
;   0xa619..0xa627  (14 bytes)
DATA_plano_A619:
	defb 008h,084h,003h,048h,003h,04ah,004h,04ch,005h,051h,004h,0d3h,004h,000h	; a619  ...H.J.L.Q....

; ----------------------------------------------------------------------
; DATOS plano_A627: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 2-0
;   (6 bytes)
;   0xa627..0xa62d  (6 bytes)
DATA_plano_A627:
	defb 005h,0c4h,001h,066h,001h,000h	; a627

; ----------------------------------------------------------------------
; DATOS plano_A62D: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 2-1
;   (12 bytes)
;   0xa62d..0xa639  (12 bytes)
DATA_plano_A62D:
	defb 006h,084h,003h,044h,008h,04ah,006h,06ch,008h,0ceh,001h,000h	; a62d  ...D.J.l....

; ----------------------------------------------------------------------
; DATOS plano_A639: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 2-2
;   (14 bytes)
;   0xa639..0xa647  (14 bytes)
DATA_plano_A639:
	defb 007h,084h,002h,043h,005h,06ch,003h,0a7h,006h,0c5h,007h,04eh,00ah,000h	; a639  ...C.l.....N..

; ----------------------------------------------------------------------
; DATOS plano_A647: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 2-3
;   (10 bytes)
;   0xa647..0xa651  (10 bytes)
DATA_plano_A647:
	defb 001h,044h,006h,068h,001h,088h,004h,0cch,005h,000h	; a647  .D.h......

; ----------------------------------------------------------------------
; DATOS plano_A651: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 2-4
;   (10 bytes)
;   0xa651..0xa65b  (10 bytes)
DATA_plano_A651:
	defb 000h,045h,001h,085h,004h,068h,004h,0ceh,001h,000h	; a651  .E...h....

; ----------------------------------------------------------------------
; DATOS plano_A65B: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 2-5,
;   zona 2-6 (22 bytes)
;   0xa65b..0xa671  (22 bytes)
DATA_plano_A65B:
	defb 00ah,041h,00ch,047h,006h,088h,003h,04bh,00ah,04eh,005h,04fh,00bh,053h,002h,053h	; a65b  .A.G...K.N.O.S.S
	defb 009h,055h,00bh,0d6h,004h,000h	; a66b

; ----------------------------------------------------------------------
; DATOS plano_A671: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 3-0
;   (14 bytes)
;   0xa671..0xa67f  (14 bytes)
DATA_plano_A671:
	defb 009h,041h,00eh,044h,00bh,067h,00dh,0c8h,009h,08bh,002h,04ch,005h,000h	; a671  .A.D.g.....L..

; ----------------------------------------------------------------------
; DATOS plano_A67F: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 3-1
;   (14 bytes)
;   0xa67f..0xa68d  (14 bytes)
DATA_plano_A67F:
	defb 00ch,065h,001h,085h,004h,049h,003h,04ch,006h,04dh,001h,0ceh,006h,000h	; a67f  .e...I.L.M....

; ----------------------------------------------------------------------
; DATOS plano_A68D: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 3-2
;   (18 bytes)
;   0xa68d..0xa69f  (18 bytes)
DATA_plano_A68D:
	defb 008h,044h,003h,082h,004h,065h,006h,0a8h,003h,04ch,005h,0d1h,004h,053h,002h,053h	; a68d  .D...e...L...S.S
	defb 004h,000h	; a69d

; ----------------------------------------------------------------------
; DATOS plano_A69F: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 3-3
;   (12 bytes)
;   0xa69f..0xa6ab  (12 bytes)
DATA_plano_A69F:
	defb 002h,085h,003h,067h,005h,04ah,004h,04bh,001h,0ceh,001h,000h	; a69f  ...g.J.K....

; ----------------------------------------------------------------------
; DATOS plano_A6AB: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 3-4
;   (20 bytes)
;   0xa6ab..0xa6bf  (20 bytes)
DATA_plano_A6AB:
	defb 00bh,061h,009h,042h,005h,046h,00ah,089h,002h,04ah,006h,04dh,00ah,052h,004h,052h	; a6ab  .a.B.F...J.M.R.R
	defb 00ah,0d4h,00ah,000h	; a6bb

; ----------------------------------------------------------------------
; DATOS plano_A6BF: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 3-5,
;   zona 3-6 (20 bytes)
;   0xa6bf..0xa6d3  (20 bytes)
DATA_plano_A6BF:
	defb 00eh,041h,009h,085h,004h,045h,00ch,047h,008h,0c9h,001h,04bh,003h,04eh,007h,050h	; a6bf  .A...E.G...K.N.P
	defb 007h,050h,00ch,000h	; a6cf

; ----------------------------------------------------------------------
; DATOS plano_A6D3: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 4-0
;   (16 bytes)
;   0xa6d3..0xa6e3  (16 bytes)
DATA_plano_A6D3:
	defb 009h,081h,003h,042h,009h,047h,006h,047h,00dh,0c8h,009h,04bh,002h,06dh,008h,000h	; a6d3  ...B.G.G...K.m..

; ----------------------------------------------------------------------
; DATOS plano_A6E3: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 4-1
;   (16 bytes)
;   0xa6e3..0xa6f3  (16 bytes)
DATA_plano_A6E3:
	defb 004h,081h,004h,0a3h,006h,045h,007h,068h,001h,049h,004h,04bh,001h,0ceh,007h,000h	; a6e3  .....E.h.I.K....

; ----------------------------------------------------------------------
; DATOS plano_A6F3: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 4-2
;   (14 bytes)
;   0xa6f3..0xa701  (14 bytes)
DATA_plano_A6F3:
	defb 002h,0c1h,008h,044h,006h,087h,001h,04bh,001h,06ch,006h,04eh,002h,000h	; a6f3  ...D...K.l.N..

; ----------------------------------------------------------------------
; DATOS plano_A701: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 4-3
;   (20 bytes)
;   0xa701..0xa715  (20 bytes)
DATA_plano_A701:
	defb 00fh,081h,005h,041h,00ch,047h,005h,049h,009h,04eh,00ah,050h,001h,071h,006h,056h	; a701  ...A.G.I.N.P.q.V
	defb 004h,0d6h,006h,000h	; a711

; ----------------------------------------------------------------------
; DATOS plano_A715: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 4-4
;   (8 bytes)
;   0xa715..0xa71d  (8 bytes)
DATA_plano_A715:
	defb 00ch,085h,001h,069h,003h,0cch,006h,000h	; a715  ...i....

; ----------------------------------------------------------------------
; DATOS plano_A71D: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 4-5,
;   zona 4-6 (22 bytes)
;   0xa71d..0xa733  (22 bytes)
DATA_plano_A71D:
	defb 00ah,081h,005h,042h,009h,0c7h,006h,048h,00bh,04ch,007h,04eh,007h,053h,00ah,056h	; a71d  ...B...H.L.N.S.V
	defb 001h,056h,004h,056h,00ch,000h	; a72d

; ----------------------------------------------------------------------
; DATOS plano_A733: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 5-0
;   (8 bytes)
;   0xa733..0xa73b  (8 bytes)
DATA_plano_A733:
	defb 000h,0c6h,004h,048h,001h,06eh,001h,000h	; a733  ...H.n..

; ----------------------------------------------------------------------
; DATOS plano_A73B: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 5-1
;   (10 bytes)
;   0xa73b..0xa745  (10 bytes)
DATA_plano_A73B:
	defb 003h,066h,005h,049h,005h,04eh,001h,0ceh,005h,000h	; a73b  .f.I.N....

; ----------------------------------------------------------------------
; DATOS plano_A745: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 5-2
;   (14 bytes)
;   0xa745..0xa753  (14 bytes)
DATA_plano_A745:
	defb 007h,084h,002h,045h,007h,0c7h,006h,069h,007h,04ch,003h,04eh,00ah,000h	; a745  ...E...i.L.N..

; ----------------------------------------------------------------------
; DATOS plano_A753: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 5-3
;   (24 bytes)
;   0xa753..0xa76b  (24 bytes)
DATA_plano_A753:
	defb 00bh,081h,006h,044h,00ah,0c6h,00ah,047h,003h,04bh,008h,06ch,004h,0aeh,008h,051h	; a753  ...D...G.K.l...Q
	defb 005h,052h,00ah,055h,003h,056h,00ah,000h	; a763  .R.U.V..

; ----------------------------------------------------------------------
; DATOS plano_A76B: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 5-4
;   (24 bytes)
;   0xa76b..0xa783  (24 bytes)
DATA_plano_A76B:
	defb 00fh,045h,00ch,047h,005h,08ah,005h,06eh,008h,0afh,00bh,0d1h,006h,052h,00ch,053h	; a76b  .E.G...n.....R.S
	defb 001h,053h,008h,055h,008h,056h,004h,000h	; a77b  .S.U.V..

; ----------------------------------------------------------------------
; DATOS plano_A783: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 5-5,
;   zona 5-6 (22 bytes)
;   0xa783..0xa799  (22 bytes)
DATA_plano_A783:
	defb 00dh,0a4h,008h,045h,010h,049h,00ch,04ah,002h,08ch,003h,04fh,010h,051h,00bh,052h	; a783  ...E.I.J...O.Q.R
	defb 00eh,055h,012h,0d6h,006h,000h	; a793

; ----------------------------------------------------------------------
; DATOS plano_A799: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 6-0
;   (12 bytes)
;   0xa799..0xa7a5  (12 bytes)
DATA_plano_A799:
	defb 00ch,0c5h,001h,045h,003h,089h,003h,06ch,006h,04eh,002h,000h	; a799  ...E...l.N..

; ----------------------------------------------------------------------
; DATOS plano_A7A5: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 6-1
;   (26 bytes)
;   0xa7a5..0xa7bf  (26 bytes)
DATA_plano_A7A5:
	defb 00dh,084h,005h,041h,007h,041h,00eh,045h,00dh,04ah,002h,04ah,009h,04dh,010h,070h	; a7a5  ...A.A.E.J.J.M.p
	defb 002h,0d2h,003h,054h,00ah,056h,011h,0b6h,012h,000h	; a7b5  ...T.V....

; ----------------------------------------------------------------------
; DATOS plano_A7BF: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 6-2
;   (16 bytes)
;   0xa7bf..0xa7cf  (16 bytes)
DATA_plano_A7BF:
	defb 008h,043h,005h,086h,002h,04ah,004h,0cdh,006h,051h,004h,053h,004h,076h,001h,000h	; a7bf  .C...J...Q.S.v..

; ----------------------------------------------------------------------
; DATOS plano_A7CF: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 6-3
;   (18 bytes)
;   0xa7cf..0xa7e1  (18 bytes)
DATA_plano_A7CF:
	defb 00ah,062h,009h,088h,003h,049h,005h,0cbh,00ah,04eh,005h,051h,009h,052h,001h,056h	; a7cf  .b...I...N.Q.R.V
	defb 00ch,000h	; a7df

; ----------------------------------------------------------------------
; DATOS plano_A7E1: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 6-4
;   (14 bytes)
;   0xa7e1..0xa7ef  (14 bytes)
DATA_plano_A7E1:
	defb 006h,044h,008h,0c6h,004h,046h,007h,089h,005h,04bh,002h,06dh,004h,000h	; a7e1  .D...F...K.m..

; ----------------------------------------------------------------------
; DATOS plano_A7EF: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 6-5,
;   zona 6-6 (22 bytes)
;   0xa7ef..0xa805  (22 bytes)
DATA_plano_A7EF:
	defb 00eh,042h,007h,042h,00bh,047h,00bh,049h,001h,08ah,003h,0ceh,007h,050h,003h,051h	; a7ef  .B.B.G.I.....P.Q
	defb 007h,050h,00ch,054h,009h,000h	; a7ff

; ----------------------------------------------------------------------
; DATOS plano_A805: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 7-0
;   (6 bytes)
;   0xa805..0xa80b  (6 bytes)
DATA_plano_A805:
	defb 001h,0c4h,006h,069h,004h,000h	; a805

; ----------------------------------------------------------------------
; DATOS plano_A80B: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 7-1
;   (24 bytes)
;   0xa80b..0xa823  (24 bytes)
DATA_plano_A80B:
	defb 00fh,043h,009h,044h,003h,067h,008h,04bh,008h,04bh,00ch,08ch,001h,050h,008h,053h	; a80b  .C.D.g.K.K...P.S
	defb 001h,053h,008h,054h,00ah,0d6h,004h,000h	; a81b  .S.T....

; ----------------------------------------------------------------------
; DATOS plano_A823: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 7-2
;   (14 bytes)
;   0xa823..0xa831  (14 bytes)
DATA_plano_A823:
	defb 004h,061h,004h,083h,001h,045h,001h,0c5h,007h,04ah,004h,04dh,006h,000h	; a823  .a...E...J.M..

; ----------------------------------------------------------------------
; DATOS plano_A831: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 7-3
;   (18 bytes)
;   0xa831..0xa843  (18 bytes)
DATA_plano_A831:
	defb 00bh,0a4h,009h,045h,006h,087h,004h,0cch,004h,04eh,006h,051h,003h,052h,00ah,076h	; a831  ...E.....N.Q.R.v
	defb 00ah,000h	; a841

; ----------------------------------------------------------------------
; DATOS plano_A843: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 7-4
;   (24 bytes)
;   0xa843..0xa85b  (24 bytes)
DATA_plano_A843:
	defb 00dh,044h,008h,042h,00dh,0c5h,00eh,04ah,002h,04ah,00ch,0ach,003h,08dh,007h,04eh	; a843  .D.B...J.J.....N
	defb 012h,04fh,008h,071h,001h,053h,00dh,000h	; a853  .O.q.S..

; ----------------------------------------------------------------------
; DATOS plano_A85B: ficha de plano de una zona: el dibujo (0xA86D) y parejas
;   [valor<<5 | x][y] que p00:5A10 marca en 0xD800; 0 acaba; lo leen zona 7-5,
;   zona 7-6 (18 bytes)
;   0xa85b..0xa86d  (18 bytes)
DATA_plano_A85B:
	defb 00fh,085h,002h,045h,00ah,0c5h,00ch,047h,004h,04ch,006h,051h,004h,051h,008h,052h	; a85b  ...E...G.L.Q.Q.R
	defb 008h,000h	; a86b

; ----------------------------------------------------------------------
; DATOS dibujos_de_plano: 16 punteros a los dibujos de plano (p00:59C2); lo
;   leen p00:59BF (32 bytes)
;   0xa86d..0xa88d  (32 bytes)
DATA_dibujos_de_plano:
	defb 08dh,0a8h,09bh,0a8h,0adh,0a8h,0c3h,0a8h,0d3h,0a8h,0e7h,0a8h,0edh,0a8h,003h,0a9h	; a86d  ................
	defb 01dh,0a9h,037h,0a9h,059h,0a9h,085h,0a9h,0abh,0a9h,0bdh,0a9h,0fbh,0a9h,02ah,0aah	; a87d  ..7.Y.........*.

; ----------------------------------------------------------------------
; DATOS plano_dibujo_0: dibujo de plano 0: [filas][ancho] y un bit por casilla
;   (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (14 bytes)
;   0xa88d..0xa89b  (14 bytes)
DATA_plano_dibujo_0:
	defb 006h,010h,0ffh,0ffh,0bbh,071h,0a0h,017h,0abh,047h,089h,011h,0ffh,0ffh	; a88d  .....q...G....

; ----------------------------------------------------------------------
; DATOS plano_dibujo_1: dibujo de plano 1: [filas][ancho] y un bit por casilla
;   (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (18 bytes)
;   0xa89b..0xa8ad  (18 bytes)
DATA_plano_dibujo_1:
	defb 008h,010h,0ffh,0ffh,0a3h,001h,0aah,07dh,0abh,045h,0a9h,01dh,08dh,055h,0a4h,041h	; a89b  .......}.E...U.A
	defb 0ffh,0ffh	; a8ab

; ----------------------------------------------------------------------
; DATOS plano_dibujo_2: dibujo de plano 2: [filas][ancho] y un bit por casilla
;   (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (22 bytes)
;   0xa8ad..0xa8c3  (22 bytes)
DATA_plano_dibujo_2:
	defb 00ah,010h,0ffh,0ffh,0a0h,08dh,08eh,0b9h,0d8h,0a3h,093h,089h,0b6h,0adh,090h,0a1h	; a8ad  ................
	defb 0dfh,0adh,080h,001h,0ffh,0ffh	; a8bd

; ----------------------------------------------------------------------
; DATOS plano_dibujo_3: dibujo de plano 3: [filas][ancho] y un bit por casilla
;   (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (16 bytes)
;   0xa8c3..0xa8d3  (16 bytes)
DATA_plano_dibujo_3:
	defb 007h,010h,0ffh,0ffh,0b0h,041h,0b5h,057h,0b5h,051h,0b5h,017h,081h,0b1h,0ffh,0ffh	; a8c3  .....A.W.Q......

; ----------------------------------------------------------------------
; DATOS plano_dibujo_4: dibujo de plano 4: [filas][ancho] y un bit por casilla
;   (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (20 bytes)
;   0xa8d3..0xa8e7  (20 bytes)
DATA_plano_dibujo_4:
	defb 009h,010h,0ffh,0ffh,0aah,02dh,088h,089h,0ddh,0dbh,080h,081h,0ddh,0dbh,088h,089h	; a8d3  .....-..........
	defb 0aah,02dh,0ffh,0ffh	; a8e3

; ----------------------------------------------------------------------
; DATOS plano_dibujo_5: dibujo de plano 5: [filas][ancho] y un bit por casilla
;   (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (6 bytes)
;   0xa8e7..0xa8ed  (6 bytes)
DATA_plano_dibujo_5:
	defb 004h,008h,0ffh,0b5h,081h,0ffh	; a8e7

; ----------------------------------------------------------------------
; DATOS plano_dibujo_6: dibujo de plano 6: [filas][ancho] y un bit por casilla
;   (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (22 bytes)
;   0xa8ed..0xa903  (22 bytes)
DATA_plano_dibujo_6:
	defb 00ah,010h,0ffh,0ffh,0a1h,011h,08ch,047h,0a1h,051h,0f5h,01bh,087h,0b1h,0b4h,015h	; a8ed  .......G.Q......
	defb 0b1h,0c1h,084h,015h,0ffh,0ffh	; a8fd

; ----------------------------------------------------------------------
; DATOS plano_dibujo_7: dibujo de plano 7: [filas][ancho] y un bit por casilla
;   (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (26 bytes)
;   0xa903..0xa91d  (26 bytes)
DATA_plano_dibujo_7:
	defb 00ch,010h,0ffh,0ffh,080h,001h,0b7h,0fdh,080h,005h,0bfh,0fdh,0a0h,005h,0aeh,0f5h	; a903  ................
	defb 0abh,0b5h,0a0h,005h,0beh,0fdh,080h,001h,0ffh,0ffh	; a913  ..........

; ----------------------------------------------------------------------
; DATOS plano_dibujo_8: dibujo de plano 8: [filas][ancho] y un bit por casilla
;   (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (26 bytes)
;   0xa91d..0xa937  (26 bytes)
DATA_plano_dibujo_8:
	defb 008h,018h,0ffh,0ffh,0ffh,0a2h,022h,001h,088h,08ah,0abh,0e2h,020h,0bfh,088h,08ah	; a91d  ......"..... ...
	defb 0a1h,0a2h,022h,0fdh,088h,08ah,001h,0ffh,0ffh,0ffh	; a92d  ..".......

; ----------------------------------------------------------------------
; DATOS plano_dibujo_9: dibujo de plano 9: [filas][ancho] y un bit por casilla
;   (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (34 bytes)
;   0xa937..0xa959  (34 bytes)
DATA_plano_dibujo_9:
	defb 010h,010h,0ffh,0ffh,080h,001h,0fdh,06dh,081h,001h,0bfh,0fdh,0a0h,005h,0aeh,0f5h	; a937  .......m........
	defb 0a8h,015h,0abh,0d1h,089h,0d5h,0ach,015h,0a7h,0f5h,0b0h,005h,0beh,0fdh,080h,001h	; a947  ................
	defb 0ffh,0ffh	; a957

; ----------------------------------------------------------------------
; DATOS plano_dibujo_10: dibujo de plano 10: [filas][ancho] y un bit por
;   casilla (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (44
;   bytes)
;   0xa959..0xa985  (44 bytes)
DATA_plano_dibujo_10:
	defb 00eh,018h,0ffh,0ffh,0ffh,080h,008h,08dh,0bbh,0dah,021h,08ah,053h,0f7h,0e8h,0d6h	; a959  ..........!.S...
	defb 005h,08bh,094h,0adh,0fah,037h,0a9h,083h,0e4h,023h,0aeh,08fh,0b9h,088h,0b8h,00dh	; a969  .....7...#......
	defb 0a3h,0abh,0e9h,0beh,02eh,03bh,080h,080h,081h,0ffh,0ffh,0ffh	; a979  .....;......

; ----------------------------------------------------------------------
; DATOS plano_dibujo_11: dibujo de plano 11: [filas][ancho] y un bit por
;   casilla (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (38
;   bytes)
;   0xa985..0xa9ab  (38 bytes)
DATA_plano_dibujo_11:
	defb 00ch,018h,0ffh,0ffh,0ffh,080h,022h,009h,0f5h,08ah,0a3h,084h,0dah,089h,0beh,052h	; a985  ......"........R
	defb 0ddh,083h,05eh,089h,0a9h,000h,0e3h,0edh,0eah,02fh,084h,028h,0a1h,0b7h,0aah,0b5h	; a995  ..^....../.(....
	defb 084h,022h,015h,0ffh,0ffh,0ffh	; a9a5

; ----------------------------------------------------------------------
; DATOS plano_dibujo_12: dibujo de plano 12: [filas][ancho] y un bit por
;   casilla (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (18
;   bytes)
;   0xa9ab..0xa9bd  (18 bytes)
DATA_plano_dibujo_12:
	defb 008h,010h,0ffh,0ffh,0a2h,00bh,08eh,0e1h,0b8h,0bbh,083h,089h,0beh,03dh,080h,085h	; a9ab  .............=..
	defb 0ffh,0ffh	; a9bb

; ----------------------------------------------------------------------
; DATOS plano_dibujo_13: dibujo de plano 13: [filas][ancho] y un bit por
;   casilla (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (62
;   bytes)
;   0xa9bd..0xa9fb  (62 bytes)
DATA_plano_dibujo_13:
	defb 014h,018h,0ffh,0ffh,0ffh,083h,001h,001h,0b6h,05dh,07dh,080h,0f5h,0d1h,0f5h,084h	; a9bd  .........]}.....
	defb 055h,084h,03dh,055h,0fdh,0e1h,055h,0b0h,00bh,057h,085h,0fah,051h,0fdh,000h,0ddh	; a9cd  U.=U..U..W..Q...
	defb 080h,05fh,091h,0dfh,0d0h,035h,0d8h,017h,065h,08ah,0b5h,0cdh,0abh,0a4h,019h,0eeh	; a9dd  ._...5..e.......
	defb 0adh,0b3h,082h,088h,087h,0b6h,0fah,0fdh,080h,000h,001h,0ffh,0ffh,0ffh	; a9ed  ..............

; ----------------------------------------------------------------------
; DATOS plano_dibujo_14: dibujo de plano 14: [filas][ancho] y un bit por
;   casilla (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (47
;   bytes)
;   0xa9fb..0xaa2a  (47 bytes)
DATA_plano_dibujo_14:
	defb 00fh,018h,0ffh,0ffh,0ffh,0a2h,080h,001h,0a8h,0fbh,0bdh,082h,00ah,005h,0a8h,0bah	; a9fb  ................
	defb 0fdh,082h,020h,001h,0ffh,0afh,0fdh,082h,021h,001h,0a8h,0ffh,0ddh,0adh,080h,057h	; aa0b  .. .....!......W
	defb 0e0h,0afh,0d1h,08eh,020h,005h,0bbh,0fbh,055h,080h,000h,001h,0ffh,0ffh,0ffh	; aa1b  .... ...U......

; ----------------------------------------------------------------------
; DATOS plano_dibujo_15: dibujo de plano 15: [filas][ancho] y un bit por
;   casilla (p00:59D7 los pasa a 0xD800, 28 por fila); lo leen p00:59C5 (44
;   bytes)
;   0xaa2a..0xaa56  (44 bytes)
DATA_plano_dibujo_15:
	defb 00eh,018h,0ffh,0ffh,0ffh,080h,030h,061h,0aah,095h,035h,083h,0d5h,0a5h,0dah,044h	; aa2a  ......0a..5....D
	defb 00dh,088h,0dfh,0bfh,0efh,090h,0a5h,080h,035h,0edh,0beh,0e5h,009h,0a3h,0afh,07dh	; aa3a  ........5......}
	defb 0a8h,028h,005h,0aeh,0aah,0f5h,088h,080h,011h,0ffh,0ffh,0ffh	; aa4a  .(..........

; ----------------------------------------------------------------------
; DATOS poses_jugador_1: 20 punteros, uno por (0xC49F x 4 + 0xC4A2), a la pose
;   del jugador 1: la lista de sprites que p01:74CD copia a 0xEE00 (p01:74AA y
;   74AF, por el bit 7 de 0xC002); lo leen p01:74BD (40 bytes)
;   0xaa56..0xaa7e  (40 bytes)
DATA_poses_jugador_1:
	defb 0a6h,0aah,0afh,0aah,0afh,0aah,0afh,0aah,0a6h,0aah,0afh,0aah,0afh,0aah,0afh,0aah	; aa56  ................
	defb 0a6h,0aah,0afh,0aah,0afh,0aah,0afh,0aah,0d2h,0aah,0b8h,0aah,0e8h,0aah,0f5h,0aah	; aa66  ................
	defb 0dfh,0aah,0dfh,0aah,0dfh,0aah,0dfh,0aah	; aa76  ........

; ----------------------------------------------------------------------
; DATOS poses_jugador_2: 20 punteros, uno por (0xC49F x 4 + 0xC4A2), a la pose
;   del jugador 2: la lista de sprites que p01:74CD copia a 0xEE00 (p01:74AA y
;   74AF, por el bit 7 de 0xC002); lo leen p01:74BD (40 bytes)
;   0xaa7e..0xaaa6  (40 bytes)
DATA_poses_jugador_2:
	defb 0afh,0aah,0afh,0aah,002h,0abh,002h,0abh,0afh,0aah,0afh,0aah,0afh,0aah,0afh,0aah	; aa7e  ................
	defb 0afh,0aah,0afh,0aah,0afh,0aah,0afh,0aah,00bh,0abh,0c5h,0aah,0e8h,0aah,0f5h,0aah	; aa8e  ................
	defb 0dfh,0aah,0dfh,0aah,0dfh,0aah,0dfh,0aah	; aa9e  ........

; ----------------------------------------------------------------------
; DATOS pose_AAA6: una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A;
;   el dibujo de cada sprite es 4 x su orden (p01:7514); lo leen p01:74CD (9
;   bytes)
;   0xaaa6..0xaaaf  (9 bytes)
DATA_pose_AAA6:
	defb 004h,0e1h,0f8h,0f1h,0f8h,0f1h,0f8h,0f1h,0f8h	; aaa6  .........

; ----------------------------------------------------------------------
; DATOS pose_AAAF: una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A;
;   el dibujo de cada sprite es 4 x su orden (p01:7514); lo leen p01:74CD (9
;   bytes)
;   0xaaaf..0xaab8  (9 bytes)
DATA_pose_AAAF:
	defb 004h,0e1h,0f8h,0f1h,0f8h,0e9h,0f8h,0f1h,0f8h	; aaaf  .........

; ----------------------------------------------------------------------
; DATOS pose_AAB8: una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A;
;   el dibujo de cada sprite es 4 x su orden (p01:7514); lo leen p01:74CD (13
;   bytes)
;   0xaab8..0xaac5  (13 bytes)
DATA_pose_AAB8:
	defb 006h,0e1h,0f8h,0f1h,0f8h,0e9h,0f8h,0f1h,0f8h,0f1h,0f8h,0f1h,0f8h	; aab8  .............

; ----------------------------------------------------------------------
; DATOS pose_AAC5: una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A;
;   el dibujo de cada sprite es 4 x su orden (p01:7514); lo leen p01:74CD (13
;   bytes)
;   0xaac5..0xaad2  (13 bytes)
DATA_pose_AAC5:
	defb 006h,0e1h,0f8h,0f1h,0f8h,0e8h,0f8h,0f0h,0f8h,0f1h,0f8h,0f1h,0f8h	; aac5  .............

; ----------------------------------------------------------------------
; DATOS pose_AAD2: una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A;
;   el dibujo de cada sprite es 4 x su orden (p01:7514); lo leen p01:74CD (13
;   bytes)
;   0xaad2..0xaadf  (13 bytes)
DATA_pose_AAD2:
	defb 006h,0e1h,0f8h,0f1h,0f8h,0e3h,0f8h,0f0h,0f8h,0e1h,0f0h,0e1h,0f0h	; aad2  .............

; ----------------------------------------------------------------------
; DATOS pose_AADF: una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A;
;   el dibujo de cada sprite es 4 x su orden (p01:7514); lo leen p01:74CD (9
;   bytes)
;   0xaadf..0xaae8  (9 bytes)
DATA_pose_AADF:
	defb 004h,0e1h,0f8h,0f1h,0f8h,0e1h,0f8h,0f1h,0f8h	; aadf  .........

; ----------------------------------------------------------------------
; DATOS pose_AAE8: una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A;
;   el dibujo de cada sprite es 4 x su orden (p01:7514); lo leen p01:74CD (13
;   bytes)
;   0xaae8..0xaaf5  (13 bytes)
DATA_pose_AAE8:
	defb 006h,0e1h,0f8h,0f1h,0f8h,0e9h,0f8h,0f1h,0f8h,0e9h,0e9h,0e9h,0e9h	; aae8  .............

; ----------------------------------------------------------------------
; DATOS pose_AAF5: una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A;
;   el dibujo de cada sprite es 4 x su orden (p01:7514); lo leen p01:74CD (13
;   bytes)
;   0xaaf5..0xab02  (13 bytes)
DATA_pose_AAF5:
	defb 006h,0e1h,0f8h,0f1h,0f8h,0e9h,0f8h,0f1h,0f8h,0e9h,008h,0e9h,008h	; aaf5  .............

; ----------------------------------------------------------------------
; DATOS pose_AB02: una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A;
;   el dibujo de cada sprite es 4 x su orden (p01:7514); lo leen p01:74CD (9
;   bytes)
;   0xab02..0xab0b  (9 bytes)
DATA_pose_AB02:
	defb 004h,0e1h,0f8h,0f1h,0f8h,0eah,0f8h,0f1h,0f8h	; ab02  .........

; ----------------------------------------------------------------------
; DATOS pose_AB0B: una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A;
;   el dibujo de cada sprite es 4 x su orden (p01:7514); lo leen p01:74CD (13
;   bytes)
;   0xab0b..0xab18  (13 bytes)
DATA_pose_AB0B:
	defb 006h,0e1h,0f8h,0f1h,0f8h,0e7h,0f8h,0f0h,0f8h,0e1h,0f0h,0e1h,0f0h	; ab0b  .............

; ----------------------------------------------------------------------
; DATOS formas_de_pasadizo: 56 formas de 9 filas x 2 bytes: cada bit puesto es
;   un bloque de 16x16 que p00:4F94 pinta (la forma la escoge p01:6A49 en
;   0xEA00); lo leen p00:4F78 (1008 bytes)
;   0xab18..0xaf08  (1008 bytes)
DATA_formas_de_pasadizo:
	defb 0ffh,0ffh,080h,030h,0fch,023h,0f8h,063h,0f0h,0f0h,0e1h,0f0h,0c3h,0e3h,087h,0e3h	; ab18  ...0.#.c........
	defb 080h,030h,0ffh,0ffh,00eh,003h,0c4h,071h,0c4h,071h,00ch,071h,00ch,071h,0c4h,071h	; ab28  .0.....q.q.q.q.q
	defb 0c4h,071h,00eh,003h,0ffh,0ffh,0c7h,018h,0c2h,011h,0c0h,011h,0c0h,010h,0c5h,018h	; ab38  .q..............
	defb 0c7h,01fh,0c7h,011h,0c7h,018h,0ffh,0ffh,018h,0f3h,088h,067h,0fch,00fh,01eh,01fh	; ab48  ...........g....
	defb 00fh,00fh,08eh,007h,08ch,0c3h,019h,0e3h,0ffh,0ffh,080h,020h,0b1h,0b1h,0f1h,0f1h	; ab58  ........... ....
	defb 0f1h,0f0h,0f1h,0f0h,0f1h,0f1h,0f1h,0f1h,0e0h,0e0h,0ffh,0ffh,008h,0e3h,0ech,077h	; ab68  ...............w
	defb 0bch,037h,03ch,037h,03dh,017h,0bdh,087h,0edh,0c7h,008h,0e3h,0ffh,0ffh,087h,080h	; ab78  .7<7=...........
	defb 0cfh,039h,0cfh,039h,0cfh,039h,0cfh,039h,0ceh,039h,080h,083h,0ffh,0ffh,0ffh,0ffh	; ab88  .9.9.9.9.9......
	defb 010h,001h,0b9h,09dh,0b9h,097h,0d3h,087h,0d3h,097h,0e7h,09dh,0e7h,001h,0ffh,0ffh	; ab98  ................
	defb 0ffh,0ffh,0f0h,070h,0e1h,0a3h,0e0h,0e3h,0f0h,063h,0f8h,023h,0ech,023h,0f0h,070h	; aba8  ...p.....c.#.#.p
	defb 0ffh,0ffh,0ffh,0ffh,070h,067h,0a1h,0a7h,0a0h,0e7h,0b0h,067h,0b8h,027h,0ach,03fh	; abb8  ....pg.....g.'.?
	defb 070h,067h,0ffh,0ffh,0ffh,0ffh,083h,09eh,081h,002h,0f9h,092h,0f9h,093h,0f9h,093h	; abc8  pg..............
	defb 0f1h,093h,0c3h,093h,0ffh,0ffh,0ffh,0ffh,06ch,0cfh,048h,081h,040h,0cfh,0ech,0c9h	; abd8  ........l.H.@...
	defb 0cch,0cfh,0cch,0cfh,0ech,049h,0ffh,0ffh,0ffh,0ffh,0cfh,002h,0cfh,032h,0cfh,032h	; abe8  .....I.......2.2
	defb 0cfh,032h,0cfh,032h,0cfh,032h,0c1h,002h,0ffh,0ffh,0ffh,0ffh,004h,099h,064h,099h	; abf8  .2.2.2........d.
	defb 07ch,089h,044h,081h,064h,091h,064h,099h,004h,099h,0ffh,0ffh,0ffh,0ffh,09ch,0ffh	; ac08  |.D.d.d.........
	defb 08ch,0ffh,084h,08ch,080h,0e5h,090h,085h,098h,0a5h,09ch,085h,0ffh,0ffh,0ffh,0ffh	; ac18  ................
	defb 0f0h,07fh,0f0h,03fh,033h,023h,093h,039h,093h,021h,090h,029h,090h,061h,0ffh,0ffh	; ac28  ...?3#.9.!.).a..
	defb 0c0h,023h,080h,023h,080h,023h,08eh,023h,08eh,023h,08eh,023h,080h,020h,080h,020h	; ac38  .#.#.#.#.#.#. .
	defb 0c0h,070h,0c4h,001h,0c4h,001h,0c4h,001h,0c7h,08fh,0c7h,08fh,0c7h,08fh,007h,08fh	; ac48  .p..............
	defb 007h,08fh,00fh,08fh,0ffh,0ffh,0b9h,087h,0b9h,003h,0b9h,051h,0bdh,058h,0bdh,059h	; ac58  ...........Q.X.Y
	defb 09dh,059h,09dh,019h,09dh,0b3h,09fh,03fh,0ffh,0ffh,09fh,03fh,09fh,03fh,01fh,03fh	; ac68  .Y.....?...?.?.?
	defb 09fh,03fh,099h,033h,083h,007h,0c7h,08fh,0ffh,000h,080h,000h,0bbh,03fh,0ffh,003h	; ac78  .?.3.........?..
	defb 0ffh,0ffh,081h,0ffh,09fh,0ffh,09fh,030h,080h,030h,000h,01dh,000h,01dh,0ffh,09dh	; ac88  .......0.0......
	defb 0ffh,09dh,0c0h,01dh,0c0h,005h,0cfh,0ffh,00fh,0ffh,000h,007h,0c0h,000h,0c0h,000h	; ac98  ................
	defb 0c0h,01fh,0c0h,01fh,0ffh,01bh,0c7h,013h,0c0h,073h,0f3h,0f0h,0f0h,000h,000h,001h	; aca8  .........s......
	defb 000h,07fh,0ffh,07fh,0ffh,077h,0e0h,077h,0ffh,0f7h,0ffh,0f7h,000h,007h,000h,003h	; acb8  .....w.w........
	defb 0c0h,070h,0c0h,070h,0e9h,073h,0e9h,073h,0e9h,003h,0f9h,073h,0c0h,073h,0c0h,070h	; acc8  .p.p.s.s...s.s.p
	defb 0c1h,0f0h,000h,0e3h,030h,0e3h,0f0h,0e3h,0e0h,023h,0e0h,023h,0e0h,023h,0e0h,023h	; acd8  ....0....#.#.#.#
	defb 000h,003h,03ch,003h,0c0h,000h,0c0h,000h,0feh,07fh,0c0h,043h,0c0h,003h,0feh,0ffh	; ace8  ..<........C....
	defb 0feh,0ffh,0c0h,000h,0c0h,000h,000h,003h,000h,003h,080h,003h,0ffh,0fbh,0ffh,0fbh	; acf8  ................
	defb 0f0h,003h,0f0h,0c3h,000h,0c3h,000h,0c3h,0e0h,000h,0e0h,000h,0e0h,0c7h,0bch,0c7h	; ad08  ................
	defb 0bch,0ffh,0bch,0c7h,080h,0c7h,080h,0c0h,080h,0c0h,000h,0e3h,000h,0e3h,0ffh,0e3h	; ad18  ................
	defb 0c0h,003h,0c0h,003h,0c7h,0ffh,0c7h,0ffh,000h,003h,000h,003h,0f7h,08ch,0e7h,08ch	; ad28  ................
	defb 0c7h,0adh,087h,0a1h,087h,0bfh,087h,0bfh,087h,0bfh,087h,0bch,080h,03ch,00eh,01fh	; ad38  .............<..
	defb 000h,0fdh,0c3h,0fdh,0fbh,0f9h,0fbh,081h,0fbh,081h,0fbh,081h,000h,001h,03fh,0ffh	; ad48  ..............?.
	defb 080h,0fch,080h,0f8h,09eh,0f3h,09eh,0e7h,09eh,0cfh,09eh,09fh,09eh,03fh,09eh,000h	; ad58  .............?..
	defb 09eh,000h,000h,079h,000h,079h,0fch,0f1h,0f9h,0e1h,0f3h,0c1h,0e6h,001h,0cfh,001h	; ad68  ...y.y..........
	defb 01eh,001h,03ch,001h,0c0h,000h,0ffh,0e0h,0ffh,0f7h,0ffh,0ffh,0f7h,0ffh,0f8h,00fh	; ad78  ..<.............
	defb 0ffh,0f9h,0c0h,000h,0c0h,000h,000h,003h,000h,003h,0f7h,003h,0ffh,0ffh,0ffh,0ffh	; ad88  ................
	defb 0ffh,0ffh,0ffh,0ffh,000h,003h,000h,003h,0c0h,000h,0c0h,000h,0cfh,0ffh,0cfh,0ffh	; ad98  ................
	defb 0cfh,0ffh,0ceh,03fh,0ceh,03fh,0ceh,038h,0ceh,000h,000h,003h,01ch,003h,0fch,003h	; ada8  ...?.?.8........
	defb 0fch,003h,0fch,003h,0fch,003h,0c0h,003h,01ch,003h,01ch,003h,0c0h,0f8h,0c1h,0f0h	; adb8  ................
	defb 0c3h,0e3h,0c3h,083h,0c3h,0c3h,0c3h,0dfh,0c3h,0c7h,0c1h,0e0h,0c1h,0e0h,000h,007h	; adc8  ................
	defb 000h,003h,0e0h,003h,0e1h,0e3h,0f8h,0e3h,0fch,063h,0feh,023h,00fh,023h,000h,027h	; add8  .........c.#.#.'
	defb 0f7h,0e0h,0f7h,0c0h,0f7h,081h,0f7h,003h,0c0h,007h,0f7h,0c3h,0f7h,0e3h,0f7h,0f0h	; ade8  ................
	defb 0f7h,0f8h,03ch,0e3h,03ch,0c3h,0f0h,0c3h,0f0h,003h,0fch,0c3h,0fch,0c3h,0fch,0c3h	; adf8  ..<.<...........
	defb 030h,0c3h,03ch,0c3h,0c3h,018h,0c0h,018h,0c3h,001h,0c3h,019h,0c6h,019h,0cch,0d9h	; ae08  0.<.............
	defb 0cch,0d9h,0c7h,098h,0c0h,000h,000h,003h,019h,0e3h,09bh,033h,09bh,033h,098h,063h	; ae18  ...........3.3.c
	defb 098h,0c3h,080h,0c3h,018h,003h,018h,0c3h,0c1h,0f0h,0c0h,0c0h,0c0h,061h,0c0h,001h	; ae28  .............a..
	defb 0ffh,01fh,0c0h,00fh,0c0h,065h,0c0h,0c0h,0c1h,0f0h,00fh,083h,003h,003h,0c6h,003h	; ae38  .....e..........
	defb 080h,003h,0f8h,0ffh,0f0h,003h,0a6h,003h,003h,003h,00fh,083h,0c0h,060h,0c0h,060h	; ae48  .............`.`
	defb 0ffh,0ffh,0c0h,061h,0c0h,061h,0c0h,061h,0ffh,0ffh,0c0h,060h,0c0h,060h,000h,001h	; ae58  ...a.a.a...`.`..
	defb 07fh,0f1h,09fh,0cdh,0e7h,03dh,0f8h,0fdh,0e7h,03dh,09fh,0cdh,07fh,0f1h,000h,001h	; ae68  .....=...=......
	defb 0e0h,000h,09fh,0feh,09fh,0ffh,09fh,0ffh,09fh,0ffh,080h,007h,080h,003h,080h,000h	; ae78  ................
	defb 080h,000h,007h,083h,073h,0c3h,0f9h,0e3h,0fch,0f3h,0feh,07bh,0deh,07bh,0deh,07bh	; ae88  ....s......{.{.{
	defb 01eh,073h,01eh,007h,0c3h,0e0h,0c3h,0f0h,0cch,00fh,0cch,00fh,0cfh,0cfh,0cfh,0cfh	; ae98  .s..............
	defb 0cfh,0cfh,0cfh,0f0h,0c0h,000h,000h,0c3h,000h,0c3h,0ffh,03fh,0ffh,03fh,0ffh,003h	; aea8  ...........?.?..
	defb 0f0h,003h,0f0h,003h,007h,00fh,00fh,00fh,080h,078h,080h,078h,080h,0f3h,081h,0e7h	; aeb8  .........x.x....
	defb 083h,0cfh,087h,09fh,08fh,03dh,080h,078h,080h,0f0h,000h,001h,01fh,001h,0cfh,081h	; aec8  .....=.x........
	defb 0e7h,0c1h,0f3h,0ffh,0f8h,0ffh,0f2h,07fh,007h,03fh,00fh,081h,0fbh,07eh,0dbh,000h	; aed8  .........?...~..
	defb 0dfh,0ffh,0dfh,0ffh,0dfh,0ffh,0dfh,0ffh,0c7h,0ffh,0fch,000h,0e9h,0f0h,003h,0c1h	; aee8  ................
	defb 003h,0c1h,083h,0c1h,083h,0c1h,0fch,001h,0fch,001h,0fch,001h,07ch,001h,000h,001h	; aef8  ............|...

; ----------------------------------------------------------------------
; DATOS pasadizos_de_cada_zona: 49 punteros, uno por zona, a sus 15 parejas de
;   formas (p01:6B02); lo leen p01:6AFF (98 bytes)
;   0xaf08..0xaf6a  (98 bytes)
DATA_pasadizos_de_cada_zona:
	defb 06ah,0afh,06dh,0afh,071h,0afh,075h,0afh,079h,0afh,07ch,0afh,081h,0afh,086h,0afh	; af08  j.m.q.u.y.|.....
	defb 088h,0afh,08dh,0afh,091h,0afh,095h,0afh,099h,0afh,09eh,0afh,0a3h,0afh,0a7h,0afh	; af18  ................
	defb 0abh,0afh,0afh,0afh,0b4h,0afh,0b7h,0afh,0bch,0afh,0c1h,0afh,0c6h,0afh,0c9h,0afh	; af28  ................
	defb 0cfh,0afh,0d4h,0afh,0d9h,0afh,0deh,0afh,0e3h,0afh,0e9h,0afh,0eeh,0afh,0f2h,0afh	; af38  ................
	defb 0f8h,0afh,0fch,0afh,003h,0b0h,008h,0b0h,00dh,0b0h,011h,0b0h,017h,0b0h,01bh,0b0h	; af48  ................
	defb 01fh,0b0h,024h,0b0h,02ah,0b0h,02dh,0b0h,031h,0b0h,036h,0b0h,03bh,0b0h,040h,0b0h	; af58  ..$.*.-.1.6.;.@.
	defb 04bh,0b0h	; af68

; ----------------------------------------------------------------------
; DATOS pasadizos_tira: la tira de numeros de pareja de la que cada zona coge
;   15 seguidos (0xAF08): las ventanas se pisan unas a otras, y la ultima
;   (0xB04B) sigue 11 bytes dentro de la tabla 0xB04F; lo leen p01:6B0A (229
;   bytes)
;   0xaf6a..0xb04f  (229 bytes)
DATA_pasadizos_tira:
	defb 001h,02fh,07ch,019h,0a7h,0b7h,03fh,00eh,01ah,02eh,048h,0ach,0beh,004h,01eh,0c8h	; af6a  ./|...?...H.....
	defb 0dah,044h,092h,03eh,018h,033h,0b0h,0b3h,073h,0c6h,0ceh,015h,02ah,002h,0a3h,011h	; af7a  .D.>.3..s...*...
	defb 030h,062h,075h,039h,031h,00bh,023h,08ch,007h,0cdh,0bfh,00ch,012h,01dh,02dh,061h	; af8a  0bu91.#.......-a
	defb 06eh,010h,038h,057h,017h,026h,088h,056h,077h,034h,03dh,029h,022h,0d8h,095h,046h	; af9a  n.8W.&.Vw4=)"..F
	defb 07ah,0b2h,0d3h,0c2h,055h,0d6h,0cch,091h,0e1h,0c1h,0cah,042h,037h,0aeh,0bdh,0dfh	; afaa  z...U......B7...
	defb 083h,0cbh,008h,0deh,003h,0bbh,009h,045h,072h,059h,068h,04dh,00ah,01bh,016h,09bh	; afba  .......ErYhM....
	defb 0e2h,0d2h,08bh,07eh,085h,0c0h,07fh,047h,079h,070h,04ah,02ch,040h,036h,020h,0b1h	; afca  ...~...GypJ,@6 .
	defb 099h,0cfh,0ddh,09eh,014h,08ah,09fh,0c5h,0b4h,07dh,08eh,084h,09ch,0b6h,0a1h,0a9h	; afda  .........}......
	defb 054h,07bh,098h,01ch,0c4h,0a5h,0aah,0a6h,080h,049h,08dh,051h,063h,06fh,03ah,041h	; afea  T{.......I.Qco:A
	defb 04eh,052h,06dh,086h,05bh,0bch,09dh,0afh,0dch,032h,0dbh,025h,0bah,060h,0d1h,0a4h	; affa  NRm.[....2.%.`..
	defb 0c3h,0e4h,0b5h,043h,05ah,04bh,066h,01fh,00fh,0c7h,0d0h,0d7h,00dh,0d4h,090h,0d9h	; b00a  ...CZKf.........
	defb 0abh,065h,05fh,076h,081h,0b8h,0a0h,089h,06bh,05dh,096h,027h,04fh,02bh,058h,078h	; b01a  .e_v....k].'O+Xx
	defb 0c9h,0e5h,097h,053h,0e3h,021h,087h,0e0h,0d5h,064h,067h,03bh,024h,093h,0a8h,035h	; b02a  ...S.!...dg;$..5
	defb 04ch,082h,09ah,08fh,0a2h,0adh,094h,050h,05eh,03ch,028h,06ch,013h,0b9h,074h,071h	; b03a  L......P^<(l..tq
	defb 05ch,005h,06ah,006h,000h	; b04a

; ----------------------------------------------------------------------
; DATOS parejas_de_formas: 230 parejas de formas de pasadizo (0-55) que
;   p01:6B11 copia a 0xEA00; lo leen p01:6B11 (460 bytes)
;   0xb04f..0xb21b  (460 bytes)
DATA_parejas_de_formas:
	defb 000h,001h,002h,003h,004h,005h,006h,007h,008h,009h,00ah,00bh,00ch,00dh,00eh,00fh	; b04f  ................
	defb 010h,011h,012h,013h,014h,015h,014h,017h,014h,019h,014h,01dh,014h,01fh,014h,021h	; b05f  ...............!
	defb 014h,023h,014h,025h,014h,029h,014h,02bh,014h,02dh,014h,02fh,014h,031h,014h,033h	; b06f  .#.%.).+.-./.1.3
	defb 014h,035h,014h,037h,016h,015h,016h,017h,016h,01bh,016h,01dh,016h,01fh,016h,021h	; b07f  .5.7...........!
	defb 016h,023h,016h,025h,016h,029h,016h,02dh,016h,031h,016h,033h,016h,035h,016h,037h	; b08f  .#.%.).-.1.3.5.7
	defb 018h,015h,018h,017h,018h,019h,018h,01dh,018h,01fh,018h,021h,018h,023h,018h,025h	; b09f  ...........!.#.%
	defb 018h,029h,018h,02fh,018h,035h,018h,037h,01ah,017h,01ah,019h,01ah,01bh,01ah,023h	; b0af  .)./.5.7.......#
	defb 01ah,029h,01ah,02bh,01ah,031h,01ah,033h,01ch,015h,01ch,019h,01ch,01bh,01ch,01fh	; b0bf  .).+.1.3........
	defb 01ch,021h,01ch,023h,01ch,025h,01ch,027h,01ch,02bh,01ch,02dh,01ch,02fh,01ch,031h	; b0cf  .!.#.%.'.+.-./.1
	defb 01ch,033h,01ch,035h,01ch,037h,01eh,015h,01eh,019h,01eh,01bh,01eh,01fh,01eh,021h	; b0df  .3.5.7.........!
	defb 01eh,023h,01eh,025h,01eh,029h,01eh,02bh,01eh,02fh,01eh,031h,01eh,033h,01eh,037h	; b0ef  .#.%.).+./.1.3.7
	defb 020h,015h,020h,017h,020h,019h,020h,01dh,020h,01fh,020h,021h,020h,025h,020h,029h	; b0ff   . . . . . ! % )
	defb 020h,02bh,020h,02dh,020h,031h,020h,033h,020h,035h,022h,015h,022h,017h,022h,01bh	; b10f   + - 1 3 5".".".
	defb 022h,01dh,022h,01fh,022h,021h,022h,023h,022h,025h,022h,029h,022h,02bh,022h,02dh	; b11f  "."."!"#"%")"+"-
	defb 022h,031h,022h,033h,022h,035h,022h,037h,024h,015h,024h,017h,024h,019h,024h,01dh	; b12f  "1"3"5"7$.$.$.$.
	defb 024h,01fh,024h,023h,024h,025h,024h,027h,024h,029h,024h,02dh,024h,02fh,024h,033h	; b13f  $.$#$%$'$)$-$/$3
	defb 024h,035h,026h,015h,026h,017h,026h,019h,026h,01bh,026h,01fh,026h,023h,026h,025h	; b14f  $5&.&.&.&.&.&#&%
	defb 026h,029h,026h,02dh,026h,02fh,026h,031h,026h,033h,026h,037h,028h,015h,028h,017h	; b15f  &)&-&/&1&3&7(.(.
	defb 028h,01dh,028h,01fh,028h,023h,028h,029h,028h,02dh,028h,031h,028h,033h,028h,035h	; b16f  (.(.(#()(-(1(3(5
	defb 028h,037h,02ah,01bh,02ah,01dh,02ah,021h,02ah,023h,02ah,029h,02ah,02bh,02ah,031h	; b17f  (7*.*.*!*#*)*+*1
	defb 02ah,035h,02ch,015h,02ch,017h,02ch,01dh,02ch,01fh,02ch,021h,02ch,023h,02ch,027h	; b18f  *5,.,.,.,.,!,#,'
	defb 02ch,029h,02ch,02dh,02ch,031h,02ch,035h,02ch,037h,02eh,017h,02eh,019h,02eh,01bh	; b19f  ,),-,1,5,7......
	defb 02eh,01dh,02eh,01fh,02eh,021h,02eh,023h,02eh,025h,02eh,029h,02eh,02bh,02eh,02fh	; b1af  .....!.#.%.).+./
	defb 02eh,031h,02eh,033h,02eh,035h,02eh,037h,030h,017h,030h,019h,030h,01bh,030h,01dh	; b1bf  .1.3.5.70.0.0.0.
	defb 030h,01fh,030h,023h,030h,025h,030h,027h,030h,02bh,030h,02dh,030h,031h,030h,033h	; b1cf  0.0#0%0'0+0-0103
	defb 030h,035h,030h,037h,032h,015h,032h,017h,032h,019h,032h,01bh,032h,021h,032h,023h	; b1df  05072.2.2.2.2!2#
	defb 032h,027h,032h,029h,032h,02dh,032h,033h,032h,037h,034h,015h,034h,019h,034h,01dh	; b1ef  2'2)2-23274.4.4.
	defb 034h,023h,034h,025h,034h,02bh,034h,02dh,034h,02fh,034h,033h,034h,035h,034h,037h	; b1ff  4#4%4+4-4/434547
	defb 036h,017h,036h,01bh,036h,021h,036h,023h,036h,029h,036h,037h	; b20f  6.6.6!6#6)67

; ----------------------------------------------------------------------
; DATOS salidas_de_cada_zona: 49 punteros, uno por zona, a su lista de salidas
;   (p01:6B27); lo leen p01:6B24 (98 bytes)
;   0xb21b..0xb27d  (98 bytes)
DATA_salidas_de_cada_zona:
	defb 07dh,0b2h,088h,0b2h,099h,0b2h,0a4h,0b2h,0b3h,0b2h,0c0h,0b2h,0d3h,0b2h,0e6h,0b2h	; b21b  }...............
	defb 0edh,0b2h,002h,0b3h,013h,0b3h,020h,0b3h,031h,0b3h,042h,0b3h,057h,0b3h,066h,0b3h	; b22b  ...... .1.B.W.f.
	defb 073h,0b3h,082h,0b3h,095h,0b3h,09eh,0b3h,0b1h,0b3h,0c6h,0b3h,0d9h,0b3h,0e6h,0b3h	; b23b  s...............
	defb 0fbh,0b3h,010h,0b4h,025h,0b4h,03ah,0b4h,04dh,0b4h,062h,0b4h,077h,0b4h,084h,0b4h	; b24b  ....%.:.M.b.w...
	defb 091h,0b4h,0a2h,0b4h,0b5h,0b4h,0cah,0b4h,0dfh,0b4h,0eeh,0b4h,005h,0b5h,016h,0b5h	; b25b  ................
	defb 027h,0b5h,03ah,0b5h,051h,0b5h,05eh,0b5h,06bh,0b5h,080h,0b5h,095h,0b5h,0a8h,0b5h	; b26b  '.:.Q.^.k.......
	defb 0c7h,0b5h	; b27b

; ----------------------------------------------------------------------
; DATOS salidas_B27D: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 1-0
;   (11 bytes)
;   0xb27d..0xb288  (11 bytes)
DATA_salidas_B27D:
	defb 005h,005h,000h,00ah,002h,00dh,024h,012h,005h,017h,003h	; b27d  ......$....

; ----------------------------------------------------------------------
; DATOS salidas_B288: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 1-1
;   (17 bytes)
;   0xb288..0xb299  (17 bytes)
DATA_salidas_B288:
	defb 008h,001h,000h,002h,002h,005h,001h,007h,004h,008h,003h,009h,006h,00bh,007h,00ch	; b288  ................
	defb 005h	; b298

; ----------------------------------------------------------------------
; DATOS salidas_B299: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 1-2
;   (11 bytes)
;   0xb299..0xb2a4  (11 bytes)
DATA_salidas_B299:
	defb 005h,001h,001h,003h,002h,004h,004h,009h,005h,00dh,007h	; b299  ...........

; ----------------------------------------------------------------------
; DATOS salidas_B2A4: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 1-3
;   (15 bytes)
;   0xb2a4..0xb2b3  (15 bytes)
DATA_salidas_B2A4:
	defb 007h,000h,001h,002h,000h,007h,002h,008h,024h,00bh,023h,00dh,046h,012h,047h	; b2a4  ........$.#.F.G

; ----------------------------------------------------------------------
; DATOS salidas_B2B3: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 1-4
;   (13 bytes)
;   0xb2b3..0xb2c0  (13 bytes)
DATA_salidas_B2B3:
	defb 006h,004h,000h,008h,001h,00bh,002h,013h,003h,014h,004h,018h,005h	; b2b3  .............

; ----------------------------------------------------------------------
; DATOS salidas_B2C0: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 1-5
;   (19 bytes)
;   0xb2c0..0xb2d3  (19 bytes)
DATA_salidas_B2C0:
	defb 009h,003h,020h,007h,021h,00bh,022h,00dh,003h,015h,004h,018h,026h,01ah,008h,023h	; b2c0  .. .!.".....&..#
	defb 005h,024h,007h	; b2d0

; ----------------------------------------------------------------------
; DATOS salidas_B2D3: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 1-6
;   (19 bytes)
;   0xb2d3..0xb2e6  (19 bytes)
DATA_salidas_B2D3:
	defb 009h,000h,0c0h,00bh,0a3h,01ah,0c4h,01bh,0c2h,020h,066h,024h,088h,031h,049h,032h	; b2d3  ......... f$.1I2
	defb 045h,03ch,007h	; b2e3

; ----------------------------------------------------------------------
; DATOS salidas_B2E6: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 2-0 (7
;   bytes)
;   0xb2e6..0xb2ed  (7 bytes)
DATA_salidas_B2E6:
	defb 003h,005h,000h,009h,022h,00dh,001h	; b2e6

; ----------------------------------------------------------------------
; DATOS salidas_B2ED: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 2-1
;   (21 bytes)
;   0xb2ed..0xb302  (21 bytes)
DATA_salidas_B2ED:
	defb 00ah,003h,000h,004h,003h,006h,002h,009h,005h,00ah,001h,00bh,006h,00eh,008h,00fh	; b2ed  ................
	defb 004h,010h,007h,011h,009h	; b2fd

; ----------------------------------------------------------------------
; DATOS salidas_B302: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 2-2
;   (17 bytes)
;   0xb302..0xb313  (17 bytes)
DATA_salidas_B302:
	defb 008h,000h,000h,003h,002h,004h,003h,00ch,041h,010h,044h,012h,047h,015h,045h,017h	; b302  ........A.D.G.E.
	defb 046h	; b312

; ----------------------------------------------------------------------
; DATOS salidas_B313: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 2-3
;   (13 bytes)
;   0xb313..0xb320  (13 bytes)
DATA_salidas_B313:
	defb 006h,003h,001h,00ah,002h,00bh,004h,00eh,005h,00fh,000h,010h,006h	; b313  .............

; ----------------------------------------------------------------------
; DATOS salidas_B320: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 2-4
;   (17 bytes)
;   0xb320..0xb331  (17 bytes)
DATA_salidas_B320:
	defb 008h,001h,021h,003h,022h,005h,023h,006h,020h,00bh,004h,00dh,006h,00fh,007h,010h	; b320  ..!.".#. .......
	defb 005h	; b330

; ----------------------------------------------------------------------
; DATOS salidas_B331: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); se solapan 2
;   bloques (0xB331-0xB346, 0xB342-0xB357); lo leen zona 2-5, zona 2-6 (38
;   bytes)
;   0xb331..0xb357  (38 bytes)
DATA_salidas_B331:
	defb 00ah,001h,020h,006h,021h,008h,003h,00ah,004h,00bh,006h,01eh,005h,020h,007h,025h	; b331  .. .!........ .%
	defb 009h,00ah,002h,0c0h,006h,0c1h,009h,0c2h,01bh,084h,01ch,087h,01eh,066h,02eh,043h	; b341  .............f.C
	defb 02fh,048h,034h,025h,039h,029h	; b351

; ----------------------------------------------------------------------
; DATOS salidas_B357: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 3-0
;   (15 bytes)
;   0xb357..0xb366  (15 bytes)
DATA_salidas_B357:
	defb 007h,005h,020h,009h,022h,00dh,004h,012h,003h,016h,007h,019h,005h,01ch,021h	; b357  .. .".........!

; ----------------------------------------------------------------------
; DATOS salidas_B366: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 3-1
;   (13 bytes)
;   0xb366..0xb373  (13 bytes)
DATA_salidas_B366:
	defb 006h,004h,000h,009h,001h,00ah,002h,00ch,004h,00eh,003h,00fh,007h	; b366  .............

; ----------------------------------------------------------------------
; DATOS salidas_B373: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 3-2
;   (15 bytes)
;   0xb373..0xb382  (15 bytes)
DATA_salidas_B373:
	defb 007h,000h,001h,008h,022h,00ah,000h,00bh,003h,00ch,004h,00dh,007h,00fh,025h	; b373  ....".........%

; ----------------------------------------------------------------------
; DATOS salidas_B382: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 3-3
;   (19 bytes)
;   0xb382..0xb395  (19 bytes)
DATA_salidas_B382:
	defb 009h,000h,000h,001h,002h,002h,001h,004h,004h,007h,003h,00ah,006h,00bh,008h,00ch	; b382  ................
	defb 007h,00fh,009h	; b392

; ----------------------------------------------------------------------
; DATOS salidas_B395: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 3-4 (9
;   bytes)
;   0xb395..0xb39e  (9 bytes)
DATA_salidas_B395:
	defb 004h,002h,000h,005h,001h,008h,003h,010h,025h	; b395  ........%

; ----------------------------------------------------------------------
; DATOS salidas_B39E: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 3-5
;   (19 bytes)
;   0xb39e..0xb3b1  (19 bytes)
DATA_salidas_B39E:
	defb 009h,007h,000h,00ah,003h,00fh,024h,013h,021h,015h,006h,022h,007h,024h,025h,025h	; b39e  ......$.!..".$%%
	defb 028h,02ah,029h	; b3ae

; ----------------------------------------------------------------------
; DATOS salidas_B3B1: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 3-6
;   (21 bytes)
;   0xb3b1..0xb3c6  (21 bytes)
DATA_salidas_B3B1:
	defb 00ah,007h,0a0h,00dh,0a1h,015h,083h,019h,082h,01dh,0c4h,021h,065h,024h,0a7h,039h	; b3b1  ...........!e$.9
	defb 029h,03ch,026h,042h,008h	; b3c1

; ----------------------------------------------------------------------
; DATOS salidas_B3C6: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 4-0
;   (19 bytes)
;   0xb3c6..0xb3d9  (19 bytes)
DATA_salidas_B3C6:
	defb 009h,000h,000h,003h,001h,007h,022h,00ah,024h,00dh,027h,011h,006h,012h,049h,015h	; b3c6  ......".$.'...I.
	defb 048h,016h,045h	; b3d6

; ----------------------------------------------------------------------
; DATOS salidas_B3D9: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 4-1
;   (13 bytes)
;   0xb3d9..0xb3e6  (13 bytes)
DATA_salidas_B3D9:
	defb 006h,000h,000h,005h,004h,006h,022h,007h,021h,00ah,003h,00eh,005h	; b3d9  ......".!....

; ----------------------------------------------------------------------
; DATOS salidas_B3E6: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 4-2
;   (21 bytes)
;   0xb3e6..0xb3fb  (21 bytes)
DATA_salidas_B3E6:
	defb 00ah,002h,000h,004h,002h,006h,003h,007h,005h,008h,001h,009h,006h,00ch,009h,00eh	; b3e6  ................
	defb 008h,011h,00bh,013h,004h	; b3f6

; ----------------------------------------------------------------------
; DATOS salidas_B3FB: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 4-3
;   (21 bytes)
;   0xb3fb..0xb410  (21 bytes)
DATA_salidas_B3FB:
	defb 00ah,000h,001h,001h,003h,002h,002h,007h,044h,00ah,026h,00bh,029h,010h,027h,011h	; b3fb  ........D.&.).'.
	defb 028h,016h,040h,01bh,005h	; b40b

; ----------------------------------------------------------------------
; DATOS salidas_B410: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 4-4
;   (21 bytes)
;   0xb410..0xb425  (21 bytes)
DATA_salidas_B410:
	defb 00ah,005h,020h,006h,003h,00eh,004h,00fh,001h,010h,026h,018h,029h,019h,025h,01ah	; b410  .. .......&.).%.
	defb 002h,01bh,007h,01dh,008h	; b420

; ----------------------------------------------------------------------
; DATOS salidas_B425: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 4-5
;   (21 bytes)
;   0xb425..0xb43a  (21 bytes)
DATA_salidas_B425:
	defb 00ah,009h,020h,00bh,023h,00ch,004h,00eh,001h,015h,026h,016h,025h,017h,027h,019h	; b425  .. .#.....&.%.'.
	defb 022h,01ch,008h,023h,009h	; b435

; ----------------------------------------------------------------------
; DATOS salidas_B43A: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 4-6
;   (19 bytes)
;   0xb43a..0xb44d  (19 bytes)
DATA_salidas_B43A:
	defb 009h,001h,0c0h,007h,0a1h,00bh,0a2h,023h,064h,024h,083h,028h,0a5h,02bh,0a6h,02ch	; b43a  .......#d$.(.+.,
	defb 049h,041h,007h	; b44a

; ----------------------------------------------------------------------
; DATOS salidas_B44D: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 5-0
;   (21 bytes)
;   0xb44d..0xb462  (21 bytes)
DATA_salidas_B44D:
	defb 00ah,003h,000h,005h,001h,009h,042h,00ch,024h,00fh,023h,011h,026h,016h,045h,018h	; b44d  ......B.$.#.&.E.
	defb 048h,01bh,009h,01dh,00bh	; b45d

; ----------------------------------------------------------------------
; DATOS salidas_B462: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 5-1
;   (21 bytes)
;   0xb462..0xb477  (21 bytes)
DATA_salidas_B462:
	defb 00ah,000h,000h,005h,002h,007h,004h,009h,006h,00ah,003h,00ch,021h,00eh,025h,013h	; b462  ............!.%.
	defb 009h,015h,007h,016h,008h	; b472

; ----------------------------------------------------------------------
; DATOS salidas_B477: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 5-2
;   (13 bytes)
;   0xb477..0xb484  (13 bytes)
DATA_salidas_B477:
	defb 006h,002h,000h,005h,003h,00ah,004h,00dh,007h,00fh,002h,010h,005h	; b477  .............

; ----------------------------------------------------------------------
; DATOS salidas_B484: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 5-3
;   (13 bytes)
;   0xb484..0xb491  (13 bytes)
DATA_salidas_B484:
	defb 006h,002h,001h,005h,003h,007h,005h,008h,007h,00ah,009h,00ch,00ah	; b484  .............

; ----------------------------------------------------------------------
; DATOS salidas_B491: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 5-4
;   (17 bytes)
;   0xb491..0xb4a2  (17 bytes)
DATA_salidas_B491:
	defb 008h,001h,000h,003h,002h,006h,025h,007h,026h,009h,023h,00bh,001h,00ch,007h,00eh	; b491  ......%.&.#.....
	defb 024h	; b4a1

; ----------------------------------------------------------------------
; DATOS salidas_B4A2: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 5-5
;   (19 bytes)
;   0xb4a2..0xb4b5  (19 bytes)
DATA_salidas_B4A2:
	defb 009h,007h,020h,008h,002h,015h,024h,01bh,007h,01dh,00ah,01eh,008h,022h,006h,024h	; b4a2  .. ...$......".$
	defb 009h,025h,00dh	; b4b2

; ----------------------------------------------------------------------
; DATOS salidas_B4B5: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 5-6
;   (21 bytes)
;   0xb4b5..0xb4ca  (21 bytes)
DATA_salidas_B4B5:
	defb 00ah,000h,0c0h,002h,0c3h,006h,0c5h,01eh,066h,01fh,062h,021h,064h,023h,061h,029h	; b4b5  ........f.b!d#a)
	defb 048h,02ch,047h,03fh,009h	; b4c5

; ----------------------------------------------------------------------
; DATOS salidas_B4CA: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 6-0
;   (21 bytes)
;   0xb4ca..0xb4df  (21 bytes)
DATA_salidas_B4CA:
	defb 00ah,001h,001h,002h,002h,005h,003h,006h,004h,00ch,006h,00dh,008h,00eh,005h,010h	; b4ca  ................
	defb 009h,013h,000h,015h,007h	; b4da

; ----------------------------------------------------------------------
; DATOS salidas_B4DF: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 6-1
;   (15 bytes)
;   0xb4df..0xb4ee  (15 bytes)
DATA_salidas_B4DF:
	defb 007h,000h,020h,003h,023h,007h,022h,00dh,004h,012h,006h,014h,005h,016h,007h	; b4df  .. .#."........

; ----------------------------------------------------------------------
; DATOS salidas_B4EE: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 6-2
;   (23 bytes)
;   0xb4ee..0xb505  (23 bytes)
DATA_salidas_B4EE:
	defb 00bh,001h,021h,004h,042h,005h,045h,007h,006h,008h,000h,00dh,008h,00fh,009h,010h	; b4ee  ..!.B.E.........
	defb 003h,013h,004h,016h,047h,01bh,02bh	; b4fe

; ----------------------------------------------------------------------
; DATOS salidas_B505: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 6-3
;   (17 bytes)
;   0xb505..0xb516  (17 bytes)
DATA_salidas_B505:
	defb 008h,001h,000h,002h,002h,006h,003h,008h,005h,009h,007h,00ch,001h,00eh,004h,010h	; b505  ................
	defb 006h	; b515

; ----------------------------------------------------------------------
; DATOS salidas_B516: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 6-4
;   (17 bytes)
;   0xb516..0xb527  (17 bytes)
DATA_salidas_B516:
	defb 008h,000h,020h,004h,023h,005h,024h,006h,002h,00ah,001h,010h,026h,019h,025h,01ah	; b516  .. .#.$.....&.%.
	defb 007h	; b526

; ----------------------------------------------------------------------
; DATOS salidas_B527: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 6-5
;   (19 bytes)
;   0xb527..0xb53a  (19 bytes)
DATA_salidas_B527:
	defb 009h,003h,001h,00ch,022h,015h,004h,01fh,000h,022h,006h,025h,027h,027h,029h,028h	; b527  ...."....".%'')(
	defb 025h,02bh,028h	; b537

; ----------------------------------------------------------------------
; DATOS salidas_B53A: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 6-6
;   (23 bytes)
;   0xb53a..0xb551  (23 bytes)
DATA_salidas_B53A:
	defb 00bh,004h,0c0h,007h,0a2h,00ah,0a5h,00eh,0a4h,011h,0a1h,01bh,0c6h,021h,069h,023h	; b53a  .............!i#
	defb 067h,024h,088h,026h,08ah,03ch,00bh	; b54a

; ----------------------------------------------------------------------
; DATOS salidas_B551: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 7-0
;   (13 bytes)
;   0xb551..0xb55e  (13 bytes)
DATA_salidas_B551:
	defb 006h,007h,000h,009h,002h,010h,005h,011h,001h,014h,004h,017h,003h	; b551  .............

; ----------------------------------------------------------------------
; DATOS salidas_B55E: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 7-1
;   (13 bytes)
;   0xb55e..0xb56b  (13 bytes)
DATA_salidas_B55E:
	defb 006h,002h,000h,004h,002h,006h,005h,008h,023h,009h,024h,00dh,007h	; b55e  ........#.$..

; ----------------------------------------------------------------------
; DATOS salidas_B56B: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 7-2
;   (21 bytes)
;   0xb56b..0xb580  (21 bytes)
DATA_salidas_B56B:
	defb 00ah,001h,000h,004h,002h,005h,005h,006h,004h,008h,006h,009h,001h,00bh,007h,00fh	; b56b  ................
	defb 008h,011h,009h,012h,003h	; b57b

; ----------------------------------------------------------------------
; DATOS salidas_B580: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 7-3
;   (21 bytes)
;   0xb580..0xb595  (21 bytes)
DATA_salidas_B580:
	defb 00ah,001h,000h,002h,002h,008h,001h,00ah,024h,00ch,023h,00fh,026h,015h,048h,019h	; b580  ........$.#.&.H.
	defb 047h,01bh,049h,01dh,025h	; b590

; ----------------------------------------------------------------------
; DATOS salidas_B595: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 7-4
;   (19 bytes)
;   0xb595..0xb5a8  (19 bytes)
DATA_salidas_B595:
	defb 009h,000h,000h,005h,002h,00bh,024h,00ch,026h,017h,007h,019h,003h,01ch,005h,01dh	; b595  ......$.&.......
	defb 008h,01fh,021h	; b5a5

; ----------------------------------------------------------------------
; DATOS salidas_B5A8: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 7-5
;   (31 bytes)
;   0xb5a8..0xb5c7  (31 bytes)
DATA_salidas_B5A8:
	defb 00fh,000h,001h,008h,022h,009h,024h,00bh,026h,00fh,028h,010h,02bh,018h,02ch,01ah	; b5a8  ....".$.&.(.+.,.
	defb 009h,01dh,00fh,01fh,010h,020h,00dh,024h,023h,027h,032h,034h,007h,038h,015h	; b5b8  ..... .$#'24.8.

; ----------------------------------------------------------------------
; DATOS salidas_B5C7: [n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a
;   0xEB00 (bits 0-4 y 5-7 del segundo byte por separado); lo leen zona 7-6
;   (15 bytes)
;   0xb5c7..0xb5d6  (15 bytes)
DATA_salidas_B5C7:
	defb 007h,003h,0a0h,013h,082h,01ah,0c3h,021h,065h,025h,0a4h,029h,0a6h,02ah,047h	; b5c7  .......!e%.).*G

; ----------------------------------------------------------------------
; DATOS cosas_de_cada_zona: 49 punteros, uno por zona, a su lista de cosas por
;   casilla (p01:7DAE); lo leen p01:7DAB (98 bytes)
;   0xb5d6..0xb638  (98 bytes)
DATA_cosas_de_cada_zona:
	defb 038h,0b6h,049h,0b6h,049h,0b6h,04ah,0b6h,049h,0b6h,064h,0b6h,071h,0b6h,057h,0b6h	; b5d6  8.I.I.J.I.d.q.W.
	defb 049h,0b6h,0b7h,0b6h,049h,0b6h,0a2h,0b6h,0ddh,0b6h,0f2h,0b6h,0c8h,0b6h,049h,0b6h	; b5e6  I...I.........I.
	defb 027h,0b7h,049h,0b6h,030h,0b7h,049h,0b7h,062h,0b7h,097h,0b7h,0ach,0b7h,049h,0b6h	; b5f6  '.I.0.I.b.....I.
	defb 0b1h,0b7h,0c2h,0b7h,064h,0b6h,071h,0b6h,0d7h,0b7h,038h,0b6h,049h,0b6h,049h,0b6h	; b606  ....d.q...8.I.I.
	defb 027h,0b7h,0ddh,0b6h,0f2h,0b6h,049h,0b6h,0c8h,0b6h,009h,0b8h,049h,0b6h,0c2h,0b7h	; b616  '.....I.....I...
	defb 049h,0b7h,071h,0b6h,049h,0b6h,057h,0b6h,049h,0b6h,037h,0b8h,0f4h,0b7h,01ah,0b8h	; b626  I.q.I.W.I.7.....
	defb 062h,0b7h	; b636

; ----------------------------------------------------------------------
; DATOS cosas_B638: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 1-0, zona 5-1 (17 bytes)
;   0xb638..0xb649  (17 bytes)
DATA_cosas_B638:
	defb 008h,003h,000h,084h,000h,086h,001h,088h,000h,00fh,000h,090h,000h,013h,001h,016h	; b638  ................
	defb 000h	; b648

; ----------------------------------------------------------------------
; DATOS cosas_B649: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 1-1, zona 1-2, zona 1-4, zona 2-1, zona 2-3, zona 3-1, zona 3-3, zona
;   4-2 y 6 mas (1 bytes)
;   0xb649..0xb64a  (1 bytes)
DATA_cosas_B649:
	defb 000h	; b649

; ----------------------------------------------------------------------
; DATOS cosas_B64A: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 1-3 (13 bytes)
;   0xb64a..0xb657  (13 bytes)
DATA_cosas_B64A:
	defb 006h,083h,001h,086h,002h,009h,000h,08ah,002h,00eh,001h,010h,000h	; b64a  .............

; ----------------------------------------------------------------------
; DATOS cosas_B657: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 2-0, zona 7-1 (13 bytes)
;   0xb657..0xb664  (13 bytes)
DATA_cosas_B657:
	defb 006h,002h,000h,083h,000h,084h,000h,006h,000h,08ah,000h,00eh,001h	; b657  .............

; ----------------------------------------------------------------------
; DATOS cosas_B664: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 1-5, zona 4-5 (13 bytes)
;   0xb664..0xb671  (13 bytes)
DATA_cosas_B664:
	defb 006h,088h,000h,08eh,001h,010h,001h,094h,000h,017h,000h,01dh,001h	; b664  .............

; ----------------------------------------------------------------------
; DATOS cosas_B671: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 1-6, zona 4-6, zona 6-6 (49 bytes)
;   0xb671..0xb6a2  (49 bytes)
DATA_cosas_B671:
	defb 018h,082h,005h,089h,004h,00ch,006h,08fh,006h,095h,003h,017h,005h,099h,004h,09ch	; b671  ................
	defb 005h,01dh,005h,021h,004h,0a2h,002h,025h,006h,0a9h,002h,02ah,006h,02dh,003h,0afh	; b681  ...!...%...*.-..
	defb 001h,0b1h,001h,034h,005h,036h,002h,0b7h,000h,038h,002h,0bah,000h,03dh,001h,040h	; b691  ...4.6...8...=.@
	defb 001h	; b6a1

; ----------------------------------------------------------------------
; DATOS cosas_B6A2: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 2-4 (21 bytes)
;   0xb6a2..0xb6b7  (21 bytes)
DATA_cosas_B6A2:
	defb 00ah,081h,000h,083h,000h,085h,000h,086h,000h,008h,000h,00bh,001h,00dh,001h,00fh	; b6a2  ................
	defb 001h,010h,001h,092h,001h	; b6b2

; ----------------------------------------------------------------------
; DATOS cosas_B6B7: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 2-2 (17 bytes)
;   0xb6b7..0xb6c8  (17 bytes)
DATA_cosas_B6B7:
	defb 008h,083h,001h,084h,002h,087h,002h,008h,000h,08ah,002h,00eh,001h,011h,001h,014h	; b6b7  ................
	defb 000h	; b6c7

; ----------------------------------------------------------------------
; DATOS cosas_B6C8: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 3-0, zona 6-1 (21 bytes)
;   0xb6c8..0xb6dd  (21 bytes)
DATA_cosas_B6C8:
	defb 00ah,081h,000h,084h,000h,088h,001h,00eh,001h,090h,001h,093h,001h,017h,001h,01ah	; b6c8  ................
	defb 000h,01eh,001h,020h,000h	; b6d8

; ----------------------------------------------------------------------
; DATOS cosas_B6DD: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 2-5, zona 5-5 (21 bytes)
;   0xb6dd..0xb6f2  (21 bytes)
DATA_cosas_B6DD:
	defb 00ah,086h,000h,089h,001h,08dh,001h,00eh,001h,091h,000h,012h,000h,096h,000h,017h	; b6dd  ................
	defb 000h,01bh,001h,022h,001h	; b6ed

; ----------------------------------------------------------------------
; DATOS cosas_B6F2: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 2-6, zona 5-6 (53 bytes)
;   0xb6f2..0xb727  (53 bytes)
DATA_cosas_B6F2:
	defb 01ah,081h,005h,088h,005h,08ah,004h,00bh,006h,012h,006h,096h,003h,019h,005h,09ah	; b6f2  ................
	defb 003h,09ch,002h,09fh,002h,020h,005h,024h,004h,0a5h,001h,029h,004h,0aah,001h,02dh	; b702  ..... .$...)...-
	defb 003h,0b1h,000h,032h,003h,0b5h,000h,0b7h,000h,038h,002h,0bah,000h,03dh,001h,040h	; b712  ...2.....8...=.@
	defb 001h,042h,001h,043h,001h	; b722

; ----------------------------------------------------------------------
; DATOS cosas_B727: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 3-2, zona 5-4 (9 bytes)
;   0xb727..0xb730  (9 bytes)
DATA_cosas_B727:
	defb 004h,082h,001h,084h,001h,008h,000h,010h,000h	; b727  .........

; ----------------------------------------------------------------------
; DATOS cosas_B730: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 3-4 (25 bytes)
;   0xb730..0xb749  (25 bytes)
DATA_cosas_B730:
	defb 00ch,001h,001h,082h,001h,086h,001h,007h,001h,089h,001h,08ah,001h,00dh,000h,00eh	; b730  ................
	defb 000h,012h,000h,093h,000h,095h,000h,016h,000h	; b740  .........

; ----------------------------------------------------------------------
; DATOS cosas_B749: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 3-5, zona 6-5 (25 bytes)
;   0xb749..0xb762  (25 bytes)
DATA_cosas_B749:
	defb 00ch,089h,000h,08dh,001h,08eh,001h,011h,001h,092h,001h,016h,000h,01ah,000h,09bh	; b749  ................
	defb 000h,01ch,000h,09eh,000h,026h,001h,029h,001h	; b759  .....&.).

; ----------------------------------------------------------------------
; DATOS cosas_B762: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 3-6, zona 7-6 (53 bytes)
;   0xb762..0xb797  (53 bytes)
DATA_cosas_B762:
	defb 01ah,080h,005h,08eh,006h,00fh,006h,094h,003h,097h,003h,098h,005h,01bh,005h,09ch	; b762  ................
	defb 005h,09fh,002h,020h,004h,022h,004h,026h,004h,027h,006h,0a8h,003h,02bh,003h,0ach	; b772  ... .".&.'...+..
	defb 001h,0b1h,001h,033h,005h,0b5h,001h,03ah,002h,0bbh,000h,0bfh,000h,040h,002h,045h	; b782  ...3...:.....@.E
	defb 003h,049h,001h,04eh,001h	; b792

; ----------------------------------------------------------------------
; DATOS cosas_B797: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 4-0 (21 bytes)
;   0xb797..0xb7ac  (21 bytes)
DATA_cosas_B797:
	defb 00ah,081h,001h,085h,000h,088h,002h,00bh,000h,08ch,002h,08fh,002h,010h,001h,013h	; b797  ................
	defb 001h,017h,001h,01ah,000h	; b7a7

; ----------------------------------------------------------------------
; DATOS cosas_B7AC: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 4-1 (5 bytes)
;   0xb7ac..0xb7b1  (5 bytes)
DATA_cosas_B7AC:
	defb 002h,081h,001h,008h,000h	; b7ac

; ----------------------------------------------------------------------
; DATOS cosas_B7B1: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 4-3 (17 bytes)
;   0xb7b1..0xb7c2  (17 bytes)
DATA_cosas_B7B1:
	defb 008h,084h,001h,088h,001h,08dh,002h,00eh,000h,093h,000h,014h,002h,017h,001h,01ch	; b7b1  ................
	defb 001h	; b7c1

; ----------------------------------------------------------------------
; DATOS cosas_B7C2: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 4-4, zona 6-4 (21 bytes)
;   0xb7c2..0xb7d7  (21 bytes)
DATA_cosas_B7C2:
	defb 00ah,082h,000h,084h,000h,088h,001h,08bh,001h,00ch,001h,00eh,001h,012h,000h,094h	; b7c2  ................
	defb 000h,017h,000h,01ch,001h	; b7d2

; ----------------------------------------------------------------------
; DATOS cosas_B7D7: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 5-0 (29 bytes)
;   0xb7d7..0xb7f4  (29 bytes)
DATA_cosas_B7D7:
	defb 00eh,082h,002h,084h,001h,087h,001h,088h,001h,009h,001h,00eh,000h,08fh,002h,010h	; b7d7  ................
	defb 002h,092h,000h,013h,002h,094h,002h,017h,000h,018h,001h,01bh,001h	; b7e7  .............

; ----------------------------------------------------------------------
; DATOS cosas_B7F4: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 7-4 (21 bytes)
;   0xb7f4..0xb809  (21 bytes)
DATA_cosas_B7F4:
	defb 00ah,083h,001h,087h,000h,08ah,000h,00fh,000h,090h,000h,014h,001h,017h,001h,099h	; b7f4  ................
	defb 001h,01ah,001h,01eh,000h	; b804

; ----------------------------------------------------------------------
; DATOS cosas_B809: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 6-2 (17 bytes)
;   0xb809..0xb81a  (17 bytes)
DATA_cosas_B809:
	defb 008h,081h,002h,082h,000h,089h,002h,00eh,001h,092h,001h,017h,001h,018h,000h,01ch	; b809  ................
	defb 000h	; b819

; ----------------------------------------------------------------------
; DATOS cosas_B81A: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 7-5 (29 bytes)
;   0xb81a..0xb837  (29 bytes)
DATA_cosas_B81A:
	defb 00eh,083h,001h,08ah,000h,08eh,000h,093h,001h,014h,001h,017h,000h,09bh,001h,022h	; b81a  ..............."
	defb 001h,025h,000h,0a6h,000h,0a9h,000h,02ch,000h,030h,001h,036h,001h	; b82a  .%.....,.0.6.

; ----------------------------------------------------------------------
; DATOS cosas_B837: [n] y n parejas [casilla | bit 7][valor]: en la casilla
;   0xC281, p01:7DDA deja en 0xC520 un 1 (2 con el bit 7) y el valor; lo leen
;   zona 7-3 (21 bytes)
;   0xb837..0xb84c  (21 bytes)
DATA_cosas_B837:
	defb 00ah,084h,001h,087h,002h,08dh,002h,00eh,000h,090h,002h,013h,001h,094h,001h,017h	; b837  ................
	defb 000h,01ah,000h,01eh,002h	; b847

; ----------------------------------------------------------------------
; DATOS puntos_de_cada_figura: 33 bytes, uno por tipo de figura 1-0x21 (ix+0):
;   las centenas de puntos en BCD que suma p00:437E al acabar con ella
;   (p01:7996); lo leen p01:798E (33 bytes)
;   0xb84c..0xb86d  (33 bytes)
DATA_puntos_de_cada_figura:
	defb 000h,005h,005h,005h,001h,000h,001h,000h,001h,001h,001h,001h,001h,001h,001h,001h	; b84c  ................
	defb 001h,000h,001h,001h,001h,001h,001h,001h,001h,005h,001h,001h,000h,001h,001h,001h	; b85c  ................
	defb 000h	; b86c

; ----------------------------------------------------------------------
; DATOS dinero_de_cada_figura: 33 bytes, uno por tipo de figura: el dinero que
;   suma p00:5929 (p01:79B9); los tipos 8 y 0x21 no van por aqui, restan 50
;   con p00:5958; lo leen p01:79B3 (33 bytes)
;   0xb86d..0xb88e  (33 bytes)
DATA_dinero_de_cada_figura:
	defb 000h,000h,020h,000h,010h,000h,005h,000h,005h,010h,005h,005h,010h,010h,000h,010h	; b86d  .. .............
	defb 010h,000h,010h,010h,010h,010h,010h,010h,010h,010h,005h,000h,000h,010h,010h,010h	; b87d  ................
	defb 000h	; b88d

; ----------------------------------------------------------------------
; DATOS tamano_de_cada_figura: 33 bytes, uno por tipo de figura: 1, 2 o 3, el
;   tamano de su caja de choque (p01:7A99: 3 es 7 de alto, el resto 15); lo
;   leen p01:7A93 (33 bytes)
;   0xb88e..0xb8af  (33 bytes)
DATA_tamano_de_cada_figura:
	defb 003h,003h,004h,003h,001h,003h,003h,001h,001h,001h,001h,001h,001h,001h,003h,001h	; b88e  ................
	defb 001h,001h,001h,002h,002h,002h,001h,001h,002h,002h,003h,003h,001h,002h,002h,002h	; b89e  ................
	defb 001h	; b8ae

; ----------------------------------------------------------------------
; DATOS casilla_de_entrada: 49 bytes, uno por zona: la casilla 0xC281 en la
;   que se empieza (p01:66A5); lo leen p01:66A2 (49 bytes)
;   0xb8af..0xb8e0  (49 bytes)
DATA_casilla_de_entrada:
	defb 000h,000h,000h,000h,000h,01ah,03ch,000h,000h,000h,000h,00ah,01ah,03ch,016h,000h	; b8af  ......<......<..
	defb 000h,00ch,000h,020h,048h,000h,00ah,008h,000h,00ah,01ah,03ch,000h,000h,000h,000h	; b8bf  ... H......<....
	defb 000h,01ah,03ch,00ah,016h,006h,000h,00ah,020h,03ch,000h,000h,008h,000h,000h,02eh	; b8cf  ..<..... <......
	defb 048h	; b8df

; ----------------------------------------------------------------------
; DATOS seis_sitios_B8E0: 6 parejas [y][x] que p01:676C recorre del ultimo al
;   primero y pasa a p01:781F; lo leen p01:676C (12 bytes)
;   0xb8e0..0xb8ec  (12 bytes)
DATA_seis_sitios_B8E0:
	defb 0b0h,0c0h,0b0h,040h,070h,0c0h,070h,040h,0b0h,080h,070h,080h	; b8e0  ...@p.p@..p.

; ----------------------------------------------------------------------
; DATOS juego_de_cada_zona: 49 bytes, uno por zona: el juego de graficos
;   0xC289 (p01:664F); p02:81FD lee los siete de la fase; lo leen p01:6649 (49
;   bytes)
;   0xb8ec..0xb91d  (49 bytes)
DATA_juego_de_cada_zona:
	defb 000h,003h,001h,002h,003h,004h,005h,000h,001h,002h,001h,000h,004h,005h,000h,003h	; b8ec  ................
	defb 000h,001h,002h,004h,005h,002h,000h,001h,002h,000h,004h,005h,002h,000h,003h,001h	; b8fc  ................
	defb 000h,004h,005h,001h,000h,002h,001h,000h,004h,005h,003h,000h,001h,002h,000h,004h	; b90c  ................
	defb 005h	; b91c

; ----------------------------------------------------------------------
; DATOS dibujos_de_caracteres: 33 punteros a dibujos hechos de caracteres que
;   p02:99FB pinta con 0x4EF1; lo leen p02:9A07 (66 bytes)
;   0xb91d..0xb95f  (66 bytes)
DATA_dibujos_de_caracteres:
	defb 05fh,0b9h,07eh,0b9h,045h,0bah,0b8h,0bah,0f3h,0bah,012h,0bbh,023h,0bbh,050h,0bbh	; b91d  _.~.E.......#.P.
	defb 06fh,0bbh,080h,0bbh,091h,0bbh,0beh,0bbh,0ddh,0bbh,0eeh,0bbh,0ffh,0bbh,02ch,0bch	; b92d  o.............,.
	defb 04bh,0bch,05ch,0bch,06dh,0bch,09ah,0bch,0b9h,0bch,0cah,0bch,0dbh,0bch,008h,0bdh	; b93d  K.\.m...........
	defb 027h,0bdh,038h,0bdh,049h,0bdh,076h,0bdh,095h,0bdh,0a6h,0bdh,06dh,0beh,0e0h,0beh	; b94d  '.8.I.v.....m...
	defb 01bh,0bfh	; b95d

; ----------------------------------------------------------------------
; DATOS dibujo_car_B95F: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (31 bytes)
;   0xb95f..0xb97e  (31 bytes)
DATA_dibujo_car_B95F:
	defb 002h,030h,080h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,000h	; b95f  .0..............
	defb 000h,000h,000h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; b96f  ...............

; ----------------------------------------------------------------------
; DATOS dibujo_car_B97E: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (199 bytes)
;   0xb97e..0xba45  (199 bytes)
DATA_dibujo_car_B97E:
	defb 00eh,030h,050h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h	; b97e  .0P.............
	defb 005h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; b98e  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; b99e  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; b9ae  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; b9be  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; b9ce  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; b9de  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; b9ee  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; b9fe  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; ba0e  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; ba1e  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; ba2e  ................
	defb 003h,003h,003h,003h,003h,003h,003h	; ba3e

; ----------------------------------------------------------------------
; DATOS dibujo_car_BA45: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (115 bytes)
;   0xba45..0xbab8  (115 bytes)
DATA_dibujo_car_BA45:
	defb 008h,030h,068h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h	; ba45  .0h.............
	defb 002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,005h,005h,005h,005h,005h	; ba55  ................
	defb 005h,005h,005h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; ba65  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; ba75  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; ba85  ................
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,004h,004h,004h,004h,004h	; ba95  ................
	defb 004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; baa5  ................
	defb 004h,004h,004h	; bab5

; ----------------------------------------------------------------------
; DATOS dibujo_car_BAB8: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (59 bytes)
;   0xbab8..0xbaf3  (59 bytes)
DATA_dibujo_car_BAB8:
	defb 004h,030h,078h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h	; bab8  .0x.............
	defb 002h,002h,002h,002h,002h,002h,002h,005h,005h,005h,005h,003h,003h,003h,003h,003h	; bac8  ................
	defb 003h,003h,003h,003h,003h,003h,003h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bad8  ................
	defb 004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bae8  ...........

; ----------------------------------------------------------------------
; DATOS dibujo_car_BAF3: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (31 bytes)
;   0xbaf3..0xbb12  (31 bytes)
DATA_dibujo_car_BAF3:
	defb 002h,030h,080h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,005h	; baf3  .0..............
	defb 005h,003h,003h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bb03  ...............

; ----------------------------------------------------------------------
; DATOS dibujo_car_BB12: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbb12..0xbb23  (17 bytes)
DATA_dibujo_car_BB12:
	defb 001h,030h,048h,040h,040h,040h,040h,040h,040h,040h,040h,040h,040h,040h,040h,040h	; bb12  .0H@@@@@@@@@@@@@
	defb 040h	; bb22

; ----------------------------------------------------------------------
; DATOS dibujo_car_BB23: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (45 bytes)
;   0xbb23..0xbb50  (45 bytes)
DATA_dibujo_car_BB23:
	defb 003h,030h,050h,017h,002h,002h,018h,017h,002h,001h,018h,019h,001h,001h,01ah,001h	; bb23  .0P.............
	defb 001h,01ah,001h,001h,01ah,001h,001h,01ah,001h,001h,01ah,001h,001h,01ah,001h,001h	; bb33  ................
	defb 01ah,001h,001h,01ah,001h,001h,01bh,001h,01ch,004h,01ch,004h,004h	; bb43  .............

; ----------------------------------------------------------------------
; DATOS dibujo_car_BB50: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (31 bytes)
;   0xbb50..0xbb6f  (31 bytes)
DATA_dibujo_car_BB50:
	defb 002h,030h,068h,002h,002h,002h,002h,002h,002h,017h,002h,018h,01dh,001h,01eh,001h	; bb50  .0h.............
	defb 01eh,001h,01eh,001h,01eh,001h,01fh,01ch,004h,004h,004h,004h,004h,004h,004h	; bb60  ...............

; ----------------------------------------------------------------------
; DATOS dibujo_car_BB6F: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbb6f..0xbb80  (17 bytes)
DATA_dibujo_car_BB6F:
	defb 001h,030h,078h,002h,002h,002h,002h,002h,017h,020h,035h,021h,004h,004h,004h,004h	; bb6f  .0x...... 5!....
	defb 004h	; bb7f

; ----------------------------------------------------------------------
; DATOS dibujo_car_BB80: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbb80..0xbb91  (17 bytes)
DATA_dibujo_car_BB80:
	defb 001h,030h,048h,005h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; bb80  .0H.............
	defb 003h	; bb90

; ----------------------------------------------------------------------
; DATOS dibujo_car_BB91: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (45 bytes)
;   0xbb91..0xbbbe  (45 bytes)
DATA_dibujo_car_BB91:
	defb 003h,030h,050h,002h,002h,002h,002h,002h,002h,002h,002h,002h,005h,005h,005h,003h	; bb91  .0P.............
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; bba1  ................
	defb 003h,003h,003h,003h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bbb1  .............

; ----------------------------------------------------------------------
; DATOS dibujo_car_BBBE: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (31 bytes)
;   0xbbbe..0xbbdd  (31 bytes)
DATA_dibujo_car_BBBE:
	defb 002h,030h,068h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,005h,005h,003h	; bbbe  .0h.............
	defb 003h,003h,003h,003h,003h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bbce  ...............

; ----------------------------------------------------------------------
; DATOS dibujo_car_BBDD: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbbdd..0xbbee  (17 bytes)
DATA_dibujo_car_BBDD:
	defb 001h,030h,078h,002h,002h,002h,002h,002h,002h,005h,003h,004h,004h,004h,004h,004h	; bbdd  .0x.............
	defb 004h	; bbed

; ----------------------------------------------------------------------
; DATOS dibujo_car_BBEE: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbbee..0xbbff  (17 bytes)
DATA_dibujo_car_BBEE:
	defb 001h,030h,048h,060h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h	; bbee  .0H`aaaaaaaaaaaa
	defb 061h	; bbfe

; ----------------------------------------------------------------------
; DATOS dibujo_car_BBFF: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (45 bytes)
;   0xbbff..0xbc2c  (45 bytes)
DATA_dibujo_car_BBFF:
	defb 003h,030h,050h,002h,002h,002h,002h,002h,002h,002h,002h,002h,005h,005h,060h,003h	; bbff  .0P...........`.
	defb 003h,061h,003h,003h,061h,003h,003h,061h,003h,003h,061h,003h,003h,061h,003h,003h	; bc0f  .a..a..a..a..a..
	defb 061h,003h,003h,061h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bc1f  a..a.........

; ----------------------------------------------------------------------
; DATOS dibujo_car_BC2C: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (31 bytes)
;   0xbc2c..0xbc4b  (31 bytes)
DATA_dibujo_car_BC2C:
	defb 002h,030h,068h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,005h,060h,003h	; bc2c  .0h...........`.
	defb 061h,003h,061h,003h,061h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bc3c  a.a.a..........

; ----------------------------------------------------------------------
; DATOS dibujo_car_BC4B: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbc4b..0xbc5c  (17 bytes)
DATA_dibujo_car_BC4B:
	defb 001h,030h,078h,002h,002h,002h,002h,002h,002h,060h,061h,004h,004h,004h,004h,004h	; bc4b  .0x......`a.....
	defb 004h	; bc5b

; ----------------------------------------------------------------------
; DATOS dibujo_car_BC5C: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbc5c..0xbc6d  (17 bytes)
DATA_dibujo_car_BC5C:
	defb 001h,030h,0c0h,016h,016h,016h,016h,016h,016h,016h,016h,016h,016h,016h,016h,016h	; bc5c  .0..............
	defb 016h	; bc6c

; ----------------------------------------------------------------------
; DATOS dibujo_car_BC6D: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (45 bytes)
;   0xbc6d..0xbc9a  (45 bytes)
DATA_dibujo_car_BC6D:
	defb 003h,030h,0a8h,002h,002h,041h,002h,041h,042h,043h,042h,001h,044h,001h,001h,044h	; bc6d  .0...A.ABCB.D..D
	defb 001h,001h,044h,001h,001h,044h,001h,001h,044h,001h,001h,044h,001h,001h,044h,001h	; bc7d  ..D..D..D..D..D.
	defb 001h,044h,001h,001h,045h,001h,001h,004h,046h,001h,004h,004h,046h	; bc8d  .D..E...F...F

; ----------------------------------------------------------------------
; DATOS dibujo_car_BC9A: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (31 bytes)
;   0xbc9a..0xbcb9  (31 bytes)
DATA_dibujo_car_BC9A:
	defb 002h,030h,098h,002h,002h,002h,002h,002h,002h,002h,041h,047h,042h,048h,001h,048h	; bc9a  .0........AGBH.H
	defb 001h,048h,001h,048h,001h,049h,001h,004h,046h,004h,004h,004h,004h,004h,004h	; bcaa  .H.H.I..F......

; ----------------------------------------------------------------------
; DATOS dibujo_car_BCB9: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbcb9..0xbcca  (17 bytes)
DATA_dibujo_car_BCB9:
	defb 001h,030h,090h,002h,002h,002h,002h,002h,041h,04ah,05fh,04bh,004h,004h,004h,004h	; bcb9  .0......AJ_K....
	defb 004h	; bcc9

; ----------------------------------------------------------------------
; DATOS dibujo_car_BCCA: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbcca..0xbcdb  (17 bytes)
DATA_dibujo_car_BCCA:
	defb 001h,030h,0c0h,005h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; bcca  .0..............
	defb 003h	; bcda

; ----------------------------------------------------------------------
; DATOS dibujo_car_BCDB: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (45 bytes)
;   0xbcdb..0xbd08  (45 bytes)
DATA_dibujo_car_BCDB:
	defb 003h,030h,0a8h,002h,002h,002h,002h,002h,002h,002h,002h,002h,005h,005h,005h,003h	; bcdb  .0..............
	defb 003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; bceb  ................
	defb 003h,003h,003h,003h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bcfb  .............

; ----------------------------------------------------------------------
; DATOS dibujo_car_BD08: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (31 bytes)
;   0xbd08..0xbd27  (31 bytes)
DATA_dibujo_car_BD08:
	defb 002h,030h,098h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,005h,005h,003h	; bd08  .0..............
	defb 003h,003h,003h,003h,003h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bd18  ...............

; ----------------------------------------------------------------------
; DATOS dibujo_car_BD27: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbd27..0xbd38  (17 bytes)
DATA_dibujo_car_BD27:
	defb 001h,030h,090h,002h,002h,002h,002h,002h,002h,005h,003h,004h,004h,004h,004h,004h	; bd27  .0..............
	defb 004h	; bd37

; ----------------------------------------------------------------------
; DATOS dibujo_car_BD38: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbd38..0xbd49  (17 bytes)
DATA_dibujo_car_BD38:
	defb 001h,030h,0c0h,036h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h	; bd38  .0.6777777777777
	defb 037h	; bd48

; ----------------------------------------------------------------------
; DATOS dibujo_car_BD49: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (45 bytes)
;   0xbd49..0xbd76  (45 bytes)
DATA_dibujo_car_BD49:
	defb 003h,030h,0a8h,002h,002h,002h,002h,002h,002h,002h,002h,002h,036h,005h,005h,037h	; bd49  .0..........6..7
	defb 003h,003h,037h,003h,003h,037h,003h,003h,037h,003h,003h,037h,003h,003h,037h,003h	; bd59  ..7..7..7..7..7.
	defb 003h,037h,003h,003h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bd69  .7...........

; ----------------------------------------------------------------------
; DATOS dibujo_car_BD76: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (31 bytes)
;   0xbd76..0xbd95  (31 bytes)
DATA_dibujo_car_BD76:
	defb 002h,030h,098h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,036h,005h,037h	; bd76  .0...........6.7
	defb 003h,037h,003h,037h,003h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bd86  .7.7...........

; ----------------------------------------------------------------------
; DATOS dibujo_car_BD95: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (17 bytes)
;   0xbd95..0xbda6  (17 bytes)
DATA_dibujo_car_BD95:
	defb 001h,030h,090h,002h,002h,002h,002h,002h,002h,036h,037h,004h,004h,004h,004h,004h	; bd95  .0.......67.....
	defb 004h	; bda5

; ----------------------------------------------------------------------
; DATOS dibujo_car_BDA6: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (199 bytes)
;   0xbda6..0xbe6d  (199 bytes)
DATA_dibujo_car_BDA6:
	defb 00eh,030h,050h,00ah,00ah,00ah,00ah,00ah,00ah,02fh,059h,00ah,00ah,00ah,00ah,00ah	; bda6  .0P....../Y.....
	defb 00ah,007h,008h,007h,008h,007h,008h,030h,05ah,007h,008h,007h,008h,007h,008h,007h	; bdb6  .......0Z.......
	defb 008h,007h,008h,007h,008h,030h,05ah,007h,008h,007h,008h,007h,008h,007h,008h,007h	; bdc6  .....0Z.........
	defb 008h,007h,008h,030h,05ah,007h,008h,007h,008h,007h,008h,007h,008h,007h,008h,007h	; bdd6  ...0Z...........
	defb 008h,030h,05ah,007h,008h,007h,008h,007h,008h,007h,008h,007h,008h,007h,008h,030h	; bde6  .0Z............0
	defb 05ah,007h,008h,007h,008h,007h,008h,007h,008h,007h,008h,007h,008h,031h,05bh,007h	; bdf6  Z............1[.
	defb 008h,007h,008h,007h,008h,007h,008h,007h,008h,007h,008h,030h,05ah,007h,008h,007h	; be06  ...........0Z...
	defb 008h,007h,008h,00ah,00ah,00ah,00ah,00ah,00ah,02fh,059h,00ah,00ah,00ah,00ah,00ah	; be16  ........./Y.....
	defb 00ah,00bh,00bh,00bh,00bh,00bh,00bh,00ch,00dh,00bh,00bh,00bh,00bh,00bh,00bh,00bh	; be26  ................
	defb 00bh,00bh,00bh,00bh,00bh,00ch,00dh,00bh,00bh,00bh,00bh,00bh,00bh,00bh,00bh,00bh	; be36  ................
	defb 00bh,00bh,00bh,00ch,00dh,00bh,00bh,00bh,00bh,00bh,00bh,00bh,00bh,00bh,00bh,00bh	; be46  ................
	defb 00bh,00ch,00dh,00bh,00bh,00bh,00bh,00bh,00bh,00ah,00ah,00ah,00ah,00ah,00ah,02fh	; be56  .............../
	defb 059h,00ah,00ah,00ah,00ah,00ah,00ah	; be66

; ----------------------------------------------------------------------
; DATOS dibujo_car_BE6D: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (115 bytes)
;   0xbe6d..0xbee0  (115 bytes)
DATA_dibujo_car_BE6D:
	defb 008h,030h,068h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h	; be6d  .0h.............
	defb 002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,009h,009h,009h,028h,052h	; be7d  ..............(R
	defb 009h,009h,009h,029h,029h,029h,02ah,054h,053h,053h,053h,029h,029h,029h,02ah,054h	; be8d  ...)))*TSSS)))*T
	defb 053h,053h,053h,029h,029h,029h,02ah,054h,053h,053h,053h,029h,029h,029h,02ah,054h	; be9d  SSS)))*TSSS)))*T
	defb 053h,053h,053h,02bh,02bh,02bh,02ch,056h,055h,055h,055h,038h,038h,038h,039h,063h	; bead  SSS+++,VUUU8889c
	defb 062h,062h,062h,02dh,02dh,02dh,02eh,058h,057h,057h,057h,004h,004h,004h,004h,004h	; bebd  bbb---.XWWW.....
	defb 004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; becd  ................
	defb 004h,004h,004h	; bedd

; ----------------------------------------------------------------------
; DATOS dibujo_car_BEE0: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (59 bytes)
;   0xbee0..0xbf1b  (59 bytes)
DATA_dibujo_car_BEE0:
	defb 004h,030h,078h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h	; bee0  .0x.............
	defb 002h,002h,002h,002h,002h,002h,002h,024h,024h,04eh,04eh,025h,025h,04fh,04fh,026h	; bef0  .......$$NN%%OO&
	defb 026h,050h,050h,027h,03ah,064h,051h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bf00  &PP':dQ.........
	defb 004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bf10  ...........

; ----------------------------------------------------------------------
; DATOS dibujo_car_BF1B: [ancho][posicion] y 14 filas de 'ancho' caracteres
;   (nibbles: fila y columna en la hoja de caracteres) que p02:9A19 pinta de 8
;   en 8; lo leen p02:9A0E (31 bytes)
;   0xbf1b..0xbf3a  (31 bytes)
DATA_dibujo_car_BF1B:
	defb 002h,030h,080h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,022h	; bf1b  .0............."
	defb 04ch,023h,04dh,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; bf2b  L#M............

; ----------------------------------------------------------------------
; DATOS relleno_09: 198 bytes 0xFF hasta el final del banco: relleno, no lo
;   lee nadie (198 bytes)
;   0xbf3a..0xc000  (198 bytes)
DATA_relleno_09:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfaa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bffa
