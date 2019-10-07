-------------------------------------------------------------------------
-- Tyler Dawson
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_ALU_1bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a sign extender
--
--
-- NOTES:
-- 9/17/19 by TWD::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ALU_1bit is
	generic (gCLK_HPER : time := 100 ns);
end tb_ALU_1bit;

architecture behavior of tb_ALU_1bit is
	constant cCLK_PER : time := gCLK_HPER * 2;
	component alu_single_bit is
		port (
			i_ctrl : in std_logic_vector(3 - 1 downto 0); -- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
			i_a : in std_logic;
			i_b : in std_logic;
			i_cin : in std_logic;
			i_less : in std_logic;
			o_f : out std_logic;
			o_cout : out std_logic;
			o_set : out std_logic
		);
	end component;

	signal s_i_ctrl : std_logic_vector(3 - 1 downto 0);
	signal s_i_a : std_logic;
	signal s_i_b : std_logic;
	signal s_o_f : std_logic;
	signal s_CLK : std_logic;
	signal s_cin : std_logic;
	signal s_cout : std_logic;
	signal s_set : std_logic;
	signal s_less : std_logic;
	-- 0 add, 1 sub, 2 slt, 3 and, 4 or, 5 xor, 6 nand, 7 nor
begin
	alu : alu_single_bit
	port map(
		i_ctrl => s_i_ctrl, 
		i_a => s_i_a, 
		i_b => s_i_b, 
		i_less => s_less, 
		i_cin => s_cin, 
		o_f => s_o_f, 
		o_set => s_set, 
		o_cout => s_cout
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
		s_less <= '0';
		--add
		s_cin <= '0';
		s_i_ctrl <= "000";
		s_i_a <= '0';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "1_sum" severity warning;
		assert s_cout = '0' report "1_carry" severity warning;

		s_i_ctrl <= "000";
		s_i_a <= '0';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "2_sum" severity warning;
		assert s_cout = '0' report "2_carry" severity warning;

		s_i_ctrl <= "000";
		s_i_a <= '1';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "3_sum" severity warning;
		assert s_cout = '0' report "3_carry" severity warning;

		s_i_ctrl <= "000";
		s_i_a <= '1';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "4_sum" severity warning;
		assert s_cout = '1' report "4_carry" severity warning;

		--sub  do not care about carry out
		-- http://www.ece.iastate.edu/~alexs/classes/2019_Fall_281/slides_PDF/17_Signed_Numbers.pdf (slide 129)
		s_cin <= '1';
		s_i_ctrl <= "001";
		s_i_a <= '0';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "5_diff" severity warning;

		s_i_ctrl <= "001";
		s_i_a <= '0';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "6_diff" severity warning;

		s_i_ctrl <= "001";
		s_i_a <= '1';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "7_diff" severity warning;

		s_i_ctrl <= "001";
		s_i_a <= '1';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "8_diff" severity warning;

		--slt
		s_i_ctrl <= "010";
		s_i_a <= '0';
		s_i_b <= '0';
		s_less <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "9_of" severity warning;
		assert s_set = '0' report "9_set" severity warning;

		s_i_ctrl <= "010";
		s_i_a <= '0';
		s_i_b <= '1';
		s_less <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "10_of" severity warning;
		assert s_set = '1' report "10_set" severity warning;


		s_i_ctrl <= "010";
		s_i_a <= '1';
		s_i_b <= '0';
		s_less <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "11_of" severity warning;
		assert s_set = '0' report "11_set" severity warning;

		s_i_ctrl <= "010";
		s_i_a <= '1';
		s_i_b <= '1';
		s_less <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "12_of" severity warning;
		assert s_set = '0' report "12_set" severity warning;

		--and
		s_i_ctrl <= "011";
		s_i_a <= '0';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "13" severity warning;

		s_i_ctrl <= "011";
		s_i_a <= '0';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "14" severity warning;

		s_i_ctrl <= "011";
		s_i_a <= '1';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "15" severity warning;

		s_i_ctrl <= "011";
		s_i_a <= '1';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "16" severity warning;

		--or
		s_i_ctrl <= "100";
		s_i_a <= '0';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "17" severity warning;

		s_i_ctrl <= "100";
		s_i_a <= '0';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "18" severity warning;

		s_i_ctrl <= "100";
		s_i_a <= '1';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "19" severity warning;

		s_i_ctrl <= "100";
		s_i_a <= '1';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "20" severity warning;

		--xor
		s_i_ctrl <= "101";
		s_i_a <= '0';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "21" severity warning;

		s_i_ctrl <= "101";
		s_i_a <= '0';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "22" severity warning;

		s_i_ctrl <= "101";
		s_i_a <= '1';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "23" severity warning;

		s_i_ctrl <= "101";
		s_i_a <= '1';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "24" severity warning;

		--nand
		s_i_ctrl <= "110";
		s_i_a <= '0';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "25" severity warning;

		s_i_ctrl <= "110";
		s_i_a <= '0';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "26" severity warning;

		s_i_ctrl <= "110";
		s_i_a <= '1';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "27" severity warning;

		s_i_ctrl <= "110";
		s_i_a <= '1';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "28" severity warning;

		--nor
		s_i_ctrl <= "111";
		s_i_a <= '0';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '1' report "29" severity warning;

		s_i_ctrl <= "111";
		s_i_a <= '0';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "30" severity warning;

		s_i_ctrl <= "111";
		s_i_a <= '1';
		s_i_b <= '0';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "31" severity warning;

		s_i_ctrl <= "111";
		s_i_a <= '1';
		s_i_b <= '1';
		wait for gCLK_HPER;
		assert s_o_f = '0' report "32" severity warning;
	end process;
end behavior;


