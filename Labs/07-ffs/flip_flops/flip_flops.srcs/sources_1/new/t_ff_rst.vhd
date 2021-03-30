
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity t_ff_rst is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           t : in STD_LOGIC;
           q : inout STD_LOGIC;
           q_bar : inout STD_LOGIC);
end t_ff_rst;

architecture Behavioral of t_ff_rst is
    begin
    
    p_t_ff_rst : process (t, rst, clk)                                                        
        begin                                                                                                                                                        
            if rising_edge(clk) then
                if (t = '1') then                                                                   
                    q     <= not q;                                                                    
                    q_bar <= not q_bar;            
                                  
                elsif (rst = '1') then                                                                   
                    q     <= '0';                                                                    
                    q_bar <= '1';  
                end if;                                                                                                                                   
            end if; 
                                                                                         
        end process p_t_ff_rst;
end Behavioral;
