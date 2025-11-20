library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_and_mod is
end tb_and_mod;

architecture Behavioral of tb_and_mod is

    constant CLK_PERIOD : time := 10 ns; -- 100 MHz
    signal CLK100MHZ    : std_logic := '0';
    signal a            : std_logic := '0';
    signal b            : std_logic := '0';
    signal y            : std_logic;

    component and_mod
        Port (
            a   : in  STD_LOGIC;
            b   : in  STD_LOGIC;
            CLK100MHZ : in  STD_LOGIC;
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
        loop
            CLK100MHZ <= '0';
            wait for CLK_PERIOD/2;
            CLK100MHZ <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    proc_stimuli : process
    begin
        wait for CLK_PERIOD * 3;

        ----------------------------------------------------------------
        -- TEST GROUP A: Regular stable inputs (checks basic functionality)
        ----------------------------------------------------------------

        -- Test case 1: a=0, b=0
        a <= '0';
        b <= '0';
        wait for CLK_PERIOD * 2;

        -- Test case 2: a=0, b=1
        a <= '0';
        b <= '1';
        wait for CLK_PERIOD * 2;

        -- Test case 3: a=1, b=0
        a <= '1';
        b <= '0';
        wait for CLK_PERIOD * 2;

        -- Test case 4: a=1, b=1
        a <= '1';
        b <= '1';
        wait for CLK_PERIOD * 2;

        ----------------------------------------------------------------
        -- TEST GROUP B: Intra-period toggles to demonstrate input sampling
        ----------------------------------------------------------------

        a <= '0';
        b <= '0';
        wait for CLK_PERIOD;

        -- Rapid toggles inside one clock period (before the next rising edge)
        a <= '1';
        b <= '0';
        wait for 1 ns;
        a <= '0';
        wait for 1 ns;
        b <= '1';
        wait for 1 ns;
        a <= '1';
        wait for 1 ns;
        wait for CLK_PERIOD;  -- wait to pass the rising edge that does the sampling
        wait for CLK_PERIOD;  -- wait one extra clock so y has the registered result

        a <= '1'; b <= '1';
        wait for 2 ns;
        a <= '0'; -- final value before rising edge
        wait for 4 ns;
        b <= '1'; -- keep b=1
        wait for CLK_PERIOD;  -- let sampling happen
        wait for CLK_PERIOD;  -- allow y to reflect sampled value

        wait;
    end process;

end Behavioral;
