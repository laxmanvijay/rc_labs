library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_template is

end tb_template;

architecture Behavioral of tb_template is
    
    constant CLK_PERIOD : time := 10 ns;
    signal clk          : std_logic;
    
    component enter_your_entity_name_here
        Port (
            -- Enter your ports here
        );
    end component enter_your_entity_name_here;
    
begin

    dut : enter_your_entity_name_here
        port map(
            entity_port => signal
        );

    proc_clk : process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    
    proc_stimuli : process
    begin
        -- ADD your stimuli here
    end process;
    
end Behavioral;