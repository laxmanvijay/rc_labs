library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom_sum is
    Generic (
        N_DATA_OUT : integer := 16
    );
    Port ( 
        clk         : in std_logic;
        data_out    : out std_logic_vector(N_DATA_OUT-1 downto 0)
    );
end rom_sum;

architecture Behavioral of rom_sum is

    -- Constants: ROM-specific
    constant N_ROM_DATA : integer := 3; -- Number of defined data points in ROM
    constant N_ROM_ADDR : integer := 2; -- Number of bits for address line of ROM
 
    -- Definition of the ROM data type
    type rom_t is array(0 to N_ROM_DATA-1) of std_logic_vector(N_DATA_OUT-1 downto 0);
    
    -- Function to initialize the ROM
    function init_rom
        return rom_t is 
        variable tmp : rom_t := (others => (others => '0'));
    begin 
        for addr_pos in 0 to N_ROM_DATA - 1 loop 
            -- Initialize each address with the address itself
            tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, N_DATA_OUT));
        end loop;
        return tmp;
    end init_rom;
    
    -- ROM signals
    signal rom          : rom_t  := init_rom;
    signal rom_data_o   : std_logic_vector(N_DATA_OUT-1 downto 0) := (others=>'0');
    signal rom_addr     : std_logic_vector(N_ROM_ADDR-1 downto 0) := (others=>'0');
    
    -- User signals
    signal sum_reg : unsigned(N_DATA_OUT-1 downto 0) := (others => '0');

begin    
    -- ROM: Do not touch
    -- Mind the delay cycle between assigning the address and 
    -- availability of the data
    proc_rom : process(clk)
    begin
        if rising_edge(clk) then
            rom_data_o <= rom(to_integer(unsigned(rom_addr)));
        end if;
    end process proc_rom;
    
    -- Process for computations
    proc_calc : process(clk)
        variable acc : unsigned(N_DATA_OUT-1 downto 0);
        variable addr_int : integer;
    begin
        if rising_edge(clk) then
            -- Read the rom_data_o which is the data from the previously requested address
            -- accumulate it into acc (variable) and write back to the registered sum_reg.
            acc := sum_reg;
            acc := acc + unsigned(rom_data_o);
            sum_reg <= acc;

            -- Output the current accumulated sum (including the just-added value)
            data_out <= std_logic_vector(acc);

            -- Advance the ROM address until we've requested all entries.
            -- Note: Because rom_data_o becomes valid one cycle after rom_addr is set,
            -- we stop incrementing rom_addr when it has reached the last valid address
            -- (N_ROM_DATA - 1). This ensures we don't drive rom_addr out-of-range.
            addr_int := to_integer(unsigned(rom_addr));
            if addr_int < (N_ROM_DATA - 1) then
                rom_addr <= std_logic_vector(to_unsigned(addr_int + 1, N_ROM_ADDR));
            else
                -- keep rom_addr at last valid address (hold)
                rom_addr <= rom_addr;
            end if;
        end if;
    end process proc_calc;

end Behavioral;
