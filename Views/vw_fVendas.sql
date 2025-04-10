-- CRIACAO DA VIEW DA TABELA FATO VENDAS
-- Foi analisado previamente e constatado que havia a mesma quantidade de colunas
-- E por isso resolvi fazer dessa forma

CREATE VIEW  AS vw_fVendas
SELECT * FROM Vendas 
UNION
SELECT * FROM Devolucoes