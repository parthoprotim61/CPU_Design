library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_tb is
end mux2_tb;

architecture Behavior of mux2_tb is

    component mux2
        Port ( d0  : in  STD_LOGIC;
               d1  : in  STD_LOGIC;
               sel : in  STD_LOGIC;
               y   : out STD_LOGIC );
    end component;

    signal d0  : STD_LOGIC := '0';
    signal d1  : STD_LOGIC := '0';
    signal sel : STD_LOGIC := '0';
    signal y   : STD_LOGIC;

begin

    uut: mux2 port map (
        d0  => d0,
        d1  => d1,
        sel => sel,
        y   => y
    );

    stim_proc: process
    begin
        -- Test 1: Select d0 (sel = 0), d0 = 1, d1 = 0 -> Output y should be 1
        d0 <= '1'; d1 <= '0'; sel <= '0';
        wait for 20 ns;

        -- Test 2: Select d1 (sel = 1), d0 = 1, d1 = 0 -> Output y should be 0
        d0 <= '1'; d1 <= '0'; sel <= '1';
        wait for 20 ns;

        -- Test 3: Select d1 (sel = 1), d0 = 0, d1 = 1 -> Output y should be 1
        d0 <= '0'; d1 <= '1'; sel <= '1';
        wait for 20 ns;

        -- Test 4: Select d0 (sel = 0), d0 = 0, d1 = 1 -> Output y should be 0
        d0 <= '0'; d1 <= '1'; sel <= '0';
        wait for 20 ns;

        wait;
    end process;

end Behavior;