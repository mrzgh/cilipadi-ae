----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 16:23:42 08/17/2015
-- Design Name:
-- Module Name: LEB_RND - Behavioral
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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity LEB_RND is
	port (
		DATAIN : in STD_LOGIC_VECTOR (0 to 63);
		DATAOUT : out STD_LOGIC_VECTOR (0 to 63);
		-- OUTAC, OUTSBX, OUTSHF,OUTMX : out STD_LOGIC_VECTOR (0 TO 63);
		CLK : in STD_LOGIC;
		CONST1, CONST2, CONST3, CONST4 : in STD_LOGIC_VECTOR (0 to 3);
		CONST5, CONST6, CONST7, CONST8 : in STD_LOGIC_VECTOR (0 to 3)
	);
end LEB_RND;

architecture Behavioral of LEB_RND is

 
	---------------------------------AddConst--------------------------------- 
	component AddConst
		port (
			ADIN : in std_logic_vector(0 to 63);
			RC5, RC6, RC7, RC8 : in STD_LOGIC_VECTOR (0 to 3);
			RC1, RC2, RC3, RC4 : in STD_LOGIC_VECTOR (0 to 3);
			ADOUT : out std_logic_vector(0 to 63)
		);
	end component;

	---------------------------------SBOX---------------------------------
	component SBox_PRES64
		port (
			SBox64_IN : in std_logic_vector(0 to 63);
			SBox64_OUT : out std_logic_vector(0 to 63)
		);
	end component; 
	---------------------------------SHIFT ROW---------------------------------
	component Shift4C
		port (
			DINSHF : in std_logic_vector(0 to 63);
			DOUTSHF : out std_logic_vector(0 to 63)
		);
	end component; 
 
	---------------------------------MIX COLUMNS---------------------------------
 
	component MATX4BY4
		port (
			In_Mat : in std_logic_vector(0 to 63);
			Out_Mat : out std_logic_vector(0 to 63)
		);
	end component;
	signal ACRND, SBXRND, SHFRND : std_logic_vector(0 to 63);

begin
	---------------------------------AddConst--------------------------------- 
	uutAC : AddConst
	port map(
		ADIN => DATAIN, 
		RC1 => CONST1, 
		RC2 => CONST2, 
		RC3 => CONST3, 
		RC4 => CONST4, 

		RC5 => CONST5, 
		RC6 => CONST6, 
		RC7 => CONST7, 
		RC8 => CONST8, 
 
		ADOUT => ACRND
	);
	-- OUTAC <= ACRND;
	---------------------------------SBOX---------------------------------
	uutSBOX : SBox_PRES64
	port map(
		SBox64_IN => ACRND, 
		SBox64_OUT => SBXRND
	);
	-- OUTSBX <= SBXRND; 
	---------------------------------SHIFT--------------------------------- 
	uutSHFIT : Shift4C
	port map(
		DINSHF => SBXRND, 
		DOUTSHF => SHFRND
	);
	-- OUTSHF <= SHFRND; 
	---------------------------------MIX 4BY4---------------------------------
	uutMIX : MATX4BY4
	port map(
		In_Mat => SHFRND, 
		Out_Mat => DATAOUT
	);
	-----------------------------------------------------------------------
end Behavioral;