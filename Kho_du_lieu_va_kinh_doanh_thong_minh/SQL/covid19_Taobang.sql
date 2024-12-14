create database Covid19_dataa


CREATE TABLE DimCountry (
    CountryID INT PRIMARY KEY,
    Country_Region VARCHAR(255),
    WHORegion VARCHAR(255),
    Population BIGINT,
    TotCases_1Mpop INT,
    Deaths_1Mpop INT,
    TotalTests BIGINT,
    TotalDeaths BIGINT,
    Tests_1Mpop INT,
    TotalCases BIGINT
);

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    Date DATE,
    Month INT,
    Day INT,
    Year INT,
    Confirmed BIGINT,
    Deaths BIGINT,
    Recovered BIGINT,
    Active BIGINT,
    NewCases BIGINT,
    NewDeaths BIGINT,
    NewRecovered BIGINT,
    Deaths_100Cases DECIMAL(5, 2),
    Recovered_100Cases DECIMAL(5, 2),
    Deaths_100Recovered DECIMAL(5, 2),
    NoOfCountries INT
);

CREATE TABLE DimContinent (
    ContinentID INT PRIMARY KEY,
    Continent VARCHAR(255),
    Country_Region VARCHAR(255)
);



CREATE TABLE DimWHO_Region (
    WHO_RegionID INT PRIMARY KEY,
    WHORegion VARCHAR(255),
    Country VARCHAR(255),
    ConfirmedLastWeek BIGINT,
    OneWeekChange BIGINT,
    OneWeekPercentIncrease DECIMAL(5, 2)
);

CREATE TABLE FactCovid (
    CountryID INT,
    DateKey INT,
    ContinentID INT,
    WHO_RegionID INT,
    Confirmed BIGINT,
    Deaths BIGINT,
    Recovered BIGINT,
    Active BIGINT,
    NewCases BIGINT,
    NewDeaths BIGINT,
    NewRecovered BIGINT,
    Deaths_100Cases DECIMAL(5, 2),
    Recovered_100Cases DECIMAL(5, 2),
    Deaths_100Recovered DECIMAL(5, 2),
    PRIMARY KEY (CountryID, DateKey, ContinentID, WHO_RegionID),
    FOREIGN KEY (CountryID) REFERENCES DimCountry(CountryID),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY (ContinentID) REFERENCES DimContinent(ContinentID),
    FOREIGN KEY (WHO_RegionID) REFERENCES DimWHO_Region(WHO_RegionID)
);

