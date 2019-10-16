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
	constant ADD_ALU_OP : std_logic_vector(6 - 1 downto 0) := "000000";
	constant SUB_ALU_OP : std_logic_vector(6 - 1 downto 0) := "000001";
	constant SLT_ALU_OP : std_logic_vector(6 - 1 downto 0) := "000010";
	constant AND_ALU_OP : std_logic_vector(6 - 1 downto 0) := "000011";
	constant OR_ALU_OP  : std_logic_vector(6 - 1 downto 0) := "000100";
	constant XOR_ALU_OP : std_logic_vector(6 - 1 downto 0) := "000101";
	-- No NAND in Proj B
	constant NAND_ALU_OP : std_logic_vector(6 - 1 downto 0) := "000110";
	constant NOR_ALU_OP  : std_logic_vector(6 - 1 downto 0) := "000111";
	constant SLL_ALU_OP  : std_logic_vector(6 - 1 downto 0) := "001000";
	constant SRL_ALU_OP  : std_logic_vector(6 - 1 downto 0) := "001001";
	constant SRA_ALU_OP  : std_logic_vector(6 - 1 downto 0) := "001010";
	constant SLLV_ALU_OP : std_logic_vector(6 - 1 downto 0) := "001011";
	constant SRLV_ALU_OP : std_logic_vector(6 - 1 downto 0) := "001100";
	constant SRAV_ALU_OP : std_logic_vector(6 - 1 downto 0) := "001101";
	constant STLU_ALU_OP : std_logic_vector(6 - 1 downto 0) := "001110";
	constant NO_ALU_OP : std_logic_vector(6 - 1 downto 0) := "111111";

	-- Do not believe I need these
	-- Remember to update the opcodes if they are needed
	constant LW_OP : std_logic_vector(6 - 1 downto 0) := "001100";
	constant SW_OP : std_logic_vector(6 - 1 downto 0) := "001101";
 
	-- MIPS OPCODES and FUNCTION CODES
	constant MIPS_R_OP : std_logic_vector(6 - 1 downto 0) := "000000";
	constant ADDI_MIPS_OP   : std_logic_vector(6 - 1 downto 0) := "001000";
	constant ADDIU_MIPS_OP  : std_logic_vector(6 - 1 downto 0) := "001001";
	constant ANDI_MIPS_OP   : std_logic_vector(6 - 1 downto 0) := "001100";
	constant LUI_MIPS_OP    : std_logic_vector(6 - 1 downto 0) := "001111";
	constant LW_MIPS_OP     : std_logic_vector(6 - 1 downto 0) := "100011";
	constant XORI_MIPS_OP   : std_logic_vector(6 - 1 downto 0) := "001110";
	constant ORI_MIPS_OP    : std_logic_vector(6 - 1 downto 0) := "001101";
	constant SLTI_MIPS_OP   : std_logic_vector(6 - 1 downto 0) := "001010";
	constant SLTIU_MIPS_OP  : std_logic_vector(6 - 1 downto 0) := "001011";
	constant SW_MIPS_OP     : std_logic_vector(6 - 1 downto 0) := "101011";
	constant BEQ_MIPS_OP    : std_logic_vector(6 - 1 downto 0) := "000100";
	constant BNE_MIPS_OP    : std_logic_vector(6 - 1 downto 0) := "000101";
	constant J_MIPS_OP      : std_logic_vector(6 - 1 downto 0) := "000010";
	constant JAL_MIPS_OP    : std_logic_vector(6 - 1 downto 0) := "000011";
 
	constant ADD_MIPS_FUNC  : std_logic_vector(6 - 1 downto 0) := "100000";
	constant ADDU_MIPS_FUNC : std_logic_vector(6 - 1 downto 0) := "100001";
	constant AND_MIPS_FUNC  : std_logic_vector(6 - 1 downto 0) := "100100";
	constant NOR_MIPS_FUNC  : std_logic_vector(6 - 1 downto 0) := "100111";
	constant XOR_MIPS_FUNC  : std_logic_vector(6 - 1 downto 0) := "100110";
	constant OR_MIPS_FUNC   : std_logic_vector(6 - 1 downto 0) := "100101";
	constant SLT_MIPS_FUNC  : std_logic_vector(6 - 1 downto 0) := "101010";
	constant SLTU_MIPS_FUNC : std_logic_vector(6 - 1 downto 0) := "101011";
	constant SLL_MIPS_FUNC  : std_logic_vector(6 - 1 downto 0) := "000000";
	constant SRL_MIPS_FUNC  : std_logic_vector(6 - 1 downto 0) := "000010";
	constant SRA_MIPS_FUNC  : std_logic_vector(6 - 1 downto 0) := "000011";
	constant SLLV_MIPS_FUNC : std_logic_vector(6 - 1 downto 0) := "000100";
	constant SRLV_MIPS_FUNC : std_logic_vector(6 - 1 downto 0) := "000110";
	constant SRAV_MIPS_FUNC : std_logic_vector(6 - 1 downto 0) := "000111";
	constant SUB_MIPS_FUNC  : std_logic_vector(6 - 1 downto 0) := "100010";
	constant SUBU_MIPS_FUNC : std_logic_vector(6 - 1 downto 0) := "100011";
	constant JR_MIPS_FUNC   : std_logic_vector(6 - 1 downto 0) := "001000";

end package opcode_t;