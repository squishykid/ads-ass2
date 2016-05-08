----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:14:53 05/08/2016 
-- Design Name: 
-- Module Name:    main - Behavioral 
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity main is
	Port ( Clock : in STD_LOGIC;
			 StartSignal : in STD_LOGIC;
			 StopSignal : in STD_LOGIC;
			 ResumeSignal : in STD_LOGIC;
			 ResetSignal : in STD_LOGIC;
			 LED : out STD_LOGIC;
			 SevenSegmentSelect : out STD_LOGIC_VECTOR (2 downto 0) := "110";
			 SevenSegmentElement : out STD_LOGIC_VECTOR (0 to 6) := "1111111");
end main;

architecture Behavioral of main is
	signal stateClock : std_logic := '0';
	signal GreyValue : std_logic_vector(4 downto 0) := "00000";
	signal counterEnable : std_logic := '0';	
begin
	
	mux: entity work.muxSSD port map (Clock, GreyValue, SevenSegmentElement, SevenSegmentSelect);
																							--counterEnable here, but it's currently fucked
	grey: entity work.greyCounter port map (stateClock, ResetSignal, StartSignal, GreyValue, LED);

	stateClockDivider: entity work.stateClockDivider port map (Clock, stateClock);

	switchControl: entity work.switchControl port map (StartSignal, StopSignal, ResumeSignal, ResetSignal, counterEnable);

end Behavioral;
