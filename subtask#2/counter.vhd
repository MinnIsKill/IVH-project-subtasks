-------------------------------------------------------------------------
-- counter.vhd
-- counter used in project |Luminous Board| for IVH 2021
-- Author: Vojtech Kalis
-------------------------------------------------------------------------
-- Implementace casovace (citac s volitelnou frekvenci)
-- Citac ma 2 genericke param.: - frekvenci hodinoveho signalu (CLK_FREQ) 
-- 								- vystupni frekvekvenci (OUT_FREQ) 
-- 										(obe dve zadane v Hz).
-- Citac s frekvenci odpovidajici OUT_FREQ (t.j., napr 2x za sekundu) 
-- aktivuje na jeden hodinovy cyklus signal EN.
-------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- v pripade nutnosti muzete nacist dalsi knihovny
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

entity counter is
	Generic (
			CLK_FREQ : positive := 100000;	-- tady kdyztak prenastavit
			OUT_FREQ : positive := 1000);		-- tady kdyztak prenastavit
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           EN : out  STD_LOGIC);
end counter;

architecture Behavioral of counter is

-- zde je funkce log2 z prednasek, pravdepodobne se vam bude hodit.
	function log2(A: integer) return integer is
		variable bits : integer := 0;
		variable b : integer := 1;
	begin
		while (b <= a) loop
			b := b * 2;
			bits := bits + 1;
		end loop;
		return bits;
	end function;

	-- dalsi vase signaly

	signal counter : integer := 0;
	
begin
	
	cnter: process(RESET, CLK, counter)
	begin
		if (RESET = '1') then
			counter <= 0;
			EN <= '0';	
		elsif (CLK'event) and (CLK = '1') then
			counter <= counter + 1;
			if (counter = ((CLK_FREQ/OUT_FREQ)-1)) then
				EN <= '1';
				counter <= 0;
			else
				EN <= '0';
			end if;
		--elsif (CLK'event) and (CLK = '0') then		-- puleni EN jeste na polovinu, myslel jsem ze ze zadani to je takhle spravne ale
														-- pak jsem zjistil ze se to ma nastavit na jeden hodinovy cyklus = jednu periodu CLK
		--	EN <= '0';
		end if;
	end process cnter;
-- citac bude mit 2 generické parametry: frekvenci hodinového signálu (CLK_FREQ) a vystupni
-- frekvekvenci (OUT_FREQ) (obe dve zadané v Hz). citac s frekvenci odpovidajici OUT_FREQ
-- (t.j., napr 2x za sekundu) aktivuje na jeden hodinovy cyklus signál EN po dobu jednoho taktu CLK
-- reset je aktivni v 1: tj kdyz je reset = 1, tak se vymaze vnitrni citac
-- pro zjednoduseni pocitejte, ze CLK_FREQ je delitelne OUT_FREQ beze zbytku 

-- Signál EN bude aktivovany po 1 periodu hodinového vstupu CLK - k cemu vám staci pouze 
-- signál CLK a jeho priznak CLK'event. Generické parametry OUT_FREQ a CLK_FREQ slouži pouze 
-- k vypoctu toho, kolika se frekvence musi delit (t.j. do kolika citac pocitá). Napriklad 
-- pokud vstupni frekvence bude 10 MHz a vy budete chtit vystupni frekvenci 10 kHz, tak musite vstupni frekvenci vydelit 1000. 

end Behavioral;
