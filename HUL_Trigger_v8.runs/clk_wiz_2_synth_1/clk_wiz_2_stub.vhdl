-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
-- Date        : Mon Dec 25 14:37:30 2017
-- Host        : suharu0201 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/suharu/Desktop/FPGA/HUL_Trigger_Pro_IOM12/HUL_Trigger_Pro_IOM12.runs/clk_wiz_2_synth_1/clk_wiz_2_stub.vhdl
-- Design      : clk_wiz_2
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k160tfbg676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz_2 is
  Port ( 
    clk_clock : out STD_LOGIC;
    reset : in STD_LOGIC;
    clk_locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_wiz_2;

architecture stub of clk_wiz_2 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_clock,reset,clk_locked,clk_in1";
begin
end;
