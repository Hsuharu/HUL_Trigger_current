library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity DPWM is
  port(
    rst             : in std_logic;
    clk_trg         : in std_logic;
--    clk_sys         : in std_logic;
    
    -- input signal --
    in1             : in  std_logic;
    reg_delay       : in  std_logic_vector(4 downto 0);
    reg_counter     : in  std_logic_vector(4 downto 0);
    -- output signal --
    out1            : out std_logic
    );
end DPWM;

architecture RTL of DPWM is
  -- signal decralation -------------------------------------------------------------
	constant NbitOut      : positive := 5;
	signal state_lbus    	: BusProcessType;

  -- For Delay ----------------------------------------------------------
	signal delay_in       : std_logic;
	signal delay_out      : std_logic;
	signal shiftreg       : std_logic_vector(15 downto 0);

  -- For PWM ------------------------------------------------------------
	signal counter_max    : std_logic_vector(NbitOut-1 downto 0);
	signal counter        : std_logic_vector(NbitOut-1 downto 0);
	signal synchro        : std_logic_vector(1 downto 0);
	signal din_edge       : std_logic_vector(1 downto 0);
--	signal din_edge       : std_logic;

	signal in_1           : std_logic;
	signal out_1          : std_logic;

--	component EDG is
--             port (
--                 rst : in std_logic;
--                 clk : in std_logic;
--                 dIn : in std_logic;
--                 dOut : out std_logic 
--                  );
--	end component;

begin
      -- =================================== body =======================================
      -- signal connection -------------------------------------------------------
      -- For Delay ----------------------------------------------------------
	delay_in <= in1;
--	delay_out <= delay_in     when(reg_delay = "00000") else
	delay_out <= shiftreg(0 ) when(reg_delay = "00001") else            
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


	-- For PWM ------------------------------------------------------------
	din_edge <= synchro(1) & synchro(0); 
	in_1     <= delay_out;
	out1     <= out_1;

	counter_max  <= reg_counter; 

--        DPWM_EDG : EDG
--            port map (
--                     rst  => rst       ,
--                     clk  => clk_trg   ,
--                     dIn  => in_1,
--                     dOut => din_edge
--                     );

	process ( clk_trg, rst )
	begin
		if( rst = '1' ) then
			synchro  <= ( others => '0');
		elsif(clk_trg'event and clk_trg ='1') then

			synchro(0) <= in_1 ; 
			synchro(1) <= synchro(0) ; 
		end if;
	end process;

--	process ( clk_trg, rst )
--	begin
--		if( rst = '1' ) then
--			out_1    <= '0';
--			counter <= ( others => '0');
--		elsif(clk_trg'event and clk_trg ='1') then
--			      if(din_edge = "01" ) then
----			      if(din_edge = '1' ) then
--			      	out_1 <= '1';
--			      	counter <= counter + 1;
--			      elsif(counter = counter_max ) then
--			      	out_1 <= '0';
--			      	counter <= ( others => '0');
--			      elsif(counter /= "00000" ) then
--			      	out_1 <= '1';
--			      	counter <= counter + 1;
--			      end if;
--		end if;
--	end process;

	process ( clk_trg, rst )
	begin
		if( rst = '1' ) then
			out_1    <= '0';
			counter <= ( others => '0');
		elsif(clk_trg'event and clk_trg ='1') then
			      if(counter = counter_max ) then
			      	out_1 <= '0';
			      	counter <= ( others => '0');
			      elsif(counter /= counter_max and din_edge = "01" ) then
			      	out_1 <= '1';
			      	counter <= counter + 1;
			      elsif(counter /= "00000" ) then
			      	out_1 <= '1';
			      	counter <= counter + 1;
			      end if;
		end if;
	end process;

end RTL;
