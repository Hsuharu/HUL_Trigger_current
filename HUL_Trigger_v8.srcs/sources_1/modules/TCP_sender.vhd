library IEEE, mylib;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use mylib.AddressMap.all;
use mylib.BusSignalTypes.all;
use mylib.AddressBook.all;

entity TCP_sender is
	port(
		RST 					: in std_logic;
		CLK 					: in std_logic;
		
		-- data from EVB --
		rdFromEVB			: in std_logic_vector(7 downto 0);
		rvFromEVB			: in std_logic;
		emptyFromEVB		: in std_logic;
		reToEVB				: out std_logic;
		
		-- data to SiTCP
		isActive			: in std_logic;
		afullTx				: in std_logic;
		weTx				: out std_logic;
		wdTx				: out std_logic_vector(7 downto 0)
		
		);
end TCP_sender;

architecture RTL of TCP_sender is
	-- signal declaration --------------------------------------------------------------
	
	-- ==================================== body ==================================== --
begin
	-- signal connection ---------------------------------------------------------------
	
	-- FIFO read
	u_buffer_reader : process(RST, CLK)
	begin
		if(RST = '1') then
			weTx	<= '0';
			wdTx	<= (others => '0');
		elsif(CLK'event AND CLK = '1') then
			weTx	<= rvFromEVB;
			wdTx	<= rdFromEVB;
		
			if(emptyFromEVB = '0' AND isActive = '1' AND afullTx = '0') then
				reToEVB	<= '1';
			else
				reToEVB	<= '0';
			end if;
		end if;
	end process u_buffer_reader;

end RTL;

