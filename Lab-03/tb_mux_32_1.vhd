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
use work.register_array_t.all


entity tb_mux_32_1 is
end tb_mux_32_1;

architecture behavior of tb_mux_32_1 is

	component mux32_1
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
	mux: mux32_1
  port map(i_in  => s_in,
			i_sel => s_sel,
  	        o_F  => s_F);
	process
	begin
		s_sel <= x"001";
		wait for 100 ns;

		s_sel <= x"002";
		wait for 100 ns;

		s_sel <= x"003";
		wait for 100 ns;
		
		s_sel <= x"004";
		wait for 100 ns;
		
		s_sel <= x"005";
		wait for 100 ns;
		
		s_sel <= x"006";
		wait for 100 ns;
		
		s_sel <= x"007";
		wait for 100 ns;
		
		s_sel <= x"008";
		wait for 100 ns;
		
		s_sel <= x"009";
		wait for 100 ns;
		
		s_sel <= x"00A";
		wait for 100 ns;
		
		s_sel <= x"00B";
		wait for 100 ns;
		
		s_sel <= x"00C";
		wait for 100 ns;
		
		s_sel <= x"00D";
		wait for 100 ns;
		
		s_sel <= x"00E";
		wait for 100 ns;
		
		s_sel <= x"00F";
		wait for 100 ns;
		
		s_sel <= x"010";
		wait for 100 ns;
		
		s_sel <= x"011";
		wait for 100 ns;
		
		s_sel <= x"012";
		wait for 100 ns;
		
		s_sel <= x"013";
		wait for 100 ns;
		
		s_sel <= x"014";
		wait for 100 ns;
		
		s_sel <= x"015";
		wait for 100 ns;
		
		s_sel <= x"016";
		wait for 100 ns;
		
		s_sel <= x"017";
		wait for 100 ns;
		
		s_sel <= x"018";
		wait for 100 ns;
		
		s_sel <= x"019";
		wait for 100 ns;
		
		s_sel <= x"01A";
		wait for 100 ns;
		
		s_sel <= x"01B";
		wait for 100 ns;
		
		s_sel <= x"01C";
		wait for 100 ns;
		
		s_sel <= x"01D";
		wait for 100 ns;
		
		s_sel <= x"01E";
		wait for 100 ns;
		
		s_sel <= x"01F";
		wait for 100 ns;
		
		s_sel <= x"020";
		wait for 100 ns;
		
		s_sel <= x"021";
		wait for 100 ns;

  end process;
  
end behavior;