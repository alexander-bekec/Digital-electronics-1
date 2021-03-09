library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top is

end tb_top;

architecture Testbench of tb_top is
    signal s_hex : std_logic_vector(4 - 1 downto 0);
    signal s_seg : std_logic_vector(7 - 1 downto 0);
    signal s_LED : std_logic_vector(8 - 1 downto 0);
begin
    uut_top : entity work.top
        port map (
            SW => s_hex,
            CA => s_seg(6),
            CB => s_seg(5),
            CC => s_seg(4),
            CD => s_seg(3),
            CE => s_seg(2),
            CF => s_seg(1),
            CG => s_seg(0),
            LED => s_LED
        );
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_hex <= "0000"; wait for 50 ns;
        s_hex <= "0001"; wait for 50 ns;
        s_hex <= "0010"; wait for 50 ns;
        s_hex <= "0011"; wait for 50 ns;
        s_hex <= "0100"; wait for 50 ns;
        s_hex <= "0101"; wait for 50 ns;
        s_hex <= "0110"; wait for 50 ns;
        s_hex <= "0111"; wait for 50 ns;
        s_hex <= "1000"; wait for 50 ns;
        s_hex <= "1001"; wait for 50 ns;
        s_hex <= "1010"; wait for 50 ns;
        s_hex <= "1011"; wait for 50 ns;
        s_hex <= "1100"; wait for 50 ns;
        s_hex <= "1101"; wait for 50 ns;
        s_hex <= "1110"; wait for 50 ns;
        s_hex <= "1111"; wait for 50 ns;
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end Testbench;