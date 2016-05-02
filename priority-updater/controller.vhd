--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   18-04-2016
-- Module Name:   controller.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity controller is
	port (g, e, l : in std_logic;
		clk, reset : in std_logic;
		sel_1 : out std_logic;
		sel_2 : out std_logic_vector(1 downto 0);
		counter_reset, counter_enable : out std_logic;
		load : out std_logic;
		counter_done : in std_logic;
		free: in std_logic;
		done: out std_logic;
		rwbar : out std_logic);
end entity;

architecture rtl of controller is
	type state is (RESET0, RESET1, WAITING, S1, S2, S3, S4, S5);
	signal current_state : state;
	signal next_state : state;
begin
	-- next
	process (clk, reset)
	begin
		if reset = '1' then
			current_state <= RESET0;
		elsif clk'event and clk = '1' then
			current_state <= next_state;
		end if;
	end process;

	-- next state + outputs :D
	process (current_state, counter_done, g, e, l, reset, free)
	begin
		if current_state = S1 then
			sel_1 <= '0';
			rwbar <= '1';
			counter_reset <= '1';
			next_state <= S2;
		elsif current_state = S2 then
			load <= '1';
			counter_reset <= '0';
			sel_1 <= '1';
			next_state <= S3;
		elsif current_state = S3 then
			load <= '0';
			next_state <= S4;
		elsif current_state = S4 then
			if e = '1' and g = '0' and l = '0' then
				sel_2 <= "10";
				rwbar <= '0';
			elsif e = '1' and g = '1' and l = '0' then
				rwbar <= '1';
			elsif e = '0' and g = '0' and l = '1' then
				sel_2 <= "00";
				rwbar <= '0';
			end if;
			next_state <= S5;
		elsif current_state = S5 then
			rwbar <= '1';
			if counter_done = '1' then
				done <= '1';
				next_state <= WAITING;
			else
				counter_enable <= '1';
				next_state <= S3;
			end if;
		elsif current_state = WAITING then
			if free = '1' then
				done <= '0';
				next_state <= S1;
			else
				next_state <= WAITING;
			end if;
		elsif current_state = RESET0 then
			counter_reset <= '1';
			next_state <= RESET1;
			sel_1 <= '1';
			sel_2 <= "11";
		elsif current_state = RESET1 then
			counter_enable <= '1';
			counter_reset <= '0';
			if counter_done = '1' then
				rwbar <= '1';
				counter_enable <= '0';
				next_state <= WAITING;
			else
				rwbar <= '0';
				next_state <= RESET1;
			end if;
		end if;
	end process;
end architecture rtl;
