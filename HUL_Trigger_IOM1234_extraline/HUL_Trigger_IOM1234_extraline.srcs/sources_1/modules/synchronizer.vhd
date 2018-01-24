library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;


entity synchronizer is
	Port (
	   CLK 				: in STD_LOGIC;
       DATAIN			: in STD_LOGIC;
       SYNC_DATAOUT	    : out  STD_LOGIC
	);
end synchronizer;

architecture RTL of synchronizer is
	signal q1, q2, q3	: std_logic;
	
begin
	SYNC_DATAOUT	<= q3;

	u_Sync1 : process(CLK)
	begin
		if(CLK'event and CLK = '1') then
			q1	<= DATAIN;
		end if;
	end process u_Sync1;
	
	u_Sync2 : process(CLK)
	begin
		if(CLK'event and CLK = '1') then
			q2	<= q1;
		end if;
	end process u_Sync2;

	u_Sync3 : process(CLK)
	begin
		if(CLK'event and CLK = '1') then
			q3	<= q2;
		end if;
	end process u_Sync3;

end RTL;

