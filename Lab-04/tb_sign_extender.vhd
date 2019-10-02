-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file tests a sign extender from 16 to 32 bits
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity tb_sign_extender is
end tb_sign_extender;

architecture behavior of tb_sign_extender is


component sign_extender is
   port(i_in_16	: in std_logic_vector(15 downto 0);
	o_out_32: out std_logic_vector(31 downto 0));
end component;
component zero_extender is
   port(i_in_16	: in std_logic_vector(15 downto 0);
	o_out_32: out std_logic_vector(31 downto 0));
end component;
signal s_in: std_logic_vector(16-1 downto 0);
signal s_out_sign: std_logic_vector(32-1 downto 0);
signal s_out_zero: std_logic_vector(32-1 downto 0);
begin
sextender: sign_extender 
  port map(i_in_16  => s_in,
	   o_out_32  => s_out_sign);
zextender: zero_extender 
  port map(i_in_16  => s_in,
	   o_out_32  => s_out_zero);
	process
	begin
		s_in <= x"0000";
		wait for 100 ns;

		s_in <= x"0001";
		wait for 100 ns;

		s_in <= x"0010";
		wait for 100 ns;
		
		s_in <= x"001F";
		wait for 100 ns;
		
		s_in <= x"0F00";
		wait for 100 ns;
	
		s_in <= x"FFFF";
		wait for 100 ns;
		
		s_in <= x"8FFF";
		wait for 100 ns;
		
  end process;
  
end behavior;