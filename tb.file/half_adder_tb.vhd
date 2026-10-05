library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder_tb is
end half_adder_tb;

architecture Behavioral of half_adder_tb is

    component half_adder
        Port ( a     : in  STD_LOGIC;
               b     : in  STD_LOGIC;
               sum   : out STD_LOGIC;
               carry : out STD_LOGIC );
    end component;

    signal a     : STD_LOGIC := '0';
    signal b     : STD_LOGIC := '0';
    signal sum   : STD_LOGIC;
    signal carry : STD_LOGIC;

begin

    uut: half_adder port map (
        a     => a,
        b     => b,
        sum   => sum,
        carry => carry
    );

    stim_proc: process
    begin
        a <= '0'; b <= '0';
        wait for 20 ns;

        a <= '0'; b <= '1';
        wait for 20 ns;

        a <= '1'; b <= '0';
        wait for 20 ns;

        a <= '1'; b <= '1';
        wait for 20 ns;

        wait;
    end process;

end Behavioral;