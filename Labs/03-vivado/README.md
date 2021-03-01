# Digital-electronics-1 Matej Ledvina (221339)
[Link to my github](https://github.com/Ledvuk/Digital-electronics-1/)
## 03-vivado
### Nexis board connections:

| FPGA pin | component | FPGA pin | component |
| --------:|:--------- | --------:|:--------- |
|H17|LED0|J15|SW0|
|K15|LED1|L16|SW1|
|J13|LED2|M13|SW2|
|N14|LED3|R15|SW3|
|R18|LED4|R17|SW4|
|V17|LED5|T18|SW5|
|U17|LED6|U18|SW6|
|U16|LED7|R13|SW7|
|V16|LED8|T8|SW8|
|T15|LED9|U8|SW9|
|U14|LED10|R16|SW10|
|T16|LED11|T13|SW11|
|V15|LED12|H6|SW12|
|V14|LED13|U12|SW13|
|V12|LED14|U11|SW14|
|V11|LED15|V10|SW15|

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
       s_a <= "00";  s_b <= "01"; s_c <= "10";s_d <= "11"; s_sel <= "00"; wait for 125 ns;
        s_sel <= "01"; wait for 125 ns;
        s_sel <= "10"; wait for 125 ns;
        s_sel <= "11"; wait for 125 ns;
        s_a <= "11";  s_b <= "10"; s_c <= "01";s_d <= "00"; s_sel <= "00"; wait for 125 ns;
        s_sel <= "01"; wait for 125 ns;
        s_sel <= "10"; wait for 125 ns;
        s_sel <= "11"; wait for 125 ns;
        wait;
    end process p_stimulus;

end architecture testbench;
```
3. simulation output:
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/03-vivado/sim1.png)

