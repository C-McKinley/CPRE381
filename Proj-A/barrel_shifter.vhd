-------------------------------------------------------------------------
-- Colby McKinley
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a barrel_shifter
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity barrel_shifter is
	port (
		i_data      : in std_logic_vector(32 - 1 downto 0);
		i_shift  : in std_logic_vector(5 - 1 downto 0); --
		i_la     : in std_logic_vector(5 - 1 downto 0); -- logical or arithmetic
		i_rl     : in std_logic_vector(5 - 1 downto 0); -- right or left
		o_f      : out std_logic_vector(32 - 1 downto 0)
	);
end barrel_shifter;

architecture structural of barrel_shifter is

	component andg2
		port (
			i_A  : in std_logic;
			i_B  : in std_logic;
			o_F  : out std_logic
		);
	end component;

	component org2
		port (
			i_A  : in std_logic;
			i_B  : in std_logic;
			o_F  : out std_logic
		);
	end component;

	component xorg2
		port (
			i_A  : in std_logic;
			i_B  : in std_logic;
			o_F  : out std_logic
		);
	end component;
	component mux2_structure
		port (
			i_A  : in std_logic;
			i_B  : in std_logic;
			i_S  : in std_logic;
			o_F  : out std_logic
		);
	end component;
	
	component mux2_structure_generic
		port (
			i_A  : in std_logic_vector(31 downto 0);
			i_B  : in std_logic (31 downto 0);
			i_S  : in std_logic;
			o_F  : out std_logic (31 downto 0)
		);
	end component;

	component invg
		port (
			i_A  : in std_logic;
			o_F  : out std_logic
		);
	end component;

	-- signal s_rl : std_logic;
	signal s_stage0 : std_logic_vector(32 - 1 downto 0);
	signal s_stage1 : std_logic_vector(32 - 1 downto 0);
	signal s_stage2 : std_logic_vector(32 - 1 downto 0);
	signal s_stage3 : std_logic_vector(32 - 1 downto 0);
	signal s_stage4 : std_logic_vector(32 - 1 downto 0);
	signal s_shift : std_logic_vector(32 - 1 downto 0);
	signal s_arithmetic_bit : std_logic;
begin
	-- set arithmetic/logic bit
	logic_arithmetic: mux2_structure port map(i_A => '0', i_B => i_data(31), i_S => i_la, o_F => s_arithmetic_bit);
	-- choose right or left
	rl: mux2_structure_generic port map(i_A => i_data, i_B => i_data, i_S => i_rl, o_F => s_shift);
	-- stage 0
	stg0: for i in 0 to 31 - 1 generate
		bit_i_stage0: mux2_structure port map(i_A => s_shift(i), i_B => s_shift(i+1), i_S => i_shift(0), o_f => s_stage0(i));
	end generate;
	bit31_stage0: mux2_structure port map(i_A => s_shift(30), i_B => s_arithmetic_bit, i_S => i_shift(0), o_f => s_stage0(31));
	
	-- stage 1
	stg1: for i in 0 to 31 - 2 generate 
		bit_i_stage1: mux2_structure port map(i_A => s_stage0(i), i_B => s_stage0(i+2), i_S => i_shift(1), o_f => s_stage1(i));
	end generate;
	bit30_stage1: mux2_structure port map(i_A => s_stage0(30), i_B => s_arithmetic_bit, i_S => i_shift(1), o_f => s_stage1(30));
	bit31_stage1: mux2_structure port map(i_A => s_stage0(31), i_B => s_arithmetic_bit, i_S => i_shift(1), o_f => s_stage1(31));

	-- stage 2
	stg2: for i in 0 to 31 - 4 generate 
		bit_i_stage2: mux2_structure port map(i_A => s_stage1(i), i_B => s_stage1(i+4), i_S => s_shift(2), o_f => s_stage2(i));
	end generate;
	bit28_stage2: mux2_structure port map(i_A => s_stage1(28), i_B => s_arithmetic_bit, i_S => s_shift(2), o_f => s_stage2(28));
	bit29_stage2: mux2_structure port map(i_A => s_stage1(29), i_B => s_arithmetic_bit, i_S => s_shift(2), o_f => s_stage2(29));
	bit30_stage2: mux2_structure port map(i_A => s_stage1(30), i_B => s_arithmetic_bit, i_S => s_shift(2), o_f => s_stage2(30));
	bit31_stage2: mux2_structure port map(i_A => s_stage1(31), i_B => s_arithmetic_bit, i_S => s_shift(2), o_f => s_stage2(31));

	-- stage 3
	stg3: for i in 0 to 31 - 8 generate 
		bit_i_stage3: mux2_structure port map(i_A => s_stage2(i), i_B => s_stage2(i+8), i_S => s_shift(3), o_f => s_stage3(i));
	end generate;
	bit24_stage3: mux2_structure port map(i_A => s_stage2(24), i_B => s_arithmetic_bit, i_S => s_shift(3), o_f => s_stage3(24));
	bit25_stage3: mux2_structure port map(i_A => s_stage2(25), i_B => s_arithmetic_bit, i_S => s_shift(3), o_f => s_stage3(25));
	bit26_stage3: mux2_structure port map(i_A => s_stage2(26), i_B => s_arithmetic_bit, i_S => s_shift(3), o_f => s_stage3(26));
	bit27_stage3: mux2_structure port map(i_A => s_stage2(27), i_B => s_arithmetic_bit, i_S => s_shift(3), o_f => s_stage3(27));
	bit28_stage3: mux2_structure port map(i_A => s_stage2(28), i_B => s_arithmetic_bit, i_S => s_shift(3), o_f => s_stage3(28));
	bit29_stage3: mux2_structure port map(i_A => s_stage2(29), i_B => s_arithmetic_bit, i_S => s_shift(3), o_f => s_stage3(29));
	bit30_stage3: mux2_structure port map(i_A => s_stage2(30), i_B => s_arithmetic_bit, i_S => s_shift(3), o_f => s_stage3(30));
	bit31_stage3: mux2_structure port map(i_A => s_stage2(31), i_B => s_arithmetic_bit, i_S => s_shift(3), o_f => s_stage3(31));

	-- stage 4
	stg4: for i in 0 to 31 - 16 generate 
		bit_i_stage4: mux2_structure port map(i_A => s_stage1(i), i_B => s_stage1(i+16), i_S => s_shift(4), o_f => s_stage4(i));
	end generate;
	bit24_stage4: mux2_structure port map(i_A => s_stage3(24), i_B => s_arithmetic_bit, i_S => s_shift(4), o_f => s_stage4(24));
	bit25_stage4: mux2_structure port map(i_A => s_stage3(25), i_B => s_arithmetic_bit, i_S => s_shift(4), o_f => s_stage4(25));
	bit26_stage4: mux2_structure port map(i_A => s_stage3(26), i_B => s_arithmetic_bit, i_S => s_shift(4), o_f => s_stage4(26));
	bit27_stage4: mux2_structure port map(i_A => s_stage3(27), i_B => s_arithmetic_bit, i_S => s_shift(4), o_f => s_stage4(27));
	bit28_stage4: mux2_structure port map(i_A => s_stage3(28), i_B => s_arithmetic_bit, i_S => s_shift(4), o_f => s_stage4(28));
	bit29_stage4: mux2_structure port map(i_A => s_stage3(29), i_B => s_arithmetic_bit, i_S => s_shift(4), o_f => s_stage4(29));
	bit30_stage4: mux2_structure port map(i_A => s_stage3(30), i_B => s_arithmetic_bit, i_S => s_shift(4), o_f => s_stage4(30));
	bit31_stage4: mux2_structure port map(i_A => s_stage3(31), i_B => s_arithmetic_bit, i_S => s_shift(4), o_f => s_stage4(31));

end structure;