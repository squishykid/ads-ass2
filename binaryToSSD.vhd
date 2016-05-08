library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity binaryToSSD is
    Port ( data : in  STD_LOGIC_VECTOR (3 downto 0);
           display : out  STD_LOGIC_VECTOR (0 to 6));
end binaryToSSD;

architecture Behavioral of binaryToSSD is
begin
--LED ON WHEN LOW
    with data select display <=
	  --abcdefg
		"0000001" when "0000",--0
		"1001111" when "0001",
		"0010010" when "0010",--2
		"0000110" when "0011",
		"1001100" when "0100",--4
		"0100100" when "0101",
		"0100000" when "0110",--6
		"0001111" when "0111",
		"0000000" when "1000",--8
		"0000100" when "1001",
		"1111110" when others; -- Just a "-"
end Behavioral;

