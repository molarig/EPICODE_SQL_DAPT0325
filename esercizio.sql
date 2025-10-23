DESCRIBE dimproduct;

DESCRIBE factresellersales;

#Conta il numero transazioni SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020
SELECT COUNT(SalesOrderLineNumber) FROM factresellersales WHERE OrderDate >= '2020-01-01';

#Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct)
#a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!
SELECT SUM(SalesAmount) AS fatturato, COUNT(OrderQuantity) AS quantita, AVG(UnitPrice) AS prezzo_medio
FROM factresellersales
WHERE OrderDate >= '2020-01-01';

#Calcola il fatturato totale FactResellerSales.SalesAmount) e la quantità totale venduta FactResellerSales.OrderQuantity) per Categoria prodotto DimProductCategory).
#Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!
SELECT c.EnglishProductCategoryName, SUM(s.SalesAmount) AS fatturato, COUNT(s.OrderQuantity) AS quantita
FROM factresellersales s
LEFT JOIN dimproduct p
ON p.ProductKey = s.ProductKey
LEFT JOIN dimproductsubcategory sc
ON sc.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN dimproductcategory c
ON c.ProductCategoryKey = sc.ProductCategoryKey
WHERE OrderDate >= '2020-01-01'
GROUP BY c.EnglishProductCategoryName;

#Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.
SELECT g.City, SUM(s.SalesAmount) AS fatturato
FROM factresellersales s
INNER JOIN dimgeography g
ON s.SalesTerritoryKey = g.SalesTerritoryKey
WHERE s.OrderDate >= '2020-01-01'
GROUP BY g.City
HAVING SUM(s.SalesAmount) > '60000';

