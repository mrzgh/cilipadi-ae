----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 22:15:19 03/26/2019
-- Design Name:
-- Module Name: Reg64 - Behavioral
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
library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
---------------------------------------------------
entity reg64 is

	generic (n : natural := 64);
	port (
		I : in std_logic_vector(0 to n - 1);
		clock : in std_logic;
		load, rst : in std_logic;
 
		Q : out std_logic_vector(0 to n - 1)
	);
end reg64;

----------------------------------------------------

architecture behv of reg64 is
begin
	process (load, rst, clock, I )
	begin
		if (rst = '1' ) then
			Q <= X"0000000000000000";

		elsif (clock'EVENT and clock = '1' and load = '1' ) then
 
			Q <= I;
 
		end if;

	end process;

end behv;