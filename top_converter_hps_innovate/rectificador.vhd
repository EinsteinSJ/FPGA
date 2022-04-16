library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rectificador is 
generic(
		W : natural := 0
		--retraso : natural := 6 			--vista en el osciloscopio (100 us)
);
port(
		clk 	: in std_logic;
		rst 	: in std_logic;
		
	-- cruce por cero generacion sin retardo 
	
		wot 	: in std_logic_vector(9 downto 0);		
	
	-- Señales de control 
	
		zcf 	: out std_logic;
		temp 	: out std_logic;
		
		sw  	: out std_logic;
		nsw 	: out std_logic
		
	--------------------------------
	----	|  SW	  |  nSW  | 	-----		(+) SW 
	----	|  nSW  |  SW   |    ----- 	(-) nSW 
	--------------------------------
		
);
end rectificador;

architecture test of rectificador is 
signal q0,q1 : std_logic;
signal cs : std_logic; 	-- habilitador
signal swot :integer range 0 to 999; --simular 
signal zc : std_logic;
 
begin
	
		swot <= to_integer(unsigned(wot));

process(clk) 
begin 
	if(clk' event and clk = '1') then 
		if(swot >=0 and swot <500) then 
			zc <= '1';
		else 
			zc <= '0'; 
		end if;
	end if;
end process;

-- Change : 01/02 Mejora del detector de flanco 
		q0 <= zc;		-- zc: se generanda aca

process(clk)
begin
	if (clk'event and clk='1') then
		q1 <= q0;
	end if;		
end process;


	cs <= (q0 and (not q1)) or ((not q0) and q1);	 --detecto flanco de subida : bajada
	
-- Señales de control 
process(clk)
begin 
---- reviso en flanco de bajada para evitar atrasos
	if (rst = '0') then 
		sw  <= '0';
		
	elsif (clk'event and clk='0') then	
	
		if (cs = '0') then 
			 if ((swot >= W/2) and (swot < 500- (W/2))) then  
					sw  <= '1';
					nsw  <= '0';
			 elsif ((swot >= 500 + (W/2)) and (swot < 1000 - (w/2)) ) then 
					sw  <= '0'; 
					nsw  <= '1';
			 else 			-- RANGE W 
					sw  <= '0';
					nsw  <= '0';
			 end if;
		else 
			sw  <= '0';
			nsw  <= '0';
	   end if;
	end if;
end process;

	zcf <= cs;
	temp <= zc;
	
end test; 