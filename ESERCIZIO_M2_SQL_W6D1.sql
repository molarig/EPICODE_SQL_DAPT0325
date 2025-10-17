#Pagina 2 Esercizio 1
SHOW DATABASES;

USE AdventureWorksDW;

#Pagina 2 Esercizio 2
SELECT * FROM dimproduct;

SHOW TABLES;

DESCRIBE dimproduct;

#Pagina 2 Esercizio 3
SELECT
	ProductKey,
    ProductAlternateKey,
    EnglishProductName as 'Nome prodotto',
    Color,
    StandardCost,
    FinishedGoodsFlag
FROM
	dimproduct;

#Pagina 2 Esercizio 4 
SELECT
	ProductKey,
    ProductAlternateKey,
    EnglishProductName as 'Nome prodotto',
    Color,
    StandardCost,
    FinishedGoodsFlag
FROM
	dimproduct
WHERE FinishedGoodsFlag = 1;

#Pagina 2 Esercizio 5
SELECT
	ProductKey,
    ProductAlternateKey,
    EnglishProductName as 'Nome prodotto',
    StandardCost,
    ListPrice
FROM
	dimproduct
WHERE
	ProductAlternateKey LIKE 'FR%'
OR 	
	ProductAlternateKey LIKE 'BK%';
    
#Pagina 3 Esercizio 1
SELECT
	ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    StandardCost,
    ListPrice,
    ListPrice - StandardCost AS Markup
FROM
	dimproduct
WHERE
	(ProductAlternateKey LIKE 'FR%'
		OR ProductAlternateKey LIKE 'BK%');
#AND ListPrice-StandardCost IS NULL

#Pagina 3 Esercizio 2
SELECT
	ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    ListPrice,
    StandardCost,
    ListPrice-StandardCost AS Markup
FROM
	dimproduct
WHERE
	FinishedGoodsFlag = 1
AND	
    ListPrice BETWEEN 1000 AND 2000
ORDER BY ListPrice #DESC;

#Pagina 3 Esercizio 3
SELECT *
FROM
	dimemployee;
    
#Pagina 3 Esercizio 4
SELECT
	EmployeeKey,
    ParentEmployeeKey,
    FirstName,
    LastName,
    MiddleName,
    Title,
    DepartmentName,
    SalesPersonFlag,
    Position    
FROM
	dimemployee
WHERE
	SalesPersonFlag = 1;
    
#Pagina 3 Esercizio 5
SELECT *
FROM
	factresellersales;
    
SELECT
	SalesOrderNumber,
    SalesOrderLineNumber,
    OrderDate,
    ProductKey,
    SalesAmount,
    TotalProductCost,
    SalesAmount - TotalProductCost AS Profitto
FROM
	factresellersales
WHERE
	Productkey IN (597,598,477,214)
AND
	OrderDate>='2020-01-01';