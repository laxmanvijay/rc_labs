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

    ----------------------------------------------------------------
    -- Clock generator (free-running)
    ----------------------------------------------------------------
    proc_clk : process
    begin
        loop
            CLK100MHZ <= '0';
            wait for CLK_PERIOD/2;
            CLK100MHZ <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    ----------------------------------------------------------------
    -- Stimulus: systematic tests + intra-period toggles to show sampling
    ----------------------------------------------------------------
    proc_stimuli : process
    begin
        -- allow some initial clocks for stable power-up
        wait for CLK_PERIOD * 3;

        ----------------------------------------------------------------
        -- TEST GROUP A: Regular stable inputs (checks basic functionality)
        -- Note: because inputs are registered and output is registered,
        -- y will reflect the AND of the inputs sampled at the previous
        -- rising edge (one-clock latency).
        ----------------------------------------------------------------

        -- Test case 1: a=0, b=0
        a <= '0';
        b <= '0';
        wait for CLK_PERIOD * 2; -- wait two clocks and then inspect y

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
        -- We'll toggle inputs several times inside a single clock period
        -- before the rising edge and show 'y' only updates at the edge.
        ----------------------------------------------------------------

        -- Make sure we start with known stable values
        a <= '0';
        b <= '0';
        wait for CLK_PERIOD; -- align to a clock boundary

        -- Rapid toggles inside one clock period (before the next rising edge)
        -- These changes should NOT directly determine 'y' until the next rising edge samples them.
        a <= '1';
        b <= '0';
        wait for 1 ns;
        a <= '0';
        wait for 1 ns;
        b <= '1';
        wait for 1 ns;
        a <= '1';
        wait for 1 ns;
        -- now wait until the next rising edge to let DUT sample a/b
        wait for CLK_PERIOD;  -- wait to pass the rising edge that does the sampling
        -- Because the DUT has output register, y will update at the following rising edge.
        wait for CLK_PERIOD;  -- wait one extra clock so y has the registered result

        -- Another rapid toggle example where final values before rising edge are (a='0', b='1')
        a <= '1'; b <= '1';
        wait for 2 ns;
        a <= '0'; -- final value before rising edge
        wait for 4 ns;
        b <= '1'; -- keep b=1
        wait for CLK_PERIOD;  -- let sampling happen
        wait for CLK_PERIOD;  -- allow y to reflect sampled value

        ----------------------------------------------------------------
        -- End simulation
        ----------------------------------------------------------------
        wait;
    end process;

end Behavioral;
