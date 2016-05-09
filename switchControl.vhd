library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switchControl is
    Port ( startSW : in  STD_LOGIC;
           stopSW : in  STD_LOGIC;
           resumeSW : in  STD_LOGIC;
			  resetSW : in  STD_LOGIC;
           enable : out  STD_LOGIC);
end switchControl;

architecture Behavioral of switchControl is
	type state_type is (reset, running, paused);
	signal state : state_type := reset;
begin

	enable <= '1' when state = running else
				 '0';

	process(startSW, stopSW, resumeSW, resetSW, state)
	begin
		if rising_edge(resetSW) then
			state <= reset;
		elsif rising_edge(startSW) and state = reset then
			state <= running;
		elsif rising_edge(stopSW) and state = running then
			state <= paused;
		elsif rising_edge(resumeSW) and state = paused then
			state <= running;
		end if;
	end process;

end Behavioral;

