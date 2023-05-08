library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PipelineReg3 is
port(
	CLK: in std_logic;
	RST: in std_logic;
	EN: in std_logic;
	OP_I: in std_logic_vector(31 downto 0);
	OP_O: out std_logic_vector(31 downto 0)
);
end PipelineReg3;

architecture rtl of PipelineReg3 is 
signal sOPQ: std_logic_vector(31 downto 0);

begin
process(clk)
begin 

	IF( clk'event and clk = '1') THEN
		IF(RST= '1')then 
        		sOPQ <= (others => '0');
		ELSIF( EN = '1') THEN
			sOPQ <= OP_I;
		ELSE
			sOPQ <= sOPQ;
			
		END IF;
	ELSE
		sOPQ <= sOPQ;
	END IF;
END process;
OP_O <= sOPQ;
end rtl;
