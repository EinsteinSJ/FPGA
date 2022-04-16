library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_constant_GND3QGQB6V is
	generic		( 			BitPattern : string := "000010101010101011";
			HDLTYPE : string := "STD_LOGIC_VECTOR";
			width : natural := 18);

	port(
		output : out std_logic_vector(17 downto 0));		
end entity;

architecture rtl of alt_dspbuilder_constant_GND3QGQB6V is 
Begin
-- Constant
output		<=	"000010101010101011";				
end architecture;