library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
    Port ( SW : in STD_LOGIC_VECTOR;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           LED : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

begin
hex2seg : entity work.hex_7seg
        port map(
            hex_i    => SW,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    -- Connect one common anode to 3.3V
    AN <= b"1111_0111";
    -- Display input value on LEDs
    LED(3 downto 0) <= SW;
    -- LED(7:4) indicators
    -- Turn LED(4) on if input value is equal to 0, ie "0000"
    -- WRITE YOUR CODE HERE
    LED(4)  <='1'when (SW ="0000") else'0';
    -- Turn LED(5) on if input value is greater than "1001", ie 9
    -- WRITE YOUR CODE HERE
    LED(5)  <='1'when (SW >"1001") else'0';   
    -- Turn LED(6) on if input value is odd, ie 1, 3, 5, ...
    -- WRITE YOUR CODE HERE
    LED(6)  <='1'when (SW ="0001" or SW ="0011" or SW ="0101" or SW ="0111" or SW ="1111");
    -- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8
    -- WRITE YOUR CODE HERE
    LED(7)  <='1'when (SW ="0001"or SW ="0010"or SW ="0100"or SW ="1000") else '0';
end Behavioral;
