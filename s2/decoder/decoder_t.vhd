--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   15-02-2016
-- Module Name:   decoder_t.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity decoder_t is
end entity decoder_t;

architecture arch_decoder_t of decoder_t is
	component decoder is
		port (i0, i1 : in std_logic;
			o0, o1, o2, o3 : out std_logic);
	end component decoder;
	signal i0, i1 : std_logic;
	signal o0, o1, o2, o3 : std_logic;
	for all:decoder use entity work.decoder(gate_arch_decoder);
begin
	d : decoder port map (i0, i1, o0, o1, o2, o3);
	i0 <= '0', '1' after 100 ns, '0' after 200 ns, '1' after 300 ns;
	i1 <= '0', '0' after 100 ns, '1' after 200 ns, '1' after 300 ns;
end architecture arch_decoder_t;
