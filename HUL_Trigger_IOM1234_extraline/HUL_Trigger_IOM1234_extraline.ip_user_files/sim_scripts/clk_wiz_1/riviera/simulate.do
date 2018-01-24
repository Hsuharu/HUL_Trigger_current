onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+clk_wiz_1 -L xil_defaultlib -L xpm -L mylib -L unisims_ver -L unimacro_ver -L secureip -O5 mylib.clk_wiz_1 mylib.glbl

do {wave.do}

view wave
view structure

do {clk_wiz_1.udo}

run -all

endsim

quit -force
