-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2_dataflow_generic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a generic 2:1 mux using dataflow
-- architecture

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2_dataflow_generic is
generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_S  : in std_logic;
       o_F  : out std_logic_vector(N-1 downto 0));

end mux2_dataflow_generic;

architecture dataflow of mux2_dataflow_generic is
begin
mux: for i in 0 to N-1 generate
	o_F(i) <= (i_A(i) AND (NOT i_S)) OR (i_B(i) AND i_S);
end generate;
 
end dataflow;