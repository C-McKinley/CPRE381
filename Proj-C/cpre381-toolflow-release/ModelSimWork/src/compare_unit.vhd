-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- compare_unit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32 bit alu
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity compare_unit is
	port (
		i_inv : in std_logic;
		i_data_rs : in std_logic_vector(32 - 1 downto 0);
		i_data_rt : in std_logic_vector(32 - 1 downto 0);
		o_equal : out std_logic
	);
end compare_unit;

architecture behavioral of compare_unit is
begin
	process (i_inv, i_data_rs, i_data_rt)
	begin
		if (i_inv = '1') then
			o_equal <= '1' when (i_data_rs /= i_data_rt)
		           else '0';
		else 
			o_equal <= '1' when (i_data_rs = i_data_rt)
		           else '0';
		end if;
	end process;

end Behavioral;