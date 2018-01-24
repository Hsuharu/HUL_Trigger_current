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

entity Region4 is
  port(
            	rst             : in std_logic;
            	clk_trg         : in std_logic;
            	clk_sys         : in std_logic;
            	
            	-- input signal --
            	BH2             : in  std_logic_vector( 7 downto 0 );
            	K_Scat          : in std_logic;
	        Clock           : in std_logic;
	        Reserve2        : in std_logic;
            	
            	-- output signal --
            	BH2_DLY         : out std_logic_vector( 7 downto 0 );
            	BH2_K           : out std_logic_vector( 7 downto 0 );
            	BH2_K_OR        : out std_logic;
            	BH2_K_OR_PS     : out std_logic;
	        Clock_sel       : out std_logic;
	        Reserve2_sel    : out std_logic;

            	-- Local bus --
            	addrLocalBus    : in LocalAddressType;
            	dataLocalBusIn  : in LocalBusInType;
            	dataLocalBusOut : out LocalBusOutType;
            	reLocalBus      : in std_logic;
            	weLocalBus      : in std_logic;
            	readyLocalBus   : out std_logic
    );
end Region4;

architecture RTL of Region4 is
  --  attribute keep : string;

  -- signal decralation -------------------------------------------------------------
	constant NbitOut           : positive := 5;
	constant NbitOut_2           : positive := 2;
	constant NbitOut_8           : positive := 8;
	signal state_lbus          : BusProcessType;


  -- Inner Signal --------------------------------------------------------
        signal in_BH2_DLY         : std_logic_vector( 7 downto 0 );
        signal in_BH2_DLY_pre     : std_logic_vector( 7 downto 0 );
        signal BH2_EDG            : std_logic_vector( 7 downto 0 );
        signal BH2_K_Pre          : std_logic_vector( 7 downto 0 );
        signal BH2_K_vector       : std_logic_vector( 7 downto 0 );
        signal in_BH2_K           : std_logic_vector( 7 downto 0 );
        signal BH2_K_2            : std_logic_vector( 7 downto 0 );
	
  -- For DLY -------------------------------------------------------------
	signal reg_DLY_BH2  : std_logic_vector(NbitOut-1 downto 0);

  -- For DPWM ------------------------------------------------------------
  -- For Delay --
	signal reg_delay_BH2_K    : std_logic_vector(NbitOut-1 downto 0);

  -- For PWM --
	signal reg_counter_BH2_K  : std_logic_vector(NbitOut-1 downto 0);

  -- For SEL ------------------------------------------------------------
        signal reg_selector_8    : std_logic_vector(7 downto 0);
        signal reg_SEL_clk    : std_logic;
        signal reg_SEL_rsv2   : std_logic;

  -- Modules  -------------------------------------------------------------
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

  component FDLY is
  port(
       rst             : in std_logic;
       clk_trg         : in std_logic;
       
       -- input signal --
       in1             : in  std_logic;
       -- output signal --
       out1            : out std_logic
      );
  end component;


  component EDG is
      port (
          rst : in std_logic;
          clk : in std_logic;
          dIn : in std_logic;
          dOut : out std_logic 
      );
  end component;

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

begin
  -- =================================== body =======================================
  -- Signal Assain ------------------------------------------------------------------
	BH2_DLY            <=  in_BH2_DLY_pre        ;
	BH2_K  <= BH2_K_2  ;

        gen_BH2_K_AND : for i in 0 to 7 generate 
                BH2_K_Pre(i) <= BH2_EDG(i) and K_Scat;
        end generate;

        gen_BH2_K_SEL : for i in 0 to 7 generate 
		BH2_K_2(i) <= in_BH2_K(i) when ( reg_selector_8(7-i) = '1' ) else '0' ;
        end generate;

	BH2_K_OR <= or_reduce(in_BH2_K);
	BH2_K_OR_PS <= or_reduce(BH2_K_2);
		Clock_sel    <= Clock    when ( reg_SEL_clk  = '1' ) else '0' ;
		Reserve2_sel <= Reserve2 when ( reg_SEL_rsv2 = '1' ) else '0' ;

  -- DLY ----------------------------------------------------------------------------
  gen_BH2_K_DLY : for i in 0 to 7 generate
      BH2_K_Inst : DLY 
            port map(
                    rst             => rst    ,
                    clk_trg         => clk_trg,
              
                    -- input signal --
                    delayin            => BH2(i), 
                    reg_delay          => reg_DLY_BH2   ,
                    -- output signal -- 
                    delayout           => in_BH2_DLY(i)
                
                    );
  end generate;

  -- FDLY ----------------------------------------------------------------------------
  gen_BH2_K_FDLY : for i in 0 to 7 generate
      BH2_K_Inst : FDLY 
            port map(
                    rst             => rst    ,
                    clk_trg         => clk_trg,
              
                    -- input signal --
                    in1            => in_BH2_DLY(i),
                    -- output signal -- 
                    out1              => in_BH2_DLY_pre(i)
                
                    );
  end generate;

  -- EDG ----------------------------------------------------------------------------------
    gen_BH2_EDG : for i in 0 to 7 generate
        BH2_EDG_Inst : EDG
            port map (
                     rst  => rst       ,
                     clk  => clk_trg   ,
                     dIn  => in_BH2_DLY_pre(i),
                     dOut => BH2_EDG(i)  
                     );
        end generate;

  -- DPWM ---------------------------------------------------------------------------
  gen_BH2_K_DPWM : for i in 0 to 7 generate
  BH2_K_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>BH2_K_Pre(i)        ,
	    reg_delay       =>reg_delay_BH2_K  ,
	    reg_counter     =>reg_counter_BH2_K,
	    -- output signal
	    out1            =>in_BH2_K(i)
	);
  end generate;


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

          reg_DLY_BH2              <= (others => '1');
          reg_delay_BH2_K          <= (others => '1');
	  reg_counter_BH2_K        <= (others => '1');
  	  reg_selector_8           <= (others => '1');

  	  reg_SEL_clk            <=  '1';
  	  reg_SEL_rsv2           <=  '1';

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
            when DLY_BH2            => reg_DLY_BH2        <= dataLocalBusIn(NbitOut-1 downto 0);
            when DPWM_delay_BH2_K   => reg_delay_BH2_K    <= dataLocalBusIn(NbitOut-1 downto 0);
            when DPWM_counter_BH2_K => reg_counter_BH2_K  <= dataLocalBusIn(NbitOut-1 downto 0);
            when SEL_8              => reg_selector_8     <= dataLocalBusIn(NbitOut_8-1 downto 0);

            when SEL_clk            => reg_SEL_clk     <= dataLocalBusIn(0);
            when SEL_rsv2           => reg_SEL_rsv2    <= dataLocalBusIn(0);

            when others => null;
          end case;
          state_lbus <= Done;

        when Read =>
          case addrLocalBus is
            when DLY_BH2            =>   dataLocalBusOut <= "000" & reg_DLY_BH2         ;
            when DPWM_delay_BH2_K   =>   dataLocalBusOut <= "000" & reg_delay_BH2_K     ;
            when DPWM_counter_BH2_K =>   dataLocalBusOut <= "000" & reg_counter_BH2_K ;
            when SEL_8              =>   dataLocalBusOut <=  reg_selector_8     ;
            when SEL_clk            =>   dataLocalBusOut <= "0000000" & reg_SEL_clk  ;
            when SEL_rsv2           =>   dataLocalBusOut <= "0000000" & reg_SEL_rsv2 ;

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
