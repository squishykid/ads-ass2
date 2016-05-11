library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Converts the limitations of the remote labs into an idea
-- system which the main module can interact with.
entity nexysTarget is
Port ( clk : in STD_LOGIC;
			--triggers the bomb
			RedLed : out STD_LOGIC;
			
			--seven segments
			SSEG_AN : out STD_LOGIC_VECTOR (2 downto 0) := "110";
			SSEG_AN_OFF : out STD_LOGIC := '1';
			SSEG_CA : out STD_LOGIC_VECTOR (0 to 6);
			
			--virtual lab interactive interface
			EppAstb : in STD_LOGIC;
			EppDstb : in STD_LOGIC;
			EppWr : in STD_LOGIC; 
			EppDB : in STD_LOGIC_VECTOR (7 downto 0);
			EppWait : out STD_LOGIC);
end nexysTarget;

architecture Behavioral of nexysTarget is
	signal startSW : std_logic := '0';
	signal stopSW : std_logic := '0';
	signal resumeSW : std_logic := '0';
	signal resetSW : std_logic := '0';
begin

--The seven segment displays are active low.
--We turn the left most segment off permanently.
SSEG_AN_OFF <= '1';

--We connect the main module to the switch signals
-- and the other physical signals
main: entity work.main port map (clk, startSW, stopSW, resumeSW, resetSW, RedLED, SSEG_AN, SSEG_CA);

--Reads the values coming in from the virtual lab hardware
-- and assigns the correct switch values
interface: entity work.labSwitchInterface port map (
EppAstb, EppDstb, EppWr, EppDB, EppWait, startSW, stopSW, resumeSW, resetSW);

end Behavioral;

