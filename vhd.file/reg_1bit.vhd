library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_1bit is
    Port ( d    : in  STD_LOGIC;
           load : in  STD_LOGIC;
           clk  : in  STD_LOGIC;
           rst  : in  STD_LOGIC;
           q    : out STD_LOGIC );
end reg_1bit;

architecture Structural of reg_1bit is

    component mux2
        Port ( d0  : in  STD_LOGIC;
               d1  : in  STD_LOGIC;
               sel : in  STD_LOGIC;
               y   : out STD_LOGIC );
    end component;

    component d_ff
        Port ( d   : in  STD_LOGIC;
               clk : in  STD_LOGIC;
               rst : in  STD_LOGIC;
               q   : out STD_LOGIC );
    end component;

    -- Signal initializations to avoid 'U' state
    signal mux_out : STD_LOGIC := '0';
    signal q_out   : STD_LOGIC := '0';

begin

    u_mux: mux2 port map (
        d0  => q_out,
        d1  => d,
        sel => load,
        y   => mux_out
    );

    u_dff: d_ff port map (
        d   => mux_out,
        clk => clk,
        rst => rst,
        q   => q_out
    );

    q <= q_out;

end Structural;