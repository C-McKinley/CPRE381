-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file tests a sign extender from 16 to 32 bits
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.opcode_t.all;
entity tb_processor is
generic(
	gCLK_HPER   : time := 50 ns);
end tb_processor;

architecture behavior of tb_processor is
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


component processor is
  port(i_opcode : in std_logic_vector(6-1 downto 0);
	i_rt: in std_logic_vector(5-1 downto 0);
	i_rs: in std_logic_vector(5-1 downto 0);
	i_rd: in std_logic_vector(5-1 downto 0);
	i_shamt: in std_logic_vector(5-1 downto 0);
	i_funct: in std_logic_vector(6-1 downto 0);
	i_immediate: in std_logic_vector(16-1 downto 0);
	i_clk: in std_logic);
end component;

signal s_clk : std_logic;
signal s_opcode, s_funct: std_logic_vector(6-1 downto 0);
signal s_rt, s_rs, s_rd, s_shamt: std_logic_vector(5-1 downto 0);
signal i_imm : std_logic_vector(16-1 downto 0);

begin
p: processor port map(
	i_opcode => s_opcode,
	i_rt => s_rt,
	i_rs => s_rs,
	i_rd => s_rd,
	i_shamt => s_shamt,
	i_funct => s_funct,
	i_immediate => i_imm,
	i_clk => s_clk);
P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
	process
	begin
		-- drive all wires
		s_opcode <= "000000";
		s_funct <= 	"000000";
		s_rt <= "00000";
		s_rs <= "00000";
		s_rd <= "00000";
		s_shamt <= "00000";
		i_imm <= x"0000";
		-- addi  $25, $0, 0 # Load &A into $25
		s_opcode <= ADDI_OP;
		s_rd <= "11001";
		s_rs <= "00000";
		i_imm <= x"0000";
		wait for 100 ns;
		-- addi  $26, $0, 256 # Load &B into $26
		s_opcode <= ADDI_OP;
		s_rd <= "11010";
		s_rs <= "00000";
		i_imm <= x"0100";
		wait for 100 ns;
		-- lw$1,  0($25) # Load A[0] into $1
		s_opcode <= LW_OP;
		s_rd <= "00001";
		s_rs <= "11001";
		i_imm <= x"0000";
		wait for 100 ns;
		-- lw $2,  4($25) # Load A[1] into $2
		s_opcode <= LW_OP;
		s_rd <= "00010";
		s_rs <= "11001";
		i_imm <= x"0004";
		wait for 100 ns;
		-- add $1,  $1, $2 # $1 = $1 + $2
		s_opcode <= ADD_OP;
		s_rd <= "00001";
		s_rs <= "00001";
		s_rt <= "00010";
		wait for 100 ns;
		-- sw    $1,  0($26) # Store $1 into B[0]
		s_opcode <= SW_OP;
		s_rt <= "00001";
		s_rs <= "11010";
		i_imm <= x"0000";
		wait for 100 ns;
		-- lw $2,  8($25) # Load A[2] into $2
		s_opcode <= LW_OP;
		s_rd <= "00010";
		s_rs <= "11001";
		i_imm <= x"0008";
		wait for 100 ns;
		-- add $1,  $1, $2 # $1 = $1 + $2
		s_opcode <= ADD_OP;
		s_rd <= "00001";
		s_rs <= "00001";
		s_rt <= "00010";
		wait for 100 ns;
		-- sw    $1,  4($26) # Store $1 into B[1]
		s_opcode <= SW_OP;
		s_rt <= "00001";
		s_rs <= "11010";
		i_imm <= x"0004";
		wait for 100 ns;
		-- lw $2,  12($25) # Load A[3] into $2
		s_opcode <= LW_OP;
		s_rd <= "00010";
		s_rs <= "11001";
		i_imm <= x"000C";
		wait for 100 ns;
		-- add $1,  $1, $2 # $1 = $1 + $2
		s_opcode <= ADD_OP;
		s_rd <= "00001";
		s_rs <= "00001";
		s_rt <= "00010";
		wait for 100 ns;
		-- sw    $1,  8($26) # Store $1 into B[2]
		s_opcode <= SW_OP;
		s_rt <= "00001";
		s_rs <= "11010";
		i_imm <= x"0008";
		wait for 100 ns;
		-- lw $2,  16($25) # Load A[4] into $2
		s_opcode <= LW_OP;
		s_rd <= "00010";
		s_rs <= "11001";
		i_imm <= x"0010";
		wait for 100 ns;
		-- add $1,  $1, $2 # $1 = $1 + $2
		s_opcode <= ADD_OP;
		s_rd <= "00001";
		s_rs <= "00001";
		s_rt <= "00010";
		wait for 100 ns;
		-- sw    $1,  12($26) # Store $1 into B[3]
		s_opcode <= SW_OP;
		s_rt <= "00001";
		s_rs <= "11010";
		i_imm <= x"000C";
		wait for 100 ns;
		-- lw $2,  20($25) # Load A[5] into $2
		s_opcode <= LW_OP;
		s_rd <= "00010";
		s_rs <= "11001";
		i_imm <= x"0014";
		wait for 100 ns;
		-- add $1,  $1, $2 # $1 = $1 + $2
		s_opcode <= ADD_OP;
		s_rd <= "00001";
		s_rs <= "00001";
		s_rt <= "00010";
		wait for 100 ns;
		-- sw    $1,  16($26) # Store $1 into B[4]
		s_opcode <= SW_OP;
		s_rt <= "00001";
		s_rs <= "11010";
		i_imm <= x"0010";
		wait for 100 ns;
		-- lw $2,  24($25) # Load A[6] into $2
		s_opcode <= LW_OP;
		s_rd <= "00010";
		s_rs <= "11001";
		i_imm <= x"0018";
		wait for 100 ns;
		-- add $1,  $1, $2 # $1 = $1 + $2
		s_opcode <= ADD_OP;
		s_rd <= "00001";
		s_rs <= "00001";
		s_rt <= "00010";
		wait for 100 ns;
		-- addi  $27, $0, 512 # Load &B[256] into $27
		s_opcode <= ADDI_OP;
		s_rd <= "11011";
		s_rs <= "00000";
		i_imm <= x"0200";
		wait for 100 ns;
		-- sw $1,  -4($27) # Store $1 into B[255]
		s_opcode <= SW_OP;
		s_rt <= "00001";
		s_rs <= "11011";
		i_imm <= x"FFFC";
		wait for 100 ns;

		-- SLL $1, $4, 3
		s_opcode <= SLL_OP;
		s_rd <= "11011";
		s_rs <= "00010";
		i_imm <= x"0003";
		wait for 100 ns;

		-- SRA $1, $1, 1
		s_opcode <= SRA_OP;
		s_rd <= "01001";
		s_rs <= "00001";
		i_imm <= x"0001";
		wait for 100 ns;

		-- SRL $1,  $27 4
		s_opcode <= SRL_OP;
		s_rd <= "01010";
		s_rs <= "11011";
		i_imm <= x"0004";
		wait for 100 ns;
		
  end process;
  
end behavior;