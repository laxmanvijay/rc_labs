library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity test_rom_sum is
end test_rom_sum;

architecture Behavioral of test_rom_sum is
    
    constant CLK_PERIOD : time := 10 ns;
    constant N_DATA_OUT : integer := 16;
    
    signal clk          : std_logic := '0';
    signal data_out     : std_logic_vector(N_DATA_OUT-1 downto 0);
    signal test_done    : boolean := false;
    
    component rom_sum
        Generic(
            N_DATA_OUT : integer := 16
        );
        Port (
            clk         : in std_logic;
            data_out    : out std_logic_vector(N_DATA_OUT-1 downto 0)
        );
    end component rom_sum;
    
begin

    -- Instantiate the Device Under Test (DUT)
    dut : rom_sum
        generic map(
            N_DATA_OUT => N_DATA_OUT
        )
        port map(
            clk         => clk,
            data_out    => data_out
        );

    -- Clock generation process
    proc_clk : process
    begin
        while not test_done loop
            clk <= '0';
            wait for CLK_PERIOD/2;
            clk <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;

    -- Stimulus and verification process
    proc_test : process
    begin
        -- Wait for initial conditions to settle
        wait for CLK_PERIOD;
        
        -- Cycle 1: rom_addr=0 is set, but rom_data_o is not yet valid
        -- acc = 0 + 0 = 0 (rom_data_o still 0 from initialization)
        wait for CLK_PERIOD;
        assert unsigned(data_out) = 0
            report "Cycle 1: Expected data_out = 0, got " & integer'image(to_integer(unsigned(data_out)))
            severity error;
        
        -- Cycle 2: rom_data_o now has value from address 0 (which is 0)
        -- rom_addr is now 1
        -- acc = 0 + 0 = 0
        wait for CLK_PERIOD;
        assert unsigned(data_out) = 0
            report "Cycle 2: Expected data_out = 0, got " & integer'image(to_integer(unsigned(data_out)))
            severity error;
        
        -- Cycle 3: rom_data_o has value from address 1 (which is 1)
        -- rom_addr is now 2
        -- acc = 0 + 1 = 1
        wait for CLK_PERIOD;
        assert unsigned(data_out) = 1
            report "Cycle 3: Expected data_out = 1, got " & integer'image(to_integer(unsigned(data_out)))
            severity error;
        
        -- Cycle 4: rom_data_o has value from address 2 (which is 2)
        -- rom_addr stays at 2 (last valid address)
        -- acc = 1 + 2 = 3
        wait for CLK_PERIOD;
        assert unsigned(data_out) = 3
            report "Cycle 4: Expected data_out = 3 (sum of 0+1+2), got " & integer'image(to_integer(unsigned(data_out)))
            severity error;
        
        -- Cycle 5: rom_addr stays at 2, rom_data_o still has 2
        -- acc = 3 + 2 = 5
        wait for CLK_PERIOD;
        assert unsigned(data_out) = 5
            report "Cycle 5: Expected data_out = 5, got " & integer'image(to_integer(unsigned(data_out)))
            severity error;
        
        -- Cycle 6: Continuing to accumulate the same value
        wait for CLK_PERIOD;
        assert unsigned(data_out) = 7
            report "Cycle 6: Expected data_out = 7, got " & integer'image(to_integer(unsigned(data_out)))
            severity error;
        
        report "All tests passed successfully!" severity note;
        test_done <= true;
        wait;
    end process;

end Behavioral;