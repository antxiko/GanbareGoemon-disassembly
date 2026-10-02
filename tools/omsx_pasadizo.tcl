# omsx_pasadizo.tcl - la pantalla de p00:5969 (0xCDB1 = 1). Se entra como
# en el juego: 0xCDB0 = 1 (lo pone el interior 16 al pagar, p03:B5B2) y,
# con el jugador en x 0x30-0x50 e y 0x40-0x46, arriba (p01:7D0D). Vuelca la
# VRAM, la paleta y la RAM al entrar y tras cada tecla (girar y avanzar).
#   GO_OUT=<dir> openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
file mkdir $OUT
set LOG [open "$OUT/pasadizo.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc h {a} { return [format %02X [debug read memory $a]] }
proc vuelca {n} {
    global OUT
    set f [open "$OUT/$n.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
    set f [open "$OUT/$n.pal" wb]; puts -nonewline $f [debug read_block "VDP palette" 0 32]; close $f
    set f [open "$OUT/$n.ram" wb]; puts -nonewline $f [debug read_block memory 0xC000 0x4000]; close $f
    say "$n  estado=[h 0xC000] CDB1=[h 0xCDB1] CDB0=[h 0xCDB0] C288=[h 0xC288] C280=[h 0xC280] C281=[h 0xC281] R2=[format %02X [debug read {VDP regs} 2]]"
}
proc entra {} {
    if {[debug read memory 0xC000] == 5} { say "en la partida" ; after time 2.0 pon ; return }
    keymatrixdown 8 0x01
    after time 0.1 { keymatrixup 8 0x01 }
    after time 0.6 entra
}
proc pon {} {
    debug write memory 0xCDB0 1
    debug write memory 0xC494 0x42
    debug write memory 0xC496 0x40
    keymatrixdown 8 0x20
    after time 0.3 { keymatrixup 8 0x20 ; say "arriba  CDB1=[h 0xCDB1]" }
    after time 1.3 { vuelca p1 }
    after time 2.0 { pasos {{8 0x80 derecha} {8 0x80 derecha} {8 0x10 izquierda} {8 0x20 arriba} {8 0x20 arriba} {8 0x10 izquierda} {8 0x20 arriba}} 2 }
}
# cada tecla, medio segundo apretada, y un volcado un segundo despues
proc pasos {lista n} {
    if {[llength $lista] == 0} { say "fin" ; exit 0 }
    set t [lindex $lista 0]
    keymatrixdown [lindex $t 0] [lindex $t 1]
    after time 0.5 "keymatrixup [lindex $t 0] [lindex $t 1] ; say {tecla [lindex $t 2]}"
    after time 1.5 "vuelca p$n ; pasos {[lrange $lista 1 end]} [expr {$n + 1}]"
}
set throttle off
after time 2 entra
after time 120 { say "tiempo" ; exit 1 }
