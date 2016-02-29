--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   22-02-2016
-- Module Name:   moore_t.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity moore_t is
end entity;

architecture arch_moore_t of moore_t is
	component moore is
		port (d, clk, reset: in std_logic;
			z: out std_logic);
	end component moore;
	signal data: std_logic_vector(0 to 9) := "1100010110";
	signal clk, r, d, z: std_logic := '0';
	signal clk_t: std_logic := '0';
	for all:moore use entity work.moore(arch_moore);
begin
	m : moore port map (d, clk, r, z);
	clk <= not clk after 50 ns;
	clk_t <= not clk_t after 40 ns;
	process (clk_t)
		variable i : natural := 0;
	begin
		if clk_t = '1' and clk_t'event then
			d <= data(i);
			i := i + 1;
		end if;
	end process;
end architecture arch_moore_t;

