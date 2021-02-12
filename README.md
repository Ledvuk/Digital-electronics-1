# Digital-electronics-1
## 01-gates
### NAND and NOR function modifications:

1. [EDA demonstration link](https://www.edaplayground.com/x/nVJ6)
2. EDA code:
3.```library ieee;
use ieee.std_logic_1164.all;

entity gates is
    port(
        a_i    : in  std_logic;       
        b_i    : in  std_logic;     
        c_i    : in  std_logic;      
        fun_o  : out std_logic;
        nand_o : out std_logic;  
        nor_o  : out std_logic  
    );
end entity gates;

architecture dataflow of gates is
begin
    fun_o    <= ((not b_i) and a_i)or((not b_i) and (not c_i));
	nand_o <= ((b_i nand b_i)nand a_i)nand((b_i nand b_i) nand (c_i nand c_i));
    nor_o  <= (((a_i nor a_i) nor b_i)nor(c_i nor b_i))nor(((a_i nor a_i) nor b_i)nor(c_i nor b_i));
end architecture dataflow;```
4. Screenshot:

