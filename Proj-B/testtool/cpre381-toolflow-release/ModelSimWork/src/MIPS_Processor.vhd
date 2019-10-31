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
		port(
			i_clk : in std_logic;     -- Clock input
       			i_write_en : in std_logic;     -- Write enable input
			i_rst : in std_logic;
       			i_write_data  : in std_logic_vector(32-1 downto 0);     -- Write data
       			i_rd  : in std_logic_vector(5-1 downto 0);     -- Write address
	  		i_rs  : in std_logic_vector(5-1 downto 0);     -- Read address A
	   		i_rt  : in std_logic_vector(5-1 downto 0);     -- Read address B
       			o_data_a : out std_logic_vector(32-1 downto 0);	-- Data output A
	   		o_data_b : out std_logic_vector(32-1 downto 0); -- Data output B
	   		o_v0 : out std_logic_vector(32-1 downto 0)
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
component full_adder_structure_generic is
  port(i_A  : in std_logic_vector(32-1 downto 0);
       i_B  : in std_logic_vector(32-1 downto 0);
       i_C  : in std_logic;
       o_S  : out std_logic_vector(32-1 downto 0);
       o_C  : out std_logic);
end component;
component invg is
  port(i_A          : in std_logic;
       o_F          : out std_logic);
end component;

	signal s_alu_opcode : std_logic_vector(6 - 1 downto 0);
	signal s_reg_addr_sel, s_reg_data_sel, s_pc_sel : std_logic_vector(2 - 1 downto 0);
	signal s_reg_dst, s_jump, s_branch, s_mem_read, s_mem_to_reg, s_alu_src, pc_write : std_logic;
	signal s_unsigned, s_zero, s_not_zero, s_compare_branch_equality, s_lui, s_bne, s_jal, s_jr : std_logic;
	signal s_rs, s_rt, s_rd, s_shamt: std_logic_vector (5 - 1 downto 0);
	signal s_overflow : std_logic;
	signal data_a, data_b, sel_data_b, zero_extended_immediate, sign_extended_immediate, extended_immediate, alu_result, return_reg_add : std_logic_vector(32 - 1 downto 0);
	signal branch_add, pc_mux1_res, branch_shift_res, jump_address, pc_val, pc_next, temp_pc_addr : std_logic_vector(32 - 1 downto 0);
	signal pc_mux1_sel : std_logic;

begin
	-- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
	with iInstLd select
		s_IMemAddr <= s_NextInstAddr when '0',
		iInstAddr when others;
	IMem : mem
	generic map(ADDR_WIDTH => 10, DATA_WIDTH => N)
	port map(
		clk => iCLK,
		addr => s_IMemAddr(11 downto 2),
		data => iInstExt,
		we => iInstLd,
		q => s_Inst
	);

	DMem : mem
	generic map(ADDR_WIDTH => 10, DATA_WIDTH => N)
	port map(
		clk => iCLK,
		addr => s_DMemAddr(11 downto 2),
		data => s_DMemData,
		we => s_DMemWr,
		q => s_DMemOut
	);

	s_Halt <= '1' when (s_Inst(31 downto 26) = "000000") and (s_Inst(5 downto 0) = "001100") and (v0 = "00000000000000000000000000001010") else '0';

	-- TODO: Implement the rest of your processor below this comment!
	zextend : zero_extender port map(i_in_16 => s_Inst(15 downto 0), o_out_32 => zero_extended_immediate);
	sextend : sign_extender port map(i_in_16 => s_Inst(15 downto 0), o_out_32 => sign_extended_immediate);
	-- extender
	with s_unsigned select extended_immediate <= sign_extended_immediate when '0', zero_extended_immediate when others;
	-- write_data mux
	-- with s_mem_to_reg select s_reg_write_data <= s_DMemOut when '1', alu_result when others;
	-- jal/write_data mux 
	s_reg_data_sel(1) <= s_jal;
	s_reg_data_sel(0) <= s_mem_to_reg;
	with s_reg_data_sel select s_RegWrData <= 
		return_reg_add when "11", 
		return_reg_add when "10",
		s_DMemOut when "01",
		alu_result when "00",
		x"00000000" when others;
	-- imm mux
	with s_alu_src select sel_data_b <= extended_immediate when '1', data_b when others;
	with s_lui select s_shamt <= "10000" when '1', s_Inst(10 downto 6) when others;
	not_zero: invg port map(i_A => s_zero, o_F => s_not_zero);
	with s_bne select s_compare_branch_equality <= s_not_zero when '1', s_zero when others;
	-- band-aid knee slapper right here
	--with s_lui select data_a <= extended_immediate when '1', data_a when others;
	s_rd <= s_Inst(15 downto 11);
	s_rs <= s_Inst(25 downto 21);
	s_rt <= s_Inst(20 downto 16);
	-- destination select 
	--with s_reg_dst select s_RegWrAddr <= s_rt when '0', s_rd when others;
	s_reg_addr_sel(1) <= s_jal;
	s_reg_addr_sel(0) <= s_reg_dst;
	with s_reg_addr_sel select s_RegWrAddr <= 
		"11111" when "11", 
		"11111" when "10",
		s_rd when "01",
		s_rt when "00",
		"00000" when others;
	
	--control module
	ctrl_unit : control_unit
	port map(
		i_opcode => s_Inst(31 downto 26),
		i_funct => s_Inst(6 - 1 downto 0),
		o_reg_dst => s_reg_dst,
		o_jump => s_jump,
		o_branch => s_branch,
		o_mem_read => s_mem_read,
		o_mem_to_reg => s_mem_to_reg,
		o_alu_op => s_alu_opcode,
		o_mem_write => s_DMemWr,
		o_alu_src => s_alu_src,
		o_reg_write => s_RegWr,
		o_sign_ext => s_unsigned,
		o_lui => s_lui,
		o_bne => s_bne,
		o_jal => s_jal,
		o_jr => s_jr
	);

	-- think about s_RegWrData 
	reg_file : register_file
	port map(
		i_clk => iCLK, i_write_en => s_RegWr, i_rst => iRST, i_write_data => s_RegWrData,
		i_rd => s_RegWrAddr, i_rs => s_rs, i_rt => s_rt,
		o_data_a => data_a, o_data_b => data_b, o_v0 =>v0
	);
	alu_compute : alu port map(i_ctrl => s_alu_opcode, i_a => data_a, i_b => sel_data_b, i_shamt => s_shamt, o_result => alu_result, o_overflow => s_overflow, o_zero => s_zero);
	s_DMemAddr <= alu_result;
	s_DMemData <= data_b;
	oALUOut <= alu_result;
	pc_register : n_bit_register port map(
		i_clk => iCLK,
		i_rst => iRST,
		i_we => '1',
		i_in => pc_next,
		o_out => s_NextInstAddr);

	-- branch and jumps
	branch_shift_res <= extended_immediate(31 - 2 downto 0) & "00";
	jump_address <= pc_val(31 downto 28) & s_Inst(26 - 1 downto 0) & "00";
	branch_adder : full_adder_structure_generic  port map(i_A => pc_val, i_B => branch_shift_res, i_C => '0', o_S => branch_add, o_C => open);
	pc_adder : full_adder_structure_generic  port map(i_A => s_IMemAddr, i_B => x"00000004", i_C => '0', o_S => pc_val, o_C => open);
	br_and : andg2 port map(i_A => s_branch, i_B => s_compare_branch_equality, o_F => pc_mux1_sel);
	s_pc_sel(1) <= s_jump;
	s_pc_sel(0) <= pc_mux1_sel;
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
