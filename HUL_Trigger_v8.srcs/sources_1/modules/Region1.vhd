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

entity Region1 is
  port(
    	        rst                      : in  std_logic;
    	        clk_trg                  : in  std_logic;
    	        clk_sys                  : in  std_logic;
    	        
		-- Selector for TOF ---------------------
    	        FSD_Sel_Pre1             : in  std_logic_vector(11 downto 0);
    	        FSD_Sel_Pre2             : in  std_logic_vector(11 downto 0);
	        -- DPWM ---------------------------------
    	        -- input signal --
    	        BH1_or                   : in  std_logic;
    	        BH2_or                   : in  std_logic;
	
                SAC_or                   : in  std_logic;
                TOF_or                   : in  std_logic;
                Lucite_or                : in  std_logic;
                TOF_High_Threshold       : in  std_logic;
--                Matrix_3D                : in  std_logic;

                Other4                   : in  std_logic;
                Other5                   : in  std_logic;

    	        -- output signal --         
    	        FSD_Sel1             : out std_logic_vector(11 downto 0);
    	        FSD_Sel2             : out std_logic_vector(11 downto 0);
    	        -- Beam --        
    	        BH1_Beam              : out std_logic;
    	        BH2_Beam              : out std_logic;

    	        -- Pi_Beam --        
    	        BH1_Pi                : out std_logic;
    	        BH2_Pi                : out std_logic;

    	        -- P_Beam --        
    	        BH1_P                 : out std_logic;
    	        BH2_P                 : out std_logic;
    	        
    	        -- K_Scat --         
                SAC_K_Scat              : out std_logic;
                TOF_K_Scat              : out std_logic;
                Lucite_K_Scat           : out std_logic;
                TOF_HT_K_Scat           : out std_logic;
--                Matrix_3D_K_Scat           : out std_logic;
                Other4_K_Scat                    : out std_logic;
                Other5_K_Scat                    : out std_logic;

                K_Scat                     : out std_logic;

    	        -- input signal --
    	        -- output signal --         
            	Beam         : out std_logic;
            	Pi_Beam         : out std_logic;
            	P_Beam          : out std_logic;

	        -- BPS ----------------------------------
    	        -- K_Scat --         
		K_Scat_Pre		 : out std_logic;
                -- Local bus --
                addrLocalBus        : in LocalAddressType;
                dataLocalBusIn      : in LocalBusInType;
                dataLocalBusOut     : out LocalBusOutType;
                reLocalBus          : in std_logic;
                weLocalBus          : in std_logic;
                readyLocalBus       : out std_logic
    );
end Region1;

architecture RTL of Region1 is
  --  attribute keep : string;

  -- signal decralation -------------------------------------------------------------
	constant NbitOut           : positive := 5;
	constant NbitOut_2           : positive := 2;
	constant NbitOut_6           : positive := 6;
	constant NbitOut_7           : positive := 7;
	signal state_lbus          : BusProcessType;


  -- Inner Signal --------------------------------------------------------
    	signal in_FSD_Sel1      : std_logic_vector(11 downto 0);
    	signal in_FSD_Sel2      : std_logic_vector(11 downto 0);
        signal in_BH1_or        : std_logic;
        signal in_BH2_or        : std_logic;
        signal in_BH1_Beam      : std_logic;
        signal in_BH2_Beam      : std_logic;
        signal in_BH1_Pi        : std_logic;
        signal in_BH2_Pi        : std_logic;
        signal in_BH1_P         : std_logic;
        signal in_BH2_P         : std_logic;
        signal in_Beam          : std_logic;
        signal in_Pi_Beam       : std_logic;
        signal in_P_Beam        : std_logic;
    	        -- K_Scat --         
        signal in_SAC_K_Scat         : std_logic;
        signal in_TOF_K_Scat         : std_logic;
        signal in_Lucite_K_Scat      : std_logic;
        signal in_TOF_HT_K_Scat      : std_logic;
        signal in_K_Scat_Pre	     : std_logic;
        signal in_Other4_K_Scat     : std_logic;
        signal in_Other5_K_Scat     : std_logic;
	
  -- For Register --------------------------------------------------------
  -- For Selector of TOF -------------------------------------------------
	signal reg_Sel_TOF  : std_logic_vector(23 downto 0);
  -- For DPWM ------------------------------------------------------------
  -- For Delay --
	signal reg_delay_BH1_Beam  : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_BH2_Beam  : std_logic_vector(NbitOut-1 downto 0);

	signal reg_delay_BH1_Pi    : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_BH2_Pi    : std_logic_vector(NbitOut-1 downto 0);
	
	signal reg_delay_BH1_P     : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_BH2_P     : std_logic_vector(NbitOut-1 downto 0);

	signal reg_delay_SAC_K_Scat               : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_TOF_K_Scat               : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_Lucite_K_Scat            : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_TOF_HT_K_Scat            : std_logic_vector(NbitOut-1 downto 0);

	signal reg_delay_K_Scat_pre               : std_logic_vector(NbitOut-1 downto 0);

	signal reg_delay_Other4                   : std_logic_vector(NbitOut-1 downto 0);
	signal reg_delay_Other5                   : std_logic_vector(NbitOut-1 downto 0);


  -- For PWM --
	signal reg_counter_BH1_Beam : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_BH2_Beam : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_BH1_Pi   : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_BH2_Pi   : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_BH1_P    : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_BH2_P    : std_logic_vector(NbitOut-1 downto 0);

	signal reg_counter_SAC_K_Scat                : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_TOF_K_Scat                : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_Lucite_K_Scat             : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_TOF_HT_K_Scat             : std_logic_vector(NbitOut-1 downto 0);

	signal reg_counter_K_Scat_pre                   : std_logic_vector(NbitOut-1 downto 0);

	signal reg_counter_Other4                   : std_logic_vector(NbitOut-1 downto 0);
	signal reg_counter_Other5                   : std_logic_vector(NbitOut-1 downto 0);


  -- For BPS ------------------------------------------------------------
        signal reg_ctrl_Beam  : std_logic_vector(1 downto 0);
        signal reg_coin_Beam  : std_logic_vector(1 downto 0);
--        signal reg_ctrl_P   : std_logic_vector(1 downto 0);
--        signal reg_coin_P   : std_logic_vector(1 downto 0);
--
        signal reg_ctrl_K_Scat   : std_logic_vector(5 downto 0);
        signal reg_coin_K_Scat   : std_logic_vector(5 downto 0);

  -- Modules  -------------------------------------------------------------
--  component FDLY is
--  port(
--       rst             : in std_logic;
--       clk_trg         : in std_logic;
--       
--       -- input signal --
--       in1             : in  std_logic;
--       -- output signal --
--       out1            : out std_logic
--      );
--  end component;

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

  component BPS_2bits is
  	port(
             rst            : in std_logic;
             clk_trg        : in std_logic;
  	     -- input signal --
  	     inA            : in  std_logic;
  	     inB            : in  std_logic;
  	     reg_ctrl       : in  std_logic_vector(1 downto 0);
  	     reg_coin       : in  std_logic_vector(1 downto 0);
  	     -- output signal --
  	     out1           : out std_logic
  	    );
  end component;

  component BPS_6bits is
  	port(
             rst            : in std_logic;
             clk_trg        : in std_logic;
  	     -- input signal --
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
  -- Signal Assain ------------------------------------------------------------------
    	FSD_Sel1           <=  in_FSD_Sel1      ;
    	FSD_Sel2           <=  in_FSD_Sel2      ;
        -- Beam --   
	BH1_Beam           <=  in_BH1_Beam       ;
        BH2_Beam           <=  in_BH2_Beam       ;
	Beam               <=  in_Beam           ;
        -- Pi_Beam --   
	BH1_Pi             <=  in_BH1_Pi         ;
        BH2_Pi             <=  in_BH2_Pi         ;
	in_Pi_Beam         <=  in_BH1_Pi and in_BH2_Pi ;
                      
        -- P_Beam --   
        BH1_P              <=  in_BH1_P          ;
        BH2_P              <=  in_BH2_P          ;
	in_P_Beam          <=  in_BH1_P  and in_BH2_P ;
                         
        -- K_Scat --    
        SAC_K_Scat         <=  in_SAC_K_Scat     ;
        TOF_K_Scat         <=  in_TOF_K_Scat     ;
        Lucite_K_Scat      <=  in_Lucite_K_Scat  ;
        TOF_HT_K_Scat      <=  in_TOF_HT_K_Scat  ;
--        Matrix_3D_K_Scat   <=  in_Matrix_3D_K_Scat;
                     
        K_Scat_Pre         <=  in_K_Scat_Pre     ;    
                    
        Other4_K_Scat             <=  in_Other4_K_Scat	         ;
        Other5_K_Scat             <=  in_Other5_K_Scat	         ;

	gen_Sel_TOF : for i in 0 to 11 generate
		in_FSD_sel1(i) <= FSD_Sel_Pre1(i) and reg_Sel_TOF(i);
		in_FSD_sel2(i) <= FSD_Sel_Pre2(i) and reg_Sel_TOF(i+12);
	end generate;

         process(clk_trg)
          begin
          	if(clk_trg'event and clk_trg = '1') then
        	Pi_Beam           <=  in_Pi_Beam         ;
                P_Beam            <=  in_P_Beam          ;
          	end if;
          end process ;

         process(clk_trg)
          begin
          	if(clk_trg'event and clk_trg = '1') then
        	in_BH1_or            <=  BH1_or          ;
                in_BH2_or            <=  BH2_or          ;
          	end if;
          end process ;

--  -- FDLY ---------------------------------------------------------------------------
--  BH2_Or_Fixed_Delay_Inst : FDLY
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>BH2_or        ,
--	    -- output signal
--	    out1            =>in_BH2_or
--	);

  -- DPWM ---------------------------------------------------------------------------
  -- BH1 --
  BH1_Beam_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>in_BH1_or        ,
	    reg_delay       =>reg_delay_BH1_Beam  ,
	    reg_counter     =>reg_counter_BH1_Beam,
	    -- output signal
	    out1            =>in_BH1_Beam
	);

  BH1_Pi_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>in_BH1_or        ,
	    reg_delay       =>reg_delay_BH1_Pi  ,
	    reg_counter     =>reg_counter_BH1_Pi,
	    -- output signal
	    out1            =>in_BH1_Pi
	);

  BH1_P_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>in_BH1_or        ,
	    reg_delay       =>reg_delay_BH1_P  ,
	    reg_counter     =>reg_counter_BH1_P,
	    -- output signal
	    out1            =>in_BH1_P
	);

  -- BH2 --
  BH2_Beam_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>in_BH2_or        ,
	    reg_delay       =>reg_delay_BH2_Beam  ,
	    reg_counter     =>reg_counter_BH2_Beam,
	    -- output signal
	    out1            =>in_BH2_Beam
	);

  BH2_Pi_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>in_BH2_or        ,
	    reg_delay       =>reg_delay_BH2_Pi  ,
	    reg_counter     =>reg_counter_BH2_Pi,
	    -- output signal
	    out1            =>in_BH2_Pi
	);

  BH2_P_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>in_BH2_or        ,
	    reg_delay       =>reg_delay_BH2_P  ,
	    reg_counter     =>reg_counter_BH2_P,
	    -- output signal
	    out1            =>in_BH2_P
	);

  -- K_Scat --
  SAC_K_Scat_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>SAC_or,
	    reg_delay       =>reg_delay_SAC_K_Scat  ,
	    reg_counter     =>reg_counter_SAC_K_Scat,
	    -- output signal
	    out1            =>in_SAC_K_Scat
	);

  TOF_K_Scat_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>TOF_or,
	    reg_delay       =>reg_delay_TOF_K_Scat  ,
	    reg_counter     =>reg_counter_TOF_K_Scat,
	    -- output signal
	    out1            =>in_TOF_K_Scat
	);

  Lucite_K_Scat_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Lucite_or,
	    reg_delay       =>reg_delay_Lucite_K_Scat  ,
	    reg_counter     =>reg_counter_Lucite_K_Scat,
	    -- output signal
	    out1            =>in_Lucite_K_Scat
	);

  TOF_HT_K_Scat_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>TOF_High_Threshold,
	    reg_delay       =>reg_delay_TOF_HT_K_Scat  ,
	    reg_counter     =>reg_counter_TOF_HT_K_Scat,
	    -- output signal
	    out1            =>in_TOF_HT_K_Scat
	);

--  Matrix_3D_K_Scat_Inst : DPWM
--	port map(
--	    rst             => rst    ,
--	    clk_trg         => clk_trg,
--	    
--	    -- input signal --
--	    in1             =>Matrix_3D,
--	    reg_delay       =>reg_delay_3DMtx_K_Scat  ,
--	    reg_counter     =>reg_counter_3DMtx_K_Scat,
--	    -- output signal
--	    out1            =>in_Matrix_3D_K_Scat
--	);

  -- K_Scat_Pre --
  K_Scat_Pre_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>in_K_Scat_Pre,
	    reg_delay       =>reg_delay_K_Scat_Pre  ,
	    reg_counter     =>reg_counter_K_Scat_Pre,
	    -- output signal
	    out1            =>K_Scat
	);

  -- Other --
  Other4_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Other4,
	    reg_delay       =>reg_delay_Other4  ,
	    reg_counter     =>reg_counter_Other4,
	    -- output signal
	    out1            =>in_Other4_K_Scat
	);

  Other5_Inst : DPWM
	port map(
	    rst             => rst    ,
	    clk_trg         => clk_trg,
	    
	    -- input signal --
	    in1             =>Other5,
	    reg_delay       =>reg_delay_Other5  ,
	    reg_counter     =>reg_counter_Other5,
	    -- output signal
	    out1            =>in_Other5_K_Scat
	);


  -- BPS ----------------------------------------------------------------------------
  Beam_BPS_Inst : BPS_2bits 
  port map(
    rst             => rst    ,
    clk_trg         => clk_trg,
    -- input signal --
    inA            => in_BH1_Beam    ,
    inB            => in_BH2_Beam    ,
    reg_ctrl       => reg_ctrl_Beam  ,
    reg_coin       => reg_coin_Beam  ,
    -- output signal --
    out1           => in_Beam 
  );

--  Pi_BPS_Inst : BPS_2bits 
--  port map(
--    rst             => rst    ,
--    clk_trg         => clk_trg,
--    -- input signal --
--    inA            => in_BH1_Pi    ,
--    inB            => in_BH2_Pi    ,
--    reg_ctrl       => reg_ctrl_Pi    ,
--    reg_coin       => reg_coin_Pi    ,
--    -- output signal --
--    out1           => Pi_Beam 
--  );
--	
--  P_BPS_Inst : BPS_2bits 
--  port map(
--    rst             => rst    ,
--    clk_trg         => clk_trg,
--    -- input signal --
--    inA            => in_BH1_P     ,
--    inB            => in_BH2_P     ,
--    reg_ctrl       => reg_ctrl_P     ,
--    reg_coin       => reg_coin_P     ,
--    -- output signal --
--    out1           => P_Beam 
--  );

  K_Scat_BPS_Inst : BPS_6bits 
  port map(
    rst             => rst    ,
    clk_trg         => clk_trg,
    -- input signal --
    inA            => in_SAC_K_Scat              ,
    inB            => in_TOF_K_Scat              ,
    inC            => in_Lucite_K_Scat           ,
    inD            => in_TOF_HT_K_Scat           ,
--    inE            => in_Matrix_3D_K_Scat        ,
    inE            => in_Other4_K_Scat        ,
    inF            => in_Other5_K_Scat       ,
    reg_ctrl       => reg_ctrl_K_Scat         ,
    reg_coin       => reg_coin_K_Scat         ,
    -- output signal     --
    out1           => in_K_Scat_Pre 
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
          reg_Sel_TOF                         <= (others => '1');
          reg_delay_BH1_Beam                  <= (others => '1');
          reg_delay_BH2_Beam                  <= (others => '1');
          reg_delay_BH1_Pi                    <= (others => '1');
          reg_delay_BH2_Pi                    <= (others => '1');
          reg_delay_BH1_P                     <= (others => '1');
          reg_delay_BH2_P                     <= (others => '1');
	  reg_delay_SAC_K_Scat                <= (others => '1');
	  reg_delay_TOF_K_Scat                <= (others => '1');
	  reg_delay_Lucite_K_Scat             <= (others => '1'); 
	  reg_delay_TOF_HT_K_Scat             <= (others => '1');
	  reg_delay_K_Scat_pre                <= (others => '1');
	  reg_delay_Other4                    <= (others => '1');
	  reg_delay_Other5                    <= (others => '1');

          reg_counter_BH1_Beam                <= (others => '1');
          reg_counter_BH2_Beam                <= (others => '1');
          reg_counter_BH1_Pi                  <= (others => '1');
          reg_counter_BH2_Pi                  <= (others => '1');
          reg_counter_BH1_P                   <= (others => '1');
          reg_counter_BH2_P                   <= (others => '1');
	  reg_counter_SAC_K_Scat              <= (others => '1');
	  reg_counter_TOF_K_Scat              <= (others => '1');
	  reg_counter_Lucite_K_Scat           <= (others => '1');
	  reg_counter_TOF_HT_K_Scat           <= (others => '1');
	  reg_counter_K_Scat_pre              <= (others => '1');
	  reg_counter_Other4                  <= (others => '1');
	  reg_counter_Other5                  <= (others => '1');
                                                                 
          reg_ctrl_Beam                       <= (others => '1');
          reg_coin_Beam                       <= (others => '1');
--          reg_ctrl_Pi                         <= (others => '1');
--          reg_coin_Pi                         <= (others => '1');
--          reg_ctrl_P                          <= (others => '1');
--          reg_coin_P                          <= (others => '1');

  	  reg_ctrl_K_Scat                     <= (others => '1');
  	  reg_coin_K_Scat                     <= (others => '1');

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
            when SEL_TOF          =>  reg_Sel_TOF          <= dataLocalBusIn(23 downto 0);
            when DLY_BH1_Beam_sel =>  reg_delay_BH1_Beam   <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_BH2_Beam_sel =>  reg_delay_BH2_Beam   <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_BH1_Pi_sel   =>  reg_delay_BH1_Pi     <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_BH2_Pi_sel   =>  reg_delay_BH2_Pi     <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_BH1_P_sel    =>  reg_delay_BH1_P      <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_BH2_P_sel    =>  reg_delay_BH2_P      <= dataLocalBusIn(NbitOut-1 downto 0);

            when PWM_BH1_Beam_sel =>  reg_counter_BH1_Beam <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_BH2_Beam_sel =>  reg_counter_BH2_Beam <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_BH1_Pi_sel   =>  reg_counter_BH1_Pi   <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_BH2_Pi_sel   =>  reg_counter_BH2_Pi   <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_BH1_P_sel    =>  reg_counter_BH1_P    <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_BH2_P_sel    =>  reg_counter_BH2_P    <= dataLocalBusIn(NbitOut-1 downto 0);

	    -- K_Scat ----------------------------------------------------------------------------
            when DLY_SAC_K_Scat_sel     => reg_delay_SAC_K_Scat    <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_TOF_K_Scat_sel     => reg_delay_TOF_K_Scat    <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_Lucite_K_Scat_sel  => reg_delay_Lucite_K_Scat <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_TOF_HT_K_Scat_sel  => reg_delay_TOF_HT_K_Scat <= dataLocalBusIn(NbitOut-1 downto 0);
--            when DLY_3DMtx_K_Scat_sel   => reg_delay_3DMtx_K_Scat  <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_Other4_Scat        => reg_delay_Other4        <= dataLocalBusIn(NbitOut-1 downto 0);
            when DLY_Other5_Scat        => reg_delay_Other5        <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_SAC_K_Scat_sel     => reg_counter_SAC_K_Scat    <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_TOF_K_Scat_sel     => reg_counter_TOF_K_Scat    <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_Lucite_K_Scat_sel  => reg_counter_Lucite_K_Scat <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_TOF_HT_K_Scat_sel  => reg_counter_TOF_HT_K_Scat <= dataLocalBusIn(NbitOut-1 downto 0);
--            when PWM_3DMtx_K_Scat_sel   => reg_counter_3DMtx_K_Scat  <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_Other4_Scat        => reg_counter_Other4      <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_Other5_Scat        => reg_counter_Other5      <= dataLocalBusIn(NbitOut-1 downto 0);

	    -- K_Scat_Pre ------------------------------------------------------------------------
            when DLY_K_Scat_Pre_sel  =>  reg_delay_K_Scat_Pre    <= dataLocalBusIn(NbitOut-1 downto 0);
            when PWM_K_Scat_Pre_sel  =>  reg_counter_K_Scat_Pre  <= dataLocalBusIn(NbitOut-1 downto 0);

            when BPS_ctrl_Beam =>  reg_ctrl_Beam <= dataLocalBusIn(NbitOut_2-1 downto 0);
            when BPS_coin_Beam =>  reg_coin_Beam <= dataLocalBusIn(NbitOut_2-1 downto 0);
--            when BPS_ctrl_Pi =>  reg_ctrl_Pi <= dataLocalBusIn(NbitOut_2-1 downto 0);
--            when BPS_coin_Pi =>  reg_coin_Pi <= dataLocalBusIn(NbitOut_2-1 downto 0);
--            when BPS_ctrl_P  =>  reg_ctrl_P  <= dataLocalBusIn(NbitOut_2-1 downto 0);
--            when BPS_coin_P  =>  reg_coin_P  <= dataLocalBusIn(NbitOut_2-1 downto 0);

            when BPS_ctrl_K_Scat  =>  reg_ctrl_K_Scat  <= dataLocalBusIn(NbitOut_6-1 downto 0);
            when BPS_coin_K_Scat  =>  reg_coin_K_Scat  <= dataLocalBusIn(NbitOut_6-1 downto 0);

            when others => null;
          end case;
          state_lbus <= Done;

        when Read =>
          case addrLocalBus( 11 downto 4) is
		  when SEL_TOF( 11 downto 4) => 
			  if(    addrLocalBus( 1 downto 0 ) = "00"  ) then
				  dataLocalBusOut <= reg_Sel_TOF(  7 downto 0 );
			  elsif( addrLocalBus( 1 downto 0 ) = "01"  ) then
				  dataLocalBusOut <= reg_Sel_TOF( 15 downto 8 );
		          else
				  dataLocalBusOut <= reg_Sel_TOF( 23 downto 16);
		          end if;

            when DLY_BH1_Beam_sel( 11 downto 4) =>   dataLocalBusOut <= "000" & reg_delay_BH1_Beam  ;
            when DLY_BH2_Beam_sel( 11 downto 4) =>   dataLocalBusOut <= "000" & reg_delay_BH2_Beam  ;
            when DLY_BH1_Pi_sel( 11 downto 4)   =>   dataLocalBusOut <= "000" & reg_delay_BH1_Pi  ;
            when DLY_BH2_Pi_sel( 11 downto 4)   =>   dataLocalBusOut <= "000" & reg_delay_BH2_Pi  ;
            when DLY_BH1_P_sel( 11 downto 4)    =>   dataLocalBusOut <= "000" & reg_delay_BH1_P  ;
            when DLY_BH2_P_sel( 11 downto 4)    =>   dataLocalBusOut <= "000" & reg_delay_BH2_P  ;

            when PWM_BH1_Beam_sel( 11 downto 4) =>   dataLocalBusOut <= "000" & reg_counter_BH1_Beam;
            when PWM_BH2_Beam_sel( 11 downto 4) =>   dataLocalBusOut <= "000" & reg_counter_BH2_Beam;
            when PWM_BH1_Pi_sel( 11 downto 4)   =>   dataLocalBusOut <= "000" & reg_counter_BH1_Pi;
            when PWM_BH2_Pi_sel( 11 downto 4)   =>   dataLocalBusOut <= "000" & reg_counter_BH2_Pi;
            when PWM_BH1_P_sel( 11 downto 4)    =>   dataLocalBusOut <= "000" & reg_counter_BH1_P;
            when PWM_BH2_P_sel( 11 downto 4)    =>   dataLocalBusOut <= "000" & reg_counter_BH2_P;

	    -- K_Scat --------------------------------------------------------------
            when DLY_SAC_K_Scat_sel( 11 downto 4)    => dataLocalBusOut <= "000" & reg_delay_SAC_K_Scat      ;
            when DLY_TOF_K_Scat_sel( 11 downto 4)    => dataLocalBusOut <= "000" & reg_delay_TOF_K_Scat      ;
            when DLY_Lucite_K_Scat_sel( 11 downto 4) => dataLocalBusOut <= "000" & reg_delay_Lucite_K_Scat   ;
            when DLY_TOF_HT_K_Scat_sel( 11 downto 4) => dataLocalBusOut <= "000" & reg_delay_TOF_HT_K_Scat   ;
--            when DLY_3DMtx_K_Scat_sel  => dataLocalBusOut <= "000" & reg_delay_3DMtx_K_Scat    ;
            -- Other --
            when DLY_Other4_Scat( 11 downto 4)   => dataLocalBusOut <= "000" & reg_delay_Other4   ;
            when DLY_Other5_Scat( 11 downto 4)   => dataLocalBusOut <= "000" & reg_delay_Other5   ;

            when PWM_SAC_K_Scat_sel( 11 downto 4)    => dataLocalBusOut <= "000" & reg_counter_SAC_K_Scat    ;
            when PWM_TOF_K_Scat_sel( 11 downto 4)    => dataLocalBusOut <= "000" & reg_counter_TOF_K_Scat    ;
            when PWM_Lucite_K_Scat_sel( 11 downto 4) => dataLocalBusOut <= "000" & reg_counter_Lucite_K_Scat ;
            when PWM_TOF_HT_K_Scat_sel( 11 downto 4) => dataLocalBusOut <= "000" & reg_counter_TOF_HT_K_Scat ;
--            when PWM_3DMtx_K_Scat_sel  => dataLocalBusOut <= "000" & reg_counter_3DMtx_K_Scat  ;
            -- Other --
            when PWM_Other4_Scat( 11 downto 4)   => dataLocalBusOut <= "000" & reg_counter_Other4 ;
            when PWM_Other5_Scat( 11 downto 4)   => dataLocalBusOut <= "000" & reg_counter_Other5 ;

	    -- K_Scat_Pre ----------------------------------------------------------
            when DLY_K_Scat_Pre_sel( 11 downto 4)  =>   dataLocalBusOut <= "000" & reg_delay_K_Scat_Pre  ;
            when PWM_K_Scat_Pre_sel( 11 downto 4)  =>   dataLocalBusOut <= "000" & reg_counter_K_Scat_Pre;

            when BPS_ctrl_Beam( 11 downto 4) =>   dataLocalBusOut <= "000000" & reg_ctrl_Beam;
            when BPS_coin_Beam( 11 downto 4) =>   dataLocalBusOut <= "000000" & reg_coin_Beam;
--            when BPS_ctrl_Pi =>   dataLocalBusOut <= "000000" & reg_ctrl_Pi;
--            when BPS_coin_Pi =>   dataLocalBusOut <= "000000" & reg_coin_Pi;
--            when BPS_ctrl_P  =>   dataLocalBusOut <= "000000" & reg_ctrl_P ;
--            when BPS_coin_P  =>   dataLocalBusOut <= "000000" & reg_coin_P ;

            when BPS_ctrl_K_Scat( 11 downto 4)  =>   dataLocalBusOut <= "00" & reg_ctrl_K_Scat ;
            when BPS_coin_K_Scat( 11 downto 4)  =>   dataLocalBusOut <= "00" & reg_coin_K_Scat ;

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
