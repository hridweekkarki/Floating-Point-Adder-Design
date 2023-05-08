library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.">";
use ieee.std_logic_unsigned.SHR;
use ieee.std_logic_unsigned.CONV_INTEGER;
use ieee.std_logic_misc.OR_REDUCE;
use ieee.std_logic_arith.all;

entity ShiftRight is
	port(   Shift_Distance: in std_logic_vector(4 downto 0);
		SMan: in std_logic_vector(25 downto 0);
		SManOut: out std_logic_vector(25 downto 0)
	);
end ShiftRight;

architecture rtl of ShiftRight is
signal SManShift: std_logic_vector(25 downto 0);
begin 
SManShift <= SHR(SMan, Shift_Distance);
SManOut <= SManShift;

end rtl;
