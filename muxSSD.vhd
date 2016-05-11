library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

--Takes a clock and numerical value in BCD as inputs
-- and outputs 
entity muxSSD is
    Port ( clk : in  STD_LOGIC;
			  value : in  STD_LOGIC_VECTOR(4 downto 0);
			  ssd : out  STD_LOGIC_VECTOR(0 to 6);
			  anodes : out  STD_LOGIC_VECTOR(2 downto 0));
end muxSSD;

architecture Behavioral of muxSSD is
	--Divide the clock by 256, otherwise the display contrast is low.
	signal clkdiv : std_logic_vector(7 downto 0) := "00000000";
	--Value to display across all displays, as an unsigned integer.
	--This type allows other operations, like "mod".
	signal valueInt : unsigned(4 downto 0) := "00000";
	--Value to display on the currently driven seven segment display.
	signal decimal : std_logic_vector(4 downto 0) := "00000";
	--The current anode to drive.
	signal segmentIndex : integer range 0 to 2 := 0;
begin

	--Convert the incoming value into an unsigned integer.
	valueInt <= unsigned(value);
	
	--Divide the clock into something more manageable.
	process (clk)
	begin
		if rising_edge(clk) then
			if clkdiv  = "11111111" then
				clkdiv <= "00000000";
				if segmentIndex = 2 then
					segmentIndex <= 0;
				else
					segmentIndex <= segmentIndex + 1;
				end if;
			else
				clkdiv <= clkdiv + 1;
			end if;
		end if;
	end process;

	--Set the number to display on a particular display.
	--I.e. when "valueInt" is 12 and "segmentIndex" is 0,
	-- the number is 2.
	--Activate the anodes for the current "segmentIndex".
	process(segmentIndex, valueInt)
	begin
		case segmentIndex is
		when 0 =>--LSB
			decimal <= std_logic_vector(valueInt mod 10);
			anodes <= "110";
		when 1 =>
			decimal <= std_logic_vector((valueInt / 10) mod 10);
			anodes <= "101";
		when 2 =>
			decimal <= std_logic_vector((valueInt / 100) mod 10);
			anodes <= "011";
		end case;
	end process;

	--In: Decimal number to display
	--Out: The combination of cathodes to activate on the display.
	binary: entity work.binaryToSSD port map (decimal(3 downto 0), ssd);

end Behavioral;
