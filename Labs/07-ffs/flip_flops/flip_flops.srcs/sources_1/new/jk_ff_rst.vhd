
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity jk_ff_rst is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           j : in STD_LOGIC;
           k : in STD_LOGIC;
           q : inout STD_LOGIC;
           q_bar : inout STD_LOGIC);
end jk_ff_rst;

architecture Behavioral of jk_ff_rst is
    begin
    
    p_jk_ff_rst : process (j, k, rst, clk)                                                        
        begin                                                                                                                                                        
            if rising_edge(clk) then
                if (rst = '1') then                                                                   
                    q     <= '0';                                                                    
                    q_bar <= '1';
                    
                elsif (j = '1' and k = '0') then                                                                   
                    q     <= '1';                                                                    
                    q_bar <= '0';            
                                  
                elsif (j = '0' and k = '1') then                                                                   
                    q     <= '0';                                                                    
                    q_bar <= '1'; 
                elsif (j = '1' and k = '1') then
                    q     <= not q;                                                                    
                    q_bar <= not q_bar;
                end if;                                                                                                                                   
            end if; 
                                                                                         
        end process p_jk_ff_rst;
end Behavioral;