
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LCD_FSM is
    Port ( CLK_12MHz : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           LCD_EN : out  STD_LOGIC;
           LCD_RS : out  STD_LOGIC;
           LCD_DATA : out  STD_LOGIC_VECTOR (7 downto 0));
end LCD_FSM;

architecture Behavioral of LCD_FSM is

signal div : std_logic_vector(15 downto 0);
signal clk_fsm, lcd_rs_s : std_logic ;

--LCD controller states
type state is (reset, func, mode, cur, clear, d0, d1, d2, d3, d4, hold);
signal ps1, nx : state;
signal dataout_s: std_logic_vector(7 downto 0);

BEGIN
	
	-- Clock Divider
	Process (RST, CLK_12MHz)
	BEGIN
		if (RST = '1') then
			div <= (others => '0');
		elsif(CLK_12MHz'event and CLK_12MHz = '1') then
		
			div <= div + 1;
		end if;
		
	end process;
	
	
	-------------
	clk_fsm <= div(15);
	
	
	------------- Present State register
	
	Process (RST, clk_fsm)
	BEGIN
		if (RST = '1') then
			ps1 <= reset;
		elsif (rising_edge(clk_fsm)) then
			ps1 <= nx;
		end if ;
		
	end process;
	
	
	---------State and Output Decodeing Process
	process (ps1)
	BEGIN
		case (ps1) is
		
			when reset => 
				nx <= func;
				lcd_rs_s <= '0';
				dataout_s <= "00111000";
				
			when func => 
				nx <= mode;
				lcd_rs_s <= '0';
				dataout_s <= "00111000";
		
			when mode => 
				nx <= cur;
				lcd_rs_s <= '0';
				dataout_s <= "00000110";
				
			when cur => 
				nx <= clear;
				lcd_rs_s <= '0';
				dataout_s <= "00001100";
				
			when clear => 
				nx <= d0;
				lcd_rs_s <= '0';
				dataout_s <= "00000001";
				
			when d0 => 
				lcd_rs_s <= '1';
				dataout_s <= "01010000";
				nx <= d1;
				
			when d1 => 
				lcd_rs_s <= '1';
				dataout_s <= "01001001";
				nx <= d2;
				
			when d2 => 
				lcd_rs_s <= '1';
				dataout_s <= "01000011";
				nx <= d3;
			
			when d3 => 
				lcd_rs_s <= '1';
				dataout_s <= "01010100";
				nx <= d4;
				
			when d4 => 
				lcd_rs_s <= '1';
				dataout_s <= "00100000";
				nx <= hold;
				
			when hold => 
				lcd_rs_s <= '1';
				dataout_s <= "00000000";
				nx <= hold;
				
			when others => 
				nx <= reset;
				lcd_rs_s <= '0';
				dataout_s <= "00000001";
				
		end case;
	end process;
	
	LCD_EN <= clk_fsm;
	LCD_RS <= lcd_rs_s;
	LCD_DATA <= dataout_s;
	
end Behavioral;

