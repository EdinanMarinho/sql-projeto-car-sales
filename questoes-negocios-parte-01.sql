-- Respondendo Quest�es de Neg�cios (N�vel B�sico (Explora��o Geral))

-- 1. Quantas vendas e devolu��es foram registradas no total?


SELECT a.Status
	 , SUM(a.Qtde) AS Qtde
  FROM
(
SELECT * FROM Vendas
UNION
SELECT * FROM Devolucoes 
) a
 GROUP
	BY a.Status
 ORDER 
	BY Qtde DESC

-- Usando Tabela Temporaria

SELECT Status
	 , SUM(Qtde) AS Qtde
  FROM #tbl_operacao
 GROUP
	BY Status
  
-- Criando Tabela Temporaria
SELECT 
* 
  INTO #tbl_operacao
  FROM
(
SELECT * FROM Vendas
UNION
SELECT * FROM Devolucoes 
) a

-- 2. Qual � o valor total das vendas realizadas?
-- 3. Quantos clientes distintos fizeram compras?

