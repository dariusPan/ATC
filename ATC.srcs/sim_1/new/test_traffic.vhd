----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.09.2017 18:40:48
-- Design Name: 
-- Module Name: test_act_traffic - Behavioral
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

entity test_traffic is
--  Port ( );
end test_traffic;

architecture Behavioral of test_traffic is
    signal clk : STD_LOGIC := '0';
    signal request : STD_LOGIC;
    signal granted : STD_LOGIC;
    signal denied : STD_LOGIC;
    signal clk_one : STD_LOGIC;
    signal mod_a : STD_LOGIC;
    signal mod_b : STD_LOGIC;
    signal mod_c : STD_LOGIC;

begin

    act: entity work.traffic(behavioral)
    port map(
         mod_a => mod_a,
         mod_b => mod_b,
         mod_c => mod_c,
         request => request,
         granted => granted,
         denied => denied,
         clk => clk,
         clk_one => clk_one
         );
          
    clock: process
        begin
            -- Toggle clock signal
            clk <= not(clk);
            -- Wait for half of the clock period
            wait for 5 ns;
    end process;
    
    test: process
    
        begin
        
        request <= '0';
        mod_a <= '0';
        mod_b <= '1';
        mod_c <= '1';
        wait for 20ns;
        request <= not request;
        wait for 100ns;
        request <= not request;
        mod_a <= '0';
        mod_b <= '1';
        mod_c <= '0';
        wait for 50ns;
        request <= not request;
        mod_a <= '0';
        mod_b <= '1';
        mod_c <= '1';
        wait for 20ns;
        request <= not request;
        wait for 80ns;
        mod_a <= '1';
        mod_b <= '1';
        mod_c <= '1';
        wait for 80ns;
        request <= not request;
        wait for 20ns;
        mod_a <= '1';
        mod_b <= '1';
        mod_c <= '1';
        wait for 20ns;
        mod_a <= '1';
        mod_b <= '1';
        mod_c <= '1';
        wait for 10ns;

        wait for 20ns;

        wait for 10ns;
        mod_a <= '1';
        mod_b <= '1';
        mod_c <= '1';
        request <= not request;
        wait for 100ns;
        mod_a <= '0';
        mod_b <= '0';
        mod_c <= '0';
        wait for 10ns;
        request <= not request;
        mod_a <= '1';
        mod_b <= '1';
        mod_c <= '1';
        wait for 100ns;
        request <= not request;
        mod_a <= '1';
        mod_b <= '1';
        mod_c <= '1';
        wait for 100ns;
        request <= not request;
        wait for 250ns;
        
        mod_a <= '1';
        mod_b <= '1';
        mod_c <= '1';
        wait for 50ns;
        mod_a <= '0';
        mod_b <= '0';
        mod_c <= '0';
        wait for 30ns;
        request <= not request;
        wait for 200ns;
        request <= not request;
        wait for 500ns;
        request <= not request;
        wait;
        
    end process;

end Behavioral;