onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L mylib -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib mylib.clk_wiz_1 mylib.glbl

do {wave.do}

view wave
view structure
view signals

do {clk_wiz_1.udo}

run -all

quit -force
