library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity IOManager_NIM is
  port(
    rst                 : in std_logic;
    clk_sys                 : in std_logic;
    
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
--    Matrix_3D_K_Scat           : in  std_logic;
    Other4_K_Scat              : in  std_logic;
    Other5_K_Scat              : in  std_logic;
    BH2_Pi_Beam_TOF            : in  std_logic; 
    SAC_or_Beam_TOF            : in  std_logic; 
    TOF_or_Beam_TOF            : in  std_logic; 
    LC_or_Beam_TOF             : in  std_logic; 
    TOF_HT_Beam_TOF            : in  std_logic; 
--    Matrix_3D_Beam_TOF         : in  std_logic; 
    Other4_Beam_TOF            : in  std_logic; 
    Other5_Beam_TOF            : in  std_logic; 
    BH2_Pi_Coin1               : in  std_logic; 
    SAC_or_Coin1               : in  std_logic; 
    TOF_or_Coin1               : in  std_logic; 
    LC_or_Coin1                : in  std_logic; 
    TOF_HT_Coin1               : in  std_logic; 
--    Matrix_3D_Coin1            : in  std_logic; 
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

--        : in  std_logic;
--        : in  std_logic;
--        : in  std_logic;
--        : in  std_logic;
--        : in  std_logic;
--        : in  std_logic;
--        : in  std_logic_vector( 7 downto 0 );

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
end IOManager_NIM;

architecture RTL of IOManager_NIM is
  attribute keep : string;

  -- signal decralation -------------------------------------------------------------
  constant NbitOut      : positive := 6;
  
  signal state_lbus    	: BusProcessType;
  
  signal nimout1          : std_logic;
  signal nimout2          : std_logic;
  signal nimout3          : std_logic;
  signal nimout4          : std_logic;
  signal reg_nimout1      : std_logic_vector( 5 downto 0);
  signal reg_nimout2      : std_logic_vector( 5 downto 0);
  signal reg_nimout3      : std_logic_vector( 5 downto 0);
  signal reg_nimout4      : std_logic_vector( 5 downto 0);

begin
  -- =================================== body =======================================
  -- signal connection -------------------------------------------------------
  nim_out1    <= nimout1;
  nim_out2    <= nimout2;
  nim_out3    <= nimout3;
  nim_out4    <= nimout4;

  nimout1    <= BH1_Beam                    when(reg_nimout1 = "000000") else
                BH2_Beam                    when(reg_nimout1 = "000001") else
                BH1_Pi                      when(reg_nimout1 = "000010") else
                BH2_Pi                      when(reg_nimout1 = "000011") else
                BH1_P                       when(reg_nimout1 = "000100") else
                BH2_P                       when(reg_nimout1 = "000101") else
                SAC_K_Scat                  when(reg_nimout1 = "000110") else
                TOF_K_Scat                  when(reg_nimout1 = "000111") else
                Lucite_K_Scat               when(reg_nimout1 = "001000") else
                TOF_HT_K_Scat               when(reg_nimout1 = "001001") else
                Other4_K_Scat               when(reg_nimout1 = "001010") else
                Other5_K_Scat               when(reg_nimout1 = "001011") else
                BH2_Pi_Beam_TOF             when(reg_nimout1 = "001100") else
                SAC_or_Beam_TOF             when(reg_nimout1 = "001101") else
                TOF_or_Beam_TOF             when(reg_nimout1 = "001110") else
                LC_or_Beam_TOF              when(reg_nimout1 = "001111") else
                TOF_HT_Beam_TOF             when(reg_nimout1 = "010000") else
                Other4_Beam_TOF             when(reg_nimout1 = "010001") else
                Other5_Beam_TOF             when(reg_nimout1 = "010010") else
                BH2_Pi_Coin1                when(reg_nimout1 = "010011") else
                SAC_or_Coin1                when(reg_nimout1 = "010100") else
                TOF_or_Coin1                when(reg_nimout1 = "010101") else
                LC_or_Coin1                 when(reg_nimout1 = "010110") else
                TOF_HT_Coin1                when(reg_nimout1 = "010111") else
                Other4_Coin1                when(reg_nimout1 = "011000") else
                Other5_Coin1                when(reg_nimout1 = "011001") else
                BH2_Pi_E03                  when(reg_nimout1 = "011010") else
                Other1_E03                  when(reg_nimout1 = "011011") else
                Other2_E03                  when(reg_nimout1 = "011100") else
                Other3_E03                  when(reg_nimout1 = "011101") else
                Other4_E03                  when(reg_nimout1 = "011110") else
                Other5_E03                  when(reg_nimout1 = "011111") else
                PS_OR_DLY                   when(reg_nimout1 = "100000") else
                K_Scat_Else_OR              when(reg_nimout1 = "100001") else
                BH2_DLY(0)                  when(reg_nimout1 = "100010") else 
                BH2_DLY(1)                  when(reg_nimout1 = "100011") else 
                BH2_DLY(2)                  when(reg_nimout1 = "100100") else 
                BH2_DLY(3)                  when(reg_nimout1 = "100101") else 
                BH2_DLY(4)                  when(reg_nimout1 = "100110") else 
                BH2_DLY(5)                  when(reg_nimout1 = "100111") else 
                BH2_DLY(6)                  when(reg_nimout1 = "101000") else 
                BH2_DLY(7)                  when(reg_nimout1 = "101001") else
                K_Scat_BH2_K                when(reg_nimout1 = "100010") else '0';

  nimout2    <= BH1_Beam                    when(reg_nimout2 = "000000") else
                BH2_Beam                    when(reg_nimout2 = "000001") else
                BH1_Pi                      when(reg_nimout2 = "000010") else
                BH2_Pi                      when(reg_nimout2 = "000011") else
                BH1_P                       when(reg_nimout2 = "000100") else
                BH2_P                       when(reg_nimout2 = "000101") else
                SAC_K_Scat                  when(reg_nimout2 = "000110") else
                TOF_K_Scat                  when(reg_nimout2 = "000111") else
                Lucite_K_Scat               when(reg_nimout2 = "001000") else
                TOF_HT_K_Scat               when(reg_nimout2 = "001001") else
                Other4_K_Scat               when(reg_nimout2 = "001010") else
                Other5_K_Scat               when(reg_nimout2 = "001011") else
                BH2_Pi_Beam_TOF             when(reg_nimout2 = "001100") else
                SAC_or_Beam_TOF             when(reg_nimout2 = "001101") else
                TOF_or_Beam_TOF             when(reg_nimout2 = "001110") else
                LC_or_Beam_TOF              when(reg_nimout2 = "001111") else
                TOF_HT_Beam_TOF             when(reg_nimout2 = "010000") else
                Other4_Beam_TOF             when(reg_nimout2 = "010001") else
                Other5_Beam_TOF             when(reg_nimout2 = "010010") else
                BH2_Pi_Coin1                when(reg_nimout2 = "010011") else
                SAC_or_Coin1                when(reg_nimout2 = "010100") else
                TOF_or_Coin1                when(reg_nimout2 = "010101") else
                LC_or_Coin1                 when(reg_nimout2 = "010110") else
                TOF_HT_Coin1                when(reg_nimout2 = "010111") else
                Other4_Coin1                when(reg_nimout2 = "011000") else
                Other5_Coin1                when(reg_nimout2 = "011001") else
                BH2_Pi_E03                  when(reg_nimout2 = "011010") else
                Other1_E03                  when(reg_nimout2 = "011011") else
                Other2_E03                  when(reg_nimout2 = "011100") else
                Other3_E03                  when(reg_nimout2 = "011101") else
                Other4_E03                  when(reg_nimout2 = "011110") else
                Other5_E03                  when(reg_nimout2 = "011111") else
                PS_OR_DLY                   when(reg_nimout2 = "100000") else
                K_Scat_Else_OR              when(reg_nimout2 = "100001") else
                BH2_DLY(0)                  when(reg_nimout2 = "100010") else 
                BH2_DLY(1)                  when(reg_nimout2 = "100011") else 
                BH2_DLY(2)                  when(reg_nimout2 = "100100") else 
                BH2_DLY(3)                  when(reg_nimout2 = "100101") else 
                BH2_DLY(4)                  when(reg_nimout2 = "100110") else 
                BH2_DLY(5)                  when(reg_nimout2 = "100111") else 
                BH2_DLY(6)                  when(reg_nimout2 = "101000") else 
                BH2_DLY(7)                  when(reg_nimout2 = "101001") else
                K_Scat_BH2_K                when(reg_nimout2 = "100010") else '0';

  nimout3    <= BH1_Beam                    when(reg_nimout3 = "000000") else
                BH2_Beam                    when(reg_nimout3 = "000001") else
                BH1_Pi                      when(reg_nimout3 = "000010") else
                BH2_Pi                      when(reg_nimout3 = "000011") else
                BH1_P                       when(reg_nimout3 = "000100") else
                BH2_P                       when(reg_nimout3 = "000101") else
                SAC_K_Scat                  when(reg_nimout3 = "000110") else
                TOF_K_Scat                  when(reg_nimout3 = "000111") else
                Lucite_K_Scat               when(reg_nimout3 = "001000") else
                TOF_HT_K_Scat               when(reg_nimout3 = "001001") else
                Other4_K_Scat               when(reg_nimout3 = "001010") else
                Other5_K_Scat               when(reg_nimout3 = "001011") else
                BH2_Pi_Beam_TOF             when(reg_nimout3 = "001100") else
                SAC_or_Beam_TOF             when(reg_nimout3 = "001101") else
                TOF_or_Beam_TOF             when(reg_nimout3 = "001110") else
                LC_or_Beam_TOF              when(reg_nimout3 = "001111") else
                TOF_HT_Beam_TOF             when(reg_nimout3 = "010000") else
                Other4_Beam_TOF             when(reg_nimout3 = "010001") else
                Other5_Beam_TOF             when(reg_nimout3 = "010010") else
                BH2_Pi_Coin1                when(reg_nimout3 = "010011") else
                SAC_or_Coin1                when(reg_nimout3 = "010100") else
                TOF_or_Coin1                when(reg_nimout3 = "010101") else
                LC_or_Coin1                 when(reg_nimout3 = "010110") else
                TOF_HT_Coin1                when(reg_nimout3 = "010111") else
                Other4_Coin1                when(reg_nimout3 = "011000") else
                Other5_Coin1                when(reg_nimout3 = "011001") else
                BH2_Pi_E03                  when(reg_nimout3 = "011010") else
                Other1_E03                  when(reg_nimout3 = "011011") else
                Other2_E03                  when(reg_nimout3 = "011100") else
                Other3_E03                  when(reg_nimout3 = "011101") else
                Other4_E03                  when(reg_nimout3 = "011110") else
                Other5_E03                  when(reg_nimout3 = "011111") else
                PS_OR_DLY                   when(reg_nimout3 = "100000") else
                K_Scat_Else_OR              when(reg_nimout3 = "100001") else
                BH2_DLY(0)                  when(reg_nimout3 = "100010") else 
                BH2_DLY(1)                  when(reg_nimout3 = "100011") else 
                BH2_DLY(2)                  when(reg_nimout3 = "100100") else 
                BH2_DLY(3)                  when(reg_nimout3 = "100101") else 
                BH2_DLY(4)                  when(reg_nimout3 = "100110") else 
                BH2_DLY(5)                  when(reg_nimout3 = "100111") else 
                BH2_DLY(6)                  when(reg_nimout3 = "101000") else 
                BH2_DLY(7)                  when(reg_nimout3 = "101001") else
                K_Scat_BH2_K                when(reg_nimout3 = "100010") else '0';

  nimout4    <= BH1_Beam                    when(reg_nimout4 = "000000") else
                BH2_Beam                    when(reg_nimout4 = "000001") else
                BH1_Pi                      when(reg_nimout4 = "000010") else
                BH2_Pi                      when(reg_nimout4 = "000011") else
                BH1_P                       when(reg_nimout4 = "000100") else
                BH2_P                       when(reg_nimout4 = "000101") else
                SAC_K_Scat                  when(reg_nimout4 = "000110") else
                TOF_K_Scat                  when(reg_nimout4 = "000111") else
                Lucite_K_Scat               when(reg_nimout4 = "001000") else
                TOF_HT_K_Scat               when(reg_nimout4 = "001001") else
                Other4_K_Scat               when(reg_nimout4 = "001010") else
                Other5_K_Scat               when(reg_nimout4 = "001011") else
                BH2_Pi_Beam_TOF             when(reg_nimout4 = "001100") else
                SAC_or_Beam_TOF             when(reg_nimout4 = "001101") else
                TOF_or_Beam_TOF             when(reg_nimout4 = "001110") else
                LC_or_Beam_TOF              when(reg_nimout4 = "001111") else
                TOF_HT_Beam_TOF             when(reg_nimout4 = "010000") else
                Other4_Beam_TOF             when(reg_nimout4 = "010001") else
                Other5_Beam_TOF             when(reg_nimout4 = "010010") else
                BH2_Pi_Coin1                when(reg_nimout4 = "010011") else
                SAC_or_Coin1                when(reg_nimout4 = "010100") else
                TOF_or_Coin1                when(reg_nimout4 = "010101") else
                LC_or_Coin1                 when(reg_nimout4 = "010110") else
                TOF_HT_Coin1                when(reg_nimout4 = "010111") else
                Other4_Coin1                when(reg_nimout4 = "011000") else
                Other5_Coin1                when(reg_nimout4 = "011001") else
                BH2_Pi_E03                  when(reg_nimout4 = "011010") else
                Other1_E03                  when(reg_nimout4 = "011011") else
                Other2_E03                  when(reg_nimout4 = "011100") else
                Other3_E03                  when(reg_nimout4 = "011101") else
                Other4_E03                  when(reg_nimout4 = "011110") else
                Other5_E03                  when(reg_nimout4 = "011111") else
                PS_OR_DLY                   when(reg_nimout4 = "100000") else
                K_Scat_Else_OR              when(reg_nimout4 = "100001") else
                BH2_DLY(0)                  when(reg_nimout4 = "100010") else 
                BH2_DLY(1)                  when(reg_nimout4 = "100011") else 
                BH2_DLY(2)                  when(reg_nimout4 = "100100") else 
                BH2_DLY(3)                  when(reg_nimout4 = "100101") else 
                BH2_DLY(4)                  when(reg_nimout4 = "100110") else 
                BH2_DLY(5)                  when(reg_nimout4 = "100111") else 
                BH2_DLY(6)                  when(reg_nimout4 = "101000") else 
                BH2_DLY(7)                  when(reg_nimout4 = "101001") else
                K_Scat_BH2_K                when(reg_nimout4 = "100010") else '0';


                         
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
	  
          reg_nimout1        <= (others => '1');
          reg_nimout2        <= (others => '1');
          reg_nimout3        <= (others => '1');
          reg_nimout4        <= (others => '1');

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

            when IOM_nim1 =>  reg_nimout1 <= dataLocalBusIn(NbitOut-1 downto 0);
            when IOM_nim2 =>  reg_nimout2 <= dataLocalBusIn(NbitOut-1 downto 0);
            when IOM_nim3 =>  reg_nimout3 <= dataLocalBusIn(NbitOut-1 downto 0);
            when IOM_nim4 =>  reg_nimout4 <= dataLocalBusIn(NbitOut-1 downto 0);

            when others => null;
          end case;
          state_lbus <= Done;

        when Read =>
          case addrLocalBus is
		  
            when IOM_nim1 =>   dataLocalBusOut <= "00" & reg_nimout1;
            when IOM_nim2 =>   dataLocalBusOut <= "00" & reg_nimout2;
            when IOM_nim3 =>   dataLocalBusOut <= "00" & reg_nimout3;
            when IOM_nim4 =>   dataLocalBusOut <= "00" & reg_nimout4;

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
