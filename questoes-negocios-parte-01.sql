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

-- 7. Qual é a Loja com Maior Número de Vendas? Em termos de Quantidade.
-- Forma mais simples e prática de responder a pergunta

SELECT TOP 1 WITH TIES 
	   b.Loja
	 , SUM( a.Qtde ) AS Total
  FROM Vendas a
  JOIN Lojas  b ON a.IDloja = b.IDLoja
  GROUP BY b.Loja
  ORDER BY Total DESC

-- Outra maneira com MAX & SUBQUERY
SELECT b.Loja
	 , SUM(a.Qtde) AS Total
  FROM Vendas a
  JOIN Lojas b ON a.IDloja = b.IDLoja
  GROUP BY b.Loja
  HAVING SUM(a.Qtde) = (
      SELECT MAX(Total) 
      FROM (
          SELECT SUM(Qtde) AS Total
          FROM Vendas
          GROUP BY IDloja
      ) AS c
)

-- 8. Qual é a Loja com Maior Número de Vendas? Em termos de Valor (R$).

SELECT TOP 1 WITH TIES 
	   b.Loja
	 , SUM( a.Valor ) AS Valor_Total
  FROM Vendas a
  JOIN Lojas  b ON a.IDloja = b.IDLoja
  GROUP BY b.Loja
  ORDER BY Valor_Total DESC

-- 9. Quais são as Cinco Marcas mais vendidas em termos de quantidade? 
SELECT TOP 5 WITH TIES
	   LEFT( b.Produto, CHARINDEX(' ', b.Produto)) AS Marca_Produto
	 , SUM( a.Qtde) AS Qtde_Total
  FROM Vendas a
  JOIN Produto b ON a.IDProduto = b.IDProduto
  GROUP BY LEFT( b.Produto, CHARINDEX(' ', b.Produto))
  ORDER BY Qtde_Total DESC

-- 10. Qual é a categoria de veículos mais vendida?
SELECT TOP 1 WITH TIES
	   c.Categoria   AS Categoria
	 , SUM( a.Qtde ) AS Qtde_Total
  FROM Vendas      a
  JOIN Produto     b ON a.IDProduto = b.IDProduto
  JOIN Categoria   c ON b.IDCategoria = c.IDCategoria  
  GROUP BY c.Categoria
  ORDER BY Qtde_Total DESC

-- 11. Qual o ticket médio das vendas por loja?
SELECT b.Loja AS Loja
	 , ROUND( SUM( a.Valor) / SUM( a.Qtde ),2 ) AS Ticket_Medio
  FROM Vendas a
  JOIN  Lojas  b ON a.IDloja = b.IDLoja
  GROUP BY b.Loja
  ORDER BY Ticket_Medio DESC

-- 12 .Quais são os três estados com maior volume de vendas?
SELECT TOP 3 WITH TIES
	   b.Estado AS Estado
	 , SUM( a.Valor ) AS Total_Vendas
  FROM Vendas a
  JOIN Clientes b ON a.IDCliente = b.IDCliente
  GROUP BY b.Estado
  ORDER BY Total_Vendas DESC

-- 13. Em qual mês ocorreu o maior número de vendas?
SELECT TOP 1 WITH TIES
	   YEAR( Data )  AS ANO
	 , MONTH( Data ) AS MES
	 , SUM( Qtde )   AS Qtde_Total
	 , SUM( Valor )  AS Valor_Total
  FROM Vendas
  GROUP BY YEAR( Data ), MONTH( Data )
  ORDER BY Valor_Total DESC

--14 .Quais são os três estados com maior volume de devolução?
SELECT TOP 3 WITH TIES
	   b.Estado AS Estado
	 , SUM( a.Valor ) AS Total_Devolucao
  FROM Devolucoes a
  JOIN Clientes   b ON a.IDCliente = b.IDCliente
  GROUP BY b.Estado
  ORDER BY Total_Devolucao DESC

-- 15. Em qual mês ocorreu o maior número de devolucao?
SELECT TOP 1 WITH TIES
	   YEAR( Data )  AS Ano
	 , MONTH( Data ) AS Mes
	 , SUM( Qtde )   AS Qtde_Total
	 , SUM( Valor )  AS Devolucao_Total
  FROM Devolucoes
  GROUP BY YEAR( Data ), MONTH( Data )
  ORDER BY Devolucao_Total DESC

-- 16. Qual é a categoria de veículos que teve mais devolucao?
SELECT TOP 1 WITH TIES
	   c.Categoria
	 , SUM( a.Qtde )  AS Qtd_Total_Devolucao
	 , SUM( a.Valor ) AS Devolucao_Total
  FROM Devolucoes a
  JOIN Produto b on a.IDProduto = b.IDProduto
  JOIN Categoria c ON b.IDCategoria = c.IDCategoria
  GROUP BY c.Categoria
  ORDER BY Devolucao_Total DESC

-- 17. Qual é o segmento de veiculos que mais teve venda? Em Qtde?
SELECT TOP 1 WITH TIES
	   b.Segmento
	 , SUM( a.Qtde )  AS Qtde_Total
	 , SUM( a.Valor ) AS Valor_Total
  FROM vw_fVendas a
  JOIN vw_dProdutos b ON a.IDProduto = b.IDProduto
  WHERE a.Status = 'Venda'
  GROUP BY b.Segmento
  ORDER BY Qtde_Total DESC


-- 18. Qual é o segmento de veiculos que mais teve venda? Em Valor?
SELECT TOP 1 WITH TIES
	   b.Segmento
	 , SUM( a.Qtde )  AS Qtde_Total
	 , SUM( a.Valor ) AS Valor_Total
  FROM vw_fVendas a
  JOIN vw_dProdutos b ON a.IDProduto = b.IDProduto
  WHERE a.Status = 'Venda'
  GROUP BY b.Segmento
  ORDER BY Valor_Total DESC




