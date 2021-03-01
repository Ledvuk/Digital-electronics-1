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
