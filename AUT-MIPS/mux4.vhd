--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   30-05-2016
-- Module Name:   mux4.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity mux4 is
	generic (N : integer := 16);
	port (I00, I01, I10, I11 : in std_logic_vector (N - 1 downto 0);
		O : out std_logic_vector (N - 1 downto 0);
		S : in  std_logic_vector (1 downto 0));
end entity;

architecture rtl of mux4 is
begin
	with S select O <=
		I00 when "00",
		I01 when "01",
		I10 when "10",
		I11 when "11",
		(others => '0') when others;
end rtl;
