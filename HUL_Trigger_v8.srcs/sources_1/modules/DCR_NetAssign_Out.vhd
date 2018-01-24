----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2017/10/27 11:58:02
-- Design Name: 
-- Module Name: DCR_NetAssign_Out - RTL
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DCR_NetAssign_Out is
    Port (
        mzn_out_u  : out  std_logic_vector(31 downto 0);
        mzn_out_d  : out  std_logic_vector(31 downto 0);
        dcr_in_u   : in std_logic_vector(31 downto 0);
        dcr_in_d   : in std_logic_vector(31 downto 0)
    );
end DCR_NetAssign_Out;

architecture Behavioral of DCR_NetAssign_Out is

begin
    mzn_out_u(15)   <= NOT dcr_in_u(0) ;
    mzn_out_u(13)   <=     dcr_in_u(1) ; 
    mzn_out_u(11)   <=     dcr_in_u(2) ; 
    mzn_out_u(9)    <= NOT dcr_in_u(3) ; 
    mzn_out_u(7)    <=     dcr_in_u(4) ; 
    mzn_out_u(5)    <=     dcr_in_u(5) ; 
    mzn_out_u(3)    <=     dcr_in_u(6) ; 
    mzn_out_u(1)    <=     dcr_in_u(7) ; 
    mzn_out_u(31)   <=     dcr_in_u(8) ; 
    mzn_out_u(29)   <= NOT dcr_in_u(9) ;
    mzn_out_u(27)   <=     dcr_in_u(10);
    mzn_out_u(25)   <= NOT dcr_in_u(11);
    mzn_out_u(23)   <=     dcr_in_u(12);
    mzn_out_u(21)   <=     dcr_in_u(13);
    mzn_out_u(19)   <=     dcr_in_u(14);
    mzn_out_u(17)   <=     dcr_in_u(15);
    mzn_out_u(14)   <= NOT dcr_in_u(16);
    mzn_out_u(12)   <=     dcr_in_u(17);
    mzn_out_u(10)   <=     dcr_in_u(18);
    mzn_out_u(8)    <=     dcr_in_u(19);
    mzn_out_u(6)    <=     dcr_in_u(20);
    mzn_out_u(4)    <=     dcr_in_u(21);
    mzn_out_u(2)    <=     dcr_in_u(22);
    mzn_out_u(0)    <=     dcr_in_u(23);
    mzn_out_u(30)   <=     dcr_in_u(24);
    mzn_out_u(28)   <= NOT dcr_in_u(25);
    mzn_out_u(26)   <= NOT dcr_in_u(26);
    mzn_out_u(24)   <=     dcr_in_u(27);
    mzn_out_u(22)   <=     dcr_in_u(28);
    mzn_out_u(20)   <=     dcr_in_u(29);
    mzn_out_u(18)   <=     dcr_in_u(30);
    mzn_out_u(16)   <=     dcr_in_u(31);

    mzn_out_d(15)   <=     dcr_in_d(0) ;
    mzn_out_d(13)   <=     dcr_in_d(1) ;
    mzn_out_d(11)   <=     dcr_in_d(2) ;
    mzn_out_d(9)    <=     dcr_in_d(3) ;
    mzn_out_d(7)    <=     dcr_in_d(4) ;
    mzn_out_d(5)    <=     dcr_in_d(5) ;
    mzn_out_d(3)    <= NOT dcr_in_d(6) ;
    mzn_out_d(1)    <= NOT dcr_in_d(7) ;
    mzn_out_d(31)   <=     dcr_in_d(8) ;
    mzn_out_d(29)   <=     dcr_in_d(9) ;
    mzn_out_d(27)   <=     dcr_in_d(10);
    mzn_out_d(25)   <= NOT dcr_in_d(11);
    mzn_out_d(23)   <=     dcr_in_d(12);
    mzn_out_d(21)   <=     dcr_in_d(13);
    mzn_out_d(19)   <=     dcr_in_d(14);
    mzn_out_d(17)   <=     dcr_in_d(15);
    mzn_out_d(14)   <=     dcr_in_d(16);
    mzn_out_d(12)   <=     dcr_in_d(17);
    mzn_out_d(10)   <=     dcr_in_d(18);
    mzn_out_d(8)    <=     dcr_in_d(19);
    mzn_out_d(6)    <=     dcr_in_d(20);
    mzn_out_d(4)    <=     dcr_in_d(21);
    mzn_out_d(2)    <= NOT dcr_in_d(22);
    mzn_out_d(0)    <= NOT dcr_in_d(23);
    mzn_out_d(30)   <=     dcr_in_d(24);
    mzn_out_d(28)   <=     dcr_in_d(25);
    mzn_out_d(26)   <=     dcr_in_d(26);
    mzn_out_d(24)   <=     dcr_in_d(27);
    mzn_out_d(22)   <=     dcr_in_d(28);
    mzn_out_d(20)   <=     dcr_in_d(29);
    mzn_out_d(18)   <=     dcr_in_d(30);
    mzn_out_d(16)   <=     dcr_in_d(31);

end Behavioral;
