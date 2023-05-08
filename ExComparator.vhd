library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.">";
use ieee.std_logic_unsigned.CONV_INTEGER;
use ieee.std_logic_misc.OR_REDUCE;

entity Comparator is
port(   Op_A: in std_logic_vector(31 downto 0);
	Op_B: in std_logic_vector(31 downto 0);
	LSign: out std_logic;
	SSign: out std_logic;
	Man_L: out std_logic_vector(25 downto 0);
	Man_S: out std_logic_vector(25 downto 0);
	Large_Exponent: out std_logic_vector(7 downto 0);
	Small_Exponent: out std_logic_vector(7 downto 0));
end Comparator;

architecture rtl of Comparator is

signal Bit_A: std_logic;
signal Bit_B: std_logic;
signal LargeO: std_logic_vector(31 downto 0);
signal SmallO: std_logic_vector(31 downto 0);

begin

LargeO <= OP_A when (OP_A(30 downto 23) > OP_B(30 downto 23)) else
	  OP_B;

SmallO <= OP_B when (OP_A(30 downto 23) > OP_B(30 downto 23)) else
	  OP_A;

Large_Exponent <= LargeO(30 downto 23);
Small_Exponent <= SmallO(30 downto 23);

LSign <= LargeO(31);
SSign <= SmallO(31);

Bit_A <= LargeO(31) OR OR_REDUCE(LargeO(22 downto 0)) OR OR_REDUCE(LargeO(30 downto 23));
Bit_B <= SmallO(31) OR OR_REDUCE(SmallO(22 downto 0)) OR OR_REDUCE(SmallO(30 downto 23));

Man_L <= '0' & Bit_A & LargeO(22 downto 0) & '0';
Man_S <= '0' & Bit_B & SmallO(22 downto 0) & '0';


end rtl;

