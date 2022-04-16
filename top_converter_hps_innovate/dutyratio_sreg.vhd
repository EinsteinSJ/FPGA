library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dutyratio_sreg is 
port(
		clk : in std_logic;
		rst : in std_logic;
		wot : in std_logic_vector(9 downto 0);
		temp 	: out std_logic;				-- svred > 0 (apoyo)
		zcf : out std_logic;
		alpha : out std_logic_vector(9 downto 0) := "0011111010"
);
end dutyratio_sreg;

architecture test of dutyratio_sreg is 
--Zona de señales 
signal swot :integer range 0 to 999; 
signal salpha : integer range 0 to 999 := 250;
signal scount 	: integer range 0 to 250 := 250;		-- := 250 --> 1 0 : sequence clock  / := 0 --> 0 1 : sequence clock
signal sclk : std_logic;		-- CLK 100KHZ
signal zc: std_logic; 
signal q0,q1 : std_logic;
signal cs : std_logic; 	-- habilitador

begin 
	
	swot <= to_integer(unsigned(wot));

------------------------------------------------------------------------
--								  ZERO	: DETECTION								    --
------------------------------------------------------------------------
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
		q0 <= zc;		-- zc: se genera aca

process(clk)
begin
	if (clk'event and clk='1') then
		q1 <= q0;
	end if;		
end process;


	cs <= (q0 and (not q1)) or ((not q0) and q1);	 --detecto flanco de subida : bajada

-----------------------------------------------------------------------	
	
process(clk,rst)
begin 
 if (rst = '0') then 
	salpha <= 250;
 elsif (clk'event and clk = '1') then 
		if (swot >=0 and swot <250) then 
			salpha <= swot + 250;
		elsif (swot >=250 and swot <500) then 
		   salpha <= 750 - swot;	
		elsif (swot >=500 and swot <750) then 
			salpha <= swot - 250;		
		else 
			salpha <= 1250 - swot;		
		end if;	
 end if;
end process;

process(clk)
begin
 if (clk'event and clk = '1') then
	if (scount = 250) then  
        scount <= 0;
        sclk <= not sclk;
    else
        scount <= scount + 1;
    end if;
 end if;
end process;

--Creacion : Registro para la salida de alpha con un clock de 100KHZ (fc) 
process(sclk)
begin 
 if (sclk'event and sclk = '1') then 
	 alpha <= std_logic_vector(to_unsigned(salpha,10));
 end if;
end process;

	zcf <= cs; 	-- zero crossed
	temp <= zc;
	
end test; 