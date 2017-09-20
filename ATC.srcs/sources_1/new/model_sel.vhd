----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.09.2017 18:28:15
-- Design Name: 
-- Module Name: model_sel - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity model_sel is
    Port ( 
    mod_a : in STD_LOGIC;
    mod_b : in STD_LOGIC;
    mod_c : in STD_LOGIC;
    output : out STD_LOGIC
    );
end model_sel;

architecture Behavioral of model_sel is
    signal model : STD_LOGIC_VECTOR (2 downto 0);

begin
    
    process(model)
    begin
        if (model = ("001" or "011" or "111")) then
            output <= '1';
        else
            output <= '0';
        end if;
    end process;

    model (0) <= mod_a;
    model (1) <= mod_a;
    model (2) <= mod_a;
    
end Behavioral;
