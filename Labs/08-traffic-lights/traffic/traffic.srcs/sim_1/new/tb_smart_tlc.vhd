library ieee;
use ieee.std_logic_1164.all;


entity tb_smart_tlc is
    
end entity tb_smart_tlc;


architecture testbench of tb_smart_tlc is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_south      : std_logic_vector(3 - 1 downto 0);
    signal s_west       : std_logic_vector(3 - 1 downto 0);
    signal s_SENSOR_WEST : std_logic;
    signal s_SENSOR_SOUTH : std_logic;

begin
    uut_smart_tlc : entity work.smart_tlc
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,
            south_o => s_south,
            west_o  => s_west,
            SENSOR_SOUTH => s_SENSOR_SOUTH,
            SENSOR_WEST => s_SENSOR_WEST
        );

    p_clk_gen : process
    begin
        while now < 10000 ns loop   -- 10 usec of simulation
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0'; wait for 200 ns;
        -- Reset activated
        s_reset <= '1'; wait for 500 ns;
        -- Reset deactivated
        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        s_SENSOR_SOUTH <= '0'; s_SENSOR_WEST <= '0'; wait for 2500 ns;
        s_SENSOR_SOUTH <= '0'; s_SENSOR_WEST <= '1'; wait for 2500 ns;
        s_SENSOR_SOUTH <= '1'; s_SENSOR_WEST <= '0'; wait for 2500 ns;
        s_SENSOR_SOUTH <= '1'; s_SENSOR_WEST <= '1';      
        wait;
    end process p_stimulus;

end architecture testbench;