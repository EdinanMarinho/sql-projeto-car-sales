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

SELECT Status
	 , SUM( Valor ) AS Valor
  FROM #tbl_operacao
  WHERE Status = 'Venda'
  GROUP
	BY Status

-- 3. Qual � o valor total das devolucoes realizadas?

SELECT Status
	 , SUM( Valor ) AS Valor
  FROM #tbl_operacao
  WHERE Status = 'Devolu��o'
  GROUP
	BY Status

-- 4. Quantos clientes distintos fizeram compras?

SELECT COUNT( DISTINCT IDCliente ) AS Clientes_Compra
  FROM #tbl_operacao
  WHERE Status = 'Venda'


-- 5. Quantos clientes distintos fizeram devolucao?

SELECT COUNT( DISTINCT IDCliente ) AS Clientes_Devolucao
  FROM #tbl_operacao
  WHERE Status = 'Devolu��o'

-- 6. Qual � a m�dia de valor por venda?

SELECT ROUND(AVG( VALOR ),2) AS Media_Valor_Venda
  FROM Vendas

-- 7. Qual � a Loja com Maior N�mero de Vendas? Em termos de Quantidade.
-- Forma mais simples e pr�tica de responder a pergunta

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

-- 8. Qual � a Loja com Maior N�mero de Vendas? Em termos de Valor (R$).

SELECT TOP 1 WITH TIES 
	   b.Loja
	 , SUM( a.Valor ) AS Valor_Total
  FROM Vendas a
  JOIN Lojas  b ON a.IDloja = b.IDLoja
  GROUP BY b.Loja
  ORDER BY Valor_Total DESC

-- 9. Quais s�o as Cinco Marcas mais vendidas em termos de quantidade? 
SELECT TOP 5 WITH TIES
	   LEFT( b.Produto, CHARINDEX('�', b.Produto)) AS Marca_Produto
	 , SUM( a.Qtde) AS Qtde_Total
  FROM Vendas a
  JOIN Produto b ON a.IDProduto = b.IDProduto
  GROUP BY LEFT( b.Produto, CHARINDEX('�', b.Produto))
  ORDER BY Qtde_Total DESC

-- 10. Qual � a categoria de ve�culos mais vendida?
SELECT TOP 1 WITH TIES
	   c.Categoria   AS Categoria
	 , SUM( a.Qtde ) AS Qtde_Total
  FROM Vendas      a
  JOIN Produto     b ON a.IDProduto = b.IDProduto
  JOIN Categoria   c ON b.IDCategoria = c.IDCategoria  
  GROUP BY c.Categoria
  ORDER BY Qtde_Total DESC
