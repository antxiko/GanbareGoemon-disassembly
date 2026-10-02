# omsx_konami.tcl - vuelca la VRAM cuando p01:6492 da por acabado el barrido
# del logotipo de Konami (pone 0xC482 a 1) y sale.
#   GO_OUT=<dir> openmsx -machine C-BIOS_MSX2_JP -cart goemon.rom -script este.tcl
set OUT $::env(GO_OUT)
file mkdir $OUT
set LOG [open "$OUT/konami.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc vuelca {} {
    global OUT
    set f [open "$OUT/konami.vram" wb]; puts -nonewline $f [debug read_block VRAM 0 131072]; close $f
    set f [open "$OUT/konami.pal" wb]; puts -nonewline $f [debug read_block "VDP palette" 0 32]; close $f
    say "volcado R7=[format %02X [debug read {VDP regs} 7]]"
    exit 0
}
debug set_bp 0x6492 {} { after time 0.1 vuelca }
after time 30 { say "no llego" ; exit 1 }
