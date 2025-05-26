# This script contains SQL queries to analyze PostgreSQL buffer/cache hit rates.
# Each query is intended to be run in a PostgreSQL client (e.g., psql) to gather statistics.

# Query 1: Calculate buffer hit rate for all databases
SELECT blks_hit, blks_read, ROUND((blks_hit :: float / (blks_hit + blks_read ))* 100 , 2) AS hit_rate FROM pg_stat_database;

# Query 2: (Incorrect syntax, for reference) Attempt to select hit rate directly (contains errors)
SELECT blks_hit, blks_read FROM ((blks_hit / (blks_hit + blks_read)) * 100) as hit_rate pg_stat_database;
# HINT:  No function matches the given name and argument types. You might need to add explicit type casts.

# Query 3: Calculate buffer hit rate for databases with at least one block hit
SELECT 
    blks_hit, 
    blks_read, 
    ROUND((blks_hit  / (blks_hit ::float + blks_read::float)) * 100, 2) AS hit_rate 
FROM 
    pg_stat_database
WHERE 
    blks_hit > 0;

# ERROR:  function round(double precision, integer) does not exist
# LINE 4:     ROUND((blks_hit :: float/ (blks_hit + blks_read)) * 100,...

############

# Query 4: Calculate buffer hit rate for each user table, ordered by hit rate descending
SELECT relname ,
shared_blks_hit ,
shared_blks_read ,
ROUND (( shared_blks_hit / ( shared_blks_hit + shared_blks_read ) ) * 100 , 2) AS hit_rate
FROM pg_statio_user_tables
ORDER BY hit_rate DESC ;

# Query 5: Show buffer statistics for each user table (without hit rate calculation)
SELECT 
    relname,
    shared_blks_hit,
    shared_blks_read
FROM 
    pg_statio_user_tables;