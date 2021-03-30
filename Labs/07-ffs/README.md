# Digital-electronics-1 Matej Ledvina (221339)
[Link to my github](https://github.com/Ledvuk/Digital-electronics-1/)
## 07-ffs
### Prepartion:

| **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 |  |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 0 |  |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 |  |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 1 |  |

   | **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | 0 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 1 | 1 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 0 | 0 |  |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 1 | 0 |  |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 0 | 1 |  |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | 1 |  |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 0 | 1 |  |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 1 | 0 |  |

   | **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 |  |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 1 |  |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 |  |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 0 |  |

### d_latch:

1. design code:

```vhdl

    p_d_latch : process (d, arst, en)                                                        
    begin                                                                                    
        if (arst = '1') then                                                                 
            q     <= '0';                                                                    
            q_bar <= '1';
                                                                                
        elsif (en = '1') then                                                               
            q     <= d;                                                                          
            q_bar <= not d;                                                                          
        end if;                                                                              
    end process p_d_latch;                                                                   

```

2. testbench code:

```vhdl
p_reset_gen : process
    begin
        s_arst <= '0';  wait for 10 ns;
        s_arst <= '1';  wait for 50 ns;
        s_arst <= '0';  wait;
    end process p_reset_gen;

    p_stimulus  : process
    begin
    report "Stimulus process started" severity note;
    s_d  <= '0';
    s_en <= '0';
    
    assert(s_q = '0')
    report "Error" severity error;
    
    --d sekv
    wait for 10 ns;
    s_d  <= '1';
    wait for 10 ns;
    s_d  <= '0';
    wait for 10 ns;
    s_d  <= '1';
    wait for 10 ns;
    s_d  <= '0';
    wait for 10 ns;
    s_d  <= '1';
    wait for 10 ns;
    s_d  <= '0';
    --/d sekv
    
    assert(s_q = '0' and s_q_bar = '1')
    report "Error" severity error;
    
    s_en <= '1';
    
    --d sekv
    wait for 10 ns;
    s_d  <= '1';
    wait for 10 ns;
    s_d  <= '0';
    wait for 10 ns;
    s_d  <= '1';
    wait for 10 ns;
    s_d  <= '0';
    wait for 10 ns;
    s_d  <= '1';
    wait for 10 ns;
    s_en  <= '0';  -- en to 0
    wait for 200 ns;
    s_d  <= '0';    
    --/d sekv
    
    --d sekv
    wait for 10 ns;
    s_d  <= '1';
    wait for 10 ns;
    s_d  <= '0';
    wait for 10 ns;
    s_d  <= '1';
    wait for 10 ns;
    s_d  <= '0';
    wait for 10 ns;
    s_d  <= '1';
    wait for 10 ns;
    s_d  <= '0';
    --/d sekv
    
    report "Stimulus process finished" severity note;
    wait;
    end process p_stimulus;

```
3. simulation screenshot:
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/07-ffs/snap1.png)


###Flip-flops

1. p_d_ff_arst

```vhdl
p_d_ff_arst : process (d, arst, clk)                                                        
        begin                                                                                    
            if (arst = '1') then                                                                 
                q     <= '0';                                                                    
                q_bar <= '1';
                                                                                
            elsif rising_edge(clk) then                                                               
                q     <= d;                                                                          
                q_bar <= not d;                                                                          
            end if;                                                                              
        end process p_d_ff_arst;
end Behavioral;

```

2. p_d_ff_rst

```vhdl
p_d_ff_rst : process (d, rst, clk)                                                        
        begin                                                                                                                                                        
            if rising_edge(clk) then
                q     <= d;                                                                          
                q_bar <= not d;
                
                if (rst = '1') then                                                                   
                    q     <= '0';                                                                    
                    q_bar <= '1';  
                end if;                                                                                                                                   
            end if; 
                                                                                         
        end process p_d_ff_rst;
```

3. p_t_ff_rst

```vhdl
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
```

4. p_jk_ff_rst

```vhdl
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
```

5. p_d_ff_arst testbench

```vhdl
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
```

6. p_d_ff_rst testbench

```vhdl
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
```

7. p_t_ff_rst testbench

```vhdl
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
```

8. p_jk_ff_rst testbench

```vhdl
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
    s_j  <= '0';
    s_k  <= '0';

    assert(s_q = '0')
    report "Error" severity error;

    --d sekv
    wait for 25 ns;
    s_j  <= '1';
    s_k  <= '0';
    wait for 10 ns;
    s_j  <= '0';
    s_k  <= '1';
    wait for 10 ns;
    s_j  <= '1';
    s_k  <= '1';
    wait for 10 ns;
    s_j  <= '1';
    s_k  <= '1';
    wait for 10 ns;
    
    
    assert(s_q = '0' and s_q_bar = '1')
    report "Error" severity error;
    
    report "Stimulus process finished" severity note;
    wait;
    end process p_stimulus;
```
10. p_d_ff_arst simulation
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/07-ffs/d_arst.png)

11. p_d_ff_rst simulation
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/07-ffs/d_rset.png)

12. p_t_ff_rst simulation
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/07-ffs/t_rst.png)

13. p_jk_ff_rst simulation
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/07-ffs/jk_rst.png)

### shift register:

1. Block diagram:

![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/07-ffs/sch.jpg)
