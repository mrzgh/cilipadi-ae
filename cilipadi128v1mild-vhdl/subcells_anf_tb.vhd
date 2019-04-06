----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2019 04:33:43 PM
-- Design Name: 
-- Module Name: subcells_anf_tb - Behavioral
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

entity subcells_anf_tb is
    Port ( sc_anf_in : in STD_LOGIC_VECTOR (63 downto 0);
           sc_anf_out : out STD_LOGIC_VECTOR (63 downto 0));
end subcells_anf_tb;

architecture Behavioral of subcells_anf_tb is

component subcells_anf is
    Port( sc_anf_in: in STD_LOGIC_VECTOR(63 downto 0);
          sc_anf_out: out STD_LOGIC_VECTOR(63 downto 0));
end component;

signal t_x, t_y: STD_LOGIC_VECTOR(63 downto 0);

begin

    U_UT: subcells_anf port map(t_x, t_y);
    
    process
    
    begin
        t_x <= x"0123456789abcdef";
        wait for 10 ns;
    
    end process;


end Behavioral;
