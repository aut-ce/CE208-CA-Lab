--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   30-05-2016
-- Module Name:   main_t.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity main_t is
end entity;

architecture rtl of main_t is
	component datapath
		port (clk: in std_logic);
	end component;

	for all:datapath use entity work.datapath;

	signal clk : std_logic := '0';
begin
	clk <= not clk after 50 ns;

	m : datapath port map (clk);
end architecture;
