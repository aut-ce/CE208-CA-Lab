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
	port (number : out std_logic_vector (N - 1 downto 0) := (others => '0');
		clk, r, en : in std_logic);
end entity counter;

architecture behavioral of counter is
begin
	process (clk, r)
		variable old_number : std_logic_vector (N - 1 downto 0) := (others => '0');
	begin
		if r = '1' then
			number <= (others => '0');
			old_number := (others => '0');
		elsif clk = '1' and clk'event and en = '1' then
			number <= old_number;
			old_number := old_number + (0 => '1');
		end if;
	end process;
end architecture behavioral;
