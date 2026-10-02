# omsx_claves.tcl - entra en la partida y, una tras otra, mete en el bufer de
# la contrasena (0xEBB0, 9 caracteres; 0xEB83 = 9) cada una de las cuatro
# claves de 0xBE8A y pone el estado 0x0E paso 1 (p01:6256): p01:6C03 ve los
# nueve, la suma de control no cuadra, y p03:BE4E las compara. Apunta lo que
# queda: 0xEF80, 0xC000, 0xC002, la vida 0xC480, el dinero 0xC265 y 0xC27F.
#   GO_OUT=<dir> openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
file mkdir $OUT
set LOG [open "$OUT/claves.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc h {a} { return [format %02X [debug read memory $a]] }
set CLAVES {
    {0x37 0x58 0x37 0x58 0x42 0x5D 0x42 0x5D 0x1F}
    {0x36 0x4F 0x40 0x53 0x5D 0x38 0x63 0x5D 0x36}
    {0x30 0x38 0x4F 0x3A 0x5D 0x48 0x3A 0x31 0x4B}
    {0x41 0x41 0x63 0x36 0x35 0x63 0x3B 0x3F 0x31}
    {0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30 0x30}
}
set ::i 0
proc entra {} {
    if {[debug read memory 0xC000] == 5} { say "en la partida" ; after time 1.0 siguiente ; return }
    keymatrixdown 8 0x01
    after time 0.1 { keymatrixup 8 0x01 }
    after time 0.6 entra
}
proc siguiente {} {
    global CLAVES
    if {$::i >= [llength $CLAVES]} { say "fin" ; exit 0 }
    set c [lindex $CLAVES $::i]
    incr ::i
    debug write memory 0xEF80 0
    debug write memory 0xC27F 0
    for {set k 0} {$k < 9} {incr k} { debug write memory [expr {0xEBB0 + $k}] [lindex $c $k] }
    debug write memory 0xEBB9 0xFF
    debug write memory 0xEB83 9
    debug write memory 0xC001 1
    debug write memory 0xC000 14
    after time 0.3 "mira $::i"
}
proc mira {n} {
    say "clave $n: EF80=[h 0xEF80] C000=[h 0xC000] C002=[h 0xC002] C480=[h 0xC480] C265=[h 0xC266][h 0xC265] C27F=[h 0xC27F] EB82=[h 0xEB82]"
    after time 1.5 { say "   despues: C000=[h 0xC000] C002=[h 0xC002] C480=[h 0xC480] C265=[h 0xC266][h 0xC265] C27F=[h 0xC27F]" }
    after time 2.0 { if {[debug read memory 0xC000] == 0} { say "  volvio al principio" } ; siguiente_tras_volver }
}
proc siguiente_tras_volver {} {
    if {[debug read memory 0xC000] != 5} {
        if {[debug read memory 0xC000] < 4} { keymatrixdown 8 0x01 ; after time 0.1 { keymatrixup 8 0x01 } }
        after time 0.5 siguiente_tras_volver
        return
    }
    after time 0.5 siguiente
}
set throttle off
after time 2 entra
after time 300 { say "tiempo" ; exit 1 }
