library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Big_ALU is
	port(OP_A: in std_logic_vector(25 downto 0);
	     OP_B: in std_logic_vector(25  downto 0);
	     Sel: in std_logic;
	     OP_Q: out std_logic_vector(25 downto 0)
	);
end Big_ALU;

architecture rtl of Big_ALU is

begin

with Sel select
OP_Q <= OP_A + OP_B when '0',
	OP_A - OP_B when others;
end rtl;

