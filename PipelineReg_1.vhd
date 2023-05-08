library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PipelineReg1 is

port(
	CLK: in std_logic;
	RST: in std_logic;
	EN: in std_logic;
	Man1: in std_logic_vector(25 downto 0);
	Man2: in std_logic_vector(25 downto 0);
	ALU_Sel: in std_logic;
	Sign: in std_logic;
	LExp: in std_logic_vector(7 downto 0);
	QMan1: out std_logic_vector(25 downto 0);
	QMan2: out std_logic_vector(25 downto 0);
	QALU_Sel: out std_logic;
	QSign: out std_logic;
	QLExp: out std_logic_vector(7 downto 0)
);
end PipelineReg1;

architecture rtl of PipelineReg1 is 
signal sMan1: std_logic_vector(25 downto 0);
signal sMan2: std_logic_vector(25 downto 0);
signal sALU_Sel: std_logic;
signal sSign: std_logic;
signal sExp: std_logic_vector(7 downto 0);

begin
process(clk)
begin 

	IF( clk'event and clk = '1') THEN
		IF(RST= '1')then 
        		sMan1 <= (others => '0');
			sMan2 <= (others => '0');
			sALU_Sel <= '0';
			sSign <= '0';
			sExp <= (others => '0');
		ELSIF( EN = '1') THEN
			sMan1 <= Man1;
			sMan2 <= Man2;
			sALU_Sel <= ALU_Sel;
			sSign <= Sign;
			sExp <= LExp;
		ELSE
			sMan1 <= sMan1;
			sMan2 <= sMan2;
			sALU_Sel <= sALU_Sel;
			sSign <= sSign;
			sExp <= sExp;
			
		END IF;
	ELSE
		sMan1 <= sMan1;
		sMan2 <= sMan2;
		sALU_Sel <= sALU_Sel;
		sSign <= sSign;
		sExp <= sExp;
	END IF;
END process;
QMan1 <= sMan1;
QMan2 <= sMan2;
QALU_Sel <= sALU_Sel;
QSign <= sSign;
QLExp <= sExp;
end rtl;
