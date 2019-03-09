----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2019 11:04:40 AM
-- Design Name: 
-- Module Name: shiftrows - shiftrows_arc
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

entity shiftrows is
    Port ( x : in STD_LOGIC_VECTOR (63 downto 0);
           y : out STD_LOGIC_VECTOR (63 downto 0));
end shiftrows;

architecture shiftrows_arc of shiftrows is
signal r0,r1,r2,r3 : STD_LOGIC_VECTOR (15 to 0);
begin

-- row by row
r0 <= x(63 downto 48);
r1 <= x(43 downto 32) & x(47 downto 44);
r2 <= x(23 downto 16) & x(31 downto 24);
r3 <= x( 3 downto  0) & x(15 downto  4); 

y <= r0 & r1 & r2 & r3;

end shiftrows_arc;
