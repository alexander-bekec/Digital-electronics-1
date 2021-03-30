library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( 
        BTNU : in STD_LOGIC;
        BTNC : in STD_LOGIC;
        SW : in STD_LOGIC_VECTOR (0 downto 0);
        LED : out STD_LOGIC_VECTOR (3 downto 0)
    );
end top;

architecture Behavioral of top is
    signal s_q0 : STD_LOGIC;
    signal s_q1 : STD_LOGIC;
    signal s_q2 : STD_LOGIC;
begin
    d_ff_0 : entity work.d_ff_rst
        port map(
            clk => BTNU,
            rst => BTNC,
            d => SW(0),
            q => s_q0            
        );
        
    d_ff_1 : entity work.d_ff_rst
        port map(
            clk => BTNU,
            rst => BTNC,
            d => s_q0,
            q => s_q1            
        );
    
    d_ff_2 : entity work.d_ff_rst
        port map(
            clk => BTNU,
            rst => BTNC,
            d => s_q1,
            q => s_q2            
        );
        
    d_ff_3 : entity work.d_ff_rst
        port map(
            clk => BTNU,
            rst => BTNC,
            d => s_q2,
            q => LED(3)            
        );
        
    LED(2) <= s_q2;
    LED(1) <= s_q1;
    LED(0) <= s_q0;
        
end Behavioral;
