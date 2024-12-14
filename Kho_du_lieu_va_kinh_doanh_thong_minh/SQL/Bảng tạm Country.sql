ALTER TABLE DimCountry
ALTER COLUMN Country_Region NVARCHAR(100)

ALTER TABLE DimCountry
ALTER COLUMN WHORegion NVARCHAR(100)

CREATE TABLE TempDimCountry2 (
	CountryID nvarchar(255),
    Country_Region NVARCHAR(255), 
	WHORegion nvarchar(255),
	Population nvarchar (255),
	TotCases_1Mpop nvarchar(255),
	Deaths_1Mpop nvarchar(255),
	TotalTests nvarchar(255),
    TotalDeaths nvarchar(255),   
	Tests_1Mpop nvarchar(255),
    TotalCases nvarchar(255)                    
);

-- Chuyen du lieu
INSERT INTO DimCountry (
    CountryID,
	Country_Region,
    WHORegion,
    Population,
    TotCases_1Mpop,
    Deaths_1Mpop,
    TotalDeaths,
    Tests_1Mpop,
    TotalCases
)
SELECT 
    CAST(ISNULL(CountryID, 0) AS INT), -- Thay NULL bằng 0
    CAST(Country_Region AS nvarchar),
    CAST(WHORegion AS nvarchar),
    CAST(Population AS BIGINT),
    CAST(TotCases_1Mpop AS INT),
    CAST(FLOOR(CAST(Deaths_1Mpop AS FLOAT)) AS INT),
    CAST(TotalDeaths AS BIGINT),
    CAST(Tests_1Mpop AS INT),
    CAST(TotalCases AS BIGINT)
from TempDimCountry2

