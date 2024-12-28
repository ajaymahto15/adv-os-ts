create table pricing (id int, price money);

insert into pricing (id, price)
select id, floor(random() * 1000 + 1)::int::money
from generate_series(1, 100) as id;

select * from pricing where id = 10;

explain (analyze, buffers, costs off) select * from pricing where id = 10;


###

create extension pg_buffercache;
select * from pg_buffercache_summary();

SELECT n.nspname, c.relname, count(*) AS buffers
FROM pg_buffercache b JOIN pg_class c
ON b.relfilenode = pg_relation_filenode(c.oid) AND
b.reldatabase IN (0, (SELECT oid FROM pg_database
WHERE datname = current_database()))
JOIN pg_namespace n ON n.oid = c.relnamespace
GROUP BY n.nspname, c.relname
ORDER BY 3 DESC
LIMIT 10;



SELECT bufferid,
relblocknumber,
isdirty,
usagecount,
pinning_backends
FROM pg_buffercache
WHERE relfilenode = pg_relation_filenode('pricing'::regclass);

UPDATE pricing SET price = 450::money where id = 10;


insert into pricing (id, price)
select id, floor(random() * 1000 + 1)::int::money
from generate_series(101, 100000) as id;

explain (analyze, buffers, costs off) select * from pricing where id = 10;

explain (analyze, buffers, costs off) select * from pricing;

alter table pricing add primary key(id);

vacuum analyze;

explain (analyze, buffers, costs off) select * from pricing where id = 10;


## New Session
explain (analyze, buffers, costs off) select * from pricing where id = 10;

explain (analyze, buffers, costs off) select * from pricing where id = 510;

SELECT bufferid,
relblocknumber,
isdirty,
usagecount,
pinning_backends
FROM pg_buffercache
WHERE relfilenode = pg_relation_filenode('pricing_pkey'::regclass);


postgres=# explain (analyze, buffers, costs off) select * from pricing where id = 10;
                                     QUERY PLAN                                     
------------------------------------------------------------------------------------
 Index Scan using pricing_pkey on pricing (actual time=0.017..0.018 rows=1 loops=1)
   Index Cond: (id = 10)
   Buffers: shared hit=3
 Planning Time: 0.070 ms
 Execution Time: 0.034 ms