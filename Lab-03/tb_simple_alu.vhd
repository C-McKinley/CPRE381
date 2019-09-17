-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_simple_alu.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file tests the simple alu file
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.register_array_t.all;
entity tb_simple_alu is
 generic(gCLK_HPER   : time := 50 ns);
end tb_simple_alu;

architecture behavior of tb_simple_alu is

  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

  component register_file is
  port(i_clk : in std_logic;     -- Clock input
       i_write_en : in std_logic;     -- Write enable input
	i_rst : in std_logic;
       i_write_data  : in std_logic_vector(32-1 downto 0);     -- Write data
       i_write_addr  : in std_logic_vector(5-1 downto 0);     -- Write address
	   i_read_a_addr  : in std_logic_vector(5-1 downto 0);     -- Read address A
	   i_read_b_addr  : in std_logic_vector(5-1 downto 0);     -- Read address B
       o_data_a : out std_logic_vector(32-1 downto 0);	-- Data output A
	   o_data_b : out std_logic_vector(32-1 downto 0));   -- Data output B
  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_RST, s_WE  : std_logic;
  signal s_da, s_db, s_wd : std_logic_vector(32-1 downto 0);
	signal s_wa, s_raa, s_rab : std_logic_vector(4 downto 0);

begin

  

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
    -- addi $1, $0, 1
    s_RST <= '1';
    s_WE  <= '0';
    s_wd   <= x"0000000E";
    s_wa <= "00001";
    s_raa   <= "10101";
    s_rab   <= "01010";
    wait for cCLK_PER;
    -- addi $2, $0, 2
    s_RST <= '0';
	s_we <= '1';
     s_wd   <= x"0000000E";
    s_wa <= "00001";
    s_raa   <= "11110";
    s_rab   <= "01111";
    wait for cCLK_PER;  
-- addi $3, $0, 3
    s_RST <= '0';
   s_wd   <= x"000000EE";
    s_wa <= "00001";
    s_raa   <= "10000";
    s_rab   <= "01111";
    wait for cCLK_PER;  
 -- addi $4, $0, 4
    s_RST <= '0';
	s_we <= '0';
    s_wd   <= x"000000EE";
    s_wa <= "00001";
    s_raa   <= "10111";
    s_rab   <= "11011";
    wait for cCLK_PER;  
 -- addi $5, $0, 5
    s_RST <= '0';
	s_we <= '1';
   s_wd   <= x"000000EE";
    s_wa <= "00001";
    s_raa   <= "11111";
    s_rab   <= "01110";
    wait for cCLK_PER;  
 -- addi $6, $0, 6
-- addi $7, $0, 7
-- addi $8, $0, 8
-- addi $9, $0, 9
-- addi $10, $0, 10
-- add $11, $1, $2
-- sub $12, $11, @3
-- add $13, $12, $4
-- sub $14, $13, $5
-- add $15, $14, $6
-- sub $16, $15, $7
-- add $17, $16, $8
-- sub $18, $17, $9
-- add $19, $18, $10
-- addi $20, $0, 35
-- add $21, $19, $20
    wait;
  end process;
  
end behavior;