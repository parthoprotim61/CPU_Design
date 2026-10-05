library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_gate_tb is
end nand_gate_tb;

architecture Behavioral of nand_gate_tb is

    component nand_gate
        Port ( a : in  STD_LOGIC;
               b : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

    signal a : STD_LOGIC := '0';
    signal b : STD_LOGIC := '0';
    signal y : STD_LOGIC;

begin

    uut: nand_gate port map (
        a => a,
        b => b,
        y => y
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