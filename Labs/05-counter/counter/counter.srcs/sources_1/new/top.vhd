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