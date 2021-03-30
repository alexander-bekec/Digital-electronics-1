library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_d_latch is

end tb_d_latch;

architecture Testbench of tb_d_latch is
    signal s_en    : std_logic;
    signal s_d     : std_logic;
    signal s_arst  : std_logic; 
    signal s_q     : std_logic;
    signal s_q_bar : std_logic;
begin
    uut_d_latch : entity work.d_latch
        port map(
            en    => s_en,
            d     => s_d,
            arst  => s_arst,
            q     => s_q,
            q_bar => s_q_bar
        );
        
    p_arst : process
    begin
        report "start of p_arst" severity note;
        s_arst <= '1';
        wait for 10 ns;
        assert (s_q='0' and s_q_bar='1') report "error at time 10 ns at p_arst" severity error;
        wait for 2 ns;
        s_arst <= '0';
        wait for 173 ns;
        s_arst <= '1';
        wait for 12 ns;
        s_arst <= '0';
        wait for 256 ns;
        s_arst <= '1';
        wait for 12 ns;
        s_arst <= '0';
        wait for 227 ns;
        s_arst <= '1';
        wait for 12 ns;
        s_arst <= '0';
        wait;
    end process p_arst;
    
    p_en : process
    begin
        report "start of p_en" severity note;
        s_en <= '1';
        wait for 176 ns;
        s_en <= '0';
        wait for 122 ns;
        s_en <= '1';
        wait for 22 ns;
        s_en <= '0';
        wait for 90 ns;
        s_en <= '1';
        wait for 10 ns;
        assert (s_q='1' and s_q_bar='0') report "error at time 420 ns at p_en" severity error;
        wait for 190 ns;
        s_en <= '0';
        wait;
    end process p_en;
    
    p_stimulus : process
    begin
        report "start of p_stimulus" severity note;
        s_d <= '1';
        wait for 83 ns;
        s_d <= '0';
        wait for 74 ns;
        s_d <= '1';
        wait for 157 ns;
        s_d <= '0';
        wait for 70 ns;
        s_d <= '1';
        wait for 296 ns;
        s_d <= '0';
        wait;
    end process p_stimulus;
end Testbench;
