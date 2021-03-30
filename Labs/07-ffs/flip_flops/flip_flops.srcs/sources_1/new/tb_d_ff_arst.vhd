library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_d_ff_arst is
--  Port ( );
end tb_d_ff_arst;

architecture Behavioral of tb_d_ff_arst is

    signal s_clk    : std_logic;
    signal s_arst    : std_logic;
    signal s_d      : std_logic;
    signal s_q      : std_logic;
    signal s_q_bar  : std_logic;

begin
  uut_d_ff_rst : entity work.d_ff_arst 
    port map (
         clk   => s_clk,   
         arst   => s_arst, 
         d     => s_d,  
         q     => s_q,   
         q_bar => s_q_bar
             );

    p_reset_gen : process
    begin
        s_arst <= '0';  wait for 15 ns;
        s_arst <= '1';  wait for 5 ns;
        s_arst <= '0';  wait;
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
    s_d  <= '0';

    assert(s_q = '0')
    report "Error" severity error;
    
    --d sekv
    wait for 25 ns;
    s_d  <= '1';
    wait for 20 ns;
    s_d  <= '0';
    wait for 20 ns;
    s_d  <= '1';
    wait for 20 ns;
    s_d  <= '0';
    --/d sekv
    
    assert(s_q = '0' and s_q_bar = '1')
    report "Error" severity error;
    
    report "Stimulus process finished" severity note;
    wait;
    end process p_stimulus;
end Behavioral;