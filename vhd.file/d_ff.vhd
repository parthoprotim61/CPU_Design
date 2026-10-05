library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff is
    Port ( d   : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           q   : out STD_LOGIC );
end d_ff;

architecture Structural of d_ff is

    component not_gate
        Port ( a : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

    component and_gate
        Port ( a : in  STD_LOGIC;
               b : in  STD_LOGIC;
               y : out STD_LOGIC );
    end component;

    component mux2
        Port ( d0  : in  STD_LOGIC;
               d1  : in  STD_LOGIC;
               sel : in  STD_LOGIC;
               y   : out STD_LOGIC );
    end component;

    signal not_rst    : STD_LOGIC := '0';
    signal d_rst      : STD_LOGIC := '0';
    signal q_internal : STD_LOGIC := '0';

begin

    u_not: not_gate port map (
        a => rst,
        y => not_rst
    );

    u_and: and_gate port map (
        a => d,
        b => not_rst,
        y => d_rst
    );

    -- d0-তে d_rst এবং d1-এ q_internal দেওয়া হলো
    u_mux: mux2 port map (
        d0  => d_rst,      -- Clock high/low অনুযায়ী সঠিক ডেটা যাবে
        d1  => q_internal,
        sel => clk,
        y   => q_internal
    );

    q <= q_internal;

end Structural;