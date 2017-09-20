----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.09.2017 17:13:26
-- Design Name: 
-- Module Name: act_traffic - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity traffic is
    Port ( clk : in STD_LOGIC;
           mod_a : in STD_LOGiC;
           mod_b : in STD_LOGiC;
           mod_c : in STD_LOGiC;
           request : in STD_LOGIC;
           granted : out STD_LOGIC;
           denied : out STD_LOGIC;
           clk_one : out STD_LOGIC;
           timer_ten: out STD_LOGIC
           );
end traffic;

architecture Behavioral of traffic is
    signal heavy : STD_LOGIC := '0';
    signal req : STD_LOGIC := '0';
    signal previous_req : STD_LOGIC := '0';
    signal start_ten : STD_LOGIC := '0';
    signal start_three : STD_LOGIC := '0';
    signal end_ten : STD_LOGIC;
    signal end_three : STD_LOGIC;
    signal previous_mod : STD_LOGIC := '0';
    signal current_mod : STD_LOGIC := '0';
    signal clk_enable : STD_LOGIC;
    type state_type is (heavy_mod,light_mod,busy);  --type of state machine.
    signal current_s: state_type := light_mod;
    signal next_s: state_type;
    signal grant : STD_LOGIC := '0';
    signal deny : STD_LOGIC := '0';

begin
    process(clk_enable)
    begin
        if rising_edge(clk_enable) then
            current_s <= next_s;
            previous_req <= req;
        end if;
    end process;

    process(current_s, end_three, req, previous_req, heavy, end_ten)
    begin
        case current_s is
        when light_mod =>
            grant <= '0';
            deny <= '0';
            if (req = '1' and previous_req = '0') then
                grant <= '1';
                start_three <= '1';
                previous_mod <= heavy;
                next_s <= busy;
                if heavy = '1' then
                    start_ten <= '1';
                end if;
            else
                next_s <= light_mod;
            end if;
        when heavy_mod =>
            grant <= '0';
            deny <= '0';
            if (req = '1' and previous_req = '0') then
                start_three <= '1';
                if heavy = '1' then
                    grant <= '1';
                    start_ten <= '1';
                    previous_mod <= heavy;
                else
                    if end_ten = '0' then
                        grant <= '1';
                        previous_mod <= heavy;
                    else
                        deny <= '1';
                    end if;
                end if;
                next_s <= busy;
            else
                next_s <= heavy_mod;
            end if;
        when busy =>
            start_three <= '0';
            start_ten <= '0';
            if (start_three or end_three) = '0' then
                if previous_mod = '1' then
                    next_s <= heavy_mod;
                else
                    next_s <= light_mod;
                end if;
            end if;
        end case;
    end process;
        
        slow_clk : entity work.slow_clk(behavioral)
            generic map (counter_size   => 50000000)
            port map(
            clk => clk,
            clk_out => clk_enable
            );
            
        count_ten : entity work.clk_ten(behavioral)
            generic map (counter_size   => 10)
            port map(
            clk => clk_enable,
            enable => start_ten,
            done => end_ten
            );
        
        count_three : entity work.clk_ten(behavioral)
            generic map (counter_size   => 2)
            port map(
            clk => clk_enable,      
            enable => start_three,
            done => end_three
            );    
            
        debounce : entity work.debounce(behavioral)
            port map(
            clk => clk,
            button => request,
            result => req
            );
--        req <= request;
        
        model_select : entity work.model_sel(behavioral)
            port map(
            mod_a => mod_a,
            mod_b => mod_b,
            mod_c => mod_c,
            output => heavy
            );
            
        timer_ten <= start_ten or end_ten;
        granted <= grant;
        denied <= deny;
        clk_one <= clk_enable;
        
end Behavioral;
