library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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
				clkdiv <= 0;
				tempCout <= not tempCout;
			else
				clkdiv <= clkdiv + 1;
			end if;
		end if;
	end process;
	
	cout <= tempCout;
	
end Behavioral;

