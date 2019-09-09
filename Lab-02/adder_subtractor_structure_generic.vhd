-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- adder_subtractor_structure_generic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a generic full adder subtractor 
-- module using structure architecture

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity adder_subtractor_structure_generic is
generic(N : integer := 32);
  port(i_A     : in std_logic_vector(N-1 downto 0);
       i_B     : in std_logic_vector(N-1 downto 0);
       i_C     : in std_logic;
       i_Sel   : in std_logic;
       o_Sum   : out std_logic_vector(N-1 downto 0);
       o_Cout  : out std_logic);

end adder_subtractor_structure_generic;

architecture structure of adder_subtractor_structure_generic is

component full_adder_structure
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       i_C  : in std_logic;
       o_S  : out std_logic;
       o_C  : out std_logic);
end component;

component ones_complimenter_structure
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

component mux2_structure_generic
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_S  : in std_logic;
       o_F  : out std_logic_vector(N-1 downto 0));
end component;


signal negi_B: std_logic_vector(N-1 downto 0);
signal selB: std_logic_vector(N-1 downto 0);

signal s_carry: std_logic_vector(N downto 0);

begin

s_carry(0) <= i_C;
one_comp: ones_complimenter_structure
		port map(i_A => i_B,
			 o_F => negi_B);
mux: mux2_structure_generic
		port map(i_A => i_B,
			 i_B => negi_B,
			 i_S =>  i_Sel,
			 o_F => selB);
adder: for i in 0 to N-1 generate
	fa_i: full_adder_structure
		port map(i_A => i_A(i),
		 	i_B => selB(i),
		 	i_C => s_carry(i),
		 	o_S => o_Sum(i),
		 	o_C => s_carry(i + 1));
end generate;
o_Cout <= s_carry(N);

end structure;