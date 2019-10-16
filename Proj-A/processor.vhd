-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file creates an simple
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.opcode_t.all;

entity processor is
	port (
		i_opcode     : in std_logic_vector(6 - 1 downto 0);
		i_rt         : in std_logic_vector(5 - 1 downto 0);
		i_rs         : in std_logic_vector(5 - 1 downto 0);
		i_rd         : in std_logic_vector(5 - 1 downto 0);
		i_shamt      : in std_logic_vector(5 - 1 downto 0);
		i_funct      : in std_logic_vector(6 - 1 downto 0);
		i_immediate  : in std_logic_vector(16 - 1 downto 0);
		i_clk        : in std_logic
	);
end processor;

architecture structure of processor is

	component mem is
		generic (
			DATA_WIDTH   : natural := 32;
			ADDR_WIDTH   : natural := 10
		);
		port (
			clk   : in std_logic;
			addr  : in std_logic_vector((ADDR_WIDTH - 1) downto 0);
			data  : in std_logic_vector((DATA_WIDTH - 1) downto 0);
			we    : in std_logic := '1';
			q     : out std_logic_vector((DATA_WIDTH - 1) downto 0)
		);
	end component;

	component sign_extender is
		port (
			i_in_16  : in std_logic_vector(16 - 1 downto 0); -- 16 bit input
		o_out_32 : out std_logic_vector(32 - 1 downto 0)); -- 32 bit output
	end component;
	component zero_extender is
		port (
			i_in_16  : in std_logic_vector(16 - 1 downto 0); -- 16 bit input
		o_out_32 : out std_logic_vector(32 - 1 downto 0)); -- 32 bit output
	end component;

	component register_file is
		port (
			i_clk          : in std_logic; -- Clock input
			i_write_en     : in std_logic; -- Write enable input
			i_rst          : in std_logic;
			i_write_data   : in std_logic_vector(32 - 1 downto 0); -- Write data
			i_write_addr   : in std_logic_vector(5 - 1 downto 0); -- Write address
			i_read_a_addr  : in std_logic_vector(5 - 1 downto 0); -- Read address A
			i_read_b_addr  : in std_logic_vector(5 - 1 downto 0); -- Read address B
			o_data_a       : out std_logic_vector(32 - 1 downto 0); -- Data output A
		o_data_b : out std_logic_vector(32 - 1 downto 0)); -- Data output B
	end component;
	component alu is
		port (
			i_ctrl  : in std_logic_vector(6 - 1 downto 0); -- ctrl format [0:{add} 1:{sub} 2:{slt} 3:{and} 4:{or} 5:{xor} 6:{nand} 7:{nor}]
			i_a     : in std_logic_vector(32 - 1 downto 0);
			i_b     : in std_logic_vector(32 - 1 downto 0);
			o_result    : out std_logic_vector(32 - 1 downto 0);
			o_overflow  : out std_logic;
			o_zero : out std_logic
		);
	end component;
	--format [0:{i_write_en} 1:{i_alusrc} 2:{n_add_sub} 3:{mem_result} 4:{mem_write}]
	signal ctrl_signal : std_logic_vector(5 - 1 downto 0);
	signal opcode : std_logic_vector(6-1 downto 0);
	signal data_a, data_b, write_data, alu_sum, sel_data_b, extended_immediate, zero_extended_immediate, sign_extended_immediate, mem_q : std_logic_vector(31 downto 0);
	signal mem_addr : std_logic_vector(10 - 1 downto 0);
	signal s_zero, overflow, set : std_logic;
begin
	-- control decoder
	with i_opcode select ctrl_signal <= 
		"01001" when ADDI_OP, --addi
		"10001" when LW_OP, --lw
		"10000" when SW_OP, --sw
		"01011" when ADD_OP, --add
		"01001" when SLL_OP, --add
		"01001" when SRA_OP, --add
		"01001" when SRL_OP, --add
		"00000" when others;
		zextend : zero_extender
		port map(i_in_16 => i_immediate, o_out_32 => zero_extended_immediate);
	sextend : sign_extender
	port map(i_in_16 => i_immediate, o_out_32 => sign_extended_immediate);
	-- extender
	with i_immediate(15) select extended_immediate <= zero_extended_immediate when '0', sign_extended_immediate when others;
	-- write_data mux
	with ctrl_signal(3) select write_data <= mem_q when '0', alu_sum when others;
	-- imm mux
	with ctrl_signal(1) select sel_data_b <= extended_immediate when '0', data_b when others;
	reg_file : register_file
	port map(
		i_clk         => i_clk, i_write_en => ctrl_signal(0), i_rst => '0', i_write_data => write_data, 
		i_write_addr  => i_rd, i_read_a_addr => i_rs, i_read_b_addr => i_rt, 
		o_data_a      => data_a, o_data_b => data_b
);
alu_compute : alu
port map(i_ctrl => i_opcode, i_a => data_a , i_b => sel_data_b, o_result => alu_sum, o_overflow => overflow, o_zero => s_zero);
-- making it byte to word addressable by shifting by 2
mem_addr <= alu_sum(11 downto 2);
mem_file : mem
port map(clk => i_clk, addr => mem_addr, data => data_b, we => ctrl_signal(4), q => mem_q);
end structure;