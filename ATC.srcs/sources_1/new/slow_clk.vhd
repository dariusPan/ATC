----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.09.2017 10:51:29
-- Design Name: 
-- Module Name: slow_clk - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity slow_clk is
    generic(counter_size  :  integer);
    Port ( clk : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end slow_clk;

architecture Behavioral of slow_clk is
    signal count : integer := 0;
    signal clk_enable : STD_LOGIC := '0';
    
begin
    process(clk)
    begin
        if rising_edge(clk) then 
            count <= count+1;
            if(count = counter_size) then
                clk_enable <= not clk_enable;
                count <= 1;
            end if; 
        end if;
    end process;
    
    clk_out <= clk_enable;
end Behavioral;
