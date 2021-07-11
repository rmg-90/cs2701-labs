-- Para empezar, necesitamos iniciar =VotosPorCentro= en cero.

INSERT INTO VotosPorCentro (
  SELECT nombre, id, null, 0 FROM Distrito D, Candidato C);

-- Ahora necesitamos poner en 0, los valores de =SedeDepartamental= y
-- =SedeProvincial=.

INSERT INTO SedeDepartamental (
  SELECT id, 0
    FROM Departamento
);

INSERT INTO SedeProvincial (
  SELECT id, 0
    FROM Provincia
);

-- Finalmente, ponemos en 0 a =CentroDeVotacion=

INSERT INTO CentroVotacion (
  SELECT ID, 0, null, (
    SELECT COUNT(partido)
      FROM candidato
  ), 0, 0 FROM Distrito);
