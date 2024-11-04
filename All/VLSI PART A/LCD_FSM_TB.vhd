LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY LCD_FSM_TB IS
END LCD_FSM_TB;
 
	ARCHITECTURE behavior OF LCD_FSM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LCD_FSM
    PORT(
         CLK_12MHz : IN  std_logic;
         RST : IN  std_logic;
         LCD_EN : OUT  std_logic;
         LCD_RS : OUT  std_logic;
         LCD_DATA : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_12MHz : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal LCD_EN : std_logic;
   signal LCD_RS : std_logic;
   signal LCD_DATA : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_12MHz_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LCD_FSM PORT MAP (
          CLK_12MHz => CLK_12MHz,
          RST => RST,
          LCD_EN => LCD_EN,
          LCD_RS => LCD_RS,
          LCD_DATA => LCD_DATA
        );

   -- Clock process definitions
   CLK_12MHz_process :process
   begin
		CLK_12MHz <= '0';
		wait for CLK_12MHz_period/2;
		CLK_12MHz <= '1';
		wait for CLK_12MHz_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		RST <= '1';
		wait for 20 ns;
		RST <= '0';
		
		wait;		
   end process;

END;