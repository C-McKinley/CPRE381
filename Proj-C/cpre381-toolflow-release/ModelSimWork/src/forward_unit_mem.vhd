-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- forward_unit_mem.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32 bit alu
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity forward_unit_mem is
	port (
		mem_write : in std_logic;
		rt_addr_mem : in std_logic_vector(5 - 1 downto 0);
		rd_addr_wb : in std_logic_vector(5 - 1 downto 0);
		reg_write_wb : in std_logic;
		forward_e : out std_logic
	);
end forward_unit_mem;

architecture behavorial of forward_unit_mem is
begin
	process (mem_write, rt_addr_mem, rd_addr_wb, reg_write_wb) is
	begin
		if ((mem_write = '1' and reg_write_wb = '1') and (rd_addr_wb /= "00000")and (rd_addr_wb = rt_addr_mem)) then
			forward_e <= '1';
		else
			forward_e <= '0';
		end if;

	end process;

end behavorial;