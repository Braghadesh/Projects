	--Cleansed Product Table
SELECT
P.[ProductKey],
P.[ProductAlternateKey] AS ProductCode,
      --,[ProductSubcategoryKey]
      --,[WeightUnitMeasureCode]
      --,[SizeUnitMeasureCode]
P.[EnglishProductName] AS [Product Name],
PS.EnglishProductSubcategoryName AS [Sub Category],--Joined from subcategory
PC.EnglishProductCategoryName AS [Product Category],--Joined from category
      --,[SpanishProductName]
      --,[FrenchProductName]
      --,[StandardCost]
      --,[FinishedGoodsFlag]
P.[Color] AS [Product Color],
      --,[SafetyStockLevel]
      --,[ReorderPoint]
      --,[ListPrice]
P.[Size] AS [Product Size],
      --,[SizeRange]
      --,[Weight]
      --,[DaysToManufacture]
P.[ProductLine] AS [Product Line],
      --,[DealerPrice]
      --,[Class]
      --,[Style]
P.[ModelName] AS [Product Model Name],
      --,[LargePhoto]
P.[EnglishDescription] AS [Product Description],
      --,[FrenchDescription]
      --,[ChineseDescription]
      --,[ArabicDescription]
      --,[HebrewDescription]
      --,[ThaiDescription]
      --,[GermanDescription]
      --,[JapaneseDescription]
      --,[TurkishDescription]
      --,[StartDate]
      --,[EndDate]
      --,[Status]
ISNULL(P.Status,'Outdated') AS [Product Status] --Replaced null valuves from the column
FROM 
	[AdventureWorksDW2019].[dbo].[DimProduct] AS P
	LEFT JOIN [dbo].[DimProductSubcategory] AS PS
		ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
	LEFT JOIN [dbo].[DimProductCategory] AS PC
		ON PC.ProductCategoryKey = PS.ProductCategoryKey
Order By 
	P.ProductKey Asc;