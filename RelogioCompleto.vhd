library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity RelogioCompleto is
	port(clock, str_sto, set, reset, config, modo: in std_logic;
		hora_dez : out  std_logic_vector(6 downto 0);
		hora_unid : out std_logic_vector(6 downto 0);
		min_dez : out std_logic_vector(6 downto 0);
		min_unid : out std_logic_vector(6 downto 0);
		seg_dez : out std_logic_vector(6 downto 0);
		seg_unid : out std_logic_vector(6 downto 0);
		dezs_dez : out std_logic_vector(6 downto 0);
		dezs_unid : out std_logic_vector(6 downto 0);
		alarme_ativo : out std_logic;
		modo_rel, modo_alarme, modo_cron: out std_logic);		
		
end RelogioCompleto;

architecture RelogioCompleto of RelogioCompleto is
	component Exibidor is
	port(
	clock, config, estado: in std_logic;
	modo: in std_logic_vector(1 downto 0);
	hora_dez_in, hora_unid_in, min_dez_in, min_unid_in, seg_dez_in, seg_unid_in, dezs_dez_in, dezs_unid_in : in std_logic_vector(6 downto 0);
   hora_dez_out, hora_unid_out, min_dez_out, min_unid_out, seg_dez_out, seg_unid_out, dezs_dez_out, dezs_unid_out : out std_logic_vector(6 downto 0));
	end component;
	
	component RelogioDisplay is
		port (clock, config, str_sto, set : in std_logic;
		modo: in std_logic_vector(1 downto 0);
		hora_dez : out  std_logic_vector(6 downto 0);
		hora_unid : out std_logic_vector(6 downto 0);
		min_dez : out std_logic_vector(6 downto 0);
		min_unid : out std_logic_vector(6 downto 0);
		seg_dez : out std_logic_vector(6 downto 0);
		seg_unid : out std_logic_vector(6 downto 0);
		dezs_dez : out std_logic_vector(6 downto 0);
		dezs_unid : out std_logic_vector(6 downto 0);
		estado_atual : out std_logic);
	end component;
	
	component Alarme is
		port (clock, config, str_sto, reset, set : in std_logic;
		modo: in std_logic_vector(1 downto 0);
		hora_dez : out  std_logic_vector(6 downto 0);
		hora_unid : out std_logic_vector(6 downto 0);
		min_dez : out std_logic_vector(6 downto 0);
		min_unid : out std_logic_vector(6 downto 0);
		Lig_Deslig, estado_atual: out std_logic);
	end component;
	
	component Cronometro is
		port(clock, config, str_sto, reset : in std_logic;
		modo: in std_logic_vector(1 downto 0);
		hora_dez : out  std_logic_vector(6 downto 0);
		hora_unid : out std_logic_vector(6 downto 0);
		min_dez : out std_logic_vector(6 downto 0);
		min_unid : out std_logic_vector(6 downto 0);
		seg_dez : out std_logic_vector(6 downto 0);
		seg_unid : out std_logic_vector(6 downto 0);
		dezs_dez : out std_logic_vector(6 downto 0);
		dezs_unid : out std_logic_vector(6 downto 0));
	end component;
	
	
	
	signal hora_dez_relogio : std_logic_vector(6 downto 0);
	signal hora_unid_relogio : std_logic_vector(6 downto 0);
	signal min_dez_relogio : std_logic_vector(6 downto 0);
	signal min_unid_relogio : std_logic_vector(6 downto 0);
	signal seg_dez_relogio : std_logic_vector(6 downto 0);
	signal seg_unid_relogio : std_logic_vector(6 downto 0);
	signal dezs_dez_relogio : std_logic_vector(6 downto 0);
	signal dezs_unid_relogio : std_logic_vector(6 downto 0);
	
	signal hora_dez_cron : std_logic_vector(6 downto 0);
	signal hora_unid_cron : std_logic_vector(6 downto 0);
	signal min_dez_cron : std_logic_vector(6 downto 0);
	signal min_unid_cron : std_logic_vector(6 downto 0);
	signal seg_dez_cron : std_logic_vector(6 downto 0);
	signal seg_unid_cron : std_logic_vector(6 downto 0);
	signal dezs_dez_cron : std_logic_vector(6 downto 0);
	signal dezs_unid_cron : std_logic_vector(6 downto 0);
	
	signal hora_dez_alarme : std_logic_vector(6 downto 0);
	signal hora_unid_alarme : std_logic_vector(6 downto 0);
	signal min_dez_alarme: std_logic_vector(6 downto 0);
	signal min_unid_alarme : std_logic_vector(6 downto 0);
	
	signal modoAtual: std_logic_vector(1 downto 0) := "01";
	signal modoPressed: std_logic :='0';
	
	signal display_hora_dez_in : std_logic_vector(6 downto 0) :="0000000";
	signal display_hora_unid_in : std_logic_vector(6 downto 0) :="0000000";
	signal display_min_dez_in : std_logic_vector(6 downto 0) :="0000000";
	signal display_min_unid_in : std_logic_vector(6 downto 0) :="0000000";
	signal display_seg_dez_in : std_logic_vector(6 downto 0) :="0000000";
	signal display_seg_unid_in : std_logic_vector(6 downto 0) :="0000000";
	signal display_dezs_dez_in : std_logic_vector(6 downto 0) :="0000000";
	signal display_dezs_unid_in : std_logic_vector(6 downto 0) :="0000000";
	signal display_hora_dez_out, display_hora_unid_out, display_min_dez_out, display_min_unid_out, display_seg_dez_out, display_seg_unid_out,
	       display_dezs_dez_out, display_dezs_unid_out : std_logic_vector(6 downto 0);
	signal Lig_Deslig_Alarme : std_logic;
	signal estadoFinal, estadoAlarme, estadoRel: std_logic;
	signal modo_rel_in: std_logic:='1';
	signal modo_alarme_in: std_logic:='0';
	signal modo_cron_in: std_logic:='0';
	
	
begin


DR:	RelogioDisplay port map (clock, config, str_sto, set, modoAtual, hora_dez_relogio, hora_unid_relogio, min_dez_relogio, min_unid_relogio, seg_dez_relogio, seg_unid_relogio, dezs_dez_relogio, dezs_unid_relogio, estadoRel);

DA:	Alarme port map (clock, config, str_sto, reset, set, modoAtual, hora_dez_alarme, hora_unid_alarme, min_dez_alarme, min_unid_alarme, Lig_Deslig_Alarme, estadoAlarme);   

DC: 	Cronometro port map (clock, config, str_sto, reset, modoAtual, hora_dez_cron, hora_unid_cron, min_dez_cron, min_unid_cron, seg_dez_cron, seg_unid_cron, dezs_dez_cron, dezs_unid_cron);

EXIB: Exibidor port map(clock, config, estadoFinal, modoAtual, display_hora_dez_in, display_hora_unid_in, display_min_dez_in, display_min_unid_in, display_seg_dez_in, display_seg_unid_in,
			 display_dezs_dez_in, display_dezs_unid_in, display_hora_dez_out, display_hora_unid_out, display_min_dez_out, display_min_unid_out, 
			 display_seg_dez_out, display_seg_unid_out, display_dezs_dez_out, display_dezs_unid_out);
			 
process(clock)
begin
	if (clock'event and clock='1') then
		if(modo='0' and modoPressed='0' and modoAtual="01") then
			modoAtual <="10";
			modoPressed<='1';
			modo_rel_in<='0';
			modo_alarme_in<='1';
			modo_cron_in<='0';
			estadoFinal<=estadoRel;
		end if;

		if(modo='0' and modoPressed='0' and modoAtual="10") then
			modoAtual<="11";
			modoPressed<='1';
			modo_rel_in<='0';
			modo_alarme_in<='0';
			modo_cron_in<='1';
			estadoFinal<=estadoAlarme;
		end if;

		if(modo='0' and modoPressed='0' and modoAtual="11") then
			modoAtual<="01";
			modoPressed<='1';
			modo_rel_in<='1';
			modo_alarme_in<='0';
			modo_cron_in<='0';
		end if;
		
		if(modoAtual="01") then
			display_hora_dez_in<=hora_dez_relogio;
			display_hora_unid_in<=hora_unid_relogio;
			display_min_dez_in<=min_dez_relogio;
			display_min_unid_in<=min_unid_relogio;
			display_seg_dez_in<=seg_dez_relogio;
			display_seg_unid_in<=seg_unid_relogio;
			display_dezs_dez_in<=dezs_dez_relogio;
			display_dezs_unid_in<=dezs_unid_relogio;
		elsif (modoAtual="10") then
			display_hora_dez_in<=hora_dez_alarme;
			display_hora_unid_in<=hora_unid_alarme;
			display_min_dez_in<=min_dez_alarme;
			display_min_unid_in<=min_unid_alarme;
			display_seg_dez_in<="0000000";
			display_seg_unid_in<="0000000";
			display_dezs_dez_in<="0000000";
			display_dezs_unid_in<="0000000";
		else
			display_hora_dez_in<=hora_dez_cron;
			display_hora_unid_in<=hora_unid_cron;
			display_min_dez_in<=min_dez_cron;
			display_min_unid_in<=min_unid_cron;
			display_seg_dez_in<=seg_dez_cron;
			display_seg_unid_in<=seg_unid_cron;
			display_dezs_dez_in<=dezs_dez_cron;
			display_dezs_unid_in<=dezs_unid_cron;
		end if;
		
		if(modo='1' and modoPressed='1') then
			modoPressed<='0';
		end if;
		
	end if;
end process;

hora_dez <= display_hora_dez_out;
hora_unid <= display_hora_unid_out;
min_dez <= display_min_dez_out;
min_unid <= display_min_unid_out;
seg_dez <= display_seg_dez_out;
seg_unid <= display_seg_unid_out;
dezs_dez <= display_dezs_dez_out;
dezs_unid <= display_dezs_unid_out;
alarme_ativo <= Lig_Deslig_Alarme;
modo_rel<=modo_rel_in;
modo_alarme<=modo_alarme_in;
modo_cron<=modo_cron_in;

end RelogioCompleto;