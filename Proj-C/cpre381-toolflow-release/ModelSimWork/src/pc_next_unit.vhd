-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- pc_next_unit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32 bit alu
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity pc_next_unit is
	port (
		i_jump : in std_logic;
		i_jr : in std_logic;
		i_branch : in std_logic;
		i_r31 : in std_logic_vector(32 - 1 downto 0);
		i_pc_val : in std_logic_vector(32 - 1 downto 0);
		i_jump_addr : in std_logic_vector(32 - 1 downto 0);
		i_branch_addr : in std_logic_vector(32 - 1 downto 0);
		o_pc_next : out std_logic_vector(32 - 1 downto 0)
	);
end pc_next_unit;

architecture mixed of pc_next_unit is
	signal s_ctrl : std_logic_vector(3 - 1 downto 0);
	signal s_funct_ctrl : std_logic_vector(19 - 1 downto 0);
begin
	s_ctrl <= i_jump & i_jr & i_branch;
	with s_ctrl select o_pc_next <= 
	i_pc_val when "000",
	i_branch_addr when "001",
	i_r31 when "010",
	i_r31 when "011",
	i_jump_addr when others;

	
end mixed;