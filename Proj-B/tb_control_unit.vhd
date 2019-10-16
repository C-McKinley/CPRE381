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
		o_reg_write : out std_logic
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
		o_reg_write => s_reg_write
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
		assert s_reg_write = '1' report "add_reg_write" severity warning;


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

		s_opcode <= MIPS_R_OP;
		s_funct <= SLTU_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "sltu_reg_dst" severity warning;
		assert s_jump = '0' report "sltu_jump" severity warning;
		assert s_branch = '0' report "sltu_branch" severity warning;
		assert s_mem_read = '0' report "sltu_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "sltu_mem_to_reg" severity warning;
		assert s_alu_op = SLT_ALU_OP report "sltu_alu_op" severity warning;
		assert s_mem_write = '0' report "sltu_mem_write" severity warning;
		assert s_alu_src = '0' report "sltu_alu_src" severity warning;
		assert s_reg_write = '1' report "sltu_reg_write" severity warning;
		
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
		
		s_opcode <= MIPS_R_OP;
		s_funct <= JR_MIPS_FUNC;
		wait for gCLK_HPER;
		assert s_reg_dst = '1' report "jr_reg_dst" severity warning;
		assert s_jump = '0' report "jr_jump" severity warning;
		assert s_branch = '0' report "jr_branch" severity warning;
		assert s_mem_read = '0' report "jr_mem_read" severity warning;
		assert s_mem_to_reg = '0' report "jr_mem_to_reg" severity warning;
		assert s_alu_op = NO_ALU_OP report "jr_alu_op" severity warning;
		assert s_mem_write = '0' report "jr_mem_write" severity warning;
		assert s_alu_src = '1' report "jr_alu_src" severity warning;
		assert s_reg_write = '1' report "jr_reg_write" severity warning;

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

	end process;
end behavior;