library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplexor is
    port (
        x: in std_logic;
        y: in std_logic;
        z: in std_logic;
        interrupcion : in std_logic;
        VF : in std_logic;
        prueba : in std_logic_vector (2 downto 0);
        cc : out std_logic
    );
end entity multiplexor;
architecture behavioral of multiplexor is
    signal qseleccionada : std_logic;
begin
    process (x,y,z,interrupcion,prueba)
    begin
        case prueba is
            when "000" =>
                qseleccionada <= x;
            when "001" =>
                qseleccionada <= y;
            when "010" =>
                qseleccionada <= z;
            when "011" =>
                qseleccionada <= interrupcion;
            when "100" =>
                qseleccionada <= '0';
            when others =>
                qseleccionada <= '0';
        end case;
    end process;
    process (qseleccionada)
    begin
        cc <= qseleccionada xor VF;
    end process;
    
    
    
    
end architecture behavioral;