----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:21:41 08/16/2015 
-- Design Name: 
-- Module Name:    MUX64 - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX64 is
    Port ( AIN   : in   STD_LOGIC_VECTOR (0 to 63);
           BIN   : in   STD_LOGIC_VECTOR (0 to 63);
           CIN   : in   STD_LOGIC_VECTOR (0 to 63);
           DIN   : in   STD_LOGIC_VECTOR (0 to 63);
           MXOUT : out  STD_LOGIC_VECTOR (0 to 63);
           SELMX : in   STD_LOGIC_VECTOR (0 to 1));
end MUX64;

architecture Behavioral of MUX64 is

begin

 process(AIN, BIN,CIN,DIN,SELMX)
    begin
    
        -- use case statement
        case SELMX is
	    when "00" =>	MXOUT <= AIN;
	    when "01" =>	MXOUT <= BIN;
	    when "10" =>	MXOUT <= CIN;
	    when "11" =>	MXOUT <= DIN;
	    when others =>	MXOUT <= x"0000000000000000";
	end case;

    end process;


end Behavioral;

