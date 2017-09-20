----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.09.2017 10:50:58
-- Design Name: 
-- Module Name: clk_ten - Behavioral
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

entity clk_ten is
    generic(counter_size  :  integer);
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           done : out STD_LOGIC);
end clk_ten;

architecture Behavioral of clk_ten is
    signal count : integer := 1;
    signal temp : STD_LOGIC := '0';
    type state_type is (waiting, counting);  --type of state machine.
    signal current_s: state_type := waiting;
    
begin

    process(clk)
        begin
            if rising_edge(clk) then
                case current_s is
                when waiting =>
                    if enable = '1' then
                        current_s <= counting;
                        count <= 1;
                        temp <= '1';
                    else
                        current_s <= waiting;
                    end if;
                when counting =>
                    if enable = '1' then
                        count <= 1;
                    else
                        count <= count + 1;
                        if count = counter_size then
                            temp <= '0';
                            current_s <= waiting;
                        end if;
                    end if;
                end case;
            end if;
        end process;
    
    done <= temp;

end Behavioral;
