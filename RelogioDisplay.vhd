library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity RelogioDisplay is
port (clock, config, str_sto, set: in std_logic;
	modo: in std_logic_vector(1 downto 0);
	hora_dez : out  std_logic_vector(6 downto 0);
	hora_unid : out std_logic_vector(6 downto 0);
	min_dez : out std_logic_vector(6 downto 0);
	min_unid : out std_logic_vector(6 downto 0);
	seg_dez : out std_logic_vector(6 downto 0);
	seg_unid : out std_logic_vector(6 downto 0);
	dezs_dez: out std_logic_vector(6 downto 0);
	dezs_unid: out std_logic_vector(6 downto 0);
	estado_atual : out std_logic);
end  RelogioDisplay;

architecture RelogioDisplay of RelogioDisplay is
  signal hora_dez_in : std_logic_vector(6 downto 0) := "0000000";
  signal hora_unid_in : std_logic_vector(6 downto 0) := "0000000";
  signal min_dez_in : std_logic_vector(6 downto 0) := "0000000";
  signal min_unid_in : std_logic_vector(6 downto 0) := "0000000";
  signal seg_dez_in : std_logic_vector(6 downto 0) := "0000000";
  signal seg_unid_in : std_logic_vector(6 downto 0) := "0000000";
  signal dezs_dez_in : std_logic_vector(6 downto 0) := "0000000";
  signal dezs_unid_in : std_logic_vector(6 downto 0) := "0000000";
  signal count : integer := 0;
  signal configRelogio : std_logic :='0';
  signal inConf: std_logic :='0';
  signal str_sto_pressed: std_logic :='0';
  signal set_pressed: std_logic:= '0';
  signal estado: std_logic:='0';
  
begin

  process(clock, config, str_sto, set)
  begin
  
	if(clock'event and clock = '1') then
		
		if (modo="01") then
			if (config='1' and inConf='0') then
				hora_dez_in <= "0000000";
				hora_unid_in <= "0000000";
				min_dez_in <= "0000000";
				min_unid_in <= "0000000";
				seg_dez_in <= "0000000";
				seg_unid_in <= "0000000";
				dezs_dez_in <= "0000000";
				dezs_unid_in <= "0000000";
				configRelogio <= '0';
				inconf <= '1';
			end if;
		
			if(config='0' and inConf='1') then
				inConf <='0';
			end if;
			
			if(configRelogio='0' and config='1') then
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
					str_sto_pressed <= '1';
					estado <='1';
				end if;	
			elsif(configRelogio='1' and config='1') then
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
					str_sto_pressed <= '1';
					estado <='0';
				end if;
			end if;
			
			if(str_sto='1' and str_sto_pressed ='1') then
				str_sto_pressed<=	'0';
			end if;
		  
			if(set='0' and set_pressed='0' and config='1') then 
				if (configRelogio= '1') then
					configRelogio<='0';
				else		
					configRelogio<='1';
				end if;
				set_pressed <= '1';
			end if;
			
			if(set='1' and set_pressed='1') then
				set_pressed <='0';
			end if;

		end if;
		
		if(config='0') then
			if(count = 500000) then
				count <= 0;
				if(dezs_unid_in = "0001001") then
					if(dezs_dez_in = "0001001") then
						if(seg_unid_in = "0001001") then
							if(seg_dez_in = "0000101") then
								if(min_unid_in = "0001001") then
									if(min_dez_in = "0000101") then
										if(hora_unid_in = "0001001" or (hora_unid_in = "0000011" and hora_dez_in = "0000010")) then
											if(hora_dez_in = "0000010") then
												if(hora_unid_in = "0000011") then
													dezs_unid_in <= "0000000";
													dezs_dez_in <= "0000000";
													seg_unid_in <= "0000000";
													seg_dez_in <= "0000000";
													min_unid_in <= "0000000";
													min_dez_in <= "0000000";
													hora_unid_in <= "0000000";
													hora_dez_in <= "0000000";
												end if;
											else
											  dezs_unid_in <= "0000000";
											  dezs_dez_in <= "0000000";
											  seg_unid_in <= "0000000";
											  seg_dez_in <= "0000000";
											  min_unid_in <= "0000000";
											  min_dez_in <= "0000000";
											  hora_unid_in <= "0000000";
											  hora_dez_in <= hora_dez_in + 1;
											end if;
										else
											dezs_unid_in <= "0000000";
											dezs_dez_in <= "0000000";
											seg_unid_in <= "0000000";
											seg_dez_in <= "0000000";
											min_unid_in <= "0000000";
											min_dez_in <= "0000000";
											hora_unid_in <= hora_unid_in + 1;
										end if;
									else
										 dezs_unid_in <= "0000000";
										 dezs_dez_in <= "0000000";
										 seg_unid_in <= "0000000";
										 seg_dez_in <= "0000000";
										 min_unid_in <= "0000000";
										 min_dez_in <= min_dez_in + 1;
									end if;
								else
									  dezs_unid_in <= "0000000";
									  dezs_dez_in <= "0000000";
									  seg_unid_in <= "0000000";
									  seg_dez_in <= "0000000";
									  min_unid_in <= min_unid_in + 1;
								end if;
							else
									dezs_unid_in <= "0000000";
									dezs_dez_in <= "0000000";
									seg_unid_in <= "0000000";
									seg_dez_in <= seg_dez_in + 1;
							end if;
						else
								 dezs_unid_in <= "0000000";
								 dezs_dez_in <= "0000000";
								 seg_unid_in <= seg_unid_in + 1;
						end if;
					else
							dezs_unid_in <= "0000000";
							dezs_dez_in <= dezs_dez_in + 1;
					end if;
				else
					dezs_unid_in <= dezs_unid_in + 1;
				end if;
			else
				count <= count + 1;
			end if;
		end if;	
	end if;
	
end process;

hora_dez <= hora_dez_in;
hora_unid <= hora_unid_in;
min_dez <= min_dez_in;
min_unid <= min_unid_in;
seg_dez <= seg_dez_in;
seg_unid <= seg_unid_in;
dezs_dez <= dezs_dez_in;
dezs_unid <= dezs_unid_in;
estado_atual <= estado;
		
end RelogioDisplay;