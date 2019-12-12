-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- forward_unit_ex.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32 bit alu
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity forward_unit_ex is
	port (
		alusrc_ex : in std_logic;
		regWrite_ex_mem : in std_logic;
		rd_addr_ex_mem : in std_logic_vector(5 - 1 downto 0);
		regWrite_mem_wb : in std_logic;
		rd_addr_mem_wb : in std_logic_vector(5 - 1 downto 0);
		rs_addr_id_ex : in std_logic_vector(5 - 1 downto 0);
		rt_addr_id_ex : in std_logic_vector(5 - 1 downto 0);
		fordward_a : out std_logic_vector(2 - 1 downto 0);
		fordward_b : out std_logic_vector(2 - 1 downto 0)
	);
end forward_unit_ex;

architecture behavorial of forward_unit_ex is
begin
	process (regWrite_ex_mem, rd_addr_ex_mem, regWrite_mem_wb,
		rd_addr_mem_wb, rs_addr_id_ex, rt_addr_id_ex) is
	begin
		if ((regWrite_ex_mem = '1') -- EX HAZARD
			and (rd_addr_ex_mem /= "00000")
			and (rd_addr_ex_mem = rs_addr_id_ex)) then
			fordward_a <= "10";

		elsif ((regWrite_mem_wb = '1') -- MEM HAZARD
			and (rd_addr_mem_wb /= "00000")
			and not(regWrite_ex_mem = '1' and (rd_addr_ex_mem /= "00000") and (rd_addr_ex_mem = rs_addr_id_ex))
			and (rd_addr_mem_wb = rs_addr_id_ex )) then
			fordward_a <= "01";
			
		else
			fordward_a <= "00";
		end if;
		if (alusrc_ex='1') then
			fordward_b <= "00";
		elsif ((regWrite_ex_mem = '1') -- MEM HAZARD
			and (rd_addr_ex_mem /= "00000")
			and (rd_addr_ex_mem = rt_addr_id_ex)) then
			fordward_b <= "10";

		elsif ((regWrite_mem_wb = '1') -- MEM HAZARD
			and (rd_addr_mem_wb /= "00000")
			and not(regWrite_ex_mem = '1' and (rd_addr_ex_mem /= "00000")
			and (rd_addr_ex_mem = rt_addr_id_ex))
			and (rd_addr_mem_wb = rt_addr_id_ex)) then
			fordward_b <= "01";

		else
			fordward_b <= "00";
		end if;
	end process;

end behavorial;