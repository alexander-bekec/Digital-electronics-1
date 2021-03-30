library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_arst is
    Port ( 
        clk : in STD_LOGIC;
        arst : in STD_LOGIC;
        d : in STD_LOGIC;
        q : out STD_LOGIC;
        q_bar : out STD_LOGIC
    );
end d_ff_arst;

architecture Behavioral of d_ff_arst is
    signal s_q  : STD_LOGIC;
begin
    p_d_ff_arst : process (clk, arst)
    begin
        if (arst = '1') then
            s_q <= '0';
        elsif rising_edge(clk) then
            s_q <= d;
        end if;
    end process p_d_ff_arst;
    q <= s_q;
    q_bar <= not s_q;
end Behavioral;
