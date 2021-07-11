--- votosPorCentro

-- Para cada centro de votación, iniciamos la candidad de votos para cada candidatos en cero.

INSERT INTO votosPorCentro (
  SELECT C.nombre,
	 D.id,
	 null,
	 0
    FROM distrito D, candidato C
);

--- sedeProvincial

-- Para cada sede provincial, iniciamos la candidad de votos de cada provincia en cero

INSERT INTO sedeProvincial (
  SELECT id, 0 FROM provincia
);

--- sedeDepartamental

-- Para cada sede departamental, iniciamos la candidad de votos de cada departamento en cero

INSERT INTO sedeDepartamental (
  SELECT id, 0 FROM departamento
);
