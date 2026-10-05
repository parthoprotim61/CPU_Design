library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_tb is
end full_adder_tb;

architecture Behavioral of full_adder_tb is

    component full_adder
        Port ( a     : in  STD_LOGIC;
               b     : in  STD_LOGIC;
               cin   : in  STD_LOGIC;
               sum   : out STD_LOGIC;
               cout  : out STD_LOGIC );
    end component;

    signal a    : STD_LOGIC := '0';
    signal b    : STD_LOGIC := '0';
    signal cin  : STD_LOGIC := '0';
    signal sum  : STD_LOGIC;
    signal cout : STD_LOGIC;

begin

    uut: full_adder port map (
        a    => a,
        b    => b,
        cin  => cin,
        sum  => sum,
        cout => cout
    );

    stim_proc: process
    begin
        a <= '0'; b <= '0'; cin <= '0'; wait for 20 ns;
        a <= '0'; b <= '0'; cin <= '1'; wait for 20 ns;
        a <= '0'; b <= '1'; cin <= '0'; wait for 20 ns;
        a <= '0'; b <= '1'; cin <= '1'; wait for 20 ns;
        a <= '1'; b <= '0'; cin <= '0'; wait for 20 ns;
        a <= '1'; b <= '0'; cin <= '1'; wait for 20 ns;
        a <= '1'; b <= '1'; cin <= '0'; wait for 20 ns;
        a <= '1'; b <= '1'; cin <= '1'; wait for 20 ns;
        wait;
    end process;

end Behavioral;