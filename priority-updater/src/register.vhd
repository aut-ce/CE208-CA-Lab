--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   22-02-2016
-- Module Name:   register.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity n_register is
	generic (N : integer := 4);
	port (d : in std_logic_vector(N - 1 downto 0);
		clk, load : in std_logic;
		q : out std_logic_vector(N - 1 downto 0));
end entity n_register;

architecture behavior of n_register is
begin
	process (clk)
	begin
		if clk = '1' and clk'event then
			if load = '1' then
				q <= d;
			end if;
		end if;
	end process;
end architecture behavior;
