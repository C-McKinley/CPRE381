-------------------------------------------------------------------------
-- Tyler Dawson
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_alu.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a alu test bench
--
--
-- NOTES:
-- 9/17/19 by TWD::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
	generic (gCLK_HPER : time := 100 ns);
end tb_alu;

architecture behavior of tb_alu is
	constant cCLK_PER : time := gCLK_HPER * 2;
	component alu is
	port (
		i_ctrl : in std_logic_vector(3 - 1 downto 0); -- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
		i_a : in std_logic_vector(32-1 downto 0);
		i_b : in std_logic_vector(32-1 downto 0);
		i_cin : in std_logic;
		i_less : in std_logic;
		o_f : out std_logic_vector(32-1 downto 0);
		o_cout : out std_logic;
		o_set : out std_logic
	);
	end component;

	signal s_i_ctrl : std_logic_vector(3 - 1 downto 0);
	signal s_i_a : std_logic_vector(32-1 downto 0);
	signal s_i_b : std_logic_vector(32-1 downto 0);
	signal s_i_cin : std_logic;
	signal s_i_less : std_logic;
	signal s_o_f : std_logic_vector(32-1 downto 0);
	signal s_o_cout : std_logic;
	signal s_o_set : std_logic;
	signal s_CLK : std_logic;
	-- 0 add, 1 sub, 2 slt, 3 and, 4 or, 5 xor, 6 nand, 7 nor
begin
	alu_test : alu
	port map(
		i_ctrl => s_i_ctrl, 
		i_a => s_i_a, 
		i_b => s_i_b, 
		i_cin => s_i_cin, 
		i_less => s_i_less, 
		o_f => s_o_f, 
		o_cout => s_o_cout, 
		o_set => s_o_set
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
		s_i_less <= '0';
		--add
		s_i_cin <= '0';
		s_i_ctrl <= "000";
		s_i_a <= x"00000000";
		s_i_b <= x"00000000";
		wait for gCLK_HPER;
		assert s_o_f = x"00000000"; report "1_sum" severity warning;
		assert s_o_cout = '0' report "1_carry" severity warning;

	end process;
end behavior;

