
-- Atualizacao VIEW trazendo a Marca atraves da funcao CHARINDEX
-- junto com LEFT para retornar somente a marca do Produto
ALTER VIEW vw_dProdutos

AS

SELECT p.IDProduto                                  AS IDProduo
	 , p.Produto                                    AS Produto
	 , p.Segmento                                   AS Segmento
	 , c.Categoria                                  AS Categoria
	 , LEFT( Produto, CHARINDEX(' ', p.Produto) -1) AS Marca
	 , p.Preco                                      AS Preco
	 , P.ImagemProduto                              AS ImagemProduto
	 , P.Marca                                      AS ImagemMarca
	 , c.Imagemcategoria                            AS ImagemCategoria
  FROM Produto p
  JOIN Categoria c ON p.IDCategoria = c.IDCategoria



SELECT * FROM vw_dProdutos