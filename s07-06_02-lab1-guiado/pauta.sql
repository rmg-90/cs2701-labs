--a)

CREATE TABLE Programa (
  Pid integer, 
  Actividad  varchar(50) ,
  Carrera varchar(50) ,
  Lugar varchar(255) ,
  Horario varchar(255) 
);

CREATE TABLE Interesado (
  DNI varchar(50) , 
  Nombre  varchar(50) ,
  Email varchar(50) ,
  Edad integer ,
  Sexo varchar(1) ,
  Colegio varchar(255)               
);

CREATE TABLE Asistencia (
  Pid integer , 
  DNI  varchar(50) ,
  Hora  timestamp 
);
--b) Restricciones de llaves primarias y foraneas

ALTER TABLE programa ADD CONSTRAINT programa_pk_id PRIMARY KEY (pid);
--ALTER TABLE programa DROP CONSTRAINT programa_pk_id;
ALTER TABLE Interesado ADD CONSTRAINT interesado_pk_dni PRIMARY KEY (dni);
ALTER TABLE Asistencia ADD CONSTRAINT asistencia_pk_dni_id PRIMARY KEY(pid, dni);
ALTER TABLE Asistencia ADD CONSTRAINT programa_fk_id FOREIGN KEY (pid) REFERENCES programa (pid);
ALTER TABLE Asistencia ADD CONSTRAINT interesado_fk_dni FOREIGN KEY (dni) REFERENCES interesado(dni);	

--c) Otras restricciones 

ALTER TABLE Interesado ADD CONSTRAINT interesando_email_unique UNIQUE (email);
ALTER TABLE Interesado ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Interesado ALTER COLUMN colegio SET NOT NULL;
ALTER TABLE Interesado ADD CONSTRAINT interesado_edad_check CHECK (edad>=12 AND edad<=85);

--d) Insertar registros 

INSERT INTO Programa (Pid,Actividad,Carrera,Lugar,Horario) VALUES 
(1,'RoboRally', 'Ciencia Computacion','Piso 5','10:00 a 11:00'),
(2,'RoboRally', 'Ciencia Computacion','Piso 5','13:00 a 14:00'),
(3,'Robots Biomédicos', 'Bioingeniería','Piso 1','12:00 a 14:00'),
(4,'Reality Space', 'Ciencia Computacion','Piso 5','10:40 a 11:25'),
(5,'Pensamiento Computacional', 'Ciencia Computacion','Piso 8','14:40 a 15:25');

INSERT INTO Interesado (DNI,Nombre,Email,Edad,Sexo,Colegio) VALUES 
('92436099','Madaline Henson','et.euismod.et@cursus.edu',18,'M','Phasellus In Consulting'),
('52527899','Ignatius Walsh','sem.molestie@Duisatlacus.net',19,'M','Risus Quisque Inc.'),
('120571899','Alyssa Massey','erat@aliquetmolestie.org',18,'F','Euismod Urna Nullam Corporation'),
('152666099','Uriel Callahan','Aliquam.vulputate@Nullam.ca',19,'M','Tincidunt Dui Institute'),
('151856699','Jeanette Prince','ullamcorper.eu.euismod@accumsaninterdum.edu',19,'F','Pede LLC'),
('103092199','Ashton Dudley','in.hendrerit@ullamcorperviverraMaecenas.org',19,'F','Arcu Imperdiet Limited'),
('152075299','Colt Turner','vestibulum@Donec.net',16,'F','Congue Incorporated'),
('121824399','Amanda Stout','Curabitur@nonjustoProin.edu',19,'F','Ac Feugiat Non Associates'),
('181055499','Brian Potter','sed.dui@mauris.ca',17,'M','Mauris LLC'),
('192928799','Dolan Mullen','adipiscing@tellus.net',18,'M','Odio Tristique Pharetra Limited');

INSERT INTO Asistencia (Pid,DNI,Hora) VALUES
(1,'181055499','1/10/2019 08:00:00'),
(2,'152666099','1/10/2019 08:00:00'),
(3,'152666099','1/10/2019 08:10:00'),
(4,'152075299','1/10/2019 08:12:00'),
(1,'192928799','1/10/2019 08:15:00'),
(2,'103092199','1/10/2019 08:30:00'),
(2,'121824399','1/10/2019 08:33:00'),
(3,'181055499','1/10/2019 08:35:00'),
(5,'181055499','1/10/2019 08:45:00'),
(4,'192928799','1/10/2019 08:47:00');

--e) Complete la consulta

Select A.Pid,P.Actividad, COUNT(*) AS NUMASIST 
from Asistencia A, Programa P
WHERE  A.Pid= P.Pid
GROUP BY A.Pid , P.Actividad
HAVING P.Actividad ='RoboRally';

--f) Complete la consulta

SELECT I.DNI,I.Nombre 
FROM  Interesado I WHERE I.DNI
    NOT IN (SELECT A.DNI
            FROM Asistencia A
            WHERE A.Pid IN (SELECT P.Pid
                            FROM Programa P
                            Where p.Carrera='Ciencia Computacion'));