-- PLL_3orden_change_GN_PLL_3orden_change_PLL_Wt_to_alphao1.vhd

-- Generated using ACDS version 17.1 590

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PLL_3orden_change_GN_PLL_3orden_change_PLL_Wt_to_alphao1 is
	port (
		wt      : in  std_logic_vector(21 downto 0) := (others => '0'); --      wt.wire
		wot     : out std_logic_vector(9 downto 0);                     --     wot.wire
		Clock   : in  std_logic                     := '0';             --   Clock.clk
		aclr    : in  std_logic                     := '0';             --        .reset
		wot_12b : out std_logic_vector(11 downto 0)                     -- wot_12b.wire
	);
end entity PLL_3orden_change_GN_PLL_3orden_change_PLL_Wt_to_alphao1;

architecture rtl of PLL_3orden_change_GN_PLL_3orden_change_PLL_Wt_to_alphao1 is
	component alt_dspbuilder_clock_GNQFU4PUDH is
		port (
			aclr      : in  std_logic := 'X'; -- reset
			aclr_n    : in  std_logic := 'X'; -- reset_n
			aclr_out  : out std_logic;        -- reset
			clock     : in  std_logic := 'X'; -- clk
			clock_out : out std_logic         -- clk
		);
	end component alt_dspbuilder_clock_GNQFU4PUDH;

	component alt_dspbuilder_cast_GNM546SEVW is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(10 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(9 downto 0)                      -- wire
		);
	end component alt_dspbuilder_cast_GNM546SEVW;

	component alt_dspbuilder_constant_GNRGQV2EVX is
		generic (
			BitPattern : string  := "0000";
			HDLTYPE    : string  := "STD_LOGIC_VECTOR";
			width      : natural := 4
		);
		port (
			output : out std_logic_vector(19 downto 0)   -- wire
		);
	end component alt_dspbuilder_constant_GNRGQV2EVX;

	component alt_dspbuilder_port_GN4K6H3QBP is
		port (
			input  : in  std_logic_vector(11 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(11 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GN4K6H3QBP;

	component alt_dspbuilder_cast_GN7TCXHQBM is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(11 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(10 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GN7TCXHQBM;

	component alt_dspbuilder_cast_GNDS5WH6UV is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(11 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(11 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNDS5WH6UV;

	component alt_dspbuilder_multiplier_GNBBBKCF23 is
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
	end component alt_dspbuilder_multiplier_GNBBBKCF23;

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

	component alt_dspbuilder_round_GNX5HX7SL2 is
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
			datain    : in  std_logic_vector(15 downto 0) := (others => 'X'); -- wire
			dataout   : out std_logic_vector(11 downto 0);                    -- wire
			ena       : in  std_logic                     := 'X';             -- wire
			user_aclr : in  std_logic                     := 'X'              -- wire
		);
	end component alt_dspbuilder_round_GNX5HX7SL2;

	component alt_dspbuilder_port_GNBVD2CPQ4 is
		port (
			input  : in  std_logic_vector(21 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(21 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNBVD2CPQ4;

	component alt_dspbuilder_port_GNSSYS4J5R is
		port (
			input  : in  std_logic_vector(9 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(9 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNSSYS4J5R;

	component alt_dspbuilder_cast_GN4PSCVLKB is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(10 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(11 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GN4PSCVLKB;

	component alt_dspbuilder_cast_GNNVOEACLJ is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(10 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(10 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNNVOEACLJ;

	signal multiplieruser_aclrgnd_output_wire : std_logic;                     -- Multiplieruser_aclrGND:output -> Multiplier:user_aclr
	signal multiplierenavcc_output_wire       : std_logic;                     -- MultiplierenaVCC:output -> Multiplier:ena
	signal rounduser_aclrgnd_output_wire      : std_logic;                     -- Rounduser_aclrGND:output -> Round:user_aclr
	signal roundresetgnd_output_wire          : std_logic;                     -- RoundresetGND:output -> Round:reset
	signal roundenavcc_output_wire            : std_logic;                     -- RoundenaVCC:output -> Round:ena
	signal wt_0_output_wire                   : std_logic_vector(21 downto 0); -- wt_0:output -> Multiplier:dataa
	signal multiplier_result_wire             : std_logic_vector(15 downto 0); -- Multiplier:result -> Round:datain
	signal round_dataout_wire                 : std_logic_vector(11 downto 0); -- Round:dataout -> Bus_Conversion3:input
	signal sca_output_wire                    : std_logic_vector(19 downto 0); -- SCA:output -> Multiplier:datab
	signal bus_conversion4_output_wire        : std_logic_vector(9 downto 0);  -- Bus_Conversion4:output -> wot_0:input
	signal bus_conversion1_output_wire        : std_logic_vector(11 downto 0); -- Bus_Conversion1:output -> wot_12b_0:input
	signal bus_conversion3_output_wire        : std_logic_vector(10 downto 0); -- Bus_Conversion3:output -> [cast13:input, cast14:input]
	signal cast13_output_wire                 : std_logic_vector(11 downto 0); -- cast13:output -> Bus_Conversion1:input
	signal cast14_output_wire                 : std_logic_vector(10 downto 0); -- cast14:output -> Bus_Conversion4:input
	signal clock_0_clock_output_clk           : std_logic;                     -- Clock_0:clock_out -> [Multiplier:clock, Round:clk]
	signal clock_0_clock_output_reset         : std_logic;                     -- Clock_0:aclr_out -> [Multiplier:aclr, Round:reset]

begin

	clock_0 : component alt_dspbuilder_clock_GNQFU4PUDH
		port map (
			clock_out => clock_0_clock_output_clk,   -- clock_output.clk
			aclr_out  => clock_0_clock_output_reset, --             .reset
			clock     => Clock,                      --        clock.clk
			aclr      => aclr                        --             .reset
		);

	bus_conversion4 : component alt_dspbuilder_cast_GNM546SEVW
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast14_output_wire,          --  input.wire
			output => bus_conversion4_output_wire  -- output.wire
		);

	sca : component alt_dspbuilder_constant_GNRGQV2EVX
		generic map (
			BitPattern => "01001111100100111101",
			HDLTYPE    => "STD_LOGIC_VECTOR",
			width      => 20
		)
		port map (
			output => sca_output_wire  -- output.wire
		);

	wot_12b_0 : component alt_dspbuilder_port_GN4K6H3QBP
		port map (
			input  => bus_conversion1_output_wire, --  input.wire
			output => wot_12b                      -- output.wire
		);

	bus_conversion3 : component alt_dspbuilder_cast_GN7TCXHQBM
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => round_dataout_wire,          --  input.wire
			output => bus_conversion3_output_wire  -- output.wire
		);

	bus_conversion1 : component alt_dspbuilder_cast_GNDS5WH6UV
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => cast13_output_wire,          --  input.wire
			output => bus_conversion1_output_wire  -- output.wire
		);

	multiplier : component alt_dspbuilder_multiplier_GNBBBKCF23
		generic map (
			aWidth                         => 22,
			Signed                         => 1,
			bWidth                         => 20,
			DEDICATED_MULTIPLIER_CIRCUITRY => "NO",
			pipeline                       => 1,
			OutputLsb                      => 23,
			OutputMsb                      => 38
		)
		port map (
			clock     => clock_0_clock_output_clk,           -- clock_aclr.clk
			aclr      => clock_0_clock_output_reset,         --           .reset
			dataa     => wt_0_output_wire,                   --      dataa.wire
			datab     => sca_output_wire,                    --      datab.wire
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

	round : component alt_dspbuilder_round_GNX5HX7SL2
		generic map (
			OUT_WIDTH_g     => 12,
			IN_WIDTH_g      => 16,
			PIPELINE_g      => 0,
			ROUNDING_TYPE_g => "TRUNCATE_LOW",
			SIGNED_g        => 1
		)
		port map (
			clk       => clock_0_clock_output_clk,      -- clk_reset.clk
			reset     => clock_0_clock_output_reset,    --          .reset
			datain    => multiplier_result_wire,        --    datain.wire
			dataout   => round_dataout_wire,            --   dataout.wire
			ena       => roundenavcc_output_wire,       --       ena.wire
			user_aclr => rounduser_aclrgnd_output_wire  -- user_aclr.wire
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

	wt_0 : component alt_dspbuilder_port_GNBVD2CPQ4
		port map (
			input  => wt,               --  input.wire
			output => wt_0_output_wire  -- output.wire
		);

	wot_0 : component alt_dspbuilder_port_GNSSYS4J5R
		port map (
			input  => bus_conversion4_output_wire, --  input.wire
			output => wot                          -- output.wire
		);

	cast13 : component alt_dspbuilder_cast_GN4PSCVLKB
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => bus_conversion3_output_wire, --  input.wire
			output => cast13_output_wire           -- output.wire
		);

	cast14 : component alt_dspbuilder_cast_GNNVOEACLJ
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => bus_conversion3_output_wire, --  input.wire
			output => cast14_output_wire           -- output.wire
		);

end architecture rtl; -- of PLL_3orden_change_GN_PLL_3orden_change_PLL_Wt_to_alphao1
