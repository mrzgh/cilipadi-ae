----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 14:07:30 08/16/2015
-- Design Name:
-- Module Name: Shift4C - Behavioral
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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity Shift4C is
	port (
		DINSHF : in STD_LOGIC_VECTOR (0 to 63);
		DOUTSHF : out STD_LOGIC_VECTOR (0 to 63)
	);
end Shift4C;

architecture Behavioral of Shift4C is
	signal SHOP : STD_LOGIC_VECTOR (0 to 63);
begin
	-----------1ST ROW-----------------------
	SHOP (0 to 15 ) <= DINSHF (0 to 15);
	----------2ND ROW------------------------------------
	SHOP (16 to 27) <= DINSHF (20 to 31);
	SHOP (28 to 31 ) <= DINSHF (16 to 19);
	---------------3RD ROW------------------------
	SHOP (32 to 39) <= DINSHF (40 to 47);
	SHOP (40 to 47 ) <= DINSHF (32 to 39);
	---------------4TH ROW------------------------
	SHOP (48 to 51) <= DINSHF (60 to 63);
	SHOP (52 to 63 ) <= DINSHF (48 to 59);
 
	DOUTSHF <= SHOP;

end Behavioral;