library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_constant_GNQGHOKVPB is
	generic		( 			BitPattern : string := "01011110010000";
			HDLTYPE : string := "STD_LOGIC_VECTOR";
			width : natural := 14);

	port(
		output : out std_logic_vector(13 downto 0));		
end entity;

architecture rtl of alt_dspbuilder_constant_GNQGHOKVPB is 
Begin
-- Constant
output		<=	"01011110010000";				
end architecture;