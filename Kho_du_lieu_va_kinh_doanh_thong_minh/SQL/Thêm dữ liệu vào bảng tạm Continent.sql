CREATE TABLE TempDimContinent (
    ContinentID NVARCHAR(50),  -- Tạm thời dùng kiểu chuỗi
    Continent NVARCHAR(100),
);

INSERT INTO DimContinent (ContinentID, Continent)
SELECT 
    CAST(ContinentID AS INT),  -- Chuyển đổi từ chuỗi sang số nguyên
    Continent
FROM TempDimContinent
WHERE ISNUMERIC(ContinentID) = 1; 

ALTER TABLE DimContinent
DROP COLUMN Country_Region;
