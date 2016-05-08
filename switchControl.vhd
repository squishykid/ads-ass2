----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:43:48 05/08/2016 
-- Design Name: 
-- Module Name:    switchControl - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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

