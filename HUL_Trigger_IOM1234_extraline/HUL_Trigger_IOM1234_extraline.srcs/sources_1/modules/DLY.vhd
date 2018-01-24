library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity DLY is
  port(
    rst                 : in std_logic;
    clk_trg             : in std_logic;
    
    -- input signal --
    delayin     : in  std_logic;
    reg_delay   : in  std_logic_vector(4 downto 0);
    -- output signal --
    delayout    : out std_logic

    );
end DLY;

architecture RTL of DLY is
--  attribute keep : string;

  -- signal decralation -------------------------------------------------------------
  constant NbitOut      : positive := 5;
  
  signal delay_out      : std_logic;
  signal delay_in       : std_logic;
  signal shiftreg       : std_logic_vector(15 downto 0);

begin
  -- =================================== body =======================================
  -- signal connection -------------------------------------------------------
  delayout    <= delay_out;
	delay_in <= delayin;
--	delay_out<= delay_in     when(reg_delay = "00000") else
	delay_out<=  shiftreg(0 ) when(reg_delay = "00001") else
		     shiftreg(1 ) when(reg_delay = "00010") else
		     shiftreg(2 ) when(reg_delay = "00011") else
		     shiftreg(3 ) when(reg_delay = "00100") else
		     shiftreg(4 ) when(reg_delay = "00101") else
		     shiftreg(5 ) when(reg_delay = "00110") else
		     shiftreg(6 ) when(reg_delay = "00111") else
		     shiftreg(7 ) when(reg_delay = "01000") else
		     shiftreg(8 ) when(reg_delay = "01001") else
		     shiftreg(9 ) when(reg_delay = "01010") else
		     shiftreg(10) when(reg_delay = "01011") else
		     shiftreg(11) when(reg_delay = "01100") else
		     shiftreg(12) when(reg_delay = "01101") else
		     shiftreg(13) when(reg_delay = "01110") else
		     shiftreg(14) when(reg_delay = "01111") else
		     shiftreg(15) ;
		   

	process ( clk_trg, rst )
	begin
		if( rst = '1' ) then
			shiftreg <= ( others => '0');
		elsif( clk_trg'event and clk_trg='1' ) then
			shiftreg  <= shiftreg(16-2 downto 0 ) & delay_in ;
		end if;

		
	end process;



end RTL;
