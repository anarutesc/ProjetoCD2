library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Cronometro is
port (clock, config, str_sto, reset: in std_logic;
	modo: in std_logic_vector(1 downto 0);
	hora_dez : out  std_logic_vector(6 downto 0);
	hora_unid : out std_logic_vector(6 downto 0);
	min_dez : out std_logic_vector(6 downto 0);
	min_unid : out std_logic_vector(6 downto 0);
	seg_dez : out std_logic_vector(6 downto 0);
	seg_unid : out std_logic_vector(6 downto 0);
	dezs_dez : out std_logic_vector(6 downto 0);
	dezs_unid : out std_logic_vector(6 downto 0));
end Cronometro;

architecture Cronometro of Cronometro is
  signal hora_dez_in : std_logic_vector(6 downto 0) := "0000000";
  signal hora_unid_in : std_logic_vector(6 downto 0) := "0000000";
  signal min_dez_in : std_logic_vector(6 downto 0) := "0000000";
  signal min_unid_in : std_logic_vector(6 downto 0) := "0000000";
  signal seg_dez_in : std_logic_vector(6 downto 0) := "0000000";
  signal seg_unid_in : std_logic_vector(6 downto 0) := "0000000";
  signal dezs_dez_in : std_logic_vector(6 downto 0) := "0000000";
  signal dezs_unid_in : std_logic_vector(6 downto 0) := "0000000";
  signal count : integer := 0;
  signal str_sto_estado : std_logic := '1';
  signal str_sto_pressed : std_logic :='0';
begin

  process(clock, str_sto, reset, modo, str_sto_estado)
  begin
  if(clock'event and clock = '1') then
   if (modo = "11") then
		if (str_sto ='0' and str_sto_pressed='0') then -- str/sto estado start (0) stop (1)
			if(str_sto_estado = '0') then
				str_sto_estado <= '1';
			else
				str_sto_estado <= '0';
			end if;
			str_sto_pressed <= '1';
		end if;
		
		if(reset='0' and str_sto_estado ='1') then
			dezs_unid_in <= "0000000";
			dezs_dez_in <= "0000000";
			seg_unid_in <= "0000000";
			seg_dez_in <= "0000000";
			min_unid_in <= "0000000";
			min_dez_in <= "0000000";
			hora_unid_in <= "0000000";
			hora_dez_in <= "0000000";
		end if;
		
		if(str_sto='1' and str_sto_pressed='1') then
			str_sto_pressed <= '0';
		end if;
	end if;
	
		if(str_sto_estado ='0') then
			if(count = 500000) then
			   count <= 0;
				if (dezs_unid_in = "0001001") then
					if (dezs_dez_in = "0001001") then	  
						if(seg_unid_in = "0001001") then
							if(seg_dez_in = "0000101") then
								if(min_unid_in = "0001001") then
									if(min_dez_in = "0000101") then
										if(hora_unid_in = "0001001") then
											if(hora_dez_in = "0001001") then
												
													dezs_unid_in <= "0000000";
													dezs_dez_in <= "0000000";
													seg_unid_in <= "0000000";
													seg_dez_in <= "0000000";
													min_unid_in <= "0000000";
													min_dez_in <= "0000000";
													hora_unid_in <= "0000000";
													hora_dez_in <= "0000000";
												
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

	end Cronometro;