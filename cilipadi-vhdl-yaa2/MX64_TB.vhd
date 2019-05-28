--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:27:08 08/16/2015
-- Design Name:   
-- Module Name:   D:/YASIR_PHD_2015/LED_Algorithms/VHDL/LED_SP3/MX64_TB.vhd
-- Project Name:  LED_SP3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX64
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MX64_TB IS
END MX64_TB;
 
ARCHITECTURE behavior OF MX64_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX64
    PORT(
         AIN : IN  std_logic_vector(0 to 63);
         BIN : IN  std_logic_vector(0 to 63);
         CIN : IN  std_logic_vector(0 to 63);
         DIN : IN  std_logic_vector(0 to 63);
         MXOUT : OUT  std_logic_vector(0 to 63);
         SELMX : IN  std_logic_vector(0 to 1)
        );
    END COMPONENT;
    

   --Inputs
   signal AIN : std_logic_vector(0 to 63) := (others => '0');
   signal BIN : std_logic_vector(0 to 63) := (others => '0');
   signal CIN : std_logic_vector(0 to 63) := (others => '0');
   signal DIN : std_logic_vector(0 to 63) := (others => '0');
   signal SELMX : std_logic_vector(0 to 1) := (others => '0');

 	--Outputs
   signal MXOUT : std_logic_vector(0 to 63);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX64 PORT MAP (
          AIN => AIN,
          BIN => BIN,
          CIN => CIN,
          DIN => DIN,
          MXOUT => MXOUT,
          SELMX => SELMX
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;
          AIN  <= X"000000000000000F";
          BIN  <= X"000000000000FFFF";
          CIN  <= X"FFFF000000000000"; 
			 DIN  <= X"0000FFFF00000000"; 
          SELMX <= "00"	;
			 wait for 10 ns;
          AIN  <= X"0000000000000000";
          BIN  <= X"000000000000FFFF";
          CIN  <= X"FFFF000000000000"; 
			 DIN  <= X"0000FFFF00000000"; 
          SELMX <= "01"	;
			  wait for 10 ns;
          AIN  <= X"0000000000000000";
          BIN  <= X"000000000000FFFF";
          CIN  <= X"FFFF000000000000"; 
			 DIN  <= X"0000FFFF00000000"; 
          SELMX <= "10"	;
			  wait for 10 ns;
          AIN  <= X"0000000000000000";
          BIN  <= X"000000000000FFFF";
          CIN  <= X"FFFF000000000000"; 
			 DIN  <= X"0000FFFF00000000"; 
          SELMX <= "11"	;

--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
