library ieee;
use ieee.std_logic_1164.all;

entity tb_cnt_up_down is
end entity tb_cnt_up_down; 

architecture testbench of tb_cnt_up_down is

    constant c_CNT_WIDTH         : natural := 5;
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_en         : std_logic;
    signal s_cnt_up     : std_logic;
    signal s_cnt        : std_logic_vector(c_CNT_WIDTH - 1 downto 0);

begin

    uut_cnt : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH  => c_CNT_WIDTH
        )
        port map(
            clk         => s_clk_100MHz,
            reset       => s_reset,
            en_i        => s_en,
            cnt_up_i    => s_cnt_up,
            cnt_o       => s_cnt
        );

    p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

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

end architecture testbench;
