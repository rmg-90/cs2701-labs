from config import *

# La siguiente función obtendrá todas las filas que se encuentran en
# la tabla «clientes».
#
# Según el profesor, hacer esto es muy inseguro.

def conseguir_clientes():
    conn, cur = get_connection()
    cur.execute('select * from clientes')
    rows = cur.fetchall()

    for row in rows:
        print(row)

    cur.close()
    conn.close()

conseguir_clientes()
