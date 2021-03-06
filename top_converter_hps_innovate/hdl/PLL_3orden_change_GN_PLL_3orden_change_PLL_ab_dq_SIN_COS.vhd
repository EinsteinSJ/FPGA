-- PLL_3orden_change_GN_PLL_3orden_change_PLL_ab_dq_SIN_COS.vhd

-- Generated using ACDS version 17.1 590

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PLL_3orden_change_GN_PLL_3orden_change_PLL_ab_dq_SIN_COS is
	port (
		alpha_o : in  std_logic_vector(9 downto 0)  := (others => '0'); -- alpha_o.wire
		Clock   : in  std_logic                     := '0';             --   Clock.clk
		aclr    : in  std_logic                     := '0';             --        .reset
		SIN1    : out std_logic_vector(13 downto 0);                    --    SIN1.wire
		COS1    : out std_logic_vector(13 downto 0)                     --    COS1.wire
	);
end entity PLL_3orden_change_GN_PLL_3orden_change_PLL_ab_dq_SIN_COS;

architecture rtl of PLL_3orden_change_GN_PLL_3orden_change_PLL_ab_dq_SIN_COS is
	component alt_dspbuilder_clock_GNQFU4PUDH is
		port (
			aclr      : in  std_logic := 'X'; -- reset
			aclr_n    : in  std_logic := 'X'; -- reset_n
			aclr_out  : out std_logic;        -- reset
			clock     : in  std_logic := 'X'; -- clk
			clock_out : out std_logic         -- clk
		);
	end component alt_dspbuilder_clock_GNQFU4PUDH;

	component alt_dspbuilder_port_GNBOOX3JQY is
		port (
			input  : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNBOOX3JQY;

	component alt_dspbuilder_rom_GNS4G2BRKR is
		generic (
			ClockPhase                : string   := "1";
			numwords                  : positive := 3;
			use_ena                   : natural  := 0;
			XFILE                     : string   := "input.hex";
			family                    : string   := "STRATIX";
			runtime_mod_instance_name : string   := "AAAA";
			register_outputs          : natural  := 1;
			data_width                : positive := 8;
			supportROM                : natural  := 1;
			ram_block_type            : string   := "AUTO";
			enable_runtime_mod        : natural  := 0;
			initialization            : string   := "From HEX file"
		);
		port (
			clock : in  std_logic                     := 'X';             -- clk
			aclr  : in  std_logic                     := 'X';             -- reset
			addr  : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- wire
			ena   : in  std_logic                     := 'X';             -- wire
			q     : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_rom_GNS4G2BRKR;

	component alt_dspbuilder_vcc_GN is
		port (
			output : out std_logic   -- wire
		);
	end component alt_dspbuilder_vcc_GN;

	component alt_dspbuilder_rom_GNXV4IIFCR is
		generic (
			ClockPhase                : string   := "1";
			numwords                  : positive := 3;
			use_ena                   : natural  := 0;
			XFILE                     : string   := "input.hex";
			family                    : string   := "STRATIX";
			runtime_mod_instance_name : string   := "AAAA";
			register_outputs          : natural  := 1;
			data_width                : positive := 8;
			supportROM                : natural  := 1;
			ram_block_type            : string   := "AUTO";
			enable_runtime_mod        : natural  := 0;
			initialization            : string   := "From HEX file"
		);
		port (
			clock : in  std_logic                     := 'X';             -- clk
			aclr  : in  std_logic                     := 'X';             -- reset
			addr  : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- wire
			ena   : in  std_logic                     := 'X';             -- wire
			q     : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_rom_GNXV4IIFCR;

	component alt_dspbuilder_port_GNSSYS4J5R is
		port (
			input  : in  std_logic_vector(9 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(9 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNSSYS4J5R;

	signal cosenavcc_output_wire      : std_logic;                     -- COSenaVCC:output -> COS:ena
	signal sinenavcc_output_wire      : std_logic;                     -- SINenaVCC:output -> SIN:ena
	signal alpha_o_0_output_wire      : std_logic_vector(9 downto 0);  -- alpha_o_0:output -> [COS:addr, SIN:addr]
	signal sin_q_wire                 : std_logic_vector(13 downto 0); -- SIN:q -> SIN1_0:input
	signal cos_q_wire                 : std_logic_vector(13 downto 0); -- COS:q -> COS1_0:input
	signal clock_0_clock_output_clk   : std_logic;                     -- Clock_0:clock_out -> [COS:clock, SIN:clock]
	signal clock_0_clock_output_reset : std_logic;                     -- Clock_0:aclr_out -> [COS:aclr, SIN:aclr]

begin

	clock_0 : component alt_dspbuilder_clock_GNQFU4PUDH
		port map (
			clock_out => clock_0_clock_output_clk,   -- clock_output.clk
			aclr_out  => clock_0_clock_output_reset, --             .reset
			clock     => Clock,                      --        clock.clk
			aclr      => aclr                        --             .reset
		);

	cos1_0 : component alt_dspbuilder_port_GNBOOX3JQY
		port map (
			input  => cos_q_wire, --  input.wire
			output => COS1        -- output.wire
		);

	cos : component alt_dspbuilder_rom_GNS4G2BRKR
		generic map (
			ClockPhase                => "1",
			numwords                  => 1000,
			use_ena                   => 0,
			XFILE                     => "input.hex",
			family                    => "Cyclone IV E",
			runtime_mod_instance_name => "AAAA",
			register_outputs          => 0,
			data_width                => 14,
			supportROM                => 1,
			ram_block_type            => "AUTO",
			enable_runtime_mod        => 0,
			initialization            => "From MATLAB array"
		)
		port map (
			clock => clock_0_clock_output_clk,   -- clock_aclr.clk
			aclr  => clock_0_clock_output_reset, --           .reset
			addr  => alpha_o_0_output_wire,      --       addr.wire
			ena   => cosenavcc_output_wire,      --        ena.wire
			q     => cos_q_wire                  --          q.wire
		);

	cosenavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => cosenavcc_output_wire  -- output.wire
		);

	sin : component alt_dspbuilder_rom_GNXV4IIFCR
		generic map (
			ClockPhase                => "1",
			numwords                  => 1000,
			use_ena                   => 0,
			XFILE                     => "input.hex",
			family                    => "Cyclone IV E",
			runtime_mod_instance_name => "AAAA",
			register_outputs          => 0,
			data_width                => 14,
			supportROM                => 1,
			ram_block_type            => "AUTO",
			enable_runtime_mod        => 0,
			initialization            => "From MATLAB array"
		)
		port map (
			clock => clock_0_clock_output_clk,   -- clock_aclr.clk
			aclr  => clock_0_clock_output_reset, --           .reset
			addr  => alpha_o_0_output_wire,      --       addr.wire
			ena   => sinenavcc_output_wire,      --        ena.wire
			q     => sin_q_wire                  --          q.wire
		);

	sinenavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => sinenavcc_output_wire  -- output.wire
		);

	alpha_o_0 : component alt_dspbuilder_port_GNSSYS4J5R
		port map (
			input  => alpha_o,               --  input.wire
			output => alpha_o_0_output_wire  -- output.wire
		);

	sin1_0 : component alt_dspbuilder_port_GNBOOX3JQY
		port map (
			input  => sin_q_wire, --  input.wire
			output => SIN1        -- output.wire
		);

end architecture rtl; -- of PLL_3orden_change_GN_PLL_3orden_change_PLL_ab_dq_SIN_COS
