--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   18-04-2016
-- Module Name:   controller.vhd
--------------------------------------------------------------------------------

entity controller is
	port (g, e, l : in std_logic;
		sel_1, sel_2 : out std_logic;
		counter_reset : out std_logic;
		load : out std_logic;
		counter_done : in std_logic;
		rwbar : out std_logic);
end entity;

architecture rtl of controller is
	type state is (RESET0, RESET1, S1, S2, S3, S4);
	signal current_state : state;
	signal next_state : state;
begin
	process (clk)
	begin
		if clk'event and clk = '1' then
			current_state <= next_state;
		end if;
	end process;

	process (current_state)
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
			if    e and (not g) and (not l) then
				sel_2 <= '10';
				rwbar <= '0';
			elsif (not e) and g and (not l) then
				rwbar <= '1';
			elsif (not e) and (not g) and l then
				sel_2 <= '00';
				rwbar <= '0';
			end if;
			if counter_done = '1' then
				next_state <= S1;
			else
				next_state <= S4;
			end if;
		elsif current_state = RESET0 then
			counter_reset <= '1';
			next_state <= RESET1;
			sel_1 <= '1';
			sel_2 <= "11";
		elsif current_state = RESET1 then
			if counter_done = '1' then
				next_state <= S1;
			else
				next_state <= RESET1;
			end if;
		end if;
	end process;
end architecture rtl;
