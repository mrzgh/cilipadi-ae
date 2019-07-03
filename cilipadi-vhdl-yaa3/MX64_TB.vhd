--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11:27:08 08/16/2015
-- Design Name: 
-- Module Name: D:/YASIR_PHD_2015/LED_Algorithms/VHDL/LED_SP3/MX64_TB.vhd
-- Project Name: LED_SP3
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

entity MX64_TB is
end MX64_TB;

architecture behavior of MX64_TB is

	-- Component Declaration for the Unit Under Test (UUT)

	component MUX64
		port (
			AIN : in std_logic_vector(0 to 63);
			BIN : in std_logic_vector(0 to 63);
			CIN : in std_logic_vector(0 to 63);
			DIN : in std_logic_vector(0 to 63);
			MXOUT : out std_logic_vector(0 to 63);
			SELMX : in std_logic_vector(0 to 1)
		);
	end component;
 

	-- Inputs
	signal AIN : std_logic_vector(0 to 63) := (others => '0');
	signal BIN : std_logic_vector(0 to 63) := (others => '0');
	signal CIN : std_logic_vector(0 to 63) := (others => '0');
	signal DIN : std_logic_vector(0 to 63) := (others => '0');
	signal SELMX : std_logic_vector(0 to 1) := (others => '0');

	-- Outputs
	signal MXOUT : std_logic_vector(0 to 63);
	-- No clocks detected in port list. Replace  below with
	-- appropriate port name

	-- constant _period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	uut : MUX64
	port map(
		AIN => AIN, 
		BIN => BIN, 
		CIN => CIN, 
		DIN => DIN, 
		MXOUT => MXOUT, 
		SELMX => SELMX
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
		wait for 10 ns;
		AIN <= X"000000000000000F";
		BIN <= X"000000000000FFFF";
		CIN <= X"FFFF000000000000";
		DIN <= X"0000FFFF00000000";
		SELMX <= "00";
		wait for 10 ns;
		AIN <= X"0000000000000000";
		BIN <= X"000000000000FFFF";
		CIN <= X"FFFF000000000000";
		DIN <= X"0000FFFF00000000";
		SELMX <= "01";
		wait for 10 ns;
		AIN <= X"0000000000000000";
		BIN <= X"000000000000FFFF";
		CIN <= X"FFFF000000000000";
		DIN <= X"0000FFFF00000000";
		SELMX <= "10";
		wait for 10 ns;
		AIN <= X"0000000000000000";
		BIN <= X"000000000000FFFF";
		CIN <= X"FFFF000000000000";
		DIN <= X"0000FFFF00000000";
		SELMX <= "11";

		-- wait for _period*10;

		-- insert stimulus here

		wait;
	end process;

	end;