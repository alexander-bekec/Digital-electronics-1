library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rgb_driver is
    Port ( 
        clk : in STD_LOGIC;
        rgb_mode_i : in STD_LOGIC_VECTOR(2 - 1 downto 0);
        rgb_color_i : in STD_LOGIC_VECTOR(3 - 1 downto 0);
        
        rgb_o : out STD_LOGIC_VECTOR(3 - 1 downto 0)
    );
end rgb_driver;

architecture Behavioral of rgb_driver is
    signal s_blink_clk : STD_LOGIC;
    signal s_blink : STD_LOGIC_VECTOR(3 - 1 downto 0);
begin
    clock_divider_0 : entity work.clock_divider
        Generic map(
            g_CYCLES => 25000000
        )
        Port map(
            clk => clk,
            rst => '0',
            clk_out => s_blink_clk            
        );
    
    mux_0 : entity work.mux_2to1
        Port map(
            dat_i => rgb_color_i(2),
            pre_i => '0',
            sel_i => s_blink_clk,
            mux_o => s_blink(2)
        );
    
    mux_1 : entity work.mux_2to1
        Port map(
            dat_i => rgb_color_i(1),
            pre_i => '0',
            sel_i => s_blink_clk,
            mux_o => s_blink(1)
        );
    
    mux_2 : entity work.mux_2to1
        Port map(
            dat_i => rgb_color_i(0),
            pre_i => '0',
            sel_i => s_blink_clk,
            mux_o => s_blink(0)
        );
        
    p_rgb_o : process(rgb_mode_i)
    begin
    case rgb_mode_i is
        when "01" =>
            rgb_o <= s_blink;
        when "10" =>
            rgb_o <= rgb_color_i;
        when others =>
            rgb_o <= "000";
        end case;
    end process p_rgb_o;
end Behavioral;
