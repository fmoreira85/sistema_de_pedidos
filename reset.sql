-- Recria o banco de dados do zero e carrega os dados de exemplo.
-- Execute este arquivo no cliente MySQL a partir da pasta do projeto.

DROP DATABASE IF EXISTS sistema_pedidos;

SOURCE schema.sql;
SOURCE seeds.sql;
