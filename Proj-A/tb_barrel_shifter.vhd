-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file tests the barrel shifter
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_barrel_shifter is
	generic (gCLK_HPER : time := 100 ns);
end tb_barrel_shifter;

architecture behavior of tb_barrel_shifter is
	constant cCLK_PER : time := gCLK_HPER * 2;
	
component barrel_shifter is
	port (
		i_a      : in std_logic_vector(32 - 1 downto 0);
		i_shift  : in std_logic_vector(5 - 1 downto 0); 
		i_la     : in std_logic_vector(5 - 1 downto 0); 
		i_rl     : in std_logic_vector(5 - 1 downto 0); 
		o_f      : out std_logic_vector(32 - 1 downto 0)
	);
component barrel_shifter;

	signal s_i_ctrl : std_logic_vector(3 - 1 downto 0);
	signal s_i_a : std_logic;
	signal s_i_b : std_logic;
	signal s_o_f : std_logic;
	signal s_CLK : std_logic;
	signal s_la : std_logic;
	signal s_rl : std_logic;
begin
	shifter : barrel_shifter
	port map(
		i_a => s_i_a, 
		i_shift => s_shift, 
		i_la => s_la, 
		i_rl => s_rl, 
		o_f => s_o_f, 
	);

	P_CLK : process
	begin
		s_CLK <= '0';
		wait for gCLK_HPER;
		s_CLK <= '1';
		wait for gCLK_HPER;
	end process;

	P_TB : process
	begin
		-- sll
		s_la <= '0';
		s_rl <= '1';
		
		s_shift <= "10000";
		s_i_a <= x"0000FFFF";
		wait for gCLK_HPER;
		assert s_o_f = x"FFFF0000" report "sll_0" severity warning;

		s_shift <= "00000";
		s_i_a <= x"0E0E0E0E";
		wait for gCLK_HPER;
		assert s_o_f = x"0E0E0E0E" report "sll_1" severity warning;


		s_shift <= "01000";
		s_i_a <= x"0E0E0E0E";
		wait for gCLK_HPER;
		assert s_o_f = x"E0E0E0E0" report "sll_2" severity warning;


		s_shift <= "00011";
		s_i_a <= x"0E0E0E0E";
		wait for gCLK_HPER;
		assert s_o_f = x"D1D1D1D0" report "sll_3" severity warning;


		-- srl
		s_la <= '0';
		s_rl <= '0';
		
		s_shift <= "00000";
		s_i_a <= x"0F0F0F0F";
		wait for gCLK_HPER;
		assert s_o_f = x"0F0F0F0F" report "srl_0" severity warning;

		s_shift <= "00100";
		s_i_a <= x"0F0F0F0F";
		wait for gCLK_HPER;
		assert s_o_f = x"000F0F0F" report "srl_1" severity warning;

		s_shift <= "11111";
		s_i_a <= x"00000001";
		wait for gCLK_HPER;
		assert s_o_f = x"80000000" report "srl_2" severity warning;

		s_shift <= "00011";
		s_i_a <= x"8000F007";
		wait for gCLK_HPER;
		assert s_o_f = x"00001E00" report "srl_3" severity warning;
		
		-- sra
		s_la <= '1'
		s_rl <= '0';

		s_shift <= "00000";
		s_i_a <= x"0F0F0F0F";
		wait for gCLK_HPER;
		assert s_o_f = x"0F0F0F0F" report "sra_0" severity warning;

		s_shift <= "00100";
		s_i_a <= x"0F0F0F0F";
		wait for gCLK_HPER;
		assert s_o_f = x"000F0F0F" report "sra_1" severity warning;

		s_shift <= "11111";
		s_i_a <= x"10000000";
		wait for gCLK_HPER;
		assert s_o_f = x"FFFFFFFF" report "sra_2" severity warning;

		s_shift <= "00011";
		s_i_a <= x"8000F007";
		wait for gCLK_HPER;
		assert s_o_f = x"F0001E00" report "sra_3" severity warning;

	end process;
end behavior;