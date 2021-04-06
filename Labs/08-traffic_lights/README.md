# Digital-electronics-1 Matej Ledvina (221339)
[Link to my github](https://github.com/Ledvuk/Digital-electronics-1/)
## 08-traffic_lights
### Prepartion:
1. State table

| **Input P** | `0` | `0` | `1` | `1` | `0` | `1` | `0` | `1` | `1` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| :-- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **Clock** | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) |
| **State** | A | A | B | C | C | D | A | B | C | D | B | B | B | C | D | B |
| **Output R** | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `1` | `0` |

2. Nexys board connections:

| **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |

![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/08-traffic_lights/cons.png)

### Traffic controller:

1. State diagram:
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/08-traffic_lights/diagram1.jpg)

2. p_traffic_fsm process:

```vhdl
p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_GO =>
                        if(s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt +1;
                        else
                            s_state <= WEST_WAIT;
                            s_cnt <= c_ZERO;
                        end if;

                    when WEST_WAIT =>
                        if(s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= STOP2;
                            s_cnt <= c_ZERO;
                        end if;
                    
                    when STOP2 =>
                        if(s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SOUTH_GO;
                            s_cnt <= c_ZERO;
                        end if;
                    
                    when SOUTH_GO =>
                        if(s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SOUTH_WAIT;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when SOUTH_WAIT =>
                        if(s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= STOP1;
                            s_cnt <= c_ZERO;
                        end if;
                                 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_traffic_fsm;
```

3. p_output_fsm process:

```vhdl
p_output_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>
                south_o <= "100";
                west_o  <= "100";
                
            when WEST_GO =>
                south_o <= "100";
                west_o  <= "010";
                
            when WEST_WAIT =>
                south_o <= "100";
                west_o  <= "110";
                
            when STOP2 =>
                south_o <= "100";
                west_o  <= "100";
                
            when SOUTH_GO =>
                south_o <= "010";
                west_o  <= "100";

            when SOUTH_WAIT =>
                south_o <= "110";
                west_o  <= "100";   

            when others =>
                south_o <= "100";
                west_o  <= "100";
        end case;
    end process p_output_fsm;
```
4. simulation screenshot:
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/08-traffic_lights/snap1.png)


###Smart traffic controller:

1. State table:
| Current state | Direction South | Direction West | Delay |    No Cars:    |    Cars to West     |    Cars to South     |         Cars to both        |
| :-----------: | :-------------: | :------------: | ----- | :------------: | :-----------------: | :------------------: | :-------------------------: |
|    `STOP1`    |       red       |      red       | 1 sec |   `WEST_GO`    |      `WEST_GO`      |      `SOUTH_GO`      |          `WEST_GO`          |
|   `WEST_GO`   |       red       |     green      | 4 sec |   `WEST_GO`    |      `WEST_GO`      |     `WEST_WAIT`      |         `WEST_WAIT`         |
|  `WEST_WAIT`  |       red       |     yellow     | 2 sec |    `STOP2`     |       `STOP2`       |       `STOP2`        |           `STOP2`           |
|    `STOP2`    |       red       |      red       | 1 sec |   `SOUTH_GO`   |      `WEST_GO`      |      `SOUTH_GO`      |         `SOUTH_GO`          |
|  `SOUTH_GO`   |      green      |      red       | 4 sec |   `SOUTH_GO`   |    `SOUTH_WAIT`     |      `SOUTH_GO`      |        `SOUTH_WAIT`         |
| `SOUTH_WAIT`  |     yellow      |      red       | 2 sec |    `STOP1`     |       `STOP1`       |       `STOP1`        |           `STOP1`           |

2. State diagram:
![alt text](https://github.com/Ledvuk/Digital-electronics-1/blob/main/Labs/08-traffic_lights/diagram2.jpg)
