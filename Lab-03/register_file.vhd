-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- register_file.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a n-bit register using dff

-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use work.register_array_t.all;

entity register_file is
  port(i_clk : in std_logic;     -- Clock input
       i_write_en : in std_logic;     -- Write enable input
	i_rst : in std_logic;
       i_write_data  : in std_logic_vector(32-1 downto 0);     -- Write data
       i_write_addr  : in std_logic_vector(5-1 downto 0);     -- Write address
	   i_read_a_addr  : in std_logic_vector(5-1 downto 0);     -- Read address A
	   i_read_b_addr  : in std_logic_vector(5-1 downto 0);     -- Read address B
       o_data_a : out std_logic_vector(32-1 downto 0);	-- Data output A
	   o_data_b : out std_logic_vector(32-1 downto 0));   -- Data output B

end register_file;

architecture structure of register_file is
	component mux_32_1 
	  port( i_in : in reg_arr;     -- Register array
		   i_sel   : in std_logic_vector(5-1 downto 0);	  -- Select value input
		    o_out 	: out std_logic_vector(32-1 downto 0));   -- Data value output
	end component;

	component n_bit_register is
	  port(i_clk : in std_logic;     -- Clock input
		   i_rst : in std_logic;     -- Reset input
		   i_we  : in std_logic;     -- Load input
		   i_in  : in std_logic_vector(32-1 downto 0);     -- Data value input
		   o_out : out std_logic_vector(32-1 downto 0));   -- Data value output
	end component;
	
	component decoder_5_to_32  is
	  port(i_S	: in std_logic_vector(4 downto 0);
			i_en : in std_logic;
		   o_F	: out std_logic_vector(31 downto 0));
	end component;
	
	signal registers : reg_arr;
	signal s_en : std_logic_vector(31 downto 0); --temperatory enable value
	signal s_reg_en : std_logic_vector(31 downto 0); -- actual register enable
	signal s_read_a : std_logic_vector(31 downto 0);
	signal s_read_b : std_logic_vector(31 downto 0);
	
begin

	regs : for i in 0 to 31 generate
		reg_i: n_bit_register
			port map (i_clk => i_clk,
				i_rst => i_rst,
				i_we => s_reg_en(i),
				i_in => i_write_data,
				o_out => registers(i));
	end generate;
	decoder: decoder_5_to_32 port map(i_S => i_write_addr,
				i_en => '1',
				o_F =>  s_en);
	set_en_val : for i in 0 to 31 generate 
		s_reg_en(i) <= s_en(i) and i_write_en;
	end generate;
	mux1: mux_32_1 port map(i_in => registers, 
           i_sel => i_read_a_addr,
           o_out   => s_read_a);
	mux2: mux_32_1 port map(i_in => registers, 
           i_sel => i_read_b_addr,
           o_out   => s_read_b);
	-- account for zero register
	with i_read_a_addr select o_data_a <= "00000000000000000000000000000000" when "00000", s_read_a when others;
  	with i_read_b_addr select o_data_b <= "00000000000000000000000000000000" when "00000", s_read_b when others;
end structure;