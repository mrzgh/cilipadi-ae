----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:07:30 08/16/2015 
-- Design Name: 
-- Module Name:    Shift4C - Behavioral 
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

entity Shift4C is
    Port ( DINSHF : in  STD_LOGIC_VECTOR (0 to 63);
           DOUTSHF : out  STD_LOGIC_VECTOR (0 to 63));
end Shift4C;

architecture Behavioral of Shift4C is
  SIGNAL SHOP : STD_LOGIC_VECTOR (0 to 63);
begin
  
  -----------1ST ROW-----------------------
  SHOP ( 0 TO 15 ) <= DINSHF ( 0 TO 15);
  ----------2ND ROW------------------------------------
    SHOP ( 16 TO 27) <= DINSHF ( 20 TO 31);
    SHOP ( 28 TO 31 ) <= DINSHF ( 16 TO 19);
	 ---------------3RD ROW------------------------
	 SHOP ( 32 TO 39) <= DINSHF  ( 40 TO 47);
    SHOP ( 40 TO 47 ) <= DINSHF  ( 32 TO 39);
	  ---------------4TH ROW------------------------
	 SHOP ( 48 TO 51) <= DINSHF  ( 60 TO 63);
    SHOP ( 52 TO 63 ) <= DINSHF  ( 48 TO 59);
	 
	 DOUTSHF <= SHOP ;
	 
	 
	 

    

  

end Behavioral;

