-----------------------------------------------------------------------
-- counter_tb.vhd
-- testbench file used in project |Luminous Board| for IVH 2021
-- Author: Vojtech Kalis
-----------------------------------------------------------------------
-- soubor slouzi pro test spravnosti funkce casovace counter.vhd
-----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY counter_tb IS
END counter_tb;
 
ARCHITECTURE behavior OF counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter
	 Generic (
			CLK_FREQ : positive := 100000;
			OUT_FREQ : positive := 10000);	
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         EN : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal EN : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 1 ns;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	-- vas ukol !!!!!!!!! vcetne nastaveni generickych parametru
	cnt: counter
	Generic map (
		CLK_FREQ => 1000,	-- tady kdyztak prenastavit (ale testbench pocita s polovicni frekvenci (=2)!!)
		OUT_FREQ => 500)	-- tady kdyztak prenastavit
   Port map (
      CLK => CLK,
      RESET => RESET,
      EN => EN);
	
   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

	-- Stimulus process
	stim_proc: process
	begin		
		-- CLK zacina v 0, v kazde pulperiode se zmeni na 1
		-- TEST BENCH POCITA S POLOVICNI FREKVENCI (=2)!!

		-- |#1| - kontrola funkcnosti RESETu
		RESET <= '1';
		wait for CLK_period/50;	-- abych se dostal do pozice, kdy kontroluju stav EN ihned za nabeznou hranou, ne na ni
		assert EN = '0' report "failed for #1.1:  EN isn't 0." severity error;	--ihned po zapnuti resetu
		wait for CLK_period/2;
		assert EN = '0' report "failed for #1.2:  EN isn't 0." severity error;	--polovina periody
		wait for CLK_period/2;
		assert EN = '0' report "failed for #1.3:  EN isn't 0." severity error;	--perioda
		wait for CLK_period;	-- just to be sure
		assert EN = '0' report "failed for #1.4:  EN isn't 0." severity error;	--dalsi perioda (na polovicni frekvenci by tu mel byt bez RESETu EN v jednicce)
		wait for CLK_period*2;	-- just to be sure
		assert EN = '0' report "failed for #1.5:  EN isn't 0." severity error;	--2 dalsi periody (to same)
		wait for CLK_period*4;	-- just to be sure
		assert EN = '0' report "failed for #1.6:  EN isn't 0." severity error;	--4 dalsi periody (to same)

		-- |#2| - kontrola normalni funkce citace
		RESET <= '0';
		assert EN = '0' report "failed for #2.1:  EN isn't 0." severity error;	--ihned po vypnuti resetu
		wait for CLK_period/2;
		assert EN = '0' report "failed for #2.2:  EN isn't 0." severity error;	--polovina periody (stale by mela byt 0)
		wait for CLK_period/2;
		assert EN = '0' report "failed for #2.3:  EN isn't 0." severity error;	--perioda (0)
		wait for CLK_period/2;
		assert EN = '1' report "failed for #2.3:  EN isn't 1." severity error;	--dalsi perioda (1)
		wait for CLK_period/4;
		assert EN = '1' report "failed for #2.4:  EN isn't 1." severity error;	--ctvrtina periody
		wait for CLK_period/4;
		assert EN = '1' report "failed for #2.5:  EN isn't 1." severity error;	--polovina periody
		wait for CLK_period/4;
		assert EN = '1' report "failed for #2.6:  EN isn't 1." severity error;	--trictvrte periody
		wait for CLK_period/8;
		assert EN = '1' report "failed for #2.7:  EN isn't 1." severity error;	--chvili pred koncem periody
		wait for CLK_period/8;
		assert EN = '0' report "failed for #2.8:  EN isn't 0." severity error;	--konec periody

		-- |#3| - kontrola nulovani counteru pri resetu
		RESET <= '1';
		wait for CLK_period*2;
		RESET <= '0';	--zacatek novych testu, jen pro vynulovani counteru
		wait for CLK_period;
		assert EN = '0' report "failed for #3.1:  EN isn't 0." severity error;	--jedna perioda
		RESET <= '1';
		wait for CLK_period*2;
		RESET <= '0';	--reset
		assert EN = '0' report "failed for #3.2:  EN isn't 0." severity error;	--novy zacatek periody (stav hned po resetu)
		wait for CLK_period;
		assert EN = '0' report "failed for #3.3:  EN isn't 0." severity error;	--jedna perioda
		wait for CLK_period;
		assert EN = '1' report "failed for #3.4:  EN isn't 1." severity error;	--druha perioda (1)
		wait for CLK_period;
		assert EN = '0' report "failed for #3.5:  EN isn't 0." severity error;	--pokracujeme normalne...

		-- |#4| - asi zbytecna kontrola, ale w/e
		RESET <= '1';
		wait for CLK_period*2;
		RESET <= '0'; --zacatek novych testu, jen pro vynulovani counteru
		assert EN = '0' report "failed for #4.1:  EN isn't 0." severity error;	--novy zacatek periody (stav hned po resetu)
		wait for CLK_period;
		assert EN = '0' report "failed for #4.2:  EN isn't 0." severity error;  --perioda (0)
		wait for CLK_period;
		assert EN = '1' report "failed for #4.3:  EN isn't 1." severity error;  --perioda (1)
		wait for CLK_period;
		assert EN = '0' report "failed for #4.4:  EN isn't 0." severity error;  --perioda (0)
		wait for CLK_period;
		assert EN = '1' report "failed for #4.5:  EN isn't 1." severity error;  --perioda (1)
		wait for CLK_period;
		assert EN = '0' report "failed for #4.6:  EN isn't 0." severity error;  --perioda (0)
		wait for CLK_period;
		assert EN = '1' report "failed for #4.7:  EN isn't 1." severity error;  --perioda (1)
		wait for CLK_period;
		assert EN = '0' report "failed for #4.8:  EN isn't 0." severity error;  --perioda (0)

		wait;
	end process;

END;