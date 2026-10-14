# omsx_sala.tcl - la sala del senor (el final de la fase, estado 0x0B) grabada:
# entra en la partida con ESPACIO; en el estado 5 pone la fase GO_FASE
# (0xC288) y el estado 0x0B en su paso 2 (p01:6120, la pantalla de la sala).
# Desde el paso 3, cada cuadro (60 por segundo) apunta en sala.txt el cuadro
# (0xC003), 0xCD54-0xCD57 y la copia de los sprites (0xEC00-0xEE7F, en hex);
# cada 30 cuadros vuelca la VRAM (vNNNN.vram) y la RAM; para al pasar al paso 4.
#   GO_OUT=<dir> GO_FASE=<f> openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
set FASE $::env(GO_FASE)
file mkdir $OUT
set LOG [open "$OUT/sala.log" w]
set TXT [open "$OUT/sala.txt" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc h {a} { return [format %02X [debug read memory $a]] }
proc estado {} { return [debug read memory 0xC000] }
proc entra {} {
    if {[estado] == 5} { say "en la partida" ; after time 1.5 a_la_sala ; return }
    keymatrixdown 8 0x01
    after time 0.1 { keymatrixup 8 0x01 }
    after time 0.6 entra
}
proc a_la_sala {} {
    debug write memory 0xC288 $::FASE
    # GO_CD60: los golpes a la figura de tipo 0x21 (p03:A9D3); con 8 o mas, el
    # senor se enfada (p02:9C3D) y dice el texto de 0x9F92 (p02:9BBF)
    if {[info exists ::env(GO_CD60)]} { debug write memory 0xCD60 $::env(GO_CD60) }
    debug write memory 0xC001 2
    debug write memory 0xC000 11
    say "al estado 0x0B, paso 2, fase $::FASE"
    set ::n 0
    after frame graba
}
proc graba {} {
    if {[estado] != 11} { say "fuera del estado 0x0B" ; exit 1 }
    set p [debug read memory 0xC001]
    if {$p >= 4} { say "paso 4: fin ($::n cuadros)" ; close $::TXT ; close $::AZAR ; exit 0 }
    if {$p == 3} {
        set b [debug read_block memory 0xEC00 0x280]
        binary scan $b H* hx
        puts $::TXT "[h 0xC003] [h 0xCD54] [h 0xCD55] [h 0xCD56] [h 0xCD57] $hx"
        if {$::n % 30 == 0} {
            set nom [format "v%04d" $::n]
            set f [open "$::OUT/$nom.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
            set f [open "$::OUT/$nom.ram" wb]; puts -nonewline $f [debug read_block memory 0xC000 0x4000]; close $f
        }
        if {$::n == 0} {
            set f [open "$::OUT/pal.bin" wb]; puts -nonewline $f [debug read_block "VDP palette" 0 32]; close $f
            say "paso 3: empieza"
        }
        incr ::n
    }
    after frame graba
}
# Los numeros al azar: cada `ld a,r` del cartucho (12 sitios) apunta en
# azar.txt, en el paso 3 de la escena, el cuadro (0xC003), su direccion y lo
# que deja en A (leido en la instruccion siguiente), para que tools/sala.py
# los use en el mismo orden.
set AZAR [open "$OUT/azar.txt" w]
set ::lar 0
foreach a {0x7E7B 0x85B4 0x9776 0x9837 0xA398 0xA434 0xA858 0xAAE5 0xAC28 0xAC31 0xB2BB 0xB77E} {
    debug set_bp $a {} [list set ::lar $a]
    debug set_bp [expr {$a + 2}] {} [list apunta_azar $a]
}
proc apunta_azar {a} {
    if {$::lar == $a && [estado] == 11 && [debug read memory 0xC001] == 3} {
        puts $::AZAR "[h 0xC003] [format %04X $a] [format %02X [reg a]]"
        flush $::AZAR
        set ::lar 0
    }
}
set throttle off
after time 2 entra
after time 900 { say "tiempo  C000=[h 0xC000] C001=[h 0xC001] n=$::n" ; exit 1 }
