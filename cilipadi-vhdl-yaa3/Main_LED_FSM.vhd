----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:06:44 08/18/2015 
-- Design Name: 
-- Module Name:    Main_LED_FSM - Behavioral 
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Main_LED_FSM is
    Port ( N : in  STD_LOGIC_VECTOR (0 to 127);

	        K : in STD_LOGIC_VECTOR (0 to 127);
		  ---  AD : in STD_LOGIC_VECTOR (0 to 63);
		   --- MODE : in STD_LOGIC_VECTOR (0 to 1);
           clock : in  STD_LOGIC;
           ctr : in  STD_LOGIC;
           rst, load : in  STD_LOGIC;
			--  CONT : OUT  STD_LOGIC;
			   Tag : out  STD_LOGIC_VECTOR (0 to 63);
			--	Rk2out : out  STD_LOGIC_VECTOR (0 to 63);
			--	RN1out : out  STD_LOGIC_VECTOR (0 to 63);
			--	RN2out : out  STD_LOGIC_VECTOR (0 to 63);
			--	Ct : out  integer ;
           Ciphertext : out  STD_LOGIC_VECTOR (0 to 63));
end Main_LED_FSM;

architecture Behavioral of Main_LED_FSM is


COMPONENT LEB_RND
    PORT(
         DATAIN : IN  std_logic_vector(0 to 63);
         DATAOUT : OUT  std_logic_vector(0 to 63);
--			 OUTAC, OUTSBX, OUTSHF,OUTMX : out  STD_LOGIC_VECTOR (0 TO 63);
         CLK : IN  std_logic;
          
         CONST1 , CONST2,CONST3,CONST4 : IN  std_logic_vector(0 to 3);
			CONST5 , CONST6,CONST7,CONST8 : IN  std_logic_vector(0 to 3);
		 
			  
			  CONST21,CONST22,CONST23 , CONST24 : in  STD_LOGIC_VECTOR (0 TO 3);
			  CONST25,CONST26,CONST27 , CONST28 : in  STD_LOGIC_VECTOR (0 TO 3)
        );
    END COMPONENT;
	 
--------------------------
 COMPONENT MUX64
    PORT(
         AIN : IN  std_logic_vector(0 to 63);
         BIN : IN  std_logic_vector(0 to 63);
         CIN : IN  std_logic_vector(0 to 63);
         DIN : IN  std_logic_vector(0 to 63);
         MXOUT : OUT  std_logic_vector(0 to 63);
         SELMX : IN  std_logic_vector(0 to 1)
        );
    END COMPONENT;
-----------------------------------------------
 COMPONENT reg64
    PORT(
         I : IN  std_logic_vector(0 to 63);
         clock : IN  std_logic;
        load : IN  std_logic;
       rst : IN  std_logic;
         Q : OUT  std_logic_vector(0 to 63)
        );
    END COMPONENT;
    -------------------------------------
--  COMPONENT MUX64_2X1
--    PORT(
--         A : IN  std_logic_vector(0 to 63);
--         B : IN  std_logic_vector(0 to 63);
--         MOUT : OUT  std_logic_vector(0 to 63);
--         SEL : IN  std_logic
--        );
--    END COMPONENT;
--    	 

signal   DINrnd, DOUTrnd , KEY :std_logic_vector(0 to 63);
signal  C1, C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16 :  std_logic_vector (0 to 3);
 

signal  AK1, BK1,CK1,DK1, MXOUTK1 :std_logic_vector(0 to 63);
signal  AN1, BN1,CN1,DN1, MXOUTN1 :std_logic_vector(0 to 63);

signal  AK2, BK2, CK2,DK2, MXOUTK2:std_logic_vector(0 to 63);
signal  AN2, BN2,CN2,DN2, MXOUTN2:std_logic_vector(0 to 63);

signal  A1 :std_logic_vector(0 to 63) := x"ffffffffffffffff" ;
signal  xc, xc1 :std_logic_vector(0 to 63);
-- signal SELK2, SELN2 :   std_logic;
signal  SELK1,SELN1 , SELK2, SELN2  :  std_logic_vector (0 to 1);
 SIGNAL  RINK1, RINK2, RINN1,RINN2, ROUTK1,ROUTK2, ROUTN1, ROUTN2 :std_logic_vector(0 to 63);

signal   K2RLED, N2RLED , KI1,NI1   :std_logic_vector(0 to 63);
--------------------------
       
Type ICD_ARRAY is array 
 (integer range 1 to 36) of std_logic_vector (0 to 3);
 constant ICD1 : ICD_ARRAY := (x"0",  x"0", x"0",  x"0", x"0", x"0", x"0", x"0", x"0",  x"0", x"0",  x"0", x"0", x"0", x"0", x"0", x"0",  x"0", x"0", x"0", x"0", x"0", x"0",  x"0", x"0",  x"0", x"0", x"0", x"0", x"0", x"0", x"0",  x"0",  x"0",  x"0", x"0");
 constant ICD2 : ICD_ARRAY := (x"1",  x"2", x"1",  x"2", x"1", x"2", x"1", x"2", x"1",  x"2", x"1",  x"2", x"1", x"2", x"1", x"2", x"1",  x"2", x"1", x"2", x"1", x"2", x"1",  x"2", x"1",  x"2", x"1", x"2", x"1", x"2", x"1", x"2",  x"1",  x"2",  x"1", x"2");
 constant ICD3 : ICD_ARRAY := (x"2",  x"2", x"2",  x"2", x"2", x"2", x"2", x"2", x"2",  x"2", x"2",  x"2", x"2", x"2", x"2", x"2", x"2",  x"2", x"2", x"2", x"2", x"2", x"2",  x"2", x"2",  x"2", x"2", x"2", x"2", x"2", x"2", x"2",  x"2",  x"2",  x"2", x"2");
 constant ICD4 : ICD_ARRAY := (x"3",  x"3", x"3",  x"3", x"3", x"3", x"3", x"3", x"3",  x"3", x"3",  x"3", x"3", x"3", x"3", x"3", x"3",  x"3", x"3", x"3", x"3", x"3", x"3",  x"3", x"3",  x"3", x"3", x"3", x"3", x"3", x"3", x"3",  x"3",  x"3",  x"3", x"3");
 constant ICD5 : ICD_ARRAY := (x"0",  x"0", x"0",  x"0", x"0", x"0", x"1", x"1", x"3",  x"3", x"7",  x"7", x"7", x"7", x"7", x"7", x"6",  x"6", x"5", x"5", x"3", x"3", x"7",  x"7", x"7",  x"7", x"6", x"6", x"4", x"4", x"1", x"1",  x"3",  x"3",  x"7", x"7");
 constant ICD6 : ICD_ARRAY := (x"1",  x"1", x"3",  x"3", x"7", x"7", x"7", x"7", x"7",  x"7", x"6",  x"6", x"5", x"5", x"3", x"3", x"7",  x"7", x"7", x"7", x"6", x"6", x"4",  x"4", x"1",  x"1", x"3", x"3", x"7", x"7", x"6", x"6",  x"5",  x"5",  x"2", x"2");
 constant ICD7 : ICD_ARRAY := (x"0",  x"0", x"0",  x"0", x"0", x"0", x"1", x"1", x"3",  x"3", x"7",  x"7", x"7", x"7", x"7", x"7", x"6",  x"6", x"5", x"5", x"3", x"3", x"7",  x"7", x"7",  x"7", x"6", x"6", x"4", x"4", x"1", x"1",  x"3",  x"3",  x"7", x"7");
 constant ICD8 : ICD_ARRAY := (x"1",  x"1", x"3",  x"3", x"7", x"7", x"7", x"7", x"7",  x"7", x"6",  x"6", x"5", x"5", x"3", x"3", x"7",  x"7", x"7", x"7", x"6", x"6", x"4",  x"4", x"1",  x"1", x"3", x"3", x"7", x"7", x"6", x"6",  x"5",  x"5",  x"2", x"2");
  -----------------------------C1----  C2----C3----C4--- -C5----C6-- -C7- --C8----C9----C10-  -C11-  -C12- --13----14---15----16----17- --18-----19- --20-- --21- --22----23-- -24----25--- -26-----27---28----29---30- ---31- --32-- --33-- --34---- 35-- -36---37-- -38--  -39-     -40--  41    42    43   44    45    46    47    48   49    50    51   52    53    54    55   56    57    58     59   60   61    62    63    64    65   66     67   68   69    70   71     72  


--Type RCV_ARRAY is array 
--  (integer range 1 to  12 ) of std_logic_vector (0 to 3);
--   constant RCV : RCV_ARRAY := ("0001","0011","0111", "1110", "1101", "1011", "0110", "1100", "1001", "0010", "0101", "1010");
 
	
 Type state_type is ( intial ,s0, s1, S2, s3, s4,s5, s6, s7, s8 );
-- , , ,s7, s8, s9, s10,
--                          s11, s12, S13,S14,S15,S16,S17,S18,S19,S20,
--								  S21,S22, S23, S24,S25,S26,S27,S28,S29,S30,
--								  S31,S32,S33,S34,S35,S36,S37,S38,S39,S40,
--								  S41,S42,S43,S44,S45,S46,S47,S48,S49,S50,
--								  S51,S52,S53,S54,S55,S56,S57,S58,S59,S60,
--								  S61,S62,S63,S64);
      Signal State, next_state : state_type;	 
	 
	 

begin

uut: LEB_RND PORT MAP (
          DATAIN => DINRND,
          DATAOUT => DOUTRND,
          CLK => clock,
          CONST1 => C1,
          CONST2 => C2,
          CONST3 => C3,
          CONST4 => C4,
          CONST5 => C5,
          CONST6 => C6,
          CONST7 => C7,
          CONST8 => C8,
          CONST21 => C9,
          CONST22 => C10,
          CONST23 => C11,
          CONST24 => C12,
          CONST25 => C13,
          CONST26 => C14,
          CONST27 => C15,
          CONST28 => C16
        );


----------------------------------------
uutMK1: MUX64 PORT MAP (
          AIN => AK1,
          BIN => BK1,
          CIN => CK1,
          DIN => DK1,
          MXOUT => MXOUTK1,
          SELMX => SELK1
        );
		  
		  ------------------
		  utMN1: MUX64 PORT MAP (
          AIN => AN1,
          BIN => BN1,
          CIN => CN1,
          DIN => DN1,
          MXOUT => MXOUTN1,
          SELMX => SELN1
        );
	--------------------------------------

uutMK2: MUX64 PORT MAP (
          AIN => AK2,
          BIN => BK2,
          CIN => CK2,
          DIN => DK2,
          MXOUT => MXOUTK2,
          SELMX => SELK2
        );
		  
		  ------------------
		  utMN2: MUX64 PORT MAP (
          AIN => AN2,
          BIN => BN2,
          CIN => CN2,
          DIN => DN2,
          MXOUT => MXOUTN2,
          SELMX => SELN2
        );	
		  
		  
 ------------------------------------
--    uutMK2: MUX64_2X1 PORT MAP (
--          A => AK2,
--          B => BK2,
--          MOUT => MXOUTK2,
--          SEL => SELK2
--        );
-------------------------------------
--uutMN2: MUX64_2X1 PORT MAP (
--          A => AN2,
--          B => BN2,
--          MOUT => MXOUTN2,
--          SEL => SELN2
--        );
---------------------------------

	uutRK1: reg64 PORT MAP (
          I => RINk1,
          clock => clock,
			 load => load,
			 rst => rst ,
          Q => ROUTK1
        );

uutRK2: reg64 PORT MAP (
          I => RINK2,
          clock => clock,
			 load => load,
			 rst => rst ,
           Q => ROUTK2
        );

uutRN1: reg64 PORT MAP (
          I => RINN1   ,
          clock => clock,
			 load => load,
			 rst => rst ,
           Q => ROUTN1
        );
	  
uutRN2: reg64 PORT MAP (
          I => RINN2   ,
          clock => clock,
			 load => load,
			 rst => rst ,
           Q => ROUTN2
        );	

--------------------------------------------------
P1: Process (clock, rst)      
		 begin
		If (rst = '1') then 
				  state <= s0;
			  elsif (clock'Event and clock = '1' ) then
				  state <= next_state;
			end if;
	end process P1;
--------------------------------------


	P2 : Process (state, ctr  )
VARIABLE   kj: INTEGER := 36; 	
	VARIABLE   count: INTEGER RANGE 1 TO 36; 
	--VARIABLE   R : INTEGER RANGE 1 TO 16; 
	 
		  begin 
			   next_state <= state ;
										 case state is 
										 
			----Intial  DATA	----------------------						 
										 when intial =>
                          						 if (ctr= '1'   )  then
                                                  												 
											       AK1  <= K (64 TO 127);
													 
													    SELK1 <= "00";
													    --   Ciphertext <= MXOUTD;  

                                           AK2 <= 	K (0 TO 63);
                                             SELK2 <= "00";	
                                          	------------------------
                                      AN1  <= N (64 TO 127);
													 
													    SELN1 <= "00";
													    --   Ciphertext <= MXOUTD;  

                                           AN2 <= 	N (0 TO 63);
                                            SELN2 <= "00";	
														    
											    		   next_state <=s1 ;
														  else 
															next_state <= intial;  
												 end if;
											---------------------18 ITERATION	 
										 when s0 =>		 
												 
                          			 if (   ctr= '1'    )  then					 			 
															 
                                          
													  BK1 <= ROUTK1;
													  BK2 <= ROUTK2;
													  SELK1 <= "01";
													  SELN1 <= "01";

													  BN1 <= ROUTN1;
													  BN2 <= ROUTN2;
													  
													  SELK2 <= "01";	
													  SELN2 <= "01";	
													 
											    		   next_state <= s1  ;
														   
												 end if;
                          								 
											   ---------------16 ITRRATION----------------------------------
												
								----------------------------------------------				    
			 --------- Round K
												 
                            when s1 =>
								  if (ctr= '1'    ) then
                                    RINN2 <=  MXOUTK1 ;
                                     DINrnd <=   MXOUTK1 ;
												 
												 
												  C1 <= ICD1 (count);
													C2 <= ICD2 (count);
													C3 <= ICD3 (count);
													C4 <= ICD4 (count);
													C5 <= ICD5 (count);
													C6 <= ICD6 (count);
													C7 <= ICD7 (count);
													C8 <= ICD8 (count);
                                       C9 <= X"0";
													C10 <= X"0";
													C11 <= X"0";
													C12 <= X"0";
													C13 <= X"0";
													C14 <= X"0";
													C15 <= X"0";
													C16 <= X"0";
													  										
										--		 Ciphertext <= x"0000000000000000" ;
												 
												 
									  next_state <= s2;  
											 end if; 

                              when s2 => 
										    if (ctr= '1'    ) then
											--	  Ciphertext <= routn2;
												    RINK1 <= DOUTrnd XOR MXOUTK2;
												--	 RINK2 <= MXOUTK1;
												 --   SELK1 <= "01";
													 
													 
												 next_state  <= s3;											 
	                           	end if;	
------ Round N

  when s3 =>
								  if (ctr= '1'  ) then
								      count := count + 1; --- 2
										 
                                    RINK2 <=  MXOUTn1 ;
                                     DINrnd <=   MXOUTN1 ;
												  C1 <= ICD1 (count);
													C2 <= ICD2 (count);
													C3 <= ICD3 (count);
													C4 <= ICD4 (count);
													C5 <= ICD5 (count);
													C6 <= ICD6 (count);
													C7 <= ICD7 (count);
													C8 <= ICD8 (count);
                                       C9 <= X"0";
													C10 <= X"0";
													C11 <= X"0";
													C12 <= X"0";
													C13 <= X"0";
													C14 <= X"0";
													C15 <= X"0";
													C16 <= X"0";
													  										
									---		 Ciphertext <= x"AA00000000000000" ;
												 
												 
									  next_state <= s4;  
											 end if; 

                              when s4 => 
										    if (ctr= '1'   ) then
											--	  Ciphertext <= DOUTrnd;
												    RINN1 <= DOUTrnd XOR MXOUTN2;
												  --  RINK2 <= MXOUTN1;
												 --   SELK1 <= "01";
													 
													 count := count + 1; --- 3 
 												 next_state  <= s5;											 
	                           	end if;		
                                when s5 => 
												 If ( ctr= '1'   and count <= kj ) THEN
                                    --  Rk1out <=  ROUTK1;
												--  Rk2out <=  ROUTK2;
												--  RN1out <=  ROUTN1;
												--  RN2out <=  ROUTN2;
												  
                                    --   Ciphertext <= x"11CC000000000000";
											    	next_state  <= S0;
													 		elsif ( kj = 36) then 
															kj := 32;
													next_state  <= s7;
                                          
														
													 elsif( kj = 32) then 
													  kj := 36;
													  next_state  <= s7;
												--	Ciphertext <= x"1357000011110000"; 													 

											     END IF;
										when s7 => 
										    if (ctr= '1'        ) then
										--	 Ciphertext <= x"aacc0000111100cc"; 
											--- xc <= routn2 xor x"1000000000000000";
											   if ( kj = 32) then  
												 XC <= ROUTK1 XOR A1;
											   ---   A1 <= x"ffffffffffffffff";
													else 
													xc1 <= routn2 xor x"0000000000000001";
													 
											  --   XC <= ROUTK1 XOR A1 ;
												  end if;
												   
												--- Ct <= kj ; 
 												  
												--   Rk1out <= Routk1 ;
												  
												--  Rk2out <=  ROUTK2;
												   
												  
												--  RN1out <= ROUTN1;
												  
												  
											--	  RN2out <= ROUTN2;
 										--		Ciphertext  <= Routk1; 
												 
												  next_state  <= s8;	
												  END IF;
												  
												  when s8 =>		 
												 
                          			 if (   ctr= '1'     )  then					 			 
															 
                                         count := 1; 
													   
								  					 
																										 
                                            if ( kj = 32 ) then 
														  SELK1 <= "10";
													     SELN1 <= "10";
													     SELK2 <= "10";	
													     SELN2 <= "10";	
														  
													--	  Ciphertext <= x"aaff000011110032"; 
										--			Ciphertext <=  XC; 
														  
													      CK1 <= XC;
													  cN2 <= ROUTN2;
													  
													  
													   cK2 <= ROUTK2;
													  

													  CN1 <= ROUTN1;
													  
													--   tag <= routk1;
													  tag <= routk1;
													  else
												--	  elsif (kj = 36 ) then 
								--			Ciphertext <=  XC1; 
													--  Ciphertext <= x"aaff000011110036"; 
													     SELK1 <= "11";
													     SELN1 <= "11";
													     SELK2 <= "11";	
													     SELN2 <= "11";	
														  
													    dK1 <= routk1;
													  dN1 <= ROUTN1;
													  
													  
													   dK2 <= ROUTK2;
													  

													  dN2 <= xc1;
													  Ciphertext <= routk1;
													 -- Ciphertext <= routk1;
													  
													 end if;
													    
													 
													 
											    		   next_state <= s1  ;
														   
												 end if;
--												  
--										when s7 => 
--										    if (ctr= '1'      ) then
--											    
--                           
--												 ---  Ciphertext <=  AD XOR ROUTK1;
--												 
--													 --SELK1 <= "10";
--												  END IF;	  

	                           	 													 
			when others => next_state  <= s0;
				  end case;  
			--	end if;  
			  end process P2;  
 
 
 
-----



end Behavioral;



--- test Bench
--
--	 N <=    X"00000000000000000000000000000000";
--          K <= X"00000000000000000000000000000000";
--          clock <= '1';
--          ctr <= '1';
--          rst <= '0';
           
											
											 
--								 when s3 =>
--								  if (ctr= '1') then 
--							         							
--									          			 
--											         <= K (64 TO 127);
--													 
--													     SELMXD <= "00";
--													    --   Ciphertext <= MXOUTD;                 
--											    		   next_state <= s1  ;
--														  else 
--															next_state <= S0;  
--												 end if;
--                          								 
----									 
----									 				 next_state <= s4 ;  
----											    end if;
------------------------N LED R 1------------------------------------												 
--                              when s4 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												  K2RLED <= DOUTrnd XOR K ( 0 TO 63);
--												    AIND <= n( 64 TO 127);
--												    SELMXD <= "00";
--												 next_state  <= s5;											 
--	                           	end if;										 
--											 
--								when s5 =>
--								  if (ctr= '1') then
-- 
--							         							
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"0";
--			                            CONST2rnd <= X"2";  
--			                            CONST3rnd <= x"2";
--                                     CONST4rnd <= X"3"; 
--												  CONST5rnd <= x"0";
--			                            CONST6rnd <= X"1";  
--			                            CONST7rnd <= x"0";
--                                     CONST8rnd <= X"1"; 
--												 SELMXD <= "00";
--									  				 next_state <= s6 ;  
--											    end if;  								
-----------------N LED R 2---------------------------------------------
--                                 when s6 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s7;											 
--	                           	end if;										 
--											 
--								when s7 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          
--												  DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"0";
--			                            CONST2rnd <= X"0";  
--			                            CONST3rnd <= x"0";
--                                     CONST4rnd <= X"0"; 
--												  CONST5rnd <= x"0";
--			                            CONST6rnd <= X"0";  
--			                            CONST7rnd <= x"0";
--                                     CONST8rnd <= X"0"; 
--												 SELMXD <= "00";
--									 	next_state <= s8 ;  
--											    end if;  
-----------   -----xor ----------------------------------------------
--                                     when s8 => 
--										    if (ctr= '1') then
--												 Ciphertext <= DOUTrnd;
--												 N2RLED <= DOUTrnd xor n ( 0 TO 63);
--												  AIND <= K2RLED;
--												  
--												  SELMXD <= "00";
--												    
--												next_state <= s9 ;       									 
--	                           	end if;															 
--------------------------------------------------------------	
--                                	when s9 =>
--								  if (ctr= '1') then
-- 
--							         	Ciphertext <= N2RLED;	
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"0";
--			                            CONST2rnd <= X"1";  
--			                            CONST3rnd <= x"2";
--                                     CONST4rnd <= X"3"; 
--												  CONST5rnd <= x"0";
--			                            CONST6rnd <= X"3";  
--			                            CONST7rnd <= x"0";
--                                     CONST8rnd <= X"3"; 
--												 SELMXD <= "00";
--									 	next_state <= s10 ;
--                             end if;	
--	--------------------  RND 6   -----------------------
--                               when s10 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												  
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s11;											 
--	                           	end if;										 
--						----yt					 
--								when s11 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"0";
--			                            CONST2rnd <= X"0";  
--			                            CONST3rnd <= x"0";
--                                     CONST4rnd <= X"0"; 
--												  CONST5rnd <= x"0";
--			                            CONST6rnd <= X"0";  
--			                            CONST7rnd <= x"0";
--                                     CONST8rnd <= X"0"; 
--										next_state <= s12 ;  
--											    end if; 
----------------------  RND 7   -----------------------
--                               when s12 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												  kI1 <= DOUTrnd;
--												    AIND <= N2RLED;
--												    SELMXD <= "00";
--												 next_state  <= s13;											 
--	                           	end if;										 
--											 
--								when s13 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"0";
--			                            CONST2rnd <= X"2";  
--			                            CONST3rnd <= x"2";
--                                     CONST4rnd <= X"3"; 
--												  CONST5rnd <= x"0";
--			                            CONST6rnd <= X"3";  
--			                            CONST7rnd <= x"0";
--                                     CONST8rnd <= X"3"; 
--										next_state <= s14 ;  
--											    end if; 
----------------------  RND 8   -----------------------
--                               when s14 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s15;											 
--	                           	end if;										 
--											 
--								when s15 =>
--								  if (ctr= '1') then
-- 
--							         			
--									           
--												 DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"0";
--			                            CONST2rnd <= X"0";  
--			                            CONST3rnd <= x"0";
--                                     CONST4rnd <= X"0"; 
--												  CONST5rnd <= x"0";
--			                            CONST6rnd <= X"0";  
--			                            CONST7rnd <= x"0";
--                                     CONST8rnd <= X"0"; 
--
--										next_state <= s16 ;  
--											    end if; 
--
-----------   -----xor with Key---RND9----------------------12:21 results ok--------------------------
--                                     when s16 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												--  BIND <= DOUTrnd XOR KEY ;
--												  SELMXD <= "01";
--												    
--												next_state <= s17 ;       									 
--	                           	end if;															 
--------------------------------------------------------------	
--                                	when s17 =>
--								  if (ctr= '1') then
-- 
--							         	Ciphertext <= DOUTrnd;	
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"6";
--			                            CONST2rnd <= X"7";  
--			                            CONST3rnd <= x"6";
--                                     CONST4rnd <= X"7"; 
--									 	next_state <= s18 ;
--                             end if;	
--	--------------------  RND 10   -----------------------
--                               when s18 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s19;											 
--	                           	end if;										 
--											 
--								when s19 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"5";
--			                            CONST2rnd <= X"7";  
--			                            CONST3rnd <= x"5";
--                                     CONST4rnd <= X"7"; 
--										next_state <= s20 ;  
--											    end if; 
----------------------  RND 11   -----------------------
--                               when s20 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s21;											 
--	                           	end if;										 
--											 
--								when s21 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"3";
--			                            CONST2rnd <= X"6";  
--			                            CONST3rnd <= x"3";
--                                     CONST4rnd <= X"6"; 
--										next_state <= s22 ;  
--											    end if; 
----------------------  RND 12   -----------------------
--                               when s22 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s23;											 
--	                           	end if;										 
--											 
--								when s23 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"7";
--			                            CONST2rnd <= X"4";  
--			                            CONST3rnd <= x"7";
--                                     CONST4rnd <= X"4"; 
--										next_state <= s24 ;  
--											    end if; 
-----------   -----xor with Key---RND13------------------------------------------------
--                                     when s24 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												  BIND <= DOUTrnd XOR KEY ;
--												  SELMXD <= "01";
--												    
--												next_state <= s25 ;       									 
--	                           	end if;															 
--------------------------------------------------------------	
--                                	when S25 =>
--								  if (ctr= '1') then
-- 
--							         	Ciphertext <= DOUTrnd;	
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"7";
--			                            CONST2rnd <= X"1";  
--			                            CONST3rnd <= x"7";
--                                     CONST4rnd <= X"1"; 
--									 	next_state <= s26 ;
--                             end if;	
--	--------------------  RND 14   -----------------------
--                               when s26 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s27;											 
--	                           	end if;										 
--											 
--								when s27 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"6";
--			                            CONST2rnd <= X"3";  
--			                            CONST3rnd <= x"6";
--                                     CONST4rnd <= X"3"; 
--										next_state <= s28 ;  
--											    end if; 
----------------------  RND 15   -----------------------
--                               when s28 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s29;											 
--	                           	end if;										 
--											 
--								when s29 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"4";
--			                            CONST2rnd <= X"7";  
--			                            CONST3rnd <= x"4";
--                                     CONST4rnd <= X"7"; 
--										next_state <= s30 ;  
--											    end if; 
----------------------  RND 16   -----------------------
--                               when s30 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s31;											 
--	                           	end if;										 
--											 
--								when s31 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"1";
--			                            CONST2rnd <= X"6";  
--			                            CONST3rnd <= x"1";
--                                     CONST4rnd <= X"6"; 
--										next_state <= s32 ;  
--											    end if; 
--
--
---------------------------------------------
----------   -----xor with Key---RND17------------------------------------------------
--                                     when s32 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												  BIND <= DOUTrnd XOR KEY ;
--												  SELMXD <= "01";
--												    
--												next_state <= s33;       									 
--	                           	end if;															 
--------------------------------------------------------------	
--                                	when s33 =>
--								  if (ctr= '1') then
-- 
--							         	Ciphertext <= DOUTrnd;	
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"3";
--			                            CONST2rnd <= X"5";  
--			                            CONST3rnd <= x"3";
--                                     CONST4rnd <= X"5"; 
--									 	next_state <= s34 ;
--                             end if;	
--	--------------------  RND 18   -----------------------
--                               when s34 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s35;											 
--	                           	end if;										 
--											 
--								when s35 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"7";
--			                            CONST2rnd <= X"2";  
--			                            CONST3rnd <= x"7";
--                                     CONST4rnd <= X"2"; 
--										next_state <= s36 ;  
--											    end if; 
----------------------  RND 19   -----------------------
--                               when s36 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s37;											 
--	                           	end if;										 
--											 
--								when s37 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"6";
--			                            CONST2rnd <= X"5";  
--			                            CONST3rnd <= x"6";
--                                     CONST4rnd <= X"5"; 
--										next_state <= s38 ;  
--											    end if; 
----------------------  RND 20   -----------------------
--                               when s38 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s39;											 
--	                           	end if;										 
--											 
--								when s39 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"5";
--			                            CONST2rnd <= X"3";  
--			                            CONST3rnd <= x"5";
--                                     CONST4rnd <= X"3"; 
--										next_state <= s40;  
--											    end if; 
--
-----------   -----xor with Key---RND21------------------------------------------------
--                                     when s40 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												  BIND <= DOUTrnd XOR KEY ;
--												  SELMXD <= "01";
--												    
--												next_state <= s41 ;       									 
--	                           	end if;															 
--------------------------------------------------------------	
--                                	when s41 =>
--								  if (ctr= '1') then
-- 
--							         	Ciphertext <= DOUTrnd;	
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"2";
--			                            CONST2rnd <= X"6";  
--			                            CONST3rnd <= x"2";
--                                     CONST4rnd <= X"6"; 
--									 	next_state <= s42 ;
--                             end if;	
--	--------------------  RND 22   -----------------------
--                               when s42 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s43;											 
--	                           	end if;										 
--											 
--								when s43 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"5";
--			                            CONST2rnd <= X"4";  
--			                            CONST3rnd <= x"5";
--                                     CONST4rnd <= X"4"; 
--										next_state <= s44 ;  
--											    end if; 
----------------------  RND 23   -----------------------
--                               when s44 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s45;											 
--	                           	end if;										 
--											 
--								when s45 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"3";
--			                            CONST2rnd <= X"0";  
--			                            CONST3rnd <= x"3";
--                                     CONST4rnd <= X"0"; 
--										next_state <= s46 ;  
--											    end if; 
----------------------  RND 24   -----------------------
--                               when s46 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s47;											 
--	                           	end if;										 
--											 
--								when s47 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"6";
--			                            CONST2rnd <= X"0";  
--			                            CONST3rnd <= x"6";
--                                     CONST4rnd <= X"0"; 
--										next_state <= s48 ;  
--											    end if; 
--							------------------------
--							--------   -----xor with Key---RND25------------------------------------------------
--                                     when s48 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												  BIND <= DOUTrnd XOR KEY ;
--												  SELMXD <= "01";
--												    
--												next_state <= s49 ;       									 
--	                           	end if;															 
--------------------------------------------------------------	
--                                	when s49 =>
--								  if (ctr= '1') then
-- 
--							         	Ciphertext <= DOUTrnd;	
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"4";
--			                            CONST2rnd <= X"1";  
--			                            CONST3rnd <= x"4";
--                                     CONST4rnd <= X"1"; 
--									 	next_state <= s50 ;
--                             end if;	
--	--------------------  RND 26   -----------------------
--                               when s50 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s51;											 
--	                           	end if;										 
--											 
--								when s51 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"0";
--			                            CONST2rnd <= X"2";  
--			                            CONST3rnd <= x"0";
--                                     CONST4rnd <= X"2"; 
--										next_state <= s52 ;  
--											    end if; 
----------------------  RND 27   -----------------------
--                               when s52 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s53;											 
--	                           	end if;										 
--											 
--								when s53 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"0";
--			                            CONST2rnd <= X"5";  
--			                            CONST3rnd <= x"0";
--                                     CONST4rnd <= X"5"; 
--										next_state <= s54 ;  
--											    end if; 
----------------------  RND 28   -----------------------
--                               when s54 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s55;											 
--	                           	end if;										 
--											 
--								when s55 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"1";
--			                            CONST2rnd <= X"3";  
--			                            CONST3rnd <= x"1";
--                                     CONST4rnd <= X"3"; 
--										next_state <= s56 ;  
--											    end if; 
--
-----------   -----xor with Key---RND29------------------------------------------------
--                                     when s56 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												  BIND <= DOUTrnd XOR KEY ;
--												  SELMXD <= "01";
--												    
--												next_state <= s57 ;       									 
--	                           	end if;															 
--------------------------------------------------------------	
--                                	when s57 =>
--								  if (ctr= '1') then
-- 
--							         	Ciphertext <= DOUTrnd;	
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"2";
--			                            CONST2rnd <= X"7";  
--			                            CONST3rnd <= x"2";
--                                     CONST4rnd <= X"7"; 
--									 	next_state <= s58 ;
--                             end if;	
--	--------------------  RND 30   -----------------------
--                               when s58 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s59;											 
--	                           	end if;										 
--											 
--								when s59 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"5";
--			                            CONST2rnd <= X"6";  
--			                            CONST3rnd <= x"5";
--                                     CONST4rnd <= X"6"; 
--										next_state <= s60 ;  
--											    end if; 
----------------------  RND 31   -----------------------
--                               when s60 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s61;											 
--	                           	end if;										 
--											 
--								when s61 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"3";
--			                            CONST2rnd <= X"4";  
--			                            CONST3rnd <= x"3";
--                                     CONST4rnd <= X"4"; 
--										next_state <= s62 ;  
--											    end if; 
----------------------  RND 32   -----------------------
--                               when s62 => 
--										    if (ctr= '1') then
--												  Ciphertext <= DOUTrnd;
--												    AIND <= DOUTrnd;
--												    SELMXD <= "00";
--												 next_state  <= s63;											 
--	                           	end if;										 
--											 
--								when s63 =>
--								  if (ctr= '1') then
-- 
--							         			
--									          DINrnd <=   MXOUTD ;
--												 CONST1rnd <= x"7";
--			                            CONST2rnd <= X"0";  
--			                            CONST3rnd <= x"7";
--                                     CONST4rnd <= X"0"; 
--										next_state <= s64 ;  
--											    end if; 
--												 
--		----FINAL REULTS										 
                                
