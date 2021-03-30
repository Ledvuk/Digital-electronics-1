library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_t_ff_rst is
--  Port ( );
end tb_t_ff_rst;

architecture Behavioral of tb_t_ff_rst is

    signal s_clk    : std_logic;
    signal s_rst    : std_logic;
    signal s_t      : std_logic;
    signal s_q      : std_logic;
    signal s_q_bar  : std_logic;

begin
  uut_t_ff_rst : entity work.t_ff_rst 
    port map (
         clk   => s_clk,   
         rst   => s_rst, 
         t     => s_t,  
         q     => s_q,   
         q_bar => s_q_bar
             );

    p_reset_gen : process
    begin
        s_rst <= '0';  wait for 5 ns;
        s_rst <= '1';  wait for 10 ns;
        s_rst <= '0';  wait;
    end process p_reset_gen;
    
     p_clock_gen : process
    begin
        s_clk <= '0';  wait for 10 ns;
        s_clk <= '1';  wait for 10 ns;
        s_clk <= '0';  wait for 10 ns;
        s_clk <= '1';  wait for 10 ns;
        s_clk <= '0';  wait for 10 ns;
        s_clk <= '1';  wait for 10 ns;
        s_clk <= '0';  wait for 10 ns;
        s_clk <= '1';  wait for 10 ns;
        s_clk <= '0';  wait for 10 ns;
        s_clk <= '1';  wait for 10 ns;
        s_clk <= '0';  wait for 10 ns;
        s_clk <= '1';  wait;
    end process p_clock_gen;
    
    p_stimulus  : process
    begin
    report "Stimulus process started" severity note;
    s_t  <= '0';

    assert(s_q = '0')
    report "Error" severity error;
    
    --d sekv
    wait for 25 ns;
    s_t  <= '1';
    wait for 10 ns;
    s_t  <= '0';
    wait for 10 ns;
    s_t  <= '1';
    wait for 10 ns;
    s_t  <= '0';
    wait for 10 ns;
    s_t  <= '1';
    wait for 10 ns;
    s_t  <= '0';
    --/t sekv
    
    assert(s_q = '0' and s_q_bar = '1')
    report "Error" severity error;
    
    report "Stimulus process finished" severity note;
    wait;
    end process p_stimulus;
end Behavioral;