--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   11-04-2016
-- Module Name:   main.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity main is
	port (clk, free : in std_logic;
		address : in std_logic_vector(3 downto 0);
		done : out std_logic;
		memory : out std_logic_vector(3 downto 0));
end entity;

architecture rtl of main is
	component datapath
		port (g, e, l : out std_logic;
			clk : in std_logic;
		      	sel_1 : in std_logic;
			sel_2 : in std_logic_vector(1 downto 0);
			counter_reset : in std_logic;
			rwbar : in std_logic;
			load : in std_logic;
			counter_done : out std_logic;
			input_address : in std_logic_vector(3 downto 0));
	end component;
	component controller
		port (g, e, l : in std_logic;
			clk : in std_logic;
			sel_1 : out std_logic;
			sel_2 : out std_logic_vector(1 downto 0);
			counter_reset : out std_logic;
			load : out std_logic;
			counter_done : in std_logic;
			free: in std_logic;
			done: out std_logic;
			rwbar : out std_logic);
	end component;
	for all:datapath use entity work.datapath;
	for all:controller use entity work.controller;
	
	signal g, e, l, sel_1, counter_reset, rwbar, counter_done, load : std_logic;
	signal sel_2 : std_logic_vector(1 downto 0);
begin
	dp : datapath port map(g, e, l, clk, sel_1, sel_2, counter_reset, rwbar, load, counter_done, address);
	cc : controller port map(g, e, l, clk, sel_1, sel_2, counter_reset, load, counter_done, free, done, rwbar);
end architecture;
