library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_and_mod is

end tb_and_mod;

architecture Behavioral of tb_and_mod is
    
    constant CLK_PERIOD : time := 10 ns;
    signal CLK100MHZ          : std_logic := '0';
    signal a            : std_logic := '0';
    signal b            : std_logic := '0';
    signal y            : std_logic;
    
    component and_mod
        Port (
            a   : in STD_LOGIC;
            b   : in STD_LOGIC;
            CLK100MHZ : in STD_LOGIC;
            y   : out STD_LOGIC
        );
    end component and_mod;
    
begin

    dut : and_mod
        port map(
            a   => a,
            b   => b,
            CLK100MHZ => CLK100MHZ,
            y   => y
        );

    proc_clk : process
    begin
        CLK100MHZ <= '0';
        wait for CLK_PERIOD/2;
        CLK100MHZ <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    
    proc_stimuli : process
    begin
        -- Test all combinations of inputs
        
        -- Test case 1: a=0, b=0
        a <= '0';
        b <= '0';
        wait for CLK_PERIOD * 3;
        
        -- Test case 2: a=0, b=1
        a <= '0';
        b <= '1';
        wait for CLK_PERIOD * 3;
        
        -- Test case 3: a=1, b=0
        a <= '1';
        b <= '0';
        wait for CLK_PERIOD * 3;
        
        -- Test case 4: a=1, b=1
        a <= '1';
        b <= '1';
        wait for CLK_PERIOD * 3;
        
        -- End simulation
        wait;
    end process;
    
end Behavioral;