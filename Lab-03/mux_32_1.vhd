-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux_32_1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32 bit 32:1 multiplexier 
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.register_array_t.all

entity mux_32_1 is
  port( i_in : in reg_arr;     -- Register array
	i_sel   : in std_logic_vector(5-1 downto 0);	  -- Select value input
        o_out 	: out std_logic_vector(32-1 downto 0));   -- Data value output
end mux_32_1;

architecture dataflow of mux_32_1 is
	o_out <= i_in(to_integer(unsigned(i_sel)));
end dataflow;