SET search_path = a2021_1_sec1_lab7_grupo2;

--- (a)

---- Enunciado

-- Elabore un consulta SQL para mostrar el chef que tiene más comidas preparadas (tome como referencia el monto total de comidas pagadas)

---- Consulta

SELECT Pr.nombre, Pr.apellido, SUM(Pa.monto_total) AS monto_total
FROM planilla Pl
INNER JOIN persona Pr ON Pl.dni = Pr.dni
INNER JOIN pedido Pe ON pr.dni = Pe.dni
INNER JOIN Delivery De ON Pe.fecha = De.fecha AND Pe.hora = De.hora AND Pe.direccion = De.direccion
INNER JOIN Pago Pa ON De.fecha = Pa.fecha AND De.hora = Pa.hora AND De.direccion = Pa.direccion

WHERE Pl.area_trabajo = 'cocina' AND (Pe.nombre, Pe.fecha_preparacion, Pe.hora_preparacion) IN (
	SELECT Co.nombre, Co.fecha_preparacion, Co.hora_preparacion
	FROM comida Co
	INNER JOIN pedido Pe ON Co.nombre = Pe.nombre AND Co.fecha_preparacion = Pe.fecha_preparacion AND Co.hora_preparacion = Pe.hora_preparacion
	INNER JOIN Delivery De ON Pe.fecha = De.fecha AND Pe.hora = De.hora AND Pe.direccion = De.direccion
	INNER JOIN Pago Pa ON De.fecha = Pa.fecha AND De.hora = Pa.hora AND De.direccion = Pa.direccion
)
GROUP BY (Pr.nombre, Pr.apellido)
HAVING SUM(Pa.monto_total) = (
	SELECT MAX(monto_total)
	FROM(
        SELECT SUM(Pa.monto_total) AS monto_total
		FROM planilla Pl
		INNER JOIN persona pr ON pl.dni = pr.dni
		INNER JOIN pedido Pe ON pr.dni = Pe.dni
		INNER JOIN Delivery De ON Pe.fecha = De.fecha AND Pe.hora = De.hora AND Pe.direccion = De.direccion
		INNER JOIN Pago Pa ON De.fecha = Pa.fecha AND De.hora = Pa.hora AND De.direccion = Pa.direccion
        WHERE Pl.area_trabajo = 'cocina' AND (Pe.nombre, Pe.fecha_preparacion, Pe.hora_preparacion) IN (
			SELECT Co.nombre, Co.fecha_preparacion, Co.hora_preparacion
			FROM comida Co
            INNER JOIN pedido Pe ON Co.nombre = Pe.nombre AND Co.fecha_preparacion = Pe.fecha_preparacion AND Co.hora_preparacion = Pe.hora_preparacion
			INNER JOIN delivery De ON Pe.fecha = De.fecha AND Pe.hora = De.hora AND Pe.direccion = De.direccion
			INNER JOIN Pago Pa ON De.fecha = Pa.fecha AND De.hora = Pa.hora AND De.direccion = Pa.direccion
		)
        GROUP BY (Pr.nombre, Pr.apellido)
    	) AS monto_total_pagado);


---- Resultado

/*
 * $ psql -U postgres -f main.sql -q
 * 
 *  nombre  | apellido |    monto_total     
 * ---------+----------+--------------------
 *  Enrique | Martinez | 164.10000000000002
 * (1 row)
 * 
 */

--- (b)

---- Enunciado

-- Elabore un consulta SQL para mostrar las ventas por mes del 2021

---- Consulta

SELECT DATE_PART('month', fecha_emision) AS mes, SUM(monto_total) AS total_de_mes
FROM pago
WHERE DATE_PART('year', fecha_emision) = 2021
GROUP BY DATE_PART('month', fecha_emision);

---- Resultado

/*
 * $ psql -U postgres -f main.sql -q
 * 
 *  mes |    total_de_mes
 * -----+--------------------
 *    1 |               71.4
 *    2 |               20.7
 *    3 |               14.8
 *    4 |                 88
 *    6 | 154.60000000000002
 *    7 |               21.3
 * (6 rows)
 *
 */
