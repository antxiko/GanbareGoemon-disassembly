; ==========================================================================
; GANBARE GOEMON - Konami (1987) - MSX2 - MegaROM RC-748 de 128 KB (Konami4) - banco 10 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ======================================================================
; CODIGO 0x6000..0x60d5  (213 bytes)
; ======================================================================


L_6000:
	ld a,(0c09fh)		;6000
	ld e,a			;6003
	ld a,007h		;6004
	call 00093h		;6006   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0c0a0h)		;6009
	or a			;600c
	jp nz,L_608B		;600d
	ld a,(0c0a9h)		;6010
	dec a			;6013
	jp m,L_603E		;6014
	jp nz,L_603B		;6017
	ld a,(0c0aah)		;601a
	dec a			;601d
	ld (0c0aah),a		;601e
	cp 0f0h		;6021
	jp nz,L_6039		;6023
	ld hl,L_6067		;6026
	ld (0c010h),hl		;6029
	ld (0c012h),hl		;602c
	ld (0c014h),hl		;602f
	xor a			;6032
	ld (0c0abh),a		;6033
	jp L_603B		;6036
L_6039:
	ld a,03ah		;6039
L_603B:
	ld (0c0a9h),a		;603b
L_603E:
	xor a			;603e
	ld b,a			;603f
	ld hl,(0c010h)		;6040
	call L_605F		;6043
	ld a,001h		;6046
	ld b,a			;6048
	ld hl,(0c012h)		;6049
	call L_605F		;604c
	ld a,002h		;604f
	ld b,a			;6051
	ld hl,(0c014h)		;6052
	call L_605F		;6055
	ld a,002h		;6058
	ld b,003h		;605a
	ld hl,(0c016h)		;605c
L_605F:
	ld (0c09ch),a		;605f
	ld a,b			;6062
	ld (0c09dh),a		;6063
	jp (hl)			;6066
L_6067:
	ld a,(0c09dh)		;6067
	cp 003h		;606a
	jp nz,L_6076		;606c
	xor a			;606f
	ld (0c09eh),a		;6070
	ld a,(0c09dh)		;6073
L_6076:
	rlca			;6076
	ld hl,0c010h		;6077
	add a,l			;607a
	ld l,a			;607b
	jr nc,L_607F		;607c
	inc h			;607e
L_607F:
	ld de,L_608A		;607f
	ld (hl),e			;6082
	inc hl			;6083
	ld (hl),d			;6084
	ld e,000h		;6085
	jp L_609B		;6087
L_608A:
	ret			;608a
L_608B:
	ld hl,(0c018h)		;608b
	jp (hl)			;608e
L_608F:
	ld a,(0c09ch)		;608f
	rlca			;6092
	call 00093h		;6093   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;6096
	ld e,d			;6097
	jp 00093h		;6098   ; BIOS WRTPSG - Writes data to PSG-register
L_609B:
	ld a,(0c09ch)		;609b
	add a,008h		;609e
	jp 00093h		;60a0   ; BIOS WRTPSG - Writes data to PSG-register
L_60A3:
	push hl			;60a3
	ld hl,060e7h		;60a4
	jp L_60BC		;60a7
L_60AA:
	push hl			;60aa
	ld hl,060e1h		;60ab
	jp L_60BC		;60ae
L_60B1:
	push hl			;60b1
	ld hl,060dbh		;60b2
	jp L_60BC		;60b5
L_60B8:
	push hl			;60b8
	ld hl,060d5h		;60b9
L_60BC:
	ld a,(0c09ch)		;60bc
	rlca			;60bf
	add a,l			;60c0
	ld l,a			;60c1
	jr nc,L_60C5		;60c2
	inc h			;60c4
L_60C5:
	ld a,(0c09fh)		;60c5
	and (hl)			;60c8
	inc hl			;60c9
	or (hl)			;60ca
	ld (0c09fh),a		;60cb
	pop hl			;60ce
	ld e,a			;60cf
	ld a,007h		;60d0
	jp 00093h		;60d2   ; BIOS WRTPSG - Writes data to PSG-register

; ----------------------------------------------------------------------
; DATOS mascaras_del_mezclador: cuatro parejas de mascaras (AND, OR) por canal
;   para el registro 7 del PSG: p10:60A3 apunta a 0x60E7, p10:60AA a 0x60E1,
;   p10:60B1 a 0x60DB y p10:60B8 a 0x60D5, y p10:60BC suma el doble del canal
;   (24 bytes)
;   0x60d5..0x60ed  (24 bytes)
DATA_mascaras_del_mezclador:
	defb 0feh,008h,0fdh,010h,0fbh,020h	; 60d5
	defb 0f7h,001h,0efh,002h,0dfh,004h	; 60db
	defb 0f6h,000h,0edh,000h,0dbh,000h	; 60e1
	defb 0ffh,009h,0ffh,012h,0ffh,024h	; 60e7

; ======================================================================
; CODIGO 0x60ed..0x6303  (534 bytes)
; ======================================================================


L_60ED:
	ld ix,0c082h		;60ed
	jp L_6106		;60f1
L_60F4:
	ld ix,0c01ah		;60f4
	jp L_6106		;60f8
L_60FB:
	ld ix,0c034h		;60fb
	jp L_6106		;60ff
L_6102:
	ld ix,0c04eh		;6102
L_6106:
	ld a,(0c09dh)		;6106
	cp 002h		;6109
	jp nz,L_6119		;610b
	ld a,(0c09eh)		;610e
	or a			;6111
	jp z,L_6119		;6112
	set 5,(ix+002h)		;6115
L_6119:
	ld a,(0c0b0h)		;6119
	or a			;611c
	jr z,L_6134		;611d
	ld a,(0c0b1h)		;611f
	inc a			;6122
	ld (0c0b1h),a		;6123
	cp 005h		;6126
	jr nz,L_6134		;6128
	xor a			;612a
	ld (0c0b1h),a		;612b
	dec (ix+009h)		;612e
	call z,L_61F1		;6131
L_6134:
	dec (ix+009h)		;6134
	jp z,L_61F1		;6137
	bit 0,(ix+002h)		;613a
	jp z,L_61DA		;613e
	bit 2,(ix+014h)		;6141
	call nz,L_6165		;6145
	ld a,(ix+009h)		;6148
	cp (ix+00bh)		;614b
	jp nc,L_6155		;614e
	cp (ix+006h)		;6151
	ret nc			;6154
L_6155:
	ld e,(ix+00ah)		;6155
	dec e			;6158
	ret m			;6159
	ld (ix+00ah),e		;615a
	bit 5,(ix+002h)		;615d
	ret nz			;6161
	jp L_609B		;6162
L_6165:
	bit 0,(ix+014h)		;6165
	jr nz,L_617B		;6169
	ld a,(ix+015h)		;616b
	inc a			;616e
	cp 00ah		;616f
	jp c,L_61BA		;6171
	inc (ix+014h)		;6174
	xor a			;6177
	jp L_61BA		;6178
L_617B:
	ld a,(ix+019h)		;617b
	and 0f0h		;617e
	rrca			;6180
	rrca			;6181
	rrca			;6182
	rrca			;6183
	ld e,a			;6184
	ld a,(ix+015h)		;6185
	inc a			;6188
	cp e			;6189
	jp c,L_61BA		;618a
	ld e,(ix+017h)		;618d
	ld d,(ix+018h)		;6190
	ld a,(ix+019h)		;6193
	and 00fh		;6196
	ld b,a			;6198
	ld a,(ix+016h)		;6199
	cpl			;619c
	ld (ix+016h),a		;619d
	and a			;61a0
	ld a,e			;61a1
	jr nz,L_61AB		;61a2
	add a,b			;61a4
	ld e,a			;61a5
	jr nc,L_61B0		;61a6
	inc d			;61a8
	jr L_61B0		;61a9
L_61AB:
	sub b			;61ab
	ld e,a			;61ac
	jr nc,L_61B0		;61ad
	dec d			;61af
L_61B0:
	ld (ix+017h),e		;61b0
	ld (ix+018h),d		;61b3
	call L_608F		;61b6
	xor a			;61b9
L_61BA:
	ld (ix+015h),a		;61ba
	ret			;61bd
L_61BE:
	bit 5,(ix+002h)		;61be
	ret nz			;61c2
	ld e,(ix+017h)		;61c3
	ld d,(ix+018h)		;61c6
	bit 6,(ix+002h)		;61c9
	jp z,L_61D1		;61cd
	inc de			;61d0
L_61D1:
	ld (ix+017h),e		;61d1
	ld (ix+018h),d		;61d4
	jp L_608F		;61d7
L_61DA:
	bit 5,(ix+002h)		;61da
	ret nz			;61de
	bit 7,(ix+002h)		;61df
	ret nz			;61e3
	call L_6454		;61e4
	ret nc			;61e7
	set 7,(ix+002h)		;61e8
	ld e,000h		;61ec
	jp L_609B		;61ee
L_61F1:
	ld l,(ix+000h)		;61f1
	ld h,(ix+001h)		;61f4
L_61F7:
	ld a,(hl)			;61f7
	inc hl			;61f8
	ld c,a			;61f9
	cp 0d0h		;61fa
	jp nc,L_6341		;61fc
	ld (ix+000h),l		;61ff
	ld (ix+001h),h		;6202
	cp 0c0h		;6205
	jp nc,L_631B		;6207
	and 00fh		;620a
	inc a			;620c
	ld b,a			;620d
	ld e,(ix+003h)		;620e
	xor a			;6211
	ld (ix+015h),a		;6212
	ld (ix+016h),a		;6215
	res 0,(ix+014h)		;6218
L_621C:
	add a,e			;621c
	djnz L_621C		;621d
	ld (ix+009h),a		;621f
	ld a,(0c09dh)		;6222
	cp 002h		;6225
	jp nz,L_6235		;6227
	ld a,(0c09eh)		;622a
	or a			;622d
	jp nz,L_6235		;622e
	res 5,(ix+002h)		;6231
L_6235:
	bit 0,(ix+002h)		;6235
	jp z,L_628F		;6239
	ld a,(ix+009h)		;623c
	sub (ix+005h)		;623f
	ld (ix+00bh),a		;6242
	bit 5,(ix+002h)		;6245
	ret nz			;6249
	ld a,c			;624a
	and 0f0h		;624b
	rrca			;624d
	rrca			;624e
	rrca			;624f
	ld hl,06303h		;6250
	add a,l			;6253
	ld l,a			;6254
	jr nc,L_6258		;6255
	inc h			;6257
L_6258:
	ld e,(hl)			;6258
	inc hl			;6259
	ld d,(hl)			;625a
	ld b,(ix+007h)		;625b
L_625E:
	srl d		;625e
	rr e		;6260
	djnz L_625E		;6262
	ld (ix+017h),e		;6264
	ld (ix+018h),d		;6267
	bit 6,(ix+002h)		;626a
	jp z,L_6272		;626e
	inc de			;6271
L_6272:
	ld (ix+017h),e		;6272
	ld (ix+018h),d		;6275
	call L_608F		;6278
	ld a,(0c0aah)		;627b
	add a,(ix+004h)		;627e
	jp p,L_6285		;6281
	xor a			;6284
L_6285:
	ld (ix+00ah),a		;6285
	ld e,a			;6288
	call L_609B		;6289
	jp L_60B8		;628c
L_628F:
	ld a,(ix+008h)		;628f
	cp 000h		;6292
	jr z,L_62C4		;6294
	cp 001h		;6296
	jr z,L_62E5		;6298
	cp 002h		;629a
	jr z,L_62EB		;629c
	cp 003h		;629e
	jr z,L_62F1		;62a0
	cp 004h		;62a2
	jr z,L_62F7		;62a4
	cp 005h		;62a6
	jr z,L_62FD		;62a8
	cp 006h		;62aa
	jr z,L_62BE		;62ac
	cp 007h		;62ae
	jr z,L_62B8		;62b0
	ld hl,08121h		;62b2
	jp L_62C7		;62b5
L_62B8:
	ld hl,08107h		;62b8
	jp L_62C7		;62bb
L_62BE:
	ld hl,080edh		;62be
	jp L_62C7		;62c1
L_62C4:
	ld hl,08051h		;62c4
L_62C7:
	ld a,c			;62c7
	and 0f0h		;62c8
	rrca			;62ca
	rrca			;62cb
	rrca			;62cc
	add a,l			;62cd
	ld l,a			;62ce
	jr nc,L_62D2		;62cf
	inc h			;62d1
L_62D2:
	ld a,(hl)			;62d2
	ld (ix+00ch),a		;62d3
	inc hl			;62d6
	ld a,(hl)			;62d7
	ld (ix+00dh),a		;62d8
	res 7,(ix+002h)		;62db
	ld a,001h		;62df
	ld (ix+00eh),a		;62e1
	ret			;62e4
L_62E5:
	ld hl,0806bh		;62e5
	jp L_62C7		;62e8
L_62EB:
	ld hl,08085h		;62eb
	jp L_62C7		;62ee
L_62F1:
	ld hl,0809fh		;62f1
	jp L_62C7		;62f4
L_62F7:
	ld hl,080b9h		;62f7
	jp L_62C7		;62fa
L_62FD:
	ld hl,080d3h		;62fd
	jp L_62C7		;6300

; ----------------------------------------------------------------------
; DATOS tonos_de_las_notas: las doce notas de la octava mas grave, una palabra
;   cada una con el periodo del PSG: p10:6250 la escoge por el nibble alto de
;   la nota y p10:625B la parte por dos tantas veces como diga la octava
;   (ix+7) (24 bytes)
;   0x6303..0x631b  (24 bytes)
DATA_tonos_de_las_notas:
	defb 0b8h,01ah	; 6303
	defb 038h,019h	; 6305
	defb 0d0h,017h	; 6307
	defb 078h,016h	; 6309
	defb 034h,015h	; 630b
	defb 004h,014h	; 630d
	defb 0e4h,012h	; 630f
	defb 0d4h,011h	; 6311
	defb 0d4h,010h	; 6313
	defb 0e4h,00fh	; 6315
	defb 000h,00fh	; 6317
	defb 028h,00eh	; 6319

; ======================================================================
; CODIGO 0x631b..0x6552  (567 bytes)
; ======================================================================


L_631B:
	and 00fh		;631b
	inc a			;631d
	ld b,a			;631e
	ld e,(ix+003h)		;631f
	xor a			;6322
L_6323:
	add a,e			;6323
	djnz L_6323		;6324
	ld (ix+009h),a		;6326
	res 0,(ix+005h)		;6329
	xor a			;632d
	ld (ix+015h),a		;632e
	ld (ix+016h),a		;6331
	bit 5,(ix+002h)		;6334
	ret nz			;6338
	ld e,000h		;6339
	ld (ix+00ah),e		;633b
	jp L_609B		;633e
L_6341:
	and 0f0h		;6341
	cp 0d0h		;6343
	jp z,L_63A1		;6345
	cp 0e0h		;6348
	jp z,L_63AA		;634a
	ld a,c			;634d
	and 00fh		;634e
	cp 00fh		;6350
	jp z,L_6434		;6352
	cp 00eh		;6355
	jp nz,L_637A		;6357
	ld a,(ix+010h)		;635a
	dec a			;635d
	jp z,L_6371		;635e
	jp p,L_6366		;6361
	ld a,(hl)			;6364
	dec a			;6365
L_6366:
	inc hl			;6366
	ld (ix+010h),a		;6367
	ld a,(hl)			;636a
	inc hl			;636b
	ld h,(hl)			;636c
	ld l,a			;636d
	jp L_61F7		;636e
L_6371:
	ld (ix+010h),a		;6371
	inc hl			;6374
	inc hl			;6375
	inc hl			;6376
	jp L_61F7		;6377
L_637A:
	ld c,a			;637a
	ld a,(0c0b2h)		;637b
	or a			;637e
	jp z,L_6386		;637f
	ld a,000h		;6382
	jr L_6389		;6384
L_6386:
	ld a,c			;6386
	inc a			;6387
	inc a			;6388
L_6389:
	ld (ix+004h),a		;6389
	ld a,(hl)			;638c
	rrca			;638d
	rrca			;638e
	rrca			;638f
	rrca			;6390
	and 00fh		;6391
	ld (ix+005h),a		;6393
	ld a,(hl)			;6396
	inc hl			;6397
	and 00fh		;6398
	inc a			;639a
	ld (ix+006h),a		;639b
	jp L_61F7		;639e
L_63A1:
	ld a,c			;63a1
	and 00fh		;63a2
	ld (ix+003h),a		;63a4
	jp L_61F7		;63a7
L_63AA:
	ld a,c			;63aa
	and 00fh		;63ab
	cp 006h		;63ad
	jp c,L_63F6		;63af
	jp z,L_6400		;63b2
	cp 007h		;63b5
	jp z,L_640F		;63b7
	cp 00ah		;63ba
	jp z,L_6416		;63bc
	cp 00bh		;63bf
	jp z,L_6408		;63c1
	cp 00dh		;63c4
	jp z,L_641D		;63c6
	cp 00eh		;63c9
	jp z,L_642B		;63cb
	cp 008h		;63ce
	jp z,L_63E3		;63d0
	cp 00ch		;63d3
	jr nz,L_63EF		;63d5
	set 2,(ix+014h)		;63d7
	ld a,(hl)			;63db
	inc hl			;63dc
	ld (ix+019h),a		;63dd
	jp L_61F7		;63e0
L_63E3:
	res 0,(ix+002h)		;63e3
	ld a,(hl)			;63e7
	inc hl			;63e8
	ld (ix+008h),a		;63e9
	jp L_61F7		;63ec
L_63EF:
	set 0,(ix+002h)		;63ef
	jp L_61F7		;63f3
L_63F6:
	neg		;63f6
	add a,006h		;63f8
	ld (ix+007h),a		;63fa
	jp L_61F7		;63fd
L_6400:
	ld a,001h		;6400
	ld (0c0ach),a		;6402
	jp L_61F7		;6405
L_6408:
	xor a			;6408
	ld (0c0ach),a		;6409
	jp L_61F7		;640c
L_640F:
	set 6,(ix+002h)		;640f
	jp L_61F7		;6413
L_6416:
	ld a,(hl)			;6416
	inc hl			;6417
	ld h,(hl)			;6418
	ld l,a			;6419
	jp L_61F7		;641a
L_641D:
	ld e,(hl)			;641d
	inc hl			;641e
	ld d,(hl)			;641f
	inc hl			;6420
	ld (ix+012h),l		;6421
	ld (ix+013h),h		;6424
	ex de,hl			;6427
	jp L_61F7		;6428
L_642B:
	ld l,(ix+012h)		;642b
	ld h,(ix+013h)		;642e
	jp L_61F7		;6431
L_6434:
	ld a,(0c09dh)		;6434
	inc a			;6437
	ld b,a			;6438
	ld a,07fh		;6439
L_643B:
	rlca			;643b
	djnz L_643B		;643c
	ld b,a			;643e
	ld a,(0c0abh)		;643f
	and b			;6442
	ld (0c0abh),a		;6443
	jp L_6067		;6446
L_6449:
	ld ix,0c068h		;6449
	call L_6454		;644d
	ret nc			;6450
	jp L_6067		;6451
L_6454:
	dec (ix+00eh)		;6454
	jp nz,L_654E		;6457
	ld a,(ix+00fh)		;645a
	ld (ix+00eh),a		;645d
	ld l,(ix+00ch)		;6460
	ld h,(ix+00dh)		;6463
L_6466:
	ld a,(hl)			;6466
	cp 0ffh		;6467
	jp z,L_6550		;6469
	inc hl			;646c
	ld c,a			;646d
	cp 0feh		;646e
	jp z,L_64D5		;6470
	and 0f0h		;6473
	cp 020h		;6475
	jp z,L_64F5		;6477
	cp 010h		;647a
	jp nz,L_648E		;647c
	ld a,c			;647f
	and 00fh		;6480
	rlca			;6482
	ld e,a			;6483
	ld a,006h		;6484
	call 00093h		;6486   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(hl)			;6489
	inc hl			;648a
	ld c,a			;648b
	and 0f0h		;648c
L_648E:
	rrca			;648e
	rrca			;648f
	rrca			;6490
	rrca			;6491
	ld e,a			;6492
	bit 4,(ix+00ah)		;6493
	jp z,L_64A2		;6497
	ld a,00dh		;649a
	call 00093h		;649c   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_64C6		;649f
L_64A2:
	bit 0,(ix+002h)		;64a2
	jr nz,L_64B2		;64a6
	ld a,(0c0b2h)		;64a8
	or a			;64ab
	jr z,L_64B2		;64ac
	ld e,000h		;64ae
	jr L_64C3		;64b0
L_64B2:
	ld a,(0c09dh)		;64b2
	cp 003h		;64b5
	jp nc,L_64C3		;64b7
	ld a,(0c0aah)		;64ba
	add a,e			;64bd
	jp p,L_64C2		;64be
	xor a			;64c1
L_64C2:
	ld e,a			;64c2
L_64C3:
	call L_609B		;64c3
L_64C6:
	ld a,c			;64c6
	and 00fh		;64c7
	ld d,a			;64c9
	ld e,(hl)			;64ca
	inc hl			;64cb
	ld (ix+00ch),l		;64cc
	ld (ix+00dh),h		;64cf
	jp L_608F		;64d2
L_64D5:
	ld a,(ix+011h)		;64d5
	dec a			;64d8
	jp z,L_64EC		;64d9
	jp p,L_64E1		;64dc
	ld a,(hl)			;64df
	dec a			;64e0
L_64E1:
	inc hl			;64e1
	ld (ix+011h),a		;64e2
	ld a,(hl)			;64e5
	inc hl			;64e6
	ld h,(hl)			;64e7
	ld l,a			;64e8
	jp L_6466		;64e9
L_64EC:
	ld (ix+011h),a		;64ec
	inc hl			;64ef
	inc hl			;64f0
	inc hl			;64f1
	jp L_6466		;64f2
L_64F5:
	bit 0,c		;64f5
	jp nz,L_650B		;64f7
	bit 1,c		;64fa
	jp nz,L_6505		;64fc
	call L_60A3		;64ff
	jp L_6519		;6502
L_6505:
	call L_60B8		;6505
	jp L_6519		;6508
L_650B:
	bit 1,c		;650b
	jp nz,L_6516		;650d
	call L_60B1		;6510
	jp L_6519		;6513
L_6516:
	call L_60AA		;6516
L_6519:
	ld a,c			;6519
	rlca			;651a
	and 010h		;651b
	ld (ix+00ah),a		;651d
	ld e,a			;6520
	call L_609B		;6521
	ld a,(hl)			;6524
	inc hl			;6525
	ld (ix+00eh),a		;6526
	ld (ix+00fh),a		;6529
	ld a,c			;652c
	cp 020h		;652d
	jp z,L_6548		;652f
	cp 028h		;6532
	jp c,L_6466		;6534
	ld e,(hl)			;6537
	inc hl			;6538
	ld a,00ch		;6539
	call 00093h		;653b   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,(hl)			;653e
	inc hl			;653f
	ld a,00bh		;6540
	call 00093h		;6542   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_6466		;6545
L_6548:
	ld (ix+00ch),l		;6548
	ld (ix+00dh),h		;654b
L_654E:
	or a			;654e
	ret			;654f
L_6550:
	scf			;6550
	ret			;6551

; ----------------------------------------------------------------------
; DATOS efectos_de_sonido: 32 punteros, los de los efectos 0x01-0x20 (p00:50DF
;   suma el doble del numero a 0x6550: la palabra del 0 serian los bytes 37 C9
;   de `scf / ret` de p10:6550, y no se lee porque p00:5009 para el sonido con
;   el 0): la lista de cuadros del canal de efectos que p00:50E7 deja en
;   0xC074; lo leen p00:50DF (64 bytes)
;   0x6552..0x6592  (64 bytes)
DATA_efectos_de_sonido:
	defb 0ech,068h,0bbh,06ah,069h,068h,041h,068h,0dfh,068h,0b4h,069h,07dh,06ah,0f6h,069h	; 6552  .h.jihAh.h.i}j.i
	defb 0d5h,06ah,057h,068h,0f9h,068h,02ah,069h,0cfh,069h,082h,066h,0bdh,068h,021h,06ah	; 6562  .jWh.h*i.i.f.h!j
	defb 0c4h,068h,08dh,069h,028h,068h,04bh,066h,09ch,068h,0a3h,066h,0d1h,066h,022h,067h	; 6572  .h.i(hKf.h.f.f"g
	defb 0c7h,067h,009h,068h,0fah,067h,005h,06ah,012h,06ah,04eh,06ah,0eah,06ah,03ch,066h	; 6582  .g.h.g.j.jNj.j<f

; ----------------------------------------------------------------------
; DATOS musicas: 28 musicas (0x80-0x9B) de tres punteros cada una, la
;   partitura de cada canal del PSG, que p00:5064 deja en 0xC01A, 0xC034 y
;   0xC04E; lo leen p00:505C (168 bytes)
;   0x6592..0x663a  (168 bytes)
DATA_musicas:
	defb 075h,07ch,092h,07ch,0b1h,07ch,090h,07ah,028h,07ah,0b3h,07ah,082h,06bh,072h,06ch	; 6592  u|.|.|.z(z.z.krl
	defb 064h,06dh,068h,06eh,0e8h,06eh,090h,06fh,018h,072h,034h,071h,061h,070h,0a1h,073h	; 65a2  dmhn.n.o.r4qap.s
	defb 0fch,072h,093h,074h,04ah,075h,0dbh,075h,0a7h,076h,06eh,077h,046h,079h,04ch,078h	; 65b2  .r.tJu.u.vnwFyLx
	defb 00fh,07bh,06bh,07bh,0d2h,07bh,074h,07ch,073h,07ch,074h,07ch,0feh,07ch,0cdh,07ch	; 65c2  .{k{.{t|s|t|.|.|
	defb 03ch,07dh,0adh,07dh,075h,07dh,093h,07dh,068h,07eh,0deh,07dh,0c7h,07dh,07ch,07fh	; 65d2  <}.}u}.}h~.}.}|.
	defb 017h,07fh,0b4h,07eh,0dah,07fh,003h,080h,02fh,080h,0ebh,06ah,007h,06bh,00eh,06bh	; 65e2  ...~..../..j.k.k
	defb 015h,06bh,01ch,06bh,021h,06bh,08ah,07ah,022h,07ah,0afh,07ah,029h,06bh,030h,06bh	; 65f2  .k.k!k.z"z.z)k0k
	defb 037h,06bh,05eh,06bh,063h,06bh,068h,06bh,03eh,06bh,043h,06bh,048h,06bh,04dh,06bh	; 6602  7k^kckhk>kCkHkMk
	defb 055h,06bh,05dh,06bh,069h,06bh,06eh,06bh,073h,06bh,0ebh,06ah,007h,06bh,00eh,06bh	; 6612  Uk]kiknksk.j.k.k
	defb 069h,068h,09bh,068h,050h,080h,07dh,06ah,0bah,06ah,050h,080h,02ah,069h,08ch,069h	; 6622  ih.hP.}j.jP.*i.i
	defb 050h,080h,050h,080h,050h,080h,050h,080h	; 6632  P.P.P.P.

; ----------------------------------------------------------------------
; DATOS musica_9C_a_medias: el primer puntero de una musica 0x9C (0x8050, el
;   silencio, como los de la 0x9B): detras ya empieza el efecto 0x20 en
;   0x663C, asi que esa musica no existe; nadie pide mas alla de la 0x96 (2
;   bytes)
;   0x663a..0x663c  (2 bytes)
DATA_musica_9C_a_medias:
	defb 050h,080h	; 663a

; ----------------------------------------------------------------------
; DATOS efecto_663C: cuadros de un efecto de sonido que interpreta p10:6454
;   (volumen y tono, ruido, mezcla y repeticiones; ver tools/bloques.py); lo
;   leen p10:6454 (556 bytes)
;   0x663c..0x6868  (556 bytes)
DATA_efecto_663C:
	defb 02bh,008h,001h,0aah,018h,0e0h,000h,02bh,003h,001h,044h,01ah,090h,000h,0ffh,022h	; 663c  +......+..D...."
	defb 001h,0c0h,0f0h,0d0h,0e0h,0e0h,090h,0e0h,070h,0e0h,070h,0e0h,050h,0e0h,030h,0d0h	; 664c  ........p.p.P.0.
	defb 090h,0d0h,080h,022h,002h,0d0h,070h,0d0h,060h,0d0h,050h,0d0h,040h,0c0h,070h,0c0h	; 665c  ..."..p.`.P.@.p.
	defb 050h,0c0h,030h,0b0h,060h,0b0h,050h,0b0h,040h,0b0h,030h,0b0h,020h,0a0h,070h,0a0h	; 666c  P.0.`.P.@.0. .p.
	defb 060h,0a0h,040h,0a0h,020h,0ffh,022h,001h,0e3h,000h,0e2h,000h,0e1h,000h,0e0h,020h	; 667c  `.@. ."........
	defb 000h,000h,0d2h,020h,0d0h,080h,0c1h,0f0h,0c0h,050h,0b1h,0e0h,0a0h,040h,091h,0d0h	; 668c  ... .....P...@..
	defb 080h,030h,071h,0b0h,060h,020h,0ffh,022h,001h,0f1h,0f0h,0e1h,050h,0f2h,0a0h,020h	; 669c  .0q.` ."....P..
	defb 003h,023h,001h,01ah,0e4h,000h,020h,002h,022h,001h,0e8h,000h,020h,002h,022h,001h	; 66ac  .#.... ."... .".
	defb 0d4h,000h,000h,000h,023h,001h,0c9h,0a0h,020h,003h,022h,002h,0bch,000h,000h,000h	; 66bc  ....#... .".....
	defb 022h,001h,0aah,000h,0ffh,022h,001h,070h,0f8h,060h,0f5h,080h,0f7h,070h,0f5h,090h	; 66cc  "....".p.`...p..
	defb 0f6h,0a0h,0f4h,0a0h,0f5h,090h,0f3h,070h,0f3h,0b0h,0f1h,0c0h,0f1h,0a0h,0f2h,0d0h	; 66dc  .......p........
	defb 0f0h,0e0h,0f1h,0e0h,0f0h,0e0h,0f2h,0f0h,0eeh,0e0h,0edh,0f0h,0ech,0d0h,0ebh,0e0h	; 66ec  ................
	defb 0eah,0f0h,0ebh,0d0h,0e8h,0c0h,0e7h,0c0h,0e6h,0a0h,0e5h,0b0h,0e4h,090h,0e3h,0a0h	; 66fc  ................
	defb 0e2h,0a0h,0e3h,090h,0e0h,090h,0e1h,080h,0deh,080h,0dch,070h,0dah,070h,0dbh,060h	; 670c  ...........p.p.`
	defb 0dah,060h,0f8h,050h,0d8h,0ffh,022h,001h,0f1h,01dh,0e1h,01dh,0d1h,025h,0c1h,025h	; 671c  .`.P.."......%.%
	defb 0b1h,02eh,0a1h,02eh,091h,037h,0f1h,053h,0e1h,053h,0d1h,05dh,0c1h,05dh,0b1h,067h	; 672c  .....7.S.S.].].g
	defb 0a1h,067h,091h,072h,0f1h,0abh,0e1h,0abh,0d1h,0b8h,0c1h,0b8h,0b1h,0c5h,0a1h,0c5h	; 673c  .g.r............
	defb 091h,0d3h,0f1h,053h,0e1h,053h,0d1h,05dh,0c1h,05dh,0b1h,067h,0a1h,067h,091h,072h	; 674c  ...S.S.].].g.g.r
	defb 0f1h,0abh,0e1h,0abh,0d1h,0b8h,0c1h,0b8h,0b1h,0a5h,0a1h,0c5h,091h,0d3h,0f2h,03bh	; 675c  ...............;
	defb 0e2h,03bh,0d2h,04ch,0c2h,04ch,0b2h,05eh,0a2h,05eh,092h,070h,0f2h,0cfh,0d2h,0cfh	; 676c  .;.L.L.^.^.p....
	defb 0b2h,0e5h,092h,0e5h,072h,0fch,0f2h,0fch,0d3h,013h,0b3h,013h,093h,02bh,073h,02bh	; 677c  ....r........+s+
	defb 0f3h,044h,0d3h,044h,0b3h,05eh,093h,05eh,073h,078h,0f3h,078h,0d3h,093h,0b3h,093h	; 678c  .D.D.^.^sx.x....
	defb 093h,0afh,073h,0afh,0f3h,0cch,0d3h,0cch,0b3h,0eah,093h,0eah,074h,009h,0f4h,009h	; 679c  ..s.........t...
	defb 0d4h,029h,0b4h,029h,094h,04ah,074h,04ah,0f4h,06ch,0d4h,06ch,0b4h,08fh,094h,08fh	; 67ac  .).).JtJ.l.l....
	defb 074h,0b3h,0f4h,0b3h,0d4h,0d8h,0b4h,0d8h,094h,0fdh,0ffh,022h,001h,060h,018h,0a0h	; 67bc  t..........".`..
	defb 017h,000h,000h,0e0h,018h,0f0h,017h,0f0h,018h,000h,000h,0e0h,017h,000h,000h,0f0h	; 67cc  ................
	defb 018h,0d0h,017h,000h,000h,0c0h,018h,0b0h,017h,000h,000h,0a0h,018h,000h,000h,090h	; 67dc  ................
	defb 017h,080h,018h,000h,000h,070h,017h,020h,002h,0feh,003h,0c7h,067h,0ffh,022h,002h	; 67ec  .....p. ....g.".
	defb 0e0h,0a0h,0e0h,0a9h,0e0h,0beh,0e0h,0d5h,0e0h,0e2h,0e0h,0fdh,0ffh,022h,001h,0e0h	; 67fc  ............."..
	defb 0d5h,0e0h,0beh,0e0h,0a9h,0e0h,0a0h,0e0h,08eh,0e0h,07fh,0e0h,071h,0e0h,06ah,0e0h	; 680c  ............q.j.
	defb 05fh,0e0h,054h,0e0h,050h,0e0h,047h,0c0h,03fh,0a0h,038h,0ffh,02ah,002h,00ch,000h	; 681c  _.T.P.G.?.8.*...
	defb 090h,0d5h,090h,0a0h,090h,07fh,090h,0a0h,090h,07fh,090h,06ah,090h,054h,090h,047h	; 682c  ...........j.T.G
	defb 090h,03fh,090h,038h,0ffh,021h,004h,01ah,0a0h,000h,0c0h,000h,0e0h,000h,0d0h,000h	; 683c  .?.8.!..........
	defb 0c0h,000h,0b0h,000h,0a0h,000h,090h,000h,080h,000h,0ffh,022h,001h,0f0h,0c0h,000h	; 684c  ..........."....
	defb 000h,000h,000h,000h,000h,000h,000h,0f0h,0f0h,0d1h,00eh,0ffh	; 685c  ............

; ----------------------------------------------------------------------
; DATOS ff_de_mas_6868: un segundo 0xFF detras del que acaba el efecto de
;   0x6867; el interprete se para en el primero y este no lo lee nadie (1
;   byte)
;   0x6868..0x6869  (1 bytes)
DATA_ff_de_mas_6868:
	defb 0ffh	; 6868

; ----------------------------------------------------------------------
; DATOS partitura_6869: partitura que interpreta p10:61F1 (nota, silencio,
;   tiempo, octava, saltos, llamadas y repeticiones; ver tools/bloques.py); se
;   solapan 4 bloques (0x6869-0x689C, 0x6869-0x6ABA, 0x692A-0x698D,
;   0x6A7D-0x6ABB); lo leen p10:61F1, p10:6454 (594 bytes)
;   0x6869..0x6abb  (594 bytes)
DATA_partitura_6869:
	defb 022h,001h,0c1h,000h,0d1h,048h,0e1h,0c8h,0e2h,010h,0e3h,059h,0e3h,020h,0e3h,068h	; 6869  "....H.....Y. .h
	defb 0e2h,030h,0e3h,078h,0d3h,040h,0c3h,088h,0d2h,050h,0c1h,000h,0b1h,048h,0a1h,0c8h	; 6879  .0.x.@...P...H..
	defb 092h,010h,083h,058h,073h,0fah,073h,0fch,072h,030h,073h,078h,073h,040h,063h,088h	; 6889  ...Xs.s.r0sxs@c.
	defb 063h,050h,0ffh,022h,001h,0f0h,080h,0e0h,070h,0d0h,060h,0c0h,050h,0a0h,040h,0f0h	; 6899  cP."....p.`.P.@.
	defb 030h,0a0h,080h,0a0h,070h,0a0h,062h,0a0h,056h,0a0h,04ch,0a0h,043h,0a0h,03bh,0a0h	; 68a9  0...p.b.V.L.C.;.
	defb 034h,0a0h,02eh,0ffh,022h,001h,0e0h,04fh,0e0h,047h,0ffh,022h,001h,0e0h,06ah,0d0h	; 68b9  4..."..O.G."..j.
	defb 06ah,0c0h,06ah,0d0h,054h,0c0h,054h,0a0h,054h,0c0h,047h,0b0h,047h,0a0h,047h,0b0h	; 68c9  j.j.T.T.T.G.G.G.
	defb 035h,090h,035h,060h,025h,0ffh,022h,001h,0f0h,0b3h,0e0h,066h,0d0h,03ah,0c0h,021h	; 68d9  5.5`%."....f.:.!
	defb 0b0h,013h,0ffh,022h,001h,0f0h,0abh,0f0h,096h,0e0h,084h,0e0h,074h,0d0h,066h,0ffh	; 68e9  ..."........t.f.
	defb 022h,001h,0e1h,080h,0a0h,050h,0e1h,080h,0d0h,0a0h,0d0h,0fah,0c0h,080h,0c0h,0c8h	; 68f9  "....P..........
	defb 0b0h,0a0h,0b0h,0fah,0a0h,080h,0a0h,0c8h,090h,0a0h,090h,0fah,080h,080h,080h,0c8h	; 6909  ................
	defb 070h,0a0h,070h,0fah,060h,080h,060h,0c8h,050h,0a0h,050h,0fah,040h,080h,040h,0c8h	; 6919  p.p.`.`.P.P.@.@.
	defb 0ffh,022h,001h,0f1h,000h,0f2h,040h,0f5h,010h,0f3h,000h,0f6h,0c0h,0fdh,030h,0e1h	; 6929  ."....@.......0.
	defb 000h,0e2h,040h,0e5h,010h,0b3h,000h,0b2h,0d0h,0b2h,0a3h,0c1h,000h,0c0h,0f0h,0c0h	; 6939  ..@.............
	defb 0e1h,0b3h,000h,0b2h,0d0h,0b2h,0a3h,0a1h,000h,0a0h,0f0h,0a0h,0e1h,083h,000h,082h	; 6949  ................
	defb 0d0h,082h,0a3h,091h,000h,090h,0f0h,090h,0e1h,073h,000h,072h,0d0h,072h,0a3h,081h	; 6959  .........s.r.r..
	defb 000h,080h,0f0h,080h,0e1h,073h,000h,072h,0d0h,072h,0a3h,063h,000h,062h,0d0h,062h	; 6969  .....s.r.r.c.b.b
	defb 0a3h,051h,000h,050h,0f0h,050h,0e1h,043h,000h,042h,0d0h,042h,0a3h,031h,000h,030h	; 6979  .Q.P.P.C.B.B.1.0
	defb 0f0h,030h,0e1h,0ffh,022h,003h,090h,0ebh,02ah,002h,006h,000h,090h,0b5h,090h,0a5h	; 6989  .0.."...*.......
	defb 090h,095h,090h,085h,090h,0b5h,090h,0a5h,090h,095h,090h,085h,090h,075h,090h,074h	; 6999  .............u.t
	defb 090h,060h,090h,057h,090h,052h,090h,048h,090h,043h,0ffh,022h,001h,0e0h,0a0h,0b0h	; 69a9  .`.W.R.H.C."....
	defb 0a8h,0c0h,003h,0b0h,0b0h,0e0h,003h,0e0h,0b8h,0b0h,003h,0e0h,070h,0b0h,020h,0e0h	; 69b9  ............p. .
	defb 078h,0e0h,027h,0b0h,031h,0ffh,022h,001h,0f0h,071h,0f0h,071h,0f0h,08dh,0e0h,0b0h	; 69c9  x.'.1."..q.q....
	defb 0f0h,0b3h,0f0h,0e2h,0f1h,01dh,0e1h,068h,0e1h,0c7h,0e2h,03eh,0d2h,0d5h,0d3h,094h	; 69d9  .......h...>....
	defb 0d4h,086h,0c5h,0b8h,0c7h,03ch,0c9h,027h,0bbh,094h,0beh,0a6h,0ffh,022h,001h,0b0h	; 69e9  .....<.'....."..
	defb 0a0h,0e0h,003h,0e0h,018h,0e0h,003h,0e0h,0b0h,0e0h,003h,0ffh,022h,001h,0e0h,064h	; 69f9  ............"..d
	defb 0b0h,058h,070h,058h,050h,058h,030h,058h,0ffh,022h,001h,0f0h,054h,0c0h,048h,080h	; 6a09  .XpXPX0X."..T.H.
	defb 048h,060h,048h,050h,048h,040h,048h,0ffh,022h,001h,050h,018h,090h,017h,000h,000h	; 6a19  H`HPH@H.".P.....
	defb 0e0h,018h,0f0h,017h,0f0h,018h,000h,000h,0e0h,017h,000h,000h,0f0h,018h,0d0h,017h	; 6a29  ................
	defb 000h,000h,0b0h,018h,0a0h,017h,000h,000h,090h,018h,000h,000h,080h,017h,070h,018h	; 6a39  ..............p.
	defb 000h,000h,060h,017h,0ffh,022h,002h,0d0h,070h,0d0h,062h,0d0h,056h,0d0h,04ch,0d0h	; 6a49  ..`.."..p.b.V.L.
	defb 043h,0c0h,070h,0c0h,062h,0c0h,056h,0c0h,04ch,0c0h,043h,0b0h,070h,0b0h,062h,0b0h	; 6a59  C.p.b.V.L.C.p.b.
	defb 056h,0b0h,04ch,0b0h,043h,0d0h,040h,0d0h,038h,0d0h,031h,0d0h,02bh,0d0h,026h,0d0h	; 6a69  V.L.C.@.8.1.+.&.
	defb 022h,0d0h,01eh,0ffh,022h,001h,0f2h,05bh,0e2h,003h,0a1h,0cdh,000h,000h,0b1h,05bh	; 6a79  "..."..[.......[
	defb 0b1h,0b6h,0b2h,029h,0b2h,0bbh,0b3h,074h,0a1h,003h,0a1h,047h,0a1h,09ch,0a2h,008h	; 6a89  ...)...t...G....
	defb 0a2h,092h,090h,0cdh,091h,002h,091h,046h,091h,09bh,091h,0ceh,081h,05bh,081h,0b6h	; 6a99  .......F.....[..
	defb 082h,029h,082h,0bbh,083h,074h,071h,003h,071h,047h,071h,09ch,072h,008h,072h,092h	; 6aa9  .)...tq.qGq.r.r.
	defb 0ffh,0ffh	; 6ab9

; ----------------------------------------------------------------------
; DATOS efecto_6ABB: cuadros de un efecto de sonido que interpreta p10:6454
;   (volumen y tono, ruido, mezcla y repeticiones; ver tools/bloques.py); lo
;   leen p10:6454 (48 bytes)
;   0x6abb..0x6aeb  (48 bytes)
DATA_efecto_6ABB:
	defb 023h,001h,010h,0c0h,000h,022h,001h,0e0h,01ah,0b0h,023h,0a0h,026h,080h,029h,090h	; 6abb  #...."....#.&.).
	defb 02ch,080h,02fh,020h,003h,0feh,002h,0bbh,06ah,0ffh,022h,001h,0f0h,020h,0c0h,06ah	; 6acb  ,./ ....j.".. .j
	defb 0b0h,050h,0a0h,04bh,090h,038h,080h,02fh,070h,028h,0c0h,01ch,0c0h,01ch,0ffh,0ffh	; 6adb  .P.K.8./p(......

; ----------------------------------------------------------------------
; DATOS partitura_6AEB: partitura que interpreta p10:61F1 (nota, silencio,
;   tiempo, octava, saltos, llamadas y repeticiones; ver tools/bloques.py); lo
;   leen p10:61F1 (41 bytes)
;   0x6aeb..0x6b14  (41 bytes)
DATA_partitura_6AEB:
	defb 0d2h,0c7h,0e8h,008h,05ch,0d1h,0e8h,008h,06dh,06dh,069h,069h,068h,068h,067h,066h	; 6aeb  ....\...mmiihhgf
	defb 065h,064h,063h,064h,066h,068h,06bh,0cbh,056h,05eh,0c0h,0ffh,0d1h,0c0h,0feh,002h	; 6afb  edcdfhk.V^......
	defb 0ebh,06ah,0ffh,0d2h,0c8h,0e8h,008h,05ch,0ffh	; 6b0b  .j.....\.

; ----------------------------------------------------------------------
; DATOS ff_de_mas_6B14: un segundo 0xFF detras del que acaba la partitura de
;   0x6B13; no lo lee nadie (1 byte)
;   0x6b14..0x6b15  (1 bytes)
DATA_ff_de_mas_6B14:
	defb 0ffh	; 6b14

; ----------------------------------------------------------------------
; DATOS partitura_6B15: partitura que interpreta p10:61F1 (nota, silencio,
;   tiempo, octava, saltos, llamadas y repeticiones; ver tools/bloques.py); lo
;   leen p10:61F1 (19 bytes)
;   0x6b15..0x6b28  (19 bytes)
DATA_partitura_6B15:
	defb 0d1h,0c1h,0d6h,0e8h,006h,00fh,0ffh,0d6h,0e8h,006h,01fh,0ffh,0d1h,0c0h,0d6h,0e8h	; 6b15  ................
	defb 006h,00ah,0ffh	; 6b25

; ----------------------------------------------------------------------
; DATOS ff_de_mas_6B28: un segundo 0xFF detras del que acaba la partitura de
;   0x6B27; no lo lee nadie (1 byte)
;   0x6b28..0x6b29  (1 bytes)
DATA_ff_de_mas_6B28:
	defb 0ffh	; 6b28

; ----------------------------------------------------------------------
; DATOS partitura_6B29: partitura que interpreta p10:61F1 (nota, silencio,
;   tiempo, octava, saltos, llamadas y repeticiones; ver tools/bloques.py); lo
;   leen p10:61F1 (88 bytes)
;   0x6b29..0x6b81  (88 bytes)
DATA_partitura_6B29:
	defb 0d1h,0c4h,0d8h,0e8h,006h,04fh,0ffh,0d1h,0c4h,0d8h,0e8h,006h,05fh,0ffh,0d1h,0c4h	; 6b29  .....O......_...
	defb 0d8h,0e8h,006h,06fh,0ffh,0d6h,0e8h,006h,07fh,0ffh,0d6h,0e8h,006h,08fh,0ffh,0d6h	; 6b39  ...o............
	defb 0e8h,006h,09fh,0ffh,0d6h,0e8h,006h,0a7h,0d3h,0c1h,0afh,0ffh,0d6h,0e8h,006h,0b7h	; 6b49  ................
	defb 0d3h,0c1h,0bfh,0ffh,0ffh,0d6h,0e8h,007h,00fh,0ffh,0d6h,0e8h,007h,01fh,0ffh,0ffh	; 6b59  ................
	defb 0d6h,0e8h,007h,085h,0ffh,0d6h,0e8h,007h,095h,0ffh,0ffh,0d1h,0fdh,088h,0e1h,004h	; 6b69  ................
	defb 074h,044h,074h,0fdh,023h,0e0h,009h,0ffh	; 6b79  tDt.#...

; ----------------------------------------------------------------------
; DATOS ff_de_mas_6B81: un segundo 0xFF detras del que acaba la musica de la
;   pausa (0x6B74, p00:5182); no lo lee nadie (1 byte)
;   0x6b81..0x6b82  (1 bytes)
DATA_ff_de_mas_6B81:
	defb 0ffh	; 6b81

; ----------------------------------------------------------------------
; DATOS partitura_6B82: partitura que interpreta p10:61F1 (nota, silencio,
;   tiempo, octava, saltos, llamadas y repeticiones; ver tools/bloques.py); lo
;   leen p10:61F1 (5246 bytes)
;   0x6b82..0x8000  (5246 bytes)
DATA_partitura_6B82:
	defb 0d6h,0fch,031h,0e2h,041h,0e3h,0b0h,0e2h,020h,041h,090h,050h,040h,0c0h,040h,040h	; 6b82  ..1.A... A.P@.@@
	defb 043h,0d4h,0fah,010h,0e1h,040h,050h,040h,050h,040h,050h,040h,050h,040h,050h,040h	; 6b92  C....@P@P@P@P@P@
	defb 050h,0d4h,0fah,000h,0e1h,020h,040h,020h,0d6h,0fbh,010h,0e2h,0b0h,0e1h,020h,043h	; 6ba2  P.... @ ...... C
	defb 0d6h,0fch,041h,0e3h,091h,090h,090h,041h,091h,091h,090h,090h,041h,091h,091h,090h	; 6bb2  ..A....A....A...
	defb 090h,041h,091h,091h,090h,090h,041h,091h,021h,020h,020h,021h,020h,020h,021h,020h	; 6bc2  .A....A.!  !  !
	defb 020h,021h,020h,020h,021h,020h,020h,021h,020h,020h,021h,040h,040h,051h,091h,042h	; 6bd2   !  !  !  !@@Q.B
	defb 040h,0e4h,0b1h,0e3h,021h,041h,040h,040h,051h,091h,0b1h,0d6h,0fah,001h,0e2h,040h	; 6be2  @...!A@@Q......@
	defb 041h,051h,091h,0b1h,091h,0b1h,0e1h,020h,0d6h,0fch,033h,0e2h,0b2h,0b0h,091h,060h	; 6bf2  AQ..... ..3....`
	defb 090h,0b2h,0c0h,0e3h,043h,0fch,042h,0e3h,021h,0e2h,090h,090h,0e3h,021h,0e2h,090h	; 6c02  ....C.B.!....!..
	defb 090h,0e3h,021h,0e2h,090h,090h,0e3h,021h,0e2h,090h,090h,0e3h,021h,0e2h,020h,020h	; 6c12  ..!....!....!.
	defb 021h,020h,020h,021h,020h,020h,021h,020h,020h,021h,020h,020h,0e3h,090h,0b0h,0e2h	; 6c22  !  !  !  !  ....
	defb 021h,021h,020h,020h,0e3h,090h,0b0h,0e2h,021h,0e3h,041h,040h,040h,0e4h,0b1h,0e3h	; 6c32  !!  ....!.A@@...
	defb 021h,041h,040h,040h,091h,051h,041h,040h,040h,0e4h,0b1h,0e3h,021h,041h,040h,040h	; 6c42  !A@@.QA@@...!A@@
	defb 041h,0c1h,041h,040h,040h,0e4h,0b1h,0e3h,021h,041h,040h,040h,091h,051h,041h,040h	; 6c52  A.A@@...!A@@.QA@
	defb 040h,021h,0e4h,0b0h,0e3h,020h,041h,040h,040h,041h,0c1h,0feh,0feh,0b2h,06bh,0ffh	; 6c62  @!... A@@A....k.
	defb 0e7h,0d6h,0fah,000h,0ech,042h,0e2h,0b3h,0d4h,0fah,000h,0b0h,0e1h,000h,0e2h,0b0h	; 6c72  .....B..........
	defb 0d6h,0fbh,010h,040h,090h,0d6h,0fbh,000h,0ech,051h,0b7h,0ech,042h,0e3h,041h,0e2h	; 6c82  ...@.....Q..B.A.
	defb 040h,050h,091h,0b1h,0d4h,0fah,010h,0e2h,090h,0b0h,090h,0d6h,0fah,033h,050h,090h	; 6c92  @P...........3P.
	defb 0ech,032h,0b3h,0ech,000h,0fbh,051h,0e1h,0c1h,041h,041h,001h,041h,001h,0e2h,0b1h	; 6ca2  .2....Q..AA.A...
	defb 0e1h,001h,0c1h,041h,041h,001h,040h,050h,040h,000h,0e2h,0b1h,091h,0c1h,0b1h,0b1h	; 6cb2  ...AA.@P@.......
	defb 091h,0b1h,091h,051h,091h,0c1h,0b1h,0b1h,091h,0b1h,091h,051h,021h,0fbh,041h,042h	; 6cc2  ...Q.......Q!.AB
	defb 040h,051h,091h,0fbh,022h,0ech,041h,0b7h,0c1h,0fah,002h,041h,051h,091h,0b1h,091h	; 6cd2  @Q..".A....AQ...
	defb 0b1h,0e1h,021h,0fbh,041h,0ech,000h,042h,040h,021h,0e2h,0b0h,0e1h,020h,0ech,081h	; 6ce2  ..!.A..B@!... ..
	defb 044h,0c0h,041h,0ech,000h,0fbh,035h,0e3h,091h,0e1h,020h,020h,0e3h,091h,0e1h,020h	; 6cf2  D.A...5...  ...
	defb 020h,0e3h,091h,0e1h,020h,020h,0e3h,091h,0e1h,020h,020h,0c1h,0fch,051h,020h,020h	; 6d02   ...  ...  ..Q
	defb 021h,041h,051h,091h,051h,041h,0d3h,0fah,010h,0b3h,090h,0b0h,0d6h,0fbh,051h,090h	; 6d12  !AQ.QA........Q.
	defb 0b1h,091h,051h,091h,051h,040h,020h,0e8h,008h,003h,003h,001h,010h,010h,013h,001h	; 6d22  ..Q.Q@ .........
	defb 010h,010h,011h,011h,011h,000h,000h,003h,0e9h,0d6h,0f9h,011h,0c1h,0e2h,0b0h,090h	; 6d32  ................
	defb 0c1h,0b0h,090h,0c1h,0b0h,090h,0c1h,0b0h,090h,0c0h,0fbh,011h,0e1h,0b0h,090h,050h	; 6d42  ...............P
	defb 090h,050h,040h,020h,040h,020h,0e2h,0b0h,0e1h,020h,0ech,031h,043h,0feh,0feh,0a7h	; 6d52  .P@ @ ... .1C...
	defb 06ch,0ffh,0d6h,0fah,000h,0ech,042h,0e2h,0b3h,0d4h,0fah,000h,0b0h,0e1h,000h,0e2h	; 6d62  l.....B.........
	defb 0b0h,0d6h,0fbh,010h,040h,090h,0fbh,000h,0ech,051h,0b7h,0ech,042h,0e3h,041h,090h	; 6d72  ....@....Q..B.A.
	defb 0b0h,0e2h,021h,041h,0d4h,0fah,000h,090h,0b0h,090h,0d6h,0fbh,010h,050h,090h,0ech	; 6d82  ..!A.........P..
	defb 031h,0b3h,0ech,000h,0d6h,0fbh,051h,0e0h,0c1h,041h,041h,001h,041h,001h,0e1h,0b1h	; 6d92  1.....Q..AA.A...
	defb 0e0h,001h,0c1h,041h,041h,001h,040h,050h,040h,000h,0e1h,0b1h,091h,0c1h,0b1h,0b1h	; 6da2  ...AA.@P@.......
	defb 091h,0b1h,091h,051h,091h,0c1h,0b1h,0b1h,091h,0b1h,091h,051h,021h,0fbh,041h,042h	; 6db2  ...Q.......Q!.AB
	defb 040h,051h,091h,0fbh,022h,0ech,041h,0b7h,0c1h,0fah,002h,0ech,041h,0e1h,041h,051h	; 6dc2  @Q..".A.....A.AQ
	defb 091h,0b1h,091h,0b1h,0e0h,021h,0fbh,041h,0ech,000h,042h,040h,021h,0e1h,0b0h,0e0h	; 6dd2  .....!.A..B@!...
	defb 020h,0f9h,003h,0ech,031h,044h,0c0h,0fbh,041h,041h,0ech,000h,0fbh,035h,0e2h,021h	; 6de2   ...1D..AA...5.!
	defb 020h,020h,021h,020h,020h,021h,020h,020h,021h,020h,020h,0c1h,0fch,051h,090h,090h	; 6df2    !  !  !  ..Q..
	defb 091h,0b1h,0e1h,021h,051h,021h,0e2h,091h,0d3h,0fah,010h,0e1h,053h,040h,050h,0d6h	; 6e02  ...!Q!......S@P.
	defb 0fbh,051h,040h,051h,041h,021h,051h,021h,0e2h,0b0h,090h,0d1h,0c0h,0d6h,0e8h,008h	; 6e12  .Q@QA!Q!........
	defb 003h,003h,001h,010h,010h,013h,001h,010h,010h,011h,011h,011h,000h,000h,002h,0e9h	; 6e22  ................
	defb 0d1h,0c4h,0d6h,0fbh,011h,0e1h,0c1h,0b0h,090h,0f8h,011h,0b0h,090h,0fbh,011h,0b0h	; 6e32  ................
	defb 090h,0f8h,011h,0b0h,090h,0fbh,011h,0b0h,090h,0f8h,011h,0b0h,090h,0fbh,011h,0b0h	; 6e42  ................
	defb 090h,0c0h,050h,040h,020h,050h,020h,0e2h,0b0h,090h,0b0h,090h,050h,090h,0ech,031h	; 6e52  ..P@ P .....P..1
	defb 0b3h,0feh,0feh,096h,06dh,0ffh,0d6h,0fch,040h,0e3h,090h,091h,090h,041h,061h,0feh	; 6e62  ....m...@....Aa.
	defb 004h,06ch,06eh,060h,061h,060h,061h,010h,040h,0feh,004h,075h,06eh,0e4h,090h,091h	; 6e72  .ln`a`a.@..un...
	defb 0e3h,090h,041h,061h,0feh,003h,07fh,06eh,0e4h,090h,091h,0e3h,090h,041h,091h,060h	; 6e82  ..Aa...n.....A.`
	defb 061h,060h,061h,010h,040h,0feh,003h,091h,06eh,060h,061h,060h,061h,061h,0e3h,021h	; 6e92  a`a.@...n`a`aa.!
	defb 0e2h,020h,020h,0feh,003h,0a0h,06eh,020h,0c0h,020h,0c0h,0e3h,041h,0e2h,040h,040h	; 6ea2  .  ...n . ..A.@@
	defb 0feh,003h,0adh,06eh,040h,0c0h,040h,0c0h,0e4h,091h,090h,090h,0e3h,091h,090h,090h	; 6eb2  ...n@.@.........
	defb 0fch,033h,062h,080h,061h,041h,0c1h,060h,040h,012h,060h,040h,0c0h,040h,060h,043h	; 6ec2  .3b.aA.`@.`@.@`C
	defb 0fch,040h,0e3h,090h,091h,090h,091h,040h,060h,090h,091h,090h,091h,0c1h,0feh,002h	; 6ed2  .@.....@`.......
	defb 0d5h,06eh,0feh,0ffh,068h,06eh,0e7h,0e9h,0d6h,0fch,031h,0ech,000h,0e1h,0c2h,010h	; 6ee2  .n..hn....1.....
	defb 0e2h,0b1h,091h,0c2h,0e1h,010h,0e2h,0b1h,091h,0c2h,0fch,033h,0e1h,010h,011h,011h	; 6ef2  ...........3....
	defb 011h,0e2h,0b0h,090h,061h,041h,062h,090h,061h,091h,065h,0fbh,022h,010h,040h,065h	; 6f02  ....aAb.a.e.".@e
	defb 010h,040h,062h,090h,061h,041h,0fch,031h,0e1h,0c2h,010h,0e2h,0b1h,091h,0c2h,0e1h	; 6f12  .@b.aA.1........
	defb 010h,0e2h,0b1h,091h,0c2h,0e1h,010h,041h,011h,061h,040h,010h,0e2h,0b1h,091h,0b2h	; 6f22  .......A.a@.....
	defb 0b0h,0ech,032h,091h,0b1h,065h,010h,040h,065h,010h,040h,067h,0fch,013h,0ech,000h	; 6f32  ..2..e.@e.@g....
	defb 0e2h,090h,090h,0c0h,060h,090h,0c0h,0b0h,0c0h,0ech,052h,095h,060h,090h,0b0h,0b0h	; 6f42  ....`.....R.`...
	defb 0c0h,090h,0b0h,0c0h,0e1h,010h,0c0h,0ech,051h,0e2h,0b7h,0fch,022h,0ech,041h,0e1h	; 6f52  ........Q...".A.
	defb 013h,043h,0fch,032h,0e2h,0b2h,0e1h,010h,0e2h,0b1h,091h,0c1h,0b0h,090h,062h,090h	; 6f62  .C.2..........b.
	defb 0b0h,0c0h,0b0h,0e1h,010h,0e2h,0b3h,0c1h,0ech,000h,0e8h,008h,000h,002h,010h,012h	; 6f72  ................
	defb 000h,000h,015h,000h,002h,010h,012h,000h,000h,013h,0feh,0ffh,0e8h,06eh,0e7h,0d6h	; 6f82  .............n..
	defb 0fah,041h,0e3h,090h,090h,0c0h,0fch,041h,0e0h,010h,0e1h,0b1h,091h,0feh,002h,090h	; 6f92  .A.....A........
	defb 06fh,0fah,041h,0e3h,090h,090h,0c0h,0fch,033h,0e2h,090h,091h,091h,091h,060h,040h	; 6fa2  o.A.....3.....`@
	defb 011h,0e3h,0b1h,0e2h,012h,040h,011h,041h,015h,0fah,011h,0ech,033h,0e1h,010h,040h	; 6fb2  .....@.A....3..@
	defb 061h,010h,040h,061h,010h,040h,062h,090h,061h,041h,0ech,000h,0fch,031h,0e3h,090h	; 6fc2  a.@a.@b.aA...1..
	defb 090h,0c0h,0e0h,010h,0e1h,0b1h,091h,0feh,002h,0d0h,06fh,0e3h,090h,090h,0c0h,0e2h	; 6fd2  ..........o.....
	defb 090h,0e1h,011h,0e2h,091h,0e1h,021h,010h,0e2h,090h,061h,041h,062h,060h,0ech,043h	; 6fe2  ......!...aAb`.C
	defb 041h,061h,0e2h,015h,0e3h,080h,0b0h,0e2h,015h,0e3h,080h,0b0h,0e2h,012h,040h,011h	; 6ff2  Aa............@.
	defb 0e3h,0b1h,0fch,013h,0ech,000h,0e2h,020h,020h,0c0h,0e3h,090h,0e2h,020h,0c0h,040h	; 7002  .......  .... .@
	defb 0c0h,021h,0e3h,090h,090h,090h,0c0h,090h,0c0h,0e2h,040h,040h,0c0h,020h,040h,0c0h	; 7012  .!........@@. @.
	defb 060h,0c0h,041h,0e3h,0b0h,0b0h,0b0h,0c0h,0b0h,0c0h,0fch,022h,0ech,042h,0e2h,013h	; 7022  `.A........".B..
	defb 043h,0e3h,0b2h,0e2h,010h,0e3h,0b1h,091h,0c1h,0b0h,090h,062h,090h,0b0h,0c0h,0b0h	; 7032  C..........b....
	defb 0e2h,010h,0e3h,0b3h,0c1h,0d1h,0c0h,0d6h,0e8h,008h,000h,002h,010h,012h,000h,000h	; 7042  ................
	defb 015h,000h,002h,010h,012h,000h,000h,012h,0e9h,0d1h,0c4h,0feh,0ffh,090h,06fh,0d6h	; 7052  ..............o.
	defb 0fah,010h,0ech,000h,0e1h,0c1h,041h,061h,091h,0b3h,0e0h,013h,0ech,051h,0e1h,0b5h	; 7062  ......Aa.....Q..
	defb 0e0h,010h,0e1h,0b0h,093h,0ech,000h,061h,041h,063h,091h,0b1h,0ech,051h,0e0h,013h	; 7072  .......aAc...Q..
	defb 043h,0e1h,0b9h,0ech,000h,090h,0b0h,091h,061h,0c1h,041h,061h,091h,0b3h,0e0h,013h	; 7082  C.......a.Aa....
	defb 0ech,051h,0e1h,0b5h,0e0h,010h,0e1h,0b0h,0ech,000h,093h,061h,041h,063h,091h,0b1h	; 7092  .Q.........aAc..
	defb 0ech,051h,0e0h,013h,043h,0e1h,0b9h,090h,0b0h,093h,0fch,040h,0e1h,0ech,000h,0c1h	; 70a2  .Q..C......@....
	defb 041h,041h,011h,041h,010h,0e2h,0b0h,091h,041h,0c1h,061h,061h,0b1h,060h,080h,061h	; 70b2  AA.A....A.aa.`.a
	defb 041h,010h,0e3h,0b0h,0e2h,02bh,0f9h,000h,040h,060h,040h,060h,0ech,018h,091h,060h	; 70c2  A....+..@`@`...`
	defb 090h,0b1h,090h,0b0h,0e1h,011h,0e2h,0b0h,0e1h,010h,041h,010h,040h,0ech,000h,0fbh	; 70d2  ..........A.@...
	defb 024h,0e1h,010h,010h,0c0h,010h,011h,0c1h,0e2h,0b0h,0b0h,0c0h,0b0h,0b1h,0c3h,0fbh	; 70e2  $...............
	defb 022h,091h,091h,0e1h,011h,0e2h,061h,080h,060h,041h,010h,0e3h,0b0h,0e2h,060h,060h	; 70f2  ".....a.`A....``
	defb 0c0h,060h,061h,0c1h,040h,040h,0c0h,040h,041h,0c3h,011h,011h,041h,0e3h,0b1h,0e2h	; 7102  .`a.@@.@A...A...
	defb 010h,0e3h,0b0h,091h,060h,040h,0ech,051h,06bh,093h,0d4h,0f8h,000h,0e0h,060h,090h	; 7112  ....`@.Qk.....`.
	defb 060h,090h,060h,090h,060h,090h,060h,090h,060h,090h,0d6h,0fbh,033h,067h,0feh,0ffh	; 7122  `.`.`.`.`...3g..
	defb 061h,070h,0e7h,0d6h,0fah,011h,0e2h,0c1h,041h,061h,091h,0b3h,0e1h,013h,0ech,051h	; 7132  ap......Aa.....Q
	defb 0e2h,0b5h,0e1h,010h,0e2h,0b0h,093h,0ech,000h,061h,041h,063h,091h,0b1h,0ech,051h	; 7142  .........aAc...Q
	defb 0e1h,013h,043h,0e2h,0b9h,0ech,000h,090h,0b0h,091h,061h,0e2h,0c1h,041h,061h,091h	; 7152  ..C.......a..Aa.
	defb 0b3h,0e1h,013h,0ech,051h,0e2h,0b5h,0e1h,010h,0e2h,0b0h,093h,0ech,000h,061h,041h	; 7162  ....Q.........aA
	defb 063h,091h,0b1h,0ech,051h,0e1h,013h,043h,0e2h,0b9h,090h,0b0h,093h,0fch,040h,0e1h	; 7172  c...Q..C......@.
	defb 0c1h,091h,091h,061h,091h,060h,040h,011h,0e2h,0b1h,0c1h,0e1h,011h,011h,041h,0e2h	; 7182  ...a.`@.......A.
	defb 0b0h,0e1h,010h,0e2h,0b1h,091h,060h,040h,06bh,0fah,000h,040h,060h,040h,060h,0ech	; 7192  ......`@k..@`@`.
	defb 018h,091h,060h,090h,0b1h,090h,0b0h,0e1h,011h,0e2h,0b0h,0e1h,010h,041h,010h,040h	; 71a2  ..`..........A.@
	defb 0ech,000h,0fbh,024h,0e1h,010h,010h,0c0h,010h,011h,0e8h,008h,001h,0e9h,0e2h,0b0h	; 71b2  ...$............
	defb 0b0h,0c0h,0b0h,0b1h,0e8h,008h,003h,0e9h,0fbh,022h,0e1h,011h,011h,041h,0e2h,0b1h	; 71c2  ........."...A..
	defb 0e1h,010h,0e2h,0b0h,091h,060h,040h,0e1h,060h,060h,0c0h,060h,061h,0e8h,008h,001h	; 71d2  .....`@.``.`a...
	defb 0e9h,0e1h,040h,040h,0c0h,040h,041h,0e8h,008h,001h,0e9h,0e1h,0c1h,011h,011h,041h	; 71e2  ..@@.@A........A
	defb 0e2h,0b1h,0e1h,010h,0e2h,0b0h,091h,060h,040h,0ech,051h,06bh,093h,0d4h,0fah,000h	; 71f2  .......`@.Qk....
	defb 060h,090h,060h,090h,060h,090h,060h,090h,060h,090h,060h,090h,0d6h,0fbh,033h,067h	; 7202  `.`.`.`.`.`...3g
	defb 0ech,000h,0feh,0ffh,034h,071h,0d6h,0fch,031h,0e4h,091h,0e3h,090h,090h,041h,091h	; 7212  ....4q..1.....A.
	defb 0e4h,091h,0e3h,090h,090h,041h,091h,0e4h,0b1h,0e3h,0b0h,0b0h,061h,0b1h,0e4h,0b1h	; 7222  .....A......a...
	defb 0e3h,0b0h,0b0h,061h,0b1h,0e4h,061h,0e3h,060h,060h,011h,061h,0e4h,061h,0e3h,060h	; 7232  ...a..a.``.a.a.`
	defb 060h,011h,061h,0e4h,041h,0e3h,040h,040h,0e4h,0b1h,0e3h,041h,0e4h,021h,0e3h,020h	; 7242  `.a.A.@@...A.!.
	defb 020h,0e4h,041h,0e3h,041h,0feh,002h,018h,072h,0fch,024h,0e2h,061h,060h,060h,061h	; 7252   .A.A...r.$.a``a
	defb 0c1h,041h,040h,040h,041h,0c1h,0e3h,091h,090h,090h,091h,0c1h,0b1h,0b0h,0b0h,0b0h	; 7262  .A@@A...........
	defb 060h,090h,0b0h,0fch,031h,0e4h,021h,0e3h,020h,020h,0e4h,091h,0e3h,021h,0e4h,021h	; 7272  `...1.!.  ...!.!
	defb 0e3h,020h,020h,0e4h,091h,0e3h,021h,0fah,000h,0e2h,021h,0e3h,0b0h,0e2h,020h,041h	; 7282  .  ...!...!... A
	defb 020h,040h,061h,040h,060h,0b1h,080h,0b0h,0fch,031h,0e1h,060h,060h,0c0h,060h,061h	; 7292   @a@`....1.``.`a
	defb 0e3h,061h,0e1h,040h,040h,0c0h,040h,041h,0e3h,041h,0e4h,091h,090h,0e3h,040h,011h	; 72a2  .a.@@.@A.A....@.
	defb 041h,0e4h,0b1h,0b0h,0e3h,060h,011h,041h,0e3h,061h,0e2h,060h,060h,0e3h,061h,0e2h	; 72b2  A....`.A.a.``.a.
	defb 060h,060h,0e3h,041h,0e2h,040h,040h,0e3h,041h,0e2h,040h,040h,0e3h,091h,090h,090h	; 72c2  ``.A.@@.A.@@....
	defb 091h,090h,090h,0b1h,0b0h,0b0h,0b1h,0b0h,0b0h,0e3h,021h,020h,020h,020h,0e4h,090h	; 72d2  ..........!   ..
	defb 0b0h,0e3h,020h,041h,040h,040h,040h,0e4h,0b0h,0e3h,010h,040h,061h,060h,060h,061h	; 72e2  .. A@@@....@a``a
	defb 010h,040h,061h,060h,060h,063h,0feh,0ffh,018h,072h,0e7h,0d6h,0fch,051h,0ech,000h	; 72f2  .@a``c...r...Q..
	defb 0e2h,0c1h,070h,070h,071h,071h,071h,050h,020h,071h,0a0h,0e1h,000h,022h,050h,021h	; 7302  ..ppqqqP q..."P!
	defb 051h,0ech,051h,027h,0ech,000h,0c1h,000h,000h,001h,001h,001h,020h,000h,0e2h,0a1h	; 7312  Q.Q'........ ...
	defb 070h,050h,072h,0a0h,071h,0a1h,0ech,052h,075h,0ech,000h,020h,050h,0c1h,0e8h,008h	; 7322  pPr.q..Ru.. P...
	defb 000h,002h,013h,000h,000h,013h,0e9h,0c1h,0e8h,008h,000h,002h,013h,000h,000h,013h	; 7332  ................
	defb 0e9h,0fch,051h,0e2h,073h,073h,071h,020h,050h,071h,020h,050h,072h,070h,0a1h,0e1h	; 7342  ..Q.ssq Pq Prp..
	defb 001h,0fah,000h,0ech,051h,024h,0ech,000h,050h,020h,050h,0fch,051h,003h,003h,001h	; 7352  ....Q$..P P.Q...
	defb 020h,000h,0e2h,0a1h,070h,050h,072h,0a0h,071h,0a1h,0fah,000h,0ech,052h,074h,0ech	; 7362   ...pPr.q....Rt.
	defb 000h,050h,020h,050h,0feh,002h,043h,073h,0fbh,022h,0e2h,0a5h,0e1h,021h,002h,020h	; 7372  .P P..Cs."...!.
	defb 001h,0e2h,0a0h,070h,0a3h,0e1h,003h,027h,053h,073h,001h,000h,020h,001h,0e2h,0a0h	; 7382  ...p...'Ss.. ...
	defb 070h,0c1h,0a0h,0a0h,071h,051h,071h,070h,070h,073h,0feh,0feh,02fh,073h,0ffh,0d6h	; 7392  p...qQqpps../s..
	defb 0fch,033h,0e4h,071h,0e2h,020h,020h,021h,021h,021h,000h,0e3h,090h,0e2h,021h,0e3h	; 73a2  .3.q.  !!!....!.
	defb 020h,020h,071h,0e2h,020h,020h,0e3h,021h,0e2h,021h,0e3h,071h,0e2h,020h,020h,0e3h	; 73b2    q.  .!.!.q.  .
	defb 021h,0e2h,021h,0e3h,001h,0e2h,070h,070h,071h,071h,071h,090h,070h,051h,020h,000h	; 73c2  !.!...ppqqq.pQ .
	defb 0e3h,071h,0e2h,020h,020h,0e3h,021h,0e2h,021h,0e3h,071h,070h,070h,071h,020h,050h	; 73d2  .q.  .!.!.qppq P
	defb 0e4h,071h,0e3h,020h,020h,0e4h,021h,0e3h,021h,0e4h,071h,0e4h,020h,020h,0e4h,071h	; 73e2  .q.  .!.!.q.  .q
	defb 020h,050h,071h,0e3h,020h,020h,0e4h,021h,0e3h,021h,0e4h,071h,020h,050h,071h,0c1h	; 73f2   Pq.  .!.!.q Pq.
	defb 0e3h,071h,0e2h,020h,020h,0e3h,021h,0e2h,020h,020h,0e3h,071h,0e2h,020h,020h,0e3h	; 7402  .q.  .!.  .q.  .
	defb 021h,0e2h,020h,020h,0e3h,0a1h,0e2h,020h,020h,0e3h,051h,0e2h,020h,020h,0e3h,0a1h	; 7412  !.  ...  .Q.  ..
	defb 0e2h,020h,020h,0e3h,051h,0e2h,020h,020h,001h,070h,070h,0e3h,071h,0e2h,071h,001h	; 7422  .  .Q.  .pp.q.q.
	defb 070h,070h,0e3h,071h,0e2h,071h,0e3h,071h,0e2h,020h,020h,0e3h,021h,0e2h,021h,0e3h	; 7432  pp.q.q.q.  .!.!.
	defb 071h,0e2h,020h,020h,0e3h,021h,0e2h,021h,0feh,002h,002h,074h,0e4h,0a1h,0e3h,0a0h	; 7442  q.  .!.!...t....
	defb 0a0h,0a0h,0c0h,0a0h,0c0h,001h,0e2h,000h,000h,000h,0c0h,000h,0c0h,0fbh,080h,0e3h	; 7452  ................
	defb 031h,0e2h,030h,030h,030h,0c0h,030h,0c0h,0fch,033h,0e4h,0a1h,0e3h,0a0h,0a0h,0a0h	; 7462  1.000.0..3......
	defb 0c0h,0a0h,0c0h,0e2h,051h,050h,050h,021h,021h,001h,000h,000h,0e3h,073h,031h,0e2h	; 7472  ....QPP!!....s1.
	defb 030h,030h,0e3h,051h,0e2h,050h,050h,0e3h,071h,0e1h,070h,070h,073h,0feh,0feh,0e2h	; 7482  00.Q.PP.q.pps...
	defb 073h,0d6h,0fch,051h,0e3h,0c1h,070h,070h,071h,071h,071h,050h,020h,071h,0a0h,0e2h	; 7492  s..Q..ppqqqP q..
	defb 000h,022h,050h,021h,051h,0ech,053h,027h,0ech,000h,0c1h,000h,000h,001h,001h,001h	; 74a2  ."P!Q.S'........
	defb 020h,000h,0e3h,0a1h,070h,050h,072h,0a0h,071h,0a1h,0ech,054h,075h,0ech,000h,090h	; 74b2   ...pPr.q..Tu...
	defb 0e2h,000h,0fch,028h,0e3h,071h,0e2h,020h,020h,0e3h,021h,0e2h,021h,0e3h,071h,0e2h	; 74c2  ...(.q.  .!.!.q.
	defb 020h,020h,0e3h,071h,020h,050h,071h,0e2h,020h,020h,0e3h,021h,0e2h,021h,0e3h,071h	; 74d2    .q Pq.  .!.!.q
	defb 020h,050h,071h,0c1h,0fch,051h,0e2h,023h,023h,021h,0e3h,090h,0e2h,000h,021h,0e1h	; 74e2   Pq..Q.##!....!.
	defb 020h,050h,072h,070h,0a1h,0e0h,001h,0fah,000h,0ech,051h,024h,0ech,000h,050h,020h	; 74f2   Prp......Q$..P
	defb 050h,0fch,051h,0e2h,073h,073h,071h,0e0h,020h,000h,0e1h,0a1h,070h,050h,072h,0a0h	; 7502  P.Q.ssq. ...pPr.
	defb 071h,0a1h,0fah,000h,0ech,051h,074h,0ech,000h,050h,020h,050h,0feh,002h,0e6h,074h	; 7512  q....Qt..P P...t
	defb 0fch,033h,0e2h,051h,050h,050h,050h,0c0h,0a1h,072h,090h,071h,050h,020h,033h,033h	; 7522  .3.QPPP..r.qP 33
	defb 057h,0e1h,027h,0e2h,071h,070h,090h,071h,050h,020h,0c1h,050h,050h,021h,001h,021h	; 7532  W.'.qp.qP .PP!.!
	defb 020h,020h,023h,0feh,0feh,0c4h,074h,0ffh,0d6h,0fah,040h,0e3h,001h,0fch,044h,0e2h	; 7542    #...t...@...D.
	defb 070h,070h,071h,071h,071h,071h,071h,0e3h,070h,070h,0feh,004h,04ah,075h,091h,090h	; 7552  ppqqqqq.pp..Ju..
	defb 090h,091h,0c1h,0feh,002h,060h,075h,051h,050h,050h,051h,0c1h,071h,070h,070h,073h	; 7562  .....`uQPPQ.qpps
	defb 0e3h,001h,000h,000h,0e4h,071h,0e3h,001h,0feh,004h,072h,075h,0e4h,091h,090h,090h	; 7572  .....q....ru....
	defb 0e3h,041h,091h,0feh,002h,07eh,075h,0e4h,051h,050h,050h,0e3h,001h,051h,0e4h,071h	; 7582  .A...~u.QPP..Q.q
	defb 070h,070h,0e3h,021h,071h,0e4h,093h,093h,091h,0e3h,090h,090h,091h,091h,021h,020h	; 7592  pp.!q.........!
	defb 020h,021h,0c1h,041h,040h,040h,071h,070h,070h,0e4h,093h,093h,091h,0e3h,090h,090h	; 75a2   !.A@@qpp.......
	defb 091h,091h,0e4h,021h,0e3h,020h,020h,0e4h,021h,0e3h,020h,020h,0e4h,071h,0e3h,070h	; 75b2  ...!.  .!.  .q.p
	defb 070h,0e4h,091h,0e3h,090h,090h,0e2h,020h,020h,0c0h,020h,041h,041h,070h,070h,0c0h	; 75c2  p......  . AApp.
	defb 070h,091h,0e1h,000h,020h,0feh,0ffh,04ah,075h,0e7h,0e9h,0d6h,0fbh,026h,0e3h,001h	; 75d2  p... ..Ju....&..
	defb 0e2h,000h,000h,001h,001h,001h,0e1h,071h,0e3h,071h,0e1h,071h,0e3h,001h,0e2h,000h	; 75e2  .......q.q.q....
	defb 000h,001h,001h,001h,0e1h,071h,0e3h,071h,0e1h,071h,0e2h,0c1h,0fah,010h,0ech,041h	; 75f2  .....q.q.q.....A
	defb 043h,071h,092h,070h,041h,071h,0c1h,0e1h,001h,0e2h,091h,071h,091h,0d4h,0f9h,000h	; 7602  Cq.pAq.....q....
	defb 070h,090h,070h,0d6h,0f9h,002h,041h,071h,093h,0e1h,003h,0ech,000h,0e2h,094h,0c0h	; 7612  p.p...Aq........
	defb 0fah,010h,090h,0e1h,000h,0ech,041h,023h,043h,0f9h,000h,0ech,000h,023h,023h,0fah	; 7622  ......A#C....##.
	defb 010h,0e2h,0c1h,043h,071h,092h,070h,041h,071h,0c1h,0e1h,001h,0e2h,091h,071h,091h	; 7632  ...Cq.pAq.....q.
	defb 0d4h,0f9h,000h,070h,090h,070h,0d6h,0fah,010h,041h,020h,000h,023h,043h,005h,090h	; 7642  ...p.p...A .#C..
	defb 0e1h,000h,0ech,041h,023h,043h,0f9h,000h,023h,023h,0fch,050h,0e1h,043h,043h,0f9h	; 7652  ...A#C..##.P.CC.
	defb 000h,040h,070h,040h,070h,0fch,051h,041h,020h,000h,0f9h,000h,0ech,032h,022h,040h	; 7662  .@p@p.QA ....2"@
	defb 021h,001h,0e2h,092h,0ech,000h,0e1h,000h,0e2h,091h,071h,0fch,050h,0e1h,043h,043h	; 7672  !.........q.P.CC
	defb 0f9h,000h,040h,070h,040h,070h,0fch,051h,041h,020h,000h,0f9h,004h,0e2h,020h,020h	; 7682  ..@p@p.QA ....
	defb 0c0h,020h,041h,041h,070h,070h,0c0h,070h,091h,091h,0c1h,0e8h,008h,003h,003h,003h	; 7692  . AApp.p........
	defb 001h,0feh,0ffh,0dbh,075h,0d6h,0fch,042h,0e3h,071h,0f8h,080h,0e2h,070h,070h,071h	; 76a2  ....u..B.q...ppq
	defb 071h,071h,0fch,042h,0e1h,001h,0f9h,080h,0e3h,071h,071h,0fch,042h,071h,0f8h,080h	; 76b2  qq.B.....qq.Bq..
	defb 0e2h,070h,070h,071h,071h,071h,0fch,042h,0e1h,001h,0fah,080h,0e4h,071h,0e3h,071h	; 76c2  .ppqqq.B.....q.q
	defb 0c1h,0fah,010h,0e1h,043h,071h,092h,070h,041h,071h,0c1h,0e0h,001h,0e1h,091h,071h	; 76d2  ....Cq.pAq.....q
	defb 091h,0d4h,0f9h,000h,070h,090h,070h,0d6h,0fah,010h,041h,071h,093h,0e0h,003h,0e1h	; 76e2  ....p.p...Aq....
	defb 094h,0c0h,090h,0e0h,000h,023h,043h,027h,0fch,041h,0e3h,001h,0e2h,040h,040h,041h	; 76f2  .....#C'.A...@@A
	defb 041h,041h,041h,001h,001h,0feh,002h,0fch,076h,0fah,010h,0e3h,093h,0b3h,075h,0e2h	; 7702  AAA.....v.....u.
	defb 040h,070h,093h,0b3h,093h,073h,0fch,050h,0e2h,093h,093h,0f9h,000h,090h,0e1h,000h	; 7712  @p...s.P........
	defb 0e2h,090h,0e1h,000h,0fch,051h,0e2h,091h,070h,090h,0f9h,000h,092h,0b0h,091h,071h	; 7722  .....Q..p......q
	defb 042h,070h,041h,021h,0fch,050h,0e2h,093h,093h,0f9h,000h,090h,0e1h,000h,0e2h,090h	; 7732  BpA!.P..........
	defb 0e1h,000h,0fch,051h,0e2h,091h,070h,090h,0e3h,090h,090h,0c0h,090h,0b1h,0b1h,0f9h	; 7742  ...Q..p.........
	defb 003h,0e2h,020h,020h,0c0h,020h,041h,041h,0fbh,023h,070h,070h,0c0h,070h,091h,091h	; 7752  ..  . AA.#pp.p..
	defb 0e1h,000h,000h,0c0h,000h,021h,040h,070h,0feh,0ffh,0a7h,076h,0d5h,0fch,030h,0e3h	; 7762  .....!@p...v..0.
	defb 091h,090h,090h,091h,091h,091h,091h,091h,091h,051h,050h,050h,051h,051h,051h,051h	; 7772  .........QPPQQQQ
	defb 051h,051h,021h,020h,020h,021h,021h,021h,021h,021h,021h,041h,040h,040h,041h,041h	; 7782  QQ!  !!!!!!A@@AA
	defb 041h,041h,041h,041h,0e4h,091h,0e3h,091h,0feh,004h,096h,077h,0e4h,051h,0e3h,051h	; 7792  AAAA.......w.Q.Q
	defb 0feh,004h,09eh,077h,021h,021h,021h,021h,0e4h,0b1h,0b1h,0e3h,021h,021h,051h,051h	; 77a2  ...w!!!!....!!QQ
	defb 091h,091h,0b1h,0b1h,0e2h,021h,021h,0e4h,091h,0e3h,091h,091h,091h,093h,091h,091h	; 77b2  .....!!.........
	defb 051h,051h,051h,051h,043h,041h,041h,0e2h,057h,097h,0b3h,093h,057h,0e4h,041h,0e3h	; 77c2  QQQQCAA.W...W.A.
	defb 041h,0feh,004h,0cfh,077h,0e4h,041h,0e2h,041h,021h,0e3h,0b1h,091h,051h,041h,001h	; 77d2  A...w.A.A!...QA.
	defb 0e4h,091h,0e3h,091h,0feh,004h,0e2h,077h,0e4h,051h,0e3h,051h,0feh,004h,0eah,077h	; 77e2  .......w.Q.Q...w
	defb 0e4h,021h,0e3h,021h,0feh,004h,0f2h,077h,0e4h,041h,0e3h,041h,0feh,004h,0fah,077h	; 77f2  .!.!...w.A.A...w
	defb 0e4h,091h,0e3h,091h,0feh,004h,002h,078h,0e4h,051h,0e3h,051h,0feh,004h,00ah,078h	; 7802  .......x.Q.Q...x
	defb 0e4h,021h,0e3h,021h,0feh,004h,012h,078h,0e4h,041h,0e3h,041h,0feh,004h,01ah,078h	; 7812  .!.!...x.A.A...x
	defb 0e4h,021h,0e3h,021h,021h,0c1h,0feh,002h,022h,078h,0e4h,091h,0e3h,091h,091h,0c1h	; 7822  .!.!!..."x......
	defb 0feh,002h,02ch,078h,0e2h,091h,051h,041h,021h,041h,021h,0e3h,0b1h,091h,051h,091h	; 7832  ..,x..QA!A!...Q.
	defb 0b1h,0e2h,021h,043h,0e3h,043h,0feh,0ffh,06eh,077h,0d5h,0f7h,000h,0e1h,040h,0f8h	; 7842  ..!C.C..nw....@.
	defb 000h,040h,0f9h,000h,041h,0fah,000h,0ech,051h,047h,003h,0f7h,000h,040h,0f8h,000h	; 7852  .@..A...QG...@..
	defb 040h,0f9h,000h,041h,0fah,000h,047h,003h,0c3h,047h,003h,0ech,000h,0fch,041h,0e2h	; 7862  @..A..G..G....A.
	defb 0b3h,091h,090h,090h,053h,043h,0fah,000h,0ech,061h,0e2h,097h,0fch,041h,091h,090h	; 7872  ....SC...a...A..
	defb 090h,091h,091h,0fah,000h,097h,0ech,000h,0fch,041h,091h,090h,090h,091h,091h,0f7h	; 7882  .........A......
	defb 000h,090h,0f8h,000h,090h,0f9h,000h,090h,0fah,000h,0ech,051h,094h,0ech,000h,0fch	; 7892  ...........Q....
	defb 041h,091h,090h,090h,091h,091h,0fch,022h,053h,043h,023h,0e3h,0b3h,0fch,041h,0e2h	; 78a2  A......"SC#...A.
	defb 0c1h,041h,041h,041h,043h,001h,0e3h,0b1h,0c1h,051h,091h,0b1h,0b3h,091h,0b1h,0f9h	; 78b2  .AAAC....Q......
	defb 000h,0e1h,0b0h,090h,0feh,010h,0c4h,078h,0fah,000h,0ech,071h,0e1h,04bh,0ech,000h	; 78c2  .......x...q.K..
	defb 0b1h,0e0h,021h,0ech,061h,04fh,0fbh,021h,0e2h,042h,091h,0b1h,0e1h,041h,0e2h,041h	; 78d2  ..!.aO.!.B...A.A
	defb 091h,0b1h,0e1h,041h,0e2h,041h,091h,0b1h,0e1h,041h,0e2h,041h,091h,0b1h,0e1h,041h	; 78e2  ...A.A...A.A...A
	defb 0e2h,041h,091h,0b1h,0e1h,041h,0e2h,041h,091h,0b1h,0e1h,041h,0e2h,041h,091h,0b1h	; 78f2  .A...A.A...A.A..
	defb 0e1h,021h,041h,0e2h,0b1h,091h,050h,0fah,011h,0e2h,040h,040h,090h,090h,0b0h,0b0h	; 7902  .!A...P...@@....
	defb 0e1h,040h,040h,0feh,008h,00bh,079h,0fch,032h,0e1h,021h,021h,021h,0e2h,0b1h,0e1h	; 7912  .@@...y.2.!!!...
	defb 021h,021h,021h,0e2h,0b1h,0c1h,091h,091h,041h,091h,051h,041h,041h,0fah,000h,0e1h	; 7922  !!!.....A.QAA...
	defb 021h,0e2h,0b1h,091h,051h,0b1h,091h,051h,041h,021h,041h,051h,091h,0ech,051h,0b7h	; 7932  !...Q..QA!AQ..Q.
	defb 0feh,0ffh,04ch,078h,0e7h,0d5h,0f7h,000h,0e1h,040h,0f8h,000h,040h,0f9h,000h,041h	; 7942  ..Lx.....@..@..A
	defb 0fah,000h,0ech,051h,047h,003h,0f7h,000h,0e1h,040h,0f8h,000h,0e1h,040h,0f9h,000h	; 7952  ...QG....@...@..
	defb 041h,0fah,000h,047h,003h,0c3h,047h,003h,0fch,041h,0ech,000h,0e2h,0b3h,091h,090h	; 7962  A..G..G..A......
	defb 090h,053h,043h,0fah,000h,0ech,061h,0e1h,04bh,003h,04bh,003h,0c3h,0e2h,0b7h,0e1h	; 7972  .SC...a.K.K.....
	defb 003h,0ech,000h,0e2h,0b3h,093h,053h,043h,0fch,041h,0c1h,091h,091h,091h,093h,051h	; 7982  ......SC.A.....Q
	defb 041h,0c1h,001h,041h,051h,043h,001h,041h,0fah,000h,0e1h,057h,097h,0b3h,093h,057h	; 7992  A..AQC.A...W...W
	defb 0fah,000h,0ech,071h,0e2h,04bh,0ech,000h,0b1h,0e1h,021h,0ech,061h,04fh,0d5h,0fch	; 79a2  ...q.K....!.aO..
	defb 041h,0e2h,041h,091h,0b1h,0e1h,041h,0feh,006h,0b3h,079h,0e2h,041h,091h,0b1h,0e1h	; 79b2  A.A...A...y.A...
	defb 021h,041h,0e2h,0b1h,091h,051h,0fbh,010h,0e1h,0c1h,0ech,051h,0e1h,043h,0fah,001h	; 79c2  !A...Q.....Q.C..
	defb 041h,0fbh,011h,041h,000h,000h,0e2h,0b1h,091h,0feh,002h,0cah,079h,0e1h,0c1h,043h	; 79d2  A..A........y..C
	defb 0fah,001h,041h,0fbh,011h,0ech,000h,041h,000h,000h,0e2h,0b1h,091h,0b1h,091h,051h	; 79e2  ..A....A.......Q
	defb 091h,053h,0ech,045h,043h,0fch,022h,0e1h,091h,091h,091h,051h,091h,091h,091h,051h	; 79f2  .S.EC."....Q...Q
	defb 0c1h,041h,041h,001h,041h,001h,0e2h,0b1h,091h,0fah,000h,0e1h,021h,0e2h,0b1h,091h	; 7a02  .AA.A.......!...
	defb 051h,0b1h,091h,051h,041h,021h,041h,051h,091h,0ech,052h,0b7h,0feh,0ffh,046h,079h	; 7a12  Q..QA!AQ..R...Fy
	defb 0d6h,0fch,000h,0e8h,006h,03eh,0e9h,0e7h,0d4h,0fbh,041h,0e2h,043h,0e1h,041h,041h	; 7a22  .....>....A.C.AA
	defb 0e2h,0b3h,0e1h,013h,0e2h,041h,0e1h,041h,0c1h,041h,041h,0c5h,0e2h,011h,0e1h,011h	; 7a32  .....A.A.AA.....
	defb 0c1h,011h,011h,0e2h,0b1h,081h,061h,0c1h,081h,061h,041h,013h,0e3h,0b3h,0feh,002h	; 7a42  ......a..aA.....
	defb 028h,07ah,0e9h,0d4h,0fbh,021h,0ech,051h,0e1h,0c1h,041h,0e2h,0b1h,0e1h,011h,047h	; 7a52  (z...!.Q..A....G
	defb 0c1h,041h,0e2h,0b1h,0e1h,011h,041h,081h,061h,041h,0c1h,011h,0e2h,081h,0b1h,0ech	; 7a62  .A....A.aA......
	defb 053h,0e1h,017h,0c1h,0e1h,011h,0e2h,081h,0b1h,0e1h,011h,041h,011h,0e2h,0b1h,0feh	; 7a72  S..........A....
	defb 002h,054h,07ah,0feh,0feh,028h,07ah,0ffh,0d6h,0fch,000h,0e8h,006h,02eh,0e9h,0d4h	; 7a82  .Tz..(z.........
	defb 0fch,055h,0e3h,045h,041h,043h,0b1h,0e2h,011h,0e3h,045h,041h,043h,0c3h,015h,011h	; 7a92  .U.EAC....EAC...
	defb 013h,061h,081h,015h,011h,013h,0e4h,0b3h,0feh,0feh,090h,07ah,0ffh,0d6h,0fch,000h	; 7aa2  .a.........z....
	defb 0ceh,0d4h,0fbh,041h,0e2h,0c3h,041h,041h,0e3h,0b3h,0e2h,013h,0c1h,0e2h,0b1h,0c1h	; 7ab2  ...A..AA........
	defb 0b1h,0b1h,0c5h,0e3h,011h,0e2h,011h,0c1h,011h,011h,0e3h,0b1h,081h,061h,0c1h,0e2h	; 7ac2  .............a..
	defb 041h,011h,0e3h,0b1h,083h,063h,0feh,002h,0b3h,07ah,0d4h,0fbh,021h,0e2h,0c1h,0b1h	; 7ad2  A....c...z..!...
	defb 041h,061h,0b1h,041h,0e3h,0b1h,0e2h,011h,041h,0b1h,041h,061h,0b1h,0e1h,041h,011h	; 7ae2  Aa.A....A.Aa..A.
	defb 0e2h,0b1h,0c1h,081h,011h,041h,081h,011h,0e3h,081h,0b1h,0e2h,011h,081h,011h,061h	; 7af2  .....A.........a
	defb 081h,0b1h,081h,061h,0feh,002h,0dch,07ah,0feh,0feh,0b3h,07ah,0ffh,0d8h,0fch,042h	; 7b02  ...a...z...z...B
	defb 0e3h,090h,090h,090h,090h,040h,040h,040h,040h,090h,090h,090h,090h,040h,040h,040h	; 7b12  .....@@@@....@@@
	defb 040h,050h,050h,050h,050h,050h,050h,050h,050h,050h,050h,090h,090h,0b0h,0b0h,0e2h	; 7b22  @PPPPPPPPPP.....
	defb 020h,020h,0feh,002h,00fh,07bh,0e3h,0c1h,040h,040h,0c1h,040h,040h,0c1h,050h,050h	; 7b32    ...{..@@.@@.PP
	defb 0c1h,050h,050h,0feh,002h,038h,07bh,0d8h,0fch,033h,0e3h,040h,040h,040h,040h,040h	; 7b42  .PP..8{..3.@@@@@
	defb 040h,040h,040h,050h,050h,050h,050h,050h,050h,050h,050h,040h,040h,040h,040h,040h	; 7b52  @@@PPPPPPPP@@@@@
	defb 040h,040h,040h,041h,0c5h,0feh,0ffh,00fh,07bh,0e7h,0d4h,0fbh,041h,0e1h,043h,003h	; 7b62  @@@A....{...A.C.
	defb 0e2h,0b3h,093h,0e1h,043h,003h,0e2h,0b3h,093h,053h,093h,0b3h,0e1h,023h,043h,0e2h	; 7b72  ....C....S...#C.
	defb 0b3h,093h,053h,0feh,002h,06bh,07bh,0d8h,0fbh,022h,0e2h,040h,050h,090h,0b0h,040h	; 7b82  ..S..k{..".@P..@
	defb 050h,090h,0b0h,050h,090h,0b0h,0e1h,020h,0e2h,050h,090h,0b0h,0e1h,020h,0feh,002h	; 7b92  P..P... .P... ..
	defb 08ch,07bh,0d8h,0fah,010h,0e1h,040h,050h,090h,0b0h,040h,050h,090h,0b0h,050h,090h	; 7ba2  .{....@P..@P..P.
	defb 0b0h,0e0h,020h,0e1h,050h,090h,0b0h,0e0h,020h,0e1h,040h,050h,090h,0b0h,040h,050h	; 7bb2  .. .P... .@P..@P
	defb 090h,0b0h,040h,0e0h,040h,020h,0e1h,0b0h,090h,050h,040h,000h,0feh,0ffh,06bh,07bh	; 7bc2  ..@.@ ...P@...k{
	defb 0d4h,0fbh,041h,0e0h,041h,0e1h,041h,0e0h,001h,0e1h,041h,0b1h,0e2h,0b1h,0e1h,091h	; 7bd2  ..A.A.A...A.....
	defb 0e2h,091h,0e0h,041h,0e1h,041h,0e0h,001h,0e1h,041h,0b1h,0e2h,0b1h,0e1h,091h,0e2h	; 7be2  ...A.A...A......
	defb 091h,0e1h,051h,0e2h,051h,0e1h,091h,0e2h,091h,0e1h,0b1h,0e2h,0b1h,0e0h,021h,0e1h	; 7bf2  ..Q.Q.........!.
	defb 021h,0e0h,041h,0e1h,041h,0b1h,0e2h,0b1h,0e1h,091h,0e2h,091h,0e1h,051h,0e2h,051h	; 7c02  !.A.A........Q.Q
	defb 0feh,002h,0d2h,07bh,0d8h,0fbh,022h,0e1h,040h,050h,090h,0b0h,040h,050h,090h,0b0h	; 7c12  ...{..".@P..@P..
	defb 050h,090h,0b0h,0e0h,020h,0e1h,050h,090h,0b0h,0e0h,020h,0e3h,0b0h,0e2h,000h,040h	; 7c22  P... .P... ....@
	defb 050h,0e3h,0b0h,0e2h,000h,040h,050h,000h,040h,050h,0b0h,000h,040h,050h,0b0h,0d8h	; 7c32  P....@P.@P..@P..
	defb 0fah,010h,0e2h,0b0h,0e1h,000h,040h,050h,0e2h,0b0h,0e1h,000h,040h,050h,000h,040h	; 7c42  ......@P....@P.@
	defb 050h,0b0h,000h,040h,050h,0b0h,0e2h,0b0h,0e1h,000h,040h,050h,0e2h,0b0h,0e1h,000h	; 7c52  P..@P.....@P....
	defb 040h,050h,0e2h,0b0h,0e1h,0b0h,090h,050h,040h,020h,0e2h,0b0h,090h,0feh,0ffh,0d2h	; 7c62  @P.....P@ ......
	defb 07bh,0ffh,0ffh,0e7h,0d6h,0fah,000h,0e2h,040h,050h,090h,0b0h,050h,090h,0b0h,0e1h	; 7c72  {.......@P..P...
	defb 020h,0e2h,0b0h,0e1h,020h,040h,050h,040h,090h,0b0h,0e0h,020h,0ech,051h,047h,0ffh	; 7c82   ... @P@... .QG.
	defb 0d1h,0fah,000h,0e3h,0c3h,0d6h,0fah,000h,0e2h,040h,050h,090h,0b0h,050h,090h,0b0h	; 7c92  .........@P..P..
	defb 0e1h,020h,0e2h,0b0h,0e1h,020h,040h,050h,040h,090h,0b0h,0e0h,020h,046h,0ffh,0d6h	; 7ca2  . ... @P@... F..
	defb 0fah,000h,0e3h,0b0h,0e2h,000h,040h,050h,000h,040h,050h,0b0h,050h,090h,0b0h,0e1h	; 7cb2  ......@P.@P.P...
	defb 000h,0e2h,0b0h,0e1h,040h,050h,090h,0ech,051h,0b7h,0ffh,0e7h,0d8h,0fah,000h,0e1h	; 7cc2  ....@P..Q.......
	defb 090h,050h,040h,020h,0e2h,0a0h,0e1h,020h,0e2h,0a0h,090h,070h,090h,0e1h,020h,0e2h	; 7cd2  .P@ ... ...p.. .
	defb 0a0h,0d9h,0ech,051h,095h,0ech,000h,0c0h,0d9h,073h,093h,0dah,0a3h,0e1h,023h,0dbh	; 7ce2  ...Q.....s....#.
	defb 0e8h,008h,051h,0e9h,040h,020h,0dch,041h,0ddh,071h,09ah,0ffh,0d8h,0f9h,000h,0e3h	; 7cf2  ..Q.@ .A.q......
	defb 040h,050h,090h,0a0h,0e2h,020h,0e3h,0a0h,0e2h,020h,040h,040h,020h,0e3h,0a0h,0e2h	; 7d02  @P... ... @@ ...
	defb 020h,0d9h,045h,0c0h,0fch,050h,0e3h,0c0h,040h,040h,040h,021h,021h,0dah,0c0h,040h	; 7d12   .E..P..@@@!!..@
	defb 040h,040h,071h,0d8h,071h,0d1h,0c1h,0dbh,0e8h,008h,001h,0e9h,0d1h,0c0h,0dbh,0a0h	; 7d22  @@q.q...........
	defb 090h,0dch,0a1h,0ddh,0fch,040h,0e2h,021h,04ah,0ffh,0d1h,0fah,000h,0e1h,0c0h,0d8h	; 7d32  .....@.!J.......
	defb 0e2h,090h,050h,040h,020h,0e3h,0a0h,0e2h,020h,0e3h,0a0h,090h,070h,090h,0e2h,020h	; 7d42  ..P@ ... ...p..
	defb 0e3h,0a0h,0d9h,0ech,051h,095h,0ech,000h,0c0h,0f9h,000h,0e2h,043h,023h,0dah,043h	; 7d52  ....Q.......C#.C
	defb 073h,0dbh,0e8h,008h,001h,0e9h,0e2h,0a0h,090h,0dch,0a1h,0ddh,0e7h,0e1h,021h,0ech	; 7d62  s.............!.
	defb 061h,04ah,0ffh,0e7h,0d4h,0fch,061h,0e0h,003h,020h,000h,0e1h,093h,071h,053h,021h	; 7d72  aJ....a.. ...qS!
	defb 003h,021h,053h,021h,053h,051h,053h,0d1h,0c0h,0d4h,0c1h,0e8h,008h,053h,0e9h,0c0h	; 7d82  .!S!SQS......S..
	defb 0ffh,0d4h,0fch,061h,0e1h,003h,020h,000h,0e2h,093h,071h,053h,021h,003h,021h,053h	; 7d92  ...a.. ...qS!.!S
	defb 021h,053h,051h,053h,0c1h,0e8h,008h,003h,0e9h,0c3h,0ffh,0d4h,0fbh,023h,0e3h,053h	; 7da2  !SQS.........#.S
	defb 051h,003h,021h,0fbh,032h,053h,051h,003h,021h,0fch,041h,053h,051h,003h,021h,052h	; 7db2  Q.!.2SQ.!.ASQ.!R
	defb 0c2h,0fdh,050h,053h,0ffh,0d8h,0fch,051h,0e1h,0c2h,0cbh,0cbh,0cbh,0c5h,0e6h,0d2h	; 7dc2  ..PS...Q........
	defb 0fch,051h,0e1h,020h,0e2h,026h,0c3h,0e1h,020h,0e2h,029h,0ffh,0e7h,0d8h,0fch,031h	; 7dd2  .Q. .&.. .)....1
	defb 0c4h,0d1h,0fch,051h,0e0h,020h,0e1h,026h,0e0h,021h,0e1h,02dh,0e0h,000h,0e1h,006h	; 7de2  ...Q. .&.!.-....
	defb 0e0h,021h,0e1h,02dh,0e0h,050h,0e1h,056h,0e0h,021h,0e1h,02dh,0e0h,000h,0e1h,006h	; 7df2  .!.-.P.V.!.-....
	defb 0d1h,0fch,051h,0e0h,020h,0e1h,029h,0d4h,0fbh,000h,000h,020h,000h,0d1h,0fch,051h	; 7e02  ..Q. .).... ...Q
	defb 0e1h,091h,0e2h,09dh,0e1h,070h,0e2h,076h,0e1h,091h,0e2h,09dh,0e0h,000h,0e1h,006h	; 7e12  .....p.v........
	defb 071h,0e2h,07dh,0e1h,050h,0e2h,056h,0d8h,0fch,051h,0c1h,0d1h,0fch,051h,0e1h,070h	; 7e22  q.}.P.V..Q...Q.p
	defb 0e2h,076h,0e1h,071h,0e2h,07dh,0e1h,050h,0e2h,056h,0e1h,071h,0e2h,07dh,0e1h,071h	; 7e32  .v.q.}.P.V.q.}.q
	defb 090h,0e2h,094h,0e1h,071h,0e2h,07dh,0e1h,050h,0e2h,056h,0e1h,021h,0e2h,02dh,0e1h	; 7e42  ....q.}.P.V.!.-.
	defb 021h,050h,0e2h,054h,0e1h,021h,0e2h,02dh,0e1h,000h,0e2h,006h,0d8h,0fch,051h,0e8h	; 7e52  !P.T.!.-......Q.
	defb 008h,002h,002h,0e9h,0c3h,0ffh,0d8h,0fch,031h,0e3h,0c2h,021h,0d4h,0fch,055h,0e2h	; 7e62  ........1..!..U.
	defb 020h,020h,0d8h,0fch,033h,0e2h,020h,0c0h,020h,022h,0e3h,071h,090h,021h,0d4h,0fch	; 7e72    ..3. . ".q.!..
	defb 033h,0e2h,020h,020h,0d8h,0fch,033h,020h,0c0h,020h,021h,0d4h,0fch,033h,0e3h,090h	; 7e82  3.  ..3 . !..3..
	defb 090h,0d8h,0fch,044h,0e3h,022h,071h,070h,071h,0d4h,0fch,044h,020h,050h,0d8h,0fch	; 7e92  ...D."qpq..D P..
	defb 044h,071h,070h,070h,0c0h,070h,021h,020h,0c1h,000h,0d8h,0fch,044h,0e3h,021h,0c0h	; 7ea2  Dqpp.p! ....D.!.
	defb 021h,0ffh,0d4h,0fch,032h,0e1h,0a1h,0c1h,050h,070h,0a1h,0c1h,050h,070h,0a1h,0c1h	; 7eb2  !...2...Pp..Pp..
	defb 0d4h,0fah,001h,0e2h,050h,070h,0d8h,0fch,040h,0a1h,0e1h,000h,0e2h,0a0h,0c0h,0d4h	; 7ec2  ....Pp..@.......
	defb 0fch,040h,0a0h,0e1h,020h,0d8h,0fch,040h,0e2h,0a1h,0e1h,020h,030h,0c0h,030h,022h	; 7ed2  .@.. ..@... 0.0"
	defb 0d8h,0fch,072h,0c1h,050h,051h,050h,031h,020h,021h,020h,0c1h,030h,031h,030h,021h	; 7ee2  ..r.PQP1 ! .010!
	defb 0e2h,0a0h,0e1h,001h,0e2h,0a0h,0d4h,0fbh,070h,0e1h,031h,0c1h,030h,020h,0e2h,0a3h	; 7ef2  ........p.1.0 ..
	defb 0e1h,021h,031h,0c1h,030h,020h,0e2h,0a3h,0e1h,021h,033h,031h,033h,031h,025h,0c5h	; 7f02  .!1.0 ...!3131%.
	defb 0feh,002h,0b4h,07eh,0ffh,0e7h,0d4h,0fch,032h,0e2h,0a1h,0c1h,050h,070h,0a1h,0c1h	; 7f12  ...~....2...Pp..
	defb 050h,070h,0a1h,0c1h,0e8h,008h,000h,000h,003h,001h,0e9h,0d4h,0fch,032h,0e1h,021h	; 7f22  Pp...........2.!
	defb 0c1h,0fch,040h,020h,050h,0d8h,021h,050h,070h,0c0h,070h,052h,0c1h,0fch,080h,0a0h	; 7f32  ..@ P.!Pp.pR....
	defb 0a1h,0a0h,071h,050h,0e8h,008h,001h,0e9h,0d8h,0fch,080h,050h,0c1h,070h,071h,070h	; 7f42  ..qP.......P.pqp
	defb 051h,020h,0e8h,008h,001h,0e9h,0d8h,0fch,080h,0e1h,020h,0d4h,0fbh,070h,071h,0c1h	; 7f52  Q ........ ..pq.
	defb 070h,050h,023h,051h,071h,0c1h,070h,050h,023h,051h,073h,051h,073h,0a1h,0a3h,0e8h	; 7f62  pP#Qq.pP#QsQs...
	defb 008h,001h,003h,0e9h,0c1h,0feh,002h,017h,07fh,0ffh,0d4h,0fch,036h,0e4h,0a5h,0a5h	; 7f72  ............6...
	defb 0a3h,0fch,0ddh,0e3h,0a0h,0a0h,0fch,039h,0a3h,051h,0e4h,0a3h,0a0h,0a0h,0a3h,0a1h	; 7f82  .......9.Q......
	defb 0e3h,033h,031h,055h,0fch,035h,0e4h,0a3h,0e3h,0a5h,0a1h,0e4h,0a3h,0a0h,0a0h,0e3h	; 7f92  .31U.5..........
	defb 023h,051h,033h,035h,031h,0e4h,0a3h,0a1h,0a3h,0a1h,0e3h,033h,031h,0fch,0a0h,0e2h	; 7fa2  #Q351......31...
	defb 032h,0f3h,000h,030h,0fah,0f0h,031h,0fch,035h,0e3h,033h,031h,0fch,0a0h,0e2h,032h	; 7fb2  2..0..1.5.31...2
	defb 0f2h,000h,030h,0f9h,0f0h,031h,0fch,035h,0e3h,033h,030h,030h,033h,031h,0e4h,0a3h	; 7fc2  ..0..1.5.30031..
	defb 0c1h,0a3h,0c1h,0feh,002h,07ch,07fh,0ffh,0e7h,0d4h,0fch,033h,0e1h,0c3h,003h,000h	; 7fd2  .....|.....3....
	defb 0e2h,0b0h,093h,0b1h,0e1h,003h,041h,003h,041h,053h,0d3h,0fbh,020h,040h,050h,0d2h	; 7fe2  ......A.AS.. @P.
	defb 040h,0d4h,0fch,033h,003h,0e2h,0b1h,0d1h,0c0h,0d4h,0fbh,0c0h,095h,0fch	; 7ff2  @..3..........
