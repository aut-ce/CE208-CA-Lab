--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   24-04-2016
-- Module Name:   main_t.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity main_t is
end entity main_t;

architecture rtl of main_t is
	component main
		port (clk, free, reset : in std_logic;
			address : in std_logic_vector(3 downto 0);
			done : out std_logic;
			memory : out std_logic_vector(3 downto 0));
	end component;

	for all:main use entity work.main;

	signal clk, reset, free, done : std_logic := '0';
	signal address, memory : std_logic_vector(3 downto 0);
begin
	m : main port map (clk, free, reset, address, done, memory);
	reset <= '1', '0' after 10 ns;
	clk <= not clk after 50 ns;
	free <= '1' after 500 ns;
	-- free <= '0' when done = '1';
	address <= "0101";
end architecture;
