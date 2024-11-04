
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY MOD25_TB IS
END MOD25_TB;
 
ARCHITECTURE behavior OF MOD25_TB IS 
 
    COMPONENT MOD25
    PORT(
         DIR : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         PR : IN  std_logic;
         Q : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DIR : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal PR : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MOD25 PORT MAP (
          DIR => DIR,
          CLK => CLK,
          RST => RST,
          PR => PR,
          Q => Q
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
   stim_proc_RST: process	--reset
   begin
		wait for 247.5 ns; --rst initialize at certain instance and then back to 0 after certain instance of setting
		RST <= '1';
	
		wait for 5 ns;
		RST <= '0';
		
		
   end process;
	
	stim_proc_PR: process --preset
   begin
		wait for 417.5 ns; --pr initialize at certain instance and then back to 0 after certain instance of setting
		PR <= '1';
		wait for 5 ns;
		PR <= '0';
		
	end process;
	
	stim_proc_DIR: process --dir
   begin
		wait for 250 ns; --dir initialized and back to 0 at same instance
		DIR <= '1';
		wait for 250 ns;
		DIR <= '0';
		
	end process;

END;
