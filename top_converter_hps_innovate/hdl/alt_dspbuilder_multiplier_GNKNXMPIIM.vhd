library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_multiplier_GNKNXMPIIM is
	generic		( 			aWidth : natural := 18;
			Signed : natural := 1;
			bWidth : natural := 18;
			DEDICATED_MULTIPLIER_CIRCUITRY : string := "YES";
			pipeline : integer := 1;
			OutputLsb : integer := 1;
			OutputMsb : integer := 31);

	port(
		aclr : in std_logic;
		clock : in std_logic;
		dataa : in std_logic_vector((aWidth)-1 downto 0);
		datab : in std_logic_vector((bWidth)-1 downto 0);
		ena : in std_logic;
		result : out std_logic_vector((OutputMsb-OutputLsb+1)-1 downto 0);
		user_aclr : in std_logic);		
end entity;

architecture rtl of alt_dspbuilder_multiplier_GNKNXMPIIM is 

signal reset: STD_LOGIC;

Begin

-- DSP Builder Block - Simulink Block "Multiplier"
Multiplieri : alt_dspbuilder_sMultAltr  Generic map (
				pipeline	=>	1,
				lpm_representation	=>	"SIGNED",
				OutputMsb	=>	31,
				OutputLsb	=>	1,
				lpm_widtha	=>	18,
				lpm_widthb	=>	18,
				lpm_hint	=>	"DEDICATED_MULTIPLIER_CIRCUITRY=YES")
		port map (
				clock		=>	clock,
				aclr		=>	aclr,
				user_aclr	=>	user_aclr,
				ena			=>	ena,
				dataa		=>	dataa,
				datab		=>	datab,
				result		=>	result);

end architecture;		
