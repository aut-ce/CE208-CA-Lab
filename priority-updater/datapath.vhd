--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   11-04-2016
-- Module Name:   datapath.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity datapath is
	port (g, e, l : out std_logic;
		sel : in std_logic);
end entity;

architecture rtl of datapath is
	component memory
		port (address : in std_logic_vector;
		      	data_in : in std_logic_vector;
		      	data_out : out std_logic_vector;
			clk, rwbar : in std_logic);
	end component;
	component n_register
		generic (N : integer := 4);
		port (d : in std_logic_vector(N - 1 downto 0);
			clk, s_sync, r_sync : in std_logic;
			s_async, r_async : in std_logic;
			q : out std_logic_vector(N - 1 downto 0));
	end component n_register;
	component compare
		port (n1, n2 : in std_logic_vector(3 downto 0);
			g, e, l : out std_logic);
	end compare;
	component fulladdr
		port (a, b : in std_logic_vector (3 downto 0);
			c_in : in std_logic;
			sum, c_out : out std_logic(3 downto 0));
	end fulladdr;
	for all:memory use entity work.memory;
	for all:n_register use entity work.n_register;
	for all:compare use entity work.compare;
	for all:fulladdr use entity work.fulladdr;

	signal value : std_logic_vector(3 downto 0);
	signal p_v : std_logic_vector(3 downto 0);
	signal mux1 : std_logic_vector(3 downto 0);
	signal mux0 : std_logic_vector(3 downto 0);
	signal new_data : std_logic_vector(3 downto 0);
begin
		mem : memory port map(address, data_in, value, clk, rwbar);
		priority_register : generic map (4) n_register port map(values, clk, open, open, open, open, p_v);
		compare : port map(value, p_v, g, e, l);
		fa : fulladr port map (value, "0001", open, mux1, open);
		new_data <= mux0 when sel = '0' else mux 1;
end architecture rtd;
