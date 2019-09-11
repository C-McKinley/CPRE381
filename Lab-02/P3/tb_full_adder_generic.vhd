-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_full_adder_generic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a VHDL testbench for the
-- full adder (not generic).
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_full_adder_generic is
generic(M : integer := 32);
end tb_full_adder_generic;

architecture behavior of tb_full_adder_generic is

component full_adder_structure_generic
  generic(N: integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_C  : in std_logic;
       o_S  : out std_logic_vector(N-1 downto 0);
       o_C  : out std_logic);
end component;

component full_adder_dataflow_generic
  generic(N: integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_C  : in std_logic;
       o_S  : out std_logic_vector(N-1 downto 0);
       o_C  : out std_logic);
end component;

signal s_Ci, s_CoS, s_CoD : std_logic;
signal s_A, s_B, s_SS, s_SD  : std_logic_vector(M-1 downto 0);

begin

adder_s: full_adder_structure_generic
  generic map(N => M)
      port map (i_A => s_A,
		i_B => s_B,
		i_C => s_Ci,
		o_S => s_SS,
		o_C => s_CoS);

adder_d: full_adder_dataflow_generic
  generic map(N => M)
      port map (i_A => s_A,
		i_B => s_B,
		i_C => s_Ci,
		o_S => s_SD,
		o_C => s_CoD);
  process
  begin

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

    s_A <= x"00000000";
    s_B <= x"00000000";
    s_Ci <= '1';
    wait for 100 ns;
    
    s_A <= x"FFFFFFFF";
    s_B <= x"FFFFFFFF";
    s_Ci <= '0';
    wait for 100 ns;
  
    s_A <= x"11111111";
    s_B <= x"11111111";
    s_Ci <= '0';
    wait for 100 ns;
  
  end process;
  
end behavior;