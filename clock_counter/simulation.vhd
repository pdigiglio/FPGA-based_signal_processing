library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_arith.all;
use     ieee.std_logic_unsigned.all;

entity cnt4 is
    port(reset_i : in  std_logic;
         clock_i : in  std_logic;
         count_o : out std_logic_vector(3 downto 0)
    );
end entity cnt4;

architecture cnt4_arch of cnt4 is
    signal iCount_o : std_logic_vector(3 downto 0);
begin

    process(clock_i, reset_i) -- sensitivity list
    begin
        if reset_i = '1' then -- asynchronus reset
            iCount_o <= "0000";
        elsif clock_i'event and clock_i = '1' then -- on the risng edge
            iCount_o <= iCount_o + 1; 
        end if;

        -- Output the value
        count_o <= iCount_o;
    end process;
end cnt4_arch;
