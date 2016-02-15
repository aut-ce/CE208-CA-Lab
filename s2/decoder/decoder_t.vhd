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
		port (i : in std_logic_vector(1 downto 0);
			o : out std_logic_vector(3 downto 0));
	end component decoder;
	signal i : std_logic_vector(1 downto 0);
	signal o : std_logic_vector(3 downto 0);
	for all:decoder use entity work.decoder(beh_arch_decoder);
begin
	d : decoder port map (i, o);
	i(0) <= '0', '1' after 100 ns, '0' after 200 ns, '1' after 300 ns;
	i(1) <= '0', '0' after 100 ns, '1' after 200 ns, '1' after 300 ns;
end architecture arch_decoder_t;
