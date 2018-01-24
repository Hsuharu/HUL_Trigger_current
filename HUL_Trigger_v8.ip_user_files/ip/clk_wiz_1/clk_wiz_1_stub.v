// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
// Date        : Fri Nov 10 20:33:08 2017
// Host        : suharu0201 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top clk_wiz_1 -prefix
//               clk_wiz_1_ clk_wiz_1_stub.v
// Design      : clk_wiz_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tfbg676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_1(clk_sys, reset, sys_locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_sys,reset,sys_locked,clk_in1" */;
  output clk_sys;
  input reset;
  output sys_locked;
  input clk_in1;
endmodule
