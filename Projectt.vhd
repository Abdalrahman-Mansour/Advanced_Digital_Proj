-------------------------------------------------------------------------------
--
-- Title       : Projectt
-- Design      : Project1
-- Author      : Abdalrahman
-- Company     : Bierzeit
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\Project\Project1\src\Projectt.vhd
-- Generated   : Sun May 23 14:58:32 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Projectt} architecture {Projectt}}

Library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder is	
	
	port( x,y , c_in: IN STD_logic;
	sum , c_out : out std_logic
	);
	
end fulladder;

--}} End of automatically maintained section

architecture full of fulladder is
begin
sum <=( x xor y )  xor c_in;
c_out<= ((x and y) or (c_in and (x xor y)));
end architecture full ; 
--Implemnt generic adder .
Library IEEE;
use IEEE.std_logic_1164.all;
entity nbitadder is 
	generic (m: positive);
	port ( x : in std_logic_vector(m-1 downto 0) ;
		   y : in std_logic_vector(m-1 downto 0) ;
	       cin: in std_logic;
	       sum2 : out std_logic_vector(m-1 downto 0) ;
	       c_out,cout1 : out std_logic 
	);
end entity nbitadder; 

ARchitecture gene of nbitadder is		  		
signal carry : std_logic_vector(m downto 0):=(others=>'0');
signal sum1 : std_logic_vector(m-1 downto 0):=(others=>'0');
begin
	c_out<=carry(m);
	carry(0)<= cin  ;
	cout1<=sum1(0);
 gen1: FOR i IN 0 TO (m-1) GENERATE
	 g: ENTITY work.fulladder(full) PORT MAP (x(i),y(i),carry(i),sum1(i),carry(i+1));   
END GENERATE gen1;
gen2: FOR i IN 1 TO (m-1) GENERATE
	sum2(i-1)<=sum1(i) ;
	   END GENERATE gen2;
	 sum2(m-1)<=carry(m);
end ARchitecture gene;


--Implement generic multipler
Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 
entity generic_multiber is 
	generic (k,j: positive:=4);
	port (
	       x : in std_logic_vector(k-1 downto 0) ;
	       y : in std_logic_vector(j-1 downto 0) ;
		   clk: in std_logic;
	      result : out std_logic_vector((j+k-1) downto 0) 
	);
end entity generic_multiber;


Architecture multiply of generic_multiber is 
type  ram64 is array(0 to j-1) of std_logic_vector (k-1 downto 0);
Signal num1 : ram64:=(others => (others => '0'));
Signal cout : std_logic_vector(k+j-1 downto 0):=(others=>'0') ;
Signal num3 : ram64:=(others => (others => '0'));
Signal result1:	 std_logic_vector((j+k-1) downto 0):=(others=>'0') ;
begin 
	result1(0)<= x(0) and y(0); 
	loop1:entity work.and_entity(loop2) generic map(k) port map(y(0),x,num3(0)); 
	loop2: for i in 1 to j-1 generate
		    loop3:entity work.and_entity(loop1) generic map(k) port map(y(i),x,num1(i-1)); 
            kbitadder2: entity  work.nbitadder(gene) generic map(k) port map(num3(i-1),num1(i-1),cout(i-1),num3(i),cout(i),result1(i)) ;
    END generate loop2;
	  fill1:entity work.fill_entity(fill) generic map(k,j) port map(num3(j-1),result1);
	 	process(clk)
		 begin
			if(rising_edge(clk) ) then
		        result<=result1;
			end if ;
		end process ;	
				
		 
end Architecture multiply;

Library IEEE;
use IEEE.std_logic_1164.all;
entity and_entity is 
	generic (m :positive :=4);
    port(x: in std_logic ;
	     y: in std_logic_vector( (m-1) downto 0) ;
		 reslut: out std_logic_vector ( (m-1) downto 0)
	     )	;
end entity and_entity ;

Architecture loop2  of and_entity is
begin	
	 reslut<= '0' & y(m-1 downto 1)  when (x='1') else 
	 (y and (not y));
end Architecture loop2;

Architecture loop1  of and_entity is
Signal num,num1 :std_logic_vector( (m-1) downto 0):=(others=>'0');
begin
    reslut<= num1 when (x='1') else num;
	num<= y xor y;	
	gene1: for i in 0 to (m-1) generate
		num1(i)<= x and y(i);
		end generate gene1;
end Architecture loop1;
--*************	

Library IEEE;
use IEEE.std_logic_1164.all;
entity fill_entity is 
	generic (m ,n:positive :=4);
    port(x: in std_logic_vector( (m-1) downto 0) ;
		 result:inout std_logic_vector ( (m+n-1) downto 0)
	     )	;
end entity fill_entity ;

Architecture fill  of fill_entity is
begin
	loop1: for i in n to m+n-1 generate
		 result(i)<=x(i-n); 
	end generate loop1;
end Architecture fill;


--
--Testbench-----
--Test for generic Multiplyer
Library IEEE;
use IEEE.std_logic_1164.all;
entity test is
end ;
architecture test1 of test  is 
Signal x: std_logic_vector(6 downto 0) :="0001010";
Signal y : std_logic_vector(3 downto 0) :=X"F";
Signal sum :std_logic_vector(10 downto 0); 
Signal clk :std_logic:='0';
begin  
	  clk<= not clk after 8 ns;
	g1: entity work.generic_multiber(multiply) generic map (7,4) port map (x,y,clk,sum); 
	x<="0001000","0001001" after 15 ns, "0000011" after 30 ns,"0000111" after 45 ns,"0001101" after 60 ns;
    y<="1111","1110"after 15 ns,"1101"after 30 ns,"0111"after 45 ns,"0100"after 60 ns;	
	end architecture test1;


--Testbench two
architecture test2 of test  is 
Signal x: std_logic_vector(3 downto 0) :="0000";
Signal y : std_logic_vector(6 downto 0) :="0000000";
signal sum :std_logic_vector(11 downto 0); 
Signal clk :std_logic:='0';
begin  
		clk<= not clk after 8 ns;
	g1: entity work.shifter_multipler(shift_method) generic map (4,7) port map (x,y,clk,sum);
        y<="0001000","0001001" after 15 ns, "0000011" after 30 ns,"0000111" after 45 ns,"0001101" after 60 ns;
		x<="1111","0101"after 15 ns,"1101"after 30 ns,"0111"after 45 ns,"0100"after 60 ns;
		
end architecture test2; 
--***************************************--
--***************************************--
--***************************************--
--***************************************--
--Stage 2 Shift
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY shifter_multipler IS
GENERIC ( k,j: POSITIVE:=4);
PORT (x: IN STD_LOGIC_VECTOR(k-1 DOWNTO 0);
      y: IN STD_LOGIC_VECTOR(j-1 DOWNTO 0);
	  clk : in std_logic ;
	  result:OUT STD_LOGIC_VECTOR((j+k) DOWNTO 0)
	  );
END ENTITY shifter_multipler;

Architecture shift_method of shifter_multipler is 
type  ram64 is array(0 to k) of std_logic_vector (k+j downto 0);
Signal num1 :ram64:=(others => (others => '0'));
begin
	    put:entity work.put_in(put1) generic map (k,j) port map(x,y,num1(0));
	    loop1: for i in 1 to k generate
			    addandshift: entity work.add_for_shift_stage(add1) generic map(k,j) port map(x,y,num1(i-1),num1(i)); 		
			end generate loop1;
			 process (clk)
			 begin
			 if(rising_edge(clk) ) then
		           result<=num1(k);
			end if ;
		    end process ;
end Architecture shift_method;	   

--******************************--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
entity put_in is 
	generic(m,n:positive :=4);
	port(x: in std_logic_vector(m-1 downto 0);
	     y: in std_logic_vector(n-1 downto 0);
	     result: out std_logic_vector(m+n downto 0)
	   );
end entity put_in;

Architecture put1 of put_in is 
begin				  
	gene1:for i in 0 to (m-1) generate
	result(i)<= x(i) ; 
	end generate gene1 ;
	gene2:for j in m to m+n generate
	result(j)<='0' ;
	end generate gene2 ;
end Architecture put1;	


--***********************************---

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
entity add_for_shift_stage is 
	generic(m,n:positive :=4);
	port(x: in std_logic_vector(m-1 downto 0);
	     y: in std_logic_vector(n-1 downto 0);
	     result1: in std_logic_vector(m+n downto 0);
	     num: out std_logic_vector(m+n downto 0)
	   );
end entity add_for_shift_stage;

Architecture add1 of add_for_shift_stage is
Signal result2 : std_logic_vector(m+n downto 0);
begin	
	 nbitadder22:entity work.nbitadder2(gene) generic map (n) port map(result1((m+n-1) downto m), 
	 y ,result1(0),result2((m+n-1) downto m),result2(m+n));
	num<= '0'& result2(m+n downto m) & result1((m-1) downto 1) ; 
end Architecture add1;

--nbit adder for shift 
Library IEEE;
use IEEE.std_logic_1164.all;
entity nbitadder2 is 
	generic (m: positive);
	port ( x,y : in std_logic_vector(m-1 downto 0) ;
		   q0: in std_logic;
	       sum : out std_logic_vector(m-1 downto 0) ;
	       c_out : out std_logic 
	);
end entity nbitadder2; 

ARchitecture gene of nbitadder2 is
signal carry : std_logic_vector(m downto 0):=(others=>'0');
signal sum1	:std_logic_vector(m-1 downto 0);
begin
	c_out<=carry(m);
	 sum<=x when (q0='0') else sum1 ;
	 gen1: FOR i IN 0 TO (m-1) GENERATE g: ENTITY work.fulladder(full) 
	PORT MAP (x(i),y(i),carry(i),sum1(i),carry(i+1)); 
    END GENERATE gen1;
end ARchitecture gene;	