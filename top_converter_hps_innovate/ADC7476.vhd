-- Interface SPI avec le CAN Analog device AD7476 AD7477 AD7478 ...

-- La lectura se realiza en 4 estados --
-- 1. Idle: 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ADC7476 is 
  generic (
    bus_width       : natural   := 16;  	 -- Longeur du bus de donnee
    data_size       : natural   := 12;   	 -- Taille de la conversion A/N
    ratio_frequence : natural   := 3);    -- FSPI=50MHz/2*ratio_frequence = 5Mhz
  
  port (                                 --
	  clk            :  in  std_logic;
     rst            :  in  std_logic;
	 
	 go_spi:	in std_logic;					 -- habilitacion --

  -- Bus de sortie : la donne plus un bit de validation de nouvelle donne
    Data_out1     :  out std_logic_vector(data_size-1 downto 0);   -- vo
	 Data_out2     :  out std_logic_vector(data_size-1 downto 0);   -- io
	 Data_out3     :  out std_logic_vector(data_size-1 downto 0);   -- vfa
	 
    fin_adc	      :  out std_logic;
    
      -- Bus SPI
    spi_clk      :  out std_logic;
    cs    	     :  out std_logic;
    vo			  :  in  std_logic;
	 io			  :  in  std_logic;
	 vfa			  :  in  std_logic);
	 
end ADC7476;

architecture test of ADC7476 is

-- Machine d'etat
	TYPE state IS (IDLE,RECEPTION, VALID, TQUIET);
	signal   ep,es			:state;
	signal   fin_rx		:std_logic;
	signal   i_spi_clk	: std_logic;
	signal   i_cs     	: std_logic;
  
begin

--Affectation de sorties
  spi_clk  <= i_spi_clk;
  cs      <= i_cs;  
  

-- Process state: sequence
process(rst, clk)
begin

  if (rst = '0') then  
  
    ep <= IDLE;

  elsif (rising_edge(clk)) then  
  
    ep  <= es;
            
  end if;
end process;

-- Machine d'etat: combinationnelle
state_suivant:process(ep,go_spi,fin_rx)
begin

    case ep is
    
	   when IDLE      =>  
			if go_spi='1' then
				es <= RECEPTION; 
			else
				es<=IDLE;
			end if;
	      				  
						  
      when RECEPTION => 
		 
			if fin_rx='1' then
				es <= TQUIET; 
			else
				es<=RECEPTION;
			end if;
			
		when TQUIET    =>           
				es<=VALID;
				
		when VALID => 	
			if go_spi='0' then
				es<=IDLE;
			else
				es<=VALID;
			end if;
                                 
	end case;
    
  end process;

  
  -- Machine d'etat pour les sorties
sorties:process(ep)
begin

      case ep is
    
			when IDLE      => 
				i_cs<='1';
				fin_adc<='0';
	     				            
			when TQUIET    =>           
				i_cs<='1';
				fin_adc<='0';		
				
			 when VALID => 	
				i_cs<='1';
				fin_adc<='1';
				
			when others => 
				i_cs<='0';
				fin_adc<='0';				
                      
		end case;
    
end process sorties;

	-- Generation de l'horloge du SPI
	clock:process(i_cs, clk)
	variable temp: integer range 0 to ratio_frequence;
	begin

	  if (i_cs= '1') then
	  
		 i_spi_clk  <= '1';
		 temp := 0;
		 
	  elsif (rising_edge(clk)) then 
			temp:=temp+1;
			if (temp =ratio_frequence) then
				temp:=0;
				i_spi_clk  <= not i_spi_clk;
			end if;

	  end if;

	end process clock;

	
	-- Registre pour le lecture du bus SPI
	Bufffer_SPI:process(i_cs,i_spi_clk)
		variable cont:integer range 0 to (bus_width);
		variable tdonne1:std_logic_vector((bus_width-1) downto 0);
		variable tdonne2:std_logic_vector((bus_width-1) downto 0);
		variable tdonne3:std_logic_vector((bus_width-1) downto 0);

	begin

	  if (i_cs='1') then
	  	 
		 tdonne1 := (others => '0');
		 tdonne2 := (others => '0');
		 tdonne3 := (others => '0');
		 cont:=0;
		 fin_rx<='0';
		 
	  elsif (rising_edge(i_spi_clk)) then 
		
				tdonne1     := tdonne1(bus_width-2 downto 0) & vo;
				tdonne2     := tdonne2(bus_width-2 downto 0) & io;
				tdonne3     := tdonne3(bus_width-2 downto 0) & vfa;
				
				cont:= cont + 1;  -- Compteur de donnee recus
				
				if (cont = bus_width) then  -- Fin de reception de donnee
					fin_rx<='1';				-- indicador de fin de rx
					cont:=0;	
					Data_out1<=tdonne1(data_size downto 1);	-- el ultimo desplzamiento no vale (ver figura)
					Data_out2<=tdonne2(data_size downto 1);	
					Data_out3<=tdonne3(data_size downto 1);	
				end if; 

	  end if;
	 end process;
		
end test;