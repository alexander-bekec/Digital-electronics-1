library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity door_lock_core is
    port(
        clk : in std_logic;
        reset : in std_logic;
        btn_i : in std_logic_vector(4 - 1 downto 0);
        
        display_o : out std_logic_vector(16 - 1 downto 0);
        rgb_color_o : out std_logic_vector(3 - 1 downto 0);
        rgb_mode_o : out std_logic_vector(2 - 1 downto 0);
        piezo_o : out std_logic_vector(2 - 1 downto 0);
        relay_o : out std_logic
    );
end door_lock_core;

architecture Behavioral of door_lock_core is
    type t_state is (IDLE, D_OPEN, NEW_PASSWORD, ENTRY_PASSWORD_NEW, ENTRY_PASSWORD, ALARM, WRONG_PASSWORD);
    
    signal s_state : t_state;
    signal s_en : std_logic;
    signal s_cnt : unsigned(11 - 1 downto 0);
    
    signal display_pos : unsigned(2 downto 0);
    signal entered_password : std_logic_vector(16 - 1 downto 0) := "1101110111011101";
    signal current_password : std_logic_vector(16 - 1 downto 0) := "0000000000000000";
    signal set_new_password : std_logic;
    signal counter : unsigned(2 downto 0) := "000";
    
    constant c_ENTRY_TIME_20SEC : unsigned(11 - 1 downto 0) := b"000_0101_0000";
    constant c_DOOR_OPEN_TIME_3SEC : unsigned(11 - 1 downto 0) := b"000_0000_1100";
    constant c_ALARM_ENGAGED_TIME_300SEC : unsigned(11 - 1 downto 0) := b"000_1011_0000";
    constant c_WRONG_PASSWORD_BLINK_TIME_1SEC : unsigned(11 - 1 downto 0) := b"000_0000_0100";
    constant c_ZERO : unsigned(11 - 1 downto 0) := b"000_0000_0000";
    
    constant c_COUNTER_MAX_ATTEMPTS : unsigned(2 downto 0) := b"010";
begin
--    clk_en0 : entity work.clock_enable
--        generic map(
--            g_MAX => 10
--        )
--        port map(
--            clk => clk,
--           reset => reset,
--            ce_o => s_en
--        );
     s_en <= '1';
        
     p_door_lock_core : process(clk)
     begin
        if rising_edge(clk) then
            if (reset = '1') then
                s_state <= IDLE;
                s_cnt <= c_ZERO;
            elsif (s_en = '1') then
                case s_state is
                
                    when IDLE =>
                        if (btn_i = "1100") then
                            s_state <= ENTRY_PASSWORD_NEW;
                            set_new_password <= '1';
                            display_pos <= "000";
                        elsif (btn_i = "1010") then
                            s_state <= ENTRY_PASSWORD;
                            set_new_password <= '0';
                            display_pos <= "000";
                        else
                            s_state <= IDLE;
                        end if;
                    
                    when ENTRY_PASSWORD =>
                        if (s_cnt < c_ENTRY_TIME_20SEC) then
                            s_cnt <= s_cnt + 1;
                            if (btn_i /= "1101" and btn_i /= "1010" and btn_i /= "1100") then
                                case display_pos is
                                    when "000" =>
                                        entered_password(15 downto 12) <= btn_i;
                                        display_pos <= "001";
                                    when "001" =>
                                        entered_password(11 downto 8) <= btn_i;
                                        display_pos <= "010";
                                    when "010" =>
                                        entered_password(7 downto 4) <= btn_i;
                                        display_pos <= "011";
                                    when "011" =>
                                        entered_password(3 downto 0) <= btn_i;
                                        display_pos <= "100";
                                    when others =>           
                                        s_state <= IDLE;     
                                        s_cnt <= c_ZERO;     
                                        display_pos <= "000";
                                    end case;
                            end if;
                            
                            if (display_pos = "100") then
                                if (entered_password = current_password) then
                                    s_state <= D_OPEN;
                                    s_cnt <= c_ZERO;
                                    entered_password <= "1101110111011101";
                                elsif (entered_password /= current_password) then
                                    s_state <= WRONG_PASSWORD;
                                    s_cnt <= c_ZERO;
                                    entered_password <= "1101110111011101";
                                end if;
                                set_new_password <= '0';
                                display_pos <= "000";                                    
                            end if;
                            else
                                s_state <= IDLE;
                                s_cnt <= c_ZERO;
                        end if;
                        
                    when D_OPEN =>
                        if (s_cnt < c_DOOR_OPEN_TIME_3SEC) then
                            s_cnt <= s_cnt + 1;    
                        else
                            s_state <= IDLE;
                            s_cnt   <= c_ZERO;
                        end if;
                            
                    when WRONG_PASSWORD =>
                        if (s_cnt < c_WRONG_PASSWORD_BLINK_TIME_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            if (counter >= c_COUNTER_MAX_ATTEMPTS) then
                                s_state <= ALARM;
                                counter <= "000";
                                s_cnt   <= c_ZERO;
                            elsif (set_new_password = '1') then
                                s_state <= ENTRY_PASSWORD_NEW;
                                counter <= counter + 1;
                                s_cnt   <= c_ZERO;
                            elsif (set_new_password = '0') then
                                s_state <= ENTRY_PASSWORD;
                                counter <= counter + 1;
                                s_cnt   <= c_ZERO;
                            end if;
                        end if;
                                
                    when ALARM =>
                        if (s_cnt < c_ALARM_ENGAGED_TIME_300SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= IDLE;
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when ENTRY_PASSWORD_NEW =>
                        if (s_cnt < c_ENTRY_TIME_20SEC) then
                            s_cnt <= s_cnt + 1;
                            if (btn_i /= "1101" and btn_i /= "1010" and btn_i /= "1100") then
                                case display_pos is
                                    when "000" =>
                                        entered_password(15 downto 12) <= btn_i;
                                        display_pos <= "001";
                                    when "001" =>
                                        entered_password(11 downto 8) <= btn_i;
                                        display_pos <= "010";
                                    when "010" =>
                                        entered_password(7 downto 4) <= btn_i;
                                        display_pos <= "011";
                                    when "011" =>
                                        entered_password(3 downto 0) <= btn_i;
                                        display_pos <= "100";
                                    when others =>           
                                        s_state <= IDLE;     
                                        s_cnt <= c_ZERO;     
                                        display_pos <= "000";
                                    end case;
                            end if;
                            
                            if (display_pos = "100") then
                                if (entered_password = current_password) then
                                    s_state <= NEW_PASSWORD;
                                    s_cnt <= c_ZERO;
                                    entered_password <= "1101110111011101";
                                elsif (entered_password /= current_password) then
                                    s_state <= WRONG_PASSWORD;
                                    s_cnt <= c_ZERO;
                                    entered_password <= "1101110111011101";
                                end if;
                                set_new_password <= '1';
                                display_pos <= "000";                                    
                            end if;
                            else
                                s_state <= IDLE;
                                s_cnt <= c_ZERO;
                        end if;
                    
                    when NEW_PASSWORD =>
                        if (s_cnt < c_ENTRY_TIME_20SEC) then
                            s_cnt <= s_cnt + 1;
                            if (btn_i /= "1101" and btn_i /= "1010" and btn_i /= "1100") then
                                case display_pos is
                                    when "000" =>
                                        entered_password(15 downto 12) <= btn_i;
                                        display_pos <= "001";
                                    when "001" =>
                                        entered_password(11 downto 8) <= btn_i;
                                        display_pos <= "010";
                                    when "010" =>
                                        entered_password(7 downto 4) <= btn_i;
                                        display_pos <= "011";
                                    when "011" =>
                                        entered_password(3 downto 0) <= btn_i;
                                        display_pos <= "100";
                                    when others =>           
                                        s_state <= IDLE;     
                                        s_cnt <= c_ZERO;     
                                        display_pos <= "000";
                                    end case;
                            end if;
                            
                            if (display_pos = "100") then
                                current_password <= entered_password;
                                s_state <= IDLE;
                                s_cnt <= c_ZERO;
                                entered_password <= "1101110111011101";
                                set_new_password <= '0';
                                display_pos <= "000";                                    
                            end if;
                            else
                                s_state <= IDLE;
                                s_cnt <= c_ZERO;
                        end if;
                        
                    when others =>
                        s_state <= IDLE;   
                end case;
            end if;
        end if;
    end process p_door_lock_core;
    
    p_door_lock_core_output : process(clk)
    begin
        case s_state is
            when IDLE =>
                piezo_o <= "00";  -- off
                rgb_color_o  <= "001"; -- blue
                rgb_mode_o   <= "10";  -- constant
                relay_o <= '0';
                display_o <= "1010101010101010";
            when ENTRY_PASSWORD =>
                piezo_o <= "00";  -- off
                rgb_color_o  <= "111"; -- white
                rgb_mode_o   <= "01";  -- blinking
                relay_o <= '0';
                display_o <= entered_password;
            when D_OPEN =>
                piezo_o <= "10";  -- constant
                rgb_color_o  <= "010"; -- green
                rgb_mode_o   <= "10";  -- constant
                relay_o <= '1';
                display_o <= "1101110111011101";
            when WRONG_PASSWORD =>
                piezo_o <= "01";  -- beeping
                rgb_color_o  <= "100"; -- red
                rgb_mode_o   <= "10";  -- constant
                relay_o <= '0';
                display_o <= "1101110111011101";
            when ALARM =>
                piezo_o <= "01";  -- beeping
                rgb_color_o  <= "100"; -- red
                rgb_mode_o   <= "10";  -- constant
                relay_o <= '0';
                display_o <= "1101110111011101";
            when ENTRY_PASSWORD_NEW =>
                piezo_o <= "00";  -- off
                rgb_color_o  <= "111"; -- white
                rgb_mode_o   <= "01";  -- blinking
                relay_o <= '0';
                display_o <= entered_password;
            when NEW_PASSWORD =>
                piezo_o <= "00";  -- off
                rgb_color_o  <= "010"; -- green
                rgb_mode_o   <= "01";  -- blinking
                relay_o <= '0';
                display_o <= entered_password;
        end case;
    end process p_door_lock_core_output;
end Behavioral;
