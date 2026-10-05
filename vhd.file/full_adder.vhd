library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( a     : in  STD_LOGIC;
           b     : in  STD_LOGIC;
           cin   : in  STD_LOGIC;
           sum   : out STD_LOGIC;
           cout  : out STD_LOGIC );
end full_adder;

architecture Structural of full_adder is

    component half_adder
        Port ( a     : in  STD_LOGIC;
               b     : in  STD_LOGIC;
               sum   : out STD_LOGIC;
               carry : out STD_LOGIC );
    end component;

    component or_gate
        Port ( a : in  STD_LOGIC;
               b : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

    signal ha1_sum   : STD_LOGIC;
    signal ha1_carry : STD_LOGIC;
    signal ha2_carry : STD_LOGIC;

begin

    -- First Half Adder
    u_ha1: half_adder port map (
        a     => a,
        b     => b,
        sum   => ha1_sum,
        carry => ha1_carry
    );

    -- Second Half Adder
    u_ha2: half_adder port map (
        a     => ha1_sum,
        b     => cin,
        sum   => sum,
        carry => ha2_carry
    );

    -- Final Carry Output using OR gate
    u_or1: or_gate port map (
        a => ha2_carry,
        b => ha1_carry,
        y => cout
    );

end Structural;