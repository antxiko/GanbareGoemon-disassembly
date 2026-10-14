# omsx_final.tcl - el final por su camino: ESPACIO en el titulo, y ya en la
# partida (estado 5) la fase 6 (0xC288), 0xC26A = GO_C26A y el estado 0x0B en su
# paso 2 (p01:6120, la pantalla del final de fase, que pone la paleta de
# p00:4D72); su paso 4 pasa a la fase 7 y al estado 0x0F. Vuelca la VRAM y la
# paleta cuando el texto acaba (0xCD67 = 1) y cuando salen los sprites (paso 2).
#   GO_OUT=<dir> GO_C26A=<n> openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
set C26A $::env(GO_C26A)
file mkdir $OUT
set LOG [open "$OUT/final.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc vuelca {n} {
    global OUT
    set f [open "$OUT/$n.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
    set f [open "$OUT/$n.pal" wb]; puts -nonewline $f [debug read_block "VDP palette" 0 32]; close $f
    set f [open "$OUT/$n.ram" wb]; puts -nonewline $f [debug read_block memory 0xC000 0x4000]; close $f
    screenshot -raw "$OUT/$n.png"
    say "volcado $n  C000=[debug read memory 0xC000] C001=[debug read memory 0xC001] C26A=[debug read memory 0xC26A] EF00=[debug read memory 0xEF00]"
}
set ::fase 0
proc mira {} {
    set e [debug read memory 0xC000]
    set p [debug read memory 0xC001]
    if {$::fase == 0 && $e == 1} {
        keymatrixdown 8 0x01
        after time 0.1 { keymatrixup 8 0x01 }
    }
    if {$::fase == 0 && $e == 5} {
        set ::fase 1
        after time 2 {
            debug write memory 0xC288 6
            debug write memory 0xC26A [expr {$::C26A - 1}]
            debug write memory 0xC001 2
            debug write memory 0xC000 11
            say "a la pantalla del final de fase"
        }
    }
    if {$::fase == 1 && $e == 15} { set ::fase 2; set ::throttle on; say "estado 0x0F (a velocidad normal: con throttle off la foto se salta cuadros)" }
    if {$::fase == 2 && $e == 15 && $p == 1 && [debug read memory 0xCD67] == 1} {
        set ::fase 3
        after time 1 { vuelca texto }
    }
    if {$::fase == 3 && $e == 15 && $p == 2} {
        set ::fase 4
        after time 1 { vuelca sprites; exit 0 }
    }
    after time 0.05 mira
}
set throttle off
after time 1 mira
after time 600 { say "se acabo el tiempo  C000=[debug read memory 0xC000] C001=[debug read memory 0xC001] fase=$::fase"; exit 1 }
