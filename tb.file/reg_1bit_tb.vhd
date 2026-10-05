library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_1bit_tb is
end reg_1bit_tb;

architecture Behavior of reg_1bit_tb is

    component reg_1bit
        Port ( d    : in  STD_LOGIC;
               load : in  STD_LOGIC;
               clk  : in  STD_LOGIC;
               rst  : in  STD_LOGIC;
               q    : out STD_LOGIC );
    end component;

    signal d    : STD_LOGIC := '0';
    signal load : STD_LOGIC := '0';
    signal clk  : STD_LOGIC := '0';
    signal rst  : STD_LOGIC := '0';
    signal q    : STD_LOGIC;

    constant clk_period : time := 10 ns;

begin

    uut: reg_1bit port map (
        d    => d,
        load => load,
        clk  => clk,
        rst  => rst,
        q    => q
    );

    -- Clock Generation
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
        -- Reset state
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;

        -- Test 1: d = 1 but load = 0 (Data should NOT load)
        d <= '1'; load <= '0';
        wait for 20 ns;

        -- Test 2: load = 1 (Data '1' should load into register)
        load <= '1';
        wait for 20 ns;

        -- Test 3: d = 0 but load = 0 (Data '1' should stay stored)
        d <= '0'; load <= '0';
        wait for 20 ns;

        -- Test 4: load = 1 (Data '0' should now load)
        load <= '1';
        wait for 20 ns;

        wait;
    end process;

end Behavior;