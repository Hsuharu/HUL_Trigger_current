-- Local Bus Controller
-- Originally designed by S. Ajimura
-- Reused by R. Honda
-----------------------------------------------------------------------------------------------
library ieee, mylib;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity BusController is
  Port(
    rstSys 		: in  std_logic;
    rstFromBus 	        : out  std_logic;
    reConfig 	        : out  std_logic;
    clk			: in  std_logic;
    -- Local Bus --
    addrLocalBus	: out LocalAddressType;
    dataFromUserModules	: in DataArray;
    dataToUserModules	: out LocalBusInType;
    reLocalBus		: out ControlRegArray;
    weLocalBus		: out ControlRegArray;
    readyLocalBus	: in  ControlRegArray;
    -- RBCP --
    RBCP_ADDR		: in std_logic_vector(31 downto 0); -- address [31:0]
    RBCP_WD		: in std_logic_vector(7 downto 0);  -- data from host [7:0]
    RBCP_WE		: in std_logic; 							-- RBCP write enable
    RBCP_RE		: in std_logic; 							-- RBCP read enable
    RBCP_ACK		: out std_logic; 							-- RBCP acknowledge
    RBCP_RD		: out std_logic_vector(7 downto 0) 	-- data to host [7:0]
    );
end BusController;

architecture RTL of BusController is
   attribute keep :String;
--   attribute mark_debug :String;
--   attribute mark_debug of RBCP_RE: signal is "true";
--   attribute mark_debug of RBCP_WE: signal is "true";
--   attribute mark_debug of RBCP_ACK: signal is "true";
   
	-- internal signal ---------------------------------------------------
	signal state_bus       : BusControlProcessType;
	signal i_Module        : ModuleID := -1;
	signal data_LBusBuf    : DataArray;
	signal ready_LBusBuf   : ControlRegArray;
	signal rst_from_bus    : std_logic := '0';
	signal re_config       : std_logic := '1';
	
   attribute keep of rst_from_bus :signal is "true";

	-- external bus -------------------------------------------------------
	signal mid_ExtBus	: std_logic_vector(3 downto 0);
	signal addr_ExtBus 	: LocalAddressType;
	signal data_ExtBusIn	: LocalBusInType;
	signal data_ExtBusOut	: LocalBusOutType;
	signal ack_ExtBus, re_ExtBus, we_ExtBus	: std_logic;

--    attribute mark_debug of state_bus: signal is "true";
--    attribute mark_debug of ready_LBusBuf: signal is "true";
--    attribute mark_debug of ack_ExtBus: signal is "true";
--    attribute mark_debug of re_ExtBus: signal is "true";
--    attribute mark_debug of we_ExtBus: signal is "true";
	-- =============================== body ===============================
begin
  -- Bus latch --
  u_BusLatchProcess : process(clk)
  begin
    if(clk'event and clk = '1') then
      for i in 0 to NofModules-1 loop
        data_LBusBuf(i)	<= dataFromUserModules(i);
        ready_LBusBUf(i)	<= readyLocalBus(i);
      end loop;
    end if;
  end process u_BusLatchProcess;
  
  -- RBCP connection --
  RBCP_RD		<= data_ExtBusOut;
  RBCP_ACK	<= ack_ExtBus;
  rstFromBus	<= rst_from_bus;
  reConfig	<= re_config;
  
  -- Bus control process --
  u_BusControlProcess : process (clk, rstSys)
  begin
    if(rstSys = '1') then
      for i in 0 to NofModules-1 loop      
        reLocalBus(i) <= '0';
        weLocalBus(i) <= '0';
      end loop;
      re_ExtBus		<= '0';
      we_ExtBus		<= '0';
      data_ExtBusOut	<= x"00";
      ack_ExtBus	<= '0';
      rst_from_bus	<= '0';
      re_config         <= '1';
      state_bus	        <= Init;
    elsif(clk'event and clk = '1') then
      case state_bus is
        when Init =>
          for i in 0 to NofModules-1 loop
            reLocalBus(i) <= '0';
            weLocalBus(i) <= '0';
          end loop;
          re_ExtBus		<= '0';
          we_ExtBus		<= '0';
          data_ExtBusOut	<= x"00";
          ack_ExtBus		<= '0';
          rst_from_bus	        <= '0';
          re_config   	        <= '1';
          state_bus		<= Idle;
          
        when Idle =>
          if(RBCP_RE = '1' or RBCP_WE = '1') then
            re_ExtBus		<= RBCP_RE;
            we_ExtBus		<= RBCP_WE;
            mid_ExtBus		<= RBCP_ADDR(31 downto 28);
            addr_ExtBus		<= RBCP_ADDR(27 downto 16);
            data_ExtBusIn	<= RBCP_ADDR(15 downto 0) & RBCP_WD;
            state_bus		<= GetDest;
          end if;
          
        when GetDest =>
          if(mid_ExtBus = mid_BCT) then -- Do in this module
            if(re_ExtBus = '1') then
              if(addr_ExtBus(11 downto 2) = BCT_Version(11 downto 2)) then --version info
                case addr_ExtBus(1 downto 0) is
                  when "00" => data_ExtBusOut	<= CurrentVersion(7 downto 0);
                  when "01" => data_ExtBusOut	<= CurrentVersion(15 downto 8);
                  when "10" => data_ExtBusOut	<= CurrentVersion(23 downto 16);
                  when others => data_ExtBusOut	<= CurrentVersion(31 downto 24);
                end case;
              end if;
            elsif(we_ExtBus = '1') then
              if(addr_ExtBus(11 downto 2) = BCT_Reset(11 downto 2)) then -- software reset
                rst_from_bus	<= '1';
              elsif(addr_ExtBus(11 downto 2) = BCT_ReConfig(11 downto 2)) then -- reconfig by SPI
              
                re_config       <= '0';
              end if;
            end if;
            state_bus	<= Done;
          else -- Go to external user modules
            case mid_ExtBus is
              when mid_LED 	 => i_Module <= i_LED.ID;
              when mid_RGN1 	 => i_Module <= i_RGN1.ID;
              when mid_RGN2_1    => i_Module <= i_RGN2_1.ID;
              when mid_RGN2_2    => i_Module <= i_RGN2_2.ID;
              when mid_RGN2_3    => i_Module <= i_RGN2_3.ID;
              when mid_RGN2_4    => i_Module <= i_RGN2_4.ID;
              when mid_RGN2_5    => i_Module <= i_RGN2_5.ID;
              when mid_RGN2_6  	 => i_Module <= i_RGN2_6.ID;
              when mid_RGN3  	 => i_Module <= i_RGN3.ID;
              when mid_RGN4  	 => i_Module <= i_RGN4.ID;
              when mid_IOM 	 => i_Module <= i_IOM.ID;
              when others  	 => i_Module <= i_Dummy.ID;
            end case;
            state_bus	<= SetBus;
          end if;
          
        when SetBus =>
          if(i_Module = -1) then
	-- error state --
            data_ExtBusOut	<= x"ff";
            state_bus		<= Done;
          else
            addrLocalBus	<= addr_ExtBus;
            dataToUserModules	<= data_ExtBusIn;
            state_bus		<= Connect;
          end if;
          
        when Connect =>
          if(we_ExtBus = '1') then
            weLocalBus(i_Module) <= '1';
          else
            reLocalBus(i_Module) <= '1';
          end if;
          -- wait ready from user modules --
          if(ready_LBusBuf(i_Module) = '1') then
            state_bus	<= Finalize;
          end if;
          
        when Finalize =>
          -- data valid end of process --
          data_ExtBusOut	<= data_LBusBuf(i_Module);
          state_bus		<= Done;
          
        when Done =>
          weLocalBus(i_Module) <= '0';
          reLocalBus(i_Module) <= '0';
          ack_ExtBus				<= '1';
          state_bus				<= Init;
          
      end case;
    end if;
  end process u_BusControlProcess;

end RTL;

