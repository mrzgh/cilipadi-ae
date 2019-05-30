--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:01:25 04/06/2019
-- Design Name:   
-- Module Name:   F:/VHDL/CilipadiLED/T1_TB.vhd
-- Project Name:  LED64_FSM
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Main_LED_FSM
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
 
ENTITY T1_TB IS
END T1_TB;
 
ARCHITECTURE behavior OF T1_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Main_LED_FSM
    PORT(
         N : IN  std_logic_vector(0 to 127);
         K : IN  std_logic_vector(0 to 127);
         clock : IN  std_logic;
         ctr : IN  std_logic;
		--	AD	 : IN  std_logic_vector(0 to 63);
				--		MODE	 : IN  std_logic_vector(0 to 1);

         rst, load : IN  std_logic;
			--CONT : OUT  STD_LOGIC;
         Rk1out : OUT  std_logic_vector(0 to 63);
         Rk2out : OUT  std_logic_vector(0 to 63);
         RN1out : OUT  std_logic_vector(0 to 63);
         RN2out : OUT  std_logic_vector(0 to 63);
         Ciphertext : OUT  std_logic_vector(0 to 63)
        );
    END COMPONENT;
    

   --Inputs
   signal N : std_logic_vector(0 to 127) := (others => '0');
   signal K : std_logic_vector(0 to 127) := (others => '0');
   signal clock : std_logic := '0';
   signal ctr : std_logic := '0';
   signal rst , load : std_logic := '0';
	--signal AD : std_logic_vector(0 to 63);
--SIGNAL MODE	 :  std_logic_vector(0 to 1);
 	--Outputs
   signal Rk1out : std_logic_vector(0 to 63);
   signal Rk2out : std_logic_vector(0 to 63);
   signal RN1out : std_logic_vector(0 to 63);
   signal RN2out : std_logic_vector(0 to 63);
   signal Ciphertext : std_logic_vector(0 to 63);

   -- Clock period definitions
   constant clock_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Main_LED_FSM PORT MAP (
          N => N,
          K => K,
		--	 AD => AD,
		--	 MODE => MODE ,
		--	 CONT => CONT,
          clock => clock,
          ctr => ctr,
          rst => rst,
			 load => load,
          Rk1out => Rk1out,
          Rk2out => Rk2out,
          RN1out => RN1out,
          RN2out => RN2out,
          Ciphertext => Ciphertext
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
      wait for 5 ns;	

      wait for clock_period*5;

      -- insert stimulus here 
	     N <=    X"00000000000000000000000000000000";
          K <= X"00000000000000000000000000000000";
			--- AD <= x"FFFFFFFFFFFFFFFF";
			-- MODE <= "00";
          clock <= '1';
          ctr <= '1';
          rst <= '0';
			 load <= '1';
--			  wait for 550 ns;	
--			  			 MODE <= "10";
--						  clock <= '1';
--          ctr <= '1';
--          rst <= '0';
--			 load <= '1';
--					 						  wait for 400 ns;	
--
--           MODE <= "10";
--			   clock <= '1';
--          ctr <= '1';
--          rst <= '0';
--			 load <= '1';
      wait;
   end process;

END;
