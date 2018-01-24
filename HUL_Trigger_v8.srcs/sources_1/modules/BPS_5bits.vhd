library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity BPS_5bits is
  port(
    rst            : in std_logic;
    clk_trg        : in std_logic;
--    clk_sys        : in std_logic;
    
    -- input signal --
      inA          : in  std_logic;
      inB          : in  std_logic;
      inC          : in  std_logic;
      inD          : in  std_logic;
      inE          : in  std_logic;
      reg_ctrl     : in  std_logic_vector(4 downto 0);
      reg_coin     : in  std_logic_vector(4 downto 0);
    -- output signal --
      out1  : out std_logic
    );
end BPS_5bits;

architecture RTL of BPS_5bits is
--  attribute keep : string;

  -- signal decralation -------------------------------------------------------------
  constant NbitOut      : positive := 5;
  
  signal state_lbus    	: BusProcessType;
  
  signal in_A         : std_logic;
  signal in_B         : std_logic;
  signal in_C         : std_logic;
  signal in_D         : std_logic;
  signal in_E         : std_logic;
  signal BitPattern   : std_logic_vector( NbitOut-1 downto 0 );
  signal out_1        : std_logic;

--   attribute keep of BitPattern   :signal is "true";

begin
  -- =================================== body =======================================
  -- signal connection -------------------------------------------------------
  -- in/out --
	in_A     <= inA;
	in_B     <= inB;
        in_C     <= inC;
        in_D     <= inD;
        in_E     <= inE;
--	out1     <= out_1;

	BitPattern(4)     <= in_A when( reg_ctrl(4) ='1' ) else '0';
	BitPattern(3)     <= in_B when( reg_ctrl(3) ='1' ) else '0';
	BitPattern(2)     <= in_C when( reg_ctrl(2) ='1' ) else '0';
	BitPattern(1)     <= in_D when( reg_ctrl(1) ='1' ) else '0';
	BitPattern(0)     <= in_E when( reg_ctrl(0) ='1' ) else '0';

	out_1 <= '1' when( BitPattern = reg_coin ) else '0' ;

	process ( clk_trg, rst )
	begin
		if( rst = '1' ) then
			out1 <= '0';
		elsif( clk_trg'event and clk_trg='1' ) then
                	out1     <= out_1;
		end if;
	end process;
		

end RTL;

