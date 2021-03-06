-- PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals1.vhd

-- Generated using ACDS version 17.1 590

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals1 is
	port (
		Va      : in  std_logic_vector(13 downto 0) := (others => '0'); --      Va.wire
		Va_12b  : out std_logic_vector(11 downto 0);                    --  Va_12b.wire
		Vm      : in  std_logic_vector(14 downto 0) := (others => '0'); --      Vm.wire
		Vb      : in  std_logic_vector(13 downto 0) := (others => '0'); --      Vb.wire
		Vm_12b  : out std_logic_vector(11 downto 0);                    --  Vm_12b.wire
		Vin     : in  std_logic_vector(13 downto 0) := (others => '0'); --     Vin.wire
		Clock   : in  std_logic                     := '0';             --   Clock.clk
		aclr    : in  std_logic                     := '0';             --        .reset
		Vin_12b : out std_logic_vector(11 downto 0);                    -- Vin_12b.wire
		Vb_12b  : out std_logic_vector(11 downto 0)                     --  Vb_12b.wire
	);
end entity PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals1;

architecture rtl of PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals1 is
	component alt_dspbuilder_clock_GNQFU4PUDH is
		port (
			aclr      : in  std_logic := 'X'; -- reset
			aclr_n    : in  std_logic := 'X'; -- reset_n
			aclr_out  : out std_logic;        -- reset
			clock     : in  std_logic := 'X'; -- clk
			clock_out : out std_logic         -- clk
		);
	end component alt_dspbuilder_clock_GNQFU4PUDH;

	component alt_dspbuilder_cast_GNXGQF7CFM is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(21 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(21 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNXGQF7CFM;

	component alt_dspbuilder_round_GNXNNM4EWH is
		generic (
			OUT_WIDTH_g     : natural := 6;
			IN_WIDTH_g      : natural := 8;
			PIPELINE_g      : natural := 0;
			ROUNDING_TYPE_g : string  := "TRUNCATE_LOW";
			SIGNED_g        : natural := 1
		);
		port (
			clk       : in  std_logic                     := 'X';             -- clk
			reset     : in  std_logic                     := 'X';             -- wire
			datain    : in  std_logic_vector(21 downto 0) := (others => 'X'); -- wire
			dataout   : out std_logic_vector(16 downto 0);                    -- wire
			ena       : in  std_logic                     := 'X';             -- wire
			user_aclr : in  std_logic                     := 'X'              -- wire
		);
	end component alt_dspbuilder_round_GNXNNM4EWH;

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

	component alt_dspbuilder_cast_GNNPYFJRPJ is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(21 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(21 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNNPYFJRPJ;

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

	component alt_dspbuilder_port_GNBOOX3JQY is
		port (
			input  : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNBOOX3JQY;

	component alt_dspbuilder_cast_GNNTBQPN53 is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(11 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNNTBQPN53;

	component alt_dspbuilder_port_GN4K6H3QBP is
		port (
			input  : in  std_logic_vector(11 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(11 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GN4K6H3QBP;

	component alt_dspbuilder_port_GNIF77H5YS is
		port (
			input  : in  std_logic_vector(14 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(14 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNIF77H5YS;

	component alt_dspbuilder_cast_GNA5AA6QPF is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(12 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(12 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNA5AA6QPF;

	component alt_dspbuilder_constant_GNGPCXCFCV is
		generic (
			BitPattern : string  := "0000";
			HDLTYPE    : string  := "STD_LOGIC_VECTOR";
			width      : natural := 4
		);
		port (
			output : out std_logic_vector(12 downto 0)   -- wire
		);
	end component alt_dspbuilder_constant_GNGPCXCFCV;

	component alt_dspbuilder_cast_GNMFPTKSML is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(21 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNMFPTKSML;

	component alt_dspbuilder_cast_GNM5FFDTMH is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(14 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(21 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNM5FFDTMH;

	component alt_dspbuilder_cast_GNCYKEYFUT is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(12 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNCYKEYFUT;

	component alt_dspbuilder_cast_GNFJ64GVK3 is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(16 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(12 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNFJ64GVK3;

	signal round1user_aclrgnd_output_wire           : std_logic;                     -- Round1user_aclrGND:output -> Round1:user_aclr
	signal round1resetgnd_output_wire               : std_logic;                     -- Round1resetGND:output -> Round1:reset
	signal round1enavcc_output_wire                 : std_logic;                     -- Round1enaVCC:output -> Round1:ena
	signal round2user_aclrgnd_output_wire           : std_logic;                     -- Round2user_aclrGND:output -> Round2:user_aclr
	signal round2resetgnd_output_wire               : std_logic;                     -- Round2resetGND:output -> Round2:reset
	signal round2enavcc_output_wire                 : std_logic;                     -- Round2enaVCC:output -> Round2:ena
	signal round3user_aclrgnd_output_wire           : std_logic;                     -- Round3user_aclrGND:output -> Round3:user_aclr
	signal round3resetgnd_output_wire               : std_logic;                     -- Round3resetGND:output -> Round3:reset
	signal round3enavcc_output_wire                 : std_logic;                     -- Round3enaVCC:output -> Round3:ena
	signal pipelined_adderuser_aclrgnd_output_wire  : std_logic;                     -- Pipelined_Adderuser_aclrGND:output -> Pipelined_Adder:user_aclr
	signal pipelined_adderenavcc_output_wire        : std_logic;                     -- Pipelined_AdderenaVCC:output -> Pipelined_Adder:ena
	signal pipelined_adder3user_aclrgnd_output_wire : std_logic;                     -- Pipelined_Adder3user_aclrGND:output -> Pipelined_Adder3:user_aclr
	signal pipelined_adder3enavcc_output_wire       : std_logic;                     -- Pipelined_Adder3enaVCC:output -> Pipelined_Adder3:ena
	signal rounduser_aclrgnd_output_wire            : std_logic;                     -- Rounduser_aclrGND:output -> Round:user_aclr
	signal roundresetgnd_output_wire                : std_logic;                     -- RoundresetGND:output -> Round:reset
	signal roundenavcc_output_wire                  : std_logic;                     -- RoundenaVCC:output -> Round:ena
	signal pipelined_adder2user_aclrgnd_output_wire : std_logic;                     -- Pipelined_Adder2user_aclrGND:output -> Pipelined_Adder2:user_aclr
	signal pipelined_adder2enavcc_output_wire       : std_logic;                     -- Pipelined_Adder2enaVCC:output -> Pipelined_Adder2:ena
	signal pipelined_adder1user_aclrgnd_output_wire : std_logic;                     -- Pipelined_Adder1user_aclrGND:output -> Pipelined_Adder1:user_aclr
	signal pipelined_adder1enavcc_output_wire       : std_logic;                     -- Pipelined_Adder1enaVCC:output -> Pipelined_Adder1:ena
	signal bus_conversion_vin_output_wire           : std_logic_vector(21 downto 0); -- Bus_Conversion_Vin:output -> Binary_Point_Casting:input
	signal bus_conversion_vin2_output_wire          : std_logic_vector(21 downto 0); -- Bus_Conversion_Vin2:output -> Binary_Point_Casting1:input
	signal bus_conversion_vin4_output_wire          : std_logic_vector(21 downto 0); -- Bus_Conversion_Vin4:output -> Binary_Point_Casting2:input
	signal bus_conversion_vin6_output_wire          : std_logic_vector(21 downto 0); -- Bus_Conversion_Vin6:output -> Binary_Point_Casting3:input
	signal bus_conversion_vin1_output_wire          : std_logic_vector(12 downto 0); -- Bus_Conversion_Vin1:output -> Pipelined_Adder:dataa
	signal cte_output_wire                          : std_logic_vector(12 downto 0); -- CTE:output -> Pipelined_Adder:datab
	signal bus_conversion_vin3_output_wire          : std_logic_vector(12 downto 0); -- Bus_Conversion_Vin3:output -> Pipelined_Adder1:dataa
	signal cte1_output_wire                         : std_logic_vector(12 downto 0); -- CTE1:output -> Pipelined_Adder1:datab
	signal bus_conversion_vin5_output_wire          : std_logic_vector(12 downto 0); -- Bus_Conversion_Vin5:output -> Pipelined_Adder2:dataa
	signal cte3_output_wire                         : std_logic_vector(12 downto 0); -- CTE3:output -> Pipelined_Adder2:datab
	signal bus_conversion_vin7_output_wire          : std_logic_vector(12 downto 0); -- Bus_Conversion_Vin7:output -> Pipelined_Adder3:dataa
	signal cte2_output_wire                         : std_logic_vector(12 downto 0); -- CTE2:output -> Pipelined_Adder3:datab
	signal binary_point_casting_output_wire         : std_logic_vector(21 downto 0); -- Binary_Point_Casting:output -> Round:datain
	signal binary_point_casting1_output_wire        : std_logic_vector(21 downto 0); -- Binary_Point_Casting1:output -> Round1:datain
	signal binary_point_casting2_output_wire        : std_logic_vector(21 downto 0); -- Binary_Point_Casting2:output -> Round2:datain
	signal binary_point_casting3_output_wire        : std_logic_vector(21 downto 0); -- Binary_Point_Casting3:output -> Round3:datain
	signal bus_conversion_output_wire               : std_logic_vector(11 downto 0); -- Bus_Conversion:output -> Vin_12b_0:input
	signal bus_conversion_1_output_wire             : std_logic_vector(11 downto 0); -- Bus_Conversion_1:output -> Va_12b_0:input
	signal bus_conversion_2_output_wire             : std_logic_vector(11 downto 0); -- Bus_Conversion_2:output -> Vb_12b_0:input
	signal bus_conversion_3_output_wire             : std_logic_vector(11 downto 0); -- Bus_Conversion_3:output -> Vm_12b_0:input
	signal vin_0_output_wire                        : std_logic_vector(13 downto 0); -- Vin_0:output -> cast19:input
	signal cast19_output_wire                       : std_logic_vector(21 downto 0); -- cast19:output -> Bus_Conversion_Vin:input
	signal va_0_output_wire                         : std_logic_vector(13 downto 0); -- Va_0:output -> cast20:input
	signal cast20_output_wire                       : std_logic_vector(21 downto 0); -- cast20:output -> Bus_Conversion_Vin2:input
	signal vb_0_output_wire                         : std_logic_vector(13 downto 0); -- Vb_0:output -> cast21:input
	signal cast21_output_wire                       : std_logic_vector(21 downto 0); -- cast21:output -> Bus_Conversion_Vin4:input
	signal vm_0_output_wire                         : std_logic_vector(14 downto 0); -- Vm_0:output -> cast22:input
	signal cast22_output_wire                       : std_logic_vector(21 downto 0); -- cast22:output -> Bus_Conversion_Vin6:input
	signal pipelined_adder_result_wire              : std_logic_vector(12 downto 0); -- Pipelined_Adder:result -> cast23:input
	signal cast23_output_wire                       : std_logic_vector(13 downto 0); -- cast23:output -> Bus_Conversion:input
	signal pipelined_adder1_result_wire             : std_logic_vector(12 downto 0); -- Pipelined_Adder1:result -> cast24:input
	signal cast24_output_wire                       : std_logic_vector(13 downto 0); -- cast24:output -> Bus_Conversion_1:input
	signal pipelined_adder2_result_wire             : std_logic_vector(12 downto 0); -- Pipelined_Adder2:result -> cast25:input
	signal cast25_output_wire                       : std_logic_vector(13 downto 0); -- cast25:output -> Bus_Conversion_2:input
	signal pipelined_adder3_result_wire             : std_logic_vector(12 downto 0); -- Pipelined_Adder3:result -> cast26:input
	signal cast26_output_wire                       : std_logic_vector(13 downto 0); -- cast26:output -> Bus_Conversion_3:input
	signal round_dataout_wire                       : std_logic_vector(16 downto 0); -- Round:dataout -> cast27:input
	signal cast27_output_wire                       : std_logic_vector(12 downto 0); -- cast27:output -> Bus_Conversion_Vin1:input
	signal round1_dataout_wire                      : std_logic_vector(16 downto 0); -- Round1:dataout -> cast28:input
	signal cast28_output_wire                       : std_logic_vector(12 downto 0); -- cast28:output -> Bus_Conversion_Vin3:input
	signal round2_dataout_wire                      : std_logic_vector(16 downto 0); -- Round2:dataout -> cast29:input
	signal cast29_output_wire                       : std_logic_vector(12 downto 0); -- cast29:output -> Bus_Conversion_Vin5:input
	signal round3_dataout_wire                      : std_logic_vector(16 downto 0); -- Round3:dataout -> cast30:input
	signal cast30_output_wire                       : std_logic_vector(12 downto 0); -- cast30:output -> Bus_Conversion_Vin7:input
	signal clock_0_clock_output_clk                 : std_logic;                     -- Clock_0:clock_out -> [Pipelined_Adder1:clock, Pipelined_Adder2:clock, Pipelined_Adder3:clock, Pipelined_Adder:clock, Round1:clk, Round2:clk, Round3:clk, Round:clk]
	signal clock_0_clock_output_reset               : std_logic;                     -- Clock_0:aclr_out -> [Pipelined_Adder1:aclr, Pipelined_Adder2:aclr, Pipelined_Adder3:aclr, Pipelined_Adder:aclr, Round1:reset, Round2:reset, Round3:reset, Round:reset]

begin

	clock_0 : component alt_dspbuilder_clock_GNQFU4PUDH
		port map (
			clock_out => clock_0_clock_output_clk,   -- clock_output.clk
			aclr_out  => clock_0_clock_output_reset, --             .reset
			clock     => Clock,                      --        clock.clk
			aclr      => aclr                        --             .reset
		);

	binary_point_casting1 : component alt_dspbuilder_cast_GNXGQF7CFM
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => bus_conversion_vin2_output_wire,   --  input.wire
			output => binary_point_casting1_output_wire  -- output.wire
		);

	round1 : component alt_dspbuilder_round_GNXNNM4EWH
		generic map (
			OUT_WIDTH_g     => 17,
			IN_WIDTH_g      => 22,
			PIPELINE_g      => 0,
			ROUNDING_TYPE_g => "TRUNCATE_LOW",
			SIGNED_g        => 1
		)
		port map (
			clk       => clock_0_clock_output_clk,          -- clk_reset.clk
			reset     => clock_0_clock_output_reset,        --          .reset
			datain    => binary_point_casting1_output_wire, --    datain.wire
			dataout   => round1_dataout_wire,               --   dataout.wire
			ena       => round1enavcc_output_wire,          --       ena.wire
			user_aclr => round1user_aclrgnd_output_wire     -- user_aclr.wire
		);

	round1user_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => round1user_aclrgnd_output_wire  -- output.wire
		);

	round1resetgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => round1resetgnd_output_wire  -- output.wire
		);

	round1enavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => round1enavcc_output_wire  -- output.wire
		);

	binary_point_casting3 : component alt_dspbuilder_cast_GNXGQF7CFM
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => bus_conversion_vin6_output_wire,   --  input.wire
			output => binary_point_casting3_output_wire  -- output.wire
		);

	round2 : component alt_dspbuilder_round_GNXNNM4EWH
		generic map (
			OUT_WIDTH_g     => 17,
			IN_WIDTH_g      => 22,
			PIPELINE_g      => 0,
			ROUNDING_TYPE_g => "TRUNCATE_LOW",
			SIGNED_g        => 1
		)
		port map (
			clk       => clock_0_clock_output_clk,          -- clk_reset.clk
			reset     => clock_0_clock_output_reset,        --          .reset
			datain    => binary_point_casting2_output_wire, --    datain.wire
			dataout   => round2_dataout_wire,               --   dataout.wire
			ena       => round2enavcc_output_wire,          --       ena.wire
			user_aclr => round2user_aclrgnd_output_wire     -- user_aclr.wire
		);

	round2user_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => round2user_aclrgnd_output_wire  -- output.wire
		);

	round2resetgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => round2resetgnd_output_wire  -- output.wire
		);

	round2enavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => round2enavcc_output_wire  -- output.wire
		);

	binary_point_casting2 : component alt_dspbuilder_cast_GNXGQF7CFM
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => bus_conversion_vin4_output_wire,   --  input.wire
			output => binary_point_casting2_output_wire  -- output.wire
		);

	round3 : component alt_dspbuilder_round_GNXNNM4EWH
		generic map (
			OUT_WIDTH_g     => 17,
			IN_WIDTH_g      => 22,
			PIPELINE_g      => 0,
			ROUNDING_TYPE_g => "TRUNCATE_LOW",
			SIGNED_g        => 1
		)
		port map (
			clk       => clock_0_clock_output_clk,          -- clk_reset.clk
			reset     => clock_0_clock_output_reset,        --          .reset
			datain    => binary_point_casting3_output_wire, --    datain.wire
			dataout   => round3_dataout_wire,               --   dataout.wire
			ena       => round3enavcc_output_wire,          --       ena.wire
			user_aclr => round3user_aclrgnd_output_wire     -- user_aclr.wire
		);

	round3user_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => round3user_aclrgnd_output_wire  -- output.wire
		);

	round3resetgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => round3resetgnd_output_wire  -- output.wire
		);

	round3enavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => round3enavcc_output_wire  -- output.wire
		);

	bus_conversion_vin : component alt_dspbuilder_cast_GNNPYFJRPJ
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast19_output_wire,             --  input.wire
			output => bus_conversion_vin_output_wire  -- output.wire
		);

	pipelined_adder : component alt_dspbuilder_pipelined_adder_GN4HTUTWRG
		generic map (
			pipeline => 0,
			width    => 13
		)
		port map (
			clock     => clock_0_clock_output_clk,                -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,              --           .reset
			dataa     => bus_conversion_vin1_output_wire,         --      dataa.wire
			datab     => cte_output_wire,                         --      datab.wire
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

	va_0 : component alt_dspbuilder_port_GNBOOX3JQY
		port map (
			input  => Va,               --  input.wire
			output => va_0_output_wire  -- output.wire
		);

	vb_0 : component alt_dspbuilder_port_GNBOOX3JQY
		port map (
			input  => Vb,               --  input.wire
			output => vb_0_output_wire  -- output.wire
		);

	bus_conversion_3 : component alt_dspbuilder_cast_GNNTBQPN53
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast26_output_wire,           --  input.wire
			output => bus_conversion_3_output_wire  -- output.wire
		);

	bus_conversion_2 : component alt_dspbuilder_cast_GNNTBQPN53
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast25_output_wire,           --  input.wire
			output => bus_conversion_2_output_wire  -- output.wire
		);

	vm_12b_0 : component alt_dspbuilder_port_GN4K6H3QBP
		port map (
			input  => bus_conversion_3_output_wire, --  input.wire
			output => Vm_12b                        -- output.wire
		);

	vm_0 : component alt_dspbuilder_port_GNIF77H5YS
		port map (
			input  => Vm,               --  input.wire
			output => vm_0_output_wire  -- output.wire
		);

	pipelined_adder3 : component alt_dspbuilder_pipelined_adder_GN4HTUTWRG
		generic map (
			pipeline => 0,
			width    => 13
		)
		port map (
			clock     => clock_0_clock_output_clk,                 -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,               --           .reset
			dataa     => bus_conversion_vin7_output_wire,          --      dataa.wire
			datab     => cte2_output_wire,                         --      datab.wire
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

	round : component alt_dspbuilder_round_GNXNNM4EWH
		generic map (
			OUT_WIDTH_g     => 17,
			IN_WIDTH_g      => 22,
			PIPELINE_g      => 0,
			ROUNDING_TYPE_g => "TRUNCATE_LOW",
			SIGNED_g        => 1
		)
		port map (
			clk       => clock_0_clock_output_clk,         -- clk_reset.clk
			reset     => clock_0_clock_output_reset,       --          .reset
			datain    => binary_point_casting_output_wire, --    datain.wire
			dataout   => round_dataout_wire,               --   dataout.wire
			ena       => roundenavcc_output_wire,          --       ena.wire
			user_aclr => rounduser_aclrgnd_output_wire     -- user_aclr.wire
		);

	rounduser_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => rounduser_aclrgnd_output_wire  -- output.wire
		);

	roundresetgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => roundresetgnd_output_wire  -- output.wire
		);

	roundenavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => roundenavcc_output_wire  -- output.wire
		);

	pipelined_adder2 : component alt_dspbuilder_pipelined_adder_GN4HTUTWRG
		generic map (
			pipeline => 0,
			width    => 13
		)
		port map (
			clock     => clock_0_clock_output_clk,                 -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,               --           .reset
			dataa     => bus_conversion_vin5_output_wire,          --      dataa.wire
			datab     => cte3_output_wire,                         --      datab.wire
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

	pipelined_adder1 : component alt_dspbuilder_pipelined_adder_GN4HTUTWRG
		generic map (
			pipeline => 0,
			width    => 13
		)
		port map (
			clock     => clock_0_clock_output_clk,                 -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,               --           .reset
			dataa     => bus_conversion_vin3_output_wire,          --      dataa.wire
			datab     => cte1_output_wire,                         --      datab.wire
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

	bus_conversion_1 : component alt_dspbuilder_cast_GNNTBQPN53
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast24_output_wire,           --  input.wire
			output => bus_conversion_1_output_wire  -- output.wire
		);

	bus_conversion_vin5 : component alt_dspbuilder_cast_GNA5AA6QPF
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast29_output_wire,              --  input.wire
			output => bus_conversion_vin5_output_wire  -- output.wire
		);

	cte3 : component alt_dspbuilder_constant_GNGPCXCFCV
		generic map (
			BitPattern => "0011101011111",
			HDLTYPE    => "STD_LOGIC_VECTOR",
			width      => 13
		)
		port map (
			output => cte3_output_wire  -- output.wire
		);

	bus_conversion_vin6 : component alt_dspbuilder_cast_GNNPYFJRPJ
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast22_output_wire,              --  input.wire
			output => bus_conversion_vin6_output_wire  -- output.wire
		);

	cte2 : component alt_dspbuilder_constant_GNGPCXCFCV
		generic map (
			BitPattern => "0011101011111",
			HDLTYPE    => "STD_LOGIC_VECTOR",
			width      => 13
		)
		port map (
			output => cte2_output_wire  -- output.wire
		);

	bus_conversion_vin7 : component alt_dspbuilder_cast_GNA5AA6QPF
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast30_output_wire,              --  input.wire
			output => bus_conversion_vin7_output_wire  -- output.wire
		);

	cte1 : component alt_dspbuilder_constant_GNGPCXCFCV
		generic map (
			BitPattern => "0011101011111",
			HDLTYPE    => "STD_LOGIC_VECTOR",
			width      => 13
		)
		port map (
			output => cte1_output_wire  -- output.wire
		);

	bus_conversion : component alt_dspbuilder_cast_GNNTBQPN53
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast23_output_wire,         --  input.wire
			output => bus_conversion_output_wire  -- output.wire
		);

	vin_12b_0 : component alt_dspbuilder_port_GN4K6H3QBP
		port map (
			input  => bus_conversion_output_wire, --  input.wire
			output => Vin_12b                     -- output.wire
		);

	bus_conversion_vin1 : component alt_dspbuilder_cast_GNA5AA6QPF
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast27_output_wire,              --  input.wire
			output => bus_conversion_vin1_output_wire  -- output.wire
		);

	bus_conversion_vin2 : component alt_dspbuilder_cast_GNNPYFJRPJ
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast20_output_wire,              --  input.wire
			output => bus_conversion_vin2_output_wire  -- output.wire
		);

	bus_conversion_vin3 : component alt_dspbuilder_cast_GNA5AA6QPF
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast28_output_wire,              --  input.wire
			output => bus_conversion_vin3_output_wire  -- output.wire
		);

	bus_conversion_vin4 : component alt_dspbuilder_cast_GNNPYFJRPJ
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast21_output_wire,              --  input.wire
			output => bus_conversion_vin4_output_wire  -- output.wire
		);

	binary_point_casting : component alt_dspbuilder_cast_GNXGQF7CFM
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => bus_conversion_vin_output_wire,   --  input.wire
			output => binary_point_casting_output_wire  -- output.wire
		);

	va_12b_0 : component alt_dspbuilder_port_GN4K6H3QBP
		port map (
			input  => bus_conversion_1_output_wire, --  input.wire
			output => Va_12b                        -- output.wire
		);

	cte : component alt_dspbuilder_constant_GNGPCXCFCV
		generic map (
			BitPattern => "0011101011111",
			HDLTYPE    => "STD_LOGIC_VECTOR",
			width      => 13
		)
		port map (
			output => cte_output_wire  -- output.wire
		);

	vin_0 : component alt_dspbuilder_port_GNBOOX3JQY
		port map (
			input  => Vin,               --  input.wire
			output => vin_0_output_wire  -- output.wire
		);

	vb_12b_0 : component alt_dspbuilder_port_GN4K6H3QBP
		port map (
			input  => bus_conversion_2_output_wire, --  input.wire
			output => Vb_12b                        -- output.wire
		);

	cast19 : component alt_dspbuilder_cast_GNMFPTKSML
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => vin_0_output_wire,  --  input.wire
			output => cast19_output_wire  -- output.wire
		);

	cast20 : component alt_dspbuilder_cast_GNMFPTKSML
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => va_0_output_wire,   --  input.wire
			output => cast20_output_wire  -- output.wire
		);

	cast21 : component alt_dspbuilder_cast_GNMFPTKSML
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => vb_0_output_wire,   --  input.wire
			output => cast21_output_wire  -- output.wire
		);

	cast22 : component alt_dspbuilder_cast_GNM5FFDTMH
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => vm_0_output_wire,   --  input.wire
			output => cast22_output_wire  -- output.wire
		);

	cast23 : component alt_dspbuilder_cast_GNCYKEYFUT
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => pipelined_adder_result_wire, --  input.wire
			output => cast23_output_wire           -- output.wire
		);

	cast24 : component alt_dspbuilder_cast_GNCYKEYFUT
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => pipelined_adder1_result_wire, --  input.wire
			output => cast24_output_wire            -- output.wire
		);

	cast25 : component alt_dspbuilder_cast_GNCYKEYFUT
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => pipelined_adder2_result_wire, --  input.wire
			output => cast25_output_wire            -- output.wire
		);

	cast26 : component alt_dspbuilder_cast_GNCYKEYFUT
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => pipelined_adder3_result_wire, --  input.wire
			output => cast26_output_wire            -- output.wire
		);

	cast27 : component alt_dspbuilder_cast_GNFJ64GVK3
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => round_dataout_wire, --  input.wire
			output => cast27_output_wire  -- output.wire
		);

	cast28 : component alt_dspbuilder_cast_GNFJ64GVK3
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => round1_dataout_wire, --  input.wire
			output => cast28_output_wire   -- output.wire
		);

	cast29 : component alt_dspbuilder_cast_GNFJ64GVK3
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => round2_dataout_wire, --  input.wire
			output => cast29_output_wire   -- output.wire
		);

	cast30 : component alt_dspbuilder_cast_GNFJ64GVK3
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => round3_dataout_wire, --  input.wire
			output => cast30_output_wire   -- output.wire
		);

end architecture rtl; -- of PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals1
