--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   22-02-2016
-- Module Name:   counter.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity counter is
	generic (N : integer := 4);
	port (number : buffer std_logic_vector (N - 1 downto 0) := (others => '0');
		clk : in std_logic);
end entity counter;

architecture beh_arch_counter of counter is
begin
	process (clk)
	begin
		if clk = '1' and clk'event then
			number <= number + (0 => '1');
		end if;
	end process;
end architecture beh_arch_counter;
