library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity Region3 is
    	port(
            	rst             : in std_logic;
            	clk_trg         : in std_logic;
            	clk_sys         : in std_logic;
            	
            	-- input signal --
            	BH2_Pi          : in  std_logic;
            	Beam_TOF        : in  std_logic;
            	Beam_Pi         : in  std_logic;
            	Beam_P          : in  std_logic;
            	Coin1           : in  std_logic;
            	Coin2           : in  std_logic;
		For_E03         : in  std_logic;

		K_Scat_Pre      : in  std_logic;
            	
            	-- output signal --
            	BH2_Pi_PS       : out std_logic;
            	Beam_TOF_PS     : out std_logic;
            	Beam_Pi_PS      : out std_logic;
            	Beam_P_PS       : out std_logic;
            	Coin1_PS        : out std_logic;
            	Coin2_PS        : out std_logic;
            	Extra_line      : out std_logic;
		For_E03_PS      : out std_logic;
	
	        PS_OR_DLY       : out std_logic;
	        K_Scat_Else_OR  : out std_logic;
	        Else_OR         : out std_logic;
	        Else_OR_DLY     : out std_logic;

            	-- Local bus --
            	addrLocalBus    : in LocalAddressType;
            	dataLocalBusIn  : in LocalBusInType;
            	dataLocalBusOut : out LocalBusOutType;
            	reLocalBus      : in std_logic;
            	weLocalBus      : in std_logic;
            	readyLocalBus   : out std_logic
            	);
end Region3;

architecture RTL of Region3 is
--  attribute keep : string;

  -- other signal -------------------------------------------------------------
  signal state_lbus    	: BusProcessType;
--  constant NbitOut      : positive := 4;
                                
  -- inner signal -------------------------------------------------------------
  signal BH2_Pi_PS_Pre            : std_logic;
  signal Beam_TOF_PS_Pre          : std_logic;
  signal Beam_Pi_PS_Pre           : std_logic;
  signal Beam_P_PS_Pre            : std_logic;
  signal Coin1_PS_Pre             : std_logic;
  signal Coin2_PS_Pre             : std_logic;
  signal For_E03_PS_Pre           : std_logic;
--  signal BH2_Pi_PWM            : std_logic;
--  signal Beam_TOF_PWM          : std_logic;
--  signal Beam_Pi_PWM           : std_logic;
--  signal Beam_P_PWM            : std_logic;
--  signal Coin1_PWM             : std_logic;
--  signal Coin2_PWM             : std_logic;
--  signal For_E03_PWM           : std_logic;
  signal in_BH2_Pi_PS_pre      : std_logic;
  signal in_BH2_Pi_PS          : std_logic;
  signal in_Beam_TOF_PS        : std_logic;
  signal in_Beam_Pi_PS         : std_logic;
  signal in_Beam_P_PS          : std_logic;
  signal in_Coin1_PS           : std_logic;
  signal in_Coin2_PS           : std_logic;
  signal in_For_E03_PS         : std_logic;
  signal in_PS_OR_DLY          : std_logic;
  signal in_Else_OR_DLY        : std_logic;
  signal in_K_Scat_Else_OR     : std_logic;
  signal in_Else_OR            : std_logic;
  signal PS_OR_Pre             : std_logic;
  signal Else_OR_Pre           : std_logic;
  signal PS_or_vector          : std_logic_vector( 6 downto 0);
            
  -- For PS -------------------------------------------------------------------
  signal reg_counter_BH2_Pi             : std_logic_vector(23 downto 0);
  signal reg_counter_Beam_TOF           : std_logic_vector(23 downto 0);
  signal reg_counter_Beam_Pi            : std_logic_vector(23 downto 0);
  signal reg_counter_Beam_P             : std_logic_vector(23 downto 0);
  signal reg_counter_Coin1              : std_logic_vector(23 downto 0);
  signal reg_counter_Coin2              : std_logic_vector(23 downto 0);
  signal reg_counter_For_E03            : std_logic_vector(23 downto 0);

  -- For PWM -----------------------------------------------------------------
--  signal reg_counter_BH2_Pi_PWM         : std_logic_vector(3 downto 0);
--  signal reg_counter_Beam_TOF_PWM       : std_logic_vector(3 downto 0);
--  signal reg_counter_Beam_Pi_PWM        : std_logic_vector(3 downto 0);
--  signal reg_counter_Beam_P_PWM         : std_logic_vector(3 downto 0);
--  signal reg_counter_Coin1_PWM          : std_logic_vector(3 downto 0);
--  signal reg_counter_Coin2_PWM          : std_logic_vector(3 downto 0);
--  signal reg_counter_For_E03_PWM        : std_logic_vector(3 downto 0);

  -- For DLY ------------------------------------------------------------------
  signal reg_DLY_PS_or                  : std_logic_vector(4 downto 0);
  signal reg_DLY_Else_or                  : std_logic_vector(4 downto 0);

  -- For DPWM -----------------------------------------------------------------
    -- For Delay --
  signal reg_delay_Else_OR_Pre          : std_logic_vector(4 downto 0);
  signal reg_delay_K_Scat_Pre           : std_logic_vector(4 downto 0);
    -- For PWM --
  signal reg_counter_Else_OR_Pre        : std_logic_vector(4 downto 0);
  signal reg_counter_K_Scat_Pre         : std_logic_vector(4 downto 0);

  -- For Selector -------------------------------------------------------------
  signal reg_ctrl                       : std_logic_vector(6 downto 0);
  signal reg_RST                        : std_logic                   ;
  signal rst_PS                         : std_logic                   ;
  

  -- module -------------------------------------------------------------------------
  -- PS --    
     component PS is
     	port(
               rst         : in std_logic;
               clk_trg     : in std_logic;
               
               in1         : in  std_logic;
               out1        : out std_logic;
               
               reg_counter :in std_logic_vector(23 downto 0)
               );
     end component;
   
  -- PWC --    
     component PWC is
       port(
         rst                 : in std_logic;
         clk_trg             : in std_logic;
         
         -- input signal --
           in1   : in  std_logic;
--           reg_counter  : in  std_logic_vector(3 downto 0);
         
         -- output signal --
           out1  : out std_logic
         );
     end component;

  -- PWCbig --    
     component PWCbig is
       port(
         rst                 : in std_logic;
         clk_trg             : in std_logic;
         
         -- input signal --
           in1   : in  std_logic;
--           reg_counter  : in  std_logic_vector(3 downto 0);
         
         -- output signal --
           out1  : out std_logic
         );
     end component;

  -- DPWM --    
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
  -- DLY --     
     component DLY is
       port(
         rst                 : in std_logic;
         clk_trg             : in std_logic;
         
         -- input signal --
         delayin             : in  std_logic;
         reg_delay           : in  std_logic_vector(4 downto 0);
         -- output signal --
         delayout            : out std_logic
     
         );
     end component;
   


begin
  -- =================================== body =======================================
  -- Signal -------------------------------------------------------------------------

        BH2_Pi_PS        <=  PS_or_vector(6)              ; 
--  Beam_dly_Inst : DPWM
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>PS_or_vector(6)        ,
--	    reg_delay       => "00001"  ,
--	    reg_counter     => "00110",
--	    -- output signal
--	    out1            =>BH2_Pi_PS 
--	);
	Beam_TOF_PS      <=  PS_or_vector(5)              ; 
	Beam_Pi_PS       <=  PS_or_vector(4)              ; 
	Beam_P_PS        <=  PS_or_vector(3)              ; 
	Coin1_PS         <=  PS_or_vector(2)              ; 
	Coin2_PS         <=  PS_or_vector(1)              ; 
	For_E03_PS       <=  PS_or_vector(0)              ; 
	PS_OR_DLY        <=  in_PS_OR_DLY                 ; 
	Else_OR_DLY      <=  in_Else_OR_DLY                 ; 
	K_Scat_Else_OR   <=  in_K_Scat_Else_OR            ; 
	Else_OR          <=  in_Else_OR                   ; 
        
--	PS_or_vector(6)  <= BH2_Pi_PS_Pre    when( reg_ctrl(6) = '1' ) else '0'; 
--        PS_or_vector(5)  <= Beam_TOF_PS_Pre  when( reg_ctrl(5) = '1' ) else '0'; 
--        PS_or_vector(4)  <= Beam_Pi_PS_Pre   when( reg_ctrl(4) = '1' ) else '0'; 
--        PS_or_vector(3)  <= Beam_P_PS_Pre    when( reg_ctrl(3) = '1' ) else '0'; 
--        PS_or_vector(2)  <= Coin1_PS_Pre     when( reg_ctrl(2) = '1' ) else '0'; 
--        PS_or_vector(1)  <= Coin2_PS_Pre     when( reg_ctrl(1) = '1' ) else '0'; 
--        PS_or_vector(0)  <= For_E03_PS_Pre   when( reg_ctrl(0) = '1' ) else '0'; 
	
  Beam_dly_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>in_BH2_Pi_PS_pre        ,
	    reg_delay       => "00010"  ,
	    reg_counter     => "00110",
	    -- output signal
	    out1            =>PS_or_vector(6) 
	);
--	PS_or_vector(6)  <= in_BH2_Pi_PS    when( reg_ctrl(6) = '1' ) else '0'; 
	in_BH2_Pi_PS_pre <= in_BH2_Pi_PS    when( reg_ctrl(6) = '1' ) else '0'; 
        PS_or_vector(5)  <= in_Beam_TOF_PS  when( reg_ctrl(5) = '1' ) else '0'; 
        PS_or_vector(4)  <= in_Beam_Pi_PS   when( reg_ctrl(4) = '1' ) else '0'; 
        PS_or_vector(3)  <= in_Beam_P_PS    when( reg_ctrl(3) = '1' ) else '0'; 
        PS_or_vector(2)  <= in_Coin1_PS     when( reg_ctrl(2) = '1' ) else '0'; 
--        PS_or_vector(1)  <= in_Coin2_PS     when( reg_ctrl(1) = '1' ) else '0'; 
        PS_or_vector(1)  <= '0';
        Extra_line       <= in_Coin2_PS     when( reg_ctrl(1) = '1' ) else '0'; 
        PS_or_vector(0)  <= in_For_E03_PS   when( reg_ctrl(0) = '1' ) else '0'; 
	
--	PS_OR_Pre        <= or_reduce(PS_or_vector);
	PS_OR_Pre        <= '0' when(PS_or_vector ="0000000") else '1';

        Else_OR_Pre      <= in_PS_or_DLY and (NOT in_K_Scat_Else_OR);

        rst_PS <= rst or reg_RST  ;

  -- PS -----------------------------------------------------------------------------
  BH2_Pi_PS_Inst : PS 
  port map(
    rst            => rst_PS         ,
    clk_trg        => clk_trg        ,

    in1            => BH2_Pi         ,
    out1           => BH2_Pi_PS_Pre      , 

    reg_counter    => reg_counter_BH2_Pi
  );
	
  Beam_TOF_PS_Inst : PS 
  port map(
    rst            => rst_PS         ,
    clk_trg        => clk_trg        ,

    in1            => Beam_TOF         ,
    out1           => Beam_TOF_PS_Pre   , 

    reg_counter    => reg_counter_Beam_TOF
  );
	
  Beam_Pi_PS_Inst : PS 
  port map(
    rst            => rst_PS         ,
    clk_trg        => clk_trg        ,

    in1            => Beam_Pi         ,
    out1           => Beam_Pi_PS_Pre      , 

    reg_counter    => reg_counter_Beam_Pi
  );
	
  Beam_P_PS_Inst : PS 
  port map(
    rst            => rst_PS         ,
    clk_trg        => clk_trg        ,

    in1            => Beam_P         ,
    out1           => Beam_P_PS_Pre      , 

    reg_counter    => reg_counter_Beam_P
  );
	
  Coin1_PS_Inst : PS 
  port map(
    rst            => rst_PS         ,
    clk_trg        => clk_trg        ,

    in1            => Coin1         ,
    out1           => Coin1_PS_Pre      , 

    reg_counter    => reg_counter_Coin1
  );
	
  Coin2_PS_Inst : PS 
  port map(
    rst            => rst_PS         ,
    clk_trg        => clk_trg        ,

    in1            => Coin2         ,
    out1           => Coin2_PS_Pre      , 

    reg_counter    => reg_counter_Coin2
  );
	
  For_E03_PS_Inst : PS 
  port map(
    rst            => rst_PS         ,
    clk_trg        => clk_trg        ,

    in1            => For_E03         ,
    out1           => For_E03_PS_Pre      , 

    reg_counter    => reg_counter_For_E03
  );
	
--  -- PWM ---------------------------------------------------------------------	
--  BH2_Pi_PS_PWM_Inst : PWM
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>BH2_Pi_PS_Pre,
--	    reg_counter     =>reg_counter_BH2_Pi_PWM,
--	    -- output signal
--	    out1            =>in_BH2_Pi_PS
--	);
--
--  Beam_TOF_PS_PWM_Inst : PWM
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>Beam_TOF_PS_Pre,
--	    reg_counter     =>reg_counter_Beam_TOF_PWM,
--	    -- output signal
--	    out1            =>in_Beam_TOF_PS
--	);
--
--  Beam_Pi_PS_PWM_Inst : PWM
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>Beam_Pi_PS_Pre,
--	    reg_counter     =>reg_counter_Beam_Pi_PWM,
--	    -- output signal
--	    out1            =>in_Beam_Pi_PS
--	);
--
--  Beam_P_PS_PWM_Inst : PWM
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>Beam_P_PS_Pre,
--	    reg_counter     =>reg_counter_Beam_P_PWM,
--	    -- output signal
--	    out1            =>in_Beam_P_PS
--	);
--
--  Coin1_PS_PWM_Inst : PWM
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>Coin1_PS_Pre,
--	    reg_counter     =>reg_counter_Coin1_PWM,
--	    -- output signal
--	    out1            =>in_Coin1_PS
--	);
--
--  Coin2_PS_PWM_Inst : PWM
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>Coin2_PS_Pre,
--	    reg_counter     =>reg_counter_Coin2_PWM,
--	    -- output signal
--	    out1            =>in_Coin2_PS
--	);
--
--  For_E03_PS_PWM_Inst : PWM
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>For_E03_PS_Pre,
--	    reg_counter     =>reg_counter_BH2_Pi_PWC,
--	    reg_counter     =>reg_counter_For_E03_PWM,
--	    -- output signal
--	    out1            =>in_For_E03_PS
--	);
	
  -- PWC ---------------------------------------------------------------------	
  BH2_Pi_PS_PWC_Inst : PWC
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>BH2_Pi_PS_Pre,
	    -- output signal
	    out1            =>in_BH2_Pi_PS
	);

  Beam_TOF_PS_PWC_Inst : PWC
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Beam_TOF_PS_Pre,
	    -- output signal
	    out1            =>in_Beam_TOF_PS
	);

  Beam_Pi_PS_PWC_Inst : PWC
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Beam_Pi_PS_Pre,
	    -- output signal
	    out1            =>in_Beam_Pi_PS
	);

  Beam_P_PS_PWC_Inst : PWC
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Beam_P_PS_Pre,
	    -- output signal
	    out1            =>in_Beam_P_PS
	);

  Coin1_PS_PWC_Inst : PWC
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Coin1_PS_Pre,
	    -- output signal
	    out1            =>in_Coin1_PS
	);

  Coin2_PS_PWC_Inst : PWCbig
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Coin2_PS_Pre,
	    -- output signal
	    out1            =>in_Coin2_PS
	);

  For_E03_PS_PWC_Inst : PWC
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>For_E03_PS_Pre,
	    -- output signal
	    out1            =>in_For_E03_PS
	);

  -- DLY ---------------------------------------------------------------------	
  PS_OR_Else_OR_Inst : DLY 
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
      
            -- input signal --
            delayin            => PS_OR_Pre, 
            reg_delay            => reg_DLY_PS_OR ,
            -- output signal -- 
            delayout           => in_PS_OR_DLY  
  
            );

  Else_OR_Delay_Inst : DLY 
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
      
            -- input signal --
	    delayin            => in_Else_OR, 
            reg_delay            => reg_DLY_Else_OR ,
            -- output signal -- 
            delayout           => in_Else_OR_DLY  
  
            );

  -- DPWM --------------------------------------------------------------------	
  K_Scat_Pre_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>K_Scat_Pre        ,
	    reg_delay       =>reg_delay_K_Scat_Pre  ,
	    reg_counter     =>reg_counter_K_Scat_Pre,
	    -- output signal
	    out1            =>in_K_Scat_Else_OR 
	);

   Else_OR_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Else_OR_Pre        ,
	    reg_delay       =>reg_delay_Else_OR_Pre  ,
	    reg_counter     =>reg_counter_Else_OR_Pre,
	    -- output signal
	    out1            =>in_Else_OR 
	);

  -- Bus process -------------------------------------------------------------
  u_BusProcess : process ( clk_sys, RST )
  begin
    if( RST = '1' ) then
      state_lbus          <= Init;
    elsif( clk_sys'event and clk_sys='1' ) then
      case state_lbus is
        when Init =>
          dataLocalBusOut     <= x"00";
          readyLocalBus       <= '0';

          reg_counter_BH2_Pi            <= (others => '1');
          reg_counter_Beam_TOF          <= (others => '1');
          reg_counter_Beam_Pi           <= (others => '1');
          reg_counter_Beam_P            <= (others => '1');
          reg_counter_Coin1             <= (others => '1');
          reg_counter_Coin2             <= (others => '1');
          reg_counter_For_E03           <= (others => '1');

--          reg_counter_BH2_Pi_PWM            <= (others => '1');
--          reg_counter_Beam_TOF_PWM          <= (others => '1');
--          reg_counter_Beam_Pi_PWM           <= (others => '1');
--          reg_counter_Beam_P_PWM            <= (others => '1');
--          reg_counter_Coin1_PWM             <= (others => '1');
--          reg_counter_Coin2_PWM             <= (others => '1');
--          reg_counter_For_E03_PWM           <= (others => '1');

          reg_DLY_PS_OR                     <= (others => '1');
          reg_DLY_Else_OR                     <= (others => '1');
	  
          reg_delay_Else_OR_Pre             <= (others => '1');
          reg_delay_K_Scat_Pre              <= (others => '1');
          reg_counter_Else_OR_Pre             <= (others => '1');
          reg_counter_K_Scat_Pre              <= (others => '1');

          reg_ctrl                            <= (others => '1');
          reg_RST                             <= '0';

          state_lbus          <= Idle;

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
            when PS_BH2_Pi   =>  reg_counter_BH2_Pi    <= dataLocalBusIn(23 downto 0);
            when PS_Beam_TOF =>  reg_counter_Beam_TOF  <= dataLocalBusIn(23 downto 0);
            when PS_Beam_Pi  =>  reg_counter_Beam_Pi   <= dataLocalBusIn(23 downto 0);
            when PS_Beam_P   =>  reg_counter_Beam_P    <= dataLocalBusIn(23 downto 0);
            when PS_Coin1    =>  reg_counter_Coin1     <= dataLocalBusIn(23 downto 0);
            when PS_Coin2    =>  reg_counter_Coin2     <= dataLocalBusIn(23 downto 0);
            when PS_For_E03  =>  reg_counter_For_E03   <= dataLocalBusIn(23 downto 0);

--            when PWM_BH2_Pi   =>  reg_counter_BH2_Pi_PWM    <= dataLocalBusIn( 3 downto 0);
--            when PWM_Beam_TOF =>  reg_counter_Beam_TOF_PWM  <= dataLocalBusIn( 3 downto 0);
--            when PWM_Beam_Pi  =>  reg_counter_Beam_Pi_PWM   <= dataLocalBusIn( 3 downto 0);
--            when PWM_Beam_P   =>  reg_counter_Beam_P_PWM    <= dataLocalBusIn( 3 downto 0);
--            when PWM_Coin1    =>  reg_counter_Coin1_PWM     <= dataLocalBusIn( 3 downto 0);
--            when PWM_Coin2    =>  reg_counter_Coin2_PWM     <= dataLocalBusIn( 3 downto 0);
--            when PWM_For_E03  =>  reg_counter_For_E03_PWM   <= dataLocalBusIn( 3 downto 0);

            when DLY_PS_OR    =>  reg_DLY_PS_OR             <= dataLocalBusIn( 4  downto 0);
            when DLY_Else_OR    =>  reg_DLY_Else_OR           <= dataLocalBusIn( 4  downto 0);

            when DPWM_delay_Else_OR   => reg_delay_Else_OR_Pre   <= dataLocalBusIn( 4 downto 0);
            when DPWM_delay_K_Scat    => reg_delay_K_Scat_Pre    <= dataLocalBusIn( 4 downto 0);
            when DPWM_counter_Else_OR => reg_counter_Else_OR_Pre <= dataLocalBusIn( 4 downto 0);
            when DPWM_counter_K_Scat  => reg_counter_K_Scat_Pre  <= dataLocalBusIn( 4 downto 0);

            when SEL_ctrl             => reg_ctrl                <= dataLocalBusIn( 6 downto 0);
            when RST_PSCNT            => reg_RST                 <= dataLocalBusIn(0);

            when others => null;
          end case;
          state_lbus <= Done;

        when Read =>
          case addrLocalBus( 11 downto 4) is
		  when PS_BH2_Pi( 11 downto 4) => 
			  if(    addrLocalBus( 1 downto 0 ) = "00"  ) then
				  dataLocalBusOut <= reg_counter_BH2_Pi(  7 downto 0 );
			  elsif( addrLocalBus( 1 downto 0 ) = "01"  ) then
				  dataLocalBusOut <= reg_counter_BH2_Pi( 15 downto 8 );
		          else
				  dataLocalBusOut <= reg_counter_BH2_Pi( 23 downto 16);
		          end if;

		  when PS_Beam_TOF( 11 downto 4) => 
			  if(    addrLocalBus( 1 downto 0 ) = "00"  ) then
				  dataLocalBusOut <= reg_counter_Beam_TOF(  7 downto 0 );
			  elsif( addrLocalBus( 1 downto 0 ) = "01"  ) then
				  dataLocalBusOut <= reg_counter_Beam_TOF( 15 downto 8 );
		          else
				  dataLocalBusOut <= reg_counter_Beam_TOF( 23 downto 16);
		          end if;


		  when PS_Beam_Pi( 11 downto 4) => 
			  if(    addrLocalBus( 1 downto 0 ) = "00"  ) then
				  dataLocalBusOut <= reg_counter_Beam_Pi(  7 downto 0 );
			  elsif( addrLocalBus( 1 downto 0 ) = "01"  ) then
				  dataLocalBusOut <= reg_counter_Beam_Pi( 15 downto 8 );
		          else
				  dataLocalBusOut <= reg_counter_Beam_Pi( 23 downto 16);
		          end if;

		  when PS_Beam_P( 11 downto 4) => 
			  if(    addrLocalBus( 1 downto 0 ) = "00"  ) then
				  dataLocalBusOut <= reg_counter_Beam_P(  7 downto 0 );
			  elsif( addrLocalBus( 1 downto 0 ) = "01"  ) then
				  dataLocalBusOut <= reg_counter_Beam_P( 15 downto 8 );
		          else
				  dataLocalBusOut <= reg_counter_Beam_P( 23 downto 16);
		          end if;

		  when PS_Coin1( 11 downto 4) => 
			  if(    addrLocalBus( 1 downto 0 ) = "00"  ) then
				  dataLocalBusOut <= reg_counter_Coin1(  7 downto 0 );
			  elsif( addrLocalBus( 1 downto 0 ) = "01"  ) then
				  dataLocalBusOut <= reg_counter_Coin1( 15 downto 8 );
		          else
				  dataLocalBusOut <= reg_counter_Coin1( 23 downto 16);
		          end if;

		  when PS_Coin2( 11 downto 4) => 
			  if(    addrLocalBus( 1 downto 0 ) = "00"  ) then
				  dataLocalBusOut <= reg_counter_Coin2(  7 downto 0 );
			  elsif( addrLocalBus( 1 downto 0 ) = "01"  ) then
				  dataLocalBusOut <= reg_counter_Coin2( 15 downto 8 );
		          else
				  dataLocalBusOut <= reg_counter_Coin2( 23 downto 16);
		          end if;

		  when PS_For_E03( 11 downto 4) => 
			  if(    addrLocalBus( 1 downto 0 ) = "00"  ) then
				  dataLocalBusOut <= reg_counter_For_E03(  7 downto 0 );
			  elsif( addrLocalBus( 1 downto 0 ) = "01"  ) then
				  dataLocalBusOut <= reg_counter_For_E03( 15 downto 8 );
		          else
				  dataLocalBusOut <= reg_counter_For_E03( 23 downto 16);
		          end if;



--            when PS_BH2_Pi   =>   dataLocalBusOut <= "0000" & reg_counter_BH2_Pi  ;
--            when PS_Beam_TOF =>   dataLocalBusOut <= "0000" & reg_counter_Beam_TOF;
--            when PS_Beam_Pi  =>   dataLocalBusOut <= "0000" & reg_counter_Beam_Pi ;
--            when PS_Beam_P   =>   dataLocalBusOut <= "0000" & reg_counter_Beam_P  ;
--            when PS_Coin1    =>   dataLocalBusOut <= "0000" & reg_counter_Coin1   ;
--            when PS_Coin2    =>   dataLocalBusOut <= "0000" & reg_counter_Coin2   ;
--            when PS_For_E03  =>   dataLocalBusOut <= "0000" & reg_counter_For_E03 ;

--            when PWM_BH2_Pi( 11 downto 4)   =>   dataLocalBusOut <= "0000" & reg_counter_BH2_Pi_PWM  ;
--            when PWM_Beam_TOF( 11 downto 4) =>   dataLocalBusOut <= "0000" & reg_counter_Beam_TOF_PWM;
--            when PWM_Beam_Pi( 11 downto 4)  =>   dataLocalBusOut <= "0000" & reg_counter_Beam_Pi_PWM ;
--            when PWM_Beam_P( 11 downto 4)   =>   dataLocalBusOut <= "0000" & reg_counter_Beam_P_PWM  ;
--            when PWM_Coin1( 11 downto 4)    =>   dataLocalBusOut <= "0000" & reg_counter_Coin1_PWM   ;
--            when PWM_Coin2( 11 downto 4)    =>   dataLocalBusOut <= "0000" & reg_counter_Coin2_PWM   ;
--            when PWM_For_E03( 11 downto 4)  =>   dataLocalBusOut <= "0000" & reg_counter_For_E03_PWM ;

            when DLY_PS_OR( 11 downto 4)    =>   dataLocalBusOut <= "000"  & reg_DLY_PS_OR           ;
            when DLY_Else_OR( 11 downto 4)    =>   dataLocalBusOut <= "000"  & reg_DLY_Else_OR           ;

            when DPWM_delay_Else_OR( 11 downto 4)   =>   dataLocalBusOut <= "000" & reg_delay_Else_OR_Pre   ;
            when DPWM_delay_K_Scat( 11 downto 4)    =>   dataLocalBusOut <= "000" & reg_delay_K_Scat_Pre    ;
            when DPWM_counter_Else_OR( 11 downto 4) =>   dataLocalBusOut <= "000" & reg_counter_Else_OR_Pre ;
            when DPWM_counter_K_Scat( 11 downto 4)  =>   dataLocalBusOut <= "000" & reg_counter_K_Scat_Pre  ;

            when SEL_ctrl( 11 downto 4)             =>   dataLocalBusOut <= "0" & reg_ctrl                ;
            when RST_PSCNT( 11 downto 4)            =>   dataLocalBusOut <= "0000000" & reg_RST                 ;

			when others                 =>   dataLocalBusOut <= x"ff";
          end case;
          state_lbus <= Done;

        when Done =>
          readyLocalBus <= '1';
	  reg_RST <= '0';
          if ( weLocalBus='0' and reLocalBus='0' ) then
            state_lbus <= Idle;
          end if;
          
        when others =>
          state_lbus    <= Init;
      end case;
    end if;
  end process u_BusProcess;


end RTL;
