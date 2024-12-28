SELECT blks_hit, blks_read, ROUND((blks_hit :: float / (blks_hit + blks_read ))* 100 , 2) AS hit_rate FROM pg_stat_database;
SELECT blks_hit, blks_read FROM ((blks_hit / (blks_hit + blks_read)) * 100) as hit_rate pg_stat_database;
# HINT:  No function matches the given name and argument types. You might need to add explicit type casts.

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

SELECT relname ,
shared_blks_hit ,
shared_blks_read ,
ROUND (( shared_blks_hit / ( shared_blks_hit + shared_blks_read ) ) * 100 , 2) AS hit_rate
FROM pg_statio_user_tables
ORDER BY hit_rate DESC ;

SELECT 
    relname,
    shared_blks_hit,
    shared_blks_read
FROM 
    pg_statio_user_tables;