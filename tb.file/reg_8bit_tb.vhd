library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_8bit_tb is
end reg_8bit_tb;

architecture Behavior of reg_8bit_tb is

    component reg_8bit
        Port ( d    : in  STD_LOGIC_VECTOR (7 downto 0);
               load : in  STD_LOGIC;
               clk  : in  STD_LOGIC;
               rst  : in  STD_LOGIC;
               q    : out STD_LOGIC_VECTOR (7 downto 0) );
    end component;

    signal d    : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal load : STD_LOGIC := '0';
    signal clk  : STD_LOGIC := '0';
    signal rst  : STD_LOGIC := '1'; -- Initial Reset
    signal q    : STD_LOGIC_VECTOR(7 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: reg_8bit port map (
        d    => d,
        load => load,
        clk  => clk,
        rst  => rst,
        q    => q
    );

    -- Clock Process
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Hold Reset at 0ns for proper initialization
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;

        -- Test 1: Apply input "10101010" (AA in Hex), load = 0 -> q should stay 00000000
        d <= "10101010"; load <= '0';
        wait for 20 ns;

        -- Test 2: Set load = 1 -> q should become "10101010"
        load <= '1';
        wait for 20 ns;

        -- Test 3: Change input to "11110000", but load = 0 -> q should retain "10101010"
        d <= "11110000"; load <= '0';
        wait for 20 ns;

        -- Test 4: Set load = 1 -> q should update to "11110000"
        load <= '1';
        wait for 20 ns;

        -- Test 5: Reset test -> q should clear to 00000000
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        wait;
    end process;

end Behavior;