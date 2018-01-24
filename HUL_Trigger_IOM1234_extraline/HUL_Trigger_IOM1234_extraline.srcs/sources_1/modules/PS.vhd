library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity PS is
  port(
    rst                 : in std_logic;
    clk_trg             : in std_logic;
    
    -- input signal --
      in1   : in  std_logic;

    -- output signal --
      out1  : out std_logic;
--      hoge  : out std_logic;
--      hoge1  : out std_logic;
--      hoge2  : out std_logic;
    
    -- register --
      reg_counter :in std_logic_vector(23 downto 0)
    );
end PS;

architecture RTL of PS is
--  attribute keep : string;

  -- signal decralation -------------------------------------------------------------
  constant NbitOut      : positive := 4;
  
  signal state_lbus    	: BusProcessType;
  
  signal counter_max  : std_logic_vector(23 downto 0);
  signal counter      : std_logic_vector(23 downto 0);
--  signal const1       : std_logic_vector(15 downto 0):="1111111111111111";
  signal synchro      : std_logic_vector(1 downto 0);
  signal din_edge     : std_logic_vector(1 downto 0);
--  signal din_edge     : std_logic;
  signal leading_edge : std_logic;
  signal pre_gate     : std_logic;
  
  signal in_1         : std_logic;
  signal out_1        : std_logic;
--  signal in_hoge       : std_logic;
--  signal in_hoge1       : std_logic;
--  signal in_hoge2       : std_logic;

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
  -- in/out --
	din_edge <= synchro(1) & synchro(0); 
	in_1     <= in1;
	out1     <= out_1;
--	hoge     <= in_hoge;
--	hoge1     <= in_hoge1;
--	hoge2     <= in_hoge2;
	out_1    <= pre_gate and leading_edge;
--	in_hoge  <= pre_gate;
--	in_hoge1  <= leading_edge;
--	in_hoge2  <= counter(0);
--	out_1    <= pre_gate and din_edge;

--        counter_max  <= reg_counter & const1;
        counter_max  <= reg_counter;

	process ( clk_trg, rst )
	  	begin
	  	  if( rst = '1' ) then
		      synchro  <= ( others => '0');
		  elsif(clk_trg'event and clk_trg ='1') then
		      synchro(0) <= in_1 ; 
		      synchro(1) <= synchro(0) ; 
		  end if;
	end process;

--        PS_EDG : EDG
--            port map (
--                     rst  => rst       ,
--                     clk  => clk_trg   ,
--                     dIn  => in_1,
--                     dOut => din_edge
--                     );
	
    process ( clk_trg, rst )
        begin
          if(rst ='1') then
            leading_edge <= '0';
          elsif(clk_trg'event and clk_trg ='1') then
            if(din_edge = "01") then
--            if(din_edge = '1' ) then
              leading_edge <= '1';
            else 
              leading_edge <= '0';
            end if;
          end if;
    end process;

	process ( leading_edge, rst )
--	process ( din_edge, rst )
	  	begin
	  	  if( rst = '1' ) then
		      counter  <= ( others => '0');
		  elsif(leading_edge'event and leading_edge = '1' ) then
--		  elsif(din_edge'event and din_edge = '1' ) then
    		      if(counter = counter_max ) then
                        counter  <= ( others => '0');
	               else
		        counter <= counter + '1';
                      end if;
		  end if;
	end process;

	process ( clk_trg, rst )
	  	begin
	  	  if( rst = '1' ) then
		      pre_gate <= '0';
		  elsif(clk_trg'event and clk_trg = '1' ) then
    	            if(counter = counter_max ) then
                         pre_gate <= '1';
                    else
                         pre_gate <= '0';
                    end if;
		  end if;
	end process;


end RTL;
