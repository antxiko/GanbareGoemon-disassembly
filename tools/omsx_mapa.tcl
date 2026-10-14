# omsx_mapa.tcl - el mapa de la provincia (estado 4, paso 0, p00:5EFD), y en
# omsx_zona_pasada.tcl el modelo: la pantalla de la zona pasada (estado 8, p01:6034):
# entra en la partida con ESPACIO; en el estado 5 fuerza la zona GO_ZONA
# (0xC288 fase, 0xC280 zona, como omsx_zonas.tcl) y, ya en ella, el tiempo a 0
# (0xC4B0) y el estado 8 en su paso 0 (p01:6073: zona + 1 y al paso 1, que pinta
# la pantalla). Vuelca VRAM, paleta y RAM a los GO_T segundos de llegar al paso 2.
#   GO_OUT=<dir> GO_ZONA=<k> GO_T="0.5 3" openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
set ZONA $::env(GO_ZONA)
set TS $::env(GO_T)
file mkdir $OUT
set LOG [open "$OUT/mapa.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc h {a} { return [format %02X [debug read memory $a]] }
proc estado {} { return [debug read memory 0xC000] }
proc vuelca {n} {
    global OUT
    set f [open "$OUT/$n.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
    set f [open "$OUT/$n.pal" wb]; puts -nonewline $f [debug read_block "VDP palette" 0 32]; close $f
    set f [open "$OUT/$n.ram" wb]; puts -nonewline $f [debug read_block memory 0xC000 0x4000]; close $f
    screenshot -raw "$OUT/$n.png"
    say "$n  C000=[h 0xC000] C001=[h 0xC001] C288=[h 0xC288] C280=[h 0xC280] C281=[h 0xC281] C289=[h 0xC289] CD11=[h 0xCD11]"
}
proc entra {} {
    if {[estado] == 5} { say "en la partida" ; after time 1.0 a_la_zona ; return }
    keymatrixdown 8 0x01
    after time 0.1 { keymatrixup 8 0x01 }
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
    after time 1.5 pasada
}
proc pasada {} {
    debug write memory 0xC004 1
    debug write memory 0xC001 0
    debug write memory 0xC000 4
    say "al estado 4, paso 0"
    after time 0.05 mira
}
proc mira {} {
    global TS
    if {[estado] == 4 && [debug read memory 0xC001] == 1} {
        set ::throttle on
        foreach t $TS { after time $t [list vuelca [format "p%s" [string map {. _} $t]]] }
        after time [expr {[lindex [lsort -real $TS] end] + 0.5}] exit
        return
    }
    after time 0.05 mira
}
set throttle off
after time 2 entra
after time 300 { say "tiempo  C000=[h 0xC000] C001=[h 0xC001]" ; exit 1 }
