#sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
#curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
#sudo apt update
#sudo apt install postgresql-17
#sudo systemctl status postgresql
#sudo service postgresql status
#sudo service postgresql start

#psql -V
#psql (PostgreSQL) 17.2 (Ubuntu 17.2-1.pgdg20.04+1)

#id postgres

#CREATE USER npcidba WITH PASSWORD 'Npci@123'
#CREATE database npcibank;
#GRANT ALL PRIVILEGES ON DATABASE npcibank TO npcidba;

CREATE TABLE customer (
customer_id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(150) UNIQUE NOT NULL
);

INSERT INTO customer (name, email) VALUES ('John Doe', 'john.doe@example.com');

# Peer Authentication by default
# psql -U codespace -d npcibank -W 

CREATE TABLE employees (
 id SERIAL PRIMARY KEY,
 name TEXT NOT NULL,
 skills TEXT[]
);

INSERT INTO employees (name, skills) VALUES
('Alice', ARRAY['Python', 'SQL', 'Java']),
('Bob', ARRAY['JavaScript', 'HTML', 'CSS']);

UPDATE employees
SET skills = array_append(skills, 'Docker')
WHERE name = 'Alice';


UPDATE employees
SET skills = array_remove(skills, 'Java')
WHERE name = 'Alice';


SELECT name,skills FROM employees WHERE skills@>ARRAY['Python', 'JavaScript']
SELECT name,skills FROM employees WHERE ARRAY['Python', 'Docker']<@skills;




## === HSTORE
CREATE EXTENSION IF NOT EXISTS hstore;

CREATE TABLE products (
 id SERIAL PRIMARY KEY,
 name TEXT NOT NULL,
 attributes HSTORE
);

\d products; -- DESCRIBE TABLE

INSERT INTO products (name, attributes) VALUES
('Laptop', 'processor => "Intel i5", ram => "8GB", storage => "512GB SSD"'),
('Smartphone', 'processor => "Snapdragon 888", ram => "6GB", storage => "128GB"'),
('Tablet', 'processor => "A12 Bionic", ram => "4GB", storage => "64GB"');



UPDATE products
SET attributes = attributes || 'battery_life => "10 hours"'
WHERE name = 'Laptop';

SELECT name, attributes
FROM products
WHERE attributes->'processor' = 'Intel i5';

SELECT name, attributes->'ram' FROM products;