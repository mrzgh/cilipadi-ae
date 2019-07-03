----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 20:09:59 04/06/2019
-- Design Name:
-- Module Name: MUX64_2X1 - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity MUX64_2x1 is
	port (
		A : in STD_LOGIC_VECTOR (0 to 63);
		B : in STD_LOGIC_VECTOR (0 to 63);
 
		MOUT : out STD_LOGIC_VECTOR (0 to 63);
		SEL : in STD_LOGIC 
	);
end MUX64_2x1;

architecture Behavioral of MUX64_2x1 is

begin
	process (A, B, SEL)
	begin
		-- use case statement
		case SEL is
			when '0' => MOUT <= A;
			when '1' => MOUT <= B;
			when others => MOUT <= x"0000000000000000";
		end case;

	end process;
end Behavioral;