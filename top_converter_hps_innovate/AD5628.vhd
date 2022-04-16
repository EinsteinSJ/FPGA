-- Interface SPI avec le CAN Analog device DA5628 ...
-- Le systeme est configure pour envoyer toujours 2 donnees --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity AD5628 is --DACPMOD 
  generic (
    bus_width       : natural   := 32;   -- Longeur du bus de donnee
    data_size       : natural   := 12;   -- Taille de la conversion A/N
	canales_dac	 	  : natural	  	:= 3;
    ratio_frequence : natural   := 5);   -- FSPI=50MHz/2*ratio_frequence  = 5 Mhz 

  
  port (                                 --
			clk              :  in  std_logic;
			rst              :  in  std_logic;
	 
			go_spi			  :  in  std_logic;					 -- habilitacion --

  -- Bus d'entree --
  
			in_data_A		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_B		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_C		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_D		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_E		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_F		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_G		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_H		  :  in  std_logic_vector(data_size-1 downto 0);
			
			fin_dac		     :  out std_logic;
    
  -- Bus SPI --
		   spi_clk      	  : out  std_logic;
		   cs  	  	     	  : out  std_logic;
		   MOSI			  	  : out  std_logic);
	 
end AD5628;

architecture test of AD5628 is

-- Machine d'etat
	TYPE state IS (Init,Config,IDLE,TRANSMITION,FIN_SPI);
	signal  ep,es:state;
	signal  init_adc			: std_logic;
	
	signal  fin_tx				: std_logic;
	signal  i_spi_clk			: std_logic;
	signal  i_cs				: std_logic;
	
	signal address_command	: std_logic_vector(3 downto 0) := "0000";
	signal data_in       	: std_logic_vector(data_size-1 downto 0);
	  
begin

--Affectation de sorties
	spi_clk  <= i_spi_clk;
	cs  <= i_cs;
	
 with address_command select
	data_in <= in_data_A when "0000",
				  in_data_B when "0001",
				  in_data_C when "0010",
				  in_data_D when "0011",
				  in_data_E when "0100",
				  in_data_F when "0101",
				  in_data_G when "0110",
				  in_data_H when "0111",
				  in_data_A	when others;
	 

-- machine d'etat: process sequentielle --
process(rst, clk)
begin

  if (rst = '0') then  
  
    ep <= Init;

  elsif (rising_edge(clk)) then  
  
    ep  <= es;
            
  end if;
end process;

-- Machine d'etat: combinationelle --
state_suivant:process(ep,go_spi,fin_tx)

begin

    case ep is
    
			when Init      => 
				es<=Config;

			when Config      => 
				if fin_tx='1' then
					es <= FIN_SPI; 
				else
					es<=Config;
				end if;				
				
	    when IDLE      =>  
			if go_spi='1' then
				es <= TRANSMITION; 
			else
				es<=IDLE;
			end if;
	      				  						
       when TRANSMITION =>  
			if fin_tx='1' then
				es <= FIN_SPI; 
			else
				es<=TRANSMITION;
			end if;
			
		when FIN_SPI =>
			if go_spi='0' then
				es<=IDLE;
			else
				es <= FIN_SPI; 
			end if;
                                 
	end case;
    
  end process;

  
  -- Machine d'etat: sorties
sorties:process(ep)
begin

      case ep is
		
		when Init      => 
				init_adc<='1';
				i_cs<='1';
				fin_dac<='0';	
--
			when Config      => 
				init_adc<='1';
				i_cs<='0';
				fin_dac<='0';	
				
			when IDLE      =>
				init_adc<='0';	
				i_cs<='1';
				fin_dac<='0';	

			when TRANSMITION => 				
				init_adc<='0';
				i_cs<='0';
				fin_dac<='0';	
			
			when FIN_SPI =>
				init_adc<='0';
				i_cs<='1';
				fin_dac<='1';		
		end case;

end process sorties;

	-- Generation de l'horloge definissant la frequence de communication SPI
	clock:process(i_cs, clk)
	variable temp: integer range 0 to ratio_frequence;
	begin

	  if (i_cs='1') then
	  
		 i_spi_clk  <= '1';
		 temp := 0;
		 
	  elsif (rising_edge(clk)) then 
			-- transmition du SPI --
				temp:=temp+1;
				if (temp =ratio_frequence) then
					temp:=0;
					i_spi_clk  <= not i_spi_clk;
				end if;
	  end if;

	end process clock;

	  --Indica fin de trama y cambio de dac
	 address:process(fin_tx)
	 begin
		if(rising_edge(fin_tx)) then
			address_command <= address_command + 1;
			if(address_command = canales_dac -1) then
				address_command <= (others => '0');
			end if;
		end if;
	 end process;
	
	
	-- Registre pour le lecture du bus SPI
	Bufffer_SPI:process(i_cs,i_spi_clk)
	
		variable cont:integer range 0 to (bus_width);					--	bit de donnees --
		variable tdonne:std_logic_vector((bus_width-1) downto 0);	-- trama a envoyer --
		
	begin

	  if (i_cs='1') then
	  	 
		 tdonne := (others => '0');
		 cont:=0;
		 fin_tx<='0';
		 MOSI<='0';		-- chargement du premier bit a envoyer
		 
	  elsif (rising_edge(i_spi_clk)) then 
	  
				-- donnees de configuration --
				if ((init_adc='1') and (cont=0)) then
					tdonne := "0000" & "1000" & "0000" & "000000000000" & "00000001";	-- Vref interne
				
--				-- chargement du donnee vers chaque channel--
				elsif ((init_adc='0') and (cont=0)) then
					tdonne := "0000" & "0011" & address_command(3 downto 0) & data_in(11 downto 0) & "00000000";
				end if;
				
				tdonne:=tdonne((bus_width-2) downto 0) & '0';	--on decalee
				
				MOSI<=tdonne(bus_width-1);	-- envoi le donnee vers le SPI
								
				cont:= cont + 1;  				-- Compteur de donnees envoyes
				
				if (cont = bus_width) then  	-- Fin de transmition vers DAC
					fin_tx<='1';
				end if;
										
	  end if;
	  
	 end process;
	 
		
end test;