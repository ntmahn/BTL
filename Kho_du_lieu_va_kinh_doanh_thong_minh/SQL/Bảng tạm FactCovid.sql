ALTER TABLE [dbo].[FactCovid]
ADD ConfirmedLastWeek BIGINT

ALTER TABLE [dbo].[FactCovid]
ADD OneWeekChange BIGINT

ALTER TABLE [dbo].[FactCovid]
ALTER COLUMN [Deaths_100Cases] DECIMAL(10,2)

ALTER TABLE [dbo].[FactCovid]
ALTER COLUMN [Recovered_100Cases] DECIMAL(10,2)

ALTER TABLE [dbo].[FactCovid]
ALTER COLUMN [Deaths_100Recovered] DECIMAL(10,2)

ALTER TABLE [dbo].[FactCovid]
ALTER COLUMN OneWeekPercentIncrease DECIMAL(10,2)

ALTER TABLE [dbo].[FactCovid]
DROP CONSTRAINT PK__FactCovi__CB6106083B624094;

-- Tạm thời tắt kiểm tra ngoại kiểm
ALTER TABLE [dbo].[FactCovid] NOCHECK CONSTRAINT FK__FactCovid__WHO_R__6A30C649;

ALTER TABLE [dbo].[FactCovid] NOCHECK CONSTRAINT FK__FactCovid__Count__6754599E;

-- Thực hiện câu lệnh INSERT
INSERT INTO [dbo].[FactCovid] (
    [CountryID], 
    [DateKey],
    [ContinentID],
    [WHO_RegionID],
    Confirmed,
    Deaths,
    Recovered,
    Active,
    NewCases,
    NewDeaths,
    NewRecovered,
    Deaths_100Cases,
    Recovered_100Cases,
    Deaths_100Recovered,
    [ConfirmedLastWeek],
    [OneWeekChange],
    [OneWeekPercentIncrease]
)
SELECT 
    CAST([CountryID ] AS INT),
    CAST([DateKey] AS INT),
    CAST([ContinentID] AS INT),
    [WHO_RegionID],
    CAST([Confirmed] AS BIGINT),
    CAST([Deaths] AS BIGINT),
    CAST([Recovered] AS BIGINT),
    CAST([Active] AS BIGINT),
    CAST([New cases] AS BIGINT),
    CAST([New deaths] AS BIGINT),
    CAST([New recovered] AS BIGINT),
    CAST([Deaths / 100 Cases] AS DECIMAL(10,2)), -- Thay đổi từ DECIMAL(5,2) thành DECIMAL(10,2)
    CAST([Recovered / 100 Cases] AS DECIMAL(10,2)), -- Thay đổi từ DECIMAL(5,2) thành DECIMAL(10,2)
    CAST([Deaths / 100 Recovered] AS DECIMAL(10,2)), -- Thay đổi từ DECIMAL(5,2) thành DECIMAL(10,2)
    CAST([Confirmed last week] AS BIGINT),
    CAST([1 week change] AS BIGINT),
    CAST([1 week % increase] AS DECIMAL(10,2)) -- Thay đổi từ DECIMAL(5,2) thành DECIMAL(10,2)
FROM [dbo].[FactCovid$];


-- Bật lại kiểm tra ngoại kiểm
ALTER TABLE [dbo].[FactCovid] CHECK CONSTRAINT FK__FactCovid__WHO_R__6A30C649;
ALTER TABLE [dbo].[FactCovid] CHECK CONSTRAINT FK__FactCovid__Count__6754599E;
