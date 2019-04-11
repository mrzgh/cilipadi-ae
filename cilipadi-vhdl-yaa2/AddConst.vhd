----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:14:24 08/16/2015 
-- Design Name: 
-- Module Name:    AddConst - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AddConst is
    Port ( ADIN : in  STD_LOGIC_VECTOR (0 to 63);
	  RC1, RC2, RC3, RC4 :  in  STD_LOGIC_VECTOR (0 to 3);
	        RC5, RC6, RC7, RC8 :  in  STD_LOGIC_VECTOR (0 to 3);
           ADOUT : out  STD_LOGIC_VECTOR (0 to 63));
end AddConst;

architecture Behavioral of AddConst is
  SIGNAL ADINS :  STD_LOGIC_VECTOR (0 to 63);
  
  
  
  
	
--Type ICD_ARRAY is array 
--  (integer range 0 to 4) of std_logic_vector (0 to 3);
--  constant ICD : ICD_ARRAY := (x"0", x"1", x"3",x"6", x"4");

begin
--- FIRST COLUMNS----------
ADINS ( 0 TO 3 )   <= ADIN( 0 to 3)   XOR Rc1;
ADINS ( 16 TO 19 ) <= ADIN( 16 to 19)  XOR rc2;
ADINS ( 32 TO 35 ) <= ADIN ( 32 to 35) XOR rc3;
ADINS ( 48 TO 51 ) <= ADIN ( 48 to 51) XOR rc4;

-----2ND COLUMNS----------


ADINS ( 4 TO 7 )   <= ADIN ( 4 to 7)   XOR RC5;
ADINS ( 20 TO 23 ) <= ADIN ( 20 to 23) XOR RC6;
ADINS ( 36 TO 39 ) <= ADIN ( 36 to 39) XOR RC7;
ADINS ( 52 TO 55 ) <= ADIN ( 52 to 55) XOR RC8;

ADOUT ( 0 TO 7 )   <= ADINS  ( 0  TO 7);
ADOUT ( 16 TO 23 ) <= ADINS  ( 16 TO 23);
ADOUT ( 32 TO 39 ) <= ADINS  ( 32 TO 39);
ADOUT ( 48 TO 55)  <= ADINS  ( 48 TO 55);

ADOUT ( 8 TO 15 ) <= ADIN  ( 8 TO 15);
ADOUT ( 24 TO 31 ) <= ADIN ( 24 TO 31);
ADOUT ( 40 TO 47 ) <= ADIN ( 40 TO 47);
ADOUT ( 56 TO 63 ) <= ADIN ( 56 TO 63);









 




end Behavioral;

