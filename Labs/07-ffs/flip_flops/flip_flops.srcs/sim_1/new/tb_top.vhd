library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top is

end tb_top;

architecture Testbench of tb_top is
    signal s_BTNU : STD_LOGIC;
    signal s_BTNC : STD_LOGIC;
    signal s_LED : STD_LOGIC_VECTOR(4-1 downto 0);
    signal s_SW : STD_LOGIC_VECTOR(1-1 downto 0);
    
begin
    uut_top : entity work.top
        port map(
            BTNU => s_BTNU,
            BTNC => s_BTNC,
            LED => s_LED,
            SW => s_SW
        );

    p_BTNU : process
    begin
        while now < 750 ns loop
            s_BTNU <= '0';
            wait for 50 ns / 2;
            s_BTNU <= '1';
            wait for 50 ns / 2;
        end loop;
        wait;
    end process p_BTNU;
    
    p_BTNC : process
    begin
        report "Start of reset generation process" severity note;
        wait;               
        report "End of reset generation process" severity note;
    end process p_BTNC;
    
    p_SW : process
    begin
        report "Start of stimulus process" severity note;
        
        while now < 750 ns loop
            s_SW(0) <= '0';
            wait for 50 ns;
            s_SW(0) <= '1';
            wait for 50 ns;
            s_SW(0) <= '1';
            wait for 50 ns;
            s_SW(0) <= '0';
            wait for 50 ns;
            s_SW(0) <= '1';
            wait for 50 ns;
        end loop;
        wait;
        
        report "End of stimulus process" severity note;
    end process p_SW;
end Testbench;
