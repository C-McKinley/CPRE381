-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_if_id_reg.vhd
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.opcode_t.all;

entity tb_if_id_reg is
	generic (gCLK_HPER : time := 100 ns);
end tb_if_id_reg;

architecture behavior of tb_if_id_reg is
	constant cCLK_PER : time := gCLK_HPER * 2;
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

	signal s_write : std_logic_vector(6 - 1 downto 0);
	signal s_rst : std_logic_vector(32-1 downto 0);
	signal s_pc_in, s_pc_out : std_logic_vector(32-1 downto 0);
	signal s_inst_in, s_pc_out : std_logic_vector(32-1 downto 0);
	signal s_CLK : std_logic;
	-- 0 add, 1 sub, 2 slt, 3 and, 4 or, 5 xor, 6 nand, 7 nor
begin
	reg_test : alu
	port map(
		i_clk => s_CLK, 
		i_rst => s_rst, 
		i_we => s_write, 
		i_pc => s_pc_in,
		i_inst => s_pc_in,
		o_pc => s_pc_out, 
		o_inst => s_inst_out
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
	-- RST Test
	i_rst <= '1';
	i_we <= '0';
	s_pc_in <= x"00000000";
	s_inst_in <= x"00000000";
	wait for gCLK_HPER;
	assert s_pc_out = x"00000000" report "rst_pc" severity warning;
	assert s_inst_out = x"00000000" report "rst_inst" severity warning;
	
	-- Write Test
	i_rst <= '0';
	i_we <= '1';
	s_pc_in <= x"FFFFFFFF";
	s_inst_in <= x"FFFFFFFF";
	wait for gCLK_HPER;
	assert s_pc_out = x"FFFFFFFF" report "write_pc" severity warning;
	assert s_inst_out = x"FFFFFFFF" report "write_inst" severity warning;
	
	-- Write En Test
	i_rst <= '0';
	i_we <= '0';
	s_pc_in <= x"EFEFEFEF";
	s_inst_in <= x"EFEFEFEF";
	wait for gCLK_HPER;
	assert s_pc_out = x"FFFFFFFF" report "wr_en_pc" severity warning;
	assert s_inst_out = x"FFFFFFFF" report "wr_en_inst" severity warning;
	
end process;

end behavior;
