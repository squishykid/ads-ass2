----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:40:03 05/08/2016 
-- Design Name: 
-- Module Name:    nexysTarget - Behavioral 
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

entity nexysTarget is
Port ( clk : in STD_LOGIC;
			--triggers the bomb
			RedLed : out STD_LOGIC;
			
			--seven segments
			SSEG_AN : out STD_LOGIC_VECTOR (2 downto 0) := "110";
			SSEG_AN_OFF : out STD_LOGIC := '1';
			SSEG_CA : out STD_LOGIC_VECTOR (0 to 6);
			
			--virtual lab interface
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

SSEG_AN_OFF <= '1';

main: entity work.main port map (clk,
											startSW,
											stopSW,
											resumeSW,
											resetSW,
											RedLED,
											SSEG_AN,
											SSEG_CA);

interface: entity work.labSwitchInterface port map (EppAstb,
																	 EppDstb,
																	 EppWr,
																	 EppDB,
																	 EppWait,
																	 startSW,
																	 stopSW,
																	 resumeSW,
																	 resetSW);

end Behavioral;

