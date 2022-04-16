library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity machinetm is
	generic(tm: natural:=5);		  -- 100ns
	port(clk:in std_logic;
		  rst:in std_logic;
		  
		  s: in std_logic;		-- signal d'entree
		  
		  s1: out std_logic;		-- signal avec temps mort positive
		  s1n: out std_logic		-- signal avec temps mort negative
		  );  -- signal avec temps mort low  
end machinetm;

architecture Beh of machinetm is

	type state is(Idle,Zero_Un,TempsMort1,Un_Zero,TempsMort2);
	signal ep,es:state;
	
	signal enable:std_logic;
	signal fin:std_logic;
	
	-- habilitation du temps Mort
	signal st:std_logic;
	signal stn:std_logic;
	
begin
	-- process sequentiel --
	process(clk,rst)
	begin
		if (rst='0') then
			ep<=Idle;
		elsif (rising_edge(clk)) then
			ep<=es;
		end if;
	end process;

	-- process combinationel --
	process(ep,s,fin)
	begin
		case ep is

			when Idle=>
				if (s='0') then
					es<=Zero_Un;
				else
					es<=Un_Zero;					
				end if;

		
			when Zero_Un=>
				if (s='1') then
					es<=TempsMort1;
				else
					es<=Zero_Un;					
				end if;
		
			when TempsMort1 =>
				if (fin='1') then
					es<=Un_Zero;
				else
					es<=TempsMort1;
				end if;
		
			when Un_Zero=>
				if (s='0') then
					es<=TempsMort2;
				else
					es<=Un_Zero;
				end if;	
				
			when TempsMort2 =>
				if (fin='1') then
					es<=Zero_Un;
				else
					es<=TempsMort2;
				end if;

			when others=>
				es<=Idle;
				
		end case;
	end process;
	
	
	-- process sortie
	process(ep)
	begin
		case ep is	
		
			when Zero_Un=>
				enable<='0';
				st<='0';	
				stn<='1';	
		
			when TempsMort1 =>
				enable<='1';
				st<='0';	
				stn<='0';	
		
			when Un_Zero=>
				enable<='0';
				st<='1';	
				stn<='0';	
				
			when TempsMort2 =>
				enable<='1';
				st<='0';	
				stn<='0';	

			when others=>
				enable<='0';
				st<='0';	
				stn<='0';	
				
		end case;
	end process;
	
	-- process retard temps mort --
	
	process(clk,rst)
	variable temp:integer range 0 to tm;
	begin
		if (rst='0') then
			temp:=0;
			fin<='0';
		elsif (rising_edge(clk)) then
			if (enable='1') then
				temp:=temp+1;
				if (temp=(tm-1)) then
					temp:=0;
					fin<='1';
				end if;				
			else
				temp:=0;
				fin<='0';
			end if;
		end if;
	end process;
	
	-- sortie avec temps mort --
	s1<=s and st;
	s1n<=(not s) and stn;
	
end Beh;