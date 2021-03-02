# Vypracovanie PC_3
Alexander Bekeč, 221096

Link to depository: https://github.com/alexander-bekec/Digital-electronics-1

## 1. Preparation task

| **Switch** | **Pin connection** | **LED** | **Pin connection** |
| :-: | :-: | :-: | :-: |
| SW0 | J15 | LED0 | H17 |
| SW1 | L16 | LED1 | K15 |
| SW2 | M13 | LED2 | J13 |
| SW3 | R15 | LED3 | N14 |
| SW4 | R17 | LED4 | R18 |
| SW5 | T18 | LED5 | V17 |
| SW6 | U18 | LED6 | U17 |
| SW7 | R13 | LED7 | U16 |
| SW8 | T8 | LED8 | V16 |
| SW9 | U8 | LED9 | T15 |
| SW10 | R16 | LED10 | U14 |
| SW11 | T13 | LED11 | T16 |
| SW12 | H6 | LED12 | V15 |
| SW13 | U12 | LED13 | V14 |
| SW14 | U11 | LED14 | V12 |
| SW15 | V10 | LED15 | V11 |

## 2. 2-bit 4-to-1 multiplexer

```VHDL
-- Architecture (Source file)
library IEEE;
use IEEE.std_logic_1164.all;

entity mux_2bit_4to1 is
    port(
        a_i           : in  std_logic_vector(2 - 1 downto 0);
        b_i           : in  std_logic_vector(2 - 1 downto 0);
        c_i           : in  std_logic_vector(2 - 1 downto 0);
        d_i           : in  std_logic_vector(2 - 1 downto 0);
        sel_i         : in  std_logic_vector(2 - 1 downto 0);
        f_o           : out std_logic_vector(2 - 1 downto 0)
    );
end entity mux_2bit_4to1;

architecture Behavioral of mux_2bit_4to1 is
begin
    f_o    <= a_i when (sel_i = "00") else
                b_i when (sel_i = "01") else
                c_i when (sel_i = "10") else
                d_i;
end architecture Behavioral;
```

```VHDL
-- Stimulus process (Testbench file)
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mux_2bit_4to1 is

end entity tb_mux_2bit_4to1;

architecture testbench of tb_mux_2bit_4to1 is

    signal s_a       : std_logic_vector(2 - 1 downto 0);
    signal s_b       : std_logic_vector(2 - 1 downto 0);
    signal s_c       : std_logic_vector(2 - 1 downto 0);
    signal s_d       : std_logic_vector(2 - 1 downto 0);
    signal s_sel     : std_logic_vector(2 - 1 downto 0);
    signal s_f       : std_logic_vector(2 - 1 downto 0);
    
begin
    uut_mux_2bit_4to1 : entity work.mux_2bit_4to1
        port map(
            a_i     => s_a,
            b_i     => s_b,
            c_i     => s_c,
            d_i     => s_d,
            sel_i   => s_sel,
            f_o     => s_f
        );
        
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_d <= "11"; s_c <= "10"; s_b <= "01"; s_a <= "00"; 
        s_sel <= "00"; wait for 250 ns;
        
        s_d <= "11"; s_c <= "10"; s_b <= "01"; s_a <= "00"; 
        s_sel <= "01"; wait for 250 ns;
        
        s_d <= "11"; s_c <= "10"; s_b <= "01"; s_a <= "00"; 
        s_sel <= "10"; wait for 250 ns;
        
        s_d <= "11"; s_c <= "10"; s_b <= "01"; s_a <= "00"; 
        s_sel <= "11"; wait for 250 ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
```

![](IMAGES/01_Priebeh_MUX.png)

## 3. Vivado Tutoriál
### Vytvorenie projektu
V hlavnom menu programu klikneme v sekcii Quick Start na Create Project:
![](IMAGES/00_Tutorial_01.png)
V nasledujúcom okne "Create a New Vivado Project" klikneme na Next >
![](IMAGES/00_Tutorial_02.png)
Otvorí sa okno "Project Name", v ktorom definujeme názov projektu a adresu k miestu jeho uloženia. Po zadaní klikneme na Next >
![](IMAGES/00_Tutorial_03.png)
V nasledujúcom okne "Project Type" klikneme na Next > (bez zmeny zaškrtávacích políčok)
![](IMAGES/00_Tutorial_04.png)
V ďalšom okne "Add Sources" pridávame alebo vytvárame nový zdrojový súbor

Vytvorenie zdrojového súboru (Create File):
![](IMAGES/00_Tutorial_05.png)
![](IMAGES/00_Tutorial_06.png)
Pridanie existujúceho zdrojového súboru (Add Files):
![](IMAGES/00_Tutorial_26.png)
![](IMAGES/00_Tutorial_27.png)
Po vytvorení alebo pridaní súboru klikneme na Next >
![](IMAGES/00_Tutorial_07.png)
To nás presunulo do okna "Add Constraints"

Vytvorenie súboru (Create File):
![](IMAGES/00_Tutorial_08.png)
![](IMAGES/00_Tutorial_09.png)
![](IMAGES/00_Tutorial_10.png)
Pridanie existujúceho súboru (Add Files):
![](IMAGES/00_Tutorial_11.png)
![](IMAGES/00_Tutorial_12.png)
![](IMAGES/00_Tutorial_13.png)
Kliknutie na Next > nás v oboch prípadoch presunie do okna s výberom súčiastky (Default Part)
![](IMAGES/00_Tutorial_14.png)
![](IMAGES/00_Tutorial_15.png)
Potvrdenie výberu stlačením Next > nás presunie do okna so zhrnutím nastavení projektu
![](IMAGES/00_Tutorial_16.png)

### Pridanie súboru v rámci programu
Súbor v rámci projektu pridáme cez File > Add Sources... (Alt + A)
![](IMAGES/00_Tutorial_17.png)
Add or Create Constrains (v ďalších oknách vedie rovnako ako pri vytváraní projektu):
![](IMAGES/00_Tutorial_24.png)
Add or Create Design Sources (v ďalších oknách vedie rovnako ako pri vytváraní projektu):
![](IMAGES/00_Tutorial_23.png)
Add or Create Simulation Sources (Testbench)
![](IMAGES/00_Tutorial_18.png)
![](IMAGES/00_Tutorial_19.png)
![](IMAGES/00_Tutorial_20.png)
### Run Simulation
![](IMAGES/00_Tutorial_21.png)
![](IMAGES/00_Tutorial_22.png)
