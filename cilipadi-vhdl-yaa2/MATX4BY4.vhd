----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:47:34 04/11/2015 
-- Design Name: 
-- Module Name:    Multiplier_Matrix5by5 - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MATX4BY4 is
    Port ( In_Mat : in  STD_LOGIC_VECTOR (0 to 63  );
	        Out_Mat : out  STD_LOGIC_VECTOR (0 to 63  ));
end MATX4BY4;

architecture Behavioral of MATX4BY4 is


  COMPONENT COMP4BIT
    PORT(
         Data_INA  : IN  std_logic_vector ( 0 to 3);
         Data_INB  : IN  std_logic_vector ( 0 to 3);
         Data_OutC : out  std_logic_vector( 0 to 3)
        );
    END COMPONENT;


-------------------------------------------------------------------------------------------------------------------------	
	signal sout001, sout002, sout003, sout004, sout005 :  STD_LOGIC_VECTOR ( 0 to 3); --1st element first Col
	signal sout011, sout012, sout013, sout014, sout015 :  STD_LOGIC_VECTOR ( 0 to 3); --2nd element first Col
	signal sout021, sout022, sout023, sout024, sout025 :  STD_LOGIC_VECTOR ( 0 to 3); --3rd element first Col
 	signal sout031, sout032, sout033, sout034, sout035 :  STD_LOGIC_VECTOR ( 0 to 3); --4th element first Col
 	signal sout041, sout042, sout043, sout044, sout045 :  STD_LOGIC_VECTOR ( 0 to 3); --5th element first Col
	
	--------------------------------------------------------------------------------------------------------------
 
	signal R_Mat00, R_Mat01, R_Mat02, R_Mat03, R_Mat04 :  STD_LOGIC_VECTOR ( 0 to 3);
	 
 ------------------------------------------------------------------------------------------------------------------
   signal sout101, sout102, sout103, sout104, sout105 :  STD_LOGIC_VECTOR ( 0 to 3); --firtst element 2nd Col
	signal sout111, sout112, sout113, sout114, sout115 :  STD_LOGIC_VECTOR ( 0 to 3); --2nd element 2nd Col
	signal sout121, sout122, sout123, sout124, sout125 :  STD_LOGIC_VECTOR ( 0 to 3); --3rd element 2nd Col
 	signal sout131, sout132, sout133, sout134, sout135 :  STD_LOGIC_VECTOR ( 0 to 3); --4rd element 2nd Col
 	signal sout141, sout142, sout143, sout144, sout145 :  STD_LOGIC_VECTOR ( 0 to 3); --4rd element 2nd Col

	signal R_Mat10, R_Mat11, R_Mat12, R_Mat13, R_Mat14 :  STD_LOGIC_VECTOR ( 0 to 3);
	
	
	------------------------------------------------------------------------------------------------------------------
   signal sout201, sout202, sout203, sout204, sout205 :  STD_LOGIC_VECTOR ( 0 to 3); --1st element 3rd Col
	signal sout211, sout212, sout213, sout214, sout215 :  STD_LOGIC_VECTOR ( 0 to 3); --2nd element 3rd Col
	signal sout221, sout222, sout223, sout224, sout225 :  STD_LOGIC_VECTOR ( 0 to 3); --3rd element 3rd Col
 	signal sout231, sout232, sout233, sout234, sout235 :  STD_LOGIC_VECTOR ( 0 to 3); --4th element 3rd Col
 	signal sout241, sout242, sout243, sout244, sout245 :  STD_LOGIC_VECTOR ( 0 to 3); --5th element 3rd Col

	signal R_Mat20, R_Mat21, R_Mat22, R_Mat23, R_Mat24 :  STD_LOGIC_VECTOR ( 0 to 3);
	------------------------------------------------------------------------------------------------------------------------
	
	
	signal sout301, sout302, sout303, sout304, sout305 :  STD_LOGIC_VECTOR ( 0 to 3); --1st element 4th Col
	signal sout311, sout312, sout313, sout314, sout315 :  STD_LOGIC_VECTOR ( 0 to 3); --2nd element 4th Col
	signal sout321, sout322, sout323, sout324, sout325 :  STD_LOGIC_VECTOR ( 0 to 3); --3rd element 4th Col
 	signal sout331, sout332, sout333, sout334, sout335 :  STD_LOGIC_VECTOR ( 0 to 3); --4th element 4th Col
 	signal sout341, sout342, sout343, sout344, sout345 :  STD_LOGIC_VECTOR ( 0 to 3); --5th element 4th Col

	signal R_Mat30, R_Mat31, R_Mat32, R_Mat33, R_Mat34 :  STD_LOGIC_VECTOR ( 0 to 3);
	
	
	------------------------------------------------------------------------------------------------------------------------
	
	
	signal sout401, sout402, sout403, sout404, sout405 :  STD_LOGIC_VECTOR ( 0 to 3); --firtst element 5th Col
	signal sout411, sout412, sout413, sout414, sout415 :  STD_LOGIC_VECTOR ( 0 to 3); --2nd element 5th Col
	signal sout421, sout422, sout423, sout424, sout425 :  STD_LOGIC_VECTOR ( 0 to 3); --3rd element 5th Col
 	signal sout431, sout432, sout433, sout434, sout435 :  STD_LOGIC_VECTOR ( 0 to 3); --4th element 5th Col
 	signal sout441, sout442, sout443, sout444, sout445 :  STD_LOGIC_VECTOR ( 0 to 3); --5th element 5th Col

	signal R_Mat40, R_Mat41, R_Mat42, R_Mat43, R_Mat44 :  STD_LOGIC_VECTOR ( 0 to 3);
	 
 ------------------------------------------------------------------------------------------------------------------


Type Matrix5by5_ARRAY is array 
  (integer range 1 to  16 ) of std_logic_vector ( 0 to 3);
   constant Mat5 : Matrix5by5_ARRAY := (x"4",x"1", x"2", x"2", 
	                                     x"8",x"6", x"5", x"6", 
													 x"B",x"E", X"A", x"9", 
													 x"2",x"2", x"F", x"B" );

	   
													 												 
													 
														 
begin

  uut001: COMP4BIT PORT MAP ( Data_INA => In_Mat (0 to 3 )  , Data_INB => Mat5 (1) , Data_OutC=> Sout001);
     uut002: COMP4BIT PORT MAP (Data_INA =>  In_Mat(16 to 19 ) , Data_INB => Mat5 (2), Data_OutC=> Sout002);
	    uut003: COMP4BIT PORT MAP (Data_INA => In_Mat ( 32 TO 35)  , Data_INB => Mat5 (3), Data_OutC=> Sout003);
		  uut004: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 48 TO 51)   , Data_INB => Mat5 (4), Data_OutC=> Sout004);
			  
				 
			  	R_Mat00 <= Sout001 XOR Sout002 XOR Sout003 XOR Sout004  ;
				 Out_Mat ( 0 TO 3) <= R_Mat00; 
        
-------------------------------------------------------------------------------------
 	 
 uut011: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 0 TO 3)  ,Data_INB  =>  Mat5 (5), Data_OutC=> Sout011);
  uut012: COMP4BIT PORT MAP (Data_INA => In_Mat ( 16 to 19)   , Data_INB => Mat5 (6), Data_OutC=> Sout012);
   uut0131: COMP4BIT PORT MAP (Data_INA => In_Mat ( 32 TO 35)  , Data_INB => Mat5 (7)  , Data_OutC=> Sout013);
    uut0141: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 48 TO 51)  , Data_INB =>  Mat5 (8) , Data_OutC=> Sout014);
  			 
   			R_Mat01 <= Sout011 XOR Sout012 XOR Sout013 XOR Sout014 ;

			  Out_Mat ( 16 to 19) <= R_Mat01 ;
 
-------------------- ---------------------------------------------------------------------------
 uut021: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 0 TO 3) , Data_INB => Mat5 (9) , Data_OutC=> Sout021);
   uut022: COMP4BIT PORT MAP (Data_INA => In_Mat ( 16 to 19) , Data_INB => Mat5 (10), Data_OutC=> Sout022);
    uut023: COMP4BIT PORT MAP (Data_INA => In_Mat ( 32 TO 35) , Data_INB => Mat5 (11) , Data_OutC=> Sout023);
	   uut024: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 48 TO 51), Data_INB => Mat5 (12) , Data_OutC=> Sout024);
			  
 			 R_Mat02 <= Sout021 XOR Sout022 XOR Sout023 XOR Sout024 ;
			 			  	 
			  Out_Mat ( 32 TO 35)   <=  R_Mat02 ;
			 
--------------------------------------------------------------------------------------------------------------------
uut031: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 0 TO 3) , Data_INB =>  Mat5 (13) , Data_OutC=> Sout031);
    uut032: COMP4BIT PORT MAP (Data_INA => In_Mat ( 16 to 19) , Data_INB =>  Mat5 (14), Data_OutC=> Sout032);
	   uut033: COMP4BIT PORT MAP (Data_INA => In_Mat ( 32 TO 35) , Data_INB =>  Mat5 (15), Data_OutC=> Sout033);
		  uut034: COMP4BIT PORT MAP ( Data_INA =>In_Mat ( 48 TO 51), Data_INB =>  Mat5 (16), Data_OutC=> Sout034);
			 
					 
			R_Mat03 <= Sout031 XOR Sout032 XOR Sout033 XOR Sout034 ;
						
				Out_Mat ( 48 TO 51)  <=  R_Mat03 ;
				 
-----------------------------------------------------------------------------------------------------------

 ------------------Secod Coloum--------------------------
---------------------------------------------------------			
 uut101: COMP4BIT PORT MAP ( Data_INA => Mat5 (1) , Data_INB => In_Mat ( 4 TO 7), Data_OutC=> Sout101);
    uut102: COMP4BIT PORT MAP (Data_INA =>  Mat5 (2) , Data_INB => In_Mat ( 20 TO 23), Data_OutC=> Sout102);
	   uut103: COMP4BIT PORT MAP (Data_INA => Mat5 (3) , Data_INB => In_Mat ( 36 TO 39), Data_OutC=> Sout103);
		  uut104: COMP4BIT PORT MAP ( Data_INA =>  Mat5 (4) , Data_INB => In_Mat ( 52 to 55) , Data_OutC=> Sout104);
			 
			R_Mat10 <= Sout101 XOR Sout102 XOR Sout103 XOR Sout104;
      
	  Out_Mat ( 4 TO 7)   <=  R_Mat10 ;
	 
-------------------------------------------------------------------------------------
	uut111: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 4 TO 7) , Data_INB => Mat5 (5) , Data_OutC=> Sout111);
    uut112: COMP4BIT PORT MAP (Data_INA => In_Mat ( 20 TO 23) , Data_INB => Mat5 (6), Data_OutC=> Sout112);
	   uut113: COMP4BIT PORT MAP (Data_INA => In_Mat ( 36 TO 39) , Data_INB => Mat5 (7) , Data_OutC=> Sout113);
		  uut114: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 52 to 55) , Data_INB => Mat5 (8) , Data_OutC=> Sout114);
			 
			R_Mat11 <= Sout111 XOR Sout112 XOR Sout113 XOR Sout114 ;
 
		 	  Out_Mat ( 20 TO 23)   <=  R_Mat11 ;
 
--------------------------------------------------------------------------------------------
uut121: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 4 TO 7) , Data_INB => Mat5 (9) , Data_OutC=> Sout121);
    uut122: COMP4BIT PORT MAP (Data_INA => In_Mat ( 20 TO 23) , Data_INB => Mat5 (10), Data_OutC=> Sout122);
	   uut123: COMP4BIT PORT MAP (Data_INA => In_Mat ( 36 TO 39) , Data_INB => Mat5 (11) , Data_OutC=> Sout123);
		  uut124: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 52 to 55) , Data_INB => Mat5 (12) , Data_OutC=> Sout124);

		 
			R_Mat12 <= Sout121 XOR Sout122 XOR Sout123 XOR Sout124 ;
			 
			   Out_Mat ( 36 TO 39)   <=  R_Mat12 ;
			
			
----------------------------------------------------------------------------------------------------------------
uut131: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 4 TO 7) , Data_INB =>  Mat5 (13) , Data_OutC=> Sout131);
    uut132: COMP4BIT PORT MAP (Data_INA => In_Mat ( 20 TO 23) , Data_INB =>  Mat5 (14), Data_OutC=> Sout132);
	   uut133: COMP4BIT PORT MAP (Data_INA => In_Mat ( 36 TO 39) , Data_INB =>  Mat5 (15), Data_OutC=> Sout133);
		  uut134: COMP4BIT PORT MAP ( Data_INA =>In_Mat ( 52 to 55) , Data_INB =>  Mat5 (16), Data_OutC=> Sout134);
			
			 
			R_Mat13 <= Sout131 XOR Sout132 XOR Sout133 XOR Sout134 ;
			 
		 			   Out_Mat ( 52 to 55)   <=  R_Mat13 ;
---------------------------------------------------------------------------------------------------------
			
------------------------------------------------------------
--------------------	Third Coloum--------------------------
---------------------------------------------------------			
 uut201: COMP4BIT PORT MAP ( Data_INA => Mat5 (1) , Data_INB => In_Mat ( 8 to 11), Data_OutC=> Sout201);
    uut202: COMP4BIT PORT MAP (Data_INA =>  Mat5 (2) , Data_INB => In_Mat ( 24 to 27), Data_OutC=> Sout202);
	   uut203: COMP4BIT PORT MAP (Data_INA => Mat5 (3) , Data_INB => In_Mat ( 40 TO 43), Data_OutC=> Sout203);
		  uut204: COMP4BIT PORT MAP ( Data_INA =>  Mat5 (4) , Data_INB => In_Mat ( 56 to 59) , Data_OutC=> Sout204);
			 
			R_Mat20 <= Sout201 XOR Sout202 XOR Sout203 XOR Sout204 ;

--------------------------------------------------
	  Out_Mat ( 8 to 11)   <=  R_Mat20 ;
	-------------------------------------------------------------------------
	 
	-------------------------------------------------------------------------------------
	uut211: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 8 to 11) , Data_INB => Mat5 (5) , Data_OutC=> Sout211);
    uut212: COMP4BIT PORT MAP (Data_INA => In_Mat ( 24 TO 27) , Data_INB => Mat5 (6), Data_OutC=> Sout212);
	   uut213: COMP4BIT PORT MAP (Data_INA => In_Mat ( 40 TO 43) , Data_INB => Mat5 (7) , Data_OutC=> Sout213);
		  uut214: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 56 TO 59) , Data_INB => Mat5 (8) , Data_OutC=> Sout214);
			 
			R_Mat21 <= Sout211 XOR Sout212 XOR Sout213 XOR Sout214;
 
		 	  Out_Mat ( 24 TO 27)   <=  R_Mat21 ;
 
 ------------------------------------------------ 
  
------------------ ---------------------------------------------------------------------------
uut221: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 8 to 11) , Data_INB => Mat5 (9) , Data_OutC=> Sout221);
    uut222: COMP4BIT PORT MAP (Data_INA => In_Mat ( 24 TO 27) , Data_INB => Mat5 (10), Data_OutC=> Sout222);
	   uut223: COMP4BIT PORT MAP (Data_INA => In_Mat ( 40 TO 43) , Data_INB => Mat5 (11) , Data_OutC=> Sout223);
		  uut224: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 56 TO 59) , Data_INB => Mat5 (12) , Data_OutC=> Sout224);

		 
			R_Mat22 <= Sout221 XOR Sout222 XOR Sout223 XOR Sout224 ;
			Out_Mat ( 40 TO 43)   <=  R_Mat22 ;
			
----------------------------------------------------------------------------------------------------------------
uut231: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 8 to 11) , Data_INB =>  Mat5 (13) , Data_OutC=> Sout231);
    uut232: COMP4BIT PORT MAP (Data_INA => In_Mat ( 24 TO 27) , Data_INB =>  Mat5 (14), Data_OutC=> Sout232);
	   uut233: COMP4BIT PORT MAP (Data_INA => In_Mat ( 40 TO 43) , Data_INB =>  Mat5 (15), Data_OutC=> Sout233);
		  uut234: COMP4BIT PORT MAP ( Data_INA =>In_Mat ( 56 TO 59) , Data_INB =>  Mat5 (16), Data_OutC=> Sout234);
			
			 
			R_Mat23 <= Sout231 XOR Sout232 XOR Sout233 XOR Sout234 ;
			 
		 	 Out_Mat ( 56 TO 59)   <=  R_Mat23 ;
---------------------------------------------------------------------------------------------------------

--------------------------------------------------------
--------------------	Fourth Coloum--------------------------
---------------------------------------------------------			
 uut301: COMP4BIT PORT MAP ( Data_INA => Mat5 (1) , Data_INB => In_Mat ( 12 TO 15), Data_OutC=> Sout301);
    uut302: COMP4BIT PORT MAP (Data_INA =>  Mat5 (2) , Data_INB => In_Mat (28 TO 31), Data_OutC=> Sout302);
	   uut303: COMP4BIT PORT MAP (Data_INA => Mat5 (3) , Data_INB => In_Mat (44 to 47), Data_OutC=> Sout303);
		  uut304: COMP4BIT PORT MAP ( Data_INA =>  Mat5 (4) , Data_INB => In_Mat (60  TO 63) , Data_OutC=> Sout304);
			 
			R_Mat30 <= Sout301 XOR Sout302 XOR Sout303 XOR Sout304 ;

--------------------------------------------------
	 Out_Mat ( 12 TO 15)   <=  R_Mat30 ;
	-------------------------------------------------------------------------
	 
	-------------------------------------------------------------------------------------
	uut311: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 12 TO 15) , Data_INB => Mat5 (5) , Data_OutC=> Sout311);
    uut312: COMP4BIT PORT MAP (Data_INA => In_Mat (28 TO 31) , Data_INB => Mat5 (6), Data_OutC=> Sout312);
	   uut313: COMP4BIT PORT MAP (Data_INA => In_Mat (44 to 47) , Data_INB => Mat5 (7) , Data_OutC=> Sout313);
		  uut314: COMP4BIT PORT MAP ( Data_INA => In_Mat (60  TO 63) , Data_INB => Mat5 (8) , Data_OutC=> Sout314);
			 
			R_Mat31 <= Sout311 XOR Sout312 XOR Sout313 XOR Sout314 ;
 
			 Out_Mat (28 TO 31)   <=  R_Mat31 ;
 
 ------------------------------------------------ 
  
------------------ ---------------------------------------------------------------------------
uut321: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 12 TO 15) , Data_INB => Mat5 (9) , Data_OutC=> Sout321);
    uut322: COMP4BIT PORT MAP (Data_INA => In_Mat (28 to 31) , Data_INB => Mat5 (10), Data_OutC=> Sout322);
	   uut323: COMP4BIT PORT MAP (Data_INA => In_Mat (44 to 47) , Data_INB => Mat5 (11) , Data_OutC=> Sout323);
		  uut324: COMP4BIT PORT MAP ( Data_INA => In_Mat (60  TO 63) , Data_INB => Mat5 (12) , Data_OutC=> Sout324);

		 
			R_Mat32 <= Sout321 XOR Sout322 XOR Sout323 XOR Sout324 ;
			 
			 Out_Mat (44 to 47)   <=  R_Mat32 ;
			
			
----------------------------------------------------------------------------------------------------------------
uut331: COMP4BIT PORT MAP ( Data_INA => In_Mat ( 12 TO 15) , Data_INB =>  Mat5 (13) , Data_OutC=> Sout331);
    uut332: COMP4BIT PORT MAP (Data_INA => In_Mat (28 TO 31) , Data_INB =>  Mat5 (14), Data_OutC=> Sout332);
	   uut333: COMP4BIT PORT MAP (Data_INA => In_Mat (44 to 47) , Data_INB =>  Mat5 (15), Data_OutC=> Sout333);
		  uut334: COMP4BIT PORT MAP ( Data_INA =>In_Mat (60  TO 63) , Data_INB =>  Mat5 (16), Data_OutC=> Sout334);
			
			 
			R_Mat33 <= Sout331 XOR Sout332 XOR Sout333 XOR Sout334 ;
			 
			 Out_Mat (60  TO 63)   <=  R_Mat33 ;		
---------------------------------------------------------------------------------------------------------
	
end Behavioral;

