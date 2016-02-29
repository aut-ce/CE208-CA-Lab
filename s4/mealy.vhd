--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   29-02-2016
-- Module Name:   mealy.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity mealy is
	port (d, clk, reset : in std_logic;
		z : out std_logic);
end entity mealy;

architecture arch_mealy of mealy is
	type state is (S0, S1, S2, S3);
	signal current : state := S0;
begin
	process (clk, reset)
	begin
		if reset = '1' then
			current <= S0;
		end if;
		if clk = '1' and clk'event then
			case current is
				when S0 =>
					current <= S0 when d = '0' else S1;
				when S1 =>
					current <= S2 when d = '0' else S0;
				when S2 =>
					current <= S3 when d = '1' else S0;
				when S3 =>
					current <= S2 when d = '0' else S1;
			end case;
		end if;
	end process;
	z <= '1' when current = S3 else '0';
end architecture arch_mealy;
