-- Respondendo Questões de Negócios (Nível Básico (Exploração Geral))

-- 1. Quantas vendas e devoluções foram registradas no total?

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

-- 2. Qual é o valor total das vendas realizadas?

SELECT Status
	 , SUM( Valor ) AS Valor
  FROM #tbl_operacao
  WHERE Status = 'Venda'
  GROUP
	BY Status

-- 3. Qual é o valor total das devolucoes realizadas?

SELECT Status
	 , SUM( Valor ) AS Valor
  FROM #tbl_operacao
  WHERE Status = 'Devolução'
  GROUP
	BY Status

-- 4. Quantos clientes distintos fizeram compras?

SELECT COUNT( DISTINCT IDCliente ) AS Clientes_Compra
  FROM #tbl_operacao
  WHERE Status = 'Venda'


-- 5. Quantos clientes distintos fizeram devolucao?

SELECT COUNT( DISTINCT IDCliente ) AS Clientes_Devolucao
  FROM #tbl_operacao
  WHERE Status = 'Devolução'

-- 6. Qual é a média de valor por venda?

SELECT ROUND(AVG( VALOR ),2) AS Media_Valor_Venda
  FROM Vendas




