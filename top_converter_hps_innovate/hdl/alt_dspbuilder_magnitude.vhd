-- This file is not intended for synthesis, is is present so that simulators
-- see a complete view of the system.

-- You may use the entity declaration from this file as the basis for a
-- component declaration in a VHDL file instantiating this entity.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity alt_dspbuilder_magnitude is
	generic (
		WIDTH : natural := 1
	);
	port (
		result : out std_logic_vector(width+1-1 downto 0);
		data : in std_logic_vector(width-1 downto 0)
	);
end entity alt_dspbuilder_magnitude;

architecture rtl of alt_dspbuilder_magnitude is

component alt_dspbuilder_magnitude_GNKKUBJJBI is
	generic (
		WIDTH : natural := 14
	);
	port (
		data : in std_logic_vector(14-1 downto 0);
		result : out std_logic_vector(15-1 downto 0)
	);
end component alt_dspbuilder_magnitude_GNKKUBJJBI;

begin

alt_dspbuilder_magnitude_GNKKUBJJBI_0: if ((WIDTH = 14)) generate
	inst_alt_dspbuilder_magnitude_GNKKUBJJBI_0: alt_dspbuilder_magnitude_GNKKUBJJBI
		generic map(WIDTH => 14)
		port map(data => data, result => result);
end generate;

assert not (((WIDTH = 14)))
	report "Please run generate again" severity error;

end architecture rtl;

