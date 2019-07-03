--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 20:13:25 04/06/2019
-- Design Name: 
-- Module Name: F:/VHDL/CilipadiLED/MUX64_2X1_TB.vhd
-- Project Name: LED64_FSM
-- Target Device: 
-- Tool versions: 
-- Description: 
--
-- VHDL Test Bench Created by ISE for module: MUX64_2X1
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

entity MUX64_2X1_TB is
end MUX64_2X1_TB;

architecture behavior of MUX64_2X1_TB is

	-- Component Declaration for the Unit Under Test (UUT)

	component MUX64_2X1
		port (
			A : in std_logic_vector(0 to 63);
			B : in std_logic_vector(0 to 63);
			MOUT : out std_logic_vector(0 to 63);
			SEL : in std_logic
		);
	end component;
 

	-- Inputs
	signal A : std_logic_vector(0 to 63) := (others => '0');
	signal B : std_logic_vector(0 to 63) := (others => '0');
	signal SEL : std_logic := '0';

	-- Outputs
	signal MOUT : std_logic_vector(0 to 63);
	-- No clocks detected in port list. Replace  below with
	-- appropriate port name

	-- constant _period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	uut : MUX64_2X1
	port map(
		A => A, 
		B => B, 
		MOUT => MOUT, 
		SEL => SEL
	);

	-- Clock process definitions
	-- _process :process
	-- begin
	--  <= '0';
	-- wait for _period/2;
	--  <= '1';
	-- wait for _period/2;
	-- end process;
	-- Stimulus process
	stim_proc : process
	begin
		-- hold reset state for 100 ns.
		wait for 100 ns; 

		-- wait for _period*10;

		-- insert stimulus here
 
		A <= X"0000000000000011";
		B <= X"1100000000000000";
		SEL <= '0';
		wait for 100 ns; 
		A <= X"0000000000000011";
		B <= X"1100000000000000";
		SEL <= '1';

		wait;
	end process;

	end;