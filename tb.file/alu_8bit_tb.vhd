library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit_tb is
end alu_8bit_tb;

architecture Behavior of alu_8bit_tb is

    component alu_8bit
    Port(
         A        : in  STD_LOGIC_VECTOR(7 downto 0);
         B        : in  STD_LOGIC_VECTOR(7 downto 0);
         Op       : in  STD_LOGIC_VECTOR(2 downto 0);
         ALU_Out  : out STD_LOGIC_VECTOR(7 downto 0);
         CarryOut : out STD_LOGIC
        );
    end component;

   signal A        : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
   signal B        : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
   signal Op       : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');

   signal ALU_Out  : STD_LOGIC_VECTOR(7 downto 0);
   signal CarryOut : STD_LOGIC;

begin

   uut: alu_8bit PORT MAP (
          A => A,
          B => B,
          Op => Op,
          ALU_Out => ALU_Out,
          CarryOut => CarryOut
        );

   stim_proc: process
   begin		
      wait for 100 ns;	

      -- Test 1: Addition (15 + 10 = 25) [Op = "000"]
      A <= "00001111"; B <= "00001010"; Op <= "000";
      wait for 20 ns;

      -- Test 2: Subtraction (15 - 10 = 5) [Op = "001"]
      Op <= "001";
      wait for 20 ns;

      -- Test 3: Bitwise AND [Op = "010"]
      Op <= "010";
      wait for 20 ns;

      -- Test 4: Bitwise OR [Op = "011"]
      Op <= "011";
      wait for 20 ns;

      -- Test 5: Bitwise XOR [Op = "100"]
      Op <= "100";
      wait for 20 ns;

      -- Test 6: Bitwise NOT [Op = "101"]
      Op <= "101";
      wait for 20 ns;

      wait;
   end process;

end Behavior;