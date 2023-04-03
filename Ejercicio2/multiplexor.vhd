library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexor is
    port (
        sel : in std_logic;  -- selection input
        in_0 : in std_logic_vector(3 downto 0); -- input 0
        in_1 : in std_logic_vector(3 downto 0); -- input 1
        out_mux : out std_logic_vector(3 downto 0)  -- output
    );
end multiplexor;

architecture Behavioral of multiplexor is
begin

    process (sel, in_0, in_1)
    begin
        if (sel = '1') then
            out_mux <= in_1;
        else
            out_mux <= in_0;
        end if;
    end process;

end Behavioral;