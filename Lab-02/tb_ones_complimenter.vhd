-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_ones_complimenter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a VHDL testbench for the
-- ones complimenter desgins.
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ones_complimenter is
generic(M : integer := 32);
end tb_ones_complimenter;

architecture behavior of tb_ones_complimenter is

component ones_complimenter_dataflow
generic(N: integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

component ones_complimenter_structure
generic(N: integer := 32);

  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

signal s_A, s_B, s_F  : std_logic_vector(M-1 downto 0);

begin

oc_d: ones_complimenter_dataflow 
  generic map(N => M)
      port map(i_A => s_A,
               o_F => s_F);  
oc_s: ones_complimenter_structure 
  generic map(N => M)
      port map(i_A => s_A,
               o_F => s_B);  

  process
  begin

    s_A <= '00000000000000000000000000000000';
    wait for 100 ns;

    s_A <= '11111111111111111111111111111111';
    wait for 100 ns;

    s_A <= '10101010101010101010101010101010';
    wait for 100 ns;

    s_A <= '00001111000011110000111100001111';
    wait for 100 ns;


  end process;
  
end behavior;
