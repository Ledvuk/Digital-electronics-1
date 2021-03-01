library ieee;
use ieee.std_logic_1164.all;

entity tb_comparator_2bit is
end entity tb_comparator_2bit;

architecture testbench of tb_comparator_2bit is

    signal s_a       : std_logic_vector(2 - 1 downto 0);
    signal s_b       : std_logic_vector(2 - 1 downto 0);
    signal s_B_greater_A : std_logic;
    signal s_B_equals_A  : std_logic;
    signal s_B_less_A    : std_logic;

begin
    uut_comparator_2bit : entity work.comparator_2bit
        port map(
            a_i           => s_a,
            b_i           => s_b,
            B_greater_A_o => s_B_greater_A,
            B_equals_A_o  => s_B_equals_A,
            B_less_A_o    => s_B_less_A
        );


    p_stimulus : process
    begin

        report "---start---" severity note;
        
        s_b <= "00"; s_a <= "00"; wait for 100 ns;
        s_b <= "00"; s_a <= "01"; wait for 100 ns;
        s_b <= "00"; s_a <= "10"; wait for 100 ns;
        s_b <= "00"; s_a <= "11"; wait for 100 ns;
        s_b <= "01"; s_a <= "00"; wait for 100 ns;
        s_b <= "01"; s_a <= "01"; wait for 100 ns;
        s_b <= "01"; s_a <= "10"; wait for 100 ns;
        s_b <= "01"; s_a <= "11"; wait for 100 ns;
        s_b <= "10"; s_a <= "00"; wait for 100 ns;
        s_b <= "10"; s_a <= "01"; wait for 100 ns;
        s_b <= "10"; s_a <= "10"; wait for 100 ns;
        s_b <= "10"; s_a <= "11"; wait for 100 ns;
        s_b <= "11"; s_a <= "00"; wait for 100 ns; 
        s_b <= "11"; s_a <= "01"; wait for 100 ns;
        s_b <= "11"; s_a <= "10"; wait for 100 ns;
        s_b <= "11"; s_a <= "11"; wait for 100 ns;
        report "---end---" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;