-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- alu_single_bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a single bit alu
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.opcode_t.all;

entity alu_single_bit is
	port 
	(
		i_ctrl : in std_logic_vector(6 - 1 downto 0); -- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
		i_a    : in std_logic;
		i_b    : in std_logic;
		i_cin  : in std_logic;
		i_less : in std_logic;
		o_f    : out std_logic;
		o_cout : out std_logic;
		o_set  : out std_logic;
		o_overflow: out std_logic
	);
end alu_single_bit;

architecture mixed of alu_single_bit is

	component full_adder_structure is
		port 
		(
			i_A : in std_logic;
			i_B : in std_logic;
			i_C : in std_logic;
			o_S : out std_logic;
			o_C : out std_logic
		);
	end component;

	-- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
	signal add_sub_res, slt_res, and_res, or_res, xor_res, nand_res, nor_res : std_logic;
	signal s_overflow, s_cout, s_b, s_carry                                          : std_logic;
	signal addsub : std_logic;
begin
	-- set b
	s_b <= addsub xor i_b;
	-- overflow
	s_overflow <= i_cin xor s_cout;
	--s_overflow <= (i_a and s_b and (not add_sub_res)) or ((not i_a) and(not s_b) and add_sub_res);
	o_overflow <= s_overflow;
	with i_ctrl select addsub <= 
		'1' when SUB_ALU_OP, -- sub
		'1' when SLT_ALU_OP, -- slt
		'1' when SLTU_ALU_OP, -- sltu
		'0' when others;
	with i_ctrl select s_carry <= 
		'1' when SUB_ALU_OP, -- sub
		'1' when SLT_ALU_OP, -- slt
		'1' when SLTU_ALU_OP, -- sltu
		i_cin when ADD_ALU_OP,
		'0' when others;
	-- output mux
	with i_ctrl select o_f <= 
		add_sub_res when ADD_ALU_OP, -- add
		add_sub_res when SUB_ALU_OP, -- sub
		slt_res when SLT_ALU_OP, -- slt
		slt_res when SLTU_ALU_OP,
		and_res when AND_ALU_OP, -- and
		or_res when OR_ALU_OP, -- or
		xor_res when XOR_ALU_OP, -- xor
		nand_res when NAND_ALU_OP, -- nand
		nor_res when NOR_ALU_OP, -- nor
		'0' when others;
		o_cout <= s_cout;
	with i_ctrl select o_set <= 
		s_overflow xor add_sub_res when SLT_ALU_OP,
		not s_cout when SLTU_ALU_OP,
		'0' when others;
		--o_set  <=  add_sub_res;
		-- full adder
		adder : full_adder_structure
		port map(i_A => i_a, i_B => s_b, i_C => i_cin, o_S => add_sub_res, o_C => s_cout);
	-- slt
	slt_res <= i_less;
	-- and
	and_res <= i_a and i_b;
	-- or
	or_res <= i_a or i_b;
	-- xor
	xor_res <= i_a xor i_b;
	-- nand
	nand_res <= i_a nand i_b;
	-- nor
	nor_res <= i_a nor i_b;

end mixed;