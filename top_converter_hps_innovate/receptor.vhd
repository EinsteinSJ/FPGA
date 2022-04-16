library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity receptor is
port(
		clk 		: in  std_logic;
		rx			: in  std_logic; 										--linea serie que entra al rx por la salida del tx
		data_out		: out std_logic_vector(7 downto 0); 	-- salida paralelo
		busy		: out std_logic								-- salida para saber si se usa
		);
end entity;
architecture test of receptor is
-- 50MHz/9600 baudios = cuenta
signal cuenta		: integer range 0 to 5208 :=0;
signal asignacion : integer range 0 to 10:=0;
signal data		 	: std_logic_vector(9 downto 0);
signal flag_rx		: std_logic :='0';
begin
process(clk)
begin
if rising_edge(clk) then
	if (flag_rx='0' and rx='0') then
		asignacion	<= 0;
		cuenta		<=	0;
		busy			<='1';
		flag_rx		<='1';
		end if;
	if (flag_rx='1') then
		data(asignacion)<= rx;
		if (cuenta<5208) then
			 cuenta <= cuenta+1;
		else 
		      cuenta<=0;
		end if;
		if (cuenta=2500) then
			if(asignacion<10) then
				asignacion <= asignacion+1;
			else 
					if (data(0)='0' and data(9)='1') then
							data_out	<= data(8 downto 1);
					else 
							data_out	<= (Others => '0');
					end if;
					flag_rx <= '0';
					busy <= '0';
			end if;
		end if;
	end if;
end if;		
end process;
end test;