--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   23-05-2016
-- Module Name:   ALU.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity ALU is
    port (A, B : in  std_logic_vector (15 downto 0);
		OP : in  std_logic_vector (3 downto 0);
		func : in  std_logic_vector (2 downto 0);
		result : out  std_logic_vector (15 downto 0);
		cond : out  std_logic);
end ALU;

architecture rtl of ALU is
	Signal tResult : std_logic_vector (15 downto 0);
	Signal tCond :   std_logic;
begin
	process(A, B, OP, func)
	begin
		case OP is
			when "0000" =>
				if func = "000" then
					tResult <= A + B;
				elsif func = "001" then
					tResult <= A - B;
				elsif func = "010" then
					tResult <= (A AND B);
				elsif func = "011" then
					tResult <= (A OR B);
				elsif func = "100" then
					tResult <= (A XOR B);
				elsif func = "101" then
					tResult <= (A NOR B);
				elsif func = "110" then
					if A < B then
						tResult <= (0 => '1', others => '0');
					else
						tResult <= (others => '0');
					end if;
				end if;
				tCond <= '0';
			when "0001" =>
				tResult <= A + B;
				tCond <= '0';
			when "0010" =>
				tResult <= (A AND B);
				tCond <= '0';
			when "0011" =>
				tResult <= (A OR B);
				tCond <= '0';
			when "0100" =>
				tResult <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
				tCond <= '0';
			when "0101" =>
				tResult <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));
				tCond <= '0';
			when "0110" =>
				tResult <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));
				tCond <= '0';
			when "0111" =>
				tResult <= A + B;
				tcond <= '0';
			when "1000" =>
				tResult <= A + B;
				tcond <= '0';	
			when "1001" =>
				if A = B then
					tCond <= '1';
				else
					tCond <= '0';
				end if;
				tResult <= A + B;
			when "1010" =>
				if A = B then
					tCond <= '0';
				else
					tCond <= '1';
				end if;
				tResult <=  A + B;
			when "1011" =>
				if A < B then
					tCond <= '1';
				else
					tCond <= '0';
				end if;
				tResult <=  A + B;
			when "1100" =>
				if A > B then
					tCond <= '1';
				else
					tCond <= '0';
				end if;
				tResult <= A + B;
			when "1101" =>
				if A > B then
					tCond <= '0';
				else
					tCond <= '1';
				end if;
				tResult <=  A + B;
			when "1110" =>
			if A < B then
					tCond <= '0';
				else
					tCond <= '1';
				end if;
				tResult <=  A + B;
			when others =>
				tResult <= (others => '0');
				tCond <= '0';
		end case;
	end process;
	result <= tResult;
	cond <= tCond;
end architecture;

