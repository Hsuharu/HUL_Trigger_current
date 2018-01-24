-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/mylib \
  "../../../ip/clk_wiz_2/clk_wiz_2_clk_wiz.v" \
  "../../../ip/clk_wiz_2/clk_wiz_2.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

