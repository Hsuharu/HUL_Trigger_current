vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/mylib

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap mylib riviera/mylib

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work mylib  -v2k5 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../ip/clk_wiz_1/clk_wiz_1_clk_wiz.v" \
"../../../ip/clk_wiz_1/clk_wiz_1.v" \

vlog -work mylib \
"glbl.v"

