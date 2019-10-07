-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a barrel_shifter
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity barrel_shifter is
	port (
		i_a      : in std_logic_vector(32 - 1 downto 0);
		i_shift  : in std_logic_vector(5 - 1 downto 0); -- shamt
		i_la     : in std_logic_vector(5 - 1 downto 0); -- logical or arithmetic
		i_rl     : in std_logic_vector(5 - 1 downto 0); -- right or left
		o_f      : out std_logic_vector(32 - 1 downto 0)
	);
end barrel_shifter;

architecture structure of barrel_shifter is

	component andg2
		port (
			i_A  : in std_logic;
			i_B  : in std_logic;
			o_F  : out std_logic
		);
	end component;

	component org2
		port (
			i_A  : in std_logic;
			i_B  : in std_logic;
			o_F  : out std_logic
		);
	end component;

	component xorg2
		port (
			i_A  : in std_logic;
			i_B  : in std_logic;
			o_F  : out std_logic
		);
	end component;
	component mux2_structure_generic
		port (
			i_A  : in std_logic_vector(32 - 1 downto 0);
			i_B  : in std_logic_vector(32 - 1 downto 0);
			i_S  : in std_logic;
			o_F  : out std_logic_vector(32 - 1 downto 0)
		);
	end component;

	component invg
		port (
			i_A  : in std_logic;
			o_F  : out std_logic
		);
	end component;

	signal s_rl : std_logic;
	signal s_stage0 : std_logic_vector(32 - 1 downto 0);
	signal s_stage1 : std_logic_vector(32 - 1 downto 0);
	signal s_stage2 : std_logic_vector(32 - 1 downto 0);
	signal s_stage3 : std_logic_vector(32 - 1 downto 0);
	signal s_stage4 : std_logic_vector(32 - 1 downto 0);

begin
end structure;