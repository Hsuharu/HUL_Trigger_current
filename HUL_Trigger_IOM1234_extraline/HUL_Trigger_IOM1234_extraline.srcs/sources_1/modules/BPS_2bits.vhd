library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity BPS_2bits is
  port(
    rst            : in std_logic;
    clk_trg        : in std_logic;
--    clk_sys        : in std_logic;
    
    -- input signal --
      inA          : in  std_logic;
      inB          : in  std_logic;
      reg_ctrl     : in  std_logic_vector(1 downto 0);
      reg_coin     : in  std_logic_vector(1 downto 0);
    -- output signal --
      out1  : out std_logic
    );
end BPS_2bits;

architecture RTL of BPS_2bits is
--  attribute keep : string;

  -- signal decralation -------------------------------------------------------------
  constant NbitOut      : positive := 2;
  
  signal state_lbus    	: BusProcessType;
  
  signal in_A         : std_logic;
  signal in_B         : std_logic;
  signal BitPattern   : std_logic_vector( 1 downto 0 );
  signal out_1        : std_logic;

--   attribute keep of BitPattern   :signal is "true";

begin
  -- =================================== body =======================================
  -- signal connection -------------------------------------------------------
  -- in/out --
	in_A     <= inA;
	in_B     <= inB;
--	out1     <= out_1;

	BitPattern(1)     <= in_A when( reg_ctrl(1) ='1' ) else '0';
	BitPattern(0)     <= in_B when( reg_ctrl(0) ='1' ) else '0';

	out_1 <= '1' when( reg_coin = BitPattern ) else '0' ;

	process ( clk_trg, rst )
	begin
		if( rst = '1' ) then
			out1 <= '0';
		elsif( clk_trg'event and clk_trg='1' ) then
                	out1     <= out_1;
		end if;

		
	end process;


end RTL;
