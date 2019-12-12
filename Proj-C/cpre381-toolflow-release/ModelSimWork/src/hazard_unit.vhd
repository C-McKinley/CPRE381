-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- hazard_unit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32 bit alu
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity hazard_unit is
	port (
		i_branch : in std_logic;
		i_jr_id : in std_logic;
		i_mem_read_id : in std_logic;
		i_mem_read_ex : in std_logic;
		i_mem_read_mem : in std_logic;
		i_rt_addr_ex : in std_logic_vector(5 - 1 downto 0);
		i_rd_addr_ex : in std_logic_vector(5 - 1 downto 0);
		i_rd_addr_mem : in std_logic_vector(5 - 1 downto 0);
		i_rs_addr_id : in std_logic_vector(5 - 1 downto 0);
		i_rt_addr_id : in std_logic_vector(5 - 1 downto 0);
		o_stall : out std_logic
	);
end hazard_unit;

architecture behavioral of hazard_unit is

begin
process (i_branch, i_jr_id, i_mem_read_id, i_mem_read_ex, i_mem_read_mem, i_rt_addr_ex, i_rs_addr_id, i_rt_addr_id, i_rd_addr_mem, i_rd_addr_ex)
	begin
		if (i_mem_read_ex = '1' and ((i_rt_addr_ex = i_rs_addr_id) or (i_rt_addr_ex = i_rt_addr_id)) and (i_rt_addr_ex /= "00000")) then
			o_stall <= '1';
		elsif (i_branch = '1' and ((i_rd_addr_ex = i_rs_addr_id) or (i_rd_addr_ex = i_rt_addr_id)) and (i_rd_addr_ex /= "00000")) then 
			o_stall <= '1';
		elsif((i_jr_id = '1' and i_mem_read_mem = '1') and (i_rd_addr_mem = i_rs_addr_id) and(i_rd_addr_mem /="00000"))then
			o_stall <= '1';
		elsif((i_branch = '1' and i_mem_read_mem = '1') and (i_rd_addr_mem = i_rs_addr_id or i_rd_addr_mem = i_rt_addr_id) and(i_rd_addr_mem /="00000"))then
			o_stall <= '1';
		else 
			o_stall <= '0';
		end if;
	end process;

end behavioral;