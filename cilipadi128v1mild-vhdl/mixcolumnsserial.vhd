----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2019 04:19:40 PM
-- Design Name: 
-- Module Name: mixcolumnsserial - mixcolumnsserial_arc
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mixcolumnsserial is
    Port ( mcs_in : in STD_LOGIC_VECTOR (63 downto 0);
           msc_out : out STD_LOGIC_VECTOR (63 downto 0));
end mixcolumnsserial;

architecture mixcolumnsserial_arc of mixcolumnsserial is

component mult4bitlookup is 
    Port ( in_a : in STD_LOGIC_VECTOR (3 downto 0);
           in_b : in STD_LOGIC_VECTOR (3 downto 0);
           out_c : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal s111, s112, s113, s114: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s11
signal s211, s212, s213, s214: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s12
signal s311, s312, s313, s314: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s13
signal s411, s412, s413, s414: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s14
---
signal s11, s21, s31, s41: STD_LOGIC_VECTOR (3 downto 0); -- column 1
---
signal s121, s122, s123, s124: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s21
signal s221, s222, s223, s224: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s22
signal s321, s322, s323, s324: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s23
signal s421, s422, s423, s424: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s24
---
signal s12, s22, s32, s42: STD_LOGIC_VECTOR (3 downto 0); -- column 2
---
signal s131, s132, s133, s134: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s31
signal s231, s232, s233, s234: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s32
signal s331, s332, s333, s334: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s33
signal s431, s432, s433, s434: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s34
---
signal s13, s23, s33, s43: STD_LOGIC_VECTOR (3 downto 0); -- column 3
---
signal s141, s142, s143, s144: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s41
signal s241, s242, s243, s244: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s42
signal s341, s342, s343, s344: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s43
signal s441, s442, s443, s444: STD_LOGIC_VECTOR (3 downto 0); -- mult variables for cell s44
---
signal s14, s24, s34, s44: STD_LOGIC_VECTOR (3 downto 0); -- column 4
---

Type matrix4x4 is array (integer range 1 to 16) of STD_LOGIC_VECTOR (3 downto 0);
constant matrixA : matrix4x4 := (x"4",x"1", x"2", x"2", 
	                             x"8",x"6", x"5", x"6", 
							     x"B",x"E", X"A", x"9", 
                                 x"2",x"2", x"F", x"B" );

begin

uut111: mult4bitlookup port map (in_a => mcs_in(63 downto 60), in_b => matrixA( 1), out_c => s111);
uut112: mult4bitlookup port map (in_a => mcs_in(47 downto 44), in_b => matrixA( 2), out_c => s112);
uut113: mult4bitlookup port map (in_a => mcs_in(31 downto 28), in_b => matrixA( 3), out_c => s113);
uut114: mult4bitlookup port map (in_a => mcs_in(15 downto 12), in_b => matrixA( 4), out_c => s114);
s11 <= s111 XOR s112 XOR s113 XOR s114;
msc_out(63 downto 60) <= s11;

uut211: mult4bitlookup port map (in_a => mcs_in(63 downto 60), in_b => matrixA( 5), out_c => s211);
uut212: mult4bitlookup port map (in_a => mcs_in(47 downto 44), in_b => matrixA( 6), out_c => s212);
uut213: mult4bitlookup port map (in_a => mcs_in(31 downto 28), in_b => matrixA( 7), out_c => s213);
uut214: mult4bitlookup port map (in_a => mcs_in(15 downto 12), in_b => matrixA( 8), out_c => s214);
s21 <= s211 XOR s212 XOR s213 XOR s214;
msc_out(47 downto 44) <= s21;

uut311: mult4bitlookup port map (in_a => mcs_in(63 downto 60), in_b => matrixA( 9), out_c => s311);
uut312: mult4bitlookup port map (in_a => mcs_in(47 downto 44), in_b => matrixA(10), out_c => s312);
uut313: mult4bitlookup port map (in_a => mcs_in(31 downto 28), in_b => matrixA(11), out_c => s313);
uut314: mult4bitlookup port map (in_a => mcs_in(15 downto 12), in_b => matrixA(12), out_c => s314);
s31 <= s311 XOR s312 XOR s313 XOR s314;
msc_out(31 downto 28) <= s31;

uut411: mult4bitlookup port map (in_a => mcs_in(63 downto 60), in_b => matrixA(13), out_c => s411);
uut412: mult4bitlookup port map (in_a => mcs_in(47 downto 44), in_b => matrixA(14), out_c => s412);
uut413: mult4bitlookup port map (in_a => mcs_in(31 downto 28), in_b => matrixA(15), out_c => s413);
uut414: mult4bitlookup port map (in_a => mcs_in(15 downto 12), in_b => matrixA(16), out_c => s414);
s41 <= s411 XOR s412 XOR s413 XOR s414;
msc_out(15 downto 12) <= s41;

uut121: mult4bitlookup port map (in_a => mcs_in(59 downto 56), in_b => matrixA( 1), out_c => s121);
uut122: mult4bitlookup port map (in_a => mcs_in(43 downto 40), in_b => matrixA( 2), out_c => s122);
uut123: mult4bitlookup port map (in_a => mcs_in(27 downto 24), in_b => matrixA( 3), out_c => s123);
uut124: mult4bitlookup port map (in_a => mcs_in(11 downto  8), in_b => matrixA( 4), out_c => s124);
s12 <= s121 XOR s122 XOR s123 XOR s124;
msc_out(59 downto 56) <= s12;

uut221: mult4bitlookup port map (in_a => mcs_in(59 downto 56), in_b => matrixA( 5), out_c => s221);
uut222: mult4bitlookup port map (in_a => mcs_in(43 downto 40), in_b => matrixA( 6), out_c => s222);
uut223: mult4bitlookup port map (in_a => mcs_in(27 downto 24), in_b => matrixA( 7), out_c => s223);
uut224: mult4bitlookup port map (in_a => mcs_in(11 downto  8), in_b => matrixA( 8), out_c => s224);
s22 <= s221 XOR s222 XOR s223 XOR s224;
msc_out(43 downto 40) <= s22;

uut321: mult4bitlookup port map (in_a => mcs_in(59 downto 56), in_b => matrixA( 9), out_c => s321);
uut322: mult4bitlookup port map (in_a => mcs_in(43 downto 40), in_b => matrixA(10), out_c => s322);
uut323: mult4bitlookup port map (in_a => mcs_in(27 downto 24), in_b => matrixA(11), out_c => s323);
uut324: mult4bitlookup port map (in_a => mcs_in(11 downto  8), in_b => matrixA(12), out_c => s324);
s32 <= s321 XOR s322 XOR s323 XOR s324;
msc_out(27 downto 24) <= s32;

uut421: mult4bitlookup port map (in_a => mcs_in(59 downto 56), in_b => matrixA(13), out_c => s421);
uut422: mult4bitlookup port map (in_a => mcs_in(43 downto 40), in_b => matrixA(14), out_c => s422);
uut423: mult4bitlookup port map (in_a => mcs_in(27 downto 24), in_b => matrixA(15), out_c => s423);
uut424: mult4bitlookup port map (in_a => mcs_in(11 downto  8), in_b => matrixA(16), out_c => s424);
s42 <= s421 XOR s422 XOR s423 XOR s424;
msc_out(11 downto  8) <= s42;

uut131: mult4bitlookup port map (in_a => mcs_in(55 downto 52), in_b => matrixA( 1), out_c => s131);
uut132: mult4bitlookup port map (in_a => mcs_in(39 downto 36), in_b => matrixA( 2), out_c => s132);
uut133: mult4bitlookup port map (in_a => mcs_in(33 downto 30), in_b => matrixA( 3), out_c => s133);
uut134: mult4bitlookup port map (in_a => mcs_in( 7 downto  4), in_b => matrixA( 4), out_c => s134);
s13 <= s131 XOR s132 XOR s133 XOR s134;
msc_out(55 downto 52) <= s13;

uut231: mult4bitlookup port map (in_a => mcs_in(55 downto 52), in_b => matrixA( 5), out_c => s231);
uut232: mult4bitlookup port map (in_a => mcs_in(39 downto 36), in_b => matrixA( 6), out_c => s232);
uut233: mult4bitlookup port map (in_a => mcs_in(33 downto 30), in_b => matrixA( 7), out_c => s233);
uut234: mult4bitlookup port map (in_a => mcs_in( 7 downto  4), in_b => matrixA( 8), out_c => s234);
s23 <= s231 XOR s232 XOR s233 XOR s234;
msc_out(39 downto 36) <= s23;

uut331: mult4bitlookup port map (in_a => mcs_in(55 downto 52), in_b => matrixA( 9), out_c => s331);
uut332: mult4bitlookup port map (in_a => mcs_in(39 downto 36), in_b => matrixA(10), out_c => s332);
uut333: mult4bitlookup port map (in_a => mcs_in(33 downto 30), in_b => matrixA(11), out_c => s333);
uut334: mult4bitlookup port map (in_a => mcs_in( 7 downto  4), in_b => matrixA(12), out_c => s334);
s33 <= s331 XOR s332 XOR s333 XOR s334;
msc_out(33 downto 30) <= s33;

uut431: mult4bitlookup port map (in_a => mcs_in(55 downto 52), in_b => matrixA(13), out_c => s431);
uut432: mult4bitlookup port map (in_a => mcs_in(39 downto 36), in_b => matrixA(14), out_c => s432);
uut433: mult4bitlookup port map (in_a => mcs_in(33 downto 30), in_b => matrixA(15), out_c => s433);
uut434: mult4bitlookup port map (in_a => mcs_in( 7 downto  4), in_b => matrixA(16), out_c => s434);
s43 <= s431 XOR s432 XOR s433 XOR s434;
msc_out( 7 downto  4) <= s43;

uut141: mult4bitlookup port map (in_a => mcs_in(51 downto 48), in_b => matrixA( 1), out_c => s141);
uut142: mult4bitlookup port map (in_a => mcs_in(35 downto 32), in_b => matrixA( 2), out_c => s142);
uut143: mult4bitlookup port map (in_a => mcs_in(19 downto 16), in_b => matrixA( 3), out_c => s143);
uut144: mult4bitlookup port map (in_a => mcs_in( 3 downto  0), in_b => matrixA( 4), out_c => s144);
s14 <= s141 XOR s142 XOR s143 XOR s144;
msc_out(51 downto 48) <= s14;

uut241: mult4bitlookup port map (in_a => mcs_in(51 downto 48), in_b => matrixA( 5), out_c => s241);
uut242: mult4bitlookup port map (in_a => mcs_in(35 downto 32), in_b => matrixA( 6), out_c => s242);
uut243: mult4bitlookup port map (in_a => mcs_in(19 downto 16), in_b => matrixA( 7), out_c => s243);
uut244: mult4bitlookup port map (in_a => mcs_in( 3 downto  0), in_b => matrixA( 8), out_c => s244);
s24 <= s241 XOR s242 XOR s243 XOR s244;
msc_out(35 downto 32) <= s24;

uut341: mult4bitlookup port map (in_a => mcs_in(51 downto 48), in_b => matrixA( 9), out_c => s341);
uut342: mult4bitlookup port map (in_a => mcs_in(35 downto 32), in_b => matrixA(10), out_c => s342);
uut343: mult4bitlookup port map (in_a => mcs_in(19 downto 16), in_b => matrixA(11), out_c => s343);
uut344: mult4bitlookup port map (in_a => mcs_in( 3 downto  0), in_b => matrixA(12), out_c => s344);
s34 <= s341 XOR s342 XOR s343 XOR s344;
msc_out(19 downto 16) <= s34;

uut441: mult4bitlookup port map (in_a => mcs_in(51 downto 48), in_b => matrixA(13), out_c => s441);
uut442: mult4bitlookup port map (in_a => mcs_in(35 downto 32), in_b => matrixA(14), out_c => s442);
uut443: mult4bitlookup port map (in_a => mcs_in(19 downto 16), in_b => matrixA(15), out_c => s443);
uut444: mult4bitlookup port map (in_a => mcs_in( 3 downto  0), in_b => matrixA(16), out_c => s444);
s44 <= s441 XOR s442 XOR s443 XOR s444;
msc_out( 3 downto  0) <= s44;

end mixcolumnsserial_arc;
