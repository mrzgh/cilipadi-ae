----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2019 12:59:08 PM
-- Design Name: 
-- Module Name: sbox_anf - Behavioral
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

entity sbox_anf is
    Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
           y : out STD_LOGIC_VECTOR (3 downto 0));
end sbox_anf;

architecture Behavioral of sbox_anf is

begin

process(x)
begin
    y(3) <= NOT( (x(1) AND x(2) AND x(0)) XOR (x(1) AND x(3) AND x(0)) XOR (x(2) AND x(3) AND x(0)) XOR x(0) XOR x(1) XOR (x(1) AND x(2)) XOR x(3));
    y(2) <= NOT( (x(0) AND x(1)) XOR (x(0) AND x(3) AND x(1)) XOR (x(3) AND x(1)) XOR x(2) XOR (x(0) AND x(3)) XOR (x(0) AND x(2) AND x(3)) XOR x(3) );
    y(1) <= (x(0) AND x(2) AND x(1)) XOR (x(0) AND x(3) AND x(1)) XOR (x(3) AND x(1)) XOR x(1) XOR (x(0) AND x(2) AND x(3)) XOR (x(2) AND x(3)) XOR x(3);
    y(0) <= x(0) XOR (x(1) AND x(2)) XOR x(2) XOR x(3);
end process;

end Behavioral;
