--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:37:51 04/19/2021
-- Design Name:   
-- Module Name:   C:/FitkitSVN/apps/ivh_proj3/build/ivh_proj3/proj3_tb.vhd
-- Project Name:  ivh_proj3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: display
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY proj3_tb IS
END proj3_tb;
 
ARCHITECTURE behavior OF proj3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT display
    PORT(
         data : IN  std_logic_vector(127 downto 0);
         reset : IN  std_logic;
         clk : IN  std_logic;
         smclk : IN  std_logic;
         A : OUT  std_logic_vector(3 downto 0);
         R : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal data : std_logic_vector(127 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal smclk : std_logic := '0';

 	--Outputs
   signal A : std_logic_vector(3 downto 0);
   signal R : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant smclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: display PORT MAP (
          data => data,
          reset => reset,
          clk => clk,
          smclk => smclk,
          A => A,
          R => R
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   smclk_process :process
   begin
		smclk <= '0';
		wait for smclk_period/2;
		smclk <= '1';
		wait for smclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		-- TESTBENCH POCITA S delay1 = 9
		
		data <=	"0101100110000000" &
					"0110100101000000" &
					"0101100100100000" &
					"0110101000010000" &
					"0101011000001000" &
					"0110010100000100" &
					"0101010100000010" &
					"0110010100000001";

      --wait for clk_period*10;
		
		-- THE CHECKS FOR 'R' HAVE TO BE UPSIDE DOWN (BECAUSE IT'S DEFINED AS (7 downto 0))
		-- [1] checking columns 1-4
		wait until A = "0000";		
		assert R = "00000000" report "failed for #1.1: R doesn't equal first column of DATA" severity error;
		wait until A = "0001";		
		assert R = "11111111" report "failed for #1.2: R doesn't equal second column of DATA" severity error;
		wait until A = "0010";
		assert R = "10101010" report "failed for #1.3: R doesn't equal third column of DATA" severity error;
		wait until A = "0011";		
		assert R = "01010101" report "failed for #1.4: R doesn't equal fourth column of DATA" severity error;
		-- [1] checking columns 5-8
		wait until A = "0100";
		assert R = "00001111" report "failed for #1.5: R doesn't equal fifth column of DATA" severity error;
		wait until A = "0101";		
		assert R = "11110000" report "failed for #1.6: R doesn't equal sixth column of DATA" severity error;
		wait until A = "0110";		
		assert R = "00011000" report "failed for #1.7: R doesn't equal seventh column of DATA" severity error;
		wait until A = "0111";		
		assert R = "11100111" report "failed for #1.8: R doesn't equal eighth column of DATA" severity error;
		-- [1] checking columns 9-12		
		wait until A = "1000";
		assert R = "00000001" report "failed for #1.9: R doesn't equal ninth column of DATA" severity error;
		wait until A = "1001";		
		assert R = "00000010" report "failed for #1.10: R doesn't equal tenth column of DATA" severity error;
		wait until A = "1010";
		assert R = "00000100" report "failed for #1.11: R doesn't equal eleventh column of DATA" severity error;
		wait until A = "1011";		
		assert R = "00001000" report "failed for #1.12: R doesn't equal twelveth column of DATA" severity error;
		-- [1] checking columns 13-16
		wait until A = "1100";
		assert R = "00010000" report "failed for #1.13: R doesn't equal thirteenth column of DATA" severity error;
		wait until A = "1101";		
		assert R = "00100000" report "failed for #1.14: R doesn't equal fourteenth column of DATA" severity error;
		wait until A = "1110";
		assert R = "01000000" report "failed for #1.15: R doesn't equal fifteenth column of DATA" severity error;
		wait until A = "1111";		
		assert R = "10000000" report "failed for #1.16: R doesn't equal sixteenth column of DATA" severity error;
		
		-- setting data back to original value
		data <=	"0000000000000000" &
					"0010001001000100" &
					"0010001001001000" &
					"0010001001010000" &
					"0001010001110000" &
					"0001010001001000" &
					"0000100001000100" &
					"0000000000000000";
					
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
		wait for 100 ns;
		
		-- [2] testing proper function of delay between column switching
		assert A = "0000" report "failed for #2.1: delay not accurate or the value of 'delay1' in 'display.vhd' was changed - this test relies on its value to be set to '3999'" severity error;
		wait for clk_period*4000;
		assert A = "0001" report "failed for #2.2: delay not accurate or the value of 'delay1' in 'display.vhd' was changed - this test relies on its value to be set to '3999'" severity error;
		wait for clk_period*4000;
		assert A = "0010" report "failed for #2.3: delay not accurate or the value of 'delay1' in 'display.vhd' was changed - this test relies on its value to be set to '3999'" severity error;
		
		
		-- [3] testing proper function of reset
		reset <= '1';
		wait for 100 ns;
		
		assert A = "1111" report "failed for #3.1: A failed to reset" severity error;
		assert R = "00000000" report "failed for #3.2: R failed to reset" severity error;
		
      wait for 100 us;
		
		assert A = "1111" report "failed for #3.3: A failed to reset" severity error;
		assert R = "00000000" report "failed for #3.4: R failed to reset" severity error;
		
		wait for 100 ns;
		reset <= '0';
		wait for 100 ns;
		
		--wait until rising_edge(clk);


      wait;
   end process;

END;
