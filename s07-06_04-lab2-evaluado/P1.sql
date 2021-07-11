DROP SCHEMA IF EXISTS a2021_1_sec1_lab7_grupo2 CASCADE;
CREATE SCHEMA a2021_1_sec1_lab7_grupo2;

SET search_path=a2021_1_sec1_lab7_grupo2;
SET datestyle = 'iso, dmy';

--- (a) Creación de tablas

---- Entidades

CREATE TABLE local (
  aforo     INT,
  direccion VARCHAR(80),
  distrito  VARCHAR(20),
  telefono  INT
);

CREATE TABLE pago (
  fecha_emision DATE,
  igv           FLOAT,
  metodo_pago   VARCHAR(20),
  monto_total   FLOAT,
  numeracion    VARCHAR(10),
  subtotal      FLOAT,
  -- Llave primaria de «Delivery»
  direccion     VARCHAR(50),
  fecha         DATE,
  hora          TIME
);

CREATE TABLE boleta (
  numeracion VARCHAR(10)
);

CREATE TABLE factura (
  numeracion   VARCHAR(10),
  razon_social VARCHAR(20),
  ruc          VARCHAR(11)
);

CREATE TABLE delivery (
  distrito  VARCHAR(20),
  direccion VARCHAR(50),
  fecha     DATE,
  hora      TIME,
  -- Llave primaria de «Cliente»
  dni       INT
);

CREATE TABLE persona (
  dni              INT,
  nombre           VARCHAR(20),
  apellido         VARCHAR(20),
  genero           VARCHAR(1),
  celular          INT,
  fecha_nacimiento VARCHAR(15)
);

CREATE TABLE cliente (
  dni INT
);

CREATE TABLE empleado (
  dni           INT,
  horario       VARCHAR(15),
  activo        BOOLEAN,
  sueldo        INTEGER,
  dias_descanso VARCHAR(15)
);

CREATE TABLE repartidor (
  dni            INT,
  placa_vehiculo VARCHAR(8),
  tipo_vehiculo  VARCHAR(10)
);

CREATE TABLE planilla (
  dni          INT,
  area_trabajo VARCHAR(10)
);

CREATE TABLE comida (
  nombre            VARCHAR(20),
  fecha_preparacion DATE,
  hora_preparacion  TIME,
  foto              VARCHAR(150),
  descripcion       VARCHAR(150),
  precio_venta      FLOAT,
  categoria         VARCHAR(20)
);

-- Esta es una entidad débil, entonces siempre que exista debe estar
-- relacionada con una entidad de la entidad identificadora, que en
-- este caso, sería «comida».

CREATE TABLE promocion (
  codigo            INTEGER,
  descuento         FLOAT,
  fecha_inicio      DATE,
  fecha_fin         DATE,
  nombre            VARCHAR(20),
  fecha_preparacion DATE,
  hora_preparacion  TIME
);

CREATE TABLE ingrediente (
  stock         INTEGER,
  precio_compra FLOAT,
  nombre        VARCHAR(20)
);

CREATE TABLE contrato (
  numero VARCHAR (10),
  desde  DATE,
  hasta  DATE,
  dni    INTEGER
);
---- Relaciones

CREATE TABLE pedido (
  -- Atributos
  cantidad          INTEGER,
  -- Llave primaria de «Planilla»
  dni               INTEGER,
  -- Llave primaria de «Comida»
  nombre            VARCHAR(20),
  fecha_preparacion DATE,
  hora_preparacion  TIME,
  -- Llave primaria de «Delivery»
  direccion         VARCHAR(50),
  fecha             DATE,
  hora              TIME
);

CREATE TABLE trabaja (
  -- Llave primaria de «Local»
  direccion VARCHAR(50),
  -- Llave primaria de «Planilla»
  dni       INTEGER
);

CREATE TABLE recibe (
  -- Llave primaria de «Pago»
  numeracion VARCHAR(10),
  -- Llave primaria de «Local»
  direccion  VARCHAR(50)
);

CREATE TABLE entrega (
  -- Llave primaria de «Delivery»
  direccion VARCHAR(50),
  fecha     DATE,
  hora      TIME,
  -- Llave primaria de «Repartidor»
  dni       INTEGER
);

CREATE TABLE requiere (
  -- Llave primaria de «Local»
  direccion          VARCHAR(50),
  -- Llave primaria de «Ingrediente»
  nombre_ingrediente VARCHAR(20),
  -- Llave primaria de «Comida»
  nombre_comida      VARCHAR(20),
  fecha_preparacion  DATE,
  hora_preparacion   TIME
);

--- (b) Llaves primarias, llaves foráneas y restricciones que consideremos

---- Llaves primarias

----- Relaciones

ALTER TABLE recibe
  ADD CONSTRAINT recibe_pkey
  PRIMARY KEY (numeracion, direccion);

ALTER TABLE pedido
  ADD CONSTRAINT pedido_pkey
  PRIMARY KEY (
    -- Llave primaria de «Comida»
    nombre, fecha_preparacion, hora_preparacion,
    -- Llave primaria de «Delivery»
    direccion, fecha, hora,
    -- Llave primaria de «Planilla»
    dni);

ALTER TABLE trabaja
  ADD CONSTRAINT trabaja_pkey
  PRIMARY KEY (dni, direccion);

ALTER TABLE entrega
  ADD CONSTRAINT entrega_pkey
  PRIMARY KEY (direccion, fecha, hora, dni);

ALTER TABLE requiere
  ADD CONSTRAINT requiere_pkey
  PRIMARY KEY (direccion, nombre_ingrediente, nombre_comida, fecha_preparacion, hora_preparacion);

----- Entidades

ALTER TABLE persona
  ADD CONSTRAINT persona_pkey
  PRIMARY KEY (dni);

ALTER TABLE cliente
  ADD CONSTRAINT cliente_pkey
  PRIMARY KEY (dni);

ALTER TABLE empleado
  ADD CONSTRAINT empleado_pkey
  PRIMARY KEY (dni);

ALTER TABLE repartidor
  ADD CONSTRAINT repartidor_pkey
  PRIMARY KEY (dni);

ALTER TABLE planilla
  ADD CONSTRAINT planilla_pkey
  PRIMARY KEY (dni);

ALTER TABLE pago
  ADD CONSTRAINT pago_pkey
  PRIMARY KEY (numeracion);

ALTER TABLE factura
  ADD CONSTRAINT factura_pkey
  PRIMARY KEY (numeracion);

ALTER TABLE boleta
  ADD CONSTRAINT boleta_pkey
  PRIMARY KEY (numeracion);

ALTER TABLE delivery
  ADD CONSTRAINT delivery_pkey
  PRIMARY KEY (fecha, hora, direccion);

ALTER TABLE local
  ADD CONSTRAINT local_pkey
  PRIMARY KEY (direccion);

ALTER TABLE comida
  ADD CONSTRAINT comida_pkey
  PRIMARY KEY (nombre, fecha_preparacion, hora_preparacion);

ALTER TABLE promocion
  ADD CONSTRAINT promocion_pkey
  PRIMARY KEY (codigo, nombre, fecha_preparacion, hora_preparacion);

ALTER TABLE ingrediente
  ADD CONSTRAINT ingrediente_pkey
  PRIMARY KEY (nombre);

ALTER TABLE contrato
  ADD CONSTRAINT contrato_pkey
  PRIMARY KEY (dni, numero);

---- Llaves foráneas

-- Añadimos las llaves foránea para asegurarnos que cuando la columna
-- correspondiente sea eliminada, la entidad en la tabla de origen que
-- la referencia también sea eliminada.

----- Entidades

ALTER TABLE cliente
  ADD CONSTRAINT cliente_dni_fkey
  FOREIGN KEY (dni)
  REFERENCES persona (dni);

ALTER TABLE empleado
  ADD CONSTRAINT empleado_dni_fkey
  FOREIGN KEY (dni)
  REFERENCES persona (dni);

ALTER TABLE planilla
  ADD CONSTRAINT planilla_dni_fkey
  FOREIGN KEY (dni)
  REFERENCES empleado (dni);

ALTER TABLE repartidor
  ADD CONSTRAINT repartidor_dni_fkey
  FOREIGN KEY (dni)
  REFERENCES empleado (dni);

ALTER TABLE boleta
  ADD CONSTRAINT boleta_numeracion_fkey
  FOREIGN KEY (numeracion)
  REFERENCES pago (numeracion);

ALTER TABLE factura
  ADD CONSTRAINT factura_numeracion_fkey
  FOREIGN KEY (numeracion)
  REFERENCES pago (numeracion);

ALTER TABLE delivery
  ADD CONSTRAINT delivery_dni_fkey
  FOREIGN KEY (dni)
  REFERENCES persona (dni);

ALTER TABLE promocion
  ADD CONSTRAINT promocion_nombre_fecha_preparacion_hora_preparacion_fkey
  FOREIGN KEY (nombre, fecha_preparacion, hora_preparacion)
  REFERENCES comida (nombre, fecha_preparacion, hora_preparacion);

ALTER TABLE pago
  ADD CONSTRAINT pago_fecha_direccion_fkey
  FOREIGN KEY (fecha, hora, direccion)
  REFERENCES delivery (fecha, hora, direccion);

ALTER TABLE contrato
  ADD CONSTRAINT contrato_dni_fkey
  FOREIGN KEY (dni)
  REFERENCES persona (dni);

----- Relaciones

ALTER TABLE pedido
  ADD CONSTRAINT pedido_nombre_fecha_preparacion_hora_preparacion_fkey
  FOREIGN KEY (nombre, fecha_preparacion, hora_preparacion)
  REFERENCES comida (nombre, fecha_preparacion, hora_preparacion);

ALTER TABLE pedido
  ADD CONSTRAINT pedido_dni_fkey
  FOREIGN KEY (dni)
  REFERENCES persona (dni);

ALTER TABLE pedido
  ADD CONSTRAINT pedido_fecha_hora_direccion_fkey
  FOREIGN KEY (fecha, hora, direccion)
  REFERENCES delivery (fecha, hora, direccion);

ALTER TABLE trabaja
  ADD CONSTRAINT trabaja_dni_fkey
  FOREIGN KEY (dni)
  REFERENCES persona (dni);

ALTER TABLE trabaja
  ADD CONSTRAINT trabaja_direccion_fkey
  FOREIGN KEY (direccion)
  REFERENCES local (direccion);

ALTER TABLE recibe
  ADD CONSTRAINT recibe_numeracion_fkey
  FOREIGN KEY (numeracion)
  REFERENCES pago (numeracion);

ALTER TABLE recibe
  ADD CONSTRAINT recibe_direccion_fkey
  FOREIGN KEY (direccion)
  REFERENCES local (direccion);

ALTER TABLE entrega
  ADD CONSTRAINT entrega_direccion_fecha_hora_fkey
  FOREIGN KEY (direccion, hora, fecha)
  REFERENCES delivery (direccion, hora, fecha);

ALTER TABLE entrega
  ADD CONSTRAINT entrega_dni_fkey
  FOREIGN KEY (dni)
  REFERENCES persona (dni);

ALTER TABLE requiere
  ADD CONSTRAINT requiere_nombre_fecha_preparacion_hora_preparacion_fkey
  FOREIGN KEY (nombre_comida, fecha_preparacion, hora_preparacion)
  REFERENCES comida (nombre, fecha_preparacion, hora_preparacion);

ALTER TABLE requiere
  ADD CONSTRAINT requiere_nombre_fkey
  FOREIGN KEY (nombre_ingrediente)
  REFERENCES ingrediente (nombre);

ALTER TABLE requiere
  ADD CONSTRAINT requiere_direccion_fkey
  FOREIGN KEY (direccion)
  REFERENCES local (direccion);

---- Restricciones consideradas por el grupo

----- Entidades

------ Contrato

ALTER TABLE contrato
  ALTER COLUMN desde
  SET NOT NULL;

ALTER TABLE contrato
  ALTER COLUMN hasta
  SET NOT NULL;

------ Persona

ALTER TABLE persona
  ALTER COLUMN nombre
  SET NOT NULL;

ALTER TABLE persona
  ALTER COLUMN apellido
  SET NOT NULL;

ALTER TABLE persona
  ALTER COLUMN genero
  SET NOT NULL;

ALTER TABLE persona
  ALTER COLUMN fecha_nacimiento
  SET NOT NULL;

ALTER TABLE persona
  ALTER COLUMN celular
  SET NOT NULL;

-- El sexo de la persona debe ser o F o M.

ALTER TABLE persona
  ADD CONSTRAINT persona_genero_check
  CHECK(genero = 'M'
	OR genero = 'F');

-- El celular de la persona debe tener 9 dígitos

ALTER TABLE persona
  ADD CONSTRAINT persona_celular_check
  CHECK(celular >= 100000000
	AND celular <= 999999999);

------ Empleado

ALTER TABLE empleado
  ALTER COLUMN horario
  SET NOT NULL;

ALTER TABLE empleado
  ALTER COLUMN activo
  SET NOT NULL;

ALTER TABLE empleado
  ALTER COLUMN sueldo
  SET NOT NULL;

ALTER TABLE empleado
  ALTER COLUMN dias_descanso
  SET NOT NULL;

------ Planilla

ALTER TABLE planilla
  ALTER COLUMN area_trabajo
  SET NOT NULL;

------ Repartidor

ALTER TABLE repartidor
  ALTER COLUMN placa_vehiculo
  SET NOT NULL;

ALTER TABLE repartidor
  ALTER COLUMN tipo_vehiculo
  SET NOT NULL;

-- Placa con máximo 6 letras

ALTER TABLE repartidor
  ADD CONSTRAINT repartidor_placa_check
  CHECK(placa_vehiculo ~ '^[A-Z]{3}[0-9]{3}$'
	OR placa_vehiculo ~ '^[A-Z]{2}[0-9]{4}$');

------ Local

ALTER TABLE local
  ALTER COLUMN telefono
  SET NOT NULL;

ALTER TABLE local
  ALTER COLUMN distrito
  SET NOT NULL;

ALTER TABLE local
  ALTER COLUMN aforo
  SET NOT NULL;

ALTER TABLE local
  ADD CONSTRAINT local_telefono_unique
  UNIQUE (telefono);

ALTER TABLE local
  ADD CONSTRAINT local_telefono_check
  CHECK(telefono >= 100000000
	AND telefono <= 999999999);

------ Delivery

ALTER TABLE delivery
  ALTER COLUMN distrito
  SET NOT NULL;

------ Pago

ALTER TABLE pago
  ALTER COLUMN igv
  SET NOT NULL;

ALTER TABLE pago
  ALTER COLUMN subtotal
  SET NOT NULL;

ALTER TABLE pago
  ALTER COLUMN fecha_emision
  SET NOT NULL;

ALTER TABLE pago
  ALTER COLUMN metodo_pago
  SET NOT NULL;

ALTER TABLE pago
  ALTER COLUMN monto_total
  SET NOT NULL;

-- El método de pago debe ser «tarjeta de credito», «tarjeta de debito» o «efectivo».

ALTER TABLE pago
  ADD CONSTRAINT pago_metodo_pago_check
  CHECK(metodo_pago = 'tarjeta de credito'
	OR metodo_pago = 'tarjeta de debito'
	OR metodo_pago = 'efectivo');

------ Factura

ALTER TABLE factura
  ALTER COLUMN ruc
  SET NOT NULL;

ALTER TABLE factura
  ALTER COLUMN razon_social
  SET NOT NULL;

-- La razon social debe insertarse en mayusculas.

ALTER TABLE factura
  ADD CONSTRAINT factura_razon_social_check
  CHECK(razon_social= UPPER(razon_social));

-- El RUC debe ser de tamaño 11 y sólo debe contener numeros.

ALTER TABLE factura
  ADD CONSTRAINT factura_ruc_check
  CHECK(CHAR_LENGTH(ruc) = 11
	AND ruc ~ '^\d*$');

------ Comida

ALTER TABLE comida
  ALTER COLUMN descripcion
  SET NOT NULL;

ALTER TABLE comida
  ALTER COLUMN precio_venta
  SET NOT NULL;

ALTER TABLE comida
  ALTER COLUMN categoria
  SET NOT NULL;

------ Promoción

ALTER TABLE promocion
  ALTER COLUMN descuento
  SET NOT NULL;

ALTER TABLE promocion
  ALTER COLUMN fecha_inicio
  SET NOT NULL;

ALTER TABLE promocion
  ALTER COLUMN fecha_fin
  SET NOT NULL;

-- El descuento debe estar entre 0 y 100

ALTER TABLE promocion
  ADD CONSTRAINT promocion_descuento_check
  CHECK(descuento >= 0.0 AND descuento <= 100.0);

------ Ingrediente

ALTER TABLE ingrediente
  ALTER COLUMN precio_compra
  SET NOT NULL;

ALTER TABLE ingrediente
  ALTER COLUMN stock
  SET NOT NULL;

----- Relaciones

------ Pedido

ALTER TABLE pedido
  ALTER COLUMN cantidad
  SET NOT NULL;

--- (c) Restricciones solicitadas

-- La numeración de los pagos deben iniciar siempre con ”P” (Ejemplo: P0001)

ALTER TABLE pago
  ADD CONSTRAINT pago_numeracion_check
  CHECK(numeracion ~ '^[P]\d*$');

-- El horario de atención es de 9:00am a 23:00hrs y toda operación solo se puede realizar dentro de este horario.

ALTER TABLE delivery
  ADD CONSTRAINT delivery_hora_check
  CHECK(EXTRACT(HOUR FROM hora) >= 9
	AND EXTRACT(HOUR FROM hora) < 23);

-- El descuento de una promoción no puede durar más de dos días.

ALTER TABLE promocion
  ADD CONSTRAINT promocion_duration_check
  CHECK (fecha_fin >= fecha_inicio
	 AND fecha_fin - fecha_inicio <= 2);

-- Los contratos siempre son por tres meses = mismo day, diferencia de meses = 3

ALTER TABLE contrato
  ADD CONSTRAINT contrato_duration_check
  CHECK (hasta >= desde
	 AND DATE_PART('day', desde) = DATE_PART('day', hasta)
	 AND ((DATE_PART('year', hasta) - DATE_PART('year', desde)) * 12 + (DATE_PART('month', hasta) - DATE_PART('month', desde)) = 3));

-- El aforo del local no debe ser mayor a 50 personas.

ALTER TABLE local
  ADD CONSTRAINT local_aforo_check
  CHECK(aforo <= 50);

--- (d) Registro de los 10 deliveries

---- Planilla

INSERT INTO persona (dni, nombre, apellido, genero, celular, fecha_nacimiento) VALUES
(70123456, 'Juan', 'Perez', 'M', 912456712, '14/05/1972'),
(10500468, 'Carlos', 'Salazar', 'M', 954678912, '20/08/1980'),
(42345687, 'Brenda', 'Diaz', 'F', 945278915, '10/01/1995'),
(70441254, 'Enrique', 'Martinez', 'M', 987415321, '25/12/1990');

INSERT INTO empleado (dni, horario, activo, sueldo, dias_descanso) VALUES
(70123456, 'Mañana', True, 2400, 'Vi'),
(10500468, 'Mañana', True, 2100, 'Sa-Do'),
(42345687, 'Mañana', True, 1950, 'Lu-Ma'),
(70441254, 'Tarde', True, 2500, 'Mi');

INSERT INTO planilla (dni, area_trabajo) VALUES
(70123456, 'cocina'),
(10500468, 'cocina'),
(42345687, 'cocina'),
(70441254, 'cocina');

---- Repartidor

INSERT INTO persona (dni, nombre, apellido, genero, celular, fecha_nacimiento) VALUES
(45123578, 'Daniel', 'Sanchez', 'M', 954789542, '17/11/1984'),
(45712687, 'Luz', 'Nuñez', 'F', 912456782, '23/04/1990');

INSERT INTO empleado (dni, horario, activo, sueldo, dias_descanso) VALUES
(45123578, 'Mañana', True, 1500, 'Lu'),
(45712687, 'Tarde', True, 1400, 'Ma');

INSERT INTO repartidor (dni, placa_vehiculo, tipo_vehiculo) VALUES
(45123578, 'AB1234', 'moto'),
(45712687, 'CD5679', 'moto');

---- Local

INSERT INTO local (aforo, direccion, distrito, telefono) VALUES
(25, 'Jirón 1 ...', 'Miraflores', 982456789),
(10, 'Jirón 2 ...', 'Barranco', 987456148);

---- Trabaja

INSERT INTO trabaja (direccion, dni) VALUES
('Jirón 1 ...', 70123456),
('Jirón 1 ...', 10500468),
('Jirón 2 ...', 42345687),
('Jirón 2 ...', 70441254);

---- Cliente

INSERT INTO persona (dni, nombre, apellido, genero, celular, fecha_nacimiento) VALUES
(70100771, 'Dante', 'Díaz', 'M', 972546128, '21/01/2000'),
(70444614, 'Alvaro', 'Riveros', 'M', 921478546, '12/02/2001'),
(78456982, 'Jorge', 'Ramirez', 'M', 941132456, '01/11/1998'),
(41563245, 'María', 'Buendía', 'F', 995789456, '15/03/2005');

INSERT INTO cliente (dni) VALUES
(70100771),
(70444614),
(78456982),
(41563245);

---- Comida

INSERT INTO comida (nombre, fecha_preparacion, hora_preparacion, foto, descripcion, precio_venta, categoria) VALUES
('Pollo a la brasa', '12/01/2021', '13:23:00', 'Foto1', 'Pollo con papas', 60.50, 'a la carta'),
('Arroz con pollo', '22/02/2021', '12:05:10', 'Foto2', 'Arroz con pollo y huancaina', 17.50, 'almuerzo'),
('Omelet', '24/03/2021', '10:05:12', 'Foto3', 'Omelet con cafe', 12.50, 'desayuno'),
('Pollo a la brasa', '08/04/2021', '16:35:00', 'Foto1', 'Pollo con papas', 60.50, 'a la carta'),
('Torta de chocolate', '08/04/2021', '09:00:00', 'Foto5', 'Porción de torta de chocolate', 8.00, 'postre'),
('Lomo saltado', '15/04/2021', '14:30:00', 'Foto6', 'Lomo saltado de carne con papas', 18.00, 'a la carta'),
('Tequeños', '21/06/2021', '15:30:00', 'Foto7', 'Tequeños de queso', 10.00, 'extra'),
('Pollo a la brasa', '22/06/2021', '17:36:00', 'Foto1', 'Pollo con papas', 60.50, 'a la carta'),
('Pollo a la brasa', '23/06/2021', '17:35:00', 'Foto1', 'Pollo con papas', 60.50, 'a la carta'),
('Lomo saltado', '23/07/2021', '15:23:00', 'Foto6', 'Lomo saltado de carne con papas', 18.00, 'a la carta');

---- Promocion

INSERT INTO promocion (codigo, descuento, fecha_inicio, fecha_fin, nombre, fecha_preparacion, hora_preparacion) VALUES
(123456, 20.0, '08/04/2021', '09/04/2021', 'Pollo a la brasa', '08/04/2021', '16:35:00');

---- Delivery

INSERT INTO delivery (distrito, hora, direccion, fecha, dni) VALUES
('Miraflores', '14:00:00', 'Jirón 3 ...', '12/01/2021', 70100771),
('Miraflores', '13:10:00', 'Jirón 4 ...', '22/02/2021', 70444614),
('Miraflores', '10:15:00', 'Jirón 3 ...', '24/03/2021', 70100771),
('Miraflores', '17:00:00', 'Jirón 4 ...', '08/04/2021', 70444614),
('Miraflores', '09:30:00', 'Jirón 4 ...', '09/04/2021', 70444614),
('Barranco', '15:25:00', 'Jirón 5 ...', '15/04/2021', 78456982),
('Barranco', '16:00:00', 'Jirón 6 ...', '21/06/2021', 41563245),
('Barranco', '18:00:00', 'Jirón 6 ...', '22/06/2021', 41563245),
('Barranco', '18:00:00', 'Jirón 6 ...', '23/06/2021', 41563245),
('Barranco', '16:00:00', 'Jirón 5 ...', '23/07/2021', 78456982);

---- Factura

INSERT INTO pago (igv, subtotal, numeracion, fecha_emision, metodo_pago, monto_total, direccion, fecha, hora) VALUES
(10.89, 60.50, 'P001', '12/01/2021','tarjeta de credito', 71.40, 'Jirón 3 ...', '12/01/2021', '14:00:00'),
(3.15, 17.50, 'P002', '22/02/2021', 'efectivo', 20.70, 'Jirón 4 ...', '22/02/2021', '13:10:00'),
(2.25, 12.50, 'P003', '24/03/2021','tarjeta de credito', 14.80, 'Jirón 3 ...', '24/03/2021', '10:15:00'),
(8.71, 48.40, 'P004', '08/04/2021','tarjeta de credito', 57.20, 'Jirón 4 ...', '08/04/2021', '17:00:00'), --Descuento 20%
(1.44, 8.00, 'P005', '09/04/2021', 'efectivo', 9.50, 'Jirón 4 ...', '09/04/2021', '09:30:00'),
(3.24, 18.00, 'P006', '15/04/2021', 'efectivo', 21.30, 'Jirón 5 ...', '15/04/2021', '15:25:00'),
(1.18, 10.00, 'P007', '21/06/2021','tarjeta de credito', 11.80, 'Jirón 6 ...', '21/06/2021', '16:00:00'),
(10.89, 60.50, 'P008', '22/06/2021','tarjeta de credito', 71.40, 'Jirón 6 ...', '22/06/2021', '18:00:00'),
(10.89, 60.50, 'P009', '23/06/2021','tarjeta de credito', 71.40, 'Jirón 6 ...', '23/06/2021', '18:00:00'),
(3.24, 18.00, 'P010', '23/07/2021', 'efectivo', 21.30, 'Jirón 5 ...', '23/07/2021', '16:00:00');

INSERT INTO factura (numeracion, razon_social, ruc) VALUES
('P001', 'SA', '12345678910'),
('P002', 'SAC', '10987654321'),
('P003', 'SA', '12345678910'),
('P004', 'SAC', '10987654321'), --Descuento 20%
('P005', 'SAC', '10987654321'),
('P006', 'EIRL', '45678912310'),
('P007', 'SRL', '78945632115'),
('P008', 'SRL', '78945632115'),
('P009', 'SRL', '78945632115'),
('P010', 'EIRL', '45678912310');

---- Pedido

INSERT INTO pedido (nombre, fecha_preparacion, hora_preparacion, dni, cantidad, direccion, fecha, hora) VALUES
('Pollo a la brasa', '12/01/2021', '13:23:00', 70123456, 1, 'Jirón 3 ...', '12/01/2021', '14:00:00'),
('Arroz con pollo', '22/02/2021', '12:05:10', 70123456, 1, 'Jirón 4 ...', '22/02/2021', '13:10:00'),
('Omelet', '24/03/2021', '10:05:12', 10500468, 1, 'Jirón 3 ...', '24/03/2021', '10:15:00'),
('Pollo a la brasa', '08/04/2021', '16:35:00', 10500468, 1, 'Jirón 4 ...', '08/04/2021', '17:00:00'),
('Torta de chocolate', '08/04/2021', '09:00:00', 10500468, 1, 'Jirón 4 ...', '09/04/2021', '09:30:00'),
('Lomo saltado', '15/04/2021', '14:30:00', 42345687, 1, 'Jirón 5 ...', '15/04/2021', '15:25:00'),
('Tequeños', '21/06/2021', '15:30:00', 42345687, 1, 'Jirón 6 ...', '21/06/2021', '16:00:00'),
('Pollo a la brasa', '22/06/2021', '17:36:00', 70441254, 1, 'Jirón 6 ...', '22/06/2021', '18:00:00'),
('Pollo a la brasa', '23/06/2021', '17:35:00', 70441254, 1, 'Jirón 6 ...', '23/06/2021', '18:00:00'),
('Lomo saltado', '23/07/2021', '15:23:00', 70441254, 1, 'Jirón 5 ...', '23/07/2021', '16:00:00');

---- Entrega

INSERT INTO entrega (direccion, fecha, hora, dni) VALUES
('Jirón 3 ...', '12/01/2021', '14:00:00', 45123578),
('Jirón 4 ...', '22/02/2021', '13:10:00', 45123578),
('Jirón 3 ...', '24/03/2021', '10:15:00', 45123578),
('Jirón 4 ...', '08/04/2021', '17:00:00', 45123578),
('Jirón 4 ...', '09/04/2021', '09:30:00', 45123578),
('Jirón 5 ...', '15/04/2021', '15:25:00', 45712687),
('Jirón 6 ...', '21/06/2021', '16:00:00', 45712687),
('Jirón 6 ...', '22/06/2021', '18:00:00', 45712687),
('Jirón 6 ...', '23/06/2021', '18:00:00', 45712687),
('Jirón 5 ...', '23/07/2021', '16:00:00', 45712687);

---- Recibe

INSERT INTO recibe (numeracion, direccion) VALUES
('P001', 'Jirón 1 ...'),
('P002', 'Jirón 1 ...'),
('P003', 'Jirón 1 ...'),
('P004', 'Jirón 1 ...'),
('P005', 'Jirón 1 ...'),
('P006', 'Jirón 2 ...'),
('P007', 'Jirón 2 ...'),
('P008', 'Jirón 2 ...'),
('P009', 'Jirón 2 ...'),
('P010', 'Jirón 2 ...');
