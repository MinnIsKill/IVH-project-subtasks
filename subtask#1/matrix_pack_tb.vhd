-----------------------------------------------------------------------
-- matrix_pack_tb.vhd
-- testbench file used in project |Luminous Board| for IVH 2021
-- Author: Vojtech Kalis
-----------------------------------------------------------------------
-- soubor slouzi pro test spravnosti funkce balicku matrix_pack
-----------------------------------------------------------------------

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  USE WORK.matrix_pack.all;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 
  BEGIN
  --  Test Bench Statements
     tb : PROCESS
     BEGIN
	   -- GETID(X,Y,ROWS,COLS)
		-- X = column movement (to the side, indexed from 0), Y = row movement (up and down, indexed from 0)
		-- ROWS = number of rows (indexed from 1), COLS = number od rows (indexed from 1)
		
		-- GENERAL TESTING FOR 'X'
        assert GETID(-1,0,2,3) = 4 report "failed for X=-1,Y=0,ROWS=2,COLS=3" severity error;
		assert GETID(-2,0,2,3) = 2 report "failed for X=-2,Y=0,ROWS=2,COLS=3" severity error;
		assert GETID(-3,0,2,3) = 0 report "failed for X=-3,Y=0,ROWS=2,COLS=3" severity error;
		  
        assert GETID(0,0,2,3) = 0 report "failed for X=0,Y=0,ROWS=2,COLS=3" severity error;
		assert GETID(1,0,2,3) = 2 report "failed for X=1,Y=0,ROWS=2,COLS=3" severity error;
		assert GETID(2,0,2,3) = 4 report "failed for X=2,Y=0,ROWS=2,COLS=3" severity error;
		
        assert GETID(3,0,2,3) = 0 report "failed for X=3,Y=0,ROWS=2,COLS=3" severity error;
		assert GETID(4,0,2,3) = 2 report "failed for X=4,Y=0,ROWS=2,COLS=3" severity error;
		assert GETID(5,0,2,3) = 4 report "failed for X=5,Y=0,ROWS=2,COLS=3" severity error;
		  
		-- GENERAL TESTING FOR 'Y'
        assert GETID(0,-1,3,2) = 2 report "failed for X=0,Y=-1,ROWS=3,COLS=2" severity error;
		assert GETID(0,-2,3,2) = 1 report "failed for X=0,Y=-2,ROWS=3,COLS=2" severity error;
		assert GETID(0,-3,3,2) = 0 report "failed for X=0,Y=-3,ROWS=3,COLS=2" severity error;
		  
        assert GETID(0,0,3,2) = 0 report "failed for X=0,Y=0,ROWS=3,COLS=2" severity error;
		assert GETID(0,1,3,2) = 1 report "failed for X=0,Y=1,ROWS=3,COLS=2" severity error;
		assert GETID(0,2,3,2) = 2 report "failed for X=0,Y=2,ROWS=3,COLS=2" severity error;
		
        assert GETID(0,3,3,2) = 0 report "failed for X=0,Y=3,ROWS=3,COLS=2" severity error;
		assert GETID(0,4,3,2) = 1 report "failed for X=0,Y=4,ROWS=3,COLS=2" severity error;
		assert GETID(0,5,3,2) = 2 report "failed for X=0,Y=5,ROWS=3,COLS=2" severity error;
		  
		-- MORE COMPLEX TESTING
        assert GETID(2,2,50,50) = 102 report "failed for X=2,Y=2,ROWS=50,COLS=50" severity error;
		assert GETID(2,3,50,50) = 103 report "failed for X=2,Y=3,ROWS=50,COLS=50" severity error;
		assert GETID(0,5,50,50) = 5 report "failed for X=0,Y=5,ROWS=50,COLS=50" severity error;
		assert GETID(-5,0,50,50) = 2250 report "failed for X=-5,Y=0,ROWS=50,COLS=50" severity error;
		assert GETID(0,-5,50,50) = 45 report "failed for X=0,Y=-5,ROWS=50,COLS=50" severity error;
		  
        assert GETID(34,0,1,37) = 34 report "failed for X=34,Y=0,ROWS=37,COLS=1" severity error;
		assert GETID(34,1,1,37) = 34 report "failed for X=34,Y=1,ROWS=37,COLS=1" severity error;
		assert GETID(34,-1,1,37) = 34 report "failed for X=34,Y=-1,ROWS=37,COLS=1" severity error;


        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 
  END;
