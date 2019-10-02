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

  component simple_alu is
 port(i_read_a_addr    : in std_logic_vector(5-1 downto 0);
		i_read_b_addr : in std_logic_vector(5-1 downto 0);
		i_write_addr     : in std_logic_vector(5-1 downto 0);
		i_immediate     : in std_logic_vector(32-1 downto 0);
		n_add_sub    : in std_logic; -- select bit
		i_clk : in std_logic;
		i_alusrc : in std_logic; -- use immediate
		i_write_en :in std_logic -- save enable
	);
  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_add_sub, s_WE, s_alu : std_logic;
  signal s_da, s_db, s_imm : std_logic_vector(32-1 downto 0);
	signal s_wa, s_raa, s_rab : std_logic_vector(4 downto 0);

begin

  
  alu: simple_alu
  port map(i_read_a_addr => s_raa,
		i_read_b_addr => s_rab,
		i_write_addr => s_wa,
		i_immediate => s_imm,
		n_add_sub => s_add_sub,
		i_clk => s_CLK,
		i_alusrc => s_alu,
		i_write_en => s_WE);


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
    s_WE  <= '1';
	s_alu <= '0';
	s_add_sub <= '0';
    s_imm   <= x"00000001";
    s_wa <= "00001";
    s_raa   <= "00000";
s_rab   <= "00000";
    wait for cCLK_PER;
    -- addi $2, $0, 2
	s_we <= '1';
	s_alu <= '0';
	s_add_sub <= '0';
	s_imm   <= x"00000002";
    s_wa <= "00010";
    s_raa   <= "00000";
    wait for cCLK_PER;  
	-- addi $3, $0, 3
    s_we <= '1';
	s_alu <= '0';
	s_add_sub <= '0';
	s_imm   <= x"00000003";
    s_wa <= "00011";
    s_raa   <= "00000";
    wait for cCLK_PER;  
 -- addi $4, $0, 4
	s_we <= '1';
	s_alu <= '0';
 	s_add_sub <= '0';
	s_imm   <= x"00000004";
    s_wa <= "00100";
    s_raa   <= "00000";
    wait for cCLK_PER;  
 -- addi $5, $0, 5
	s_we <= '1';
	s_alu <= '0';
	s_add_sub <= '0';
	s_imm   <= x"00000005";
    s_wa <= "00101";
    s_raa   <= "00000";
    wait for cCLK_PER;  
 -- addi $6, $0, 6
	s_we <= '1';
	s_alu <= '0';
	s_add_sub <= '0';
	s_imm   <= x"00000006";
    s_wa <= "00110";
    s_raa   <= "00000";
    wait for cCLK_PER;  
-- addi $7, $0, 7
s_we <= '1';
	s_alu <= '0';
	s_add_sub <= '0';
	s_imm   <= x"00000007";
    s_wa <= "00111";
    s_raa   <= "00000";
    wait for cCLK_PER;  
-- addi $8, $0, 8
s_we <= '1';
	s_alu <= '0';
	s_add_sub <= '0';
	s_imm   <= x"00000008";
    s_wa <= "01000";
    s_raa   <= "00000";
    wait for cCLK_PER;  
-- addi $9, $0, 9
s_we <= '1';
	s_alu <= '0';
	s_add_sub <= '0';
	s_imm   <= x"00000009";
    s_wa <= "01001";
    s_raa   <= "00000";
    wait for cCLK_PER;  
-- addi $10, $0, 10
s_we <= '1';
	s_alu <= '0';
	s_add_sub <= '0';
	s_imm   <= x"0000000A";
    s_wa <= "01010";
    s_raa   <= "00000";
    wait for cCLK_PER;  
-- add $11, $1, $2
s_we <= '1';
	s_alu <= '1';
 	s_add_sub <= '0';
   s_wa <= "01011";
    s_raa   <= "00001";
	s_rab   <= "00010";
    wait for cCLK_PER; 
-- sub $12, $11, $3
s_we <= '1';
	s_alu <= '1';
	s_add_sub <= '1';
    s_wa <= "01100";
    s_raa   <= "01011";
	s_rab   <= "00011";
    wait for cCLK_PER; 
-- add $13, $12, $4
s_we <= '1';
	s_alu <= '1';
s_add_sub <= '0';
    s_wa <= "01100";
    s_raa   <= "01011";
	s_rab   <= "00011";
    wait for cCLK_PER; 
-- sub $14, $13, $5
s_we <= '1';	
s_add_sub <= '1';
  	s_alu <= '1';
  s_wa <= "01110";
    s_raa   <= "01101";
	s_rab   <= "00101";
    wait for cCLK_PER; 
-- add $15, $14, $6
s_we <= '1';	
s_add_sub <= '0';
   	s_alu <= '1';
 s_wa <= "01111";
    s_raa   <= "01110";
	s_rab   <= "00110";
    wait for cCLK_PER;
-- sub $16, $15, $7
s_we <= '1';	
s_add_sub <= '1';
  	s_alu <= '1';
  s_wa <= "10000";
    s_raa   <= "01111";
	s_rab   <= "00111";
    wait for cCLK_PER;
-- add $17, $16, $8
s_we <= '1';	
s_add_sub <= '0';
   	s_alu <= '1';
 s_wa <= "10001";
    s_raa   <= "10000";
	s_rab   <= "01000";
    wait for cCLK_PER;
-- sub $18, $17, $9
s_we <= '1';	
s_add_sub <= '1';
   	s_alu <= '1';
 s_wa <= "10010";
    s_raa   <= "10001";
	s_rab   <= "01001";
    wait for cCLK_PER;
-- add $19, $18, $10
s_we <= '1';	
s_add_sub <= '0';
   	s_alu <= '1';
 s_wa <= "10011";
    s_raa   <= "10010";
	s_rab   <= "01010";
    wait for cCLK_PER;
-- addi $20, $0, 35
s_we <= '1';	
s_add_sub <= '0';
   	s_alu <= '0';
 s_wa <= "10100";
    s_raa   <= "00000";
	s_imm   <= x"00000023";
    wait for cCLK_PER;
-- add $21, $19, $20
s_we <= '1';	
s_add_sub <= '0';
  	s_alu <= '1';
 s_wa <= "10101";
    s_raa   <= "10011";
	s_rab   <= "10100";
    wait for cCLK_PER;
    wait;
  end process;
  
end behavior;