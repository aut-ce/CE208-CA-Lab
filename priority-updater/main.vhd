--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   11-04-2016
-- Module Name:   main.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164;

entity main is
	port (clk, free : in std_logic;
		number : in std_logic_vector(3 downto 0);
		done : out std_logic;
		memory : out std_logic_vector(3 downto 0));
end entity;

architecture rtl of main is
begin
end architecture;
