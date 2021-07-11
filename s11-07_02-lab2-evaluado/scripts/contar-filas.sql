-- Este script muestra el conteo de las filas y el resultado esperado
-- que el profesor puso en los comentarios en el archivo SQL que fue
-- incluido en el ZIP que contenía los datos.

\echo Expected: 856421
SELECT COUNT(*) FROM lab11.actor100;
\echo Expected: 72696
SELECT COUNT(*) FROM lab11.pelicula100;
\echo Expected: 2170526
SELECT COUNT(*) FROM lab11.personaje100; 
\echo Expected: 440234
SELECT COUNT(*) FROM lab11.actor1000; 
\echo Expected: 22490
SELECT COUNT(*) FROM lab11.pelicula1000; 
\echo Expected: 944964
SELECT COUNT(*) FROM lab11.personaje1000; 
\echo Expected: 197219
SELECT COUNT(*) FROM lab11.actor10000; 
\echo Expected: 6401
SELECT COUNT(*) FROM lab11.pelicula10000; 
\echo Expected: 372367
SELECT COUNT(*) FROM lab11.personaje10000; 

\echo Expected: 856421
SELECT COUNT(*) FROM lab11i.actor100; 
\echo Expected: 72696
SELECT COUNT(*) FROM lab11i.pelicula100; 
\echo Expected: 2170526
SELECT COUNT(*) FROM lab11i.personaje100; 
\echo Expected: 440234
SELECT COUNT(*) FROM lab11i.actor1000; 
\echo Expected: 22490
SELECT COUNT(*) FROM lab11i.pelicula1000; 
\echo Expected: 944964
SELECT COUNT(*) FROM lab11i.personaje1000; 
\echo Expected: 197219
SELECT COUNT(*) FROM lab11i.actor10000; 
\echo Expected: 6401
SELECT COUNT(*) FROM lab11i.pelicula10000; 
\echo Expected: 372367
SELECT COUNT(*) FROM lab11i.personaje10000; 

