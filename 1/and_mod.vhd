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
    signal a_reg : STD_LOGIC;
    signal b_reg : STD_LOGIC;
    signal y_internal : STD_LOGIC;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            a_reg <= a;
            b_reg <= b;
            
            y_internal <= a_reg and b_reg;
            
            y <= y_internal;
        end if;
    end process;
    
end Behavioral;