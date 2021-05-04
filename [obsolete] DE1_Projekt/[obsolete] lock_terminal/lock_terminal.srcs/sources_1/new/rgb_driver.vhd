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
            g_CYCLES => 50000000
        )
        Port map(
            clk => clk,
            rst => '0',
            clk_out => s_blink_clk            
        );
    
    mux_0 : entity work.mux_2to1
        Port map(
            dat_i => rgb_color_i,
            pre_i => "000",
            sel_i => s_blink_clk,
            mux_o => s_
        );


end Behavioral;
