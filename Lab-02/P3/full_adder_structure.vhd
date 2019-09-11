-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- full_adder_structure.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a full adder using structure
-- architecture

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_structure is
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       i_C  : in std_logic;
       o_S  : out std_logic;
       o_C  : out std_logic);
end full_adder_structure;

architecture structure of full_adder_structure is
component andg2
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       o_F  : out std_logic);
end component;

component org2
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       o_F  : out std_logic);
end component;

component xorg2
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       o_F  : out std_logic);
end component;

signal xor_ab, and_ac, and_ab, and_xc: std_logic;
begin

-- i_A ^ i_B
xor1: xorg2
	port map(i_A  => i_A,
		 i_B  => i_B,
		 o_F  => xor_ab);
-- i_A & i_B
and1: andg2
	port map(i_A  => i_A,
		 i_B  => i_B,
		 o_F  => and_ab);
-- (i_A ^ i_B) &  i_C
and2: andg2
	port map(i_A  => xor_ab,
		 i_B  => i_C,
		 o_F  => and_xc);
-- (i_A ^ i_B) ^  i_C
xor2: xorg2
	port map(i_A  => xor_ab,
		 i_B  => i_C,
		 o_F  => o_S);
-- (i_A ^ i_B) &  i_C
or1: org2
	port map(i_A  => and_xc,
		 i_B  => and_ab,
		 o_F  => o_C);
 
end structure;