library IEEE;
use IEEE.std_logic_1164.all;

entity compare is
	port (n1, n2 : in std_logic_vector(3 downto 0);
		g, e, l : out std_logic);
end entity compare;

architecture rtl of compare is
begin
	g <= '1' when n1 > n2 else '0'
	l <= '1' when n1 < n2 else '0'
	e <= '1' when n1 = n2 else '0'
end rtl;
	
