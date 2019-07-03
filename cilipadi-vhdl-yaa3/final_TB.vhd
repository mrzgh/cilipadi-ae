--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 23:18:13 04/11/2019
-- Design Name: 
-- Module Name: F:/VHDL/Cilipidia9april19final/final_TB.vhd
-- Project Name: LED64_FSM
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
-- std_logic_vector for the ports of the unit under test. Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- USE ieee.numeric_std.ALL;

entity final_TB is
end final_TB;

architecture behavior of final_TB is

	-- Component Declaration for the Unit Under Test (UUT)

	component Main_LED_FSM
		port (
			N : in std_logic_vector(0 to 127);
			K : in std_logic_vector(0 to 127);
			clock : in std_logic;
			ctr : in std_logic;
			rst : in std_logic;
			load : in std_logic;
			Tag : out std_logic_vector(0 to 63);
			Ciphertext : out std_logic_vector(0 to 63)
		);
	end component;
 

	-- Inputs
	signal N : std_logic_vector(0 to 127) := (others => '0');
	signal K : std_logic_vector(0 to 127) := (others => '0');
	signal clock : std_logic := '0';
	signal ctr : std_logic := '0';
	signal rst : std_logic := '0';
	signal load : std_logic := '0';

	-- Outputs
	signal Tag : std_logic_vector(0 to 63);
	signal Ciphertext : std_logic_vector(0 to 63);

	-- Clock period definitions
	constant clock_period : time := 1.6 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	uut : Main_LED_FSM
	port map(
		N => N, 
		K => K, 
		clock => clock, 
		ctr => ctr, 
		rst => rst, 
		load => load, 
		Tag => Tag, 
		Ciphertext => Ciphertext
	);

	-- Clock process definitions
	clock_process : process
	begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
	end process;
	-- Stimulus process
	stim_proc : process
	begin
		-- hold reset state for 100 ns.
		wait for 5 ns; 

		wait for clock_period * 3;

		-- insert stimulus here
 
		N <= x"00000000000000000000000000000000";
		K <= x"00000000000000000000000000000000";
		clock <= '1';
		ctr <= '1';
		rst <= '0';
		load <= '1';

		wait;
	end process;

	end;