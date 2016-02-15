--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   15-02-2016
-- Module Name:   decoder.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity decoder is
	port (i0, i1 : in std_logic;
		o0, o1, o2, o3 : out std_logic);
end entity;

architecture gate_arch_decoder of decoder is
begin
	o0 <= (not i0) and (not i1);
	o1 <= i0 and (not i1);
	o2 <= (not i0) and i1;
	o3 <= i0 and i1;
end architecture;
