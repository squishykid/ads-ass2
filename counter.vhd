library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

--Count from 30 to 0 in decimal and then output the result in grey code.
entity greyCounter is
    Port ( clk : in  STD_LOGIC;--Clock input (1Hz)
           rst : in  STD_LOGIC;--Reset input
           en : in  STD_LOGIC;--Enable line
           data : out  STD_LOGIC_VECTOR (4 downto 0) := "11110";--Counter value
			  done : out  STD_LOGIC := '0');--Turns on when the counter finishes
end greyCounter;

architecture Behavioral of greyCounter is
	signal temp : std_logic_vector(4 downto 0) := "11110";
	--You can't read from an output, so we use a signal and assign it to the output.
begin

--To convert BDC to grey, the most significant bit stays the same,
-- while each less significant grey code bit is the result of an
-- XOR operation between the same significance bit and the next
-- most significant bit.
data(4) <= temp(4);
data(3) <= temp(4) XOR temp (3);
data(2) <= temp(3) XOR temp (2);
data(1) <= temp(2) XOR temp (1);
data(0) <= temp(1) XOR temp (0);

--Turn on the led ONLY if the counter value is 0x0.
process(temp)
begin
	if temp = "00000" then
		done <= '1';
	else
		done <= '0';
	end if;
end process;

--Count down with enable and asynchronous reset.
-- Stop counting at 0.
process (clk, rst)
begin
	if rst = '1' then
		temp <= "11110";
	elsif rising_edge(clk) and en = '1' and temp /= "00000" then
		temp <= temp - 1;
	end if;
end process;

end Behavioral;

