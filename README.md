# Projeto Car Sales
## 1. Contexto

## 2. Premissas Assumidas

1. A análise foi realizada com dados entre 14/01/2022 e 06/10/2024
2. Projeto de Análise de Vendas para apoiar novas ações de expansão do negócio
3. As 3 principais visões desse projeto foram: Análise de Vendas, Análise de Devolução e Análise Estratégica para saber quais são os produtos mais vendidos e o impacto no faturamento final.

## 3. Recursos Utilizados

Para o desenvolvimento do projeto, foram utilizadas as seguintes ferramentas:

### 3.1 SQL Server 
Base de dados e criação de Views para conexão com o DataFlow (Fluxo de Dados) no Microsoft Fabric, permitindo a conexão posterior ao Power BI. Acesse o artigo sobre essa etapa  <a href="https://edinanmarinho.com.br/entendendo-o-banco-de-dados-e-criando-views-no-sql-server-para-o-projeto-car-sales/" target="_blank">clicando aqui</a>


### 3.2 Pasta de Trabalho Excel 
Utilizada para armazenar metas de faturamento para cada ano/mês e integrada ao fluxo de dados. Acesse o artigo com mais detalhes sobre essa etapa <a href="https://edinanmarinho.com.br/como-o-excel-e-sql-junto-ao-power-query-reduziram-o-tempo-de-analise-no-projeto-car-sales/" target="_blank">clicando aqui</a>

### 3.3 Microsoft Fabric 
Utilização dos recursos de Fluxo de Dados (Gen 2) para carregar os dados do SQL Server e Excel. Acesse artigo com mais detalhes sobre a etapa do Fluxo de Dados Gen2 no Fabric <a href="https://edinanmarinho.com.br/como-criei-um-fluxo-de-dados-gen2-no-microsoft-fabric-para-analise-de-vendas-no-projeto-car-sales/" target="_blank">clicando aqui!</a>

### 3.4 Power BI 
Ferramenta principal para o desenvolvimento do dashboard. Acesse artigo com mais detalhes sobre como foi o desenvolvimento do dashboard <a href="https://edinanmarinho.com.br/meu-desenvolvimento-do-dashboard-car-sales-no-power-bi/" target="_blank">clicando aqui!</a>

### 3.5 Figma 
Criação do layout do dashboard, garantindo uma abordagem focada em visualização de dados e UX/UI Design com um layout leve.

## 4. Desenvolvimento do Projeto

### 4.1 Tratamento e Medidas

Após a importação dos dados via Fluxo de Dados no Power BI Desktop, foi realizada uma verificação adicional para ajustes:

* Conversão de valores numéricos para formato decimal fixo ($), garantindo a consistência dos dados.

* Categorização de tabelas e colunas:

* dCalendario: Definição como tabela de data, configuração de ordenação por MesInt e AnoMesInt.

* dProdutos: Categorização de colunas com imagens como URL da imagem.

* dClientes: Definição de categorias considerando estado e cidade.

### 4.2 Ajustes no Banco de Dados e Planilha de Metas

* Conversão da coluna de data, anteriormente armazenada como inteiro (int), para o formato correto de data.

* Definição de perguntas de negócios que o projeto buscará responder.

### 4.3 Criação do Esquema de Dados

Desenvolvimento de um esquema de dados para facilitar a criação de consultas e otimizar a análise.
![image alt](https://github.com/EdinanMarinho/sql-projeto-car-sales/blob/51a26155878c8c1ae965944309ee1e5512f18ef8/meu-esquema-de-dados.png)

### 4.4 Criação de Consultas para Análise no Excel

* Construção de uma consulta SQL para extração e análise rápida dos dados no Excel.

* O objetivo é acelerar a criação do projeto e, futuramente, considerar abordagens mais avançadas, como clusterização e previsão de vendas com Python.

### 4.5 Importação de Planilha de Feriados

* Importação de dados de feriados nacionais a partir do site da Anbima.

* Criação de uma coluna condicional para indicar dias úteis:

   * Se a coluna "feriado" for diferente de "null", retorna 0 (feriado).

   * Se a coluna "dia da semana" for 0 (domingo) ou 6 (sábado), retorna 0 (não útil).

   * Caso contrário, retorna 1 (dia útil).

### 4.6 Criação de Medidas

* Foram criadas medidas gerais, de inteligência de tempo e de metas.

* Organização das medidas em três pastas distintas para facilitar a manutenção.


# Acessar mais detalhes do projeto
Confira mais detalhes sobre o desenvolvimento do projeto clicando no link <a href="https://projetos.edinanmarinho.com.br/dashboard-car-sales-com-power-bi-microsoft-fabric-sql-server-e-excel/"> Página do Projeto</a>
