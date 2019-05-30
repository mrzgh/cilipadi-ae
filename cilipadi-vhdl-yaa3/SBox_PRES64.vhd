----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:29:00 08/16/2015 
-- Design Name: 
-- Module Name:    SBox_PRES64 - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SBox_PRES64 is


    Port ( SBox64_IN : in  STD_LOGIC_VECTOR (0 to 63);
           SBox64_OUT : out  STD_LOGIC_VECTOR (0 to 63));

end SBox_PRES64;

architecture Behavioral of SBox_PRES64 is



COMPONENT  SBox_4BitPRESENT
    Port ( SBox4_In : in  STD_LOGIC_VECTOR (0 to 3);
           SBox4_Out : out  STD_LOGIC_VECTOR (0 to 3));
end COMPONENT;

 signal      a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15  : std_logic_vector (3 downto 0); 
 signal      s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14, s15 : std_logic_vector (3 downto 0);
begin



---------------------------------------------------
   Sbox_0 : SBox_4BitPRESENT
	   port map (
                 SBox4_IN  => a0 ,	
                 SBox4_OUT => S0 
		              );
------------------------------	
    Sbox_1 : SBox_4BitPRESENT 
	   port map (
               SBox4_IN  => a1,	
               SBox4_OUT  => S1
		               );
-----------------------------------	
  Sbox_2 : SBox_4BitPRESENT 
	    port map (
                 SBox4_IN  => a2,	
                 SBox4_OUT  => S2
	              );
-------------------------------------	
box_3 : SBox_4BitPRESENT 
	    port map (
                  SBox4_IN  => a3,	
                  SBox4_OUT  => S3
	               );
-----------------------------------	
Sbox_4 : SBox_4BitPRESENT 
    port map (
                 SBox4_IN  => a4,	
                 SBox4_OUT  => S4
	               );
-----------------------------------	
Sbox_5 : SBox_4BitPRESENT 
	    port map (
                 SBox4_IN  => a5,	
                  SBox4_OUT  => S5
						);
-----------------------------------	
Sbox_6 : SBox_4BitPRESENT 
	    port map (
                  SBox4_IN  => a6,	
                 SBox4_OUT  => S6
	               );
-----------------------------------	
Sbox_7 : SBox_4BitPRESENT 
	   port map (
                  SBox4_IN  => a7,	
                  SBox4_OUT  => S7
		               );
-------------------------------------	
Sbox_8 : SBox_4BitPRESENT 
	    port map (
                  SBox4_IN  => a8,	
                  SBox4_OUT  => S8
		               );
-----------------------------------	
Sbox_9 : SBox_4BitPRESENT 
    port map (
                 SBox4_IN  => a9,	
                  SBox4_OUT  => S9
	               );
-----------------------------------	
Sbox_10 : SBox_4BitPRESENT 
    port map (
                 SBox4_IN  => a10,	
                  SBox4_OUT  => S10
		               );						
 -------------------------------	
Sbox_11 : SBox_4BitPRESENT 
	    port map (
                  SBox4_IN  => a11,	
                  SBox4_OUT  => S11
		               );
-----------------------------------	
Sbox_12 : SBox_4BitPRESENT 
	    port map (
                  SBox4_IN  => a12,	
                  SBox4_OUT  => S12
	               );
-----------------------------------	
Sbox_13 : SBox_4BitPRESENT 
	    port map (
                  SBox4_IN  => a13,	
                 SBox4_OUT  => S13
		               );
-----------------------------------	
Sbox_14 : SBox_4BitPRESENT 
    port map (
                 SBox4_IN  => a14,	
                 SBox4_OUT  => S14
	               );
-----------------------------------	
Sbox_15 : SBox_4BitPRESENT 
	    port map (
                  SBox4_IN  => a15,	
                 SBox4_OUT  => S15
		               );

----------------------------------------

 a15 <= SBox64_IN ( 60 to 63);  
 a14 <= SBox64_IN (56 to 59);    
 a13 <= SBox64_IN (52 to 55);   
 a12 <= SBox64_IN (48 to 51);  
 a11 <= SBox64_IN (44 to 47) ; 
 a10 <= SBox64_IN (40 to 43);  
 a9  <= SBox64_IN (36 to 39) ; 
 a8  <= SBox64_IN (32 to 35); 
 a7  <= SBox64_IN (28 to 31);  
 a6  <= SBox64_IN (24 to 27);   
 a5  <= SBox64_IN ( 20 to 23);  
 a4  <= SBox64_IN ( 16 to 19);  
 a3  <= SBox64_IN ( 12 to 15); 
 a2  <= SBox64_IN ( 8 to 11);  
 a1  <= SBox64_IN ( 4 to 7);  
 a0  <= SBox64_IN ( 0 to 3 ) ;  
 
 
 SBox64_OUT  ( 60 to 63) <= S15 ;
 SBox64_OUT  ( 56 to 59) <= S14 ;
 SBox64_OUT  (52 to 55)<= S13 ;
 SBox64_OUT  (48 to 51) <= s12 ;
 SBox64_OUT  (44 to 47) <= s11 ;
 SBox64_OUT  (40 to 43)<= s10 ;
 SBox64_OUT  (36 to 39) <= s9  ;
 SBox64_OUT (32 to 35) <= s8  ;
 SBox64_OUT  (28 to 31) <= s7  ;
 SBox64_OUT (24 to 27)<= s6  ;
 SBox64_OUT  ( 20 to 23) <= s5  ;
 SBox64_OUT ( 16 to 19) <= s4  ;
 SBox64_OUT  ( 12 to 15) <= s3  ;
 SBox64_OUT  ( 8 to 11) <= s2  ;
 SBox64_OUT   ( 4 to 7) <= s1  ;
 SBox64_OUT  ( 0 to 3 ) <= s0  ;
 


end Behavioral;




