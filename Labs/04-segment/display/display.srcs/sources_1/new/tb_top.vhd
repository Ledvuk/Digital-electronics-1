library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is

    signal s_SW : STD_LOGIC_VECTOR (4 - 1 downto 0); -- Input binary data
    signal s_CA : STD_LOGIC; -- 	Cathod A
    signal s_CB : STD_LOGIC; -- 	Cathod B
    signal s_CC : STD_LOGIC; -- 	Cathod C
    signal s_CD : STD_LOGIC; -- 	Cathod D
    signal s_CE : STD_LOGIC; -- 	Cathod E
    signal s_CF : STD_LOGIC; -- 	Cathod F
    signal s_CG : STD_LOGIC; -- 	Cathod G
        
    signal s_LED : STD_LOGIC_VECTOR (8 - 1 downto 0); -- LED indicators
    signal s_AN  : STD_LOGIC_VECTOR (8 - 1 downto 0); -- Common anode signals to individual displays

begin

    uut_top : entity work.top
        port map(
            SW           => s_SW,
            CA           => s_CA,
            CB           => s_CB,
            CC           => s_CC,
            CD           => s_CD,
            CE           => s_CE,
            CF           => s_CF,
            CG           => s_CG,
            LED          => s_LED,
            AN           => s_AN
        );

p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;

        s_SW <= "0000"; wait for 100 ns;
        
        s_SW <= "0001"; wait for 100 ns;
        
        s_SW <= "0010"; wait for 100 ns;
        
        s_SW <= "0011"; wait for 100 ns;
        
        s_SW <= "0100"; wait for 100 ns;
       
        s_SW <= "0101"; wait for 100 ns;
        
        s_SW <= "0110"; wait for 100 ns;
        
        s_SW <= "0111"; wait for 100 ns;
        
        s_SW <= "1000"; wait for 100 ns;
        
        s_SW <= "1001"; wait for 100 ns;
        
        s_SW <= "1010"; wait for 100 ns;
        
        s_SW <= "1011"; wait for 100 ns;
        
        s_SW <= "1100"; wait for 100 ns;
        
        s_SW <= "1101"; wait for 100 ns;
        
        s_SW <= "1110"; wait for 100 ns;
        
        s_SW <= "1111"; wait for 100 ns;

        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end Behavioral;
