--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   22-02-2016
-- Module Name:   counter_t.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity counter_t is
end entity;

architecture arch_counter_t of counter_t is
	component counter is
		generic (N : integer := 4);
		port (number : out std_logic_vector (N - 1 downto 0) := (others => '0');
			clk, r : in std_logic);
	end component counter;
	signal clk, r : std_logic := '0';
	signal number : std_logic_vector (3 downto 0);
	for all:counter use entity work.counter(beh_arch_counter);
begin
	c : counter generic map (4) port map (number, clk, r);
	clk <= not clk after 50 ns;
end architecture arch_counter_t;

