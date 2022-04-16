library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_magnitude_GNKKUBJJBI is
	generic		( 			width : natural := 14);

	port(
		data : in std_logic_vector((width)-1 downto 0);
		result : out std_logic_vector((width+1)-1 downto 0));		
end entity;

architecture rtl of alt_dspbuilder_magnitude_GNKKUBJJBI is 

	signal abs_result : std_logic_vector(width-1 downto 0);

Begin

	-- Absolute Value Operator - Simulink Block "Mag"
	Magi : LPM_ABS generic map (LPM_WIDTH	=>	width )
			port map (	data => data,
						result => abs_result,		
						overflow => result(width -1));

	-- the lpm result can overflow, DSPBuilder
	-- result is 1 larger to accomodate
	result(width) <= '0';
	result(width-2 downto 0) <= abs_result(width-2 downto 0);
end architecture;		
