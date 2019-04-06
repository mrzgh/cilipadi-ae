----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2019 12:21:17 PM
-- Design Name: 
-- Module Name: mixcolumnsserial_tb - Behavioral
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

entity mixcolumnsserial_tb is
--  Port ( );
end mixcolumnsserial_tb;

architecture Behavioral of mixcolumnsserial_tb is

component mixcolumnsserial is
    Port ( mcs_in : in STD_LOGIC_VECTOR (63 downto 0);
           msc_out : out STD_LOGIC_VECTOR (63 downto 0));
end component;

signal t_x, t_y: STD_LOGIC_VECTOR(63 downto 0);

begin

    U_UT: mixcolumnsserial port map(t_x, t_y);
    
    process
    
    begin
        t_x <= x"cccc5cc5cc6ccb5c";
        wait for 10 ns;
    
    end process;


end Behavioral;
