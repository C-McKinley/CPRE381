-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_full_adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a VHDL testbench for the
-- full adder (not generic).
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_full_adder is
end tb_full_adder;

architecture behavior of tb_full_adder is

component full_adder_structure 
  port(i_A  : in std_logic;
       i_B  : in std_logic;
       i_C  : in std_logic;
       o_S  : out std_logic;
       o_C  : out std_logic);
end component;

signal s_A, s_B, s_Ci, s_Co, s_S  : std_logic;

begin

adder: full_adder_structure 
  generic map(N => M)
      port map (i_A => s_A,
		i_B => s_B,
		i_C => s_Ci,
		o_S => s_S,
		o_C => s_Co);

  process
  begin

    s_A <= '1';
    s_B <= '0';
    s_Ci <= '0';
    wait for 100 ns;

    s_A <= '1';
    s_B <= '1';
    s_Ci <= '0';
    wait for 100 ns;

    s_A <= '0';
    s_B <= '0';
    s_Ci <= '1';
    wait for 100 ns;

    s_A <= '1';
    s_B <= '0';
    s_Ci <= '1';
    wait for 100 ns;

    s_A <= '1';
    s_B <= '1';
    s_Ci <= '1';
    wait for 100 ns;
  end process;
  
end behavior;