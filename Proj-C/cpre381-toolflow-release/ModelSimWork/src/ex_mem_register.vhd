-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- ex_mem_register.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a pc register using dff

-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity ex_mem_register is
	generic (N : integer := 32);
	port (
		i_clk         : in std_logic; -- Clock input
		i_rst         : in std_logic; -- Reset input
		i_we          : in std_logic; -- Load input
		i_rt_addr	: in std_logic_vector(5 - 1 downto 0);
		i_mem_read : in std_logic;
		i_pc_val : in std_logic_vector(32 - 1 downto 0);
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
		o_inst : out std_logic_vector(32 - 1 downto 0);
		o_pc_val : out std_logic_vector(32 - 1 downto 0);
		o_mem_read : out std_logic;
		o_rt_addr	: out std_logic_vector(5 - 1 downto 0)

	);

end ex_mem_register;

architecture structure of ex_mem_register is
	signal s_D : std_logic_vector(177 - 1 downto 0); -- Multiplexed input to the FF
	signal s_Q : std_logic_vector(177 - 1 downto 0); -- Output of the FF
begin
	-- The output of the FF is fixed to s_Q
	o_rt_addr <= s_Q(177 - 1 downto 172);
	o_mem_read <= s_Q(171);
	o_pc_val <=  s_Q(171 - 1 downto 139);
	o_inst <= s_Q(139 - 1 downto 107);
	o_wb          <= s_Q(107 - 1 downto 105);
	o_mem         <= s_Q(105 - 1 downto 103);
	o_branch      <= s_Q(102);
	o_branch_addr <= s_Q(102 - 1 downto 70);
	o_alu_sum     <= s_Q(70 - 1 downto 38);
	o_alu_zero    <= s_Q(37);
	o_rt_data     <= s_Q(37 - 1 downto 5);
	o_rd_addr     <= s_Q(5 - 1 downto 0);
	-- Create a multiplexed input to the FF based on i_WE
	with i_WE select
	s_D <= i_rt_addr & i_mem_read & i_pc_val & i_inst & i_wb & i_mem & i_branch & i_branch_addr & i_alu_sum & i_alu_zero & i_rt_data & i_rd_addr when '1', 
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