library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is 
port(   LSign: in std_logic;
	SSign: in std_logic;
	LMan: in std_logic_vector(25 downto 0);
	SMan: in std_logic_vector(25 downto 0);
	MUXSel: out std_logic;
	ALUSel: out std_logic
);
end ControlUnit;

architecture rtl of ControlUnit is

begin

ALUSel <= '0' when (LSign = SSign) else
	  '1'; 

MUXSel <= '0' when (LSign = SSign) else
	  '0' when (LMan > SMan) else
	   '1';

end rtl;

