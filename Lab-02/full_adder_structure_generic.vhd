-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- full_adder_structure_generic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a generic full adder using structure
-- architecture

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_structure_generic is
generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_C  : in std_logic;
       o_S  : out std_logic_vector(N-1 downto 0);
       o_C  : out std_logic);

end full_adder_structure_generic;

architecture structure of full_adder_structure_generic is

component full_adder_structure
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       i_C  : in std_logic;
       o_S  : out std_logic;
       o_C  : out std_logic);
end component;

signal carry_in: std_logic_vector(N downto 0);
begin
carry_in(0) <= i_C;
adder: for i in 0 to N-1 generate
	fa_i: full_adder_structure
		port map(i_A => i_A(i),
				 i_B => i_B(i),
				 i_C => carry_in(i),
				 o_S => o_S(i),
				 o_C => carry_in(i+1));
end generate;
o_C <= carry_in(N);
end structure;