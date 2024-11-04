
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL; 

ENTITY ALU_4bit_tb IS
END ALU_4bit_tb;
 
ARCHITECTURE behavior OF ALU_4bit_tb IS 
 
 
    COMPONENT ALU_4bit
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         F : IN  std_logic_vector(2 downto 0);
         Y : OUT  std_logic_vector(3 downto 0);
         C_B : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := "0111";
   signal B : std_logic_vector(3 downto 0) := "1110";
   signal F : std_logic_vector(2 downto 0) := (others => '1');

 	--Outputs
   signal Y : std_logic_vector(3 downto 0);
   signal C_B : std_logic; 
 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU_4bit PORT MAP (
          A => A,
          B => B,
          F => F,
          Y => Y,
          C_B => C_B
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
   
		F <= F+1;
		wait for 100 ns;
   
   end process;

END;
