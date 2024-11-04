
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
 
 
ENTITY UNI_Shift_Register_TB IS
END UNI_Shift_Register_TB;
 
ARCHITECTURE behavior OF UNI_Shift_Register_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UNI_Shift_Register
    PORT(
         Pin : IN  std_logic_vector(3 downto 0);
         Sin : IN  std_logic;
         Mode : IN  std_logic_vector(1 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         Sout : OUT  std_logic;
         Pout : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Pin : std_logic_vector(3 downto 0) := "0000";
   signal Sin : std_logic := '0';
   signal Mode : std_logic_vector(1 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '1';

 	--Outputs
   signal Sout : std_logic;
   signal Pout : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UNI_Shift_Register PORT MAP (
          Pin => Pin,
          Sin => Sin,
          Mode => Mode,
          RST => RST,
          CLK => CLK,
          Sout => Sout,
          Pout => Pout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc_Mode: process
   begin		
      
		Mode <= "00";
		wait for 80 ns;
		Mode <= "01";
		wait for 50 ns;
		Mode <= "10";
		wait for 50 ns;
		Mode <= "11";
		wait for 20 ns;
		
   end process;

	stim_proc_Sin: process
	begin
	
		Sin <= '1';
		wait for 10 ns;
		Sin <= '0';
		wait for 10 ns;
		Sin <= '1';
		wait for 10 ns;
		Sin <= '0';
		wait for 10 ns;
		---Sin process for 0-40 ns
		
		Sin <= '0';
		wait for 40 ns;
		---Sin process for 40-80 ns
		
		Sin <= '1';
		wait for 10 ns;
		Sin <= '0';
		wait for 10 ns;
		Sin <= '1';
		wait for 10 ns;
		Sin <= '0';
		wait for 10 ns;
		---Sin process for 80-120 ns
		
	end process;
	
	stim_proc_RST: process
	begin
		
		wait for 122.5 ns;
		RST <= '1';
		wait for 5 ns;
		RST <= '0';
		
		--wait;
	end process;

END;
