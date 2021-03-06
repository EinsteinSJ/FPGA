-- PLL_3orden_change_GN_PLL_3orden_change_PLL.vhd

-- Generated using ACDS version 17.1 590

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PLL_3orden_change_GN_PLL_3orden_change_PLL is
	port (
		Vd      : out std_logic_vector(13 downto 0);                    --      Vd.wire
		Va_12b  : out std_logic_vector(11 downto 0);                    --  Va_12b.wire
		Vb_12b  : out std_logic_vector(11 downto 0);                    --  Vb_12b.wire
		vit     : in  std_logic_vector(11 downto 0) := (others => '0'); --     vit.wire
		Vin_12b : out std_logic_vector(11 downto 0);                    -- Vin_12b.wire
		wot     : out std_logic_vector(9 downto 0);                     --     wot.wire
		Vm_9b   : out std_logic_vector(8 downto 0);                     --   Vm_9b.wire
		Clock   : in  std_logic                     := '0';             --   Clock.clk
		aclr    : in  std_logic                     := '0';             --        .reset
		clk_60K : in  std_logic                     := '0';             -- clk_60K.wire
		Vm_12b  : out std_logic_vector(11 downto 0)                     --  Vm_12b.wire
	);
end entity PLL_3orden_change_GN_PLL_3orden_change_PLL;

architecture rtl of PLL_3orden_change_GN_PLL_3orden_change_PLL is
	component alt_dspbuilder_clock_GNQFU4PUDH is
		port (
			aclr      : in  std_logic := 'X'; -- reset
			aclr_n    : in  std_logic := 'X'; -- reset_n
			aclr_out  : out std_logic;        -- reset
			clock     : in  std_logic := 'X'; -- clk
			clock_out : out std_logic         -- clk
		);
	end component alt_dspbuilder_clock_GNQFU4PUDH;

	component PLL_3orden_change_GN_PLL_3orden_change_PLL_PI_z is
		port (
			Clock     : in  std_logic                     := 'X';             -- clk
			aclr      : in  std_logic                     := 'X';             -- reset
			Vd        : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			Wo_ref    : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			wo        : out std_logic_vector(17 downto 0);                    -- wire
			Ts        : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			CLK_60KHz : in  std_logic                     := 'X'              -- wire
		);
	end component PLL_3orden_change_GN_PLL_3orden_change_PLL_PI_z;

	component PLL_3orden_change_GN_PLL_3orden_change_PLL_Wt_to_alphao1 is
		port (
			wt      : in  std_logic_vector(21 downto 0) := (others => 'X'); -- wire
			wot     : out std_logic_vector(9 downto 0);                     -- wire
			Clock   : in  std_logic                     := 'X';             -- clk
			aclr    : in  std_logic                     := 'X';             -- reset
			wot_12b : out std_logic_vector(11 downto 0)                     -- wire
		);
	end component PLL_3orden_change_GN_PLL_3orden_change_PLL_Wt_to_alphao1;

	component alt_dspbuilder_magnitude_GNKKUBJJBI is
		generic (
			width : natural := 1
		);
		port (
			data   : in  std_logic_vector(width-1 downto 0)   := (others => 'X'); -- wire
			result : out std_logic_vector(width+1-1 downto 0)                     -- wire
		);
	end component alt_dspbuilder_magnitude_GNKKUBJJBI;

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

	component alt_dspbuilder_port_GN4K6H3QBP is
		port (
			input  : in  std_logic_vector(11 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(11 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GN4K6H3QBP;

	component alt_dspbuilder_port_GNSSYS4J5R is
		port (
			input  : in  std_logic_vector(9 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(9 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNSSYS4J5R;

	component alt_dspbuilder_constant_GNOR66RVON is
		generic (
			BitPattern : string  := "0000";
			HDLTYPE    : string  := "STD_LOGIC_VECTOR";
			width      : natural := 4
		);
		port (
			output : out std_logic_vector(31 downto 0)   -- wire
		);
	end component alt_dspbuilder_constant_GNOR66RVON;

	component alt_dspbuilder_port_GNJVFJM3AT is
		port (
			input  : in  std_logic_vector(8 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(8 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNJVFJM3AT;

	component PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals is
		port (
			Clock : in  std_logic                     := 'X';             -- clk
			aclr  : in  std_logic                     := 'X';             -- reset
			Vm    : in  std_logic_vector(14 downto 0) := (others => 'X'); -- wire
			Vb    : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			Vin   : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			Vb_2  : out std_logic_vector(21 downto 0);                    -- wire
			Vin_2 : out std_logic_vector(21 downto 0);                    -- wire
			Va_2  : out std_logic_vector(21 downto 0);                    -- wire
			Va    : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			Vm_2  : out std_logic_vector(21 downto 0)                     -- wire
		);
	end component PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals;

	component PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals1 is
		port (
			Va      : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			Va_12b  : out std_logic_vector(11 downto 0);                    -- wire
			Vm      : in  std_logic_vector(14 downto 0) := (others => 'X'); -- wire
			Vb      : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			Vm_12b  : out std_logic_vector(11 downto 0);                    -- wire
			Vin     : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			Clock   : in  std_logic                     := 'X';             -- clk
			aclr    : in  std_logic                     := 'X';             -- reset
			Vin_12b : out std_logic_vector(11 downto 0);                    -- wire
			Vb_12b  : out std_logic_vector(11 downto 0)                     -- wire
		);
	end component PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals1;

	component PLL_3orden_change_GN_PLL_3orden_change_PLL_1erCon is
		port (
			Clock      : in  std_logic                     := 'X';             -- clk
			aclr       : in  std_logic                     := 'X';             -- reset
			id_14sfVin : out std_logic_vector(13 downto 0);                    -- wire
			Vin12b     : out std_logic_vector(11 downto 0);                    -- wire
			Vr         : in  std_logic_vector(11 downto 0) := (others => 'X')  -- wire
		);
	end component PLL_3orden_change_GN_PLL_3orden_change_PLL_1erCon;

	component PLL_3orden_change_GN_PLL_3orden_change_PLL_Vm_Num is
		port (
			Vmi   : in  std_logic_vector(14 downto 0) := (others => 'X'); -- wire
			Clock : in  std_logic                     := 'X';             -- clk
			aclr  : in  std_logic                     := 'X';             -- reset
			Vmo   : out std_logic_vector(8 downto 0)                      -- wire
		);
	end component PLL_3orden_change_GN_PLL_3orden_change_PLL_Vm_Num;

	component PLL_3orden_change_GN_PLL_3orden_change_PLL_ab_dq is
		port (
			a       : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			alpha_o : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- wire
			b       : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			Vd      : out std_logic_vector(13 downto 0);                    -- wire
			Clock   : in  std_logic                     := 'X';             -- clk
			aclr    : in  std_logic                     := 'X';             -- reset
			Vq      : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component PLL_3orden_change_GN_PLL_3orden_change_PLL_ab_dq;

	component PLL_3orden_change_GN_PLL_3orden_change_PLL_IntegradorW is
		port (
			w       : in  std_logic_vector(17 downto 0) := (others => 'X'); -- wire
			Clock   : in  std_logic                     := 'X';             -- clk
			aclr    : in  std_logic                     := 'X';             -- reset
			CLK_60K : in  std_logic                     := 'X';             -- wire
			Ts      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- wire
			wot     : out std_logic_vector(21 downto 0)                     -- wire
		);
	end component PLL_3orden_change_GN_PLL_3orden_change_PLL_IntegradorW;

	component alt_dspbuilder_constant_GNQGHOKVPB is
		generic (
			BitPattern : string  := "0000";
			HDLTYPE    : string  := "STD_LOGIC_VECTOR";
			width      : natural := 4
		);
		port (
			output : out std_logic_vector(13 downto 0)   -- wire
		);
	end component alt_dspbuilder_constant_GNQGHOKVPB;

	component PLL_3orden_change_GN_PLL_3orden_change_PLL_SOGI is
		port (
			Va      : out std_logic_vector(13 downto 0);                    -- wire
			wo      : in  std_logic_vector(17 downto 0) := (others => 'X'); -- wire
			Vin     : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			Vb      : out std_logic_vector(13 downto 0);                    -- wire
			Clk_60K : in  std_logic                     := 'X';             -- wire
			Clock   : in  std_logic                     := 'X';             -- clk
			aclr    : in  std_logic                     := 'X';             -- reset
			Ts      : in  std_logic_vector(31 downto 0) := (others => 'X')  -- wire
		);
	end component PLL_3orden_change_GN_PLL_3orden_change_PLL_SOGI;

	component alt_dspbuilder_cast_GNTJ4YWTXH is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(11 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(11 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNTJ4YWTXH;

	signal vit_0_output_wire                              : std_logic_vector(11 downto 0); -- vit_0:output -> PLL_3orden_change_PLL_1erCon_0:Vr
	signal clk_60k_0_output_wire                          : std_logic;                     -- clk_60K_0:output -> [PLL_3orden_change_PLL_IntegradorW_0:CLK_60K, PLL_3orden_change_PLL_PI_z_0:CLK_60KHz, PLL_3orden_change_PLL_SOGI_0:Clk_60K]
	signal pll_3orden_change_pll_pi_z_0_wo_wire           : std_logic_vector(17 downto 0); -- PLL_3orden_change_PLL_PI_z_0:wo -> [PLL_3orden_change_PLL_IntegradorW_0:w, PLL_3orden_change_PLL_SOGI_0:wo]
	signal pll_3orden_change_pll_1ercon_0_id_14sfvin_wire : std_logic_vector(13 downto 0); -- PLL_3orden_change_PLL_1erCon_0:id_14sfVin -> [PLL_3orden_change_PLL_SOGI_0:Vin, PLL_3orden_change_PLL_Signals1_0:Vin, PLL_3orden_change_PLL_Signals_0:Vin]
	signal pll_3orden_change_pll_sogi_0_va_wire           : std_logic_vector(13 downto 0); -- PLL_3orden_change_PLL_SOGI_0:Va -> [PLL_3orden_change_PLL_Signals1_0:Va, PLL_3orden_change_PLL_Signals_0:Va, PLL_3orden_change_PLL_ab_dq_0:a]
	signal pll_3orden_change_pll_sogi_0_vb_wire           : std_logic_vector(13 downto 0); -- PLL_3orden_change_PLL_SOGI_0:Vb -> [PLL_3orden_change_PLL_Signals1_0:Vb, PLL_3orden_change_PLL_Signals_0:Vb, PLL_3orden_change_PLL_ab_dq_0:b]
	signal magnitude_result_wire                          : std_logic_vector(14 downto 0); -- Magnitude:result -> [PLL_3orden_change_PLL_Signals1_0:Vm, PLL_3orden_change_PLL_Signals_0:Vm, PLL_3orden_change_PLL_Vm_Num_0:Vmi]
	signal ts_output_wire                                 : std_logic_vector(31 downto 0); -- Ts:output -> [PLL_3orden_change_PLL_IntegradorW_0:Ts, PLL_3orden_change_PLL_PI_z_0:Ts, PLL_3orden_change_PLL_SOGI_0:Ts]
	signal pll_3orden_change_pll_signals1_0_vin_12b_wire  : std_logic_vector(11 downto 0); -- PLL_3orden_change_PLL_Signals1_0:Vin_12b -> Vin_12b_0:input
	signal pll_3orden_change_pll_integradorw_0_wot_wire   : std_logic_vector(21 downto 0); -- PLL_3orden_change_PLL_IntegradorW_0:wot -> PLL_3orden_change_PLL_Wt_to_alphao1_0:wt
	signal pll_3orden_change_pll_wt_to_alphao1_0_wot_wire : std_logic_vector(9 downto 0);  -- PLL_3orden_change_PLL_Wt_to_alphao1_0:wot -> [PLL_3orden_change_PLL_ab_dq_0:alpha_o, wot_0:input]
	signal pll_3orden_change_pll_ab_dq_0_vd_wire          : std_logic_vector(13 downto 0); -- PLL_3orden_change_PLL_ab_dq_0:Vd -> [PLL_3orden_change_PLL_PI_z_0:Vd, Vd_0:input]
	signal pll_3orden_change_pll_ab_dq_0_vq_wire          : std_logic_vector(13 downto 0); -- PLL_3orden_change_PLL_ab_dq_0:Vq -> Magnitude:data
	signal wo_ref_output_wire                             : std_logic_vector(13 downto 0); -- wo_ref:output -> PLL_3orden_change_PLL_PI_z_0:Wo_ref
	signal pll_3orden_change_pll_vm_num_0_vmo_wire        : std_logic_vector(8 downto 0);  -- PLL_3orden_change_PLL_Vm_Num_0:Vmo -> Vm_9b_0:input
	signal pll_3orden_change_pll_signals1_0_va_12b_wire   : std_logic_vector(11 downto 0); -- PLL_3orden_change_PLL_Signals1_0:Va_12b -> cast60:input
	signal cast60_output_wire                             : std_logic_vector(11 downto 0); -- cast60:output -> Va_12b_0:input
	signal pll_3orden_change_pll_signals1_0_vb_12b_wire   : std_logic_vector(11 downto 0); -- PLL_3orden_change_PLL_Signals1_0:Vb_12b -> cast61:input
	signal cast61_output_wire                             : std_logic_vector(11 downto 0); -- cast61:output -> Vb_12b_0:input
	signal pll_3orden_change_pll_signals1_0_vm_12b_wire   : std_logic_vector(11 downto 0); -- PLL_3orden_change_PLL_Signals1_0:Vm_12b -> cast62:input
	signal cast62_output_wire                             : std_logic_vector(11 downto 0); -- cast62:output -> Vm_12b_0:input
	signal clock_0_clock_output_clk                       : std_logic;                     -- Clock_0:clock_out -> [PLL_3orden_change_PLL_1erCon_0:Clock, PLL_3orden_change_PLL_IntegradorW_0:Clock, PLL_3orden_change_PLL_PI_z_0:Clock, PLL_3orden_change_PLL_SOGI_0:Clock, PLL_3orden_change_PLL_Signals1_0:Clock, PLL_3orden_change_PLL_Signals_0:Clock, PLL_3orden_change_PLL_Vm_Num_0:Clock, PLL_3orden_change_PLL_Wt_to_alphao1_0:Clock, PLL_3orden_change_PLL_ab_dq_0:Clock]
	signal clock_0_clock_output_reset                     : std_logic;                     -- Clock_0:aclr_out -> [PLL_3orden_change_PLL_1erCon_0:aclr, PLL_3orden_change_PLL_IntegradorW_0:aclr, PLL_3orden_change_PLL_PI_z_0:aclr, PLL_3orden_change_PLL_SOGI_0:aclr, PLL_3orden_change_PLL_Signals1_0:aclr, PLL_3orden_change_PLL_Signals_0:aclr, PLL_3orden_change_PLL_Vm_Num_0:aclr, PLL_3orden_change_PLL_Wt_to_alphao1_0:aclr, PLL_3orden_change_PLL_ab_dq_0:aclr]

begin

	clock_0 : component alt_dspbuilder_clock_GNQFU4PUDH
		port map (
			clock_out => clock_0_clock_output_clk,   -- clock_output.clk
			aclr_out  => clock_0_clock_output_reset, --             .reset
			clock     => Clock,                      --        clock.clk
			aclr      => aclr                        --             .reset
		);

	pll_3orden_change_pll_pi_z_0 : component PLL_3orden_change_GN_PLL_3orden_change_PLL_PI_z
		port map (
			Clock     => clock_0_clock_output_clk,              --     Clock.clk
			aclr      => clock_0_clock_output_reset,            --          .reset
			Vd        => pll_3orden_change_pll_ab_dq_0_vd_wire, --        Vd.wire
			Wo_ref    => wo_ref_output_wire,                    --    Wo_ref.wire
			wo        => pll_3orden_change_pll_pi_z_0_wo_wire,  --        wo.wire
			Ts        => ts_output_wire,                        --        Ts.wire
			CLK_60KHz => clk_60k_0_output_wire                  -- CLK_60KHz.wire
		);

	pll_3orden_change_pll_wt_to_alphao1_0 : component PLL_3orden_change_GN_PLL_3orden_change_PLL_Wt_to_alphao1
		port map (
			wt      => pll_3orden_change_pll_integradorw_0_wot_wire,   --      wt.wire
			wot     => pll_3orden_change_pll_wt_to_alphao1_0_wot_wire, --     wot.wire
			Clock   => clock_0_clock_output_clk,                       --   Clock.clk
			aclr    => clock_0_clock_output_reset,                     --        .reset
			wot_12b => open                                            -- wot_12b.wire
		);

	magnitude : component alt_dspbuilder_magnitude_GNKKUBJJBI
		generic map (
			width => 14
		)
		port map (
			data   => pll_3orden_change_pll_ab_dq_0_vq_wire, --   data.wire
			result => magnitude_result_wire                  -- result.wire
		);

	vd_0 : component alt_dspbuilder_port_GNBOOX3JQY
		port map (
			input  => pll_3orden_change_pll_ab_dq_0_vd_wire, --  input.wire
			output => Vd                                     -- output.wire
		);

	clk_60k_0 : component alt_dspbuilder_port_GN37ALZBS4
		port map (
			input  => clk_60K,               --  input.wire
			output => clk_60k_0_output_wire  -- output.wire
		);

	vm_12b_0 : component alt_dspbuilder_port_GN4K6H3QBP
		port map (
			input  => cast62_output_wire, --  input.wire
			output => Vm_12b              -- output.wire
		);

	wot_0 : component alt_dspbuilder_port_GNSSYS4J5R
		port map (
			input  => pll_3orden_change_pll_wt_to_alphao1_0_wot_wire, --  input.wire
			output => wot                                             -- output.wire
		);

	ts : component alt_dspbuilder_constant_GNOR66RVON
		generic map (
			BitPattern => "00000000000000000100010111101000",
			HDLTYPE    => "STD_LOGIC_VECTOR",
			width      => 32
		)
		port map (
			output => ts_output_wire  -- output.wire
		);

	vm_9b_0 : component alt_dspbuilder_port_GNJVFJM3AT
		port map (
			input  => pll_3orden_change_pll_vm_num_0_vmo_wire, --  input.wire
			output => Vm_9b                                    -- output.wire
		);

	vit_0 : component alt_dspbuilder_port_GN4K6H3QBP
		port map (
			input  => vit,               --  input.wire
			output => vit_0_output_wire  -- output.wire
		);

	vin_12b_0 : component alt_dspbuilder_port_GN4K6H3QBP
		port map (
			input  => pll_3orden_change_pll_signals1_0_vin_12b_wire, --  input.wire
			output => Vin_12b                                        -- output.wire
		);

	pll_3orden_change_pll_signals_0 : component PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals
		port map (
			Clock => clock_0_clock_output_clk,                       -- Clock.clk
			aclr  => clock_0_clock_output_reset,                     --      .reset
			Vm    => magnitude_result_wire,                          --    Vm.wire
			Vb    => pll_3orden_change_pll_sogi_0_vb_wire,           --    Vb.wire
			Vin   => pll_3orden_change_pll_1ercon_0_id_14sfvin_wire, --   Vin.wire
			Vb_2  => open,                                           --  Vb_2.wire
			Vin_2 => open,                                           -- Vin_2.wire
			Va_2  => open,                                           --  Va_2.wire
			Va    => pll_3orden_change_pll_sogi_0_va_wire,           --    Va.wire
			Vm_2  => open                                            --  Vm_2.wire
		);

	pll_3orden_change_pll_signals1_0 : component PLL_3orden_change_GN_PLL_3orden_change_PLL_Signals1
		port map (
			Va      => pll_3orden_change_pll_sogi_0_va_wire,           --      Va.wire
			Va_12b  => pll_3orden_change_pll_signals1_0_va_12b_wire,   --  Va_12b.wire
			Vm      => magnitude_result_wire,                          --      Vm.wire
			Vb      => pll_3orden_change_pll_sogi_0_vb_wire,           --      Vb.wire
			Vm_12b  => pll_3orden_change_pll_signals1_0_vm_12b_wire,   --  Vm_12b.wire
			Vin     => pll_3orden_change_pll_1ercon_0_id_14sfvin_wire, --     Vin.wire
			Clock   => clock_0_clock_output_clk,                       --   Clock.clk
			aclr    => clock_0_clock_output_reset,                     --        .reset
			Vin_12b => pll_3orden_change_pll_signals1_0_vin_12b_wire,  -- Vin_12b.wire
			Vb_12b  => pll_3orden_change_pll_signals1_0_vb_12b_wire    --  Vb_12b.wire
		);

	pll_3orden_change_pll_1ercon_0 : component PLL_3orden_change_GN_PLL_3orden_change_PLL_1erCon
		port map (
			Clock      => clock_0_clock_output_clk,                       --      Clock.clk
			aclr       => clock_0_clock_output_reset,                     --           .reset
			id_14sfVin => pll_3orden_change_pll_1ercon_0_id_14sfvin_wire, -- id_14sfVin.wire
			Vin12b     => open,                                           --     Vin12b.wire
			Vr         => vit_0_output_wire                               --         Vr.wire
		);

	pll_3orden_change_pll_vm_num_0 : component PLL_3orden_change_GN_PLL_3orden_change_PLL_Vm_Num
		port map (
			Vmi   => magnitude_result_wire,                   --   Vmi.wire
			Clock => clock_0_clock_output_clk,                -- Clock.clk
			aclr  => clock_0_clock_output_reset,              --      .reset
			Vmo   => pll_3orden_change_pll_vm_num_0_vmo_wire  --   Vmo.wire
		);

	va_12b_0 : component alt_dspbuilder_port_GN4K6H3QBP
		port map (
			input  => cast60_output_wire, --  input.wire
			output => Va_12b              -- output.wire
		);

	pll_3orden_change_pll_ab_dq_0 : component PLL_3orden_change_GN_PLL_3orden_change_PLL_ab_dq
		port map (
			a       => pll_3orden_change_pll_sogi_0_va_wire,           --       a.wire
			alpha_o => pll_3orden_change_pll_wt_to_alphao1_0_wot_wire, -- alpha_o.wire
			b       => pll_3orden_change_pll_sogi_0_vb_wire,           --       b.wire
			Vd      => pll_3orden_change_pll_ab_dq_0_vd_wire,          --      Vd.wire
			Clock   => clock_0_clock_output_clk,                       --   Clock.clk
			aclr    => clock_0_clock_output_reset,                     --        .reset
			Vq      => pll_3orden_change_pll_ab_dq_0_vq_wire           --      Vq.wire
		);

	pll_3orden_change_pll_integradorw_0 : component PLL_3orden_change_GN_PLL_3orden_change_PLL_IntegradorW
		port map (
			w       => pll_3orden_change_pll_pi_z_0_wo_wire,         --       w.wire
			Clock   => clock_0_clock_output_clk,                     --   Clock.clk
			aclr    => clock_0_clock_output_reset,                   --        .reset
			CLK_60K => clk_60k_0_output_wire,                        -- CLK_60K.wire
			Ts      => ts_output_wire,                               --      Ts.wire
			wot     => pll_3orden_change_pll_integradorw_0_wot_wire  --     wot.wire
		);

	wo_ref : component alt_dspbuilder_constant_GNQGHOKVPB
		generic map (
			BitPattern => "01011110010000",
			HDLTYPE    => "STD_LOGIC_VECTOR",
			width      => 14
		)
		port map (
			output => wo_ref_output_wire  -- output.wire
		);

	pll_3orden_change_pll_sogi_0 : component PLL_3orden_change_GN_PLL_3orden_change_PLL_SOGI
		port map (
			Va      => pll_3orden_change_pll_sogi_0_va_wire,           --      Va.wire
			wo      => pll_3orden_change_pll_pi_z_0_wo_wire,           --      wo.wire
			Vin     => pll_3orden_change_pll_1ercon_0_id_14sfvin_wire, --     Vin.wire
			Vb      => pll_3orden_change_pll_sogi_0_vb_wire,           --      Vb.wire
			Clk_60K => clk_60k_0_output_wire,                          -- Clk_60K.wire
			Clock   => clock_0_clock_output_clk,                       --   Clock.clk
			aclr    => clock_0_clock_output_reset,                     --        .reset
			Ts      => ts_output_wire                                  --      Ts.wire
		);

	vb_12b_0 : component alt_dspbuilder_port_GN4K6H3QBP
		port map (
			input  => cast61_output_wire, --  input.wire
			output => Vb_12b              -- output.wire
		);

	cast60 : component alt_dspbuilder_cast_GNTJ4YWTXH
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => pll_3orden_change_pll_signals1_0_va_12b_wire, --  input.wire
			output => cast60_output_wire                            -- output.wire
		);

	cast61 : component alt_dspbuilder_cast_GNTJ4YWTXH
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => pll_3orden_change_pll_signals1_0_vb_12b_wire, --  input.wire
			output => cast61_output_wire                            -- output.wire
		);

	cast62 : component alt_dspbuilder_cast_GNTJ4YWTXH
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => pll_3orden_change_pll_signals1_0_vm_12b_wire, --  input.wire
			output => cast62_output_wire                            -- output.wire
		);

end architecture rtl; -- of PLL_3orden_change_GN_PLL_3orden_change_PLL
