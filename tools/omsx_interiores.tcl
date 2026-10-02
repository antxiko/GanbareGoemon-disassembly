# omsx_interiores.tcl - entra en la partida pulsando ESPACIO y luego mete al
# jugador, uno tras otro, en los interiores de GO_INTERIORES: la primera
# puerta de la pantalla (0xC500) con el bit 7 y el numero del interior,
# 0xC482 = 1 (dentro) y 0xC283 = 5 (se sale de la casilla por el lado 5).
# p00:5F23 pasa al estado 9 y p01:609C llama a p01:672F, que monta la
# pantalla especial y, con p02:925D, lo que hay en el interior. Al volver al
# estado 5 espera y vuelca VRAM, paleta y RAM.
#   GO_OUT=<dir> GO_INTERIORES="0 1 2" openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
set LISTA $::env(GO_INTERIORES)
file mkdir $OUT
set LOG [open "$OUT/interiores.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc estado {} { return [debug read memory 0xC000] }
set ::i 0
proc vuelca {k} {
    global OUT
    set n [format %02d $k]
    set f [open "$OUT/i$n.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
    set f [open "$OUT/i$n.pal" wb]; puts -nonewline $f [debug read_block "VDP palette" 0 32]; close $f
    set f [open "$OUT/i$n.ram" wb]; puts -nonewline $f [debug read_block memory 0xC000 0x4000]; close $f
    say "interior $k  C482=[debug read memory 0xC482] CD5F=[debug read memory 0xCD5F] C289=[debug read memory 0xC289] C4B0=[debug read memory 0xC4B0]"
}
proc entra {} {
    if {[estado] == 5} { say "en la partida" ; after time 2.0 siguiente ; return }
    keymatrixdown 8 0x01
    after time 0.1 { keymatrixup 8 0x01 }
    after time 0.6 entra
}
proc siguiente {} {
    global LISTA
    if {$::i >= [llength $LISTA]} { say "fin" ; exit 0 }
    set k [lindex $LISTA $::i]
    incr ::i
    debug write memory 0xC500 [expr {0x80 | $k}]
    debug write memory 0xC501 0x80
    debug write memory 0xC502 0x80
    debug write memory 0xC482 1
    debug write memory 0xC283 5
    after time 0.5 "espera $k"
}
proc espera {k} {
    if {[estado] != 5} { after time 0.2 "espera $k" ; return }
    after time 2.0 "vuelca $k ; siguiente"
}
set throttle off
after time 2 entra
after time 600 { say "tiempo" ; exit 1 }
