-- Recuperacao dos dados necessarios para realizar analise no Excel.
-- A consulta foi inserida diretamente no Excel.
-- Dados -> Obter Dados -> Do Banco de Dados -> SQL Server ->
-- Inserido informacoes do Servidor, Banco de Dados e em opções avançadas a consulta abaixo. 

SELECT a.Status
	 , a.Qtde
	 , a.Valor
	 , a.Data
	 , l.Loja
	 , c.NomeCliente
	 , c.SiglaUF
	 , c.Estado
	 , c.Cidade
	 , b.Categoria
	 , b.Segmento
	 , b.Produto
  FROM (
SELECT * FROM Vendas
UNION 
SELECT * FROM Devolucoes) a
LEFT JOIN Lojas l     ON a.IDloja = l.IDLoja
LEFT JOIN Clientes c  ON a.IDCliente = c.IDCliente
LEFT JOIN ( 
	SELECT p.IDProduto
	 , ca.Categoria
	 , p.Segmento
	 , p.Produto
  FROM Produto p
  LEFT JOIN Categoria ca ON p.IDCategoria = ca.IDCategoria ) b ON a.IDProduto = b.IDProduto