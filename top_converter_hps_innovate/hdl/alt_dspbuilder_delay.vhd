-- This file is not intended for synthesis, is is present so that simulators
-- see a complete view of the system.

-- You may use the entity declaration from this file as the basis for a
-- component declaration in a VHDL file instantiating this entity.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity alt_dspbuilder_delay is
	generic (
		CLOCKPHASE : string := "1";
		BITPATTERN : string := "00000001";
		WIDTH : positive := 8;
		USE_INIT : natural := 0;
		DELAY : positive := 1
	);
	port (
		output : out std_logic_vector(width-1 downto 0);
		input : in std_logic_vector(width-1 downto 0);
		sclr : in std_logic;
		aclr : in std_logic;
		ena : in std_logic;
		clock : in std_logic
	);
end entity alt_dspbuilder_delay;

architecture rtl of alt_dspbuilder_delay is

component alt_dspbuilder_delay_GNKZDMBKQG is
	generic (
		CLOCKPHASE : string := "1";
		BITPATTERN : string := "01000000000000000000000000000000";
		WIDTH : positive := 32;
		USE_INIT : natural := 0;
		DELAY : positive := 1
	);
	port (
		aclr : in std_logic;
		clock : in std_logic;
		ena : in std_logic;
		input : in std_logic_vector(32-1 downto 0);
		output : out std_logic_vector(32-1 downto 0);
		sclr : in std_logic
	);
end component alt_dspbuilder_delay_GNKZDMBKQG;

begin

alt_dspbuilder_delay_GNKZDMBKQG_0: if ((CLOCKPHASE = "1") and (BITPATTERN = "01000000000000000000000000000000") and (WIDTH = 32) and (USE_INIT = 0) and (DELAY = 1)) generate
	inst_alt_dspbuilder_delay_GNKZDMBKQG_0: alt_dspbuilder_delay_GNKZDMBKQG
		generic map(CLOCKPHASE => "1", BITPATTERN => "01000000000000000000000000000000", WIDTH => 32, USE_INIT => 0, DELAY => 1)
		port map(aclr => aclr, clock => clock, ena => ena, input => input, output => output, sclr => sclr);
end generate;

assert not (((CLOCKPHASE = "1") and (BITPATTERN = "01000000000000000000000000000000") and (WIDTH = 32) and (USE_INIT = 0) and (DELAY = 1)))
	report "Please run generate again" severity error;

end architecture rtl;

