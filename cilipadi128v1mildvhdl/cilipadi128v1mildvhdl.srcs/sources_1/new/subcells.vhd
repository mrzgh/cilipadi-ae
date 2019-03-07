----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2019 12:16:02 AM
-- Design Name: 
-- Module Name: subcells - subcells_arc
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

entity subcells is
    Port ( sc_in  : in STD_LOGIC_VECTOR (63 downto 0);
           sc_out : out STD_LOGIC_VECTOR (63 downto 0));
end subcells;

architecture subcells_arc of subcells is

component sbox is 
Port (  x : in  STD_LOGIC_VECTOR (3 downto 0);
        y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

begin
o1  : sbox port map (sc_in(63 downto 60), sc_out(63 downto 60));
o2  : sbox port map (sc_in(59 downto 56), sc_out(59 downto 56));
o3  : sbox port map (sc_in(55 downto 52), sc_out(55 downto 52));
o4  : sbox port map (sc_in(51 downto 48), sc_out(51 downto 48));
o5  : sbox port map (sc_in(47 downto 44), sc_out(47 downto 44));
o6  : sbox port map (sc_in(43 downto 40), sc_out(43 downto 40));
o7  : sbox port map (sc_in(39 downto 36), sc_out(39 downto 36));
o8  : sbox port map (sc_in(35 downto 32), sc_out(35 downto 32));
o9  : sbox port map (sc_in(31 downto 28), sc_out(31 downto 28));
o10 : sbox port map (sc_in(27 downto 24), sc_out(27 downto 24));
o11 : sbox port map (sc_in(63 downto 20), sc_out(63 downto 20));
o12 : sbox port map (sc_in(59 downto 16), sc_out(59 downto 16));
o13 : sbox port map (sc_in(63 downto 12), sc_out(63 downto 12));
o14 : sbox port map (sc_in(59 downto  8), sc_out(59 downto  8));
o15 : sbox port map (sc_in(63 downto  4), sc_out(63 downto  4));
o16 : sbox port map (sc_in(59 downto  0), sc_out(59 downto  0));
end subcells_arc;
