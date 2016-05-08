library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity greyCounter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           data : out  STD_LOGIC_VECTOR (4 downto 0) := "00000";
			  done : out  STD_LOGIC := '0');
end greyCounter;

architecture Behavioral of greyCounter is
	signal temp : std_logic_vector(4 downto 0) := "00000";
begin

data <= temp;

process (clk, rst)
begin
	if rst = '1' then
		temp <= "00000";
	elsif rising_edge(clk) then
		if en = '1' then
			temp <= temp + 1;
		end if;
	end if;
end process;

end Behavioral;

