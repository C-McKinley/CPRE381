-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor 
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.opcode_t.all;

entity MIPS_Processor is
	generic (N : integer := 32);
	port (
		iCLK : in std_logic;
		iRST : in std_logic;
		iInstLd : in std_logic;
		iInstAddr : in std_logic_vector(N - 1 downto 0);
		iInstExt : in std_logic_vector(N - 1 downto 0);
		oALUOut : out std_logic_vector(N - 1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end MIPS_Processor;
architecture structure of MIPS_Processor is

	-- Required data memory signals
	signal s_DMemWr : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
	signal s_DMemAddr : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as the final data memory address input
	signal s_DMemData : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as the final data memory data input
	signal s_DMemOut : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as the data memory output

	-- Required register file signals
	signal s_RegWr : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
	signal s_RegWrAddr : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
	signal s_RegWrData : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as the final data memory data input

	-- Required instruction memory signals
	signal s_IMemAddr : std_logic_vector(N - 1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
	signal s_NextInstAddr : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
	signal s_Inst : std_logic_vector(N - 1 downto 0); -- TODO: use this signal as the instruction signal

	-- Required halt signal -- for simulation
	signal v0 : std_logic_vector(N - 1 downto 0); -- TODO: should be assigned to the output of register 2, used to implement the halt SYSCALL
	signal s_Halt : std_logic; -- TODO: this signal indicates to the simulation that intended program execution has completed. This case happens when the syscall instruction is observed and the V0 register is at 0x0000000A. This signal is active high and should only be asserted after the last register and memory writes before the syscall are guaranteed to be completed.

	component mem is
		generic (
			ADDR_WIDTH : integer;
			DATA_WIDTH : integer
		);
		port (
			clk : in std_logic;
			addr : in std_logic_vector((ADDR_WIDTH - 1) downto 0);
			data : in std_logic_vector((DATA_WIDTH - 1) downto 0);
			we : in std_logic := '1';
			q : out std_logic_vector((DATA_WIDTH - 1) downto 0)
		);
	end component;

	-- TODO: You may add any additional signals or components your implementation
	-- requires below this comment

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
	component sign_extender is
		port (
			i_in_16 : in std_logic_vector(16 - 1 downto 0); -- 16 bit input
			o_out_32 : out std_logic_vector(32 - 1 downto 0)); -- 32 bit output
	end component;
	component zero_extender is
		port (
			i_in_16 : in std_logic_vector(16 - 1 downto 0); -- 16 bit input
			o_out_32 : out std_logic_vector(32 - 1 downto 0)); -- 32 bit output
	end component;

	component register_file is
		port (
			i_clk : in std_logic; -- Clock input
			i_write_en : in std_logic; -- Write enable input
			i_rst : in std_logic;
			i_write_data : in std_logic_vector(32 - 1 downto 0); -- Write data
			i_rd : in std_logic_vector(5 - 1 downto 0); -- Write address
			i_rs : in std_logic_vector(5 - 1 downto 0); -- Read address A
			i_rt : in std_logic_vector(5 - 1 downto 0); -- Read address B
			o_data_a : out std_logic_vector(32 - 1 downto 0); -- Data output A
			o_data_b : out std_logic_vector(32 - 1 downto 0); -- Data output B
			o_v0 : out std_logic_vector(32 - 1 downto 0)
		);
	end component;
	component mux2_structure
		port (
			i_A : in std_logic;
			i_B : in std_logic;
			i_S : in std_logic;
			o_F : out std_logic
		);
	end component;

	component mux2_structure_generic
		port (
			i_A : in std_logic_vector(31 downto 0);
			i_B : in std_logic_vector(31 downto 0);
			i_S : in std_logic;
			o_F : out std_logic_vector(31 downto 0)
		);
	end component;

	component andg2 is
		port (
			i_A : in std_logic;
			i_B : in std_logic;
			o_F : out std_logic);

	end component;
	component alu is
		port (
			i_ctrl : in std_logic_vector(6 - 1 downto 0); -- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
			i_a : in std_logic_vector(32 - 1 downto 0);
			i_b : in std_logic_vector(32 - 1 downto 0);
			i_shamt : in std_logic_vector(5 - 1 downto 0);
			o_result : out std_logic_vector(32 - 1 downto 0);
			o_overflow : out std_logic;
			o_zero : out std_logic
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

	component n_bit_register is
		port (
			i_clk : in std_logic; -- Clock input
			i_rst : in std_logic; -- Reset input
			i_we : in std_logic; -- Load input
			i_in : in std_logic_vector(32 - 1 downto 0); -- Data value input
			o_out : out std_logic_vector(32 - 1 downto 0)); -- Data value output
	end component;

	component ex_mem_register is
		port (
		i_clk         : in std_logic; -- Clock input
		i_rst         : in std_logic; -- Reset input
		i_we          : in std_logic; -- Load input
		i_inst	:  in std_logic_vector(32 - 1 downto 0);
		i_wb          : in std_logic_vector(2 - 1 downto 0);
		i_mem         : in std_logic_vector(2 - 1 downto 0); 
		i_branch      : in std_logic;
		i_branch_addr : in std_logic_vector(32 - 1 downto 0); 
		i_alu_sum     : in std_logic_vector(32 - 1 downto 0); 
		i_alu_zero    : in std_logic; 
		i_rt_data     : in std_logic_vector(32 - 1 downto 0); 
		i_rd_addr     : in std_logic_vector(5 - 1 downto 0); 
		o_wb          : out std_logic_vector(2 - 1 downto 0);
		o_mem         : out std_logic_vector(2 - 1 downto 0);
		o_branch      : out std_logic;
		o_branch_addr : out std_logic_vector(32 - 1 downto 0);
		o_alu_sum     : out std_logic_vector(32 - 1 downto 0);
		o_alu_zero    : out std_logic;
		o_rt_data     : out std_logic_vector(32 - 1 downto 0);
		o_rd_addr     : out std_logic_vector(5 - 1 downto 0);
		o_inst : out std_logic_vector(32 - 1 downto 0)
		);

	end component;
	component id_ex_register is
		port (
		i_clk      : in std_logic; -- Clock input
		i_rst      : in std_logic; -- Reset input
		i_we       : in std_logic; -- Load input
		i_inst	   : in std_logic_vector(32 - 1 downto 0);
		i_shamt : in std_logic_vector(5 - 1 downto 0);
		i_data_b : in std_logic_vector(32 - 1 downto 0);
		i_wb       : in std_logic_vector(2 - 1 downto 0);
		i_mem      : in std_logic_vector(2 - 1 downto 0);
		i_ex       : in std_logic_vector(7 - 1 downto 0);
		i_pc       : in std_logic_vector(32 - 1 downto 0);
		i_rs_data  : in std_logic_vector(32 - 1 downto 0);
		i_rt_data  : in std_logic_vector(32 - 1 downto 0);
		i_sign_ext : in std_logic_vector(32 - 1 downto 0);
		i_rt_addr  : in std_logic_vector(5 - 1 downto 0);
		i_rd_addr  : in std_logic_vector(5 - 1 downto 0);
		o_wb       : out std_logic_vector(2 - 1 downto 0);
		o_mem      : out std_logic_vector(2 - 1 downto 0);
		o_alu_src  : out std_logic;
		o_alu_op   : out std_logic_vector(6 - 1 downto 0);
		o_pc       : out std_logic_vector(32 - 1 downto 0);
		o_rs_data  : out std_logic_vector(32 - 1 downto 0);
		o_rt_data  : out std_logic_vector(32 - 1 downto 0);
		o_sign_ext : out std_logic_vector(32 - 1 downto 0);
		o_rt_addr  : out std_logic_vector(5 - 1 downto 0);
		o_rd_addr  : out std_logic_vector(5 - 1 downto 0);
		o_inst : out std_logic_vector(32 - 1 downto 0);
		o_shamt: out std_logic_vector(5 - 1 downto 0);
		o_data_b : out std_logic_vector(32 - 1 downto 0)
		);

	end component;
	component if_id_register is
		port (
			i_clk : in std_logic; -- Clock input
			i_rst : in std_logic; -- Reset input
			i_we : in std_logic; -- Load input
			i_pc : in std_logic_vector(32 - 1 downto 0);
			i_inst : in std_logic_vector(32 - 1 downto 0);
			o_pc : out std_logic_vector(32 - 1 downto 0);
			o_inst : out std_logic_vector(32 - 1 downto 0)
		);
	end component;

	component mem_wb_register is
		port (
		i_clk     : in std_logic; -- Clock input
		i_rst     : in std_logic; -- Reset input
		i_we      : in std_logic; -- Load input
		i_inst_op : in std_logic_vector(6-1 downto 0);
		i_funct : in std_logic_vector(6-1 downto 0);
		i_v0 : in std_logic_vector(32 - 1 downto 0);
		i_mem     : in std_logic_vector(2 - 1 downto 0); 
		i_alu_sum : in std_logic_vector(32 - 1 downto 0); 
		i_data_q  : in std_logic_vector(32 - 1 downto 0);
		i_rd_addr : in std_logic_vector(5 - 1 downto 0); 
		o_mem      : out std_logic_vector(2 - 1 downto 0);
		o_alu_sum : out std_logic_vector(32 - 1 downto 0);
		o_data_q  : out std_logic_vector(32 - 1 downto 0);
		o_rd_addr : out std_logic_vector(5 - 1 downto 0);
		o_inst_op : out std_logic_vector(6-1 downto 0);
		o_funct : out std_logic_vector(6-1 downto 0);
		o_v0 : out std_logic_vector(32 - 1 downto 0)
		);
	end component;

	component pc_register is
		generic (N : integer := 32);
		port (
			i_clk : in std_logic; -- Clock input
			i_rst : in std_logic; -- Reset input
			i_we : in std_logic; -- Load input
			i_in : in std_logic_vector(N - 1 downto 0); -- Data value input
			o_out : out std_logic_vector(N - 1 downto 0)); -- Data value output

	end component;
	component full_adder_structure_generic is
		port (
			i_A : in std_logic_vector(32 - 1 downto 0);
			i_B : in std_logic_vector(32 - 1 downto 0);
			i_C : in std_logic;
			o_S : out std_logic_vector(32 - 1 downto 0);
			o_C : out std_logic);
	end component;
	component invg is
		port (
			i_A : in std_logic;
			o_F : out std_logic);
	end component;

	signal s_alu_opcode_id, s_alu_opcode_ex : std_logic_vector(6 - 1 downto 0);
	signal s_reg_addr_sel, s_reg_data_sel, s_pc_sel : std_logic_vector(2 - 1 downto 0);
	signal s_reg_dst, s_jump, s_branch, s_mem_read, s_mem_to_reg, s_alu_src_id, s_alu_src_ex, pc_write : std_logic;
	signal s_unsigned, s_zero, s_not_zero, s_compare_branch_equality, s_lui, s_bne, s_jal, s_jr : std_logic;
	signal s_shamt_id, s_shamt_ex : std_logic_vector (5 - 1 downto 0);
	signal s_overflow : std_logic;
	signal data_a, data_b, sel_data_b, zero_extended_immediate, sign_extended_immediate, extended_immediate, alu_result, return_reg_add : std_logic_vector(32 - 1 downto 0);
	signal branch_add, pc_mux1_res, branch_shift_res, jump_address, pc_val, temp_pc_addr : std_logic_vector(32 - 1 downto 0);
	signal pc_next : std_logic_vector(32 - 1 downto 0) := x"00400000";
	signal pc_mux1_sel : std_logic;
	signal s_flush : std_logic;
signal s_reg_write_addr_id, s_reg_write_addr_ex, s_reg_write_addr_mem : std_logic_vector (5 - 1 downto 0);
	
	signal s_inst_id, s_inst_if, s_inst_ex, s_inst_mem, s_inst_wb : std_logic_vector(32 - 1 downto 0);
	
	signal s_branch_add_ex, s_branch_add_mem : std_logic_vector(32 - 1 downto 0);
	signal s_alu_result_ex, s_alu_result_mem, s_alu_result_wb : std_logic_vector(32 - 1 downto 0);
	signal s_pc_val_id, s_pc_val_ex : std_logic_vector(32 - 1 downto 0);
	signal s_ex_id : std_logic_vector(7-1 downto 0);
	signal s_wb_id, s_wb_ex, s_wb_mem, s_wb_wb : std_logic_vector(2 - 1 downto 0);
	signal s_mem_id, s_mem_ex, s_mem_mem, s_mem_wb : std_logic_vector(2 - 1 downto 0);
	signal s_sign_ext_ex, s_sign_ext_mem : std_logic_vector(32 - 1 downto 0);
	signal s_rs_data_ex : std_logic_vector(32 - 1 downto 0);
	signal s_rt_data_ex, s_rt_data_mem : std_logic_vector(32 - 1 downto 0);
	signal s_rt_addr_id, s_rt_addr_ex : std_logic_vector(5 - 1 downto 0);
	signal s_rs_addr_id, s_rs_addr_ex : std_logic_vector(5 - 1 downto 0);
	signal s_rd_addr_id, s_rd_addr_ex , s_rd_addr_mem: std_logic_vector(5 - 1 downto 0);
	signal s_zero_ex, s_zero_mem : std_logic;
	signal s_branch_ex, s_branch_mem : std_logic;
	signal s_dmem_data_wb : std_logic_vector(32 - 1 downto 0);
	signal s_data_b_id, s_data_b_ex : std_logic_vector(32 - 1 downto 0);
	signal s_inst_op_id, s_inst_op_ex, s_inst_op_mem, s_inst_op_wb : std_logic_vector(5 downto 0);
	signal s_funct_id, s_funct_ex, s_fucnt_mem, s_funct_wb : std_logic_vector(5 downto 0);
	signal s_v0_id, s_v0_ex, s_v0_mem, s_v0_wb : std_logic_vector(32 - 1 downto 0);

begin

	-- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
	-- IF/ID
	with iInstLd select
		s_IMemAddr <= s_NextInstAddr when '0',
		iInstAddr when others;
	IMem : mem generic map(ADDR_WIDTH => 10, DATA_WIDTH => N)
	port map(
		clk => iCLK,
		addr => s_IMemAddr(11 downto 2),
		data => iInstExt,
		we => iInstLd,
		q => s_Inst
	);
	s_Halt <= '1' when (s_inst_op_wb = "000000") and (s_funct_wb = "001100") and (v0 = "00000000000000000000000000001010") else '0';
	s_flush <= '0';

	pc_adder : full_adder_structure_generic port map(i_A => s_IMemAddr, i_B => x"00000004", i_C => '0', o_S => pc_val, o_C => open);
	pc_reg : pc_register port map(
		i_clk => iCLK,
		i_rst => iRST,
		i_we => '1',
		i_in => pc_next,
		o_out => s_NextInstAddr);
	s_inst_if <= s_Inst;
	-- IF/ID
	if_id_reg : if_id_register
	port map(
		i_clk => iCLK,
		i_rst => iRST,
		i_we => '1',
		i_pc => pc_next,
		i_inst => s_inst_if,
		o_pc => s_pc_val_id,
		o_inst => s_inst_id);

	s_rd_addr_id <= s_inst_id(15 downto 11);
	s_rs_addr_id <= s_inst_id(25 downto 21);
	s_rt_addr_id <= s_inst_id(20 downto 16);

	--control module
	ctrl_unit : control_unit
	port map(
		i_opcode => s_inst_id(31 downto 26),
		i_funct => s_inst_id(6 - 1 downto 0),
		o_reg_dst => s_reg_dst,
		o_jump => s_jump,
		o_branch => s_branch,
		o_mem_read => s_mem_read,
		o_mem_to_reg => s_mem_to_reg,
		o_alu_op => s_alu_opcode_id,
		o_mem_write => s_DMemWr,
		o_alu_src => s_alu_src_id,
		o_reg_write => s_RegWr,
		o_sign_ext => s_unsigned,
		o_lui => s_lui,
		o_bne => s_bne,
		o_jal => s_jal,
		o_jr => s_jr
	);
	zextend : zero_extender port map(i_in_16 => s_inst_id(15 downto 0), o_out_32 => zero_extended_immediate);
	sextend : sign_extender port map(i_in_16 => s_inst_id(15 downto 0), o_out_32 => sign_extended_immediate);
	-- extender
	with s_unsigned select extended_immediate <= sign_extended_immediate when '1', zero_extended_immediate when others;
	reg_file : register_file
	port map(
		i_clk => iCLK, i_write_en => s_RegWr, i_rst => iRST, i_write_data => s_RegWrData,
		i_rd => s_RegWrAddr, i_rs => s_rs_addr_id, i_rt => s_rt_addr_id,
		o_data_a => data_a, o_data_b => data_b, o_v0 => v0
	);
	-- destination select 
	with s_reg_addr_sel select s_RegWrAddr <=
		"11111" when "11",
		"11111" when "10",
		s_rd_addr_id when "01",
		s_rt_addr_id when "00",
		"00000" when others;
	s_ex_id <=  s_alu_src_id & s_alu_opcode_id;
	s_wb_id <= s_DMemWr & s_RegWr;
	s_mem_id <= s_jal & s_mem_to_reg; --s_mem_to_reg & s_RegWr;
	with s_alu_src_id select s_data_b_id <= extended_immediate when '1', data_b when others;
	with s_lui select s_shamt_id <= "10000" when '1', s_inst_id(10 downto 6) when others;
	-- ID/EX
	id_ex_reg : id_ex_register
	port map (
			i_clk => iCLK,
		i_rst => iRST,
		i_we => '1',
		i_inst => s_inst_id,
		i_shamt => s_shamt_id,
		i_data_b => s_data_b_id,
			i_wb => s_wb_id,
			i_mem => s_mem_id,
			i_ex => s_ex_id,
			i_pc => s_pc_val_id,
			i_rs_data => data_a,
			i_rt_data => data_b,
			i_sign_ext => sign_extended_immediate,
			i_rt_addr => s_rt_addr_id,
			i_rd_addr => s_RegWrAddr,
			o_wb => s_wb_ex,
			o_mem => s_mem_ex,
			o_alu_src => s_alu_src_ex,
			o_alu_op => s_alu_opcode_ex,
			o_pc => s_pc_val_ex,
			o_rs_data => s_rs_data_ex,
			o_rt_data => s_rt_data_ex,
			o_sign_ext => s_sign_ext_ex,
			o_rt_addr => s_rt_addr_ex,
			o_rd_addr => s_rd_addr_ex,
			o_inst => s_inst_ex,
		o_shamt => s_shamt_ex,
		o_data_b => s_data_b_ex
		);
	--with s_reg_dst select s_RegWrAddr <= s_rt when '0', s_rd when others;
	s_reg_addr_sel(1) <= s_jal;
	s_reg_addr_sel(0) <= s_reg_dst;
	-- imm mux
	
	
	branch_shift_res <= s_sign_ext_ex(29 downto 0) & "00";
	branch_adder : full_adder_structure_generic port map(i_A => s_pc_val_ex, i_B => branch_shift_res, i_C => '0', o_S => s_branch_add_ex, o_C => open);
	jump_address <= s_pc_val_ex(31 downto 28) & s_inst_ex(26 - 1 downto 0) & "00";
	alu_compute : alu port map(i_ctrl => s_alu_opcode_ex, i_a => data_a, i_b => s_data_b_ex, i_shamt => s_shamt_ex, o_result => s_alu_result_ex, o_overflow => s_overflow, o_zero => s_zero_ex);
	s_DMemAddr <= s_alu_result_ex;
	s_DMemData <= data_b;
	oALUOut <= s_alu_result_ex;
		-- EX/MEM
		ex_mem_reg : ex_mem_register
		port map(
			i_clk => iCLK,
			i_rst => iRST,
			i_we => '1',
			i_inst => s_inst_ex,
			i_wb => s_wb_ex,
			i_mem => s_mem_ex,
			i_branch => s_branch_ex,
			i_branch_addr => s_branch_add_ex,
			i_alu_sum => s_alu_result_ex, 
			i_alu_zero => s_zero_ex,
			i_rt_data => s_rt_data_ex, 
			i_rd_addr => s_rd_addr_ex, 
			o_wb => s_wb_mem, 
			o_mem => s_mem_mem,
			o_branch => s_branch_mem,
			o_branch_addr => s_branch_add_mem,
			o_alu_sum => s_alu_result_mem,
			o_alu_zero => s_zero_mem,
			o_rt_data => s_rt_data_mem, 
			o_rd_addr => s_rd_addr_mem,
		o_inst => s_inst_mem
		);
	not_zero : invg port map(i_A => s_zero, o_F => s_not_zero);
	with s_bne select s_compare_branch_equality <= s_not_zero when '1', s_zero when others;
	DMem : mem
	generic map(ADDR_WIDTH => 10, DATA_WIDTH => N)
	port map(
		clk => iCLK,
		addr => s_DMemAddr(11 downto 2),
		data => s_DMemData,
		we => s_DMemWr,
		q => s_DMemOut
	);
	br_and : andg2 port map(i_A => s_branch, i_B => s_compare_branch_equality, o_F => pc_mux1_sel);
s_inst_op_mem <= s_inst_mem(31 downto 26);
s_fucnt_mem <= s_inst_mem(5 downto 0);
	-- MEM/WB
	mem_wb_reg : mem_wb_register
	port map(
		i_clk => iCLK,
			i_rst => iRST,
			i_we => '1',
			i_inst_op => s_inst_op_mem,
			i_v0 => s_v0_mem,
			i_funct => s_fucnt_mem,
			i_mem => s_mem_mem,
			i_alu_sum => s_alu_result_mem,
			i_data_q => s_DMemOut, 
			i_rd_addr => s_rd_addr_mem,
			o_mem => s_mem_wb,
			o_alu_sum => s_alu_result_wb,
			o_data_q => s_dmem_data_wb,
			o_rd_addr => s_reg_write_addr_mem,
			o_inst_op => s_inst_op_wb,
			o_funct => s_funct_wb,
			o_v0 =>  s_v0_wb
	);

	

	-- write_data mux
	-- with s_mem_to_reg select s_reg_write_data <= s_DMemOut when '1', alu_result when others;
	-- jal/write_data mux 
	--s_reg_data_sel <= s_jal & s_mem_mem(0);
	with s_mem_wb select s_RegWrData <=
		return_reg_add when "11",
		return_reg_add when "10",
	 	s_dmem_data_wb when "01",
		s_alu_result_wb when "00",
		x"00000000" when others;
	--s_RegWrAddr <= s_reg_write_addr_mem;

	-- branch and jumps

	s_pc_sel <= s_jump & pc_mux1_sel;
	with s_pc_sel select temp_pc_addr <=
		pc_val when "00",
		branch_add when "01",
		jump_address when "10",
		jump_address when "11",
		x"00000000" when others;
	with s_jr select pc_next <= temp_pc_addr when '0', data_a when others;
	--with  select pc_next <= pc_mux1_res when '0', jump_address when others;
	return_reg_add <= pc_val;

end structure;
