# CAR-SALES-ANALYSIS
Este projeto aplica técnicas de Business Intelligence (BI) e análise de dados no setor automóvel para extrair insights estratégicos

Análise de Vendas de Automóveis (CarSales Analytics)

Repositório dedicado à análise exploratória de dados de vendas de veículos (carSales_menor), utilizando PostgreSQL e pgAdmin 4 para responder a perguntas estratégicas de negócio, avaliar o desempenho comercial, calcular preços médios e analisar métricas de comissão da equipa de vendas.

📋 Sobre o Projeto

Este projeto consiste numa análise de dados aplicada ao setor automóvel, visando apoiar a tomada de decisões comerciais. Os valores de vendas foram convertidos e calculados em Meticais (MT) para contextualizar a análise no mercado moçambicano.

Os principais pilares da análise incluem:

Volume Geral: Avaliação do volume de transações registadas na base de dados.

Distribuição por Marca: Desempenho comercial individual das marcas de veículos (Ford, Honda, Nissan, Chevrolet, Toyota).

Análise Temporal: Evolução mensal de vendas entre os anos de 2022 e 2023.

Métricas Financeiras (MT): Determinação dos preços médios por veículo e faturação total.

Desempenho Comercial: Identificação dos melhores vendedores por receita gerada e por taxa de comissão acumulada.

🛠️ Tecnologias e Ferramentas

SGBD: PostgreSQL 18

Interface de Gestão: pgAdmin 4

Linguagem: SQL (DDL, DML e Agregações Avançadas)

❓ Perguntas de Negócio, Consultas SQL e Resultados

1. Volume Total de Vendas

Pergunta: Qual é o volume total de vendas de veículos registado na base de dados?

SELECT COUNT(*) AS quant_modelo 
FROM "carSales_menor";


Resultado: Total de 25.000 vendas registadas.

2. Distribuição de Vendas por Marca

Pergunta: Qual é a distribuição do número de vendas por marca de automóvel?

SELECT "Car Make", COUNT(*) AS quant_modelo
FROM "carSales_menor"
GROUP BY "Car Make"
ORDER BY quant_modelo DESC;


Resultados:

Ford: 5.106 vendas

Honda: 5.098 vendas

Nissan: 5.016 vendas

Chevrolet: 4.919 vendas

Toyota: 4.861 vendas

3. Análise Mensal de Vendas por Marca (2022 / 2023)

Pergunta: Como se comportou o volume de vendas por marca ao longo dos meses em 2023?

SELECT 
    "Car Make", 
    EXTRACT(YEAR FROM "Date"::DATE) AS ano,
    EXTRACT(MONTH FROM "Date"::DATE) AS mes,
    COUNT(*) AS total_vendas
FROM "carSales_menor"
WHERE EXTRACT(YEAR FROM "Date"::DATE) = 2023
GROUP BY "Car Make", EXTRACT(YEAR FROM "Date"::DATE), EXTRACT(MONTH FROM "Date"::DATE)
ORDER BY ano, mes, total_vendas DESC;


Resultados (Destaques):

Janeiro/2023: Liderança da Honda (445 vendas), seguida da Nissan (442) e Ford (438).

Fevereiro/2023: Destaque para Ford (402 vendas) e Nissan (387).

Maio/2022: Destaque para Chevrolet (413 vendas) e Nissan/Honda (410 vendas cada).

4. Preço Médio de Venda por Marca (em Meticais - MT)

Pergunta: Qual é o preço médio de venda dos veículos por marca nos anos de 2022 e 2023 (em MT)?

SELECT 
    "Car Make",
    EXTRACT(YEAR FROM "Date"::DATE) AS ano,
    ROUND(AVG("Sale Price") * 64, 2) AS media_venda_mt
FROM "carSales_menor"
GROUP BY "Car Make", EXTRACT(YEAR FROM "Date"::DATE)
ORDER BY media_venda_mt DESC;


Resultados:

Ford (2023): 1.956.198,40 MT

Toyota (2023): 1.949.664,00 MT

Chevrolet (2023): 1.941.907,20 MT

Nissan (2022): 1.941.766,40 MT

Ford (2022): 1.928.614,40 MT

5. Faturação Total por Vendedor (em Meticais - MT)

Pergunta: Quais são os vendedores que geraram maior receita total para a empresa?

SELECT 
    "Salesperson",
    COUNT(*) AS quant_vendas,
    ROUND(AVG("Sale Price") * 64, 2) AS media_venda_mt,
    ROUND(SUM("Sale Price") * 64, 2) AS valor_total_vendas_mt
FROM "carSales_menor"
GROUP BY "Salesperson"
ORDER BY valor_total_vendas_mt DESC;


Top Vendedores (Faturação):

David Smith: 29.486.848,00 MT (16 vendas | Média: 1.842.928,00 MT)

Christopher Johnson: 28.521.856,00 MT (15 vendas | Média: 1.901.457,07 MT)

Robert Smith: 26.984.384,00 MT (13 vendas | Média: 2.075.721,80 MT)

Christopher Smith: 24.458.560,00 MT (11 vendas | Média: 2.223.505,28 MT)

6. Top 10 Vendedores por Taxa de Comissão

Pergunta: Quais são os 10 vendedores com maior soma acumulada de comissões?

SELECT 
    "Salesperson", 
    SUM("Commission Rate") AS soma_comissao
FROM "carSales_menor"
GROUP BY "Salesperson"
ORDER BY soma_comissao DESC
LIMIT 10;


Resultados:

David Smith: 1.6893 (168,93%)

Christopher Johnson: 1.3452 (134,52%)

James Johnson: 1.3440 (134,40%)

Robert Smith: 1.2860 (128,60%)

Christopher Smith: 1.1753 (117,53%)
