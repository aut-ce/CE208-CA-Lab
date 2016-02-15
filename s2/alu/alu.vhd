library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity alu is
	port (a, b : in std_logic_vector(3 downto 0);
		sel : in std_logic_vector(1 downto 0);
		res : out std_logic_vector(3 downto 0);
		c_out : out std_logic);
end entity alu;

architecture arch_alu of alu is
	signal im : std_logic_vector(4 downto 0);
begin
	with sel select
		im <= ('0'&a) + ('0'&b) when "00",
		      ('0'&a) - ('0'&b) when "01",
		      ('0'&a) xor ('0'&b) when "10",
		      "XXXXX" when others;
	res <= im(3 downto 0);
	c_out <= im(4);
end architecture arch_alu;
