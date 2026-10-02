# omsx_vuelca.tcl - deja correr la demo y, cada vez que cambia la casilla
# (0xC281) o el estado (0xC000), espera un segundo y vuelca la VRAM entera
# (128 KB), la paleta, los registros del VDP y la RAM de 0xC000 a 0xFFFF.
#   GO_OUT=<dir> openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
set MAX 12
file mkdir $OUT
set LOG [open "$OUT/vuelca.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
set ::n 0
set ::ultimo ""
proc vuelca {} {
    global OUT MAX
    incr ::n
    set k [format %02d $::n]
    set f [open "$OUT/v$k.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
    set f [open "$OUT/v$k.pal" wb]; puts -nonewline $f [debug read_block "VDP palette" 0 32]; close $f
    set f [open "$OUT/v$k.ram" wb]; puts -nonewline $f [debug read_block memory 0xC000 0x4000]; close $f
    set r {}
    for {set i 0} {$i < 24} {incr i} { lappend r [format %02X [debug read "VDP regs" $i]] }
    say "volcado $k  C000=[format %02X [debug read memory 0xC000]] C288=[debug read memory 0xC288] C280=[debug read memory 0xC280] C281=[debug read memory 0xC281] C289=[debug read memory 0xC289] R=$r"
    if {$::n >= $MAX} { exit 0 }
}
proc mira {} {
    set ahora "[debug read memory 0xC000]-[debug read memory 0xC281]"
    if {$ahora ne $::ultimo} {
        set ::ultimo $ahora
        after time 1.0 vuelca
    }
    after time 0.25 mira
}
after time 3 mira
after time 150 { say "tiempo" ; exit 0 }
