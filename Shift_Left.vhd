library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.">";
use ieee.std_logic_unsigned.SHL;
use ieee.std_logic_unsigned.CONV_INTEGER;
use ieee.std_logic_misc.OR_REDUCE;
use ieee.std_logic_arith.all;

entity ShiftLeft is
	port(   Shift_Distance: in std_logic_vector(4 downto 0);
		SMan: in std_logic_vector(25 downto 0);
		SManOut: out std_logic_vector(22 downto 0)
	);
end ShiftLeft;

architecture rtl of ShiftLeft is
signal SManQ: std_logic_vector(25 downto 0);

begin 
SManQ <= SHL(SMan, Shift_Distance);
SManOut <= SManQ(24 downto 2);

end rtl;
