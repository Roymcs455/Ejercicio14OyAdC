LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY TAREA14 IS
	PORT(
		clock : in std_logic;
		reset : in std_logic;
		entradas: in std_logic_vector (3 downto 0);
		salidas: out std_logic_vector (4 downto 0)
		);
END TAREA14;

ARCHITECTURE BEHAVIORAL OF TAREA14 IS
--SIGNALS
signal microinst: std_logic_vector(2 downto 0);
signal qselect: std_logic;
signal selector: std_logic;
signal pl: std_logic;
signal mp: std_logic;
signal vect: std_logic;
signal reg_INT : std_logic_vector (3 downto 0) := "0000";
signal reg_TRANS : std_logic_vector (3 downto 0) := "0000";
signal reg_LIGA : std_logic_vector (3 downto 0);
signal reg_TRISTATE : std_logic_vector (3 downto 0);
signal reg_uPC : std_logic_vector (3 downto 0);
signal estado_presente: std_logic_vector(3 downto 0);
signal prueba : std_logic_vector (1 downto 0);


--COMPONENTS
	COMPONENT logica
	PORT (
		microinst: in std_logic_vector(2 downto 0);
		qselect: in std_logic;
		selector: out std_logic;
		pl: out std_logic;
		mp: out std_logic;
		vect: out std_logic
	);
	end component logica;
	COMPONENT tristate_buffer
	PORT(
		enable: in std_logic;
		inpt : in std_logic_vector(3 downto 0);
		outpt : out std_logic_vector(3 downto 0)
	);
	end component tristate_buffer;
	COMPONENT multiplexor
	port (
        sel : in std_logic;  -- selection input
        in_0 : in std_logic_vector(3 downto 0); -- input 0
        in_1 : in std_logic_vector(3 downto 0); -- input 1
        out_mux : out std_logic_vector(3 downto 0)  -- output
    );
	end component multiplexor;
	COMPONENT rom 
	port (
		estado_presente : in std_logic_vector(3 downto 0);
		liga : out std_logic_vector(3 downto 0);
		prueba : out std_logic_vector(1 downto 0);
		microinst : out std_logic_vector(2 downto 0);
		salidas : out std_logic_vector (4 downto 0)
	);
	end component rom;
BEGIN
--INSTANCIAS
	logica_instancia : logica
	PORT map(
		microinst => microinst,
		qselect=> qselect,
		selector=> selector,
		pl=>pl,
		mp=>mp,
		vect=>vect
	);
	transf_buffer : tristate_buffer
	PORT map(
		enable =>mp ,
		inpt => reg_TRANS,
		outpt => reg_TRISTATE
	);
	INT_buffer : tristate_buffer
	PORT map(
		enable =>vect ,
		inpt => reg_INT,
		outpt => reg_TRISTATE
	);
	LIGA_buffer : tristate_buffer
	PORT map(
		enable =>pl ,
		inpt => reg_LIGA,
		outpt => reg_TRISTATE
	);
	mux_edo_presente : multiplexor
	port map (
		sel => selector,
		in_0 => reg_uPC,
		in_1 => reg_TRISTATE,
		out_mux => estado_presente
	);
	memoria_rom : rom
	port map (
		estado_presente => estado_presente,
		liga => reg_LIGA,
		prueba => prueba,
		microinst => microinst,
		salidas => salidas
	);
	process (clock)
	begin
		if(rising_edge(clock)) then
			if reset = '0' then
				reg_uPC <= "0000";
			else
				reg_uPC <= std_logic_vector(unsigned(estado_presente)+1);
			end if;
		end if;
	end process;
	
	process(prueba, entradas )
	begin
		case prueba is
			when "00" =>
				qselect <= entradas (0);
			when "01" =>
				qselect <= entradas (1);
			when "10" =>
				qselect <= entradas (2);
			when "11" =>
				qselect <= entradas (3);
		end case;
	end process ;
END ARCHITECTURE;