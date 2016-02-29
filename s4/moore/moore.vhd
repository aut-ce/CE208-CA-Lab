--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   29-02-2016
-- Module Name:   moore.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity moore is
	port (d, clk, reset : in std_logic;
		z : out std_logic);
end entity moore;

architecture arch_moore of moore is
	type state is (S0, S1, S2, S3, S4);
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
					if d = '0' then
						current <= S0;
					else
						current <= S1;
					end if;
				when S1 =>
					if d = '0' then
						current <= S2;
					else
						current <= S0;
					end if;
				when S2 =>
					if d = '1' then
						current <= S3;
					else
						current <= S0;
					end if;
				when S3 =>
					if d = '0' then
						current <= S2;
					else
						current <= S4;
					end if;
				when S4 =>
					if d = '0' then
						current <= S1;
					else
						current <= S2;
					end if;
			end case;
		end if;
	end process;
	z <= '1' when current = S4 else '0';
end architecture arch_moore;
