-- Blikani ledkami
-- uvodni priklad pro IVH - Vojtech Mrazek
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

architecture main of tlv_gp_ifc is
   constant TMR : natural := 20; -- 18 je normalni

   signal cnt : std_logic_vector(23 downto 0) := (others => '0');

   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal R : std_logic_vector(7 downto 0); 
begin
   LEDF <= cnt(22);

   -- synchronni citac s asynchronnim nulovanim
   process(RESET, SMCLK)
   begin
      if SMCLK'event and SMCLK = '1' then
        if (RESET = '1') then
          cnt <= (0=>'1', others => '0'); -- zaciname od 1, kvuli prvnimu preskoceni
        else
           cnt <= cnt + 1;
        end if;
      end If;
   end process;


   process(SMCLK, RESET) is
   begin

      if rising_edge(SMCLK) then
         if RESET = '1' then
            A <= (others => '0');
            R <= (0=>'1', others => '0'); 
         else   
            if cnt(TMR downto 0) = 0 then
               R <= R(6 downto 0) & R(7);
            end if;
                
            if cnt(TMR + 3 downto 0) = 0 then
                 A <= A + 1;
            end if;
         end if;
      end if;
   end process;
        
        -- mapovani vystupu
        -- nemenit
        X(6) <= A(3);
        X(8) <= A(1);
        X(10) <= A(0);
        X(7) <= '0'; -- en_n
        X(9) <= A(2);

        X(16) <= R(1);
        X(18) <= R(0);
        X(20) <= R(7);
        X(22) <= R(2);
      
        X(17) <= R(4);
        X(19) <= R(3);
        X(21) <= R(6);
        X(23) <= R(5);
end main;

