-- 12-bit Parallel Input Serial Output Shift Register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_piso is
    Port(
        btn_1      : in  STD_LOGIC;   -- Button 1
        btn_2      : in  STD_LOGIC;   -- Button 2
        btn_3      : in  STD_LOGIC;   -- Button 3
        btn_4      : in  STD_LOGIC;   -- Button 4
        btn_5      : in  STD_LOGIC;   -- Button 5
        btn_6      : in  STD_LOGIC;   -- Button 6
        btn_7      : in  STD_LOGIC;   -- Button 7
        btn_8      : in  STD_LOGIC;   -- Button 8
        btn_9      : in  STD_LOGIC;   -- Button 9
        btn_0      : in  STD_LOGIC;   -- Button 0
        btn_STAR   : in  STD_LOGIC;   -- Button *
        btn_HASH   : in  STD_LOGIC;   -- Button #        
        shift      : in  STD_LOGIC;   -- Shift (1 - Shift; 0 - Write)
        clk        : in  STD_LOGIC;   -- Clock input
        rst        : in  STD_LOGIC;   -- Reset
        serial_out : out STD_LOGIC    -- Serial output        
    );
end shift_register_piso;

architecture Behavioral of shift_register_piso is
    signal s_q0  : STD_LOGIC;
    signal s_q1  : STD_LOGIC;
    signal s_q2  : STD_LOGIC;
    signal s_q3  : STD_LOGIC;
    signal s_q4  : STD_LOGIC;
    signal s_q5  : STD_LOGIC;
    signal s_q6  : STD_LOGIC;
    signal s_q7  : STD_LOGIC;
    signal s_q8  : STD_LOGIC;
    signal s_q9  : STD_LOGIC;
    signal s_q10 : STD_LOGIC;
    signal s_q11 : STD_LOGIC;
    
    signal s_mux1  : STD_LOGIC;
    signal s_mux2  : STD_LOGIC;
    signal s_mux3  : STD_LOGIC;
    signal s_mux4  : STD_LOGIC;
    signal s_mux5  : STD_LOGIC;
    signal s_mux6  : STD_LOGIC;
    signal s_mux7  : STD_LOGIC;
    signal s_mux8  : STD_LOGIC;
    signal s_mux9  : STD_LOGIC;
    signal s_mux10 : STD_LOGIC;
    signal s_mux11 : STD_LOGIC;
begin
    d_ff_0 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => btn_HASH,
            q   => s_q0
        );
        
    mux_1 : entity work.mux_2to1
        Port map(
            dat_i => btn_STAR,
            pre_i => s_q0,
            sel_i => shift,
            mux_o => s_mux1
        );
        
    d_ff_1 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux1,
            q   => s_q1
        );
        
    mux_2 : entity work.mux_2to1
        Port map(
            dat_i => btn_0,
            pre_i => s_q1,
            sel_i => shift,
            mux_o => s_mux2
        );
    
    d_ff_2 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux2,
            q   => s_q2
        );
        
    mux_3 : entity work.mux_2to1
        Port map(
            dat_i => btn_9,
            pre_i => s_q2,
            sel_i => shift,
            mux_o => s_mux3
        );
        
    d_ff_3 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux3,
            q   => s_q3
        );
        
    mux_4 : entity work.mux_2to1
        Port map(
            dat_i => btn_8,
            pre_i => s_q3,
            sel_i => shift,
            mux_o => s_mux4
        );
        
    d_ff_4 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux4,
            q   => s_q4
        );
        
    mux_5 : entity work.mux_2to1
        Port map(
            dat_i => btn_7,
            pre_i => s_q4,
            sel_i => shift,
            mux_o => s_mux5
        );
    
    d_ff_5 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux5,
            q   => s_q5
        );
        
    mux_6 : entity work.mux_2to1
        Port map(
            dat_i => btn_6,
            pre_i => s_q5,
            sel_i => shift,
            mux_o => s_mux6
        );
        
    d_ff_6 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux6,
            q   => s_q6
        );
        
    mux_7 : entity work.mux_2to1
        Port map(
            dat_i => btn_5,
            pre_i => s_q6,
            sel_i => shift,
            mux_o => s_mux7
        );
        
    d_ff_7 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux7,
            q   => s_q7
        );
        
    mux_8 : entity work.mux_2to1
        Port map(
            dat_i => btn_4,
            pre_i => s_q7,
            sel_i => shift,
            mux_o => s_mux8
        );
        
    d_ff_8 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux8,
            q   => s_q8
        );
        
    mux_9 : entity work.mux_2to1
        Port map(
            dat_i => btn_3,
            pre_i => s_q8,
            sel_i => shift,
            mux_o => s_mux9
        );
        
    d_ff_9 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux9,
            q   => s_q9
        );
        
    mux_10 : entity work.mux_2to1
        Port map(
            dat_i => btn_2,
            pre_i => s_q9,
            sel_i => shift,
            mux_o => s_mux10
        );
        
    d_ff_10 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux10,
            q   => s_q10
        );
        
    mux_11 : entity work.mux_2to1
        Port map(
            dat_i => btn_1,
            pre_i => s_q10,
            sel_i => shift,
            mux_o => s_mux11
        );
        
    d_ff_11 : entity work.d_flip_flop_rst
        Port map(
            clk => clk,
            rst => rst,
            d   => s_mux11,
            q   => serial_out
        );
end architecture Behavioral;
