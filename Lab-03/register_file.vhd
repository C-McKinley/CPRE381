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
  generic(N: integer:=32);
  port(i_clk : in std_logic;     -- Clock input
       i_rst : in std_logic;     -- Reset input
       i_ld  : in std_logic;     -- Load input
       i_in  : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_out : out std_logic_vector(N-1 downto 0));   -- Data value output

end register_file;

architecture structural of register_file is
  signal s_D    : std_logic_vector(N-1 downto 0);    -- Multiplexed input to the FF
  signal s_Q    : std_logic_vector(N-1 downto 0);    -- Output of the FF

begin

  -- The output of the FF is fixed to s_Q
  o_out <= s_Q;
  
  -- Create a multiplexed input to the FF based on i_WE
  with i_ld select
    s_D <= i_in when '1',
           s_Q when others;
  
  -- This process handles the asyncrhonous reset and
  -- synchronous write. We want to be able to reset 
  -- our processor's registers so that we minimize
  -- glitchy behavior on startup.
  process (i_clk, i_rst)
  begin
    if (i_RST = '1') then
      s_Q <= (others => '0');
    elsif (rising_edge(i_CLK)) then
      s_Q <= s_D;
    end if;

  end process;
  
end structural;