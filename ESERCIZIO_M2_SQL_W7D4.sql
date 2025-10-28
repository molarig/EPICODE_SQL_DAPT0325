##Esercizio 1
#Implementa una vista denominata Product al fine di creare unʼanagrafica (dimensione) prodotto completa.
#La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome prodotto, il nome della sottocategoria associata e il nome della categoria associata.

CREATE VIEW Product
AS (
	SELECT p.EnglishProductName, c.EnglishProductCategoryName, s.EnglishProductSubcategoryName 
	FROM dimproduct p
	LEFT JOIN dimproductsubcategory s
	ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
	LEFT JOIN dimproductcategory c
	ON s.ProductCategoryKey = c.ProductCategoryKey
);

##Esercizio 2
#Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa.
#La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome del reseller, il nome della città e il nome della regione.

CREATE VIEW Reseller
AS (
	SELECT r.ResellerName, g.City, g.EnglishCountryRegionName
	FROM dimreseller r
	LEFT JOIN dimgeography g
	ON r.GeographyKey = g.GeographyKey
);

##Esercizio 3
#Crea una vista denominata Sales che deve restituire la data dellʼordine, il codice documento, la riga di corpo del documento, la quantità venduta, lʼimporto totale e il profitto.

CREATE VIEW Sales
AS (
	SELECT OrderDate, SalesOrderNumber, SalesOrderLineNumber, OrderQuantity, SalesAmount, TotalProductCost, SalesAmount-TotalProductCost AS Revenue
    FROM factresellersales
);

##Esercizio 4
#Crea un report in Excel che consenta ad un utente di analizzare quantità venduta, importo totale e profitti per prodotto/categoria prodotto e reseller/regione. 

CREATE VIEW Sales
AS (
	SELECT p.EnglishProductName, c.EnglishProductCategoryName, s.EnglishProductSubcategoryName, r.ResellerName, g.EnglishCountryRegionName, rs.OrderQuantity, rs.SalesAmount, rs.TotalProductCost, rs.SalesAmount-rs.TotalProductCost AS Revenue
    FROM dimproduct p
	LEFT JOIN dimproductsubcategory s
	ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
	LEFT JOIN dimproductcategory c
	ON s.ProductCategoryKey = c.ProductCategoryKey
    LEFT JOIN factresellersales rs
    ON p.ProductKey = rs.ProductKey
    LEFT JOIN dimreseller r
    ON r.ResellerKey = rs.ResellerKey
    LEFT JOIN dimgeography g
    ON r.GeographyKey = g.GeographyKey
);