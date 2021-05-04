library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity door_lock_core is
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        btn_i : in STD_LOGIC_VECTOR(4 - 1 downto 0);
        
        rgb_color_o : out STD_LOGIC_VECTOR(3 - 1 downto 0);
        rgb_mode_o   : out STD_LOGIC_VECTOR(2 - 1 downto 0);
        piezo_mode_o : out STD_LOGIC_VECTOR(2 - 1 downto 0);
        door_o       : out STD_LOGIC;
        display_o    : out STD_LOGIC_VECTOR(16 - 1 downto 0)
    );
end door_lock_core;

architecture Behavioral of door_lock_core is
    type t_state is (IDLE, PASSWORD_ENTRY, PASSWORD_CORRECT, PASSWORD_WRONG, PASSWORD_CHANGE_OLD_ENTRY, PASSWORD_CHANGE_NEW_ENTRY, ALARM);
    signal s_state : t_state;
    signal s_cnt : UNSIGNED(11 - 1 downto 0);
    signal s_counter_wrong_attempts : UNSIGNED(2 - 1 downto 0);
    signal s_en : STD_LOGIC;
    signal s_password_set_new : STD_LOGIC;
    signal s_password_entered : STD_LOGIC_VECTOR(16 - 1 downto 0);
     
    shared variable password_current : STD_LOGIC_VECTOR(16 - 1 downto 0);
    shared variable password_entered : STD_LOGIC_VECTOR(16 - 1 downto 0);
    shared variable display_position : STD_LOGIC_VECTOR(2 - 1 downto 0);
    
    constant c_TIME_PASSWORD_ENTRY : UNSIGNED(11 - 1 downto 0) := b"000_0101_0000";
    constant c_TIME_DOOR_OPENED : UNSIGNED(11 - 1 downto 0) := b"000_0000_1100";
    constant c_TIME_ALARM_ENGAGED : UNSIGNED(11 - 1 downto 0) := b"100_1011_0000";
    constant c_TIME_PASSWORD_WRONG_WARNING : UNSIGNED(11 - 1 downto 0) := b"000_0000_0100";
    constant c_ZERO : UNSIGNED(11 - 1 downto 0) := b"000_0000_0000";
begin
--    clk_en0 : entity work.clock_enable
--        Generic map(
--            g_MAX => 4
--        )
--        Port map(
--            clk => clk,
--            reset => rst,
--            ce_o => s_en
--        );
        
    p_door_lock_core : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                s_state <= IDLE;
                s_cnt <= c_ZERO;
            elsif (s_en = '1') then
                case s_state is                
                    when IDLE =>
                        if (btn_i = "1010") then
                            s_state <= PASSWORD_CHANGE_OLD_ENTRY;
                            s_password_set_new <= '1';
                        elsif (btn_i = "1100") then
                            s_state <= PASSWORD_ENTRY;
                            s_password_set_new <= '0';
                        else
                            s_state <= IDLE;
                        end if;
                        
                    when PASSWORD_CORRECT =>
                        if (s_cnt < c_TIME_DOOR_OPENED) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= IDLE;
                            s_cnt <= c_ZERO;
                        end if;
                    
                    when PASSWORD_WRONG =>
                        if (s_cnt < c_TIME_PASSWORD_WRONG_WARNING) then
                            s_cnt <= s_cnt + 1;
                        else
                            if (s_counter_wrong_attempts > 2) then
                                s_state <= ALARM;
                                s_counter_wrong_attempts <= "00";
                                s_cnt <= c_ZERO;                            
                            elsif (s_password_set_new = '1') then
                                s_state <= PASSWORD_CHANGE_OLD_ENTRY;
                                s_counter_wrong_attempts <= s_counter_wrong_attempts + 1;
                                s_cnt <= c_ZERO;
                            else
                                s_state <= PASSWORD_ENTRY;
                                s_counter_wrong_attempts <= s_counter_wrong_attempts + 1;
                                s_cnt <= c_ZERO;
                            end if;
                        end if;
                        
                    when ALARM =>
                        if (s_cnt < c_TIME_ALARM_ENGAGED) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= IDLE;
                            s_cnt <= c_ZERO;
                            s_counter_wrong_attempts <= "00";
                        end if;
                        
                    when PASSWORD_ENTRY =>
                        if (s_cnt < c_TIME_PASSWORD_ENTRY) then
                            s_cnt <= s_cnt + 1;
                            if (btn_i /= "0000" and btn_i /= "1010" and btn_i /= "1100") then
                                case display_position is
                                    when "00" =>
                                        display_o(3 downto 0) <= btn_i;
                                        password_entered(15 downto 12) := btn_i;
                                        display_position := "01";
                                    when "01" =>
                                        display_o(7 downto 4) <= btn_i;
                                        password_entered(11 downto 8) := btn_i;
                                        display_position := "10";
                                    when "10" =>
                                        display_o(11 downto 8) <= btn_i;
                                        password_entered(7 downto 4) := btn_i;
                                        display_position := "11";
                                    when "11" =>
                                        display_o(15 downto 12) <= btn_i;
                                        password_entered(3 downto 0) := btn_i;
                                        if (password_entered = password_current) then
                                            s_state <= PASSWORD_CORRECT;
                                        else
                                            s_state <= PASSWORD_WRONG;
                                        end if;
                                        display_position := "00";
                                end case;
                            end if;
                        end if;
           end case;             
    end process p_door_lock_core;
    
    p_door_lock_core_output : process(s_state)
    begin
        case s_state is
            when IDLE =>
                piezo_mode_o <= "00";  -- off
                rgb_color_o  <= "001"; -- blue
                rgb_mode_o   <= "10";  -- constant
                display_o    <= "1011101110111011"; -- dashes (-) on all four digits (blinking with use of module)     
            when PASSWORD_ENTRY =>
                piezo_mode_o <= "00";  -- off
                rgb_color_o  <= "111"; -- white
                rgb_mode_o   <= "01";  -- blinking
            when PASSWORD_CORRECT =>
                piezo_mode_o <= "10";  -- constant
                rgb_color_o  <= "010"; -- green
                rgb_mode_o   <= "10";  -- constant
            when PASSWORD_WRONG =>
                piezo_mode_o <= "01";  -- beeping
                rgb_color_o  <= "100"; -- red
                rgb_mode_o   <= "10";  -- constant
            when ALARM =>
                piezo_mode_o <= "01";  -- beeping
                rgb_color_o  <= "100"; -- red
                rgb_mode_o   <= "10";  -- constant
            when PASSWORD_CHANGE_OLD_ENTRY =>
                piezo_mode_o <= "00";  -- off
                rgb_color_o  <= "111"; -- white
                rgb_mode_o   <= "01";  -- blinking
            when PASSWORD_CHANGE_NEW_ENTRY =>
                piezo_mode_o <= "00";  -- off
                rgb_color_o  <= "010"; -- green
                rgb_mode_o   <= "01";  -- blinking
        end case;
    end process p_door_lock_core_output
        

end architecture Behavioral;
