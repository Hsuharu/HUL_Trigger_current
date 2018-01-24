library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity PWM is
  port(
    rst                 : in std_logic;
    clk_trg             : in std_logic;
    
    -- input signal --
      in1   : in  std_logic;
      reg_counter  : in  std_logic_vector(3 downto 0);
    
    -- output signal --
      out1  : out std_logic
    );
end PWM;

architecture RTL of PWM is
--  attribute keep : string;

  -- signal decralation -------------------------------------------------------------
  constant NbitOut      : positive := 4;
  
  signal state_lbus    	: BusProcessType;
  
  signal counter_max  : std_logic_vector(3 downto 0);
  signal counter      : std_logic_vector(3 downto 0);
  signal synchro      : std_logic_vector(1 downto 0);
--  signal din_edge     : std_logic_vector(1 downto 0);
  signal din_edge     : std_logic;
  
  signal in_1         : std_logic;
  signal out_1        : std_logic;

	component EDG is
             port (
                 rst : in std_logic;
                 clk : in std_logic;
                 dIn : in std_logic;
                 dOut : out std_logic 
                  );
	end component;
begin
  -- =================================== body =======================================
  -- signal connection -------------------------------------------------------
--	din_edge <= synchro(1) & synchro(0); 
	in_1     <= in1;
	out1     <= out_1;


        counter_max  <= reg_counter; 

        PWM_EDG : EDG
            port map (
                     rst  => rst       ,
                     clk  => clk_trg   ,
                     dIn  => in_1,
                     dOut => din_edge
                     );

--	process ( clk_trg, rst )
--	  	begin
--	  	  if( rst = '1' ) then
--		      synchro  <= ( others => '0');
--		  elsif(clk_trg'event and clk_trg ='1') then
--		      synchro(0) <= in_1 ; 
--		      synchro(1) <= synchro(0) ; 
--		  end if;
--	end process;

	process ( clk_trg, rst )
	  	begin
	  	  if( rst = '1' ) then
		      out_1    <= '0';
		      counter <= ( others => '0');
		    elsif(clk_trg'event and clk_trg ='1') then
--		      if(din_edge = "01" ) then
		      if(din_edge = '1' ) then
		      	out_1 <= '1';
		        counter <= counter + 1;
		      elsif(counter = counter_max ) then
			    out_1 <= '0';
		        counter <= ( others => '0');
		      elsif(counter /= "0000" ) then
                 out_1 <= '1';
                 counter <= counter + 1;
		      end if;
		    end if;
	end process;


end RTL;
