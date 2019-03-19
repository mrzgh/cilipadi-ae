----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2019 11:52:15 PM
-- Design Name: 
-- Module Name: sbox - sbox_arc
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

entity sbox is
    Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
           y : out STD_LOGIC_VECTOR (3 downto 0));
end sbox;

architecture sbox_arc of sbox is

begin
process(x)
begin
case x is
    when "0000"=>y<="1100";
    when "0001"=>y<="0101";
    when "0010"=>y<="0110";
    when "0011"=>y<="1011";
    when "0100"=>y<="1001";
    when "0101"=>y<="0000";
    when "0110"=>y<="1010";
    when "0111"=>y<="1101";
    when "1000"=>y<="0011";
    when "1001"=>y<="1110";
    when "1010"=>y<="1111";
    when "1011"=>y<="1000";
    when "1100"=>y<="0100";
    when "1101"=>y<="0111";
    when "1110"=>y<="0001";
    when "1111"=>y<="0010";
    when others=>y<="0000";
end case;
end process;

end sbox_arc;
