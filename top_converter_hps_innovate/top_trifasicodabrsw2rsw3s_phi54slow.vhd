
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_trifasicodabrsw2rsw3s_phi54slow is
generic(
			 retardo : natural := 7 		-- 116us (60M)
);
port(
			CLK 			: in  std_logic;
			RST 			: in  std_logic;
			
			--data_leds 	: out std_logic_vector(11 downto 0);
			
			go 			: in std_logic;
			
			--SALIDAS ZIGBEE - PHASE CONTROL 
			
			cuenta 		: out std_logic_vector(4 downto 0);  -- leds [4..0]
			led	  		: out std_logic;							 -- leds [7]
			phi_min		: out std_logic;							 -- leds [6]
			phi_max  	: out std_logic;							 -- leds [5]
			
			-- switches para seleccion de phase
			--switches 	: in std_logic_vector(3 downto 0);  -- switches [3..0]
			
			-- ZIGBEE
			USB_TXD 		:  in 	std_logic;
			
			--SEÑALES DE APOYO 
			MISO5			: out std_logic;
			MISO4			: out std_logic;
			
			--CLOCK MULTIPLEXADO ADC Y DAC
			SCLK_A		: out std_logic;	--clock DAC
			SCLK_B		: out std_logic;	--clock ADC

			--DAC
			DA_SSEL 		: out std_logic;
			DA_MOSI  	: out std_logic;
			
			--ADC
			-- LINEA R 
			SSEL1 		: out std_logic; 
			MISO2 		: in  std_logic;
			
			-- LINEA S 
			SSEL3 		: out std_logic; 
			MISO6 		: in  std_logic;
			
			-- LINEA T 
			SSEL4 		: out std_logic; 
			MISO8 		: in  std_logic;
			
		--DABSR: DUAL ACTIVE BRIDGE SERIE RESONANT   
			--			DC		| 7	5 |	  RS		|	1    3	|	--  |	5    7	|		AC
			--	 	 SOURCE	| 8   6 |	SOURCE	|	2    4	|	--  |	6    8	| 	 SOURCE
		
		-- SALIDAS DRIVERS POTENCIA:
		
		-- LINEA R 
		-- BRIDGE TWO 
			DRV6_1		: 	out	std_logic;
			DRV6_2		: 	out	std_logic;
			DRV6_3		: 	out	std_logic;
			DRV6_4		: 	out	std_logic;
			
		-- RECTIFICADOR SINCRONO
			DRV6_5		: 	out	std_logic;
			DRV6_6		: 	out	std_logic;
			DRV6_7		: 	out	std_logic;
			DRV6_8		: 	out	std_logic;
			
		-- SW ON
			DRV6_10		: 	out	std_logic;
			DRV6_12		: 	out	std_logic;
		
		-- LINEA S 
		-- BRIDGE TWO 
			DRV3_1		: 	out	std_logic;
			DRV3_2		: 	out	std_logic;
			DRV3_3		: 	out	std_logic;
			DRV3_4		: 	out	std_logic;
			
		-- RECTIFICADOR SINCRONO
			DRV3_5		: 	out	std_logic;
			DRV3_6		: 	out	std_logic;
			DRV3_7		: 	out	std_logic;
			DRV3_8		: 	out	std_logic;
			
		-- SW ON
			DRV3_10		: 	out	std_logic;
			DRV3_12		: 	out	std_logic;
		
		-- LINEA T
		-- BRIDGE TWO 
			DRV1_1		: 	out	std_logic;
			DRV1_2		: 	out	std_logic;
			DRV1_3		: 	out	std_logic;
			DRV1_4		: 	out	std_logic;
			
		-- RECTIFICADOR SINCRONO
			DRV1_5		: 	out	std_logic;
			DRV1_6		: 	out	std_logic;
			DRV1_7		: 	out	std_logic;
			DRV1_8		: 	out	std_logic;
			
		-- SW ON
			DRV1_10		: 	out	std_logic;
			DRV1_12		: 	out	std_logic;
			
		-- BRIGDE ONE 
			DRV4_5		: 	out	std_logic;
			DRV4_6		: 	out	std_logic;
			DRV4_7		: 	out	std_logic;
			DRV4_8		: 	out	std_logic	
			
);
end top_trifasicodabrsw2rsw3s_phi54slow;

architecture test of top_trifasicodabrsw2rsw3s_phi54slow is 

--Zona de componentes
component ADC7476 is
generic (
			data_size       : natural   := 12
);
port (                            
			clk        :  in  std_logic;
			rst        :  in  std_logic;
	 
			go_spi	  :	in std_logic;					 -- habilitacion --

		-- Bus de sortie : la donne plus un bit de validation de nouvelle donne --
			Data_out1  :  out std_logic_vector(data_size-1 downto 0);
			Data_out2  :  out std_logic_vector(data_size-1 downto 0);
			Data_out3  :  out std_logic_vector(data_size-1 downto 0);
	 
			fin_adc	  :  out std_logic;
    
      -- Bus comunicacion SPI --
			spi_clk    :  out std_logic;
			cs    	  :  out std_logic;
			vo			  :  in  std_logic;
			io			  :  in  std_logic;
			vfa		  :  in  std_logic
);
end component;

component AD5628 is
generic (
			data_size       : natural   := 12
);
port(
			clk        :  in  std_logic;
			rst        :  in  std_logic;
	 
			go_spi	  :  in  std_logic;					 -- habilitacion --
			
		-- Bus d'entree --
			in_data_A		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_B		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_C		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_D		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_E		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_F		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_G		  :  in  std_logic_vector(data_size-1 downto 0);
			in_data_H		  :  in  std_logic_vector(data_size-1 downto 0);
			
			fin_dac	  :  out std_logic;
    
      -- Bus comunicacion SPI --
			spi_clk    :  out std_logic;
			cs  	  	  :  out std_logic;
			MOSI		  :  out std_logic
);
end component;

component timer is 
port(
			clk        :  in  std_logic;
			rst        :  in  std_logic;
	  		
		-- Señales de temporization --
			t_0		  :  out  std_logic;		-- lecture des ADC 
			t_1		  :  out  std_logic		-- Calcule des signals de commande	
);
end component;

component automate is 
port(
			clk        :  in  std_logic;
			rst        :  in  std_logic;
	 
	   -- signaux de temporization  --
			t_0		  :  in  std_logic;					 -- debut de la periode --
			t_1		  :  in  std_logic;					 -- debut de calcul --
		
      -- signaux pour le controle du ADC  --
			go_adc	  :  out std_logic;
			fin_adc	  :  in	std_logic;		
    
      -- signaux pour le controle du DAC  --
			go_dac	  :  out std_logic;
			fin_dac	  :  in	std_logic
);
end component;

--DSP BUILDER generate
component PLL_3orden_change is
port(
			Clock 	: in std_logic;
			Va_12b : out std_logic_vector(12-1 downto 0);
			Vb_12b : out std_logic_vector(12-1 downto 0);
			Vin_12b : out std_logic_vector(12-1 downto 0);
			Vm_12b : out std_logic_vector(12-1 downto 0);
			aclr 		: in std_logic;
			clk60KPLL: in std_logic;
			vin 		: in std_logic_vector(12-1 downto 0);
			wot 		: out std_logic_vector(10-1 downto 0)
);
end component;

component machinetm is
port
	(
		clk		: in  std_logic;
		rst		: in  std_logic;
		s			: in  std_logic;
		s1			: out  std_logic;
		s1n 		: out  std_logic
);
end component;

component signalcontrol is
port(
		clk            	:  in  std_logic;
		rst            	:  in  std_logic;
		alpha	 	   		: 	in integer range 0 to 999;	 
		phi					: 	in integer range 0 to 999;	 
		s1			  			:  out  std_logic;
		s2			  			:  out  std_logic	
);
end component;

component dutyratio_sreg is 
port(
		clk				   : in std_logic;
		rst 					: in std_logic;
		wot 					: in std_logic_vector(9 downto 0);
		temp 					: out std_logic;		-- apoyo 
		zcf 					: out std_logic;
		alpha 				: out std_logic_vector(9 downto 0)
);
end component;

--Maquina de estados SW ON
component automateSW is 
port(	
		clk 				 	: in  std_logic;
		rst 					: in  std_logic;
		zero 					: in  std_logic;
		svred 				: in  std_logic_vector(11 downto 0);
		temp 					: out std_logic := '0'
);
end component;

component pll is 
port(
		inclk0				: in  std_logic := '0';
		c0 					: out std_logic;		-- 120MHz
		c1 					: out std_logic		-- 60MHz
);
end component;

component rectificador is 
port(
		clk : in std_logic;
		rst : in std_logic;
		
	-- cruce por cero generacion sin retardo 
		
		wot : in std_logic_vector(9 downto 0);		--angulo 
		
	-- Señales de control
		zcf : out std_logic;
		temp : out std_logic;
		
		sw  : out std_logic;
		nsw : out std_logic
		
	--------------------------------
	----	|  SW	  |  nSW  | 	-----		(+) SW 
	----	|  nSW  |  SW   |    ----- 	(-) nSW 
	--------------------------------
		
);
end component;

--Receptor Zigbee RX 
component receptor is 
port(
			clk 			: in  std_logic;
			rx				: in  std_logic; 								--linea serie que entra al rx por la salida del tx
			data_out		: out std_logic_vector(7 downto 0); 	-- salida paralelo
			busy			: out std_logic								-- salida para saber si se usa
			);
end component;

-- Zona de componentes 
component top_phase is 
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
end component;

--Zona de señales
signal sgo_adc  	:  std_logic;
signal sgo_dac  	:  std_logic;
signal sfin_adc 	:  std_logic;
signal sfin_adc1, sfin_adc2, sfin_adc3 : std_logic;
signal sfin_dac 	:  std_logic;
signal sclk_adc 	:  std_logic;
signal sclk_adc1, sclk_adc2, sclk_adc3 : std_logic;
signal sclk_dac 	:  std_logic;
signal st_0		 	:	std_logic;
signal st_1		 	:	std_logic;
signal ptest_R	 	:  std_logic_vector(11 downto 0);
signal ptest_S	 	:  std_logic_vector(11 downto 0);
signal ptest_T	 	:  std_logic_vector(11 downto 0);

signal salpha1,salpha2,salpha3 : std_logic_vector(9 downto 0);
signal angle1,angle1_r	: std_logic_vector(9 downto 0);
signal angle2,angle2_r	: std_logic_vector(9 downto 0);
signal angle3,angle3_r	: std_logic_vector(9 downto 0);


-- Bus comunicacion SPI - ADC --
signal cs_adc1  	: std_logic;
signal miso_adc1 	: std_logic;
signal cs_adc2   	: std_logic;
signal miso_adc2 	: std_logic;
signal cs_adc3   	: std_logic;
signal miso_adc3 	: std_logic;
	
-- Bus comunicacion SPI - DAC --
signal cs_dac   	: std_logic;
signal mosi_dac 	: std_logic;

-- señales para mejorar el retraso	
signal sangle1   	: integer range 0 to 999 := 0;
signal sangle2   	: integer range 0 to 999 := 0;
signal sangle3   	: integer range 0 to 999 := 0;

-- Señales de potencias
signal CLK_120MHZ : std_logic;
signal CLK_60MHZ : std_logic;
signal ss1,ss2	 	: std_logic;
signal ss3,ss4	 	: std_logic;
signal ss5,ss6	 	: std_logic;
signal ss7,ss8	 	: std_logic;
signal ss9,ss10	: std_logic;
signal ss11,ss12	: std_logic;
signal ss13,ss14	: std_logic;

signal sa_1		 	: std_logic;
signal sa_2		 	: std_logic;
signal sb_1		 	: std_logic;
signal sb_2		 	: std_logic;

signal sc_1		 	: std_logic;
signal sc_2		 	: std_logic;
signal sd_1		 	: std_logic;
signal sd_2		 	: std_logic;

signal se_1		 	: std_logic;
signal se_2		 	: std_logic;
signal sf_1		 	: std_logic;
signal sf_2		 	: std_logic;

signal sg_1		 	: std_logic;
signal sg_2		 	: std_logic;
signal sh_1		 	: std_logic;
signal sh_2		 	: std_logic;

signal sw_r_1		 	: std_logic;
signal sw_r_2		 	: std_logic;
signal sw_s_1		 	: std_logic;
signal sw_s_2		 	: std_logic;
signal sw_t_1		 	: std_logic;
signal sw_t_2		 	: std_logic;

-- VRED RMS
signal svred_R	 	: std_logic_vector(11 downto 0);
signal svred_S	 	: std_logic_vector(11 downto 0);
signal svred_T	 	: std_logic_vector(11 downto 0);

signal temp : std_logic;

-- Zero crossed
signal zero1,zero2,zero3 : std_logic;
signal temp1,temp2,temp3 : std_logic;

-- ZIGBEE RX
signal scount 		: integer range 0 to 2500000 := 0;
signal sled 		: std_logic;
signal sclk 		: std_logic;
signal sphi 		: integer range 0 to 999;
signal rx_data		: std_logic_vector(7 downto 0);
signal go_uart		: std_logic;
signal q0, q1, flanco : std_logic;

signal go2phase   : std_logic;

-- CASO : RED FALLA 26/02 
signal nq0, nq1 	: std_logic;
signal ntemp 		: std_logic;		-- SI LA RED FALLA 

-- SIGNAL SELECTOR PHASE 08 NOV 21
--signal scuenta 	 : std_logic_vector(4 downto 0);
--signal selectphase : integer range 0 to 500;

-- VENDREDI 26 NOV
signal ss1_ref		: std_logic;

begin

	sfin_adc <= sfin_adc3; 
	sclk_adc <= sclk_adc1 ;

	--data_leds <= ptest;
	SCLK_A    	 <= sclk_dac and sclk_adc;
	SCLK_B	 	 <= sclk_adc;
	miso_adc1	 <= MISO2;
	SSEL1	    	 <= cs_adc1;
	miso_adc2	 <= MISO6;
	SSEL3	    	 <= cs_adc2;
	miso_adc3	 <= MISO8;
	SSEL4	    	 <= cs_adc3;
	DA_SSEL   	 <= cs_dac;	
	DA_MOSI   	 <= mosi_dac;
	
-- Señales de apoyo 
	MISO5     <= ss1_ref;
	MISO4		 <= ss1;

--Zona de instancias
U1_R :ADC7476 PORT MAP(
			clk	 	 => CLK_60MHZ,
			rst	 	 => RST,
			
			go_spi  	 => sgo_adc,
		
		-- Bus de sortie : la donne plus un bit de validation de nouvelle donne --	
			Data_out1 => ptest_R,
			Data_out2 => open,
			Data_out3 => open,
			
			fin_adc 	 => sfin_adc1,
			
		-- Bus comunicacion SPI --	
			spi_clk 	 => sclk_adc1,
			cs 		 => cs_adc1,
			vo			 => miso_adc1,
			io			 => '0',
			vfa		 => '0'		
	);
	
U1_S :ADC7476 PORT MAP(
			clk	 	 => CLK_60MHZ,
			rst	 	 => RST,
			
			go_spi  	 => sgo_adc,
		
		-- Bus de sortie : la donne plus un bit de validation de nouvelle donne --	
			Data_out1 => ptest_S,
			Data_out2 => open,
			Data_out3 => open,
			
			fin_adc 	 => sfin_adc2,
			
		-- Bus comunicacion SPI --	
			spi_clk 	 => sclk_adc2,
			cs 		 => cs_adc2,
			vo			 => miso_adc2,
			io			 => '0',
			vfa		 => '0'		
	);
	
U1_T :ADC7476 PORT MAP(
			clk	 	 => CLK_60MHZ,
			rst	 	 => RST,
			
			go_spi  	 => sgo_adc,
		
		-- Bus de sortie : la donne plus un bit de validation de nouvelle donne --	
			Data_out1 => ptest_T,
			Data_out2 => open,
			Data_out3 => open,
			
			fin_adc 	 => sfin_adc3,
			
		-- Bus comunicacion SPI --	
			spi_clk 	 => sclk_adc3,
			cs 		 => cs_adc3,
			vo			 => miso_adc3,
			io			 => '0',
			vfa		 => '0'		
	);

U2	:AD5628 PORT MAP(
			clk	 	 => CLK_60MHZ,
			rst	 	 => RST,
			
			go_spi  	 => sgo_dac,
			
		-- Bus d'entree --	
			in_data_A   => "00" & angle1_r, 		--ptest
			in_data_B   => (others => '0'),
			in_data_C   => (others => '0'),
			in_data_D   => (others => '0'),
			in_data_E   => (others => '0'),
			in_data_F   => (others => '0'),
			in_data_G   => (others => '0'),
			in_data_H   => (others => '0'),
			
			fin_dac 	 => sfin_dac,
			
		-- Bus comunicacion SPI --	
			spi_clk 	 => sclk_dac,
			cs 		 => cs_dac,
			MOSI 		 => mosi_dac
	);

U3	:automate PORT MAP(
			clk	 	 => CLK_60MHZ,
			rst	 	 => RST,
			
		 -- signaux de temporization  --
			t_0		 => st_0,
			t_1		 => st_1,
			
		-- signaux pour le controle du ADC  --
			go_adc    => sgo_adc,
			fin_adc   => sfin_adc,
			
		-- signaux pour le controle du ADC  --
			go_dac	 => sgo_dac,
			fin_dac	 => sfin_dac
	);
	
T1	:timer PORT MAP(
			clk	 	 => CLK_60MHZ,
			rst	 	 => RST,
			
		-- Señales de temporization --
			t_0		 => st_0,
			t_1		 => st_1
	);

P1_R :PLL_3orden_change PORT MAP(		
			Clock 								 => CLK_60MHZ,			
			Va_12b								 => open,
			Vb_12b 								 => open,
			Vin_12b 								 => open,
			Vm_12b 								 => svred_R,
			aclr 									 => RST,
			clk60KPLL 							 => st_0,
			vin 									 => ptest_R,
			wot 									 => angle1		
);

-- Se tiene un retardo en el PLL (100 us) por ende se adelanta la señal  
 sangle1 <= to_integer(unsigned(angle1));	

process(CLK_60MHZ)
variable vwot : integer range 0 to (1000 + retardo) :=0;
begin 
if (CLK_60MHZ'event and CLK_60MHZ = '1') then 
	if (sangle1 >= 0) then 
		vwot := sangle1 + retardo;
		if(vwot >= 1000 and vwot < (1000 + retardo)) then 
			vwot := vwot -1000;
		end if;
	end if;
end if;
	angle1_r <= std_logic_vector(to_unsigned(vwot,10));
end process;

P1_S :PLL_3orden_change PORT MAP(		
			Clock 								 => CLK_60MHZ,			
			Va_12b								 => open,
			Vb_12b 								 => open,
			Vin_12b 								 => open,
			Vm_12b 								 => svred_S,
			aclr 									 => RST,
			clk60KPLL 							 => st_0,
			vin 									 => ptest_S,
			wot 									 => angle2		
);

-- Se tiene un retardo en el PLL (100 us) por ende se adelanta la señal  
 sangle2 <= to_integer(unsigned(angle2));	

process(CLK_60MHZ)
variable vwot : integer range 0 to (1000 + retardo) :=0;
begin 
if (CLK_60MHZ'event and CLK_60MHZ = '1') then 
	if (sangle2 >= 0) then 
		vwot := sangle2 + retardo;
		if(vwot >= 1000 and vwot < (1000 + retardo)) then 
			vwot := vwot -1000;
		end if;
	end if;
end if;
	angle2_r <= std_logic_vector(to_unsigned(vwot,10));
end process;

P1_T :PLL_3orden_change PORT MAP(		
			Clock 								 => CLK_60MHZ,			
			Va_12b								 => open,
			Vb_12b 								 => open,
			Vin_12b 								 => open,
			Vm_12b 								 => svred_T,
			aclr 									 => RST,
			clk60KPLL 							 => st_0,
			vin 									 => ptest_T,
			wot 									 => angle3		
);

-- Se tiene un retardo en el PLL (100 us) por ende se adelanta la señal  
 sangle3 <= to_integer(unsigned(angle3));	

process(CLK_60MHZ)
variable vwot : integer range 0 to (1000 + retardo) :=0;
begin 
if (CLK_60MHZ'event and CLK_60MHZ = '1') then 
	if (sangle3 >= 0) then 
		vwot := sangle3 + retardo;
		if(vwot >= 1000 and vwot < (1000 + retardo)) then 
			vwot := vwot -1000;
		end if;
	end if;
end if;
	angle3_r <= std_logic_vector(to_unsigned(vwot,10));
end process;


-- modificacion el duty ratio se usara en el puente conectado al rectificador sincrono 
-- antes se usaba en el puente conectado al PV
 
U4_R :dutyratio_sreg PORT MAP(
			clk	 	 => CLK_60MHZ,
			rst	 	 => RST,
			wot 		 => angle1_r,
			temp 		 => open,
			zcf 		 => zero1,
			alpha 	 => salpha1
);

U4_S :dutyratio_sreg PORT MAP(
			clk	 	 => CLK_60MHZ,
			rst	 	 => RST,
			wot 		 => angle2_r,
			temp 		 => open,
			zcf 		 => zero2,
			alpha 	 => salpha2
);

U4_T :dutyratio_sreg PORT MAP(
			clk	 	 => CLK_60MHZ,
			rst	 	 => RST,
			wot 		 => angle3_r,
			temp 		 => open,
			zcf 		 => zero3,
			alpha 	 => salpha3
);

-- BRIGDE CONECTED TO RS CIRCUIT
-- salidas puente conectado al rectificador sincrono
-- R

S2: signalcontrol PORT MAP(    
			clk		=>	CLK_120MHZ,				-- CLK 100 MHZ 
			rst  		=>	RST,
			alpha		=>	to_integer(unsigned(salpha1)),
			phi		=>	250,						-- EN FASE 0°
			s1			=>	ss3, 			
			s2			=>	ss4						
);

D3: machinetm PORT MAP(
				clk		=> CLK,
				rst		=> RST,
				
				s			=>	ss3,					-- S1 
				
				s1			=> sc_1,					-- ADD DELAY 300ns  
				s1n		=> sc_2
);

D4: machinetm PORT MAP(
				clk		=> CLK,
				rst		=> RST,
				
				s			=>	ss4,				 	-- S2
				
				s1			=> sd_1,					-- ADD DELAY 300ns  
				s1n		=> sd_2
);	

-- S

S3: signalcontrol PORT MAP(    
			clk		=>	CLK_120MHZ,				-- CLK 100 MHZ 
			rst  		=>	RST,
			alpha		=>	to_integer(unsigned(salpha2)),
			phi		=>	250,						-- EN FASE 0°
			s1			=>	ss7, 			
			s2			=>	ss8						
);

D7: machinetm PORT MAP(
				clk		=> CLK,
				rst		=> RST,
				
				s			=>	ss7,					-- S1 
				
				s1			=> se_1,					-- ADD DELAY 300ns  
				s1n		=> se_2
);

D8: machinetm PORT MAP(
				clk		=> CLK,
				rst		=> RST,
				
				s			=>	ss8,				 	-- S2
				
				s1			=> sf_1,					-- ADD DELAY 300ns  
				s1n		=> sf_2
);	

-- T

S4: signalcontrol PORT MAP(    
			clk		=>	CLK_120MHZ,				-- CLK 100 MHZ 
			rst  		=>	RST,
			alpha		=>	to_integer(unsigned(salpha3)),
			phi		=>	250,						-- EN FASE 0°
			s1			=>	ss11, 			
			s2			=>	ss12						
);

D11: machinetm PORT MAP(
				clk		=> CLK,
				rst		=> RST,
				
				s			=>	ss11,					-- S1 
				
				s1			=> sg_1,					-- ADD DELAY 300ns  
				s1n		=> sg_2
);

D12: machinetm PORT MAP(
				clk		=> CLK,
				rst		=> RST,
				
				s			=>	ss12,				 	-- S2
				
				s1			=> sh_1,					-- ADD DELAY 300ns  
				s1n		=> sh_2
);	


--Rectificador Sincrono (RS) modulacion 

U5_R: automateSW PORT MAP(
				clk		=> CLK_60MHZ,
				rst		=> RST,
				zero 		=> zero1,
				svred 	=> svred_R,
				temp 		=> temp1					-- ENABLED SIGNALS 
);

U5_S: automateSW PORT MAP(
				clk		=> CLK_60MHZ,
				rst		=> RST,
				zero 		=> zero2,
				svred 	=> svred_S,
				temp 		=> temp2					-- ENABLED SIGNALS 
);

U5_T: automateSW PORT MAP(
				clk		=> CLK_60MHZ,
				rst		=> RST,
				zero 		=> zero3,
				svred 	=> svred_T,
				temp 		=> temp3					-- ENABLED SIGNALS 
);

P2: pll PORT MAP (
				inclk0   => CLK,
				c0			=> CLK_120MHZ,			-- CLK 120 MHZ 
				c1       => CLK_60MHZ			-- CLK 60MHZ
);

-- R

R1 : rectificador PORT MAP(
			clk	 	 => CLK_60MHZ, 	
			rst 		 => RST,				 
			wot 		 => angle1_r, 
			zcf		 => open,
			temp 		 => open,
			sw 		 => ss5,
			nsw       => ss6
			
);

D5: machinetm PORT MAP(
				clk	=> CLK,
				rst	=> RST,
				
				s		=>	ss5,				 		-- S5	
				
				s1		=> sw_r_1,					--SW_R
				s1n	=> open						--nSW_R
			);

D6: machinetm PORT MAP(
				clk	=> CLK,
				rst	=> RST,
				
				s		=>	ss6,				 		-- S6
				
				s1		=> sw_r_2,					--nSW_R
				s1n	=> open						--SW_R
			);

-- S

R2 : rectificador PORT MAP(
			clk	 	 => CLK_60MHZ, 	
			rst 		 => RST,				 
			wot 		 => angle2_r, 
			zcf		 => open,
			temp 		 => open,
			sw 		 => ss9,
			nsw       => ss10
			
);

D9: machinetm PORT MAP(
				clk	=> CLK,
				rst	=> RST,
				
				s		=>	ss9,				 		-- S9	
				
				s1		=> sw_s_1,					--SW_S
				s1n	=> open						--nSW_S
			);

D10: machinetm PORT MAP(
				clk	=> CLK,
				rst	=> RST,
				
				s		=>	ss10,				 		-- S10
				
				s1		=> sw_s_2,					--nSW_S
				s1n	=> open						--SW_S
			);
		
-- T

R3 : rectificador PORT MAP(
			clk	 	 => CLK_60MHZ, 	
			rst 		 => RST,				 
			wot 		 => angle3_r, 
			zcf		 => open,
			temp 		 => open,
			sw 		 => ss13,
			nsw       => ss14
			
);

D13: machinetm PORT MAP(
				clk	=> CLK,
				rst	=> RST,
				
				s		=>	ss13,				 		-- S13	
				
				s1		=> sw_t_1,					--SW_T
				s1n	=> open						--nSW_T
			);

D14: machinetm PORT MAP(
				clk	=> CLK,
				rst	=> RST,
				
				s		=>	ss14,				 		-- S14
				
				s1		=> sw_t_2,					--nSW_T
				s1n	=> open						--SW_T
			);	
			
-- BRIGDE CONECTED TO PV

S1: signalcontrol PORT MAP(    
				clk		=>	CLK_120MHZ,
				rst  		=>	RST,
				alpha		=>	500,					-- DR = sin(90°) = 1 --> alpha = 500
				phi		=>	sphi,					-- SE LE ASIGNA EL PHI_REF					
				s1			=>	ss1, 			
				s2			=>	ss2			
			);

D1: machinetm PORT MAP(
				clk		=> CLK,
				rst		=> RST,
				
				s			=>	ss1,				 	-- S3							
				
				s1			=> sa_1,					-- ADD DELAY 300ns 
				s1n		=> sa_2
			);

D2: machinetm PORT MAP(
				clk		=> CLK,
				rst		=> RST,
				
				s			=>	ss2,				 	-- S4
				
				s1			=> sb_1,					-- ADD DELAY 300ns 	
				s1n		=> sb_2
			);

-- RED FALLA (PENSAR PARA EL TRIFASICO temp1, temp2, temp3)

temp <= temp1 and temp2 and temp3;

		process(clk)
		begin
		if (clk'event and clk='1') then
			nq1 <= temp;
			nq0 <= nq1;
		end if;
		ntemp <= (not nq1) and nq0;			--detecto flanco de bajada
		end process;
		
-- ZIGBEE 

go2phase <= go and (not flanco) when (temp = '1') else '1';

-- el desfasaje phi esta comprendido entre 250 y 500, es decir de 0 a 90°
-- cada 14 representa 5°
--with switches select 
--	selectphase <= 264 when "0001",		-- 5°
	--					278 when "0010", 		-- 10°
	--					292 when "0011", 		-- 15° 
	--					306 when "0100", 		-- 20°
	--					319 when "0110",  	-- 25°
	--					333 when "1000", 		-- 30°
	--					254 when others; 				

--cuenta <= '0' & switches when (unsigned(scuenta) >= 15) else scuenta; 

U6: top_phase PORT MAP(
				clk 		=> CLK, 
				rst 		=> RST and (not ntemp), 
				go 		=> go2phase, 
				phi_ref	=> 400,  --54° 
				phi		=> sphi, 
			--Sorties 
				cuenta 	=> cuenta, 
				led	  	=> sled, 
				phi_min	=> phi_min, 
				phi_max  => phi_max
			);
U7: receptor PORT MAP(
				clk 		=> CLK, 
				rx			=> USB_TXD,
				data_out => rx_data,
				busy		=> open
			);	

toggle_led: process(CLK)
begin
if((CLK'event and CLK = '1')) then
	if (scount = 2500000) then  
        scount <= 0;
        sclk <= not sclk;
    else
        scount <= scount + 1;
    end if;
end if;
end process toggle_led;

	--PRODUCE UN PULSO EN BAJO 
		go_uart <= '1' when (rx_data = X"41") else '0';
	
		process(clk)
		begin
		if (clk'event and clk='1') then
			q1 <= go_uart;
			q0 <= q1;
		end if;
		flanco <= q1 and (not q0);			--detecto flanco de subida 
		end process;
		
	--CONVERTIDOR FUNCIONANDO - BLINK	
		led <= sclk when (sled = '1') else '0';	

-- VENDREDI 26 NOV 

S0: signalcontrol PORT MAP(    
				clk		=>	CLK_120MHZ,
				rst  		=>	RST,
				alpha		=>	500,					-- PI/2
				phi		=>	250,					-- FASE 0°			
				s1			=>	ss1_ref, 			
				s2			=>	open			
			);
		
--BRIDGE : PV CONNECTED TO RS CIRCUIT 
		DRV4_7 <= sa_1 when (temp = '1') else '0';	-- 7 : S1 
		DRV4_8 <= sa_2 when (temp = '1') else '0';	-- 8 : S1N
		DRV4_5 <= sb_1 when (temp = '1') else '0';	-- 5 : S2
		DRV4_6 <= sb_2 when (temp = '1') else '0';	-- 6 : S2N
		

-- LINE RN
--BRIDGE : AC CONNECTED TO RS
																-- EN LA TARJETA DE POTENCIA
		DRV6_7 <= sw_r_1 	when (temp1 = '1') else '0';	-- 7 :   s1n	 = SW_R
		DRV6_8 <= sw_r_2	when (temp1 = '1') else '0';	-- 8 :	 s1	 = nSW_R 
		DRV6_5 <= sw_r_2 	when (temp1 = '1') else '0';	-- 5 :   s2n	 = nSW_R
		DRV6_6 <= sw_r_1	when (temp1 = '1') else '0';	-- 6 :    s2	 = SW_R

--BRIDGE : RS CONNECTED TO RS CIRCUIT

		DRV6_3 <= sc_1 when (temp = '1') else '0';	-- 3 :	s3     = S1
		DRV6_4 <= sc_2 when (temp = '1') else '0';	--	4 :	s3n	 = S1n
 		DRV6_1 <= sd_1 when (temp = '1') else '0';	-- 1 :   s4		 = S2
		DRV6_2 <= sd_2 when (temp = '1') else '0';	-- 2 :   s4n    = S2n
		
--SW ON : WHEN ZERO CROSSED
		DRV6_10 <= temp1;
		DRV6_12 <= temp1;
		
-- LINE SN
--BRIDGE : AC CONNECTED TO RS
																-- EN LA TARJETA DE POTENCIA
		DRV3_7 <= sw_s_1 	when (temp2 = '1') else '0';	-- 7 :   s1n	 = SW_S
		DRV3_8 <= sw_s_2	when (temp2 = '1') else '0';	-- 8 :	 s1	 = nSW_S 
		DRV3_5 <= sw_s_2 	when (temp2 = '1') else '0';	-- 5 :   s2n	 = nSW_S
		DRV3_6 <= sw_s_1	when (temp2 = '1') else '0';	-- 6 :    s2	 = SW_S

--BRIDGE : RS CONNECTED TO RS CIRCUIT

		DRV3_3 <= se_1 when (temp = '1') else '0';	-- 3 :	s3     = S1
		DRV3_4 <= se_2 when (temp = '1') else '0';	--	4 :	s3n	 = S1n
 		DRV3_1 <= sf_1 when (temp = '1') else '0';	-- 1 :   s4		 = S2
		DRV3_2 <= sf_2 when (temp = '1') else '0';	-- 2 :   s4n    = S2n
		
--SW ON : WHEN ZERO CROSSED
		DRV3_10 <= temp2;
		DRV3_12 <= temp2;
		
-- LINE TN
--BRIDGE : AC CONNECTED TO RS
																-- EN LA TARJETA DE POTENCIA
		DRV1_7 <= sw_t_1 	when (temp3 = '1') else '0';	-- 7 :   s1n	 = SW_T
		DRV1_8 <= sw_t_2	when (temp3 = '1') else '0';	-- 8 :	 s1	 = nSW_T 
		DRV1_5 <= sw_t_2 	when (temp3 = '1') else '0';	-- 5 :   s2n	 = nSW_T
		DRV1_6 <= sw_t_1	when (temp3 = '1') else '0';	-- 6 :    s2	 = SW_T

--BRIDGE : RS CONNECTED TO RS CIRCUIT

		DRV1_3 <= sg_1 when (temp = '1') else '0';	-- 3 :	s3     = S1
		DRV1_4 <= sg_2 when (temp = '1') else '0';	--	4 :	s3n	 = S1n
 		DRV1_1 <= sh_1 when (temp = '1') else '0';	-- 1 :   s4		 = S2
		DRV1_2 <= sh_2 when (temp = '1') else '0';	-- 2 :   s4n    = S2n
		
--SW ON : WHEN ZERO CROSSED
		DRV1_10 <= temp3;
		DRV1_12 <= temp3;
	
end test;