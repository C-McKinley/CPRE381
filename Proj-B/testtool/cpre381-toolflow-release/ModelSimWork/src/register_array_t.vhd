-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- register_array_t.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file creates an array of 32, 32 bit vectors 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package register_array_t is
	type reg_arr is array(0 to 31) of std_logic_vector(31 downto 0);
end package register_array_t;