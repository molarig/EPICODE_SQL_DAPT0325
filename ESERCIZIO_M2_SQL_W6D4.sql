USE AdventureWorksDW;

##ESERCIZIO 1
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

##ESERCIZIO 2
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

## ESERCIZIO 3
#Esponi lʼelenco dei soli prodotti venduti (DimProduct, FactResellerSales)

#Join
SELECT DISTINCT p.ProductKey, p.EnglishProductName
FROM dimproduct AS p
LEFT JOIN factresellersales AS s
ON s.ProductKey = p.ProductKey
WHERE SalesAmount > 0;
