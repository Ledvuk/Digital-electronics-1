# Digital-electronics-1 Matej Ledvina (221339)
[Link to my github](https://github.com/Ledvuk/Digital-electronics-1/)
## 03-vivado
### Nexis board connections:
![alt text](link here)

### 2 bit 4to1 multiplexer:

1. design.vhd:

```vhdl
library ieee;
use ieee.std_logic_1164.all;


entity mux_2bit_4to1 is
    port(
		a_i			: in  std_logic_vector(2 - 1 downto 0);
        	b_i			: in  std_logic_vector(2 - 1 downto 0);
       		c_i			: in  std_logic_vector(2 - 1 downto 0);
        	d_i			: in  std_logic_vector(2 - 1 downto 0);
 		sel_i			: in  std_logic_vector(2 - 1 downto 0);
 		f_o             	: out std_logic_vector(2 - 1 downto 0)
    );
end entity mux_2bit_4to1;

architecture Behavioral of mux_2bit_4to1 is
begin
	f_o     <= a_i when (sel_i = "00") else
	           b_i when (sel_i = "01") else
	           c_i when (sel_i = "10") else
	           d_i when (sel_i = "11");


end architecture Behavioral;
```

2. testbench.vhd:
```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity tb_comparator_2bit is
end entity tb_comparator_2bit;

architecture testbench of tb_comparator_2bit is

    signal s_a       : std_logic_vector(2 - 1 downto 0);
    signal s_b       : std_logic_vector(2 - 1 downto 0);
    signal s_c       : std_logic_vector(2 - 1 downto 0);
    signal s_d       : std_logic_vector(2 - 1 downto 0);
    signal s_sel     : std_logic_vector(2 - 1 downto 0);
    signal s_f       : std_logic_vector(2 - 1 downto 0);
begin
    uut_mux_2bit_4to1 : entity work.mux_2bit_4to1
        port map(
            a_i           => s_a,
            b_i           => s_b,
            c_i           => s_c,
            d_i           => s_d,
            sel_i         => s_sel,
            f_o           => s_f
        );


    p_stimulus : process
    begin    
        s_a <= "00";  s_b <= "01"; s_c <= "10";s_d <= "11"; s_sel <= "00"; wait for 250 ns;
        s_sel <= "01"; wait for 250 ns;
        s_sel <= "10"; wait for 250 ns;
        s_sel <= "11"; wait for 250 ns;
        wait;
    end process p_stimulus;

end architecture testbench;
```
3. simulation output:
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/03-vivado/sim1.png)

