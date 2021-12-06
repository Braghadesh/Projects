--Cleansed Customer Table
SELECT
C.[CustomerKey],
      --,[GeographyKey]
      --,[CustomerAlternateKey]
      --,[Title]
C.[FirstName],
      --,[MiddleName]
C.[LastName],
C.[FirstName] + ' ' + C.[LastName] AS [Full Name], --First and Last name Concat
      --,[NameStyle]
      --,[BirthDate]
      --,[MaritalStatus]
      --,[Suffix]
CASE C.[Gender] 
	WHEN 'M' Then 'Male' 
	WHEN 'F' Then 'Female' 
	END AS [Gender],
      --,[EmailAddress]
      --,[YearlyIncome]
      --,[TotalChildren]
      --,[NumberChildrenAtHome]
      --,[EnglishEducation]
      --,[SpanishEducation]
      --,[FrenchEducation]
      --,[EnglishOccupation]
      --,[SpanishOccupation]
      --,[FrenchOccupation]
      --,[HouseOwnerFlag]
      --,[NumberCarsOwned]
      --,[AddressLine1]
      --,[AddressLine2]
      --,[Phone]
C.DateFirstPurchase AS [DatefirstPurchase],
G.City AS [Custmer City] --Joined from Geography
      --,[CommuteDistance]
FROM
[AdventureWorksDW2019].[dbo].[DimCustomer] AS C
  LEFT JOIN [dbo].[DimGeography] AS G
	ON C.GeographyKey = G.GeographyKey
ORDER BY [CustomerKey] Asc;