----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2019 07:34:22 AM
-- Design Name: 
-- Module Name: shiftrows_tb - shiftrows_tb_arc
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

entity shiftrows_tb is
--  Port ( );
end shiftrows_tb;

architecture shiftrows_tb_arc of shiftrows_tb is

component shiftrows is
    Port( x: in STD_LOGIC_VECTOR(63 downto 0);
          y: out STD_LOGIC_VECTOR(63 downto 0));
end component;

signal t_x, t_y: STD_LOGIC_VECTOR(63 downto 0);

begin

    U_UT: shiftrows port map(t_x, t_y);
    
    process
    
    begin
        t_x <= x"0123456789abcdef";
        wait for 10 ns;
    
    end process;


end shiftrows_tb_arc;
