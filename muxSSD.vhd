library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity muxSSD is
    Port ( clk : in  STD_LOGIC;
			  value : in  STD_LOGIC_VECTOR(4 downto 0);
			  ssd : out  STD_LOGIC_VECTOR(0 to 6);
			  anodes : out  STD_LOGIC_VECTOR(2 downto 0));
end muxSSD;

architecture Behavioral of muxSSD is
	signal clkdiv : std_logic_vector(7 downto 0) := "00000000";
	signal valueInt : unsigned(4 downto 0) := "00000";
	signal decimal : std_logic_vector(4 downto 0) := "00000";
	signal segmentIndex : integer range 0 to 2 := 0;
begin

	valueInt <= unsigned(value);
	
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

	binary: entity work.binaryToSSD port map (decimal(3 downto 0), ssd);

end Behavioral;

