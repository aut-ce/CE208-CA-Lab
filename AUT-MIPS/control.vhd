library IEEE;
use IEEE.std_logic_1164.all;

entity control is
    Port ( clk : in  STD_LOGIC;
           cond : in  STD_LOGIC;
           op : in  STD_LOGIC_VECTOR (3 downto 0);
           PCen : out  STD_LOGIC;
           PCwrite : out  STD_LOGIC;
           IorD : out  STD_LOGIC_vector (1 downto 0);
           memread : out  STD_LOGIC;
           memwrite : out  STD_LOGIC;
           memtoreg : out  STD_LOGIC_VECTOR (1 downto 0);
           IRe : out  STD_LOGIC;
           PCscr : out  STD_LOGIC_VECTOR (1 downto 0);
           ALUop : out  STD_LOGIC_VECTOR (3 downto 0);
           ALUsrcB : out  STD_LOGIC_VECTOR (1 downto 0);
           ALUsrcA : out  STD_LOGIC_VECTOR (1 downto 0);
           AluFunc : out  STD_LOGIC_VECTOR (1 downto 0);
           regdest : out  STD_LOGIC_VECTOR (1 downto 0);
           regwrite : out  STD_LOGIC);
end control;

architecture rtl of control is
	type state is (S0, S1, S2, S3, SR0, SR1, SI0, SI10, SI11, SI20, SI21, SI220, SI221, SI30, SI31, SJ0);
	signal present_state, next_state : state := S0;
begin
	process (clk)
		if clk'event and clk = '1' then
			current_state <= next_state;
		end if;
	end process;

	process(current_state)
	begin
		case present_state is
			when S0 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '1';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "01";
				ALUop <= "0000";
				ALUsrcB <= "01";
				ALUsrcA <= "00";
				AluFunc <= "00";
				regdest <= "00";
				regwrite <= '0';
				
				next_state <= S1;

			when S1 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '1';
				PCscr <= "00";
				ALUop <= "0000";
				ALUsrcB <= "01";
				ALUsrcA <= "00";
				AluFunc <= "00";
				regdest <= "00";
				regwrite <= '0';
				
				next_state <= S2;
			when S2 =>
				PCen <= '1';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '1';
				PCscr <= "00";
				ALUop <= "0000";
				ALUsrcB <= "01";
				ALUsrcA <= "00";
				AluFunc <= "00";
				regdest <= "00";
				regwrite <= '0';

				next_state <= S2;
			when S3 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "01";
				ALUop <= "0000";
				ALUsrcB <= "01";
				ALUsrcA <= "00";
				AluFunc <= "01";
				regdest <= "00";
				regwrite <= '0';
				
				if op = "0000" then
					next_state <= SR0;
				elsif op = "1111" then
					next_state <= SJ0;
				else
					next_state <= SI0;
				end if;
			when SR0 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "00";
				ALUop <= op;
				ALUsrcB <= "00";
				ALUsrcA <= "01";
				AluFunc <= "01";
				regdest <= "00";
				regwrite <= '0';

				next_state <= SR1;
			when SR1 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "00";
				ALUop <= op;
				ALUsrcB <= "00";
				ALUsrcA <= "01";
				AluFunc <= "01";
				regdest <= "01";
				regwrite <= '1';

				next_state <= S0;
			when SJ0 =>
				PCen <= '1';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "10";
				ALUop <= op;
				ALUsrcB <= "00";
				ALUsrcA <= "01";
				AluFunc <= "01";
				regdest <= "00";
				regwrite <= '0';

				next_state <= S0;
			when SI0 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "10";
				ALUop <= op;
				ALUsrcB <= "10";
				ALUsrcA <= "01";
				AluFunc <= "01";
				regdest <= "00";
				regwrite <= '0';
				
				if op (3 downto 2) = "00" and op(1 downto 0) /= "00" then
					next_state <=SI10;
				elsif op (3 downto 2) = "01" and op(1 downto 0) /= "11" then
					next_state <=SI10;
				elsif op = "0111" or op = "1000"  then
					next_state <=SI20 ;
				else
					next_state <= SI30;
				end if;
			when SI10 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "10";
				ALUop <= op;
				ALUsrcB <= "10";
				ALUsrcA <= "01";
				AluFunc <= "01";
				regdest <= "00";
				regwrite <= '0';

				next_state <= SI11;
			when SI11 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "10";
				ALUop <= op;
				ALUsrcB <= "10";
				ALUsrcA <= "01";
				AluFunc <= "01";
				regdest <= "00";
				regwrite <= '1';

				next_state <= S0;
			when SI20 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "10";
				ALUop <= op;
				ALUsrcB <= "10";
				ALUsrcA <= "01";
				AluFunc <= "00";
				regdest <= "00";
				regwrite <= '0';
				if op = "1000" then
					next_state <= SI210;
				end if;
				if op = "0111" then
					next_state <= SI220;
				end if;
			when SI210 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "01";
				memread <= '0';
				memwrite <= '1';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "10";
				ALUop <= op;
				ALUsrcB <= "10";
				ALUsrcA <= "01";
				AluFunc <= "00";
				regdest <= "00";
				regwrite <= '0';

				next_state <= S0;
			when SI220 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "01";
				memread <= '1';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "10";
				ALUop <= op;
				ALUsrcB <= "10";
				ALUsrcA <= "01";
				AluFunc <= "01";
				regdest <= "00";
				regwrite <= '0';

				next_state <= SI221;
			when SI221 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "01";
				IRe <= '0';
				PCscr <= "10";
				ALUop <= op;
				ALUsrcB <= "10";
				ALUsrcA <= "01";
				AluFunc <= "01";
				regdest <= "00";
				regwrite <= '1';

				next_state <= S0;
			when SI30 =>
				PCen <= '0';
				PCwrite <= '0';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "10";
				ALUop <= op;
				ALUsrcB <= "10";
				ALUsrcA <= "00";
				AluFunc <= "10";
				regdest <= "00";
				regwrite <= '0';

				next_state <= SI31;
			when SI31 =>
				PCen <= '0';
				PCwrite <= '1';
				IorD <= "00";
				memread <= '0';
				memwrite <= '0';
				memtoreg <= "00";
				IRe <= '0';
				PCscr <= "01";
				ALUop <= op;
				ALUsrcB <= "00";
				ALUsrcA <= "01";
				AluFunc <= "01";
				regdest <= "00";
				regwrite <= '0';

				next_state <= S0;
			when others =>
				next_state <= current_state;
		end case;
	end process;
end architecture rtl;

