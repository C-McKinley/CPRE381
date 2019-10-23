-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- sign_extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a sign_extender using dff

-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sign_extender is
  port(i_in_16  : in std_logic_vector(16-1 downto 0);     -- 16 bit input
       o_out_32  : out std_logic_vector(32-1 downto 0));     -- 32 bit output
end sign_extender;

architecture dataflow of sign_extender is
begin
	load: for i in 0 to 15 generate
		o_out_32(i) <= i_in_16(i);
	end generate;
	extend: for j in 16 to 31 generate
		o_out_32(j) <= i_in_16(15);
	end generate;
end dataflow;
