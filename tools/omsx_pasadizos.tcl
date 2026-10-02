# omsx_pasadizos.tcl - los pasadizos secretos de GO_ZONAS (fase x 7 + zona),
# uno tras otro en UNA partida. Por cada zona: la fuerza como omsx_zonas.tcl
# (0xC288, 0xC280, 0xC268 = 0 y estado 4 paso 1); en el estado 5 pone
# 0xCDB0 = 1 (lo que deja el interior 16 al pagar, p03:B5B2), el mapa cogido
# (0xC27A = 1) y al jugador en (0x40, 0x42), y aprieta arriba (p01:7D0D).
# Vuelca la vista (vNN) y, tras el primer boton (p03:B8DF), el mapa (mNN).
# Antes de la zona siguiente, fuera del pasadizo a mano (0xCDB1, 0xCDC8 = 0).
#   GO_OUT=<dir> GO_ZONAS="0 1 2" openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
set ZONAS $::env(GO_ZONAS)
file mkdir $OUT
set LOG [open "$OUT/pasadizos.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc h {a} { return [format %02X [debug read memory $a]] }
proc estado {} { return [debug read memory 0xC000] }
set ::i 0
proc vuelca {n} {
    global OUT
    set f [open "$OUT/$n.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
    set f [open "$OUT/$n.pal" wb]; puts -nonewline $f [debug read_block "VDP palette" 0 32]; close $f
    set f [open "$OUT/$n.ram" wb]; puts -nonewline $f [debug read_block memory 0xC000 0x4000]; close $f
    say "$n  C288=[h 0xC288] C280=[h 0xC280] CDB1=[h 0xCDB1] CDC8=[h 0xCDC8] CDD3=[h 0xCDD3] CDD4=[h 0xCDD4]"
}
proc tecla {f b} { keymatrixdown $f $b ; after time 0.3 "keymatrixup $f $b" }
proc entra {} {
    if {[estado] == 5} { say "en la partida" ; after time 1.0 siguiente ; return }
    tecla 8 0x01
    after time 0.6 entra
}
proc siguiente {} {
    global ZONAS
    if {$::i >= [llength $ZONAS]} { say "fin" ; exit 0 }
    set k [lindex $ZONAS $::i]
    incr ::i
    debug write memory 0xCDB1 0
    debug write memory 0xCDC8 0
    debug write memory 0xCDB0 0
    debug write memory 0xC288 [expr {$k / 7}]
    debug write memory 0xC280 [expr {$k % 7}]
    debug write memory 0xC268 0
    debug write memory 0xC004 1
    debug write memory 0xC001 1
    debug write memory 0xC000 4
    after time 0.5 "espera $k"
}
proc espera {k} {
    if {[estado] != 5} { after time 0.2 "espera $k" ; return }
    after time 1.5 "dentro $k"
}
proc dentro {k} {
    set n [format %02d $k]
    debug write memory 0xCDB0 1
    debug write memory 0xC27A 1
    debug write memory 0xC494 0x42
    debug write memory 0xC496 0x40
    tecla 8 0x20
    after time 1.5 "vuelca v$n ; tecla 8 0x01"
    after time 3.0 "vuelca m$n ; siguiente"
}
set throttle off
after time 2 entra
after time 900 { say "tiempo" ; exit 1 }
