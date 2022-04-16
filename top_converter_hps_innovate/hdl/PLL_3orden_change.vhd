-- This file is not intended for synthesis, is is present so that simulators
-- see a complete view of the system.

-- You may use the entity declaration from this file as the basis for a
-- component declaration in a VHDL file instantiating this entity.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity PLL_3orden_change is
	port (
		Clock : in std_logic;
		Va_12b : out std_logic_vector(12-1 downto 0);
		Vb_12b : out std_logic_vector(12-1 downto 0);
		Vin_12b : out std_logic_vector(12-1 downto 0);
		Vm_12b : out std_logic_vector(12-1 downto 0);
		aclr : in std_logic;
		clk60KPLL : in std_logic;
		vin : in std_logic_vector(12-1 downto 0);
		wot : out std_logic_vector(10-1 downto 0)
	);
end entity PLL_3orden_change;

architecture rtl of PLL_3orden_change is

component PLL_3orden_change_GN is
	port (
		Clock : in std_logic;
		PLL_3orden_change_PLL_Va_12b : out std_logic_vector(12-1 downto 0);
		PLL_3orden_change_PLL_Vb_12b : out std_logic_vector(12-1 downto 0);
		PLL_3orden_change_PLL_Vin_12b : out std_logic_vector(12-1 downto 0);
		PLL_3orden_change_PLL_Vm_12b : out std_logic_vector(12-1 downto 0);
		aclr : in std_logic;
		clk60KPLL : in std_logic;
		vin : in std_logic_vector(12-1 downto 0);
		wot : out std_logic_vector(10-1 downto 0)
	);
end component PLL_3orden_change_GN;

begin

PLL_3orden_change_GN_0: if true generate
	inst_PLL_3orden_change_GN_0: PLL_3orden_change_GN
		port map(Clock => Clock, PLL_3orden_change_PLL_Va_12b => Va_12b, PLL_3orden_change_PLL_Vb_12b => Vb_12b, PLL_3orden_change_PLL_Vin_12b => Vin_12b, PLL_3orden_change_PLL_Vm_12b => Vm_12b, aclr => aclr, clk60KPLL => clk60KPLL, vin => vin, wot => wot);
end generate;

end architecture rtl;

