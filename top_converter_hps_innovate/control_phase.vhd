--REVISADO : 13/01/2020
--Para un solo phi el cual sera usado en un convertidor DC/DC 
--Changes 20/01 : Se habilito phi_min

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Entidad que permite aumentar de manera progresiva la phase (phi) --
entity control_phase is 		

  generic (
    max 			     : natural   := 25000000; -- velocidad de aumento de phi (50MH/max secondes)  0.1s = 5000000
	 phi_min			  : natural   := 258		--fase minima 
	 );   
	 
  port (                                 
		clk            		:  in  std_logic;
		rst            		:  in  std_logic;
				
		go_phase					: in std_logic;					-- Indicador del funcionamiento
		go_pnom					: in std_logic;					-- '1': Indica aumentar o disminuir phi hasta el phi nominal 
																			--	 	: la potencia nominal
																			-- '0': regresar a 0  (volviendo las phases a Zero)
		
		phi_ref					: in integer range 0 to 500;	-- phi referencia 
		phi		 	   		: out integer range 0 to 500;
	
	-- Indicadores 	
		phi_tmax					: out std_logic;					--  led phi maximo 
		phi_tmin					: out std_logic					--  led phi minimo 
		
		);
	 
end control_phase;

architecture archi of control_phase is
	
	
begin

	
	process(clk,rst)
	
		variable temp:integer range 0 to max;
		variable sphi: natural range 0 to 500;
		variable sphi_tmax: std_logic;
		variable sphi_tmin: std_logic;	
	
	begin
		if (rst='0') then
			temp:=0;
			
			sphi:=phi_min;
			phi<=phi_min;					--250 (0° = cero grados)
			
		--indicadores 
			sphi_tmax:='0';
			sphi_tmin:='0';

		elsif (rising_edge(clk)) then
		
			-- if les commandes sont habilité
			if (go_phase='1') then
			
				temp:=temp+1;
				
				-- solo aumenta cada 0.1 segundo --
				if (temp=max) then
					temp:=0;
					
					-- si on aumente la phase jusque la puissance nominale
					if (go_pnom='1') then
						
						-- *** pour phi**
						
						-- RESEAU DONNE DE PUISSANCE (phi_ref>250)
						if (sphi<phi_ref) then
							sphi:=sphi+1;
							sphi_tmax:='0';
							sphi_tmin:='0';
							
						-- RESEAU RECOIT DE PUISSANCE (phi_ref<250)	
						elsif (sphi>phi_ref) then
							sphi:=sphi-1;
							sphi_tmax:='0';
							sphi_tmin:='0';
						
						-- ON EST A LA phase de reference du reseau
						else	
							sphi:=phi_ref;	
							sphi_tmax:='1';
							sphi_tmin:='0';
						end if;						
						
					
					else  		-- else de go_pnom (go_pnom='0') retornamos a cero grados 
					
					-- DISMINUIMOS LA PHASE a ZERO  --					

						-- pour phi
						if (sphi<phi_min) then
							sphi:=sphi+1;
							sphi_tmin:='0';
							sphi_tmax:='0';
							
						elsif (sphi>phi_min) then
							sphi:=sphi-1;
							sphi_tmin:='0';
							sphi_tmax:='0';
							
						else	
							sphi:=phi_min;
							sphi_tmin:='1';
							sphi_tmax:='0';
						end if;						
	
					end if;	-- end de flag phase 									
					
				end if;	-- end de temp
				
			else	-- else de enable phase
			
				temp:=0;
				
				sphi:=phi_min;
				phi<=phi_min;	--250 (0° = cero grados)
								
				sphi_tmin:='0';								

				sphi_tmax:='0';					
				
			end if;	-- end de enable_cmd
			
			phi<=sphi;
			
			-- on arrive a la puissance maximale de test --
			phi_tmax <= sphi_tmax;	
			
			-- on arrive a la puissance de demarrage
			phi_tmin <= sphi_tmin;
					 
		end if;
	end process;
	
end archi;