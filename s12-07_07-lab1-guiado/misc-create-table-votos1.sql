START TRANSACTION;

-- Creación de tabla =Votos1=

CREATE TABLE Votos1 (
  candidato varchar(120),
  centro varchar(6) NOT NULL,
  HoraReporte timestamp WITHOUT time zone ,
  votos int
);

-- Insertar valores aleatorios en =Votos1=

INSERT INTO Votos1 (
  SELECT NOMBRE, ID, (SELECT now()), (floor(random() * (10 - 0 + 1)) + 0) 
    FROM Distrito D, Candidato C 
);

COMMIT;
