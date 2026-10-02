# omsx_zonas.tcl - entra en la partida pulsando ESPACIO y luego fuerza, una
# tras otra, las zonas de GO_ZONAS (numeros fase x 7 + zona): pone 0xC288,
# 0xC280 y 0xC268 = 0 (para que p01:66A2 coja la casilla de entrada de 0xB8AF)
# y vuelve al estado 4, paso 1 (p00:5EA3, que carga la zona con p01:663A).
# Cuando el juego vuelve al estado 5, espera y vuelca VRAM, paleta y RAM.
#   GO_OUT=<dir> GO_ZONAS="0 1 2" openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
set ZONAS $::env(GO_ZONAS)
file mkdir $OUT
set LOG [open "$OUT/zonas.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc estado {} { return [debug read memory 0xC000] }
set ::i 0
proc vuelca {k} {
    global OUT
    set n [format %02d $k]
    set f [open "$OUT/z$n.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
    set f [open "$OUT/z$n.pal" wb]; puts -nonewline $f [debug read_block "VDP palette" 0 32]; close $f
    set f [open "$OUT/z$n.ram" wb]; puts -nonewline $f [debug read_block memory 0xC000 0x4000]; close $f
    say "zona $k  C288=[debug read memory 0xC288] C280=[debug read memory 0xC280] C281=[debug read memory 0xC281] C289=[debug read memory 0xC289] C267=[debug read memory 0xC267]"
}
proc entra {} {
    if {[estado] == 5} { say "en la partida" ; after time 1.0 siguiente ; return }
    keymatrixdown 8 0x01
    after time 0.1 { keymatrixup 8 0x01 }
    after time 0.6 entra
}
proc siguiente {} {
    global ZONAS
    if {$::i >= [llength $ZONAS]} { say "fin" ; exit 0 }
    set k [lindex $ZONAS $::i]
    incr ::i
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
    after time 2.0 "vuelca $k ; siguiente"
}
set throttle off
after time 2 entra
after time 600 { say "tiempo" ; exit 1 }
