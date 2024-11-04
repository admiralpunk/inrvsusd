----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIFO_BT is
	 generic(depth : integer := 16);
    Port ( WR_EN : in  STD_LOGIC;
           RD_EN : in  STD_LOGIC;
           DATA_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           FIFO_FULL : out  STD_LOGIC;
           FIFO_EMPTY : out  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end FIFO_BT;

architecture Behavioral of FIFO_BT is

type memory_type is  array (0 to depth-1) of std_logic_vector(7 downto 0);
signal memory : memory_type := (others => (others => '0'));
signal readptr, writeptr : integer := 0;
signal empty, full : std_logic := '0';

begin

	FIFO_EMPTY <= empty;
	FIFO_FULL <= full;
	process (CLK, RST)
	variable num_elem : integer := 0;
	begin
		
		if (RST = '1') then
			memory <= (others => (others => '0'));
			DATA_OUT <= (others => '0');
			empty <= '1';
			full <= '0';
			readptr <= 0;
			writeptr <= 0;
			num_elem := 0;
			
		elsif(rising_edge(CLK)) then
			if(RD_EN = '1' and empty = '0') then --read
				DATA_OUT <= memory(readptr);
				readptr <= readptr + 1;
				num_elem := num_elem - 1;
			end if;
			
			if(WR_EN = '1' and full = '0') then
				memory(writeptr) <= DATA_IN;
				writeptr <= writeptr + 1;
				num_elem := num_elem + 1;
			end if;
			
			if(readptr = depth - 1) then
				readptr <= 0;
			end if;
			
			if(writeptr = depth - 1) then 
				writeptr <= 0;
			end if;
			
			if(num_elem = 0) then
				empty <= '1';
			else 
				empty <= '0';
			end if;
			
			if(num_elem = depth) then
				full <= '1';
			else 
				full <= '0';
			end if;
			
		end if;
	end process;
end Behavioral;

