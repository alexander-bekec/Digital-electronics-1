library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
        CLK100MHZ : in  STD_LOGIC; -- Clock
        BTNC      : in  STD_LOGIC; -- Reset
        PB1       : in  STD_LOGIC; -- Button 1
        PB2       : in  STD_LOGIC; -- Button 2 
        PB3       : in  STD_LOGIC; -- Button 3
        PB4       : in  STD_LOGIC; -- Button 4
        PB5       : in  STD_LOGIC; -- Button 5
        PB6       : in  STD_LOGIC; -- Button 6
        PB7       : in  STD_LOGIC; -- Button 7
        PB8       : in  STD_LOGIC; -- Button 8
        PB9       : in  STD_LOGIC; -- Button 9
        PB0       : in  STD_LOGIC; -- Button 0
        PBC       : in  STD_LOGIC; -- Button *
        PBH       : in  STD_LOGIC; -- Button #
        BTN       : in  STD_LOGIC_VECTOR(4 - 1 downto 0);
        RGB       : out STD_LOGIC_VECTOR(3 - 1 downto 0); -- RGB LED
        CA        : out STD_LOGIC; -- Segment A
        CB        : out STD_LOGIC; -- Segment B
        CC        : out STD_LOGIC; -- Segment C
        CD        : out STD_LOGIC; -- Segment D
        CE        : out STD_LOGIC; -- Segment E
        CF        : out STD_LOGIC; -- Segment F
        CG        : out STD_LOGIC; -- Segment G
        CDP       : out STD_LOGIC; -- Segment DP
        A         : out STD_LOGIC_VECTOR (4 - 1 downto 0); -- Anodes
        REL       : out STD_LOGIC; -- Relay
        BUZZ_PIN  : out STD_LOGIC  -- Piezo
    );
end top;

architecture Behavioral of top is
    signal s_btn_i : STD_LOGIC_VECTOR(4 - 1 downto 0);
    signal s_display_o : STD_LOGIC_VECTOR(16 - 1 downto 0);
    signal s_data3_o : STD_LOGIC_VECTOR(4 - 1 downto 0);
    signal s_data2_o : STD_LOGIC_VECTOR(4 - 1 downto 0);
    signal s_data1_o : STD_LOGIC_VECTOR(4 - 1 downto 0);
    signal s_data0_o : STD_LOGIC_VECTOR(4 - 1 downto 0);
begin
    keyboard_decoder0 : entity work.keyboard_decoder
        port map(
            decoder_out => s_btn_i,
            btn_1       => PB1,
            btn_2       => PB2,
            btn_3       => PB3,
            btn_4       => PB4,
            btn_5       => PB5,
            btn_6       => PB6,
            btn_7       => PB7,
            btn_8       => PB8,
            btn_9       => PB9,
            btn_0       => PB0,
            btn_STAR    => PBC,
            btn_HASH    => PBH
        );
        
    door_lock_core0 : entity work.door_lock_core
        port map(
            clk => CLK100MHZ,
            reset => BTNC,
            btn_i => s_btn_i,
            
            display_o
            rgb_color_o
            rgb_mode_o
            piezo_o
            relay_o
        );
    
    display_driver0 : entity work.driver_7seg_4digits
        port map(
            clk => CLK100MHZ,
            reset => BTNC,
            data0_i => s_data0_o,
            data1_i => s_data1_o,
            data2_i => s_data2_o,
            data3_i => s_data3_o
            
        );

end architecture Behavioral;
