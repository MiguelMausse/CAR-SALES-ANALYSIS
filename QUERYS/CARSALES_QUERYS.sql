SELECT * FROM "carSales"

--quantidade das vendas
SELECT COUNT(*) as quant_modelo FROM "carSales"

--numero de vendas por modelo de automoveis
SELECT "Car Make", COUNT(*) as quant_modelo 
FROM "carSales_menor"
GROUP BY "Car Make"
ORDER BY "Car Make" desc

--quantas vendas por cada mes em 2023
SELECT "Date" , "Car Make", COUNT(*) AS vendas_mes 
FROM "carSales_menor"
GROUP BY "Date", "Car Make"

--vendas por modelo em cada mês de 2022
SELECT 
    "Car Make",
    EXTRACT(YEAR FROM "Date"::DATE) AS ano,
    EXTRACT(MONTH FROM "Date"::DATE) AS mes,
    COUNT(*) AS total_vendas
FROM "carSales_menor"
WHERE EXTRACT(YEAR FROM "Date"::DATE) = 2022
GROUP BY
	    "Car Make",
    EXTRACT(YEAR FROM "Date"::DATE),
    EXTRACT(MONTH FROM "Date"::DATE)
ORDER BY
    ano,
	mes,
    total_vendas DESC;

--vendas por modelo em cada mês de 2023
SELECT 
    "Car Make",
    EXTRACT(YEAR FROM "Date"::DATE) AS ano,
    EXTRACT(MONTH FROM "Date"::DATE) AS mes,
    COUNT(*) AS total_vendas
FROM "carSales_menor"
WHERE EXTRACT(YEAR FROM "Date"::DATE) = 2023 
GROUP BY
	    "Car Make",
    EXTRACT(YEAR FROM "Date"::DATE),
    EXTRACT(MONTH FROM "Date"::DATE)
ORDER BY
    ano,
	mes,
    total_vendas DESC;

  -- QUAL E O PRECO MEDIO DE VENDA DOS VEICULOS 2022 e 23

 SELECT 
    "Car Make",
    EXTRACT(YEAR FROM "Date"::DATE) AS ano,
    ROUND(AVG("Sale Price"), 1) AS media_venda_veicu
FROM "carSales_menor"
GROUP BY
    "Car Make",
	EXTRACT(YEAR FROM "Date"::DATE)
ORDER BY
    media_venda_veicu, "Car Make",
    ano DESC;

--melhores vendedores, QUANTIDE DE VENDAS E A MEDIA POR VENDEDOR

	SELECT DISTINCT("Salesperson") FROM "carSales"

	SELECT
    "Salesperson",
    COUNT(*) AS quant_vendas,
    ROUND(AVG("Sale Price"), 2) AS media_vendas,
    SUM("Sale Price") AS valor_total_vendas
FROM "carSales_menor"
GROUP BY "Salesperson"
ORDER BY valor_total_vendas DESC;

--OS MODELOS DE CARROS QUE GERAM MAIS RECEITA A EMPRESA
SELECT "Car Model", SUM("Sale Price") as total_vendido
FROM "carSales_menor"
GROUP BY "Car Model"
ORDER BY total_vendido DESC

--QUAIS 10 VENDEDORES QUE CONSEGUEM MAIS COMISSOES 

SELECT "Salesperson", SUM("Commission Rate") as media_comissa
FROM "carSales_menor"
GROUP BY "Salesperson"
ORDER BY media_comissa DESC
LIMIT 10 

--criando uma nova tabela
CREATE TABLE "carSales_menor" AS
SELECT *
FROM "carSales"
ORDER BY RANDOM()
LIMIT 250000;

SELECT * FROM "carSales_menor"

SELECT "Salesperson", SUM("Commission Rate") as media_comissa
FROM "carSales_menor"
GROUP BY "Salesperson"
ORDER BY media_comissa DESC
LIMIT 10 
	