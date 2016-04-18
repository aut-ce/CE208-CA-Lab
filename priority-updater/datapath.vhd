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
		sel_1 : in std_logic;
		sel_2 : in std_logic_vector(1 downto 0);
		counter_reset : in std_logic;
		rwbar : in std_logic;
		load : in std_logic;
		input_address : in std_logic_vector(3 downto 0));
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
			clk, load : in std_logic;
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
	component counter
		generic (N : integer := 4);
		port (number : out std_logic_vector (N - 1 downto 0) := (others => '0');
			clk, r : in std_logic);
	end component;
	for all:memory use entity work.memory;
	for all:n_register use entity work.n_register;
	for all:compare use entity work.compare;
	for all:fulladdr use entity work.fulladdr;
	for all:counter use entity work.counter;

	signal value : std_logic_vector(3 downto 0);
	signal p_v : std_logic_vector(3 downto 0);
	signal fulladdr_data_in : std_logic_vector(3 downto 0);
	signal data_in : std_logic_vector(3 downto 0);
	signal c_out : std_logic;
	signal address : std_logic_vector(3 downto 0);
	signal counter_address : std_logic_vector(3 downto 0);
begin
	mem : memory port map(address, data_in, value, clk, rwbar);
	priority_register : n_register generic map(4) port map(values, clk, load, p_v);
	cmp : compare port map(value, p_v, g, e, l);
	fa : fulladdr port map (value, "0001", '0', fulladdr_data_in, c_out);
	cn : counter generic map(4) port map(counter_address, clk, counter_reset);

	data_in <= counter_address when sel_2 = "11" else fulladdr_data_in when sel_2 = "00" else (others => '0') ;
	address <= counter_address when sel_1 = '1' else input_address;
end architecture rtl;
