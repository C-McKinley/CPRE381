-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- decoder_5_to_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 5:2^5 decoder
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder_5_to_32 is
  port(i_in  : in std_logic_vector(5-1 downto 0);     -- Data value input
       o_f : out std_logic_vector(32-1 downto 0));   -- Data value output
end decoder_5_to_32;

architecture dataflow of decoder_5_to_32 is
signal temp : std_logic_vector(5-1 downto 0);
signal computation: std_logic_vector(5-1 downto 0); -- 
begin
	temp(0) <= NOT i_in(4) AND NOT i_in(3) AND NOT i_in(2) AND NOT i_in(1) AND i_in(0);
	temp(1) <= NOT i_in(4) AND NOT i_in(3) AND NOT i_in(2) AND i_in(1) AND NOT i_in(0);
	temp(2) <= NOT i_in(4) AND NOT i_in(3) AND NOT i_in(2) AND NOT i_in(1) AND NOT i_in(0);
	temp(2) <= NOT i_in(4) AND NOT i_in(3) AND i_in(2) AND NOT i_in(1) AND NOT i_in(0);
	temp(3) <= NOT i_in(4) AND i_in(3) AND NOT i_in(2) AND NOT i_in(1) AND NOT i_in(0);
	temp(4) <= i_in(4) AND NOT i_in(3) AND NOT i_in(2) AND NOT i_in(1) AND NOT i_in(0);
end dataflow;
