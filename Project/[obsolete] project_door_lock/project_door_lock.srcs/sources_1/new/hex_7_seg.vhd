library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hex_7_seg is
    Port ( 
           hex_i : in STD_LOGIC_VECTOR (4 - 1  downto 0);
           seg_o : out STD_LOGIC_VECTOR (7 - 1  downto 0)
          );
end hex_7_seg;

architecture Behavioral of hex_7_seg is

begin
    hex_7_seg : process(hex_i)
    begin
        case hex_i is
            when "0000" =>
                seg_o <= "0000001";     -- 0
            when "0001" =>
                seg_o <= "1001111";     -- 1
            when "0010" =>
                seg_o <= "0010010";     -- 2
            when "0011" =>
                seg_o <= "0000110";     -- 3
            when "0100" =>
                seg_o <= "1001100";     -- 4
            when "0101" =>
                seg_o <= "0100100";     -- 5
            when "0110" =>
                seg_o <= "0100000";     -- 6
            when "0111" =>
                seg_o <= "0001111";     -- 7
            when "1000" =>
                seg_o <= "0000000";     -- 8
            when "1001" =>
                seg_o <= "0000100";     -- 9
            when "1010" =>
                seg_o <= "1111110";     -- (-)
            when "1011" =>
                seg_o <= "1111111";     -- 
            when "1100" =>
                seg_o <= "0110001";     -- C
            when "1101" =>
                seg_o <= "1000010";     -- D            
            when "1110" =>
                seg_o <= "0110000";     -- E
            when others =>
                seg_o <= "0111000";     -- F
        end case;
    end process hex_7_seg;

end Behavioral;