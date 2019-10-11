-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- opcode_t.vhd
-- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
-------------------------------------------------------------------------
-- DESCRIPTION: This file creates an array of 32, 32 bit vectors
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package opcode_t is
	constant ADD_OP  : std_logic_vector(6 - 1 downto 0) := "000000";
	constant SUB_OP  : std_logic_vector(6 - 1 downto 0) := "000001";
	constant SLT_OP  : std_logic_vector(6 - 1 downto 0) := "000010";
	constant AND_OP  : std_logic_vector(6 - 1 downto 0) := "000011";
	constant OR_OP   : std_logic_vector(6 - 1 downto 0) := "000100";
	constant XOR_OP  : std_logic_vector(6 - 1 downto 0) := "000101";
	constant NAND_OP : std_logic_vector(6 - 1 downto 0) := "000110";
	constant NOR_OP  : std_logic_vector(6 - 1 downto 0) := "000111";
	constant SLL_OP  : std_logic_vector(6 - 1 downto 0) := "001000";
	constant SRL_OP  : std_logic_vector(6 - 1 downto 0) := "001001";
	constant SRA_OP  : std_logic_vector(6 - 1 downto 0) := "001011";
end package opcode_t;