-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- n_bit_register.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a n-bit register using dff

-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity n_bit_register is
  generic(N: integer:=32);
  port(i_clk : in std_logic;     -- Clock input
       i_rst : in std_logic;     -- Reset input
       i_we  : in std_logic;     -- Load input
       i_in  : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_out : out std_logic_vector(N-1 downto 0));   -- Data value output

end n_bit_register;

architecture structure of n_bit_register is
  component dff port (i_CLK : in std_logic;
			i_RST :in std_logic;
			i_WE : in std_logic;
			i_d :in std_logic;
			o_Q : out std_logic);
	end component;
begin
	ff: for i in 0 to N-1 generate
		ff_i: dff port map (i_CLK => i_CLK,
				i_RST => i_RST,
				i_WE => i_we,
				i_d => i_in(i),
				o_Q => o_out(i));
	end generate;

  
end structure;
