library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity greyCounter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           data : out  STD_LOGIC_VECTOR (4 downto 0) := "11111";
			  done : out  STD_LOGIC := '0');
end greyCounter;

architecture Behavioral of greyCounter is
	signal temp : std_logic_vector(4 downto 0) := "11111";
begin

data <= temp;

process(temp)
begin
	if temp = "00000" then
		done <= '1';
	else
		done <= '0';
	end if;
end process;

process (clk, rst)
begin
	if rst = '1' then
		temp <= "11111";
	elsif rising_edge(clk) then
		if en = '1' then
			if temp /= "00000" then
				temp <= temp - 1;
			end if;
		end if;
	end if;
end process;

end Behavioral;

