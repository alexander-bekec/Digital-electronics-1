library ieee;
use ieee.std_logic_1164.all;

entity tb_door_lock_core is
    -- Entity of testbench is always empty
end entity tb_door_lock_core;

architecture testbench of tb_door_lock_core is
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    signal   s_clk           :   std_logic;
    signal   s_reset         :   std_logic;
    signal   s_btn_i         :   std_logic_vector(4 - 1 downto 0);
     
    signal   s_rgb_color_o   :   std_logic_vector( 3 - 1 downto 0);
    signal   s_rgb_mode_o    :   std_logic_vector( 2 - 1 downto 0);
    signal   s_piezo_o       :   std_logic_vector( 2 - 1 downto 0);
    signal   s_relay_o       :   std_logic;
    signal   s_display_o     :   std_logic_vector(16 - 1 downto 0);
    
begin
    uut_door_lock_core : entity work.door_lock_core 
        port map(
            clk          => s_clk,
            reset        => s_reset,
    
            btn_i        => s_btn_i,
            rgb_color_o  => s_rgb_color_o,
            rgb_mode_o   => s_rgb_mode_o,
            piezo_o      => s_piezo_o,
            relay_o      => s_relay_o
    );
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 10000 ns loop         -- 1000 periods of 100MHz clock
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
       p_reset_gen : process
        begin
        s_reset <= '0';
        wait for 10 ns;
        
        -- Reset activated
        s_reset <= '1';
        wait for 25 ns;

        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        wait for 1 us;
        s_btn_i  <= "1100";
        wait for 10 ns;
        s_btn_i  <= "0000";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0000";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0000";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0000";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 20 ns;
        
        s_btn_i  <= "0001";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0001";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0001";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0001";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 30 ns;
        
        s_btn_i  <= "1010";
        wait for 10 ns;
        s_btn_i  <= "0001";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0001";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0001";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 10 ns;
        s_btn_i  <= "0001";
        wait for 10 ns;
        s_btn_i  <= "1101";
        wait for 20 ns;
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;