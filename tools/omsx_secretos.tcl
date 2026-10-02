# omsx_secretos.tcl - los secretos que solo se habian leido en el codigo, en
# UNA partida y con teclas de verdad (keymatrix), apuntando la RAM:
#  A. en el menu del titulo, 6 cambios de opcion (cursor abajo): 0xEF81 = 6 y,
#     al entrar en la zona, p00:5EB6 llama a p03:BEDD (bit 6 de 0xEF80).
#  B. F1 (pausa) y す き や ね ん con las teclas de la tabla de p01:6CD8
#     (banco 6, 0xADEC): bit 1 de 0xEF80 (p03:BE2C).
#  C. F2 en la pausa: al estado 0x0D, la contrasena (p01:6B5F) en 0xEB90;
#     F2 otra vez la quita (p01:6237) y F1 la pausa.
#  D. dinero a 4800 ryo, una vida, continuar puesto (0xC27F) y vida 0:
#     al morir el dinero a la mitad (p01:701E); en el estado 7, F5 (p00:5F8E)
#     y la partida sigue con 3 vidas (p00:5FF1).
#  E. dentro del "laberinto" forzado (0xCDB1 = 1) y en la pausa, お や ぶ ん:
#     bit 0 de 0xEF80 y 0xC27A = 1 (p03:BE13).
#   GO_OUT=<dir> openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
file mkdir $OUT
set LOG [open "$OUT/secretos.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc h {a} { return [format %02X [debug read memory $a]] }
proc hs {a n} { set s "" ; for {set k 0} {$k < $n} {incr k} { append s [h [expr {$a + $k}]] " " } ; return $s }
proc estado {} { return [debug read memory 0xC000] }
# una tecla: fila, bit
proc tecla {f b} { keymatrixdown $f [expr {1 << $b}] ; after time 0.08 "keymatrixup $f [expr {1 << $b}]" }
# una lista de teclas {fila bit} con 0.35 s entre una y otra; luego el comando
proc teclas {lista fin} {
    if {[llength $lista] == 0} { after time 0.5 $fin ; return }
    set t [lindex $lista 0]
    tecla [lindex $t 0] [lindex $t 1]
    after time 0.35 [list teclas [lrange $lista 1 end] $fin]
}
proc espera_estado {e fin} {
    if {[estado] == $e} { eval $fin ; return }
    after time 0.1 [list espera_estado $e $fin]
}
# --- A: el menu del titulo
proc al_titulo {} {
    if {[estado] == 1} { say "titulo  EF81=[h 0xEF81]" ; after time 1.0 abajo6 ; return }
    tecla 8 0
    after time 0.6 al_titulo
}
proc abajo6 {} { teclas {{8 6} {8 6} {8 6} {8 6} {8 6} {8 6}} a_jugar }
proc a_jugar {} {
    say "A: tras 6 cambios EF81=[h 0xEF81] C252=[h 0xC252]"
    tecla 8 0
    espera_estado 5 { after time 1.5 tras_A }
}
proc tras_A {} {
    say "A: en la partida  EF80=[h 0xEF80] (bit 6 = el menu)"
    tecla 6 5
    espera_estado 10 { after time 0.6 B }
}
# --- B: sukiyanen
proc B {} {
    say "B: pausa  C590=[h 0xC590] FCAD=[h 0xFCAD]"
    teclas {{3 1} {5 4} {4 3} {1 1} {2 5}} tras_B
}
proc tras_B {} {
    say "B: C580=[hs 0xC580 5] C590=[h 0xC590] EF80=[h 0xEF80] (bit 1 = sukiyanen)"
    tecla 6 6
    after time 3.0 tras_C
}
# --- C: F2
proc tras_C {} {
    say "C: tras F2  estado=[h 0xC000] paso=[h 0xC001] C28C=[h 0xC28C] EB90=[hs 0xEB90 9]"
    tecla 6 6
    after time 1.0 { say "C: tras F2 otra vez  estado=[h 0xC000]" ; tecla 6 5 }
    after time 2.5 tras_C2
}
proc tras_C2 {} {
    say "C: tras F1  estado=[h 0xC000]"
    if {[estado] != 5} { say "no vuelve a la partida" ; exit 1 }
    after time 1.0 D
}
# --- D: morir con continuar
proc D {} {
    debug write memory 0xC265 0x00
    debug write memory 0xC266 0x48
    debug write memory 0xC260 1
    debug write memory 0xC27F 1
    say "D: antes  dinero C265/6=[hs 0xC265 2] vidas C260=[h 0xC260] C27F=[h 0xC27F] vida C481=[h 0xC481]"
    debug set_bp 0x700A {} { say "D: pierde (p01:700A)  dinero=[hs 0xC265 2] vidas=[h 0xC260] tiempo C4B0=[hs 0xC4B0 2]" }
    debug set_bp 0x704D {} { say "D: tras la mitad (p01:704D)  dinero=[hs 0xC265 2]" }
    debug write memory 0xC481 0
    espera_estado 7 { after time 1.0 D7 }
}
proc D7 {} {
    say "D: estado 7  dinero=[hs 0xC265 2] vidas=[h 0xC260] C486=[h 0xC486]"
    keymatrixdown 7 0x02
    after time 1.0 { keymatrixup 7 0x02 ; say "D: tras F5  C486=[h 0xC486]" }
    after time 1.2 { espera_estado 5 { after time 1.5 tras_D } }
}
proc tras_D {} {
    say "D: sigue  estado=[h 0xC000] vidas=[h 0xC260] dinero=[hs 0xC265 2] puntos C257=[hs 0xC257 3]"
    tecla 6 5
    espera_estado 10 { after time 0.6 E }
}
# --- E: oyabun en el laberinto (forzado)
proc E {} {
    set ::CDB1 [h 0xCDB1]
    debug write memory 0xCDB1 1
    debug write memory 0xC27A 0
    say "E: pausa  CDB1 era $::CDB1, ahora 01; C590=[h 0xC590]"
    teclas {{0 5} {4 3} {3 6} {2 0} {2 5}} tras_E
}
proc tras_E {} {
    say "E: C580=[hs 0xC580 5] EF80=[h 0xEF80] (bit 0 = oyabun) C27A=[h 0xC27A]"
    say "fin"
    exit 0
}
set throttle off
after time 2 al_titulo
after time 400 { say "tiempo" ; exit 1 }
