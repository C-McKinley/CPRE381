-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- adder_subtractor_module.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a adder subtractor module using 
-- structure architecture

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity simple_alu is
generic(N : integer := 32);
  port(i_read_a     : in std_logic_vector(5-1 downto 0);
	i_read_b : in std_logic_vector(5-1 downto 0);
	i_save_addr     : in std_logic_vector(5-1 downto 0);
       i_immediate     : in std_logic_vector(N-1 downto 0);
       n_add_sub    : in std_logic; -- select bit
	i_clk : in std_logic;
	i_alusrc : in std_logic;
	i_rst : in std_logic;
	i_write_en :in std_logic;
       o_Sum   : out std_logic_vector(N-1 downto 0);
       o_Cout  : out std_logic);

end simple_alu;

architecture structure of simple_alu is


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
component mux2_structure_generic is 
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_S  : in std_logic; -- Single bit select
       o_F  : out std_logic_vector(N-1 downto 0));
end component;
component adder_subtractor_structure_generic is
  port(i_A     : in std_logic_vector(N-1 downto 0);
       i_B     : in std_logic_vector(N-1 downto 0);
       i_C     : in std_logic;
       o_Sum   : out std_logic_vector(N-1 downto 0);
       o_Cout  : out std_logic);
end component;



signal sum: std_logic_vector(N-1 downto 0);
signal selB: std_logic_vector(N-1 downto 0);
signal tempB: std_logic_vector(N-1 downto 0); 
signal valA: std_logic_vector(N-1 downto 0);
signal s_carry: std_logic_vector(N downto 0);

begin

reg_file: register_file port map(
	 i_clk => i_clk, i_write_en => i_write_en, i_rst => i_rst, i_write_data => sum, 
	i_write_addr => i_save_addr,  i_read_a_addr => i_read_a, i_read_b_addr => i_read_b, 
	o_data_a => valA, o_data_b => tempB);
mux: mux2_structure_generic port map( i_A => i_immediate, i_B => tempB, i_S => i_alusrc, o_F => selB);
add_sub: adder_subtractor_structure_generic port map(
	i_A => valA, i_B => selB, i_C => n_add_sub, o_Sum => sum, o_Cout => o_Cout);

end structure;