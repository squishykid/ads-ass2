library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switchControl is
    Port ( clk : in  STD_LOGIC;
			  startSW : in  STD_LOGIC;
           stopSW : in  STD_LOGIC;
           resumeSW : in  STD_LOGIC;
			  resetSW : in  STD_LOGIC;
           enable : out  STD_LOGIC);
end switchControl;

architecture Behavioral of switchControl is
	type state_type is (reset, running, paused);
	signal current_state : state_type := reset;
	signal next_state : state_type := reset;
begin
	
	--Enable high when in the running
	-- state. Else low.
	process(current_state)
	begin
		if current_state = running then
			enable <= '1';
		else
			enable <= '0';
		end if;
	end process;

	process(clk, resetSW)
	begin
		if resetSW = '1' then
			current_state <= reset;
		elsif rising_edge(clk) then
			current_state <= next_state;
		end if;
	end process;
	
	process(startSW, stopSW, resumeSW, resetSW, current_state)
	begin
		if resetSW = '1' then
			next_state <= reset;
		elsif startSW = '1' and current_state = reset then
			next_state <= running;
		elsif stopSW = '1' and current_state = running then
			next_state <= paused;
		elsif resumeSW = '1' and current_state = paused then
			next_state <= running;
		else
			next_state <= current_state;
		end if;
	end process;

end Behavioral;

