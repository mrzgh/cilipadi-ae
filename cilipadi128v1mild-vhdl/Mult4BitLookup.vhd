----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2019 12:31:28 AM
-- Design Name: 
-- Module Name: Mult4BitLookup - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mult4bitlookup is
    Port ( in_a : in STD_LOGIC_VECTOR (3 downto 0);
           in_b : in STD_LOGIC_VECTOR (3 downto 0);
           out_c : out STD_LOGIC_VECTOR (3 downto 0));
end mult4bitlookup;

architecture Behavioral of mult4bitlookup is

begin
P1 : Process ( in_a, in_b ) 
    begin	
		If ((in_a <=  X"0") OR  (in_b <=  X"0")) then  --- If A or B zero the output zero    
            out_c <=  X"0";
		elsIF  (in_a <=  X"1") then                          ----IF A = 1 the Out = B
		      
				 out_c <=  in_b ;
				 
		   elsIF   (in_b <=  X"1") then                        --- IF B = 1 the Out = A
		      
				 out_c <=  in_a;
				 
				  elsIF ((in_a <=  X"2") and (in_b <=  X"2")) then
		      	 out_c <=  X"4";
					 
				   elsIF ((in_a <=  X"2") and (in_b <=  X"3")) or   ((in_a <=  X"3") and (in_b <=  X"2"))then
		      	 out_c <=  X"6";
					 		 
					  elsIF ((in_a <=  X"2") and (in_b <=  X"4")) or ((in_a <=  X"4") and (in_b <=  X"2"))then
		      	 out_c <=  X"8";
					 
					  elsIF ((in_a <=  X"2") and (in_b <=  X"5")) or  ((in_a <=  X"5") and (in_b <=  X"2"))then
		      	 out_c <=  X"A";
					 
                 elsIF ((in_a <=  X"2") and (in_b <=  X"6"))  or ((in_a <=  X"6") and (in_b <=  X"2"))then
		      	 out_c <=  X"C";
					 
					 elsIF ((in_a <=  X"2") and (in_b <=  X"7")) or  ((in_a <=  X"7") and (in_b <=  X"2"))then
		      	 out_c <=  X"E";
					 
					  elsIF ((in_a <=  X"2") and (in_b <=  X"8")) or  ((in_a <=  X"8") and (in_b <=  X"2"))then
		      	 out_c <=  X"3";
					 
					  elsIF ((in_a <=  X"2") and (in_b <=  X"9")) or  ((in_a <=  X"9") and (in_b <=  X"2"))then
		      	 out_c <=  X"1";
					 
					 elsIF ((in_a <=  X"2") and (in_b <=  X"A")) or ((in_a <=  X"A") and (in_b <=  X"2"))then
		      	 out_c <=  X"7";
					 
					 elsIF ((in_a <=  X"2") and (in_b <=  X"B")) or((in_a <=  X"B") and (in_b <=  X"2"))then
		      	 out_c <=  X"5";
					 
					 elsIF ((in_a <=  X"2") and (in_b <=  X"C")) or ((in_a <=  X"C") and (in_b <=  X"2"))then
		      	 out_c <=  X"B";
					 
					 elsIF ((in_a <=  X"2") and (in_b <=  X"D"))  or ((in_a <=  X"D") and (in_b <=  X"2"))then
		      	 out_c <=  X"9";
					 
					 elsIF ((in_a <=  X"2") and (in_b <=  X"E"))  or ((in_a <=  X"E") and (in_b <=  X"2"))then
		      	 out_c <=  X"F";
					 
					 elsIF ((in_a <=  X"2") and (in_b <=  X"f")) or((in_a <=  X"F") and (in_b <=  X"2"))then
		      	 out_c <=  X"D";
					 ---------------------------------------------
					  elsIF ((in_a <=  X"3") and (in_b <=  X"3")) then
		      	 out_c <=  X"5";
					 		 
					  elsIF ((in_a <=  X"3") and (in_b <=  X"4"))  or ((in_a <=  X"4") and (in_b <=  X"3"))then
		      	 out_c <=  X"C";
					 
					  elsIF ((in_a <=  X"3") and (in_b <=  X"5"))  or ((in_a <=  X"5") and (in_b <=  X"3"))then
		      	 out_c <=  X"F";
					 
                 elsIF ((in_a <=  X"3") and (in_b <=  X"6")) or ((in_a <=  X"6") and (in_b <=  X"3"))then
		      	 out_c <=  X"A";
					 
					 elsIF ((in_a <=  X"3") and (in_b <=  X"7")) or ((in_a <=  X"7") and (in_b <=  X"3"))then
		      	 out_c <=  X"9";
					 
					  elsIF ((in_a <=  X"3") and (in_b <=  X"8")) or ((in_a <=  X"8") and (in_b <=  X"3"))then
		      	 out_c <=  X"B";
					 
					 
					  elsIF ((in_a <=  X"3") and (in_b <=  X"9")) or ((in_a <=  X"9") and (in_b <=  X"3"))then
		      	 out_c <=  X"8";
					 
					 elsIF ((in_a <=  X"3") and (in_b <=  X"A"))  or  ((in_a <=  X"A") and (in_b <=  X"3"))then
		      	 out_c <=  X"D";
					 
					 elsIF ((in_a <=  X"3") and (in_b <=  X"B"))  or ((in_a <=  X"B") and (in_b <=  X"3"))then
		      	 out_c <=  X"E";
					 
					 elsIF ((in_a <=  X"3") and (in_b <=  X"C") ) or ((in_a <=  X"C") and (in_b <=  X"3"))then
		      	 out_c <=  X"7";
					 
					 elsIF ((in_a <=  X"3") and (in_b <=  X"D")) or  ((in_a <=  X"D") and (in_b <=  X"3"))then
		      	 out_c <=  X"4";
			
					 
					  elsIF  ((in_a <=  X"E") and (in_b <=  X"3")) or ((in_a <=  X"3") and (in_b <=  X"E"))
					  then		      	 out_c <=  X"1";

					 
					  elsIF  ((in_a <=  X"F") and (in_b <=  X"3")) or ((in_a <=  X"3") and (in_b <=  X"f"))then
		      	 out_c <=  X"2";
					 ----------------------------------------------------------------------------------------
					   
					 		 
					  elsIF ((in_a <=  X"4") and (in_b <=  X"4")) then
		      	 out_c <=  X"3";
					  elsIF (((in_a <=  X"4") and (in_b <=  X"5")) or  ((in_a <=  X"5") and (in_b <=  X"4")))then
		      	 out_c <=  X"7";
                 elsIF (((in_a <=  X"4") and (in_b <=  X"6")) or  ((in_a <=  X"6") and (in_b <=  X"4")))then
		      	 out_c <=  X"B";
					 elsIF (((in_a <=  X"4") and (in_b <=  X"7")) or  ((in_a <=  X"7") and (in_b <=  X"4")))then
		      	 out_c <=  X"F";
					  elsIF (((in_a <=  X"4") and (in_b <=  X"8")) or  ((in_a <=  X"8") and (in_b <=  X"4")))then
		      	 out_c <=  X"6";
					  elsIF (((in_a <=  X"4") and (in_b <=  X"9")) or  ((in_a <=  X"9") and (in_b <=  X"4")))then
		      	 out_c <=  X"2";
					 elsIF (((in_a <=  X"4") and (in_b <=  X"A")) or  ((in_a <=  X"A") and (in_b <=  X"4")))then
		      	 out_c <=  X"E";
					 elsIF (((in_a <=  X"4") and (in_b <=  X"B")) or  ((in_a <=  X"B") and (in_b <=  X"4")))then
		      	 out_c <=  X"A";
					 elsIF (((in_a <=  X"4") and (in_b <=  X"C")) or  ((in_a <=  X"C") and (in_b <=  X"4")))then
		      	 out_c <=  X"5";
					 elsIF (((in_a <=  X"4") and (in_b <=  X"D")) or  ((in_a <=  X"D") and (in_b <=  X"4")))then
		      	 out_c <=  X"1";
					 elsIF (((in_a <=  X"4") and (in_b <=  X"E")) or  ((in_a <=  X"E") and (in_b <=  X"4")))then
		      	 out_c <=  X"D";
					 elsIF (((in_a <=  X"4") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"4")))then
		      	 out_c <=  X"9";
					 
				-----------------------------------------------------------------------------------------------------
                
					  elsIF ((in_a <=  X"5") and (in_b <=  X"5")) then
		      	 out_c <=  X"2";
                 elsIF (((in_a <=  X"5") and (in_b <=  X"6")) or  ((in_a <=  X"6") and (in_b <=  X"5")))then
		      	 out_c <=  X"D";
					 elsIF (((in_a <=  X"5") and (in_b <=  X"7")) or  ((in_a <=  X"7") and (in_b <=  X"5")))then
		      	 out_c <=  X"8";
					  elsIF (((in_a <=  X"5") and (in_b <=  X"8")) or  ((in_a <=  X"8") and (in_b <=  X"5")))then
		      	 out_c <=  X"E";
					  elsIF (((in_a <=  X"5") and (in_b <=  X"9")) or  ((in_a <=  X"9") and (in_b <=  X"5")))then
		      	 out_c <=  X"B";
					 elsIF (((in_a <=  X"5") and (in_b <=  X"A")) or  ((in_a <=  X"A") and (in_b <=  X"5")))then
		      	 out_c <=  X"4";
					 elsIF (((in_a <=  X"5") and (in_b <=  X"B")) or  ((in_a <=  X"B") and (in_b <=  X"5")))then
		      	 out_c <=  X"1";
					 elsIF (((in_a <=  X"5") and (in_b <=  X"C")) or  ((in_a <=  X"C") and (in_b <=  X"5")))then
		      	 out_c <=  X"9";
					 elsIF (((in_a <=  X"5") and (in_b <=  X"D")) or  ((in_a <=  X"D") and (in_b <=  X"5")))then
		      	 out_c <=  X"C";
					 elsIF (((in_a <=  X"5") and (in_b <=  X"E")) or  ((in_a <=  X"E") and (in_b <=  X"5")))then
		      	 out_c <=  X"3";
					 elsIF (((in_a <=  X"5") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"5")))then
		      	 out_c <=  X"6";

---------------------------------------------------------------------------
  
                 elsIF ((in_a <=  X"6") and (in_b <=  X"6"))then
		      	 out_c <=  X"7";
					 elsIF (((in_a <=  X"6") and (in_b <=  X"7")) or  ((in_a <=  X"7") and (in_b <=  X"6")))then
		      	 out_c <=  X"1";
					  elsIF (((in_a <=  X"6") and (in_b <=  X"8")) or  ((in_a <=  X"8") and (in_b <=  X"6")))then
		      	 out_c <=  X"5";
					  elsIF (((in_a <=  X"6") and (in_b <=  X"9")) or  ((in_a <=  X"9") and (in_b <=  X"6")))then
		      	 out_c <=  X"3";
					 elsIF (((in_a <=  X"6") and (in_b <=  X"A")) or  ((in_a <=  X"A") and (in_b <=  X"6")))then
		      	 out_c <=  X"9";
					 elsIF (((in_a <=  X"6") and (in_b <=  X"B")) or  ((in_a <=  X"B") and (in_b <=  X"6")))then
		      	 out_c <=  X"F";
					 elsIF (((in_a <=  X"6") and (in_b <=  X"C")) or  ((in_a <=  X"C") and (in_b <=  X"6")))then
		      	 out_c <=  X"E";
					 elsIF (((in_a <=  X"6") and (in_b <=  X"D")) or  ((in_a <=  X"D") and (in_b <=  X"6")))then
		      	 out_c <=  X"8";
					 elsIF (((in_a <=  X"6") and (in_b <=  X"E")) or  ((in_a <=  X"E") and (in_b <=  X"6")))then
		      	 out_c <=  X"2";
					 elsIF (((in_a <=  X"6") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"6")))then
		      	 out_c <=  X"4";	

---------------------------------------------------------------------------------------------------------------------


 
					 elsIF ((in_a <=  X"7") and (in_b <=  X"7")) then
		      	 out_c <=  X"6";
					  elsIF (((in_a <=  X"7") and (in_b <=  X"8")) or  ((in_a <=  X"8") and (in_b <=  X"7")))then
		      	 out_c <=  X"D";
					  elsIF (((in_a <=  X"7") and (in_b <=  X"9")) or  ((in_a <=  X"9") and (in_b <=  X"7")))then
		      	 out_c <=  X"A";
					 elsIF (((in_a <=  X"7") and (in_b <=  X"A")) or  ((in_a <=  X"A") and (in_b <=  X"7")))then
		      	 out_c <=  X"3";
					 elsIF (((in_a <=  X"7") and (in_b <=  X"B")) or  ((in_a <=  X"B") and (in_b <=  X"7")))then
		      	 out_c <=  X"4";
					 elsIF (((in_a <=  X"7") and (in_b <=  X"C")) or  ((in_a <=  X"C") and (in_b <=  X"7")))then
		      	 out_c <=  X"2";
					 elsIF (((in_a <=  X"7") and (in_b <=  X"D")) or  ((in_a <=  X"D") and (in_b <=  X"7")))then
		      	 out_c <=  X"5";
					 elsIF (((in_a <=  X"7") and (in_b <=  X"E")) or  ((in_a <=  X"E") and (in_b <=  X"7")))then
		      	 out_c <=  X"C";
					 elsIF (((in_a <=  X"7") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"7")))then
		      	 out_c <=  X"B";	
-------------------------------------------------------------------------------------------------------------
 					  elsIF ((in_a <=  X"8") and (in_b <=  X"8"))then
		      	 out_c <=  X"C";
					  elsIF (((in_a <=  X"8") and (in_b <=  X"9")) or  ((in_a <=  X"9") and (in_b <=  X"8")))then
		      	 out_c <=  X"4";
					 elsIF (((in_a <=  X"8") and (in_b <=  X"A")) or  ((in_a <=  X"A") and (in_b <=  X"8")))then
		      	 out_c <=  X"F";
					 elsIF (((in_a <=  X"8") and (in_b <=  X"B")) or  ((in_a <=  X"B") and (in_b <=  X"8")))then
		      	 out_c <=  X"7";
					 elsIF (((in_a <=  X"8") and (in_b <=  X"C")) or  ((in_a <=  X"C") and (in_b <=  X"8")))then
		      	 out_c <=  X"A";
					 elsIF (((in_a <=  X"8") and (in_b <=  X"D")) or  ((in_a <=  X"D") and (in_b <=  X"8")))then
		      	 out_c <=  X"2";
					 elsIF (((in_a <=  X"8") and (in_b <=  X"E")) or  ((in_a <=  X"E") and (in_b <=  X"8")))then
		      	 out_c <=  X"9";
					 elsIF (((in_a <=  X"8") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"8")))then
		      	 out_c <=  X"1";	
					 
					-------------------------------------------------------------------------------------------------------
 
					 elsIF ((in_a <=  X"9") and (in_b <=  X"9")) then
		      	 out_c <=  X"D";
					 elsIF (((in_a <=  X"9") and (in_b <=  X"A")) or  ((in_a <=  X"A") and (in_b <=  X"9")))then
		      	 out_c <=  X"5";
					 elsIF (((in_a <=  X"9") and (in_b <=  X"B")) or  ((in_a <=  X"B") and (in_b <=  X"9")))then
		      	 out_c <=  X"C";
					 elsIF (((in_a <=  X"9") and (in_b <=  X"C")) or  ((in_a <=  X"C") and (in_b <=  X"9")))then
		      	 out_c <=  X"6";
					 elsIF (((in_a <=  X"9") and (in_b <=  X"D")) or  ((in_a <=  X"D") and (in_b <=  X"9")))then
		      	 out_c <=  X"F";
					 elsIF (((in_a <=  X"9") and (in_b <=  X"E")) or  ((in_a <=  X"E") and (in_b <=  X"9")))then
		      	 out_c <=  X"7";
					 elsIF (((in_a <=  X"9") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"9")))then
		      	 out_c <=  X"E";						
					 
			----------------------------------------------------------------------------------------------------------------------
  
					 elsIF ((in_a <=  X"A") and (in_b <=  X"A"))  then
		      	 out_c <=  X"8";
					 elsIF (((in_a <=  X"A") and (in_b <=  X"B")) or  ((in_a <=  X"B") and (in_b <=  X"A")))then
		      	 out_c <=  X"2";
					 elsIF (((in_a <=  X"A") and (in_b <=  X"C")) or  ((in_a <=  X"C") and (in_b <=  X"A")))then
		      	 out_c <=  X"1";
					 elsIF (((in_a <=  X"A") and (in_b <=  X"D")) or  ((in_a <=  X"D") and (in_b <=  X"A")))then
		      	 out_c <=  X"B";
					 elsIF (((in_a <=  X"A") and (in_b <=  X"E")) or  ((in_a <=  X"E") and (in_b <=  X"A")))then
		      	 out_c <=  X"6";
					 elsIF (((in_a <=  X"A") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"A")))then
		      	 out_c <=  X"C";				
					 
					 
------------------------------------------------------------------------------------------------------------------------------
  
					 elsIF ((in_a <=  X"B") and (in_b <=  X"B")) then
		      	 out_c <=  X"9";
					 elsIF (((in_a <=  X"B") and (in_b <=  X"C")) or  ((in_a <=  X"C") and (in_b <=  X"B")))then
		      	 out_c <=  X"D";
					 elsIF (((in_a <=  X"B") and (in_b <=  X"D")) or  ((in_a <=  X"D") and (in_b <=  X"B")))then
		      	 out_c <=  X"6";
					 elsIF (((in_a <=  X"B") and (in_b <=  X"E")) or  ((in_a <=  X"E") and (in_b <=  X"B")))then
		      	 out_c <=  X"8";
					 elsIF (((in_a <=  X"B") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"B")))then
		      	 out_c <=  X"3";					 
					 
		------------------------------------------------------------------------------------------------------------
 
					 elsIF ((in_a <=  X"C") and (in_b <=  X"C"))then
		      	 out_c <=  X"F";
					 elsIF (((in_a <=  X"C") and (in_b <=  X"D")) or  ((in_a <=  X"D") and (in_b <=  X"C")))then
		      	 out_c <=  X"3";
					 elsIF (((in_a <=  X"C") and (in_b <=  X"E")) or  ((in_a <=  X"E") and (in_b <=  X"C")))then
		      	 out_c <=  X"4";
					 elsIF (((in_a <=  X"C") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"C")))then
		      	 out_c <=  X"8";					 
					 		
					 
		-----------------------------------------------------------------------------------------------------------------------
 
					 elsIF ((in_a <=  X"D") and (in_b <=  X"D"))then
		      	 out_c <=  X"E";
					 elsIF (((in_a <=  X"D") and (in_b <=  X"E")) or  ((in_a <=  X"E") and (in_b <=  X"D")))then
		      	 out_c <=  X"A";
					 elsIF (((in_a <=  X"D") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"D")))then
		      	 out_c <=  X"7";					 
					 		
	----------------------------------------------------------------------------------------------------------------------------

 
					 elsIF ((in_a <=  X"E") and (in_b <=  X"E"))then
		      	 out_c <=  X"B";
					 elsIF (((in_a <=  X"E") and (in_b <=  X"f")) or  ((in_a <=  X"F") and (in_b <=  X"E")))then
		      	 out_c <=  X"5";	
----------------------------------------------------------------------------------------------------------------------------

 
					 
					 elsIF ((in_a <=  X"F") and (in_b <=  X"f")) then
		      	 out_c <=  X"A";							 
					 
					 
					 
		 
					 
				 end if;
end process P1;
end Behavioral;
