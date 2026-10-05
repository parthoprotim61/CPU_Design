library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_tb is
end d_ff_tb;

architecture Behavior of d_ff_tb is

    component d_ff
        Port ( d   : in  STD_LOGIC;
               clk : in  STD_LOGIC;
               rst : in  STD_LOGIC;
               q   : out STD_LOGIC );
    end component;

    signal d   : STD_LOGIC := '0';
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal q   : STD_LOGIC;

    constant clk_period : time := 10 ns;

begin

    uut: d_ff port map (
        d   => d,
        clk => clk,
        rst => rst,
        q   => q
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
        -- Initial Reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;

        -- Test D = 1
        d <= '1';
        wait for 20 ns;

        -- Test D = 0
        d <= '0';
        wait for 20 ns;

        -- Test Reset Signal
        d <= '1';
        wait for 10 ns;
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        wait;
    end process;

end Behavior;