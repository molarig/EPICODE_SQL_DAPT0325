USE AdventureWorksDW;

##Pagina 1, ESERCIZIO 1
#Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory)

#Join
SELECT p1.ProductKey, p1.EnglishProductName, s1.EnglishProductSubcategoryName
FROM dimproduct AS p1
LEFT JOIN dimproductsubcategory AS s1
ON p1.productsubcategorykey = s1.productsubcategorykey;

#Subquery
SELECT ProductKey, EnglishProductName,
  (SELECT EnglishProductSubcategoryName 
   FROM dimproductsubcategory 
   WHERE dimproductsubcategory.ProductSubcategoryKey = dimproduct.ProductSubcategoryKey
   ) AS Subcategory
FROM dimproduct;

##Pagina 1, ESERCIZIO 2
#Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory)

#Join
SELECT p1.ProductKey, p1.EnglishProductName, c1.EnglishProductCategoryName, s1.EnglishProductSubcategoryName
FROM dimproduct AS p1
LEFT JOIN dimproductsubcategory AS s1
ON p1.ProductSubcategoryKey = s1.ProductSubcategoryKey
LEFT JOIN dimproductcategory AS c1
ON s1.ProductCategoryKey = c1.ProductCategoryKey;

#Subquery
SELECT p.ProductKey, p.EnglishProductName, (
	SELECT s.EnglishProductSubcategoryName
    FROM dimproductsubcategory AS s
    WHERE s.ProductSubcategoryKey = p.ProductSubcategoryKey) AS Subcategory, (
    SELECT c.EnglishProductCategoryName
    FROM dimproductcategory AS c
    WHERE c.ProductCategoryKey = (
		SELECT s.ProductCategoryKey
        FROM dimproductsubcategory AS s
        WHERE s.ProductSubcategoryKey = p.ProductSubcategoryKey)) AS Category
FROM dimproduct AS p;

##Pagina 1, ESERCIZIO 3
#Esponi lʼelenco dei soli prodotti venduti (DimProduct, FactResellerSales)

#Join
SELECT DISTINCT p.ProductKey, p.EnglishProductName
FROM dimproduct AS p
LEFT JOIN factresellersales AS s
ON p.ProductKey = s.ProductKey
WHERE SalesAmount > 0;

#Subquery
SELECT ProductKey, EnglishProductName
FROM dimproduct
WHERE ProductKey IN (
	SELECT DISTINCT ProductKey
    FROM factresellersales
    );
    
##Pagina 1, ESERCIZIO 4
#Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1)

#Join
SELECT DISTINCT p.ProductKey, p.EnglishProductName, p.FinishedGoodsFlag, s.SalesAmount
FROM dimproduct AS p
LEFT JOIN factresellersales as s
ON s.ProductKey = p.ProductKey
WHERE p.FinishedGoodsFlag = 1
AND SalesAmount IS NULL;

#Subquery
SELECT ProductKey, EnglishProductName, FinishedGoodsFlag
FROM dimproduct
WHERE FinishedGoodsFlag = 1
AND ProductKey NOT IN (
	SELECT ProductKey FROM factresellersales
    );
    
##Pagina 1, Esercizio 5
#Esponi lʼelenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)

#Join
SELECT p.EnglishProductName, s.*  
FROM factresellersales s
LEFT JOIN dimproduct p
ON p.ProductKey = s.ProductKey;

#Subquery
SELECT s.*, (
	SELECT p.EnglishProductName
    FROM dimproduct p
    WHERE p.ProductKey = s.ProductKey
    ) AS EnglishProductName
FROM factresellersales s;

##Pagina 2 Esercizio 1
#Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.

#Join
SELECT p.EnglishProductName, c.EnglishProductCategoryName, s.* 
FROM factresellersales s
LEFT JOIN dimproduct p
ON p.ProductKey = s.ProductKey
LEFT JOIN dimproductsubcategory sc
ON sc.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN dimproductcategory c
ON c.ProductCategoryKey = sc.ProductSubcategoryKey;

##Pagina 2 Esercizio 2
#Esplora la tabella DimReseller

SELECT *
FROM dimreseller;

##Pagina 2 Esercizio 3
#Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica

SELECT r.ResellerName, g.GeographyKey, g.City, g.StateProvinceName, g.EnglishCountryRegionName
FROM dimreseller r
LEFT JOIN dimgeography g
ON g.GeographyKey = r.GeographyKey;

#Pagina 2 Esercizio 4
#Esponi lʼelenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.

SELECT p.EnglishProductName, c.EnglishProductCategoryName, sc.EnglishProductSubcategoryName, r.ResellerName, g.City, g.StateProvinceName, g.EnglishCountryRegionName, s.SalesOrderNumber, s.SalesOrderLineNumber, s.OrderDate, s.UnitPrice, s.OrderQuantity, s.TotalProductCost
FROM factresellersales s
LEFT JOIN dimproduct p
ON p.ProductKey = s.ProductKey
LEFT JOIN dimproductsubcategory sc
ON sc.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN dimproductcategory c
ON c.ProductCategoryKey = sc.ProductCategoryKey
LEFT JOIN dimreseller r
ON r.ResellerKey = s.ResellerKey
LEFT JOIN dimgeography g
ON g.GeographyKey = r.GeographyKey;

SELECT * FROM dimproductcategory;
