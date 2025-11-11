library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity and_mod is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           clk : in STD_LOGIC;
           y : out STD_LOGIC);
end and_mod;

architecture Behavioral of and_mod is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            y <= a AND b;
        end if;
    end process;
    
end Behavioral;