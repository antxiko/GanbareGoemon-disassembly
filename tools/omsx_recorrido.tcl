# omsx_recorrido.tcl - un pasadizo secreto andado con las teclas: entra en el
# de la zona GO_ZONA como omsx_pasadizos.tcl y aprieta los cursores de
# GO_PASOS (A arriba, I izquierda, D derecha, V abajo; fila 8 del teclado),
# uno cada segundo; vuelca la VRAM y la RAM antes del primero (r000) y tras
# cada uno (r001...).
#   GO_OUT=<dir> GO_ZONA=<k> GO_PASOS=AIDV... openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
set ZONA $::env(GO_ZONA)
set PASOS $::env(GO_PASOS)
file mkdir $OUT
set LOG [open "$OUT/recorrido.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc h {a} { return [format %02X [debug read memory $a]] }
proc estado {} { return [debug read memory 0xC000] }
proc vuelca {n} {
    global OUT
    set f [open "$OUT/$n.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
    set f [open "$OUT/$n.ram" wb]; puts -nonewline $f [debug read_block memory 0xC000 0x4000]; close $f
    say "$n  CDC6=[h 0xCDC6] CDC7=[h 0xCDC7] CDC4=[h 0xCDC4] CDB1=[h 0xCDB1] CDCD=[h 0xCDCD]"
}
proc tecla {f b} { keymatrixdown $f $b ; after time 0.1 "keymatrixup $f $b" }
proc entra {} {
    if {[estado] == 5} { say "en la partida" ; after time 1.0 a_la_zona ; return }
    tecla 8 0x01
    after time 0.6 entra
}
proc a_la_zona {} {
    global ZONA
    debug write memory 0xC288 [expr {$ZONA / 7}]
    debug write memory 0xC280 [expr {$ZONA % 7}]
    debug write memory 0xC268 0
    debug write memory 0xC004 1
    debug write memory 0xC001 1
    debug write memory 0xC000 4
    after time 0.5 espera
}
proc espera {} {
    if {[estado] != 5} { after time 0.2 espera ; return }
    after time 1.5 dentro
}
proc dentro {} {
    debug write memory 0xCDB0 1
    debug write memory 0xC494 0x42
    debug write memory 0xC496 0x40
    tecla 8 0x20
    after time 1.5 "vuelca r000 ; paso 0"
}
proc paso {k} {
    global PASOS
    if {$k >= [string length $PASOS]} { say "fin" ; exit 0 }
    set a [string index $PASOS $k]
    set bit [dict get {A 0x20 I 0x10 D 0x80 V 0x40} $a]
    tecla 8 $bit
    set n [format r%03d [expr {$k + 1}]]
    after time 1.0 "vuelca $n ; paso [expr {$k + 1}]"
}
set throttle off
after time 2 entra
after time 600 { say "tiempo" ; exit 1 }
