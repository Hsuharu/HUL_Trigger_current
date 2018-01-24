library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity FDLY is
  port(
    rst                 : in std_logic;
    clk_trg             : in std_logic;
    
    -- input signal --
    in1     : in  std_logic;
    -- output signal --
    out1    : out std_logic

    );
end FDLY;

architecture RTL of FDLY is
--  attribute keep : string;

  -- signal decralation -------------------------------------------------------------
  signal out_1      : std_logic;
  signal in_1       : std_logic;
  signal shiftreg       : std_logic_vector(11 downto 0);

begin
  -- =================================== body =======================================
  -- signal connection -------------------------------------------------------
  out1    <= out_1;
	in_1 <= in1;
--	out_1 <=  shiftreg(0 ) ;
--		  shiftreg(1 ) ;
--		  shiftreg(2 ) ;
--		  shiftreg(3 ) ;
--		  shiftreg(4 ) ;
--		  shiftreg(5 ) ;
--   out_1 <= shiftreg(5) ;
--		  shiftreg(6 ) ;
--		  shiftreg(7 ) ;
--   out_1 <= shiftreg(7) ;
--		  shiftreg(8 ) ;
--		  shiftreg(9 ) ;
--   out_1 <= shiftreg(9) ;
--		  shiftreg(10) ;
--		  shiftreg(11) ;
--   out_1 <= shiftreg(12) ;
--		  shiftreg(13) ;
   out_1 <= shiftreg(11) ;
--		  shiftreg(14) ;
--		  shiftreg(15) ;
		   

	process ( clk_trg, rst )
	begin
		if( rst = '1' ) then
			shiftreg <= ( others => '0');
		elsif( clk_trg'event and clk_trg='1' ) then
			shiftreg  <= shiftreg(12-2 downto 0 ) & in_1 ;
		end if;

		
	end process;



end RTL;
