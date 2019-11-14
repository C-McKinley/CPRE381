-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- control_unit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32 bit alu
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_misc.or_reduce;
use work.opcode_t.all;

entity control_unit is
	port (
		i_opcode : in std_logic_vector(6 - 1 downto 0);
		i_funct : in std_logic_vector(6 - 1 downto 0);
		o_reg_dst : out std_logic;
		o_jump : out std_logic;
		o_branch : out std_logic;
		o_mem_read : out std_logic;
		o_mem_to_reg : out std_logic;
		o_alu_op : out std_logic_vector(6 - 1 downto 0);
		o_mem_write : out std_logic;
		o_alu_src : out std_logic;
		o_reg_write : out std_logic;
		o_sign_ext : out std_logic;
		o_lui : out std_logic;
		o_bne : out std_logic;
		o_jal : out std_logic;
		o_jr : out std_logic
	);
end control_unit;

architecture structure of control_unit is
	-- ctrl format [0:{reg_dst} 1:{jump} 2:{branch} 3:{mem_read} 4:{mem_write} 5:{mem_to_reg} 6:11{alu_op} 12:{alu_src} 13:{reg_write}]
	signal s_control : std_logic_vector(19 - 1 downto 0);
	signal s_funct_ctrl : std_logic_vector(19 - 1 downto 0);
begin
	with i_funct select s_funct_ctrl <=
	--	JR    JAL   BNE   LUI  Sign   RGDT  JMP   BR    MRd   MW    MRg   ALU_CTRL     ASRC  RW
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & ADD_ALU_OP & "0" & "1" when ADD_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & ADD_ALU_OP & "0" & "1" when ADDU_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & AND_ALU_OP & "0" & "1" when AND_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & NOR_ALU_OP & "0" & "1" when NOR_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & XOR_ALU_OP & "0" & "1" when XOR_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & OR_ALU_OP & "0" & "1" when OR_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & SLT_ALU_OP & "0" & "1" when SLT_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & SLTU_ALU_OP & "0" & "1" when SLTU_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & SLL_ALU_OP & "0" & "1" when SLL_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & SRL_ALU_OP & "0" & "1" when SRL_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & SRA_ALU_OP & "0" & "1" when SRA_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & SLLV_ALU_OP & "0" & "1" when SLLV_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & SRLV_ALU_OP & "0" & "1" when SRLV_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & SRAV_ALU_OP & "0" & "1" when SRAV_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & SUB_ALU_OP & "0" & "1" when SUB_MIPS_FUNC, 
		"0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & SUB_ALU_OP & "0" & "1" when SUBU_MIPS_FUNC, 
		"1" & "0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & ADD_ALU_OP & "0" & "0" when JR_MIPS_FUNC, 
		"0000000000000000000" when others;
	with i_opcode select s_control <= 
	--	 0     1     2     3     4     5    6:11         12    13
	--  	JR    JAL   BNE   LUI  Sign  RGDT   JMP   BR    MRd   MW    MRg   ALU_CTRL     ASRC  RW
		s_funct_ctrl when MIPS_R_OP,
		"0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & "0" & ADD_ALU_OP & "1" & "1" when ADDI_MIPS_OP, 
		"0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & "0" & ADD_ALU_OP & "1" & "1" when ADDIU_MIPS_OP, 
		"0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & AND_ALU_OP & "1" & "1" when ANDI_MIPS_OP, 
		"0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & SLL_ALU_OP & "1" & "1" when LUI_MIPS_OP, 
		"0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "1" & "0" & "1" & ADD_ALU_OP & "1" & "1" when LW_MIPS_OP,
		"0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & XOR_ALU_OP & "1" & "1" when XORI_MIPS_OP, 
		"0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & OR_ALU_OP & "1" & "1" when ORI_MIPS_OP, 
		"0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & "0" & SLT_ALU_OP & "1" & "1" when SLTI_MIPS_OP, 
		"0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "0" & "0" & SLTU_ALU_OP & "1" & "1" when SLTIU_MIPS_OP, 
		"0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & "1" & "0" & ADD_ALU_OP & "1" & "0" when SW_MIPS_OP, 
		"0" & "0" & "0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & SUB_ALU_OP & "0" & "0" when BEQ_MIPS_OP, 
		"0" & "0" & "1" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & SUB_ALU_OP & "0" & "0" when BNE_MIPS_OP, 
		"0" & "0" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & NO_ALU_OP & "0" & "0" when J_MIPS_OP, 
		"0" & "1" & "0" & "0" & "0" & "0" & "1" & "0" & "0" & "0" & "0" & NO_ALU_OP & "0" & "1" when JAL_MIPS_OP, 
		"0000000000000000000" when others;
	-- drive outputs
	o_jr <= s_control(18);
	o_jal <= s_control(17);
	o_bne <= s_control(16);
	o_lui <= s_control(15);
	o_sign_ext <= s_control(14);
	o_reg_dst <= s_control(13);
	o_jump <= s_control(12);
	o_branch <= s_control(11);
	o_mem_read <= s_control(10);
	o_mem_write <= s_control(9);
	o_mem_to_reg <= s_control(8);
	o_alu_op <= s_control(7 downto 2);
	o_alu_src <= s_control(1);
	o_reg_write <= s_control(0);
end structure;