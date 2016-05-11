library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

--The main module implements the program on ideal hardware
--Using the wrapper module we make the program run on the
-- remote lab hardware.
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
	signal stateClock : std_logic := '0';--1Hz signal
	signal GreyValue : std_logic_vector(4 downto 0) := "00000";--Grey value
	signal counterEnable : std_logic := '0';--enable signal
begin
	
	--In: 100Mhz signal, Grey value
	--Out: Seven segment cathodes, Seven segment anodes
	mux: entity work.muxSSD port map (Clock, GreyValue, SevenSegmentElement, SevenSegmentSelect);
	
	--In: 1Hz signal, reset button, enable signal
	--Out: Grey value, LED on/off
	grey: entity work.greyCounter port map (stateClock, ResetSignal, counterEnable, GreyValue, LED);
	
	--In: 100Mhz signal
	--Out: 1Hz signal
	stateClockDivider: entity work.stateClockDivider port map (Clock, stateClock);
	
	--In: 100Mhz signal, start button, stop button, resume button, reset button
	--Out: enable signal
	switchControl: entity work.switchControl port map (Clock, StartSignal, StopSignal, ResumeSignal, ResetSignal, counterEnable);

end Behavioral;
