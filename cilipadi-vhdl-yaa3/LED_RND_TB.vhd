--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:35:10 08/17/2015
-- Design Name:   
-- Module Name:   D:/YASIR_PHD_2015/LED_Algorithms/VHDL/LED_comp/LED_RND_TB.vhd
-- Project Name:  LED_comp
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LEB_RND
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
 
ENTITY LED_RND_TB IS
END LED_RND_TB;
 
ARCHITECTURE behavior OF LED_RND_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LEB_RND
    PORT(
         DATAIN : IN  std_logic_vector(0 to 63);
         DATAOUT : OUT  std_logic_vector(0 to 63);
--			 OUTAC, OUTSBX, OUTSHF,OUTMX : out  STD_LOGIC_VECTOR (0 TO 63);
         CLK : IN  std_logic;
         CONST1,CONST3,CONST4  : IN  std_logic_vector(0 to 3);
         CONST2 : IN  std_logic_vector(0 to 3)
        );
    END COMPONENT;
    

   --Inputs
   signal DATAIN : std_logic_vector(0 to 63) := (others => '0');
   signal CLK : std_logic := '0';
   signal CONST1,CONST2,CONST3  : std_logic_vector(0 to 3) := (others => '0');
   signal CONST4 : std_logic_vector(0 to 3) := (others => '0');

 	--Outputs
--	SIGNAL  OUTAC, OUTSBX, OUTSHF,OUTMX :   STD_LOGIC_VECTOR (0 TO 63);
   signal DATAOUT : std_logic_vector(0 to 63);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LEB_RND PORT MAP (
          DATAIN => DATAIN,
          DATAOUT => DATAOUT,
--			  OUTAC => OUTAC,
--			  OUTSBX => OUTSBX,
--			  OUTSHF => OUTSHF,
--			  OUTMX => OUTMX,
          CLK => CLK,
          CONST1 => CONST1,
			 CONST2 => CONST2,
			 CONST3 => CONST3,
          CONST4 => CONST4
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
 	
---R1
		DATAIN <= X"0000000000000000";
           CONST1 <= X"0";
          CONST2 <= X"1";
			  CONST3 <= X"0";
          CONST4 <= X"1";
			 
--R2			 
--			  wait for 10 ns;
--				 DATAIN <= DATAOUT ; 
--       
--
--          CONST1 <= X"0";
--          CONST2 <= X"3";
--			  CONST3 <= X"0";
--          CONST4 <= X"3";				 
--
--	---R3		       
--	wait for 10 ns;
--					  DATAIN <=  DATAOUT;    
--              CONST1 <= X"0";
--          CONST2 <= X"7";
--			  CONST3 <= X"0";
--          CONST4 <= X"7";
--	
--				 
--				  wait for 10 ns;
--				 DATAIN <= DATAOUT ; 
--       
--            CONST1 <= X"1";
--          CONST2 <= X"7";
--			  CONST3 <= X"1";
--          CONST4 <= X"7";
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
