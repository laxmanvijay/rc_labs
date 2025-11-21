library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_mod_tb is
end nand_mod_tb;

architecture Behavioral of nand_mod_tb is
    component nand_mod is
        Generic (
            N : integer := 16
        );
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            SW : in STD_LOGIC_VECTOR(15 downto 0);
            led_out : out STD_LOGIC
        );
    end component;
    
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal SW : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal led_out : STD_LOGIC;
    
    constant clk_period : time := 10 ns;
    
    constant N_TEST : integer := 4;  
    
begin
    uut: nand_mod
        generic map (
            N => N_TEST
        )
        port map (
            clk => clk,
            reset => reset,
            SW => SW,
            led_out => led_out
        );
    
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    stim_proc: process
    begin
        report "Test 1: Reset behavior";
        reset <= '1';
        SW <= (others => '1');
        wait for clk_period * 2;
        reset <= '0';
        wait for clk_period;
        
        -- Expected: NAND(0,0,0,0) = NOT(0) = 1
        report "Test 2: All switches OFF";
        SW <= (others => '0');
        wait for clk_period * 3; 
        assert led_out = '1' report "Test 2 failed: Expected led_out = '1'" severity error;
        

        -- Expected: NAND(1,1,1,1) = NOT(1) = 0
        report "Test 3: All N switches ON";
        SW <= (others => '1');
        wait for clk_period * 3;
        assert led_out = '0' report "Test 3 failed: Expected led_out = '0'" severity error;
        

        -- Expected: NAND(0,1,1,1) = NOT(0) = 1
        report "Test 4: One switch OFF";
        SW(0) <= '0';
        SW(15 downto 1) <= (others => '1');
        wait for clk_period * 3;
        assert led_out = '1' report "Test 4 failed: Expected led_out = '1'" severity error;
        

        -- Expected: NAND(1,0,1,0) = NOT(0) = 1
        report "Test 5: Alternating pattern";
        SW(0) <= '1';
        SW(1) <= '0';
        SW(2) <= '1';
        SW(3) <= '0';
        SW(15 downto 4) <= (others => '0');
        wait for clk_period * 3;
        assert led_out = '1' report "Test 5 failed: Expected led_out = '1'" severity error;
        

        -- Set first N=4 switches to '1' and rest to '0'
        report "Test 6: Only first N switches matter";
        SW(3 downto 0) <= "1111";
        SW(15 downto 4) <= (others => '0');
        wait for clk_period * 3;
        assert led_out = '0' report "Test 6 failed: Expected led_out = '0'" severity error;
        
        -- Switches beyond N should not affect output
        SW(3 downto 0) <= "1111";
        SW(15 downto 4) <= (others => '1');  -- These should be ignored
        wait for clk_period * 3;
        assert led_out = '0' report "Test 7 failed: Expected led_out = '0'" severity error;
        
        -- Single bit change propagation
        report "Test 8: Single bit change propagation";
        SW(0) <= '0';  -- Change one bit
        wait for clk_period * 3;
        assert led_out = '1' report "Test 8 failed: Expected led_out = '1'" severity error;
        
        -- Reset during operation
        report "Test 9: Reset during operation";
        SW <= (others => '1');
        wait for clk_period;
        reset <= '1';
        wait for clk_period * 2;
        assert led_out = '0' report "Test 9 failed: Expected led_out = '0' after reset" severity error;
        reset <= '0';
        wait for clk_period;
        
        -- Rapid switching
        report "Test 10: Rapid switching";
        for i in 0 to 5 loop
            SW <= (others => '1');
            wait for clk_period;
            SW <= (others => '0');
            wait for clk_period;
        end loop;
        wait for clk_period * 3;
        
        report "All tests completed!";
        wait;
    end process;

end Behavioral;