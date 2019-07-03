----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 14:26:09 08/16/2015
-- Design Name:
-- Module Name: SBox_4BitPRESENT - Behavioral
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

entity SBox_4BitPRESENT is
	port (
		SBox4_IN : in STD_LOGIC_VECTOR (0 to 3);
		SBox4_OUT : out STD_LOGIC_VECTOR (0 to 3)
	);

end SBox_4BitPRESENT;

architecture Behavioral of SBox_4BitPRESENT is
begin
	with SBox4_In select
	SBox4_Out <= 
 
		x"c" when x"0", 
		x"5" when x"1", 
		x"6" when x"2", 
		x"b" when x"3", 
		x"9" when x"4", 
		x"0" when x"5", 
		x"a" when x"6", 
		x"D" when x"7", 
		x"3" when x"8", 
		x"E" when x"9", 
		x"F" when x"A", 
		x"8" when x"B", 
		x"4" when x"C", 
		x"7" when x"D", 
		x"1" when x"E", 
		x"2" when x"F", 
		X"0" when others;

end Behavioral;