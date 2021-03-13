library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        CLK100MHZ : in std_logic; --main clock
        BTNC : in std_logic; --synchronous std_logic
        SW : in std_logic_vector(1 - 1 downto 0); --counter direction
        LED : out std_logic_vector(16 - 1 downto 0); --counter value LED indicators
        CA : out std_logic; --cathode A
        CB : out std_logic; --cathode B
        CC : out std_logic; --cathode C
        CD : out std_logic; --cathode D
        CE : out std_logic; --cathode E
        CF : out std_logic; --cathode F
        CG : out std_logic; --cathode G
        AN : out std_logic_vector(8 - 1 downto 0)
    );
end top;

architecture Behavioral of top is
    signal s_en  : std_logic; -- Internal clock enable
    signal s_cnt : std_logic_vector(4 - 1 downto 0); -- Internal counter
    signal s_en_16 : std_logic;
    signal s_cnt_16 : std_logic_vector(16 - 1 downto 0);
begin
    clk_en0 : entity work.clock_enable -- Instance (copy) of clock_enable entity
        generic map(
            g_MAX => 100000000
        )
        port map(
            clk => CLK100MHZ,
            reset => BTNC,
            ce_o => s_en
        );
        
    clk_en1 : entity work.clock_enable -- Instance (copy) of clock_enable entity
        generic map(
            g_MAX => 1000000
        )
        port map(
            clk => CLK100MHZ,
            reset => BTNC,
            ce_o => s_en_16
        );

    bin_cnt0 : entity work.cnt_up_down -- Instance (copy) of cnt_up_down entity
        generic map(
            g_CNT_WIDTH => 4
        )
        port map(
            clk => CLK100MHZ,
            reset => BTNC,
            en_i => s_en,
            cnt_up_i => SW(0),
            cnt_o => s_cnt
        );
        
    bin_cnt1 : entity work.cnt_up_down -- Instance (copy) of cnt_up_down entity
        generic map(
            g_CNT_WIDTH => 16
        )
        port map(
            clk => CLK100MHZ,
            reset => BTNC,
            en_i => s_en_16,
            cnt_up_i => '1',
            cnt_o => s_cnt_16
        );

    LED(15 downto 0) <= s_cnt_16; -- Display input value on LEDs

    hex2seg : entity work.hex_7seg -- Instance (copy) of hex_7seg entity
        port map(
            hex_i    => s_cnt,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    AN <= b"1111_1110"; -- Connect one common anode to 3.3V

end architecture Behavioral;
