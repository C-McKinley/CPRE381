-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_dmem.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file tests a sign extender from 16 to 32 bits
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity tb_dmem is
generic(DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10;
	gCLK_HPER   : time := 50 ns);
end tb_dmem;

architecture behavior of tb_dmem is
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
type arr is array(0 to 10) of std_logic_vector(DATA_WIDTH-1 downto 0);

component mem is
   port (clk: in std_logic;
	addr: in std_logic_vector((ADDR_WIDTH-1) downto 0);
	data: in std_logic_vector((DATA_WIDTH-1) downto 0);
	we: in std_logic := '1';
	q: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end component;
signal s_clk, s_we : std_logic;
signal s_addr: std_logic_vector(ADDR_WIDTH-1 downto 0);
signal s_data: std_logic_vector(DATA_WIDTH-1 downto 0);
signal s_out: std_logic_vector(DATA_WIDTH-1 downto 0);
signal s_mem : arr;
begin
dmem: mem 
  port map(clk => s_clk,
	addr => s_addr,
	data => s_data,
	we=> s_we,
	q => s_out);
P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
	process
	begin
		s_we <= '0';
		s_data <= x"00000000";
		-- Read tests
		s_addr <= "0000000000";
		wait for 100 ns;
		--save
		s_mem(0) <= s_out;
		wait for 100 ns;
		s_addr <= "0000000001";
		wait for 100 ns;
		--save
		s_mem(1) <= s_out;
		wait for 100 ns;
		s_addr <= "0000000010";
		wait for 100 ns;
--save
		s_mem(2) <= s_out;
		wait for 100 ns;
		s_addr <= "0000000011";
		wait for 100 ns;
--save
		s_mem(3) <= s_out;
		wait for 100 ns;
		s_addr <= "0000000100";
		wait for 100 ns;
--save
		s_mem(4) <= s_out;
		wait for 100 ns;
		s_addr <= "0000000101";
		wait for 100 ns;
--save
		s_mem(5) <= s_out;
		wait for 100 ns;
		s_addr <= "0000000101";
		wait for 100 ns;
--save
		s_mem(6) <= s_out;
		wait for 100 ns;
		s_addr <= "0000000111";
		wait for 100 ns;
--save
		s_mem(7) <= s_out;
		wait for 100 ns;
		s_addr <= "0000001000";
		wait for 100 ns;
--save
		s_mem(8) <= s_out;
		wait for 100 ns;
		s_addr <= "0000001001";
		wait for 100 ns;
		s_mem(9) <= s_out;
		wait for 100 ns;
		s_addr <= "0000001010";
		wait for 100 ns;
		s_mem(10) <= s_out;
		wait for 100 ns;
		
		
		-- Write tests
		s_we <= '1';
		s_data <= s_mem(0);
		s_addr <= "0100000000";
		wait for 100 ns;
		s_data <= s_mem(1);
		s_addr <= "0100000001";
		wait for 100 ns;
		s_data <= s_mem(2);
		s_addr <= "0100000010";
		wait for 100 ns;
		s_data <= s_mem(3);
		s_addr <= "0100000011";
		wait for 100 ns;
		s_data <= s_mem(4);
		s_addr <= "0100000100";
		wait for 100 ns;
		s_data <= s_mem(5);
		s_addr <= "0100000101";
		wait for 100 ns;
		s_data <= s_mem(6);
		s_addr <= "0100000110";
		wait for 100 ns;
		s_data <= s_mem(7);
		s_addr <= "0100000111";
		wait for 100 ns;
		s_data <= s_mem(8);
		s_addr <= "0100001000";
		wait for 100 ns;
		s_data <= s_mem(9);
		s_addr <= "0100001001";
		wait for 100 ns;
s_data <= s_mem(10);
		s_addr <= "0100001010";
		wait for 100 ns;
  end process;
  
end behavior;