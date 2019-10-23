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
use ieee.std_logic_misc.nor_reduce;
use work.opcode_t.all;

entity alu is
	port (
		i_ctrl : in std_logic_vector(6 - 1 downto 0); -- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
		i_a : in std_logic_vector(32 - 1 downto 0);
		i_b : in std_logic_vector(32 - 1 downto 0);
		o_result : out std_logic_vector(32 - 1 downto 0);
		o_overflow : out std_logic;
		o_zero : out std_logic
	);
end alu;

architecture structure of alu is

	component alu_single_bit is
		port (
			i_ctrl : in std_logic_vector(6 - 1 downto 0); -- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
			i_a : in std_logic;
			i_b : in std_logic;
			i_cin : in std_logic;
			i_less : in std_logic;
			o_f : out std_logic;
			o_cout : out std_logic;
			o_set : out std_logic;
			o_overflow : out std_logic
		);
	end component;
	component barrel_shifter is
		port (
			i_data : in std_logic_vector(32 - 1 downto 0);
			i_shift : in std_logic_vector(5 - 1 downto 0); --
			i_la : in std_logic; -- logical or arithmetic
			i_rl : in std_logic; -- right or left
			o_f : out std_logic_vector(32 - 1 downto 0)
		);
	end component;
	component invg is
		port(i_A          : in std_logic;
		     o_F          : out std_logic);
	end component;
	signal barrel_ctrl : std_logic_vector(1 downto 0); -- [0:{logic/arithmetic} 1:{right/left}]
	signal alu_result,  s_overflow, barrel_shifter_result, s_set, s_result : std_logic_vector(32 - 1 downto 0);
	signal s_carry: std_logic_vector(32 downto 0);
begin
	with i_ctrl select barrel_ctrl <= 
		"10" when SLL_ALU_OP, 
		"00" when SRL_ALU_OP, 
		"01" when SRA_ALU_OP, 
		"10" when SLLV_ALU_OP,
		"00" when SRLV_ALU_OP,
		"01" when SRAV_ALU_OP,
		"00" when others;
	shifter : barrel_shifter
		port map(
			i_data => i_a, 
			i_shift => i_b (5 - 1 downto 0), 
			i_la => barrel_ctrl(0), 
			i_rl => barrel_ctrl(1), 
			o_f => barrel_shifter_result
		);
	with i_ctrl select s_carry(0) <= 
		'1' when SUB_ALU_OP, -- sub
		'1' when SLT_ALU_OP, -- slt
		'1' when SLTU_ALU_OP, -- slt
		'0' when others;

	alu_0 : alu_single_bit
	port map(
		i_ctrl => i_ctrl, 
		i_a => i_a(0), 
		i_b => i_b(0), 
		i_cin => s_carry(0), 
		i_less => s_set(31), 
		o_f => alu_result(0), 
		o_cout => s_carry(1), 
		o_set => s_set(0), 
		o_overflow => s_overflow(0)
	);
	alu_loop : for i in 1 to 31 generate
		alu_i : alu_single_bit
		port map(
			i_ctrl => i_ctrl, 
			i_a => i_a(i), 
			i_b => i_b(i), 
			i_cin => s_carry(i), 
			i_less => '0', 
			o_f => alu_result(i), 
			o_cout => s_carry(i + 1), 
			o_set => s_set(i), 
			o_overflow => s_overflow(i)
		);
	end generate;
	-- zero detect
	o_zero <= nor_reduce(s_result);
	o_result <= s_result;
	o_overflow <= s_overflow(31);
	-- output mux
	with i_ctrl select s_result <= 
		alu_result when ADD_ALU_OP, -- add
		alu_result when SUB_ALU_OP, -- sub
		alu_result when SLT_ALU_OP, -- slt
		alu_result when AND_ALU_OP, -- and
		alu_result when OR_ALU_OP, -- or
		alu_result when XOR_ALU_OP, -- xor
		alu_result when NAND_ALU_OP, -- nand
		alu_result when NOR_ALU_OP, -- nor
		alu_result when SLTU_ALU_OP, -- sltu
		barrel_shifter_result when SLLV_ALU_OP, -- sllv
		barrel_shifter_result when SRLV_ALU_OP, -- srlv
		barrel_shifter_result when SRAV_ALU_OP, -- srav
		barrel_shifter_result when SLL_ALU_OP, -- sll
		barrel_shifter_result when SRL_ALU_OP, -- srl
		barrel_shifter_result when SRA_ALU_OP, -- sra
		x"00000000" when others;
end structure;