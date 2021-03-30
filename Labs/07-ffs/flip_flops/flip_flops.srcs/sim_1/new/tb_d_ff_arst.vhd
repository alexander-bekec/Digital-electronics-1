library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_d_ff_arst is

end tb_d_ff_arst;

architecture Behavioral of tb_d_ff_arst is
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
    signal s_CLK_100MHZ : STD_LOGIC;
    signal s_arst : STD_LOGIC;
    signal s_d : STD_LOGIC;
    signal s_q : STD_LOGIC;
    signal s_q_bar : STD_LOGIC;
    
begin
    uut_d_ff_arst : entity work.d_ff_arst
        port map(
            arst => s_arst,
            clk => s_CLK_100MHZ,
            d => s_d,
            q => s_q,
            q_bar => s_q_bar
        );

    p_clk_gen : process
    begin
        while now < 750 ns loop
            s_CLK_100MHZ <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_CLK_100MHZ <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_reset_gen : process
    begin
        report "Start of reset generation process" severity note;
        
        while now < 750 ns loop
            s_arst <= '0';
            wait for 40 ns;
            s_arst <= '1';
            wait for 17 ns;
            s_arst <= '0';
            wait for 164 ns;
        end loop;
        wait;
        
        report "End of reset generation process" severity note;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
        report "Start of stimulus process" severity note;
        
        while now < 600 ns loop
            s_d <= '0';
            wait for 20 ns;
            s_d <= '1';
            wait for 40 ns;
        end loop;
        s_d <= '0';
        wait for 10 ns;
        assert (s_q = '0' and s_q_bar = '1') report "assert error" severity error;
        wait for 24 ns;
        s_d <= '1';
        wait for 10 ns;
        assert (s_q = '1' and s_q_bar = '0') report "assert error" severity error;
        wait;
        
        report "End of stimulus process" severity note;
    end process p_stimulus;
end Behavioral;