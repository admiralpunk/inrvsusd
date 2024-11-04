
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
 
ENTITY FIFO_BT_TB IS
END FIFO_BT_TB;
 
ARCHITECTURE behavior OF FIFO_BT_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FIFO_BT
    PORT(
         WR_EN : IN  std_logic;
         RD_EN : IN  std_logic;
         DATA_IN : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         RST : IN  std_logic;
         FIFO_FULL : OUT  std_logic;
         FIFO_EMPTY : OUT  std_logic;
         DATA_OUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal WR_EN : std_logic := '0';
   signal RD_EN : std_logic := '0';
   signal DATA_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal FIFO_FULL : std_logic;
   signal FIFO_EMPTY : std_logic;
   signal DATA_OUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FIFO_BT PORT MAP (
          WR_EN => WR_EN,
          RD_EN => RD_EN,
          DATA_IN => DATA_IN,
          CLK => CLK,
          RST => RST,
          FIFO_FULL => FIFO_FULL,
          FIFO_EMPTY => FIFO_EMPTY,
          DATA_OUT => DATA_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
	--stimulus proces
	 stim_proc_input: process
	 begin		
		DATA_IN <= "10101010";
		wait for 10 ns;
		DATA_IN <= DATA_IN+1;
		wait for 10 ns;
		DATA_IN <= DATA_IN+1;
		wait for 10 ns;
		DATA_IN <= DATA_IN+1;
		wait;
	 end process;

   stim_proc_RST: process
   begin		
      
		wait for 22.5 ns;
		RST <= '1';
		wait for 30 ns;
		RST <= '0';
		wait;
	end process;
		
	stim_proc_RD: process --rd
   begin		
      
		wait for 45 ns;
		RD_EN <= '1';
		
		wait for 40 ns;
		RD_EN <= '0';
		
	end process;
	
	stim_proc_WR: process --wr
   begin		
      
		wait for 5 ns;
		WR_EN <= '1';
		
		wait for 40 ns;
		WR_EN <= '0';
		
	end process;

END;
