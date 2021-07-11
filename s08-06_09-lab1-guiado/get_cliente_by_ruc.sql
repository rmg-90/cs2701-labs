CREATE OR REPLACE FUNCTION get_cliente_by_ruc(p_ruc VARCHAR)
  RETURNS TABLE(clienteid INTEGER, fechaorden DATE)
AS $$
  BEGIN RETURN QUERY
	  SELECT O.clienteid, O.fechaorden
	  FROM clientes C, ordenes O
	  WHERE C.clienteid = O.clienteid
	  AND C.cedula_ruc = p_ruc;
  END;
$$ LANGUAGE plpgsql;
