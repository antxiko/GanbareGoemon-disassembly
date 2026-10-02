; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX2 - MegaROM RC-748 de 128 KB (Konami4) - banco 15 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS rle_9F76_cola: rle a la VRAM (0x4539) (sigue del banco anterior,
;   0x9F76); lo leen p00:5402 (43 bytes)
;   0xa000..0xa02b  (43 bytes)
DATA_rle_9F76_cola:
	defb 000h,018h,03ch,03ch,018h,000h,07fh,00eh,0ffh,082h,07fh,0feh,00eh,0ffh,082h,0feh	; a000  ..<<............
	defb 0f0h,003h,080h,008h,000h,003h,080h,082h,0f0h,00fh,003h,001h,008h,000h,003h,001h	; a010  ................
	defb 081h,00fh,00fh,000h,081h,0ffh,00fh,000h,081h,0ffh,000h	; a020  ...........

; ----------------------------------------------------------------------
; DATOS piezas: 9 punteros a las piezas de decorado que p02:9132 pinta (el
;   numero es el nibble bajo del tercer byte de cada cosa de 0xA08E); lo leen
;   p02:9132 (18 bytes)
;   0xa02b..0xa03d  (18 bytes)
DATA_piezas:
	defb 03dh,0a0h,042h,0a0h,047h,0a0h,04ch,0a0h,051h,0a0h,064h,0a0h,077h,0a0h,08ah,0a0h	; a02b  =.B.G.L.Q.d.w...
	defb 08ch,0a0h	; a03b

; ----------------------------------------------------------------------
; DATOS pieza_0: pieza 0: [x][y] del bloque de 16x16 en la hoja de la VRAM (y
;   0xFF, ninguna) y parejas [dx][dy] donde pintarlo con p00:4E84; 0xFF acaba;
;   lo leen p02:9139 (5 bytes)
;   0xa03d..0xa042  (5 bytes)
DATA_pieza_0:
	defb 080h,010h,000h,000h,0ffh	; a03d

; ----------------------------------------------------------------------
; DATOS pieza_1: pieza 1: [x][y] del bloque de 16x16 en la hoja de la VRAM (y
;   0xFF, ninguna) y parejas [dx][dy] donde pintarlo con p00:4E84; 0xFF acaba;
;   lo leen p02:9139 (5 bytes)
;   0xa042..0xa047  (5 bytes)
DATA_pieza_1:
	defb 080h,020h,000h,000h,0ffh	; a042

; ----------------------------------------------------------------------
; DATOS pieza_2: pieza 2: [x][y] del bloque de 16x16 en la hoja de la VRAM (y
;   0xFF, ninguna) y parejas [dx][dy] donde pintarlo con p00:4E84; 0xFF acaba;
;   lo leen p02:9139 (5 bytes)
;   0xa047..0xa04c  (5 bytes)
DATA_pieza_2:
	defb 080h,000h,000h,000h,0ffh	; a047

; ----------------------------------------------------------------------
; DATOS pieza_3: pieza 3: [x][y] del bloque de 16x16 en la hoja de la VRAM (y
;   0xFF, ninguna) y parejas [dx][dy] donde pintarlo con p00:4E84; 0xFF acaba;
;   lo leen p02:9139 (5 bytes)
;   0xa04c..0xa051  (5 bytes)
DATA_pieza_3:
	defb 080h,030h,000h,000h,0ffh	; a04c

; ----------------------------------------------------------------------
; DATOS pieza_4: pieza 4: [x][y] del bloque de 16x16 en la hoja de la VRAM (y
;   0xFF, ninguna) y parejas [dx][dy] donde pintarlo con p00:4E84; 0xFF acaba;
;   lo leen p02:9139 (19 bytes)
;   0xa051..0xa064  (19 bytes)
DATA_pieza_4:
	defb 080h,030h,000h,000h,000h,010h,000h,020h,000h,030h,010h,000h,010h,010h,010h,020h	; a051  .0..... .0.....
	defb 010h,030h,0ffh	; a061

; ----------------------------------------------------------------------
; DATOS pieza_5: pieza 5: [x][y] del bloque de 16x16 en la hoja de la VRAM (y
;   0xFF, ninguna) y parejas [dx][dy] donde pintarlo con p00:4E84; 0xFF acaba;
;   lo leen p02:9139 (19 bytes)
;   0xa064..0xa077  (19 bytes)
DATA_pieza_5:
	defb 080h,030h,000h,000h,000h,010h,010h,000h,010h,010h,020h,000h,020h,010h,030h,000h	; a064  .0........ . .0.
	defb 030h,010h,0ffh	; a074

; ----------------------------------------------------------------------
; DATOS pieza_6: pieza 6: [x][y] del bloque de 16x16 en la hoja de la VRAM (y
;   0xFF, ninguna) y parejas [dx][dy] donde pintarlo con p00:4E84; 0xFF acaba;
;   lo leen p02:9139 (19 bytes)
;   0xa077..0xa08a  (19 bytes)
DATA_pieza_6:
	defb 080h,030h,000h,000h,000h,010h,000h,020h,000h,030h,000h,040h,000h,050h,000h,060h	; a077  .0..... .0.@.P.`
	defb 000h,070h,0ffh	; a087

; ----------------------------------------------------------------------
; DATOS pieza_7: pieza 7: [x][y] del bloque de 16x16 en la hoja de la VRAM (y
;   0xFF, ninguna) y parejas [dx][dy] donde pintarlo con p00:4E84; 0xFF acaba;
;   lo leen p02:9139 (2 bytes)
;   0xa08a..0xa08c  (2 bytes)
DATA_pieza_7:
	defb 0ffh,0ffh	; a08a

; ----------------------------------------------------------------------
; DATOS pieza_8: pieza 8: [x][y] del bloque de 16x16 en la hoja de la VRAM (y
;   0xFF, ninguna) y parejas [dx][dy] donde pintarlo con p00:4E84; 0xFF acaba;
;   lo leen p02:9139 (2 bytes)
;   0xa08c..0xa08e  (2 bytes)
DATA_pieza_8:
	defb 0ffh,0ffh	; a08c

; ----------------------------------------------------------------------
; DATOS cosas_fijas_de_cada_zona: 49 punteros, uno por zona, a las cosas fijas
;   de sus casillas (p02:90E5); lo leen p02:90D5 (98 bytes)
;   0xa08e..0xa0f0  (98 bytes)
DATA_cosas_fijas_de_cada_zona:
	defb 0f0h,0a0h,073h,0a1h,0abh,0a1h,0d4h,0a1h,033h,0a2h,07dh,0a2h,0c7h,0a2h,002h,0a3h	; a08e  ..s.....3.}.....
	defb 067h,0a3h,0aeh,0a3h,028h,0a4h,05dh,0a4h,0d4h,0a4h,045h,0a5h,06bh,0a5h,003h,0a6h	; a09e  g...(.]...E.k...
	defb 04dh,0a6h,0b5h,0a6h,0ffh,0a6h,091h,0a7h,017h,0a8h,040h,0a8h,0cch,0a8h,03ah,0a9h	; a0ae  M.........@...:.
	defb 07bh,0a9h,016h,0aah,0b1h,0aah,0fbh,0aah,01eh,0abh,0adh,0abh,057h,0ach,098h,0ach	; a0be  {...........W...
	defb 0c1h,0ach,023h,0adh,097h,0adh,0d5h,0adh,01fh,0aeh,0c6h,0aeh,046h,0afh,078h,0afh	; a0ce  ..#.........F.x.
	defb 00dh,0b0h,066h,0b0h,08fh,0b0h,0e5h,0b0h,032h,0b1h,070h,0b1h,023h,0b2h,097h,0b2h	; a0de  ..f.....2.p.#...
	defb 03bh,0b3h	; a0ee

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A0F0: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   1-0 (131 bytes)
;   0xa0f0..0xa173  (131 bytes)
DATA_cosas_fijas_A0F0:
	defb 02bh,000h,070h,0a5h,001h,081h,050h,001h,070h,075h,001h,084h,0a1h,001h,080h,0c5h	; a0f0  +.p...P.pu......
	defb 002h,060h,025h,002h,0a2h,050h,003h,070h,035h,003h,0a4h,091h,004h,080h,025h,004h	; a100  .`%..P.p5.....%.
	defb 080h,044h,004h,071h,090h,005h,080h,024h,005h,060h,065h,005h,076h,0c7h,008h,082h	; a110  .D.q...$.`e.v...
	defb 030h,008h,080h,084h,009h,080h,046h,009h,080h,0c5h,00ah,096h,047h,00dh,096h,067h	; a120  0.....F.....G..g
	defb 00dh,070h,0a5h,00eh,0a4h,051h,00eh,084h,061h,00eh,060h,075h,00fh,080h,015h,00fh	; a130  .p...Q..a.`u....
	defb 0a2h,040h,00fh,060h,0a5h,010h,090h,046h,011h,071h,040h,012h,076h,067h,012h,060h	; a140  .@.`...F.q@.vg.`
	defb 095h,012h,0a0h,066h,013h,091h,080h,015h,084h,031h,015h,094h,051h,015h,0a4h,071h	; a150  ...f.....1..Q..q
	defb 015h,070h,074h,015h,070h,0b5h,016h,082h,020h,016h,080h,046h,016h,080h,0c5h,017h	; a160  .pt.p... ..F....
	defb 076h,0a7h,0ffh	; a170

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A173: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   1-1 (56 bytes)
;   0xa173..0xa1ab  (56 bytes)
DATA_cosas_fijas_A173:
	defb 012h,001h,081h,040h,001h,0a2h,040h,001h,096h,0b7h,002h,076h,067h,003h,072h,050h	; a173  ...@..@....vg.rP
	defb 003h,084h,0b1h,003h,084h,0c1h,004h,071h,0c0h,005h,076h,0e7h,007h,0b6h,077h,008h	; a183  .......q..v...w.
	defb 076h,077h,008h,074h,0c1h,009h,0a6h,077h,00ah,084h,021h,00ah,074h,031h,00bh,076h	; a193  vw.t...w..!.t1.v
	defb 067h,00bh,082h,080h,00ch,096h,0a7h,0ffh	; a1a3  g.......

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A1AB: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   1-2 (41 bytes)
;   0xa1ab..0xa1d4  (41 bytes)
DATA_cosas_fijas_A1AB:
	defb 00dh,000h,092h,080h,001h,094h,031h,001h,092h,060h,001h,0a6h,097h,003h,0b6h,047h	; a1ab  ......1..`.....G
	defb 004h,0a6h,0b7h,007h,074h,031h,007h,074h,061h,007h,084h,081h,009h,066h,087h,00bh	; a1bb  ....t1.ta....f..
	defb 091h,040h,00ch,074h,0b1h,00dh,076h,027h,0ffh	; a1cb  .@.t..v'.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A1D4: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   1-3 (95 bytes)
;   0xa1d4..0xa233  (95 bytes)
DATA_cosas_fijas_A1D4:
	defb 01fh,000h,086h,087h,001h,060h,094h,001h,082h,0b0h,002h,084h,051h,002h,074h,061h	; a1d4  .....`......Q.ta
	defb 002h,070h,094h,002h,0a6h,097h,004h,071h,070h,005h,074h,081h,005h,090h,066h,006h	; a1e4  .p.....qp.t...f.
	defb 081h,0c0h,007h,084h,041h,007h,094h,051h,007h,0a4h,061h,007h,076h,097h,008h,0a6h	; a1f4  ....A..Q..a.v...
	defb 0a7h,009h,060h,085h,00ah,070h,036h,00ah,092h,030h,00bh,084h,031h,00bh,076h,097h	; a204  ..`..p6..0..1.v.
	defb 00dh,094h,031h,00dh,094h,051h,00dh,094h,071h,00dh,076h,0e7h,00fh,060h,045h,00fh	; a214  ..1..Q..q.v..`E.
	defb 080h,065h,011h,080h,056h,011h,0a1h,070h,012h,090h,056h,012h,076h,0e7h,0ffh	; a224  .e..V..p..V.v..

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A233: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   1-4 (74 bytes)
;   0xa233..0xa27d  (74 bytes)
DATA_cosas_fijas_A233:
	defb 018h,001h,082h,040h,002h,081h,070h,004h,076h,027h,005h,084h,081h,005h,094h,0a1h	; a233  ...@..p.v'......
	defb 005h,084h,0c1h,007h,084h,061h,007h,094h,071h,007h,0a4h,081h,008h,076h,077h,009h	; a243  .....a..q....vw.
	defb 082h,060h,00bh,076h,0e7h,00dh,074h,041h,00dh,084h,051h,00dh,094h,061h,010h,094h	; a253  .`.v..tA..Q..a..
	defb 091h,010h,084h,0a1h,010h,074h,0b1h,013h,076h,017h,013h,081h,0a0h,014h,076h,0a7h	; a263  .....t..v.....v.
	defb 014h,091h,0b0h,016h,074h,021h,018h,066h,077h,0ffh	; a273  ....t!.fw.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A27D: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   1-5 (74 bytes)
;   0xa27d..0xa2c7  (74 bytes)
DATA_cosas_fijas_A27D:
	defb 018h,003h,0a6h,037h,004h,080h,064h,004h,0a0h,0a4h,005h,092h,060h,007h,0a6h,037h	; a27d  ...7..d.....`..7
	defb 00bh,096h,097h,00dh,086h,0c7h,00fh,090h,046h,00fh,0a0h,084h,013h,081h,070h,013h	; a28d  ........F.....p.
	defb 092h,070h,015h,086h,067h,017h,082h,070h,018h,096h,097h,01ah,096h,0b7h,01fh,091h	; a29d  .p..g..p........
	defb 030h,01fh,0c0h,016h,01fh,080h,095h,01fh,080h,0b5h,022h,0a0h,044h,023h,096h,047h	; a2ad  0.........".D#.G
	defb 023h,0a0h,036h,023h,080h,0b5h,024h,0b6h,067h,0ffh	; a2bd  #.6#..$.g.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A2C7: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   1-6 (59 bytes)
;   0xa2c7..0xa302  (59 bytes)
DATA_cosas_fijas_A2C7:
	defb 013h,000h,096h,047h,006h,084h,061h,006h,094h,071h,006h,0a4h,081h,00bh,096h,057h	; a2c7  ...G..a..q.....W
	defb 00dh,074h,051h,00dh,084h,071h,00dh,094h,091h,01ah,076h,027h,01bh,096h,0c7h,020h	; a2d7  .tQ..q....v'...
	defb 096h,077h,024h,076h,0c7h,02dh,082h,070h,031h,076h,0b7h,032h,0a6h,027h,033h,081h	; a2e7  .w$v.-.p1v.2.'3.
	defb 050h,03ah,071h,070h,03ch,076h,0a7h,03fh,072h,060h,0ffh	; a2f7  P:qp<v.?r`.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A302: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   2-0 (101 bytes)
;   0xa302..0xa367  (101 bytes)
DATA_cosas_fijas_A302:
	defb 021h,000h,060h,075h,000h,090h,094h,001h,0a2h,020h,001h,060h,055h,001h,070h,0a5h	; a302  !.`u..... .`U.p.
	defb 002h,090h,046h,002h,0b1h,070h,002h,074h,0b1h,002h,094h,0d1h,003h,060h,085h,003h	; a312  ..F..p.t.....`..
	defb 0a0h,094h,003h,071h,0c0h,004h,094h,081h,004h,084h,0a1h,005h,096h,027h,005h,060h	; a322  ...q.........'.`
	defb 075h,005h,090h,094h,006h,080h,045h,006h,092h,080h,006h,0b4h,091h,008h,092h,090h	; a332  u.....E.........
	defb 009h,076h,057h,009h,070h,0a5h,00ch,080h,045h,00ch,060h,0a5h,00ch,0a4h,0c1h,00ch	; a342  .vW.p...E.`.....
	defb 094h,0d1h,00dh,084h,031h,00dh,060h,065h,00dh,0a0h,046h,00dh,086h,0c7h,00eh,060h	; a352  ....1.`e..F....`
	defb 085h,00eh,090h,0a4h,0ffh	; a362

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A367: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   2-1 (71 bytes)
;   0xa367..0xa3ae  (71 bytes)
DATA_cosas_fijas_A367:
	defb 017h,001h,082h,070h,002h,094h,041h,003h,086h,0c7h,004h,0a1h,050h,004h,086h,0c7h	; a367  ...p..A.....P...
	defb 006h,0b6h,057h,007h,0b1h,0c0h,008h,084h,081h,008h,094h,091h,008h,0a4h,0a1h,009h	; a377  ..W.............
	defb 076h,0b7h,00ah,076h,027h,00ah,094h,051h,00ah,084h,061h,00ah,074h,071h,00bh,0a6h	; a387  v..v'..Q..a.tq..
	defb 047h,00eh,096h,0a7h,00fh,076h,0b7h,010h,056h,0c7h,011h,092h,050h,011h,0a6h,0b7h	; a397  G....v..V...P...
	defb 012h,074h,031h,012h,084h,041h,0ffh	; a3a7

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A3AE: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   2-2 (122 bytes)
;   0xa3ae..0xa428  (122 bytes)
DATA_cosas_fijas_A3AE:
	defb 028h,000h,0a6h,057h,001h,080h,044h,001h,084h,0a1h,002h,074h,081h,002h,084h,0a1h	; a3ae  (..W..D....t....
	defb 002h,090h,046h,003h,076h,027h,003h,071h,060h,003h,060h,095h,004h,084h,051h,004h	; a3be  ..F.v'.q`.`...Q.
	defb 094h,061h,004h,0a4h,071h,004h,0a6h,0d7h,006h,084h,0d1h,007h,072h,060h,008h,060h	; a3ce  .a..q.......r`.`
	defb 065h,008h,090h,084h,009h,090h,034h,009h,090h,074h,00ch,0a6h,057h,00dh,080h,056h	; a3de  e.....4..t..W..V
	defb 00dh,0b0h,056h,00dh,091h,080h,00fh,074h,021h,00fh,094h,041h,00fh,0a4h,061h,010h	; a3ee  ..V....t!..A..a.
	defb 0a6h,047h,011h,072h,0a0h,011h,090h,056h,012h,076h,0b7h,013h,080h,046h,013h,0a0h	; a3fe  .G.r...V.v...F..
	defb 046h,014h,084h,071h,014h,084h,081h,014h,084h,0a1h,015h,0a6h,027h,015h,060h,085h	; a40e  F..q........'.`.
	defb 015h,080h,0a5h,016h,081h,090h,017h,0b6h,0b7h,0ffh	; a41e  ..........

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A428: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   2-3 (53 bytes)
;   0xa428..0xa45d  (53 bytes)
DATA_cosas_fijas_A428:
	defb 011h,001h,082h,060h,002h,0b4h,041h,002h,0b4h,051h,003h,086h,057h,005h,094h,041h	; a428  ...`..A..Q..W..A
	defb 006h,071h,080h,007h,0b4h,021h,00ah,096h,0c7h,00bh,096h,087h,00ch,0b4h,021h,00ch	; a438  .q...!........!.
	defb 0b4h,031h,00dh,081h,050h,00eh,0a6h,0c7h,00fh,086h,067h,010h,096h,0d7h,011h,0a4h	; a448  .1..P.....g.....
	defb 041h,011h,0a4h,081h,0ffh	; a458

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A45D: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   2-4 (119 bytes)
;   0xa45d..0xa4d4  (119 bytes)
DATA_cosas_fijas_A45D:
	defb 027h,001h,082h,030h,001h,0a6h,087h,002h,084h,031h,002h,060h,055h,002h,090h,074h	; a45d  '..0.....1.`U..t
	defb 003h,076h,027h,003h,090h,056h,003h,081h,060h,003h,0a0h,094h,004h,060h,065h,004h	; a46d  .v'..V..`....`e.
	defb 080h,085h,005h,076h,027h,005h,0a4h,051h,005h,070h,066h,005h,0a1h,080h,006h,0a6h	; a47d  ...v'..Q.pf.....
	defb 087h,007h,070h,075h,007h,0b0h,046h,007h,082h,0a0h,00bh,076h,017h,00bh,080h,064h	; a48d  ..pu..F....v...d
	defb 00ch,090h,026h,00ch,072h,070h,00ch,090h,0a4h,00dh,080h,045h,00dh,080h,066h,00dh	; a49d  ..&.rp.....E..f.
	defb 096h,077h,00dh,0a4h,0a1h,00fh,076h,017h,00fh,080h,044h,00fh,060h,085h,010h,096h	; a4ad  .w....v...D.`...
	defb 077h,011h,060h,035h,011h,0a0h,046h,011h,081h,070h,012h,0a0h,016h,012h,080h,056h	; a4bd  w.`5..F..p.....V
	defb 012h,0a4h,0b1h,012h,0a4h,0d1h,0ffh	; a4cd

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A4D4: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   2-5 (113 bytes)
;   0xa4d4..0xa545  (113 bytes)
DATA_cosas_fijas_A4D4:
	defb 025h,001h,0a6h,0d7h,004h,0a2h,040h,006h,096h,0c7h,007h,094h,041h,007h,0a4h,051h	; a4d4  %.....@.....A..Q
	defb 007h,094h,081h,007h,0a4h,091h,008h,086h,057h,009h,071h,040h,00ah,076h,037h,00ah	; a4e4  ........W.q@.v7.
	defb 080h,036h,00bh,0a6h,067h,00dh,080h,046h,00eh,060h,085h,00eh,0a0h,094h,011h,080h	; a4f4  .6..g..F.`......
	defb 084h,012h,090h,084h,013h,072h,030h,014h,081h,070h,015h,074h,061h,015h,084h,061h	; a504  .....r0..p.ta..a
	defb 015h,094h,061h,018h,090h,046h,01bh,081h,080h,01ch,090h,046h,01eh,0a0h,044h,01eh	; a514  ..a..F.....F..D.
	defb 086h,087h,01fh,084h,041h,01fh,094h,051h,01fh,0a4h,061h,020h,086h,0c7h,021h,080h	; a524  ....A..Q..a ..!.
	defb 084h,023h,090h,056h,024h,0a4h,021h,024h,094h,041h,024h,082h,060h,025h,086h,087h	; a534  .#.V$.!$.A$.`%..
	defb 0ffh	; a544

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A545: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   2-6 (38 bytes)
;   0xa545..0xa56b  (38 bytes)
DATA_cosas_fijas_A545:
	defb 00ch,002h,076h,047h,006h,076h,0d7h,009h,0a6h,017h,01bh,076h,0c7h,01ch,0a6h,0c7h	; a545  ..vG.v.....v....
	defb 01eh,076h,0b7h,02eh,076h,0e7h,02fh,076h,0d7h,034h,076h,0b7h,039h,086h,027h,03ch	; a555  .v..v./v.4v.9.'<
	defb 0a1h,090h,045h,082h,090h,0ffh	; a565

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A56B: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   3-0 (152 bytes)
;   0xa56b..0xa603  (152 bytes)
DATA_cosas_fijas_A56B:
	defb 032h,000h,082h,0a0h,001h,090h,036h,001h,080h,066h,002h,060h,045h,002h,080h,066h	; a56b  2.....6..f.`E..f
	defb 002h,074h,091h,002h,074h,0c1h,004h,080h,034h,004h,092h,090h,005h,086h,027h,005h	; a57b  .t..t...4.....'.
	defb 090h,026h,008h,060h,085h,008h,0a0h,066h,008h,081h,0d0h,009h,0a0h,026h,009h,090h	; a58b  .&.`...f.....&..
	defb 0a4h,009h,086h,0d7h,00ah,090h,024h,00ah,0a0h,066h,00dh,060h,075h,00dh,082h,050h	; a59b  ......$..f.`u..P
	defb 00dh,0a0h,066h,00dh,086h,0b7h,00fh,060h,045h,00fh,080h,085h,00fh,060h,0a5h,010h	; a5ab  ..f....`E....`..
	defb 070h,026h,010h,091h,040h,010h,080h,095h,012h,086h,057h,013h,080h,065h,013h,081h	; a5bb  p&..@.....W..e..
	defb 090h,013h,060h,0c5h,016h,076h,0c7h,018h,070h,024h,018h,0a4h,031h,018h,070h,065h	; a5cb  ..`..v..p$..1.pe
	defb 018h,090h,084h,018h,074h,091h,019h,086h,017h,01ah,090h,056h,01ch,090h,024h,01ch	; a5db  ....t......V..$.
	defb 082h,070h,01ch,090h,094h,01ch,086h,0c7h,01fh,070h,046h,01fh,091h,070h,01fh,0a0h	; a5eb  .p.......pF..p..
	defb 046h,021h,080h,046h,021h,0a0h,046h,0ffh	; a5fb  F!.F!.F.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A603: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   3-1 (74 bytes)
;   0xa603..0xa64d  (74 bytes)
DATA_cosas_fijas_A603:
	defb 018h,000h,072h,0b0h,002h,071h,0c0h,003h,082h,0b0h,004h,086h,047h,005h,084h,051h	; a603  ..r..q......G..Q
	defb 005h,094h,061h,006h,094h,0b1h,006h,084h,0c1h,006h,074h,0d1h,008h,074h,031h,008h	; a613  ..a.......t..t1.
	defb 084h,041h,008h,094h,051h,009h,076h,0a7h,009h,092h,0c0h,00ah,076h,0e7h,00bh,071h	; a623  .A..Q.v.....v..q
	defb 060h,00bh,084h,081h,00bh,094h,0a1h,00bh,0a4h,0c1h,00ch,076h,0d7h,00eh,076h,047h	; a633  `..........v..vG
	defb 00fh,074h,031h,00fh,084h,051h,00fh,086h,0a7h,0ffh	; a643  .t1..Q....

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A64D: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   3-2 (104 bytes)
;   0xa64d..0xa6b5  (104 bytes)
DATA_cosas_fijas_A64D:
	defb 022h,000h,086h,0c7h,001h,070h,034h,001h,090h,084h,001h,0a2h,050h,001h,071h,090h	; a64d  "....p4.....P.q.
	defb 002h,090h,044h,002h,070h,084h,002h,074h,061h,002h,0a4h,091h,004h,074h,051h,004h	; a65d  ..D.p..ta....tQ.
	defb 080h,075h,004h,060h,095h,006h,080h,066h,007h,082h,030h,008h,070h,036h,008h,086h	; a66d  .u.`...f..0.p6..
	defb 097h,00ah,086h,0c7h,00bh,076h,037h,00bh,060h,055h,00bh,090h,074h,00bh,071h,080h	; a67d  .....v7.`U..t.q.
	defb 00ch,080h,046h,00ch,0b0h,046h,00ch,0a4h,071h,00ch,076h,0d7h,00dh,076h,087h,00eh	; a68d  ..F..F..q.v..v..
	defb 080h,056h,00eh,0a0h,056h,00eh,074h,091h,00fh,082h,050h,00fh,0b6h,067h,010h,090h	; a69d  .V..V.t...P..g..
	defb 044h,010h,060h,085h,010h,081h,0c0h,0ffh	; a6ad  D.`.....

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A6B5: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   3-3 (74 bytes)
;   0xa6b5..0xa6ff  (74 bytes)
DATA_cosas_fijas_A6B5:
	defb 018h,000h,066h,077h,001h,066h,077h,001h,064h,0a1h,001h,0c4h,051h,002h,096h,0d7h	; a6b5  ..fw.fw.d...Q...
	defb 003h,091h,060h,004h,096h,027h,005h,0a4h,061h,005h,0a4h,081h,007h,086h,057h,008h	; a6c5  ..`..'..a.....W.
	defb 094h,021h,008h,0a4h,031h,008h,0a1h,050h,008h,0b4h,041h,009h,070h,034h,00ah,0a4h	; a6d5  .!..1..P..A.p4..
	defb 041h,00ah,066h,0c7h,00bh,0b6h,0b7h,00ch,096h,087h,00eh,072h,0a0h,00fh,096h,077h	; a6e5  A.f........r...w
	defb 010h,094h,031h,010h,060h,065h,010h,0a0h,074h,0ffh	; a6f5  ..1.`e..t.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A6FF: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   3-4 (146 bytes)
;   0xa6ff..0xa791  (146 bytes)
DATA_cosas_fijas_A6FF:
	defb 030h,001h,091h,040h,001h,060h,0a5h,002h,094h,021h,002h,084h,031h,002h,074h,041h	; a6ff  0..@.`...!..1.tA
	defb 002h,0a6h,067h,003h,072h,040h,003h,080h,0b5h,004h,084h,021h,004h,094h,031h,004h	; a70f  ..g.r@.....!..1.
	defb 0a4h,041h,004h,080h,084h,005h,0a6h,0b7h,006h,070h,036h,006h,082h,050h,007h,082h	; a71f  .A.......p6..P..
	defb 020h,007h,070h,085h,007h,0a4h,0b1h,007h,084h,0c1h,008h,076h,097h,009h,070h,026h	; a72f   .p........v..p&
	defb 009h,080h,0a4h,00ah,080h,044h,00ah,084h,0b1h,00ah,074h,0c1h,00dh,080h,066h,00dh	; a73f  .....D....t...f.
	defb 0a0h,066h,00eh,080h,064h,00eh,060h,0a5h,00fh,074h,011h,00fh,084h,021h,00fh,094h	; a74f  .f..d.`..t...!..
	defb 031h,00fh,081h,0a0h,010h,076h,027h,010h,0a0h,036h,010h,070h,066h,011h,094h,0c1h	; a75f  1....v'..6.pf...
	defb 011h,084h,0d1h,011h,074h,0e1h,012h,081h,040h,012h,060h,085h,012h,0a0h,0a4h,014h	; a76f  ....t...@.`.....
	defb 070h,056h,014h,0a4h,0a1h,014h,094h,0b1h,014h,084h,0c1h,015h,060h,035h,015h,080h	; a77f  pV..........`5..
	defb 054h,0ffh	; a78f

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A791: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   3-5 (134 bytes)
;   0xa791..0xa817  (134 bytes)
DATA_cosas_fijas_A791:
	defb 02ch,002h,094h,041h,002h,0a4h,061h,003h,090h,056h,004h,0a0h,036h,006h,090h,044h	; a791  ,..A..a..V..6..D
	defb 007h,096h,097h,00ah,0a6h,027h,00bh,092h,070h,00dh,081h,050h,00eh,080h,046h,00fh	; a7a1  .....'..p..P..F.
	defb 076h,027h,010h,072h,050h,010h,090h,0a4h,011h,084h,031h,011h,094h,041h,011h,0a4h	; a7b1  v'.rP.....1..A..
	defb 051h,011h,060h,095h,013h,086h,097h,015h,0a0h,056h,015h,076h,0a7h,015h,060h,0b5h	; a7c1  Q.`......V.v..`.
	defb 016h,060h,075h,016h,090h,094h,017h,081h,030h,01ah,090h,026h,01ah,060h,0a5h,01ch	; a7d1  .`u.....0..&.`..
	defb 090h,084h,01dh,080h,044h,01dh,0a0h,084h,01fh,074h,021h,01fh,094h,021h,01fh,0a4h	; a7e1  ....D....t!..!..
	defb 041h,021h,090h,044h,021h,0a2h,0c0h,022h,0b0h,026h,022h,096h,0c7h,024h,096h,0c7h	; a7f1  A!.D!..".&"..$..
	defb 025h,0b6h,037h,025h,0b4h,071h,025h,0a4h,091h,025h,094h,0b1h,027h,0a0h,064h,028h	; a801  %.7%.q%..%..'.d(
	defb 090h,044h,02ah,096h,0a7h,0ffh	; a811

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A817: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   3-6 (41 bytes)
;   0xa817..0xa840  (41 bytes)
DATA_cosas_fijas_A817:
	defb 00dh,007h,076h,0a7h,00dh,0a6h,0d7h,015h,076h,0a7h,019h,076h,0a7h,01dh,0a6h,097h	; a817  ..v.....v..v....
	defb 021h,0a6h,0b7h,024h,076h,0b7h,039h,086h,037h,03ch,076h,0d7h,042h,071h,060h,042h	; a827  !..$v.9.7<v.Bq`B
	defb 086h,0e7h,049h,082h,090h,04bh,060h,085h,0ffh	; a837  ..I..K`..

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A840: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   4-0 (140 bytes)
;   0xa840..0xa8cc  (140 bytes)
DATA_cosas_fijas_A840:
	defb 02eh,000h,076h,067h,001h,060h,035h,001h,071h,090h,002h,0a0h,044h,002h,060h,085h	; a840  ..vg.`5.q...D.`.
	defb 003h,0a6h,037h,004h,094h,091h,004h,074h,0a1h,005h,070h,036h,006h,074h,041h,006h	; a850  ..7....t..p6.tA.
	defb 084h,061h,006h,094h,081h,006h,0a4h,0a1h,007h,0a6h,027h,007h,080h,045h,007h,080h	; a860  .a........'..E..
	defb 066h,007h,0a4h,091h,007h,0a4h,0c1h,008h,084h,091h,008h,074h,0b1h,009h,080h,024h	; a870  f..........t...$
	defb 00ah,076h,087h,00bh,094h,021h,00bh,090h,046h,00bh,060h,0c5h,00ch,081h,070h,00dh	; a880  .v...!..F.`...p.
	defb 076h,027h,00eh,070h,066h,00eh,0a0h,066h,00fh,072h,020h,010h,084h,021h,010h,080h	; a890  v'.pf..f.r ..!..
	defb 054h,010h,060h,095h,011h,072h,040h,011h,0a6h,0b7h,012h,0a6h,0d7h,013h,0a4h,031h	; a8a0  T.`..r@........1
	defb 013h,082h,080h,015h,076h,047h,016h,076h,087h,017h,090h,024h,017h,080h,064h,017h	; a8b0  ....vG.v...$..d.
	defb 0a0h,0a4h,018h,081h,050h,019h,060h,044h,019h,080h,084h,0ffh	; a8c0  ....P.`D....

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A8CC: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   4-1 (110 bytes)
;   0xa8cc..0xa93a  (110 bytes)
DATA_cosas_fijas_A8CC:
	defb 024h,000h,066h,067h,000h,080h,066h,000h,0a0h,046h,001h,080h,036h,001h,0a2h,0c0h	; a8cc  $.fg..f..F..6...
	defb 002h,080h,026h,002h,0a1h,070h,003h,060h,035h,003h,090h,056h,004h,074h,021h,004h	; a8dc  ..&..p.`5..V.t!.
	defb 060h,055h,004h,080h,075h,004h,094h,0b1h,004h,0a4h,0c1h,005h,066h,077h,005h,080h	; a8ec  `U..u.......fw..
	defb 026h,005h,0b0h,046h,006h,090h,056h,006h,076h,0c7h,007h,060h,025h,007h,080h,065h	; a8fc  &..F..V.v..`%..e
	defb 007h,076h,087h,007h,060h,0a5h,00ah,076h,0c7h,00bh,070h,035h,00bh,091h,070h,00bh	; a90c  .v..`..v..p5..p.
	defb 070h,0b5h,00dh,070h,035h,00dh,090h,054h,00dh,074h,061h,00dh,094h,0a1h,00eh,096h	; a91c  p..p5..T.ta.....
	defb 057h,00eh,060h,074h,00eh,080h,074h,00eh,080h,0b5h,00fh,080h,056h,0ffh	; a92c  W.`t..t.....V.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A93A: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   4-2 (65 bytes)
;   0xa93a..0xa97b  (65 bytes)
DATA_cosas_fijas_A93A:
	defb 015h,001h,0a4h,0b1h,002h,066h,077h,004h,0b6h,087h,005h,074h,0b1h,006h,0a6h,0a7h	; a93a  .....fw....t....
	defb 006h,094h,0c1h,007h,0a6h,0a7h,008h,096h,037h,009h,096h,057h,00bh,0a2h,060h,00ch	; a94a  ........7..W..`.
	defb 084h,011h,00ch,094h,021h,00ch,0a4h,031h,00ch,086h,0a7h,00eh,0a6h,037h,00eh,084h	; a95a  ....!..1.....7..
	defb 0c1h,011h,076h,0c7h,012h,074h,031h,012h,071h,060h,013h,076h,0c7h,014h,064h,091h	; a96a  ..v..t1.q`.v..d.
	defb 0ffh	; a97a

; ----------------------------------------------------------------------
; DATOS cosas_fijas_A97B: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   4-3 (155 bytes)
;   0xa97b..0xaa16  (155 bytes)
DATA_cosas_fijas_A97B:
	defb 033h,000h,0a6h,0a7h,001h,076h,0b7h,002h,0b6h,037h,002h,0a1h,050h,003h,080h,064h	; a97b  3....v...7..P..d
	defb 003h,060h,084h,003h,080h,0a5h,004h,080h,046h,006h,0b4h,0a1h,006h,094h,0b1h,006h	; a98b  .`......F.......
	defb 074h,0c1h,007h,076h,027h,007h,090h,094h,008h,074h,041h,00ah,076h,067h,00ah,0a4h	; a99b  t..v'....tA.vg..
	defb 071h,00ah,094h,091h,00ah,084h,0b1h,00bh,0a6h,0b7h,00ch,070h,075h,00dh,080h,044h	; a9ab  q..........pu..D
	defb 00eh,0a0h,064h,00eh,080h,0a4h,00fh,084h,041h,010h,096h,0b7h,011h,084h,071h,011h	; a9bb  ..d.....A.....q.
	defb 0a4h,071h,011h,081h,0a0h,011h,0b6h,0c7h,012h,060h,075h,013h,060h,024h,013h,060h	; a9cb  .q.......`u.`$.`
	defb 065h,014h,092h,080h,015h,084h,051h,015h,094h,061h,015h,0a4h,071h,016h,0a6h,0d7h	; a9db  e.....Q..a..q...
	defb 017h,080h,046h,017h,0b0h,046h,018h,092h,0b0h,019h,084h,021h,019h,094h,041h,019h	; a9eb  ..F..F.....!..A.
	defb 0a4h,061h,01ah,091h,090h,01bh,080h,035h,01bh,080h,056h,01bh,076h,0c7h,01ch,092h	; a9fb  .a.....5..V.v...
	defb 080h,01dh,084h,021h,01dh,094h,041h,01dh,0a4h,061h,0ffh	; aa0b  ...!..A..a.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AA16: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; se solapan 2
;   bloques (0xAA16-0xAAB4, 0xAAB1-0xAAFB); lo leen zona 4-4, zona 4-5 (229
;   bytes)
;   0xaa16..0xaafb  (229 bytes)
DATA_cosas_fijas_AA16:
	defb 034h,000h,070h,075h,001h,074h,031h,001h,064h,041h,001h,064h,071h,001h,080h,026h	; aa16  4.pu.t1.dA.dq..&
	defb 001h,070h,0a5h,002h,080h,056h,003h,070h,046h,003h,0a0h,046h,003h,082h,060h,004h	; aa26  .p...V.pF..F..`.
	defb 060h,025h,004h,080h,046h,005h,076h,017h,006h,076h,057h,007h,090h,046h,00bh,080h	; aa36  `%..F.v..vW..F..
	defb 026h,00bh,090h,064h,00bh,070h,0a5h,00ch,090h,044h,00ch,060h,085h,00ch,082h,050h	; aa46  &..d.p...D.`...P
	defb 00eh,060h,025h,00eh,090h,046h,00eh,071h,070h,00eh,076h,0a7h,00fh,076h,017h,010h	; aa56  .`%..F.qp.v..v..
	defb 076h,057h,011h,060h,035h,011h,080h,054h,011h,080h,095h,011h,071h,070h,012h,0a4h	; aa66  vW.`5..T....qp..
	defb 071h,012h,094h,081h,012h,084h,091h,013h,060h,025h,013h,090h,046h,014h,070h,095h	; aa76  q.......`%..F.p.
	defb 017h,0a0h,036h,017h,070h,0b5h,018h,0a6h,027h,018h,081h,070h,019h,0a6h,0c7h,01ah	; aa86  ..6.p...'..p....
	defb 076h,057h,01bh,080h,016h,01bh,060h,095h,01bh,062h,050h,01bh,0a6h,037h,01ch,060h	; aa96  vW....`..bP..7.`
	defb 0b5h,01ch,090h,074h,01dh,092h,030h,01dh,076h,097h,0ffh,018h,003h,0a0h,046h,008h	; aaa6  ...t..0.v.....F.
	defb 080h,024h,008h,0a0h,064h,009h,096h,057h,00bh,0a6h,087h,00ch,0a6h,037h,00eh,076h	; aab6  .$..d..W.....7.v
	defb 027h,00eh,080h,025h,00eh,060h,044h,00eh,060h,084h,013h,080h,044h,013h,080h,085h	; aac6  '..%.`D.`...D...
	defb 015h,076h,067h,016h,086h,0d7h,017h,080h,024h,017h,060h,064h,017h,0a0h,064h,017h	; aad6  .vg.....$.`d..d.
	defb 076h,0a7h,019h,0a6h,097h,01ch,096h,0c7h,01eh,0a0h,036h,020h,090h,046h,020h,0c0h	; aae6  v.........6 .F .
	defb 046h,023h,096h,0c7h,0ffh	; aaf6

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AAFB: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   4-6 (35 bytes)
;   0xaafb..0xab1e  (35 bytes)
DATA_cosas_fijas_AAFB:
	defb 00bh,001h,076h,097h,007h,096h,0d7h,00bh,0a6h,027h,023h,076h,057h,024h,076h,057h	; aafb  ..v......'#vW$vW
	defb 028h,0a6h,037h,02bh,076h,047h,02ch,0a6h,097h,03ah,072h,060h,03eh,061h,060h,041h	; ab0b  (.7+vG,..:r`>a`A
	defb 076h,0a7h,0ffh	; ab1b

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AB1E: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; se solapan 2
;   bloques (0xAB1E-0xABB0, 0xABAD-0xAC57); lo leen zona 5-0, zona 5-1 (313
;   bytes)
;   0xab1e..0xac57  (313 bytes)
DATA_cosas_fijas_AB1E:
	defb 030h,001h,081h,080h,002h,060h,0b5h,003h,0a6h,047h,003h,094h,0a1h,003h,084h,0b1h	; ab1e  0....`...G......
	defb 003h,074h,0c1h,004h,060h,065h,005h,076h,027h,008h,082h,030h,009h,076h,0b7h,00ch	; ab2e  .t..`e.v'..0.v..
	defb 076h,0c7h,00dh,071h,070h,00dh,080h,046h,00dh,0a0h,046h,00eh,0a0h,044h,00eh,060h	; ab3e  v..qp..F..F..D.`
	defb 085h,00fh,074h,021h,00fh,084h,031h,00fh,072h,070h,00fh,076h,0e7h,010h,0a0h,044h	; ab4e  ..t!..1.rp.v...D
	defb 010h,080h,084h,011h,076h,0b7h,012h,072h,090h,013h,090h,036h,013h,070h,084h,014h	; ab5e  ....v..r...6.p..
	defb 060h,025h,014h,090h,046h,015h,074h,041h,015h,074h,051h,015h,094h,061h,015h,094h	; ab6e  `%..F.tA.tQ..a..
	defb 071h,016h,094h,081h,016h,084h,091h,016h,074h,0a1h,016h,076h,0d7h,017h,070h,026h	; ab7e  q.......t..v..p&
	defb 017h,0a0h,066h,018h,081h,040h,018h,0a6h,0d7h,01ah,094h,0a1h,01bh,076h,017h,01bh	; ab8e  ..f..@.......v..
	defb 0a0h,036h,01bh,060h,075h,01ch,0a2h,030h,01ch,080h,084h,01dh,086h,047h,0ffh,038h	; ab9e  .6.`u..0.....G.8
	defb 000h,0a6h,067h,001h,060h,035h,001h,080h,075h,001h,071h,080h,001h,060h,0c5h,002h	; abae  ..g.`5..u.q..`..
	defb 090h,046h,002h,060h,0c5h,002h,0b2h,060h,003h,060h,025h,003h,072h,0c0h,004h,070h	; abbe  .F.`...`.`%.r..p
	defb 054h,004h,070h,095h,005h,084h,051h,005h,0a4h,051h,005h,0a4h,081h,005h,076h,0a7h	; abce  T.p...Q..Q....v.
	defb 006h,060h,025h,006h,080h,046h,006h,071h,060h,006h,074h,0a1h,006h,070h,0c5h,007h	; abde  .`%..F.q`.t..p..
	defb 0a6h,0a7h,008h,070h,076h,008h,082h,090h,008h,0a0h,076h,009h,0a6h,027h,009h,080h	; abee  ...pv.....v..'..
	defb 046h,009h,0a1h,0d0h,00ah,060h,035h,00ah,0a0h,036h,00ah,076h,0a7h,00ch,0a6h,067h	; abfe  F....`5..6.v...g
	defb 00ch,060h,0a5h,00dh,071h,050h,00dh,080h,036h,00dh,0b0h,076h,00eh,0a6h,0a7h,00fh	; ac0e  .`..qP..6..v....
	defb 060h,025h,00fh,090h,046h,00fh,080h,0c5h,010h,070h,055h,010h,082h,080h,010h,091h	; ac1e  `%..F....pU.....
	defb 080h,012h,064h,061h,012h,074h,081h,012h,080h,066h,012h,094h,0a1h,013h,060h,075h	; ac2e  ..da.t...f....`u
	defb 013h,0a0h,036h,013h,076h,0c7h,015h,080h,044h,015h,0b2h,050h,015h,086h,0b7h,016h	; ac3e  ..6.v...D..P....
	defb 076h,0c7h,017h,060h,045h,017h,0a0h,026h,0ffh	; ac4e  v..`E..&.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AC57: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   5-2 (65 bytes)
;   0xac57..0xac98  (65 bytes)
DATA_cosas_fijas_AC57:
	defb 015h,001h,072h,050h,001h,084h,0b1h,002h,086h,087h,002h,074h,0c1h,005h,081h,030h	; ac57  ..rP.......t...0
	defb 005h,096h,0a7h,007h,072h,050h,008h,074h,051h,008h,084h,061h,008h,094h,071h,009h	; ac67  ....rP.tQ..a..q.
	defb 074h,031h,009h,084h,041h,009h,094h,051h,00ah,096h,0d7h,00ch,081h,070h,00dh,076h	; ac77  t1..A..Q.....p.v
	defb 027h,00eh,074h,061h,00fh,086h,027h,010h,072h,090h,010h,096h,0d7h,014h,074h,061h	; ac87  '.ta..'.r.....ta
	defb 0ffh	; ac97

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AC98: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   5-3 (41 bytes)
;   0xac98..0xacc1  (41 bytes)
DATA_cosas_fijas_AC98:
	defb 00dh,001h,092h,050h,002h,076h,0b7h,003h,0a1h,060h,003h,0a4h,091h,003h,0a4h,0b1h	; ac98  ...P.v...`......
	defb 005h,096h,087h,006h,074h,0c1h,007h,061h,050h,007h,086h,057h,008h,0a6h,047h,00ah	; aca8  ....t..aP..W..G.
	defb 096h,067h,00bh,094h,021h,00ch,056h,0c7h,0ffh	; acb8  .g..!.V..

; ----------------------------------------------------------------------
; DATOS cosas_fijas_ACC1: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   5-4 (98 bytes)
;   0xacc1..0xad23  (98 bytes)
DATA_cosas_fijas_ACC1:
	defb 020h,001h,076h,087h,001h,084h,061h,001h,0a0h,056h,002h,072h,070h,002h,080h,046h	; acc1   .v...a..V.rp..F
	defb 003h,0a6h,047h,003h,070h,066h,003h,0a0h,066h,003h,091h,080h,004h,080h,046h,006h	; acd1  ..G.pf..f.....F.
	defb 0a6h,057h,007h,0a6h,0d7h,008h,080h,036h,008h,0a2h,050h,008h,080h,0b5h,009h,0a6h	; ace1  .W.....6..P.....
	defb 037h,00ah,084h,051h,00ah,0a4h,041h,00ah,070h,066h,00ah,080h,065h,00ah,092h,0a0h	; acf1  7..Q..A.pf..e...
	defb 00bh,076h,087h,00ch,080h,046h,00ch,0a1h,050h,00ch,0a6h,0d7h,00eh,080h,035h,00eh	; ad01  .v...F..P.....5.
	defb 076h,047h,00eh,090h,056h,010h,080h,036h,010h,0a1h,050h,010h,080h,0b5h,011h,080h	; ad11  vG..V..6..P.....
	defb 034h,0ffh	; ad21

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AD23: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   5-5 (116 bytes)
;   0xad23..0xad97  (116 bytes)
DATA_cosas_fijas_AD23:
	defb 026h,002h,0a4h,081h,002h,0a4h,0a1h,003h,080h,044h,007h,096h,077h,008h,0a6h,037h	; ad23  &........D..w..7
	defb 00ah,060h,035h,00ah,090h,056h,00dh,080h,064h,00eh,090h,056h,011h,070h,036h,012h	; ad33  .`5..V..d..V.p6.
	defb 090h,084h,013h,080h,034h,013h,0a4h,041h,013h,0a4h,061h,015h,086h,0c7h,017h,090h	; ad43  ....4..A..a.....
	defb 046h,018h,094h,041h,018h,084h,061h,018h,094h,0a1h,019h,094h,041h,01bh,0a6h,0a7h	; ad53  F..A..a.....A...
	defb 01dh,0a6h,0c7h,01eh,080h,036h,01eh,090h,045h,01eh,090h,065h,01eh,0b6h,0a7h,021h	; ad63  .....6..E..e...!
	defb 0a0h,046h,022h,080h,065h,022h,080h,085h,022h,0b0h,0a4h,022h,096h,0c7h,023h,0a0h	; ad73  .F".e"..".."..#.
	defb 056h,024h,080h,044h,024h,094h,091h,024h,0a4h,0b1h,024h,0b6h,0e7h,024h,0b0h,094h	; ad83  V$.D$..$..$..$..
	defb 025h,096h,087h,0ffh	; ad93

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AD97: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   5-6 (62 bytes)
;   0xad97..0xadd5  (62 bytes)
DATA_cosas_fijas_AD97:
	defb 014h,000h,076h,0a7h,002h,0a6h,047h,006h,076h,097h,01eh,076h,057h,01fh,0a6h,0b7h	; ad97  ..v...G.v..vW...
	defb 021h,076h,0c7h,023h,076h,0c7h,029h,076h,0c7h,02ch,076h,0d7h,02eh,094h,041h,02fh	; ada7  !v.#v.)v.,v...A/
	defb 084h,021h,02fh,0a4h,041h,02fh,0a4h,071h,03eh,060h,055h,03fh,0a6h,0c7h,040h,060h	; adb7  .!/.A/.q>`U?..@`
	defb 0a5h,041h,074h,091h,041h,084h,0a1h,041h,094h,0b1h,044h,072h,080h,0ffh	; adc7  .At.A..A..Dr..

; ----------------------------------------------------------------------
; DATOS cosas_fijas_ADD5: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   6-0 (74 bytes)
;   0xadd5..0xae1f  (74 bytes)
DATA_cosas_fijas_ADD5:
	defb 018h,001h,096h,027h,001h,092h,090h,002h,0a6h,047h,002h,074h,071h,004h,074h,071h	; add5  ...'.....G.tq.tq
	defb 004h,064h,091h,005h,0a6h,0a7h,006h,094h,081h,006h,086h,0b7h,007h,081h,0a0h,008h	; ade5  .d..............
	defb 074h,031h,00ch,096h,0b7h,00dh,096h,0e7h,00eh,081h,080h,00eh,056h,0d7h,00fh,0a4h	; adf5  t1..........V...
	defb 031h,00fh,0a4h,051h,010h,0a6h,097h,013h,066h,027h,014h,0a2h,040h,014h,0b4h,081h	; ae05  1..Q....f'..@...
	defb 014h,0a4h,0b1h,015h,086h,057h,015h,084h,081h,0ffh	; ae15  .....W....

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AE1F: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   6-1 (167 bytes)
;   0xae1f..0xaec6  (167 bytes)
DATA_cosas_fijas_AE1F:
	defb 037h,000h,086h,057h,000h,090h,066h,000h,081h,090h,001h,080h,056h,001h,0a2h,0a0h	; ae1f  7..W..f.....V...
	defb 002h,070h,055h,002h,074h,081h,002h,0a4h,081h,002h,070h,0a5h,003h,096h,037h,004h	; ae2f  .pU.t.....p...7.
	defb 080h,026h,004h,092h,050h,004h,0a0h,066h,006h,080h,074h,006h,080h,0b5h,007h,0a6h	; ae3f  .&..P..f..t.....
	defb 0a7h,008h,060h,045h,008h,080h,064h,009h,080h,035h,009h,090h,056h,00ch,060h,065h	; ae4f  ..`E..d..5..V.`e
	defb 00ch,081h,090h,00ch,080h,0a5h,00dh,066h,027h,00fh,060h,055h,00fh,060h,075h,00fh	; ae5f  .......f'.`U.`u.
	defb 060h,095h,00fh,0a2h,070h,012h,0b4h,051h,012h,094h,061h,012h,074h,071h,012h,066h	; ae6f  `...p..Q..a.tq.f
	defb 0d7h,013h,071h,060h,013h,090h,026h,013h,060h,0a5h,014h,066h,027h,016h,066h,0d7h	; ae7f  ..q`..&.`..f'.f.
	defb 016h,080h,066h,017h,080h,026h,017h,0a1h,0a0h,01bh,071h,070h,01bh,090h,056h,01dh	; ae8f  ..f..&....qp..V.
	defb 080h,036h,01dh,090h,076h,01dh,0a2h,070h,01eh,060h,065h,01eh,0a0h,036h,01eh,082h	; ae9f  .6..v..p.`e..6..
	defb 080h,01fh,060h,045h,01fh,080h,064h,01fh,080h,0a5h,01fh,084h,0d1h,01fh,0a4h,0d1h	; aeaf  ..`E..d.........
	defb 021h,080h,056h,021h,0a0h,026h,0ffh	; aebf

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AEC6: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   6-2 (128 bytes)
;   0xaec6..0xaf46  (128 bytes)
DATA_cosas_fijas_AEC6:
	defb 02ah,000h,071h,0c0h,001h,060h,065h,001h,076h,097h,002h,070h,036h,004h,076h,087h	; aec6  *.q..`e.v..p6.v.
	defb 004h,090h,094h,005h,074h,031h,005h,084h,041h,005h,094h,051h,005h,0a6h,087h,007h	; aed6  ....t1..A..Q....
	defb 076h,0d7h,008h,072h,030h,008h,076h,0b7h,00ah,080h,056h,00ah,0a2h,070h,00bh,080h	; aee6  v..r0.v...V..p..
	defb 056h,00ch,074h,0b1h,00ch,084h,0c1h,00ch,094h,0d1h,00dh,076h,0c7h,00eh,071h,050h	; aef6  V.t........v..qP
	defb 00eh,090h,084h,00fh,086h,0b7h,010h,0a6h,027h,010h,080h,066h,011h,082h,0b0h,012h	; af06  ........'..f....
	defb 060h,044h,012h,080h,044h,013h,0a6h,027h,013h,081h,080h,014h,090h,044h,016h,0a6h	; af16  `D..D..'.....D..
	defb 057h,017h,081h,040h,018h,0a0h,034h,018h,060h,075h,019h,084h,041h,019h,094h,061h	; af26  W..@..4.`u..A..a
	defb 01ah,0a4h,081h,01ah,094h,091h,01ah,084h,0a1h,01bh,076h,0c7h,01ch,090h,066h,0ffh	; af36  ..........v...f.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AF46: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   6-3 (50 bytes)
;   0xaf46..0xaf78  (50 bytes)
DATA_cosas_fijas_AF46:
	defb 010h,000h,0a2h,0b0h,001h,0b6h,057h,002h,0a1h,060h,002h,096h,0c7h,004h,0b4h,041h	; af46  ......W..`.....A
	defb 004h,0a4h,061h,006h,0b6h,057h,008h,096h,087h,009h,074h,091h,009h,064h,0a1h,009h	; af56  ..a..W....t..d..
	defb 076h,0d7h,00ch,076h,067h,00ch,062h,080h,00eh,086h,0b7h,00fh,074h,0b1h,010h,056h	; af66  v..vg.b.....t..V
	defb 0d7h,0ffh	; af76

; ----------------------------------------------------------------------
; DATOS cosas_fijas_AF78: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   6-4 (149 bytes)
;   0xaf78..0xb00d  (149 bytes)
DATA_cosas_fijas_AF78:
	defb 031h,000h,0a6h,047h,000h,084h,0a1h,000h,074h,0c1h,000h,0a4h,0c1h,001h,080h,034h	; af78  1..G....t......4
	defb 001h,080h,074h,001h,0a2h,040h,003h,060h,045h,003h,080h,065h,003h,071h,080h,004h	; af88  ..t..@.`E..e.q..
	defb 080h,046h,004h,0a6h,097h,005h,066h,0a7h,006h,0a6h,0d7h,007h,090h,036h,008h,060h	; af98  .F....f......6.`
	defb 035h,008h,090h,056h,00ah,0a6h,047h,00bh,060h,035h,00bh,080h,056h,00bh,092h,070h	; afa8  5..V..G.`5..V..p
	defb 00dh,070h,045h,00dh,080h,064h,00eh,080h,056h,00eh,0a1h,080h,010h,066h,0c7h,011h	; afb8  .pE..d..V....f..
	defb 070h,035h,011h,070h,0b5h,012h,080h,036h,013h,080h,025h,013h,080h,046h,013h,0a2h	; afc8  p5.p...6..%..F..
	defb 060h,015h,080h,026h,015h,0a4h,041h,017h,080h,054h,017h,060h,095h,018h,090h,034h	; afd8  `..&..A..T.`...4
	defb 018h,080h,075h,018h,072h,060h,019h,080h,026h,019h,0a6h,0b7h,01ah,066h,0c7h,01bh	; afe8  ..u.r`..&....f..
	defb 060h,065h,01bh,080h,084h,01dh,060h,035h,01dh,080h,055h,01dh,074h,081h,01dh,084h	; aff8  `e....`5..U.t...
	defb 091h,01dh,094h,0a1h,0ffh	; b008

; ----------------------------------------------------------------------
; DATOS cosas_fijas_B00D: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   6-5 (89 bytes)
;   0xb00d..0xb066  (89 bytes)
DATA_cosas_fijas_B00D:
	defb 01dh,003h,096h,057h,007h,0a1h,050h,00ch,076h,0c7h,00eh,081h,090h,015h,076h,017h	; b00d  ...W..P.v.....v.
	defb 015h,082h,0a0h,016h,090h,094h,01ah,090h,054h,01ah,090h,094h,01bh,084h,061h,01bh	; b01d  ........T.....a.
	defb 084h,081h,01bh,084h,0a1h,01ch,082h,070h,01dh,080h,026h,01dh,090h,084h,01fh,076h	; b02d  .......p..&....v
	defb 087h,021h,0a0h,036h,022h,096h,0d7h,024h,0b4h,0a1h,024h,094h,0b1h,025h,096h,017h	; b03d  .!.6"..$..$..%..
	defb 025h,0b0h,056h,027h,0a0h,026h,027h,080h,0a5h,027h,0b6h,0d7h,028h,096h,017h,029h	; b04d  %.V'.&'..'..(..)
	defb 080h,065h,029h,0a0h,084h,02bh,096h,067h,0ffh	; b05d  .e)..+.g.

; ----------------------------------------------------------------------
; DATOS cosas_fijas_B066: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   6-6 (41 bytes)
;   0xb066..0xb08f  (41 bytes)
DATA_cosas_fijas_B066:
	defb 00dh,004h,076h,027h,007h,076h,027h,00ah,0a6h,0d7h,00eh,086h,0c7h,011h,076h,017h	; b066  ..v'.v'.......v.
	defb 01bh,076h,0d7h,021h,086h,0a7h,023h,076h,087h,024h,096h,0d7h,026h,066h,0a7h,03ch	; b076  .v.!..#v.$..&f.<
	defb 076h,0b7h,03eh,061h,060h,040h,062h,0a0h,0ffh	; b086  v.>a`@b..

; ----------------------------------------------------------------------
; DATOS cosas_fijas_B08F: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   7-0 (86 bytes)
;   0xb08f..0xb0e5  (86 bytes)
DATA_cosas_fijas_B08F:
	defb 01ch,000h,082h,0b0h,001h,081h,0a0h,004h,092h,0a0h,006h,074h,091h,006h,084h,0b1h	; b08f  ...........t....
	defb 007h,086h,047h,008h,082h,050h,009h,076h,027h,00ah,074h,051h,00ah,094h,061h,00ah	; b09f  ..G..P.v'.tQ..a.
	defb 0b4h,071h,00ch,0a4h,081h,00ch,084h,091h,00ch,094h,0b1h,00ch,074h,0c1h,00dh,081h	; b0af  .q..........t...
	defb 060h,00fh,084h,061h,010h,076h,087h,011h,074h,031h,011h,096h,077h,013h,084h,031h	; b0bf  `..a.v..t1..w..1
	defb 013h,094h,061h,013h,084h,081h,014h,076h,0e7h,015h,082h,040h,016h,081h,090h,017h	; b0cf  ..a....v...@....
	defb 086h,027h,017h,084h,051h,0ffh	; b0df

; ----------------------------------------------------------------------
; DATOS cosas_fijas_B0E5: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   7-1 (77 bytes)
;   0xb0e5..0xb132  (77 bytes)
DATA_cosas_fijas_B0E5:
	defb 019h,000h,071h,070h,000h,080h,064h,001h,090h,036h,001h,072h,070h,001h,0a1h,070h	; b0e5  ..qp..d..6.rp..p
	defb 002h,0a6h,037h,002h,080h,0b5h,003h,082h,0b0h,004h,0a6h,027h,004h,060h,0a5h,004h	; b0f5  ..7........'.`..
	defb 080h,0c5h,006h,060h,015h,006h,091h,050h,006h,0a6h,0d7h,007h,082h,030h,008h,066h	; b105  ...`...P.....0.f
	defb 067h,009h,0a6h,027h,00ch,060h,065h,00ch,071h,090h,00ch,080h,0a5h,00dh,070h,044h	; b115  g..'.`e.q.....pD
	defb 00dh,090h,046h,00dh,074h,0a1h,00dh,0b4h,051h,00dh,096h,0d7h,0ffh	; b125  ..F.t...Q....

; ----------------------------------------------------------------------
; DATOS cosas_fijas_B132: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   7-2 (62 bytes)
;   0xb132..0xb170  (62 bytes)
DATA_cosas_fijas_B132:
	defb 014h,001h,0a6h,0b7h,004h,096h,0b7h,005h,086h,0a7h,005h,081h,0c0h,006h,0b6h,027h	; b132  ...............'
	defb 006h,094h,0b1h,008h,086h,047h,009h,094h,071h,009h,0b6h,0d7h,00ah,072h,0a0h,00bh	; b142  .....G..q....r..
	defb 056h,017h,00eh,094h,081h,00fh,066h,017h,011h,0a6h,027h,011h,074h,0c1h,012h,084h	; b152  V.....f...'.t...
	defb 041h,012h,071h,050h,012h,076h,097h,015h,084h,061h,015h,084h,081h,0ffh	; b162  A.qP.v...a....

; ----------------------------------------------------------------------
; DATOS cosas_fijas_B170: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   7-3 (179 bytes)
;   0xb170..0xb223  (179 bytes)
DATA_cosas_fijas_B170:
	defb 03bh,001h,086h,027h,001h,092h,080h,002h,060h,025h,002h,0a0h,044h,002h,0b6h,0c7h	; b170  ...'....`%..D...
	defb 003h,060h,095h,003h,060h,0b5h,003h,0a0h,094h,003h,074h,0e1h,003h,094h,0e1h,003h	; b180  .`..`.....t.....
	defb 0b4h,0e1h,004h,081h,090h,005h,080h,046h,006h,072h,070h,006h,090h,056h,008h,0a6h	; b190  .......F.rp..V..
	defb 027h,00ah,076h,067h,00bh,060h,075h,00bh,084h,0b1h,00bh,094h,0c1h,00ch,086h,027h	; b1a0  '.vg.`u........'
	defb 00ch,060h,085h,00ch,092h,0c0h,00dh,060h,065h,00dh,060h,085h,00fh,074h,041h,00fh	; b1b0  .`.....`e.`..tA.
	defb 084h,051h,00fh,0a6h,0a7h,010h,0a4h,071h,010h,094h,081h,010h,084h,091h,011h,084h	; b1c0  .Q.....q........
	defb 041h,011h,094h,051h,011h,0a4h,061h,012h,094h,0b1h,012h,084h,0c1h,013h,090h,046h	; b1d0  A..Q..a........F
	defb 014h,081h,060h,015h,076h,0c7h,016h,090h,066h,017h,0a0h,044h,017h,090h,066h,018h	; b1e0  ..`.v...f..D..f.
	defb 071h,060h,018h,080h,084h,019h,076h,027h,01ah,090h,046h,01ah,060h,0c5h,01bh,076h	; b1f0  q`....v'..F.`..v
	defb 0a7h,01ch,094h,091h,01ch,084h,0b1h,01dh,090h,044h,01dh,076h,0c7h,01eh,090h,036h	; b200  .........D.v...6
	defb 01fh,090h,056h,01fh,074h,071h,01fh,084h,091h,020h,060h,055h,020h,080h,074h,020h	; b210  ..V.tq... `U .t
	defb 0a2h,070h,0ffh	; b220

; ----------------------------------------------------------------------
; DATOS cosas_fijas_B223: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   7-4 (116 bytes)
;   0xb223..0xb297  (116 bytes)
DATA_cosas_fijas_B223:
	defb 026h,000h,086h,0c7h,001h,071h,070h,001h,090h,036h,002h,080h,034h,004h,080h,034h	; b223  &....qp..6..4..4
	defb 004h,072h,0a0h,004h,090h,0a4h,005h,0a6h,037h,007h,080h,046h,008h,082h,040h,009h	; b233  .r......7..F..@.
	defb 060h,055h,009h,080h,0b5h,00bh,066h,097h,00ch,0a6h,0d7h,00dh,080h,064h,00eh,082h	; b243  `U....f......d..
	defb 050h,00eh,090h,036h,00fh,090h,056h,010h,070h,036h,013h,090h,036h,013h,060h,0b5h	; b253  P..6..V.p6..6.`.
	defb 016h,090h,084h,017h,0a6h,0a7h,018h,081h,060h,018h,090h,046h,019h,090h,046h,019h	; b263  ........`..F..F.
	defb 076h,0d7h,01ah,090h,036h,01ah,060h,0b5h,01ah,0a1h,060h,01bh,090h,046h,01bh,080h	; b273  v...6.`...`..F..
	defb 0c5h,01ch,0a6h,037h,01dh,0b6h,0c7h,01eh,0a4h,061h,01eh,094h,071h,01eh,084h,081h	; b283  ...7.....a..q...
	defb 01fh,076h,037h,0ffh	; b293

; ----------------------------------------------------------------------
; DATOS cosas_fijas_B297: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   7-5 (164 bytes)
;   0xb297..0xb33b  (164 bytes)
DATA_cosas_fijas_B297:
	defb 036h,000h,096h,037h,002h,091h,050h,008h,0a6h,027h,008h,092h,090h,009h,080h,045h	; b297  6..7..P..'.....E
	defb 009h,096h,0b7h,00ah,0a0h,066h,00bh,096h,027h,00dh,080h,044h,00fh,0a6h,037h,010h	; b2a7  .....f..'..D..7.
	defb 096h,0c7h,013h,080h,046h,014h,090h,094h,015h,090h,024h,017h,081h,080h,018h,076h	; b2b7  ....F.....$....v
	defb 057h,018h,070h,0a4h,01ah,086h,0d7h,01bh,080h,094h,01ch,080h,046h,01dh,076h,097h	; b2c7  W.p.........F.v.
	defb 01fh,076h,037h,01fh,060h,085h,01fh,0a0h,056h,020h,091h,040h,020h,086h,0c7h,021h	; b2d7  .v7.`...V .@ ..!
	defb 060h,065h,021h,0a0h,084h,022h,080h,065h,024h,076h,067h,025h,080h,036h,025h,0a0h	; b2e7  `e!..".e$vg%.6%.
	defb 036h,027h,081h,030h,027h,0a6h,0b7h,02ah,080h,065h,02ah,060h,085h,02ah,060h,0a5h	; b2f7  6'.0'..*.e*`.*`.
	defb 02dh,084h,071h,02fh,0a1h,030h,02fh,080h,085h,030h,0b0h,046h,031h,094h,071h,031h	; b307  -.q/.0/..0.F1.q1
	defb 0a4h,081h,031h,0b4h,091h,032h,090h,055h,032h,0b0h,074h,034h,0a6h,0a7h,037h,090h	; b317  ..1..2.U2.t4..7.
	defb 034h,037h,0b0h,074h,038h,0a2h,040h,038h,0c6h,0c7h,039h,0a4h,041h,039h,0b4h,061h	; b327  47.t8.@8..9.A9.a
	defb 039h,0c4h,081h,0ffh	; b337

; ----------------------------------------------------------------------
; DATOS cosas_fijas_B33B: [n], n fichas de 3 bytes [casilla][x | figura][y |
;   pieza] y un 0xFF: si el nibble bajo del segundo no es 0 p02:8FD5 pone una
;   figura; el del tercero es la pieza (0xA02B); el 0xFF hace de casilla que
;   no es ninguna, para que p02:90EE pare tras la ultima ficha; lo leen zona
;   7-6 (50 bytes)
;   0xb33b..0xb36d  (50 bytes)
DATA_cosas_fijas_B33B:
	defb 010h,003h,086h,027h,013h,086h,0d7h,01ah,086h,0d7h,021h,076h,0d7h,025h,076h,0b7h	; b33b  ...'......!v.%v.
	defb 029h,0a6h,0a7h,02ah,076h,037h,02eh,074h,031h,02eh,084h,041h,02eh,094h,051h,030h	; b34b  )..*v7.t1..A..Q0
	defb 094h,041h,030h,084h,051h,030h,074h,061h,039h,071h,070h,042h,072h,050h,046h,071h	; b35b  .A0.Q0ta9qpBrPFq
	defb 070h,0ffh	; b36b

; ----------------------------------------------------------------------
; DATOS piezas_del_subsuelo: 16 punteros a listas de bloques que p02:9155
;   pinta en los pasadizos; lo leen p02:9155 (32 bytes)
;   0xb36d..0xb38d  (32 bytes)
DATA_piezas_del_subsuelo:
	defb 08dh,0b3h,090h,0b3h,093h,0b3h,093h,0b3h,093h,0b3h,093h,0b3h,093h,0b3h,095h,0b3h	; b36d  ................
	defb 098h,0b3h,09dh,0b3h,0a2h,0b3h,0a7h,0b3h,0ach,0b3h,0b1h,0b3h,0b6h,0b3h,0b9h,0b3h	; b37d  ................

; ----------------------------------------------------------------------
; DATOS subsuelo_B38D: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (3 bytes)
;   0xb38d..0xb390  (3 bytes)
DATA_subsuelo_B38D:
	defb 090h,070h,0ffh	; b38d

; ----------------------------------------------------------------------
; DATOS subsuelo_B390: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (3 bytes)
;   0xb390..0xb393  (3 bytes)
DATA_subsuelo_B390:
	defb 090h,0a0h,0ffh	; b390

; ----------------------------------------------------------------------
; DATOS subsuelo_B393: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (1 bytes)
;   0xb393..0xb394  (1 bytes)
DATA_subsuelo_B393:
	defb 0ffh	; b393

; ----------------------------------------------------------------------
; DATOS ff_de_mas_B394: un segundo 0xFF detras de la lista vacia de 0xB393 (la
;   de las piezas 2-6 de 0xB36D); no lo lee nadie (1 byte)
;   0xb394..0xb395  (1 bytes)
DATA_ff_de_mas_B394:
	defb 0ffh	; b394

; ----------------------------------------------------------------------
; DATOS subsuelo_B395: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (3 bytes)
;   0xb395..0xb398  (3 bytes)
DATA_subsuelo_B395:
	defb 080h,040h,0ffh	; b395

; ----------------------------------------------------------------------
; DATOS subsuelo_B398: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (5 bytes)
;   0xb398..0xb39d  (5 bytes)
DATA_subsuelo_B398:
	defb 090h,070h,090h,020h,0ffh	; b398

; ----------------------------------------------------------------------
; DATOS subsuelo_B39D: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (5 bytes)
;   0xb39d..0xb3a2  (5 bytes)
DATA_subsuelo_B39D:
	defb 090h,070h,080h,080h,0ffh	; b39d

; ----------------------------------------------------------------------
; DATOS subsuelo_B3A2: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (5 bytes)
;   0xb3a2..0xb3a7  (5 bytes)
DATA_subsuelo_B3A2:
	defb 090h,070h,090h,010h,0ffh	; b3a2

; ----------------------------------------------------------------------
; DATOS subsuelo_B3A7: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (5 bytes)
;   0xb3a7..0xb3ac  (5 bytes)
DATA_subsuelo_B3A7:
	defb 090h,070h,080h,050h,0ffh	; b3a7

; ----------------------------------------------------------------------
; DATOS subsuelo_B3AC: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (5 bytes)
;   0xb3ac..0xb3b1  (5 bytes)
DATA_subsuelo_B3AC:
	defb 090h,070h,090h,000h,0ffh	; b3ac

; ----------------------------------------------------------------------
; DATOS subsuelo_B3B1: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (5 bytes)
;   0xb3b1..0xb3b6  (5 bytes)
DATA_subsuelo_B3B1:
	defb 090h,070h,080h,0e0h,0ffh	; b3b1

; ----------------------------------------------------------------------
; DATOS subsuelo_B3B6: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (3 bytes)
;   0xb3b6..0xb3b9  (3 bytes)
DATA_subsuelo_B3B6:
	defb 080h,000h,0ffh	; b3b6

; ----------------------------------------------------------------------
; DATOS subsuelo_B3B9: parejas [x][y] de bloques de la hoja que p02:915C
;   pinta; 0xFF acaba; lo leen p02:915C (5 bytes)
;   0xb3b9..0xb3be  (5 bytes)
DATA_subsuelo_B3B9:
	defb 090h,070h,090h,0d0h,0ffh	; b3b9

; ----------------------------------------------------------------------
; DATOS huecos_de_cada_zona: 49 punteros, uno por zona, a sus fichas de
;   pasadizo (p02:9231); lo leen p02:922E (98 bytes)
;   0xb3be..0xb420  (98 bytes)
DATA_huecos_de_cada_zona:
	defb 020h,0b4h,032h,0b4h,04ch,0b4h,062h,0b4h,07eh,0b4h,09ah,0b4h,0bch,0b4h,0e4h,0b4h	; b3be   .2.L.b.~.......
	defb 0fah,0b4h,03ch,0b5h,05eh,0b5h,07ah,0b5h,096h,0b5h,0bch,0b5h,0f2h,0b5h,010h,0b6h	; b3ce  ..<.^.z.........
	defb 030h,0b6h,062h,0b6h,08eh,0b6h,0aeh,0b6h,0d6h,0b6h,006h,0b7h,034h,0b7h,04eh,0b7h	; b3de  0.b.........4.N.
	defb 080h,0b7h,0b6h,0b7h,0d8h,0b7h,004h,0b8h,034h,0b8h,05ah,0b8h,08eh,0b8h,0aeh,0b8h	; b3ee  ........4.Z.....
	defb 0e8h,0b8h,00ch,0b9h,03eh,0b9h,070h,0b9h,0a6h,0b9h,0c6h,0b9h,0feh,0b9h,030h,0bah	; b3fe  ....>.p.......0.
	defb 054h,0bah,07ch,0bah,0c0h,0bah,0e4h,0bah,018h,0bbh,04eh,0bbh,07ch,0bbh,09ch,0bbh	; b40e  T.|.......N.|...
	defb 0e8h,0bbh	; b41e

; ----------------------------------------------------------------------
; DATOS huecos_B420: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 1-0 (18 bytes)
;   0xb420..0xb432  (18 bytes)
DATA_huecos_B420:
	defb 057h,068h,02ah,068h,098h,020h,027h,058h,047h,098h,027h,030h,07dh,080h,09ch,0e8h	; b420  Wh*h. 'XG.'0}...
	defb 047h,0cch	; b430

; ----------------------------------------------------------------------
; DATOS huecos_B432: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 1-1 (26 bytes)
;   0xb432..0xb44c  (26 bytes)
DATA_huecos_B432:
	defb 077h,020h,04ch,0d8h,057h,068h,078h,030h,087h,0d8h,027h,070h,079h,0c8h,057h,058h	; b432  w L.Whx0..'py.WX
	defb 05ch,060h,027h,0c8h,087h,058h,027h,030h,06fh,0bch	; b442  \`'..X'0o.

; ----------------------------------------------------------------------
; DATOS huecos_B44C: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 1-2 (22 bytes)
;   0xb44c..0xb462  (22 bytes)
DATA_huecos_B44C:
	defb 049h,088h,077h,0b8h,068h,020h,027h,098h,058h,028h,01bh,030h,067h,058h,087h,058h	; b44c  I.w.h '.X(.0gX.X
	defb 02dh,040h,078h,0b8h,067h,09ch	; b45c

; ----------------------------------------------------------------------
; DATOS huecos_B462: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 1-3 (28 bytes)
;   0xb462..0xb47e  (28 bytes)
DATA_huecos_B462:
	defb 037h,058h,04ch,010h,077h,0b8h,028h,010h,018h,030h,077h,078h,027h,040h,08fh,0b8h	; b462  7XL.w.(..0wx'@..
	defb 057h,0c8h,03ch,098h,037h,050h,07dh,0c8h,027h,020h,06bh,0ach	; b472  W.<.7P}.' k.

; ----------------------------------------------------------------------
; DATOS huecos_B47E: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 1-4 (28 bytes)
;   0xb47e..0xb49a  (28 bytes)
DATA_huecos_B47E:
	defb 099h,010h,01bh,040h,087h,068h,06eh,050h,06eh,060h,06eh,070h,027h,0b8h,017h,070h	; b47e  ...@.hnPn`np'..p
	defb 078h,0e8h,037h,088h,07bh,010h,037h,068h,077h,060h,02ch,0bch	; b48e  x.7.{.7hw`,.

; ----------------------------------------------------------------------
; DATOS huecos_B49A: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 1-5 (34 bytes)
;   0xb49a..0xb4bc  (34 bytes)
DATA_huecos_B49A:
	defb 058h,020h,05eh,040h,027h,0b8h,087h,078h,049h,010h,037h,0b8h,087h,058h,06bh,010h	; b49a  X ^@'..xI.7..Xk.
	defb 097h,0c8h,067h,050h,098h,0d8h,087h,050h,088h,0d8h,077h,070h,04dh,0d8h,057h,0c8h	; b4aa  ..gP...P..wpM.W.
	defb 08bh,0bch	; b4ba

; ----------------------------------------------------------------------
; DATOS huecos_B4BC: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 1-6 (40 bytes)
;   0xb4bc..0xb4e4  (40 bytes)
DATA_huecos_B4BC:
	defb 02ah,030h,097h,0c8h,028h,0a8h,067h,050h,088h,0d8h,037h,020h,04fh,0b8h,068h,020h	; b4bc  *0..(.gP..7 O.h
	defb 077h,088h,06ah,020h,08eh,020h,017h,098h,097h,060h,038h,0a8h,017h,070h,07dh,0e8h	; b4cc  w.j . ...`8..p}.
	defb 037h,010h,088h,088h,047h,030h,05bh,0ech	; b4dc  7...G0[.

; ----------------------------------------------------------------------
; DATOS huecos_B4E4: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 2-0 (22 bytes)
;   0xb4e4..0xb4fa  (22 bytes)
DATA_huecos_B4E4:
	defb 077h,050h,05eh,090h,05eh,0a0h,05eh,0b8h,038h,040h,087h,098h,027h,010h,08dh,0d8h	; b4e4  wP^.^.^.8@..'...
	defb 02eh,0b0h,02eh,0c0h,02ch,0dch	; b4f4

; ----------------------------------------------------------------------
; DATOS huecos_B4FA: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 2-1 (66 bytes)
;   0xb4fa..0xb53c  (66 bytes)
DATA_huecos_B4FA:
	defb 027h,030h,06eh,0b0h,07dh,0c8h,018h,040h,097h,058h,08ch,010h,097h,080h,018h,0d8h	; b4fa  '0n.}..@.X......
	defb 07eh,030h,07eh,040h,07eh,050h,077h,0b8h,087h,060h,05eh,090h,05eh,0a0h,05eh,0b8h	; b50a  ~0~@~Pw..`^.^.^.
	defb 01ch,010h,08eh,010h,08eh,040h,047h,0b8h,067h,010h,07eh,080h,06eh,090h,07eh,098h	; b51a  .....@G.g.~.n.~.
	defb 01eh,030h,01eh,040h,02eh,040h,027h,0c8h,07bh,020h,027h,0a8h,018h,030h,097h,0a0h	; b52a  .0.@.@'.{ '..0..
	defb 04fh,0cch	; b53a

; ----------------------------------------------------------------------
; DATOS huecos_B53C: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 2-2 (34 bytes)
;   0xb53c..0xb55e  (34 bytes)
DATA_huecos_B53C:
	defb 049h,020h,057h,078h,077h,060h,068h,0a0h,02dh,0b8h,087h,0d8h,04ch,040h,047h,088h	; b53c  I Wxw`h.-...L@G.
	defb 03ch,010h,027h,098h,097h,030h,048h,0c8h,087h,0e8h,04ah,010h,04eh,020h,04eh,030h	; b54c  <.'..0H...J.N N0
	defb 027h,0cch	; b55c

; ----------------------------------------------------------------------
; DATOS huecos_B55E: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 2-3 (28 bytes)
;   0xb55e..0xb57a  (28 bytes)
DATA_huecos_B55E:
	defb 087h,060h,04eh,098h,077h,090h,02ch,0d8h,067h,068h,05dh,010h,06ch,0d8h,028h,030h	; b55e  .`N.w.,.gh].l.(0
	defb 047h,0a8h,029h,040h,087h,058h,097h,0b8h,028h,040h,04bh,0cch	; b56e  G.)@.X..(@K.

; ----------------------------------------------------------------------
; DATOS huecos_B57A: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 2-4 (28 bytes)
;   0xb57a..0xb596  (28 bytes)
DATA_huecos_B57A:
	defb 03eh,050h,098h,050h,027h,0c8h,067h,078h,047h,0c8h,087h,010h,03ch,0b8h,027h,038h	; b57a  >P.P'.gxG...<.'8
	defb 029h,030h,057h,088h,04dh,030h,087h,058h,067h,070h,048h,0dch	; b58a  )0W.M0.XgpH.

; ----------------------------------------------------------------------
; DATOS huecos_B596: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 2-5 (38 bytes)
;   0xb596..0xb5bc  (38 bytes)
DATA_huecos_B596:
	defb 068h,010h,027h,058h,057h,060h,07bh,0c8h,08dh,050h,087h,0e8h,067h,0c8h,027h,088h	; b596  h.'XW`{..P..g.'.
	defb 097h,050h,03dh,0c8h,057h,030h,05eh,080h,05eh,090h,058h,0c8h,03bh,060h,067h,0c8h	; b5a6  .P=.W0^.^.X..`g.
	defb 049h,030h,09eh,098h,017h,0bch	; b5b6

; ----------------------------------------------------------------------
; DATOS huecos_B5BC: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 2-6 (54 bytes)
;   0xb5bc..0xb5f2  (54 bytes)
DATA_huecos_B5BC:
	defb 06fh,020h,027h,098h,078h,050h,077h,098h,068h,020h,027h,050h,07eh,088h,03eh,030h	; b5bc  o '.xPw.h 'P~.>0
	defb 05ah,040h,07eh,070h,097h,0c8h,05bh,030h,087h,0d8h,08eh,040h,038h,060h,067h,0b8h	; b5cc  Z@~p..[0...@8`g.
	defb 057h,030h,09eh,090h,019h,0a0h,04eh,0e8h,028h,050h,067h,098h,03ah,020h,067h,088h	; b5dc  W0....N.(Pg.: g.
	defb 08dh,020h,098h,090h,047h,0cch	; b5ec

; ----------------------------------------------------------------------
; DATOS huecos_B5F2: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 3-0 (30 bytes)
;   0xb5f2..0xb610  (30 bytes)
DATA_huecos_B5F2:
	defb 077h,078h,01eh,020h,02eh,020h,029h,050h,097h,088h,08dh,0b0h,027h,0c8h,027h,0c8h	; b5f2  wx. . )P....'.'.
	defb 028h,050h,027h,0d8h,05bh,070h,097h,098h,058h,098h,028h,060h,087h,0cch	; b602  (P'.[p..X.(`..

; ----------------------------------------------------------------------
; DATOS huecos_B610: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 3-1 (32 bytes)
;   0xb610..0xb630  (32 bytes)
DATA_huecos_B610:
	defb 037h,030h,08eh,080h,03eh,0d8h,03dh,040h,027h,0b8h,047h,0b8h,087h,078h,087h,058h	; b610  70..>.=@'.G..x.X
	defb 06ch,030h,04bh,090h,08fh,0c8h,019h,060h,07ch,088h,08eh,010h,08eh,020h,057h,09ch	; b620  l0K....`|.... W.

; ----------------------------------------------------------------------
; DATOS huecos_B630: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 3-2 (50 bytes)
;   0xb630..0xb662  (50 bytes)
DATA_huecos_B630:
	defb 02bh,030h,057h,050h,04ch,0e8h,058h,040h,06eh,070h,06eh,080h,047h,0c8h,029h,030h	; b630  +0WPL.X@npn.G.)0
	defb 047h,0a0h,01eh,0b8h,08eh,040h,067h,098h,01dh,030h,077h,078h,07eh,020h,09bh,020h	; b640  G....@g..0wx~ .
	defb 037h,0a8h,058h,020h,09eh,090h,03eh,0b0h,04eh,0b8h,03ch,050h,03eh,060h,04eh,060h	; b650  7.X ..>.N.<P>`N`
	defb 027h,0cch	; b660

; ----------------------------------------------------------------------
; DATOS huecos_B662: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 3-3 (44 bytes)
;   0xb662..0xb68e  (44 bytes)
DATA_huecos_B662:
	defb 037h,030h,03eh,0c0h,04eh,0c0h,03eh,0d8h,09ch,010h,077h,060h,02bh,0c8h,05dh,020h	; b662  70>.N.>...w`+.]
	defb 097h,0e8h,027h,058h,067h,0c8h,05ch,090h,039h,0e8h,047h,020h,02eh,050h,07eh,020h	; b672  ..'Xg.\.9.G .P~
	defb 07eh,038h,077h,060h,02fh,0c8h,018h,040h,087h,078h,027h,0bch	; b682  ~8w`/..@.x'.

; ----------------------------------------------------------------------
; DATOS huecos_B68E: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 3-4 (32 bytes)
;   0xb68e..0xb6ae  (32 bytes)
DATA_huecos_B68E:
	defb 087h,030h,048h,070h,01eh,0b8h,09bh,060h,067h,098h,07ch,020h,098h,070h,089h,0d8h	; b68e  .0Hp...`g.| .p..
	defb 01eh,030h,01eh,040h,01eh,050h,067h,0a8h,06eh,070h,07eh,078h,097h,030h,03ch,04ch	; b69e  .0.@.Pg.np~x.0<L

; ----------------------------------------------------------------------
; DATOS huecos_B6AE: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 3-5 (40 bytes)
;   0xb6ae..0xb6d6  (40 bytes)
DATA_huecos_B6AE:
	defb 057h,058h,087h,080h,02bh,0d8h,018h,040h,069h,088h,08eh,020h,067h,068h,047h,030h	; b6ae  WX..+..@i.. ghG0
	defb 088h,0d8h,077h,0a8h,027h,040h,04eh,090h,04eh,0a0h,05eh,0a8h,04bh,030h,057h,068h	; b6be  ..w.'@N.N.^.K0Wh
	defb 097h,020h,018h,0b8h,05dh,030h,097h,0dch	; b6ce  . ..]0..

; ----------------------------------------------------------------------
; DATOS huecos_B6D6: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 3-6 (48 bytes)
;   0xb6d6..0xb706  (48 bytes)
DATA_huecos_B6D6:
	defb 057h,020h,038h,0c8h,02dh,080h,077h,0a8h,048h,010h,037h,030h,08bh,0d8h,037h,0b8h	; b6d6  W 8.-.w.H.70..7.
	defb 027h,010h,07eh,070h,02dh,098h,05ah,020h,087h,0e8h,047h,040h,058h,0d8h,02fh,040h	; b6e6  '.~p-.Z ..G@X./@
	defb 077h,098h,097h,010h,08eh,090h,098h,098h,047h,090h,07eh,0c0h,08eh,0c0h,07ah,0dch	; b6f6  w.......G.~...z.

; ----------------------------------------------------------------------
; DATOS huecos_B706: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 4-0 (46 bytes)
;   0xb706..0xb734  (46 bytes)
DATA_huecos_B706:
	defb 07bh,060h,087h,0b8h,027h,030h,088h,0c8h,097h,0c8h,07eh,040h,08eh,040h,07eh,050h	; b706  {`..'0....~@.@~P
	defb 089h,098h,047h,018h,097h,090h,04ch,0c0h,08eh,0c0h,09eh,0c8h,058h,040h,087h,060h	; b716  ..G...L.....X@.`
	defb 03dh,0c8h,027h,058h,01ch,040h,03eh,0e0h,047h,0e8h,087h,020h,098h,0dch	; b726  =.'X.@>.G.. ..

; ----------------------------------------------------------------------
; DATOS huecos_B734: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 4-1 (26 bytes)
;   0xb734..0xb74e  (26 bytes)
DATA_huecos_B734:
	defb 067h,050h,049h,0d8h,09bh,0b0h,037h,0e8h,077h,030h,07eh,088h,057h,070h,098h,0d8h	; b734  gPI...7.w0~.Wp..
	defb 027h,0a8h,08ch,010h,01eh,040h,017h,0b0h,08eh,0cch	; b744  '....@....

; ----------------------------------------------------------------------
; DATOS huecos_B74E: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 4-2 (50 bytes)
;   0xb74e..0xb780  (50 bytes)
DATA_huecos_B74E:
	defb 087h,030h,028h,098h,06eh,030h,07eh,030h,06eh,040h,077h,0c8h,07ch,040h,097h,0d8h	; b74e  .0(.n0~0n@w.|@..
	defb 017h,030h,06eh,030h,05eh,040h,06eh,048h,028h,030h,047h,0a8h,087h,0a8h,087h,048h	; b75e  .0n0^@nH(0G....H
	defb 09dh,010h,02eh,040h,03eh,060h,01bh,0b8h,038h,030h,097h,0d8h,057h,068h,04ch,098h	; b76e  ...@>`..80..WhL.
	defb 027h,05ch	; b77e

; ----------------------------------------------------------------------
; DATOS huecos_B780: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 4-3 (54 bytes)
;   0xb780..0xb7b6  (54 bytes)
DATA_huecos_B780:
	defb 087h,068h,017h,0a8h,027h,068h,08dh,040h,067h,0a8h,04ch,010h,027h,0b8h,04eh,070h	; b780  .h..'h.@g.L.'.Np
	defb 05eh,070h,05eh,080h,027h,0c8h,09eh,0a0h,09eh,0b0h,09eh,0c0h,087h,0d8h,037h,040h	; b790  ^p^.'.........7@
	defb 03fh,080h,098h,0a0h,01bh,0c8h,098h,030h,097h,090h,02eh,0b0h,03ch,0c8h,08eh,0c0h	; b7a0  ?......0....<...
	defb 09eh,0c0h,057h,0d0h,08eh,0dch	; b7b0

; ----------------------------------------------------------------------
; DATOS huecos_B7B6: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 4-4 (34 bytes)
;   0xb7b6..0xb7d8  (34 bytes)
DATA_huecos_B7B6:
	defb 027h,0d8h,027h,020h,02ch,0a8h,029h,050h,087h,0e8h,027h,050h,08eh,050h,048h,0d8h	; b7b6  '.' ,.)P..'P.PH.
	defb 077h,068h,017h,040h,078h,0b8h,057h,0c8h,027h,090h,09ch,078h,02dh,050h,087h,0d8h	; b7c6  wh.@x.W.'..x-P..
	defb 027h,0cch	; b7d6

; ----------------------------------------------------------------------
; DATOS huecos_B7D8: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 4-5 (44 bytes)
;   0xb7d8..0xb804  (44 bytes)
DATA_huecos_B7D8:
	defb 018h,020h,087h,0c8h,08eh,050h,02eh,070h,017h,0a0h,029h,0e8h,057h,088h,087h,050h	; b7d8  . ...P.p..).W..P
	defb 02bh,0b8h,027h,030h,038h,080h,01eh,0b0h,09eh,0b8h,03bh,040h,027h,098h,027h,058h	; b7e8  +.'08......@'.'X
	defb 017h,020h,069h,098h,017h,020h,058h,0a8h,06dh,060h,097h,0dch	; b7f8  . i.. X.m`..

; ----------------------------------------------------------------------
; DATOS huecos_B804: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 4-6 (48 bytes)
;   0xb804..0xb834  (48 bytes)
DATA_huecos_B804:
	defb 03ah,010h,087h,080h,09dh,0d8h,047h,020h,07bh,0b8h,037h,030h,04eh,090h,089h,0b8h	; b804  :.....G {.70N...
	defb 058h,060h,037h,0a8h,027h,030h,058h,020h,03ah,0c8h,027h,0c0h,03eh,060h,08eh,0c0h	; b814  X`7.'0X :.'.>`..
	defb 09eh,0c8h,087h,050h,078h,0b8h,02fh,030h,087h,0b8h,05bh,030h,088h,0c8h,057h,0ach	; b824  ...Px./0..[0..W.

; ----------------------------------------------------------------------
; DATOS huecos_B834: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 5-0 (38 bytes)
;   0xb834..0xb85a  (38 bytes)
DATA_huecos_B834:
	defb 077h,088h,037h,0b8h,058h,040h,037h,0c8h,057h,068h,047h,098h,087h,050h,08ch,0b8h	; b834  w.7.X@7.WhG..P..
	defb 067h,068h,028h,090h,08bh,0b8h,057h,040h,059h,0c8h,077h,068h,078h,038h,067h,050h	; b844  gh(...W@Y.whx8gP
	defb 06eh,0b0h,06eh,0c0h,01ch,0ech	; b854

; ----------------------------------------------------------------------
; DATOS huecos_B85A: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 5-1 (52 bytes)
;   0xb85a..0xb88e  (52 bytes)
DATA_huecos_B85A:
	defb 077h,058h,07dh,010h,08eh,010h,09eh,010h,037h,0a8h,057h,030h,04ch,0b8h,01eh,010h	; b85a  wX}.....7.W0L...
	defb 01eh,020h,067h,098h,02bh,030h,087h,088h,06eh,060h,05eh,070h,06eh,070h,027h,0a8h	; b86a  . g.+0..n`^pnp'.
	defb 058h,020h,05eh,050h,05eh,060h,057h,0a8h,077h,0b8h,037h,080h,07eh,080h,068h,0d8h	; b87a  X ^P^`W.w.7.~.h.
	defb 09fh,060h,087h,0bch	; b88a

; ----------------------------------------------------------------------
; DATOS huecos_B88E: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 5-2 (32 bytes)
;   0xb88e..0xb8ae  (32 bytes)
DATA_huecos_B88E:
	defb 077h,068h,04bh,088h,037h,040h,02dh,0c0h,07ch,0e8h,06eh,070h,06eh,080h,067h,0c8h	; b88e  whK.7@-.|.npn.g.
	defb 02ch,020h,077h,048h,027h,0c0h,08eh,0c0h,09eh,0c8h,03bh,030h,078h,0e8h,027h,0bch	; b89e  , wH'......0x.'.

; ----------------------------------------------------------------------
; DATOS huecos_B8AE: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 5-3 (58 bytes)
;   0xb8ae..0xb8e8  (58 bytes)
DATA_huecos_B8AE:
	defb 028h,038h,087h,010h,03dh,0b8h,03ch,048h,05eh,050h,06eh,050h,07eh,050h,067h,068h	; b8ae  (8..=.<H^PnP~Pgh
	defb 08ch,030h,04eh,090h,04eh,0a0h,05eh,0a8h,028h,040h,077h,088h,09ch,0e8h,07eh,020h	; b8be  .0N.N.^.(@w...~
	defb 07eh,030h,07eh,040h,017h,0c8h,08bh,080h,03eh,0c0h,04eh,0c0h,03eh,0d8h,07eh,040h	; b8ce  ~0~@....>.N.>.~@
	defb 08eh,040h,017h,0b8h,019h,060h,097h,098h,02dh,0ach	; b8de  .@...`..-.

; ----------------------------------------------------------------------
; DATOS huecos_B8E8: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 5-4 (36 bytes)
;   0xb8e8..0xb90c  (36 bytes)
DATA_huecos_B8E8:
	defb 08ch,020h,058h,040h,057h,0b8h,02eh,040h,04eh,070h,027h,0c0h,08eh,0c8h,087h,0b8h	; b8e8  . X@W..@Np'.....
	defb 027h,0b8h,047h,030h,09eh,090h,02bh,0a8h,017h,0a0h,029h,0e8h,047h,030h,04eh,0b8h	; b8f8  '.G0..+...).G0N.
	defb 057h,070h,058h,0cch	; b908

; ----------------------------------------------------------------------
; DATOS huecos_B90C: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 5-5 (50 bytes)
;   0xb90c..0xb93e  (50 bytes)
DATA_huecos_B90C:
	defb 019h,040h,087h,0b8h,028h,078h,047h,030h,04eh,098h,039h,048h,027h,040h,06eh,090h	; b90c  .@..(xG0N.9H'@n.
	defb 07eh,090h,09dh,0b8h,000h,008h,077h,068h,05bh,040h,05eh,080h,017h,088h,087h,040h	; b91c  ~.....wh[@^....@
	defb 048h,0d8h,08eh,040h,08eh,050h,087h,068h,087h,060h,058h,0d8h,000h,008h,000h,008h	; b92c  H..@.P.h.`X.....
	defb 087h,0dch	; b93c

; ----------------------------------------------------------------------
; DATOS huecos_B93E: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 5-6 (50 bytes)
;   0xb93e..0xb970  (50 bytes)
DATA_huecos_B93E:
	defb 047h,030h,05eh,090h,05eh,0a0h,05eh,0b8h,088h,020h,06eh,070h,047h,0c0h,09ah,0e8h	; b93e  G0^.^.^.. npG...
	defb 057h,020h,02fh,078h,088h,020h,087h,048h,068h,030h,027h,078h,06bh,040h,077h,098h	; b94e  W /x. .Hh0'xk@w.
	defb 048h,020h,087h,050h,04ah,0c8h,06dh,060h,017h,0a8h,03bh,010h,017h,068h,087h,070h	; b95e  H .PJ.m`.....h.p
	defb 048h,0dch	; b96e

; ----------------------------------------------------------------------
; DATOS huecos_B970: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 6-0 (54 bytes)
;   0xb970..0xb9a6  (54 bytes)
DATA_huecos_B970:
	defb 097h,070h,01ch,0b8h,08eh,010h,08eh,040h,08eh,050h,047h,0c8h,077h,068h,02eh,070h	; b970  .p.....@.PG.wh.p
	defb 01ch,0a0h,077h,0b8h,068h,030h,087h,078h,06eh,060h,05eh,070h,06eh,070h,027h,0a8h	; b980  ..w.h0.xn`^pnp'.
	defb 09eh,050h,08eh,060h,09eh,060h,097h,0c8h,017h,010h,058h,070h,02bh,0b8h,05dh,040h	; b990  .P.`.`....Xp+.]@
	defb 087h,0c8h,077h,070h,029h,0cch	; b9a0

; ----------------------------------------------------------------------
; DATOS huecos_B9A6: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 6-1 (32 bytes)
;   0xb9a6..0xb9c6  (32 bytes)
DATA_huecos_B9A6:
	defb 087h,0b8h,02bh,0a8h,077h,098h,087h,078h,048h,020h,02fh,040h,09eh,090h,017h,0a8h	; b9a6  ..+.w..xH /@....
	defb 02dh,040h,067h,0b8h,018h,080h,097h,088h,027h,050h,068h,0c0h,08eh,0c0h,09eh,0cch	; b9b6  -@g.....'Ph.....

; ----------------------------------------------------------------------
; DATOS huecos_B9C6: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 6-2 (56 bytes)
;   0xb9c6..0xb9fe  (56 bytes)
DATA_huecos_B9C6:
	defb 037h,060h,078h,0c8h,06eh,070h,06eh,080h,087h,0a8h,069h,020h,027h,098h,06eh,070h	; b9c6  7`x.npn...i '.np
	defb 06eh,080h,087h,0c8h,018h,030h,077h,040h,078h,0d8h,027h,030h,08eh,030h,09eh,030h	; b9d6  n....0w@x.'0.0.0
	defb 08eh,048h,02bh,030h,047h,0a8h,027h,078h,027h,030h,08dh,020h,03eh,0c0h,03eh,0d8h	; b9e6  .H+0G.'x'0. >.>.
	defb 067h,038h,000h,008h,01ch,060h,097h,09ch	; b9f6  g8...`..

; ----------------------------------------------------------------------
; DATOS huecos_B9FE: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 6-3 (50 bytes)
;   0xb9fe..0xba30  (50 bytes)
DATA_huecos_B9FE:
	defb 01eh,0b0h,01eh,0c0h,02eh,0c0h,027h,0e8h,05ch,060h,067h,098h,017h,040h,05eh,040h	; b9fe  ......'.\`g..@^@
	defb 08ch,048h,01bh,040h,047h,088h,037h,020h,05eh,0a0h,06eh,0a0h,04ch,0b8h,097h,010h	; ba0e  .H.@G.7 ^.n.L...
	defb 07eh,020h,07eh,030h,07eh,048h,077h,030h,058h,098h,03eh,020h,07eh,040h,097h,0a0h	; ba1e  ~ ~0~Hw0X.> ~@..
	defb 02fh,0ech	; ba2e

; ----------------------------------------------------------------------
; DATOS huecos_BA30: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 6-4 (36 bytes)
;   0xba30..0xba54  (36 bytes)
DATA_huecos_BA30:
	defb 087h,058h,097h,070h,02bh,0e8h,087h,020h,068h,098h,08eh,040h,08eh,050h,02dh,060h	; ba30  .X.p+.. h..@.P-`
	defb 087h,0c8h,029h,030h,077h,088h,01eh,020h,01eh,030h,077h,048h,03ch,040h,04eh,090h	; ba40  ..)0w.. .0wH<@N.
	defb 097h,0e8h,017h,05ch	; ba50

; ----------------------------------------------------------------------
; DATOS huecos_BA54: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 6-5 (40 bytes)
;   0xba54..0xba7c  (40 bytes)
DATA_huecos_BA54:
	defb 017h,020h,049h,070h,088h,0d8h,04eh,060h,097h,088h,05dh,020h,057h,0d8h,000h,008h	; ba54  . Ip..N`..] W...
	defb 03bh,030h,037h,0c8h,077h,0a8h,097h,020h,02eh,0b0h,03eh,0c8h,09bh,040h,037h,0a8h	; ba64  .07.w.. ..>..@7.
	defb 027h,020h,09dh,098h,098h,060h,077h,0bch	; ba74  ' ...`w.

; ----------------------------------------------------------------------
; DATOS huecos_BA7C: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 6-6 (68 bytes)
;   0xba7c..0xbac0  (68 bytes)
DATA_huecos_BA7C:
	defb 05bh,020h,017h,040h,05eh,040h,098h,048h,08eh,030h,09eh,030h,08eh,040h,067h,098h	; ba7c  [ .@^@.H.0.0.@g.
	defb 027h,080h,05dh,0d8h,01ah,0a8h,078h,010h,057h,030h,04eh,0e0h,09fh,0e8h,05eh,040h	; ba8c  '.]...x.W0N...^@
	defb 067h,040h,04eh,050h,05eh,058h,089h,040h,057h,0d8h,058h,040h,087h,098h,06dh,010h	; ba9c  g@NP^X.@W.X@..m.
	defb 087h,078h,09eh,040h,09eh,050h,09ah,0c0h,037h,0e8h,027h,030h,07bh,088h,08dh,050h	; baac  .x.@.P..7.'0{..P
	defb 018h,090h,077h,0cch	; babc

; ----------------------------------------------------------------------
; DATOS huecos_BAC0: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 7-0 (36 bytes)
;   0xbac0..0xbae4  (36 bytes)
DATA_huecos_BAC0:
	defb 01ch,050h,087h,088h,027h,020h,078h,0a8h,02eh,050h,01eh,080h,02eh,080h,027h,0e8h	; bac0  .P..' x..P....'.
	defb 02dh,040h,058h,090h,097h,0c8h,057h,040h,02bh,0a0h,089h,0c8h,06eh,050h,06eh,060h	; bad0  -@X...W@+...nPn`
	defb 06eh,070h,097h,0dch	; bae0

; ----------------------------------------------------------------------
; DATOS huecos_BAE4: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 7-1 (52 bytes)
;   0xbae4..0xbb18  (52 bytes)
DATA_huecos_BAE4:
	defb 077h,030h,01eh,090h,02eh,098h,04bh,080h,05eh,088h,09eh,050h,08eh,060h,09eh,060h	; bae4  w0....K.^..P.`.`
	defb 097h,0d8h,03ch,040h,098h,060h,027h,0a8h,078h,030h,027h,050h,07eh,088h,07eh,020h	; baf4  ..<@.`'.x0'P~.~
	defb 087h,020h,02bh,0c8h,07eh,0a0h,07eh,0b0h,05eh,0c0h,07ch,0c8h,07eh,020h,07eh,030h	; bb04  . +.~.~.^.|.~ ~0
	defb 057h,090h,01fh,0dch	; bb14

; ----------------------------------------------------------------------
; DATOS huecos_BB18: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 7-2 (54 bytes)
;   0xbb18..0xbb4e  (54 bytes)
DATA_huecos_BB18:
	defb 04bh,020h,087h,078h,087h,040h,01dh,0c8h,087h,020h,07eh,080h,08eh,080h,07eh,098h	; bb18  K .x.@... ~...~.
	defb 019h,030h,06eh,0b0h,06eh,0c0h,027h,0e8h,087h,080h,05eh,0b8h,03eh,020h,08eh,040h	; bb28  .0n.n.'...^.> .@
	defb 01ch,0a0h,097h,0c8h,067h,070h,038h,0c8h,087h,068h,097h,080h,04ch,0c8h,06eh,040h	; bb38  ....gp8..h..L.n@
	defb 07eh,040h,08eh,040h,067h,08ch	; bb48

; ----------------------------------------------------------------------
; DATOS huecos_BB4E: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 7-3 (46 bytes)
;   0xbb4e..0xbb7c  (46 bytes)
DATA_huecos_BB4E:
	defb 037h,088h,067h,020h,028h,0b0h,08eh,0c0h,09eh,0c8h,037h,0a8h,087h,050h,05dh,0b8h	; bb4e  7.g (.....7..P].
	defb 037h,058h,017h,010h,08eh,040h,04ch,098h,097h,030h,05fh,0c8h,057h,070h,028h,0c8h	; bb5e  7X...@L..0_.Wp(.
	defb 057h,030h,03eh,0b0h,04eh,0b0h,04eh,0c8h,09ch,010h,048h,030h,027h,0cch	; bb6e  W0>.N.N...H0'.

; ----------------------------------------------------------------------
; DATOS huecos_BB7C: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; se
;   solapan 2 bloques (0xBB7C-0xBBE8, 0xBB9C-0xBBE8); lo leen zona 7-4, zona
;   7-5 (108 bytes)
;   0xbb7c..0xbbe8  (108 bytes)
DATA_huecos_BB7C:
	defb 047h,030h,04eh,098h,097h,070h,019h,0c8h,028h,030h,077h,068h,047h,0c8h,057h,028h	; bb7c  G0N..p..(0whG.W(
	defb 02dh,030h,097h,078h,057h,098h,017h,020h,05ch,038h,058h,030h,057h,0d8h,028h,078h	; bb8c  -0.xW.. \8X0W.(x
	defb 05eh,040h,09ah,048h,017h,020h,069h,0b8h,057h,028h,097h,060h,02bh,0c8h,087h,088h	; bb9c  ^@.H. i.W(.`+...
	defb 089h,078h,087h,058h,057h,078h,087h,050h,088h,0c8h,018h,040h,027h,0e8h,09dh,040h	; bbac  .x.XWx.P...@'..@
	defb 068h,080h,028h,0b8h,067h,098h,087h,0e8h,057h,0c8h,048h,030h,09dh,0b8h,087h,090h	; bbbc  h.(.g...W.H0....
	defb 01ah,0d8h,027h,048h,000h,008h,01bh,020h,097h,058h,06eh,040h,07eh,040h,08eh,048h	; bbcc  ..'H... .Xn@~@.H
	defb 018h,020h,029h,0d8h,027h,0e0h,04eh,0e0h,05eh,0e0h,06eh,0ech	; bbdc  . ).'.N.^.n.

; ----------------------------------------------------------------------
; DATOS huecos_BBE8: parejas [x | figura][y | banderas] que p02:9239 copia a
;   0xCDE0, cuatro por pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra
;   el pasadizo y rellena lo que falta con 0xFF; el bit 2 acaba la lista; lo
;   leen zona 7-6 (46 bytes)
;   0xbbe8..0xbc16  (46 bytes)
DATA_huecos_BBE8:
	defb 088h,030h,047h,0c8h,08eh,060h,08eh,070h,08ah,088h,097h,030h,068h,080h,019h,0d8h	; bbe8  .0G..`.p...0h...
	defb 07eh,020h,08eh,020h,07eh,030h,087h,0b8h,037h,020h,02fh,080h,08eh,0c0h,08dh,0d8h	; bbf8  ~ . ~0..7 /.....
	defb 059h,020h,047h,0a8h,027h,010h,098h,098h,09bh,030h,038h,060h,097h,0dch	; bc08  Y G.'....08`..

; ----------------------------------------------------------------------
; DATOS textos_de_cada_zona: 35 punteros, uno por (fase x 5 + zona - 1), al
;   texto que p02:962F escribe con p00:42E1 al llegar; lo leen p02:9625 (70
;   bytes)
;   0xbc16..0xbc5c  (70 bytes)
DATA_textos_de_cada_zona:
	defb 05ch,0bch,06ch,0bch,07fh,0bch,092h,0bch,0a6h,0bch,0b8h,0bch,0cah,0bch,0dch,0bch	; bc16  \.l.............
	defb 0eeh,0bch,000h,0bdh,013h,0bdh,025h,0bdh,036h,0bdh,049h,0bdh,05ch,0bdh,06fh,0bdh	; bc26  ......%.6.I.\.o.
	defb 083h,0bdh,097h,0bdh,0a8h,0bdh,0bah,0bdh,0cdh,0bdh,0e0h,0bdh,0f0h,0bdh,002h,0beh	; bc36  ................
	defb 016h,0beh,029h,0beh,03dh,0beh,04fh,0beh,063h,0beh,07ah,0beh,08dh,0beh,0a4h,0beh	; bc46  ..).=.O.c.z.....
	defb 0b9h,0beh,0cch,0beh,0e0h,0beh	; bc56

; ----------------------------------------------------------------------
; DATOS texto_BC5C: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (16
;   bytes)
;   0xbc5c..0xbc6c  (16 bytes)
DATA_texto_BC5C:
	defb 04eh,03ch,063h,049h,000h,04dh,05dh,048h,000h,039h,042h,03bh,056h,04ch,063h,0ffh	; bc5c  N<cI.M]H.9B.VLc.

; ----------------------------------------------------------------------
; DATOS texto_BC6C: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbc6c..0xbc7f  (19 bytes)
DATA_texto_BC6C:
	defb 041h,035h,05eh,042h,000h,04ch,063h,05dh,057h,044h,000h,03bh,063h,061h,032h,04dh	; bc6c  A5^B.Lc]WD..ca2M
	defb 032h,053h,0ffh	; bc7c

; ----------------------------------------------------------------------
; DATOS texto_BC7F: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbc7f..0xbc92  (19 bytes)
DATA_texto_BC7F:
	defb 034h,04eh,052h,057h,030h,058h,043h,000h,03bh,063h,061h,032h,04dh,032h,000h,04bh	; bc7f  4NRW0XC..ca2M2.K
	defb 033h,058h,0ffh	; bc8f

; ----------------------------------------------------------------------
; DATOS texto_BC92: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (20
;   bytes)
;   0xbc92..0xbca6  (20 bytes)
DATA_texto_BC92:
	defb 047h,039h,045h,000h,039h,049h,063h,05dh,000h,04bh,063h,03fh,045h,000h,03bh,05dh	; bc92  G9E.9Ic].Kc?E..]
	defb 03bh,063h,060h,0ffh	; bca2

; ----------------------------------------------------------------------
; DATOS texto_BCA6: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (18
;   bytes)
;   0xbca6..0xbcb8  (18 bytes)
DATA_texto_BCA6:
	defb 041h,036h,063h,049h,000h,03ch,042h,066h,03bh,063h,026h,03fh,063h,000h,054h,038h	; bca6  A6cI.<Bf.c&?c.T8
	defb 05eh,0ffh	; bcb6

; ----------------------------------------------------------------------
; DATOS texto_BCB8: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (18
;   bytes)
;   0xbcb8..0xbcca  (18 bytes)
DATA_texto_BCB8:
	defb 03fh,05dh,049h,063h,03ah,03ah,053h,04eh,000h,031h,048h,03bh,03bh,000h,032h,04eh	; bcb8  ?]Ic::SN.1H...2N
	defb 031h,0ffh	; bcc8

; ----------------------------------------------------------------------
; DATOS texto_BCCA: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (18
;   bytes)
;   0xbcca..0xbcdc  (18 bytes)
DATA_texto_BCCA:
	defb 035h,031h,049h,063h,056h,039h,032h,039h,032h,000h,05bh,035h,063h,04dh,063h,039h	; bcca  51IcV9292.[5cMc9
	defb 032h,0ffh	; bcda

; ----------------------------------------------------------------------
; DATOS texto_BCDC: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (18
;   bytes)
;   0xbcdc..0xbcee  (18 bytes)
DATA_texto_BCDC:
	defb 044h,05dh,042h,05eh,03fh,05eh,042h,000h,030h,031h,043h,063h,058h,000h,03fh,063h	; bcdc  D]B^?^B.01CcX.?c
	defb 031h,0ffh	; bcec

; ----------------------------------------------------------------------
; DATOS texto_BCEE: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (18
;   bytes)
;   0xbcee..0xbd00  (18 bytes)
DATA_texto_BCEE:
	defb 054h,038h,049h,063h,000h,054h,037h,04dh,043h,063h,000h,034h,037h,035h,063h,030h	; bcee  T8Ic.T7MCc.475c0
	defb 058h,0ffh	; bcfe

; ----------------------------------------------------------------------
; DATOS texto_BD00: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbd00..0xbd13  (19 bytes)
DATA_texto_BD00:
	defb 041h,036h,063h,049h,000h,03ch,042h,066h,03bh,063h,021h,023h,03fh,063h,000h,03eh	; bd00  A6cI.<Bf.c!#?c.>
	defb 059h,05eh,0ffh	; bd10

; ----------------------------------------------------------------------
; DATOS texto_BD13: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (18
;   bytes)
;   0xbd13..0xbd25  (18 bytes)
DATA_texto_BD13:
	defb 03fh,04ah,063h,049h,000h,04fh,040h,03ch,063h,059h,000h,055h,049h,000h,044h,03ah	; bd13  ?JcI.O@<cY.UI.D:
	defb 038h,0ffh	; bd23

; ----------------------------------------------------------------------
; DATOS texto_BD25: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (17
;   bytes)
;   0xbd25..0xbd36  (17 bytes)
DATA_texto_BD25:
	defb 048h,05eh,042h,036h,03fh,036h,03fh,000h,030h,066h,039h,057h,05fh,039h,057h,05fh	; bd25  H^B6?6?.0f9W_9W_
	defb 0ffh	; bd35

; ----------------------------------------------------------------------
; DATOS texto_BD36: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbd36..0xbd49  (19 bytes)
DATA_texto_BD36:
	defb 043h,036h,051h,036h,048h,000h,03ch,042h,066h,03bh,063h,037h,057h,030h,000h,03bh	; bd36  C6Q6H.<Bf.c7W0..
	defb 063h,05fh,0ffh	; bd46

; ----------------------------------------------------------------------
; DATOS texto_BD49: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbd49..0xbd5c  (19 bytes)
DATA_texto_BD49:
	defb 03ah,035h,03dh,042h,000h,03ah,035h,03dh,042h,000h,052h,052h,031h,05ah,000h,03ch	; bd49  :5=B.:5=B.RR1Z.<
	defb 058h,051h,0ffh	; bd59

; ----------------------------------------------------------------------
; DATOS texto_BD5C: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbd5c..0xbd6f  (19 bytes)
DATA_texto_BD5C:
	defb 041h,036h,063h,049h,000h,03ch,042h,066h,03bh,063h,022h,020h,03fh,063h,000h,043h	; bd5c  A6cI.<Bf.c" ?c.C
	defb 034h,05eh,0ffh	; bd6c

; ----------------------------------------------------------------------
; DATOS texto_BD6F: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (20
;   bytes)
;   0xbd6f..0xbd83  (20 bytes)
DATA_texto_BD6F:
	defb 053h,059h,049h,063h,000h,053h,058h,04dh,043h,063h,000h,030h,03bh,063h,035h,063h	; bd6f  SYIc.SXMCc.0.c5c
	defb 042h,063h,058h,0ffh	; bd7f

; ----------------------------------------------------------------------
; DATOS texto_BD83: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (20
;   bytes)
;   0xbd83..0xbd97  (20 bytes)
DATA_texto_BD83:
	defb 039h,044h,04fh,048h,000h,05bh,066h,04bh,062h,05ah,000h,03dh,063h,05dh,051h,05dh	; bd83  9DOH.[fKbZ.=c]Q]
	defb 037h,057h,030h,0ffh	; bd93

; ----------------------------------------------------------------------
; DATOS texto_BD97: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (17
;   bytes)
;   0xbd97..0xbda8  (17 bytes)
DATA_texto_BD97:
	defb 044h,05dh,03fh,063h,000h,044h,05dh,03fh,063h,000h,044h,05dh,044h,05dh,03fh,063h	; bd97  D]?c.D]?c.D]D]?c
	defb 0ffh	; bda7

; ----------------------------------------------------------------------
; DATOS texto_BDA8: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (18
;   bytes)
;   0xbda8..0xbdba  (18 bytes)
DATA_texto_BDA8:
	defb 036h,030h,031h,05ch,000h,031h,059h,042h,000h,03eh,059h,03eh,059h,03eh,059h,03eh	; bda8  601\.1YB.>Y>Y>Y>
	defb 059h,0ffh	; bdb8

; ----------------------------------------------------------------------
; DATOS texto_BDBA: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbdba..0xbdcd  (19 bytes)
DATA_texto_BDBA:
	defb 041h,036h,063h,049h,000h,03ch,042h,066h,03bh,063h,022h,027h,03fh,063h,000h,053h	; bdba  A6cI.<Bf.c"'?c.S
	defb 030h,05eh,0ffh	; bdca

; ----------------------------------------------------------------------
; DATOS texto_BDCD: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbdcd..0xbde0  (19 bytes)
DATA_texto_BDCD:
	defb 044h,03eh,063h,051h,037h,000h,03bh,035h,038h,045h,000h,040h,035h,063h,03ah,05bh	; bdcd  D>cQ7..58E.@5c:[
	defb 037h,063h,0ffh	; bddd

; ----------------------------------------------------------------------
; DATOS texto_BDE0: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (16
;   bytes)
;   0xbde0..0xbdf0  (16 bytes)
DATA_texto_BDE0:
	defb 039h,039h,056h,042h,063h,000h,03ch,039h,03bh,000h,053h,03ch,04eh,05dh,035h,0ffh	; bde0  99VBc.<9..S<N]5.

; ----------------------------------------------------------------------
; DATOS texto_BDF0: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (18
;   bytes)
;   0xbdf0..0xbe02  (18 bytes)
DATA_texto_BDF0:
	defb 03ch,042h,066h,03bh,063h,037h,057h,030h,03fh,063h,000h,04dh,04dh,031h,048h,04dh	; bdf0  <Bf.c7W0?c.MM1HM
	defb 031h,0ffh	; be00

; ----------------------------------------------------------------------
; DATOS texto_BE02: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (20
;   bytes)
;   0xbe02..0xbe16  (20 bytes)
DATA_texto_BE02:
	defb 041h,035h,05eh,042h,000h,04ch,063h,05dh,057h,044h,000h,035h,037h,03bh,039h,04eh	; be02  A5^B.Lc]WD.57.9N
	defb 05dh,043h,063h,0ffh	; be12

; ----------------------------------------------------------------------
; DATOS texto_BE16: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbe16..0xbe29  (19 bytes)
DATA_texto_BE16:
	defb 041h,036h,063h,049h,000h,03ch,042h,066h,03bh,063h,023h,024h,03fh,063h,000h,04dh	; be16  A6cI.<Bf.c#$?c.M
	defb 057h,05fh,0ffh	; be26

; ----------------------------------------------------------------------
; DATOS texto_BE29: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (20
;   bytes)
;   0xbe29..0xbe3d  (20 bytes)
DATA_texto_BE29:
	defb 05bh,049h,049h,049h,049h,000h,031h,05eh,04dh,062h,05dh,000h,043h,056h,059h,04eh	; be29  [IIII.1^Mb].CVYN
	defb 03bh,03fh,044h,0ffh	; be39

; ----------------------------------------------------------------------
; DATOS texto_BE3D: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (18
;   bytes)
;   0xbe3d..0xbe4f  (18 bytes)
DATA_texto_BE3D:
	defb 035h,037h,03bh,039h,04eh,05dh,043h,063h,049h,000h,04fh,041h,035h,05eh,03fh,035h	; be3d  57.9N]CcI.OA5^?5
	defb 044h,0ffh	; be4d

; ----------------------------------------------------------------------
; DATOS texto_BE4F: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (20
;   bytes)
;   0xbe4f..0xbe63  (20 bytes)
DATA_texto_BE4F:
	defb 036h,061h,03fh,063h,031h,044h,000h,032h,051h,04dh,063h,03bh,000h,04eh,058h,035h	; be4f  6a?c1D.2QMc..NX5
	defb 03bh,063h,057h,0ffh	; be5f

; ----------------------------------------------------------------------
; DATOS texto_BE63: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (23
;   bytes)
;   0xbe63..0xbe7a  (23 bytes)
DATA_texto_BE63:
	defb 03fh,04ah,063h,054h,035h,049h,063h,000h,031h,041h,035h,049h,030h,03fh,058h,000h	; be63  ?JcT5Ic.1A5I0?X.
	defb 033h,043h,063h,048h,04eh,040h,0ffh	; be73

; ----------------------------------------------------------------------
; DATOS texto_BE7A: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbe7a..0xbe8d  (19 bytes)
DATA_texto_BE7A:
	defb 041h,036h,063h,049h,000h,03ch,042h,066h,03bh,063h,024h,021h,03fh,063h,000h,03fh	; be7a  A6cI.<Bf.c$!?c.?
	defb 030h,05eh,0ffh	; be8a

; ----------------------------------------------------------------------
; DATOS texto_BE8D: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (23
;   bytes)
;   0xbe8d..0xbea4  (23 bytes)
DATA_texto_BE8D:
	defb 033h,043h,063h,048h,04eh,040h,000h,031h,05eh,036h,031h,05eh,036h,042h,063h,000h	; be8d  3CcHN@.1^61^6Bc.
	defb 043h,05eh,03bh,05dh,03fh,063h,0ffh	; be9d

; ----------------------------------------------------------------------
; DATOS texto_BEA4: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (21
;   bytes)
;   0xbea4..0xbeb9  (21 bytes)
DATA_texto_BEA4:
	defb 039h,039h,04eh,042h,063h,037h,059h,049h,063h,000h,030h,043h,049h,000h,039h,05dh	; bea4  99NBc7YIc.0CI.9]
	defb 03bh,063h,061h,032h,0ffh	; beb4

; ----------------------------------------------------------------------
; DATOS texto_BEB9: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (19
;   bytes)
;   0xbeb9..0xbecc  (19 bytes)
DATA_texto_BEB9:
	defb 035h,037h,03bh,039h,04eh,05dh,043h,063h,000h,036h,04fh,040h,05fh,05dh,038h,063h	; beb9  57.9N]Cc.6O@_]8c
	defb 05dh,036h,0ffh	; bec9

; ----------------------------------------------------------------------
; DATOS texto_BECC: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (20
;   bytes)
;   0xbecc..0xbee0  (20 bytes)
DATA_texto_BECC:
	defb 039h,039h,04eh,042h,063h,037h,059h,049h,063h,000h,030h,05dh,03fh,049h,000h,04bh	; becc  99NBc7YIc.0]?I.K
	defb 062h,05ah,055h,0ffh	; bedc

; ----------------------------------------------------------------------
; DATOS texto_BEE0: texto que p00:42F1 escribe letra a letra (0xFF o 0xE0
;   acaba, 0xFE baja una fila, 0xE1-0xFD dejan hueco); lo leen p02:962F (25
;   bytes)
;   0xbee0..0xbef9  (25 bytes)
DATA_texto_BEE0:
	defb 041h,036h,063h,049h,000h,033h,043h,063h,03bh,063h,061h,032h,000h,043h,041h,045h	; bee0  A6cI.3Cc.ca2.CAE
	defb 060h,032h,03fh,063h,000h,05bh,034h,05eh,0ffh	; bef0  `2?c.[4^.

; ----------------------------------------------------------------------
; DATOS relleno_15: 263 bytes 0xFF hasta el final del banco: relleno, no lo
;   lee nadie (263 bytes)
;   0xbef9..0xc000  (263 bytes)
DATA_relleno_15:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bef9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf09  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf29  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf39  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf49  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf59  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf69  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf79  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf89  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf99  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfa9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfb9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff9
