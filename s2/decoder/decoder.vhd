--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   15-02-2016
-- Module Name:   decoder.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity decoder is
	port (i : in std_logic_vector (1 downto 0);
		o : out std_logic_vector (3 downto 0));
end entity;

architecture gate_arch_decoder of decoder is
begin
	o(0) <= (not i(0)) and (not i(1));
	o(1) <= i(0) and (not i(1));
	o(2) <= (not i(0)) and i(1);
	o(3) <= i(0) and i(1);
end architecture;

architecture beh_arch_decoder of decoder is
begin
	with i select
		o <= "0001" when "00",
		     "0010" when "01",
		     "0100" when "10",
		     "1000" when "11",
		     "XXXX" when others;
end architecture beh_arch_decoder;
