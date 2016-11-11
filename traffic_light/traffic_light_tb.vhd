library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_arith.all;
use     ieee.std_logic_unsigned.all;
use     ieee.numeric_std.all;

library xil_defaultlib;

entity traffic_light_tb is
end traffic_light_tb;

architecture Behavioral of traffic_light_tb is
--	component traffic_light is 
--        Port (reset_i      : in  std_logic;
--              clk_i        : in  std_logic;
--              led_green_o  : out std_logic;
--              led_yellow_o : out std_logic;
--              led_red_o    : out std_logic);
--    end component;

    signal iReset_i : std_logic := '1';
    signal iClock_i : std_logic := '0';

    -- Signals to control lights (no default assignment
    -- as values will be driven by the component)
    signal iGreen_o  : std_logic;
    signal iYellow_o : std_logic;
    signal iRed_o    : std_logic;

begin

    -- Map the entity parameters to the local ones
    tl_instantiation : entity xil_defaultlib.traffic_light
        port map(
            reset_i      => iReset_i,
            clock_i      => iClock_i,
            led_green_o  => iGreen_o,
            led_yellow_o => iYellow_o,
            led_red_o    => iRed_o
        );

    ResetProcess : process
    begin
        iReset_i <= '1';
        -- This wait time must be longer than the clock period,
        -- otherwise it won't trigger anything as we used a synchronus
        -- reset (i.e. it will be detected on the clock rising edge)
        wait for 600 ns;
        iReset_i <= '0';
        wait; -- wait forever (i.e. no signal anymore)
    end process;
    
    -- Generate clock with 10 MHz
    ClockProcess : process
    begin
        loop
            iClock_i <= '0';
            wait for 100 ns;
            iClock_i <= '1';
            wait for 100 ns;
        end loop;
    end process;

end Behavioral;
