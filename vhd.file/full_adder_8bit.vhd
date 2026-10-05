library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_8bit is
    Port ( a    : in  STD_LOGIC_VECTOR (7 downto 0);
           b    : in  STD_LOGIC_VECTOR (7 downto 0);
           cin  : in  STD_LOGIC;
           sum  : out STD_LOGIC_VECTOR (7 downto 0);
           cout : out STD_LOGIC );
end full_adder_8bit;

architecture Structural of full_adder_8bit is

    component full_adder
        Port ( a    : in  STD_LOGIC;
               b    : in  STD_LOGIC;
               cin  : in  STD_LOGIC;
               sum  : out STD_LOGIC;
               cout : out STD_LOGIC );
    end component;

    signal c : STD_LOGIC_VECTOR (6 downto 0);

begin

    fa0: full_adder port map (a => a(0), b => b(0), cin => cin,  sum => sum(0), cout => c(0));
    fa1: full_adder port map (a => a(1), b => b(1), cin => c(0), sum => sum(1), cout => c(1));
    fa2: full_adder port map (a => a(2), b => b(2), cin => c(1), sum => sum(2), cout => c(2));
    fa3: full_adder port map (a => a(3), b => b(3), cin => c(2), sum => sum(3), cout => c(3));
    fa4: full_adder port map (a => a(4), b => b(4), cin => c(3), sum => sum(4), cout => c(4));
    fa5: full_adder port map (a => a(5), b => b(5), cin => c(4), sum => sum(5), cout => c(5));
    fa6: full_adder port map (a => a(6), b => b(6), cin => c(5), sum => sum(6), cout => c(6));
    fa7: full_adder port map (a => a(7), b => b(7), cin => c(6), sum => sum(7), cout => cout);

end Structural;