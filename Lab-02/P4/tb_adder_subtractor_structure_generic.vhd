-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_adder_subtractor_structure_generic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a VHDL testbench for the
-- full adder (not generic).
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_adder_subtractor_structure_generic is
generic(M : integer := 32);
end tb_adder_subtractor_structure_generic;

architecture behavior of tb_adder_subtractor_structure_generic is

component adder_subtractor_structure_generic
  generic(N: integer := 32);
  port(i_A     : in std_logic_vector(N-1 downto 0);
       i_B     : in std_logic_vector(N-1 downto 0);
       i_C     : in std_logic;
       o_Sum   : out std_logic_vector(N-1 downto 0);
       o_Cout  : out std_logic);
end component;

signal s_Ci, s_Co : std_logic;
signal s_A, s_B, s_Sum  : std_logic_vector(M-1 downto 0);

begin

adder_s: adder_subtractor_structure_generic
  generic map(N => M)
      port map (i_A => s_A,
		i_B => s_B,
		i_C => s_Ci,
		o_Sum => s_Sum,
		o_Cout => s_Co);
  process
  begin

    --Add Tests
    s_A <= x"00000001";
    s_B <= x"00000002";
    s_Ci <= '0';
    wait for 100 ns;
    
    s_A <= x"FFFFFFFF";
    s_B <= x"00000000";
    s_Ci <= '0';
    wait for 100 ns;
    
    s_A <= x"FFFFFFFF";
    s_B <= x"00000001";
    s_Ci <= '0';
    wait for 100 ns;

    s_A <= x"01001010";
    s_B <= x"F0A00A00";
    s_Ci <= '1';
    wait for 100 ns;
    
    --Subtract tests
    s_A <= x"FFFFFFFF";
    s_B <= x"FFFFFFFF";
    s_Ci <= '1';
    wait for 100 ns;
  
    s_A <= x"FFFFFFFF";
    s_B <= x"FFFFFFFE";
    s_Ci <= '1';
    wait for 100 ns;
  
    s_A <= x"00000001";
    s_B <= x"00000002";
    s_Ci <= '1';
    wait for 100 ns;
 
    s_A <= x"00000001";
    s_B <= x"FFFFFFFF";
    s_Ci <= '1';
    wait for 100 ns;

    s_A <= x"00000000";
    s_B <= x"FFFFFFFF";
    s_Ci <= '1';
    wait for 100 ns;

    s_A <= x"EEEEEEEE";
    s_B <= x"FFFFFFFF";
    s_Ci <= '1';
    wait for 100 ns;

  s_A <= x"00000007";
    s_B <= x"00000001";
    s_Ci <= '1';
    wait for 100 ns;
  end process;
  
end behavior;