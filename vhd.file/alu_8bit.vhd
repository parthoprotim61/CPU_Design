library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit is
    Port ( A        : in  STD_LOGIC_VECTOR (7 downto 0);
           B        : in  STD_LOGIC_VECTOR (7 downto 0);
           Op       : in  STD_LOGIC_VECTOR (2 downto 0);
           ALU_Out  : out STD_LOGIC_VECTOR (7 downto 0);
           CarryOut : out STD_LOGIC
         );
end alu_8bit;

architecture Pure_Structural of alu_8bit is

    -- Apnar full_adder_8bit component
    component full_adder_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               Cin  : in  STD_LOGIC;
               Sum  : out STD_LOGIC_VECTOR (7 downto 0);
               Cout : out STD_LOGIC
             );
    end component;

    -- Apnar mux2 component
    component mux2
        Port ( D0  : in  STD_LOGIC;
               D1  : in  STD_LOGIC;
               Sel : in  STD_LOGIC;
               Y   : out STD_LOGIC
             );
    end component;

    -- Apnar basic gate components
    component and_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;

    component or_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;

    component xor_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;

    component not_gate
        Port ( A : in STD_LOGIC; Y : out STD_LOGIC);
    end component;

    -- Internal Signals
    signal B_not, B_in  : STD_LOGIC_VECTOR(7 downto 0);
    signal sum_res      : STD_LOGIC_VECTOR(7 downto 0);
    signal add_carry    : STD_LOGIC;
    
    signal and_res      : STD_LOGIC_VECTOR(7 downto 0);
    signal or_res       : STD_LOGIC_VECTOR(7 downto 0);
    signal xor_res      : STD_LOGIC_VECTOR(7 downto 0);
    signal not_res      : STD_LOGIC_VECTOR(7 downto 0);

    -- MUX Tree Signals (3-Stage MUX using apnar mux2)
    signal m_stage1_0, m_stage1_1, m_stage1_2, m_stage1_3 : STD_LOGIC_VECTOR(7 downto 0);
    signal m_stage2_0, m_stage2_1                          : STD_LOGIC_VECTOR(7 downto 0);
    signal carry_stage1, carry_stage2                      : STD_LOGIC;

begin

    -- 1. Subtraction Input Setup: B_not = NOT B, and select B_in using mux2
    GEN_SUB_LOGIC: for i in 0 to 7 generate
        NOT_B_INST : not_gate port map (A => B(i), Y => B_not(i));
        MUX_B_INST : mux2     port map (D0 => B(i), D1 => B_not(i), Sel => Op(0), Y => B_in(i));
    end generate GEN_SUB_LOGIC;

    -- 2. Arithmetic Operation using apnar full_adder_8bit
    ADDER_INST : full_adder_8bit port map (
        A    => A,
        B    => B_in,
        Cin  => Op(0), -- Subtraction mode-e initial Cin = 1
        Sum  => sum_res,
        Cout => add_carry
    );

    -- 3. Gate Level Logic Operations using apnar gate components
    GEN_LOGIC_GATES: for i in 0 to 7 generate
        AND_INST : and_gate port map (A => A(i), B => B(i), Y => and_res(i));
        OR_INST  : or_gate  port map (A => A(i), B => B(i), Y => or_res(i));
        XOR_INST : xor_gate port map (A => A(i), B => B(i), Y => xor_res(i));
        NOT_INST : not_gate port map (A => A(i), Y => not_res(i));
    end generate GEN_LOGIC_GATES;

    -- 4. 8-to-1 Output Selection Tree using cascading apnar mux2
    GEN_MUX_TREE: for i in 0 to 7 generate
        -- Stage 1 (Sel: Op(0))
        -- Pair 0: Op 000 (Add) vs Op 001 (Sub)
        -- Pair 1: Op 010 (AND) vs Op 011 (OR)
        -- Pair 2: Op 100 (XOR) vs Op 101 (NOT)
        MUX_S1_0 : mux2 port map (D0 => sum_res(i), D1 => sum_res(i), Sel => Op(0), Y => m_stage1_0(i));
        MUX_S1_1 : mux2 port map (D0 => and_res(i), D1 => or_res(i),  Sel => Op(0), Y => m_stage1_1(i));
        MUX_S1_2 : mux2 port map (D0 => xor_res(i), D1 => not_res(i), Sel => Op(0), Y => m_stage1_2(i));
        MUX_S1_3 : mux2 port map (D0 => '0',        D1 => '0',        Sel => Op(0), Y => m_stage1_3(i));

        -- Stage 2 (Sel: Op(1))
        MUX_S2_0 : mux2 port map (D0 => m_stage1_0(i), D1 => m_stage1_1(i), Sel => Op(1), Y => m_stage2_0(i));
        MUX_S2_1 : mux2 port map (D0 => m_stage1_2(i), D1 => m_stage1_3(i), Sel => Op(1), Y => m_stage2_1(i));

        -- Stage 3 (Sel: Op(2)) Output Select
        MUX_S3_0 : mux2 port map (D0 => m_stage2_0(i), D1 => m_stage2_1(i), Sel => Op(2), Y => ALU_Out(i));
    end generate GEN_MUX_TREE;

    -- Carry Out Routing Tree using apnar mux2
    CARRY_M1 : mux2 port map (D0 => add_carry,    D1 => add_carry,    Sel => Op(0), Y => carry_stage1);
    CARRY_M2 : mux2 port map (D0 => carry_stage1, D1 => '0',          Sel => Op(1), Y => carry_stage2);
    CARRY_M3 : mux2 port map (D0 => carry_stage2, D1 => '0',          Sel => Op(2), Y => CarryOut);

end Pure_Structural;