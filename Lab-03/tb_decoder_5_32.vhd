-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_decoder_5_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file tests a 5:  2^5 decoder
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity tb_decoder_5_32 is
end tb_decoder_5_32;

architecture behavior of tb_decoder_5_32 is


component decoder_5_to_32 is
   port(i_S	: in std_logic_vector(4 downto 0);
	o_F	: out std_logic_vector(31 downto 0));
end component;
signal s_in: std_logic_vector(5-1 downto 0);
signal s_F: std_logic_vector(32-1 downto 0);

begin
decoder: decoder_5_to_32 
  port map(i_S  => s_in,
  	        o_F  => s_F);
	process
	begin
		s_in <= "00000";
		wait for 100 ns;

		s_in <= "00001";
		wait for 100 ns;

		s_in <= "00010";
		wait for 100 ns;
		
		s_in <= "00011";
		wait for 100 ns;
		
		s_in <= "00100";
		wait for 100 ns;
		
		s_in <= "00101";
		wait for 100 ns;
		
		s_in <= "00110";
		wait for 100 ns;
		
		s_in <= "00111";
		wait for 100 ns;
		
		s_in <= "01000";
		wait for 100 ns;
		
		s_in <= "01001";
		wait for 100 ns;
		
		s_in <= "01010";
		wait for 100 ns;
		
		s_in <= "01011";
		wait for 100 ns;
		
		s_in <= "01100";
		wait for 100 ns;
		
		s_in <= "01101";
		wait for 100 ns;
		
		s_in <= "01110";
		wait for 100 ns;
		
		s_in <= "01111";
		wait for 100 ns;
		
		s_in <= "10000";
		wait for 100 ns;
		
		s_in <= "10001";
		wait for 100 ns;
		
		s_in <= "10010";
		wait for 100 ns;
		
		s_in <= "10011";
		wait for 100 ns;
		
		s_in <= "10100";
		wait for 100 ns;
		
		s_in <= "10101";
		wait for 100 ns;
		
		s_in <= "10110";
		wait for 100 ns;
		
		s_in <= "10111";
		wait for 100 ns;
		
		s_in <= "11000";
		wait for 100 ns;
		
		s_in <= "11001";
		wait for 100 ns;
		
		s_in <= "11010";
		wait for 100 ns;
		
		s_in <= "11011";
		wait for 100 ns;
		
		s_in <= "11100";
		wait for 100 ns;
		
		s_in <= "11101";
		wait for 100 ns;
		
		s_in <= "11110";
		wait for 100 ns;
		
		s_in <= "11111";
		wait for 100 ns;
		
		s_in <= x"021";
		wait for 100 ns;

  end process;
  
end behavior;