; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX2 - MegaROM RC-748 de 128 KB (Konami4) - banco 13 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS pantallas_de_cada_juego: 6 punteros, uno por juego de graficos
;   (0xC289): las pantallas de ese juego, en rle; p00:4295 las descomprime en
;   0xD000 (48 bytes cada una); lo leen p00:429C (12 bytes)
;   0x6000..0x600c  (12 bytes)
DATA_pantallas_de_cada_juego:
	defb 034h,063h,077h,064h,0dch,06eh,083h,070h,0d0h,066h,08eh,069h	; 6000  4cwd.n.p.f.i

; ----------------------------------------------------------------------
; DATOS rejilla_de_cada_zona: 49 punteros, uno por zona (fase x 7 + zona): la
;   rejilla de pantallas que p00:5311 copia en 0xE700; lo leen p00:5317 (98
;   bytes)
;   0x600c..0x606e  (98 bytes)
DATA_rejilla_de_cada_zona:
	defb 06eh,060h,07ah,060h,081h,060h,089h,060h,093h,060h,0a8h,060h,0ceh,060h,0a0h,060h	; 600c  n`z`.`.`.`.`.`.`
	defb 01ah,061h,024h,061h,030h,061h,010h,061h,04ah,061h,070h,061h,039h,061h,0b6h,061h	; 601c  .a$a0a.aJapa9a.a
	defb 0bfh,061h,0c8h,061h,0d1h,061h,0ddh,061h,009h,062h,059h,062h,067h,062h,0b8h,062h	; 602c  .a.a.a.a.bYbgb.b
	defb 070h,062h,07fh,062h,0a8h,060h,0ceh,060h,08eh,062h,06eh,060h,0adh,062h,081h,060h	; 603c  pb.b.`.`.bn`.b.`
	defb 0bfh,061h,04ah,061h,070h,061h,0c3h,062h,039h,061h,0ceh,062h,01ah,061h,07fh,062h	; 604c  .aJapa.b9a.b.a.b
	defb 0ddh,061h,0ceh,060h,0ddh,062h,0a0h,060h,0b8h,062h,023h,063h,09dh,062h,0e9h,062h	; 605c  .a.`.b.`.b#c.b.b
	defb 009h,062h	; 606c

; ----------------------------------------------------------------------
; DATOS rejilla_606E: rejilla de pantallas de una zona: 24 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 1-0, zona 5-1 (12
;   bytes)
;   0x606e..0x607a  (12 bytes)
DATA_rejilla_606E:
	defb 001h,023h,041h,042h,042h,01fh,001h,023h,045h,067h,09ah,07bh	; 606e  .#ABB..#Eg.{

; ----------------------------------------------------------------------
; DATOS rejilla_607A: rejilla de pantallas de una zona: 14 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 1-1 (7 bytes)
;   0x607a..0x6081  (7 bytes)
DATA_rejilla_607A:
	defb 002h,018h,093h,045h,074h,098h,0afh	; 607a

; ----------------------------------------------------------------------
; DATOS rejilla_6081: rejilla de pantallas de una zona: 16 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 1-2, zona 5-3 (8
;   bytes)
;   0x6081..0x6089  (8 bytes)
DATA_rejilla_6081:
	defb 001h,023h,045h,067h,089h,0abh,0cdh,0efh	; 6081  .#Eg....

; ----------------------------------------------------------------------
; DATOS rejilla_6089: rejilla de pantallas de una zona: 20 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 1-3 (10 bytes)
;   0x6089..0x6093  (10 bytes)
DATA_rejilla_6089:
	defb 005h,032h,034h,026h,001h,026h,07bh,098h,098h,0bfh	; 6089  .24&.&{...

; ----------------------------------------------------------------------
; DATOS rejilla_6093: rejilla de pantallas de una zona: 26 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 1-4 (13 bytes)
;   0x6093..0x60a0  (13 bytes)
DATA_rejilla_6093:
	defb 002h,087h,060h,096h,002h,089h,036h,009h,086h,008h,074h,034h,0afh	; 6093  ..`...6...t4.

; ----------------------------------------------------------------------
; DATOS rejilla_60A0: rejilla de pantallas de una zona: 16 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 2-0, zona 7-1 (8
;   bytes)
;   0x60a0..0x60a8  (8 bytes)
DATA_rejilla_60A0:
	defb 021h,034h,042h,031h,069h,08fh,0aah,079h	; 60a0  !4B1i..y

; ----------------------------------------------------------------------
; DATOS rejilla_60A8: rejilla de pantallas de una zona: 38 casillas, un byte
;   cada una (p00:5311 copia siempre 128 bytes, y lo de mas es de la zona de
;   al lado); varias zonas la comparten; lo leen zona 1-5, zona 4-5 (38 bytes)
;   0x60a8..0x60ce  (38 bytes)
DATA_rejilla_60A8:
	defb 013h,015h,017h,016h,019h,018h,015h,016h,014h,016h,015h,01ah,00eh,011h,00fh,011h	; 60a8  ................
	defb 010h,012h,008h,009h,00bh,00dh,008h,00ch,009h,00dh,000h,001h,001h,002h,003h,004h	; 60b8  ................
	defb 003h,004h,006h,001h,001h,007h	; 60c8

; ----------------------------------------------------------------------
; DATOS rejilla_60CE: rejilla de pantallas de una zona: 66 casillas, un byte
;   cada una (p00:5311 copia siempre 128 bytes, y lo de mas es de la zona de
;   al lado); varias zonas la comparten; lo leen zona 1-6, zona 4-6, zona 6-6
;   (66 bytes)
;   0x60ce..0x6110  (66 bytes)
DATA_rejilla_60CE:
	defb 025h,027h,026h,028h,027h,029h,01ch,01dh,020h,01eh,021h,022h,01fh,023h,01ch,01eh	; 60ce  %'&(').. .!".#..
	defb 020h,021h,024h,023h,01ah,018h,01ah,019h,017h,018h,01ah,01ah,018h,019h,01ah,01bh	; 60de   !$#............
	defb 012h,014h,013h,016h,012h,014h,015h,016h,012h,013h,014h,016h,00bh,00dh,00eh,00ch	; 60ee  ................
	defb 00fh,00ch,00eh,010h,00dh,011h,007h,006h,007h,008h,006h,009h,000h,001h,002h,003h	; 60fe  ................
	defb 001h,004h	; 610e

; ----------------------------------------------------------------------
; DATOS rejilla_6110: rejilla de pantallas de una zona: 20 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 2-4 (10 bytes)
;   0x6110..0x611a  (10 bytes)
DATA_rejilla_6110:
	defb 014h,014h,024h,042h,032h,067h,097h,097h,07ah,08fh	; 6110  ..$B2g..z.

; ----------------------------------------------------------------------
; DATOS rejilla_611A: rejilla de pantallas de una zona: 20 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 2-1, zona 6-3 (10
;   bytes)
;   0x611a..0x6124  (10 bytes)
DATA_rejilla_611A:
	defb 00bh,012h,03ah,034h,056h,078h,094h,056h,0cdh,0efh	; 611a  ..:4Vx.V..

; ----------------------------------------------------------------------
; DATOS rejilla_6124: rejilla de pantallas de una zona: 24 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 2-2 (12 bytes)
;   0x6124..0x6130  (12 bytes)
DATA_rejilla_6124:
	defb 078h,0bah,0ach,002h,014h,02fh,078h,09ch,001h,034h,014h,056h	; 6124  x..../x..4.V

; ----------------------------------------------------------------------
; DATOS rejilla_6130: rejilla de pantallas de una zona: 18 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 2-3 (9 bytes)
;   0x6130..0x6139  (9 bytes)
DATA_rejilla_6130:
	defb 017h,08ah,0b0h,0cdh,0efh,025h,067h,08ah,0b1h	; 6130  .....%g..

; ----------------------------------------------------------------------
; DATOS rejilla_6139: rejilla de pantallas de una zona: 34 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 3-0, zona 6-1 (17
;   bytes)
;   0x6139..0x614a  (17 bytes)
DATA_rejilla_6139:
	defb 068h,0a9h,08bh,069h,089h,0afh,002h,031h,045h,004h,025h,003h,015h,032h,012h,031h	; 6139  h..i...1E.%..2.1
	defb 032h	; 6149

; ----------------------------------------------------------------------
; DATOS rejilla_614A: rejilla de pantallas de una zona: 38 casillas, un byte
;   cada una (p00:5311 copia siempre 128 bytes, y lo de mas es de la zona de
;   al lado); varias zonas la comparten; lo leen zona 2-5, zona 5-5 (38 bytes)
;   0x614a..0x6170  (38 bytes)
DATA_rejilla_614A:
	defb 013h,017h,018h,019h,018h,019h,014h,01ah,00eh,00fh,011h,012h,00eh,00fh,010h,012h	; 614a  ................
	defb 008h,00bh,00ch,00dh,008h,00ah,00bh,00ch,009h,00dh,000h,002h,004h,006h,001h,007h	; 615a  ................
	defb 000h,001h,002h,003h,006h,007h	; 616a

; ----------------------------------------------------------------------
; DATOS rejilla_6170: rejilla de pantallas de una zona: 70 casillas, un byte
;   cada una (p00:5311 copia siempre 128 bytes, y lo de mas es de la zona de
;   al lado); varias zonas la comparten; lo leen zona 2-6, zona 5-6 (70 bytes)
;   0x6170..0x61b6  (70 bytes)
DATA_rejilla_6170:
	defb 025h,026h,028h,029h,025h,028h,027h,028h,026h,029h,01eh,01fh,01ch,024h,01dh,020h	; 6170  %&()%('(&)...$.
	defb 022h,021h,01fh,020h,022h,01dh,01eh,023h,017h,019h,018h,01ah,018h,01bh,017h,018h	; 6180  "!. "..#........
	defb 019h,01bh,012h,015h,014h,013h,015h,016h,012h,014h,013h,016h,012h,014h,015h,016h	; 6190  ................
	defb 005h,006h,007h,008h,009h,006h,008h,006h,007h,008h,006h,00ah,000h,001h,002h,003h	; 61a0  ................
	defb 001h,004h,001h,001h,002h,003h	; 61b0

; ----------------------------------------------------------------------
; DATOS rejilla_61B6: rejilla de pantallas de una zona: 18 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 3-1 (9 bytes)
;   0x61b6..0x61bf  (9 bytes)
DATA_rejilla_61B6:
	defb 004h,037h,016h,009h,060h,012h,045h,038h,0afh	; 61b6  .7..`.E8.

; ----------------------------------------------------------------------
; DATOS rejilla_61BF: rejilla de pantallas de una zona: 18 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 3-2, zona 5-4 (9
;   bytes)
;   0x61bf..0x61c8  (9 bytes)
DATA_rejilla_61BF:
	defb 001h,042h,04fh,069h,07bh,001h,025h,0a9h,079h	; 61bf  .BOi{.%.y

; ----------------------------------------------------------------------
; DATOS rejilla_61C8: rejilla de pantallas de una zona: 18 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 3-3 (9 bytes)
;   0x61c8..0x61d1  (9 bytes)
DATA_rejilla_61C8:
	defb 099h,0b0h,0b0h,03ah,017h,084h,00bh,0cdh,0efh	; 61c8  ...:.....

; ----------------------------------------------------------------------
; DATOS rejilla_61D1: rejilla de pantallas de una zona: 24 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 3-4 (12 bytes)
;   0x61d1..0x61dd  (12 bytes)
DATA_rejilla_61D1:
	defb 001h,023h,045h,021h,032h,026h,001h,013h,045h,012h,032h,01fh	; 61d1  .#E!2&..E.2.

; ----------------------------------------------------------------------
; DATOS rejilla_61DD: rejilla de pantallas de una zona: 44 casillas, un byte
;   cada una (p00:5311 copia siempre 128 bytes, y lo de mas es de la zona de
;   al lado); varias zonas la comparten; lo leen zona 3-5, zona 6-5 (44 bytes)
;   0x61dd..0x6209  (44 bytes)
DATA_rejilla_61DD:
	defb 013h,017h,016h,019h,018h,01ah,013h,019h,018h,014h,015h,01ah,00eh,00fh,00fh,012h	; 61dd  ................
	defb 00eh,010h,00fh,012h,008h,009h,00ch,00dh,008h,00ah,00ch,00bh,00ch,009h,00bh,00dh	; 61ed  ................
	defb 000h,001h,001h,007h,000h,001h,002h,003h,004h,005h,006h,007h	; 61fd  ............

; ----------------------------------------------------------------------
; DATOS rejilla_6209: rejilla de pantallas de una zona: 80 casillas, un byte
;   cada una (p00:5311 copia siempre 128 bytes, y lo de mas es de la zona de
;   al lado); varias zonas la comparten; lo leen zona 3-6, zona 7-6 (80 bytes)
;   0x6209..0x6259  (80 bytes)
DATA_rejilla_6209:
	defb 026h,027h,01ch,01dh,020h,024h,022h,022h,021h,01dh,021h,022h,022h,020h,01eh,01fh	; 6209  &'.. $""!.!"" ..
	defb 01dh,023h,017h,01ah,018h,01bh,017h,018h,018h,01bh,017h,019h,018h,01bh,012h,013h	; 6219  .#..............
	defb 014h,015h,014h,016h,012h,015h,014h,014h,013h,016h,00bh,00dh,00ch,011h,00eh,00fh	; 6229  ................
	defb 010h,00ch,00bh,00dh,00fh,00ch,010h,011h,005h,008h,007h,006h,009h,00ah,005h,006h	; 6239  ................
	defb 007h,008h,009h,009h,008h,007h,008h,00ah,000h,001h,002h,003h,002h,003h,001h,004h	; 6249  ................

; ----------------------------------------------------------------------
; DATOS rejilla_6259: rejilla de pantallas de una zona: 28 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 4-0 (14 bytes)
;   0x6259..0x6267  (14 bytes)
DATA_rejilla_6259:
	defb 002h,046h,002h,034h,026h,079h,0ach,002h,016h,079h,0bch,079h,0b8h,09fh	; 6259  .F.4&y...y.y..

; ----------------------------------------------------------------------
; DATOS rejilla_6267: rejilla de pantallas de una zona: 18 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 4-1 (9 bytes)
;   0x6267..0x6270  (9 bytes)
DATA_rejilla_6267:
	defb 068h,09ah,09bh,09ah,079h,001h,025h,002h,01fh	; 6267  h...y.%..

; ----------------------------------------------------------------------
; DATOS rejilla_6270: rejilla de pantallas de una zona: 30 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 4-3 (15 bytes)
;   0x6270..0x627f  (15 bytes)
DATA_rejilla_6270:
	defb 07bh,0b8h,0afh,078h,0ach,004h,032h,016h,004h,032h,016h,079h,0bch,078h,09ch	; 6270  {..x..2..2.y.x.

; ----------------------------------------------------------------------
; DATOS rejilla_627F: rejilla de pantallas de una zona: 30 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 4-4, zona 6-4 (15
;   bytes)
;   0x627f..0x628e  (15 bytes)
DATA_rejilla_627F:
	defb 06ah,08ah,08bh,002h,04fh,068h,07ah,07bh,001h,032h,045h,067h,09bh,001h,035h	; 627f  j...Ohz{.2Eg..5

; ----------------------------------------------------------------------
; DATOS rejilla_628E: rejilla de pantallas de una zona: 30 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 5-0 (15 bytes)
;   0x628e..0x629d  (15 bytes)
DATA_rejilla_628E:
	defb 003h,025h,026h,002h,021h,04fh,004h,012h,013h,021h,026h,079h,09ch,079h,0bch	; 628e  .%&.!O...!&y.y.

; ----------------------------------------------------------------------
; DATOS rejilla_629D: rejilla de pantallas de una zona: 32 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 7-4 (16 bytes)
;   0x629d..0x62ad  (16 bytes)
DATA_rejilla_629D:
	defb 001h,024h,015h,068h,09ah,08bh,06ah,097h,08bh,069h,07fh,003h,024h,032h,015h,07ah	; 629d  .$.h..j..i..$2.z

; ----------------------------------------------------------------------
; DATOS rejilla_62AD: rejilla de pantallas de una zona: 22 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 5-2 (11 bytes)
;   0x62ad..0x62b8  (11 bytes)
DATA_rejilla_62AD:
	defb 008h,071h,036h,009h,086h,005h,089h,026h,004h,057h,0afh	; 62ad  .q6....&.W.

; ----------------------------------------------------------------------
; DATOS rejilla_62B8: rejilla de pantallas de una zona: 22 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 4-2, zona 7-2 (11
;   bytes)
;   0x62b8..0x62c3  (11 bytes)
DATA_rejilla_62B8:
	defb 023h,094h,056h,034h,000h,0cdh,0efh,012h,056h,078h,09ah	; 62b8  #.V4....Vx.

; ----------------------------------------------------------------------
; DATOS rejilla_62C3: rejilla de pantallas de una zona: 22 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 6-0 (11 bytes)
;   0x62c3..0x62ce  (11 bytes)
DATA_rejilla_62C3:
	defb 0a1h,078h,094h,056h,078h,012h,03ah,0cdh,0efh,012h,03ah	; 62c3  .x.Vx.:...:

; ----------------------------------------------------------------------
; DATOS rejilla_62CE: rejilla de pantallas de una zona: 30 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 6-2 (15 bytes)
;   0x62ce..0x62dd  (15 bytes)
DATA_rejilla_62CE:
	defb 002h,026h,006h,003h,032h,043h,053h,015h,045h,023h,04fh,079h,09ch,005h,016h	; 62ce  .&..2CS.E#Oy...

; ----------------------------------------------------------------------
; DATOS rejilla_62DD: rejilla de pantallas de una zona: 24 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 7-0 (12 bytes)
;   0x62dd..0x62e9  (12 bytes)
DATA_rejilla_62DD:
	defb 007h,054h,081h,079h,024h,0afh,008h,096h,006h,008h,041h,076h	; 62dd  .T.y$.....Av

; ----------------------------------------------------------------------
; DATOS rejilla_62E9: rejilla de pantallas de una zona: 58 casillas, un byte
;   cada una (p00:5311 copia siempre 128 bytes, y lo de mas es de la zona de
;   al lado); varias zonas la comparten; lo leen zona 7-5 (58 bytes)
;   0x62e9..0x6323  (58 bytes)
DATA_rejilla_62E9:
	defb 013h,016h,015h,014h,018h,019h,017h,01ah,013h,015h,014h,01ah,013h,016h,014h,019h	; 62e9  ................
	defb 018h,01ah,00eh,00fh,010h,012h,00eh,010h,011h,012h,00eh,00fh,011h,012h,008h,00ah	; 62f9  ................
	defb 009h,00ah,00ch,00dh,008h,00ch,00bh,00dh,008h,00bh,009h,00ah,00ch,00dh,000h,001h	; 6309  ................
	defb 002h,004h,006h,007h,000h,001h,002h,003h,006h,007h	; 6319  ..........

; ----------------------------------------------------------------------
; DATOS rejilla_6323: rejilla de pantallas de una zona: 34 casillas, medio
;   byte cada una (p00:5311 copia siempre 64 bytes, y lo de mas es de la zona
;   de al lado); varias zonas la comparten; lo leen zona 7-3 (17 bytes)
;   0x6323..0x6334  (17 bytes)
DATA_rejilla_6323:
	defb 078h,08bh,0a8h,0bah,0bfh,003h,042h,016h,0a8h,001h,024h,031h,045h,016h,078h,098h	; 6323  x.....B...$1E.x.
	defb 08ch	; 6333

; ----------------------------------------------------------------------
; DATOS pantallas_0: las pantallas del juego de graficos 0 en rle (0x42C3 las
;   deja en 0xD000): 8x6 bloques cada una; lo leen p00:42A6 (323 bytes)
;   0x6334..0x6477  (323 bytes)
DATA_pantallas_0:
	defb 093h,010h,011h,010h,00eh,010h,010h,011h,00eh,004h,016h,048h,030h,02dh,030h,02dh	; 6334  ...........H0-0-
	defb 030h,004h,018h,01ah,005h,000h,082h,01eh,01ch,006h,000h,082h,018h,01ah,006h,000h	; 6344  0...............
	defb 008h,01fh,002h,00dh,08eh,00eh,00fh,00fh,00eh,011h,010h,02dh,02dh,030h,014h,02fh	; 6354  ...........--0./
	defb 02dh,030h,02eh,018h,000h,008h,01fh,090h,00eh,008h,027h,009h,042h,043h,044h,00dh	; 6364  -0........'.BCD.
	defb 030h,00ah,04dh,00bh,040h,006h,041h,02fh,018h,000h,008h,01fh,090h,00dh,00eh,012h	; 6374  0.M.@.A/........
	defb 001h,002h,003h,00eh,00ch,02dh,030h,013h,005h,006h,007h,02eh,02dh,018h,000h,008h	; 6384  .....-0.....-...
	defb 01fh,090h,00eh,031h,032h,033h,034h,00fh,031h,032h,02dh,035h,036h,037h,038h,02eh	; 6394  ...1234.12-5678.
	defb 039h,03ah,012h,000h,081h,04bh,005h,000h,002h,01fh,081h,04ch,005h,01fh,090h,00eh	; 63a4  9:...K.....L....
	defb 033h,034h,00fh,011h,010h,010h,011h,02dh,03bh,03ch,030h,014h,047h,015h,004h,005h	; 63b4  34.....-;<0.G...
	defb 000h,083h,019h,017h,004h,006h,000h,082h,01bh,01dh,006h,000h,082h,019h,017h,008h	; 63c4  ................
	defb 01fh,002h,010h,091h,00ch,00eh,00fh,00fh,00eh,00eh,004h,016h,048h,02fh,02dh,02eh	; 63d4  ............H/-.
	defb 02dh,030h,004h,018h,01ah,005h,000h,082h,01eh,01ch,006h,000h,082h,018h,01ah,006h	; 63e4  -0..............
	defb 000h,008h,049h,090h,031h,032h,012h,00ch,031h,032h,033h,034h,039h,03ah,013h,02dh	; 63f4  ..I.12..12349:.-
	defb 035h,036h,03bh,03ch,018h,000h,008h,04ah,090h,020h,021h,022h,00ch,023h,027h,027h	; 6404  56;<...J. !".#''
	defb 028h,024h,025h,026h,02dh,029h,02ah,02bh,02ch,012h,000h,081h,04bh,005h,000h,002h	; 6414  ($%&-)*+,...K...
	defb 04ah,081h,04ch,005h,04ah,090h,03dh,03eh,03fh,008h,027h,009h,031h,032h,040h,006h	; 6424  J.L.J.=>?.'.12@.
	defb 041h,005h,006h,007h,035h,036h,018h,000h,008h,049h,090h,031h,032h,00fh,00eh,033h	; 6434  A...56...I.12..3
	defb 034h,031h,032h,039h,03ah,030h,02eh,03bh,03ch,035h,036h,018h,000h,008h,049h,085h	; 6444  4129:0.;<56...I.
	defb 020h,021h,022h,00fh,00dh,003h,010h,088h,024h,025h,026h,02eh,02dh,047h,015h,004h	; 6454   !".....$%&.-G..
	defb 005h,000h,083h,019h,017h,004h,006h,000h,082h,01bh,01dh,006h,000h,082h,019h,017h	; 6464  ................
	defb 008h,04ah,000h	; 6474

; ----------------------------------------------------------------------
; DATOS pantallas_1: las pantallas del juego de graficos 1 en rle (0x42C3 las
;   deja en 0xD000): 8x6 bloques cada una; lo leen p00:42A6 (601 bytes)
;   0x6477..0x66d0  (601 bytes)
DATA_pantallas_1:
	defb 081h,020h,005h,021h,08ah,022h,023h,032h,032h,025h,032h,025h,032h,026h,033h,004h	; 6477  . .!."#22%2%2&3.
	defb 035h,084h,02fh,03bh,037h,03bh,008h,002h,008h,001h,008h,003h,082h,028h,020h,004h	; 6487  5./;7;.......( .
	defb 021h,091h,022h,023h,02ch,024h,03ch,03dh,025h,032h,032h,027h,038h,039h,03eh,03fh	; 6497  !."#,$<=%22'89>?
	defb 037h,01ah,01bh,006h,002h,009h,001h,081h,008h,007h,003h,084h,009h,000h,028h,020h	; 64a7  7.............(
	defb 003h,021h,09ch,022h,023h,04bh,030h,031h,024h,025h,024h,026h,027h,02eh,002h,002h	; 64b7  .!."#K01$%$&'...
	defb 012h,000h,013h,002h,01ch,052h,008h,00eh,014h,000h,015h,00bh,001h,01dh,009h,004h	; 64c7  .....R..........
	defb 000h,083h,00ah,00bh,001h,006h,000h,0a2h,00ah,00eh,04bh,028h,020h,021h,022h,023h	; 64d7  ..........K( !"#
	defb 028h,020h,02dh,02ch,025h,025h,026h,027h,02ch,024h,046h,053h,047h,054h,054h,046h	; 64e7  ( -,%%&',$FSGTTF
	defb 047h,000h,043h,044h,045h,01ah,01bh,002h,012h,000h,003h,002h,003h,001h,085h,016h	; 64f7  G.CDE...........
	defb 00fh,00eh,00eh,00ch,003h,003h,087h,009h,000h,021h,022h,023h,028h,020h,003h,021h	; 6507  .........!"#( .!
	defb 088h,025h,026h,027h,02ch,025h,024h,024h,025h,005h,000h,083h,046h,053h,047h,004h	; 6517  .%&',%$$%...FSG.
	defb 000h,084h,055h,048h,049h,04ah,004h,00fh,081h,011h,003h,002h,004h,000h,094h,015h	; 6527  ..UHIJ..........
	defb 00ch,00dh,00eh,022h,023h,01eh,01fh,04eh,04eh,01eh,01fh,026h,027h,02ah,02bh,029h	; 6537  ..."#..NN..&'*+)
	defb 02ah,02bh,029h,003h,000h,0adh,055h,039h,038h,056h,000h,056h,000h,000h,013h,002h	; 6547  *+)...U98V.V....
	defb 002h,010h,00fh,010h,00fh,00fh,017h,001h,008h,014h,000h,014h,000h,000h,00ah,00ch	; 6557  ................
	defb 009h,000h,000h,01fh,04eh,01eh,01fh,01fh,01eh,01eh,028h,02ah,02bh,029h,02ah,02eh	; 6567  ....N.....(*+)*.
	defb 01fh,02dh,030h,004h,000h,081h,013h,003h,002h,004h,00fh,081h,017h,003h,001h,08bh	; 6577  .-0.............
	defb 013h,002h,012h,000h,00ah,00ch,003h,003h,015h,00eh,014h,005h,000h,090h,020h,021h	; 6587  .............. !
	defb 022h,023h,04eh,04eh,01eh,01fh,031h,025h,026h,027h,02ah,02eh,04bh,028h,006h,002h	; 6597  "#NN..1%&'*.K(..
	defb 082h,010h,00fh,005h,001h,089h,008h,014h,000h,00dh,00bh,001h,004h,005h,009h,003h	; 65a7  ................
	defb 000h,083h,00ah,00ch,04fh,004h,000h,002h,01eh,002h,01fh,08ch,028h,020h,021h,022h	; 65b7  ....O.......( !"
	defb 020h,021h,022h,029h,02ch,024h,025h,026h,005h,00fh,082h,011h,012h,006h,000h,0a6h	; 65c7   !"),$%&........
	defb 015h,014h,000h,000h,013h,002h,010h,00fh,011h,010h,00fh,000h,015h,00eh,014h,000h	; 65d7  ................
	defb 015h,014h,000h,023h,028h,020h,021h,022h,023h,028h,020h,027h,02ch,024h,025h,025h	; 65e7  ...#( !"#( ',$%%
	defb 027h,02ch,024h,000h,000h,013h,003h,002h,081h,012h,003h,000h,081h,015h,003h,00eh	; 65f7  ',$.............
	defb 082h,014h,000h,008h,00fh,002h,000h,082h,013h,012h,004h,000h,085h,021h,022h,023h	; 6607  .............!"#
	defb 028h,020h,003h,021h,085h,025h,026h,027h,030h,031h,003h,026h,082h,000h,013h,003h	; 6617  ( .!.%&'01.&....
	defb 002h,085h,018h,019h,038h,000h,057h,005h,001h,0a9h,002h,00fh,017h,001h,001h,008h	; 6627  ....8.W.........
	defb 00dh,00bh,001h,000h,00ah,00eh,00ch,009h,000h,00ah,00ch,021h,021h,022h,023h,028h	; 6637  ...........!!"#(
	defb 020h,021h,021h,040h,041h,042h,027h,02ch,024h,025h,026h,048h,049h,04ah,03bh,038h	; 6647   !!@AB',$%&HIJ;8
	defb 039h,03bh,056h,008h,002h,003h,001h,09ah,008h,00dh,00bh,001h,001h,00dh,00eh,00ch	; 6657  9;V.............
	defb 009h,000h,00ah,00ch,003h,022h,029h,02ah,02ch,033h,030h,038h,039h,026h,054h,054h	; 6667  .....")*,3089&TT
	defb 01ah,01bh,003h,002h,083h,034h,01ah,01bh,005h,001h,081h,002h,009h,001h,089h,004h	; 6677  .....4..........
	defb 005h,003h,003h,006h,007h,00dh,00ch,04fh,004h,000h,099h,050h,03ah,052h,027h,02eh	; 6687  .......O...P:R'.
	defb 02dh,02ch,025h,026h,002h,01ch,056h,03ch,03dh,054h,054h,02fh,001h,001h,01dh,04ch	; 6697  -,%&..V<=TT/...L
	defb 04dh,01ah,01bh,002h,003h,001h,002h,002h,00bh,001h,083h,006h,005h,00dh,004h,00eh	; 66a7  M...............
	defb 091h,00ch,027h,02eh,02dh,02ch,03ch,03dh,03ch,03dh,03bh,02fh,03bh,038h,03eh,03fh	; 66b7  ..'.-,<=<=;/;8>?
	defb 04ch,04dh,008h,002h,010h,001h,008h,003h,000h	; 66c7  LM.......

; ----------------------------------------------------------------------
; DATOS pantallas_4: las pantallas del juego de graficos 4 en rle (0x42C3 las
;   deja en 0xD000): 8x6 bloques cada una; lo leen p00:42A6 (702 bytes)
;   0x66d0..0x698e  (702 bytes)
DATA_pantallas_4:
	defb 090h,042h,019h,019h,044h,04bh,042h,044h,04bh,045h,013h,013h,046h,035h,045h,046h	; 66d0  .B..DKBDKE..F5EF
	defb 034h,008h,011h,082h,010h,014h,006h,018h,082h,010h,016h,006h,000h,081h,014h,007h	; 66e0  4...............
	defb 000h,090h,043h,044h,042h,019h,044h,04bh,043h,044h,045h,046h,045h,013h,046h,034h	; 66f0  ..CDB.DKCDEFE.F4
	defb 045h,046h,008h,011h,008h,018h,010h,000h,08bh,04bh,02bh,027h,02bh,028h,02ah,02bh	; 6700  EF.......K+'+(*+
	defb 029h,032h,023h,025h,005h,023h,084h,04dh,01ah,000h,01bh,004h,012h,084h,018h,04ah	; 6710  )2#%.#.M.......J
	defb 000h,049h,004h,018h,010h,000h,082h,02bh,02ch,004h,02dh,082h,02eh,02bh,008h,023h	; 6720  .I.....+,.-..+.#
	defb 008h,012h,008h,018h,010h,000h,088h,028h,026h,02bh,029h,02ah,029h,026h,028h,008h	; 6730  .......(&+)*)&(.
	defb 023h,008h,012h,008h,018h,010h,000h,08bh,026h,027h,02ch,02dh,02dh,02eh,027h,026h	; 6740  #.......&',--.'&
	defb 023h,023h,025h,005h,023h,084h,012h,01ah,000h,01bh,004h,012h,084h,018h,04ah,000h	; 6750  ##%.#.........J.
	defb 049h,004h,018h,010h,000h,088h,029h,02ch,02eh,02bh,029h,027h,029h,04bh,007h,023h	; 6760  I.....),.+)')K.#
	defb 081h,033h,007h,012h,081h,04eh,008h,018h,010h,000h,090h,04bh,04ch,04bh,042h,019h	; 6770  .3...N.....KLKB.
	defb 044h,04bh,04ch,035h,036h,034h,045h,013h,046h,034h,034h,008h,011h,006h,018h,082h	; 6780  DKL564E.F44.....
	defb 015h,010h,006h,000h,082h,017h,010h,007h,000h,093h,015h,04bh,01eh,004h,005h,004h	; 6790  ...........K....
	defb 006h,007h,004h,035h,036h,008h,008h,00ch,008h,00ch,008h,011h,047h,006h,018h,082h	; 67a0  ...56.......G...
	defb 010h,016h,006h,000h,081h,014h,007h,000h,081h,01ch,007h,011h,08ah,004h,005h,001h	; 67b0  ................
	defb 002h,002h,003h,004h,006h,008h,00ch,004h,008h,082h,00ch,008h,008h,018h,010h,000h	; 67c0  ................
	defb 008h,011h,08ah,001h,002h,003h,004h,006h,001h,002h,003h,008h,00ch,004h,008h,082h	; 67d0  ................
	defb 00ch,008h,008h,018h,010h,000h,008h,011h,002h,004h,088h,005h,006h,006h,007h,005h	; 67e0  ................
	defb 004h,008h,00ch,004h,008h,082h,00ch,008h,008h,018h,010h,000h,084h,011h,047h,000h	; 67f0  ..............G.
	defb 048h,004h,011h,08bh,004h,005h,004h,007h,004h,006h,004h,005h,008h,00ch,024h,003h	; 6800  H.............$.
	defb 008h,085h,00ch,008h,018h,018h,000h,005h,018h,010h,000h,008h,011h,08ah,004h,005h	; 6810  ................
	defb 006h,004h,005h,004h,01fh,04bh,008h,00ch,004h,008h,082h,034h,035h,006h,018h,082h	; 6820  .....K.....45...
	defb 048h,011h,006h,000h,082h,017h,010h,007h,000h,081h,015h,007h,011h,089h,01dh,037h	; 6830  H..............7
	defb 02bh,027h,02bh,03bh,03fh,03fh,037h,008h,022h,082h,012h,01ah,006h,018h,082h,010h	; 6840  +'+;??7.".......
	defb 016h,006h,000h,081h,014h,007h,000h,008h,02fh,088h,037h,027h,02ch,02dh,02dh,02eh	; 6850  ......../.7',--.
	defb 027h,03fh,008h,022h,008h,018h,010h,000h,002h,02fh,081h,000h,005h,02fh,08bh,037h	; 6860  '?."...../.../.7
	defb 02bh,027h,02bh,03fh,03fh,03bh,037h,022h,022h,024h,005h,022h,002h,018h,081h,000h	; 6870  +'+??;7""$."....
	defb 005h,018h,010h,000h,008h,02fh,088h,001h,002h,003h,005h,004h,001h,002h,003h,008h	; 6880  ...../..........
	defb 022h,008h,018h,010h,000h,008h,02fh,088h,03fh,037h,037h,03fh,02bh,027h,02bh,03bh	; 6890  "...../.?77?+'+;
	defb 008h,022h,006h,018h,082h,01bh,012h,006h,000h,082h,017h,010h,007h,000h,081h,015h	; 68a0  ."..............
	defb 008h,02fh,090h,004h,001h,002h,003h,007h,006h,004h,006h,008h,008h,00ch,008h,008h	; 68b0  ./..............
	defb 00ch,008h,008h,008h,012h,081h,014h,007h,018h,081h,016h,007h,000h,008h,02fh,090h	; 68c0  ............../.
	defb 006h,005h,007h,006h,006h,004h,006h,006h,008h,008h,00ch,008h,008h,00ch,008h,008h	; 68d0  ................
	defb 008h,012h,008h,018h,008h,000h,002h,02fh,081h,000h,005h,02fh,090h,004h,027h,001h	; 68e0  ......./.../..'.
	defb 002h,002h,003h,027h,004h,008h,008h,00ch,008h,008h,00ch,008h,008h,008h,012h,008h	; 68f0  ...'............
	defb 018h,008h,000h,008h,02fh,090h,004h,001h,002h,002h,003h,004h,027h,004h,008h,008h	; 6900  ..../.......'...
	defb 00ch,008h,008h,00ch,008h,008h,008h,012h,008h,018h,008h,000h,008h,02fh,090h,005h	; 6910  ............./..
	defb 006h,027h,02ch,02dh,02eh,027h,004h,008h,00ch,008h,009h,00ah,00bh,008h,00ch,003h	; 6920  .',-.'..........
	defb 012h,085h,00dh,00eh,00fh,012h,012h,008h,018h,008h,000h,008h,02fh,004h,023h,084h	; 6930  ............/.#.
	defb 021h,041h,004h,004h,004h,023h,084h,031h,03ah,008h,008h,005h,03dh,083h,03eh,012h	; 6940  !A...#.1:...=.>.
	defb 012h,008h,018h,008h,000h,008h,02fh,083h,006h,040h,020h,005h,023h,083h,008h,038h	; 6950  ....../..@ .#..8
	defb 030h,005h,023h,082h,012h,03ch,006h,03dh,008h,018h,008h,000h,008h,02fh,090h,004h	; 6960  0.#..<.=...../..
	defb 005h,004h,001h,003h,005h,006h,006h,008h,008h,00ch,008h,008h,00ch,008h,008h,008h	; 6970  ................
	defb 012h,006h,018h,082h,015h,010h,006h,000h,082h,017h,010h,008h,02fh,000h	; 6980  ............/.

; ----------------------------------------------------------------------
; DATOS pantallas_5: las pantallas del juego de graficos 5 en rle (0x42C3 las
;   deja en 0xD000): 8x6 bloques cada una; lo leen p00:42A6 (1358 bytes)
;   0x698e..0x6edc  (1358 bytes)
DATA_pantallas_5:
	defb 092h,00bh,009h,00bh,009h,00bh,009h,00bh,009h,00ah,011h,00ah,011h,00ah,011h,00ah	; 698e  ................
	defb 011h,004h,001h,006h,000h,082h,03ch,03eh,006h,000h,083h,03ch,003h,001h,005h,000h	; 699e  ......<>...<....
	defb 002h,03ch,081h,003h,005h,004h,090h,00bh,006h,007h,008h,00bh,009h,00bh,009h,00ah	; 69ae  .<..............
	defb 011h,00ch,011h,00ah,011h,00ah,011h,008h,000h,084h,002h,004h,004h,001h,004h,000h	; 69be  ................
	defb 089h,03fh,03ch,03ch,003h,004h,001h,000h,000h,005h,004h,03ch,093h,003h,004h,004h	; 69ce  .?<<.......<....
	defb 00bh,009h,00bh,009h,00bh,009h,00bh,009h,00ah,011h,00ah,011h,00ah,011h,00ah,011h	; 69de  ................
	defb 00bh,000h,081h,002h,004h,004h,002h,000h,082h,002h,005h,004h,03ch,002h,004h,081h	; 69ee  ............<...
	defb 005h,005h,03ch,090h,00bh,009h,00bh,009h,00bh,009h,00bh,009h,00ah,011h,00ah,011h	; 69fe  ..<.............
	defb 00ah,011h,00ah,011h,008h,000h,002h,004h,081h,001h,005h,000h,002h,03ch,086h,003h	; 6a0e  .............<..
	defb 004h,004h,001h,000h,000h,005h,03ch,093h,003h,004h,004h,00bh,009h,00bh,009h,00bh	; 6a1e  ......<.........
	defb 009h,00bh,009h,00ah,011h,00ah,011h,00ah,011h,00ah,011h,006h,000h,095h,002h,004h	; 6a2e  ................
	defb 000h,000h,002h,004h,001h,000h,03fh,03ch,000h,000h,03fh,03ch,003h,004h,005h,03ch	; 6a3e  ......?<..?<...<
	defb 004h,004h,005h,005h,03ch,091h,048h,037h,017h,01ah,01bh,01bh,01ch,018h,048h,045h	; 6a4e  ....<.H7......HE
	defb 02ch,01dh,01eh,01eh,01fh,02bh,048h,007h,00dh,09ah,048h,00dh,010h,00dh,010h,00dh	; 6a5e  ,....+H...H.....
	defb 010h,00dh,048h,012h,013h,012h,013h,012h,013h,012h,048h,03dh,00ah,011h,00ah,011h	; 6a6e  ..H.......H=....
	defb 00ah,011h,017h,01ah,003h,01bh,085h,01ch,018h,037h,02ch,01dh,003h,01eh,083h,01fh	; 6a7e  .........7,.....
	defb 02bh,045h,008h,00dh,0a8h,010h,042h,00dh,043h,010h,00dh,010h,00dh,013h,040h,00dh	; 6a8e  +E....B.C.....@.
	defb 041h,013h,012h,013h,012h,00ah,011h,00ch,011h,00ah,011h,00ah,011h,037h,02fh,04eh	; 6a9e  A............7/N
	defb 030h,037h,037h,018h,037h,045h,031h,039h,032h,045h,045h,02bh,045h,008h,00dh,09ah	; 6aae  077.7E192EE+E...
	defb 010h,00dh,010h,00dh,010h,00dh,010h,00dh,013h,012h,013h,012h,013h,012h,013h,012h	; 6abe  ................
	defb 00ah,011h,00ah,011h,00ah,011h,00ah,011h,037h,017h,004h,019h,08ah,018h,037h,045h	; 6ace  ........7.....7E
	defb 02ch,00eh,00fh,00eh,00fh,02bh,045h,008h,00dh,09ah,010h,00dh,010h,00dh,010h,00dh	; 6ade  ,....+E.........
	defb 010h,00dh,013h,012h,013h,012h,013h,012h,013h,012h,00ah,011h,00ah,011h,00ah,011h	; 6aee  ................
	defb 00ah,011h,037h,017h,004h,037h,084h,018h,037h,045h,02ch,004h,045h,082h,02bh,045h	; 6afe  ..7..7..7E,.E.+E
	defb 008h,00dh,09ah,010h,00dh,010h,00dh,010h,00dh,010h,00dh,013h,012h,013h,012h,013h	; 6b0e  ................
	defb 012h,013h,012h,00ah,011h,00ah,011h,00ah,011h,00ah,011h,037h,017h,004h,020h,08ah	; 6b1e  ...........7.. .
	defb 018h,047h,045h,02ch,022h,021h,022h,021h,02bh,047h,007h,00dh,09ch,047h,010h,00dh	; 6b2e  .GE,"!"!+G...G..
	defb 010h,00dh,010h,00dh,010h,047h,013h,012h,013h,012h,013h,012h,013h,047h,00ah,011h	; 6b3e  .....G.......G..
	defb 00ah,011h,00ah,011h,00ah,047h,048h,014h,048h,004h,019h,08ah,047h,048h,046h,016h	; 6b4e  .....GH.H...GHF.
	defb 024h,023h,024h,023h,015h,048h,007h,00dh,081h,048h,007h,00dh,081h,048h,007h,00dh	; 6b5e  $#$#.H...H...H..
	defb 089h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,048h,006h,020h,089h,047h,016h,022h	; 6b6e  .'J'J'J'JH. .G."
	defb 021h,022h,021h,022h,021h,015h,018h,00dh,098h,027h,028h,00dh,029h,027h,04ah,027h	; 6b7e  !"!"!....'(.)'J'
	defb 04ah,014h,02fh,04eh,030h,014h,014h,047h,014h,046h,031h,039h,032h,046h,046h,015h	; 6b8e  J./N0..G.F192FF.
	defb 046h,018h,00dh,08ah,027h,04ah,027h,04ah,027h,04ah,027h,04ah,048h,048h,004h,019h	; 6b9e  F...'J'J'J'JHH..
	defb 002h,047h,002h,016h,086h,024h,023h,024h,023h,015h,015h,018h,00dh,08ah,027h,04ah	; 6bae  .G...$#$#.....'J
	defb 027h,04ah,027h,04ah,027h,04ah,014h,048h,004h,020h,08ah,047h,014h,046h,016h,022h	; 6bbe  'J'J'J.H. .G.F."
	defb 021h,022h,021h,015h,046h,018h,00dh,08ch,027h,04ah,027h,04ah,027h,04ah,027h,04ah	; 6bce  !"!.F...'J'J'J'J
	defb 048h,014h,014h,048h,003h,014h,085h,047h,016h,046h,046h,016h,003h,046h,081h,015h	; 6bde  H..H...G.FF..F..
	defb 018h,00dh,089h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,048h,004h,019h,08bh,047h	; 6bee  ...'J'J'J'JH...G
	defb 014h,047h,016h,024h,023h,024h,023h,015h,046h,047h,007h,00dh,081h,047h,007h,00dh	; 6bfe  .G.$#$#.FG...G..
	defb 081h,047h,007h,00dh,08bh,047h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,048h,025h	; 6c0e  .G...G'J'J'J'JH%
	defb 004h,020h,08bh,04ch,02ah,048h,049h,033h,034h,033h,034h,04dh,04bh,048h,007h,00dh	; 6c1e  . .L*HI3434MKH..
	defb 081h,048h,007h,00dh,081h,048h,007h,00dh,089h,027h,04ah,027h,04ah,027h,04ah,027h	; 6c2e  .H...H...'J'J'J'
	defb 04ah,025h,006h,020h,089h,04ch,049h,022h,021h,022h,021h,022h,021h,04dh,018h,00dh	; 6c3e  J%. .LI"!"!"!M..
	defb 098h,027h,028h,00dh,029h,027h,04ah,027h,04ah,02ah,02fh,04eh,030h,02ah,02ah,04ch	; 6c4e  .'(.)'J'J*/N0**L
	defb 02ah,04bh,031h,039h,032h,04bh,04bh,04dh,04bh,018h,00dh,098h,027h,04ah,027h,04ah	; 6c5e  *K192KKMK...'J'J
	defb 027h,04ah,027h,04ah,02ah,025h,01ah,01bh,01bh,01ch,04ch,02ah,04bh,049h,01dh,01eh	; 6c6e  'J'J*%....L*KI..
	defb 01eh,01fh,04dh,04bh,018h,00dh,08ah,027h,04ah,027h,04ah,027h,04ah,027h,04ah,02ah	; 6c7e  ..MK...'J'J'J'J*
	defb 025h,004h,020h,08ah,04ch,047h,04bh,049h,033h,034h,033h,034h,04dh,047h,007h,00dh	; 6c8e  %. .LGKI3434MG..
	defb 081h,047h,007h,00dh,081h,047h,007h,00dh,09ah,047h,027h,04ah,027h,04ah,027h,04ah	; 6c9e  .G...G...G'J'J'J
	defb 027h,04ah,048h,038h,038h,02dh,038h,038h,02dh,038h,048h,046h,046h,015h,046h,046h	; 6cae  'JH88-88-8HFF.FF
	defb 015h,046h,048h,007h,00dh,081h,048h,007h,00dh,081h,048h,007h,00dh,098h,027h,04ah	; 6cbe  .FH...H...H...'J
	defb 027h,04ah,027h,04ah,027h,04ah,038h,02dh,038h,038h,02dh,038h,038h,02dh,046h,015h	; 6cce  'J'J'J8-88-88-F.
	defb 046h,046h,015h,046h,046h,015h,018h,00dh,08ch,027h,028h,00dh,029h,027h,04ah,027h	; 6cde  FF.FF....'(.)'J'
	defb 04ah,038h,02fh,04eh,030h,003h,020h,089h,02dh,046h,031h,039h,032h,021h,022h,021h	; 6cee  J8/N0. .-F192!"!
	defb 015h,018h,00dh,089h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,02eh,006h,019h,089h	; 6cfe  ....'J'J'J'J....
	defb 02dh,016h,024h,023h,024h,023h,024h,023h,015h,018h,00dh,08ah,027h,04ah,027h,04ah	; 6d0e  -.$#$#$#....'J'J
	defb 027h,04ah,027h,04ah,038h,02dh,003h,038h,085h,02dh,038h,047h,046h,015h,003h,046h	; 6d1e  'J'J8-.8.-8GF..F
	defb 083h,015h,046h,047h,007h,00dh,081h,047h,007h,00dh,081h,047h,007h,00dh,08bh,047h	; 6d2e  ..FG...G...G...G
	defb 027h,04ah,027h,04ah,027h,04ah,027h,04ah,048h,017h,003h,037h,085h,017h,037h,037h	; 6d3e  'J'J'J'JH..7..77
	defb 048h,02ch,003h,045h,084h,02ch,045h,045h,048h,007h,00dh,081h,048h,007h,00dh,081h	; 6d4e  H,.E.,EEH...H...
	defb 048h,007h,00dh,08ah,027h,04ah,027h,04ah,027h,04ah,027h,04ah,037h,017h,004h,019h	; 6d5e  H...'J'J'J'J7...
	defb 08ah,018h,037h,045h,02ch,00eh,00fh,00eh,00fh,02bh,045h,018h,00dh,098h,027h,04ah	; 6d6e  ..7E,....+E...'J
	defb 027h,04ah,027h,04ah,027h,04ah,037h,017h,037h,017h,01ah,01bh,018h,037h,045h,02ch	; 6d7e  'J'J'J7.7....7E,
	defb 045h,02ch,01dh,01eh,02bh,045h,018h,00dh,098h,027h,028h,00dh,029h,027h,04ah,027h	; 6d8e  E,..+E...'(.)'J'
	defb 04ah,037h,02fh,04eh,030h,037h,037h,018h,037h,045h,031h,039h,032h,045h,045h,02bh	; 6d9e  J7/N077.7E192EE+
	defb 045h,018h,00dh,089h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,017h,006h,020h,089h	; 6dae  E...'J'J'J'J.. .
	defb 018h,02ch,022h,021h,022h,021h,022h,021h,02bh,018h,00dh,08bh,027h,04ah,027h,04ah	; 6dbe  .,"!"!"!+...'J'J
	defb 027h,04ah,027h,04ah,037h,037h,017h,004h,019h,089h,018h,045h,045h,02ch,00eh,00fh	; 6dce  'J'J77.....EE,..
	defb 00eh,00fh,02bh,018h,00dh,098h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,017h,037h	; 6dde  ..+...'J'J'J'J.7
	defb 037h,017h,037h,037h,017h,037h,02ch,045h,045h,02ch,045h,045h,02ch,045h,018h,00dh	; 6dee  7.77.7,EE,EE,E..
	defb 098h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,037h,037h,017h,020h,020h,018h,037h	; 6dfe  .'J'J'J'J77.  .7
	defb 047h,045h,045h,02ch,022h,021h,02bh,045h,047h,007h,00dh,081h,047h,007h,00dh,081h	; 6e0e  GEE,"!+EG...G...
	defb 047h,007h,00dh,08ah,047h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,017h,006h,019h	; 6e1e  G...G'J'J'J'J...
	defb 089h,018h,02ch,035h,036h,035h,036h,035h,036h,02bh,018h,00dh,099h,027h,04ah,027h	; 6e2e  ..,565656+...'J'
	defb 04ah,027h,04ah,027h,04ah,048h,044h,026h,044h,044h,026h,044h,044h,048h,045h,02ch	; 6e3e  J'J'JHD&DD&DDHE,
	defb 045h,045h,02ch,045h,045h,048h,007h,00dh,081h,048h,007h,00dh,081h,048h,007h,00dh	; 6e4e  EE,EEH...H...H..
	defb 08bh,027h,04ah,027h,04ah,027h,04ah,027h,04ah,026h,044h,026h,004h,020h,089h,03ah	; 6e5e  .'J'J'J'J&D&. .:
	defb 02ch,045h,02ch,022h,021h,022h,021h,02bh,018h,00dh,089h,027h,028h,00dh,029h,027h	; 6e6e  ,E,"!"!+...'(.)'
	defb 04ah,027h,04ah,026h,003h,044h,085h,026h,019h,019h,03ah,02ch,003h,045h,084h,02ch	; 6e7e  J'J&.D.&..:,.E.,
	defb 00eh,00fh,02bh,018h,00dh,098h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,026h,020h	; 6e8e  ..+...'J'J'J'J&
	defb 020h,03ah,026h,020h,020h,03ah,02ch,022h,021h,02bh,02ch,022h,021h,02bh,018h,00dh	; 6e9e   :&  :,"!+,"!+..
	defb 098h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,026h,01ah,01bh,01bh,01ch,03ah,044h	; 6eae  .'J'J'J'J&....:D
	defb 047h,02ch,01dh,01eh,01eh,01fh,02bh,045h,047h,007h,00dh,081h,047h,007h,00dh,081h	; 6ebe  G,....+EG...G...
	defb 047h,007h,00dh,089h,047h,027h,04ah,027h,04ah,027h,04ah,027h,04ah,000h	; 6ece  G...G'J'J'J'J.

; ----------------------------------------------------------------------
; DATOS pantallas_2: las pantallas del juego de graficos 2 en rle (0x42C3 las
;   deja en 0xD000): 8x6 bloques cada una; lo leen p00:42A6 (423 bytes)
;   0x6edc..0x7083  (423 bytes)
DATA_pantallas_2:
	defb 002h,040h,090h,000h,001h,002h,000h,000h,001h,041h,041h,046h,005h,006h,004h,004h	; 6edc  .@.......AAF....
	defb 005h,041h,042h,006h,04dh,082h,041h,043h,006h,04dh,082h,041h,044h,006h,04dh,098h	; 6eec  .AB.M.AC.M.AD.M.
	defb 041h,045h,008h,009h,00ah,008h,009h,00ah,002h,000h,003h,000h,020h,021h,022h,001h	; 6efc  AE.......... !".
	defb 006h,004h,007h,004h,024h,019h,026h,005h,018h,04dh,098h,00ah,009h,009h,00ah,008h	; 6f0c  ....$.&..M......
	defb 00ah,009h,00ah,000h,001h,002h,027h,02bh,01ch,01dh,000h,004h,005h,006h,02fh,01bh	; 6f1c  ......'+....../.
	defb 02fh,01fh,004h,014h,04dh,098h,009h,04fh,04dh,04dh,00ah,009h,04dh,04bh,04eh,04eh	; 6f2c  /...M..OMM..MKNN
	defb 045h,00ah,040h,002h,000h,001h,040h,002h,040h,001h,006h,006h,004h,005h,003h,006h	; 6f3c  E.@...@.@.......
	defb 081h,005h,012h,04dh,082h,008h,04fh,004h,04dh,098h,00ah,04bh,04eh,04eh,045h,009h	; 6f4c  ...M..O.M..KNNE.
	defb 008h,00ah,040h,028h,029h,02ah,020h,021h,022h,040h,006h,02ch,023h,02eh,02ch,02dh	; 6f5c  ..@()* !"@.,#.,-
	defb 02eh,006h,018h,04dh,098h,00ah,009h,008h,009h,00ah,008h,00ah,00ah,01ch,01dh,028h	; 6f6c  ...M...........(
	defb 029h,02ah,028h,029h,02ah,02fh,01fh,024h,025h,026h,02ch,02dh,02eh,013h,04dh,082h	; 6f7c  )*()*/.$%&,-..M.
	defb 009h,04fh,003h,04dh,002h,00ah,096h,04bh,04eh,04eh,045h,00ah,00ah,000h,000h,002h	; 6f8c  .O.M...KNNE.....
	defb 001h,000h,001h,040h,040h,004h,004h,006h,005h,004h,047h,041h,041h,006h,04dh,082h	; 6f9c  ...@@.....GAA.M.
	defb 048h,041h,006h,04dh,08bh,049h,041h,04dh,008h,009h,04fh,04dh,04dh,04ah,041h,04bh	; 6fac  HA.M.IAM..OMMJAK
	defb 003h,04eh,084h,045h,008h,04bh,041h,004h,00eh,090h,00dh,00eh,00eh,00dh,00dh,00eh	; 6fbc  .N.E.KA.........
	defb 00eh,012h,00bh,00bh,00ch,00ch,00eh,00eh,012h,013h,004h,04dh,083h,00eh,012h,013h	; 6fcc  ...........M....
	defb 005h,04dh,082h,012h,013h,006h,04dh,082h,00dh,016h,003h,015h,093h,016h,015h,015h	; 6fdc  .M....M.........
	defb 00dh,00eh,00dh,00fh,00dh,00eh,00dh,00eh,00bh,00ch,00bh,00bh,00ch,00ch,00bh,00bh	; 6fec  ................
	defb 018h,04dh,098h,015h,016h,015h,016h,016h,015h,016h,015h,00dh,014h,018h,014h,030h	; 6ffc  .M.............0
	defb 031h,032h,00dh,00bh,00bh,017h,00ch,034h,035h,036h,00bh,018h,04dh,002h,015h,002h	; 700c  12.....456..M...
	defb 016h,094h,015h,016h,015h,015h,037h,03bh,00dh,03dh,033h,038h,039h,03ah,02fh,01bh	; 701c  ......7;.=389:/.
	defb 00bh,02fh,03fh,034h,019h,036h,018h,04dh,098h,015h,016h,04dh,016h,016h,015h,016h	; 702c  ./?4.6.M...M....
	defb 015h,00fh,030h,031h,032h,03dh,033h,038h,03ah,00bh,034h,025h,036h,02fh,03fh,03ch	; 703c  ..012=38:.4%6/?<
	defb 03eh,018h,04dh,08dh,015h,016h,015h,016h,016h,015h,016h,015h,00eh,00dh,00eh,00eh	; 704c  >.M.............
	defb 00fh,003h,00eh,088h,00ch,00bh,00ch,00bh,011h,00eh,00eh,00dh,004h,04dh,084h,010h	; 705c  .............M..
	defb 011h,00eh,00eh,005h,04dh,083h,010h,011h,00eh,006h,04dh,082h,010h,00eh,003h,015h	; 706c  ....M.....M.....
	defb 085h,016h,015h,016h,016h,00eh,000h	; 707c

; ----------------------------------------------------------------------
; DATOS pantallas_3: las pantallas del juego de graficos 3 en rle (0x42C3 las
;   deja en 0xD000): 8x6 bloques cada una; lo leen p00:42A6 (438 bytes)
;   0x7083..0x7239  (438 bytes)
DATA_pantallas_3:
	defb 093h,02ah,025h,027h,029h,025h,028h,027h,029h,02bh,022h,019h,018h,01dh,02dh,010h	; 7083  .*%')%(')+"...-.
	defb 011h,020h,021h,004h,005h,000h,083h,023h,024h,004h,005h,000h,002h,021h,081h,008h	; 7093  . !....#$....!..
	defb 005h,00ah,098h,020h,021h,022h,023h,023h,02fh,024h,02fh,025h,026h,028h,028h,027h	; 70a3  ... !"##/$/%&(('
	defb 02ah,029h,029h,010h,012h,01dh,01ah,020h,02bh,019h,011h,004h,000h,083h,003h,020h	; 70b3  *)).... +......
	defb 004h,005h,000h,084h,007h,021h,006h,000h,004h,00ah,091h,009h,023h,008h,00ah,02fh	; 70c3  .....!......#../
	defb 02fh,022h,02fh,021h,021h,023h,022h,029h,029h,025h,026h,027h,003h,029h,088h,010h	; 70d3  /"/!!#"))%&'.)..
	defb 01dh,02dh,010h,012h,011h,010h,011h,010h,000h,008h,00ah,09dh,022h,021h,023h,022h	; 70e3  .-.........."!#"
	defb 024h,022h,02fh,021h,025h,027h,029h,02ah,029h,029h,025h,027h,010h,012h,01ah,02bh	; 70f3  $"/!%')*))%'...+
	defb 019h,02dh,011h,011h,000h,000h,007h,020h,004h,005h,000h,08eh,005h,023h,008h,00ah	; 7103  .-..... .....#..
	defb 013h,000h,00ah,00ah,009h,020h,020h,022h,008h,00ah,003h,021h,086h,024h,021h,020h	; 7113  .....  "...!.$!
	defb 023h,024h,025h,003h,028h,0ech,026h,028h,027h,029h,010h,01ah,02fh,001h,02fh,022h	; 7123  #$%.(.&(').././"
	defb 019h,011h,000h,007h,021h,023h,020h,024h,006h,000h,000h,005h,020h,00ch,00dh,020h	; 7133  ....!# $.... ..
	defb 004h,000h,00ah,009h,024h,006h,007h,020h,008h,00ah,02fh,023h,020h,008h,009h,023h	; 7143  ....$.. ../# ..#
	defb 020h,020h,029h,025h,026h,028h,027h,029h,025h,027h,010h,01ah,02fh,02ch,001h,021h	; 7153    )%&(')%'../,.!
	defb 019h,011h,000h,01ch,020h,024h,021h,023h,004h,000h,000h,007h,023h,019h,011h,01ah	; 7163  .... $!#....#...
	defb 008h,013h,00ah,009h,020h,006h,014h,009h,021h,008h,020h,023h,024h,015h,017h,024h	; 7173  .... ...!. #$..$
	defb 021h,020h,029h,025h,028h,028h,027h,029h,025h,027h,010h,012h,02dh,010h,011h,01ah	; 7183  ! )%((')%'..-...
	defb 022h,02ch,005h,000h,083h,005h,023h,021h,006h,000h,082h,003h,023h,006h,00ah,09eh	; 7193  ",....#!....#...
	defb 009h,024h,022h,021h,023h,021h,022h,02fh,021h,02ch,029h,025h,027h,029h,03dh,03eh	; 71a3  .$"!#!"/!,)%')=>
	defb 03fh,029h,010h,01ah,021h,019h,01eh,01bh,01fh,011h,000h,005h,023h,006h,005h,000h	; 71b3  ?)..!.......#...
	defb 083h,005h,021h,004h,004h,000h,084h,00ah,009h,024h,008h,004h,00ah,098h,023h,020h	; 71c3  ..!......$....#
	defb 021h,021h,022h,023h,024h,02fh,029h,030h,031h,032h,033h,038h,025h,027h,010h,034h	; 71d3  !!"#$/)01238%'.4
	defb 035h,036h,039h,03ch,02dh,011h,010h,000h,008h,00ah,098h,021h,020h,021h,023h,020h	; 71e3  569<-......! !#
	defb 024h,020h,020h,030h,03bh,031h,032h,033h,038h,032h,038h,02eh,039h,03ch,036h,037h	; 71f3  $  0;123828.9<67
	defb 03ch,03ah,035h,00ah,000h,081h,014h,003h,00ah,097h,013h,000h,00ah,00ah,009h,022h	; 7203  <:5............"
	defb 024h,02fh,008h,00ah,021h,020h,022h,020h,024h,021h,023h,02fh,029h,025h,026h,028h	; 7213  $/..! " $!#/)%&(
	defb 027h,003h,00eh,085h,010h,011h,02dh,018h,018h,003h,00bh,010h,000h,081h,013h,007h	; 7223  '.....-.........
	defb 000h,081h,015h,007h,016h,000h	; 7233

; ----------------------------------------------------------------------
; DATOS pantalla_7239: la pantalla de la demo (0xC482): 48 bloques de 4x4
;   caracteres, sin comprimir; lo leen p00:525D (48 bytes)
;   0x7239..0x7269  (48 bytes)
DATA_pantalla_7239:
	defb 000h,001h,001h,003h,00bh,00bh,010h,002h,004h,005h,005h,007h,00fh,00fh,014h,006h	; 7239  ................
	defb 008h,011h,012h,012h,012h,012h,013h,00ah,00ch,015h,016h,016h,016h,016h,017h,00eh	; 7249  ................
	defb 009h,005h,005h,005h,005h,005h,005h,00dh,018h,018h,018h,019h,01ah,018h,018h,018h	; 7259  ................

; ----------------------------------------------------------------------
; DATOS bloques_7269: los 27 bloques que usa la pantalla de la demo (0xC482),
;   16 bytes cada uno (p00:52A6..52B5); lo leen p00:525D (432 bytes)
;   0x7269..0x7419  (432 bytes)
DATA_bloques_7269:
	defb 0b0h,0a0h,0a0h,0a0h,0c3h,0b0h,0a0h,0a0h,0b4h,0c3h,0b0h,0a0h,0a0h,0b4h,0b1h,0afh	; 7269  ................
	defb 0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0abh,0abh,0abh,0abh	; 7279  ................
	defb 0a0h,0a0h,0a0h,0c1h,0a0h,0a0h,0c1h,0b2h,0a0h,0c1h,0b2h,0c5h,0c1h,0c2h,0c5h,0a0h	; 7289  ................
	defb 0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0b9h,0a3h,0a3h,0a3h,0bbh,000h,000h,000h	; 7299  ................
	defb 0a0h,0a0h,0b3h,0bdh,0a0h,0a0h,0a1h,0b5h,0a0h,0a0h,0a1h,0b5h,0a0h,0a0h,0a1h,0b5h	; 72a9  ................
	defb 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h	; 72b9  ................
	defb 0ceh,0c4h,0a0h,0a0h,0c6h,0a1h,0a0h,0a0h,0c6h,0a1h,0a0h,0a0h,0c6h,0a1h,0a0h,0a0h	; 72c9  ................
	defb 0bbh,000h,000h,000h,0bbh,000h,000h,000h,0bbh,000h,000h,000h,0bah,0a4h,0a4h,0a4h	; 72d9  ................
	defb 0a0h,0a0h,0a1h,0b5h,0b0h,0a0h,0a1h,0b5h,0c3h,0b0h,0a1h,0b5h,0b4h,0c3h,0afh,0b5h	; 72e9  ................
	defb 0a0h,0a0h,0a1h,0b5h,0a0h,0a0h,0a1h,0b5h,0b0h,0a0h,0a1h,0b5h,0c3h,0b0h,0a1h,0b5h	; 72f9  ................
	defb 0c6h,0a1h,0a0h,0a0h,0c6h,0a1h,0a0h,0c1h,0c6h,0a1h,0c1h,0b2h,0c6h,0c0h,0b2h,0c5h	; 7309  ................
	defb 0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a3h,0a3h,0a3h,0a3h,000h,000h,000h,000h	; 7319  ................
	defb 0a0h,0b4h,0b1h,0b6h,0a0h,0a0h,0b3h,0bdh,0a0h,0a0h,0a1h,0b5h,0a0h,0a0h,0a1h,0b5h	; 7329  ................
	defb 0c6h,0a1h,0a0h,0a0h,0c6h,0a1h,0a0h,0a0h,0c6h,0a1h,0a0h,0c1h,0c6h,0a1h,0c1h,0b2h	; 7339  ................
	defb 0c7h,0c2h,0c5h,0a0h,0ceh,0c4h,0a0h,0a0h,0c6h,0a1h,0a0h,0a0h,0c6h,0a1h,0a0h,0a0h	; 7349  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0a4h,0a4h,0a4h,0a4h	; 7359  ................
	defb 0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a3h,0a3h,0a3h,0cah,000h,000h,000h,0cch	; 7369  ................
	defb 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,0b7h,0a5h,001h,001h,0bch,000h	; 7379  ................
	defb 001h,001h,001h,001h,001h,001h,001h,001h,0a5h,0a5h,0a5h,0a5h,000h,000h,000h,000h	; 7389  ................
	defb 001h,001h,001h,001h,001h,001h,001h,001h,0a5h,0c8h,001h,001h,000h,0cdh,001h,001h	; 7399  ................
	defb 000h,000h,000h,0cch,000h,000h,000h,0cch,000h,000h,000h,0cch,0a4h,0a4h,0a4h,0cbh	; 73a9  ................
	defb 001h,001h,0bch,000h,001h,001h,0bch,000h,001h,001h,0b8h,0a6h,001h,001h,0aeh,0a2h	; 73b9  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0a6h,0a6h,0a6h,0a6h,0a2h,0a2h,0a2h,0a2h	; 73c9  ................
	defb 000h,0cdh,001h,001h,000h,0cdh,001h,001h,0a6h,0c9h,001h,001h,0a2h,0bfh,001h,001h	; 73d9  ................
	defb 0a7h,0a8h,0a7h,0a8h,0a9h,0aah,0a9h,0aah,000h,000h,000h,000h,000h,000h,000h,000h	; 73e9  ................
	defb 0a9h,0aah,0a9h,0aah,0adh,0ach,0ach,0ach,000h,000h,000h,000h,000h,000h,000h,000h	; 73f9  ................
	defb 0a9h,0aah,0a9h,0aah,0ach,0ach,0ach,0beh,000h,000h,000h,000h,000h,000h,000h,000h	; 7409  ................

; ----------------------------------------------------------------------
; DATOS pantalla_7419: la pantalla de la casilla 0xFF de la rejilla: 48
;   bloques de 4x4 caracteres, sin comprimir; lo leen p00:5268 (48 bytes)
;   0x7419..0x7449  (48 bytes)
DATA_pantalla_7419:
	defb 000h,001h,002h,003h,008h,009h,001h,00bh,004h,005h,006h,007h,00ch,00dh,005h,00fh	; 7419  ................
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah	; 7429  ................
	defb 00ah,00ah,00ah,00ah,00ah,00ah,00ah,00ah,00eh,00eh,00eh,00eh,00eh,00eh,00eh,00eh	; 7439  ................

; ----------------------------------------------------------------------
; DATOS bloques_7449: los 16 bloques que usa la pantalla de la casilla 0xFF de
;   la rejilla, 16 bytes cada uno (p00:52A6..52B5); lo leen p00:5268 (256
;   bytes)
;   0x7449..0x7549  (256 bytes)
DATA_bloques_7449:
	defb 0cfh,0d0h,0cfh,0d0h,0d1h,0d2h,0d1h,0d2h,0d3h,0d4h,0d6h,0d6h,0d4h,0d7h,0d7h,0d7h	; 7449  ................
	defb 0cfh,0d0h,0cfh,0d0h,0d1h,0d2h,0d1h,0d2h,0d6h,0d6h,0d6h,0d6h,0d7h,0d7h,0d7h,0d7h	; 7459  ................
	defb 0cfh,0d0h,0d8h,0d8h,0d1h,0d2h,0d9h,0d9h,0d6h,0d6h,0d9h,0d9h,0d7h,0d7h,0dah,0dah	; 7469  ................
	defb 0d8h,0d8h,0d8h,0d8h,0d9h,0d9h,0d9h,0d9h,0d9h,0d9h,0d9h,0d9h,0dah,0dah,0dah,0dah	; 7479  ................
	defb 0dbh,0dfh,0dfh,0dfh,0dch,0e0h,0f1h,0f1h,0ddh,0e1h,0e2h,0e1h,0deh,0e3h,0e4h,0e3h	; 7489  ................
	defb 0dfh,0dfh,0dfh,0dfh,0f1h,0f1h,0f1h,0f1h,0e2h,0e1h,0e2h,0e1h,0e4h,0e3h,0e4h,0e3h	; 7499  ................
	defb 0dfh,0dfh,0e5h,0e6h,0f1h,0e0h,0e5h,0e6h,0e2h,0e1h,0e5h,0e6h,0e4h,0e3h,0e5h,0e6h	; 74a9  ................
	defb 0e6h,0e5h,0e7h,0e8h,0e6h,0e5h,0eah,0eah,0e6h,0e5h,0ebh,0ebh,0e6h,0e5h,0ech,0ech	; 74b9  ................
	defb 0d8h,0d8h,0d8h,0d8h,0d9h,0d9h,0d9h,0d9h,0d9h,0d9h,0d9h,0d9h,0dah,0dah,0dah,0dah	; 74c9  ................
	defb 0d8h,0d8h,0cfh,0d0h,0d9h,0d9h,0d1h,0d2h,0d9h,0d9h,0d6h,0d6h,0dah,0dah,0d7h,0d7h	; 74d9  ................
	defb 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h	; 74e9  ................
	defb 0cfh,0d0h,0cfh,0d0h,0d1h,0d2h,0d1h,0d2h,0d6h,0d6h,0d5h,0d2h,0d7h,0d7h,0d7h,0d5h	; 74f9  ................
	defb 0e9h,0e7h,0e5h,0e6h,0eah,0eah,0e5h,0e6h,0ebh,0ebh,0e5h,0e6h,0ech,0ech,0e5h,0e6h	; 7509  ................
	defb 0e6h,0e5h,0dfh,0dfh,0e6h,0e5h,0e0h,0f1h,0e6h,0e5h,0e1h,0e2h,0e6h,0e5h,0e3h,0e4h	; 7519  ................
	defb 0d6h,0d6h,0d6h,0d6h,0d7h,0d7h,0d7h,0d7h,0dfh,0dfh,0dfh,0dfh,0f1h,0f1h,0f1h,0f1h	; 7529  ................
	defb 0dfh,0dfh,0dfh,0edh,0e0h,0f1h,0e0h,0eeh,0e1h,0e2h,0e1h,0efh,0e3h,0e4h,0e3h,0f0h	; 7539  ................

; ----------------------------------------------------------------------
; DATOS pantalla_7549: la pantalla del estado 8: 48 bloques de 4x4 caracteres,
;   sin comprimir; lo leen p00:526D (48 bytes)
;   0x7549..0x7579  (48 bytes)
DATA_pantalla_7549:
	defb 002h,003h,007h,004h,005h,006h,002h,007h,008h,009h,008h,009h,008h,009h,008h,009h	; 7549  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,001h,001h,001h,001h,001h,001h,001h,001h	; 7559  ................
	defb 00bh,00ah,00bh,00ah,00bh,00ah,00bh,00ah,007h,007h,007h,007h,007h,007h,007h,007h	; 7569  ................

; ----------------------------------------------------------------------
; DATOS fila_de_mas_7579: una septima fila de 8 bloques detras de la pantalla
;   del estado 8 (0x7549), que p00:5283 monta con 6 filas: no la lee nadie (8
;   bytes)
;   0x7579..0x7581  (8 bytes)
DATA_fila_de_mas_7579:
	defb 007h,007h,007h,007h,007h,007h,007h,007h	; 7579  ........

; ----------------------------------------------------------------------
; DATOS pantalla_7581: la pantalla del estado 0x0B (8 filas de bloques): 64
;   bloques de 4x4 caracteres, sin comprimir; se solapan 2 bloques
;   (0x7581-0x75C1, 0x75B9-0x75C5); lo leen p00:42B3, p00:5272 (68 bytes)
;   0x7581..0x75c5  (68 bytes)
DATA_pantalla_7581:
	defb 000h,001h,002h,003h,010h,011h,012h,013h,004h,005h,006h,007h,007h,015h,016h,017h	; 7581  ................
	defb 008h,009h,00ah,00bh,00bh,019h,01ah,01bh,00ch,00dh,00eh,00fh,01ch,01dh,01eh,01fh	; 7591  ................
	defb 020h,021h,014h,028h,029h,018h,022h,023h,024h,025h,025h,02ah,02bh,026h,026h,027h	; 75a1   !.()."#$%%*+&&'
	defb 02ch,02ch,02ch,02dh,02eh,02fh,02fh,02fh,0c5h,075h,025h,07ah,0cch,086h,0a6h,08bh	; 75b1  ,,,-.///.u%z....
	defb 0e7h,07eh,0f2h,082h	; 75c1

; ----------------------------------------------------------------------
; DATOS bloques_0: los bloques de 4x4 caracteres del juego de graficos 0, en
;   rle; lo leen p00:42BD (1120 bytes)
;   0x75c5..0x7a25  (1120 bytes)
DATA_bloques_0:
	defb 010h,001h,081h,052h,003h,019h,08ch,053h,01ch,01ah,01ch,054h,01dh,01bh,01dh,00ah	; 75c5  ...R...S...T....
	defb 023h,024h,025h,004h,019h,088h,01ah,01ch,01ah,01ch,01bh,01dh,01bh,01dh,004h,026h	; 75d5  #$%............&
	defb 003h,019h,08ch,078h,01ah,01ch,01ah,079h,01bh,01dh,01bh,07ah,023h,024h,025h,011h	; 75e5  ...x...y...z#$%.
	defb 00ah,094h,05dh,01dh,01bh,01dh,00fh,05ah,05ah,020h,001h,05ah,05ah,020h,001h,05bh	; 75f5  ..]....ZZ .ZZ .[
	defb 05bh,020h,01bh,01dh,01bh,01dh,004h,00dh,004h,00eh,004h,030h,091h,01bh,01dh,01bh	; 7605  [ .........0....
	defb 083h,020h,080h,080h,00fh,020h,080h,080h,03dh,020h,081h,081h,03eh,052h,003h,019h	; 7615  . ... ..= ..>R..
	defb 081h,053h,003h,01eh,081h,054h,003h,01fh,084h,00ah,023h,024h,025h,003h,019h,081h	; 7625  .S...T....#$%...
	defb 078h,003h,01eh,081h,079h,003h,01fh,086h,07ah,023h,024h,025h,00ah,05dh,003h,01fh	; 7635  x...y...z#$%.]..
	defb 085h,00fh,07ch,07bh,07ch,001h,003h,07dh,081h,001h,003h,07eh,003h,01fh,085h,083h	; 7645  ..|{|..}...~....
	defb 056h,055h,056h,00fh,003h,057h,081h,03dh,003h,058h,0aeh,03eh,059h,07fh,059h,07fh	; 7655  VUV..W.=.X.>Y.Y.
	defb 04eh,074h,04eh,074h,03fh,040h,03fh,040h,00ah,008h,00ah,00ah,059h,07fh,059h,07fh	; 7665  NtNt?@?@....Y.Y.
	defb 04fh,075h,04fh,075h,03fh,040h,03fh,040h,009h,00ah,008h,009h,032h,032h,059h,07fh	; 7675  OuOu?@?@....22Y.
	defb 048h,048h,04fh,075h,03fh,040h,03fh,040h,008h,003h,00ah,08bh,071h,073h,099h,097h	; 7685  HHOu?@?@....qs..
	defb 072h,067h,08dh,098h,00ah,00ah,009h,005h,00ah,0a0h,059h,07fh,059h,07fh,04eh,074h	; 7695  rg........Y.Y.Nt
	defb 04fh,075h,03fh,040h,03fh,040h,008h,00ah,009h,008h,059h,07fh,032h,032h,04eh,074h	; 76a5  Ou?@?@....Y.22Nt
	defb 048h,048h,03fh,040h,03fh,040h,00ah,00ah,009h,00ah,004h,03bh,094h,06ch,001h,001h	; 76b5  HH?@?@.....;.l..
	defb 092h,06dh,002h,002h,093h,06eh,003h,003h,094h,06fh,004h,004h,095h,070h,005h,005h	; 76c5  .m...n...o...p..
	defb 096h,008h,001h,004h,00ah,004h,00fh,008h,001h,004h,00ah,081h,00fh,003h,00ah,086h	; 76d5  ................
	defb 084h,00ch,00ah,00ah,085h,007h,009h,00ah,0a9h,00fh,00ah,00ah,00bh,05eh,00ah,00ah	; 76e5  .............^..
	defb 006h,05fh,085h,084h,00ch,00ah,085h,085h,007h,00ah,08ah,085h,084h,00ch,08bh,085h	; 76f5  ._..............
	defb 085h,007h,00ah,00bh,05eh,05fh,00ah,006h,05fh,05fh,00bh,05eh,05fh,064h,006h,05fh	; 7705  ....^_..__.^_d._
	defb 061h,065h,003h,001h,081h,08ah,003h,001h,081h,08bh,008h,001h,081h,064h,003h,001h	; 7715  ae...........d..
	defb 081h,065h,00ch,001h,0a0h,08ah,085h,084h,001h,08bh,085h,085h,001h,001h,08ah,085h	; 7725  .e..............
	defb 001h,001h,08bh,085h,05eh,05fh,064h,001h,05fh,061h,065h,001h,05fh,064h,001h,001h	; 7735  ....^_d._ae._d..
	defb 061h,065h,001h,001h,00ch,003h,00ah,081h,007h,003h,00ah,086h,084h,00ch,00ah,00ah	; 7745  ae..............
	defb 085h,007h,005h,00ah,081h,00bh,003h,00ah,0b5h,006h,00ah,00ah,00bh,05eh,00ah,00ah	; 7755  .............^..
	defb 006h,05fh,010h,011h,012h,013h,014h,015h,016h,017h,016h,017h,014h,015h,014h,015h	; 7765  ._..............
	defb 016h,017h,059h,07fh,032h,032h,04eh,074h,06ah,069h,03fh,069h,066h,036h,00ah,036h	; 7775  ..Y.22Ntji?if6.6
	defb 036h,021h,06ah,069h,08fh,090h,066h,036h,036h,08ch,036h,029h,029h,036h,004h,021h	; 7785  6!ji..f66.6))6.!
	defb 002h,032h,09fh,059h,07fh,08fh,090h,04fh,075h,036h,08ch,08fh,040h,021h,036h,036h	; 7795  .2.Y...Ou6..@!66
	defb 009h,032h,052h,019h,019h,048h,053h,01eh,01eh,03fh,054h,01fh,01fh,04dh,04dh,023h	; 77a5  .2R..HS..?T..MM#
	defb 024h,008h,003h,02fh,081h,00fh,003h,06bh,081h,001h,003h,06bh,081h,001h,003h,041h	; 77b5  $../...k...k...A
	defb 004h,02fh,008h,06bh,004h,041h,003h,02fh,081h,00ah,003h,06bh,081h,00fh,003h,06bh	; 77c5  ./.k.A./...k...k
	defb 081h,03dh,003h,041h,081h,03eh,004h,019h,004h,01eh,004h,01fh,095h,025h,026h,026h	; 77d5  .=.A.>.......%&&
	defb 023h,019h,019h,078h,032h,01eh,01eh,079h,048h,01fh,01fh,07ah,040h,024h,025h,04dh	; 77e5  #..x2..yH..z@$%M
	defb 04dh,05dh,003h,01fh,089h,00fh,036h,033h,033h,001h,036h,033h,033h,001h,003h,041h	; 77f5  M]....633.633..A
	defb 004h,01fh,08ch,033h,020h,00dh,00dh,033h,020h,00eh,00eh,041h,020h,030h,030h,004h	; 7805  ...3 ..3 ..A 00.
	defb 01fh,002h,00dh,08ah,020h,033h,00eh,00eh,020h,033h,030h,030h,020h,041h,003h,01fh	; 7815  .... 3.. 300 A..
	defb 089h,083h,033h,033h,036h,00fh,033h,033h,036h,03dh,003h,041h,0cah,03eh,00ah,00ah	; 7825  ..336.336=.A.>..
	defb 042h,043h,042h,043h,044h,045h,02eh,03ah,046h,047h,049h,04ah,04bh,04ch,042h,043h	; 7835  BCBCDE.:FGIJKLBC
	defb 042h,043h,044h,045h,044h,045h,02eh,03ah,046h,047h,049h,04ah,04bh,04ch,00ah,00ah	; 7845  BCDEDE.:FGIJKL..
	defb 042h,043h,00fh,00fh,044h,045h,001h,001h,046h,047h,001h,001h,04bh,04ch,042h,043h	; 7855  BC..DE..FG..KLBC
	defb 00ah,00ah,044h,045h,042h,043h,046h,047h,02eh,03ah,04bh,04ch,049h,04ah,059h,07fh	; 7865  ..DEBCFG.:KLIJY.
	defb 059h,07fh,04eh,074h,04fh,075h,068h,003h,018h,081h,05ch,003h,01eh,002h,032h,086h	; 7875  Y.NtOuh...\...2.
	defb 059h,07fh,048h,048h,04fh,075h,003h,018h,081h,08eh,003h,01eh,08ah,082h,059h,07fh	; 7885  Y.HHOu........Y.
	defb 032h,032h,04eh,074h,048h,048h,068h,003h,018h,08ch,05ch,01ch,01ah,01ch,032h,032h	; 7895  22NtHHh...\...22
	defb 059h,07fh,048h,048h,04fh,075h,003h,018h,086h,08eh,01ah,01ch,01ah,082h,05dh,003h	; 78a5  Y.HHOu........].
	defb 01fh,08ch,050h,02ah,02bh,037h,051h,02ah,02bh,038h,051h,02ch,02dh,039h,003h,01fh	; 78b5  ..P*+7Q*+8Q,-9..
	defb 0aeh,083h,037h,037h,02ah,076h,038h,038h,02ah,077h,039h,039h,02ch,077h,05dh,01dh	; 78c5  ..77*v88*w99,w].
	defb 01bh,01dh,050h,03ch,031h,031h,051h,03ch,091h,091h,051h,034h,091h,091h,01bh,01dh	; 78d5  ..P<11Q<..Q4....
	defb 01bh,083h,031h,031h,03ch,076h,091h,091h,03ch,077h,091h,091h,034h,077h,05dh,003h	; 78e5  ..11<v..<w..4w].
	defb 01fh,08ch,050h,035h,035h,037h,051h,035h,035h,038h,051h,041h,041h,039h,003h,01fh	; 78f5  ..P557Q558QAA9..
	defb 0aeh,083h,037h,037h,035h,076h,038h,038h,035h,077h,039h,039h,041h,077h,05dh,01dh	; 7905  ..775v885w99Aw].
	defb 01bh,01dh,050h,091h,037h,037h,051h,091h,038h,038h,051h,091h,039h,039h,01bh,01dh	; 7915  ..P.77Q.88Q.99..
	defb 01bh,083h,037h,037h,06bh,076h,038h,038h,06bh,077h,039h,039h,06bh,077h,052h,003h	; 7925  ..77kv88kw99kwR.
	defb 019h,08ch,053h,01ch,01ah,01ch,054h,01dh,01bh,01dh,00ah,023h,022h,025h,004h,019h	; 7935  ..S...T....#"%..
	defb 088h,01ah,01ch,01ah,01ch,01bh,01dh,01bh,01dh,004h,022h,003h,019h,0aeh,078h,01ah	; 7945  .........."...x.
	defb 01ch,01ah,079h,01bh,01dh,01bh,07ah,023h,022h,025h,00ah,05dh,01dh,01bh,01dh,00fh	; 7955  ..y...z#"%.]....
	defb 062h,062h,020h,001h,062h,062h,020h,001h,063h,063h,020h,01bh,01dh,01bh,083h,020h	; 7965  bb .bb .cc ....
	defb 088h,088h,00fh,020h,088h,088h,03dh,020h,089h,089h,03eh,052h,003h,019h,08ch,053h	; 7975  ... ..= ..>R...S
	defb 01ch,01ah,01ch,054h,01dh,01bh,01dh,00ah,033h,026h,033h,004h,019h,08ch,01ah,01ch	; 7985  ...T....3&3.....
	defb 01ah,01ch,01bh,01dh,01bh,01dh,033h,026h,026h,033h,003h,019h,08eh,078h,01ah,01ch	; 7995  ......3&&3...x..
	defb 01ah,079h,01bh,01dh,01bh,07ah,033h,026h,033h,008h,05dh,003h,01fh,081h,00fh,003h	; 79a5  .y...z3&3.].....
	defb 062h,081h,001h,003h,062h,081h,001h,003h,063h,003h,01fh,081h,083h,003h,088h,081h	; 79b5  b...b...c.......
	defb 00fh,003h,088h,081h,03dh,003h,089h,0a1h,03eh,00ah,00ah,086h,086h,00fh,00fh,087h	; 79c5  ....=...>.......
	defb 087h,001h,001h,08ah,087h,001h,001h,08bh,087h,060h,060h,00ah,00ah,061h,061h,00fh	; 79d5  .........``..aa.
	defb 00fh,061h,064h,001h,001h,061h,065h,001h,001h,004h,027h,08ch,01ah,01ch,01ah,01ch	; 79e5  .ad..ae...'.....
	defb 01bh,01dh,01bh,01dh,033h,026h,026h,033h,004h,027h,004h,01eh,004h,01fh,004h,036h	; 79f5  ....3&&3.'.....6
	defb 00ch,001h,094h,06ch,001h,001h,092h,06dh,002h,002h,093h,06eh,003h,003h,094h,06fh	; 7a05  ...l...m...n...o
	defb 004h,004h,095h,070h,005h,005h,096h,004h,01fh,004h,00dh,004h,00eh,004h,030h,000h	; 7a15  ...p..........0.

; ----------------------------------------------------------------------
; DATOS bloques_1: los bloques de 4x4 caracteres del juego de graficos 1, en
;   rle; lo leen p00:42BD (1218 bytes)
;   0x7a25..0x7ee7  (1218 bytes)
DATA_bloques_1:
	defb 010h,026h,010h,001h,004h,002h,00ch,001h,08ch,017h,018h,017h,018h,01eh,021h,01eh	; 7a25  .&............!.
	defb 021h,020h,01dh,020h,01dh,004h,026h,00ah,001h,0a6h,003h,015h,003h,015h,023h,022h	; 7a35  ! . ..&.......#"
	defb 001h,001h,003h,015h,003h,015h,023h,022h,023h,022h,024h,020h,024h,020h,020h,026h	; 7a45  ......#"#"$ $  &
	defb 016h,005h,001h,001h,022h,023h,016h,005h,020h,024h,022h,023h,026h,020h,020h,024h	; 7a55  ...."#.. $"#&  $
	defb 008h,001h,088h,016h,005h,001h,001h,022h,023h,016h,005h,003h,001h,096h,004h,001h	; 7a65  ......."#.......
	defb 001h,00fh,019h,001h,001h,019h,020h,001h,003h,01dh,026h,018h,01eh,026h,026h,021h	; 7a75  ...... ...&..&&!
	defb 020h,026h,026h,01dh,008h,026h,087h,01fh,016h,005h,026h,026h,01dh,025h,003h,026h	; 7a85   &&..&....&&.%.&
	defb 081h,01dh,004h,026h,004h,001h,081h,010h,003h,001h,086h,01fh,006h,001h,001h,026h	; 7a95  ...&...........&
	defb 007h,004h,001h,09eh,003h,015h,018h,017h,023h,023h,021h,01eh,021h,01dh,01dh,020h	; 7aa5  ........##!.!..
	defb 01dh,026h,016h,005h,001h,001h,021h,021h,017h,018h,020h,021h,01eh,021h,026h,020h	; 7ab5  .&....!!.. !.!&
	defb 020h,01dh,004h,001h,08ch,017h,018h,017h,018h,01eh,021h,01eh,021h,020h,01dh,020h	; 7ac5   .........!.! .
	defb 01dh,008h,009h,008h,026h,002h,002h,086h,008h,009h,001h,001h,00bh,009h,003h,001h	; 7ad5  ....&...........
	defb 081h,00dh,003h,001h,08ah,00fh,009h,00ah,002h,002h,009h,00ch,001h,001h,00eh,003h	; 7ae5  ................
	defb 001h,081h,010h,003h,001h,003h,002h,081h,011h,003h,001h,081h,00dh,003h,001h,081h	; 7af5  ................
	defb 00dh,003h,001h,082h,00fh,00eh,003h,002h,081h,010h,003h,001h,0d0h,01fh,006h,001h	; 7b05  ................
	defb 001h,026h,006h,001h,001h,005h,001h,004h,019h,023h,017h,019h,026h,01eh,021h,01dh	; 7b15  .&.......#..&.!.
	defb 026h,020h,01dh,026h,026h,01fh,010h,001h,001h,026h,020h,018h,017h,026h,020h,01eh	; 7b25  & .&&....& ..& .
	defb 021h,026h,026h,020h,01dh,001h,001h,008h,009h,001h,001h,00bh,009h,001h,001h,00fh	; 7b35  !&& ............
	defb 026h,001h,004h,019h,026h,009h,00ah,001h,001h,009h,00ch,001h,001h,026h,010h,001h	; 7b45  &...&........&..
	defb 001h,026h,01fh,006h,001h,012h,01ah,032h,033h,001h,001h,012h,01ah,008h,001h,004h	; 7b55  .&.....23.......
	defb 030h,0a2h,032h,033h,030h,030h,012h,01ah,032h,033h,001h,001h,012h,01ah,02ah,02bh	; 7b65  0.2300..23....*+
	defb 02dh,02fh,02dh,02fh,02eh,030h,02eh,030h,01bh,013h,01bh,013h,001h,001h,02eh,030h	; 7b75  -/-/.0.0.......0
	defb 01bh,013h,01bh,013h,00ah,001h,088h,002h,012h,01ch,033h,001h,001h,014h,035h,003h	; 7b85  ..........3...5.
	defb 001h,081h,01ch,003h,001h,091h,014h,01ch,033h,030h,030h,014h,035h,030h,030h,001h	; 7b95  ........300.500.
	defb 01ch,032h,033h,001h,014h,034h,035h,004h,027h,082h,028h,029h,003h,027h,082h,028h	; 7ba5  .23..45.'.().'.(
	defb 029h,00ah,027h,083h,028h,029h,028h,00ch,027h,08ch,028h,06ah,06bh,06ch,072h,073h	; 7bb5  ).'.()(.'.(jklrs
	defb 074h,075h,061h,068h,071h,058h,004h,027h,08ch,06dh,06eh,06fh,070h,076h,073h,077h	; 7bc5  tuahqX.'.mnopvsw
	defb 078h,069h,067h,077h,056h,004h,027h,08ch,06ah,06bh,06ch,07eh,060h,074h,073h,083h	; 7bd5  xigwV.'.jkl~`ts.
	defb 058h,071h,058h,067h,006h,027h,083h,028h,029h,07eh,003h,027h,08ch,04fh,06ch,07eh	; 7be5  XqXg.'.()~.'.Ol~
	defb 027h,04dh,060h,061h,062h,066h,066h,065h,066h,003h,030h,081h,066h,004h,030h,08ch	; 7bf5  'M`abffef.0.f.0.
	defb 04fh,074h,074h,078h,056h,05eh,056h,065h,030h,04dh,066h,066h,004h,030h,08ch,060h	; 7c05  OttxV^Ve0Mff.0.`
	defb 061h,062h,044h,04dh,05eh,04ah,05eh,066h,030h,030h,04dh,004h,030h,090h,063h,062h	; 7c15  abDM^J^f00M.0.cb
	defb 083h,082h,044h,05fh,069h,042h,030h,04dh,04ah,04dh,030h,030h,04dh,04dh,005h,027h	; 7c25  ..D_iB0MJM00MM.'
	defb 085h,028h,029h,028h,028h,029h,003h,027h,083h,084h,040h,03eh,006h,027h,08ah,084h	; 7c35  .()(().'..@>.'..
	defb 040h,040h,06ch,07dh,064h,05eh,04dh,056h,030h,004h,027h,088h,06ch,040h,06bh,06ch	; 7c45  @@l}d^MV0.'.l@kl
	defb 04dh,04dh,05fh,04fh,004h,030h,004h,027h,081h,07eh,003h,027h,092h,04fh,06ch,040h	; 7c55  MM_O.0.'.~.'.Ol@
	defb 06ch,04dh,065h,04dh,05eh,07ch,07dh,075h,065h,064h,065h,056h,04dh,065h,04dh,006h	; 7c65  lMeM^|}uedeVMeM.
	defb 030h,083h,027h,028h,029h,004h,027h,089h,072h,027h,027h,06ah,067h,06ah,06bh,064h	; 7c75  0.'().'.r''jgjkd
	defb 04dh,004h,027h,0ffh,082h,028h,027h,028h,067h,06ch,07eh,027h,04dh,05fh,083h,082h	; 7c85  M.'..('(gl~'M_..
	defb 030h,030h,02ah,02bh,02ah,02bh,02dh,02ch,02eh,02fh,02eh,033h,031h,033h,032h,035h	; 7c95  00*+*+-,./.31325
	defb 07ch,07dh,05eh,05fh,064h,065h,066h,065h,065h,033h,032h,033h,033h,035h,034h,035h	; 7ca5  |}^_defee3233545
	defb 04fh,060h,061h,062h,066h,04fh,065h,05fh,032h,033h,030h,066h,034h,035h,033h,030h	; 7cb5  O`abfOe_230f4530
	defb 04fh,060h,061h,062h,066h,04fh,065h,05fh,030h,030h,02ah,02bh,02ah,02bh,02dh,02ch	; 7cc5  O`abfOe_00*+*+-,
	defb 063h,062h,083h,082h,044h,04dh,065h,069h,02ah,02bh,030h,04ah,02dh,02ch,02ah,02bh	; 7cd5  cb..DMei*+0J-,*+
	defb 030h,030h,02ah,02bh,02ah,02bh,02dh,02ch,02dh,02ch,02eh,02fh,031h,030h,031h,030h	; 7ce5  00*+*+-,-,./1010
	defb 02ah,02bh,02ah,02bh,02dh,02ch,02dh,02ch,02eh,02fh,02eh,02fh,031h,030h,031h,030h	; 7cf5  *+*+-,-,././1010
	defb 02ah,02bh,030h,0c6h,030h,02dh,02ch,02ah,02bh,02eh,02fh,02dh,02ch,031h,030h,031h	; 7d05  *+0.0-,*+./-,101
	defb 030h,02dh,02ch,02dh,02ch,02dh,02ch,02eh,02fh,032h,033h,036h,033h,035h,034h,037h	; 7d15  0-,-,-,./2363547
	defb 035h,038h,039h,039h,03ah,03bh,03ch,03ch,03dh,033h,036h,033h,032h,035h,037h,035h	; 7d25  5899:;<<=3632575
	defb 034h,038h,039h,03ah,030h,03bh,03ch,03dh,030h,033h,032h,033h,033h,035h,034h,035h	; 7d35  489:0;<=03233545
	defb 035h,038h,039h,039h,03ah,03bh,03ch,03ch,03dh,032h,003h,033h,09dh,034h,035h,034h	; 7d45  5899:;<<=2.3.454
	defb 035h,02ah,02bh,02ah,02bh,02dh,02ch,02eh,02fh,033h,033h,032h,033h,034h,035h,034h	; 7d55  5*+*+-,./3323454
	defb 035h,065h,05eh,056h,065h,030h,04dh,066h,030h,030h,003h,03fh,081h,07ah,003h,041h	; 7d65  5e^Ve0Mf00.?.z.A
	defb 088h,04fh,05eh,04ah,05eh,066h,030h,030h,04dh,003h,03fh,081h,030h,003h,041h,082h	; 7d75  .O^J^f00M.?.0.A.
	defb 080h,07bh,003h,041h,08ch,043h,049h,048h,048h,043h,04bh,030h,030h,043h,04ch,030h	; 7d85  .{.A.CIHHCK00CL0
	defb 030h,003h,041h,09dh,081h,048h,049h,049h,043h,030h,04bh,04bh,043h,030h,04ch,04ch	; 7d95  0.A..HIIC0KKC0LL
	defb 043h,05eh,079h,04eh,04eh,066h,050h,051h,051h,030h,053h,054h,054h,079h,057h,059h	; 7da5  C^yNNfPQQ0STTyWY
	defb 059h,004h,04eh,004h,051h,004h,054h,004h,059h,002h,04eh,08fh,07fh,066h,051h,051h	; 7db5  Y.N.Q.T.Y.N..fQQ
	defb 052h,030h,054h,054h,055h,030h,059h,059h,057h,07fh,050h,003h,051h,081h,030h,003h	; 7dc5  R0TTU0YYW.P.Q.0.
	defb 05ah,081h,032h,003h,05bh,081h,034h,003h,05ch,004h,051h,00ch,030h,003h,051h,085h	; 7dd5  Z.2.[.4.\.Q.0.Q.
	defb 052h,05dh,05ah,05ah,030h,003h,05bh,081h,033h,003h,05ch,0a2h,035h,030h,079h,04eh	; 7de5  R]ZZ0.[.3.\.50yN
	defb 04eh,030h,050h,051h,051h,030h,053h,054h,054h,030h,043h,04ch,04ch,04eh,04eh,07fh	; 7df5  N0PQQ0STT0CLLNN.
	defb 030h,051h,051h,052h,030h,054h,054h,055h,030h,04ch,04ch,043h,030h,050h,003h,051h	; 7e05  0QQR0TTU0LLC0P.Q
	defb 081h,043h,003h,05ah,081h,043h,003h,046h,081h,043h,003h,047h,004h,051h,004h,048h	; 7e15  .C.Z.C.F.C.G.Q.H
	defb 008h,030h,003h,051h,085h,052h,05dh,05ah,05ah,043h,003h,046h,081h,043h,003h,047h	; 7e25  .0.Q.R]ZZC.F.C.G
	defb 081h,043h,005h,027h,002h,028h,081h,029h,008h,027h,081h,07bh,003h,041h,08ch,043h	; 7e35  .C.'.(.).'.{.A.C
	defb 045h,045h,048h,043h,046h,046h,030h,043h,047h,047h,030h,003h,041h,090h,081h,048h	; 7e45  EEHCFF0CGG0.A..H
	defb 048h,045h,043h,030h,030h,046h,043h,030h,030h,047h,043h,028h,028h,029h,003h,027h	; 7e55  HEC00FC00GC(().'
	defb 082h,028h,029h,008h,027h,089h,023h,025h,023h,020h,024h,025h,01dh,026h,020h,007h	; 7e65  .().'.#%# $%.& .
	defb 026h,088h,023h,025h,023h,025h,026h,020h,01dh,025h,003h,026h,081h,020h,004h,026h	; 7e75  &.#%#%& .%.&. .&
	defb 008h,001h,084h,017h,018h,017h,018h,004h,01eh,08dh,04dh,060h,061h,062h,030h,066h	; 7e85  ..........M`ab0f
	defb 064h,065h,033h,030h,04dh,056h,035h,003h,030h,004h,04eh,004h,051h,004h,054h,004h	; 7e95  de30MV5.0.N.Q.T.
	defb 04ch,005h,030h,08bh,000h,02ah,02bh,02ah,02bh,02dh,02ch,02dh,02ch,02eh,02fh,00ah	; 7ea5  L.0..*+*+-,-,./.
	defb 030h,086h,033h,032h,030h,033h,034h,034h,008h,030h,081h,033h,003h,030h,081h,035h	; 7eb5  0.320344.0.3.0.5
	defb 003h,030h,08eh,026h,006h,001h,001h,026h,007h,001h,001h,026h,00eh,001h,001h,026h	; 7ec5  .0.&...&...&...&
	defb 007h,005h,001h,081h,00fh,003h,001h,089h,022h,001h,001h,00dh,022h,001h,001h,00dh	; 7ed5  ........"..."...
	defb 019h,000h	; 7ee5

; ----------------------------------------------------------------------
; DATOS bloques_4: los bloques de 4x4 caracteres del juego de graficos 4, en
;   rle; lo leen p00:42BD (281 bytes)
;   0x7ee7..0x8000  (281 bytes)
DATA_bloques_4:
	defb 010h,001h,002h,030h,086h,066h,024h,04eh,067h,068h,025h,004h,024h,004h,025h,004h	; 7ee7  ...0.f$Ngh%.$.%.
	defb 024h,004h,025h,004h,024h,004h,025h,088h,024h,087h,030h,030h,025h,089h,088h,04fh	; 7ef7  $.%.$.%.$.00%..O
	defb 004h,024h,004h,025h,002h,030h,086h,04eh,04fh,04eh,04fh,050h,051h,004h,024h,004h	; 7f07  .$.%.0.NONOPQ.$.
	defb 025h,088h,046h,047h,030h,030h,048h,049h,04eh,04fh,004h,024h,004h,025h,088h,04eh	; 7f17  %.FG00HINO.$.%.N
	defb 04fh,030h,030h,050h,051h,04eh,04fh,004h,024h,004h,025h,002h,030h,086h,034h,035h	; 7f27  O00PQNO.$.%.0.45
	defb 04eh,04fh,036h,037h,004h,024h,004h,025h,084h,02fh,029h,02fh,029h,004h,02ah,08ch	; 7f37  NO67.$.%./)/).*.
	defb 03bh,03ch,03dh,03eh,03fh,040h,041h,042h,029h,02fh,02fh,029h,004h,02ah,088h,03bh	; 7f47  ;<=>?@AB)//).*.;
	defb 03ch,03dh,070h,03fh,040h,071h,072h,004h,04ah,004h,04bh,004h,04ch,004h,04dh,084h	; 7f57  <=p?@qr.J.K.L.M.
	defb 029h,02fh,02fh,029h,004h,02ah,0a8h,091h,03ch,03dh,03eh,093h,092h,041h,042h,02fh	; 7f67  )//).*..<=>..AB/
	defb 032h,02fh,029h,02ah,033h,02ah,02ah,03bh,03ch,03dh,03eh,03fh,040h,041h,042h,03bh	; 7f77  2/)*3**;<=>?@AB;
	defb 03ch,070h,074h,010h,075h,076h,077h,00fh,078h,079h,00dh,00fh,078h,07ah,00eh,004h	; 7f87  <pt.uvw.xy..xz..
	defb 00ch,008h,00dh,004h,00eh,08fh,095h,091h,03dh,03eh,098h,097h,096h,011h,00dh,09ah	; 7f97  ........=>......
	defb 099h,00fh,00eh,09bh,099h,011h,00fh,088h,018h,019h,018h,019h,01ah,01bh,01ah,01bh	; 7fa7  ................
	defb 008h,00fh,088h,03bh,03ch,03dh,03eh,010h,01eh,010h,011h,008h,00fh,084h,02bh,031h	; 7fb7  ...;<=>.......+1
	defb 031h,02bh,004h,043h,004h,044h,004h,045h,003h,00fh,081h,012h,003h,00fh,08ah,008h	; 7fc7  1+.C.D.E........
	defb 00fh,00fh,012h,001h,00fh,00fh,008h,001h,013h,003h,00fh,081h,009h,003h,00fh,086h	; 7fd7  ................
	defb 001h,013h,00fh,00fh,001h,009h,003h,00fh,088h,012h,001h,001h,00fh,008h,001h,001h	; 7fe7  ................
	defb 012h,003h,001h,081h,008h,005h,001h,086h,013h	; 7ff7  .........
