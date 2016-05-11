library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--Divide a 100Mhz clock into a 1Hz clock which can be used
-- to increment the grey code counter.
entity stateClockDivider is
    Port ( clk : in  STD_LOGIC;
           cout : out  STD_LOGIC := '0');
end stateClockDivider;

architecture Behavioral of stateClockDivider is
	signal clkdiv: integer range 0 to 99_999_999 := 0;
	signal tempCout : std_logic := '0';
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if clkdiv = 99_999_999 then
			--Reset the counter when it runs out and
			-- invert the output signal.
				clkdiv <= 0;
				tempCout <= not tempCout;
			else
			--Otherwise increment the counter.
				clkdiv <= clkdiv + 1;
			end if;
		end if;
	end process;
	
	--An output cannot be read, which means that a signal
	-- must be used and it's value assigned to the output.
	cout <= tempCout;
	
end Behavioral;

