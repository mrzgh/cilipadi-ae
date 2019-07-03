--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 22:26:35 04/05/2019
-- Design Name: 
-- Module Name: F:/VHDL/CilipadiLED/LED2R_TB.vhd
-- Project Name: LED64_FSM
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

entity LED2R_TB is
end LED2R_TB;

architecture behavior of LED2R_TB is

	-- Component Declaration for the Unit Under Test (UUT)

	component LEB_RND
		port (
			DATAIN : in std_logic_vector(0 to 63);
			DATAOUT : out std_logic_vector(0 to 63);
			CLK : in std_logic;
			CONST1 : in std_logic_vector(0 to 3);
			CONST2 : in std_logic_vector(0 to 3);
			CONST3 : in std_logic_vector(0 to 3);
			CONST4 : in std_logic_vector(0 to 3);
			CONST5 : in std_logic_vector(0 to 3);
			CONST6 : in std_logic_vector(0 to 3);
			CONST7 : in std_logic_vector(0 to 3);
			CONST8 : in std_logic_vector(0 to 3);
			CONST21 : in std_logic_vector(0 to 3);
			CONST22 : in std_logic_vector(0 to 3);
			CONST23 : in std_logic_vector(0 to 3);
			CONST24 : in std_logic_vector(0 to 3);
			CONST25 : in std_logic_vector(0 to 3);
			CONST26 : in std_logic_vector(0 to 3);
			CONST27 : in std_logic_vector(0 to 3);
			CONST28 : in std_logic_vector(0 to 3)
		);
	end component;
 

	-- Inputs
	signal DATAIN : std_logic_vector(0 to 63) := (others => '0');
	signal CLK : std_logic := '0';
	signal CONST1 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST2 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST3 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST4 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST5 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST6 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST7 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST8 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST21 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST22 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST23 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST24 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST25 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST26 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST27 : std_logic_vector(0 to 3) := (others => '0');
	signal CONST28 : std_logic_vector(0 to 3) := (others => '0');

	-- Outputs
	signal DATAOUT : std_logic_vector(0 to 63);

	-- Clock period definitions
	constant CLK_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
	uut : LEB_RND
	port map(
		DATAIN => DATAIN, 
		DATAOUT => DATAOUT, 
		CLK => CLK, 
		CONST1 => CONST1, 
		CONST2 => CONST2, 
		CONST3 => CONST3, 
		CONST4 => CONST4, 
		CONST5 => CONST5, 
		CONST6 => CONST6, 
		CONST7 => CONST7, 
		CONST8 => CONST8, 
		CONST21 => CONST21, 
		CONST22 => CONST22, 
		CONST23 => CONST23, 
		CONST24 => CONST24, 
		CONST25 => CONST25, 
		CONST26 => CONST26, 
		CONST27 => CONST27, 
		CONST28 => CONST28
	);

	-- Clock process definitions
	CLK_process : process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;
	-- Stimulus process
	stim_proc : process
	begin
		-- hold reset state for 100 ns.
		wait for 100 ns; 

		wait for CLK_period * 10;

		-- insert stimulus here
 
		DATAIN <= x"0000000000000000";
		CLK <= '1';
		CONST1 <= x"0";
		CONST2 <= x"1";
		CONST3 <= x"2";
		CONST4 <= x"3";
		CONST5 <= x"0";
		CONST6 <= x"1";
		CONST7 <= x"0";
		CONST8 <= x"1";
		CONST21 <= x"0";
		CONST22 <= x"0";
		CONST23 <= x"0";
		CONST24 <= x"0";
		CONST25 <= x"0";
		CONST26 <= x"0";
		CONST27 <= x"0";
		CONST28 <= x"0";

		wait;
	end process;

	end;