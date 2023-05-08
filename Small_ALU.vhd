library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Small_ALU is
	port(OP_A: in std_logic_vector(7 downto 0);
	     OP_B: in std_logic_vector(7  downto 0);
	     OP_Q: out std_logic_vector(4 downto 0)
	);
end Small_ALU;

architecture rtl of Small_ALU is
signal sOP_Q: std_logic_vector(7 downto 0);
begin
sOP_Q <= OP_A - OP_B;
OP_Q <= sOP_Q(4 downto 0);
end rtl;

