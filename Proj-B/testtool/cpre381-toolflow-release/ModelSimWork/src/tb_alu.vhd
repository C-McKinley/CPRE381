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
use work.opcode_t.all;

entity tb_alu is
	generic (gCLK_HPER : time := 100 ns);
end tb_alu;

architecture behavior of tb_alu is
	constant cCLK_PER : time := gCLK_HPER * 2;
	component alu is
	port (
		i_ctrl : in std_logic_vector(6 - 1 downto 0); -- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
		i_a : in std_logic_vector(32 - 1 downto 0);
		i_b : in std_logic_vector(32 - 1 downto 0);
		o_result : out std_logic_vector(32 - 1 downto 0);
		o_overflow : out std_logic;
		o_zero : out std_logic
	);
	end component;

	signal s_i_ctrl : std_logic_vector(6 - 1 downto 0);
	signal s_i_a : std_logic_vector(32-1 downto 0);
	signal s_i_b : std_logic_vector(32-1 downto 0);
	signal s_o_f : std_logic_vector(32-1 downto 0);
	signal s_o_overflow : std_logic;
	signal s_zero : std_logic;
	signal s_CLK : std_logic;
	-- 0 add, 1 sub, 2 slt, 3 and, 4 or, 5 xor, 6 nand, 7 nor
begin
	alu_test : alu
	port map(
		i_ctrl => s_i_ctrl, 
		i_a => s_i_a, 
		i_b => s_i_b, 
		o_result => s_o_f, 
		o_overflow => s_o_overflow,
		o_zero => s_zero
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
	--add
	s_i_ctrl <= ADD_ALU_OP;
	s_i_a <= x"00000000";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "0_sum" severity warning;
	assert s_o_overflow = '0' report "0_carry" severity warning;

	s_i_a <= x"10101010";
	s_i_b <= x"01010101";
	wait for gCLK_HPER;
	assert s_o_f = x"11111111" report "2_sum" severity warning;
	assert s_o_overflow = '0' report "2_sum_carry" severity warning;

	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"FFFFFFFE" report "3_sum" severity warning;
	assert s_o_overflow = '0' report "3_sum_carry" severity warning;

	--sub
	-- CM I feel like overflow doesnt matter for this... if it does we need to do the math ourselves.
	s_i_ctrl <= SUB_ALU_OP;
	s_i_a <= x"00000000";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "0_diff" severity warning;
	--assert s_o_overflow = '0' report "0_carry" severity warning;

	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "1_diff" severity warning;
	--assert s_o_overflow = '0' report "1_sub_carry" severity warning;

	s_i_a <= x"10101010";
	s_i_b <= x"01010101";
	wait for gCLK_HPER;
	assert s_o_f = x"0F0F0F0F" report "2_diff" severity warning;
	--assert s_o_overflow = '0' report "2_sub_carry" severity warning;

	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "3_diff" severity warning;
	--assert s_o_overflow = '0' report "3_carry" severity warning;

	s_i_a <= x"0000000A";
	s_i_b <= x"0000000B";
	wait for gCLK_HPER;
	assert s_o_f = x"FFFFFFFF" report "4_diff" severity warning;


	--slt
	
	s_i_ctrl <= SLT_ALU_OP;
	s_i_a <= x"00000000";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "1_slt" severity warning;
	
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"00000001" report "2_slt" severity warning;
	
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "3_slt" severity warning;

	s_i_a <= x"00000000";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "4_slt" severity warning;

	s_i_a <= x"FFFFFFFA";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"00000001" report "5_slt" severity warning;

	s_i_a <= x"00000000";
	s_i_b <= x"00000001";
	wait for gCLK_HPER;
	assert s_o_f = x"00000001" report "6_slt" severity warning;

	s_i_a <= x"00000000";
	s_i_b <= x"70000000";
	wait for gCLK_HPER;
	assert s_o_f = x"00000001" report "7_slt" severity warning;
	
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"FFFFFFFA";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "8_slt" severity warning;

	--nor
	--0nor0
	s_i_ctrl <= NOR_ALU_OP;
	s_i_a <= x"00000000";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"FFFFFFFF" report "1_nor" severity warning;
	--1nor0
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "2_nor" severity warning;
	--1nor1
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "3_nor" severity warning;

	--nand
	--0nand0
	s_i_ctrl <= NAND_ALU_OP;
	s_i_a <= x"00000000";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"FFFFFFFF" report "1_nand" severity warning;
	--0nand1
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"FFFFFFFF" report "2_nand" severity warning;
	--1nand1
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "3_nand" severity warning;

	--xor
	--0xor0
	s_i_ctrl <= XOR_ALU_OP;
	s_i_a <= x"00000000";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "1_xor" severity warning;
	--1xor0
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"FFFFFFFF" report "2_xor" severity warning;
	--1xor1
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "3_xor" severity warning;

	--or
	--0or0
	s_i_ctrl <= OR_ALU_OP;
	s_i_a <= x"00000000";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "1_or" severity warning;
	--1or0
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"FFFFFFFF" report "2_or" severity warning;
	--0or1
	s_i_a <= x"00000000";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"FFFFFFFF" report "3_or" severity warning;
	--1or1
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"FFFFFFFF" report "4_or" severity warning;

	--and
	--0and0
	s_i_ctrl <= AND_ALU_OP;
	s_i_a <= x"00000000";
	s_i_b <= x"00000000";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "1_and" severity warning;
	--0and1
	s_i_ctrl <= AND_ALU_OP;
	s_i_a <= x"00000000";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"00000000" report "2_and" severity warning;
	--1and1
	s_i_ctrl <= AND_ALU_OP;
	s_i_a <= x"FFFFFFFF";
	s_i_b <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_o_f = x"FFFFFFFF" report "3_and" severity warning;

	end process;

end behavior;

