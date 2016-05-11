library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Convert binary coded decimal values into
-- the cathodes which should be enabled to
-- display the number.
entity binaryToSSD is
    Port ( data : in  STD_LOGIC_VECTOR (3 downto 0);
           display : out  STD_LOGIC_VECTOR (0 to 6));
end binaryToSSD;

architecture Behavioral of binaryToSSD is
begin
--Seven segment cathodes are active low.
    with data select display <=
	  --abcdefg
	  --'0' turns the segment on
	  --'1' turns the segment off
		"0000001" when "0000",--activate a,b,c,d,e,f of 7seg set on when bcd input is 0
		"1001111" when "0001",--activate b,c of 7seg set on when bcd input is 1
		"0010010" when "0010",--activate a,b,d,e,g of 7seg set on when bcd input is 2
		"0000110" when "0011",--activate a,b,c,d,g of 7seg set on when bcd input is 3
		"1001100" when "0100",--activate b,c,f,g of 7seg set on when bcd input is 4
		"0100100" when "0101",--activate a,c,d,f,g of 7seg set on when bcd input is 5
		"0100000" when "0110",--activate a,c,d,e,f,g of 7seg set on when bcd input is 6
		"0001111" when "0111",--activate a,b,c of 7seg set on when bcd input is 7
		"0000000" when "1000",--activate a,b,c,d,e,f,g of 7seg set on when bcd input is 8
		"0000100" when "1001",--activate a,b,c,d,f,g, of 7seg set on when bcd input is 9
		"1111110" when others; -- Just a "-"
end Behavioral;

