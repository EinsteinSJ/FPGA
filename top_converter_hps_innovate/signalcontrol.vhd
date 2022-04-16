library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signalcontrol is 
  port (                                 
		clk            	:  in  std_logic;
		rst            	:  in  std_logic;

		-- control de rapport cyclique --	
		alpha	 	   		: in integer range 0 to 999;	 
	
	 -- decalage des phase --
		phi					: in integer range 0 to 999;	 
		
		--** PV --
		s1			  			:  out  std_logic;
		s2			  			:  out  std_logic	
);
	 
end signalcontrol;

architecture behaviour of signalcontrol is

signal fase1,fase2 : integer range 500 to 2499;

begin

		-- temporizador cada 50KHz --
		process(rst, clk)
		
			variable temp: integer range 0  to 999:=0;
			
			-- reference pour le PV et la batterie
			variable talpha: integer range 0  to 999;		
				
			-- reference pour le PV
			variable tphi: integer range 0  to 999;
		
		--	variable sel_so: std_logic;	-- (indicateur si alpha<=500)
			
			variable ts1: std_logic;
			variable ts2: std_logic;
		  
		begin
		
		  if (rst = '0') then  
		  
				temp:=0;								
				talpha:=0;	-- decalage pour le PV et batterie
				tphi:=0;	
				fase1<=500;
				fase2<=500;
								
		  elsif (rising_edge(clk)) then  		
												
							-- **** MIS A JOUR DE LA COMMANDE ******* --		
				if (temp=0)  then
					
			
			-- *** conversion de donnnes *** --	
					talpha:=alpha;
					tphi:=phi;						
					
											
				end if; -- (fin de temp=500)
				
				fase1 <= 1000 + temp - talpha - tphi + 500;
				fase2 <= 1000 + temp + talpha - tphi;
				
				if (temp=999) then		-- t=0
					temp:=0;
				else
					temp:=temp+1;			
				end if; -- fin de aumento de temp
						
				
		  end if;	-- end de if sequentielle
		end process;
		s1 <= '1' when	( ( (fase1 >= 750) and (fase1 < 1250) ) or ( (fase1 >= 1750) and (fase1 < 2250)))	else
				'0';
		
		s2 <= '1' when	(( (fase2 >= 750) and (fase2 < 1250) ) or ( (fase2 >= 1750) and (fase2 < 2250)))	else
				'0';

		
		
end behaviour;