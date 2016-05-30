--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   23-05-2016
-- Module Name:   datapath.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity datapath is
	port(clk: in std_logic);
end entity datapath;

architecture structural of datapath is
	component ALU is
		port (A : in  std_logic_vector (15 downto 0);
			B : in std_logic_vector (15 downto 0);
			OP : in std_logic_vector (3 downto 0);
			func : in std_logic_vector (2 downto 0);
			result : out std_logic_vector (15 downto 0);
			cond : out std_logic);
	end component;

	component control
		port (clk : in std_logic;
			cond : in std_logic;
			op : in std_logic_vector (3 downto 0);
			PCen : out std_logic;
			PCwrite : out std_logic;
			IorD : out std_logic_vector (1 downto 0);
			memread : out std_logic;
			memwrite : out std_logic;
			memtoreg : out std_logic_vector (1 downto 0);
			IRe : out std_logic;
			PCscr : out std_logic_vector (1 downto 0);
        	   	ALUop : out std_logic_vector (3 downto 0);
        	   	ALUsrcB : out std_logic_vector (1 downto 0);
        	   	ALUsrcA : out std_logic_vector (1 downto 0);
        	   	AluFunc : out std_logic_vector (1 downto 0);
        	   	regdest : out std_logic_vector (1 downto 0);
        	   	regwrite : out std_logic);
	end component;

	component memory
		port (address : in std_logic_vector;
			data_in : in std_logic_vector;
			data_out : out std_logic_vector;
			clk, read, write : in std_logic);
	end component;

	component regfile
		generic (N : integer := 3;
			M : integer := 16);
		port (readaddr1, readaddr2 : in std_logic_vector (N - 1 downto 0);
			writeaddr : in std_logic_vector (N - 1 downto 0);
			data : in std_logic_vector (M - 1 downto 0);
			write, clk : in std_logic;
			O1, O2 : out std_logic_vector (M - 1 downto 0));
	end component;
	
	component register_N
		generic (N : integer := 16);
		port (reset, clk, load  : in std_logic;
			ldata : in std_logic_vector (N - 1 downto 0);
			O : out std_logic_vector (N - 1 downto 0));
	end component;

	component mux4
		generic (N : integer := 16);
		port (I00, I01, I10, I11 : in std_logic_vector (N - 1 downto 0);
			O : out std_logic_vector (N - 1 downto 0);
			S : in  std_logic_vector (1 downto 0));
	end component;

	for all:mux4 use entity work.mux4;
	for all:register_N use entity work.register_N;
	for all:memory use entity work.memory;
	for all:regfile use entity work.regfile;
	for all:control use entity work.control;
	for all:ALU use entity work.ALU;

	signal tmp1,tmp2,tmp3,tmp4,tmp5, tmp6 :std_logic_vector(15 downto 0);

	signal PCen, memread, memwrite, IRe, regWrite,cond,PCenOrCond, PCwrite:std_logic;
	signal pcInput, pcOutput, outOfAlu, Aout, Bout, AluOutIn, memoryIn, AluA, AluB, writeData, writeRegister, Ain, Bin,memoryDataIn, IRIn, IROut, FuncOfAlu:std_logic_vector (15 downto 0);
	signal IorD, regDst, memToReg, AluSrcA, AluSrcB, AluFunc,pcSrc:std_logic_vector (1 downto 0); 
	signal op: std_logic_vector (3 downto 0);


begin
	tmp1 <= "0000000000000" & IROut(8 downto 6);
	tmp2 <= "0000000000000" & IROut(5 downto 3);
	tmp3 <= "0000" & IROut(11 downto 0);
	tmp4 <= "0000000000" & IROut(5 downto 0);
	tmp5 <= "0000000000000" & IROut(2 downto 0);
	PCenOrCond <= PCen or (cond and PCwrite);
	
	mem: memory port map (IRIn, memoryIn ,Bout, clk, memread , memwrite);
	
	m1: mux4 port map (pcOutput, outOfAlu, (others => '0'), (others => '0'), memoryIn, IorD);
	m2: mux4 port map (outOfAlu, IRIn, (others => '0'), (others => '0'), writeData, memToReg);
	m3: mux4 port map (tmp1, tmp2, (others => '0'), (others => '0'), writeRegister, regDst);
	m4: mux4 port map (pcOutput, Aout, (others => '0'), (others => '0'), AluA, AluSrcA);
	m5: mux4 port map (Bout, (0 => '1'), tmp4, (others => '0'), AluB, AluSrcB);
	m6: mux4 port map (AluOutIn, outOfAlu, tmp3, (others => '0'), pcInput, pcSrc);
	
	IR: register_N port map ('0' ,clk, IRe, IRIn, IROut);
	pc: register_N port map ('0' ,clk, PCenOrCond, pcInput, pcOutput);
	A: register_N port map ('0' ,clk, '1', Ain, Aout);
	B: register_N port map ('0' ,clk, '1', Bin, Bout);
	ALUOUT: register_N port map ('0' ,clk, '1', AluOutIn, outOfAlu);
	
	controlUnit: control port map (clk, cond, IROut(15 downto 12), PCen,PCwrite, IorD, memread, memwrite, memtoreg, IRe, PCsrc, op, ALUsrcB, ALUsrcA, AluFunc, regdst, regwrite);
	
	registerFile: regfile port map (IROut(11 downto 9), IROut(8 downto 6), writeRegister(2 downto 0), writeData, regWrite, clk, Ain,Bin);
	mux7foralufunc:	mux4 port map ((others => '0'), tmp5, (others => '0'), (others => '0'), FuncOfAlu, AluFunc);
	ALU000: ALU port map (AluA, AluB, op, FuncOfAlu(2 downto 0), AluOutIn, cond);

end architecture;
