----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2019 07:34:22 AM
-- Design Name: 
-- Module Name: subcells_tb - subcells_tb_arc
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

entity subcells_tb is
--  Port ( );
end subcells_tb;

architecture subcells_tb_arc of subcells_tb is

component subcells is
    Port( sc_in: in STD_LOGIC_VECTOR(63 downto 0);
          sc_out: out STD_LOGIC_VECTOR(63 downto 0));
end component;

signal t_x, t_y: STD_LOGIC_VECTOR(63 downto 0);

begin

    U_UT: subcells port map(t_x, t_y);
    
    process
    
    begin
        t_x <= x"0123456789abcdef";
        wait for 10 ns;
    
    end process;


end subcells_tb_arc;
