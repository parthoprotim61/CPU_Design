library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_gate is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           y : out STD_LOGIC );
end nand_gate;

architecture Structural of nand_gate is

    component and_gate
        Port ( a : in  STD_LOGIC;
               b : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

    component not_gate
        Port ( a : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

    signal and_out : STD_LOGIC;

begin

    gate_and: and_gate port map (
        a => a,
        b => b,
        y => and_out
    );

    gate_not: not_gate port map (
        a => and_out,
        y => y
    );

end Structural;