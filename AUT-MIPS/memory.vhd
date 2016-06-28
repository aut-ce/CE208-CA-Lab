--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   30-03-2016
-- Module Name:   memory.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory is
	port (address : in std_logic_vector (15 downto 0);
		data_in : in std_logic_vector (15 downto 0);
		data_out : out std_logic_vector (15 downto 0);
		clk, read, write : in std_logic);
end entity;

architecture behavioral of memory is
	type mem is array (natural range <>) of std_logic_vector (15 downto 0);
begin
	process (clk)
		constant memsize : integer := 2 ** 16;
		variable memory : mem (0 to memsize - 1) := (
			"0011000000000010",
			"0011001001000010",
			"1111000001010111",
			"1111000001011110",
			"1111000001100101",
			"1111000001101100",
			"1111000001110011",
			"1111000001111010",
			"0111000001000011",
			"1000000001001100",
			"1001000000111111",
			"1010000000011010",
			"0000000000000000",
			"0000000000000010",
			others => "0000000000000000"
		);
	begin
		if  clk'event and clk = '1' then
			if read = '1' then -- Reading :)
				data_out <= memory(to_integer(unsigned(address)));
			elsif write = '1' then -- Writing :)
				memory(to_integer(unsigned(address))) := data_in;
			end if;
		end if;
	end process;
end architecture behavioral;
