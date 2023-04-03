LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY TAREA14 IS
	PORT(
		clock : in std_logic;
		reset : in std_logic;
		entradas: in std_logic_vector (4 downto 0);
		salidas: out std_logic_vector (4 downto 0)
		);
END TAREA14;

ARCHITECTURE BEHAVIORAL OF TAREA14 IS
--SIGNALS
signal CC : std_logic;
signal VF : std_logic;
signal prueba : std_logic_vector(2 downto 0);
signal LIGA : std_logic_vector (3 downto 0);
signal REG_TRANSF : std_logic_vector (3 downto 0);
signal REG_INT : std_logic_vector (3 downto 0);
signal ESTADO_PRESENTE : std_logic_vector (3 downto 0 );
SIGNAL MICROINST : STD_LOGIC_VECTOR (1 DOWNTO 0);

signal qseleccionada: std_logic;

--COMPONENTS
	COMPONENT SECUENCIADOR
	PORT (
		CLOCK: IN STD_LOGIC;
        RESET: IN STD_LOGIC;
        CC: IN STD_LOGIC;
        MICROINST: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        LIGA: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        REG_TRANSF: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        REG_INT: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        ESTADO_PRESENTE : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
	END COMPONENT SECUENCIADOR;
	
	COMPONENT ROM
	PORT (
		ESTADO_PRESENTE: in std_logic_vector( 3 downto 0);
		liga: out std_logic_vector (3 downto 0);
		prueba: out std_logic_vector (2 downto 0);
		vf: out std_logic;
		microinst : out std_logic_vector (1 downto 0);
		salidas : out std_logic_vector (4 downto 0)
	);
	end component ROM;
	COMPONENT multiplexor
	PORT(
		x : in std_logic;
		y : in std_logic;
		z : in std_logic;
		interrupcion : in std_logic;
		prueba : in std_logic_vector(2 downto 0);
		VF : in std_logic;
		cc: out STD_LOGIC
	);
	end component multiplexor;
BEGIN
	SECUENCIADOR_INSTANCIA : SECUENCIADOR
		PORT MAP(
			CLOCK => clock,
			RESET => reset,
			CC => CC,
			MICROINST => MICROINST,
			LIGA => LIGA,
			REG_TRANSF => REG_TRANSF,
			REG_INT => REG_INT,
			ESTADO_PRESENTE => ESTADO_PRESENTE
		);
	mem_programa : ROM
		PORT MAP (--cambiar el # de estado presente
			ESTADO_PRESENTE => ESTADO_PRESENTE,
			liga => liga,
			prueba => prueba,
			vf => VF,
			microinst => MICROINST,
			salidas => salidas
		);
	multiplexor_instancia : multiplexor
		PORT MAP (
			x => entradas(0),
			y => entradas(1),
			z => entradas(2),
			interrupcion => entradas(3),
			VF => VF,
			prueba => prueba,
			cc =>  cc
		);
END ARCHITECTURE;