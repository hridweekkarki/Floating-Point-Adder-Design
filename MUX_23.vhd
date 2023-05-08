library ieee;
use ieee.std_logic_1164.all;

entity MUX_26 is
port( 
OP_A: in std_logic_vector(25 downto 0);
OP_B: in std_logic_vector(25 downto 0);
Sel: in std_logic;
OP_Q: out std_logic_vector(25 downto 0)
);

end MUX_26;

architecture rtl of MUX_26 is
begin
OP_Q <= OP_A when (Sel='0') else
	OP_B;
end rtl;
