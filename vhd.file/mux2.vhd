library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Port ( d0  : in  STD_LOGIC;
           d1  : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           y   : out STD_LOGIC );
end mux2;

architecture Structural of mux2 is

    -- Basic Gates Component Declarations
    component not_gate
        Port ( a : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

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

    -- Internal Signals
    signal not_sel : STD_LOGIC;
    signal and0_out: STD_LOGIC;
    signal and1_out: STD_LOGIC;

begin

    -- NOT Gate for Sel Signal
    u_not: not_gate port map (
        a => sel,
        y => not_sel
    );

    -- AND Gate 0: d0 AND NOT(sel)
    u_and0: and_gate port map (
        a => d0,
        b => not_sel,
        y => and0_out
    );

    -- AND Gate 1: d1 AND sel
    u_and1: and_gate port map (
        a => d1,
        b => sel,
        y => and1_out
    );

    -- OR Gate: Output Selection
    u_or: or_gate port map (
        a => and0_out,
        b => and1_out,
        y => y
    );

end Structural;