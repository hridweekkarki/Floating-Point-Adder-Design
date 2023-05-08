library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ExpAlign is
	port(Exp: in std_logic_vector(7 downto 0);
	     ExpCorrector: in std_logic_vector(7  downto 0);
	     Exp_Out: out std_logic_vector(7 downto 0)
	);
end ExpAlign;

architecture rtl of ExpAlign is

signal sExp: std_logic_vector(7 downto 0);
signal sExpCorrector: std_logic_vector(7 downto 0);
signal sExp_Out: std_logic_vector(7 downto 0);
begin
sExp <= Exp;
sExpCorrector <= ExpCorrector;
sExp_Out <= sExp + sExpCorrector;
Exp_Out <= sExp_Out;

end rtl;

