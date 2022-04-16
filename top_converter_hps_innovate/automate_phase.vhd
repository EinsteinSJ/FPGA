	-- Controla el inicio y fin de las pruebas --	
	
    -- 1) Las pruebas se inician cuando se presionan el bottom go
	 -- 2) Una vez presionado GO, se espera que termine la scuenta de 25s
	 -- 3) Una vez detectado el termino de la scuenta, se habilita el foncionamiento del conversor
	 -- 4) El sistema parte de la phase minima hasta la phase maxima 
	 -- 5) Se presiona otra vez GO, para indicar el fin de pruebas y contador vuelve a 0
	 -- 6) Se regresa a la phase minima 
	 -- 7) Con la fase minima y una scuenta por seguridad, se detiene el convertidor 
	  
	-- NOTA:
	-- phi_max: corresponde al angulo requerido
	-- phi_min: corresponde al angulo minmo (cero)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity automate_phase is 
generic(
			count_ref : natural := 15		
);
port (                                 --
		clk            	:  in  std_logic;
		rst            	:  in  std_logic;
	
    -- signaux pour demarrer la commande  --		
	 
		phi_min			  	: in std_logic;	-- indicateur de restart de la phase
		phi_max				: in std_logic;	-- indicateur de phi max (puissance nominal)
	 
		go				   	: in std_logic;	-- bottom

		led				   : out std_logic;	-- indicateur de funcionamiento
														-- '1': ON
														-- '0': OFF
	--scuenta de seguridad 25 s 											
		cuenta 				: out std_logic_vector(4 downto 0);
		
		go_phase				: out std_logic;	-- habilitador de comando
		go_pnom				: out std_logic	-- '1': indica que aumenta fase
														-- '0': indica que disminuye fase 
);
	 
end automate_phase;

architecture test of automate_phase is

-- Machine d'etat
	TYPE state IS (Idle,Wait_BottomandCount,Fonct,Start_Arret,Fin_DAB);
	signal   ep,es:state;

-- Para el contador :
	signal go_count_max 		 : std_logic;
	signal go_count_min 		 : std_logic;
	signal scount 		  		 : integer range 0 to 25000000 := 0;
	signal clk1s 		  		 : std_logic;
	signal aumentar_scuenta  : std_logic;
	signal disminuir_scuenta : std_logic;
	signal scuenta				 : integer range 0 to count_ref := 0;
	signal activar_cuenta 	 : std_logic;
	signal desactivar_cuenta : std_logic;
	
begin
	
	cuenta <= std_logic_vector(to_unsigned(scuenta,5));

-- machine d'etat: process sequentielle --
process(rst, clk)
begin

  if (rst = '0') then  
  
    ep <= Idle;

  elsif (rising_edge(clk)) then  
  
    ep  <= es;
            
  end if;
end process;

-- Machine d'etat: combinationelle --
state_suivant:process(go,go_count_max,go_count_min,phi_max,phi_min)

begin

    case ep is

			-- attend le demarrage du systeme --
			when Idle=>
				if (go='0') then
					es<=Wait_BottomandCount;
				else
					es<=Idle;
				end if;
				
			-- espera que suelte el botom	
			when Wait_BottomandCount=>
				if (go='1' and go_count_max = '1') then
					es<=Fonct;
				else
					es<=Wait_BottomandCount;
				end if;			
				
			-- salta cuando se esta en la phase maxima de prueba y se presiono el botom go
			when Fonct=> 
				if ((go='0') and (phi_max='1')) then
					es<=Start_Arret;
				else
					es<=Fonct;
				end if;

			when Start_Arret => 
				if (go_count_min = '1' and phi_min='1') then
					es <= Fin_DAB; 
				else
					es<=Start_Arret;
				end if;

			when Fin_DAB=>
					es<=Idle;

		end case;
    
  end process;

  
  -- Machine d'etat: sorties
sorties:process(ep)
begin

      case ep is				
				
			-- On fonctionne de facon normale
			when Wait_BottomandCount =>
				
				-- signal para el control de phase --
				activar_cuenta <= '1';
				desactivar_cuenta <= '0';
				go_pnom<='0';		-- aumente phase	
				go_phase<='1';		-- habilita commando y funcionamiento de phase
				led<='1';		   -- ON
				--- ----------------------------
			
			when Fonct=> 
			
				-- signal para el control de phase --
				activar_cuenta <= '0';
				desactivar_cuenta <= '0';
				go_pnom<='1';		-- aumente phase	
				go_phase<='1';		-- habilita commando y funcionamiento de phase
				led<='1';		   -- ON
				--- ----------------------------

			-- On commence l'arret
			when Start_Arret => 
				
				-- signal para el control de phase --
				desactivar_cuenta <= '1';
				activar_cuenta    <= '0';
				go_pnom<='0';		-- disminue phase
				go_phase<='1';		-- habilita commando y funcionamiento de phase
				led<='1';		   -- ON
				--- ----------------------------
				
			when others => 
				
				-- signal para el control de phase --
				activar_cuenta <= '0';
				desactivar_cuenta <= '0';
				go_pnom<='0';		-- disminue phase
				go_phase<='0';		-- habilita commando y funcionamiento de phase
				led<='0';			-- OFF
				--- ----------------------------
								
		end case;

end process sorties;
	
clk_ref:process(clk)
begin
if (clk'event and clk='1') then
    if (scount = 25000000) then  --medio periodo T/2 = 1/2s
        scount <= 0;
        clk1s <= not clk1s;
    else
        scount <= scount + 1;
    end if;
end if;
end process clk_ref;


--control_count: process(activar_cuenta,desactivar_cuenta,scuenta)
--begin
--if(activar_cuenta <= '1' and scuenta = 0) then				--emula flanco de subida (go)
--	aumentar_scuenta <= '1';				
--	disminuir_scuenta <= '0';
--elsif(desactivar_cuenta <= '1' and scuenta = 25) then 	--emula flanco de bajada (go)
--	disminuir_scuenta <= '1';
--	aumentar_scuenta <= '0';
--end if;
--end process control_count;

count: process(clk1s,activar_cuenta,desactivar_cuenta)
begin
if (rst = '0') then
	scuenta <= 0;
elsif(clk1s'event and clk1s = '1') then
	if(activar_cuenta ='1') then 
		scuenta <= scuenta +1;
		if(scuenta >count_ref) then 
			scuenta <= count_ref;
		end if;
	elsif(desactivar_cuenta = '1') then 
			scuenta <= 0;
--		scuenta <= scuenta -1;
--		if(scuenta < 0) then 
--			scuenta <= 0;
--		end if;
	end if;
end if;
end process count;

go_count_max <= '1' when (scuenta = count_ref) else '0';
go_count_min <= '1' when (scuenta = 0) else '0';

end test;