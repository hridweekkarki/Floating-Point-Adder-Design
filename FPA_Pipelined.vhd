library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity FPAPipelined is
port(   Clk: in std_logic;
	RST: in std_logic;
	EN: in std_logic;
	OP_A: in std_logic_vector(31 downto 0);
	OP_B: in std_logic_vector(31 downto 0);
	OP_Q: out std_logic_vector(31 downto 0)
);
end FPAPipelined;

architecture structural of FPAPipelined is

-- Components

component PipelineReg1 is
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
end component;

component PipelineReg2 is
port(
	CLK: in std_logic;
	RST: in std_logic;
	EN: in std_logic;
	OP_I: in std_logic_vector(31 downto 0);
	OP_O: out std_logic_vector(31 downto 0)
);
end component;

component Comparator is
port(   Op_A: in std_logic_vector(31 downto 0);
	Op_B: in std_logic_vector(31 downto 0);
	LSign: out std_logic;
	SSign: out std_logic;
	Man_L: out std_logic_vector(25 downto 0);
	Man_S: out std_logic_vector(25 downto 0);
	Large_Exponent: out std_logic_vector(7 downto 0);
	Small_Exponent: out std_logic_vector(7 downto 0));
end component;

component Small_ALU is
	port(OP_A: in std_logic_vector(7 downto 0);
	     OP_B: in std_logic_vector(7  downto 0);
	     OP_Q: out std_logic_vector(4 downto 0)
	);
end component;

component Big_ALU is
	port(OP_A: in std_logic_vector(25 downto 0);
	     OP_B: in std_logic_vector(25  downto 0);
	     Sel: in std_logic;
	     OP_Q: out std_logic_vector(25 downto 0)
	);
end component;

component MUX_1bit is
	port( 
		OP_A: in std_logic;
		OP_B: in std_logic;
		Sel: in std_logic;
		OP_Q: out std_logic
		);
end component;


component MUX_26 is
port( 
OP_A: in std_logic_vector(25 downto 0);
OP_B: in std_logic_vector(25 downto 0);
Sel: in std_logic;
OP_Q: out std_logic_vector(25 downto 0)
);

end component;

component ShiftRight is
	port(   Shift_Distance: in std_logic_vector(4 downto 0);
		SMan: in std_logic_vector(25 downto 0);
		SManOut: out std_logic_vector(25 downto 0)
	);
end component;

component ShiftLeft is
	port(   Shift_Distance: in std_logic_vector(4 downto 0);
		SMan: in std_logic_vector(25 downto 0);
		SManOut: out std_logic_vector(22 downto 0)
	);
end component;

component LOD is
	port(   Man_In: in std_logic_vector(25 downto 0);
		ExpCor: out std_logic_vector(7 downto 0);
		ShftDist: out std_logic_vector(4 downto 0);
		Man_Out: out std_logic_vector(25 downto 0)
	);
end component;

component ExpAlign is
	port(Exp: in std_logic_vector(7 downto 0);
	     ExpCorrector: in std_logic_vector(7  downto 0);
	     Exp_Out: out std_logic_vector(7 downto 0)
	);
end component;
--SIGNALS

signal SALU_A: std_logic_vector(7 downto 0);
signal SALU_B: std_logic_vector(7 downto 0);
signal ExpCorrector: std_logic_vector(7 downto 0);
signal Shift_Dist: std_logic_vector(4 downto 0);
signal Shift_Dist2: std_logic_vector(4 downto 0);
signal L_Man: std_logic_vector(25 downto 0);
signal S_Man: std_logic_vector(25 downto 0);
signal ManL2: std_logic_vector(25 downto 0);
signal ManS2: std_logic_vector(25 downto 0);
signal Man_S25: std_logic_vector(25 downto 0);
signal Man_Q: std_logic_vector(25 downto 0);
signal Man_Q2: std_logic_vector(25 downto 0);
signal LMUX_Sel: std_logic;
signal SMUX_Sel: std_logic;
signal LSign: std_logic;
signal SSign: std_logic;
signal BigALU_Sel: std_logic;
signal sQMan1: std_logic_vector(25 downto 0);
signal sQMan2: std_logic_vector(25 downto 0);
signal sQALU_Sel: std_logic;
signal sQSign: std_logic;
signal QSign: std_logic;
signal sQLExp: std_logic_vector(7 downto 0);

signal sOP_Q: std_logic_vector(31 downto 0);

begin

BigALU_Sel <= '0' when (OP_A(31) = OP_B(31)) else
	      '1';   
ExpComparator: Comparator port map(OP_A, OP_B, LSign, SSign, L_Man, Man_S25, SALU_A, SALU_B);
Exponent_Difference: Small_ALU port map(SALU_A, SALU_B, Shift_Dist);
RightShifter: ShiftRight port map(Shift_Dist, Man_S25, S_Man);
LMUX_Sel <= '0' when (LSign = SSign) else
	    '0' when (L_Man > S_Man) else
	    '1';
SMUX_Sel <= NOT(LMUX_Sel);
Large_MUX: MUX_26 port map(L_Man, S_Man, LMUX_Sel, ManL2);
Small_MUX: MUX_26 port map(L_Man, S_Man, SMUX_Sel, ManS2);
MUX1_Sign: MUX_1bit port map(LSign, SSign, LMUX_Sel, QSign);
RegisterPipeline_1: PipelineReg1 port map(Clk, RST, EN, ManL2, ManS2, BigALU_Sel, QSign, SALU_A, sQMan1, sQMan2, sQALU_Sel, sQSign, sQLExp); 
Mantissa_Addition: Big_ALU port map(sQMan1, sQMan2, sQALU_Sel, Man_Q);
Leading_One_Detector: LOD port map(Man_Q, ExpCorrector, Shift_Dist2, Man_Q2);
Exponent_Alignment: ExpAlign port map(sQLExp, ExpCorrector, sOP_Q(30 downto 23));
LeftShifter: ShiftLeft port map(Shift_Dist2, Man_Q2, sOP_Q(22 downto 0));
sOP_Q(31) <= sQSign;
RegisterPipeline_2: PipelineReg2 port map(Clk, RST, EN, sOP_Q, OP_Q);

 
end structural;
