-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- full_adder_dataflow_generic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a generic full adder using dataflow
-- architecture

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_dataflow_generic is
generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_C  : in std_logic;
       o_S  : out std_logic_vector(N-1 downto 0);
       o_C  : out std_logic);

end full_adder_dataflow_generic;

architecture dataflow of full_adder_dataflow_generic is
	begin
	  adder: for i in 0 to N-1 generate
		o_S(i) <= i_C xor (i_A(i) xor i_B(i));
		o_C <= (i_A(i) and i_B(i)) or (i_B(i) and i_C) or (i_A(i) and i_C);
		end generate
	end dataflow;