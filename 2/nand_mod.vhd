library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_mod is
    Generic (
        N : integer := 7
    );
    Port (
        CLK100MHZ : in STD_LOGIC;
        reset : in STD_LOGIC;
        SW : in STD_LOGIC_VECTOR(15 downto 0);
        led_out : out STD_LOGIC
    );
end nand_mod;

architecture Behavioral of nand_mod is
    signal SW_reg : STD_LOGIC_VECTOR(15 downto 0);
    signal and_result : STD_LOGIC;
    signal led_reg : STD_LOGIC;
    
begin
    process(CLK100MHZ, reset)
    begin
        if reset = '1' then
            SW_reg <= (others => '0');
        elsif rising_edge(CLK100MHZ) then
            SW_reg <= SW;
        end if;
    end process;
    
    process(SW_reg)
        variable temp_and : STD_LOGIC;
    begin
        temp_and := '1';
        for i in 0 to N-1 loop
            temp_and := temp_and and SW_reg(i);
        end loop;
        and_result <= temp_and;
    end process;
    
    process(CLK100MHZ, reset)
    begin
        if reset = '1' then
            led_reg <= '0';
        elsif rising_edge(CLK100MHZ) then
            led_reg <= not and_result;
        end if;
    end process;
    
    led_out <= led_reg;

end Behavioral;