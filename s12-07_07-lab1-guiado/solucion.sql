\connect cs2701

  
--- P1

---- Creación del esquema

DROP SCHEMA IF EXISTS lab12 CASCADE;

CREATE SCHEMA IF NOT EXISTS lab12;

SET search_path = lab12;

---- Creación de tablas

-- Tabla para los centros de votación

CREATE TABLE centroVotacion (
  codigo VARCHAR(6) NOT NULL,
  
  -- Cantidad expectada de electores que votarían en ese centro de votación en específico.
  electores INT NOT NULL,
  
  -- Hora en el que el centro de votación no acepta más votos.
  cierre TIMESTAMP WITHOUT TIME ZONE,
  
  -- Cantidad de candidatos presidenciales
  numCandidatos INT,
  
  habilitados INT,
  
  reportado INT
);

-- Tabla para el reporte de cantidad de votos emitidos en cada departamento durante cada hora de la elección.


CREATE TABLE sedeDepartamental (
  codigo VARCHAR(2) NOT NULL,
  reportado INT	
);

-- Tabla para el reporte de cantidad de votos emitidos en cada provincia durante cada hora de la elección.

CREATE TABLE sedeProvincial(
  codigo VARCHAR(4) NOT NULL, 
  reportado INT	
);

-- Tabla para las sedes distritales.
--
-- Esta tabla almacena la cantidad de votos para cada candidato en cada centroVotacion

CREATE TABLE votosPorCentro (
  Candidato VARCHAR(120),
  Centro VARCHAR(6) NOT NULL,
  ultimaReporte TIMESTAMP WITHOUT TIME ZONE,
  votos INT
);

-- Tabla para los candidatos presidenciales.

CREATE TABLE candidato (
  -- Nombre del partido al que partenece el candidato
  partido VARCHAR (120),
  -- Nombre completo del candidato
  nombre VARCHAR(120),
  -- Cantidad total de votos a medida que se van dando las elecciones
  totalVotos INT
);

-- Tabla para los departamentos.

CREATE TABLE departamento (
  id VARCHAR(2) NOT NULL,
  name VARCHAR(45) NOT NULL
);

-- Tabla para las provincias.

CREATE TABLE  provincia (
  id VARCHAR(4) NOT NULL,
  name VARCHAR(45) NOT NULL,
  departamentoId VARCHAR(2) NOT NULL
);

-- Tabla para los distritos.

CREATE TABLE distrito (
  id VARCHAR(6) NOT NULL,
  name VARCHAR(45) DEFAULT NULL,
  provinciaId VARCHAR(4) DEFAULT NULL,
  departamentoId VARCHAR(2) DEFAULT NULL
);

--- P2

---- Creación de llaves primarias

ALTER TABLE centroVotacion
  ADD CONSTRAINT pkey_centroVotacion
  PRIMARY KEY (Codigo);

ALTER TABLE sedeDepartamental
  ADD CONSTRAINT pkey_sedeDepartamental
  PRIMARY KEY (Codigo);

ALTER TABLE sedeProvincial
  ADD CONSTRAINT pkey_sedeProvincial
  PRIMARY KEY (Codigo);

ALTER TABLE votosPorCentro
  ADD CONSTRAINT pkey_votosPorCentro
  PRIMARY KEY (candidato, centro);

ALTER TABLE candidato
  ADD CONSTRAINT pkey_candidato
  PRIMARY KEY (partido, nombre);

ALTER TABLE departamento
  ADD CONSTRAINT pkey_departamento
  PRIMARY KEY (id);

ALTER TABLE provincia
  ADD CONSTRAINT pkey_provincia
  PRIMARY KEY (id);

ALTER TABLE distrito
  ADD CONSTRAINT pkey_distrito
  PRIMARY KEY (id);

---- Creación de llaves foráneas

ALTER TABLE provincia
  ADD CONSTRAINT fkey_provincia_departamentoId
  FOREIGN KEY (departamentoId)
  REFERENCES departamento;

ALTER TABLE distrito
  ADD CONSTRAINT fkey_distrito_provinciaId
  FOREIGN KEY (provinciaId)
  REFERENCES provincia;

ALTER TABLE distrito
  ADD CONSTRAINT fkey_distrito_departamentoId
  FOREIGN KEY (departamentoId)
  REFERENCES departamento;

--- P3

---- Creación de la tabla Votos1

CREATE TABLE votos1 (
  candidato VARCHAR(120),
  centro VARCHAR(6) NOT NULL,
  horaReporte TIMESTAMP WITHOUT TIME ZONE,
  votos INT
);
 

--- P4

-- asd

--- P5

