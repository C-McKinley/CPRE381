-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_mux2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a VHDL testbench for the
-- mux 2:1 desgins.
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mux2 is
generic(M : integer := 32);
end tb_mux2;

architecture behavior of tb_mux2 is

component mux2_dataflow_generic
  generic(N: integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_S  : in std_logic;
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

component mux2_structure_generic
  generic(N: integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_S  : in std_logic;
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

signal s_A, s_B, s_C, s_F  : std_logic_vector(M-1 downto 0);
signal s_S : std_logic;

begin

mux2_d: mux2_dataflow_generic 
  generic map(N => M)
      port map(i_A => s_A,
			   i_B => s_B,
			   i_S => s_S,
               o_F => s_F);  

mux2_s: mux2_structure_generic 
  generic map(N => M)
      port map(i_A => s_A,
			   i_B => s_B,
			   i_S => s_S,
               o_F => s_C);  

  process
  begin

    s_A <= "00000000000000000000000000000000";
	s_B <= "11111111111111111111111111111111";
	s_S <= '0';
    wait for 100 ns;

    s_A <= "00000000000000000000000000000000";
	s_B <= "11111111111111111111111111111111";
	s_S <= '1';
    wait for 100 ns;

    s_A <= "10101010101010101010101010101010";
	s_B <= "00000000000000000000000000000000";
	s_S <= '0';
    wait for 100 ns;

    s_A <= "00001111000011110000111100001111";
	s_B <= "11110000111100001111000011110000";
	s_S <= '0';
    wait for 100 ns;

	s_A <= "00001111000011110000111100001111";
	s_B <= "11110000111100001111000011110000";
	s_S <= '1';
    wait for 100 ns;

  end process;
  
end behavior;