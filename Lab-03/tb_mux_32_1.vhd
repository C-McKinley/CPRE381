-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_mux_32_1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file tests a 32 bit 32:1 multiplexier 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.register_array_t.all;


entity tb_mux_32_1 is
end tb_mux_32_1;

architecture behavior of tb_mux_32_1 is

	component mux_32_1
		port(i_in : reg_arr;
			i_sel : in std_logic_vector(5-1 downto 0);
			o_out : out std_logic_vector(32-1 downto 0));
	end component;
	signal s_in : reg_arr := (x"0000000F",
							  x"000000EF",
							  x"00000DDF",
							  x"0000CDEF",
							  x"000BCDEF",
							  x"00ABCDEF",
							  x"09ABCDEF",
							  x"89ABCDEF",
							  x"F0000000",
							  x"FE000000",
							  x"FED00000",
							  x"FEDC0000",
							  x"FEDCB000",
							  x"FEDCBA00",
							  x"FEDCBA90",
							  x"FEDCBA98",
							  x"FFFFFFFF",
							  x"F0F0F0F0",
							  x"0F0F0F0F",
							  x"0D0D0D0D",
							  x"D0D0D0D0",
							  x"C0C0C0C0",
							  x"0C0C0C0C",
							  x"B0B0B0B0",
							  x"0B0B0B0B",
							  x"A0A0A0A0",
							  x"0A0A0A0A",
							  x"12345678",
							  x"23456789",
							  x"3456789A",
							  x"456789AB",
							  x"56789ABC");
	signal s_sel: std_logic_vector(5-1 downto 0);
	signal s_F: std_logic_vector(32-1 downto 0);
	begin 
	mux: mux_32_1 port map(i_in  => s_in,
			i_sel => s_sel,
  	        o_out  => s_F);
	process
	begin
		s_sel <= "00001";
		wait for 100 ns;

		s_sel <= "00010";
		wait for 100 ns;

		s_sel <= "00011";
		wait for 100 ns;
		
		s_sel <= "00100";
		wait for 100 ns;
		
		s_sel <= "00101";
		wait for 100 ns;
		
		s_sel <= "00110";
		wait for 100 ns;
		
		s_sel <= "00111";
		wait for 100 ns;
		
		s_sel <= "01000";
		wait for 100 ns;
		
		s_sel <= "01001";
		wait for 100 ns;
		
		s_sel <= "01010";
		wait for 100 ns;
		
		s_sel <= "01011";
		wait for 100 ns;
		
		s_sel <= "01100";
		wait for 100 ns;
		
		s_sel <= "01101";
		wait for 100 ns;
		
		s_sel <= "01110";
		wait for 100 ns;
		
		s_sel <= "01111";
		wait for 100 ns;
		
		s_sel <= "10000";
		wait for 100 ns;
		
		s_sel <= "10001";
		wait for 100 ns;
		
		s_sel <= "10010";
		wait for 100 ns;
		
		s_sel <= "10011";
		wait for 100 ns;
		
		s_sel <= "10010";
		wait for 100 ns;
		
		s_sel <= "10101";
		wait for 100 ns;
		
		s_sel <= "10110";
		wait for 100 ns;
		
		s_sel <= "10111";
		wait for 100 ns;
		
		s_sel <= "11000";
		wait for 100 ns;
		
		s_sel <= "11001";
		wait for 100 ns;
		
		s_sel <= "11010";
		wait for 100 ns;
		
		s_sel <= "11011";
		wait for 100 ns;
		
		s_sel <= "11100";
		wait for 100 ns;
		
		s_sel <= "11101";
		wait for 100 ns;
		
		s_sel <= "11110";
		wait for 100 ns;
		
		s_sel <= "11111";
		wait for 100 ns;
		

  end process;
  
end behavior;