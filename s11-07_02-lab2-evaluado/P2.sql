set search_path = lab11;
EXPLAIN ANALYSE SELECT * FROM personaje100 WHERE p_nombre=’Fight Club’;
--Planning time: 0.083 ms
--Execution time: 86.964 ms
set search_path = lab11i;
EXPLAIN ANALYSE SELECT * FROM personaje100 WHERE p_nombre=’Fight Club’;
--Planning time: 6.245 ms
--Execution time: 10.581 ms