library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_8bit is
    Port ( d    : in  STD_LOGIC_VECTOR (7 downto 0);
           load : in  STD_LOGIC;
           clk  : in  STD_LOGIC;
           rst  : in  STD_LOGIC;
           q    : out STD_LOGIC_VECTOR (7 downto 0) );
end reg_8bit;

architecture Structural of reg_8bit is

    component reg_1bit
        Port ( d    : in  STD_LOGIC;
               load : in  STD_LOGIC;
               clk  : in  STD_LOGIC;
               rst  : in  STD_LOGIC;
               q    : out STD_LOGIC );
    end component;

begin

    -- Instantiate 8 instances of 1-bit register for 8-bit bus
    gen_reg: for i in 0 to 7 generate
        u_reg1b: reg_1bit port map (
            d    => d(i),
            load => load,
            clk  => clk,
            rst  => rst,
            q    => q(i)
        );
    end generate gen_reg;

end Structural;