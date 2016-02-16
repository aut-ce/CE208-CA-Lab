--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   15-02-2016
-- Module Name:   4-bit-adder.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity four_bit_adder is
	generic(N : natural := 4);
	port (a, b : in std_logic_vector(N - 1 downto 0);
		c_in : in std_logic;
		sum : out std_logic_vector(N - 1 downto 0);
		c_out : out std_logic);
end entity;

architecture arch_four_bit_adder of four_bit_adder is
	component fulladdr is
		port (a, b, c_in : in std_logic;
			sum, c_out : out std_logic);
	end component fulladdr;
	signal c : std_logic_vector(N downto 0);
	for all:fulladdr use entity work.fulladdr(arch_fulladdr);
begin
	c(0) <= c_in;
	c_out <= c(N);
	F : for I in 0 to N - 1 generate
		fas : fulladdr port map (a(I), b(I), c(I), sum(I), c(I + 1));
	end generate F;
end architecture arch_four_bit_adder;
