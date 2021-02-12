# Vypracovanie PC_1

## 1. Boolean Postulates:

https://www.edaplayground.com/x/bG6s
```VHDL
--Boolean Postulates
library IEEE;
use IEEE.std_logic_1164.all;

entity gates is
	port(
    	x_i : in std_logic;
        f1_o : out std_logic;
        f2_o : out std_logic;
        f3_o : out std_logic;
        f4_o : out std_logic
    );	
end entity gates;

architecture dataflow of gates is
begin
	f1_o <= x_i and (not x_i);
    f2_o <= x_i or (not x_i);
    f3_o <= x_i or x_i or x_i;
    f4_o <= x_i and x_i and x_i;
    
end architecture dataflow;
```
