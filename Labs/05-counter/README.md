# Digital-electronics-1 Matej Ledvina (221339)
[Link to my github](https://github.com/Ledvuk/Digital-electronics-1/)
## 05-counter
### Prepartion:
1. FPGA Buttons:

2. Clock period conversion table:

|**Time**| **Clock periods** | **Clocl periods (HEX)** | **Clock periods (BIN)** |
| :-: | :-: | :-: | :-: |
| 2ms | 200 000 | ``` x"3_0d40" ``` | ``` b"0011_0000_1101_0100_0000" ``` |
| 4ms | 400 000 | ``` x"6_1A80" ``` | ``` b"0110_0001_1010_1000_0000" ``` | 
| 10ms | 1 000 000 | ``` x"F_4240"  ``` | ``` b"1111_0100_0010_0100_0000" ``` |
| 250ms | 25 000 000 | ``` x"17D_7840" ``` | ``` b"0001_0111_1101_0111_1000_0100_0000"  ``` |
| 500ms | 50 000 000 | ```  x"2FA_F080" ``` | ``` b"0010_1111_1010_1111_0000_1000_0000"  ``` |
| 1s | 100 000 000 | ``` x"5F5_E100"  ``` | ``` b"0101_1111_0101_1110_0001_0000_0000"  ``` | 

### Bidirectional counter:

1. design code:

```vhdl

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cnt_up_down is
    generic(
        g_CNT_WIDTH : natural := 4      -- Number of bits for counter
    );
    port(
        clk         : in  std_logic;       -- Main clock
        reset       : in  std_logic;       -- Synchronous reset
        en_i        : in  std_logic;       -- Enable input
        cnt_up_i    : in  std_logic;       -- Direction of the counter up
        cnt_o       : out std_logic_vector(g_CNT_WIDTH - 1 downto 0)
    );
end entity cnt_up_down;

architecture behavioral of cnt_up_down is

    -- Local counter
    signal s_cnt_local : unsigned(g_CNT_WIDTH - 1 downto 0);

begin
    p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then
        
            if (reset = '1') then               -- Synchronous reset
                s_cnt_local <= (others => '0'); -- Clear all bits

            elsif (en_i = '1') then       -- Test if counter is enabled

                if (cnt_up_i = '1') then
                    s_cnt_local <= s_cnt_local + 1;

                elsif (cnt_up_i = '0') then
                    s_cnt_local <= s_cnt_local - 1;
                end if;
            end if;
        end if;
    end process p_cnt_up_down;

    cnt_o <= std_logic_vector(s_cnt_local);

end architecture behavioral;

```

2. testbench code:

```vhdl
 p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 12 ns;
        
        -- Reset activated
        s_reset <= '1';
        wait for 73 ns;

        s_reset <= '0';
        wait;
    end process p_reset_gen;

    p_stimulus : process
    begin
        report "Stimulus process started" severity note;


        s_en     <= '1';
        
        s_cnt_up    <= '1';
        wait for 300 ns;
        s_cnt_up    <= '0';
        wait for 220 ns;
        s_cnt_up    <= '1';
        wait for 80 ns;
        s_en     <= '0';

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

```
3. simulation screenshot:
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/05-counter/snap2.png)


###Top level

1. Code:

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( CLK100MHZ : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           SW : in STD_LOGIC;
           LED : in STD_LOGIC_VECTOR (3 downto 0);
           CA : in STD_LOGIC;
           CB : in STD_LOGIC;
           CC : in STD_LOGIC;
           CD : in STD_LOGIC;
           CE : in STD_LOGIC;
           CF : in STD_LOGIC;
           CG : in STD_LOGIC;
           AN : in STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal counter
    signal s_cnt : std_logic_vector(4 - 1 downto 0);

begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX : natural := 10       -- Number of clk pulses to generate
        );
        port map(
            clk   : in  std_logic;      -- Main clock
            reset : in  std_logic;      -- Synchronous reset
            ce_o  : out std_logic       -- Clock enable pulse signal
        );

    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH : natural := 4      -- Number of bits for counter
        );
        port map(
            clk         : in  std_logic;       -- Main clock
            reset       : in  std_logic;       -- Synchronous reset
            en_i        : in  std_logic;       -- Enable input
            cnt_up_i    : in  std_logic;       -- Direction of the counter up
            cnt_o       : out std_logic_vector(g_CNT_WIDTH - 1 downto 0)
        );

    -- Display input value on LEDs
    LED(3 downto 0) <= s_cnt;

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => s_cnt,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    -- Connect one common anode to 3.3V
    AN <= b"1111_1110";

end architecture Behavioral;

```


2. block diagram (with 16 bit couter):
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/05-counter/block.png)
