library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

package AddressMap is

	constant CurrentVersion : std_logic_vector(31 downto 0) := x"00000100";
	
	constant NofInput      : natural := 32;

	constant NofModules : natural := 11;
	
	subtype LocalAddressType is std_logic_vector(11 downto 0);
	subtype LocalBusInType   is std_logic_vector(23 downto 0);
	subtype LocalBusOutType  is std_logic_vector(7 downto 0);

	-- Module ID Map
	-- <Module ID : 31-28> + <Local Address 27 - 16>
	-- mid_MTM:		0000
	-- mid_DCT:		0001
	-- mid_IOM:		0010
	-- mid_BCT:		1110
	-- SiTCP:		1111 (Reserved)

	-- Module ID Map -----------------------------------------------------------
	constant mid_LED 		: std_logic_vector(3 downto 0) := "0000";
	constant mid_RGN1               : std_logic_vector(3 downto 0) := "0001";
	constant mid_RGN2_1             : std_logic_vector(3 downto 0) := "0010";
	constant mid_RGN2_2             : std_logic_vector(3 downto 0) := "0011";
	constant mid_RGN2_3             : std_logic_vector(3 downto 0) := "0100";
	constant mid_RGN2_4             : std_logic_vector(3 downto 0) := "0101";
	constant mid_RGN2_5             : std_logic_vector(3 downto 0) := "0110";
	constant mid_RGN2_6             : std_logic_vector(3 downto 0) := "0111";
	constant mid_RGN3               : std_logic_vector(3 downto 0) := "1000";
	constant mid_RGN4               : std_logic_vector(3 downto 0) := "1001";

	constant mid_IOM                : std_logic_vector(3 downto 0) := "1010";
	   
	constant mid_BCT	 	: std_logic_vector(3 downto 0) := "1110";
	
	-- Local Address Map -------------------------------------------------------
	-- Module LED -- 
	constant LED_sel_led	    : LocalAddressType := x"000"; -- W/R, [3:0], select LED
   	
   	-- Module RGN1 ------------------------------------------------------------------------ 
        constant SEL_TOF               : localaddresstype := x"000"; --w/r, [23:0], select TOF SEG
        -- DPWM ------
        -- Beam --
        constant DLY_BH1_Beam_sel      : localaddresstype := x"a00"; -- w/r, [4:0], select  delay
        constant DLY_BH2_Beam_sel      : localaddresstype := x"a10"; -- w/r, [4:0], select  delay
        constant DLY_BH1_Pi_sel        : localaddresstype := x"a20"; -- w/r, [4:0], select  delay
        constant DLY_BH2_Pi_sel        : localaddresstype := x"a30"; -- w/r, [4:0], select  delay
        constant DLY_BH1_P_sel         : localaddresstype := x"a40"; -- w/r, [4:0], select  delay
        constant DLY_BH2_P_sel         : localaddresstype := x"a50"; -- w/r, [4:0], select  delay
        -- K_Scat --
        constant DLY_SAC_K_Scat_sel    : localaddresstype := x"a60"; -- w/r, [4:0], select  delay
        constant DLY_TOF_K_Scat_sel    : localaddresstype := x"a70"; -- w/r, [4:0], select  delay
        constant DLY_Lucite_K_Scat_sel : localaddresstype := x"a80"; -- w/r, [4:0], select  delay
        constant DLY_TOF_HT_K_Scat_sel : localaddresstype := x"a90"; -- w/r, [4:0], select  delay
--        constant DLY_3DMtx_K_Scat_sel  : localaddresstype := x"a80"; -- w/r, [4:0], select  delay
        -- Other --
        constant DLY_Other4_Scat       : localaddresstype := x"aa0"; -- w/r, [4:0], select  delay
        constant DLY_Other5_Scat       : localaddresstype := x"ab0"; -- w/r, [4:0], select  delay
        -- K_Scat_Pre --
        constant DLY_K_Scat_Pre_sel    : localaddresstype := x"ac0"; -- w/r, [4:0], select  delay
        -- Other --
        
        -- Beam --
        constant PWM_BH1_Beam_sel      : localaddresstype := x"b00"; -- w/r, [4:0], select  width
        constant PWM_BH2_Beam_sel      : localaddresstype := x"b10"; -- w/r, [4:0], select  width
        constant PWM_BH1_Pi_sel        : localaddresstype := x"b20"; -- w/r, [4:0], select  width
        constant PWM_BH2_Pi_sel        : localaddresstype := x"b30"; -- w/r, [4:0], select  width
        constant PWM_BH1_P_sel         : localaddresstype := x"b40"; -- w/r, [4:0], select  width
        constant PWM_BH2_P_sel         : localaddresstype := x"b50"; -- w/r, [4:0], select  width
        -- K_Scat --                                             
        constant PWM_SAC_K_Scat_sel    : localaddresstype := x"b60"; -- w/r, [4:0], select  width
        constant PWM_TOF_K_Scat_sel    : localaddresstype := x"b70"; -- w/r, [4:0], select  width
        constant PWM_Lucite_K_Scat_sel : localaddresstype := x"b80"; -- w/r, [4:0], select  width
        constant PWM_TOF_HT_K_Scat_sel : localaddresstype := x"b90"; -- w/r, [4:0], select  width
--        constant PWM_3DMtx_K_Scat_sel  : localaddresstype := x"b80"; -- w/r, [4:0], select  width
        -- Other --                                              
        constant PWM_Other4_Scat       : localaddresstype := x"ba0"; -- w/r, [4:0], select  width
        constant PWM_Other5_Scat       : localaddresstype := x"bb0"; -- w/r, [4:0], select  width
        -- K_Scat_Pre --                                         
        constant PWM_K_Scat_Pre_sel    : localaddresstype := x"bc0"; -- w/r, [4:0], select  width
        
        -- BPS -------
        constant BPS_ctrl_Beam         : LocalAddressType := x"c00"; -- W/R, [1:0], select sig
        constant BPS_coin_Beam         : LocalAddressType := x"c10"; -- W/R, [1:0], select sig 
--        constant BPS_ctrl_Pi           : LocalAddressType := x"c00"; -- W/R, [1:0], select sig
--        constant BPS_coin_Pi           : LocalAddressType := x"c10"; -- W/R, [1:0], select sig 
--        constant BPS_ctrl_P            : LocalAddressType := x"c20"; -- W/R, [1:0], select sig
--        constant BPS_coin_P            : LocalAddressType := x"c30"; -- W/R, [1:0], select sig 
        
        constant BPS_ctrl_K_Scat       : LocalAddressType := x"c20"; -- W/R, [5:0], select sig
        constant BPS_coin_K_Scat       : LocalAddressType := x"c30"; -- W/R, [5:0], select sig 
          


   	-- Module RGN2_1~5 ---------------------------------------------------------------------- 
          constant DLY_BH2_Pi          : localaddresstype := x"a00"; -- w/r, [4:0], select  delay
          constant DLY_SAC_or          : localaddresstype := x"a10"; -- w/r, [4:0], select  delay
          constant DLY_TOF_or          : localaddresstype := x"a20"; -- w/r, [4:0], select  delay
          constant DLY_LC_or           : localaddresstype := x"a30"; -- w/r, [4:0], select  delay
          constant DLY_TOF_HT          : localaddresstype := x"a40"; -- w/r, [4:0], select  delay
--          constant DLY_Matrix_3D       : localaddresstype := x"a50"; -- w/r, [4:0], select  delay
          constant DLY_Other4          : localaddresstype := x"a50"; -- w/r, [4:0], select  delay
          constant DLY_Other5          : localaddresstype := x"a60"; -- w/r, [4:0], select  delay

          constant PWM_BH2_Pi          : localaddresstype := x"b00"; -- w/r, [4:0], select  delay
          constant PWM_SAC_or          : localaddresstype := x"b10"; -- w/r, [4:0], select  delay
          constant PWM_TOF_or          : localaddresstype := x"b20"; -- w/r, [4:0], select  delay
          constant PWM_LC_or           : localaddresstype := x"b30"; -- w/r, [4:0], select  delay
          constant PWM_TOF_HT          : localaddresstype := x"b40"; -- w/r, [4:0], select  delay
--          constant PWM_Matrix_3D       : localaddresstype := x"b50"; -- w/r, [4:0], select  delay
          constant PWM_Other4          : localaddresstype := x"b50"; -- w/r, [4:0], select  delay
          constant PWM_Other5          : localaddresstype := x"b60"; -- w/r, [4:0], select  delay

          constant BPS_ctrl_7          : LocalAddressType := x"c00"; -- W/R, [6:0], select sig
          constant BPS_coin_7          : LocalAddressType := x"c10"; -- W/R, [6:0], select sig 

   	-- Module RGN2_6 ---------------------------------------------------------------------- 
          constant DLY_BH2_Pi_E03      : localaddresstype := x"a00"; -- w/r, [4:0], select  delay
          constant DLY_Other1_E03      : localaddresstype := x"a10"; -- w/r, [4:0], select  delay
          constant DLY_Other2_E03      : localaddresstype := x"a20"; -- w/r, [4:0], select  delay
          constant DLY_Other3_E03      : localaddresstype := x"a30"; -- w/r, [4:0], select  delay
          constant DLY_Other4_E03      : localaddresstype := x"a40"; -- w/r, [4:0], select  delay
          constant DLY_Other5_E03      : localaddresstype := x"a50"; -- w/r, [4:0], select  delay
                                 
          constant PWM_BH2_Pi_E03      : localaddresstype := x"b00"; -- w/r, [4:0], select  delay
          constant PWM_Other1_E03      : localaddresstype := x"b10"; -- w/r, [4:0], select  delay
          constant PWM_Other2_E03      : localaddresstype := x"b20"; -- w/r, [4:0], select  delay
          constant PWM_Other3_E03      : localaddresstype := x"b30"; -- w/r, [4:0], select  delay
          constant PWM_Other4_E03      : localaddresstype := x"b40"; -- w/r, [4:0], select  delay
          constant PWM_Other5_E03      : localaddresstype := x"b50"; -- w/r, [4:0], select  delay
  
          constant BPS_ctrl_6          : LocalAddressType := x"c00"; -- W/R, [7:0], select sig
          constant BPS_coin_6          : LocalAddressType := x"c10"; -- W/R, [7:0], select sig 
  
   	-- Module RGN3 ---------------------------------------------------------------------- 
          constant  PS_BH2_Pi           : localaddresstype := x"d00"; -- w/r, [3:0], 
          constant  PS_Beam_TOF         : localaddresstype := x"d10"; -- w/r, [3:0], 
          constant  PS_Beam_Pi          : localaddresstype := x"d20"; -- w/r, [3:0], 
          constant  PS_Beam_P           : localaddresstype := x"d30"; -- w/r, [3:0], 
          constant  PS_Coin1            : localaddresstype := x"d40"; -- w/r, [3:0], 
          constant  PS_Coin2            : localaddresstype := x"d50"; -- w/r, [3:0], 
          constant  PS_For_E03          : localaddresstype := x"d60"; -- w/r, [3:0], 

--          constant  PWM_BH2_Pi          : localaddresstype := x"b00"; -- w/r, [3:0], 
--          constant  PWM_Beam_TOF        : localaddresstype := x"b10"; -- w/r, [3:0], 
--          constant  PWM_Beam_Pi         : localaddresstype := x"b20"; -- w/r, [3:0], 
--          constant  PWM_Beam_P          : localaddresstype := x"b30"; -- w/r, [3:0], 
--          constant  PWM_Coin1           : localaddresstype := x"b40"; -- w/r, [3:0], 
--          constant  PWM_Coin2           : localaddresstype := x"b50"; -- w/r, [3:0], 
--          constant  PWM_For_E03         : localaddresstype := x"b60"; -- w/r, [3:0], 
  
          constant  DLY_PS_OR           : localaddresstype := x"a00"; -- w/r, [4:0], 
          constant  DLY_Else_OR         : localaddresstype := x"a10"; -- w/r, [4:0], 
  
          constant  DPWM_delay_Else_OR   : localaddresstype := x"aa0"; -- w/r, [4:0], 
          constant  DPWM_delay_K_Scat    : localaddresstype := x"ab0"; -- w/r, [4:0], 
          constant  DPWM_counter_Else_OR : localaddresstype := x"ba0"; -- w/r, [4:0], 
          constant  DPWM_counter_K_Scat  : localaddresstype := x"bb0"; -- w/r, [4:0], 
  
          constant  SEL_ctrl            : localaddresstype := x"e00"; -- w/r, [6:0], 
          constant  RST_PSCNT           : localaddresstype := x"e10"; -- w/r, [0], 
	
   	-- Module RGN4 ---------------------------------------------------------------------- 
          constant  DLY_BH2            : localaddresstype := x"aa0"; -- w/r, [4:0], 
          constant  DPWM_delay_BH2_K   : localaddresstype := x"a00"; -- w/r, [4:0], 
          constant  DPWM_counter_BH2_K : localaddresstype := x"b00"; -- w/r, [4:0], 
          constant  SEL_8              : localaddresstype := x"e00"; -- w/r, [7:0], 
          constant  SEL_clk            : localaddresstype := x"e10"; -- w/r, [0], 
          constant  SEL_rsv2           : localaddresstype := x"e20"; -- w/r, [0], 

       	-- Module IOM  -- 
        constant IOM_nim1            : LocalAddressType := x"010"; -- W/R, [3:0],mzn_u select sig 
        constant IOM_nim2            : LocalAddressType := x"020"; -- W/R, [3:0],mzn_u select sig 
        constant IOM_nim3            : LocalAddressType := x"030"; -- W/R, [3:0],mzn_u select sig 
        constant IOM_nim4            : LocalAddressType := x"040"; -- W/R, [3:0],mzn_u select sig 
    
	-- BusController --
	constant BCT_Reset   		: LocalAddressType := x"000"; -- W
	constant BCT_Version 		: LocalAddressType := x"010"; -- R, [7:0] 4 byte (0x010,011,012,013);
	constant BCT_ReConfig  		: LocalAddressType := x"020"; -- W, Reconfig FPGA by SPI
	
end package AddressMap;

library ieee, mylib;    
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;

package AddressBook is

	subtype ModuleID is integer range -1 to NofModules-1;
	type Leaf is record
		ID : ModuleID;
	end record;

	type Binder is array (integer range <>) of Leaf;
	constant i_LED		: Leaf := (ID => 0);
	constant i_RGN1 	: Leaf := (ID => 1);
	constant i_RGN2_1       : Leaf := (ID => 2);
	constant i_RGN2_2       : Leaf := (ID => 3);
	constant i_RGN2_3       : Leaf := (ID => 4);
	constant i_RGN2_4       : Leaf := (ID => 5);
	constant i_RGN2_5       : Leaf := (ID => 6);
	constant i_RGN2_6  	: Leaf := (ID => 7);
	constant i_RGN3  	: Leaf := (ID => 8);
	constant i_RGN4  	: Leaf := (ID => 9);
	constant i_IOM		: Leaf := (ID =>10);
	constant i_Dummy	: Leaf := (ID => -1);

	constant AddressBook : Binder(NofModules-1 downto 0) :=
		(10=>i_IOM   ,
		  9=>i_RGN4  ,
		  8=>i_RGN3  ,
		  7=>i_RGN2_6,
		  6=>i_RGN2_5,
		  5=>i_RGN2_4,
		  4=>i_RGN2_3,
		  3=>i_RGN2_2,
		  2=>i_RGN2_1,
		  1=>i_RGN1  ,
		  0=>i_LED   ,
		  others=>i_Dummy 
	        );

end package AddressBook;

library ieee, mylib;    
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;

package BusSignalTypes is

	type AddressArray is array (integer range NofModules-1 downto 0)
		of std_logic_vector(11 downto 0);
	type DataArray is array (integer range NofModules-1 downto 0)
		of std_logic_vector(7 downto 0);
	type ControlRegArray is array (integer range NofModules-1 downto 0)
		of std_logic;

	type BusControlProcessType is (
		Init,
		Idle,
		GetDest,
		SetBus,
		Connect,
		Finalize,
		Done
	);

	type BusProcessType is (
		Init,
		Idle,
		Connect,
		Write,
		Read,
		Execute,
		Finalize,
		Done
	);
	
	type SubProcessType is (
		SubIdle, 
		ExecModule,
		WaitAck,
		SubDone
	);
	

end package BusSignalTypes;
