-------------------------------------------------------------------------
-- Tyler Dawson
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the 381 MIPS Processor

-- 11/20/2019 by TD::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

--Usually name your testbench similar to below for clarify tb_<name>
entity tb_MIPS_Processor is
--Generic for half of the clock cycle period
  generic(gCLK_HPER   : time := 10 ns;
          N           : integer := 32);  
end tb_MIPS_Processor;

architecture mixed of tb_MIPS_Processor is

--Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

--We will be making an instance of the file that we are testing
--TODO: Provide the appropriate port declarations for your processor
componet MIPS_Processor is
	generic (N : integer := 32);
	port   (iCLK : in std_logic;
		iRST : in std_logic;
		iInstLd : in std_logic;
		iInstAddr : in std_logic_vector(N - 1 downto 0);
		iInstExt : in std_logic_vector(N - 1 downto 0);
		oALUOut : out std_logic_vector(N - 1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end component;





