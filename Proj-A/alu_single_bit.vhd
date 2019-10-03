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

entity alu_single_bit is
  port(i_ctrl : in std_logic_vector(4-1 downto 0); -- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
	i_a: in std_logic;
	i_b: in std_logic;
	o_f: out std_logic);
end alu_single_bit;

architecture structure of alu_single_bit is

component full_adder_structure is
	port( i_A  : in std_logic;
       i_B  : in std_logic;
       i_C  : in std_logic;
       o_S  : out std_logic;
       o_C  : out std_logic);
end component;

-- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
signal data_a, data_b, write_data, alu_sum, sel_data_b, extended_immediate, zero_extended_immediate, sign_extended_immediate, mem_q: std_logic_vector(31 downto 0);
signal mem_addr: std_logic_vector(10-1 downto 0);
signal add_sub_res, slt_res, and_res, or_res, xor_res, nand_res, nor_res : std_logic;
signal cout, n_add_sub: std_logic;
begin
-- n_add_sub
with i_ctrl select n_add_sub <=
	'0' when "0000", -- add
	'1' when "0001", -- sub
	'1' when "0011", -- slt
	'0' when others;
-- output mux
with i_ctrl select o_f <=
	add_sub_res when "0000", -- add
	add_sub_res when "0001", -- sub
	slt_res when "0011", -- slt
	and_res when "0100", -- and
	or_res when "0101", -- or
	xor_res when "0110", -- xor
	nand_res when "0111", -- nand
	nor_res when "1000", -- nor
	'0' when others;
-- full adder
adder: full_adder_structure port map(i_A => i_a, i_B => i_b, i_C => n_add_sub, o_S => add_sub_res, o_C => cout);
-- slt
slt_res <= add_sub_res and '1';
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

end structure;  