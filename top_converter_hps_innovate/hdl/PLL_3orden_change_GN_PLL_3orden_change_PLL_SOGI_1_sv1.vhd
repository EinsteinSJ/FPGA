-- PLL_3orden_change_GN_PLL_3orden_change_PLL_SOGI_1_sv1.vhd

-- Generated using ACDS version 17.1 590

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PLL_3orden_change_GN_PLL_3orden_change_PLL_SOGI_1_sv1 is
	port (
		In_1    : in  std_logic_vector(15 downto 0) := (others => '0'); --    In_1.wire
		CLK_60K : in  std_logic                     := '0';             -- CLK_60K.wire
		Ts      : in  std_logic_vector(31 downto 0) := (others => '0'); --      Ts.wire
		Clock   : in  std_logic                     := '0';             --   Clock.clk
		aclr    : in  std_logic                     := '0';             --        .reset
		Out1    : out std_logic_vector(13 downto 0)                     --    Out1.wire
	);
end entity PLL_3orden_change_GN_PLL_3orden_change_PLL_SOGI_1_sv1;

architecture rtl of PLL_3orden_change_GN_PLL_3orden_change_PLL_SOGI_1_sv1 is
	component alt_dspbuilder_clock_GNQFU4PUDH is
		port (
			aclr      : in  std_logic := 'X'; -- reset
			aclr_n    : in  std_logic := 'X'; -- reset_n
			aclr_out  : out std_logic;        -- reset
			clock     : in  std_logic := 'X'; -- clk
			clock_out : out std_logic         -- clk
		);
	end component alt_dspbuilder_clock_GNQFU4PUDH;

	component alt_dspbuilder_cast_GNBBMDRQ7A is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(31 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNBBMDRQ7A;

	component alt_dspbuilder_multiplier_GNKNXMPIIM is
		generic (
			aWidth                         : natural := 8;
			Signed                         : natural := 0;
			bWidth                         : natural := 8;
			DEDICATED_MULTIPLIER_CIRCUITRY : string  := "AUTO";
			pipeline                       : integer := 0;
			OutputLsb                      : integer := 0;
			OutputMsb                      : integer := 8
		);
		port (
			aclr      : in  std_logic                                          := 'X';             -- clk
			clock     : in  std_logic                                          := 'X';             -- clk
			dataa     : in  std_logic_vector(aWidth-1 downto 0)                := (others => 'X'); -- wire
			datab     : in  std_logic_vector(bWidth-1 downto 0)                := (others => 'X'); -- wire
			ena       : in  std_logic                                          := 'X';             -- wire
			result    : out std_logic_vector(OutputMsb-OutputLsb+1-1 downto 0);                    -- wire
			user_aclr : in  std_logic                                          := 'X'              -- wire
		);
	end component alt_dspbuilder_multiplier_GNKNXMPIIM;

	component alt_dspbuilder_gnd_GN is
		port (
			output : out std_logic   -- wire
		);
	end component alt_dspbuilder_gnd_GN;

	component alt_dspbuilder_vcc_GN is
		port (
			output : out std_logic   -- wire
		);
	end component alt_dspbuilder_vcc_GN;

	component alt_dspbuilder_pipelined_adder_GN4HTUTWRG is
		generic (
			pipeline : integer := 0;
			width    : natural := 0
		);
		port (
			aclr      : in  std_logic                          := 'X';             -- clk
			add_sub   : in  std_logic                          := 'X';             -- wire
			cin       : in  std_logic                          := 'X';             -- wire
			clock     : in  std_logic                          := 'X';             -- clk
			cout      : out std_logic;                                             -- wire
			dataa     : in  std_logic_vector(width-1 downto 0) := (others => 'X'); -- wire
			datab     : in  std_logic_vector(width-1 downto 0) := (others => 'X'); -- wire
			ena       : in  std_logic                          := 'X';             -- wire
			result    : out std_logic_vector(width-1 downto 0);                    -- wire
			user_aclr : in  std_logic                          := 'X'              -- wire
		);
	end component alt_dspbuilder_pipelined_adder_GN4HTUTWRG;

	component alt_dspbuilder_delay_GNKZDMBKQG is
		generic (
			ClockPhase : string   := "1";
			BitPattern : string   := "00000001";
			width      : positive := 8;
			use_init   : natural  := 0;
			delay      : positive := 1
		);
		port (
			aclr   : in  std_logic                          := 'X';             -- clk
			clock  : in  std_logic                          := 'X';             -- clk
			ena    : in  std_logic                          := 'X';             -- wire
			input  : in  std_logic_vector(width-1 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(width-1 downto 0);                    -- wire
			sclr   : in  std_logic                          := 'X'              -- wire
		);
	end component alt_dspbuilder_delay_GNKZDMBKQG;

	component alt_dspbuilder_port_GNBO6OMO5Y is
		port (
			input  : in  std_logic_vector(15 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(15 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNBO6OMO5Y;

	component alt_dspbuilder_multiplier_GNXJFZQ54I is
		generic (
			aWidth                         : natural := 8;
			Signed                         : natural := 0;
			bWidth                         : natural := 8;
			DEDICATED_MULTIPLIER_CIRCUITRY : string  := "AUTO";
			pipeline                       : integer := 0;
			OutputLsb                      : integer := 0;
			OutputMsb                      : integer := 8
		);
		port (
			aclr      : in  std_logic                                          := 'X';             -- clk
			clock     : in  std_logic                                          := 'X';             -- clk
			dataa     : in  std_logic_vector(aWidth-1 downto 0)                := (others => 'X'); -- wire
			datab     : in  std_logic_vector(bWidth-1 downto 0)                := (others => 'X'); -- wire
			ena       : in  std_logic                                          := 'X';             -- wire
			result    : out std_logic_vector(OutputMsb-OutputLsb+1-1 downto 0);                    -- wire
			user_aclr : in  std_logic                                          := 'X'              -- wire
		);
	end component alt_dspbuilder_multiplier_GNXJFZQ54I;

	component alt_dspbuilder_pipelined_adder_GNY2JEH574 is
		generic (
			pipeline : integer := 0;
			width    : natural := 0
		);
		port (
			aclr      : in  std_logic                          := 'X';             -- clk
			add_sub   : in  std_logic                          := 'X';             -- wire
			cin       : in  std_logic                          := 'X';             -- wire
			clock     : in  std_logic                          := 'X';             -- clk
			cout      : out std_logic;                                             -- wire
			dataa     : in  std_logic_vector(width-1 downto 0) := (others => 'X'); -- wire
			datab     : in  std_logic_vector(width-1 downto 0) := (others => 'X'); -- wire
			ena       : in  std_logic                          := 'X';             -- wire
			result    : out std_logic_vector(width-1 downto 0);                    -- wire
			user_aclr : in  std_logic                          := 'X'              -- wire
		);
	end component alt_dspbuilder_pipelined_adder_GNY2JEH574;

	component alt_dspbuilder_cast_GNTSUCRN4Q is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNTSUCRN4Q;

	component alt_dspbuilder_cast_GNGZDNROJB is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(17 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(17 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNGZDNROJB;

	component alt_dspbuilder_cast_GND47QX5DY is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(31 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GND47QX5DY;

	component alt_dspbuilder_port_GNEPKLLZKY is
		port (
			input  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(31 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNEPKLLZKY;

	component alt_dspbuilder_cast_GN6DTGWIDG is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(17 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(17 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GN6DTGWIDG;

	component alt_dspbuilder_cast_GNGWUGSP35 is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(31 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNGWUGSP35;

	component alt_dspbuilder_port_GNBOOX3JQY is
		port (
			input  : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNBOOX3JQY;

	component alt_dspbuilder_port_GN37ALZBS4 is
		port (
			input  : in  std_logic := 'X'; -- wire
			output : out std_logic         -- wire
		);
	end component alt_dspbuilder_port_GN37ALZBS4;

	component alt_dspbuilder_constant_GND3QGQB6V is
		generic (
			BitPattern : string  := "0000";
			HDLTYPE    : string  := "STD_LOGIC_VECTOR";
			width      : natural := 4
		);
		port (
			output : out std_logic_vector(17 downto 0)   -- wire
		);
	end component alt_dspbuilder_constant_GND3QGQB6V;

	component alt_dspbuilder_cast_GN3MSXHHKG is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(15 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(17 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GN3MSXHHKG;

	component alt_dspbuilder_cast_GNVVN754F4 is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(31 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNVVN754F4;

	component alt_dspbuilder_cast_GNTWTJF3KX is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(30 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNTWTJF3KX;

	component alt_dspbuilder_cast_GNRCBZ7OTJ is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(30 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(17 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNRCBZ7OTJ;

	component alt_dspbuilder_cast_GNXTVWHWB4 is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNXTVWHWB4;

	component alt_dspbuilder_cast_GNKUAJE7NW is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(31 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNKUAJE7NW;

	component alt_dspbuilder_cast_GNSLUF5FF5 is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(31 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNSLUF5FF5;

	signal multiplier1user_aclrgnd_output_wire      : std_logic;                     -- Multiplier1user_aclrGND:output -> Multiplier1:user_aclr
	signal multiplier1enavcc_output_wire            : std_logic;                     -- Multiplier1enaVCC:output -> Multiplier1:ena
	signal pipelined_adderuser_aclrgnd_output_wire  : std_logic;                     -- Pipelined_Adderuser_aclrGND:output -> Pipelined_Adder:user_aclr
	signal pipelined_adderenavcc_output_wire        : std_logic;                     -- Pipelined_AdderenaVCC:output -> Pipelined_Adder:ena
	signal delaysclrgnd_output_wire                 : std_logic;                     -- DelaysclrGND:output -> Delay:sclr
	signal multiplieruser_aclrgnd_output_wire       : std_logic;                     -- Multiplieruser_aclrGND:output -> Multiplier:user_aclr
	signal multiplierenavcc_output_wire             : std_logic;                     -- MultiplierenaVCC:output -> Multiplier:ena
	signal pipelined_adder4user_aclrgnd_output_wire : std_logic;                     -- Pipelined_Adder4user_aclrGND:output -> Pipelined_Adder4:user_aclr
	signal pipelined_adder4enavcc_output_wire       : std_logic;                     -- Pipelined_Adder4enaVCC:output -> Pipelined_Adder4:ena
	signal pipelined_adder3user_aclrgnd_output_wire : std_logic;                     -- Pipelined_Adder3user_aclrGND:output -> Pipelined_Adder3:user_aclr
	signal pipelined_adder3enavcc_output_wire       : std_logic;                     -- Pipelined_Adder3enaVCC:output -> Pipelined_Adder3:ena
	signal pipelined_adder2user_aclrgnd_output_wire : std_logic;                     -- Pipelined_Adder2user_aclrGND:output -> Pipelined_Adder2:user_aclr
	signal pipelined_adder2enavcc_output_wire       : std_logic;                     -- Pipelined_Adder2enaVCC:output -> Pipelined_Adder2:ena
	signal pipelined_adder1user_aclrgnd_output_wire : std_logic;                     -- Pipelined_Adder1user_aclrGND:output -> Pipelined_Adder1:user_aclr
	signal pipelined_adder1enavcc_output_wire       : std_logic;                     -- Pipelined_Adder1enaVCC:output -> Pipelined_Adder1:ena
	signal pipelined_adder6user_aclrgnd_output_wire : std_logic;                     -- Pipelined_Adder6user_aclrGND:output -> Pipelined_Adder6:user_aclr
	signal pipelined_adder6enavcc_output_wire       : std_logic;                     -- Pipelined_Adder6enaVCC:output -> Pipelined_Adder6:ena
	signal delay2sclrgnd_output_wire                : std_logic;                     -- Delay2sclrGND:output -> Delay2:sclr
	signal delay1sclrgnd_output_wire                : std_logic;                     -- Delay1sclrGND:output -> Delay1:sclr
	signal clk_60k_0_output_wire                    : std_logic;                     -- CLK_60K_0:output -> [Delay1:ena, Delay2:ena, Delay:ena]
	signal delay_output_wire                        : std_logic_vector(31 downto 0); -- Delay:output -> [Delay1:input, x16_2:input]
	signal bus_conversion6_output_wire              : std_logic_vector(31 downto 0); -- Bus_Conversion6:output -> Delay2:input
	signal delay2_output_wire                       : std_logic_vector(31 downto 0); -- Delay2:output -> [AltBus:input, Delay:input, cast53:input, x16:input, x8:input]
	signal bus_conversion7_output_wire              : std_logic_vector(17 downto 0); -- Bus_Conversion7:output -> Multiplier:dataa
	signal bus_conversion5_output_wire              : std_logic_vector(17 downto 0); -- Bus_Conversion5:output -> Multiplier1:dataa
	signal id_1_12_output_wire                      : std_logic_vector(17 downto 0); -- id_1_12:output -> Multiplier1:datab
	signal bus_conversion1_output_wire              : std_logic_vector(31 downto 0); -- Bus_Conversion1:output -> Pipelined_Adder:datab
	signal pipelined_adder_result_wire              : std_logic_vector(31 downto 0); -- Pipelined_Adder:result -> Pipelined_Adder1:dataa
	signal bus_conversion2_output_wire              : std_logic_vector(31 downto 0); -- Bus_Conversion2:output -> Pipelined_Adder1:datab
	signal pipelined_adder1_result_wire             : std_logic_vector(31 downto 0); -- Pipelined_Adder1:result -> Pipelined_Adder2:dataa
	signal bus_conversion3_output_wire              : std_logic_vector(31 downto 0); -- Bus_Conversion3:output -> Pipelined_Adder3:dataa
	signal bus_conversion4_output_wire              : std_logic_vector(31 downto 0); -- Bus_Conversion4:output -> Pipelined_Adder3:datab
	signal pipelined_adder2_result_wire             : std_logic_vector(31 downto 0); -- Pipelined_Adder2:result -> Pipelined_Adder4:dataa
	signal pipelined_adder3_result_wire             : std_logic_vector(31 downto 0); -- Pipelined_Adder3:result -> Pipelined_Adder4:datab
	signal multiplier_result_wire                   : std_logic_vector(31 downto 0); -- Multiplier:result -> Pipelined_Adder6:dataa
	signal altbus_output_wire                       : std_logic_vector(31 downto 0); -- AltBus:output -> Pipelined_Adder6:datab
	signal pipelined_adder6_result_wire             : std_logic_vector(31 downto 0); -- Pipelined_Adder6:result -> Bus_Conversion6:input
	signal x16_output_wire                          : std_logic_vector(31 downto 0); -- x16:output -> Pipelined_Adder:dataa
	signal x16_2_output_wire                        : std_logic_vector(31 downto 0); -- x16_2:output -> Pipelined_Adder2:datab
	signal delay1_output_wire                       : std_logic_vector(31 downto 0); -- Delay1:output -> [cast52:input, x4:input]
	signal bus_conversion8_output_wire              : std_logic_vector(13 downto 0); -- Bus_Conversion8:output -> Out1_0:input
	signal in_1_0_output_wire                       : std_logic_vector(15 downto 0); -- In_1_0:output -> cast51:input
	signal cast51_output_wire                       : std_logic_vector(17 downto 0); -- cast51:output -> Bus_Conversion5:input
	signal cast52_output_wire                       : std_logic_vector(31 downto 0); -- cast52:output -> Bus_Conversion4:input
	signal cast53_output_wire                       : std_logic_vector(31 downto 0); -- cast53:output -> Bus_Conversion2:input
	signal ts_0_output_wire                         : std_logic_vector(31 downto 0); -- Ts_0:output -> cast54:input
	signal cast54_output_wire                       : std_logic_vector(30 downto 0); -- cast54:output -> Multiplier:datab
	signal multiplier1_result_wire                  : std_logic_vector(30 downto 0); -- Multiplier1:result -> cast55:input
	signal cast55_output_wire                       : std_logic_vector(17 downto 0); -- cast55:output -> Bus_Conversion7:input
	signal pipelined_adder4_result_wire             : std_logic_vector(31 downto 0); -- Pipelined_Adder4:result -> cast56:input
	signal cast56_output_wire                       : std_logic_vector(13 downto 0); -- cast56:output -> Bus_Conversion8:input
	signal x4_output_wire                           : std_logic_vector(31 downto 0); -- x4:output -> cast57:input
	signal cast57_output_wire                       : std_logic_vector(31 downto 0); -- cast57:output -> Bus_Conversion3:input
	signal x8_output_wire                           : std_logic_vector(31 downto 0); -- x8:output -> cast58:input
	signal cast58_output_wire                       : std_logic_vector(31 downto 0); -- cast58:output -> Bus_Conversion1:input
	signal clock_0_clock_output_clk                 : std_logic;                     -- Clock_0:clock_out -> [Delay1:clock, Delay2:clock, Delay:clock, Multiplier1:clock, Multiplier:clock, Pipelined_Adder1:clock, Pipelined_Adder2:clock, Pipelined_Adder3:clock, Pipelined_Adder4:clock, Pipelined_Adder6:clock, Pipelined_Adder:clock]
	signal clock_0_clock_output_reset               : std_logic;                     -- Clock_0:aclr_out -> [Delay1:aclr, Delay2:aclr, Delay:aclr, Multiplier1:aclr, Multiplier:aclr, Pipelined_Adder1:aclr, Pipelined_Adder2:aclr, Pipelined_Adder3:aclr, Pipelined_Adder4:aclr, Pipelined_Adder6:aclr, Pipelined_Adder:aclr]

begin

	clock_0 : component alt_dspbuilder_clock_GNQFU4PUDH
		port map (
			clock_out => clock_0_clock_output_clk,   -- clock_output.clk
			aclr_out  => clock_0_clock_output_reset, --             .reset
			clock     => Clock,                      --        clock.clk
			aclr      => aclr                        --             .reset
		);

	x8 : component alt_dspbuilder_cast_GNBBMDRQ7A
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => delay2_output_wire, --  input.wire
			output => x8_output_wire      -- output.wire
		);

	multiplier1 : component alt_dspbuilder_multiplier_GNKNXMPIIM
		generic map (
			aWidth                         => 18,
			Signed                         => 1,
			bWidth                         => 18,
			DEDICATED_MULTIPLIER_CIRCUITRY => "YES",
			pipeline                       => 1,
			OutputLsb                      => 1,
			OutputMsb                      => 31
		)
		port map (
			clock     => clock_0_clock_output_clk,            -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,          --           .reset
			dataa     => bus_conversion5_output_wire,         --      dataa.wire
			datab     => id_1_12_output_wire,                 --      datab.wire
			result    => multiplier1_result_wire,             --     result.wire
			user_aclr => multiplier1user_aclrgnd_output_wire, --  user_aclr.wire
			ena       => multiplier1enavcc_output_wire        --        ena.wire
		);

	multiplier1user_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => multiplier1user_aclrgnd_output_wire  -- output.wire
		);

	multiplier1enavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => multiplier1enavcc_output_wire  -- output.wire
		);

	pipelined_adder : component alt_dspbuilder_pipelined_adder_GN4HTUTWRG
		generic map (
			pipeline => 0,
			width    => 32
		)
		port map (
			clock     => clock_0_clock_output_clk,                -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,              --           .reset
			dataa     => x16_output_wire,                         --      dataa.wire
			datab     => bus_conversion1_output_wire,             --      datab.wire
			result    => pipelined_adder_result_wire,             --     result.wire
			user_aclr => pipelined_adderuser_aclrgnd_output_wire, --  user_aclr.wire
			ena       => pipelined_adderenavcc_output_wire        --        ena.wire
		);

	pipelined_adderuser_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => pipelined_adderuser_aclrgnd_output_wire  -- output.wire
		);

	pipelined_adderenavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => pipelined_adderenavcc_output_wire  -- output.wire
		);

	delay : component alt_dspbuilder_delay_GNKZDMBKQG
		generic map (
			ClockPhase => "1",
			BitPattern => "01000000000000000000000000000000",
			width      => 32,
			use_init   => 0,
			delay      => 1
		)
		port map (
			input  => delay2_output_wire,         --      input.wire
			clock  => clock_0_clock_output_clk,   -- clock_aclr.clk
			aclr   => clock_0_clock_output_reset, --           .reset
			output => delay_output_wire,          --     output.wire
			sclr   => delaysclrgnd_output_wire,   --       sclr.wire
			ena    => clk_60k_0_output_wire       --        ena.wire
		);

	delaysclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => delaysclrgnd_output_wire  -- output.wire
		);

	in_1_0 : component alt_dspbuilder_port_GNBO6OMO5Y
		port map (
			input  => In_1,               --  input.wire
			output => in_1_0_output_wire  -- output.wire
		);

	multiplier : component alt_dspbuilder_multiplier_GNXJFZQ54I
		generic map (
			aWidth                         => 18,
			Signed                         => 1,
			bWidth                         => 31,
			DEDICATED_MULTIPLIER_CIRCUITRY => "YES",
			pipeline                       => 1,
			OutputLsb                      => 11,
			OutputMsb                      => 42
		)
		port map (
			clock     => clock_0_clock_output_clk,           -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,         --           .reset
			dataa     => bus_conversion7_output_wire,        --      dataa.wire
			datab     => cast54_output_wire,                 --      datab.wire
			result    => multiplier_result_wire,             --     result.wire
			user_aclr => multiplieruser_aclrgnd_output_wire, --  user_aclr.wire
			ena       => multiplierenavcc_output_wire        --        ena.wire
		);

	multiplieruser_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => multiplieruser_aclrgnd_output_wire  -- output.wire
		);

	multiplierenavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => multiplierenavcc_output_wire  -- output.wire
		);

	pipelined_adder4 : component alt_dspbuilder_pipelined_adder_GN4HTUTWRG
		generic map (
			pipeline => 0,
			width    => 32
		)
		port map (
			clock     => clock_0_clock_output_clk,                 -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,               --           .reset
			dataa     => pipelined_adder2_result_wire,             --      dataa.wire
			datab     => pipelined_adder3_result_wire,             --      datab.wire
			result    => pipelined_adder4_result_wire,             --     result.wire
			user_aclr => pipelined_adder4user_aclrgnd_output_wire, --  user_aclr.wire
			ena       => pipelined_adder4enavcc_output_wire        --        ena.wire
		);

	pipelined_adder4user_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => pipelined_adder4user_aclrgnd_output_wire  -- output.wire
		);

	pipelined_adder4enavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => pipelined_adder4enavcc_output_wire  -- output.wire
		);

	pipelined_adder3 : component alt_dspbuilder_pipelined_adder_GN4HTUTWRG
		generic map (
			pipeline => 0,
			width    => 32
		)
		port map (
			clock     => clock_0_clock_output_clk,                 -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,               --           .reset
			dataa     => bus_conversion3_output_wire,              --      dataa.wire
			datab     => bus_conversion4_output_wire,              --      datab.wire
			result    => pipelined_adder3_result_wire,             --     result.wire
			user_aclr => pipelined_adder3user_aclrgnd_output_wire, --  user_aclr.wire
			ena       => pipelined_adder3enavcc_output_wire        --        ena.wire
		);

	pipelined_adder3user_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => pipelined_adder3user_aclrgnd_output_wire  -- output.wire
		);

	pipelined_adder3enavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => pipelined_adder3enavcc_output_wire  -- output.wire
		);

	pipelined_adder2 : component alt_dspbuilder_pipelined_adder_GNY2JEH574
		generic map (
			pipeline => 0,
			width    => 32
		)
		port map (
			clock     => clock_0_clock_output_clk,                 -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,               --           .reset
			dataa     => pipelined_adder1_result_wire,             --      dataa.wire
			datab     => x16_2_output_wire,                        --      datab.wire
			result    => pipelined_adder2_result_wire,             --     result.wire
			user_aclr => pipelined_adder2user_aclrgnd_output_wire, --  user_aclr.wire
			ena       => pipelined_adder2enavcc_output_wire        --        ena.wire
		);

	pipelined_adder2user_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => pipelined_adder2user_aclrgnd_output_wire  -- output.wire
		);

	pipelined_adder2enavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => pipelined_adder2enavcc_output_wire  -- output.wire
		);

	pipelined_adder1 : component alt_dspbuilder_pipelined_adder_GNY2JEH574
		generic map (
			pipeline => 0,
			width    => 32
		)
		port map (
			clock     => clock_0_clock_output_clk,                 -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,               --           .reset
			dataa     => pipelined_adder_result_wire,              --      dataa.wire
			datab     => bus_conversion2_output_wire,              --      datab.wire
			result    => pipelined_adder1_result_wire,             --     result.wire
			user_aclr => pipelined_adder1user_aclrgnd_output_wire, --  user_aclr.wire
			ena       => pipelined_adder1enavcc_output_wire        --        ena.wire
		);

	pipelined_adder1user_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => pipelined_adder1user_aclrgnd_output_wire  -- output.wire
		);

	pipelined_adder1enavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => pipelined_adder1enavcc_output_wire  -- output.wire
		);

	bus_conversion8 : component alt_dspbuilder_cast_GNTSUCRN4Q
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast56_output_wire,          --  input.wire
			output => bus_conversion8_output_wire  -- output.wire
		);

	x16 : component alt_dspbuilder_cast_GNBBMDRQ7A
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => delay2_output_wire, --  input.wire
			output => x16_output_wire     -- output.wire
		);

	bus_conversion7 : component alt_dspbuilder_cast_GNGZDNROJB
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast55_output_wire,          --  input.wire
			output => bus_conversion7_output_wire  -- output.wire
		);

	bus_conversion6 : component alt_dspbuilder_cast_GND47QX5DY
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => pipelined_adder6_result_wire, --  input.wire
			output => bus_conversion6_output_wire   -- output.wire
		);

	pipelined_adder6 : component alt_dspbuilder_pipelined_adder_GN4HTUTWRG
		generic map (
			pipeline => 0,
			width    => 32
		)
		port map (
			clock     => clock_0_clock_output_clk,                 -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,               --           .reset
			dataa     => multiplier_result_wire,                   --      dataa.wire
			datab     => altbus_output_wire,                       --      datab.wire
			result    => pipelined_adder6_result_wire,             --     result.wire
			user_aclr => pipelined_adder6user_aclrgnd_output_wire, --  user_aclr.wire
			ena       => pipelined_adder6enavcc_output_wire        --        ena.wire
		);

	pipelined_adder6user_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => pipelined_adder6user_aclrgnd_output_wire  -- output.wire
		);

	pipelined_adder6enavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => pipelined_adder6enavcc_output_wire  -- output.wire
		);

	ts_0 : component alt_dspbuilder_port_GNEPKLLZKY
		port map (
			input  => Ts,               --  input.wire
			output => ts_0_output_wire  -- output.wire
		);

	bus_conversion5 : component alt_dspbuilder_cast_GN6DTGWIDG
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast51_output_wire,          --  input.wire
			output => bus_conversion5_output_wire  -- output.wire
		);

	bus_conversion4 : component alt_dspbuilder_cast_GNGWUGSP35
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast52_output_wire,          --  input.wire
			output => bus_conversion4_output_wire  -- output.wire
		);

	bus_conversion3 : component alt_dspbuilder_cast_GNGWUGSP35
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast57_output_wire,          --  input.wire
			output => bus_conversion3_output_wire  -- output.wire
		);

	bus_conversion2 : component alt_dspbuilder_cast_GNGWUGSP35
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast53_output_wire,          --  input.wire
			output => bus_conversion2_output_wire  -- output.wire
		);

	x16_2 : component alt_dspbuilder_cast_GNBBMDRQ7A
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => delay_output_wire, --  input.wire
			output => x16_2_output_wire  -- output.wire
		);

	bus_conversion1 : component alt_dspbuilder_cast_GNGWUGSP35
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast58_output_wire,          --  input.wire
			output => bus_conversion1_output_wire  -- output.wire
		);

	delay2 : component alt_dspbuilder_delay_GNKZDMBKQG
		generic map (
			ClockPhase => "1",
			BitPattern => "01000000000000000000000000000000",
			width      => 32,
			use_init   => 0,
			delay      => 1
		)
		port map (
			input  => bus_conversion6_output_wire, --      input.wire
			clock  => clock_0_clock_output_clk,    -- clock_aclr.clk
			aclr   => clock_0_clock_output_reset,  --           .reset
			output => delay2_output_wire,          --     output.wire
			sclr   => delay2sclrgnd_output_wire,   --       sclr.wire
			ena    => clk_60k_0_output_wire        --        ena.wire
		);

	delay2sclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => delay2sclrgnd_output_wire  -- output.wire
		);

	altbus : component alt_dspbuilder_cast_GND47QX5DY
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => delay2_output_wire, --  input.wire
			output => altbus_output_wire  -- output.wire
		);

	delay1 : component alt_dspbuilder_delay_GNKZDMBKQG
		generic map (
			ClockPhase => "1",
			BitPattern => "01000000000000000000000000000000",
			width      => 32,
			use_init   => 0,
			delay      => 1
		)
		port map (
			input  => delay_output_wire,          --      input.wire
			clock  => clock_0_clock_output_clk,   -- clock_aclr.clk
			aclr   => clock_0_clock_output_reset, --           .reset
			output => delay1_output_wire,         --     output.wire
			sclr   => delay1sclrgnd_output_wire,  --       sclr.wire
			ena    => clk_60k_0_output_wire       --        ena.wire
		);

	delay1sclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => delay1sclrgnd_output_wire  -- output.wire
		);

	out1_0 : component alt_dspbuilder_port_GNBOOX3JQY
		port map (
			input  => bus_conversion8_output_wire, --  input.wire
			output => Out1                         -- output.wire
		);

	clk_60k_0 : component alt_dspbuilder_port_GN37ALZBS4
		port map (
			input  => CLK_60K,               --  input.wire
			output => clk_60k_0_output_wire  -- output.wire
		);

	id_1_12 : component alt_dspbuilder_constant_GND3QGQB6V
		generic map (
			BitPattern => "000010101010101011",
			HDLTYPE    => "STD_LOGIC_VECTOR",
			width      => 18
		)
		port map (
			output => id_1_12_output_wire  -- output.wire
		);

	x4 : component alt_dspbuilder_cast_GNBBMDRQ7A
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => delay1_output_wire, --  input.wire
			output => x4_output_wire      -- output.wire
		);

	cast51 : component alt_dspbuilder_cast_GN3MSXHHKG
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => in_1_0_output_wire, --  input.wire
			output => cast51_output_wire  -- output.wire
		);

	cast52 : component alt_dspbuilder_cast_GNVVN754F4
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => delay1_output_wire, --  input.wire
			output => cast52_output_wire  -- output.wire
		);

	cast53 : component alt_dspbuilder_cast_GNVVN754F4
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => delay2_output_wire, --  input.wire
			output => cast53_output_wire  -- output.wire
		);

	cast54 : component alt_dspbuilder_cast_GNTWTJF3KX
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => ts_0_output_wire,   --  input.wire
			output => cast54_output_wire  -- output.wire
		);

	cast55 : component alt_dspbuilder_cast_GNRCBZ7OTJ
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => multiplier1_result_wire, --  input.wire
			output => cast55_output_wire       -- output.wire
		);

	cast56 : component alt_dspbuilder_cast_GNXTVWHWB4
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => pipelined_adder4_result_wire, --  input.wire
			output => cast56_output_wire            -- output.wire
		);

	cast57 : component alt_dspbuilder_cast_GNKUAJE7NW
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => x4_output_wire,     --  input.wire
			output => cast57_output_wire  -- output.wire
		);

	cast58 : component alt_dspbuilder_cast_GNSLUF5FF5
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => x8_output_wire,     --  input.wire
			output => cast58_output_wire  -- output.wire
		);

end architecture rtl; -- of PLL_3orden_change_GN_PLL_3orden_change_PLL_SOGI_1_sv1
