library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_4bit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           F : in  STD_LOGIC_VECTOR (2 downto 0);
           Y : out  STD_LOGIC_VECTOR (3 downto 0);
           C_B : out  STD_LOGIC);
end ALU_4bit;

architecture ALU_4bit_arch of ALU_4bit is

signal result:STD_LOGIC_VECTOR(4 downto 0):="00000";

begin

	process(A,B,F)
	begin
		CASE F IS
			WHEN "000" => 
			result <= '0' & (A AND B);
			WHEN "001" => 
			result <= '0' & (A NAND B);
			WHEN "010" => 
			result <= '0' & (A OR B);
			WHEN "011" => 
			result <= '0' & (A XOR B);
			WHEN "100" => 
			result <= '0' & (A XNOR B);
			WHEN "101" => 
			result <= '0' & (A NOR B);
			WHEN "110" => 
			result <= ('0' & A)+('0' & B);
			
			WHEN OTHERS =>
			
			IF A < B then
				result <= '0' & (NOT B);
				result <= result+1;
				result <= ('0' & A)+result;
				result <= (NOT result)+1;
				result <= (NOT(('0' & A) + ('0' &(NOT B)) + 1))+1;
				
			ELSE
				result <= ('0'& A) - ('0' & B);
			END IF;
		
		END CASE;
		END PROCESS;
		
		Y <= result (3 downto 0);
		C_B <= result (4);
			
end ALU_4bit_arch;

