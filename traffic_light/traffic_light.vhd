library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_arith.all;
use     ieee.std_logic_unsigned.all;
use     ieee.numeric_std.all;

entity traffic_light is
    Port (reset_i      : in  std_logic;
          clock_i      : in  std_logic;
          led_green_o  : out std_logic;
          led_yellow_o : out std_logic;
          led_red_o    : out std_logic);
end traffic_light;

architecture Behavioral of traffic_light is
    -- Define an enumeration with all the possible states
	type tl_state is (yellow_state, green_state, red_state);
    -- Initialize the traffic-light state to yellow
	signal iState : tl_state := yellow_state;

	-- Define constant times for each state
	constant green_time  : integer := 100;
	constant yellow_time : integer := 10;
	constant red_time    : integer := 200;
begin

	process(clock_i)
        variable iCount : integer := 0;
	begin
        -- Magic happens on the rising edge of the clock
        if rising_edge(clock_i) then
            -- Synchronous reset (it's triggered by the clock)
            if reset_i = '1' then
                led_yellow_o <= '1';
                led_green_o  <= '0';
                led_red_o    <= '0';
                iCount       := 0;
            -- If a reset signal doesn't come, go to the
            -- execution of the state machine.
            else
                -- Increment the counter
                iCount := iCount + 1;

                case iState is
                    when green_state =>
                        if iCount = green_time then
                            iState <= yellow_state;
                            -- Send signal outside
                            led_yellow_o <= '1';
                            -- Set the green to '0'
                            led_green_o  <= '0';
                            iCount := 0;
                        end if;

                    when yellow_state =>
                        if iCount = yellow_time then
                            iState <= red_state;
                            -- Send signal outside
                            led_red_o <= '1';
                            -- Set the yellow to '0'
                            led_yellow_o  <= '0';
                            iCount := 0;
                        end if;

                    when red_state =>
                        if iCount = red_time then
                            iState <= green_state;
                            -- Send signal outside
                            led_green_o <= '1';
                            -- Set the red to '0'
                            led_red_o  <= '0';
                            iCount := 0;
                        end if;
                end case;
            end if;
        end if;
    end process;

end Behavioral;
