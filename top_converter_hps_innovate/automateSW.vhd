library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity automateSW is 
port(	
		clk 	: in  std_logic;
		rst 	: in  std_logic;
		zero 	: in  std_logic;
		svred : in  std_logic_vector(11 downto 0);
		temp 	: out std_logic := '0'
);
end automateSW;

architecture test of automateSW is 

type state_type is (detector,fin);
signal ep,es:state_type;

--	Señal SW ON
signal enable_cuenta : std_logic := '0';
signal scount 	 		: integer range 0 to 250 := 0;	-- tiempo de espera cuento zeros 
signal cont 			: std_logic;

begin

process(zero,svred)
begin
 if (enable_cuenta = '1') then 
	if ((zero'event and zero = '1') and to_integer(unsigned(svred)) > 2500) then 
		if (scount = 120) then 
		   scount <= 0;
		else 
			scount <= scount +1;
		end if;
	end if;
 end if;
end process;

cont <= '1' when (scount = 120) else '0';
			
process(rst,clk)
begin 
 if(rst = '0') then 
	ep <= detector;
 elsif(clk'event and clk = '1') then 
	ep <= es;
 end if;
end process;

process(zero,svred)
begin 
	
	case ep is
		when detector => 
			if (zero='1' and to_integer(unsigned(svred)) > 2500 and cont = '1') then 
				es <= fin;
			else 
				es <= detector;
			end if;
		
		when fin => 
			if (to_integer(unsigned(svred)) > 2500) then
				es <= fin;
			else
				es <= detector; 
			end if;
			
	end case;
end process;

temp <= '1' when (ep = fin) else '0';
enable_cuenta <= '1' when (ep = detector) else '0';


end test;