library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

library mylib;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity toplevel is
  Port (
   -- System ----------------------------------------------------------------------
   CLKOSC       : in std_logic; -- 50 MHz
   LED          : out std_logic_vector(3 downto 0);
   DIP          : in  std_logic_vector(7 downto 0);
   PROG_B_ON    : out std_logic;
   
   -- Fixed signal input ----------------------------------------------------------
   FIXED_SIGIN_U  : in std_logic_vector(31 downto 0); -- 0-31 ch
   FIXED_SIGIN_D  : in std_logic_vector(31 downto 0); -- 32-63 ch
   
--    Mezzanine signal/In ------------------------------------------------------------
--   MZN_SIG_Up   : inout std_logic_vector(31 downto 0); -- 64-95 ch
--   MZN_SIG_Un   : inout std_logic_vector(31 downto 0);
--   MZN_SIG_Dp   : in std_logic_vector(31 downto 0); -- 96-127 ch
--   MZN_SIG_Dn   : in std_logic_vector(31 downto 0);

   -- Mezzanine signal/Out ------------------------------------------------------------
   MZN_SIG_Up   : inout std_logic_vector(31 downto 0); -- 64-95 ch
   MZN_SIG_Un   : inout std_logic_vector(31 downto 0);
   MZN_SIG_Dp   : out std_logic_vector(31 downto 0); -- 96-127 ch
   MZN_SIG_Dn   : out std_logic_vector(31 downto 0);
   
   -- PHY -------------------------------------------------------------------------
   PHY_MDIO		: inout std_logic;
   PHY_MDC      : out std_logic;
   PHY_nRST     : out std_logic;
   PHY_HPD      : out std_logic;
   --PHY_IRQ      : in std_logic;
   
   PHY_RXD      : in std_logic_vector(7 downto 0);
   PHY_RXDV     : in std_logic;
   PHY_RXER     : in std_logic;
   PHY_RX_CLK   : in std_logic;
   
   PHY_TXD      : out std_logic_vector(7 downto 0);
   PHY_TXEN     : out std_logic;
   PHY_TXER     : out std_logic;
   PHY_TX_CLK   : in std_logic;
   
   PHY_GTX_CLK  : out std_logic;
   
   PHY_CRS      : in std_logic;
   PHY_COL      : in std_logic;
   
   -- EEPROM ----------------------------------------------------------------------
   PROM_CS	    : out std_logic;
   PROM_SK      : out std_logic;
   PROM_DI      : out std_logic;
   PROM_DO      : in std_logic;
   
   -- J0 BUS ----------------------------------------------------------------------
   -- Receiver mode --
   --J0RS         : in std_logic_vector(7 downto 1);
   J0DC         : out std_logic_vector(2 downto 1);
   
   -- Driver mode --
   --J0DS         : out std_logic_vector(7 downto 1);
   --J0RC         : in std_logic_vector(2 downto 1);
   
   -- User I/O --------------------------------------------------------------------
   USER_RST_B   : in std_logic;
   NIMIN        : in  std_logic_vector(4 downto 1); -- NIM in1 : stop, NIM in2 : L2, NIM in3 : clear, NIM in4 : gTag
   NIMOUT       : out std_logic_vector(4 downto 1)
   
  );
end toplevel;

architecture Behavioral of toplevel is

--    attribute mark_debug : string;
    attribute keep       : string;

    -- System --------------------------------------------------------------------------------
    signal sitcp_reset  : std_logic;
    signal system_reset : std_logic;
    signal user_reset   : std_logic;
    signal rst_from_bus : std_logic;

    -- DIP -----------------------------------------------------------------------------------
    signal dip_sw       : std_logic_vector(7 downto 0);
    subtype DipID is integer range -1 to 7;
    type regLeaf is record
        Index : DipID;
    end record;
    constant i_SiTCP     : regLeaf := (Index => 0);
    constant i_LED1      : regLeaf := (Index => 1);
    constant i_LED2      : regLeaf := (Index => 2);
    constant i_LED3      : regLeaf := (Index => 3);
    constant i_LED4      : regLeaf := (Index => 4);
    constant i_NC1       : regLeaf := (Index => 5);
    constant i_NC2       : regLeaf := (Index => 6);
    constant i_USER      : regLeaf := (Index => 7);
    constant i_Dummy     : regLeaf := (Index => -1); 
    
    -- Finxed input ports --------------------------------------------------------------------
    
    -- Mezzanine ports -----------------------------------------------------------------------
    signal mzn_u, mzn_d                         : std_logic_vector(31 downto 0);
    signal dcr_u, dcr_d                         : std_logic_vector(31 downto 0);
    
    -- Mezzanine In ver -----------------------------------------------------------------------
--    component DCR_NetAssign is
--        Port (
--            mzn_in_u  : in  std_logic_vector(31 downto 0);
--            mzn_in_d  : in  std_logic_vector(31 downto 0);
--            dcr_out_u : out std_logic_vector(31 downto 0);
--            dcr_out_d : out std_logic_vector(31 downto 0)
--        );
--    end component;

    -- Mezzanine Out ver -----------------------------------------------------------------------
    component DCR_NetAssign_Out is
        Port (
            mzn_out_u  : out  std_logic_vector(31 downto 0);
            mzn_out_d  : out  std_logic_vector(31 downto 0);
            dcr_in_u   : in  std_logic_vector(31 downto 0);
            dcr_in_d   : in  std_logic_vector(31 downto 0)
        );
    end component;

    signal nim_in     : std_logic_vector(4 downto 1);
    signal nim_in_Pre : std_logic_vector(4 downto 1);
    signal nim_out    : std_logic_vector(4 downto 1);
        
    -- LED ----------------------------------------------------------------------------------
    signal reg_led  : std_logic_vector(3 downto 0);
    
    component LED_Module is
        port(
            rst    : in std_logic;
            clk    : in std_logic;
            -- Module output --
            outLED    : out std_logic_vector(3 downto 0);
            -- Local bus --
            addrLocalBus       : in LocalAddressType;
            dataLocalBusIn     : in LocalBusInType;
            dataLocalBusOut    : out LocalBusOutType;
            reLocalBus         : in std_logic;
            weLocalBus         : in std_logic;
            readyLocalBus      : out std_logic
        );
    end component;    
    
    -- Module & Signal ------------------------------------------------------------------------
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


    -- Siganals ------------------------------------------------------
    signal FSU                      : std_logic_vector(31 downto 0);
    signal FSD                      : std_logic_vector(31 downto 0);
    signal FSD_sel_Pre1             : std_logic_vector(11 downto 0);
    signal FSD_sel_Pre2             : std_logic_vector(11 downto 0);
    signal FSD_sel1                 : std_logic_vector(11 downto 0);
    signal FSD_sel2                 : std_logic_vector(11 downto 0);
    signal Fixed_Signal_In_Up       : std_logic_vector(31 downto 0);
    signal Fixed_Signal_In_Down     : std_logic_vector(31 downto 0);

    -- LVDS In -------------------------------------------------------
    signal BH1                      : std_logic_vector(10 downto 0);
    signal BH2                      : std_logic_vector( 7 downto 0);
    
    signal SAC                      : std_logic_vector( 3 downto 0);
    signal TOF                      : std_logic_vector(23 downto 0);
    signal LC_OR                    : std_logic;
    signal TOF_HT                   : std_logic;
    signal SpillGate                : std_logic;
--    signal Mtx_3D                   : std_logic;
    signal Other                    : std_logic_vector( 5 downto 1);
    signal Clock                    : std_logic;
    signal Reserve2                 : std_logic;

    -- Internal Sig --------------------------------------------------
--    signal BH1_or_Pre               : std_logic_vector( 1 downto 0);
    signal BH1_or_Pre               : std_logic;
    signal BH1_or                   : std_logic;
    signal BH2_or                   : std_logic;
    signal SAC_or                   : std_logic;
    signal TOF_or_Pre               : std_logic_vector( 3 downto 0);
--    signal Pre_TOF_or               : std_logic;
    signal TOF_or                   : std_logic;
    signal TOF_or_R1                : std_logic;
    signal TOF_or_R2_1                : std_logic;
    signal TOF_or_R2_2                : std_logic;
    signal TOF_or_R2_3                : std_logic;
    signal TOF_or_R2_4                : std_logic;
    signal TOF_or_R2_5                : std_logic;
--    signal TOF_or_IOM                 : std_logic;
    signal Lucite_or                : std_logic;
    signal TOF_High_Threshold       : std_logic;
    signal SG                       : std_logic;
--    signal Matrix_3D                : std_logic;

    signal Other1                   : std_logic;
    signal Other2                   : std_logic;
    signal Other3                   : std_logic;
    signal Other4                   : std_logic;
    signal Other5                   : std_logic;

    signal BH1_Beam                 : std_logic;
    signal BH2_Beam                 : std_logic;
    signal BH1_Pi                   : std_logic;
    signal BH2_Pi                   : std_logic;
    signal BH1_P                    : std_logic;
    signal BH2_P                    : std_logic;

    -- Beam --         
    signal Beam                     : std_logic;
--    signal Beam_Pregate             : std_logic;
--    signal Beam_leadingedge             : std_logic;
--    signal Beam_counter0                : std_logic;
    signal Pi_Beam                  : std_logic;
    signal P_Beam                   : std_logic;

    -- K_Scat --       
    signal K_Scat_Pre               : std_logic;
    signal K_Scat                   : std_logic;

    signal SAC_K_Scat               : std_logic;
    signal TOF_K_Scat               : std_logic;
    signal Lucite_K_Scat            : std_logic;
    signal TOF_HT_K_Scat            : std_logic;
    signal Matrix_3D_K_Scat         : std_logic;
    signal Other4_K_Scat            : std_logic;
    signal Other5_K_Scat            : std_logic;

    -- Beam_TOF --         
    signal BH2_Pi_Beam_TOF          : std_logic;
--    signal Beam_Beam_TOF            : std_logic;
    signal SAC_or_Beam_TOF          : std_logic;
    signal TOF_or_Beam_TOF          : std_logic;
    signal LC_or_Beam_TOF           : std_logic;
    signal TOF_HT_Beam_TOF          : std_logic;
    signal Matrix_3D_Beam_TOF       : std_logic;
    signal Other4_Beam_TOF          : std_logic;
    signal Other5_Beam_TOF          : std_logic;

    -- For_E03 --
    signal BH2_Pi_E03               : std_logic;
    signal Other1_E03               : std_logic;
    signal Other2_E03               : std_logic;
    signal Other3_E03               : std_logic;
    signal Other4_E03               : std_logic;
    signal Other5_E03               : std_logic;

    -- Coin --	
    signal Beam_TOF                 : std_logic;
    signal Beam_Pi                  : std_logic;
    signal Beam_P                   : std_logic;
    signal Coin1                    : std_logic;
    signal Coin2                    : std_logic;
    signal For_E03                  : std_logic;
    
    -- PS --	
    signal BH2_Pi_PS                : std_logic;
--    signal Beam_PS                  : std_logic;
    signal Beam_TOF_PS              : std_logic;
    signal Beam_Pi_PS               : std_logic;
    signal Beam_P_PS                : std_logic;
    signal Coin1_PS                 : std_logic;
    signal Coin2_PS                 : std_logic;
    signal Extra_line               : std_logic;
    signal For_E03_PS               : std_logic;
    
    signal BH2_Pi_Coin1             : std_logic;
    signal SAC_or_Coin1             : std_logic;
    signal TOF_or_Coin1             : std_logic;
    signal LC_or_Coin1              : std_logic;
    signal TOF_HT_Coin1             : std_logic;
--    signal Matrix_3D_Coin1          : std_logic;
    signal Other4_Coin1             : std_logic;
    signal Other5_Coin1             : std_logic;

    signal Clock_sel                : std_logic;
    signal Reserve2_sel             : std_logic;
    
    signal PS_OR_DLY                : std_logic;
    -- Else_OR ------------------------------------------------
    signal PS_or           : std_logic;
    signal PS_Else_OR      : std_logic;
    signal K_Scat_Else_OR  : std_logic;

    signal Else_OR         : std_logic;
    signal Else_OR_DLY         : std_logic;

    -- BH2_K --------------------------------------------------
    signal BH2_DLY : std_logic_vector( 7 downto 0 );
    signal BH2_EDG : std_logic_vector( 7 downto 0 );
    signal BH2_K_Pre : std_logic_vector( 7 downto 0 );
    signal BH2_K : std_logic_vector( 7 downto 0 );
    signal BH2_K_OR : std_logic;
    signal BH2_K_OR_PS : std_logic;
    signal K_Scat_BH2_K  : std_logic;
    -- Clock --------------------------------------------------
--    signal clk1MHz   : std_logic;
--    signal clk100kHz : std_logic;
--    signal clk10kHz  : std_logic;
--    signal clk1kHz   : std_logic;

    -- Synchroniyzer ------------------------------------------------------------------------- 
    component synchronizer is
	    Port (
		 CLK 		: in STD_LOGIC;
		 DATAIN		: in STD_LOGIC;
		 SYNC_DATAOUT   : out  STD_LOGIC
	    );
    end component;

    -- Region1 -------------------------------------------------------------------------------
    component Region1 is
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

    	        -- K_Scat --         
--		K_Scat_Pre		 : in  std_logic;

    	        -- output signal --         
    	        FSD_Sel1              : out std_logic_vector(11 downto 0);
    	        FSD_Sel2              : out std_logic_vector(11 downto 0);
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
                TOF_HT_K_Scat  : out std_logic;
--                Matrix_3D_K_Scat           : out std_logic;

                K_Scat                     : out std_logic;

                Other4_K_Scat                    : out std_logic;
                Other5_K_Scat                    : out std_logic;

	        -- BPS ----------------------------------
    	        -- input signal --
            	Beam            : out std_logic;
            	Pi_Beam         : out std_logic;
            	P_Beam          : out std_logic;
          

    	        -- output signal --         
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
    end component;    

    -- Region2 -------------------------------------------------------------------------------
    -- Region2_1 -----
    component Region2_1 is
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
    end component;    

    -- Region2_2 -----
    component Region2_2 is
    	port(
    	        rst                      : in  std_logic;
    	        clk_trg                  : in  std_logic;
    	        clk_sys                  : in  std_logic;
    	        
	        -- DPWM ---------------------------------
    	        -- input signal --
    	        BH2_Pi                    : in  std_logic;
--    	        Beam                      : in  std_logic;
                SAC_or                    : in  std_logic;
                TOF_or                    : in  std_logic;
                Lucite_or                 : in  std_logic;
                TOF_High_Threshold        : in  std_logic;
--                Matrix_3D                 : in  std_logic;
                Other4                    : in  std_logic;
                Other5                    : in  std_logic;

    	        -- output signal --
	        Beam_Pi                  : out std_logic;
	
                -- Local bus --
                addrLocalBus        : in LocalAddressType;
                dataLocalBusIn      : in LocalBusInType;
                dataLocalBusOut     : out LocalBusOutType;
                reLocalBus          : in std_logic;
                weLocalBus          : in std_logic;
                readyLocalBus       : out std_logic
    	);
    end component;    

    -- Region2_3 -----
    component Region2_3 is
    	port(
    	        rst                      : in  std_logic;
    	        clk_trg                  : in  std_logic;
    	        clk_sys                  : in  std_logic;
    	        
	        -- DPWM ---------------------------------
    	        -- input signal --
    	        BH2_Pi                    : in  std_logic;
--    	        Beam                      : in  std_logic;
                SAC_or                    : in  std_logic;
                TOF_or                    : in  std_logic;
                Lucite_or                 : in  std_logic;
                TOF_High_Threshold        : in  std_logic;
--                Matrix_3D                 : in  std_logic;
                Other4                    : in  std_logic;
                Other5                    : in  std_logic;

    	        -- output signal --
	        Beam_P                   : out std_logic;
	
                -- Local bus --
                addrLocalBus        : in LocalAddressType;
                dataLocalBusIn      : in LocalBusInType;
                dataLocalBusOut     : out LocalBusOutType;
                reLocalBus          : in std_logic;
                weLocalBus          : in std_logic;
                readyLocalBus       : out std_logic
    	);
    end component;    

    -- Region2_4 -----
    component Region2_4 is
    	port(
    	        rst                      : in  std_logic;
    	        clk_trg                  : in  std_logic;
    	        clk_sys                  : in  std_logic;
    	        
	        -- DPWM ---------------------------------
    	        -- input signal --
    	        BH2_Pi                    : in  std_logic;
--    	        Beam                      : in  std_logic;
                SAC_or                    : in  std_logic;
                TOF_or                    : in  std_logic;
                Lucite_or                 : in  std_logic;
                TOF_High_Threshold        : in  std_logic;
--                Matrix_3D                 : in  std_logic;
                Other4                    : in  std_logic;
                Other5                    : in  std_logic;

    	        -- output signal --
    	        BH2_Pi_Coin1              : out std_logic;
                SAC_or_Coin1              : out std_logic;
                TOF_or_Coin1              : out std_logic;
                LC_or_Coin1               : out std_logic;
                TOF_HT_Coin1              : out std_logic;
--                Matrix_3D_Coin1           : out std_logic;
                Other4_Coin1              : out std_logic;
                Other5_Coin1              : out std_logic;

	        Coin1               : out std_logic;
	
                -- Local bus --
                addrLocalBus        : in LocalAddressType;
                dataLocalBusIn      : in LocalBusInType;
                dataLocalBusOut     : out LocalBusOutType;
                reLocalBus          : in std_logic;
                weLocalBus          : in std_logic;
                readyLocalBus       : out std_logic
    	);
    end component;    

    -- Region2_5 -----
    component Region2_5 is
    	port(
    	        rst                      : in  std_logic;
    	        clk_trg                  : in  std_logic;
    	        clk_sys                  : in  std_logic;
    	        
	        -- DPWM ---------------------------------
    	        -- input signal --
    	        BH2_Pi                    : in  std_logic;
--    	        Beam                      : in  std_logic;
                SAC_or                    : in  std_logic;
                TOF_or                    : in  std_logic;
                Lucite_or                 : in  std_logic;
                TOF_High_Threshold        : in  std_logic;
--                Matrix_3D                 : in  std_logic;
                Other4                    : in  std_logic;
                Other5                    : in  std_logic;

    	        -- output signal --
	        Coin2               : out std_logic;
	
                -- Local bus --
                addrLocalBus        : in LocalAddressType;
                dataLocalBusIn      : in LocalBusInType;
                dataLocalBusOut     : out LocalBusOutType;
                reLocalBus          : in std_logic;
                weLocalBus          : in std_logic;
                readyLocalBus       : out std_logic
    	);
    end component;    

    -- Region2_6 -----
    component Region2_6 is
    	port(
    	        rst                      : in  std_logic;
    	        clk_trg                  : in  std_logic;
    	        clk_sys                  : in  std_logic;
    	        
	        -- DPWM ---------------------------------
    	        -- input signal --
    	        BH2_Pi                    : in  std_logic;
--    	        Beam                     : in  std_logic;
                Other1                   : in  std_logic;
                Other2                   : in  std_logic;
                Other3                   : in  std_logic;
                Other4                   : in  std_logic;
                Other5                   : in  std_logic;

    	        -- output signal --
    	        BH2_Pi_E03               : out std_logic;
                Other1_E03               : out std_logic;
                Other2_E03               : out std_logic;
                Other3_E03               : out std_logic;
                Other4_E03               : out std_logic;
                Other5_E03               : out std_logic;
		For_E03                  : out std_logic;
	
                -- Local bus --
                addrLocalBus        : in LocalAddressType;
                dataLocalBusIn      : in LocalBusInType;
                dataLocalBusOut     : out LocalBusOutType;
                reLocalBus          : in std_logic;
                weLocalBus          : in std_logic;
                readyLocalBus       : out std_logic
    	);
    end component;    


    -- Region3 -------------------------------------------------------------------------------
    component Region3 is
    	port(
            	rst             : in std_logic;
            	clk_trg         : in std_logic;
            	clk_sys         : in std_logic;
            	
            	-- input signal --
    	        BH2_Pi                    : in  std_logic;
--            	Beam            : in  std_logic;
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
	        Else_OR_DLY         : out std_logic;

--    	        BH2_Pi_Pregate            : out std_logic;
--    	        BH2_Pi_leadingedge             : out std_logic;
--    	        BH2_Pi_counter0                : out std_logic;
            	-- Local bus --
            	addrLocalBus    : in LocalAddressType;
            	dataLocalBusIn  : in LocalBusInType;
            	dataLocalBusOut : out LocalBusOutType;
            	reLocalBus      : in std_logic;
            	weLocalBus      : in std_logic;
            	readyLocalBus   : out std_logic
            	);
    end component;

    -- Region4 -------------------------------------------------------------------------------
    component Region4 is
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
    end component; 

--    component ClkDivision is 
--	    port (
--	          rst          : in  std_logic;
--	          clk          : in  std_logic;
--
--	          -- module Output --
--	          clk1MHz      : out std_logic;
--	          clk100kHz    : out std_logic;
--	          clk10kHz     : out std_logic;
--	          clk1kHz      : out std_logic
--            );
--    end component;

    -- IOM --------------------------------------------------------------------------------  
        component IOManager_NIM is
            port(
                  rst                 : in std_logic;
                  clk_sys             : in std_logic;
                  
                  -- input ----------------
                  BH1_Beam                   : in  std_logic; 
                  BH2_Beam                   : in  std_logic; 
                  BH1_Pi                     : in  std_logic; 
                  BH2_Pi                     : in  std_logic; 
                  BH1_P                      : in  std_logic; 
                  BH2_P                      : in  std_logic; 
                  SAC_K_Scat                 : in  std_logic;
                  TOF_K_Scat                 : in  std_logic;
                  Lucite_K_Scat              : in  std_logic;
                  TOF_HT_K_Scat              : in  std_logic;
--                  Matrix_3D_K_Scat           : in  std_logic;
                  Other4_K_Scat              : in  std_logic;
                  Other5_K_Scat              : in  std_logic;
                  BH2_Pi_Beam_TOF            : in  std_logic; 
--                  Beam_Beam_TOF              : in  std_logic; 
                  SAC_or_Beam_TOF            : in  std_logic; 
                  TOF_or_Beam_TOF            : in  std_logic; 
                  LC_or_Beam_TOF             : in  std_logic; 
                  TOF_HT_Beam_TOF            : in  std_logic; 
--                  Matrix_3D_Beam_TOF         : in  std_logic; 
                  Other4_Beam_TOF            : in  std_logic; 
                  Other5_Beam_TOF            : in  std_logic; 
                  BH2_Pi_Coin1               : in  std_logic; 
                  SAC_or_Coin1               : in  std_logic; 
                  TOF_or_Coin1               : in  std_logic; 
                  LC_or_Coin1                : in  std_logic; 
                  TOF_HT_Coin1               : in  std_logic; 
--                  Matrix_3D_Coin1            : in  std_logic; 
                  Other4_Coin1               : in  std_logic;
                  Other5_Coin1               : in  std_logic;
                  BH2_Pi_E03                 : in  std_logic;
                  Other1_E03                 : in  std_logic;
                  Other2_E03                 : in  std_logic;
                  Other3_E03                 : in  std_logic;
                  Other4_E03                 : in  std_logic;
                  Other5_E03                 : in  std_logic;
	          PS_OR_DLY                  : in  std_logic;
                  K_Scat_Else_OR             : in  std_logic;
                  BH2_DLY                    : in  std_logic_vector( 7 downto 0 );
                  K_Scat_BH2_K               : in  std_logic;


                  -- output ----------------
                  nim_out1   : out std_logic;
                  nim_out2   : out std_logic;
                  nim_out3   : out std_logic;
                  nim_out4   : out std_logic;
                  
                  -- Local bus --
                  addrLocalBus        : in LocalAddressType;
                  dataLocalBusIn      : in LocalBusInType;
                  dataLocalBusOut     : out LocalBusOutType;
                  reLocalBus          : in std_logic;
                  weLocalBus          : in std_logic;
                  readyLocalBus       : out std_logic
            );
        end component;            
            

   -- BCT -----------------------------------------------------------------------------------
   signal addr_LocalBus			: LocalAddressType;
   signal data_LocalBusIn       : LocalBusInType;
   signal data_LocalBusOut      : DataArray;
   signal re_LocalBus           : ControlRegArray;
   signal we_LocalBus           : ControlRegArray;
   signal ready_LocalBus        : ControlRegArray;
   
   component BusController
   Port(
           rstSys           : in  std_logic;
           rstFromBus       : out  std_logic;
           reConfig         : out  std_logic;
           clk              : in  std_logic;
           -- Local Bus --
           addrLocalBus                 : out LocalAddressType;
           dataFromUserModules          : in DataArray;
           dataToUserModules            : out LocalBusInType;
           reLocalBus                   : out ControlRegArray;
           weLocalBus                   : out ControlRegArray;
           readyLocalBus                : in  ControlRegArray;
           -- RBCP --
           RBCP_ADDR                    : in std_logic_vector(31 downto 0); -- address [31:0]
           RBCP_WD                      : in std_logic_vector(7 downto 0);  -- data from host [7:0]
           RBCP_WE                      : in std_logic;                             -- RBCP write enable
           RBCP_RE                      : in std_logic;                             -- RBCP read enable
           RBCP_ACK                     : out std_logic;                             -- RBCP acknowledge
           RBCP_RD                      : out std_logic_vector(7 downto 0)     -- data to host [7:0]
           );
   end component;

   -- TSD -----------------------------------------------------------------------------------
   signal daq_data                          : std_logic_vector(7 downto 0);
   signal valid_data, empty_data, req_data   : std_logic;
   
   component TCP_sender is
       port(
           RST                     : in std_logic;
           CLK                     : in std_logic;
           
           -- data from EVB --
           rdFromEVB               : in std_logic_vector(7 downto 0);
           rvFromEVB               : in std_logic;
           emptyFromEVB            : in std_logic;
           reToEVB                 : out std_logic;
           
           -- data to SiTCP
           isActive                : in std_logic;
           afullTx                 : in std_logic;
           weTx                    : out std_logic;
           wdTx                    : out std_logic_vector(7 downto 0)
           
           );
   end component;

   -- SiTCP ---------------------------------------------------------------------------------
    signal sel_gmii_mii : std_logic;
    
    signal mdio_out, mdio_oe	: std_logic;
    signal tcp_isActive, close_req, close_act    : std_logic;
    signal reg_dummy0    : std_logic_vector(7 downto 0);
    signal reg_dummy1    : std_logic_vector(7 downto 0);
    signal reg_dummy2    : std_logic_vector(7 downto 0);
    signal reg_dummy3    : std_logic_vector(7 downto 0);
    
    signal tcp_tx_clk   : std_logic;
    signal tcp_rx_wr    : std_logic;
    signal tcp_rx_data  : std_logic_vector(7 downto 0);
    signal tcp_tx_full  : std_logic;
    signal tcp_tx_wr    : std_logic;
    signal tcp_tx_data  : std_logic_vector(7 downto 0);
    
    signal rbcp_act     : std_logic;
    signal rbcp_addr    : std_logic_vector(31 downto 0);
    signal rbcp_wd      : std_logic_vector(7 downto 0);
    signal rbcp_we      : std_logic; --: Write enable
    signal rbcp_re      : std_logic; --: Read enable
    signal rbcp_ack     : std_logic; -- : Access acknowledge
    signal rbcp_rd      : std_logic_vector(7 downto 0 ); -- : Read data[7:0]

    component WRAP_SiTCP_GMII_XC7K_32K
    port
    (
        CLK                    : in std_logic; --: System Clock >129MHz
        RST                    : in std_logic; --: System reset
    -- Configuration parameters
        FORCE_DEFAULTn         : in std_logic; --: Load default parameters
        EXT_IP_ADDR            : in std_logic_vector(31 downto 0); --: IP address[31:0]
        EXT_TCP_PORT           : in std_logic_vector(15 downto 0); --: TCP port #[15:0]
        EXT_RBCP_PORT          : in std_logic_vector(15 downto 0); --: RBCP port #[15:0]
        PHY_ADDR               : in std_logic_vector(4 downto 0);  --: PHY-device MIF address[4:0]
        MY_MAC_ADDR	           : out std_logic_vector(47 downto 0); -- My MAC adder [47:0]
    -- EEPROM
        EEPROM_CS            : out std_logic; --: Chip select
        EEPROM_SK            : out std_logic; --: Serial data clock
        EEPROM_DI            : out    std_logic; --: Serial write data
        EEPROM_DO            : in std_logic; --: Serial read data
        --    user data, intialial values are stored in the EEPROM, 0xFFFF_FC3C-3F
        USR_REG_X3C            : out    std_logic_vector(7 downto 0); --: Stored at 0xFFFF_FF3C
        USR_REG_X3D            : out    std_logic_vector(7 downto 0); --: Stored at 0xFFFF_FF3D
        USR_REG_X3E            : out    std_logic_vector(7 downto 0); --: Stored at 0xFFFF_FF3E
        USR_REG_X3F            : out    std_logic_vector(7 downto 0); --: Stored at 0xFFFF_FF3F
    -- MII interface
        GMII_RSTn             : out    std_logic; --: PHY reset
        GMII_1000M            : in std_logic;  --: GMII mode (0:MII, 1:GMII)
        -- TX
        GMII_TX_CLK           : in std_logic; -- : Tx clock
        GMII_TX_EN            : out    std_logic; --: Tx enable
        GMII_TXD              : out    std_logic_vector(7 downto 0); --: Tx data[7:0]
        GMII_TX_ER            : out    std_logic; --: TX error
        -- RX
        GMII_RX_CLK           : in std_logic; -- : Rx clock
        GMII_RX_DV            : in std_logic; -- : Rx data valid
        GMII_RXD              : in std_logic_vector(7 downto 0); -- : Rx data[7:0]
        GMII_RX_ER            : in std_logic; --: Rx error
        GMII_CRS              : in std_logic; --: Carrier sense
        GMII_COL              : in std_logic; --: Collision detected
        -- Management IF
        GMII_MDC              : out std_logic; --: Clock for MDIO
        GMII_MDIO_IN          : in std_logic; -- : Data
        GMII_MDIO_OUT         : out    std_logic; --: Data
        GMII_MDIO_OE          : out    std_logic; --: MDIO output enable
    -- User I/F
        SiTCP_RST             : out    std_logic; --: Reset for SiTCP and related circuits
        -- TCP connection control
        TCP_OPEN_REQ          : in std_logic; -- : Reserved input, shoud be 0
        TCP_OPEN_ACK          : out    std_logic; --: Acknowledge for open (=Socket busy)
        TCP_ERROR             : out    std_logic; --: TCP error, its active period is equal to MSL
        TCP_CLOSE_REQ         : out    std_logic; --: Connection close request
        TCP_CLOSE_ACK         : in std_logic ;-- : Acknowledge for closing
        -- FIFO I/F
        TCP_RX_WC             : in std_logic_vector(15 downto 0); --: Rx FIFO write count[15:0] (Unused bits should be set 1)
        TCP_RX_WR             : out    std_logic; --: Write enable
        TCP_RX_DATA           : out    std_logic_vector(7 downto 0); --: Write data[7:0]
        TCP_TX_FULL           : out    std_logic; --: Almost full flag
        TCP_TX_WR             : in std_logic; -- : Write enable
        TCP_TX_DATA           : in std_logic_vector(7 downto 0); -- : Write data[7:0]
        -- RBCP
        RBCP_ACT              : out std_logic; -- RBCP active
        RBCP_ADDR             : out    std_logic_vector(31 downto 0); --: Address[31:0]
        RBCP_WD               : out    std_logic_vector(7 downto 0); --: Data[7:0]
        RBCP_WE               : out    std_logic; --: Write enable
        RBCP_RE               : out    std_logic; --: Read enable
        RBCP_ACK              : in std_logic; -- : Access acknowledge
        RBCP_RD               : in std_logic_vector(7 downto 0 ) -- : Read data[7:0]
    );
    end component;

	component global_sitcp_manager
		port(
		RST			: in std_logic;
		CLK			: in std_logic;
		ACTIVE		: in std_logic;
		REQ			: in std_logic;
		ACT			: out std_logic;
		rstFromTcp	: out std_logic
		);
	end component;

    -- Clock ---------------------------------------------------------------------------
    signal clk_400MHz         : std_logic;
    signal clk_100MHz         : std_logic;
    signal clk_gtx            : std_logic;
    signal clk_int            : std_logic;
    signal clk_trg_locked         : std_logic;
    
    component clk_wiz_0
        port(
            clk_in1     : in  std_logic;
            clk_trg     : out std_logic;
            clk_gtx     : out std_logic;
	    clk_int     : out std_logic;
            reset       : in  std_logic;
            trg_locked      : out std_logic
        );
    end component;
    
    -- Clock ---------------------------------------------------------------------------
    signal clk_130MHz             : std_logic;
    signal clk_sys_locked         : std_logic;
    
    component clk_wiz_1
        port(
            clk_in1     : in std_logic;
            clk_sys     : out std_logic;
            reset       : in std_logic;
            sys_locked      : out std_logic
        );
    end component;
    
    -- Clock ---------------------------------------------------------------------------
--    signal clk_10MHz             : std_logic;
--    signal clk_clk_locked         : std_logic;
--    
--    component clk_wiz_2
--        port(
--            clk_in1     : in std_logic;
--            clk_clock   : out std_logic;
--            reset       : in std_logic;
--            clk_locked  : out std_logic
--        );
--    end component;
    
    -- debug -----------------------------------------------------------------------------

begin
    -- ===================================================================================
    -- body -----------------------------------------------

    -- Synchroniyzer ------------------------------------------------------------------------- 
	gen_fixed_nim : for i in 1 to 3 generate
		u_sync_nim : synchronizer 
			port map ( 
	                              CLK            => clk_400MHz,
				      DATAIN         => nim_in_Pre(i)  ,
				      SYNC_DATAOUT   => nim_in(i)
			           );
	end generate;

	gen_fixed_u1 : for i in 0 to 11 generate
		u_sync_fu1 : synchronizer 
			port map ( 
	                              CLK            => clk_400MHz,
				      DATAIN         => FSU(i)  ,
--				      DATAIN         => FIXED_SIGIN_U(i)  ,
				      SYNC_DATAOUT   => Fixed_Signal_In_Up(i)
			           );
	end generate;

	gen_fixed_u2 : for i in 16 to 20 generate
		u_sync_fu2 : synchronizer 
			port map ( 
	                              CLK            => clk_400MHz,
				      DATAIN         => FSU(i)  ,
--				      DATAIN         => FIXED_SIGIN_U(i)  ,
				      SYNC_DATAOUT   => Fixed_Signal_In_Up(i)
			           );
	end generate;

	gen_fixed_d1 : for i in 0 to 12 generate
		u_sync_fd1 : synchronizer 
			port map ( 
				      CLK            => clk_400MHz,
				      DATAIN         => FSD(i)  , 
--				      DATAIN         => FIXED_SIGIN_D(i)  , 
				      SYNC_DATAOUT   => Fixed_Signal_In_Down(i)
				   );
	end generate;

	gen_fixed_d2 : for i in 16 to 27 generate
		u_sync_fd2 : synchronizer 
			port map ( 
				      CLK            => clk_400MHz,
				      DATAIN         => FSD(i)  , 
--				      DATAIN         => FIXED_SIGIN_D(i)  , 
				      SYNC_DATAOUT   => Fixed_Signal_In_Down(i)
				   );
	end generate;

    -- Signal assain ------------------------------------------------------------------------ 
	FSU(11 downto  0)  <= Fixed_SigIn_U(11 downto  0);
	FSU(20 downto 16)  <= Fixed_SigIn_U(20 downto 16);
	FSD_sel_Pre1(11 downto 0) <= Fixed_SigIn_D(11 downto  0);
	FSD_sel_Pre2(11 downto 0) <= Fixed_SigIn_D(27 downto 16);
	FSD(11 downto  0)  <= FSD_sel1(11 downto 0);
	FSD(27 downto 16)  <= FSD_sel2(11 downto 0);
--	FSD(12)            <= Fixed_SigIn_D(12);
	FSD(29 downto 28)  <= Fixed_SigIn_D(29 downto 28);
	nim_in(4)          <= nim_in_Pre(4);
	BH1_or_Pre         <= nim_in(1);
	LC_or              <= nim_in(2);
	TOF_HT             <= nim_in(3);
	SpillGate          <= nim_in(4);

        gen_BH2 : for i in 0 to 7 generate 
           u_BH2_Fixed_Delay_Inst : FDLY
         	port map(
                    rst                        => user_reset,
                    clk_trg                    => clk_400MHz,
         	    
         	    -- input signal --
         	    in1             => Fixed_Signal_In_Up(7-i)       ,
         	    -- output signal
         	    out1            => BH2(i)
         	);
--	       BH2(i) <= Fixed_Signal_In_Up(7-i);
        end generate;

--	BH2                <= Fixed_Signal_In_Up( 7 downto  0);
	SAC                <= Fixed_Signal_In_Up(11 downto  8);
	Other              <= Fixed_Signal_In_Up(20 downto 16);
	TOF(11 downto  0)  <= Fixed_Signal_In_Down(11 downto  0);
--	TOF_HT             <= Fixed_Signal_In_Down(12);
	TOF(23 downto 12)  <= Fixed_Signal_In_Down(27 downto 16);
--	LC_or              <= Fixed_Signal_In_Down(28);
--	Clock              <= FSD(29);
--	Reserve2           <= FSD(30);
	Clock              <= FSD(28);
	Reserve2           <= FSD(29);
--	Mtx_3D             <= Fixed_Signal_In_Down(30);
	
--	PS_or_vector       <=  Pi_Beam_PS & 
--        	               P_Beam_PS  & 
--                               Pi_TOF_PS  & 
--                               P_TOF_PS   & 
--                               Pi_Scat_PS & 
--                               Pi_Pi_PS   & 
--                               P_P_PS     & 
--                               P_Scat_PS  & 
--                               Pi_P_PS    ; 
    -- Or ----------------------------------------------------------------------------------- 
--	BH1_or             <= or_reduce(BH1);
--	BH1_or_Pre(0)      <= or_reduce(BH1(  5 downto 0));
--	BH1_or_Pre(1)      <= or_reduce(BH1( 10 downto 6));
	BH1_or             <= BH1_or_Pre;   
	BH2_or             <= or_reduce(BH2);
	SAC_or             <= or_reduce(SAC);
--	TOF_or             <= or_reduce(TOF);
	TOF_or_Pre(0)      <= or_reduce(TOF( 5 downto 0) );
	TOF_or_Pre(1)      <= or_reduce(TOF(11 downto 5) );
	TOF_or_Pre(2)      <= or_reduce(TOF(17 downto 12) );
	TOF_or_Pre(3)      <= or_reduce(TOF(23 downto 18) );
	TOF_or             <= or_reduce(TOF_or_Pre);
--	Pre_TOF_or             <= or_reduce(TOF_or_Pre);
	Lucite_or          <= LC_or;
	TOF_High_Threshold <= TOF_HT;
--	Matrix_3D          <= Mtx_3D;
	Other1 <= Other(1);
	Other2 <= Other(2);
	Other3 <= Other(3);
	Other4 <= Other(4);
	Other5 <= Other(5);

        SG     <= SpillGate when( dip_sw(i_NC2.Index) ='1' ) else '1';

	
	 process(clk_400MHz)
	  begin
	  	if(clk_400MHz'event and clk_400MHz = '1') then
	  		TOF_or_R1	<= TOF_or;
	  	end if;
	  end process ;

	 process(clk_400MHz)
	  begin
	  	if(clk_400MHz'event and clk_400MHz = '1') then
	  		TOF_or_R2_1     <= TOF_or;
	  	end if;
	  end process ;

	 process(clk_400MHz)
	  begin
	  	if(clk_400MHz'event and clk_400MHz = '1') then
	  		TOF_or_R2_2     <= TOF_or;
	  	end if;
	  end process ;

	 process(clk_400MHz)
	  begin
	  	if(clk_400MHz'event and clk_400MHz = '1') then
	  		TOF_or_R2_3     <= TOF_or;
	  	end if;
	  end process ;

	 process(clk_400MHz)
	  begin
	  	if(clk_400MHz'event and clk_400MHz = '1') then
	  		TOF_or_R2_4     <= TOF_or;
	  	end if;
	  end process ;

	 process(clk_400MHz)
	  begin
	  	if(clk_400MHz'event and clk_400MHz = '1') then
	  		TOF_or_R2_5     <= TOF_or;
	  	end if;
	  end process ;

--	 process(clk_400MHz)
--	  begin
--	  	if(clk_400MHz'event and clk_400MHz = '1') then
--	  		TOF_or_IOM      <= TOF_or;
--	  	end if;
--	  end process ;

--	PS_or              <= or_reduce(PS_or_vector);
--
--        Else_OR_Pre <= PS_or and (NOT K_Scat_Else_OR);

    -- BH2_K -------------------------------------------------------------------------------- 
--       gen_BH2_K_AND : for i in 0 to 7 generate 
--	       BH2_K_Pre(i) <= BH2_DLY(i) and K_Scat;
--       end generate;

    -- OUT Signal --------------------------------------------------------------------------- 
        gen_out_Else_OR : for i in 0 to 7 generate
--		dcr_u( i ) <= Else_OR;
		dcr_u( 2*i ) <= SG AND Else_OR_DLY;
           	dcr_u( 2*i+1 ) <= SG AND BH2_K(i);
        end generate;
--	dcr_u( 15 downto  8 ) <= BH2_K;
--	dcr_u( 20 downto 16 ) <= Other;
--	dcr_u(21) <= Clock_sel         ;
--	dcr_u(22) <= Reserve2_sel      ;
	dcr_u(16) <= SG AND Else_OR          ;
	dcr_u(17) <= SG AND BH2_K_OR          ;
	dcr_u(18) <= SG AND Clock_sel         ;
	dcr_u(19) <= SG AND Reserve2_sel      ;
	dcr_u(20) <= SG AND Extra_line     ;
	dcr_u(21) <= SG AND Else_OR          ;
        gen_out_BH2_K_for_Flag : for i in 0 to 7 generate
           	dcr_u( i + 22  ) <= SG AND BH2_K(i);
        end generate;
	dcr_u(30) <= SG AND Clock_sel         ;
	dcr_u(31) <= SG AND Reserve2_sel      ;

	dcr_d( 0) <= BH1_or            ;
	dcr_d( 1) <= BH2_or            ;
	dcr_d( 2) <= SAC_or            ;
	dcr_d( 3) <= TOF_or            ;
	dcr_d( 4) <= Lucite_or         ;
	dcr_d( 5) <= TOF_High_Threshold;
--	dcr_d( 10 downto 6 ) <= SG AND Other  ;
        gen_out_Other : for i in 0 to 4 generate
           	dcr_d( i+6 ) <= Other(i+1);
        end generate;
	dcr_d(11) <= SG AND Beam              ;
	dcr_d(12) <= Pi_Beam           ;
	dcr_d(13) <= P_Beam            ;
	dcr_d(14) <= K_Scat            ;
	dcr_d(15) <= SG AND Beam_TOF          ;
	dcr_d(16) <= SG AND Beam_Pi           ;
	dcr_d(17) <= SG AND Beam_P            ;
	dcr_d(18) <= SG AND Coin1             ;
	dcr_d(19) <= SG AND Coin2             ;
	dcr_d(20) <= SG AND For_E03           ;
	dcr_d(21) <= SG AND BH2_Pi_PS         ;
	dcr_d(22) <= SG AND Beam_TOF_PS       ;
	dcr_d(23) <= SG AND Beam_Pi_PS        ;
	dcr_d(24) <= SG AND Beam_P_PS         ;
	dcr_d(25) <= SG AND Coin1_PS          ;
	dcr_d(26) <= SG AND Extra_line        ;
	dcr_d(27) <= SG AND For_E03_PS        ;
	dcr_d(28) <= SG AND BH2_K_OR_PS       ;
--	dcr_d(28) <= clk1MHz   ;
--	dcr_d(29) <= clk100kHz ;
--	dcr_d(30) <= clk10kHz  ;
--	dcr_d(31) <= clk1kHz   ;

    -- Module ------------------------------------------------------------------------------- 
    -- Region1 ------------------------------------------------------------------------------ 
    u_Region1_Inst : Region1
        port map(
            rst                        => user_reset,
            clk_trg                    => clk_400MHz,
            clk_sys                    => clk_130MHz,

    	    FSD_Sel_Pre1               => FSD_Sel_Pre1,  
    	    FSD_Sel_Pre2               => FSD_Sel_Pre2,  
	    -- DPWM ---------------------------------
            -- input signal --
            BH1_or                     => BH1_or,
            BH2_or                     => BH2_or,

            SAC_or                     => SAC_or             ,
            TOF_or                     => TOF_or_R1          ,
            Lucite_or                  => Lucite_or          ,
            TOF_High_Threshold         => TOF_High_Threshold ,
--            Matrix_3D                  => Matrix_3D          ,
	    
	    Other4                     => Other4          ,
	    Other5                     => Other5          ,

            -- output signal --
    	    FSD_Sel1               => FSD_Sel1,  
    	    FSD_Sel2               => FSD_Sel2,  
    	    -- Beam --        
            BH1_Beam                   => BH1_Beam,
            BH2_Beam                   => BH2_Beam,

    	    -- Pi_Beam --        
            BH1_Pi                     => BH1_Pi,
            BH2_Pi                     => BH2_Pi,

    	    -- P_Beam --        
            BH1_P                      => BH1_P ,
            BH2_P                      => BH2_P ,

    	    -- K_Scat --         
            SAC_K_Scat              => SAC_K_Scat              ,
            TOF_K_Scat              => TOF_K_Scat              ,
            Lucite_K_Scat           => Lucite_K_Scat           ,
            TOF_HT_K_Scat           => TOF_HT_K_Scat  ,
--            Matrix_3D_K_Scat           => Matrix_3D_K_Scat           ,

            K_Scat                     => K_Scat         ,

            Other4_K_Scat                     => Other4_K_Scat         ,
            Other5_K_Scat                     => Other5_K_Scat         ,
	    -- BPS ----------------------------------
    	    -- input signal --
    	    -- output signal --         
            Beam                       => Beam    ,
            Pi_Beam                    => Pi_Beam    ,
            P_Beam                     => P_Beam     ,

            -- K_Scat --         
            K_Scat_Pre                 => K_Scat_Pre         ,

            -- Local bus --
            addrLocalBus        => addr_LocalBus, 
            dataLocalBusIn      => data_LocalBusIn,
            dataLocalBusOut     => data_LocalBusOut(i_RGN1.ID),
            reLocalBus          => re_LocalBus(i_RGN1.ID),
            weLocalBus          => we_LocalBus(i_RGN1.ID),
            readyLocalBus       => ready_LocalBus(i_RGN1.ID)
	   );

    -- Region2 -------------------------------------------------------------------------------
    u_Region2_1_Inst : Region2_1
        port map(
            rst                        => user_reset,
            clk_trg                    => clk_400MHz,
            clk_sys                    => clk_130MHz,
            -- input signal --
    	    BH2_Pi                      => Beam                          ,
            SAC_or                      => SAC_or                        ,
            TOF_or                      => TOF_or_R2_1                   ,
            Lucite_or                   => Lucite_or                     ,
            TOF_High_Threshold          => TOF_High_Threshold            ,
--            Matrix_3D                   => Matrix_3D                     ,
            Other4                      => Other4                        ,
            Other5                      => Other5                        ,
                                                                       
    	    -- output signal --            
    	    BH2_Pi_Beam_TOF             => BH2_Pi_Beam_TOF               ,
            SAC_or_Beam_TOF             => SAC_or_Beam_TOF               ,
            TOF_or_Beam_TOF             => TOF_or_Beam_TOF               ,
            LC_or_Beam_TOF              => LC_or_Beam_TOF            ,
            TOF_HT_Beam_TOF             => TOF_HT_Beam_TOF   ,
--            Matrix_3D_Beam_TOF          => Matrix_3D_Beam_TOF            ,
            Other4_Beam_TOF             => Other4_Beam_TOF               ,
            Other5_Beam_TOF             => Other5_Beam_TOF               ,
                                                                       
	    Beam_TOF                    => Beam_TOF                     , 
	
            -- Local bus --
            addrLocalBus        => addr_LocalBus, 
            dataLocalBusIn      => data_LocalBusIn,
            dataLocalBusOut     => data_LocalBusOut(i_RGN2_1.ID),
            reLocalBus          => re_LocalBus(i_RGN2_1.ID),
            weLocalBus          => we_LocalBus(i_RGN2_1.ID),
            readyLocalBus       => ready_LocalBus(i_RGN2_1.ID)
    	);

    u_Region2_2_Inst : Region2_2
        port map(
            rst                        => user_reset,
            clk_trg                    => clk_400MHz,
            clk_sys                    => clk_130MHz,
            -- input signal --
    	    BH2_Pi                      => Beam                          ,
            SAC_or                      => SAC_or                        ,
            TOF_or                      => TOF_or_R2_2                   ,
            Lucite_or                   => Lucite_or                     ,
            TOF_High_Threshold          => TOF_High_Threshold            ,
--            Matrix_3D                   => Matrix_3D                     ,
            Other4                      => Other4                        ,
            Other5                      => Other5                        ,
                                                                       
    	    -- output signal --            
	    Beam_Pi                     => Beam_Pi                     , 
	
            -- Local bus --
            addrLocalBus        => addr_LocalBus, 
            dataLocalBusIn      => data_LocalBusIn,
            dataLocalBusOut     => data_LocalBusOut(i_RGN2_2.ID),
            reLocalBus          => re_LocalBus(i_RGN2_2.ID),
            weLocalBus          => we_LocalBus(i_RGN2_2.ID),
            readyLocalBus       => ready_LocalBus(i_RGN2_2.ID)
    	);

    u_Region2_3_Inst : Region2_3
        port map(
            rst                        => user_reset,
            clk_trg                    => clk_400MHz,
            clk_sys                    => clk_130MHz,
            -- input signal --
    	    BH2_Pi                      => Beam                          ,
            SAC_or                      => SAC_or                        ,
            TOF_or                      => TOF_or_R2_3                   ,
            Lucite_or                   => Lucite_or                     ,
            TOF_High_Threshold          => TOF_High_Threshold            ,
--            Matrix_3D                   => Matrix_3D                     ,
            Other4                      => Other4                        ,
            Other5                      => Other5                        ,
                                                                       
    	    -- output signal --            
	    Beam_P                      => Beam_P                       , 
	
            -- Local bus --
            addrLocalBus        => addr_LocalBus, 
            dataLocalBusIn      => data_LocalBusIn,
            dataLocalBusOut     => data_LocalBusOut(i_RGN2_3.ID),
            reLocalBus          => re_LocalBus(i_RGN2_3.ID),
            weLocalBus          => we_LocalBus(i_RGN2_3.ID),
            readyLocalBus       => ready_LocalBus(i_RGN2_3.ID)
    	);
        
    u_Region2_4_Inst : Region2_4
        port map(
            rst                        => user_reset,
            clk_trg                    => clk_400MHz,
            clk_sys                    => clk_130MHz,
            -- input signal --
    	    BH2_Pi                      => Beam                          ,
            SAC_or                      => SAC_or                        ,
            TOF_or                      => TOF_or_R2_4                   ,
            Lucite_or                   => Lucite_or                     ,
            TOF_High_Threshold          => TOF_High_Threshold            ,
--            Matrix_3D                   => Matrix_3D                     ,
            Other4                      => Other4                        ,
            Other5                      => Other5                        ,
                                                                       
    	    -- output signal --            
    	    BH2_Pi_Coin1                => BH2_Pi_Coin1               ,
            SAC_or_Coin1                => SAC_or_Coin1               ,
            TOF_or_Coin1                => TOF_or_Coin1               ,
            LC_or_Coin1                 => LC_or_Coin1            ,
            TOF_HT_Coin1                => TOF_HT_Coin1   ,
--            Matrix_3D_Coin1             => Matrix_3D_Coin1            ,
            Other4_Coin1                => Other4_Coin1               ,
            Other5_Coin1                => Other5_Coin1               ,

	    Coin1                  => Coin1                   , 
	
            -- Local bus --
            addrLocalBus        => addr_LocalBus, 
            dataLocalBusIn      => data_LocalBusIn,
            dataLocalBusOut     => data_LocalBusOut(i_RGN2_4.ID),
            reLocalBus          => re_LocalBus(i_RGN2_4.ID),
            weLocalBus          => we_LocalBus(i_RGN2_4.ID),
            readyLocalBus       => ready_LocalBus(i_RGN2_4.ID)
    	);
        
    u_Region2_5_Inst : Region2_5
        port map(
            rst                        => user_reset,
            clk_trg                    => clk_400MHz,
            clk_sys                    => clk_130MHz,
            -- input signal --
    	    BH2_Pi                      => Beam                          ,
            SAC_or                      => SAC_or                        ,
            TOF_or                      => TOF_or_R2_5                   ,
            Lucite_or                   => Lucite_or                     ,
            TOF_High_Threshold          => TOF_High_Threshold            ,
--            Matrix_3D                   => Matrix_3D                     ,
            Other4                      => Other4                        ,
            Other5                      => Other5                        ,
                                                                       
    	    -- output signal --            
	    Coin2                  => Coin2                   , 
	
            -- Local bus --
            addrLocalBus        => addr_LocalBus, 
            dataLocalBusIn      => data_LocalBusIn,
            dataLocalBusOut     => data_LocalBusOut(i_RGN2_5.ID),
            reLocalBus          => re_LocalBus(i_RGN2_5.ID),
            weLocalBus          => we_LocalBus(i_RGN2_5.ID),
            readyLocalBus       => ready_LocalBus(i_RGN2_5.ID)
    	);
        
    u_Region2_6_Inst : Region2_6
        port map(
            rst                        => user_reset,
            clk_trg                    => clk_400MHz,
            clk_sys                    => clk_130MHz,
            -- input signal --
    	    BH2_Pi                      => Beam                          ,
            Other1                      => Other1                        ,
            Other2                      => Other2                        ,
            Other3                      => Other3                        ,
            Other4                      => Other4                        ,
            Other5                      => Other5                        ,
                                                                       
    	    -- output signal --            
    	    BH2_Pi_E03              => BH2_Pi_E03 , 
            Other1_E03              => Other1_E03 , 
            Other2_E03              => Other2_E03 , 
            Other3_E03              => Other3_E03 , 
            Other4_E03              => Other4_E03 , 
            Other5_E03              => Other5_E03 , 
	    For_E03                 => For_E03                       ,
	
            -- Local bus --
            addrLocalBus        => addr_LocalBus, 
            dataLocalBusIn      => data_LocalBusIn,
            dataLocalBusOut     => data_LocalBusOut(i_RGN2_6.ID),
            reLocalBus          => re_LocalBus(i_RGN2_6.ID),
            weLocalBus          => we_LocalBus(i_RGN2_6.ID),
            readyLocalBus       => ready_LocalBus(i_RGN2_6.ID)
        );

    -- Region3------------------------------------------------------------------------------- 
    u_Region3_Inst : Region3
        port map(
            rst            => user_reset,
            clk_trg        => clk_400MHz,
            clk_sys        => clk_130MHz,

            -- input signal --
            BH2_Pi          => Beam       , 
            Beam_TOF        => Beam_TOF   , 
            Beam_Pi         => Beam_Pi    , 
            Beam_P          => Beam_P     , 
            Coin1           => Coin1      , 
            Coin2           => Coin2      , 

	    For_E03         => For_E03    , 
	    K_Scat_Pre      => K_Scat_Pre , 
            
            -- output signal --
            BH2_Pi_PS       => BH2_Pi_PS      , 
            Beam_TOF_PS     => Beam_TOF_PS    , 
            Beam_Pi_PS      => Beam_Pi_PS     , 
            Beam_P_PS       => Beam_P_PS      , 
            Coin1_PS        => Coin1_PS       , 
            Coin2_PS        => Coin2_PS       , 
	    Extra_line      => Extra_line      , 
	    For_E03_PS      => For_E03_PS     , 

	    PS_OR_DLY       => PS_OR_DLY      , 
	    K_Scat_Else_OR  => K_Scat_Else_OR , 
	    Else_OR         => Else_OR        , 
	    Else_OR_DLY         => Else_OR_DLY        , 

--            BH2_Pi_Pregate          => Beam_Pregate       , 
--            BH2_Pi_leadingedge          => Beam_leadingedge       , 
--            BH2_Pi_counter0             => Beam_counter0          , 
            -- Local bus --
            addrLocalBus        => addr_LocalBus, 
            dataLocalBusIn      => data_LocalBusIn,
            dataLocalBusOut     => data_LocalBusOut(i_RGN3.ID),
            reLocalBus          => re_LocalBus(i_RGN3.ID),
            weLocalBus          => we_LocalBus(i_RGN3.ID),
            readyLocalBus       => ready_LocalBus(i_RGN3.ID)
        );

    -- Region4------------------------------------------------------------------------------- 
    u_Region4_Inst : Region4
        port map(
            rst            => user_reset,
            clk_trg        => clk_400MHz,
            clk_sys        => clk_130MHz,

            -- input signal --
            BH2            => BH2        , 
            K_Scat         => K_Scat     , 
	    Clock          => Clock      ,
	    Reserve2       => Reserve2   ,

            
            -- output signal --
            BH2_DLY        => BH2_DLY    ,    
            BH2_K          => BH2_K      ,    
            BH2_K_OR       => BH2_K_OR   ,    
            BH2_K_OR_PS    => BH2_K_OR_PS,    
	    Clock_sel      => Clock_sel  ,
	    Reserve2_sel   => Reserve2_sel,

            -- Local bus --
            addrLocalBus        => addr_LocalBus, 
            dataLocalBusIn      => data_LocalBusIn,
            dataLocalBusOut     => data_LocalBusOut(i_RGN4.ID),
            reLocalBus          => re_LocalBus(i_RGN4.ID),
            weLocalBus          => we_LocalBus(i_RGN4.ID),
            readyLocalBus       => ready_LocalBus(i_RGN4.ID)
        );

--    -- Clk Division -----------------------------------------------------------------------  
--    u_Clock_Inst : ClkDivision 
--	    port map(
--	          rst      => user_reset,
--	          clk      => clk_10MHz,
--
--	          -- module Output --
--	          clk1MHz    => clk1MHz   , 
--	          clk100kHz  => clk100kHz , 
--	          clk10kHz   => clk10kHz  , 
--	          clk1kHz    => clk1kHz    
--            );

    -- IOM --------------------------------------------------------------------------------  
    u_IOM_NIM_Inst : IOManager_NIM 
            port map(
                  rst        => user_reset,
                  clk_sys        => clk_130MHz,
                  
                  -- input ----------------
                   BH1_Beam                 => BH1_Beam                , 
                   BH2_Beam                 => BH2_Beam                , 
                   BH1_Pi                   => BH1_Pi                  , 
                   BH2_Pi                   => BH2_Pi                  , 
                   BH1_P                    => BH1_P                   , 
                   BH2_P                    => BH2_P                   , 
                   SAC_K_Scat               => SAC_K_Scat              , 
                   TOF_K_Scat               => TOF_K_Scat              , 
                   Lucite_K_Scat            => Lucite_K_Scat           , 
                   TOF_HT_K_Scat            => TOF_HT_K_Scat           , 
--                   Matrix_3D_K_Scat         => Matrix_3D_K_Scat        , 
                   Other4_K_Scat            => Other4_K_Scat           , 
                   Other5_K_Scat            => Other5_K_Scat           , 
                   BH2_Pi_Beam_TOF          => BH2_Pi_Beam_TOF         , 
                   SAC_or_Beam_TOF          => SAC_or_Beam_TOF         , 
                   TOF_or_Beam_TOF          => TOF_or_Beam_TOF         , 
                   LC_or_Beam_TOF           => LC_or_Beam_TOF          , 
                   TOF_HT_Beam_TOF          => TOF_HT_Beam_TOF         , 
--                   Matrix_3D_Beam_TOF       => Matrix_3D_Beam_TOF      , 
                   Other4_Beam_TOF          => Other4_Beam_TOF         , 
                   Other5_Beam_TOF          => Other5_Beam_TOF         , 
                   BH2_Pi_Coin1             => BH2_Pi_Coin1            , 
                   SAC_or_Coin1             => SAC_or_Coin1            , 
                   TOF_or_Coin1             => TOF_or_Coin1            , 
                   LC_or_Coin1              => LC_or_Coin1             , 
                   TOF_HT_Coin1             => TOF_HT_Coin1            , 
--                   Matrix_3D_Coin1          => Matrix_3D_Coin1         , 
                   Other4_Coin1             => Other4_Coin1            , 
                   Other5_Coin1             => Other5_Coin1            , 
                   BH2_Pi_E03               => BH2_Pi_E03              , 
                   Other1_E03               => Other1_E03              ,   
                   Other2_E03               => Other2_E03              ,   
                   Other3_E03               => Other3_E03              , 
                   Other4_E03               => Other4_E03              , 
                   Other5_E03               => Other5_E03              , 
                   PS_OR_DLY                => PS_OR_DLY               , 
                   K_Scat_Else_OR           => K_Scat_Else_OR          , 
                   BH2_DLY                  => BH2_DLY                 , 
                   K_Scat_BH2_K             => K_Scat          , 


                  -- output ----------------
                  nim_out1   => nim_out(1),
                  nim_out2   => nim_out(2),
                  nim_out3   => nim_out(3),
                  nim_out4   => nim_out(4),
                  
                  -- Local bus --
                  addrLocalBus        => addr_LocalBus, 
                  dataLocalBusIn      => data_LocalBusIn,
                  dataLocalBusOut     => data_LocalBusOut(i_IOM.ID),
                  reLocalBus          => re_LocalBus(i_IOM.ID),
                  weLocalBus          => we_LocalBus(i_IOM.ID),
                  readyLocalBus       => ready_LocalBus(i_IOM.ID)
            );

    -- ===================================================================================

    -- Global ----------------------------------------------------------------------------
--    system_reset    <= NOT clk_locked;
--    user_reset      <= (NOT clk_locked) OR rst_from_bus;
    system_reset    <= (NOT clk_trg_locked) OR (Not clk_sys_locked);
    user_reset      <= ( (NOT clk_trg_locked) OR (Not clk_sys_locked) ) OR rst_from_bus;
    
    dip_sw(0)   <= NOT DIP(0);
    dip_sw(1)   <= NOT DIP(1);
    dip_sw(2)   <= NOT DIP(2);
    dip_sw(3)   <= NOT DIP(3);
    dip_sw(4)   <= NOT DIP(4);
    dip_sw(5)   <= NOT DIP(5);
    dip_sw(6)   <= NOT DIP(6);
    dip_sw(7)   <= NOT DIP(7);

   -- NIMIN -------------------------------------------------------------------------------
    nim_in_Pre   <=  NIMIN;
    
   -- NIMOUT -------------------------------------------------------------------------------
--    NIMOUT(1)   <= or_reduce(FIXED_SIGIN_U) OR reg_nimout(0);
--    NIMOUT(2)   <= or_reduce(FIXED_SIGIN_D);
--    NIMOUT(3)   <= or_reduce(dcr_u);
--    NIMOUT(4)   <= or_reduce(dcr_d);

--    NIMOUT(1)   <= or_reduce(FIXED_SIGIN_U) OR ( NOT reg_nimout(0) ) OR NIM_OUT1;
--    NIMOUT(2)   <= or_reduce(FIXED_SIGIN_D) OR ( NOT reg_nimout(1) );
--    NIMOUT(3)   <= or_reduce(dcr_u) OR ( NOT reg_nimout(2));
--    NIMOUT(4)   <= or_reduce(dcr_d) OR ( NOT reg_nimout(3));

--    NIMOUT(1)   <=  reg_nimout(0) or nim_out(1);
--    NIMOUT(2)   <=  reg_nimout(1) or nim_out(2);
--    NIMOUT(3)   <=  reg_nimout(2) or nim_out(3);
--    NIMOUT(4)   <=  reg_nimout(3) or nim_out(4);

    NIMOUT(1)   <=  nim_out(1);
    NIMOUT(2)   <=  nim_out(2);
    NIMOUT(3)   <=  nim_out(3);
    NIMOUT(4)   <=  nim_out(4);
    
    LED <= (dip_sw(i_LED4.Index) OR reg_led(3)) & (dip_sw(i_LED3.Index) OR reg_led(2)) & (dip_sw(i_LED2.Index) OR reg_led(1)) & (dip_sw(i_LED1.Index) OR reg_led(0));
    
    J0DC(1) <= '1';
    J0DC(2) <= '1';
    
    -- Fixed input ports -----------------------------------------------------------------

   
    -- Mezzanine connectors In--------------------------------------------------------------
--    gen_mzn_sig : for i in 0 to 31 generate

--        MZNU_BUFDS_Inst : IBUFDS
--        generic map (DIFF_TERM => TRUE, IBUF_LOW_PWR => TRUE, IOSTANDARD => "LVDS")
--        port map (O  => mzn_u(i), I  => MZN_SIG_Up(i), IB => MZN_SIG_Un(i));
        
--        MZND_BUFDS_Inst : IBUFDS
--        generic map (DIFF_TERM => TRUE, IBUF_LOW_PWR => TRUE, IOSTANDARD => "LVDS")
--        port map (O  => mzn_d(i), I  => MZN_SIG_Dp(i), IB => MZN_SIG_Dn(i));
      
--    end generate;

--    u_DCR_NetAssign : DCR_NetAssign
--    port map(
--        mzn_in_u  => mzn_u,
--        mzn_in_d  => mzn_d,
--        dcr_out_u => dcr_u,
--        dcr_out_d => dcr_d
--    );

    -- Mezzanine connectors Out--------------------------------------------------------------
    gen_mzn_sig : for i in 0 to 31 generate

      MZNU_BUFDS_Inst_Out : OBUFDS
        generic map ( IOSTANDARD => "LVDS", SLEW => "SLOW")       
        port map (
           O => MZN_SIG_Up(i),   
           OB => MZN_SIG_Un(i),  
           I => mzn_u(i)       
        );

      MZND_BUFDS_Inst_Out : OBUFDS
        generic map ( IOSTANDARD => "LVDS", SLEW => "SLOW")      
        port map (
           O => MZN_SIG_Dp(i),  
           OB => MZN_SIG_Dn(i), 
           I => mzn_d(i)      
        );
    end generate;

    u_DCR_NetAssign_Out : DCR_NetAssign_Out
        port map(
            mzn_out_u  => mzn_u,
            mzn_out_d  => mzn_d,
            dcr_in_u => dcr_u,
            dcr_in_d => dcr_d
        );


    -- LED -------------------------------------------------------------------------------
    u_LED_Inst : LED_Module
        port map(
            rst    => user_reset,
            clk    => clk_130MHz,
            -- Module output --
            outLED              => reg_led,
            -- Local bus --
            addrLocalBus        => addr_LocalBus, 
            dataLocalBusIn      => data_LocalBusIn,
            dataLocalBusOut     => data_LocalBusOut(i_LED.ID),
            reLocalBus          => re_LocalBus(i_LED.ID),
            weLocalBus          => we_LocalBus(i_LED.ID),
            readyLocalBus       => ready_LocalBus(i_LED.ID)
        );



    -- BCT -------------------------------------------------------------------------------
    u_BCT_Inst : BusController
    port map(
        rstSys                      => system_reset,
        rstFromBus                  => rst_from_bus,
        reConfig                    => PROG_B_ON,
--        clk                         => clk_200MHz,
        clk                         => clk_130MHz,
        -- Local Bus --
        addrLocalBus                => addr_LocalBus,
        dataFromUserModules         => data_LocalBusOut,
        dataToUserModules           => data_LocalBusIn,
        reLocalBus                  => re_LocalBus,
        weLocalBus                  => we_LocalBus,
        readyLocalBus               => ready_LocalBus,
        -- RBCP --
        RBCP_ADDR                   => rbcp_addr,
        RBCP_WD                     => rbcp_wd,
        RBCP_WE                     => rbcp_we,
        RBCP_RE                     => rbcp_re,
        RBCP_ACK                    => rbcp_ack,
        RBCP_RD                     => rbcp_rd
    );
    
    -- TSD -------------------------------------------------------------------------------
    u_TSD_Inst : TCP_sender
    port map(
        RST                      => user_reset,
--        CLK                      => clk_200MHz,
        CLK                      => clk_130MHz,
         
        -- data from EVB --
        rdFromEVB                => X"00",
        rvFromEVB                => '0',
        emptyFromEVB             => '1',
        reToEVB                  => open,
           
        -- data to SiTCP
        isActive                 => tcp_isActive,
        afullTx                  => tcp_tx_full,
        weTx                     => tcp_tx_wr,
        wdTx                     => tcp_tx_data
    );


    -- SiTCP Inst ------------------------------------------------------------------------
    sitcp_reset     <= system_reset OR (NOT USER_RST_B);
   	PHY_MDIO        <= mdio_out when(mdio_oe = '1') else 'Z';
   	sel_gmii_mii    <= '1';
   	tcp_tx_clk      <= clk_gtx when(sel_gmii_mii = '1') else PHY_TX_CLK;
   	PHY_GTX_CLK     <= clk_gtx;
   	PHY_HPD         <= '0';

    u_SiTCP_Inst : WRAP_SiTCP_GMII_XC7K_32K
    port map
    (
--        CLK                    => clk_200MHz, --: System Clock >129MHz
        CLK                    => clk_130MHz, --: System Clock >129MHz
        RST                    => sitcp_reset, --: System reset
    -- Configuration parameters
        FORCE_DEFAULTn         => DIP(i_SiTCP.Index), --: Load default parameters
        EXT_IP_ADDR            => X"00000000", --: IP address[31:0]
        EXT_TCP_PORT           => X"0000", --: TCP port #[15:0]
        EXT_RBCP_PORT          => X"0000", --: RBCP port #[15:0]
        PHY_ADDR               => "00000", --: PHY-device MIF address[4:0]
        MY_MAC_ADDR	           => open,
    -- EEPROM
        EEPROM_CS            => PROM_CS, --: Chip select
        EEPROM_SK            => PROM_SK, --: Serial data clock
        EEPROM_DI            => PROM_DI, --: Serial write data
        EEPROM_DO            => PROM_DO, --: Serial read data
        --    user data, intialial values are stored in the EEPROM, 0xFFFF_FC3C-3F
        USR_REG_X3C            => reg_dummy0, --: Stored at 0xFFFF_FF3C
        USR_REG_X3D            => reg_dummy1, --: Stored at 0xFFFF_FF3D
        USR_REG_X3E            => reg_dummy2, --: Stored at 0xFFFF_FF3E
        USR_REG_X3F            => reg_dummy3, --: Stored at 0xFFFF_FF3F
    -- MII interface
        GMII_RSTn             => PHY_nRST, --: PHY reset
        GMII_1000M            => sel_gmii_mii,  --: GMII mode (0:MII, 1:GMII)
        -- TX
        GMII_TX_CLK           => tcp_tx_clk, -- : Tx clock
        GMII_TX_EN            => PHY_TXEN, --: Tx enable
        GMII_TXD              => PHY_TXD, --: Tx data[7:0]
        GMII_TX_ER            => PHY_TXER, --: TX error
        -- RX
        GMII_RX_CLK           => PHY_RX_CLK, -- : Rx clock
        GMII_RX_DV            => PHY_RXDV, -- : Rx data valid
        GMII_RXD              => PHY_RXD, -- : Rx data[7:0]
        GMII_RX_ER            => PHY_RXER, --: Rx error
        GMII_CRS              => PHY_CRS, --: Carrier sense
        GMII_COL              => PHY_COL, --: Collision detected
        -- Management IF
        GMII_MDC              => PHY_MDC, --: Clock for MDIO
        GMII_MDIO_IN          => PHY_MDIO, -- : Data
        GMII_MDIO_OUT         => mdio_out, --: Data
        GMII_MDIO_OE          => mdio_oe, --: MDIO output enable
    -- User I/F
        SiTCP_RST             => open, --: Reset for SiTCP and related circuits
        -- TCP connection control
        TCP_OPEN_REQ          => '0', -- : Reserved input, shoud be 0
        TCP_OPEN_ACK          => tcp_isActive, --: Acknowledge for open (=Socket busy)
    --    TCP_ERROR           : out    std_logic; --: TCP error, its active period is equal to MSL
        TCP_CLOSE_REQ         => close_req, --: Connection close request
        TCP_CLOSE_ACK         => close_act, -- : Acknowledge for closing
        -- FIFO I/F
        TCP_RX_WC             => X"0000",    --: Rx FIFO write count[15:0] (Unused bits should be set 1)
        TCP_RX_WR             => open, --: Read enable
        TCP_RX_DATA           => open, --: Read data[7:0]
        TCP_TX_FULL           => tcp_tx_full, --: Almost full flag
        TCP_TX_WR             => tcp_tx_wr, -- : Write enable
        TCP_TX_DATA           => tcp_tx_data, -- : Write data[7:0]
        -- RBCP
        RBCP_ACT              => open, --: RBCP active
        RBCP_ADDR             => rbcp_addr, --: Address[31:0]
        RBCP_WD               => rbcp_wd, --: Data[7:0]
        RBCP_WE               => rbcp_we, --: Write enable
        RBCP_RE               => rbcp_re, --: Read enable
        RBCP_ACK              => rbcp_ack, -- : Access acknowledge
        RBCP_RD               => rbcp_rd -- : Read data[7:0]
    );

    u_gTCP_inst : global_sitcp_manager
    port map(
        RST           => system_reset,
--        CLK           => clk_200MHz,
        CLK           => clk_130MHz,
        ACTIVE        => tcp_isActive,
        REQ           => close_req,
        ACT           => close_act,
        rstFromTCP    => open
    );

    -- Clock inst Trigger ---------------------------------------------------------------
    u_ClkMan_Trg_Inst   : clk_wiz_0
        port map(
            clk_in1     => CLKOSC,
            clk_trg     => clk_400MHz,
            clk_gtx     => clk_gtx,
            clk_int     => clk_100MHz,
            reset       => '0',
            trg_locked  => clk_trg_locked
        );         

    -- Clock inst System -----------------------------------------------------------------
    u_ClkMan_Sys_Inst   : clk_wiz_1
        port map(
            clk_in1     => clk_100MHz,
            clk_sys     => clk_130MHz,
            reset       => '0',
            sys_locked  => clk_sys_locked
        );         

--    -- Clock inst Clock ------------------------------------------------------------------
--    u_ClkMan_Clk_Inst   : clk_wiz_2
--        port map(
--            clk_in1     => clk_100MHz,
--            clk_clock   => clk_10MHz,
--            reset       => '0',
--            clk_locked  => clk_clk_locked
--        );         

end Behavioral;
