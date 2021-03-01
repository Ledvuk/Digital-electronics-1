library ieee;
use ieee.std_logic_1164.all;


entity comparator_2bit is
    port(
		a_i				: in  std_logic_vector(2 - 1 downto 0);
        b_i				: in  std_logic_vector(2 - 1 downto 0);
 
 		B_less_A_o		: out std_logic;
        B_equals_A_o	: out std_logic;
        B_greater_A_o 	: out std_logic  
    );
end entity comparator_2bit;


architecture Behavioral of comparator_2bit is
begin
	B_less_A_o		<= '1' when (b_i < a_i) else '0';
    B_equals_A_o		<= '1' when (b_i = a_i) else '0';
    B_greater_A_o	<= '1' when (b_i > a_i) else '0';


end architecture Behavioral;