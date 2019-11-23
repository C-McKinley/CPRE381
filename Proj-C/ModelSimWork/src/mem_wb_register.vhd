-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mem_wb_register.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a pc register using dff

-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity mem_wb_register is
	generic (N : integer := 32);
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
end mem_wb_register;

architecture structure of mem_wb_register is
	signal s_D : std_logic_vector(115 - 1 downto 0); -- Multiplexed input to the FF
	signal s_Q : std_logic_vector(115 - 1 downto 0); -- Output of the FF
begin
	-- The output of the FF is fixed to s_Q
	o_v0 <= s_Q(115 -1 downto 83);
	o_inst_op <= s_Q(83 -  1 downto 77);
	o_funct <=  s_Q(77 -  1 downto 71);
	o_mem      <= s_Q(71 - 1 downto 69);
	o_alu_sum <= s_Q(69 - 1 downto 37);
	o_data_q  <= s_Q(37 - 1 downto 5);
	o_rd_addr <= s_Q(5 - 1 downto 0);
 
	-- Create a multiplexed input to the FF based on i_WE
	with i_WE select
	s_D <= i_v0 & i_inst_op & i_funct & i_mem & i_alu_sum & i_data_q & i_rd_addr when '1', 
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