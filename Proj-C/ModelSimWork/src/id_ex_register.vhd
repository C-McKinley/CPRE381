-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- id_ex_register.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a pc register using dff

-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity id_ex_register is

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

end id_ex_register;

architecture structure of id_ex_register is
	signal s_D : std_logic_vector(218 - 1 downto 0); -- Multiplexed input to the FF
	signal s_Q : std_logic_vector(218 - 1 downto 0); -- Output of the FF
begin
	-- The output of the FF is fixed to s_Q
	o_data_b <= s_Q(218 -1 downto 186 );
	o_shamt <= s_Q(186 -1 downto 181 );
	o_inst <= s_Q(181-1 downto 149);
	o_wb       <= s_Q(149 - 1 downto 147);
	o_mem      <= s_Q(147 - 1 downto 145);
	o_alu_src  <= s_Q(144);
	o_alu_op   <= s_Q(144 - 1 downto 138);
	o_pc       <= s_Q(138 - 1 downto 106);
	o_rs_data  <= s_Q(106 - 1 downto 74);
	o_rt_data  <= s_Q(74 - 1 downto 42);
	o_sign_ext <= s_Q(42 - 1 downto 10);
	o_rt_addr  <= s_Q(10 - 1 downto 5);
	o_rd_addr  <= s_Q(5 - 1 downto 0);
 
	-- Create a multiplexed input to the FF based on i_WE
	with i_WE select
	s_D <= i_data_b & i_shamt & i_inst & i_wb & i_mem & i_ex & i_pc & i_rs_data & i_rt_data & i_sign_ext & i_rt_addr & i_rd_addr when '1', 
	       s_Q when others;
 
	-- This process handles the asyncrhonous reset and
	-- synchronous write. We want to be able to reset
	-- our processor's registers so that we minimize
	-- glitchy behavior on startup.
	process (i_CLK, i_RST)
	begin
		if (i_RST = '1') then
			s_Q <= (others => '0');
		elsif (rising_edge(i_CLK)) then
			s_Q <= s_D;
		end if;

	end process;

 
end structure;