--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 10:46:56 08/18/2015
-- Design Name: 
-- Module Name: D:/YASIR_PHD_2015/LED_Algorithms/VHDL/LED_1RND_FSM/main_TB.vhd
-- Project Name: LED_1RND_FSM
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

entity main_TB is
end main_TB;

architecture behavior of main_TB is

	-- Component Declaration for the Unit Under Test (UUT)

	component Main_LED_FSM
		port (
			N : in std_logic_vector(0 to 127);
			K : in std_logic_vector(0 to 127);
			clk : in std_logic;
			ctr : in std_logic;
			rst : in std_logic;
			Ciphertext : out std_logic_vector(0 to 63)
		);
	end component;
 

	-- Inputs
	signal N : std_logic_vector(0 to 127) := (others => '0');
	signal K : std_logic_vector(0 to 127) := (others => '0');
	signal clk : std_logic := '0';
	signal ctr : std_logic := '0';
	signal rst : std_logic := '0';

	-- Outputs
	signal Ciphertext : std_logic_vector(0 to 63);

	-- Clock period definitions
	constant clk_period : time := 2 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	uut : Main_LED_FSM
	port map(
		k => k, 
		n => n, 
		clk => clk, 
		ctr => ctr, 
		rst => rst, 
		Ciphertext => Ciphertext
	);

	-- Clock process definitions
	clk_process : process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	-- Stimulus process
	stim_proc : process
	begin
		-- hold reset state for 100 ns.
		-- wait for 50 ns;
		--
		k <= x"00000000000000000000000000000000";
		n <= x"00000000000000000000000000000000";
		ctr <= '1';
		rst <= '0'; 
		--wait for 100 ns;
		--
		-- Plaintext <= x"0123456789abcdef";
		-- KEY <= x"0123456789abcdef";
		-- ctr <= '1';
		-- rst <= '0'; 

		wait for clk_period * 10;

		-- insert stimulus here

		wait;
	end process;

	end;