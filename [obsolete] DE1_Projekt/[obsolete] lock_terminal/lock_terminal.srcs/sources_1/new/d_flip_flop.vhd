library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flip_flop_rst is
    Port (
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        d     : in  STD_LOGIC;
        q     : out STD_LOGIC;
        q_bar : out STD_LOGIC
    );
end d_flip_flop_rst;

architecture Behavioral of d_flip_flop_rst is
    signal s_q  : STD_LOGIC;
begin
    p_d_flip_flop_rst : process(clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                s_q <= '0';
            else
                s_q <= d;
            end if;
        end if;
    end process p_d_flip_flop_rst;
    q <= s_q;
    q_bar <= not s_q;
end architecture Behavioral;