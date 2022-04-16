library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_converter_hps_innovate is 
generic(
			 retardo 	: natural := 7; 		-- 116us (60M)
			 phase_ref	: natural := 400
);
port(
		-- CLOCK 
		
		--FPGA_CLK1_50 	: in 	std_logic;		--CLK
		FPGA_CLK2_50 	: in 	std_logic;
		FPGA_CLK3_50 	: in 	std_logic;
		
--		-- HDMI
--	   HDMI_I2C_SCL	: inout 	std_logic;
--		HDMI_I2C_SDA	: inout 	std_logic;
--		HDMI_I2S			: inout 	std_logic;
--		HDMI_LRCLK		: inout 	std_logic;
--		HDMI_MCLK		: inout 	std_logic;
--		HDMI_SCLK		: inout 	std_logic;
--		HDMI_TX_CLK		: out 	std_logic;
--		HDMI_TX_D		: out 	std_logic_vector(23 downto 0);
--		HDMI_TX_DE		: out 	std_logic;
--		HDMI_TX_HS		: out		std_logic;
--		HDMI_TX_INT		: in 		std_logic;
--		HDMI_TX_VS		: out 	std_logic;

		-- HPS 
		HPS_CONV_USB_N		: inout 	std_logic;
		HPS_DDR3_ADDR		: out 	std_logic_vector(14 downto 0);
		HPS_DDR3_BA			: out 	std_logic_vector(2 downto 0);
		HPS_DDR3_CAS_N		: out 	std_logic;
		HPS_DDR3_CK_N		: out 	std_logic;
		HPS_DDR3_CK_P		: out 	std_logic;
		HPS_DDR3_CKE		: out 	std_logic;
		HPS_DDR3_CS_N		: out 	std_logic;
		HPS_DDR3_DM			: out 	std_logic_vector(3 downto 0);
		HPS_DDR3_DQ			: inout  std_logic_vector(31 downto 0);
		HPS_DDR3_DQS_N		: inout 	std_logic_vector(3 downto 0);
		HPS_DDR3_DQS_P		: inout	std_logic_vector(3 downto 0);
		HPS_DDR3_ODT		: out 	std_logic;
		HPS_DDR3_RAS_N		: out 	std_logic;
		HPS_DDR3_RESET_N	: out 	std_logic;
		HPS_DDR3_RZQ		: in 		std_logic;
		HPS_DDR3_WE_N		: out 	std_logic;
		HPS_ENET_GTX_CLK	: out 	std_logic;
		HPS_ENET_INT_N		: inout 	std_logic;
		HPS_ENET_MDC		: out 	std_logic;
		HPS_ENET_MDIO		: inout 	std_logic;
		HPS_ENET_RX_CLK	: in 		std_logic;
		HPS_ENET_RX_DATA	: in 		std_logic_vector(3 downto 0);
		HPS_ENET_RX_DV		: in 		std_logic;
		HPS_ENET_TX_DATA	: out 	std_logic_vector(3 downto 0);	
		HPS_ENET_TX_EN		: out 	std_logic;
		HPS_GSENSOR_INT	: inout 	std_logic;
		HPS_I2C0_SCLK		: inout	std_logic;
		HPS_I2C0_SDAT		: inout	std_logic;
		HPS_I2C1_SCLK		: inout	std_logic;
		HPS_I2C1_SDAT		: inout	std_logic;
		HPS_KEY				: inout	std_logic;
		HPS_LED				: inout	std_logic;
		HPS_LTC_GPIO		: inout	std_logic;
		HPS_SD_CLK			: out 	std_logic;	
		HPS_SD_CMD			: inout	std_logic;
		HPS_SD_DATA			: inout	std_logic_vector(3 downto 0);
		HPS_SPIM_CLK		: out 	std_logic;
		HPS_SPIM_MISO		: in 		std_logic;
		HPS_SPIM_MOSI		: out 	std_logic;
		HPS_SPIM_SS			: inout	std_logic;
		HPS_UART_RX			: in  	std_logic;
		HPS_UART_TX			: out 	std_logic;
		HPS_USB_CLKOUT		: in 		std_logic;
		HPS_USB_DATA		: inout	std_logic_vector(7 downto 0);
		HPS_USB_DIR			: in 		std_logic;	
		HPS_USB_NXT			: in 		std_logic;
		HPS_USB_STP			: out		std_logic;
		
		-- ANALIZADOR LOGICO 
		--CLK_to_cpu					: out 	std_logic;
		--Vacont_int_to_cpu			: out 	std_logic_vector(11 downto 0);
		
		-- KEY 
		--KEY	: in 	std_logic_vector(1 downto 0);
	 
		-- LED
		--LED 	: out std_logic_vector(7 downto 0);
		
		-- SW 
		--SW		: in 	std_logic_vector(3 downto 0);
		
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
		
		
--		-- RFS CARD INTERFACE SIGNALS 
--		LSENSOR_INT			: in 	 	std_logic;
--		LSENSOR_SCL 		: inout	std_logic;
--		LSENSOR_SDA			: inout	std_logic;
--		MPU_AD0_SDO			: inout	std_logic;
--		MPU_CS_n				: out 	std_logic;
--		MPU_FSYNC			: out 	std_logic;
--		MPU_INT				: in 	 	std_logic;
--		MPU_SCL_SCLK		: inout	std_logic;
--		MPU_SDA_SDI 		: inout	std_logic;
--		RH_TEMP_DRDY_n		: inout	std_logic;
--		RH_TEMP_I2C_SCL	: inout	std_logic;
--		RH_TEMP_I2C_SDA	: inout	std_logic;
--	 
--		-- UNUSED SIGNALS IN THIS DESIGN 
--		BT_KEY		 		: inout	std_logic;
--		BT_UART_RX			: in 	 	std_logic;
--		BT_UART_TX 			: out 	std_logic;
--		TMD_D					: inout	std_logic_vector(7 downto 0);
--		UART2USB_CTS		: in 	 	std_logic;
--		UART2USB_RTS		: out 	std_logic;
--		UART2USB_RX			: in 	 	std_logic;
--		UART2USB_TX			: out 	std_logic;
--		WIFI_EN				: out 	std_logic;
--		WIFI_RST_n			: out 	std_logic;
--		WIFI_UART0_CTS		: in 	 	std_logic;
--		WIFI_UART0_RTS		: out 	std_logic;
--		WIFI_UART0_RX		: in 	 	std_logic;
--		WIFI_UART0_TX		: out 	std_logic;
--		WIFI_UART1_RX		: in 	 	std_logic

);
end top_converter_hps_innovate;

architecture test of top_converter_hps_innovate is

--Zona de componentes
component cpu is
  port (
		clk_clk                         : in    std_logic                     := 'X';             -- clk
		reset_reset_n                   : in    std_logic                     := 'X';             -- reset_n
		memory_mem_a                    : out   std_logic_vector(14 downto 0);                    -- mem_a
		memory_mem_ba                   : out   std_logic_vector(2 downto 0);                     -- mem_ba
		memory_mem_ck                   : out   std_logic;                                        -- mem_ck
		memory_mem_ck_n                 : out   std_logic;                                        -- mem_ck_n
		memory_mem_cke                  : out   std_logic;                                        -- mem_cke
		memory_mem_cs_n                 : out   std_logic;                                        -- mem_cs_n
		memory_mem_ras_n                : out   std_logic;                                        -- mem_ras_n
		memory_mem_cas_n                : out   std_logic;                                        -- mem_cas_n
		memory_mem_we_n                 : out   std_logic;                                        -- mem_we_n
		memory_mem_reset_n              : out   std_logic;                                        -- mem_reset_n
		memory_mem_dq                   : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
		memory_mem_dqs                  : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
		memory_mem_dqs_n                : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
		memory_mem_odt                  : out   std_logic;                                        -- mem_odt
		memory_mem_dm                   : out   std_logic_vector(3 downto 0);                     -- mem_dm
		memory_oct_rzqin                : in    std_logic                     := 'X';             -- oct_rzqin
		hps_0_h2f_reset_reset_n         : out   std_logic;                                        -- reset_n
		hps_io_hps_io_emac1_inst_TX_CLK : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
		hps_io_hps_io_emac1_inst_TXD0   : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
		hps_io_hps_io_emac1_inst_TXD1   : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
		hps_io_hps_io_emac1_inst_TXD2   : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
		hps_io_hps_io_emac1_inst_TXD3   : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
		hps_io_hps_io_emac1_inst_RXD0   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
		hps_io_hps_io_emac1_inst_MDIO   : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
		hps_io_hps_io_emac1_inst_MDC    : out   std_logic;                                        -- hps_io_emac1_inst_MDC
		hps_io_hps_io_emac1_inst_RX_CTL : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
		hps_io_hps_io_emac1_inst_TX_CTL : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
		hps_io_hps_io_emac1_inst_RX_CLK : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
		hps_io_hps_io_emac1_inst_RXD1   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
		hps_io_hps_io_emac1_inst_RXD2   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
		hps_io_hps_io_emac1_inst_RXD3   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
		hps_io_hps_io_sdio_inst_CMD     : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
		hps_io_hps_io_sdio_inst_D0      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
		hps_io_hps_io_sdio_inst_D1      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
		hps_io_hps_io_sdio_inst_CLK     : out   std_logic;                                        -- hps_io_sdio_inst_CLK
		hps_io_hps_io_sdio_inst_D2      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
		hps_io_hps_io_sdio_inst_D3      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
		hps_io_hps_io_usb1_inst_D0      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
		hps_io_hps_io_usb1_inst_D1      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
		hps_io_hps_io_usb1_inst_D2      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
		hps_io_hps_io_usb1_inst_D3      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
		hps_io_hps_io_usb1_inst_D4      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
		hps_io_hps_io_usb1_inst_D5      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
		hps_io_hps_io_usb1_inst_D6      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
		hps_io_hps_io_usb1_inst_D7      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
		hps_io_hps_io_usb1_inst_CLK     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
		hps_io_hps_io_usb1_inst_STP     : out   std_logic;                                        -- hps_io_usb1_inst_STP
		hps_io_hps_io_usb1_inst_DIR     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
		hps_io_hps_io_usb1_inst_NXT     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
		hps_io_hps_io_uart0_inst_RX     : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
		hps_io_hps_io_uart0_inst_TX     : out   std_logic;                                         -- hps_io_uart0_inst_TX
		led_external_connection_export  : out   std_logic_vector(2 downto 0);                     -- export
		sw_external_connection_export   : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- export
		bacurrent_external_connection_export   : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		bavoltage_external_connection_export   : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		phase_external_connection_in_port      : in    std_logic_vector(11 downto 0) := (others => 'X'); -- in_port
		phase_external_connection_out_port     : out   std_logic_vector(11 downto 0);                    -- out_port
		pvcurrent_external_connection_export   : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		pvvoltage_external_connection_export   : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgr_current_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgr_voltage_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgs_current_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgs_voltage_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgt_current_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgt_voltage_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X')  -- export
  );
end component cpu;

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
signal sfin_bat	:  std_logic;
signal sfin_dac 	:  std_logic;
signal sclk_adc 	:  std_logic;
signal sclk_adc1, sclk_adc2, sclk_adc3 : std_logic;
signal sclk_bat	:  std_logic;
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
signal cs_bat  	: std_logic;
signal miso_bat 	: std_logic;
	
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

signal sIacont	: std_logic_vector(11 downto 0);
signal sIbcont	: std_logic_vector(11 downto 0);
signal sIccont: std_logic_vector(11 downto 0);

signal sVacont	: std_logic_vector(11 downto 0);
signal sVbcont	: std_logic_vector(11 downto 0);
signal sVccont: std_logic_vector(11 downto 0);

signal sIb	: std_logic_vector(11 downto 0);
signal sVb	: std_logic_vector(11 downto 0);

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
			Data_out1 => sVacont,
			Data_out2 => sIacont,
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
			Data_out1 => sVbcont,
			Data_out2 => sIbcont,
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
			Data_out1 => sVccont,
			Data_out2 => sIccont,
			Data_out3 => open,
			
			fin_adc 	 => sfin_adc3,
			
		-- Bus comunicacion SPI --	
			spi_clk 	 => sclk_adc3,
			cs 		 => cs_adc3,
			vo			 => miso_adc3,
			io			 => '0',
			vfa		 => '0'		
	);
	
U1_Bat :ADC7476 PORT MAP(
			clk	 	 => CLK_60MHZ,
			rst	 	 => RST,
			
			go_spi  	 => sgo_adc,
		
		-- Bus de sortie : la donne plus un bit de validation de nouvelle donne --	
			Data_out1 => sVb,
			Data_out2 => sIb,
			Data_out3 => open,
			
			fin_adc 	 => sfin_bat,
			
		-- Bus comunicacion SPI --	
			spi_clk 	 => sclk_bat,
			cs 		 => cs_bat,
			vo			 => miso_bat,
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
			vin 									 => sVacont,
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
			vin 									 => sVbcont,
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
			vin 									 => sVccont,
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
				phi_ref	=> phase_ref,  --54° 
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
			
U10 : component cpu
        port map (
		  
				-- CLK AND RESET
            clk_clk                         => CLK,                         --                     clk.clk
            reset_reset_n                   => RST,                   --                   reset.reset_n
				
				--HPS DDR3
            memory_mem_a                    => HPS_DDR3_ADDR,                    --                  memory.mem_a
            memory_mem_ba                   => HPS_DDR3_BA,                   --                        .mem_ba
            memory_mem_ck                   => HPS_DDR3_CK_P,                   --                        .mem_ck
            memory_mem_ck_n                 => HPS_DDR3_CK_N,                 --                        .mem_ck_n
            memory_mem_cke                  => HPS_DDR3_CKE,                  --                        .mem_cke
            memory_mem_cs_n                 => HPS_DDR3_CS_N,                 --                        .mem_cs_n
            memory_mem_ras_n                => HPS_DDR3_RAS_N,                --                        .mem_ras_n
            memory_mem_cas_n                => HPS_DDR3_CAS_N,                --                        .mem_cas_n
            memory_mem_we_n                 => HPS_DDR3_WE_N,                 --                        .mem_we_n
            memory_mem_reset_n              => HPS_DDR3_RESET_N,              --                        .mem_reset_n
            memory_mem_dq                   => HPS_DDR3_DQ,                   --                        .mem_dq
            memory_mem_dqs                  => HPS_DDR3_DQS_P,                  --                        .mem_dqs
            memory_mem_dqs_n                => HPS_DDR3_DQS_N,                --                        .mem_dqs_n
            memory_mem_odt                  => HPS_DDR3_ODT,                  --                        .mem_odt
            memory_mem_dm                   => HPS_DDR3_DM,                   --                        .mem_dm
            memory_oct_rzqin                => HPS_DDR3_RZQ,                --                        .oct_rzqin
				
            hps_0_h2f_reset_reset_n         => open,         --         hps_0_h2f_reset.reset_n
            led_external_connection_export  => open,  -- led_external_connection.export
            sw_external_connection_export   => (others=>'0'),   --  sw_external_connection.export
				phase_external_connection_in_port => std_logic_vector(to_unsigned(phase_ref,12)),
				phase_external_connection_out_port => open,
				pvcurrent_external_connection_export => std_logic_vector(to_unsigned(0,12)),
				pvvoltage_external_connection_export => std_logic_vector(to_unsigned(0,12)),
				vgr_current_external_connection_export => sIacont, 	--std_logic_vector(to_unsigned(70,12)),
				vgr_voltage_external_connection_export => sVacont,	--std_logic_vector(to_unsigned(200,12)),
				vgs_current_external_connection_export => sIbcont,	--std_logic_vector(to_unsigned(60,12)),
				vgs_voltage_external_connection_export => sVbcont,	--std_logic_vector(to_unsigned(300,12)),
				vgt_current_external_connection_export => sIccont,	--std_logic_vector(to_unsigned(10,12)),
				vgt_voltage_external_connection_export => sVccont,	--std_logic_vector(to_unsigned(250,12)),
				bacurrent_external_connection_export => sVb,
				bavoltage_external_connection_export => sIb,
				
				--HPS ETHERNET
            hps_io_hps_io_emac1_inst_TX_CLK => HPS_ENET_GTX_CLK, --                  hps_io.hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0   => HPS_ENET_TX_DATA(0),   --                        .hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1   => HPS_ENET_TX_DATA(1),   --                        .hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2   => HPS_ENET_TX_DATA(2),   --                        .hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3   => HPS_ENET_TX_DATA(3),   --                        .hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0   => HPS_ENET_RX_DATA(0),   --                        .hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO   => HPS_ENET_MDIO,   --                        .hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC    => HPS_ENET_MDC,    --                        .hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL => HPS_ENET_RX_DV, --                        .hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL => HPS_ENET_TX_EN, --                        .hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK => HPS_ENET_RX_CLK, --                        .hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1   => HPS_ENET_RX_DATA(1),   --                        .hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2   => HPS_ENET_RX_DATA(2),   --                        .hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3   => HPS_ENET_RX_DATA(3),   --                        .hps_io_emac1_inst_RXD3
				
				--HPS SD CARD
            hps_io_hps_io_sdio_inst_CMD     => HPS_SD_CMD,     --                        .hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0      => HPS_SD_DATA(0),      --                        .hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1      => HPS_SD_DATA(1),      --                        .hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK     => HPS_SD_CLK,     --                        .hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2      => HPS_SD_DATA(2),      --                        .hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3      => HPS_SD_DATA(3),      --                        .hps_io_sdio_inst_D3
				
				--HPS USB
            hps_io_hps_io_usb1_inst_D0      => HPS_USB_DATA(0),      --                        .hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1      => HPS_USB_DATA(1),      --                        .hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2      => HPS_USB_DATA(2),      --                        .hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3      => HPS_USB_DATA(3),      --                        .hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4      => HPS_USB_DATA(4),      --                        .hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5      => HPS_USB_DATA(5),      --                        .hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6      => HPS_USB_DATA(6),      --                        .hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7      => HPS_USB_DATA(7),      --                        .hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK     => HPS_USB_CLKOUT,     --                        .hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP     => HPS_USB_STP,     --                        .hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR     => HPS_USB_DIR,     --                        .hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT     => HPS_USB_NXT,     --                        .hps_io_usb1_inst_NXT
				
				--HPS UART
            hps_io_hps_io_uart0_inst_RX     => HPS_UART_RX,     --                        .hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX     => HPS_UART_TX      --                        .hps_io_uart0_inst_TX
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