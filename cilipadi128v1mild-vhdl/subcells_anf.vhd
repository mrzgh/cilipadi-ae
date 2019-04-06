----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2019 04:06:27 PM
-- Design Name: 
-- Module Name: subcells_anf - Behavioral
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

entity subcells_anf is
    Port ( sc_anf_in : in STD_LOGIC_VECTOR (63 downto 0);
           sc_anf_out : out STD_LOGIC_VECTOR (63 downto 0));
end subcells_anf;

architecture Behavioral of subcells_anf is

component sbox_anf is 
Port (  x : in  STD_LOGIC_VECTOR (3 downto 0);
        y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

begin
    o1  : sbox_anf port map (sc_anf_in(63 downto 60), sc_anf_out(63 downto 60));
    o2  : sbox_anf port map (sc_anf_in(59 downto 56), sc_anf_out(59 downto 56));
    o3  : sbox_anf port map (sc_anf_in(55 downto 52), sc_anf_out(55 downto 52));
    o4  : sbox_anf port map (sc_anf_in(51 downto 48), sc_anf_out(51 downto 48));
    o5  : sbox_anf port map (sc_anf_in(47 downto 44), sc_anf_out(47 downto 44));
    o6  : sbox_anf port map (sc_anf_in(43 downto 40), sc_anf_out(43 downto 40));
    o7  : sbox_anf port map (sc_anf_in(39 downto 36), sc_anf_out(39 downto 36));
    o8  : sbox_anf port map (sc_anf_in(35 downto 32), sc_anf_out(35 downto 32));
    o9  : sbox_anf port map (sc_anf_in(31 downto 28), sc_anf_out(31 downto 28));
    o10 : sbox_anf port map (sc_anf_in(27 downto 24), sc_anf_out(27 downto 24));
    o11 : sbox_anf port map (sc_anf_in(23 downto 20), sc_anf_out(23 downto 20));
    o12 : sbox_anf port map (sc_anf_in(19 downto 16), sc_anf_out(19 downto 16));
    o13 : sbox_anf port map (sc_anf_in(15 downto 12), sc_anf_out(15 downto 12));
    o14 : sbox_anf port map (sc_anf_in(11 downto  8), sc_anf_out(11 downto  8));
    o15 : sbox_anf port map (sc_anf_in( 7 downto  4), sc_anf_out( 7 downto  4));
    o16 : sbox_anf port map (sc_anf_in( 3 downto  0), sc_anf_out( 3 downto  0));
end Behavioral;
