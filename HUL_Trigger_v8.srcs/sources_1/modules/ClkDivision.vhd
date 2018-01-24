library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ClkDivision is
  port (
    rst         : in std_logic;
    clk         : in std_logic;
    
    -- module output --
    clk1MHz    : out std_logic;
    clk100kHz  : out std_logic;
    clk10kHz   : out std_logic;
    clk1kHz    : out std_logic
    );
end ClkDivision;

architecture RTL of ClkDivision is
  -- signal decralation ------------------------------------------------------
  signal clk_1MHz, clk_100kHz, clk_10kHz, clk_1kHz : std_logic;
  
  component Division10 is
    port (
      rst         : in std_logic;
      clk         : in std_logic;
      clkDiv10    : out std_logic
      );
  end component;    
begin
  -- =============================== body ====================================
  clk1MHz     <= clk_1MHz;
  clk100kHz   <= clk_100kHz;
  clk10kHz    <= clk_10kHz;
  clk1kHz     <= clk_1kHz;
  
  u_clk1MHz   : Division10 port map(rst=>rst, clk=>clk,        clkDiv10=>clk_1MHz);
  u_clk100kHz : Division10 port map(rst=>rst, clk=>clk_1MHz,   clkDiv10=>clk_100kHz);
  u_clk10kHz  : Division10 port map(rst=>rst, clk=>clk_100kHz, clkDiv10=>clk_10kHz);
  u_clk1kHz   : Division10 port map(rst=>rst, clk=>clk_10kHz,  clkDiv10=>clk_1kHz);

end RTL;
