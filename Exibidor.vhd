library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Exibidor is
	port(
	clock, config, estado: in std_logic;
	modo: in std_logic_vector(1 downto 0);
	hora_dez_in, hora_unid_in, min_dez_in, min_unid_in, seg_dez_in, seg_unid_in, dezs_dez_in, dezs_unid_in : in std_logic_vector(6 downto 0);
   hora_dez_out, hora_unid_out, min_dez_out, min_unid_out, seg_dez_out, seg_unid_out, dezs_dez_out, dezs_unid_out : out std_logic_vector(6 downto 0));
end entity;
	
architecture Exibidor of Exibidor is
	signal count: integer :=0;
begin	

process(dezs_unid_in, dezs_dez_in, seg_unid_in, seg_unid_in, min_unid_in, min_dez_in, hora_unid_in, hora_dez_in)
begin
	if(dezs_unid_in = "0000") then
		dezs_unid_out <= "1000000";
	elsif (dezs_unid_in = "0001") then
		dezs_unid_out <= "1111001";
	elsif (dezs_unid_in= "0010") then
		dezs_unid_out <= "0100100";
	elsif (dezs_unid_in= "0011") then
		dezs_unid_out <= "0110000";
	elsif (dezs_unid_in= "0100") then
		dezs_unid_out <= "0011001";
	elsif (dezs_unid_in= "0101") then
		dezs_unid_out <= "0010010";
	elsif (dezs_unid_in= "0110") then
		dezs_unid_out <= "0000010";
	elsif (dezs_unid_in= "0111") then
		dezs_unid_out <= "1111000";
	elsif (dezs_unid_in= "1000") then
		dezs_unid_out <= "0000000";
	elsif (dezs_unid_in= "1001") then
		dezs_unid_out <= "0010000";
	end if;
	
	if (dezs_dez_in = "0000") then
		dezs_dez_out <= "1000000";
	elsif (dezs_dez_in = "0001") then
		dezs_dez_out <= "1111001";
	elsif (dezs_dez_in= "0010") then
		dezs_dez_out <= "0100100";
	elsif (dezs_dez_in= "0011") then
		dezs_dez_out <= "0110000";
	elsif (dezs_dez_in= "0100") then
		dezs_dez_out <= "0011001";
	elsif (dezs_dez_in= "0101") then
		dezs_dez_out <= "0010010";
	elsif (dezs_dez_in= "0110") then
		dezs_dez_out <= "0000010";
	elsif (dezs_dez_in= "0111") then
		dezs_dez_out <= "1111000";
	elsif (dezs_dez_in= "1000") then
		dezs_dez_out <= "0000000";
	elsif (dezs_dez_in= "1001") then
		dezs_dez_out <= "0010000";
	end if;

	if(seg_unid_in = "0000") then
		seg_unid_out <= "1000000";
	elsif (seg_unid_in = "0001") then
		seg_unid_out <= "1111001";
	elsif (seg_unid_in = "0010") then
		seg_unid_out <= "0100100";
	elsif (seg_unid_in = "0011") then
		seg_unid_out <= "0110000";
	elsif (seg_unid_in = "0100") then
		seg_unid_out <= "0011001";
	elsif (seg_unid_in = "0101") then
		seg_unid_out <= "0010010";
	elsif (seg_unid_in = "0110") then
		seg_unid_out <= "0000010";
	elsif (seg_unid_in = "0111") then
		seg_unid_out <= "1111000";
	elsif (seg_unid_in = "1000") then
		seg_unid_out <= "0000000";
	elsif (seg_unid_in = "1001") then
		seg_unid_out <= "0010000";
	end if;

	if (seg_dez_in = "0000") then
		seg_dez_out <= "1000000";
	elsif (seg_dez_in = "0001") then
		seg_dez_out <= "1111001";
	elsif (seg_dez_in = "0010") then
		seg_dez_out <= "0100100";
	elsif (seg_dez_in = "0011") then
		seg_dez_out <= "0110000";
	elsif (seg_dez_in = "0100") then
		seg_dez_out <= "0011001";
	elsif (seg_dez_in = "0101") then
		seg_dez_out <= "0010010";
	elsif (seg_dez_in = "0110") then
		seg_dez_out <= "0000010";
	elsif (seg_dez_in = "0111") then
		seg_dez_out <= "1111000";
	elsif (seg_dez_in = "1000") then
		seg_dez_out <= "0000000";
	elsif (seg_dez_in = "1001") then
		seg_dez_out <= "0010000";
	end if;

	if (min_unid_in = "0000") then
		min_unid_out <= "1000000";
	elsif (min_unid_in = "0001") then
		min_unid_out <= "1111001";
	elsif (min_unid_in = "0010") then
		min_unid_out <= "0100100";
	elsif (min_unid_in = "0011") then
		min_unid_out <= "0110000";
	elsif (min_unid_in = "0100") then
		min_unid_out <= "0011001";
	elsif (min_unid_in = "0101") then
		min_unid_out <= "0010010";
	elsif (min_unid_in = "0110") then
		min_unid_out <= "0000010";
	elsif (min_unid_in = "0111") then
		min_unid_out <= "1111000";
	elsif (min_unid_in = "1000") then
		min_unid_out <= "0000000";
	elsif (min_unid_in = "1001") then
		min_unid_out <= "0010000";
	end if;

	if (min_dez_in = "0000") then
		min_dez_out <= "1000000";
	elsif (min_dez_in = "0001") then
		min_dez_out <= "1111001";
	elsif (min_dez_in = "0010") then
		min_dez_out <= "0100100";
	elsif (min_dez_in = "0011") then
		min_dez_out <= "0110000";
	elsif (min_dez_in = "0100") then
		min_dez_out <= "0011001";
	elsif (min_dez_in = "0101") then
		min_dez_out <= "0010010";
	elsif (min_dez_in = "0110") then
		min_dez_out <= "0000010";
	elsif (min_dez_in = "0111") then
		min_dez_out <= "1111000";
	elsif (min_dez_in = "1000") then
		min_dez_out <= "0000000";
	elsif (min_dez_in = "1001") then
		min_dez_out <= "0010000";
	end if;

	if (hora_unid_in = "0000") then
		hora_unid_out <= "1000000";
	elsif (hora_unid_in = "0001") then
		hora_unid_out <= "1111001";
	elsif (hora_unid_in = "0010") then
		hora_unid_out <= "0100100";
	elsif (hora_unid_in = "0011") then
		hora_unid_out <= "0110000";
	elsif (hora_unid_in = "0100") then
		hora_unid_out <= "0011001";
	elsif (hora_unid_in = "0101") then
		hora_unid_out <= "0010010";
	elsif (hora_unid_in = "0110") then
		hora_unid_out <= "0000010";
	elsif (hora_unid_in = "0111") then
		hora_unid_out <= "1111000";
	elsif (hora_unid_in = "1000") then
		hora_unid_out <= "0000000";
	elsif (hora_unid_in = "1001") then
		hora_unid_out <= "0010000";
	end if;

	if (hora_dez_in = "0000") then
		hora_dez_out <= "1000000";
	elsif (hora_dez_in = "0001") then
		hora_dez_out <= "1111001";
	elsif (hora_dez_in = "0010") then
		hora_dez_out <= "0100100";
	elsif (hora_dez_in = "0011") then
		hora_dez_out <= "0110000";
	elsif (hora_dez_in = "0100") then
		hora_dez_out <= "0011001";
	elsif (hora_dez_in = "0101") then
		hora_dez_out <= "0010010";
	elsif (hora_dez_in = "0110") then
		hora_dez_out <= "0000010";
	elsif (hora_dez_in = "0111") then
		hora_dez_out <= "1111000";
	elsif (hora_dez_in = "1000") then
		hora_dez_out <= "0000000";
	elsif (hora_dez_in = "1001") then
		hora_dez_out <= "0010000";
	end if;
			
end process;

end Exibidor;
	
	