CREATE DATABASE IF NOT EXISTS indigoiam;
CREATE USER IF NOT EXISTS indigoiam@'%' IDENTIFIED BY 'secret';
SET PASSWORD FOR indigoiam@'%' = PASSWORD('secret');
GRANT ALL ON indigoiam.* TO indigoiam@'%';
