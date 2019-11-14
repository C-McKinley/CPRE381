-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_control_unit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file tests the control unit
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.opcode_t.all;


entity tb_control_unit is
	generic (gCLK_HPER : time := 100 ns);
end tb_control_unit;

architecture behavior of tb_control_unit is
	constant cCLK_PER : time := gCLK_HPER * 2;
	
component control_unit is
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
end component;
	signal s_opcode : std_logic_vector(6 - 1 downto 0);
	signal s_funct : std_logic_vector(6 - 1 downto 0);
	signal s_reg_dst : std_logic;
	signal s_jump : std_logic;
	signal s_CLK : std_logic;
	signal s_branch : std_logic;
	signal s_mem_read : std_logic;
	signal s_mem_to_reg : std_logic;
	signal s_mem_write : std_logic;
	signal s_alu_op :  std_logic_vector(6 - 1 downto 0);
	signal s_alu_src : std_logic;
	signal s_reg_write : std_logic;
	signal s_sign_ext : std_logic;
	signal s_lui : std_logic;
	signal s_bne : std_logic;
	signal s_jal : std_logic;
	signal s_jr : std_logic;
begin
	ctrl : control_unit
	port map(
		i_opcode => s_opcode,
		i_funct => s_funct,
		o_reg_dst => s_reg_dst,
		o_jump => s_jump,
		o_branch => s_branch,
		o_mem_read => s_mem_read,
		o_mem_to_reg => s_mem_to_reg,
		o_alu_op => s_alu_op,
		o_mem_write => s_mem_write,
		o_alu_src => s_alu_src,
		o_reg_write => s_reg_write,
		o_sign_ext => s_sign_ext,
		o_lui => s_lui,
		o_bne => s_bne,
		o_jal => s_jal,
		o_jr => s_jr
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
		s_opcode <= MIPS_R_OP;
		s_funct <= ADD_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "add_reg_dst" severity warning;
		assert s_jump = '0' report "add_jump" severity warning;
		assert s_branch = '0' report "add_branch" severity warning;
		assert s_mem_read = '0' report "add_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "add_mem_to_reg" severity warning;
		assert s_alu_op = ADD_ALU_OP report "add_alu_op" severity warning;
		assert s_mem_write = '0' report "add_mem_write" severity warning;
		assert s_alu_src = '0' report "add_alu_src" severity warning;
		assert s_sign_ext = '0' report "add_sign_ext" severity warning;
		assert s_lui = '0' report "add_lui" severity warning;
		assert s_bne = '0' report "add_bne" severity warning;
		assert s_jal = '0' report "add_jal" severity warning;
		assert s_jr = '0' report "add_jr" severity warning;



		s_opcode <= MIPS_R_OP;
		s_funct <= ADDU_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "addu_reg_dst" severity warning;
		assert s_jump = '0' report "addu_jump" severity warning;
		assert s_branch = '0' report "addu_branch" severity warning;
		assert s_mem_read = '0' report "addu_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "addu_mem_to_reg" severity warning;
		assert s_alu_op = ADD_ALU_OP report "addu_alu_op" severity warning;
		assert s_mem_write = '0' report "addu_mem_write" severity warning;
		assert s_alu_src = '0' report "addu_alu_src" severity warning;
		assert s_reg_write = '1' report "addu_reg_write" severity warning;
		assert s_sign_ext = '0' report "addu_sign_ext" severity warning;
		assert s_lui = '0' report "addu_lui" severity warning;
		assert s_bne = '0' report "addu_bne" severity warning;
		assert s_jal = '0' report "addu_jal" severity warning;
		assert s_jr = '0' report "addu_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= AND_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "and_reg_dst" severity warning;
		assert s_jump = '0' report "and_jump" severity warning;
		assert s_branch = '0' report "and_branch" severity warning;
		assert s_mem_read = '0' report "and_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "and_mem_to_reg" severity warning;
		assert s_alu_op = AND_ALU_OP report "and_alu_op" severity warning;
		assert s_mem_write = '0' report "and_mem_write" severity warning;
		assert s_alu_src = '0' report "and_alu_src" severity warning;
		assert s_reg_write = '1' report "and_reg_write" severity warning;
		assert s_sign_ext = '0' report "and_sign_ext" severity warning;
		assert s_lui = '0' report "and_lui" severity warning;
		assert s_bne = '0' report "and_bne" severity warning;
		assert s_jal = '0' report "and_jal" severity warning;
		assert s_jr = '0' report "and_jr" severity warning;

		s_opcode <= MIPS_R_OP;
		s_funct <= NOR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "nor_reg_dst" severity warning;
		assert s_jump = '0' report "nor_jump" severity warning;
		assert s_branch = '0' report "nor_branch" severity warning;
		assert s_mem_read = '0' report "nor_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "nor_mem_to_reg" severity warning;
		assert s_alu_op = NOR_ALU_OP report "nor_alu_op" severity warning;
		assert s_mem_write = '0' report "nor_mem_write" severity warning;
		assert s_alu_src = '0' report "nor_alu_src" severity warning;
		assert s_reg_write = '1' report "nor_reg_write" severity warning;
		assert s_sign_ext = '0' report "nor_sign_ext" severity warning;
		assert s_lui = '0' report "nor_lui" severity warning;
		assert s_bne = '0' report "nor_bne" severity warning;
		assert s_jal = '0' report "nor_jal" severity warning;
		assert s_jr = '0' report "nor_jr" severity warning;

		s_opcode <= MIPS_R_OP;
		s_funct <= XOR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "xor_reg_dst" severity warning;
		assert s_jump = '0' report "xor_jump" severity warning;
		assert s_branch = '0' report "xor_branch" severity warning;
		assert s_mem_read = '0' report "xor_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "xor_mem_to_reg" severity warning;
		assert s_alu_op = XOR_ALU_OP report "xor_alu_op" severity warning;
		assert s_mem_write = '0' report "xor_mem_write" severity warning;
		assert s_alu_src = '0' report "xor_alu_src" severity warning;
		assert s_reg_write = '1' report "xor_reg_write" severity warning;
		assert s_sign_ext = '0' report "xor_sign_ext" severity warning;
		assert s_lui = '0' report "xor_lui" severity warning;
		assert s_bne = '0' report "xor_bne" severity warning;
		assert s_jal = '0' report "xor_jal" severity warning;
		assert s_jr = '0' report "xor_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= OR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "or_reg_dst" severity warning;
		assert s_jump = '0' report "or_jump" severity warning;
		assert s_branch = '0' report "or_branch" severity warning;
		assert s_mem_read = '0' report "or_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "or_mem_to_reg" severity warning;
		assert s_alu_op = OR_ALU_OP report "or_alu_op" severity warning;
		assert s_mem_write = '0' report "or_mem_write" severity warning;
		assert s_alu_src = '0' report "or_alu_src" severity warning;
		assert s_reg_write = '1' report "or_reg_write" severity warning;
		assert s_sign_ext = '0' report "or_sign_ext" severity warning;
		assert s_lui = '0' report "or_lui" severity warning;
		assert s_bne = '0' report "or_bne" severity warning;
		assert s_jal = '0' report "or_jal" severity warning;
		assert s_jr = '0' report "or_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= SLT_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "slt_reg_dst" severity warning;
		assert s_jump = '0' report "slt_jump" severity warning;
		assert s_branch = '0' report "slt_branch" severity warning;
		assert s_mem_read = '0' report "slt_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "slt_mem_to_reg" severity warning;
		assert s_alu_op = SLT_ALU_OP report "slt_alu_op" severity warning;
		assert s_mem_write = '0' report "slt_mem_write" severity warning;
		assert s_alu_src = '0' report "slt_alu_src" severity warning;
		assert s_reg_write = '1' report "slt_reg_write" severity warning;
		assert s_sign_ext = '0' report "slt_sign_ext" severity warning;
		assert s_lui = '0' report "slt_lui" severity warning;
		assert s_bne = '0' report "slt_bne" severity warning;
		assert s_jal = '0' report "slt_jal" severity warning;
		assert s_jr = '0' report "slt_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= SLTU_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "sltu_reg_dst" severity warning;
		assert s_jump = '0' report "sltu_jump" severity warning;
		assert s_branch = '0' report "sltu_branch" severity warning;
		assert s_mem_read = '0' report "sltu_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "sltu_mem_to_reg" severity warning;
		assert s_alu_op = SLTU_ALU_OP report "sltu_alu_op" severity warning;
		assert s_mem_write = '0' report "sltu_mem_write" severity warning;
		assert s_alu_src = '0' report "sltu_alu_src" severity warning;
		assert s_reg_write = '1' report "sltu_reg_write" severity warning;
		assert s_sign_ext = '0' report "sltu_sign_ext" severity warning;
		assert s_lui = '0' report "sltu_lui" severity warning;
		assert s_bne = '0' report "sltu_bne" severity warning;
		assert s_jal = '0' report "sltu_jal" severity warning;
		assert s_jr = '0' report "sltu_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= SLL_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "sll_reg_dst" severity warning;
		assert s_jump = '0' report "sll_jump" severity warning;
		assert s_branch = '0' report "sll_branch" severity warning;
		assert s_mem_read = '0' report "sll_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "sll_mem_to_reg" severity warning;
		assert s_alu_op = SLL_ALU_OP report "sll_alu_op" severity warning;
		assert s_mem_write = '0' report "sll_mem_write" severity warning;
		assert s_alu_src = '1' report "sll_alu_src" severity warning;
		assert s_reg_write = '1' report "sll_reg_write" severity warning;
		assert s_sign_ext = '0' report "sll_sign_ext" severity warning;
		assert s_lui = '0' report "sll_lui" severity warning;
		assert s_bne = '0' report "sll_bne" severity warning;
		assert s_jal = '0' report "sll_jal" severity warning;
		assert s_jr = '0' report "sll_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= SRL_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "srl_reg_dst" severity warning;
		assert s_jump = '0' report "srl_jump" severity warning;
		assert s_branch = '0' report "srl_branch" severity warning;
		assert s_mem_read = '0' report "srl_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "srl_mem_to_reg" severity warning;
		assert s_alu_op = SRL_ALU_OP report "srl_alu_op" severity warning;
		assert s_mem_write = '0' report "srl_mem_write" severity warning;
		assert s_alu_src = '1' report "srl_alu_src" severity warning;
		assert s_reg_write = '1' report "srl_reg_write" severity warning;
		assert s_sign_ext = '0' report "srl_sign_ext" severity warning;
		assert s_lui = '0' report "srl_lui" severity warning;
		assert s_bne = '0' report "srl_bne" severity warning;
		assert s_jal = '0' report "srl_jal" severity warning;
		assert s_jr = '0' report "srl_jr" severity warning;

		s_opcode <= MIPS_R_OP;
		s_funct <= SRA_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "sra_reg_dst" severity warning;
		assert s_jump = '0' report "sra_jump" severity warning;
		assert s_branch = '0' report "sra_branch" severity warning;
		assert s_mem_read = '0' report "sra_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "sra_mem_to_reg" severity warning;
		assert s_alu_op = SRA_ALU_OP report "sra_alu_op" severity warning;
		assert s_mem_write = '0' report "sra_mem_write" severity warning;
		assert s_alu_src = '1' report "sra_alu_src" severity warning;
		assert s_reg_write = '1' report "sra_reg_write" severity warning;
		assert s_sign_ext = '0' report "sra_sign_ext" severity warning;
		assert s_lui = '0' report "sra_lui" severity warning;
		assert s_bne = '0' report "sra_bne" severity warning;
		assert s_jal = '0' report "sra_jal" severity warning;
		assert s_jr = '0' report "sra_jr" severity warning;

		s_opcode <= MIPS_R_OP;
		s_funct <= SLLV_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "sllv_reg_dst" severity warning;
		assert s_jump = '0' report "sllv_jump" severity warning;
		assert s_branch = '0' report "sllv_branch" severity warning;
		assert s_mem_read = '0' report "sllv_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "sllv_mem_to_reg" severity warning;
		assert s_alu_op = SLLV_ALU_OP report "sllv_alu_op" severity warning;
		assert s_mem_write = '0' report "sllv_mem_write" severity warning;
		assert s_alu_src = '0' report "sllv_alu_src" severity warning;
		assert s_reg_write = '1' report "sllv_reg_write" severity warning;
		assert s_sign_ext = '0' report "sllv_sign_ext" severity warning;
		assert s_lui = '0' report "sllv_lui" severity warning;
		assert s_bne = '0' report "sllv_bne" severity warning;
		assert s_jal = '0' report "sllv_jal" severity warning;
		assert s_jr = '0' report "sllv_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= SRLV_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "srlv_reg_dst" severity warning;
		assert s_jump = '0' report "srlv_jump" severity warning;
		assert s_branch = '0' report "srlv_branch" severity warning;
		assert s_mem_read = '0' report "srlv_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "srlv_mem_to_reg" severity warning;
		assert s_alu_op = SRLV_ALU_OP report "srlv_alu_op" severity warning;
		assert s_mem_write = '0' report "srlv_mem_write" severity warning;
		assert s_alu_src = '0' report "srlv_alu_src" severity warning;
		assert s_reg_write = '1' report "srlv_reg_write" severity warning;
		assert s_sign_ext = '0' report "srlv_sign_ext" severity warning;
		assert s_lui = '0' report "srlv_lui" severity warning;
		assert s_bne = '0' report "srlv_bne" severity warning;
		assert s_jal = '0' report "srlv_jal" severity warning;
		assert s_jr = '0' report "srlv_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= SRAV_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "srav_reg_dst" severity warning;
		assert s_jump = '0' report "srav_jump" severity warning;
		assert s_branch = '0' report "srav_branch" severity warning;
		assert s_mem_read = '0' report "srav_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "srav_mem_to_reg" severity warning;
		assert s_alu_op = SRAV_ALU_OP report "srav_alu_op" severity warning;
		assert s_mem_write = '0' report "srav_mem_write" severity warning;
		assert s_alu_src = '0' report "srav_alu_src" severity warning;
		assert s_reg_write = '1' report "srav_reg_write" severity warning;
		assert s_sign_ext = '0' report "srav_sign_ext" severity warning;
		assert s_lui = '0' report "srav_lui" severity warning;
		assert s_bne = '0' report "srav_bne" severity warning;
		assert s_jal = '0' report "srav_jal" severity warning;
		assert s_jr = '0' report "srav_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= SUB_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "sub_reg_dst" severity warning;
		assert s_jump = '0' report "sub_jump" severity warning;
		assert s_branch = '0' report "sub_branch" severity warning;
		assert s_mem_read = '0' report "sub_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "sub_mem_to_reg" severity warning;
		assert s_alu_op = SUB_ALU_OP report "sub_alu_op" severity warning;
		assert s_mem_write = '0' report "sub_mem_write" severity warning;
		assert s_alu_src = '0' report "sub_alu_src" severity warning;
		assert s_reg_write = '1' report "sub_reg_write" severity warning;
		assert s_sign_ext = '0' report "sub_sign_ext" severity warning;
		assert s_lui = '0' report "sub_lui" severity warning;
		assert s_bne = '0' report "sub_bne" severity warning;
		assert s_jal = '0' report "sub_jal" severity warning;
		assert s_jr = '0' report "sub_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= SUBU_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "subu_reg_dst" severity warning;
		assert s_jump = '0' report "subu_jump" severity warning;
		assert s_branch = '0' report "subu_branch" severity warning;
		assert s_mem_read = '0' report "subu_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "subu_mem_to_reg" severity warning;
		assert s_alu_op = SUB_ALU_OP report "subu_alu_op" severity warning;
		assert s_mem_write = '0' report "subu_mem_write" severity warning;
		assert s_alu_src = '0' report "subu_alu_src" severity warning;
		assert s_reg_write = '1' report "subu_reg_write" severity warning;
		assert s_sign_ext = '0' report "subu_sign_ext" severity warning;
		assert s_lui = '0' report "subu_lui" severity warning;
		assert s_bne = '0' report "subu_bne" severity warning;
		assert s_jal = '0' report "subu_jal" severity warning;
		assert s_jr = '0' report "subu_jr" severity warning;
		
		s_opcode <= MIPS_R_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "jr_reg_dst" severity warning;
		assert s_jump = '1' report "jr_jump" severity warning;
		assert s_branch = '0' report "jr_branch" severity warning;
		assert s_mem_read = '0' report "jr_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "jr_mem_to_reg" severity warning;
		assert s_alu_op = ADD_ALU_OP report "jr_alu_op" severity warning;
		assert s_mem_write = '0' report "jr_mem_write" severity warning;
		assert s_alu_src = '0' report "jr_alu_src" severity warning;
		assert s_reg_write = '0' report "jr_reg_write" severity warning;
		assert s_sign_ext = '0' report "jr_sign_ext" severity warning;
		assert s_lui = '0' report "jr_lui" severity warning;
		assert s_bne = '0' report "jr_bne" severity warning;
		assert s_jal = '0' report "jr_jal" severity warning;
		assert s_jr = '1' report "jr_jr" severity warning;

		s_opcode <= ADDI_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "addi_reg_dst" severity warning;
		assert s_jump = '0' report "addi_jump" severity warning;
		assert s_branch = '0' report "addi_branch" severity warning;
		assert s_mem_read = '0' report "addi_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "addi_mem_to_reg" severity warning;
		assert s_alu_op = ADD_ALU_OP report "addi_alu_op" severity warning;
		assert s_mem_write = '0' report "addi_mem_write" severity warning;
		assert s_alu_src = '1' report "addi_alu_src" severity warning;
		assert s_reg_write = '1' report "addi_reg_write" severity warning;
		assert s_sign_ext = '1' report "addi_sign_ext" severity warning;
		assert s_lui = '0' report "addi_lui" severity warning;
		assert s_bne = '0' report "addi_bne" severity warning;
		assert s_jal = '0' report "addi_jal" severity warning;
		assert s_jr = '0' report "addi_jr" severity warning;

		s_opcode <= ADDIU_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "addiu_reg_dst" severity warning;
		assert s_jump = '0' report "addiu_jump" severity warning;
		assert s_branch = '0' report "addiu_branch" severity warning;
		assert s_mem_read = '0' report "addiu_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "addiu_mem_to_reg" severity warning;
		assert s_alu_op = ADD_ALU_OP report "addiu_alu_op" severity warning;
		assert s_mem_write = '0' report "addiu_mem_write" severity warning;
		assert s_alu_src = '1' report "addiu_alu_src" severity warning;
		assert s_reg_write = '1' report "addiu_reg_write" severity warning;
		assert s_sign_ext = '1' report "addiu_sign_ext" severity warning;
		assert s_lui = '0' report "addiu_lui" severity warning;
		assert s_bne = '0' report "addiu_bne" severity warning;
		assert s_jal = '0' report "addiu_jal" severity warning;
		assert s_jr = '0' report "addiu_jr" severity warning;
		
		s_opcode <= ANDI_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "andi_reg_dst" severity warning;
		assert s_jump = '0' report "andi_jump" severity warning;
		assert s_branch = '0' report "andi_branch" severity warning;
		assert s_mem_read = '0' report "andi_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "andi_mem_to_reg" severity warning;
		assert s_alu_op = AND_ALU_OP report "andi_alu_op" severity warning;
		assert s_mem_write = '0' report "andi_mem_write" severity warning;
		assert s_alu_src = '1' report "andi_alu_src" severity warning;
		assert s_reg_write = '1' report "andi_reg_write" severity warning;
		assert s_sign_ext = '0' report "andi_sign_ext" severity warning;
		assert s_lui = '0' report "andi_lui" severity warning;
		assert s_bne = '0' report "andi_bne" severity warning;
		assert s_jal = '0' report "andi_jal" severity warning;
		assert s_jr = '0' report "andi_jr" severity warning;
		
		s_opcode <= LUI_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "lui_reg_dst" severity warning;
		assert s_jump = '0' report "lui_jump" severity warning;
		assert s_branch = '0' report "lui_branch" severity warning;
		assert s_mem_read = '1' report "lui_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "lui_mem_to_reg" severity warning;
		assert s_alu_op = SLL_ALU_OP report "lui_alu_op" severity warning;
		assert s_mem_write = '0' report "lui_mem_write" severity warning;
		assert s_alu_src = '1' report "lui_alu_src" severity warning;
		assert s_reg_write = '1' report "lui_reg_write" severity warning;
		assert s_sign_ext = '0' report "lui_sign_ext" severity warning;
		assert s_lui = '1' report "lui_lui" severity warning;
		assert s_bne = '0' report "lui_bne" severity warning;
		assert s_jal = '0' report "lui_jal" severity warning;
		assert s_jr = '0' report "lui_jr" severity warning;
		
		
		s_opcode <= LW_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "lw_reg_dst" severity warning;
		assert s_jump = '0' report "lw_jump" severity warning;
		assert s_branch = '0' report "lw_branch" severity warning;
		assert s_mem_read = '1' report "lw_mem_read" severity warning;
		assert s_mem_to_reg = '1' report "lw_mem_to_reg" severity warning;
		assert s_alu_op = ADD_ALU_OP report "lw_alu_op" severity warning;
		assert s_mem_write = '0' report "lw_mem_write" severity warning;
		assert s_alu_src = '1' report "lw_alu_src" severity warning;
		assert s_reg_write = '1' report "lw_reg_write" severity warning;
		assert s_sign_ext = '1' report "lw_sign_ext" severity warning;
		assert s_lui = '0' report "lw_lui" severity warning;
		assert s_bne = '0' report "lw_bne" severity warning;
		assert s_jal = '0' report "lw_jal" severity warning;
		assert s_jr = '0' report "lw_jr" severity warning;
		
		s_opcode <= XORI_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "xori_reg_dst" severity warning;
		assert s_jump = '0' report "xori_jump" severity warning;
		assert s_branch = '0' report "xori_branch" severity warning;
		assert s_mem_read = '0' report "xori_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "xori_mem_to_reg" severity warning;
		assert s_alu_op = XOR_ALU_OP report "xori_alu_op" severity warning;
		assert s_mem_write = '0' report "xori_mem_write" severity warning;
		assert s_alu_src = '1' report "xori_alu_src" severity warning;
		assert s_reg_write = '1' report "xori_reg_write" severity warning;
		assert s_sign_ext = '0' report "xori_sign_ext" severity warning;
		assert s_lui = '0' report "xori_lui" severity warning;
		assert s_bne = '0' report "xori_bne" severity warning;
		assert s_jal = '0' report "xori_jal" severity warning;
		assert s_jr = '0' report "xori_jr" severity warning;
		
		s_opcode <= ORI_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "ori_reg_dst" severity warning;
		assert s_jump = '0' report "ori_jump" severity warning;
		assert s_branch = '0' report "ori_branch" severity warning;
		assert s_mem_read = '0' report "ori_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "ori_mem_to_reg" severity warning;
		assert s_alu_op = OR_ALU_OP report "ori_alu_op" severity warning;
		assert s_mem_write = '0' report "ori_mem_write" severity warning;
		assert s_alu_src = '1' report "ori_alu_src" severity warning;
		assert s_reg_write = '1' report "ori_reg_write" severity warning;
		assert s_sign_ext = '0' report "ori_sign_ext" severity warning;
		assert s_lui = '0' report "ori_lui" severity warning;
		assert s_bne = '0' report "ori_bne" severity warning;
		assert s_jal = '0' report "ori_jal" severity warning;
		assert s_jr = '0' report "ori_jr" severity warning;
		
		s_opcode <= SLTI_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "slti_reg_dst" severity warning;
		assert s_jump = '0' report "slti_jump" severity warning;
		assert s_branch = '0' report "slti_branch" severity warning;
		assert s_mem_read = '0' report "slti_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "slti_mem_to_reg" severity warning;
		assert s_alu_op = SLT_ALU_OP report "slti_alu_op" severity warning;
		assert s_mem_write = '0' report "slti_mem_write" severity warning;
		assert s_alu_src = '1' report "slti_alu_src" severity warning;
		assert s_reg_write = '1' report "slti_reg_write" severity warning;
		assert s_sign_ext = '1' report "slti_sign_ext" severity warning;
		assert s_lui = '0' report "slti_lui" severity warning;
		assert s_bne = '0' report "slti_bne" severity warning;
		assert s_jal = '0' report "slti_jal" severity warning;
		assert s_jr = '0' report "slti_jr" severity warning;
		
		s_opcode <= SLTIU_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "sltiu_reg_dst" severity warning;
		assert s_jump = '0' report "sltiu_jump" severity warning;
		assert s_branch = '0' report "sltiu_branch" severity warning;
		assert s_mem_read = '0' report "sltiu_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "sltiu_mem_to_reg" severity warning;
		assert s_alu_op = SLTU_ALU_OP report "sltiu_alu_op" severity warning;
		assert s_mem_write = '0' report "sltiu_mem_write" severity warning;
		assert s_alu_src = '1' report "sltiu_alu_src" severity warning;
		assert s_reg_write = '1' report "sltiu_reg_write" severity warning;
		assert s_sign_ext = '1' report "sltiu_sign_ext" severity warning;
		assert s_lui = '0' report "sltiu_lui" severity warning;
		assert s_bne = '0' report "sltiu_bne" severity warning;
		assert s_jal = '0' report "sltiu_jal" severity warning;
		assert s_jr = '0' report "sltiu_jr" severity warning;
		
		s_opcode <= SW_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "sw_reg_dst" severity warning;
		assert s_jump = '0' report "sw_jump" severity warning;
		assert s_branch = '0' report "sw_branch" severity warning;
		assert s_mem_read = '0' report "sw_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "sw_mem_to_reg" severity warning;
		assert s_alu_op = ADD_ALU_OP report "sw_alu_op" severity warning;
		assert s_mem_write = '1' report "sw_mem_write" severity warning;
		assert s_alu_src = '1' report "sw_alu_src" severity warning;
		assert s_reg_write = '0' report "sw_reg_write" severity warning;
		assert s_sign_ext = '1' report "sw_sign_ext" severity warning;
		assert s_lui = '0' report "sw_lui" severity warning;
		assert s_bne = '0' report "sw_bne" severity warning;
		assert s_jal = '0' report "sw_jal" severity warning;
		assert s_jr = '0' report "sw_jr" severity warning;
		
		s_opcode <= BEQ_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "beq_reg_dst" severity warning;
		assert s_jump = '0' report "beq_jump" severity warning;
		assert s_branch = '1' report "beq_branch" severity warning;
		assert s_mem_read = '0' report "beq_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "beq_mem_to_reg" severity warning;
		assert s_alu_op = SUB_ALU_OP report "beq_alu_op" severity warning;
		assert s_mem_write = '0' report "beq_mem_write" severity warning;
		assert s_alu_src = '0' report "beq_alu_src" severity warning;
		assert s_reg_write = '0' report "beq_reg_write" severity warning;
		assert s_sign_ext = '0' report "beq_sign_ext" severity warning;
		assert s_lui = '0' report "beq_lui" severity warning;
		assert s_bne = '0' report "beq_bne" severity warning;
		assert s_jal = '0' report "beq_jal" severity warning;
		assert s_jr = '0' report "beq_jr" severity warning;
		
		s_opcode <= BNE_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "bne_reg_dst" severity warning;
		assert s_jump = '0' report "bne_jump" severity warning;
		assert s_branch = '1' report "bne_branch" severity warning;
		assert s_mem_read = '0' report "bne_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "bne_mem_to_reg" severity warning;
		assert s_alu_op = SUB_ALU_OP report "bne_alu_op" severity warning;
		assert s_mem_write = '0' report "bne_mem_write" severity warning;
		assert s_alu_src = '0' report "bne_alu_src" severity warning;
		assert s_reg_write = '0' report "bne_reg_write" severity warning;
		assert s_sign_ext = '0' report "bne_sign_ext" severity warning;
		assert s_lui = '0' report "bne_lui" severity warning;
		assert s_bne = '1' report "bne_bne" severity warning;
		assert s_jal = '0' report "bne_jal" severity warning;
		assert s_jr = '0' report "bne_jr" severity warning;
		
		s_opcode <= J_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "j_reg_dst" severity warning;
		assert s_jump = '1' report "j_jump" severity warning;
		assert s_branch = '0' report "j_branch" severity warning;
		assert s_mem_read = '0' report "j_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "j_mem_to_reg" severity warning;
		assert s_alu_op = NO_ALU_OP report "j_alu_op" severity warning;
		assert s_mem_write = '0' report "j_mem_write" severity warning;
		assert s_alu_src = '0' report "j_alu_src" severity warning;
		assert s_reg_write = '0' report "j_reg_write" severity warning;
		assert s_sign_ext = '0' report "j_sign_ext" severity warning;
		assert s_lui = '0' report "j_lui" severity warning;
		assert s_bne = '0' report "j_bne" severity warning;
		assert s_jal = '0' report "j_jal" severity warning;
		assert s_jr = '0' report "j_jr" severity warning;
		
		s_opcode <= JAL_MIPS_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '0' report "jal_reg_dst" severity warning;
		assert s_jump = '1' report "jal_jump" severity warning;
		assert s_branch = '0' report "jal_branch" severity warning;
		assert s_mem_read = '0' report "jal_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "jal_mem_to_reg" severity warning;
		assert s_alu_op = NO_ALU_OP report "jal_alu_op" severity warning;
		assert s_mem_write = '0' report "jal_mem_write" severity warning;
		assert s_alu_src = '0' report "jal_alu_src" severity warning;
		assert s_reg_write = '1' report "jal_reg_write" severity warning;
		assert s_sign_ext = '0' report "jal_sign_ext" severity warning;
		assert s_lui = '0' report "jal_lui" severity warning;
		assert s_bne = '0' report "jal_bne" severity warning;
		assert s_jal = '1' report "jal_jal" severity warning;
		assert s_jr = '0' report "jal_jr" severity warning;
		

	end process;
end behavior;