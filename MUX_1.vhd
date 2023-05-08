library ieee;
use ieee.std_logic_1164.all;

entity MUX_1bit is
port( 
OP_A: in std_logic;
OP_B: in std_logic;
Sel: in std_logic;
OP_Q: out std_logic
);

end MUX_1bit;

architecture rtl of MUX_1bit is
begin
OP_Q <= OP_A when (Sel='0') else
	OP_B;
end rtl;
