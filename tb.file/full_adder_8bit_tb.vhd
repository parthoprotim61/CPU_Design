library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_full_adder_8bit is
end tb_full_adder_8bit;

architecture Behavior of tb_full_adder_8bit is

    component full_adder_8bit
        Port ( a    : in  STD_LOGIC_VECTOR (7 downto 0);
               b    : in  STD_LOGIC_VECTOR (7 downto 0);
               cin  : in  STD_LOGIC;
               sum  : out STD_LOGIC_VECTOR (7 downto 0);
               cout : out STD_LOGIC );
    end component;

    signal a    : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal b    : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal cin  : STD_LOGIC := '0';

    signal sum  : STD_LOGIC_VECTOR (7 downto 0);
    signal cout : STD_LOGIC;

begin

    uut: full_adder_8bit port map (
        a    => a,
        b    => b,
        cin  => cin,
        sum  => sum,
        cout => cout
    );

    stim_proc: process
    begin
        -- Test 1: 0 + 0 (cin = 0)
        a <= "00000000"; b <= "00000000"; cin <= '0';
        wait for 20 ns;

        -- Test 2: 5 + 10 (cin = 0)
        a <= "00000101"; b <= "00001010"; cin <= '0';
        wait for 20 ns;

        -- Test 3: 255 + 1 (cin = 0) -> Cout check
        a <= "11111111"; b <= "00000001"; cin <= '0';
        wait for 20 ns;

        -- Test 4: 255 + 255 (cin = 1)
        a <= "11111111"; b <= "11111111"; cin <= '1';
        wait for 20 ns;

        wait;
    end process;

end Behavior;