-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2_structure_generic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a generic 2:1 mux using structure
-- architecture

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2_structure_generic is
generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_S  : in std_logic;
       o_F  : out std_logic_vector(N-1 downto 0));

end mux2_structure_generic;

architecture structure of mux2_structure_generic is

component invg
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;

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

signal inv_S, i_AS, i_BIS

begin

--compute ~S
inv_s: invg 
    port map(i_A  => i_S,
  	     o_F  => inv_S);
--compute B & ~S
andBIS_i: andg2 
    port map(i_A  => i_B(i),
             i_B  => inv_S,
  	          o_F  => i_BIS);
--compute A & S
 andAS_i: andg2 
    port map(i_A  => i_A(i),
             i_B  => i_S,
  	          o_F  => i_AS);
--compute (A & S) | (B & ~S)
 or_i: andg2 
    port map(i_A  => i_AS(i),
             i_B  => i_BIS(i),
  	          o_F  => o_F);
   

end generate;

  
end structure;