; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX2 - MegaROM RC-748 de 128 KB (Konami4) - banco 12 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS figura_1E_cola: el dibujo de la figura de tipo 0x1E en rle (p00:547C;
;   p00:54AB lo vuelve a leer dado la vuelta si la ficha lo pide) (sigue del
;   banco anterior, 0x9F67); lo leen p00:547C (190 bytes)
;   0xa000..0xa0be  (190 bytes)
DATA_figura_1E_cola:
	defb 0c0h,0c0h,080h,0c0h,000h,000h,0ach,030h,0d8h,0d8h,000h,038h,0c4h,0c4h,0b4h,070h	; a000  .......0...8...p
	defb 078h,01ch,07ch,005h,000h,08dh,001h,007h,018h,020h,046h,0a9h,0b9h,0c6h,0a0h,080h	; a010  x.|...... F.....
	defb 0a0h,043h,07fh,003h,000h,08dh,0e0h,0f0h,038h,008h,004h,03ch,0fch,04ch,048h,010h	; a020  .C......8..<.LH.
	defb 020h,0ffh,0efh,005h,000h,08ah,007h,01fh,039h,056h,046h,039h,05fh,07fh,05fh,03ch	; a030   .......9VF9_._<
	defb 006h,000h,08fh,0c0h,0f0h,0f8h,0c0h,000h,0b0h,0b0h,0e0h,0c0h,000h,056h,000h,00fh	; a040  .............V..
	defb 01fh,00fh,004h,000h,004h,001h,004h,000h,089h,01fh,0ffh,0e7h,0c2h,040h,038h,047h	; a050  .............@8G
	defb 0ffh,083h,003h,0ffh,087h,0feh,07ch,000h,0ffh,000h,000h,00bh,00eh,000h,08ch,007h	; a060  ......|.........
	defb 0d8h,03dh,03fh,007h,000h,000h,07ch,082h,0fah,0f6h,07ch,003h,000h,002h,0ffh,083h	; a070  .=?...|...|.....
	defb 00fh,01fh,03fh,004h,0ffh,08dh,00fh,084h,044h,022h,042h,08ch,0ffh,0cch,0e4h,0e4h	; a080  ..?.....D"B.....
	defb 0fch,0feh,0c3h,003h,0ffh,0a1h,0feh,07ch,060h,040h,020h,020h,0feh,07fh,000h,0f7h	; a090  .......|`@  ....
	defb 0efh,0dfh,000h,060h,0ffh,00fh,0f0h,07bh,03bh,01dh,03dh,073h,000h,030h,0d8h,0d8h	; a0a0  ...`...{;.=s.0..
	defb 0c0h,000h,03ch,0c2h,0dah,0b6h,03ch,003h,080h,002h,0c0h,081h,000h,000h	; a0b0  ..<...<.......

; ----------------------------------------------------------------------
; DATOS figura_1F: el dibujo de la figura de tipo 0x1F en rle (p00:547C;
;   p00:54AB lo vuelve a leer dado la vuelta si la ficha lo pide); lo leen
;   p00:547C (322 bytes)
;   0xa0be..0xa200  (322 bytes)
DATA_figura_1F:
	defb 008h,000h,08dh,07fh,02eh,015h,015h,03fh,037h,03fh,01eh,044h,06ch,010h,008h,008h	; a0be  .......?7?.Dl...
	defb 003h,000h,081h,0fch,004h,080h,082h,0d8h,0f0h,003h,000h,098h,003h,00fh,00fh,03fh	; a0ce  ...............?
	defb 07fh,07fh,080h,0d1h,0eah,0eah,0c0h,048h,048h,021h,000h,000h,0ech,0f6h,0f7h,0ffh	; a0de  .......HH!......
	defb 0fbh,0fch,002h,07eh,003h,07fh,0b0h,027h,00eh,0f6h,01fh,019h,035h,0c4h,0d5h,031h	; a0ee  ...~...'....5..1
	defb 01fh,01fh,015h,011h,03fh,021h,051h,0ffh,0ffh,000h,05fh,01fh,05fh,07fh,07fh,0fah	; a0fe  ....?!Q..._._...
	defb 0f6h,0f6h,056h,012h,0fdh,021h,01fh,0ffh,0fch,000h,001h,007h,01fh,03fh,03fh,01eh	; a10e  ..V..!.......??.
	defb 001h,000h,00fh,00fh,000h,01eh,02eh,003h,000h,002h,0f6h,08ah,0eeh,0d6h,0bah,074h	; a11e  ...............t
	defb 0ech,01ch,0fch,0fch,002h,01eh,00ah,000h,082h,07fh,01fh,00bh,000h,002h,003h,083h	; a12e  ................
	defb 038h,0e0h,080h,00dh,000h,084h,0ffh,080h,060h,01fh,005h,000h,081h,003h,004h,000h	; a13e  8.......`.......
	defb 086h,003h,01fh,0c4h,018h,060h,080h,004h,000h,082h,003h,0ffh,009h,000h,08dh,07fh	; a14e  .....`..........
	defb 02eh,015h,015h,03fh,037h,0bfh,0deh,044h,06ch,010h,008h,008h,003h,000h,081h,0fch	; a15e  ...?7..Dl.......
	defb 004h,080h,082h,0d8h,0f0h,003h,000h,098h,003h,00fh,00fh,03fh,07fh,07fh,080h,0d1h	; a16e  ...........?....
	defb 0eah,0eah,0c0h,0c8h,048h,021h,000h,000h,0ech,0f6h,0f7h,0ffh,0fbh,0fch,002h,07eh	; a17e  ....H!.........~
	defb 003h,07fh,097h,027h,00eh,0f0h,0feh,0a2h,0aah,088h,06bh,01fh,00fh,017h,015h,011h	; a18e  ...'......k.....
	defb 015h,014h,00fh,008h,007h,07fh,0a8h,02eh,0afh,0cfh,003h,0ffh,08ah,0feh,054h,014h	; a19e  ..............T.
	defb 058h,048h,0f0h,050h,0f0h,0f8h,001h,003h,07fh,084h,01eh,001h,007h,008h,004h,00fh	; a1ae  XH.P............
	defb 092h,000h,007h,000h,000h,0f0h,0f0h,0d6h,0b6h,00eh,0f6h,0fah,000h,0f8h,0f8h,0f0h	; a1be  ................
	defb 0f0h,000h,0a0h,003h,000h,002h,008h,002h,00ch,084h,00eh,007h,007h,001h,00eh,000h	; a1ce  ................
	defb 002h,080h,084h,040h,030h,038h,018h,003h,000h,08ah,008h,014h,014h,012h,012h,011h	; a1de  ...@08..........
	defb 008h,008h,006h,001h,00ch,000h,08ah,080h,040h,040h,0a0h,070h,038h,01ch,00eh,007h	; a1ee  ........@@.p8...
	defb 003h,000h	; a1fe

; ----------------------------------------------------------------------
; DATOS de_mas_A200: dibujo de mas de la figura de tipo 0x1F, en rle
;   (p00:5454); lo leen p00:5454 (160 bytes)
;   0xa200..0xa2a0  (160 bytes)
DATA_de_mas_A200:
	defb 085h,000h,030h,030h,008h,008h,004h,000h,081h,001h,003h,000h,081h,001h,00dh,000h	; a200  ..00............
	defb 002h,080h,004h,000h,002h,030h,002h,000h,002h,00ch,083h,03fh,07fh,0feh,003h,0ffh	; a210  .....0.....?....
	defb 083h,0feh,07fh,03fh,008h,000h,087h,080h,0c0h,0c0h,040h,040h,0c0h,080h,005h,000h	; a220  ...?......@@....
	defb 089h,001h,002h,004h,009h,00ah,009h,004h,002h,001h,007h,000h,089h,0c0h,020h,090h	; a230  .............. .
	defb 048h,028h,048h,090h,020h,0c0h,006h,000h,08bh,002h,004h,008h,011h,002h,014h,002h	; a240  H(H. ...........
	defb 011h,008h,004h,002h,005h,000h,08bh,0a0h,010h,088h,044h,020h,014h,020h,044h,088h	; a250  ..........D . D.
	defb 010h,0a0h,005h,000h,08bh,001h,006h,008h,009h,012h,014h,012h,009h,008h,006h,001h	; a260  ................
	defb 005h,000h,08bh,0c0h,030h,088h,048h,024h,014h,024h,048h,088h,030h,0c0h,004h,000h	; a270  ....0.H$.$H.0...
	defb 09eh,005h,008h,011h,022h,004h,029h,04ah,029h,004h,022h,011h,008h,005h,000h,000h	; a280  ....".)J).".....
	defb 080h,050h,008h,0c4h,022h,090h,04ah,029h,04ah,090h,022h,0c4h,008h,050h,080h,000h	; a290  .P..".J)J."..P..

; ----------------------------------------------------------------------
; DATOS figura_20: el dibujo de la figura de tipo 0x20 en rle (p00:547C;
;   p00:54AB lo vuelve a leer dado la vuelta si la ficha lo pide); lo leen
;   p00:547C (343 bytes)
;   0xa2a0..0xa3f7  (343 bytes)
DATA_figura_20:
	defb 004h,000h,08ch,020h,01eh,01fh,00fh,009h,00eh,008h,05dh,04fh,06dh,0bah,081h,005h	; a2a0  ... ......]Om...
	defb 000h,08bh,040h,0e0h,0f0h,0e0h,0d0h,090h,090h,030h,0f0h,030h,0d0h,003h,000h,08dh	; a2b0  ..@......0.0....
	defb 00fh,0dfh,061h,060h,0f0h,0f6h,0f1h,0f7h,0a2h,0b0h,092h,045h,07eh,004h,000h,08eh	; a2c0  ..a`.......E~...
	defb 0c0h,0a0h,010h,008h,018h,028h,068h,068h,0c8h,008h,0c8h,028h,081h,07fh,004h,0ffh	; a2d0  .....(hh...(....
	defb 083h,07fh,03fh,03fh,003h,07fh,004h,0ffh,089h,0feh,0f9h,0fdh,0ffh,0feh,0feh,0fch	; a2e0  ..??............
	defb 0f8h,0f0h,003h,0f8h,002h,0fch,084h,0f8h,0ffh,07eh,001h,003h,07fh,08eh,071h,03eh	; a2f0  .........~....q>
	defb 000h,007h,02eh,03fh,01fh,00fh,07fh,07fh,000h,000h,0f6h,0fah,003h,0fch,089h,0f8h	; a300  ...?............
	defb 000h,0e0h,030h,0d0h,0e0h,0f8h,0f8h,0f0h,005h,000h,084h,020h,018h,00eh,003h,003h	; a310  ..0........ ....
	defb 000h,083h,001h,002h,002h,009h,000h,088h,080h,0c0h,020h,0c0h,000h,081h,087h,083h	; a320  .......... .....
	defb 004h,000h,08ch,060h,058h,026h,011h,00ch,003h,000h,001h,003h,007h,007h,003h,007h	; a330  ...`X&..........
	defb 000h,08ah,080h,040h,020h,0f0h,0fch,0cfh,0c6h,0c8h,0c4h,083h,005h,000h,08bh,010h	; a340  ...@ ...........
	defb 00fh,00fh,007h,004h,007h,004h,02eh,027h,036h,01dh,006h,000h,08ah,020h,0f0h,0f8h	; a350  .......'6.... ..
	defb 0f0h,068h,048h,0c8h,098h,0f8h,019h,004h,000h,08ch,007h,06fh,030h,030h,078h,07bh	; a360  .hH........o00x{
	defb 078h,07bh,051h,058h,049h,022h,004h,000h,096h,080h,0e0h,0d0h,008h,004h,00ch,094h	; a370  x{QXI"..........
	defb 0b4h,034h,064h,005h,0e6h,01bh,0fch,083h,0f1h,0ffh,0ffh,0f9h,0e3h,060h,071h,006h	; a380  .4d..........`q.
	defb 0ffh,082h,014h,00ch,004h,0ffh,085h,0feh,0fch,0f8h,0f8h,0feh,005h,0ffh,08bh,004h	; a390  ................
	defb 003h,07ch,00eh,071h,07eh,066h,05ch,01fh,00eh,061h,003h,07fh,091h,07eh,000h,0ebh	; a3a0  .|.q~f\..a...~..
	defb 0f3h,000h,002h,08eh,016h,034h,078h,000h,0f0h,0f8h,0beh,03eh,07eh,07eh,007h,000h	; a3b0  .....4x....>~~..
	defb 097h,001h,004h,002h,001h,000h,000h,001h,080h,080h,000h,000h,004h,008h,030h,060h	; a3c0  ..............0`
	defb 0c0h,080h,000h,000h,080h,000h,0a0h,020h,008h,000h,09bh,001h,002h,007h,00fh,01fh	; a3d0  ....... ........
	defb 039h,071h,0e3h,041h,040h,080h,006h,00ah,034h,048h,090h,020h,040h,080h,080h,0e0h	; a3e0  9q.A@...4H. @...
	defb 0e0h,0f0h,0f0h,020h,000h,000h,000h	; a3f0

; ----------------------------------------------------------------------
; DATOS figura_21: el dibujo de la figura de tipo 0x21 en rle (p00:547C;
;   p00:54AB lo vuelve a leer dado la vuelta si la ficha lo pide); lo leen
;   p00:547C (190 bytes)
;   0xa3f7..0xa4b5  (190 bytes)
DATA_figura_21:
	defb 004h,000h,08ch,007h,00dh,0f0h,060h,0c0h,091h,01fh,024h,036h,016h,01fh,01fh,005h	; a3f7  ......`...$6....
	defb 000h,08bh,080h,03eh,01ch,02eh,02ah,080h,0a0h,060h,0c0h,0d8h,0d0h,003h,000h,08dh	; a407  ...>..*..`......
	defb 003h,008h,072h,0bfh,07fh,03fh,06eh,0e0h,0dbh,0c9h,0e9h,060h,024h,003h,000h,09eh	; a417  ..r..?n....`$...
	defb 0fch,0feh,07fh,0ebh,0feh,0d1h,0d5h,07fh,05fh,09fh,03fh,027h,02eh,00fh,000h,001h	; a427  ........_.?'....
	defb 007h,01fh,000h,05fh,04ah,05eh,001h,01dh,00eh,017h,077h,000h,000h,040h,003h,080h	; a437  ..._J^....w..@..
	defb 0bdh,098h,03ch,0bch,01ch,0ech,0fch,0f8h,078h,080h,0fch,000h,000h,030h,06fh,066h	; a447  ..<.....x....0of
	defb 07fh,07fh,0ffh,0e0h,0ffh,0a1h,07fh,03ah,035h,07ah,0ffh,0ffh,000h,0b8h,070h,070h	; a457  .......:5z....pp
	defb 0f8h,0fch,0feh,06eh,0f6h,0bah,056h,0ach,0d4h,0fch,0feh,0feh,000h,00fh,000h,001h	; a467  ...n..V.........
	defb 007h,01fh,000h,05fh,04ah,05eh,001h,01dh,00eh,017h,017h,037h,000h,040h,003h,080h	; a477  ..._J^.....7.@..
	defb 0ach,098h,03ch,0bch,01ch,0ech,0fch,0f8h,078h,080h,0f0h,0f8h,000h,030h,06fh,066h	; a487  ..<.....x....0of
	defb 07fh,07fh,0ffh,0e0h,0ffh,0a1h,07fh,03ah,035h,03ah,03fh,07fh,07fh,0b8h,070h,070h	; a497  .......:5:?...pp
	defb 0f8h,0fch,0feh,06eh,0f6h,0bah,056h,0ach,0d4h,0f8h,0f8h,0fch,0feh,000h	; a4a7  ...n..V.......

; ----------------------------------------------------------------------
; DATOS figura_22: el dibujo de la figura de tipo 0x22 en rle (p00:547C;
;   p00:54AB lo vuelve a leer dado la vuelta si la ficha lo pide); lo leen
;   p00:547C (231 bytes)
;   0xa4b5..0xa59c  (231 bytes)
DATA_figura_22:
	defb 004h,000h,08ch,003h,005h,008h,010h,02ch,020h,024h,04ah,040h,021h,024h,023h,004h	; a4b5  ......., $J@!$#.
	defb 000h,08ch,080h,0c0h,020h,010h,068h,008h,048h,0a4h,004h,008h,048h,088h,005h,000h	; a4c5  .... .h.H...H...
	defb 08bh,002h,007h,00fh,013h,01fh,01bh,035h,03fh,01eh,01bh,01ch,006h,000h,08ch,0c0h	; a4d5  .......5?.......
	defb 0e0h,090h,0f0h,0b0h,058h,0f8h,0f0h,0b0h,070h,070h,07ch,003h,0ffh,084h,0fch,0fbh	; a4e5  ....X...pp|.....
	defb 078h,03ch,004h,03fh,085h,027h,053h,03ch,01ch,07ch,003h,0feh,084h,07eh,0beh,03ch	; a4f5  x<.?.'S<.|...~.<
	defb 078h,004h,0f8h,0a2h,0c8h,094h,078h,00fh,003h,004h,003h,000h,003h,004h,007h,013h	; a505  x.....x.........
	defb 014h,018h,00fh,000h,018h,02ch,000h,0e0h,080h,040h,080h,000h,080h,040h,0c0h,090h	; a515  .....,...@...@..
	defb 050h,030h,0e0h,000h,030h,068h,006h,000h,08bh,001h,007h,009h,010h,02ch,020h,024h	; a525  P0..0h......., $
	defb 04ah,040h,021h,064h,005h,000h,08bh,080h,0c0h,0a0h,010h,068h,008h,048h,0a4h,004h	; a535  J@!d.......h.H..
	defb 008h,04ch,007h,000h,089h,006h,00fh,013h,01fh,01bh,035h,03fh,01eh,01bh,007h,000h	; a545  .L........5?....
	defb 091h,040h,0e0h,090h,0f0h,0b0h,058h,0f8h,0f0h,0b0h,067h,0f3h,0fch,0ffh,0fch,0fbh	; a555  .@....X...g.....
	defb 078h,03ch,005h,03fh,08bh,027h,053h,03ch,0cch,09eh,07eh,0feh,07eh,0beh,03ch,078h	; a565  x<.?.'S<..~.~.<x
	defb 005h,0f8h,0a3h,0c8h,094h,078h,018h,00ch,003h,000h,003h,004h,007h,003h,014h,017h	; a575  .....x..........
	defb 018h,00fh,000h,018h,02ch,000h,030h,060h,080h,000h,080h,040h,0c0h,080h,050h,0d0h	; a585  ....,.0`...@..P.
	defb 030h,0e0h,000h,030h,068h,000h,000h	; a595

; ----------------------------------------------------------------------
; DATOS figura_23: el dibujo de la figura de tipo 0x23 en rle (p00:547C;
;   p00:54AB lo vuelve a leer dado la vuelta si la ficha lo pide); lo leen
;   p00:547C (243 bytes)
;   0xa59c..0xa68f  (243 bytes)
DATA_figura_23:
	defb 004h,000h,08ch,007h,000h,000h,006h,00fh,01dh,01fh,013h,01dh,03fh,01bh,01fh,004h	; a59c  ............?...
	defb 000h,08ch,0c0h,000h,000h,0c0h,0e0h,070h,0f0h,090h,070h,0f8h,0b0h,0f0h,003h,000h	; a5ac  .......p..p.....
	defb 08dh,007h,008h,01fh,01fh,039h,070h,0e2h,0e0h,0ech,0e2h,040h,024h,023h,003h,000h	; a5bc  .....9p....@$#..
	defb 0b6h,0c0h,020h,0f0h,0f0h,038h,01ch,08eh,00eh,06eh,08eh,004h,048h,088h,02fh,033h	; a5cc  .. ..8...n..H./3
	defb 074h,07bh,07ch,07bh,074h,007h,013h,010h,010h,01fh,007h,01bh,02ch,000h,0e0h,098h	; a5dc  t{|{t.......,...
	defb 05ch,0bch,07ch,0bch,05ch,0c0h,090h,010h,010h,0f0h,0c0h,0b0h,068h,000h,070h,07ch	; a5ec  \.|.\.......h.p|
	defb 0fbh,0fch,0ffh,0fch,0fbh,078h,03ch,004h,03fh,08ch,027h,053h,0ffh,01ch,07ch,0beh	; a5fc  .....x<.?.'S..|.
	defb 07eh,0feh,07eh,0beh,03ch,078h,004h,0f8h,083h,0c8h,094h,0ffh,005h,000h,08bh,007h	; a60c  ~.~.<x..........
	defb 000h,000h,006h,00fh,01dh,01fh,013h,01dh,03fh,01eh,005h,000h,08bh,0c0h,000h,000h	; a61c  ........?.......
	defb 0c0h,0e0h,070h,0f0h,090h,070h,0f8h,0f0h,004h,000h,08ch,007h,008h,01fh,01fh,039h	; a62c  ..p..p.........9
	defb 070h,0e2h,0e0h,0ech,0e2h,040h,021h,004h,000h,094h,0c0h,020h,0f0h,0f0h,038h,01ch	; a63c  p....@!.... ..8.
	defb 08eh,00eh,06eh,08eh,004h,008h,01ch,06fh,073h,07ch,07bh,074h,037h,003h,003h,010h	; a64c  ..n....os|{t7...
	defb 08dh,01fh,007h,01bh,02ch,000h,070h,0ech,0bch,07ch,0bch,05ch,0d8h,080h,003h,010h	; a65c  ....,.p..|.\....
	defb 08dh,0f0h,0c0h,0b0h,068h,000h,063h,0f1h,0fch,0ffh,0fch,0fbh,078h,03ch,005h,03fh	; a66c  ....h.c.....x<.?
	defb 08bh,027h,053h,0ffh,08ch,01eh,07eh,0feh,07eh,0beh,03ch,078h,005h,0f8h,083h,0c8h	; a67c  .'S...~.~.<x....
	defb 094h,0ffh,000h	; a68c

; ----------------------------------------------------------------------
; DATOS figura_24: el dibujo de la figura de tipo 0x24 en rle (p00:547C;
;   p00:54AB lo vuelve a leer dado la vuelta si la ficha lo pide); lo leen
;   p00:547C (244 bytes)
;   0xa68f..0xa783  (244 bytes)
DATA_figura_24:
	defb 004h,000h,08ch,002h,006h,007h,007h,00fh,003h,029h,02fh,02eh,01fh,01ch,00bh,004h	; a68f  .........)/.....
	defb 000h,08ch,040h,060h,0e0h,0e0h,0f0h,0c0h,094h,0f4h,074h,0f8h,038h,0d0h,003h,000h	; a69f  ..@`......t.8...
	defb 08dh,003h,005h,009h,018h,038h,070h,07ch,056h,050h,051h,020h,023h,014h,003h,000h	; a6af  .....8p|VPQ #...
	defb 0a7h,0c0h,0a0h,090h,018h,01ch,00eh,03eh,06ah,01ah,09ah,024h,0c4h,028h,010h,00ch	; a6bf  .......>j..$.(..
	defb 07fh,0c0h,080h,0c3h,0feh,07bh,038h,03ch,01fh,01fh,03fh,03fh,07fh,07fh,008h,03ch	; a6cf  .....{8<..??...<
	defb 0c2h,001h,00dh,0f3h,061h,002h,006h,07eh,004h,0fch,002h,0feh,0a0h,00fh,003h,000h	; a6df  ....a..~........
	defb 03fh,07fh,03ch,001h,004h,007h,003h,000h,018h,006h,001h,003h,006h,0f0h,0c0h,03ch	; a6ef  ?.<............<
	defb 0feh,0f2h,00ch,09eh,0fch,0f8h,080h,000h,00ch,0b0h,040h,060h,030h,006h,000h,08ah	; a6ff  ..........@`0...
	defb 002h,006h,007h,007h,00fh,003h,029h,02fh,02eh,01fh,006h,000h,08ah,040h,060h,0e0h	; a70f  ......)/.....@`.
	defb 0e0h,0f0h,0c0h,094h,0f4h,074h,0f8h,005h,000h,08bh,003h,005h,009h,018h,038h,070h	; a71f  .....t........8p
	defb 07ch,056h,050h,051h,020h,005h,000h,0cbh,0c0h,0a0h,090h,018h,01ch,00eh,03eh,06ah	; a72f  |VPQ .........>j
	defb 01ah,09ah,024h,023h,037h,070h,0fch,0fbh,0cch,08eh,087h,087h,040h,021h,011h,018h	; a73f  ..$#7p......@!..
	defb 01eh,03fh,03fh,0c4h,0ech,00eh,037h,0dfh,03fh,07fh,0ffh,0fbh,071h,0b1h,0e1h,0e2h	; a74f  .??...7.?...q...
	defb 026h,0c3h,0b9h,01ch,008h,00fh,003h,00ch,037h,073h,079h,078h,03fh,01eh,00eh,017h	; a75f  &.......7syx?...
	defb 011h,000h,003h,038h,010h,0f0h,0c8h,030h,0e0h,0c0h,080h,004h,08eh,04eh,01eh,01ch	; a76f  ...8...0.....N..
	defb 0d8h,03ch,046h,000h	; a77f

; ----------------------------------------------------------------------
; DATOS rle_A783: rle a la VRAM 0xF9C0 (p00:53F6) para el jugador 1; el del 2
;   es 0xA7DD (p00:53EB-53F0); lo leen p00:53F6 (90 bytes)
;   0xa783..0xa7dd  (90 bytes)
DATA_rle_A783:
	defb 031h,000h,002h,010h,003h,000h,002h,002h,086h,000h,001h,001h,002h,00ch,030h,004h	; a783  1.............0.
	defb 000h,083h,003h,007h,003h,00eh,000h,081h,0c0h,00dh,000h,085h,003h,004h,008h,004h	; a793  ................
	defb 003h,00ch,000h,084h,0c0h,000h,0b8h,038h,003h,000h,002h,004h,08ah,000h,002h,002h	; a7a3  .......8........
	defb 004h,038h,000h,007h,00fh,00fh,007h,00dh,000h,084h,080h,0c0h,000h,038h,00ah,000h	; a7b3  .8...........8..
	defb 086h,007h,008h,010h,010h,008h,007h,00bh,000h,085h,080h,040h,000h,07ch,07ch,003h	; a7c3  ...........@.||.
	defb 000h,002h,004h,085h,000h,002h,002h,004h,038h,000h	; a7d3  ........8.

; ----------------------------------------------------------------------
; DATOS rle_A7DD: rle a la VRAM (0x4539); lo leen p00:53F6 (83 bytes)
;   0xa7dd..0xa830  (83 bytes)
DATA_rle_A7DD:
	defb 025h,000h,002h,002h,086h,000h,001h,001h,002h,00ch,030h,013h,000h,085h,003h,007h	; a7dd  %.........0.....
	defb 00bh,005h,003h,00ch,000h,002h,0c0h,081h,080h,004h,000h,002h,004h,08ah,000h,002h	; a7ed  ................
	defb 002h,004h,038h,000h,000h,003h,007h,003h,00eh,000h,081h,0c0h,00dh,000h,086h,007h	; a7fd  ..8.............
	defb 00fh,01fh,017h,009h,007h,00bh,000h,084h,080h,0c0h,0c0h,080h,004h,000h,002h,004h	; a80d  ................
	defb 08ah,000h,002h,002h,004h,038h,000h,007h,00fh,00fh,007h,00dh,000h,082h,080h,0c0h	; a81d  .....8..........
	defb 00ch,000h,000h	; a82d

; ----------------------------------------------------------------------
; DATOS fichas_de_figura: 36 fichas de 10 bytes, una por tipo de figura 1-0x24
;   (p00:5465): el dibujo en rle, su sitio en la VRAM, los colores 4 y 6 de la
;   paleta (0xFFFF, sin tocar) y el sitio de la copia dada la vuelta (0xFF,
;   sin copia); lo leen p00:5465 (360 bytes)
;   0xa830..0xa998  (360 bytes)
DATA_fichas_de_figura:
	defb 052h,088h,080h,0f9h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,02ch,089h,000h,0fbh,0ffh,0ffh	; a830  R.........,.....
	defb 0ffh,0ffh,080h,0fbh,0f0h,089h,000h,0fbh,0ffh,0ffh,0ffh,0ffh,000h,0fdh,0a6h,08ch	; a840  ................
	defb 080h,0f9h,0ffh,0ffh,0ffh,0ffh,000h,0fah,00eh,08dh,000h,0fbh,0ffh,0ffh,0ffh,0ffh	; a850  ................
	defb 000h,0fch,009h,08eh,080h,0f9h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0d4h,08eh,080h,0f9h	; a860  ................
	defb 074h,005h,050h,003h,000h,0fah,052h,08fh,080h,0f9h,0ffh,0ffh,0ffh,0ffh,040h,0fah	; a870  t.P...R.......@.
	defb 012h,090h,000h,0fbh,0ffh,0ffh,0ffh,0ffh,000h,0fch,004h,091h,080h,0fdh,0ffh,0ffh	; a880  ................
	defb 0ffh,0ffh,080h,0feh,02ah,092h,000h,0fdh,074h,005h,077h,007h,000h,0feh,02ah,092h	; a890  ....*...t.w...*.
	defb 000h,0fdh,074h,005h,050h,000h,000h,0feh,060h,093h,080h,0feh,0ffh,0ffh,0ffh,0ffh	; a8a0  ..t.P...`.......
	defb 0ffh,0ffh,060h,093h,080h,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,084h,094h,000h,0fdh	; a8b0  ..`.............
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01fh,095h,080h,0feh,074h,005h,050h,003h,040h,0ffh	; a8c0  ..........t.P.@.
	defb 0d9h,095h,080h,0f9h,0ffh,0ffh,0ffh,0ffh,040h,0fah,0d9h,095h,080h,0f9h,077h,007h	; a8d0  ........@.....w.
	defb 047h,003h,000h,0fbh,08fh,096h,000h,0fbh,074h,005h,050h,003h,000h,0fch,083h,097h	; a8e0  G.......t.P.....
	defb 000h,0fdh,046h,005h,074h,005h,040h,0feh,098h,098h,080h,0f9h,074h,005h,050h,003h	; a8f0  ..F.t.@.....t.P.
	defb 0c0h,0fah,0bah,099h,000h,0fdh,074h,005h,050h,003h,080h,0feh,0f1h,09ah,000h,0fdh	; a900  ......t.P.......
	defb 074h,005h,077h,007h,000h,0feh,0e0h,09bh,000h,0fdh,074h,005h,050h,003h,0c0h,0fdh	; a910  t.w.......t.P...
	defb 081h,09ch,000h,0fdh,0ffh,0ffh,0ffh,0ffh,080h,0feh,0a4h,09dh,000h,0fdh,0ffh,0ffh	; a920  ................
	defb 0ffh,0ffh,080h,0feh,0d4h,08eh,080h,0f9h,074h,005h,050h,003h,000h,0fah,0f1h,09eh	; a930  ........t.P.....
	defb 080h,0f9h,0ffh,0ffh,0ffh,0ffh,000h,0fah,0f1h,09eh,080h,0fch,077h,007h,047h,003h	; a940  ............w.G.
	defb 0ffh,0ffh,067h,09fh,000h,0fdh,074h,005h,050h,003h,080h,0feh,0beh,0a0h,080h,0f9h	; a950  ..g...t.P.......
	defb 056h,000h,076h,006h,000h,0fbh,0a0h,0a2h,080h,0f9h,074h,005h,036h,002h,000h,0fbh	; a960  V.v.......t.6...
	defb 0f7h,0a3h,080h,0fdh,0ffh,0ffh,0ffh,0ffh,040h,0feh,0b5h,0a4h,0c0h,0f9h,074h,005h	; a970  ........@.....t.
	defb 063h,004h,0ffh,0ffh,09ch,0a5h,0c0h,0f9h,074h,005h,063h,004h,0ffh,0ffh,08fh,0a6h	; a980  c.......t.c.....
	defb 0c0h,0f9h,074h,005h,077h,007h,0ffh,0ffh	; a990  ..t.w...

; ----------------------------------------------------------------------
; DATOS dibujos_de_mas: 8 fichas de 5 bytes: [tipo][rle][VRAM], un dibujo de
;   mas para los tipos 2, 3, 0x0A, 0x0B, 0x0C, 0x0F, 0x15 y 0x1F (p00:5436);
;   lo leen p00:5436 (40 bytes)
;   0xa998..0xa9c0  (40 bytes)
DATA_dibujos_de_mas:
	defb 002h,09ch,089h,000h,0fch,003h,0adh,08bh,000h,0ffh,00ah,0bfh,091h,080h,0ffh,00bh	; a998  ................
	defb 00fh,093h,000h,0ffh,00ch,00fh,093h,000h,0ffh,00fh,004h,095h,080h,0fdh,015h,089h	; a9a8  ................
	defb 099h,000h,0fch,01fh,000h,0a2h,080h,0fch	; a9b8  ........

; ----------------------------------------------------------------------
; DATOS rotulos: 120 punteros a los rotulos que p00:4280 escribe con 0x48F3
;   (el numero lo pasa quien llama, hasta 0x70); los seis ultimos apuntan a
;   0xB6D2, donde acaban los rotulos: no hay rotulo 114-119; lo leen p00:4288
;   (240 bytes)
;   0xa9c0..0xaab0  (240 bytes)
DATA_rotulos:
	defb 0b0h,0aah,0bah,0aah,0c3h,0aah,0d3h,0aah,0e3h,0aah,004h,0abh,018h,0abh,028h,0abh	; a9c0  ..............(.
	defb 05bh,0abh,07ah,0abh,095h,0abh,09bh,0abh,0a0h,0abh,0f3h,0abh,03dh,0ach,05bh,0ach	; a9d0  [.z.........=.[.
	defb 068h,0ach,068h,0ach,080h,0ach,09dh,0ach,0c0h,0ach,0edh,0ach,009h,0adh,01ah,0adh	; a9e0  h.h.............
	defb 02fh,0adh,052h,0adh,06ch,0adh,083h,0adh,0ach,0adh,0b4h,0adh,0bch,0adh,0c4h,0adh	; a9f0  /.R.l...........
	defb 0cch,0adh,0dch,0adh,0f8h,0adh,012h,0aeh,028h,0aeh,04ah,0aeh,062h,0aeh,07bh,0aeh	; aa00  ........(.J.b.{.
	defb 094h,0aeh,0b1h,0aeh,0c6h,0aeh,0e0h,0aeh,0ffh,0aeh,01ch,0afh,02bh,0afh,039h,0afh	; aa10  ............+.9.
	defb 046h,0afh,056h,0afh,070h,0afh,098h,0afh,0b6h,0afh,0e6h,0afh,010h,0b0h,040h,0b0h	; aa20  F.V.p.........@.
	defb 058h,0b0h,077h,0b0h,091h,0b0h,0adh,0b0h,0cbh,0b0h,0e2h,0b0h,002h,0b1h,021h,0b1h	; aa30  X.w...........!.
	defb 03eh,0b1h,05fh,0b1h,07bh,0b1h,099h,0b1h,0b5h,0b1h,0d0h,0b1h,0efh,0b1h,00dh,0b2h	; aa40  >._.{...........
	defb 029h,0b2h,049h,0b2h,066h,0b2h,084h,0b2h,0a4h,0b2h,0c4h,0b2h,0e4h,0b2h,001h,0b3h	; aa50  ).I.f...........
	defb 01eh,0b3h,03eh,0b3h,05dh,0b3h,07ch,0b3h,099h,0b3h,0b5h,0b3h,0d1h,0b3h,0f1h,0b3h	; aa60  ..>.].|.........
	defb 013h,0b4h,02fh,0b4h,04bh,0b4h,068h,0b4h,085h,0b4h,0a1h,0b4h,0beh,0b4h,0dbh,0b4h	; aa70  ../.K.h.........
	defb 0f9h,0b4h,015h,0b5h,02dh,0b5h,04fh,0b5h,06eh,0b5h,08ah,0b5h,0a6h,0b5h,0c4h,0b5h	; aa80  ....-.O.n.......
	defb 0deh,0b5h,0e9h,0b5h,006h,0b6h,020h,0b6h,03ah,0b6h,04ch,0b6h,067h,0b6h,078h,0b6h	; aa90  ...... .:.L.g.x.
	defb 088h,0b6h,0a5h,0b6h,0d2h,0b6h,0d2h,0b6h,0d2h,0b6h,0d2h,0b6h,0d2h,0b6h,0d2h,0b6h	; aaa0  ................

; ----------------------------------------------------------------------
; DATOS rotulo_0: rotulo 0: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (10 bytes)
;   0xaab0..0xaaba  (10 bytes)
DATA_rotulo_0:
	defb 068h,050h,049h,031h,000h,000h,031h,031h,033h,0ffh	; aab0  hPI1..113.

; ----------------------------------------------------------------------
; DATOS rotulo_1: rotulo 1: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (9 bytes)
;   0xaaba..0xaac3  (9 bytes)
DATA_rotulo_1:
	defb 068h,050h,040h,061h,032h,000h,049h,05dh,0ffh	; aaba  hP@a2.I].

; ----------------------------------------------------------------------
; DATOS rotulo_2: rotulo 2: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (16 bytes)
;   0xaac3..0xaad3  (16 bytes)
DATA_rotulo_2:
	defb 068h,038h,034h,036h,05fh,037h,03ah,05dh,000h,034h,043h,04eh,057h,035h,047h,0ffh	; aac3  h846_7:].4CNW5G.

; ----------------------------------------------------------------------
; DATOS rotulo_3: rotulo 3: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (16 bytes)
;   0xaad3..0xaae3  (16 bytes)
DATA_rotulo_3:
	defb 068h,038h,043h,063h,032h,040h,060h,032h,000h,034h,036h,05ch,041h,038h,042h,0ffh	; aad3  h8Cc2@`2.46\A8B.

; ----------------------------------------------------------------------
; DATOS rotulo_4: rotulo 4: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (33 bytes)
;   0xaae3..0xab04  (33 bytes)
DATA_rotulo_4:
	defb 068h,038h,039h,059h,05eh,04dh,062h,05eh,040h,048h,000h,034h,035h,047h,03bh,063h	; aae3  h89Y^Mb^@H.45G;c
	defb 05fh,0feh,068h,040h,043h,051h,058h,05bh,038h,045h,000h,031h,035h,044h,031h,047h	; aaf3  _.h@CQX[8E.15D1G
	defb 0ffh	; ab03

; ----------------------------------------------------------------------
; DATOS rotulo_5: rotulo 5: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (20 bytes)
;   0xab04..0xab18  (20 bytes)
DATA_rotulo_5:
	defb 068h,038h,045h,031h,03ah,05dh,000h,049h,063h,037h,040h,049h,0feh,068h,040h,053h	; ab04  h8E1:].Ic7@I.h@S
	defb 058h,035h,031h,0ffh	; ab14

; ----------------------------------------------------------------------
; DATOS rotulo_6: rotulo 6: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (16 bytes)
;   0xab18..0xab28  (16 bytes)
DATA_rotulo_6:
	defb 068h,038h,03ah,030h,000h,05bh,035h,031h,048h,000h,049h,05eh,042h,037h,059h,0ffh	; ab18  h8:0.[51H.I^B7Y.

; ----------------------------------------------------------------------
; DATOS rotulo_7: rotulo 7: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (51 bytes)
;   0xab28..0xab5b  (51 bytes)
DATA_rotulo_7:
	defb 068h,038h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; ab28  h8..............
	defb 0feh,068h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; ab38  .h@.............
	defb 000h,0feh,068h,048h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; ab48  ..hH............
	defb 000h,000h,0ffh	; ab58

; ----------------------------------------------------------------------
; DATOS rotulo_8: rotulo 8: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (31 bytes)
;   0xab5b..0xab7a  (31 bytes)
DATA_rotulo_8:
	defb 068h,038h,042h,063h,04eh,03bh,03fh,0feh,068h,040h,000h,000h,048h,000h,042h,063h	; ab5b  h8BcN;?.h@..H.Bc
	defb 0feh,068h,048h,052h,05eh,042h,038h,000h,043h,063h,05ah,04dh,063h,032h,0ffh	; ab6b  .hHR^B8.CcZMc2.

; ----------------------------------------------------------------------
; DATOS rotulo_9: rotulo 9: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (27 bytes)
;   0xab7a..0xab95  (27 bytes)
DATA_rotulo_9:
	defb 068h,038h,042h,063h,04eh,03bh,03fh,0feh,068h,040h,000h,000h,048h,000h,042h,063h	; ab7a  h8BcN;?.h@..H.Bc
	defb 0feh,068h,048h,04eh,03fh,000h,036h,044h,049h,059h,0ffh	; ab8a  .hHN?.6DIY.

; ----------------------------------------------------------------------
; DATOS rotulo_10: rotulo 10: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (6 bytes)
;   0xab95..0xab9b  (6 bytes)
DATA_rotulo_10:
	defb 098h,040h,040h,061h,032h,0ffh	; ab95

; ----------------------------------------------------------------------
; DATOS rotulo_11: rotulo 11: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (5 bytes)
;   0xab9b..0xaba0  (5 bytes)
DATA_rotulo_11:
	defb 098h,040h,049h,05dh,0ffh	; ab9b

; ----------------------------------------------------------------------
; DATOS rotulo_12: rotulo 12: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (83 bytes)
;   0xaba0..0xabf3  (83 bytes)
DATA_rotulo_12:
	defb 030h,060h,0b6h,0feh,030h,068h,0b2h,0feh,030h,098h,0b6h,0feh,030h,0a0h,0b6h,0feh	; aba0  0`..0h..0...0...
	defb 030h,0a8h,0b6h,0feh,030h,0b0h,0b9h,0b5h,0b5h,0b5h,0b5h,0b5h,0b4h,0feh,0c8h,098h	; abb0  0...0...........
	defb 0b1h,0feh,0c8h,0a0h,0b6h,0feh,0c8h,0a8h,0b6h,0feh,098h,0b0h,0b5h,0b5h,0b5h,0b5h	; abc0  ................
	defb 0b5h,0b5h,0bah,0feh,0c8h,060h,0b1h,0feh,0c8h,068h,0b6h,0feh,0b8h,018h,0b3h,0b5h	; abd0  .....`...h......
	defb 0b8h,0feh,0c8h,020h,0b6h,0feh,0c8h,028h,0b6h,0feh,0c8h,030h,0b6h,0feh,078h,018h	; abe0  ... ...(...0..x.
	defb 0b3h,0b5h,0ffh	; abf0

; ----------------------------------------------------------------------
; DATOS rotulo_13: rotulo 13: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (74 bytes)
;   0xabf3..0xac3d  (74 bytes)
DATA_rotulo_13:
	defb 028h,028h,0a9h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h	; abf3  ((..............
	defb 0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0ach,0feh,028h,030h,0aah,0feh,0d0h,030h,0adh	; ac03  .........(0...0.
	defb 0feh,028h,038h,0aah,0feh,0d0h,038h,0adh,0feh,028h,040h,0aah,0feh,0d0h,040h,0adh	; ac13  .(8...8..(@...@.
	defb 0feh,028h,048h,0abh,0a8h,0a8h,0a8h,0a8h,0a8h,0a8h,0a8h,0a8h,0a8h,0a8h,0a8h,0a8h	; ac23  .(H.............
	defb 0a8h,0a8h,0a8h,0a8h,0a8h,0a8h,0a8h,0a8h,0aeh,0ffh	; ac33  ..........

; ----------------------------------------------------------------------
; DATOS rotulo_14: rotulo 14: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (30 bytes)
;   0xac3d..0xac5b  (30 bytes)
DATA_rotulo_14:
	defb 054h,060h,08fh,090h,093h,094h,097h,098h,09bh,09ch,09fh,0a0h,0a3h,0a4h,0feh,054h	; ac3d  T`.............T
	defb 068h,091h,092h,095h,096h,099h,09ah,09dh,09eh,0a1h,0a2h,0a5h,0a6h,0ffh	; ac4d  h.............

; ----------------------------------------------------------------------
; DATOS rotulo_15: rotulo 15: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (13 bytes)
;   0xac5b..0xac68  (13 bytes)
DATA_rotulo_15:
	defb 068h,038h,044h,045h,035h,000h,034h,03bh,033h,055h,032h,035h,0ffh	; ac5b  h8DE5.4;3U25.

; ----------------------------------------------------------------------
; DATOS rotulo_16: rotulo 16: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (24 bytes)
;   0xac68..0xac80  (24 bytes)
DATA_rotulo_16:
	defb 068h,038h,039h,059h,042h,063h,034h,03bh,04eh,031h,03fh,063h,0feh,088h,040h,06ah	; ac68  h89YBc4;N1?c..@j
	defb 031h,03fh,03fh,063h,037h,03dh,063h,0ffh	; ac78  1??c7=c.

; ----------------------------------------------------------------------
; DATOS rotulo_18: rotulo 18: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xac80..0xac9d  (29 bytes)
DATA_rotulo_18:
	defb 068h,038h,05bh,035h,031h,048h,000h,043h,063h,032h,03bh,03fh,0feh,068h,040h,04eh	; ac80  h8[51H.Cc2;?.h@N
	defb 03fh,000h,044h,045h,035h,000h,036h,036h,03fh,031h,048h,035h,0ffh	; ac90  ?.DE5.66?1H5.

; ----------------------------------------------------------------------
; DATOS rotulo_19: rotulo 19: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (35 bytes)
;   0xac9d..0xacc0  (35 bytes)
DATA_rotulo_19:
	defb 068h,038h,05bh,035h,031h,048h,000h,03bh,041h,039h,031h,03dh,063h,0feh,068h,040h	; ac9d  h8[51H.;A91=c.h@
	defb 030h,057h,035h,063h,047h,000h,034h,031h,042h,0feh,068h,048h,042h,063h,042h,031h	; acad  0W5cG.41B.hHBcB1
	defb 036h,044h,0ffh	; acbd

; ----------------------------------------------------------------------
; DATOS rotulo_20: rotulo 20: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (45 bytes)
;   0xacc0..0xaced  (45 bytes)
DATA_rotulo_20:
	defb 068h,038h,05bh,035h,031h,048h,000h,044h,05dh,043h,063h,052h,0feh,068h,040h,034h	; acc0  h8[51H.D]CcR.h@4
	defb 03eh,059h,031h,05eh,03fh,064h,000h,000h,000h,000h,000h,048h,0feh,068h,048h,042h	; acd0  >Y1^?d.....H.hHB
	defb 035h,063h,04fh,05ch,052h,03fh,03dh,042h,053h,05ah,032h,064h,0ffh	; ace0  5cO\R?=BSZ2d.

; ----------------------------------------------------------------------
; DATOS rotulo_21: rotulo 21: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xaced..0xad09  (28 bytes)
DATA_rotulo_21:
	defb 068h,038h,035h,047h,035h,063h,03fh,057h,047h,033h,03dh,063h,0feh,068h,040h,03bh	; aced  h85G5c?WG3=c.h@;
	defb 05dh,042h,063h,052h,056h,032h,03bh,035h,047h,033h,044h,0ffh	; acfd  ]BcRV2;5G3D.

; ----------------------------------------------------------------------
; DATOS rotulo_22: rotulo 22: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (17 bytes)
;   0xad09..0xad1a  (17 bytes)
DATA_rotulo_22:
	defb 068h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; ad09  hP..............
	defb 0ffh	; ad19

; ----------------------------------------------------------------------
; DATOS rotulo_23: rotulo 23: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (21 bytes)
;   0xad1a..0xad2f  (21 bytes)
DATA_rotulo_23:
	defb 068h,038h,034h,036h,05fh,037h,03ah,05dh,000h,04fh,03dh,049h,0feh,068h,040h,034h	; ad1a  h846_7:].O=I.h@4
	defb 05bh,05eh,03fh,055h,0ffh	; ad2a

; ----------------------------------------------------------------------
; DATOS rotulo_24: rotulo 24: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (35 bytes)
;   0xad2f..0xad52  (35 bytes)
DATA_rotulo_24:
	defb 068h,038h,000h,000h,000h,000h,000h,048h,042h,035h,063h,04fh,05ch,0feh,068h,040h	; ad2f  h8.....HB5cO\.h@
	defb 052h,05eh,042h,000h,044h,031h,053h,041h,049h,0feh,068h,048h,035h,033h,05eh,043h	; ad3f  R^B.D1SAI.hH53^C
	defb 037h,059h,0ffh	; ad4f

; ----------------------------------------------------------------------
; DATOS rotulo_25: rotulo 25: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (26 bytes)
;   0xad52..0xad6c  (26 bytes)
DATA_rotulo_25:
	defb 068h,038h,032h,040h,049h,000h,03bh,040h,053h,000h,03fh,063h,03ch,0feh,068h,040h	; ad52  h82@I.;@S.?c<.h@
	defb 044h,045h,035h,000h,032h,057h,04eh,03ch,035h,0ffh	; ad62  DE5.2WN<5.

; ----------------------------------------------------------------------
; DATOS rotulo_26: rotulo 26: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (23 bytes)
;   0xad6c..0xad83  (23 bytes)
DATA_rotulo_26:
	defb 068h,038h,055h,032h,035h,063h,000h,044h,031h,044h,056h,0feh,068h,040h,042h,063h	; ad6c  h8U25c.D1DV.h@Bc
	defb 042h,031h,05eh,043h,037h,059h,0ffh	; ad7c

; ----------------------------------------------------------------------
; DATOS rotulo_27: rotulo 27: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (41 bytes)
;   0xad83..0xadac  (41 bytes)
DATA_rotulo_27:
	defb 068h,038h,045h,031h,03ah,05dh,000h,04eh,031h,043h,063h,0feh,068h,040h,039h,05dh	; ad83  h8E1:].N1Cc.h@9]
	defb 035h,031h,000h,043h,037h,04ch,063h,041h,045h,0feh,068h,048h,04eh,036h,052h,048h	; ad93  51.C7LcAE.hHN6RH
	defb 000h,05ch,000h,030h,038h,063h,055h,032h,0ffh	; ada3  .\.08cU2.

; ----------------------------------------------------------------------
; DATOS rotulo_28: rotulo 28: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (8 bytes)
;   0xadac..0xadb4  (8 bytes)
DATA_rotulo_28:
	defb 068h,038h,034h,053h,04bh,063h,05dh,0ffh	; adac  h84SKc].

; ----------------------------------------------------------------------
; DATOS rotulo_29: rotulo 29: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (8 bytes)
;   0xadb4..0xadbc  (8 bytes)
DATA_rotulo_29:
	defb 068h,038h,039h,063h,035h,05ah,032h,0ffh	; adb4  h89c5Z2.

; ----------------------------------------------------------------------
; DATOS rotulo_30: rotulo 30: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (8 bytes)
;   0xadbc..0xadc4  (8 bytes)
DATA_rotulo_30:
	defb 0a0h,040h,034h,053h,04bh,063h,05dh,0ffh	; adbc  .@4SKc].

; ----------------------------------------------------------------------
; DATOS rotulo_31: rotulo 31: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (8 bytes)
;   0xadc4..0xadcc  (8 bytes)
DATA_rotulo_31:
	defb 0a0h,040h,039h,063h,035h,05ah,032h,0ffh	; adc4  .@9c5Z2.

; ----------------------------------------------------------------------
; DATOS rotulo_32: rotulo 32: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (16 bytes)
;   0xadcc..0xaddc  (16 bytes)
DATA_rotulo_32:
	defb 068h,038h,044h,05dh,03bh,063h,000h,03bh,063h,03bh,05dh,05ch,03bh,059h,064h,0ffh	; adcc  h8D];c.;c;]\;Yd.

; ----------------------------------------------------------------------
; DATOS rotulo_33: rotulo 33: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xaddc..0xadf8  (28 bytes)
DATA_rotulo_33:
	defb 068h,038h,042h,041h,035h,063h,037h,049h,000h,03ah,031h,03bh,063h,061h,032h,048h	; addc  h8BA5c7I.:1;ca2H
	defb 0feh,068h,040h,034h,05dh,035h,063h,037h,044h,057h,064h,0ffh	; adec  .h@4]5c7DWd.

; ----------------------------------------------------------------------
; DATOS rotulo_34: rotulo 34: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (26 bytes)
;   0xadf8..0xae12  (26 bytes)
DATA_rotulo_34:
	defb 068h,038h,036h,04dh,063h,032h,043h,049h,000h,051h,03ah,063h,051h,042h,031h,058h	; adf8  h86Mc2CI.Q:cQB1X
	defb 0feh,068h,040h,054h,051h,000h,044h,057h,064h,0ffh	; ae08  .h@TQ.DWd.

; ----------------------------------------------------------------------
; DATOS rotulo_35: rotulo 35: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (22 bytes)
;   0xae12..0xae28  (22 bytes)
DATA_rotulo_35:
	defb 068h,038h,05bh,03fh,03bh,049h,000h,03bh,061h,032h,057h,05ch,0feh,068h,040h,046h	; ae12  h8[?;I.;a2W\.h@F
	defb 03ch,04eh,044h,031h,064h,0ffh	; ae22

; ----------------------------------------------------------------------
; DATOS rotulo_36: rotulo 36: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (34 bytes)
;   0xae28..0xae4a  (34 bytes)
DATA_rotulo_36:
	defb 068h,038h,03bh,05dh,048h,000h,055h,05eh,036h,060h,032h,000h,044h,037h,03bh,042h	; ae28  h8;]H.U^6`2.D7;B
	defb 0feh,068h,040h,03bh,05dh,048h,000h,04eh,05dh,03eh,063h,037h,049h,000h,044h,031h	; ae38  .h@;]H.N]>c7I.D1
	defb 064h,0ffh	; ae48

; ----------------------------------------------------------------------
; DATOS rotulo_37: rotulo 37: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (24 bytes)
;   0xae4a..0xae62  (24 bytes)
DATA_rotulo_37:
	defb 068h,038h,031h,035h,057h,049h,000h,031h,05eh,043h,036h,048h,0feh,068h,040h,036h	; ae4a  h815WI.1^C6H.h@6
	defb 061h,032h,036h,000h,044h,057h,064h,0ffh	; ae5a  a26.DWd.

; ----------------------------------------------------------------------
; DATOS rotulo_38: rotulo 38: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (25 bytes)
;   0xae62..0xae7b  (25 bytes)
DATA_rotulo_38:
	defb 068h,038h,044h,05dh,03bh,063h,000h,048h,000h,036h,061h,032h,049h,0feh,068h,040h	; ae62  h8D];c.H.6a2I.h@
	defb 033h,031h,033h,05dh,000h,044h,057h,064h,0ffh	; ae72  313].DWd.

; ----------------------------------------------------------------------
; DATOS rotulo_39: rotulo 39: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (25 bytes)
;   0xae7b..0xae94  (25 bytes)
DATA_rotulo_39:
	defb 068h,038h,044h,037h,039h,043h,052h,000h,031h,05eh,03bh,060h,048h,0feh,068h,040h	; ae7b  h8D79CR.1^;`H.h@
	defb 035h,031h,056h,037h,000h,044h,057h,064h,0ffh	; ae8b  51V7.DWd.

; ----------------------------------------------------------------------
; DATOS rotulo_40: rotulo 40: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xae94..0xaeb1  (29 bytes)
DATA_rotulo_40:
	defb 068h,038h,045h,05dh,038h,063h,05dh,049h,0feh,068h,040h,035h,05dh,035h,063h,033h	; ae94  h8E]8c]I.h@5]5c3
	defb 058h,000h,030h,03bh,0feh,068h,048h,042h,063h,030h,058h,064h,0ffh	; aea4  X.0;.hHBc0Xd.

; ----------------------------------------------------------------------
; DATOS rotulo_41: rotulo 41: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (21 bytes)
;   0xaeb1..0xaec6  (21 bytes)
DATA_rotulo_41:
	defb 068h,038h,042h,05dh,03ah,031h,043h,049h,0feh,068h,040h,045h,05dh,03fh,031h,042h	; aeb1  h8B]:1CI.h@E]?1B
	defb 063h,030h,058h,064h,0ffh	; aec1

; ----------------------------------------------------------------------
; DATOS rotulo_42: rotulo 42: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (26 bytes)
;   0xaec6..0xaee0  (26 bytes)
DATA_rotulo_42:
	defb 068h,038h,039h,039h,05ah,049h,000h,031h,05eh,03bh,060h,048h,0feh,068h,040h,038h	; aec6  h899ZI.1^;`H.h@8
	defb 063h,036h,03bh,063h,061h,032h,03fh,063h,064h,0ffh	; aed6  c6;ca2?cd.

; ----------------------------------------------------------------------
; DATOS rotulo_43: rotulo 43: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (31 bytes)
;   0xaee0..0xaeff  (31 bytes)
DATA_rotulo_43:
	defb 068h,038h,042h,041h,035h,063h,037h,048h,0feh,068h,040h,03fh,063h,031h,031h,05eh	; aee0  h8BA5c7H.h@?c11^
	defb 04dh,062h,049h,0feh,068h,048h,04bh,03bh,05dh,000h,045h,030h,058h,064h,0ffh	; aef0  MbI.hHK;].E0Xd.

; ----------------------------------------------------------------------
; DATOS rotulo_44: rotulo 44: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xaeff..0xaf1c  (29 bytes)
DATA_rotulo_44:
	defb 068h,038h,05bh,03fh,03bh,048h,000h,033h,05dh,05ch,0feh,068h,040h,04fh,03fh,063h	; aeff  h8[?;H.3]\.h@O?c
	defb 03ah,044h,031h,042h,063h,000h,037h,03fh,063h,03ah,031h,064h,0ffh	; af0f  :D1Bc.7?c:1d.

; ----------------------------------------------------------------------
; DATOS rotulo_45: rotulo 45: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (15 bytes)
;   0xaf1c..0xaf2b  (15 bytes)
DATA_rotulo_45:
	defb 068h,038h,03bh,045h,05dh,000h,045h,000h,037h,063h,040h,044h,03bh,064h,0ffh	; af1c  h8;E].E.7c@D;d.

; ----------------------------------------------------------------------
; DATOS rotulo_46: rotulo 46: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (14 bytes)
;   0xaf2b..0xaf39  (14 bytes)
DATA_rotulo_46:
	defb 068h,038h,03bh,056h,046h,035h,063h,000h,043h,04dh,063h,038h,064h,0ffh	; af2b  h8;VF5c.CMc8d.

; ----------------------------------------------------------------------
; DATOS rotulo_47: rotulo 47: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (13 bytes)
;   0xaf39..0xaf46  (13 bytes)
DATA_rotulo_47:
	defb 068h,038h,042h,052h,040h,000h,04bh,063h,03fh,03ah,05dh,064h,0ffh	; af39  h8BR@.Kc?:]d.

; ----------------------------------------------------------------------
; DATOS rotulo_48: rotulo 48: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (16 bytes)
;   0xaf46..0xaf56  (16 bytes)
DATA_rotulo_48:
	defb 068h,038h,039h,051h,03fh,063h,05bh,056h,000h,039h,032h,03fh,05ah,032h,064h,0ffh	; af46  h89Q?c[V.92?Z2d.

; ----------------------------------------------------------------------
; DATOS rotulo_49: rotulo 49: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (26 bytes)
;   0xaf56..0xaf70  (26 bytes)
DATA_rotulo_49:
	defb 068h,038h,030h,057h,03eh,042h,063h,000h,032h,05eh,04bh,05dh,0feh,068h,040h,044h	; af56  h80W>Bc.2^K].h@D
	defb 035h,03eh,047h,000h,030h,05eh,049h,05dh,064h,0ffh	; af66  5>G.0^I]d.

; ----------------------------------------------------------------------
; DATOS rotulo_50: rotulo 50: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (40 bytes)
;   0xaf70..0xaf98  (40 bytes)
DATA_rotulo_50:
	defb 068h,038h,04dh,063h,037h,056h,049h,04fh,05dh,044h,0feh,068h,040h,034h,036h,042h	; af70  h8Mc7VIO]D.h@46B
	defb 031h,058h,064h,0feh,068h,048h,034h,036h,042h,031h,058h,035h,056h,0feh,068h,050h	; af80  1Xd.hH46B1X5V.hP
	defb 047h,050h,031h,05dh,03fh,063h,064h,0ffh	; af90  GP1]?cd.

; ----------------------------------------------------------------------
; DATOS rotulo_51: rotulo 51: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (30 bytes)
;   0xaf98..0xafb6  (30 bytes)
DATA_rotulo_51:
	defb 068h,038h,03fh,048h,03bh,036h,043h,000h,034h,052h,032h,035h,063h,0feh,068h,040h	; af98  h8?H;6C.4R25c.h@
	defb 03fh,048h,03bh,036h,000h,03bh,05dh,03ch,063h,031h,044h,057h,064h,0ffh	; afa8  ?H;6.;]<c1DWd.

; ----------------------------------------------------------------------
; DATOS rotulo_52: rotulo 52: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (40 bytes)
;   0xafb6..0xafde  (40 bytes)
DATA_rotulo_52:
	defb 068h,038h,038h,063h,066h,050h,043h,049h,000h,031h,036h,03fh,0feh,068h,040h,03eh	; afb6  h88cfPCI.16?.h@>
	defb 032h,039h,063h,032h,042h,063h,030h,057h,0feh,068h,048h,031h,03fh,063h,031h,044h	; afc6  29c2Bc0W.hH1?c1D
	defb 000h,03fh,05dh,03bh,063h,060h,05dh,0ffh	; afd6  .?];c`].

; ----------------------------------------------------------------------
; DATOS rotulo_AFDE: un rotulo con el formato de 0x48F3 en (0x68, 0x50) entre
;   los rotulos 67 y 68, al que no apunta ninguna de las 120 entradas de
;   0xA9C0: nadie lo escribe (8 bytes)
;   0xafde..0xafe6  (8 bytes)
DATA_rotulo_AFDE:
	defb 068h,050h,042h,063h,030h,058h,064h,0ffh	; afde  hPBc0Xd.

; ----------------------------------------------------------------------
; DATOS rotulo_53: rotulo 53: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (42 bytes)
;   0xafe6..0xb010  (42 bytes)
DATA_rotulo_53:
	defb 068h,038h,05bh,036h,030h,035h,063h,058h,000h,035h,05dh,043h,063h,032h,043h,049h	; afe6  h8[605cX.5]Cc2CI
	defb 0feh,068h,040h,039h,039h,05ah,043h,000h,035h,05dh,035h,037h,048h,000h,031h,05eh	; aff6  .h@99ZC.5]57H.1^
	defb 040h,0feh,068h,048h,042h,063h,030h,058h,064h,0ffh	; b006  @.hHBc0Xd.

; ----------------------------------------------------------------------
; DATOS rotulo_54: rotulo 54: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (48 bytes)
;   0xb010..0xb040  (48 bytes)
DATA_rotulo_54:
	defb 068h,038h,03dh,031h,03bh,05dh,042h,036h,000h,045h,049h,0feh,068h,040h,030h,04eh	; b010  h8=1;]B6.EI.h@0N
	defb 040h,060h,030h,000h,042h,063h,0feh,068h,048h,036h,063h,03bh,063h,060h,041h,042h	; b020  @`0.Bc.hH6c;c`AB
	defb 036h,000h,045h,049h,0feh,068h,050h,04bh,062h,05ah,042h,063h,030h,059h,064h,0ffh	; b030  6.EI.hPKbZBc0Yd.

; ----------------------------------------------------------------------
; DATOS rotulo_55: rotulo 55: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (24 bytes)
;   0xb040..0xb058  (24 bytes)
DATA_rotulo_55:
	defb 068h,038h,032h,04fh,048h,049h,03bh,0feh,068h,040h,043h,04ch,063h,049h,063h,0feh	; b040  h82OHI;.h@CLcIc.
	defb 068h,048h,04ah,055h,057h,030h,057h,0ffh	; b050  hHJUW0W.

; ----------------------------------------------------------------------
; DATOS rotulo_56: rotulo 56: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (31 bytes)
;   0xb058..0xb077  (31 bytes)
DATA_rotulo_56:
	defb 068h,038h,043h,063h,032h,040h,060h,032h,048h,0feh,068h,040h,038h,063h,05dh,036h	; b058  h8Cc2@`2H.h@8c]6
	defb 04fh,044h,036h,063h,058h,0feh,068h,048h,053h,043h,063h,053h,035h,044h,0ffh	; b068  OD6cX.hHSCcS5D.

; ----------------------------------------------------------------------
; DATOS rotulo_57: rotulo 57: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (26 bytes)
;   0xb077..0xb091  (26 bytes)
DATA_rotulo_57:
	defb 068h,038h,040h,035h,041h,032h,05ah,0feh,068h,040h,043h,034h,059h,046h,031h,05bh	; b077  h8@5A2Z.h@C4YF1[
	defb 045h,0feh,068h,048h,036h,03dh,058h,032h,040h,0ffh	; b087  E.hH6=X2@.

; ----------------------------------------------------------------------
; DATOS rotulo_58: rotulo 58: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb091..0xb0ad  (28 bytes)
DATA_rotulo_58:
	defb 068h,038h,049h,057h,03dh,05dh,045h,0feh,068h,040h,031h,05bh,034h,052h,037h,03fh	; b091  h8IW=]E.h@1[4R7?
	defb 063h,037h,0feh,068h,048h,031h,057h,061h,037h,035h,044h,0ffh	; b0a1  c7.hH1Wa75D.

; ----------------------------------------------------------------------
; DATOS rotulo_59: rotulo 59: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (30 bytes)
;   0xb0ad..0xb0cb  (30 bytes)
DATA_rotulo_59:
	defb 068h,038h,031h,05bh,037h,03fh,063h,036h,0feh,068h,040h,035h,04bh,063h,043h,035h	; b0ad  h81[7?c6.h@5KcC5
	defb 063h,04ah,035h,058h,0feh,068h,048h,03ah,05eh,036h,049h,063h,059h,0ffh	; b0bd  cJ5X.hH:^6IcY.

; ----------------------------------------------------------------------
; DATOS rotulo_60: rotulo 60: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (23 bytes)
;   0xb0cb..0xb0e2  (23 bytes)
DATA_rotulo_60:
	defb 068h,038h,043h,036h,049h,000h,035h,047h,044h,057h,0feh,068h,040h,039h,049h,063h	; b0cb  h8C6I.5GDW.h@9Ic
	defb 05dh,049h,000h,032h,044h,057h,0ffh	; b0db

; ----------------------------------------------------------------------
; DATOS rotulo_61: rotulo 61: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (32 bytes)
;   0xb0e2..0xb102  (32 bytes)
DATA_rotulo_61:
	defb 068h,038h,031h,03fh,041h,063h,056h,053h,0feh,068h,040h,03ch,03ch,063h,051h,048h	; b0e2  h81?AcVS.h@<<cQH
	defb 000h,04bh,05dh,045h,049h,0feh,068h,048h,03ah,05dh,043h,063h,035h,063h,03ah,0ffh	; b0f2  .K]EI.hH:]Cc5c:.

; ----------------------------------------------------------------------
; DATOS rotulo_62: rotulo 62: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (31 bytes)
;   0xb102..0xb121  (31 bytes)
DATA_rotulo_62:
	defb 068h,038h,039h,051h,03fh,063h,05bh,056h,0feh,068h,040h,041h,04bh,063h,03ah,059h	; b102  h89Q?c[V.h@AKc:Y
	defb 04eh,031h,03eh,063h,043h,0feh,068h,048h,035h,04bh,063h,043h,041h,038h,0ffh	; b112  N1>cC.hH5KcCA8.

; ----------------------------------------------------------------------
; DATOS rotulo_63: rotulo 63: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb121..0xb13e  (29 bytes)
DATA_rotulo_63:
	defb 068h,038h,04eh,036h,052h,048h,045h,0feh,068h,040h,04ah,042h,063h,05dh,000h,04fh	; b121  h8N6RHE.h@JBc].O
	defb 041h,038h,042h,0feh,068h,048h,039h,05dh,042h,045h,060h,032h,0ffh	; b131  A8B.hH9]BE`2.

; ----------------------------------------------------------------------
; DATOS rotulo_64: rotulo 64: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (33 bytes)
;   0xb13e..0xb15f  (33 bytes)
DATA_rotulo_64:
	defb 068h,038h,04ah,061h,032h,03fh,05dh,042h,063h,0feh,068h,040h,03fh,031h,057h,061h	; b13e  h8Ja2?]Bc.h@?1Wa
	defb 037h,000h,04fh,044h,036h,063h,058h,0feh,068h,048h,04bh,03bh,036h,063h,035h,044h	; b14e  7.OD6cX.hHK;6c5D
	defb 0ffh	; b15e

; ----------------------------------------------------------------------
; DATOS rotulo_65: rotulo 65: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb15f..0xb17b  (28 bytes)
DATA_rotulo_65:
	defb 068h,038h,05ah,032h,03eh,037h,048h,0feh,068h,040h,04ah,035h,057h,045h,000h,04ah	; b15f  h8Z2>7H.h@J5WE.J
	defb 035h,058h,0feh,068h,048h,031h,057h,037h,063h,040h,053h,0ffh	; b16f  5X.hH1W7c@S.

; ----------------------------------------------------------------------
; DATOS rotulo_66: rotulo 66: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (30 bytes)
;   0xb17b..0xb199  (30 bytes)
DATA_rotulo_66:
	defb 068h,038h,03ch,044h,043h,063h,038h,031h,0feh,068h,040h,043h,036h,048h,000h,04ah	; b17b  h8<DCc81.h@C6H.J
	defb 062h,05dh,040h,045h,0feh,068h,048h,040h,061h,032h,04dh,032h,03bh,0ffh	; b18b  b]@E.hH@a2M2;.

; ----------------------------------------------------------------------
; DATOS rotulo_67: rotulo 67: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb199..0xb1b5  (28 bytes)
DATA_rotulo_67:
	defb 068h,038h,034h,04eh,052h,057h,045h,0feh,068h,040h,04ah,036h,05fh,037h,048h,000h	; b199  h84NRWE.h@J6_7H.
	defb 030h,03bh,048h,0feh,068h,048h,043h,034h,048h,038h,057h,0ffh	; b1a9  0;H.hHC4H8W.

; ----------------------------------------------------------------------
; DATOS rotulo_68: rotulo 68: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (27 bytes)
;   0xb1b5..0xb1d0  (27 bytes)
DATA_rotulo_68:
	defb 068h,038h,04ah,035h,033h,034h,05ah,032h,0feh,068h,040h,039h,048h,031h,05dh,05ah	; b1b5  h8J534Z2.h@9H1]Z
	defb 032h,049h,0feh,068h,048h,050h,042h,036h,044h,057h,0ffh	; b1c5  2I.hHPB6DW.

; ----------------------------------------------------------------------
; DATOS rotulo_69: rotulo 69: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (31 bytes)
;   0xb1d0..0xb1ef  (31 bytes)
DATA_rotulo_69:
	defb 068h,038h,04ah,044h,05bh,03bh,063h,060h,032h,0feh,068h,040h,055h,05ah,031h,035h	; b1d0  h8JD[;c`2.h@UZ15
	defb 063h,000h,030h,059h,049h,063h,0feh,068h,048h,032h,059h,031h,044h,03bh,0ffh	; b1e0  c.0YIc.hH2Y1D;.

; ----------------------------------------------------------------------
; DATOS rotulo_70: rotulo 70: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (30 bytes)
;   0xb1ef..0xb20d  (30 bytes)
DATA_rotulo_70:
	defb 068h,038h,054h,036h,043h,063h,04eh,057h,0feh,068h,040h,036h,03dh,058h,035h,063h	; b1ef  h8T6CcNW.h@6=X5c
	defb 000h,044h,031h,042h,058h,0feh,068h,048h,040h,035h,041h,032h,05ah,0ffh	; b1ff  .D1BX.hH@5A2Z.

; ----------------------------------------------------------------------
; DATOS rotulo_71: rotulo 71: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb20d..0xb229  (28 bytes)
DATA_rotulo_71:
	defb 068h,038h,032h,057h,04dh,063h,032h,048h,0feh,068h,040h,03ah,05dh,04ah,063h,036h	; b20d  h82WMc2H.h@:]Jc6
	defb 04ch,03fh,031h,0feh,068h,048h,035h,05bh,031h,031h,044h,0ffh	; b21d  L?1.hH5[11D.

; ----------------------------------------------------------------------
; DATOS rotulo_72: rotulo 72: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (32 bytes)
;   0xb229..0xb249  (32 bytes)
DATA_rotulo_72:
	defb 068h,038h,031h,03bh,035h,063h,036h,045h,0feh,068h,040h,030h,058h,049h,03ch,063h	; b229  h81;5c6E.h@0XI<c
	defb 044h,035h,05ah,032h,0feh,068h,048h,041h,032h,039h,032h,042h,035h,063h,03fh,0ffh	; b239  D5Z2.hHA292B5c?.

; ----------------------------------------------------------------------
; DATOS rotulo_73: rotulo 73: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb249..0xb266  (29 bytes)
DATA_rotulo_73:
	defb 068h,038h,042h,05dh,035h,038h,058h,0feh,068h,040h,042h,05dh,037h,063h,048h,049h	; b249  h8B]58X.h@B]7cHI
	defb 044h,045h,0feh,068h,048h,039h,049h,063h,05dh,044h,038h,063h,0ffh	; b259  DE.hH9Ic]D8c.

; ----------------------------------------------------------------------
; DATOS rotulo_74: rotulo 74: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (30 bytes)
;   0xb266..0xb284  (30 bytes)
DATA_rotulo_74:
	defb 068h,038h,032h,05eh,035h,057h,043h,0feh,068h,040h,04ah,036h,05fh,037h,045h,000h	; b266  h82^5WC.h@J6_7E.
	defb 043h,056h,059h,058h,0feh,068h,048h,042h,035h,063h,04fh,035h,044h,0ffh	; b276  CVYX.hHB5cO5D.

; ----------------------------------------------------------------------
; DATOS rotulo_75: rotulo 75: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (32 bytes)
;   0xb284..0xb2a4  (32 bytes)
DATA_rotulo_75:
	defb 068h,038h,034h,053h,04bh,063h,05dh,048h,0feh,068h,040h,042h,035h,063h,04fh,05ch	; b284  h84SKc]H.h@B5cO\
	defb 000h,031h,03fh,03fh,063h,037h,0feh,068h,048h,04ah,036h,05fh,037h,035h,044h,0ffh	; b294  .1??c7.hHJ6_75D.

; ----------------------------------------------------------------------
; DATOS rotulo_76: rotulo 76: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (32 bytes)
;   0xb2a4..0xb2c4  (32 bytes)
DATA_rotulo_76:
	defb 068h,038h,034h,053h,04bh,063h,05dh,048h,0feh,068h,040h,042h,035h,063h,04fh,035h	; b2a4  h84SKc]H.h@B5cO5
	defb 063h,000h,044h,038h,059h,049h,063h,0feh,068h,048h,055h,03eh,048h,04ah,043h,0ffh	; b2b4  c.D8YIc.hHU>HJC.

; ----------------------------------------------------------------------
; DATOS rotulo_77: rotulo 77: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (32 bytes)
;   0xb2c4..0xb2e4  (32 bytes)
DATA_rotulo_77:
	defb 068h,038h,036h,05ch,041h,038h,05ah,0feh,068h,040h,034h,049h,063h,049h,063h,048h	; b2c4  h86\A8Z.h@4IcIcH
	defb 000h,049h,063h,037h,03fh,063h,05dh,0feh,068h,048h,031h,048h,040h,043h,057h,0ffh	; b2d4  .Ic7?c].hH1H@CW.

; ----------------------------------------------------------------------
; DATOS rotulo_78: rotulo 78: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb2e4..0xb301  (29 bytes)
DATA_rotulo_78:
	defb 068h,038h,03bh,063h,061h,032h,04dh,032h,053h,0feh,068h,040h,034h,035h,047h,000h	; b2e4  h8;ca2M2S.h@45G.
	defb 043h,056h,059h,042h,0feh,068h,048h,052h,056h,031h,044h,036h,0ffh	; b2f4  CVYB.hHRV1D6.

; ----------------------------------------------------------------------
; DATOS rotulo_79: rotulo 79: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb301..0xb31e  (29 bytes)
DATA_rotulo_79:
	defb 068h,038h,03bh,063h,061h,032h,04dh,032h,053h,0feh,068h,040h,03dh,031h,035h,037h	; b301  h8;ca2M2S.h@=157
	defb 000h,05bh,035h,058h,0feh,068h,048h,03ah,05dh,035h,031h,051h,0ffh	; b311  .[5X.hH:]51Q.

; ----------------------------------------------------------------------
; DATOS rotulo_80: rotulo 80: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (32 bytes)
;   0xb31e..0xb33e  (32 bytes)
DATA_rotulo_80:
	defb 068h,038h,03bh,063h,061h,032h,04dh,032h,053h,0feh,068h,040h,03dh,031h,035h,037h	; b31e  h8;ca2M2S.h@=157
	defb 000h,05bh,035h,058h,0feh,068h,048h,042h,05dh,048h,000h,030h,058h,044h,03bh,0ffh	; b32e  .[5X.hHB]H.0XD;.

; ----------------------------------------------------------------------
; DATOS rotulo_81: rotulo 81: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (31 bytes)
;   0xb33e..0xb35d  (31 bytes)
DATA_rotulo_81:
	defb 068h,038h,033h,059h,036h,035h,063h,045h,0feh,068h,040h,03fh,031h,03bh,063h,048h	; b33e  h83Y65cE.h@?1;cH
	defb 000h,049h,053h,031h,0feh,068h,048h,039h,049h,063h,05dh,044h,038h,063h,0ffh	; b34e  .IS1.hH9Ic]D8c.

; ----------------------------------------------------------------------
; DATOS rotulo_82: rotulo 82: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (31 bytes)
;   0xb35d..0xb37c  (31 bytes)
DATA_rotulo_82:
	defb 068h,038h,043h,041h,03dh,063h,05dh,045h,0feh,068h,040h,043h,04ah,063h,03fh,063h	; b35d  h8CA=c]E.h@CJc?c
	defb 03ch,000h,03ah,035h,044h,045h,0feh,068h,048h,034h,034h,034h,034h,034h,0ffh	; b36d  <.:5DE.hH44444.

; ----------------------------------------------------------------------
; DATOS rotulo_83: rotulo 83: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb37c..0xb399  (29 bytes)
DATA_rotulo_83:
	defb 068h,038h,039h,032h,038h,063h,036h,045h,0feh,068h,040h,04ah,063h,037h,043h,052h	; b37c  h8928c6E.h@Jc7CR
	defb 03bh,044h,031h,0feh,068h,048h,039h,051h,03fh,063h,05bh,056h,0ffh	; b38c  ;D1.hH9Q?c[V.

; ----------------------------------------------------------------------
; DATOS rotulo_84: rotulo 84: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb399..0xb3b5  (28 bytes)
DATA_rotulo_84:
	defb 068h,038h,035h,063h,038h,048h,04bh,040h,0feh,068h,040h,032h,035h,041h,044h,032h	; b399  h85c8HK@.h@25AD2
	defb 039h,063h,036h,0feh,068h,048h,031h,048h,040h,043h,057h,0ffh	; b3a9  9c6.hH1H@CW.

; ----------------------------------------------------------------------
; DATOS rotulo_85: rotulo 85: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb3b5..0xb3d1  (28 bytes)
DATA_rotulo_85:
	defb 068h,038h,045h,035h,031h,051h,048h,0feh,068h,040h,030h,031h,042h,050h,000h,035h	; b3b5  h8E51QH.h@01BP.5
	defb 035h,037h,049h,0feh,068h,048h,031h,05dh,04bh,059h,055h,0ffh	; b3c5  57I.hH1]KYU.

; ----------------------------------------------------------------------
; DATOS rotulo_86: rotulo 86: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (32 bytes)
;   0xb3d1..0xb3f1  (32 bytes)
DATA_rotulo_86:
	defb 068h,038h,040h,035h,048h,031h,05bh,0feh,068h,040h,03ch,04ah,062h,066h,043h,063h	; b3d1  h8@5H1[.h@<JbfCc
	defb 030h,05eh,04bh,062h,042h,063h,0feh,068h,048h,03ah,05dh,039h,043h,04ah,063h,0ffh	; b3e1  0^KbBc.hH:]9CJc.

; ----------------------------------------------------------------------
; DATOS rotulo_87: rotulo 87: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (34 bytes)
;   0xb3f1..0xb413  (34 bytes)
DATA_rotulo_87:
	defb 068h,038h,036h,060h,032h,049h,063h,066h,043h,0feh,068h,040h,03bh,063h,060h,032h	; b3f1  h86`2IcfC.h@;c`2
	defb 049h,063h,031h,000h,03fh,048h,03bh,050h,0feh,068h,048h,04ch,063h,05dh,057h,03ah	; b401  Ic1.?H;P.hHLc]W:
	defb 055h,0ffh	; b411

; ----------------------------------------------------------------------
; DATOS rotulo_88: rotulo 88: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb413..0xb42f  (28 bytes)
DATA_rotulo_88:
	defb 068h,038h,031h,041h,048h,04ah,035h,0feh,068h,040h,054h,037h,03eh,063h,000h,04bh	; b413  h81AHJ5.h@T7>c.K
	defb 057h,045h,050h,0feh,068h,048h,047h,047h,037h,031h,030h,0ffh	; b423  WEP.hHGG710.

; ----------------------------------------------------------------------
; DATOS rotulo_89: rotulo 89: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb42f..0xb44b  (28 bytes)
DATA_rotulo_89:
	defb 068h,038h,030h,056h,04bh,03bh,036h,063h,0feh,068h,040h,031h,059h,042h,000h,041h	; b42f  h80VK;6c.h@1YB.A
	defb 04dh,040h,047h,0feh,068h,048h,037h,03dh,05bh,033h,034h,0ffh	; b43f  M@G.hH7=[34.

; ----------------------------------------------------------------------
; DATOS rotulo_90: rotulo 90: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb44b..0xb468  (29 bytes)
DATA_rotulo_90:
	defb 068h,038h,039h,063h,033h,052h,05dh,045h,0feh,068h,040h,04ch,063h,05dh,057h,000h	; b44b  h89c3R]E.h@Lc]W.
	defb 051h,05ch,04dh,054h,0feh,068h,048h,046h,04ch,03ch,031h,032h,0ffh	; b45b  Q\MT.hHFL<12.

; ----------------------------------------------------------------------
; DATOS rotulo_91: rotulo 91: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb468..0xb485  (29 bytes)
DATA_rotulo_91:
	defb 068h,038h,043h,05dh,042h,063h,054h,037h,0feh,068h,040h,04bh,03bh,036h,063h,000h	; b468  h8C]BcT7.h@K;6c.
	defb 036h,040h,05dh,038h,0feh,068h,048h,058h,030h,04eh,032h,033h,0ffh	; b478  6@]8.hHX0N23.

; ----------------------------------------------------------------------
; DATOS rotulo_92: rotulo 92: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb485..0xb4a1  (28 bytes)
DATA_rotulo_92:
	defb 068h,038h,030h,05dh,039h,063h,032h,048h,0feh,068h,040h,04ah,04fh,041h,000h,033h	; b485  h80]9c2H.h@JOA.3
	defb 03dh,031h,038h,0feh,068h,048h,033h,05bh,04bh,033h,034h,0ffh	; b495  =18.hH3[K34.

; ----------------------------------------------------------------------
; DATOS rotulo_93: rotulo 93: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb4a1..0xb4be  (29 bytes)
DATA_rotulo_93:
	defb 068h,038h,032h,059h,03bh,031h,05bh,0feh,068h,040h,04fh,057h,061h,037h,048h,000h	; b4a1  h82Y;1[.h@OWa7H.
	defb 048h,051h,043h,049h,0feh,068h,048h,045h,041h,031h,031h,034h,0ffh	; b4b1  HQCI.hHEA114.

; ----------------------------------------------------------------------
; DATOS rotulo_94: rotulo 94: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb4be..0xb4db  (29 bytes)
DATA_rotulo_94:
	defb 068h,038h,031h,05eh,040h,05fh,05eh,03fh,0feh,068h,040h,03ch,039h,063h,031h,000h	; b4be  h81^@_^?.h@<9c1.
	defb 057h,031h,04fh,057h,0feh,068h,048h,051h,04fh,03fh,031h,03fh,0ffh	; b4ce  W1OW.hHQO?1?.

; ----------------------------------------------------------------------
; DATOS rotulo_95: rotulo 95: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (30 bytes)
;   0xb4db..0xb4f9  (30 bytes)
DATA_rotulo_95:
	defb 068h,038h,034h,053h,04bh,063h,05dh,000h,049h,0feh,068h,040h,051h,031h,05ah,048h	; b4db  h84SKc].I.h@Q1ZH
	defb 000h,040h,03ch,063h,05ch,0feh,068h,048h,037h,059h,044h,049h,058h,0ffh	; b4eb  .@<c\.hH7YDIX.

; ----------------------------------------------------------------------
; DATOS rotulo_96: rotulo 96: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb4f9..0xb515  (28 bytes)
DATA_rotulo_96:
	defb 068h,038h,036h,04fh,040h,05fh,05dh,038h,063h,05dh,036h,000h,042h,063h,0feh,068h	; b4f9  h86O@_]8c]6.Bc.h
	defb 040h,039h,063h,033h,052h,05dh,000h,038h,063h,05dh,036h,0ffh	; b509  @9c3R].8c]6.

; ----------------------------------------------------------------------
; DATOS rotulo_97: rotulo 97: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (24 bytes)
;   0xb515..0xb52d  (24 bytes)
DATA_rotulo_97:
	defb 068h,038h,030h,038h,04fh,03ah,05dh,048h,03ah,031h,04bh,000h,045h,049h,0feh,068h	; b515  h808O:]H:1K.EI.h
	defb 040h,045h,03dh,05dh,057h,061h,032h,0ffh	; b525  @E=]Wa2.

; ----------------------------------------------------------------------
; DATOS rotulo_98: rotulo 98: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (34 bytes)
;   0xb52d..0xb54f  (34 bytes)
DATA_rotulo_98:
	defb 068h,038h,047h,03ch,063h,04fh,039h,03eh,063h,032h,049h,0feh,068h,040h,037h,058h	; b52d  h8G<cO9>c2I.h@7X
	defb 037h,058h,042h,05dh,000h,03ch,04ch,062h,066h,03ch,0feh,068h,048h,042h,063h,03ch	; b53d  7XB].<Lbf<.hHBc<
	defb 055h,0ffh	; b54d

; ----------------------------------------------------------------------
; DATOS rotulo_99: rotulo 99: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (31 bytes)
;   0xb54f..0xb56e  (31 bytes)
DATA_rotulo_99:
	defb 068h,038h,039h,05dh,042h,045h,060h,032h,0feh,068h,040h,041h,041h,063h,036h,035h	; b54f  h89]BE`2.h@AAc65
	defb 063h,03bh,03fh,031h,000h,043h,0feh,068h,048h,031h,048h,057h,04eh,03ch,0ffh	; b55f  c;?1.C.hH1HWN<.

; ----------------------------------------------------------------------
; DATOS rotulo_100: rotulo 100: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb56e..0xb58a  (28 bytes)
DATA_rotulo_100:
	defb 068h,038h,03dh,05dh,03fh,037h,049h,0feh,068h,040h,042h,063h,037h,063h,040h,048h	; b56e  h8=]?7I.h@Bc7c@H
	defb 04fh,033h,058h,0feh,068h,048h,03ah,05dh,035h,031h,051h,0ffh	; b57e  O3X.hH:]51Q.

; ----------------------------------------------------------------------
; DATOS rotulo_101: rotulo 101: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (28 bytes)
;   0xb58a..0xb5a6  (28 bytes)
DATA_rotulo_101:
	defb 068h,038h,034h,04fh,05eh,040h,05fh,05dh,0feh,068h,040h,039h,049h,063h,05dh,052h	; b58a  h84O^@_].h@9Ic]R
	defb 037h,059h,058h,0feh,068h,048h,03ch,036h,053h,047h,05dh,0ffh	; b59a  7YX.hH<6SG].

; ----------------------------------------------------------------------
; DATOS rotulo_102: rotulo 102: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (30 bytes)
;   0xb5a6..0xb5c4  (30 bytes)
DATA_rotulo_102:
	defb 068h,038h,05bh,035h,031h,048h,000h,043h,063h,032h,03bh,03fh,0feh,068h,040h,04eh	; b5a6  h8[51H.Cc2;?.h@N
	defb 03fh,063h,000h,044h,045h,035h,000h,036h,036h,03fh,031h,048h,035h,0ffh	; b5b6  ?c.DE5.66?1H5.

; ----------------------------------------------------------------------
; DATOS rotulo_103: rotulo 103: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (26 bytes)
;   0xb5c4..0xb5de  (26 bytes)
DATA_rotulo_103:
	defb 068h,038h,031h,056h,05eh,03bh,05fh,031h,04eh,03dh,0feh,068h,040h,04ah,043h,041h	; b5c4  h81V^;_1N=.h@JCA
	defb 000h,043h,063h,044h,031h,042h,063h,03ch,035h,0ffh	; b5d4  .CcD1Bc<5.

; ----------------------------------------------------------------------
; DATOS rotulo_104: rotulo 104: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (11 bytes)
;   0xb5de..0xb5e9  (11 bytes)
DATA_rotulo_104:
	defb 068h,038h,04ch,031h,000h,055h,032h,034h,039h,03bh,0ffh	; b5de  h8L1.U249;.

; ----------------------------------------------------------------------
; DATOS rotulo_105: rotulo 105: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb5e9..0xb606  (29 bytes)
DATA_rotulo_105:
	defb 068h,038h,031h,041h,052h,000h,045h,039h,045h,039h,000h,038h,063h,05dh,036h,05dh	; b5e9  h81AR.E9E9.8c]6]
	defb 0feh,068h,040h,049h,063h,056h,031h,000h,000h,000h,000h,000h,0ffh	; b5f9  .h@IcV1......

; ----------------------------------------------------------------------
; DATOS rotulo_106: rotulo 106: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (26 bytes)
;   0xb606..0xb620  (26 bytes)
DATA_rotulo_106:
	defb 068h,038h,045h,031h,03ah,05dh,000h,04eh,031h,043h,063h,0feh,068h,040h,044h,045h	; b606  h8E1:].N1Cc.h@DE
	defb 000h,03ah,03bh,030h,038h,063h,04eh,03bh,061h,0ffh	; b616  .:;08cN;a.

; ----------------------------------------------------------------------
; DATOS rotulo_107: rotulo 107: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (26 bytes)
;   0xb620..0xb63a  (26 bytes)
DATA_rotulo_107:
	defb 068h,038h,035h,047h,052h,000h,052h,05eh,042h,047h,033h,048h,045h,0feh,068h,040h	; b620  h85GR.R^BG3HE.h@
	defb 04bh,042h,033h,000h,053h,05ah,032h,03fh,063h,0ffh	; b630  KB3.SZ2?c.

; ----------------------------------------------------------------------
; DATOS rotulo_108: rotulo 108: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (18 bytes)
;   0xb63a..0xb64c  (18 bytes)
DATA_rotulo_108:
	defb 068h,038h,045h,031h,03ah,05dh,000h,04bh,03ah,063h,038h,040h,05fh,039h,04eh,058h	; b63a  h8E1:].K:c8@_9NX
	defb 044h,0ffh	; b64a

; ----------------------------------------------------------------------
; DATOS rotulo_109: rotulo 109: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (27 bytes)
;   0xb64c..0xb667  (27 bytes)
DATA_rotulo_109:
	defb 068h,038h,035h,047h,052h,044h,031h,048h,045h,000h,04fh,03dh,045h,0feh,068h,040h	; b64c  h85GRD1HE.O=E.h@
	defb 037h,058h,05dh,03bh,063h,05fh,044h,031h,03dh,063h,0ffh	; b65c  7X];c_D1=c.

; ----------------------------------------------------------------------
; DATOS rotulo_110: rotulo 110: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (17 bytes)
;   0xb667..0xb678  (17 bytes)
DATA_rotulo_110:
	defb 068h,038h,030h,05dh,03fh,000h,034h,035h,047h,035h,063h,03fh,057h,044h,031h,055h	; b667  h80]?.45G5c?WD1U
	defb 0ffh	; b677

; ----------------------------------------------------------------------
; DATOS rotulo_111: rotulo 111: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (16 bytes)
;   0xb678..0xb688  (16 bytes)
DATA_rotulo_111:
	defb 068h,038h,045h,031h,03ah,05dh,000h,04fh,03dh,049h,034h,05bh,05eh,03fh,055h,0ffh	; b678  h8E1:].O=I4[^?U.

; ----------------------------------------------------------------------
; DATOS rotulo_112: rotulo 112: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (29 bytes)
;   0xb688..0xb6a5  (29 bytes)
DATA_rotulo_112:
	defb 068h,038h,04eh,03fh,039h,05dh,043h,063h,000h,04fh,03dh,048h,030h,031h,042h,031h	; b688  h8N?9]Cc.O=H01B1
	defb 058h,0feh,068h,040h,043h,036h,045h,000h,036h,043h,037h,059h,0ffh	; b698  X.h@C6E.6C7Y.

; ----------------------------------------------------------------------
; DATOS rotulo_113: rotulo 113: [x][y] y caracteres, 0xFE otra posicion, 0xFF
;   acaba (0x48F3); lo leen p00:428F (45 bytes)
;   0xb6a5..0xb6d2  (45 bytes)
DATA_rotulo_113:
	defb 068h,038h,045h,031h,03ah,05dh,000h,000h,000h,000h,06ah,03fh,063h,03dh,049h,063h	; b6a5  h8E1:]....j?c=Ic
	defb 0feh,068h,040h,039h,048h,034h,037h,048h,000h,04ah,04fh,041h,048h,041h,032h,05ah	; b6b5  .h@9H47H.JOAHA2Z
	defb 045h,0feh,068h,048h,030h,05dh,044h,031h,000h,03bh,055h,032h,0ffh	; b6c5  E.hH0]D1.;U2.

; ----------------------------------------------------------------------
; DATOS poses_de_figura: 150 punteros, uno por pose de figura (ix+0x0A), a su
;   ficha de sprites (p02:8800); lo leen p02:8800 (300 bytes)
;   0xb6d2..0xb7fe  (300 bytes)
DATA_poses_de_figura:
	defb 010h,0b8h,015h,0b8h,01ah,0b8h,01fh,0b8h,02eh,0b8h,033h,0b8h,038h,0b8h,03dh,0b8h	; b6d2  ..........3.8.=.
	defb 094h,0b8h,099h,0b8h,09eh,0b8h,0a3h,0b8h,042h,0b8h,047h,0b8h,04ch,0b8h,051h,0b8h	; b6e2  ........B.G.L.Q.
	defb 024h,0b8h,029h,0b8h,072h,0b8h,0feh,0b7h,001h,0b8h,004h,0b8h,007h,0b8h,00ah,0b8h	; b6f2  $.).r...........
	defb 00dh,0b8h,090h,0b8h,092h,0b8h,0a8h,0b8h,074h,0b8h,07bh,0b8h,082h,0b8h,089h,0b8h	; b702  ........t.{.....
	defb 0abh,0b8h,0b2h,0b8h,0b9h,0b8h,0c0h,0b8h,0c7h,0b8h,0cch,0b8h,0d1h,0b8h,0d6h,0b8h	; b712  ................
	defb 056h,0b8h,05dh,0b8h,064h,0b8h,06bh,0b8h,0dbh,0b8h,0e2h,0b8h,0e9h,0b8h,0f0h,0b8h	; b722  V.].d.k.........
	defb 0f7h,0b8h,0fah,0b8h,0fdh,0b8h,000h,0b9h,003h,0b9h,006h,0b9h,003h,0b9h,006h,0b9h	; b732  ................
	defb 009h,0b9h,00eh,0b9h,013h,0b9h,018h,0b9h,01dh,0b9h,020h,0b9h,023h,0b9h,026h,0b9h	; b742  .......... .#.&.
	defb 029h,0b9h,02ch,0b9h,031h,0b9h,036h,0b9h,03bh,0b9h,040h,0b9h,045h,0b9h,04ah,0b9h	; b752  ).,.1.6.;.@.E.J.
	defb 04dh,0b9h,050h,0b9h,053h,0b9h,05ah,0b9h,053h,0b9h,05ah,0b9h,061h,0b9h,06ah,0b9h	; b762  M.P.S.Z.S.Z.a.j.
	defb 073h,0b9h,07ch,0b9h,088h,0b9h,085h,0b9h,08bh,0b9h,092h,0b9h,099h,0b9h,0a0h,0b9h	; b772  s.|.............
	defb 0a7h,0b9h,0aah,0b9h,0adh,0b9h,0b0h,0b9h,0b3h,0b9h,0bah,0b9h,0c1h,0b9h,0c8h,0b9h	; b782  ................
	defb 0cfh,0b9h,0d6h,0b9h,0ddh,0b9h,0e4h,0b9h,0ebh,0b9h,0f2h,0b9h,0f9h,0b9h,000h,0bah	; b792  ................
	defb 007h,0bah,00eh,0bah,015h,0bah,018h,0bah,01bh,0bah,01eh,0bah,021h,0bah,024h,0bah	; b7a2  ............!.$.
	defb 027h,0bah,02ah,0bah,02dh,0bah,036h,0bah,03fh,0bah,048h,0bah,051h,0bah,056h,0bah	; b7b2  '.*.-.6.?.H.Q.V.
	defb 05bh,0bah,060h,0bah,065h,0bah,06ah,0bah,06fh,0bah,074h,0bah,079h,0bah,07ch,0bah	; b7c2  [.`.e.j.o.t.y.|.
	defb 07fh,0bah,082h,0bah,08bh,0bah,094h,0bah,09dh,0bah,0a0h,0bah,0a3h,0bah,0a6h,0bah	; b7d2  ................
	defb 0b2h,0bah,0bbh,0bah,0a9h,0bah,0c4h,0bah,0c9h,0bah,0ceh,0bah,0d3h,0bah,0d8h,0bah	; b7e2  ................
	defb 0dbh,0bah,0deh,0bah,0e1h,0bah,0e4h,0bah,0e7h,0bah,0eah,0bah	; b7f2  ............

; ----------------------------------------------------------------------
; DATOS fichas_de_pose: las fichas de pose: [desplazamientos] (el numero de la
;   lista de 0xBAF3) y el dibujo de cada sprite; cuantos sprites lleva lo dice
;   (ix+0x20), que pone quien crea la figura, asi que cada ficha llega hasta
;   la siguiente (p02:8806, 8831); lo leen p02:8806 (757 bytes)
;   0xb7fe..0xbaf3  (757 bytes)
DATA_fichas_de_pose:
	defb 000h,058h,070h,000h,05ch,070h,000h,060h,070h,000h,064h,070h,000h,068h,070h,000h	; b7fe  .Xp.\p.`p.dp.hp.
	defb 06ch,070h,002h,0b0h,0b4h,0b8h,0bch,001h,0b0h,0b4h,0c0h,0c4h,002h,0c8h,0cch,0d0h	; b80e  lp..............
	defb 0d4h,001h,0c8h,0cch,0d8h,0dch,001h,038h,03ch,040h,044h,001h,048h,04ch,050h,054h	; b81e  .......8<@D.HLPT
	defb 001h,060h,064h,068h,06ch,001h,070h,074h,078h,07ch,001h,080h,084h,088h,08ch,001h	; b82e  .`dhl.ptx|......
	defb 090h,094h,098h,09ch,001h,0d0h,0d4h,0d8h,0dch,002h,0d0h,0d4h,0e0h,0e4h,001h,0e8h	; b83e  ................
	defb 0ech,0f0h,0f4h,002h,0e8h,0ech,0f8h,0fch,00ch,030h,034h,038h,03ch,040h,044h,00dh	; b84e  .........048<@D.
	defb 048h,04ch,050h,054h,058h,05ch,00eh,060h,064h,068h,06ch,070h,074h,00fh,078h,07ch	; b85e  HLPTX\.`dhlpt.x|
	defb 080h,084h,088h,08ch,000h,01ch,004h,0a0h,0a4h,0a8h,0ach,0b0h,0b4h,005h,0a0h,0a4h	; b86e  ................
	defb 0b8h,0bch,0c0h,0c4h,006h,0c8h,0cch,0d0h,0d4h,0d8h,0dch,007h,0c8h,0cch,0e0h,0e4h	; b87e  ................
	defb 0e8h,0ech,000h,074h,000h,078h,002h,030h,034h,038h,03ch,001h,030h,034h,040h,044h	; b88e  ...t.x.048<.04@D
	defb 002h,048h,04ch,050h,054h,001h,048h,04ch,058h,05ch,003h,090h,094h,008h,0d0h,0d4h	; b89e  .HLPT.HLX\......
	defb 0d8h,0dch,0e0h,0e4h,009h,0e8h,0ech,0f0h,0f4h,0f8h,0fch,00ah,0a0h,0a4h,0a8h,0ach	; b8ae  ................
	defb 0b0h,0b4h,00bh,0b8h,0bch,0c0h,0c4h,0c8h,0cch,002h,0a0h,0a4h,0a8h,0ach,001h,0a0h	; b8be  ................
	defb 0a4h,0b0h,0b4h,002h,0b8h,0bch,0c0h,0c4h,001h,0b8h,0bch,0c8h,0cch,008h,060h,064h	; b8ce  ..............`d
	defb 068h,06ch,070h,074h,011h,078h,07ch,080h,084h,088h,08ch,00ah,030h,034h,038h,03ch	; b8de  hlpt.x|.....048<
	defb 040h,044h,010h,048h,04ch,050h,054h,058h,05ch,000h,030h,034h,000h,038h,03ch,000h	; b8ee  @D.HLPTX\.04.8<.
	defb 040h,044h,000h,048h,04ch,000h,0a0h,0a4h,000h,0a8h,0ach,001h,0b0h,0b4h,0b8h,0bch	; b8fe  @D.HL...........
	defb 001h,0c0h,0c4h,0c8h,0cch,001h,0d0h,0d4h,0d8h,0dch,001h,0e0h,0e4h,0e8h,0ech,000h	; b90e  ................
	defb 080h,084h,000h,088h,08ch,000h,038h,03ch,013h,040h,044h,013h,048h,04ch,001h,030h	; b91e  ......8<.@D.HL.0
	defb 034h,038h,03ch,001h,040h,044h,048h,04ch,002h,030h,034h,038h,03ch,001h,030h,034h	; b92e  48<.@DHL.048<.04
	defb 040h,044h,002h,048h,04ch,050h,054h,001h,048h,04ch,058h,05ch,000h,020h,024h,000h	; b93e  @D.HLPT.HLX\. $.
	defb 028h,02ch,003h,0b0h,0b4h,005h,0d0h,0d4h,0d8h,0dch,0e0h,0e4h,005h,0e8h,0ech,0f0h	; b94e  (,..............
	defb 0f4h,0f8h,0fch,014h,060h,064h,068h,06ch,070h,074h,078h,07ch,014h,080h,084h,088h	; b95e  ....`dhlptx|....
	defb 08ch,090h,094h,098h,09ch,014h,0a8h,0ach,0a0h,0a4h,0b8h,0bch,0b0h,0b4h,014h,0c8h	; b96e  ................
	defb 0cch,0c0h,0c4h,0d8h,0dch,0d0h,0d4h,003h,098h,09ch,003h,0a0h,0a4h,015h,0a0h,0a4h	; b97e  ................
	defb 0b0h,0b4h,0a8h,0ach,015h,0b8h,0bch,0c8h,0cch,0c0h,0c4h,016h,0d0h,0d4h,0e0h,0e4h	; b98e  ................
	defb 0d8h,0dch,016h,0e8h,0ech,0f8h,0fch,0f0h,0f4h,000h,0e0h,0e4h,000h,0e8h,0ech,000h	; b99e  ................
	defb 0f0h,0f4h,000h,0f8h,0fch,017h,030h,034h,040h,044h,038h,03ch,018h,030h,034h,048h	; b9ae  ......04@D8<.04H
	defb 04ch,038h,03ch,019h,058h,05ch,068h,06ch,060h,064h,01ah,058h,05ch,070h,074h,060h	; b9be  L8<.X\hl`d.X\pt`
	defb 064h,00ah,0a0h,0a4h,0a8h,0ach,0b0h,0b4h,009h,0b8h,0bch,0c0h,0c4h,0c8h,0cch,008h	; b9ce  d...............
	defb 0d0h,0d4h,0d8h,0dch,0e0h,0e4h,00bh,0e8h,0ech,0f0h,0f4h,0f8h,0fch,009h,0a0h,0a4h	; b9de  ................
	defb 0a8h,0ach,0b0h,0b4h,009h,0b8h,0bch,0c0h,0c4h,0c8h,0cch,00bh,0d0h,0d4h,0d8h,0dch	; b9ee  ................
	defb 0e0h,0e4h,00bh,0e8h,0ech,0f0h,0f4h,0f8h,0fch,01bh,030h,034h,050h,054h,038h,03ch	; b9fe  ..........04PT8<
	defb 01ch,058h,05ch,078h,07ch,060h,064h,000h,030h,034h,000h,038h,03ch,012h,040h,044h	; ba0e  .X\x|`d.04.8<.@D
	defb 000h,048h,04ch,000h,030h,034h,000h,038h,03ch,000h,040h,044h,000h,048h,04ch,001h	; ba1e  .HL.04.8<.@D.HL.
	defb 070h,074h,078h,07ch,0d4h,0d4h,0d4h,0d4h,002h,070h,074h,080h,084h,0d4h,0d4h,0d4h	; ba2e  ptx|.....pt.....
	defb 0d4h,020h,088h,08ch,090h,094h,098h,09ch,0d4h,0d4h,021h,0a0h,0a4h,0a8h,0ach,0b0h	; ba3e  . ........!.....
	defb 0b4h,0b8h,0bch,01dh,010h,014h,028h,02ch,01dh,040h,044h,058h,05ch,01eh,030h,034h	; ba4e  ......(,.@DX\.04
	defb 038h,03ch,01fh,060h,064h,068h,06ch,002h,010h,014h,018h,01ch,001h,010h,014h,020h	; ba5e  8<.`dhl........
	defb 024h,002h,040h,044h,048h,04ch,001h,040h,044h,050h,054h,025h,038h,03ch,013h,044h	; ba6e  $.@DHL.@DPT%8<.D
	defb 040h,022h,04ch,048h,001h,000h,004h,008h,00ch,010h,064h,064h,064h,001h,014h,018h	; ba7e  @"LH......ddd...
	defb 01ch,020h,024h,064h,064h,064h,023h,028h,02ch,030h,034h,038h,03ch,040h,064h,000h	; ba8e  . $ddd#(,048<@d.
	defb 054h,058h,000h,05ch,060h,000h,044h,048h,000h,04ch,050h,024h,090h,094h,098h,09ch	; ba9e  TX.\`.DH.LP$....
	defb 0a0h,0a4h,0a8h,064h,001h,068h,06ch,070h,074h,078h,064h,064h,064h,001h,07ch,080h	; baae  ...d.hlptxddd.|.
	defb 084h,088h,08ch,064h,064h,064h,001h,0a0h,0a4h,0a8h,0ach,001h,0b0h,0b4h,0b8h,0bch	; babe  ...ddd..........
	defb 001h,0c0h,0c4h,0c8h,0cch,001h,0d0h,0d4h,0d8h,0dch,000h,060h,064h,000h,068h,06ch	; bace  ...........`d.hl
	defb 000h,070h,074h,000h,078h,07ch,000h,0e0h,0e4h,000h,0e8h,0ech,020h,088h,08ch,0c0h	; bade  .pt.x|...... ...
	defb 0c4h,0c8h,0cch,0d4h,0d4h	; baee

; ----------------------------------------------------------------------
; DATOS desplazamientos_de_pose: 38 punteros a listas de desplazamientos de
;   sprite (p02:8809); lo leen p02:8809 (76 bytes)
;   0xbaf3..0xbb3f  (76 bytes)
DATA_desplazamientos_de_pose:
	defb 043h,0bbh,03fh,0bbh,04fh,0bbh,0b7h,0bbh,093h,0bbh,0abh,0bbh,087h,0bbh,09fh,0bbh	; baf3  C.?.O...........
	defb 0c7h,0bbh,0bbh,0bbh,0d3h,0bbh,0dfh,0bbh,063h,0bbh,06fh,0bbh,057h,0bbh,07bh,0bbh	; bb03  ........c.o.W.{.
	defb 0f7h,0bbh,0ebh,0bbh,053h,0bbh,003h,0bch,007h,0bch,017h,0bch,023h,0bch,03bh,0bch	; bb13  ....S.......#.;.
	defb 047h,0bch,02fh,0bch,053h,0bch,05fh,0bch,06bh,0bch,09bh,0bch,0a3h,0bch,0abh,0bch	; bb23  G./.S._.k.......
	defb 077h,0bch,087h,0bch,097h,0bch,0b3h,0bch,0c3h,0bch,013h,0bch	; bb33  w...........

; ----------------------------------------------------------------------
; DATOS listas_de_desplazamientos: parejas [dy][dx] de cada sprite respecto a
;   (ix+3, ix+5), un dx negativo con el bit 7 (p02:8821, 883C); cada lista
;   llega hasta la siguiente; lo leen p02:8821 (404 bytes)
;   0xbb3f..0xbcd3  (404 bytes)
DATA_listas_de_desplazamientos:
	defb 0e1h,0f8h,0e1h,0f8h,0f1h,0f8h,0f1h,0f8h,0f1h,0f8h,0d1h,0f8h,0d1h,0f8h,0d1h,0f8h	; bb3f  ................
	defb 0e2h,0f8h,0e2h,0f8h,0f2h,0f8h,0f2h,0f8h,0e3h,0f8h,0e3h,0f8h,0f3h,0f8h,0f3h,0f8h	; bb4f  ................
	defb 0f3h,008h,0f3h,008h,0e3h,0f8h,0e3h,0f8h,0f3h,0f8h,0f3h,0f8h,0f3h,0e8h,0f3h,0e8h	; bb5f  ................
	defb 0e2h,0f8h,0e2h,0f8h,0f2h,0f8h,0f2h,0f8h,0e2h,0e8h,0e2h,0e8h,0e2h,0f8h,0e2h,0f8h	; bb6f  ................
	defb 0f2h,0f8h,0f2h,0f8h,0e2h,008h,0e2h,008h,0e2h,0f8h,0e2h,0f8h,0f2h,0f8h,0f2h,0f8h	; bb7f  ................
	defb 0f2h,008h,0f2h,008h,0e2h,0f8h,0e2h,0f8h,0f2h,0f8h,0f2h,0f8h,0f2h,0e8h,0f2h,0e8h	; bb8f  ................
	defb 0e1h,0f8h,0e1h,0f8h,0f1h,0f8h,0f1h,0f8h,0e9h,008h,0e9h,008h,0e1h,0f8h,0e1h,0f8h	; bb9f  ................
	defb 0f1h,0f8h,0f1h,0f8h,0e9h,0e8h,0e9h,0e8h,0f9h,0fch,0f9h,0fch,0e1h,0f8h,0e1h,0f8h	; bbaf  ................
	defb 0f1h,0f8h,0f1h,0f8h,0f1h,0e8h,0f1h,0e8h,0e1h,0f8h,0e1h,0f8h,0f1h,0f8h,0f1h,0f8h	; bbbf  ................
	defb 0e1h,008h,0e1h,008h,0e1h,0f8h,0e1h,0f8h,0f1h,0f8h,0f1h,0f8h,0e1h,0e8h,0e1h,0e8h	; bbcf  ................
	defb 0e1h,0f8h,0e1h,0f8h,0f1h,0f8h,0f1h,0f8h,0f1h,008h,0f1h,008h,0e1h,0f8h,0e1h,0f8h	; bbdf  ................
	defb 0f1h,0f8h,0f1h,0f8h,0e3h,0e8h,0e3h,0e8h,0e1h,0f8h,0e1h,0f8h,0f1h,0f8h,0f1h,0f8h	; bbef  ................
	defb 0e3h,008h,0e3h,008h,0eeh,0f8h,0eeh,0f8h,0e1h,0f0h,0e1h,0f0h,0e1h,000h,0e1h,000h	; bbff  ................
	defb 0f1h,0f0h,0f1h,0f0h,0f1h,000h,0f1h,000h,0e1h,0fah,0e1h,0fah,0f1h,0fbh,0f1h,0fbh	; bc0f  ................
	defb 0f1h,0ebh,0f1h,0ebh,0e1h,0f7h,0e1h,0f7h,0f1h,0f6h,0f1h,0f6h,0f1h,006h,0f1h,006h	; bc1f  ................
	defb 0e0h,0f8h,0e0h,0f8h,0f0h,0f8h,0f0h,0f8h,0e7h,008h,0e7h,008h,0e0h,0f8h,0e0h,0f8h	; bc2f  ................
	defb 0f0h,0f8h,0f0h,0f8h,0e7h,0e8h,0e7h,0e8h,0e1h,0f8h,0e1h,0f8h,0f1h,0f8h,0f1h,0f8h	; bc3f  ................
	defb 0e8h,0e8h,0e8h,0e8h,0e1h,0f8h,0e1h,0f8h,0f1h,0f8h,0f1h,0f8h,0e8h,008h,0e8h,008h	; bc4f  ................
	defb 0e5h,0f8h,0e5h,0f8h,0f5h,0f8h,0f5h,0f8h,0ech,0e8h,0ech,0e8h,0e5h,0f8h,0e5h,0f8h	; bc5f  ................
	defb 0f5h,0f8h,0f5h,0f8h,0ech,008h,0ech,008h,0e5h,0f7h,0e5h,0f7h,0f5h,0efh,0f5h,0efh	; bc6f  ................
	defb 0f5h,0ffh,0f5h,0ffh,0d5h,0f7h,0d5h,0f7h,0e7h,0ech,0e7h,0ech,0e7h,0fch,0e7h,0fch	; bc7f  ................
	defb 0f7h,0eeh,0f7h,0eeh,0f7h,0feh,0f7h,0feh,0edh,0f8h,0edh,0f8h,0e3h,0f8h,0e3h,0f8h	; bc8f  ................
	defb 0f3h,0f8h,0f3h,0f8h,0f1h,0f3h,0f1h,0f3h,0f1h,003h,0f1h,003h,0f1h,0feh,0f1h,0feh	; bc9f  ................
	defb 0f1h,0eeh,0f1h,0eeh,0e1h,0f9h,0e1h,0f9h,0f1h,0f9h,0f1h,0f9h,0f1h,0f9h,0eeh,0f1h	; bcaf  ................
	defb 0eeh,0f1h,0d1h,0f9h,0e1h,0f9h,0e1h,0f9h,0f1h,0f9h,0f1h,0f9h,0f1h,0f9h,0eeh,0e9h	; bcbf  ................
	defb 0eeh,0e9h,0d1h,0f9h	; bccf

; ----------------------------------------------------------------------
; DATOS palabras: 7 punteros a trozos de texto que p01:656E junta en 0xD800
;   separados por 0xFE 0xFE; lo leen p01:656B (14 bytes)
;   0xbcd3..0xbce1  (14 bytes)
DATA_palabras:
	defb 0e1h,0bch,0f2h,0bch,010h,0bdh,098h,0bdh,02eh,0beh,044h,0beh,083h,0beh	; bcd3  ..........D...

; ----------------------------------------------------------------------
; DATOS palabra_0: trozo de texto 0: [n] y n caracteres (p01:6573 los copia
;   con ldir); lo leen p01:6571 (17 bytes)
;   0xbce1..0xbcf2  (17 bytes)
DATA_palabra_0:
	defb 010h,034h,046h,03bh,049h,000h,03fh,031h,03bh,03fh,000h,052h,048h,055h,048h,032h	; bce1  .4F;I.?1;?.RHUH2
	defb 064h	; bcf1

; ----------------------------------------------------------------------
; DATOS palabra_1: trozo de texto 1: [n] y n caracteres (p01:6573 los copia
;   con ldir); lo leen p01:6571 (30 bytes)
;   0xbcf2..0xbd10  (30 bytes)
DATA_palabra_1:
	defb 01dh,034h,046h,03bh,000h,055h,037h,053h,05eh,03fh,064h,0feh,0feh,043h,057h,030h	; bcf2  .4F;.U7S^?d..CW0
	defb 033h,03ch,063h,049h,000h,04dh,051h,042h,000h,041h,035h,05bh,03ch,064h	; bd02  3<cI.MQB.A5[<d

; ----------------------------------------------------------------------
; DATOS palabra_2: trozo de texto 2: [n] y n caracteres (p01:6573 los copia
;   con ldir); lo leen p01:6571 (136 bytes)
;   0xbd10..0xbd98  (136 bytes)
DATA_palabra_2:
	defb 087h,039h,059h,042h,063h,000h,055h,048h,044h,035h,052h,000h,04ch,031h,05bh,043h	; bd10  .9YBc.UHD5R.L1[C
	defb 044h,057h,000h,03bh,061h,04fh,05dh,048h,0feh,0feh,037h,056h,03bh,052h,000h,055h	; bd20  DW.;aO]H..7V;R.U
	defb 037h,044h,058h,042h,063h,000h,030h,05ah,032h,064h,0feh,0feh,03bh,035h,03bh,000h	; bd30  7DXBc.0Z2d..;5;.
	defb 031h,041h,04eh,03fh,000h,043h,063h,039h,035h,042h,063h,000h,05bh,058h,031h,000h	; bd40  1AN?.Cc95Bc.[X1.
	defb 043h,048h,03ah,04eh,035h,063h,0feh,0feh,030h,056h,05bh,059h,058h,035h,000h,05bh	; bd50  CH:N5c..0V[YX5.[
	defb 035h,057h,05fh,03dh,05dh,064h,0feh,0feh,03eh,048h,043h,036h,045h,049h,000h,04bh	; bd60  5W_=]d..>HC6EI.K
	defb 03fh,03fh,04ah,063h,000h,034h,046h,03bh,048h,000h,035h,041h,053h,037h,045h,0feh	; bd70  ??Jc.4F;H.5AS7E.
	defb 0feh,03bh,061h,04fh,05dh,048h,000h,047h,035h,063h,031h,05ch,000h,03fh,037h,03ch	; bd80  .;aO]H.G5c1\.?7<
	defb 039h,043h,045h,000h,044h,05ah,032h,064h	; bd90  9CE.DZ2d

; ----------------------------------------------------------------------
; DATOS palabra_3: trozo de texto 3: [n] y n caracteres (p01:6573 los copia
;   con ldir); lo leen p01:6571 (150 bytes)
;   0xbd98..0xbe2e  (150 bytes)
DATA_palabra_3:
	defb 095h,03bh,035h,03bh,000h,03ch,04ch,063h,042h,048h,000h,037h,045h,048h,000h,043h	; bd98  .;5;.<LcBH.7EH.C
	defb 048h,03ah,04eh,035h,063h,000h,055h,031h,0feh,0feh,03dh,031h,03bh,063h,05ch,000h	; bda8  H:N5c.U1..=1;c\.
	defb 053h,037h,03eh,037h,000h,03bh,042h,037h,059h,03fh,000h,05bh,038h,042h,063h,049h	; bdb8  S7>7.;B7Y?.[8BcI
	defb 000h,044h,031h,064h,0feh,0feh,039h,059h,042h,063h,049h,000h,03ch,04ch,063h,042h	; bdc8  .D1d..9YBcI.<LcB
	defb 048h,000h,03bh,061h,04fh,05dh,048h,000h,037h,056h,03bh,035h,063h,000h,055h,037h	; bdd8  H.;aO]H.7V;5c.U7
	defb 0feh,0feh,044h,05eh,03fh,043h,049h,000h,031h,031h,035h,063h,03fh,031h,064h,0feh	; bde8  ..D^?CI.115c?1d.
	defb 0feh,031h,04eh,031h,040h,043h,063h,000h,03bh,061h,039h,037h,045h,000h,052h,043h	; bdf8  .1N1@Cc.;a97E.RC
	defb 063h,057h,000h,04bh,03fh,03fh,04ah,063h,0feh,0feh,055h,044h,034h,03bh,05ch,000h	; be08  cW.K??Jc..UD4;\.
	defb 053h,05eh,042h,037h,059h,064h,0feh,0feh,038h,05dh,043h,032h,05ch,000h,031h,048h	; be18  S^B7Yd..8]C2\.1H
	defb 05eh,043h,058h,03eh,063h,064h	; be28

; ----------------------------------------------------------------------
; DATOS palabra_4: trozo de texto 4: [n] y n caracteres (p01:6573 los copia
;   con ldir); lo leen p01:6571 (22 bytes)
;   0xbe2e..0xbe44  (22 bytes)
DATA_palabra_4:
	defb 015h,039h,063h,037h,05ah,032h,042h,063h,030h,05eh,03fh,064h,000h,030h,05eh,049h	; be2e  .9c7Z2Bc0^?d.0^I
	defb 062h,059h,03bh,063h,05fh,064h	; be3e

; ----------------------------------------------------------------------
; DATOS palabra_5: trozo de texto 5: [n] y n caracteres (p01:6573 los copia
;   con ldir); lo leen p01:6571 (63 bytes)
;   0xbe44..0xbe83  (63 bytes)
DATA_palabra_5:
	defb 03eh,043h,039h,05ah,042h,063h,000h,041h,036h,063h,045h,042h,063h,058h,000h,039h	; be44  >C9ZBc.A6cEBcX.9
	defb 044h,04fh,048h,000h,038h,063h,066h,050h,049h,0feh,0feh,04ah,048h,043h,057h,000h	; be54  DOH.8cfPI..JHCW.
	defb 043h,000h,04eh,03bh,063h,061h,032h,042h,063h,05dh,03dh,041h,022h,000h,03bh,063h	; be64  C.N;ca2Bc]=A".;c
	defb 05fh,064h,0feh,0feh,055h,05ah,03bh,037h,000h,03fh,048h,050h,03eh,063h,064h	; be74  _d..UZ;7.?HP>cd

; ----------------------------------------------------------------------
; DATOS palabra_6: trozo de texto 6: [n] y n caracteres (p01:6573 los copia
;   con ldir); lo leen p01:6571 (61 bytes)
;   0xbe83..0xbec0  (61 bytes)
DATA_palabra_6:
	defb 03ch,043h,039h,05ah,042h,063h,000h,039h,048h,041h,036h,063h,049h,000h,021h,020h	; be83  <C9ZBc.9HA6cI.!
	defb 049h,063h,031h,03fh,048h,03bh,050h,000h,035h,066h,043h,0feh,0feh,057h,05eh,03bh	; be93  Ic1?H;P.5fC..W^;
	defb 063h,05ch,041h,035h,05bh,03ch,063h,045h,000h,055h,044h,034h,03bh,05ch,000h,053h	; bea3  c\A5[<cE.UD4;\.S
	defb 05eh,042h,04dh,03bh,031h,0feh,0feh,052h,048h,055h,048h,032h,064h	; beb3  ^BM;1..RHUH2d

; ----------------------------------------------------------------------
; DATOS relleno_12: 320 bytes 0xFF hasta el final del banco: relleno, no lo
;   lee nadie; lo leen nadie (320 bytes)
;   0xbec0..0xc000  (320 bytes)
DATA_relleno_12:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bec0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bed0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bee0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bef0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf00  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf10  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf20  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf30  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf40  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf50  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf60  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf70  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf80  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf90  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfa0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfb0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff0  ................
