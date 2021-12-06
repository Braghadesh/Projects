--Cleansed DimDate Table
SELECT 
[DateKey],
[FullDateAlternateKey] AS Date,
      --,[DayNumberOfWeek]
[EnglishDayNameOfWeek] AS Day,
      --,[SpanishDayNameOfWeek]
      --,[FrenchDayNameOfWeek]
      --,[DayNumberOfMonth]
      --,[DayNumberOfYear]
[WeekNumberOfYear] AS WeekNr,
[EnglishMonthName] AS Month,
LEFT([EnglishMonthName],3) AS "Month Short", --Extracted first 3 chars from Month column
      --,[SpanishMonthName]
      --,[FrenchMonthName]
[MonthNumberOfYear] AS MonthNr,
[CalendarQuarter] AS Quater,
[CalendarYear] AS Year
      --,[CalendarSemester]
      --,[FiscalQuarter]
      --,[FiscalYear]
      --,[FiscalSemester]
FROM [AdventureWorksDW2019].[dbo].[DimDate]
WHERE CalendarYear >= 2019;