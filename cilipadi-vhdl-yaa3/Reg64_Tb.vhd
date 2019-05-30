--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:26:33 04/07/2019
-- Design Name:   
-- Module Name:   F:/VHDL/CilipadiLED/Reg64_TB.vhd
-- Project Name:  LED64_FSM
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg64
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
 
ENTITY Reg64_TB IS
END Reg64_TB;
 
ARCHITECTURE behavior OF Reg64_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg64
    PORT(
         I : IN  std_logic_vector(0 to 63);
         clock : IN  std_logic;
         load : IN  std_logic;
         rst : IN  std_logic;
         Q : OUT  std_logic_vector(0 to 63)
        );
    END COMPONENT;
    

   --Inputs
   signal I : std_logic_vector(0 to 63) := (others => '0');
   signal clock : std_logic := '0';
   signal load : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(0 to 63);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg64 PORT MAP (
          I => I,
          clock => clock,
          load => load,
          rst => rst,
          Q => Q
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 
		      wait for 100 ns;	
            I <= x"0000000000000011";
          clock <= '1';
          load <= '1';
          rst <= '0';
			 
			 wait for 100 ns;	
            I <= x"0000000000011111";
          clock <= clock;
          load <= '1';
          rst <= '0';
			 wait for 100 ns;	
            I <= x"0000000000000011";
          clock <= clock;
          load <= '0';
          rst <= '0';
			 
          
      wait;
   end process;

END;
