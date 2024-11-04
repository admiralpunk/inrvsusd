library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MOD25 is
    Port ( DIR : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PR : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (4 downto 0));
end MOD25;

architecture Behavioral of MOD25 is
signal Qtemp : STD_LOGIC_VECTOR(4 downto 0) := "00000";

begin

	process(CLK, RST, PR, DIR)
	begin
		if RST = '1' then
			Qtemp <= (OTHERS => '0');
		elsif PR = '1' then
			Qtemp <= (OTHERS => '1');
		elsif falling_edge(CLK) then 
			if DIR = '1' then
					if Qtemp < 24 then
						Qtemp <= Qtemp + 1;
					else 
						Qtemp <= "00000";
					end if;
			else 
					if Qtemp > 7 then
						Qtemp <= Qtemp - 1;
					else
						Qtemp <= "11111";
					end if;
			end if;
		end if;
	end process;
	
	Q <= Qtemp;

end Behavioral;

