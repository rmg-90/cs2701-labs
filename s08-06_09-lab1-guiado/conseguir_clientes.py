import psycopg2

# Para que este comando funcione correctamente, es necesario que
#
# + La base de datos exista
# + La tabla clientes haya sido creada
# + El usuario especificado tenga los permisos necesarios para leer la tabla.

conn = psycopg2.connect(dbname = 'sem8',
                        user = 'postgres');

cur = conn.cursor()

cur.execute('select * from clientes;')

for row in cur.fetchall():
    print(row[0], row[1], row[2])
    
cur.close()
conn.close()
