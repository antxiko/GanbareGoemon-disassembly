# omsx_demo.tcl - deja correr el cartucho sin tocar nada y hace una foto cada
# GO_PASO segundos, apuntando el estado del juego (0xC000/0xC001) en el log.
#   GO_OUT=<dir> openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
set PASO 3.0
set N 40
file mkdir $OUT
set LOG [open "$OUT/demo.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
set ::k 0
proc foto {} {
    global OUT N PASO
    incr ::k
    set n [format %02d $::k]
    if {[catch {screenshot -raw "$OUT/d$n.png"} e]} { say "ERROR $e" }
    say "foto $n  C000=[format %02X [debug read memory 0xC000]] C001=[format %02X [debug read memory 0xC001]]"
    if {$::k >= $N} { exit 0 }
    after time $PASO foto
}
after time 2 foto
