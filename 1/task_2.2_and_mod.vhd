library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_mod is
    Port (
        a         : in  STD_LOGIC;
        b         : in  STD_LOGIC;
        CLK100MHZ : in  STD_LOGIC;
        y         : out STD_LOGIC
    );
end and_mod;

architecture Behavioral of and_mod is
    signal a_reg      : std_logic := '0';
    signal b_reg      : std_logic := '0';
    signal comb_result : std_logic;
    signal y_reg      : std_logic := '0';
begin

    process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            a_reg <= a;
            b_reg <= b;
        end if;
    end process;

    comb_result <= a_reg and b_reg;

    process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            y_reg <= comb_result;
        end if;
    end process;

    y <= y_reg;

end Behavioral;
