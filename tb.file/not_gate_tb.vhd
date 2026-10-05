library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_gate_tb is
end not_gate_tb;

architecture Behavioral of not_gate_tb is

    component not_gate
        Port ( a : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

    signal a : STD_LOGIC := '0';
    signal y : STD_LOGIC;

begin

    uut: not_gate port map (
        a => a,
        y => y
    );

    stim_proc: process
    begin
        a <= '0';
        wait for 20 ns;

        a <= '1';
        wait for 20 ns;

        wait;
    end process;

end Behavioral;