-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- alu.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32 bit alu
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
	port (
		i_ctrl : in std_logic_vector(3 - 1 downto 0); -- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
		i_a : in std_logic_vector(32-1 downto 0);
		i_b : in std_logic_vector(32-1 downto 0);
		i_less : in std_logic;
		o_f : out std_logic_vector(32-1 downto 0);
		o_cout : out std_logic;
		o_set : out std_logic
	);
end alu;

architecture structure of alu is

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
	signal s_set, s_carry: std_logic_vector(32 downto 0);
	signal s_cin: std_logic_vector(32 downto 0);
begin

	s_set(0) <= i_less;
	s_carry(0) <= '0';
	s_cin(0)   <= '0';
	alu_loop: for i in 0 to 31 generate
		alu_i: alu_single_bit port map(i_ctrl => i_ctrl, 
						  i_a => i_a(i), 
						  i_b => i_b(i),
						i_cin => s_carry(i),  
					       i_less => '0', 
						  o_f => o_f(i), 
					       o_cout => s_carry(i+1), 
					        o_set => s_set(i+1));
	end generate;
	o_set <= s_set(31);
	o_cout <= s_carry(31);
end structure;