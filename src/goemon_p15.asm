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
; DATOS sin identificar  0xa02b..0xbef8  (7885 bytes)
DATA_A02B:
	defb 03dh,0a0h,042h,0a0h,047h,0a0h,04ch,0a0h,051h,0a0h,064h,0a0h,077h,0a0h,08ah,0a0h	; a02b  =.B.G.L.Q.d.w...
	defb 08ch,0a0h,080h,010h,000h,000h,0ffh,080h,020h,000h,000h,0ffh,080h,000h,000h,000h	; a03b  ........ .......
	defb 0ffh,080h,030h,000h,000h,0ffh,080h,030h,000h,000h,000h,010h,000h,020h,000h,030h	; a04b  ..0....0..... .0
	defb 010h,000h,010h,010h,010h,020h,010h,030h,0ffh,080h,030h,000h,000h,000h,010h,010h	; a05b  ..... .0..0.....
	defb 000h,010h,010h,020h,000h,020h,010h,030h,000h,030h,010h,0ffh,080h,030h,000h,000h	; a06b  ... . .0.0...0..
	defb 000h,010h,000h,020h,000h,030h,000h,040h,000h,050h,000h,060h,000h,070h,0ffh,0ffh	; a07b  ... .0.@.P.`.p..
	defb 0ffh,0ffh,0ffh,0f0h,0a0h,073h,0a1h,0abh,0a1h,0d4h,0a1h,033h,0a2h,07dh,0a2h,0c7h	; a08b  .....s.....3.}..
	defb 0a2h,002h,0a3h,067h,0a3h,0aeh,0a3h,028h,0a4h,05dh,0a4h,0d4h,0a4h,045h,0a5h,06bh	; a09b  ...g...(.]...E.k
	defb 0a5h,003h,0a6h,04dh,0a6h,0b5h,0a6h,0ffh,0a6h,091h,0a7h,017h,0a8h,040h,0a8h,0cch	; a0ab  ...M.........@..
	defb 0a8h,03ah,0a9h,07bh,0a9h,016h,0aah,0b1h,0aah,0fbh,0aah,01eh,0abh,0adh,0abh,057h	; a0bb  .:.{...........W
	defb 0ach,098h,0ach,0c1h,0ach,023h,0adh,097h,0adh,0d5h,0adh,01fh,0aeh,0c6h,0aeh,046h	; a0cb  .....#.........F
	defb 0afh,078h,0afh,00dh,0b0h,066h,0b0h,08fh,0b0h,0e5h,0b0h,032h,0b1h,070h,0b1h,023h	; a0db  .x...f.....2.p.#
	defb 0b2h,097h,0b2h,03bh,0b3h,02bh,000h,070h,0a5h,001h,081h,050h,001h,070h,075h,001h	; a0eb  ...;.+.p...P.pu.
	defb 084h,0a1h,001h,080h,0c5h,002h,060h,025h,002h,0a2h,050h,003h,070h,035h,003h,0a4h	; a0fb  ......`%..P.p5..
	defb 091h,004h,080h,025h,004h,080h,044h,004h,071h,090h,005h,080h,024h,005h,060h,065h	; a10b  ...%..D.q...$.`e
	defb 005h,076h,0c7h,008h,082h,030h,008h,080h,084h,009h,080h,046h,009h,080h,0c5h,00ah	; a11b  .v...0.....F....
	defb 096h,047h,00dh,096h,067h,00dh,070h,0a5h,00eh,0a4h,051h,00eh,084h,061h,00eh,060h	; a12b  .G..g.p...Q..a.`
	defb 075h,00fh,080h,015h,00fh,0a2h,040h,00fh,060h,0a5h,010h,090h,046h,011h,071h,040h	; a13b  u.....@.`...F.q@
	defb 012h,076h,067h,012h,060h,095h,012h,0a0h,066h,013h,091h,080h,015h,084h,031h,015h	; a14b  .vg.`...f.....1.
	defb 094h,051h,015h,0a4h,071h,015h,070h,074h,015h,070h,0b5h,016h,082h,020h,016h,080h	; a15b  .Q..q.pt.p... ..
	defb 046h,016h,080h,0c5h,017h,076h,0a7h,0ffh,012h,001h,081h,040h,001h,0a2h,040h,001h	; a16b  F....v.....@..@.
	defb 096h,0b7h,002h,076h,067h,003h,072h,050h,003h,084h,0b1h,003h,084h,0c1h,004h,071h	; a17b  ...vg.rP.......q
	defb 0c0h,005h,076h,0e7h,007h,0b6h,077h,008h,076h,077h,008h,074h,0c1h,009h,0a6h,077h	; a18b  ..v...w.vw.t...w
	defb 00ah,084h,021h,00ah,074h,031h,00bh,076h,067h,00bh,082h,080h,00ch,096h,0a7h,0ffh	; a19b  ..!.t1.vg.......
	defb 00dh,000h,092h,080h,001h,094h,031h,001h,092h,060h,001h,0a6h,097h,003h,0b6h,047h	; a1ab  ......1..`.....G
	defb 004h,0a6h,0b7h,007h,074h,031h,007h,074h,061h,007h,084h,081h,009h,066h,087h,00bh	; a1bb  ....t1.ta....f..
	defb 091h,040h,00ch,074h,0b1h,00dh,076h,027h,0ffh,01fh,000h,086h,087h,001h,060h,094h	; a1cb  .@.t..v'......`.
	defb 001h,082h,0b0h,002h,084h,051h,002h,074h,061h,002h,070h,094h,002h,0a6h,097h,004h	; a1db  .....Q.ta.p.....
	defb 071h,070h,005h,074h,081h,005h,090h,066h,006h,081h,0c0h,007h,084h,041h,007h,094h	; a1eb  qp.t...f.....A..
	defb 051h,007h,0a4h,061h,007h,076h,097h,008h,0a6h,0a7h,009h,060h,085h,00ah,070h,036h	; a1fb  Q..a.v.....`..p6
	defb 00ah,092h,030h,00bh,084h,031h,00bh,076h,097h,00dh,094h,031h,00dh,094h,051h,00dh	; a20b  ..0..1.v...1..Q.
	defb 094h,071h,00dh,076h,0e7h,00fh,060h,045h,00fh,080h,065h,011h,080h,056h,011h,0a1h	; a21b  .q.v..`E..e..V..
	defb 070h,012h,090h,056h,012h,076h,0e7h,0ffh,018h,001h,082h,040h,002h,081h,070h,004h	; a22b  p..V.v.....@..p.
	defb 076h,027h,005h,084h,081h,005h,094h,0a1h,005h,084h,0c1h,007h,084h,061h,007h,094h	; a23b  v'...........a..
	defb 071h,007h,0a4h,081h,008h,076h,077h,009h,082h,060h,00bh,076h,0e7h,00dh,074h,041h	; a24b  q....vw..`.v..tA
	defb 00dh,084h,051h,00dh,094h,061h,010h,094h,091h,010h,084h,0a1h,010h,074h,0b1h,013h	; a25b  ..Q..a.......t..
	defb 076h,017h,013h,081h,0a0h,014h,076h,0a7h,014h,091h,0b0h,016h,074h,021h,018h,066h	; a26b  v.....v.....t!.f
	defb 077h,0ffh,018h,003h,0a6h,037h,004h,080h,064h,004h,0a0h,0a4h,005h,092h,060h,007h	; a27b  w....7..d.....`.
	defb 0a6h,037h,00bh,096h,097h,00dh,086h,0c7h,00fh,090h,046h,00fh,0a0h,084h,013h,081h	; a28b  .7........F.....
	defb 070h,013h,092h,070h,015h,086h,067h,017h,082h,070h,018h,096h,097h,01ah,096h,0b7h	; a29b  p..p..g..p......
	defb 01fh,091h,030h,01fh,0c0h,016h,01fh,080h,095h,01fh,080h,0b5h,022h,0a0h,044h,023h	; a2ab  ..0.........".D#
	defb 096h,047h,023h,0a0h,036h,023h,080h,0b5h,024h,0b6h,067h,0ffh,013h,000h,096h,047h	; a2bb  .G#.6#..$.g....G
	defb 006h,084h,061h,006h,094h,071h,006h,0a4h,081h,00bh,096h,057h,00dh,074h,051h,00dh	; a2cb  ..a..q.....W.tQ.
	defb 084h,071h,00dh,094h,091h,01ah,076h,027h,01bh,096h,0c7h,020h,096h,077h,024h,076h	; a2db  .q....v'... .w$v
	defb 0c7h,02dh,082h,070h,031h,076h,0b7h,032h,0a6h,027h,033h,081h,050h,03ah,071h,070h	; a2eb  .-.p1v.2.'3.P:qp
	defb 03ch,076h,0a7h,03fh,072h,060h,0ffh,021h,000h,060h,075h,000h,090h,094h,001h,0a2h	; a2fb  <v.?r`.!.`u.....
	defb 020h,001h,060h,055h,001h,070h,0a5h,002h,090h,046h,002h,0b1h,070h,002h,074h,0b1h	; a30b   .`U.p...F..p.t.
	defb 002h,094h,0d1h,003h,060h,085h,003h,0a0h,094h,003h,071h,0c0h,004h,094h,081h,004h	; a31b  ....`.....q.....
	defb 084h,0a1h,005h,096h,027h,005h,060h,075h,005h,090h,094h,006h,080h,045h,006h,092h	; a32b  ....'.`u.....E..
	defb 080h,006h,0b4h,091h,008h,092h,090h,009h,076h,057h,009h,070h,0a5h,00ch,080h,045h	; a33b  ........vW.p...E
	defb 00ch,060h,0a5h,00ch,0a4h,0c1h,00ch,094h,0d1h,00dh,084h,031h,00dh,060h,065h,00dh	; a34b  .`.........1.`e.
	defb 0a0h,046h,00dh,086h,0c7h,00eh,060h,085h,00eh,090h,0a4h,0ffh,017h,001h,082h,070h	; a35b  .F....`........p
	defb 002h,094h,041h,003h,086h,0c7h,004h,0a1h,050h,004h,086h,0c7h,006h,0b6h,057h,007h	; a36b  ..A.....P.....W.
	defb 0b1h,0c0h,008h,084h,081h,008h,094h,091h,008h,0a4h,0a1h,009h,076h,0b7h,00ah,076h	; a37b  ............v..v
	defb 027h,00ah,094h,051h,00ah,084h,061h,00ah,074h,071h,00bh,0a6h,047h,00eh,096h,0a7h	; a38b  '..Q..a.tq..G...
	defb 00fh,076h,0b7h,010h,056h,0c7h,011h,092h,050h,011h,0a6h,0b7h,012h,074h,031h,012h	; a39b  .v..V...P....t1.
	defb 084h,041h,0ffh,028h,000h,0a6h,057h,001h,080h,044h,001h,084h,0a1h,002h,074h,081h	; a3ab  .A.(..W..D....t.
	defb 002h,084h,0a1h,002h,090h,046h,003h,076h,027h,003h,071h,060h,003h,060h,095h,004h	; a3bb  .....F.v'.q`.`..
	defb 084h,051h,004h,094h,061h,004h,0a4h,071h,004h,0a6h,0d7h,006h,084h,0d1h,007h,072h	; a3cb  .Q..a..q.......r
	defb 060h,008h,060h,065h,008h,090h,084h,009h,090h,034h,009h,090h,074h,00ch,0a6h,057h	; a3db  `.`e.....4..t..W
	defb 00dh,080h,056h,00dh,0b0h,056h,00dh,091h,080h,00fh,074h,021h,00fh,094h,041h,00fh	; a3eb  ..V..V....t!..A.
	defb 0a4h,061h,010h,0a6h,047h,011h,072h,0a0h,011h,090h,056h,012h,076h,0b7h,013h,080h	; a3fb  .a..G.r...V.v...
	defb 046h,013h,0a0h,046h,014h,084h,071h,014h,084h,081h,014h,084h,0a1h,015h,0a6h,027h	; a40b  F..F..q........'
	defb 015h,060h,085h,015h,080h,0a5h,016h,081h,090h,017h,0b6h,0b7h,0ffh,011h,001h,082h	; a41b  .`..............
	defb 060h,002h,0b4h,041h,002h,0b4h,051h,003h,086h,057h,005h,094h,041h,006h,071h,080h	; a42b  `..A..Q..W..A.q.
	defb 007h,0b4h,021h,00ah,096h,0c7h,00bh,096h,087h,00ch,0b4h,021h,00ch,0b4h,031h,00dh	; a43b  ..!........!..1.
	defb 081h,050h,00eh,0a6h,0c7h,00fh,086h,067h,010h,096h,0d7h,011h,0a4h,041h,011h,0a4h	; a44b  .P.....g.....A..
	defb 081h,0ffh,027h,001h,082h,030h,001h,0a6h,087h,002h,084h,031h,002h,060h,055h,002h	; a45b  ..'..0.....1.`U.
	defb 090h,074h,003h,076h,027h,003h,090h,056h,003h,081h,060h,003h,0a0h,094h,004h,060h	; a46b  .t.v'..V..`....`
	defb 065h,004h,080h,085h,005h,076h,027h,005h,0a4h,051h,005h,070h,066h,005h,0a1h,080h	; a47b  e....v'..Q.pf...
	defb 006h,0a6h,087h,007h,070h,075h,007h,0b0h,046h,007h,082h,0a0h,00bh,076h,017h,00bh	; a48b  ....pu..F....v..
	defb 080h,064h,00ch,090h,026h,00ch,072h,070h,00ch,090h,0a4h,00dh,080h,045h,00dh,080h	; a49b  .d..&.rp.....E..
	defb 066h,00dh,096h,077h,00dh,0a4h,0a1h,00fh,076h,017h,00fh,080h,044h,00fh,060h,085h	; a4ab  f..w....v...D.`.
	defb 010h,096h,077h,011h,060h,035h,011h,0a0h,046h,011h,081h,070h,012h,0a0h,016h,012h	; a4bb  ..w.`5..F..p....
	defb 080h,056h,012h,0a4h,0b1h,012h,0a4h,0d1h,0ffh,025h,001h,0a6h,0d7h,004h,0a2h,040h	; a4cb  .V.......%.....@
	defb 006h,096h,0c7h,007h,094h,041h,007h,0a4h,051h,007h,094h,081h,007h,0a4h,091h,008h	; a4db  .....A..Q.......
	defb 086h,057h,009h,071h,040h,00ah,076h,037h,00ah,080h,036h,00bh,0a6h,067h,00dh,080h	; a4eb  .W.q@.v7..6..g..
	defb 046h,00eh,060h,085h,00eh,0a0h,094h,011h,080h,084h,012h,090h,084h,013h,072h,030h	; a4fb  F.`...........r0
	defb 014h,081h,070h,015h,074h,061h,015h,084h,061h,015h,094h,061h,018h,090h,046h,01bh	; a50b  ..p.ta..a..a..F.
	defb 081h,080h,01ch,090h,046h,01eh,0a0h,044h,01eh,086h,087h,01fh,084h,041h,01fh,094h	; a51b  ....F..D.....A..
	defb 051h,01fh,0a4h,061h,020h,086h,0c7h,021h,080h,084h,023h,090h,056h,024h,0a4h,021h	; a52b  Q..a ..!..#.V$.!
	defb 024h,094h,041h,024h,082h,060h,025h,086h,087h,0ffh,00ch,002h,076h,047h,006h,076h	; a53b  $.A$.`%.....vG.v
	defb 0d7h,009h,0a6h,017h,01bh,076h,0c7h,01ch,0a6h,0c7h,01eh,076h,0b7h,02eh,076h,0e7h	; a54b  .....v.....v..v.
	defb 02fh,076h,0d7h,034h,076h,0b7h,039h,086h,027h,03ch,0a1h,090h,045h,082h,090h,0ffh	; a55b  /v.4v.9.'<..E...
	defb 032h,000h,082h,0a0h,001h,090h,036h,001h,080h,066h,002h,060h,045h,002h,080h,066h	; a56b  2.....6..f.`E..f
	defb 002h,074h,091h,002h,074h,0c1h,004h,080h,034h,004h,092h,090h,005h,086h,027h,005h	; a57b  .t..t...4.....'.
	defb 090h,026h,008h,060h,085h,008h,0a0h,066h,008h,081h,0d0h,009h,0a0h,026h,009h,090h	; a58b  .&.`...f.....&..
	defb 0a4h,009h,086h,0d7h,00ah,090h,024h,00ah,0a0h,066h,00dh,060h,075h,00dh,082h,050h	; a59b  ......$..f.`u..P
	defb 00dh,0a0h,066h,00dh,086h,0b7h,00fh,060h,045h,00fh,080h,085h,00fh,060h,0a5h,010h	; a5ab  ..f....`E....`..
	defb 070h,026h,010h,091h,040h,010h,080h,095h,012h,086h,057h,013h,080h,065h,013h,081h	; a5bb  p&..@.....W..e..
	defb 090h,013h,060h,0c5h,016h,076h,0c7h,018h,070h,024h,018h,0a4h,031h,018h,070h,065h	; a5cb  ..`..v..p$..1.pe
	defb 018h,090h,084h,018h,074h,091h,019h,086h,017h,01ah,090h,056h,01ch,090h,024h,01ch	; a5db  ....t......V..$.
	defb 082h,070h,01ch,090h,094h,01ch,086h,0c7h,01fh,070h,046h,01fh,091h,070h,01fh,0a0h	; a5eb  .p.......pF..p..
	defb 046h,021h,080h,046h,021h,0a0h,046h,0ffh,018h,000h,072h,0b0h,002h,071h,0c0h,003h	; a5fb  F!.F!.F...r..q..
	defb 082h,0b0h,004h,086h,047h,005h,084h,051h,005h,094h,061h,006h,094h,0b1h,006h,084h	; a60b  ....G..Q..a.....
	defb 0c1h,006h,074h,0d1h,008h,074h,031h,008h,084h,041h,008h,094h,051h,009h,076h,0a7h	; a61b  ..t..t1..A..Q.v.
	defb 009h,092h,0c0h,00ah,076h,0e7h,00bh,071h,060h,00bh,084h,081h,00bh,094h,0a1h,00bh	; a62b  ....v..q`.......
	defb 0a4h,0c1h,00ch,076h,0d7h,00eh,076h,047h,00fh,074h,031h,00fh,084h,051h,00fh,086h	; a63b  ...v..vG.t1..Q..
	defb 0a7h,0ffh,022h,000h,086h,0c7h,001h,070h,034h,001h,090h,084h,001h,0a2h,050h,001h	; a64b  .."....p4.....P.
	defb 071h,090h,002h,090h,044h,002h,070h,084h,002h,074h,061h,002h,0a4h,091h,004h,074h	; a65b  q...D.p..ta....t
	defb 051h,004h,080h,075h,004h,060h,095h,006h,080h,066h,007h,082h,030h,008h,070h,036h	; a66b  Q..u.`...f..0.p6
	defb 008h,086h,097h,00ah,086h,0c7h,00bh,076h,037h,00bh,060h,055h,00bh,090h,074h,00bh	; a67b  .......v7.`U..t.
	defb 071h,080h,00ch,080h,046h,00ch,0b0h,046h,00ch,0a4h,071h,00ch,076h,0d7h,00dh,076h	; a68b  q...F..F..q.v..v
	defb 087h,00eh,080h,056h,00eh,0a0h,056h,00eh,074h,091h,00fh,082h,050h,00fh,0b6h,067h	; a69b  ...V..V.t...P..g
	defb 010h,090h,044h,010h,060h,085h,010h,081h,0c0h,0ffh,018h,000h,066h,077h,001h,066h	; a6ab  ..D.`.......fw.f
	defb 077h,001h,064h,0a1h,001h,0c4h,051h,002h,096h,0d7h,003h,091h,060h,004h,096h,027h	; a6bb  w.d...Q.....`..'
	defb 005h,0a4h,061h,005h,0a4h,081h,007h,086h,057h,008h,094h,021h,008h,0a4h,031h,008h	; a6cb  ..a.....W..!..1.
	defb 0a1h,050h,008h,0b4h,041h,009h,070h,034h,00ah,0a4h,041h,00ah,066h,0c7h,00bh,0b6h	; a6db  .P..A.p4..A.f...
	defb 0b7h,00ch,096h,087h,00eh,072h,0a0h,00fh,096h,077h,010h,094h,031h,010h,060h,065h	; a6eb  .....r...w..1.`e
	defb 010h,0a0h,074h,0ffh,030h,001h,091h,040h,001h,060h,0a5h,002h,094h,021h,002h,084h	; a6fb  ..t.0..@.`...!..
	defb 031h,002h,074h,041h,002h,0a6h,067h,003h,072h,040h,003h,080h,0b5h,004h,084h,021h	; a70b  1.tA..g.r@.....!
	defb 004h,094h,031h,004h,0a4h,041h,004h,080h,084h,005h,0a6h,0b7h,006h,070h,036h,006h	; a71b  ..1..A.......p6.
	defb 082h,050h,007h,082h,020h,007h,070h,085h,007h,0a4h,0b1h,007h,084h,0c1h,008h,076h	; a72b  .P.. .p........v
	defb 097h,009h,070h,026h,009h,080h,0a4h,00ah,080h,044h,00ah,084h,0b1h,00ah,074h,0c1h	; a73b  ..p&.....D....t.
	defb 00dh,080h,066h,00dh,0a0h,066h,00eh,080h,064h,00eh,060h,0a5h,00fh,074h,011h,00fh	; a74b  ..f..f..d.`..t..
	defb 084h,021h,00fh,094h,031h,00fh,081h,0a0h,010h,076h,027h,010h,0a0h,036h,010h,070h	; a75b  .!..1....v'..6.p
	defb 066h,011h,094h,0c1h,011h,084h,0d1h,011h,074h,0e1h,012h,081h,040h,012h,060h,085h	; a76b  f.......t...@.`.
	defb 012h,0a0h,0a4h,014h,070h,056h,014h,0a4h,0a1h,014h,094h,0b1h,014h,084h,0c1h,015h	; a77b  ....pV..........
	defb 060h,035h,015h,080h,054h,0ffh,02ch,002h,094h,041h,002h,0a4h,061h,003h,090h,056h	; a78b  `5..T.,..A..a..V
	defb 004h,0a0h,036h,006h,090h,044h,007h,096h,097h,00ah,0a6h,027h,00bh,092h,070h,00dh	; a79b  ..6..D.....'..p.
	defb 081h,050h,00eh,080h,046h,00fh,076h,027h,010h,072h,050h,010h,090h,0a4h,011h,084h	; a7ab  .P..F.v'.rP.....
	defb 031h,011h,094h,041h,011h,0a4h,051h,011h,060h,095h,013h,086h,097h,015h,0a0h,056h	; a7bb  1..A..Q.`......V
	defb 015h,076h,0a7h,015h,060h,0b5h,016h,060h,075h,016h,090h,094h,017h,081h,030h,01ah	; a7cb  .v..`..`u.....0.
	defb 090h,026h,01ah,060h,0a5h,01ch,090h,084h,01dh,080h,044h,01dh,0a0h,084h,01fh,074h	; a7db  .&.`......D....t
	defb 021h,01fh,094h,021h,01fh,0a4h,041h,021h,090h,044h,021h,0a2h,0c0h,022h,0b0h,026h	; a7eb  !..!..A!.D!..".&
	defb 022h,096h,0c7h,024h,096h,0c7h,025h,0b6h,037h,025h,0b4h,071h,025h,0a4h,091h,025h	; a7fb  "..$..%.7%.q%..%
	defb 094h,0b1h,027h,0a0h,064h,028h,090h,044h,02ah,096h,0a7h,0ffh,00dh,007h,076h,0a7h	; a80b  ..'.d(.D*.....v.
	defb 00dh,0a6h,0d7h,015h,076h,0a7h,019h,076h,0a7h,01dh,0a6h,097h,021h,0a6h,0b7h,024h	; a81b  ....v..v....!..$
	defb 076h,0b7h,039h,086h,037h,03ch,076h,0d7h,042h,071h,060h,042h,086h,0e7h,049h,082h	; a82b  v.9.7<v.Bq`B..I.
	defb 090h,04bh,060h,085h,0ffh,02eh,000h,076h,067h,001h,060h,035h,001h,071h,090h,002h	; a83b  .K`....vg.`5.q..
	defb 0a0h,044h,002h,060h,085h,003h,0a6h,037h,004h,094h,091h,004h,074h,0a1h,005h,070h	; a84b  .D.`...7....t..p
	defb 036h,006h,074h,041h,006h,084h,061h,006h,094h,081h,006h,0a4h,0a1h,007h,0a6h,027h	; a85b  6.tA..a........'
	defb 007h,080h,045h,007h,080h,066h,007h,0a4h,091h,007h,0a4h,0c1h,008h,084h,091h,008h	; a86b  ..E..f..........
	defb 074h,0b1h,009h,080h,024h,00ah,076h,087h,00bh,094h,021h,00bh,090h,046h,00bh,060h	; a87b  t...$.v...!..F.`
	defb 0c5h,00ch,081h,070h,00dh,076h,027h,00eh,070h,066h,00eh,0a0h,066h,00fh,072h,020h	; a88b  ...p.v'.pf..f.r
	defb 010h,084h,021h,010h,080h,054h,010h,060h,095h,011h,072h,040h,011h,0a6h,0b7h,012h	; a89b  ..!..T.`..r@....
	defb 0a6h,0d7h,013h,0a4h,031h,013h,082h,080h,015h,076h,047h,016h,076h,087h,017h,090h	; a8ab  ....1....vG.v...
	defb 024h,017h,080h,064h,017h,0a0h,0a4h,018h,081h,050h,019h,060h,044h,019h,080h,084h	; a8bb  $..d.....P.`D...
	defb 0ffh,024h,000h,066h,067h,000h,080h,066h,000h,0a0h,046h,001h,080h,036h,001h,0a2h	; a8cb  .$.fg..f..F..6..
	defb 0c0h,002h,080h,026h,002h,0a1h,070h,003h,060h,035h,003h,090h,056h,004h,074h,021h	; a8db  ...&..p.`5..V.t!
	defb 004h,060h,055h,004h,080h,075h,004h,094h,0b1h,004h,0a4h,0c1h,005h,066h,077h,005h	; a8eb  .`U..u.......fw.
	defb 080h,026h,005h,0b0h,046h,006h,090h,056h,006h,076h,0c7h,007h,060h,025h,007h,080h	; a8fb  .&..F..V.v..`%..
	defb 065h,007h,076h,087h,007h,060h,0a5h,00ah,076h,0c7h,00bh,070h,035h,00bh,091h,070h	; a90b  e.v..`..v..p5..p
	defb 00bh,070h,0b5h,00dh,070h,035h,00dh,090h,054h,00dh,074h,061h,00dh,094h,0a1h,00eh	; a91b  .p..p5..T.ta....
	defb 096h,057h,00eh,060h,074h,00eh,080h,074h,00eh,080h,0b5h,00fh,080h,056h,0ffh,015h	; a92b  .W.`t..t.....V..
	defb 001h,0a4h,0b1h,002h,066h,077h,004h,0b6h,087h,005h,074h,0b1h,006h,0a6h,0a7h,006h	; a93b  ....fw....t.....
	defb 094h,0c1h,007h,0a6h,0a7h,008h,096h,037h,009h,096h,057h,00bh,0a2h,060h,00ch,084h	; a94b  .......7..W..`..
	defb 011h,00ch,094h,021h,00ch,0a4h,031h,00ch,086h,0a7h,00eh,0a6h,037h,00eh,084h,0c1h	; a95b  ...!..1.....7...
	defb 011h,076h,0c7h,012h,074h,031h,012h,071h,060h,013h,076h,0c7h,014h,064h,091h,0ffh	; a96b  .v..t1.q`.v..d..
	defb 033h,000h,0a6h,0a7h,001h,076h,0b7h,002h,0b6h,037h,002h,0a1h,050h,003h,080h,064h	; a97b  3....v...7..P..d
	defb 003h,060h,084h,003h,080h,0a5h,004h,080h,046h,006h,0b4h,0a1h,006h,094h,0b1h,006h	; a98b  .`......F.......
	defb 074h,0c1h,007h,076h,027h,007h,090h,094h,008h,074h,041h,00ah,076h,067h,00ah,0a4h	; a99b  t..v'....tA.vg..
	defb 071h,00ah,094h,091h,00ah,084h,0b1h,00bh,0a6h,0b7h,00ch,070h,075h,00dh,080h,044h	; a9ab  q..........pu..D
	defb 00eh,0a0h,064h,00eh,080h,0a4h,00fh,084h,041h,010h,096h,0b7h,011h,084h,071h,011h	; a9bb  ..d.....A.....q.
	defb 0a4h,071h,011h,081h,0a0h,011h,0b6h,0c7h,012h,060h,075h,013h,060h,024h,013h,060h	; a9cb  .q.......`u.`$.`
	defb 065h,014h,092h,080h,015h,084h,051h,015h,094h,061h,015h,0a4h,071h,016h,0a6h,0d7h	; a9db  e.....Q..a..q...
	defb 017h,080h,046h,017h,0b0h,046h,018h,092h,0b0h,019h,084h,021h,019h,094h,041h,019h	; a9eb  ..F..F.....!..A.
	defb 0a4h,061h,01ah,091h,090h,01bh,080h,035h,01bh,080h,056h,01bh,076h,0c7h,01ch,092h	; a9fb  .a.....5..V.v...
	defb 080h,01dh,084h,021h,01dh,094h,041h,01dh,0a4h,061h,0ffh,034h,000h,070h,075h,001h	; aa0b  ...!..A..a.4.pu.
	defb 074h,031h,001h,064h,041h,001h,064h,071h,001h,080h,026h,001h,070h,0a5h,002h,080h	; aa1b  t1.dA.dq..&.p...
	defb 056h,003h,070h,046h,003h,0a0h,046h,003h,082h,060h,004h,060h,025h,004h,080h,046h	; aa2b  V.pF..F..`.`%..F
	defb 005h,076h,017h,006h,076h,057h,007h,090h,046h,00bh,080h,026h,00bh,090h,064h,00bh	; aa3b  .v..vW..F..&..d.
	defb 070h,0a5h,00ch,090h,044h,00ch,060h,085h,00ch,082h,050h,00eh,060h,025h,00eh,090h	; aa4b  p...D.`...P.`%..
	defb 046h,00eh,071h,070h,00eh,076h,0a7h,00fh,076h,017h,010h,076h,057h,011h,060h,035h	; aa5b  F.qp.v..v..vW.`5
	defb 011h,080h,054h,011h,080h,095h,011h,071h,070h,012h,0a4h,071h,012h,094h,081h,012h	; aa6b  ..T....qp..q....
	defb 084h,091h,013h,060h,025h,013h,090h,046h,014h,070h,095h,017h,0a0h,036h,017h,070h	; aa7b  ...`%..F.p...6.p
	defb 0b5h,018h,0a6h,027h,018h,081h,070h,019h,0a6h,0c7h,01ah,076h,057h,01bh,080h,016h	; aa8b  ...'..p....vW...
	defb 01bh,060h,095h,01bh,062h,050h,01bh,0a6h,037h,01ch,060h,0b5h,01ch,090h,074h,01dh	; aa9b  .`..bP..7.`...t.
	defb 092h,030h,01dh,076h,097h,0ffh,018h,003h,0a0h,046h,008h,080h,024h,008h,0a0h,064h	; aaab  .0.v.....F..$..d
	defb 009h,096h,057h,00bh,0a6h,087h,00ch,0a6h,037h,00eh,076h,027h,00eh,080h,025h,00eh	; aabb  ..W.....7.v'..%.
	defb 060h,044h,00eh,060h,084h,013h,080h,044h,013h,080h,085h,015h,076h,067h,016h,086h	; aacb  `D.`...D....vg..
	defb 0d7h,017h,080h,024h,017h,060h,064h,017h,0a0h,064h,017h,076h,0a7h,019h,0a6h,097h	; aadb  ...$.`d..d.v....
	defb 01ch,096h,0c7h,01eh,0a0h,036h,020h,090h,046h,020h,0c0h,046h,023h,096h,0c7h,0ffh	; aaeb  .....6 .F .F#...
	defb 00bh,001h,076h,097h,007h,096h,0d7h,00bh,0a6h,027h,023h,076h,057h,024h,076h,057h	; aafb  ..v......'#vW$vW
	defb 028h,0a6h,037h,02bh,076h,047h,02ch,0a6h,097h,03ah,072h,060h,03eh,061h,060h,041h	; ab0b  (.7+vG,..:r`>a`A
	defb 076h,0a7h,0ffh,030h,001h,081h,080h,002h,060h,0b5h,003h,0a6h,047h,003h,094h,0a1h	; ab1b  v..0....`...G...
	defb 003h,084h,0b1h,003h,074h,0c1h,004h,060h,065h,005h,076h,027h,008h,082h,030h,009h	; ab2b  ....t..`e.v'..0.
	defb 076h,0b7h,00ch,076h,0c7h,00dh,071h,070h,00dh,080h,046h,00dh,0a0h,046h,00eh,0a0h	; ab3b  v..v..qp..F..F..
	defb 044h,00eh,060h,085h,00fh,074h,021h,00fh,084h,031h,00fh,072h,070h,00fh,076h,0e7h	; ab4b  D.`..t!..1.rp.v.
	defb 010h,0a0h,044h,010h,080h,084h,011h,076h,0b7h,012h,072h,090h,013h,090h,036h,013h	; ab5b  ..D....v..r...6.
	defb 070h,084h,014h,060h,025h,014h,090h,046h,015h,074h,041h,015h,074h,051h,015h,094h	; ab6b  p..`%..F.tA.tQ..
	defb 061h,015h,094h,071h,016h,094h,081h,016h,084h,091h,016h,074h,0a1h,016h,076h,0d7h	; ab7b  a..q.......t..v.
	defb 017h,070h,026h,017h,0a0h,066h,018h,081h,040h,018h,0a6h,0d7h,01ah,094h,0a1h,01bh	; ab8b  .p&..f..@.......
	defb 076h,017h,01bh,0a0h,036h,01bh,060h,075h,01ch,0a2h,030h,01ch,080h,084h,01dh,086h	; ab9b  v...6.`u..0.....
	defb 047h,0ffh,038h,000h,0a6h,067h,001h,060h,035h,001h,080h,075h,001h,071h,080h,001h	; abab  G.8..g.`5..u.q..
	defb 060h,0c5h,002h,090h,046h,002h,060h,0c5h,002h,0b2h,060h,003h,060h,025h,003h,072h	; abbb  `...F.`...`.`%.r
	defb 0c0h,004h,070h,054h,004h,070h,095h,005h,084h,051h,005h,0a4h,051h,005h,0a4h,081h	; abcb  ..pT.p...Q..Q...
	defb 005h,076h,0a7h,006h,060h,025h,006h,080h,046h,006h,071h,060h,006h,074h,0a1h,006h	; abdb  .v..`%..F.q`.t..
	defb 070h,0c5h,007h,0a6h,0a7h,008h,070h,076h,008h,082h,090h,008h,0a0h,076h,009h,0a6h	; abeb  p.....pv.....v..
	defb 027h,009h,080h,046h,009h,0a1h,0d0h,00ah,060h,035h,00ah,0a0h,036h,00ah,076h,0a7h	; abfb  '..F....`5..6.v.
	defb 00ch,0a6h,067h,00ch,060h,0a5h,00dh,071h,050h,00dh,080h,036h,00dh,0b0h,076h,00eh	; ac0b  ..g.`..qP..6..v.
	defb 0a6h,0a7h,00fh,060h,025h,00fh,090h,046h,00fh,080h,0c5h,010h,070h,055h,010h,082h	; ac1b  ...`%..F....pU..
	defb 080h,010h,091h,080h,012h,064h,061h,012h,074h,081h,012h,080h,066h,012h,094h,0a1h	; ac2b  .....da.t...f...
	defb 013h,060h,075h,013h,0a0h,036h,013h,076h,0c7h,015h,080h,044h,015h,0b2h,050h,015h	; ac3b  .`u..6.v...D..P.
	defb 086h,0b7h,016h,076h,0c7h,017h,060h,045h,017h,0a0h,026h,0ffh,015h,001h,072h,050h	; ac4b  ...v..`E..&...rP
	defb 001h,084h,0b1h,002h,086h,087h,002h,074h,0c1h,005h,081h,030h,005h,096h,0a7h,007h	; ac5b  .......t...0....
	defb 072h,050h,008h,074h,051h,008h,084h,061h,008h,094h,071h,009h,074h,031h,009h,084h	; ac6b  rP.tQ..a..q.t1..
	defb 041h,009h,094h,051h,00ah,096h,0d7h,00ch,081h,070h,00dh,076h,027h,00eh,074h,061h	; ac7b  A..Q.....p.v'.ta
	defb 00fh,086h,027h,010h,072h,090h,010h,096h,0d7h,014h,074h,061h,0ffh,00dh,001h,092h	; ac8b  ..'.r.....ta....
	defb 050h,002h,076h,0b7h,003h,0a1h,060h,003h,0a4h,091h,003h,0a4h,0b1h,005h,096h,087h	; ac9b  P.v...`.........
	defb 006h,074h,0c1h,007h,061h,050h,007h,086h,057h,008h,0a6h,047h,00ah,096h,067h,00bh	; acab  .t..aP..W..G..g.
	defb 094h,021h,00ch,056h,0c7h,0ffh,020h,001h,076h,087h,001h,084h,061h,001h,0a0h,056h	; acbb  .!.V.. .v...a..V
	defb 002h,072h,070h,002h,080h,046h,003h,0a6h,047h,003h,070h,066h,003h,0a0h,066h,003h	; accb  .rp..F..G.pf..f.
	defb 091h,080h,004h,080h,046h,006h,0a6h,057h,007h,0a6h,0d7h,008h,080h,036h,008h,0a2h	; acdb  ....F..W.....6..
	defb 050h,008h,080h,0b5h,009h,0a6h,037h,00ah,084h,051h,00ah,0a4h,041h,00ah,070h,066h	; aceb  P.....7..Q..A.pf
	defb 00ah,080h,065h,00ah,092h,0a0h,00bh,076h,087h,00ch,080h,046h,00ch,0a1h,050h,00ch	; acfb  ..e....v...F..P.
	defb 0a6h,0d7h,00eh,080h,035h,00eh,076h,047h,00eh,090h,056h,010h,080h,036h,010h,0a1h	; ad0b  ....5.vG..V..6..
	defb 050h,010h,080h,0b5h,011h,080h,034h,0ffh,026h,002h,0a4h,081h,002h,0a4h,0a1h,003h	; ad1b  P.....4.&.......
	defb 080h,044h,007h,096h,077h,008h,0a6h,037h,00ah,060h,035h,00ah,090h,056h,00dh,080h	; ad2b  .D..w..7.`5..V..
	defb 064h,00eh,090h,056h,011h,070h,036h,012h,090h,084h,013h,080h,034h,013h,0a4h,041h	; ad3b  d..V.p6.....4..A
	defb 013h,0a4h,061h,015h,086h,0c7h,017h,090h,046h,018h,094h,041h,018h,084h,061h,018h	; ad4b  ..a.....F..A..a.
	defb 094h,0a1h,019h,094h,041h,01bh,0a6h,0a7h,01dh,0a6h,0c7h,01eh,080h,036h,01eh,090h	; ad5b  ....A........6..
	defb 045h,01eh,090h,065h,01eh,0b6h,0a7h,021h,0a0h,046h,022h,080h,065h,022h,080h,085h	; ad6b  E..e...!.F".e"..
	defb 022h,0b0h,0a4h,022h,096h,0c7h,023h,0a0h,056h,024h,080h,044h,024h,094h,091h,024h	; ad7b  ".."..#.V$.D$..$
	defb 0a4h,0b1h,024h,0b6h,0e7h,024h,0b0h,094h,025h,096h,087h,0ffh,014h,000h,076h,0a7h	; ad8b  ..$..$..%.....v.
	defb 002h,0a6h,047h,006h,076h,097h,01eh,076h,057h,01fh,0a6h,0b7h,021h,076h,0c7h,023h	; ad9b  ..G.v..vW...!v.#
	defb 076h,0c7h,029h,076h,0c7h,02ch,076h,0d7h,02eh,094h,041h,02fh,084h,021h,02fh,0a4h	; adab  v.)v.,v...A/.!/.
	defb 041h,02fh,0a4h,071h,03eh,060h,055h,03fh,0a6h,0c7h,040h,060h,0a5h,041h,074h,091h	; adbb  A/.q>`U?..@`.At.
	defb 041h,084h,0a1h,041h,094h,0b1h,044h,072h,080h,0ffh,018h,001h,096h,027h,001h,092h	; adcb  A..A..Dr.....'..
	defb 090h,002h,0a6h,047h,002h,074h,071h,004h,074h,071h,004h,064h,091h,005h,0a6h,0a7h	; addb  ...G.tq.tq.d....
	defb 006h,094h,081h,006h,086h,0b7h,007h,081h,0a0h,008h,074h,031h,00ch,096h,0b7h,00dh	; adeb  ..........t1....
	defb 096h,0e7h,00eh,081h,080h,00eh,056h,0d7h,00fh,0a4h,031h,00fh,0a4h,051h,010h,0a6h	; adfb  ......V...1..Q..
	defb 097h,013h,066h,027h,014h,0a2h,040h,014h,0b4h,081h,014h,0a4h,0b1h,015h,086h,057h	; ae0b  ..f'..@........W
	defb 015h,084h,081h,0ffh,037h,000h,086h,057h,000h,090h,066h,000h,081h,090h,001h,080h	; ae1b  ....7..W..f.....
	defb 056h,001h,0a2h,0a0h,002h,070h,055h,002h,074h,081h,002h,0a4h,081h,002h,070h,0a5h	; ae2b  V....pU.t.....p.
	defb 003h,096h,037h,004h,080h,026h,004h,092h,050h,004h,0a0h,066h,006h,080h,074h,006h	; ae3b  ..7..&..P..f..t.
	defb 080h,0b5h,007h,0a6h,0a7h,008h,060h,045h,008h,080h,064h,009h,080h,035h,009h,090h	; ae4b  ......`E..d..5..
	defb 056h,00ch,060h,065h,00ch,081h,090h,00ch,080h,0a5h,00dh,066h,027h,00fh,060h,055h	; ae5b  V.`e.......f'.`U
	defb 00fh,060h,075h,00fh,060h,095h,00fh,0a2h,070h,012h,0b4h,051h,012h,094h,061h,012h	; ae6b  .`u.`...p..Q..a.
	defb 074h,071h,012h,066h,0d7h,013h,071h,060h,013h,090h,026h,013h,060h,0a5h,014h,066h	; ae7b  tq.f..q`..&.`..f
	defb 027h,016h,066h,0d7h,016h,080h,066h,017h,080h,026h,017h,0a1h,0a0h,01bh,071h,070h	; ae8b  '.f...f..&....qp
	defb 01bh,090h,056h,01dh,080h,036h,01dh,090h,076h,01dh,0a2h,070h,01eh,060h,065h,01eh	; ae9b  ..V..6..v..p.`e.
	defb 0a0h,036h,01eh,082h,080h,01fh,060h,045h,01fh,080h,064h,01fh,080h,0a5h,01fh,084h	; aeab  .6....`E..d.....
	defb 0d1h,01fh,0a4h,0d1h,021h,080h,056h,021h,0a0h,026h,0ffh,02ah,000h,071h,0c0h,001h	; aebb  ....!.V!.&.*.q..
	defb 060h,065h,001h,076h,097h,002h,070h,036h,004h,076h,087h,004h,090h,094h,005h,074h	; aecb  `e.v..p6.v.....t
	defb 031h,005h,084h,041h,005h,094h,051h,005h,0a6h,087h,007h,076h,0d7h,008h,072h,030h	; aedb  1..A..Q....v..r0
	defb 008h,076h,0b7h,00ah,080h,056h,00ah,0a2h,070h,00bh,080h,056h,00ch,074h,0b1h,00ch	; aeeb  .v...V..p..V.t..
	defb 084h,0c1h,00ch,094h,0d1h,00dh,076h,0c7h,00eh,071h,050h,00eh,090h,084h,00fh,086h	; aefb  ......v..qP.....
	defb 0b7h,010h,0a6h,027h,010h,080h,066h,011h,082h,0b0h,012h,060h,044h,012h,080h,044h	; af0b  ...'..f....`D..D
	defb 013h,0a6h,027h,013h,081h,080h,014h,090h,044h,016h,0a6h,057h,017h,081h,040h,018h	; af1b  ..'.....D..W..@.
	defb 0a0h,034h,018h,060h,075h,019h,084h,041h,019h,094h,061h,01ah,0a4h,081h,01ah,094h	; af2b  .4.`u..A..a.....
	defb 091h,01ah,084h,0a1h,01bh,076h,0c7h,01ch,090h,066h,0ffh,010h,000h,0a2h,0b0h,001h	; af3b  .....v...f......
	defb 0b6h,057h,002h,0a1h,060h,002h,096h,0c7h,004h,0b4h,041h,004h,0a4h,061h,006h,0b6h	; af4b  .W..`.....A..a..
	defb 057h,008h,096h,087h,009h,074h,091h,009h,064h,0a1h,009h,076h,0d7h,00ch,076h,067h	; af5b  W....t..d..v..vg
	defb 00ch,062h,080h,00eh,086h,0b7h,00fh,074h,0b1h,010h,056h,0d7h,0ffh,031h,000h,0a6h	; af6b  .b.....t..V..1..
	defb 047h,000h,084h,0a1h,000h,074h,0c1h,000h,0a4h,0c1h,001h,080h,034h,001h,080h,074h	; af7b  G....t......4..t
	defb 001h,0a2h,040h,003h,060h,045h,003h,080h,065h,003h,071h,080h,004h,080h,046h,004h	; af8b  ..@.`E..e.q...F.
	defb 0a6h,097h,005h,066h,0a7h,006h,0a6h,0d7h,007h,090h,036h,008h,060h,035h,008h,090h	; af9b  ...f......6.`5..
	defb 056h,00ah,0a6h,047h,00bh,060h,035h,00bh,080h,056h,00bh,092h,070h,00dh,070h,045h	; afab  V..G.`5..V..p.pE
	defb 00dh,080h,064h,00eh,080h,056h,00eh,0a1h,080h,010h,066h,0c7h,011h,070h,035h,011h	; afbb  ..d..V....f..p5.
	defb 070h,0b5h,012h,080h,036h,013h,080h,025h,013h,080h,046h,013h,0a2h,060h,015h,080h	; afcb  p...6..%..F..`..
	defb 026h,015h,0a4h,041h,017h,080h,054h,017h,060h,095h,018h,090h,034h,018h,080h,075h	; afdb  &..A..T.`...4..u
	defb 018h,072h,060h,019h,080h,026h,019h,0a6h,0b7h,01ah,066h,0c7h,01bh,060h,065h,01bh	; afeb  .r`..&....f..`e.
	defb 080h,084h,01dh,060h,035h,01dh,080h,055h,01dh,074h,081h,01dh,084h,091h,01dh,094h	; affb  ...`5..U.t......
	defb 0a1h,0ffh,01dh,003h,096h,057h,007h,0a1h,050h,00ch,076h,0c7h,00eh,081h,090h,015h	; b00b  .....W..P.v.....
	defb 076h,017h,015h,082h,0a0h,016h,090h,094h,01ah,090h,054h,01ah,090h,094h,01bh,084h	; b01b  v.........T.....
	defb 061h,01bh,084h,081h,01bh,084h,0a1h,01ch,082h,070h,01dh,080h,026h,01dh,090h,084h	; b02b  a........p..&...
	defb 01fh,076h,087h,021h,0a0h,036h,022h,096h,0d7h,024h,0b4h,0a1h,024h,094h,0b1h,025h	; b03b  .v.!.6"..$..$..%
	defb 096h,017h,025h,0b0h,056h,027h,0a0h,026h,027h,080h,0a5h,027h,0b6h,0d7h,028h,096h	; b04b  ..%.V'.&'..'..(.
	defb 017h,029h,080h,065h,029h,0a0h,084h,02bh,096h,067h,0ffh,00dh,004h,076h,027h,007h	; b05b  .).e)..+.g...v'.
	defb 076h,027h,00ah,0a6h,0d7h,00eh,086h,0c7h,011h,076h,017h,01bh,076h,0d7h,021h,086h	; b06b  v'.......v..v.!.
	defb 0a7h,023h,076h,087h,024h,096h,0d7h,026h,066h,0a7h,03ch,076h,0b7h,03eh,061h,060h	; b07b  .#v.$..&f.<v.>a`
	defb 040h,062h,0a0h,0ffh,01ch,000h,082h,0b0h,001h,081h,0a0h,004h,092h,0a0h,006h,074h	; b08b  @b.............t
	defb 091h,006h,084h,0b1h,007h,086h,047h,008h,082h,050h,009h,076h,027h,00ah,074h,051h	; b09b  ......G..P.v'.tQ
	defb 00ah,094h,061h,00ah,0b4h,071h,00ch,0a4h,081h,00ch,084h,091h,00ch,094h,0b1h,00ch	; b0ab  ..a..q..........
	defb 074h,0c1h,00dh,081h,060h,00fh,084h,061h,010h,076h,087h,011h,074h,031h,011h,096h	; b0bb  t...`..a.v..t1..
	defb 077h,013h,084h,031h,013h,094h,061h,013h,084h,081h,014h,076h,0e7h,015h,082h,040h	; b0cb  w..1..a....v...@
	defb 016h,081h,090h,017h,086h,027h,017h,084h,051h,0ffh,019h,000h,071h,070h,000h,080h	; b0db  .....'..Q...qp..
	defb 064h,001h,090h,036h,001h,072h,070h,001h,0a1h,070h,002h,0a6h,037h,002h,080h,0b5h	; b0eb  d..6.rp..p..7...
	defb 003h,082h,0b0h,004h,0a6h,027h,004h,060h,0a5h,004h,080h,0c5h,006h,060h,015h,006h	; b0fb  .....'.`.....`..
	defb 091h,050h,006h,0a6h,0d7h,007h,082h,030h,008h,066h,067h,009h,0a6h,027h,00ch,060h	; b10b  .P.....0.fg..'.`
	defb 065h,00ch,071h,090h,00ch,080h,0a5h,00dh,070h,044h,00dh,090h,046h,00dh,074h,0a1h	; b11b  e.q.....pD..F.t.
	defb 00dh,0b4h,051h,00dh,096h,0d7h,0ffh,014h,001h,0a6h,0b7h,004h,096h,0b7h,005h,086h	; b12b  ..Q.............
	defb 0a7h,005h,081h,0c0h,006h,0b6h,027h,006h,094h,0b1h,008h,086h,047h,009h,094h,071h	; b13b  ......'.....G..q
	defb 009h,0b6h,0d7h,00ah,072h,0a0h,00bh,056h,017h,00eh,094h,081h,00fh,066h,017h,011h	; b14b  ....r..V.....f..
	defb 0a6h,027h,011h,074h,0c1h,012h,084h,041h,012h,071h,050h,012h,076h,097h,015h,084h	; b15b  .'.t...A.qP.v...
	defb 061h,015h,084h,081h,0ffh,03bh,001h,086h,027h,001h,092h,080h,002h,060h,025h,002h	; b16b  a....;..'....`%.
	defb 0a0h,044h,002h,0b6h,0c7h,003h,060h,095h,003h,060h,0b5h,003h,0a0h,094h,003h,074h	; b17b  .D....`..`.....t
	defb 0e1h,003h,094h,0e1h,003h,0b4h,0e1h,004h,081h,090h,005h,080h,046h,006h,072h,070h	; b18b  ............F.rp
	defb 006h,090h,056h,008h,0a6h,027h,00ah,076h,067h,00bh,060h,075h,00bh,084h,0b1h,00bh	; b19b  ..V..'.vg.`u....
	defb 094h,0c1h,00ch,086h,027h,00ch,060h,085h,00ch,092h,0c0h,00dh,060h,065h,00dh,060h	; b1ab  ....'.`.....`e.`
	defb 085h,00fh,074h,041h,00fh,084h,051h,00fh,0a6h,0a7h,010h,0a4h,071h,010h,094h,081h	; b1bb  ..tA..Q.....q...
	defb 010h,084h,091h,011h,084h,041h,011h,094h,051h,011h,0a4h,061h,012h,094h,0b1h,012h	; b1cb  .....A..Q..a....
	defb 084h,0c1h,013h,090h,046h,014h,081h,060h,015h,076h,0c7h,016h,090h,066h,017h,0a0h	; b1db  ....F..`.v...f..
	defb 044h,017h,090h,066h,018h,071h,060h,018h,080h,084h,019h,076h,027h,01ah,090h,046h	; b1eb  D..f.q`....v'..F
	defb 01ah,060h,0c5h,01bh,076h,0a7h,01ch,094h,091h,01ch,084h,0b1h,01dh,090h,044h,01dh	; b1fb  .`..v.........D.
	defb 076h,0c7h,01eh,090h,036h,01fh,090h,056h,01fh,074h,071h,01fh,084h,091h,020h,060h	; b20b  v...6..V.tq... `
	defb 055h,020h,080h,074h,020h,0a2h,070h,0ffh,026h,000h,086h,0c7h,001h,071h,070h,001h	; b21b  U .t .p.&....qp.
	defb 090h,036h,002h,080h,034h,004h,080h,034h,004h,072h,0a0h,004h,090h,0a4h,005h,0a6h	; b22b  .6..4..4.r......
	defb 037h,007h,080h,046h,008h,082h,040h,009h,060h,055h,009h,080h,0b5h,00bh,066h,097h	; b23b  7..F..@.`U....f.
	defb 00ch,0a6h,0d7h,00dh,080h,064h,00eh,082h,050h,00eh,090h,036h,00fh,090h,056h,010h	; b24b  .....d..P..6..V.
	defb 070h,036h,013h,090h,036h,013h,060h,0b5h,016h,090h,084h,017h,0a6h,0a7h,018h,081h	; b25b  p6..6.`.........
	defb 060h,018h,090h,046h,019h,090h,046h,019h,076h,0d7h,01ah,090h,036h,01ah,060h,0b5h	; b26b  `..F..F.v...6.`.
	defb 01ah,0a1h,060h,01bh,090h,046h,01bh,080h,0c5h,01ch,0a6h,037h,01dh,0b6h,0c7h,01eh	; b27b  ..`..F.....7....
	defb 0a4h,061h,01eh,094h,071h,01eh,084h,081h,01fh,076h,037h,0ffh,036h,000h,096h,037h	; b28b  .a..q....v7.6..7
	defb 002h,091h,050h,008h,0a6h,027h,008h,092h,090h,009h,080h,045h,009h,096h,0b7h,00ah	; b29b  ..P..'.....E....
	defb 0a0h,066h,00bh,096h,027h,00dh,080h,044h,00fh,0a6h,037h,010h,096h,0c7h,013h,080h	; b2ab  .f..'..D..7.....
	defb 046h,014h,090h,094h,015h,090h,024h,017h,081h,080h,018h,076h,057h,018h,070h,0a4h	; b2bb  F.....$....vW.p.
	defb 01ah,086h,0d7h,01bh,080h,094h,01ch,080h,046h,01dh,076h,097h,01fh,076h,037h,01fh	; b2cb  ........F.v..v7.
	defb 060h,085h,01fh,0a0h,056h,020h,091h,040h,020h,086h,0c7h,021h,060h,065h,021h,0a0h	; b2db  `...V .@ ..!`e!.
	defb 084h,022h,080h,065h,024h,076h,067h,025h,080h,036h,025h,0a0h,036h,027h,081h,030h	; b2eb  .".e$vg%.6%.6'.0
	defb 027h,0a6h,0b7h,02ah,080h,065h,02ah,060h,085h,02ah,060h,0a5h,02dh,084h,071h,02fh	; b2fb  '..*.e*`.*`.-.q/
	defb 0a1h,030h,02fh,080h,085h,030h,0b0h,046h,031h,094h,071h,031h,0a4h,081h,031h,0b4h	; b30b  .0/..0.F1.q1..1.
	defb 091h,032h,090h,055h,032h,0b0h,074h,034h,0a6h,0a7h,037h,090h,034h,037h,0b0h,074h	; b31b  .2.U2.t4..7.47.t
	defb 038h,0a2h,040h,038h,0c6h,0c7h,039h,0a4h,041h,039h,0b4h,061h,039h,0c4h,081h,0ffh	; b32b  8.@8..9.A9.a9...
	defb 010h,003h,086h,027h,013h,086h,0d7h,01ah,086h,0d7h,021h,076h,0d7h,025h,076h,0b7h	; b33b  ...'......!v.%v.
	defb 029h,0a6h,0a7h,02ah,076h,037h,02eh,074h,031h,02eh,084h,041h,02eh,094h,051h,030h	; b34b  )..*v7.t1..A..Q0
	defb 094h,041h,030h,084h,051h,030h,074h,061h,039h,071h,070h,042h,072h,050h,046h,071h	; b35b  .A0.Q0ta9qpBrPFq
	defb 070h,0ffh,08dh,0b3h,090h,0b3h,093h,0b3h,093h,0b3h,093h,0b3h,093h,0b3h,093h,0b3h	; b36b  p...............
	defb 095h,0b3h,098h,0b3h,09dh,0b3h,0a2h,0b3h,0a7h,0b3h,0ach,0b3h,0b1h,0b3h,0b6h,0b3h	; b37b  ................
	defb 0b9h,0b3h,090h,070h,0ffh,090h,0a0h,0ffh,0ffh,0ffh,080h,040h,0ffh,090h,070h,090h	; b38b  ...p.......@..p.
	defb 020h,0ffh,090h,070h,080h,080h,0ffh,090h,070h,090h,010h,0ffh,090h,070h,080h,050h	; b39b   ..p....p....p.P
	defb 0ffh,090h,070h,090h,000h,0ffh,090h,070h,080h,0e0h,0ffh,080h,000h,0ffh,090h,070h	; b3ab  ..p....p.......p
	defb 090h,0d0h,0ffh,020h,0b4h,032h,0b4h,04ch,0b4h,062h,0b4h,07eh,0b4h,09ah,0b4h,0bch	; b3bb  ... .2.L.b.~....
	defb 0b4h,0e4h,0b4h,0fah,0b4h,03ch,0b5h,05eh,0b5h,07ah,0b5h,096h,0b5h,0bch,0b5h,0f2h	; b3cb  .....<.^.z......
	defb 0b5h,010h,0b6h,030h,0b6h,062h,0b6h,08eh,0b6h,0aeh,0b6h,0d6h,0b6h,006h,0b7h,034h	; b3db  ...0.b.........4
	defb 0b7h,04eh,0b7h,080h,0b7h,0b6h,0b7h,0d8h,0b7h,004h,0b8h,034h,0b8h,05ah,0b8h,08eh	; b3eb  .N.........4.Z..
	defb 0b8h,0aeh,0b8h,0e8h,0b8h,00ch,0b9h,03eh,0b9h,070h,0b9h,0a6h,0b9h,0c6h,0b9h,0feh	; b3fb  .......>.p......
	defb 0b9h,030h,0bah,054h,0bah,07ch,0bah,0c0h,0bah,0e4h,0bah,018h,0bbh,04eh,0bbh,07ch	; b40b  .0.T.|.......N.|
	defb 0bbh,09ch,0bbh,0e8h,0bbh,057h,068h,02ah,068h,098h,020h,027h,058h,047h,098h,027h	; b41b  .....Wh*h. 'XG.'
	defb 030h,07dh,080h,09ch,0e8h,047h,0cch,077h,020h,04ch,0d8h,057h,068h,078h,030h,087h	; b42b  0}...G.w L.Whx0.
	defb 0d8h,027h,070h,079h,0c8h,057h,058h,05ch,060h,027h,0c8h,087h,058h,027h,030h,06fh	; b43b  .'py.WX\`'..X'0o
	defb 0bch,049h,088h,077h,0b8h,068h,020h,027h,098h,058h,028h,01bh,030h,067h,058h,087h	; b44b  .I.w.h '.X(.0gX.
	defb 058h,02dh,040h,078h,0b8h,067h,09ch,037h,058h,04ch,010h,077h,0b8h,028h,010h,018h	; b45b  X-@x.g.7XL.w.(..
	defb 030h,077h,078h,027h,040h,08fh,0b8h,057h,0c8h,03ch,098h,037h,050h,07dh,0c8h,027h	; b46b  0wx'@..W.<.7P}.'
	defb 020h,06bh,0ach,099h,010h,01bh,040h,087h,068h,06eh,050h,06eh,060h,06eh,070h,027h	; b47b   k....@.hnPn`np'
	defb 0b8h,017h,070h,078h,0e8h,037h,088h,07bh,010h,037h,068h,077h,060h,02ch,0bch,058h	; b48b  ..px.7.{.7hw`,.X
	defb 020h,05eh,040h,027h,0b8h,087h,078h,049h,010h,037h,0b8h,087h,058h,06bh,010h,097h	; b49b   ^@'..xI.7..Xk..
	defb 0c8h,067h,050h,098h,0d8h,087h,050h,088h,0d8h,077h,070h,04dh,0d8h,057h,0c8h,08bh	; b4ab  .gP...P..wpM.W..
	defb 0bch,02ah,030h,097h,0c8h,028h,0a8h,067h,050h,088h,0d8h,037h,020h,04fh,0b8h,068h	; b4bb  .*0..(.gP..7 O.h
	defb 020h,077h,088h,06ah,020h,08eh,020h,017h,098h,097h,060h,038h,0a8h,017h,070h,07dh	; b4cb   w.j . ...`8..p}
	defb 0e8h,037h,010h,088h,088h,047h,030h,05bh,0ech,077h,050h,05eh,090h,05eh,0a0h,05eh	; b4db  .7...G0[.wP^.^.^
	defb 0b8h,038h,040h,087h,098h,027h,010h,08dh,0d8h,02eh,0b0h,02eh,0c0h,02ch,0dch,027h	; b4eb  .8@..'.......,.'
	defb 030h,06eh,0b0h,07dh,0c8h,018h,040h,097h,058h,08ch,010h,097h,080h,018h,0d8h,07eh	; b4fb  0n.}..@.X......~
	defb 030h,07eh,040h,07eh,050h,077h,0b8h,087h,060h,05eh,090h,05eh,0a0h,05eh,0b8h,01ch	; b50b  0~@~Pw..`^.^.^..
	defb 010h,08eh,010h,08eh,040h,047h,0b8h,067h,010h,07eh,080h,06eh,090h,07eh,098h,01eh	; b51b  ....@G.g.~.n.~..
	defb 030h,01eh,040h,02eh,040h,027h,0c8h,07bh,020h,027h,0a8h,018h,030h,097h,0a0h,04fh	; b52b  0.@.@'.{ '..0..O
	defb 0cch,049h,020h,057h,078h,077h,060h,068h,0a0h,02dh,0b8h,087h,0d8h,04ch,040h,047h	; b53b  .I Wxw`h.-...L@G
	defb 088h,03ch,010h,027h,098h,097h,030h,048h,0c8h,087h,0e8h,04ah,010h,04eh,020h,04eh	; b54b  .<.'..0H...J.N N
	defb 030h,027h,0cch,087h,060h,04eh,098h,077h,090h,02ch,0d8h,067h,068h,05dh,010h,06ch	; b55b  0'..`N.w.,.gh].l
	defb 0d8h,028h,030h,047h,0a8h,029h,040h,087h,058h,097h,0b8h,028h,040h,04bh,0cch,03eh	; b56b  .(0G.)@.X..(@K.>
	defb 050h,098h,050h,027h,0c8h,067h,078h,047h,0c8h,087h,010h,03ch,0b8h,027h,038h,029h	; b57b  P.P'.gxG...<.'8)
	defb 030h,057h,088h,04dh,030h,087h,058h,067h,070h,048h,0dch,068h,010h,027h,058h,057h	; b58b  0W.M0.XgpH.h.'XW
	defb 060h,07bh,0c8h,08dh,050h,087h,0e8h,067h,0c8h,027h,088h,097h,050h,03dh,0c8h,057h	; b59b  `{..P..g.'..P=.W
	defb 030h,05eh,080h,05eh,090h,058h,0c8h,03bh,060h,067h,0c8h,049h,030h,09eh,098h,017h	; b5ab  0^.^.X.;`g.I0...
	defb 0bch,06fh,020h,027h,098h,078h,050h,077h,098h,068h,020h,027h,050h,07eh,088h,03eh	; b5bb  .o '.xPw.h 'P~.>
	defb 030h,05ah,040h,07eh,070h,097h,0c8h,05bh,030h,087h,0d8h,08eh,040h,038h,060h,067h	; b5cb  0Z@~p..[0...@8`g
	defb 0b8h,057h,030h,09eh,090h,019h,0a0h,04eh,0e8h,028h,050h,067h,098h,03ah,020h,067h	; b5db  .W0....N.(Pg.: g
	defb 088h,08dh,020h,098h,090h,047h,0cch,077h,078h,01eh,020h,02eh,020h,029h,050h,097h	; b5eb  .. ..G.wx. . )P.
	defb 088h,08dh,0b0h,027h,0c8h,027h,0c8h,028h,050h,027h,0d8h,05bh,070h,097h,098h,058h	; b5fb  ...'.'.(P'.[p..X
	defb 098h,028h,060h,087h,0cch,037h,030h,08eh,080h,03eh,0d8h,03dh,040h,027h,0b8h,047h	; b60b  .(`..70..>.=@'.G
	defb 0b8h,087h,078h,087h,058h,06ch,030h,04bh,090h,08fh,0c8h,019h,060h,07ch,088h,08eh	; b61b  ..x.Xl0K....`|..
	defb 010h,08eh,020h,057h,09ch,02bh,030h,057h,050h,04ch,0e8h,058h,040h,06eh,070h,06eh	; b62b  .. W.+0WPL.X@npn
	defb 080h,047h,0c8h,029h,030h,047h,0a0h,01eh,0b8h,08eh,040h,067h,098h,01dh,030h,077h	; b63b  .G.)0G....@g..0w
	defb 078h,07eh,020h,09bh,020h,037h,0a8h,058h,020h,09eh,090h,03eh,0b0h,04eh,0b8h,03ch	; b64b  x~ . 7.X ..>.N.<
	defb 050h,03eh,060h,04eh,060h,027h,0cch,037h,030h,03eh,0c0h,04eh,0c0h,03eh,0d8h,09ch	; b65b  P>`N`'.70>.N.>..
	defb 010h,077h,060h,02bh,0c8h,05dh,020h,097h,0e8h,027h,058h,067h,0c8h,05ch,090h,039h	; b66b  .w`+.] ..'Xg.\.9
	defb 0e8h,047h,020h,02eh,050h,07eh,020h,07eh,038h,077h,060h,02fh,0c8h,018h,040h,087h	; b67b  .G .P~ ~8w`/..@.
	defb 078h,027h,0bch,087h,030h,048h,070h,01eh,0b8h,09bh,060h,067h,098h,07ch,020h,098h	; b68b  x'..0Hp...`g.| .
	defb 070h,089h,0d8h,01eh,030h,01eh,040h,01eh,050h,067h,0a8h,06eh,070h,07eh,078h,097h	; b69b  p...0.@.Pg.np~x.
	defb 030h,03ch,04ch,057h,058h,087h,080h,02bh,0d8h,018h,040h,069h,088h,08eh,020h,067h	; b6ab  0<LWX..+..@i.. g
	defb 068h,047h,030h,088h,0d8h,077h,0a8h,027h,040h,04eh,090h,04eh,0a0h,05eh,0a8h,04bh	; b6bb  hG0..w.'@N.N.^.K
	defb 030h,057h,068h,097h,020h,018h,0b8h,05dh,030h,097h,0dch,057h,020h,038h,0c8h,02dh	; b6cb  0Wh. ..]0..W 8.-
	defb 080h,077h,0a8h,048h,010h,037h,030h,08bh,0d8h,037h,0b8h,027h,010h,07eh,070h,02dh	; b6db  .w.H.70..7.'.~p-
	defb 098h,05ah,020h,087h,0e8h,047h,040h,058h,0d8h,02fh,040h,077h,098h,097h,010h,08eh	; b6eb  .Z ..G@X./@w....
	defb 090h,098h,098h,047h,090h,07eh,0c0h,08eh,0c0h,07ah,0dch,07bh,060h,087h,0b8h,027h	; b6fb  ...G.~...z.{`..'
	defb 030h,088h,0c8h,097h,0c8h,07eh,040h,08eh,040h,07eh,050h,089h,098h,047h,018h,097h	; b70b  0....~@.@~P..G..
	defb 090h,04ch,0c0h,08eh,0c0h,09eh,0c8h,058h,040h,087h,060h,03dh,0c8h,027h,058h,01ch	; b71b  .L.....X@.`=.'X.
	defb 040h,03eh,0e0h,047h,0e8h,087h,020h,098h,0dch,067h,050h,049h,0d8h,09bh,0b0h,037h	; b72b  @>.G.. ..gPI...7
	defb 0e8h,077h,030h,07eh,088h,057h,070h,098h,0d8h,027h,0a8h,08ch,010h,01eh,040h,017h	; b73b  .w0~.Wp..'....@.
	defb 0b0h,08eh,0cch,087h,030h,028h,098h,06eh,030h,07eh,030h,06eh,040h,077h,0c8h,07ch	; b74b  ....0(.n0~0n@w.|
	defb 040h,097h,0d8h,017h,030h,06eh,030h,05eh,040h,06eh,048h,028h,030h,047h,0a8h,087h	; b75b  @...0n0^@nH(0G..
	defb 0a8h,087h,048h,09dh,010h,02eh,040h,03eh,060h,01bh,0b8h,038h,030h,097h,0d8h,057h	; b76b  ..H...@>`..80..W
	defb 068h,04ch,098h,027h,05ch,087h,068h,017h,0a8h,027h,068h,08dh,040h,067h,0a8h,04ch	; b77b  hL.'\.h..'h.@g.L
	defb 010h,027h,0b8h,04eh,070h,05eh,070h,05eh,080h,027h,0c8h,09eh,0a0h,09eh,0b0h,09eh	; b78b  .'.Np^p^.'......
	defb 0c0h,087h,0d8h,037h,040h,03fh,080h,098h,0a0h,01bh,0c8h,098h,030h,097h,090h,02eh	; b79b  ...7@?......0...
	defb 0b0h,03ch,0c8h,08eh,0c0h,09eh,0c0h,057h,0d0h,08eh,0dch,027h,0d8h,027h,020h,02ch	; b7ab  .<.....W...'.' ,
	defb 0a8h,029h,050h,087h,0e8h,027h,050h,08eh,050h,048h,0d8h,077h,068h,017h,040h,078h	; b7bb  .)P..'P.PH.wh.@x
	defb 0b8h,057h,0c8h,027h,090h,09ch,078h,02dh,050h,087h,0d8h,027h,0cch,018h,020h,087h	; b7cb  .W.'..x-P..'.. .
	defb 0c8h,08eh,050h,02eh,070h,017h,0a0h,029h,0e8h,057h,088h,087h,050h,02bh,0b8h,027h	; b7db  ..P.p..).W..P+.'
	defb 030h,038h,080h,01eh,0b0h,09eh,0b8h,03bh,040h,027h,098h,027h,058h,017h,020h,069h	; b7eb  08.....;@'.'X. i
	defb 098h,017h,020h,058h,0a8h,06dh,060h,097h,0dch,03ah,010h,087h,080h,09dh,0d8h,047h	; b7fb  .. X.m`..:.....G
	defb 020h,07bh,0b8h,037h,030h,04eh,090h,089h,0b8h,058h,060h,037h,0a8h,027h,030h,058h	; b80b   {.70N...X`7.'0X
	defb 020h,03ah,0c8h,027h,0c0h,03eh,060h,08eh,0c0h,09eh,0c8h,087h,050h,078h,0b8h,02fh	; b81b   :.'.>`.....Px./
	defb 030h,087h,0b8h,05bh,030h,088h,0c8h,057h,0ach,077h,088h,037h,0b8h,058h,040h,037h	; b82b  0..[0..W.w.7.X@7
	defb 0c8h,057h,068h,047h,098h,087h,050h,08ch,0b8h,067h,068h,028h,090h,08bh,0b8h,057h	; b83b  .WhG..P..gh(...W
	defb 040h,059h,0c8h,077h,068h,078h,038h,067h,050h,06eh,0b0h,06eh,0c0h,01ch,0ech,077h	; b84b  @Y.whx8gPn.n...w
	defb 058h,07dh,010h,08eh,010h,09eh,010h,037h,0a8h,057h,030h,04ch,0b8h,01eh,010h,01eh	; b85b  X}.....7.W0L....
	defb 020h,067h,098h,02bh,030h,087h,088h,06eh,060h,05eh,070h,06eh,070h,027h,0a8h,058h	; b86b   g.+0..n`^pnp'.X
	defb 020h,05eh,050h,05eh,060h,057h,0a8h,077h,0b8h,037h,080h,07eh,080h,068h,0d8h,09fh	; b87b   ^P^`W.w.7.~.h..
	defb 060h,087h,0bch,077h,068h,04bh,088h,037h,040h,02dh,0c0h,07ch,0e8h,06eh,070h,06eh	; b88b  `..whK.7@-.|.npn
	defb 080h,067h,0c8h,02ch,020h,077h,048h,027h,0c0h,08eh,0c0h,09eh,0c8h,03bh,030h,078h	; b89b  .g., wH'.....;0x
	defb 0e8h,027h,0bch,028h,038h,087h,010h,03dh,0b8h,03ch,048h,05eh,050h,06eh,050h,07eh	; b8ab  .'.(8..=.<H^PnP~
	defb 050h,067h,068h,08ch,030h,04eh,090h,04eh,0a0h,05eh,0a8h,028h,040h,077h,088h,09ch	; b8bb  Pgh.0N.N.^.(@w..
	defb 0e8h,07eh,020h,07eh,030h,07eh,040h,017h,0c8h,08bh,080h,03eh,0c0h,04eh,0c0h,03eh	; b8cb  .~ ~0~@....>.N.>
	defb 0d8h,07eh,040h,08eh,040h,017h,0b8h,019h,060h,097h,098h,02dh,0ach,08ch,020h,058h	; b8db  .~@.@...`..-.. X
	defb 040h,057h,0b8h,02eh,040h,04eh,070h,027h,0c0h,08eh,0c8h,087h,0b8h,027h,0b8h,047h	; b8eb  @W..@Np'.....'.G
	defb 030h,09eh,090h,02bh,0a8h,017h,0a0h,029h,0e8h,047h,030h,04eh,0b8h,057h,070h,058h	; b8fb  0..+...).G0N.WpX
	defb 0cch,019h,040h,087h,0b8h,028h,078h,047h,030h,04eh,098h,039h,048h,027h,040h,06eh	; b90b  ..@..(xG0N.9H'@n
	defb 090h,07eh,090h,09dh,0b8h,000h,008h,077h,068h,05bh,040h,05eh,080h,017h,088h,087h	; b91b  .~.....wh[@^....
	defb 040h,048h,0d8h,08eh,040h,08eh,050h,087h,068h,087h,060h,058h,0d8h,000h,008h,000h	; b92b  @H..@.P.h.`X....
	defb 008h,087h,0dch,047h,030h,05eh,090h,05eh,0a0h,05eh,0b8h,088h,020h,06eh,070h,047h	; b93b  ...G0^.^.^.. npG
	defb 0c0h,09ah,0e8h,057h,020h,02fh,078h,088h,020h,087h,048h,068h,030h,027h,078h,06bh	; b94b  ...W /x. .Hh0'xk
	defb 040h,077h,098h,048h,020h,087h,050h,04ah,0c8h,06dh,060h,017h,0a8h,03bh,010h,017h	; b95b  @w.H .PJ.m`..;..
	defb 068h,087h,070h,048h,0dch,097h,070h,01ch,0b8h,08eh,010h,08eh,040h,08eh,050h,047h	; b96b  h.pH..p.....@.PG
	defb 0c8h,077h,068h,02eh,070h,01ch,0a0h,077h,0b8h,068h,030h,087h,078h,06eh,060h,05eh	; b97b  .wh.p..w.h0.xn`^
	defb 070h,06eh,070h,027h,0a8h,09eh,050h,08eh,060h,09eh,060h,097h,0c8h,017h,010h,058h	; b98b  pnp'..P.`.`....X
	defb 070h,02bh,0b8h,05dh,040h,087h,0c8h,077h,070h,029h,0cch,087h,0b8h,02bh,0a8h,077h	; b99b  p+.]@..wp)...+.w
	defb 098h,087h,078h,048h,020h,02fh,040h,09eh,090h,017h,0a8h,02dh,040h,067h,0b8h,018h	; b9ab  ..xH /@....-@g..
	defb 080h,097h,088h,027h,050h,068h,0c0h,08eh,0c0h,09eh,0cch,037h,060h,078h,0c8h,06eh	; b9bb  ...'Ph.....7`x.n
	defb 070h,06eh,080h,087h,0a8h,069h,020h,027h,098h,06eh,070h,06eh,080h,087h,0c8h,018h	; b9cb  pn...i '.npn....
	defb 030h,077h,040h,078h,0d8h,027h,030h,08eh,030h,09eh,030h,08eh,048h,02bh,030h,047h	; b9db  0w@x.'0.0.0.H+0G
	defb 0a8h,027h,078h,027h,030h,08dh,020h,03eh,0c0h,03eh,0d8h,067h,038h,000h,008h,01ch	; b9eb  .'x'0. >.>.g8...
	defb 060h,097h,09ch,01eh,0b0h,01eh,0c0h,02eh,0c0h,027h,0e8h,05ch,060h,067h,098h,017h	; b9fb  `........'.\`g..
	defb 040h,05eh,040h,08ch,048h,01bh,040h,047h,088h,037h,020h,05eh,0a0h,06eh,0a0h,04ch	; ba0b  @^@.H.@G.7 ^.n.L
	defb 0b8h,097h,010h,07eh,020h,07eh,030h,07eh,048h,077h,030h,058h,098h,03eh,020h,07eh	; ba1b  ...~ ~0~Hw0X.> ~
	defb 040h,097h,0a0h,02fh,0ech,087h,058h,097h,070h,02bh,0e8h,087h,020h,068h,098h,08eh	; ba2b  @../..X.p+.. h..
	defb 040h,08eh,050h,02dh,060h,087h,0c8h,029h,030h,077h,088h,01eh,020h,01eh,030h,077h	; ba3b  @.P-`..)0w.. .0w
	defb 048h,03ch,040h,04eh,090h,097h,0e8h,017h,05ch,017h,020h,049h,070h,088h,0d8h,04eh	; ba4b  H<@N....\. Ip..N
	defb 060h,097h,088h,05dh,020h,057h,0d8h,000h,008h,03bh,030h,037h,0c8h,077h,0a8h,097h	; ba5b  `..] W...;07.w..
	defb 020h,02eh,0b0h,03eh,0c8h,09bh,040h,037h,0a8h,027h,020h,09dh,098h,098h,060h,077h	; ba6b   ..>..@7.' ...`w
	defb 0bch,05bh,020h,017h,040h,05eh,040h,098h,048h,08eh,030h,09eh,030h,08eh,040h,067h	; ba7b  .[ .@^@.H.0.0.@g
	defb 098h,027h,080h,05dh,0d8h,01ah,0a8h,078h,010h,057h,030h,04eh,0e0h,09fh,0e8h,05eh	; ba8b  .'.]...x.W0N...^
	defb 040h,067h,040h,04eh,050h,05eh,058h,089h,040h,057h,0d8h,058h,040h,087h,098h,06dh	; ba9b  @g@NP^X.@W.X@..m
	defb 010h,087h,078h,09eh,040h,09eh,050h,09ah,0c0h,037h,0e8h,027h,030h,07bh,088h,08dh	; baab  ..x.@.P..7.'0{..
	defb 050h,018h,090h,077h,0cch,01ch,050h,087h,088h,027h,020h,078h,0a8h,02eh,050h,01eh	; babb  P..w..P..' x..P.
	defb 080h,02eh,080h,027h,0e8h,02dh,040h,058h,090h,097h,0c8h,057h,040h,02bh,0a0h,089h	; bacb  ...'.-@X...W@+..
	defb 0c8h,06eh,050h,06eh,060h,06eh,070h,097h,0dch,077h,030h,01eh,090h,02eh,098h,04bh	; badb  .nPn`np..w0....K
	defb 080h,05eh,088h,09eh,050h,08eh,060h,09eh,060h,097h,0d8h,03ch,040h,098h,060h,027h	; baeb  .^..P.`.`..<@.`'
	defb 0a8h,078h,030h,027h,050h,07eh,088h,07eh,020h,087h,020h,02bh,0c8h,07eh,0a0h,07eh	; bafb  .x0'P~.~ . +.~.~
	defb 0b0h,05eh,0c0h,07ch,0c8h,07eh,020h,07eh,030h,057h,090h,01fh,0dch,04bh,020h,087h	; bb0b  .^.|.~ ~0W...K .
	defb 078h,087h,040h,01dh,0c8h,087h,020h,07eh,080h,08eh,080h,07eh,098h,019h,030h,06eh	; bb1b  x.@... ~...~..0n
	defb 0b0h,06eh,0c0h,027h,0e8h,087h,080h,05eh,0b8h,03eh,020h,08eh,040h,01ch,0a0h,097h	; bb2b  .n.'...^.> .@...
	defb 0c8h,067h,070h,038h,0c8h,087h,068h,097h,080h,04ch,0c8h,06eh,040h,07eh,040h,08eh	; bb3b  .gp8..h..L.n@~@.
	defb 040h,067h,08ch,037h,088h,067h,020h,028h,0b0h,08eh,0c0h,09eh,0c8h,037h,0a8h,087h	; bb4b  @g.7.g (.....7..
	defb 050h,05dh,0b8h,037h,058h,017h,010h,08eh,040h,04ch,098h,097h,030h,05fh,0c8h,057h	; bb5b  P].7X...@L..0_.W
	defb 070h,028h,0c8h,057h,030h,03eh,0b0h,04eh,0b0h,04eh,0c8h,09ch,010h,048h,030h,027h	; bb6b  p(.W0>.N.N...H0'
	defb 0cch,047h,030h,04eh,098h,097h,070h,019h,0c8h,028h,030h,077h,068h,047h,0c8h,057h	; bb7b  .G0N..p..(0whG.W
	defb 028h,02dh,030h,097h,078h,057h,098h,017h,020h,05ch,038h,058h,030h,057h,0d8h,028h	; bb8b  (-0.xW.. \8X0W.(
	defb 078h,05eh,040h,09ah,048h,017h,020h,069h,0b8h,057h,028h,097h,060h,02bh,0c8h,087h	; bb9b  x^@.H. i.W(.`+..
	defb 088h,089h,078h,087h,058h,057h,078h,087h,050h,088h,0c8h,018h,040h,027h,0e8h,09dh	; bbab  ..x.XWx.P...@'..
	defb 040h,068h,080h,028h,0b8h,067h,098h,087h,0e8h,057h,0c8h,048h,030h,09dh,0b8h,087h	; bbbb  @h.(.g...W.H0...
	defb 090h,01ah,0d8h,027h,048h,000h,008h,01bh,020h,097h,058h,06eh,040h,07eh,040h,08eh	; bbcb  ...'H... .Xn@~@.
	defb 048h,018h,020h,029h,0d8h,027h,0e0h,04eh,0e0h,05eh,0e0h,06eh,0ech,088h,030h,047h	; bbdb  H. ).'.N.^.n..0G
	defb 0c8h,08eh,060h,08eh,070h,08ah,088h,097h,030h,068h,080h,019h,0d8h,07eh,020h,08eh	; bbeb  ..`.p...0h...~ .
	defb 020h,07eh,030h,087h,0b8h,037h,020h,02fh,080h,08eh,0c0h,08dh,0d8h,059h,020h,047h	; bbfb   ~0..7 /.....Y G
	defb 0a8h,027h,010h,098h,098h,09bh,030h,038h,060h,097h,0dch,05ch,0bch,06ch,0bch,07fh	; bc0b  .'....08`..\.l..
	defb 0bch,092h,0bch,0a6h,0bch,0b8h,0bch,0cah,0bch,0dch,0bch,0eeh,0bch,000h,0bdh,013h	; bc1b  ................
	defb 0bdh,025h,0bdh,036h,0bdh,049h,0bdh,05ch,0bdh,06fh,0bdh,083h,0bdh,097h,0bdh,0a8h	; bc2b  .%.6.I.\.o......
	defb 0bdh,0bah,0bdh,0cdh,0bdh,0e0h,0bdh,0f0h,0bdh,002h,0beh,016h,0beh,029h,0beh,03dh	; bc3b  .............).=
	defb 0beh,04fh,0beh,063h,0beh,07ah,0beh,08dh,0beh,0a4h,0beh,0b9h,0beh,0cch,0beh,0e0h	; bc4b  .O.c.z..........
	defb 0beh,04eh,03ch,063h,049h,000h,04dh,05dh,048h,000h,039h,042h,03bh,056h,04ch,063h	; bc5b  .N<cI.M]H.9B;VLc
	defb 0ffh,041h,035h,05eh,042h,000h,04ch,063h,05dh,057h,044h,000h,03bh,063h,061h,032h	; bc6b  .A5^B.Lc]WD.;ca2
	defb 04dh,032h,053h,0ffh,034h,04eh,052h,057h,030h,058h,043h,000h,03bh,063h,061h,032h	; bc7b  M2S.4NRW0XC.;ca2
	defb 04dh,032h,000h,04bh,033h,058h,0ffh,047h,039h,045h,000h,039h,049h,063h,05dh,000h	; bc8b  M2.K3X.G9E.9Ic].
	defb 04bh,063h,03fh,045h,000h,03bh,05dh,03bh,063h,060h,0ffh,041h,036h,063h,049h,000h	; bc9b  Kc?E.;];c`.A6cI.
	defb 03ch,042h,066h,03bh,063h,026h,03fh,063h,000h,054h,038h,05eh,0ffh,03fh,05dh,049h	; bcab  <Bf;c&?c.T8^.?]I
	defb 063h,03ah,03ah,053h,04eh,000h,031h,048h,03bh,03bh,000h,032h,04eh,031h,0ffh,035h	; bcbb  c::SN.1H;;.2N1.5
	defb 031h,049h,063h,056h,039h,032h,039h,032h,000h,05bh,035h,063h,04dh,063h,039h,032h	; bccb  1IcV9292.[5cMc92
	defb 0ffh,044h,05dh,042h,05eh,03fh,05eh,042h,000h,030h,031h,043h,063h,058h,000h,03fh	; bcdb  .D]B^?^B.01CcX.?
	defb 063h,031h,0ffh,054h,038h,049h,063h,000h,054h,037h,04dh,043h,063h,000h,034h,037h	; bceb  c1.T8Ic.T7MCc.47
	defb 035h,063h,030h,058h,0ffh,041h,036h,063h,049h,000h,03ch,042h,066h,03bh,063h,021h	; bcfb  5c0X.A6cI.<Bf;c!
	defb 023h,03fh,063h,000h,03eh,059h,05eh,0ffh,03fh,04ah,063h,049h,000h,04fh,040h,03ch	; bd0b  #?c.>Y^.?JcI.O@<
	defb 063h,059h,000h,055h,049h,000h,044h,03ah,038h,0ffh,048h,05eh,042h,036h,03fh,036h	; bd1b  cY.UI.D:8.H^B6?6
	defb 03fh,000h,030h,066h,039h,057h,05fh,039h,057h,05fh,0ffh,043h,036h,051h,036h,048h	; bd2b  ?.0f9W_9W_.C6Q6H
	defb 000h,03ch,042h,066h,03bh,063h,037h,057h,030h,000h,03bh,063h,05fh,0ffh,03ah,035h	; bd3b  .<Bf;c7W0.;c_.:5
	defb 03dh,042h,000h,03ah,035h,03dh,042h,000h,052h,052h,031h,05ah,000h,03ch,058h,051h	; bd4b  =B.:5=B.RR1Z.<XQ
	defb 0ffh,041h,036h,063h,049h,000h,03ch,042h,066h,03bh,063h,022h,020h,03fh,063h,000h	; bd5b  .A6cI.<Bf;c" ?c.
	defb 043h,034h,05eh,0ffh,053h,059h,049h,063h,000h,053h,058h,04dh,043h,063h,000h,030h	; bd6b  C4^.SYIc.SXMCc.0
	defb 03bh,063h,035h,063h,042h,063h,058h,0ffh,039h,044h,04fh,048h,000h,05bh,066h,04bh	; bd7b  ;c5cBcX.9DOH.[fK
	defb 062h,05ah,000h,03dh,063h,05dh,051h,05dh,037h,057h,030h,0ffh,044h,05dh,03fh,063h	; bd8b  bZ.=c]Q]7W0.D]?c
	defb 000h,044h,05dh,03fh,063h,000h,044h,05dh,044h,05dh,03fh,063h,0ffh,036h,030h,031h	; bd9b  .D]?c.D]D]?c.601
	defb 05ch,000h,031h,059h,042h,000h,03eh,059h,03eh,059h,03eh,059h,03eh,059h,0ffh,041h	; bdab  \.1YB.>Y>Y>Y>Y.A
	defb 036h,063h,049h,000h,03ch,042h,066h,03bh,063h,022h,027h,03fh,063h,000h,053h,030h	; bdbb  6cI.<Bf;c"'?c.S0
	defb 05eh,0ffh,044h,03eh,063h,051h,037h,000h,03bh,035h,038h,045h,000h,040h,035h,063h	; bdcb  ^.D>cQ7.;58E.@5c
	defb 03ah,05bh,037h,063h,0ffh,039h,039h,056h,042h,063h,000h,03ch,039h,03bh,000h,053h	; bddb  :[7c.99VBc.<9;.S
	defb 03ch,04eh,05dh,035h,0ffh,03ch,042h,066h,03bh,063h,037h,057h,030h,03fh,063h,000h	; bdeb  <N]5.<Bf;c7W0?c.
	defb 04dh,04dh,031h,048h,04dh,031h,0ffh,041h,035h,05eh,042h,000h,04ch,063h,05dh,057h	; bdfb  MM1HM1.A5^B.Lc]W
	defb 044h,000h,035h,037h,03bh,039h,04eh,05dh,043h,063h,0ffh,041h,036h,063h,049h,000h	; be0b  D.57;9N]Cc.A6cI.
	defb 03ch,042h,066h,03bh,063h,023h,024h,03fh,063h,000h,04dh,057h,05fh,0ffh,05bh,049h	; be1b  <Bf;c#$?c.MW_.[I
	defb 049h,049h,049h,000h,031h,05eh,04dh,062h,05dh,000h,043h,056h,059h,04eh,03bh,03fh	; be2b  III.1^Mb].CVYN;?
	defb 044h,0ffh,035h,037h,03bh,039h,04eh,05dh,043h,063h,049h,000h,04fh,041h,035h,05eh	; be3b  D.57;9N]CcI.OA5^
	defb 03fh,035h,044h,0ffh,036h,061h,03fh,063h,031h,044h,000h,032h,051h,04dh,063h,03bh	; be4b  ?5D.6a?c1D.2QMc;
	defb 000h,04eh,058h,035h,03bh,063h,057h,0ffh,03fh,04ah,063h,054h,035h,049h,063h,000h	; be5b  .NX5;cW.?JcT5Ic.
	defb 031h,041h,035h,049h,030h,03fh,058h,000h,033h,043h,063h,048h,04eh,040h,0ffh,041h	; be6b  1A5I0?X.3CcHN@.A
	defb 036h,063h,049h,000h,03ch,042h,066h,03bh,063h,024h,021h,03fh,063h,000h,03fh,030h	; be7b  6cI.<Bf;c$!?c.?0
	defb 05eh,0ffh,033h,043h,063h,048h,04eh,040h,000h,031h,05eh,036h,031h,05eh,036h,042h	; be8b  ^.3CcHN@.1^61^6B
	defb 063h,000h,043h,05eh,03bh,05dh,03fh,063h,0ffh,039h,039h,04eh,042h,063h,037h,059h	; be9b  c.C^;]?c.99NBc7Y
	defb 049h,063h,000h,030h,043h,049h,000h,039h,05dh,03bh,063h,061h,032h,0ffh,035h,037h	; beab  Ic.0CI.9];ca2.57
	defb 03bh,039h,04eh,05dh,043h,063h,000h,036h,04fh,040h,05fh,05dh,038h,063h,05dh,036h	; bebb  ;9N]Cc.6O@_]8c]6
	defb 0ffh,039h,039h,04eh,042h,063h,037h,059h,049h,063h,000h,030h,05dh,03fh,049h,000h	; becb  .99NBc7YIc.0]?I.
	defb 04bh,062h,05ah,055h,0ffh,041h,036h,063h,049h,000h,033h,043h,063h,03bh,063h,061h	; bedb  KbZU.A6cI.3Cc;ca
	defb 032h,000h,043h,041h,045h,060h,032h,03fh,063h,000h,05bh,034h,05eh	; beeb  2.CAE`2?c.[4^

; ----------------------------------------------------------------------
; DATOS relleno_15: 264 bytes 0xFF hasta el final del banco: relleno, no lo
;   lee nadie; lo leen nadie (264 bytes)
;   0xbef8..0xc000  (264 bytes)
DATA_relleno_15:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bef8  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf08  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf18  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf28  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf38  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf48  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf58  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf68  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf78  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf88  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf98  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfa8  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfb8  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc8  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd8  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe8  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff8  ........
