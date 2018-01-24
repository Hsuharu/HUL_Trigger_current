vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm
vlib msim/mylib

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm
vmap mylib msim/mylib

vlog -work xil_defaultlib -64 -sv "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work mylib -64 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../ip/clk_wiz_2/clk_wiz_2_clk_wiz.v" \
"../../../ip/clk_wiz_2/clk_wiz_2.v" \

vlog -work mylib \
"glbl.v"

