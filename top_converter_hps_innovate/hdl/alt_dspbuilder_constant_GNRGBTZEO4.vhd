library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_constant_GNRGBTZEO4 is
	generic		( 			BitPattern : string := "00011001001000011111101101010100";
			HDLTYPE : string := "STD_LOGIC_VECTOR";
			width : natural := 32);

	port(
		output : out std_logic_vector(31 downto 0));		
end entity;

architecture rtl of alt_dspbuilder_constant_GNRGBTZEO4 is 
Begin
-- Constant
output		<=	"00011001001000011111101101010100";				
end architecture;