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

architecture Behavioral of control is
	type state is (S0,S1,S2,S3, R_type, R_type1, I_type,SI1,SI11,SI2,SI21,SI22,SI221,SI3, SI31,J_type);
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
		end if;
		if present_state = S3 then 
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
					--next_state <= R_type;
					present_state <= R_type;
				elsif	op = "1111" then
					--next_state <= J_type;
					present_state <= J_type;
				else 
					--next_state <= I_type;
					present_state <= I_type;
				end if;
		end if;
		if present_state = R_type then 
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
				--next_state <= R_type1;
				present_state <= R_type1;
		end if;
		if present_state = R_type1 then 
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
				--next_state <= S0;
				present_state <= S0;
		end if;
		if present_state = J_type then 
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
				--next_state <= S0;
				present_state <= S0;
		end if;
		if present_state = I_type then 
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
						--next_state <=SI1 ;
						present_state <= SI1;
				elsif op (3 downto 2) = "01" and op(1 downto 0) /= "11" then 
						--next_state <=SI1 ;
						present_state <= SI1;
				elsif op = "0111" or op = "1000"  then 
						--next_state <=SI2 ;
						present_state <= SI2;
				else
					--next_state <= SI3;
					present_state <= SI3;
				end if;
		end if;
		if present_state = SI1 then 
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
				--next_state <= SI11;
				present_state <= SI11;
		end if;
		if present_state = SI11 then 
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
				--next_state <= S0;
				present_state <= S0;
		end if;
		if present_state = SI2 then 
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
					--next_state <= SI21;
					present_state <= SI21;
				end if;
				if op = "0111" then
					--next_state <= SI22;
					present_state <= SI22;
				end if;
		end if;
		if present_state = SI21 then 
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
				--next_state <= S0;
				present_state <= S0;
		end if;
		if present_state = SI22 then 
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
				--next_state <= SI221;
				present_state <= SI221;
		end if;
		if present_state = SI221 then 
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
				--next_state <= S0;
				present_state <= S0;
		end if;
		if present_state = SI3 then 
		    --if cond = '1' then
		    --  PCen <= '1';
		    --else
		    PCen <= '0';
		    PCwrite <= '0';
		    --end if;
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
				--next_state <= SI31;
				present_state <= SI31;
		end if;
		if present_state = SI31 then 
		  --if cond = '1' then
	      --PCen <= '1';
	    --else 
	      PCen <= '0';
	      PCwrite <= '1';
	    --end if;
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
				--next_state <= S0;
				present_state <= S0;
		end if;
		--present_state <= next_state;
		end if;
	end process;

end Behavioral;

