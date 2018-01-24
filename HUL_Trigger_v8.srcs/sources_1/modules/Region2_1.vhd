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

entity Region2_1 is
  port(
    	        rst                      : in  std_logic;
    	        clk_trg                  : in  std_logic;
    	        clk_sys                  : in  std_logic;
    	        
	        -- DPWM ---------------------------------
    	        -- input signal --
    	        BH2_Pi                    : in  std_logic;
                SAC_or                    : in  std_logic;
                TOF_or                    : in  std_logic;
                Lucite_or                 : in  std_logic;
                TOF_High_Threshold        : in  std_logic;
--                Matrix_3D                 : in  std_logic;
                Other4                    : in  std_logic;
                Other5                    : in  std_logic;

    	        -- output signal --
    	        BH2_Pi_Beam_TOF              : out std_logic;
                SAC_or_Beam_TOF              : out std_logic;
                TOF_or_Beam_TOF              : out std_logic;
                LC_or_Beam_TOF               : out std_logic;
                TOF_HT_Beam_TOF              : out std_logic;
--                Matrix_3D_Beam_TOF           : out std_logic;
                Other4_Beam_TOF              : out std_logic;
                Other5_Beam_TOF              : out std_logic;

	        Beam_TOF                     : out std_logic;
	
                -- Local bus --
                addrLocalBus        : in LocalAddressType;
                dataLocalBusIn      : in LocalBusInType;
                dataLocalBusOut     : out LocalBusOutType;
                reLocalBus          : in std_logic;
                weLocalBus          : in std_logic;
                readyLocalBus       : out std_logic
    );
end Region2_1;

architecture RTL of Region2_1 is
  --  attribute keep : string;

  -- other signal -------------------------------------------------------------
	constant NbitOut           : positive := 5;
	constant NbitOut_2           : positive := 2;
	constant NbitOut_7           : positive := 7;
	constant NbitOut_8           : positive := 8;
	signal state_lbus          : BusProcessType;

  -- inner signal -------------------------------------------------------------
	signal in_BH2_Pi_Beam_TOF           : std_logic;
	signal in_SAC_or_Beam_TOF           : std_logic;
	signal in_TOF_or_Beam_TOF           : std_logic;
	signal in_LC_or_Beam_TOF            : std_logic;
	signal in_TOF_HT_Beam_TOF           : std_logic;
--	signal in_Matrix_3D_Beam_TOF        : std_logic;
	signal in_Other4_Beam_TOF           : std_logic;
	signal in_Other5_Beam_TOF           : std_logic;

  -- For DPWM ------------------------------------------------------------
  -- For Delay --
	signal reg_delay_BH2_Pi           : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_SAC_or           : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_TOF_or           : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_LC_or            : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_TOF_HT           : std_logic_vector(NbitOut-1 downto 0);
--	signal reg_delay_Matrix_3D        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_Other4           : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_Other5           : std_logic_vector(NbitOut-1 downto 0);


  -- For PWM --
	signal reg_counter_BH2_Pi           : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_SAC_or           : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_TOF_or           : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_LC_or            : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_TOF_HT           : std_logic_vector(NbitOut-1 downto 0);
--	signal reg_counter_Matrix_3D        : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_Other4           : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_Other5           : std_logic_vector(NbitOut-1 downto 0);

  -- For BPS --------------------------------------------------------------
        signal reg_ctrl_7  : std_logic_vector(NbitOut_7-1 downto 0);
        signal reg_coin_7  : std_logic_vector(NbitOut_7-1 downto 0);

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

  component BPS_7bits is
  	port(
  	     -- input signal --
             rst             : in std_logic;
             clk_trg         : in std_logic;
  	     inA          : in  std_logic;
  	     inB          : in  std_logic;
  	     inC          : in  std_logic;
  	     inD          : in  std_logic;
  	     inE          : in  std_logic;
  	     inF          : in  std_logic;
  	     inG          : in  std_logic;
--  	     inH          : in  std_logic;
  	     reg_ctrl     : in  std_logic_vector(6 downto 0);
  	     reg_coin     : in  std_logic_vector(6 downto 0);
  	     -- output signal --
  	     out1  : out std_logic
  	    );
  end component;


begin
  -- =================================== body =======================================
  -- Signal -------------------------------------------------------------------------
	BH2_Pi_Beam_TOF     <=  in_BH2_Pi_Beam_TOF     ; 
	SAC_or_Beam_TOF     <=  in_SAC_or_Beam_TOF     ; 
	TOF_or_Beam_TOF     <=  in_TOF_or_Beam_TOF     ; 
	LC_or_Beam_TOF      <=  in_LC_or_Beam_TOF      ; 
	TOF_HT_Beam_TOF     <=  in_TOF_HT_Beam_TOF     ; 
--	Matrix_3D_Beam_TOF  <=  in_Matrix_3D_Beam_TOF  ; 
	Other4_Beam_TOF     <=  in_Other4_Beam_TOF     ; 
	Other5_Beam_TOF     <=  in_Other5_Beam_TOF     ; 


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
	    out1            =>in_BH2_Pi_Beam_TOF
	);

  SAC_or_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>SAC_or        ,
	    reg_delay       =>reg_delay_SAC_or  ,
	    reg_counter     =>reg_counter_SAC_or,
	    -- output signal
	    out1            =>in_SAC_or_Beam_TOF
	);

  TOF_or_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>TOF_or        ,
	    reg_delay       =>reg_delay_TOF_or  ,
	    reg_counter     =>reg_counter_TOF_or,
	    -- output signal
	    out1            =>in_TOF_or_Beam_TOF
	);

  Lucite_or_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Lucite_or        ,
	    reg_delay       =>reg_delay_LC_or  ,
	    reg_counter     =>reg_counter_LC_or,
	    -- output signal
	    out1            =>in_LC_or_Beam_TOF
	);

  TOF_High_Threshold_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>TOF_High_Threshold        ,
	    reg_delay       =>reg_delay_TOF_HT  ,
	    reg_counter     =>reg_counter_TOF_HT,
	    -- output signal
	    out1            =>in_TOF_HT_Beam_TOF
	);

--  Matrix_3D_Inst : DPWM
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>Matrix_3D        ,
--	    reg_delay       =>reg_delay_Matrix_3D  ,
--	    reg_counter     =>reg_counter_Matrix_3D,
--	    -- output signal
--	    out1            =>in_Matrix_3D_Beam_TOF
--	);

  Other4_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Other4        ,
	    reg_delay       =>reg_delay_Other4  ,
	    reg_counter     =>reg_counter_Other4,
	    -- output signal
	    out1            =>in_Other4_Beam_TOF
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
	    out1            =>in_Other5_Beam_TOF
	);


  -- BPS ----------------------------------------------------------------------------
  Beam_TOF_BPS_Inst : BPS_7bits 
  port map(
    -- input signal --
    rst            => rst    ,
    clk_trg        => clk_trg,
    inA            => in_BH2_Pi_Beam_TOF         ,
    inB            => in_SAC_or_Beam_TOF         ,
    inC            => in_TOF_or_Beam_TOF         ,
    inD            => in_LC_or_Beam_TOF          ,
    inE            => in_TOF_HT_Beam_TOF         ,
--    inF            => in_Matrix_3D_Beam_TOF      ,
    inF            => in_Other4_Beam_TOF         ,
    inG            => in_Other5_Beam_TOF         ,
    reg_ctrl       => reg_ctrl_7       ,
    reg_coin       => reg_coin_7       ,
    -- output signal     --
    out1           => Beam_TOF
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
          reg_delay_BH2_Pi            <= (others => '1');
          reg_delay_SAC_or            <= (others => '1');
          reg_delay_TOF_or            <= (others => '1');
          reg_delay_LC_or             <= (others => '1');
	  reg_delay_TOF_HT            <= (others => '1');
--	  reg_delay_Matrix_3D         <= (others => '1');
	  reg_delay_Other4            <= (others => '1'); 
	  reg_delay_Other5            <= (others => '1');

          reg_counter_BH2_Pi            <= (others => '1');
          reg_counter_SAC_or            <= (others => '1');
          reg_counter_TOF_or            <= (others => '1');
          reg_counter_LC_or             <= (others => '1');
	  reg_counter_TOF_HT            <= (others => '1');
--	  reg_counter_Matrix_3D         <= (others => '1');
	  reg_counter_Other4            <= (others => '1');
	  reg_counter_Other5            <= (others => '1');
                                                                    
          reg_ctrl_7                            <= (others => '1');
          reg_coin_7                            <= (others => '1');
	  
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
            when DLY_BH2_Pi    =>  reg_delay_BH2_Pi      <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_SAC_or    =>  reg_delay_SAC_or      <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_TOF_or    =>  reg_delay_TOF_or      <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_LC_or     =>  reg_delay_LC_or       <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_TOF_HT    =>  reg_delay_TOF_HT      <= dataLocalBusIn(NbitOut-1 downto 0);
--            when DLY_Matrix_3D =>  reg_delay_Matrix_3D   <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_Other4    =>  reg_delay_Other4      <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_Other5    =>  reg_delay_Other5      <= dataLocalBusIn(NbitOut-1 downto 0);

            when PWM_BH2_Pi    =>  reg_counter_BH2_Pi    <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_SAC_or    =>  reg_counter_SAC_or    <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_TOF_or    =>  reg_counter_TOF_or    <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_LC_or     =>  reg_counter_LC_or     <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_TOF_HT    =>  reg_counter_TOF_HT    <= dataLocalBusIn(NbitOut-1 downto 0);
--            when PWM_Matrix_3D =>  reg_counter_Matrix_3D <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_Other4    =>  reg_counter_Other4    <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_Other5    =>  reg_counter_Other5    <= dataLocalBusIn(NbitOut-1 downto 0);

            when BPS_ctrl_7=>  reg_ctrl_7 <= dataLocalBusIn(NbitOut_7-1 downto 0);
            when BPS_coin_7=>  reg_coin_7 <= dataLocalBusIn(NbitOut_7-1 downto 0);

            when others => null;
          end case;
          state_lbus <= Done;

        when Read =>
          case addrLocalBus is
            when DLY_BH2_Pi    =>   dataLocalBusOut <= "000" & reg_delay_BH2_Pi      ;
            when DLY_SAC_or    =>   dataLocalBusOut <= "000" & reg_delay_SAC_or      ;
            when DLY_TOF_or    =>   dataLocalBusOut <= "000" & reg_delay_TOF_or      ;
            when DLY_LC_or     =>   dataLocalBusOut <= "000" & reg_delay_LC_or       ;
            when DLY_TOF_HT    =>   dataLocalBusOut <= "000" & reg_delay_TOF_HT      ;
--            when DLY_Matrix_3D =>   dataLocalBusOut <= "000" & reg_delay_Matrix_3D   ;
            when DLY_Other4    =>   dataLocalBusOut <= "000" & reg_delay_Other4      ;
            when DLY_Other5    =>   dataLocalBusOut <= "000" & reg_delay_Other5      ;

            when PWM_BH2_Pi    =>   dataLocalBusOut <= "000" & reg_counter_BH2_Pi   ;
            when PWM_SAC_or    =>   dataLocalBusOut <= "000" & reg_counter_SAC_or   ;
            when PWM_TOF_or    =>   dataLocalBusOut <= "000" & reg_counter_TOF_or   ;
            when PWM_LC_or     =>   dataLocalBusOut <= "000" & reg_counter_LC_or    ;
            when PWM_TOF_HT    =>   dataLocalBusOut <= "000" & reg_counter_TOF_HT   ;
--            when PWM_Matrix_3D =>   dataLocalBusOut <= "000" & reg_counter_Matrix_3D;
            when PWM_Other4    =>   dataLocalBusOut <= "000" & reg_counter_Other4   ;
            when PWM_Other5    =>   dataLocalBusOut <= "000" & reg_counter_Other5   ;

            when BPS_ctrl_7  =>   dataLocalBusOut <= "0" & reg_ctrl_7 ;
            when BPS_coin_7  =>   dataLocalBusOut <= "0" & reg_coin_7 ;

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
