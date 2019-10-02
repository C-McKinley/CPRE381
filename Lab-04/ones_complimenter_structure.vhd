-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- ones_complimenter_structure.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a one's complimenter using structure
-- architecture

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ones_complimenter_structure is
  generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end ones_complimenter_structure;

architecture structure of ones_complimenter_structure is

component invg
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;

begin

one_comp: for i in 0 to N-1 generate
  inv_i: invg 
    port map(i_A  => i_A(i),
  	     o_F  => o_F(i));
end generate;

  
end structure;