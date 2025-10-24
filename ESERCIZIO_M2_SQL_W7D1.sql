USE AdventureWorksDW;

##Pagina 1, Esercizio 1
DESCRIBE dimproduct;

##Pagina 1, Esercizio 2
DESCRIBE factresellersales;

DESCRIBE dimgeography;

##Pagina 1, Esercizio 3
#Conta il numero transazioni SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020
SELECT COUNT(SalesOrderLineNumber) FROM factresellersales WHERE OrderDate >= '2020-01-01';

##Pagina 1, Esercizio 4
#Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct)
#a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!
SELECT 	p.EnglishProductName AS nome_prodotto,
		SUM(s.SalesAmount) AS fatturato,
        SUM(s.OrderQuantity) AS quantita,
        AVG(s.UnitPrice) AS prezzo_medio
FROM factresellersales s
LEFT JOIN dimproduct p
ON s.ProductKey = p.ProductKey
WHERE OrderDate >= '2020-01-01'
GROUP BY p.EnglishProductName;

##Pagina 2, Esercizio 1
#Calcola il fatturato totale FactResellerSales.SalesAmount) e la quantità totale venduta FactResellerSales.OrderQuantity) per Categoria prodotto DimProductCategory).
#Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!
SELECT 	c.EnglishProductCategoryName AS categoria,
		SUM(s.SalesAmount) AS fatturato,
        SUM(s.OrderQuantity) AS quantita
FROM factresellersales s
LEFT JOIN dimproduct p
ON p.ProductKey = s.ProductKey
LEFT JOIN dimproductsubcategory sc
ON sc.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN dimproductcategory c
ON c.ProductCategoryKey = sc.ProductCategoryKey
WHERE OrderDate >= '2020-01-01'
GROUP BY c.EnglishProductCategoryName;

##Pagina 2, Esercizio 2
#Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.
SELECT g.City, SUM(s.SalesAmount) AS fatturato
FROM factresellersales s
INNER JOIN dimreseller r
ON s.ResellerKey = r.ResellerKey
INNER JOIN dimgeography g
ON r.GeographyKey = g.GeographyKey
WHERE s.OrderDate >= '2020-01-01'
GROUP BY g.City
HAVING SUM(s.SalesAmount) > 60000;