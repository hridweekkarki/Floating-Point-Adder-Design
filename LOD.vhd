library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned."-";
use ieee.std_logic_unsigned."+";
use ieee.std_logic_unsigned.">";
use ieee.std_logic_unsigned.SHL;
use ieee.std_logic_arith.CONV_STD_LOGIC_VECTOR;

entity LOD is
	port(   Man_In: in std_logic_vector(25 downto 0);
		ExpCor: out std_logic_vector(7 downto 0);
		ShftDist: out std_logic_vector(4 downto 0);
		Man_Out: out std_logic_vector(25 downto 0)
	);
end LOD;

architecture rtl of LOD is

signal ExpCorrector: std_logic_vector(7 downto 0);
signal Shift_Distance2: std_logic_vector(4 downto 0);
begin

ExpCorrector <= "00000001" when (Man_In(25)='1') else
		"00000000" when (Man_In(24)='1') else
		"11111111" when (Man_In(23)='1') else
		"11111110" when (Man_In(22)='1') else
		"11111101" when (Man_In(21)='1') else
		"11111100" when (Man_In(20)='1') else
		"11111011" when (Man_In(19)='1') else
		"11111010" when (Man_In(18)='1') else
		"11111001" when (Man_In(17)='1') else
		"11111000" when (Man_In(16)='1') else
		"11110111" when (Man_In(15)='1') else
		"11110110" when (Man_In(14)='1') else
		"11110101" when (Man_In(13)='1') else
		"11110100" when (Man_In(12)='1') else
		"11110011" when (Man_In(11)='1') else
		"11110010" when (Man_In(10)='1') else
		"11110001" when (Man_In(9)='1') else
		"11110000" when (Man_In(8)='1') else
		"11101111" when (Man_In(7)='1') else
		"11101110" when (Man_In(6)='1') else
		"11101101" when (Man_In(5)='1') else
		"11101100" when (Man_In(4)='1') else
		"11101011" when (Man_In(3)='1') else
		"11101010" when (Man_In(2)='1') else
		"11101001" when (Man_In(1)='1') else
		"00000000";

Shift_Distance2   <=    "00000" when (Man_In(25)='1') else
			"00001" when (Man_In(24)='1') else	
			"00010" when (Man_In(23)='1') else
			"00011" when (Man_In(22)='1') else
			"00100" when (Man_In(21)='1') else
			"00101" when (Man_In(20)='1') else
			"00110" when (Man_In(19)='1') else
			"00111" when (Man_In(18)='1') else
			"01000" when (Man_In(17)='1') else
			"01001" when (Man_In(16)='1') else
			"01010" when (Man_In(15)='1') else
			"01011" when (Man_In(14)='1') else
			"01100" when (Man_In(13)='1') else
			"01101" when (Man_In(12)='1') else
			"01110" when (Man_In(11)='1') else
			"01111" when (Man_In(10)='1') else
			"10000" when (Man_In(9)='1') else
			"10001" when (Man_In(8)='1') else
			"10010" when (Man_In(7)='1') else
			"10011" when (Man_In(6)='1') else
			"10100" when (Man_In(5)='1') else
			"10101" when (Man_In(4)='1') else
			"10110" when (Man_In(3)='1') else
			"10111" when (Man_In(2)='1') else
			"11000" when (Man_In(1)='1') else
			"00000";

ExpCor <= ExpCorrector;
ShftDist <= Shift_Distance2;
Man_Out <= Man_In;

end rtl;
