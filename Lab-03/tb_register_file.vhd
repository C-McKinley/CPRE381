-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_register_file.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file tests the n_bit_register file
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.register_array_t.all;
entity tb_register_file is
 generic(gCLK_HPER   : time := 50 ns);
end tb_register_file;

architecture behavior of tb_register_file is

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

  reg_file: register_file
  port map(i_CLK => s_CLK, 
	i_write_en => s_WE,
           i_RST => s_RST,
           i_write_data => s_wd,
           i_write_addr => s_wa,
	 i_read_a_addr => s_raa,
	i_read_b_addr => s_rab,
           o_data_a   => s_da,
	o_data_b   => s_db);

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
    s_wd   <= x"0000000F";
    s_wa <= "00001";
    s_raa   <= "10101";
    s_rab   <= "01010";
    wait for cCLK_PER;

    s_RST <= '0';
	s_we <= '1';
     s_wd   <= x"000000EF";
    s_wa <= "00010";
    s_raa   <= "00001";
    s_rab   <= "01111";
    wait for cCLK_PER;  
	
    s_RST <= '0';
   s_wd   <= x"00000DDF";
   s_we <= '1';
    s_wa <= "00001";
    s_raa   <= "10000";
    s_rab   <= "01111";
    wait for cCLK_PER;  
 
    s_RST <= '0';
	s_we <= '0';
    s_wd   <= x"0000CDEF";
	s_we <= '1';
    s_wa <= "00011";
    s_raa   <= "10111";
    s_rab   <= "11011";
    wait for cCLK_PER;  

    s_RST <= '0';
	s_we <= '1';
   s_wd   <= x"000BCDEF";
    s_wa <= "00101";
    s_raa   <= "11111";
    s_rab   <= "01110";
    wait for cCLK_PER;  


    s_RST <= '0';
	s_we <= '0';
   s_wd   <= x"00ABCDEF";
    s_wa <= "00111";
    s_raa   <= "11111";
    s_rab   <= "01110";
    wait for cCLK_PER;  

  s_RST <= '0';
	s_we <= '1';
   s_wd   <= x"09ABCDEF";
    s_wa <= "00111";
    s_raa   <= "11111";
    s_rab   <= "01110";
    wait for cCLK_PER;  

    wait;
  end process;
  
end behavior;