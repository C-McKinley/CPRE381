-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_n_bit_register.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file tests the n_bit_register file
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_n_bit_register is
 generic(gCLK_HPER   : time := 50 ns);
end tb_n_bit_register;

architecture behavior of tb_n_bit_register is

  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

  component n_bit_register
    port(i_clk : in std_logic;     -- Clock input
       i_rst : in std_logic;     -- Reset input
       i_we  : in std_logic;     -- Load input
       i_in  : in std_logic_vector(32-1 downto 0);     -- Data value input
       o_out : out std_logic_vector(32-1 downto 0));   -- Data value output
  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_RST, s_WE  : std_logic;
  signal s_D, s_Q : std_logic_vector(32-1 downto 0);

begin

  reg: n_bit_register
  port map(i_CLK => s_CLK, 
           i_RST => s_RST,
           i_WE  => s_WE,
           i_in   => s_D,
           o_out   => s_Q);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
    -- Reset the FF
    s_RST <= '1';
    s_WE  <= '0';
    s_D   <= x"00000000";
    wait for cCLK_PER;

    s_RST <= '0';
    s_WE  <= '1';
    s_D   <=  x"00000001";
    wait for cCLK_PER;  
    s_RST <= '0';
    s_WE  <= '0';
    s_D   <=  x"FFFF0000";
    wait for cCLK_PER;  

    -- Store '0'    
    s_RST <= '0';
    s_WE  <= '1';
    s_D   <= x"0000FFF0";
    wait for cCLK_PER;  

    s_RST <= '0';
    s_WE  <= '0';
    s_D   <= x"00000000";
    wait for cCLK_PER;  

    wait;
  end process;
  
end behavior;