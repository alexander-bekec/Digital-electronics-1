library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_latch is
    Port ( 
        en    : in STD_LOGIC;
        arst  : in STD_LOGIC;
        d     : in STD_LOGIC;
        q     : out STD_LOGIC;
        q_bar : out STD_LOGIC
    );
end d_latch;

architecture Behavioral of d_latch is
    signal s_q  : STD_LOGIC;
begin
    p_d_latch : process (en, arst, d)
    begin
        if (arst = '1') then
            s_q <= '0';
        elsif (en = '1') then
            s_q <= d;
        end if;
    end process p_d_latch;
    q <= s_q;
    q_bar <= not s_q;
end Behavioral;