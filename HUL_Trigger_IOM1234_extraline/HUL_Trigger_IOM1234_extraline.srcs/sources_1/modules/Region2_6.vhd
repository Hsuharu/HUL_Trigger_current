library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

library UNISIM;
use UNISIM.VComponents.all;

entity Region2_6 is
  port(
    	        rst                      : in  std_logic;
    	        clk_trg                  : in  std_logic;
    	        clk_sys                  : in  std_logic;
    	        
	        -- DPWM ---------------------------------
    	        -- input signal --
    	        BH2_Pi                    : in  std_logic;
                Other1                    : in  std_logic;
                Other2                    : in  std_logic;
                Other3                    : in  std_logic;
                Other4                    : in  std_logic;
                Other5                    : in  std_logic;

    	        -- output signal --
    	        BH2_Pi_E03                : out std_logic;
                Other1_E03                : out std_logic;
                Other2_E03                : out std_logic;
                Other3_E03                : out std_logic;
                Other4_E03                : out std_logic;
                Other5_E03                : out std_logic;

		For_E03                   : out std_logic;
	
                -- Local bus --
                addrLocalBus        : in LocalAddressType;
                dataLocalBusIn      : in LocalBusInType;
                dataLocalBusOut     : out LocalBusOutType;
                reLocalBus          : in std_logic;
                weLocalBus          : in std_logic;
                readyLocalBus       : out std_logic
    );
end Region2_6;

architecture RTL of Region2_6 is
  --  attribute keep : string;

  -- other signal -------------------------------------------------------------
	constant NbitOut             : positive := 5;
	constant NbitOut_2           : positive := 2;
	constant NbitOut_6           : positive := 6;
	constant NbitOut_7           : positive := 7;
	constant NbitOut_8           : positive := 8;
	signal state_lbus          : BusProcessType;

  -- inner signal -------------------------------------------------------------
	signal in_BH2_Pi_E03           : std_logic;
	signal in_Other1_E03           : std_logic;
	signal in_Other2_E03           : std_logic;
	signal in_Other3_E03           : std_logic;
	signal in_Other4_E03           : std_logic;
	signal in_Other5_E03           : std_logic;

  -- For DPWM ------------------------------------------------------------
  -- For Delay --
	signal reg_delay_BH2_Pi        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_Other1        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_Other2        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_Other3        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_Other4        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_Other5        : std_logic_vector(NbitOut-1 downto 0);


  -- For PWM --
	signal reg_counter_BH2_Pi        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_Other1        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_Other2        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_Other3        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_Other4        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_Other5        : std_logic_vector(NbitOut-1 downto 0);

  -- For BPS --------------------------------------------------------------
        signal reg_ctrl_6  : std_logic_vector(NbitOut_6-1 downto 0);
        signal reg_coin_6  : std_logic_vector(NbitOut_6-1 downto 0);

  -- Modules  -------------------------------------------------------------
  component DPWM is
  port(
       rst             : in std_logic;
       clk_trg         : in std_logic;
       
       -- input signal --
       in1             : in  std_logic;
       reg_delay       : in  std_logic_vector( 4 downto 0);
       reg_counter     : in  std_logic_vector( 4 downto 0);
       -- output signal --
       out1            : out std_logic
      );
  end component;

  component BPS_6bits is
  	port(
  	     -- input signal --
             rst          : in std_logic;
             clk_trg      : in std_logic;
  	     inA          : in  std_logic;
  	     inB          : in  std_logic;
  	     inC          : in  std_logic;
  	     inD          : in  std_logic;
  	     inE          : in  std_logic;
  	     inF          : in  std_logic;
  	     reg_ctrl     : in  std_logic_vector(5 downto 0);
  	     reg_coin     : in  std_logic_vector(5 downto 0);
  	     -- output signal --
  	     out1  : out std_logic
  	    );
  end component;


begin
  -- =================================== body =======================================
  -- Signal -------------------------------------------------------------------------
	BH2_Pi_E03  <=  in_BH2_Pi_E03  ; 
	Other1_E03  <=  in_Other1_E03  ; 
	Other2_E03  <=  in_Other2_E03  ; 
	Other3_E03  <=  in_Other3_E03  ; 
	Other4_E03  <=  in_Other4_E03  ; 
	Other5_E03  <=  in_Other5_E03  ; 


  -- DPWM ---------------------------------------------------------------------------
  BH2_Pi_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>BH2_Pi        ,
	    reg_delay       =>reg_delay_BH2_Pi  ,
	    reg_counter     =>reg_counter_BH2_Pi,
	    -- output signal
	    out1            =>in_BH2_Pi_E03
	);

  Other1_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Other1        ,
	    reg_delay       =>reg_delay_Other1  ,
	    reg_counter     =>reg_counter_Other1,
	    -- output signal
	    out1            =>in_Other1_E03     
	);

  Other2_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Other2        ,
	    reg_delay       =>reg_delay_Other2  ,
	    reg_counter     =>reg_counter_Other2,
	    -- output signal
	    out1            =>in_Other2_E03     
	);

  Other3_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Other3        ,
	    reg_delay       =>reg_delay_Other3  ,
	    reg_counter     =>reg_counter_Other3,
	    -- output signal
	    out1            =>in_Other3_E03     
	);

  Other4_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Other4        ,
	    reg_delay       =>reg_delay_Other4  ,
	    reg_counter     =>reg_counter_Other4,
	    -- output signal
	    out1            =>in_Other4_E03     
	);

  Other5_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Other5        ,
	    reg_delay       =>reg_delay_Other5  ,
	    reg_counter     =>reg_counter_Other5,
	    -- output signal
	    out1            =>in_Other5_E03     
	);


  -- BPS ----------------------------------------------------------------------------
  K_Scat_BPS_Inst : BPS_6bits 
  port map(
    -- input signal --
    rst            => rst    ,
    clk_trg        => clk_trg,
    inA            => in_BH2_Pi_E03    ,
    inB            => in_Other1_E03    ,
    inC            => in_Other2_E03    ,
    inD            => in_Other3_E03    ,
    inE            => in_Other4_E03    ,
    inF            => in_Other5_E03    ,
    reg_ctrl       => reg_ctrl_6       ,
    reg_coin       => reg_coin_6       ,
    -- output signal     --
    out1           => For_E03
  );


  -- ================================================================================

  -- Bus process -------------------------------------------------------------
  u_BusProcess : process ( clk_sys, RST )
  begin
    if( RST = '1' ) then
      state_lbus          <= Init;
    elsif( clk_sys'event and clk_sys='1' ) then
      case state_lbus is
        when Init =>
          dataLocalBusOut          <= x"00";
          readyLocalBus            <= '0';
          reg_delay_BH2_Pi         <= (others => '1');
          reg_delay_Other1         <= (others => '1');
          reg_delay_Other2         <= (others => '1');
          reg_delay_Other3         <= (others => '1');
	  reg_delay_Other4         <= (others => '1');
	  reg_delay_Other5         <= (others => '1');

          reg_counter_BH2_Pi         <= (others => '1');
          reg_counter_Other1         <= (others => '1');
          reg_counter_Other2         <= (others => '1');
          reg_counter_Other3         <= (others => '1');
	  reg_counter_Other4         <= (others => '1');
	  reg_counter_Other5         <= (others => '1');
                                                                    
          reg_ctrl_6                            <= (others => '1');
          reg_coin_6                            <= (others => '1');
	  
          state_lbus               <= Idle;

	when Idle =>
		readyLocalBus	<= '0';
		if(weLocalBus = '1' or reLocalBus = '1') then
			state_lbus	<= Connect;
		end if;
	
	when Connect =>
		if(weLocalBus = '1') then
			state_lbus	<= Write;
		else
			state_lbus	<= Read;
		end if;
  
        when Write =>
          case addrLocalBus is
            when DLY_BH2_Pi_E03 =>  reg_delay_BH2_Pi   <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_Other1_E03 =>  reg_delay_Other1   <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_Other2_E03 =>  reg_delay_Other2   <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_Other3_E03 =>  reg_delay_Other3   <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_Other4_E03 =>  reg_delay_Other4   <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_Other5_E03 =>  reg_delay_Other5   <= dataLocalBusIn(NbitOut-1 downto 0);

            when PWM_BH2_Pi_E03 =>  reg_counter_BH2_Pi <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_Other1_E03 =>  reg_counter_Other1 <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_Other2_E03 =>  reg_counter_Other2 <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_Other3_E03 =>  reg_counter_Other3 <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_Other4_E03 =>  reg_counter_Other4 <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_Other5_E03 =>  reg_counter_Other5 <= dataLocalBusIn(NbitOut-1 downto 0);

            when BPS_ctrl_6=>  reg_ctrl_6 <= dataLocalBusIn(NbitOut_6-1 downto 0);
            when BPS_coin_6=>  reg_coin_6 <= dataLocalBusIn(NbitOut_6-1 downto 0);

            when others => null;
          end case;
          state_lbus <= Done;

        when Read =>
          case addrLocalBus is
            when DLY_BH2_Pi_E03 =>   dataLocalBusOut <= "000" & reg_delay_BH2_Pi   ;
            when DLY_Other1_E03 =>   dataLocalBusOut <= "000" & reg_delay_Other1   ;
            when DLY_Other2_E03 =>   dataLocalBusOut <= "000" & reg_delay_Other2   ;
            when DLY_Other3_E03 =>   dataLocalBusOut <= "000" & reg_delay_Other3   ;
            when DLY_Other4_E03 =>   dataLocalBusOut <= "000" & reg_delay_Other4   ;
            when DLY_Other5_E03 =>   dataLocalBusOut <= "000" & reg_delay_Other5   ;

            when PWM_BH2_Pi_E03 =>   dataLocalBusOut <= "000" & reg_counter_BH2_Pi;
            when PWM_Other1_E03 =>   dataLocalBusOut <= "000" & reg_counter_Other1;
            when PWM_Other2_E03 =>   dataLocalBusOut <= "000" & reg_counter_Other2;
            when PWM_Other3_E03 =>   dataLocalBusOut <= "000" & reg_counter_Other3;
            when PWM_Other4_E03 =>   dataLocalBusOut <= "000" & reg_counter_Other4;
            when PWM_Other5_E03 =>   dataLocalBusOut <= "000" & reg_counter_Other5;

            when BPS_ctrl_6  =>   dataLocalBusOut <= "00" & reg_ctrl_6 ;
            when BPS_coin_6  =>   dataLocalBusOut <= "00" & reg_coin_6 ;

			when others                 =>   dataLocalBusOut <= x"ff";
          end case;
          state_lbus <= Done;

        when Done =>
          readyLocalBus <= '1';
          if ( weLocalBus='0' and reLocalBus='0' ) then
            state_lbus <= Idle;
          end if;
          
        when others =>
          state_lbus    <= Init;
      end case;
    end if;
  end process u_BusProcess;


end RTL;
