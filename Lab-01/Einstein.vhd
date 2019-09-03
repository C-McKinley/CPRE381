-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Einstein.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of Einstein's energy
-- mass equation E=mc^2 using invidual adder and multiplier units.
--
-- 8/28/2019
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity Einstein is

  port(iCLK             : in std_logic;
       iM 		            : in integer;
       oE 		            : out integer);

end Einstein;

architecture structure of Einstein is
  
  -- Describe the component entities as defined in Adder.vhd 
  -- and Multiplier.vhd.
  component Adder
    port(iCLK           : in std_logic;
         iA             : in integer;
         iB             : in integer;
         oC             : out integer);
  end component;

  component Multiplier
    port(iCLK           : in std_logic;
         iA             : in integer;
         iB             : in integer;
         oC             : out integer);
  end component;

  -- constant c (converted to gigajoules to avoid overflow)
  constant cC : integer := 9487;

  -- Signal to store c^2
  signal sCsq : integer;

begin

  
  ---------------------------------------------------------------------------
  -- Level 1: Calculate c^2
  ---------------------------------------------------------------------------
  g_Mult1: Multiplier
    port MAP(iCLK             => iCLK,
             iA               => cC,
             iB               => cC,
             oC               => sCsq);
    
 ---------------------------------------------------------------------------
  -- Level 2: Calculate mc^2
  ---------------------------------------------------------------------------
  g_Mult2: Multiplier
    port MAP(iCLK             => iCLK,
             iA               => sCsq,
             iB               => iM,
             oC               => oE);

end structure;