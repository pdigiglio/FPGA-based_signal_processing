library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_arith.all;
use     ieee.std_logic_unsigned.all;

library xil_defaultlib;

entity Behavior is
end entity Behavior;

architecture Behavior_arch of Behavior is
--    component cnt4 is -- Do I have to repeat the entity definition?
--        port(reset_i : in  std_logic;
--             clock_i : in  std_logic;
--             count_o : out std_logic_vector(3 downto 0)
--        );
--    end component;

    signal iReset_i : std_logic;
    signal iClock_i : std_logic;
    signal iCount_o : std_logic_vector(3 downto 0);
begin

    -- Map the entity parameters to the local ones
    cnt4_instantiation : entity xil_defaultlib.cnt4
        port map(
            reset_i => iReset_i,
            clock_i => iClock_i,
            count_o => iCount_o
        );

    -- One-time reset signal
    reset_process : process
    begin
        iReset_i <= '1';
        wait for 400 ns;
        iReset_i <= '0';
        wait; -- forever
    end process;

    -- Periodic clock at 250 MHz
    clock_process : process
    begin
        loop
            iClock_i <= '0';
            wait for 25 ns;
            iClock_i <= '1';
            wait for 25 ns;
        end loop;
    end process;

end Behavior_arch;
