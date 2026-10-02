# omsx_entrada_pasadizo.tcl - la entrada al pasadizo secreto como en el juego:
# se entra en el interior 16 por la puerta (0xC500 con el bit 7, 0xC482 = 1,
# 0xC283 = 5, como omsx_interiores.tcl), con 1000 ryo; CTRL dice que si (el
# segundo boton elige y el primero cambia de opcion, p03:B0AD); p03:B58E paga
# 900, pone 0xCDB0 = 1 y abre la puerta del fondo (icono 0x0E en (0x30, 0x20)).
# Con las teclas se rodea el mostrador por la izquierda, se sube hasta arriba,
# se va a x 0x30-0x50 y arriba entra (p01:7D0D). Apunta 0xCDB0, 0xCDB1, el
# dinero y el sitio del jugador.
#   GO_OUT=<dir> openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
file mkdir $OUT
set LOG [open "$OUT/entrada.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc h {a} { return [format %02X [debug read memory $a]] }
proc estado {} { return [debug read memory 0xC000] }
proc sitio {} { return "x=[h 0xC496] y=[h 0xC494] dinero=[h 0xC266][h 0xC265] CDB0=[h 0xCDB0] CDB1=[h 0xCDB1] C482=[h 0xC482] estado=[h 0xC000]" }
proc vuelca {n} {
    global OUT
    set f [open "$OUT/$n.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
    set f [open "$OUT/$n.pal" wb]; puts -nonewline $f [debug read_block "VDP palette" 0 32]; close $f
    set f [open "$OUT/$n.ram" wb]; puts -nonewline $f [debug read_block memory 0xC000 0x4000]; close $f
}
proc entra {} {
    if {[estado] == 5} { say "en la partida" ; after time 2.0 al_interior ; return }
    keymatrixdown 8 0x01
    after time 0.1 { keymatrixup 8 0x01 }
    after time 0.6 entra
}
proc al_interior {} {
    debug write memory 0xC265 0x00
    debug write memory 0xC266 0x10
    debug write memory 0xC27E 0
    debug write memory 0xC500 [expr {0x80 | 16}]
    debug write memory 0xC501 0x80
    debug write memory 0xC502 0x80
    debug write memory 0xC482 1
    debug write memory 0xC283 5
    after time 0.5 espera
}
proc espera {} {
    if {[estado] != 5 || [debug read memory 0xC482] != 1} { after time 0.2 espera ; return }
    after time 6.0 { say "dentro: [sitio] CD82=[h 0xCD82]" ; vuelca i16 ; si }
}
proc si {} {
    keymatrixdown 6 0x02
    after time 0.2 { keymatrixup 6 0x02 }
    after time 3.0 { say "tras CTRL: [sitio] CD82=[h 0xCD82]" ; vuelca i16_pagado ; izquierda }
}
# el mostrador tapa el camino recto: se rodea por la izquierda
proc ve {x0 x1 fin} {
    set x [debug read memory 0xC496]
    if {$x >= $x0 && $x < $x1} { keymatrixup 8 0x90 ; say "x $x0-$x1: [sitio]" ; after time 0.3 $fin ; return }
    if {$x < $x0} { keymatrixup 8 0x10 ; keymatrixdown 8 0x80 } else { keymatrixup 8 0x80 ; keymatrixdown 8 0x10 }
    after time 0.05 [list ve $x0 $x1 $fin]
}
proc izquierda {} { ve 0x25 0x2E sube }
set ::antes -1
set ::quieto 0
proc sube {} {
    set y [debug read memory 0xC494]
    if {$y == $::antes} { incr ::quieto } else { set ::quieto 0 }
    set ::antes $y
    if {$::quieto > 20} { keymatrixup 8 0x20 ; say "arriba del todo: [sitio]" ; after time 0.3 { ve 0x30 0x50 arriba } ; return }
    keymatrixdown 8 0x20
    after time 0.05 sube
}
set ::vueltas 0
proc arriba {} {
    set y [debug read memory 0xC494]
    incr ::vueltas
    if {[debug read memory 0xCDB1] != 0} { keymatrixup 8 0x20 ; say "DENTRO DEL PASADIZO: [sitio]" ; after time 1.5 { vuelca pasadizo ; say fin ; exit 0 } ; return }
    if {$::vueltas % 40 == 0} { say "subiendo: [sitio]" }
    if {$::vueltas > 200} { keymatrixup 8 0x20 ; say "no entra: [sitio]" ; vuelca no_entra ; exit 1 }
    keymatrixdown 8 0x20
    after time 0.05 arriba
}
set throttle off
after time 2 entra
after time 200 { say "tiempo: [sitio]" ; exit 1 }
