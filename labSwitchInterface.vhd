library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Recieves the digital signals from the remote lab hardware
-- and extrates the state information of the switches
entity labSwitchInterface is
	Port ( AddressStrobe : in STD_LOGIC;
			 DataStrobe : in STD_LOGIC;
			 PortWriteSignal : in STD_LOGIC;
			 DataBus : in STD_LOGIC_VECTOR(7 downto 0);
			 WaitSignal : out STD_LOGIC;
			 Switch0 : out STD_LOGIC;
			 Switch1 : out STD_LOGIC;
			 Switch3 : out STD_LOGIC;
			 Switch4 : out STD_LOGIC);
end labSwitchInterface;

architecture Behavioral of labSwitchInterface is
	--The address of the next byte of data.
	signal addressRegister : STD_LOGIC_VECTOR(7 downto 0);
begin

--Remote lab hardware needs to wait while sending before sending the next byte.
WaitSignal <= '1' when AddressStrobe = '0' or DataStrobe = '0' else '0';

--Read the address of the data when the address strobe line goes high.
process(AddressStrobe)
begin
	if rising_edge(AddressStrobe) then
		if PortWriteSignal = '0' then
			addressRegister <= DataBus;
		end if;
	end if;
end process;

--Read the data when the data strobe line goes high and the address is set to 0x0.
process(DataStrobe)
begin
	if rising_edge(DataStrobe) then
		if PortWriteSignal = '0' then
			if addressRegister = X"00" then
				--Read the switch states directly from the data bus.
				Switch0 <= DataBus(0);
				Switch1 <= DataBus(1);
				Switch3 <= DataBus(3);
				Switch4 <= DataBus(4);
			end if;
		end if;
	end if;
end process;

end Behavioral;

