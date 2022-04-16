
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_phase is 
port(
		clk 		: in 	std_logic;
		rst 		: in 	std_logic;
		go 		: in  std_logic;  						 -- bottom
		phi_ref	: in  integer range 0 to 500;			 -- valuer souhatiee
		phi		: out integer range 0 to 500;			 -- toSignalControl
		
	--Sorties 
		cuenta 	: out std_logic_vector(4 downto 0);  -- leds [4..0]
		led	  	: out std_logic;							 -- leds [5]
		phi_min	: out std_logic;							 -- leds [6]
		phi_max  : out std_logic							 -- leds [7]
);
end top_phase;

architecture test of top_phase is
component automate_phase is
port (                                
		clk            	:  in  std_logic;
		rst            	:  in  std_logic;
		phi_min			  	:  in  std_logic;	
		phi_max				:  in  std_logic;	
		go				   	:  in  std_logic;
		led				   : out  std_logic;																									
		cuenta 				: out  std_logic_vector(4 downto 0);		
		go_phase				: out  std_logic;	
		go_pnom				: out  std_logic														
);

end component;

component control_phase is
port(
		clk            		:  in  std_logic;
		rst            		:  in  std_logic;			
		go_phase					:  in  std_logic;					
		go_pnom					:  in  std_logic;							
		phi_ref					:  in  integer range 0 to 500;	
		phi		 	   		: out  integer range 0 to 500;
	-- Indicators 
		phi_tmax					: out  std_logic;					
		phi_tmin					: out  std_logic			
);
end component;

--Declaracion de señales 
signal sgo_phase : std_logic;
signal sgo_pnom  : std_logic;
signal sphi_max  : std_logic;
signal sphi_min  : std_logic;

begin

U1: control_phase PORT MAP(
		clk            		=> clk,
		rst            		=> rst,			
		go_phase					=> sgo_phase,					
		go_pnom					=> sgo_pnom,							
		phi_ref					=> phi_ref,	
		phi		 	   		=> phi,
	-- Indicadores 	
		phi_tmax					=> sphi_max,					
		phi_tmin					=> sphi_min	
);

U2 : automate_phase PORT MAP(
		clk            	=> clk,
		rst            	=> rst,
		phi_min			  	=> sphi_min,
		phi_max				=> sphi_max,
		go				   	=> go,
		led				   => led,																									
		cuenta 				=> cuenta,		
		go_phase				=> sgo_phase,	
		go_pnom				=> sgo_pnom	

);

phi_max <= sphi_max;
phi_min <= sphi_min;

end test;