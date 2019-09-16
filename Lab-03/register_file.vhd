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

entity register_file is
  port(i_clk : in std_logic;     -- Clock input
       i_write_en : in std_logic;     -- Write enable input
       i_write_data  : in std_logic_vector(5-1 downto 0);     -- Write data
       i_write_addr  : in std_logic_vector(5-1 downto 0);     -- Write address
	   i_read_a_addr  : in std_logic_vector(5-1 downto 0);     -- Read address A
	   i_read_b_addr  : in std_logic_vector(5-1 downto 0);     -- Read address B
       o_data_a : out std_logic_vector(32-1 downto 0);	-- Data output A
	   o_data_b : out std_logic_vector(32-1 downto 0));   -- Data output B

end register_file;

architecture structural of register_file is
	component mux_32_1 
	  port( i_in : in reg_arr;     -- Register array
		   i_sel   : in std_logic_vector(5-1 downto 0);	  -- Select value input
		    o_out 	: out std_logic_vector(32-1 downto 0));   -- Data value output
	end component;

	component n_bit_register is
	  port(i_clk : in std_logic;     -- Clock input
		   i_rst : in std_logic;     -- Reset input
		   i_ld  : in std_logic;     -- Load input
		   i_in  : in std_logic_vector(32-1 downto 0);     -- Data value input
		   o_out : out std_logic_vector(32-1 downto 0));   -- Data value output
	end component;
	
	component decoder_5_to_32  is
	  port(i_S	: in std_logic_vector(4 downto 0);
			i_en : in std_logic;
		   o_F	: out std_logic_vector(31 downto 0));
	end component;
	
	signal registers : reg_arr;
	signal select_wire : std_logic_vector(31 downto 0);
begin

	decoder: decoder_5_to_32 port map(i_S => i_write_addr,
				i_en => i_write_en,
				o_F =>  select_wire,

	mux1: mux32_1 port map(i_in => registers, 
           i_sel => i_read_a_addr,
           o_Q   => o_data_a);
	
	mux2: mux32_1 port map(i_in => registers, 
           i_sel => i_read_b_addr,
           o_Q   => o_data_b);
  
end structural;