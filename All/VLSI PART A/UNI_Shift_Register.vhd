
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UNI_Shift_Register is
    Port ( Pin : in  STD_LOGIC_VECTOR (3 downto 0);
           Sin : in  STD_LOGIC;
           Mode : in  STD_LOGIC_VECTOR (1 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Sout : out  STD_LOGIC;
           Pout : out  STD_LOGIC_VECTOR (3 downto 0));
end UNI_Shift_Register;

architecture Behavioral of UNI_Shift_Register is

SIGNAL temp : STD_LOGIC_VECTOR(3 downto 0):="0000";
BEGIN	
	PROCESS(RST, CLK, Mode, Sin, Pin)
	BEGIN
		if RST = '1' THEN
			Pout <= "0000";
			Sout <= '0';
			
		ElSIF FALLING_EDGE(CLK) THEN
		
			CASE mode IS 
				WHEN "00" => 
							 temp(3 downto 1) <= temp (2 downto 0);
							 temp(0) <= Sin;
							 Sout <= temp(3);
							 Pout <= "0000";
							 
				WHEN "01" =>
							 temp(3 downto 1) <= temp (2 downto 0);
							 temp(0) <= Sin;
							 Pout <= temp;
							 Sout <= '0';
							 
				WHEN "10" => 
							 temp <= Pin;
							 Sout <= temp(3);
							 temp (3 downto 1) <= temp (2 downto 0);
							 Pout <= "0000";
							 
				WHEN OTHERS =>
								temp <= Pin;
								Pout <= temp;
						
			END CASE;
		END IF;
	END PROCESS;

end Behavioral;

