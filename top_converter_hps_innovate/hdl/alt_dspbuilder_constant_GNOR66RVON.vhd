library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_constant_GNOR66RVON is
	generic		( 			BitPattern : string := "00000000000000000100010111101000";
			HDLTYPE : string := "STD_LOGIC_VECTOR";
			width : natural := 32);

	port(
		output : out std_logic_vector(31 downto 0));		
end entity;

architecture rtl of alt_dspbuilder_constant_GNOR66RVON is 
Begin
-- Constant
output		<=	"00000000000000000100010111101000";				
end architecture;