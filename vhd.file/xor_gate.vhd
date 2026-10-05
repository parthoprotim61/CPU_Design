library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           y : out STD_LOGIC );
end xor_gate;

architecture Structural of xor_gate is

    -- Basic gate components
    component and_gate
        Port ( a : in  STD_LOGIC;
               b : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

    component or_gate
        Port ( a : in  STD_LOGIC;
               b : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

    component not_gate
        Port ( a : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

    -- Internal signals
    signal not_a, not_b : STD_LOGIC;
    signal term1, term2 : STD_LOGIC;

begin

    -- NOT gates: A' and B'
    u_not_a: not_gate port map (a => a, y => not_a);
    u_not_b: not_gate port map (a => b, y => not_b);

    -- AND gates: (A . B') and (A' . B)
    u_and1: and_gate port map (a => a, b => not_b, y => term1);
    u_and2: and_gate port map (a => not_a, b => b, y => term2);

    -- OR gate: (A . B') + (A' . B)
    u_or1: or_gate port map (a => term1, b => term2, y => y);

end Structural;