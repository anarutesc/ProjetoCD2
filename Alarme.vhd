library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Alarme is
port (clock, config, str_sto, reset, set : in std_logic;
	modo: in std_logic_vector(1 downto 0);
	hora_dez : out  std_logic_vector(6 downto 0);
	hora_unid : out std_logic_vector(6 downto 0);
	min_dez : out std_logic_vector(6 downto 0);
	min_unid : out std_logic_vector(6 downto 0);
	estado_atual : out std_logic;
	Lig_Deslig: out std_logic);
end  Alarme;

architecture Alarme of Alarme is
		
	signal hora_dez_in : std_logic_vector(6 downto 0) := "0000000";
	signal hora_unid_in : std_logic_vector(6 downto 0) := "0000000";
	signal min_dez_in : std_logic_vector(6 downto 0) := "0000000";
	signal min_unid_in : std_logic_vector(6 downto 0):= "0000000";
	signal configAlarme: std_logic := '0';
	signal Lig_Deslig_Sig: std_logic := '0';
	signal inConf: std_logic :='0';
   signal str_sto_pressed: std_logic :='0';
   signal set_pressed: std_logic:= '0';
	signal reset_pressed: std_logic:= '0';
	signal estado : std_logic:='0';
  
 begin

  process(clock, config, str_sto, set)
  begin
  
if(clock'event and clock = '1' and modo="10") then
   if (config='1' and inConf='0') then
			Lig_Deslig_Sig <= '1';
			configAlarme <= '0';
			inConf<='1';
	end if;
			
	if(configAlarme='0' and config='1') then
		if (str_sto= '0' and str_sto_pressed='0') then
			if (hora_unid_in = "0001001" or (hora_unid_in = "0000011" and hora_dez_in = "0000010")) then
				if(hora_dez_in = "0000010") then
					if(hora_unid_in = "0000011") then
						hora_unid_in <= "0000000";
						hora_dez_in <= "0000000";
					end if;
				else
					hora_unid_in <= "0000000";
					hora_dez_in <= hora_dez_in + 1;
				end if;
			else 
				hora_unid_in <= hora_unid_in + 1; 
			end if;
			str_sto_pressed<='1';
			estado <='1';
		end if;	
	elsif(configAlarme='1' and config='1') then
		if (str_sto= '0' and str_sto_pressed='0') then
			if (min_unid_in = "0001001") then
				if(min_dez_in = "0000101") then
					min_unid_in <= "0000000";
					min_dez_in <= "0000000";
				else
					min_unid_in <= "0000000";
					min_dez_in <= min_dez_in + 1;
				end if;
			else 
				min_unid_in <= min_unid_in +1; 
			end if;
			str_sto_pressed<='1';
			estado <='0';
		end if;
	end if;
	
	if(set='0' and set_pressed='0' and config='1') then 
		if (configAlarme= '1') then
			configAlarme<='0';
		else
			configAlarme <='1';
		end if;
		
		set_pressed <= '1';
	end if;
	
	if(reset='0' and reset_pressed='0' and config='1') then
		
		if(Lig_Deslig_Sig='0') then
			lig_Deslig_Sig <='1';
		else
			Lig_Deslig_Sig <='0';
		end if;
			
		configAlarme <='0';
		reset_pressed <='1';
	end if;
	
	
	if(str_sto='1' and str_sto_pressed ='1') then
		str_sto_pressed<=	'0';
	end if;
	
	if(set='1' and set_pressed ='1') then
		set_pressed<=	'0';
	end if;
	
	if(reset='1' and reset_pressed ='1') then
		reset_pressed<=	'0';
	end if;
	
	if(config='0' and inConf = '1') then
		inConf <= '0';
	end if;
end if;
end process;

Lig_Deslig <= Lig_Deslig_Sig;
hora_dez <= hora_dez_in;
hora_unid <= hora_unid_in;
min_dez <= min_dez_in;
min_unid <= min_unid_in;
estado_atual <= estado;

end Alarme;