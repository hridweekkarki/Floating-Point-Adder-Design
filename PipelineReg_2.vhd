library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PipelineReg2 is

port(
	CLK: in std_logic;
	RST: in std_logic;
	EN: in std_logic;
	Man: in std_logic_vector(25 downto 0);
	Sign: in std_logic;
	LExp: in std_logic_vector(7 downto 0);
	QMan: out std_logic_vector(25 downto 0);
	QSign: out std_logic;
	QLExp: out std_logic_vector(7 downto 0)
);
end PipelineReg2;

architecture rtl of PipelineReg2 is 
signal sMan: std_logic_vector(25 downto 0);
signal sSign: std_logic;
signal sExp: std_logic_vector(7 downto 0);

begin
process(clk)
begin 

	IF( clk'event and clk = '1') THEN
		IF(RST= '1')then 
        		sMan <= (others => '0');
			sSign <= '0';
			sExp <= (others => '0');
		ELSIF( EN = '1') THEN
			sMan <= Man;
			sSign <= Sign;
			sExp <= LExp;
		ELSE
			sMan <= sMan;
			sSign <= sSign;
			sExp <= sExp;
			
		END IF;
	ELSE
		sMan <= sMan;
		sSign <= sSign;
		sExp <= sExp;
	END IF;
END process;
QMan <= sMan;
QSign <= sSign;
QLExp <= sExp;
end rtl;
