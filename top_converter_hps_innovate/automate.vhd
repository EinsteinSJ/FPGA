-- automate pour controller le systeme ...

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity automate is 
  
  port (                                 --
		clk            	:  in  std_logic;
		rst            	:  in  std_logic;
	 
	  -- signaux de temporization  --
		t_0					:	in std_logic;					 -- debut de la periode --
		t_1					:	in std_logic;					 -- debut de calcul --
		
      -- signaux pour le controle du ADC  --
	 go_adc			  		:  out  std_logic;
	 fin_adc			  		:  in	  std_logic;		
    
      -- signaux pour le controle du DAC  --
	 go_dac			  		:  out  std_logic;
	 fin_dac			  		:  in	  std_logic
	 );
	 
end automate;

architecture archi_automate of automate is

-- Machine d'etat
	TYPE state IS (Wait_DAC,Init,ADC,CALCUL,WAIT_CALCUL,DAC);
	signal   ep,es:state;
	  
	signal enable_calcul:std_logic;  
	signal fin_calcul:std_logic;  

begin

-- machine d'etat: process sequentielle --
process(rst, clk)
begin

  if (rst = '0') then  
  
    ep <= Wait_DAC;

  elsif (rising_edge(clk)) then  
  
    ep  <= es;
            
  end if;
end process;

-- Machine d'etat: combinationelle --
state_suivant:process(ep,t_0,t_1,fin_dac,fin_adc,fin_calcul)

begin

    case ep is
				
			-- attend la periode d'echantionage
			when Wait_DAC   => 
				if fin_dac='1' then
					es<=Init;
				else
					es<=Wait_DAC;
				end if;
				
			-- attend la periode d'echantionage
			when Init      => 
				if t_0='1' then
					es<=ADC;
				else
					es<=Init;
				end if;

			-- On lire le donnee analogique 
			when ADC      => 
				if fin_adc='1' then
					es <= CALCUL; 
				else
					es<=ADC;
				end if;

			-- On calcul les signaux de commande
			when CALCUL      => 
				if t_1='1' then
					es <= WAIT_CALCUL; 
				else
					es<=CALCUL;
				end if;							
				
			-- On calcul les signaux de commande
			when WAIT_CALCUL  => 
				if fin_calcul='1' then
					es <= DAC; 
				else
					es<=WAIT_CALCUL;
				end if;											
				
			-- On envoi le 1er donne vers le DAC --
			when DAC=>  
				if fin_dac='1' then
					es <= Init; 
				else
					es<=DAC;
				end if;
				
	end case;
    
  end process;

  
  -- Machine d'etat: sorties
sorties:process(ep)
begin

      case ep is	
			
			-- On regarde le donne dans le DAC
			when Wait_DAC 		=>  
				go_dac<='1';
				go_adc<='0';
				enable_calcul<='0';						
				
			-- On lire le donnee analogique 
			when ADC      	=> 
				enable_calcul<='0';
				go_dac<='0';
				go_adc<='1';

			-- On calcul les signaux de commande
			when CALCUL    =>  
				enable_calcul<='0';
				go_dac<='0';
				go_adc<='0';

			-- On calcul les signaux de commande
			when WAIT_CALCUL    =>  
				enable_calcul<='1';
				go_dac<='0';
				go_adc<='0';
			
			-- On regarde le donne dans le DAC
			when DAC 		=>  
				go_dac<='1';
				go_adc<='0';
				enable_calcul<='0';								
																
			when others=>
				go_dac<='0';
				go_adc<='0';
				enable_calcul<='0';				
				
		end case;

end process sorties;


-- temps d'attend pour le calcul -- (2us par default)

process(rst, clk)
variable temp:integer range 0 to 200;
begin
  if (rst = '0') then  
  
    temp:=0;
	 fin_calcul<='0';

  elsif (rising_edge(clk)) then  
  
    if (enable_calcul='1') then
		temp:=temp+1;
		if (temp=150) then
			fin_calcul<='1';	 
			temp:=0;
		end if; 
	 else
		temp:=0;
		fin_calcul<='0';	 
	 end if;
            
  end if;
end process;



end archi_automate;