-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- forward_unit_id.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32 bit alu
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity forward_unit_id is
	port (
		branch_id : in std_logic;
		reg_write_mem : in std_logic;
		reg_write_wb : in std_logic;
		rd_addr_ex_mem : in std_logic_vector(5 - 1 downto 0);
		rd_addr_mem_wb : in std_logic_vector(5 - 1 downto 0);
		rs_addr_if_id : in std_logic_vector(5 - 1 downto 0);
		rt_addr_if_id : in std_logic_vector(5 - 1 downto 0);
		forward_c : out std_logic_vector(2 - 1 downto 0);
		forward_d : out std_logic_vector(2 - 1 downto 0)
	);
end forward_unit_id;

architecture behavorial of forward_unit_id is
begin
	process (branch_id, reg_write_wb, rd_addr_ex_mem, rs_addr_if_id, rt_addr_if_id, rd_addr_mem_wb) is
	begin
		if ((branch_id = '1' and reg_write_mem = '1') and (rd_addr_ex_mem /= "00000")and (rd_addr_ex_mem = rs_addr_if_id)) then
			forward_c <= "01";
		elsif ((reg_write_wb = '1') and (rd_addr_mem_wb /= "00000") and (rd_addr_mem_wb = rs_addr_if_id)) then 
			forward_c <= "10";
		else
			forward_c <= "00";
		end if;
		if ((branch_id = '1' and reg_write_mem = '1') and (rd_addr_ex_mem /= "00000") and (rd_addr_ex_mem = rt_addr_if_id)) then 
			forward_d <= "01";
		elsif ((reg_write_wb = '1') and (rd_addr_mem_wb /= "00000") and (rd_addr_mem_wb = rt_addr_if_id)) then 
			forward_d <= "10";
		else
			forward_d <= "00";
		end if;


	end process;

end behavorial;