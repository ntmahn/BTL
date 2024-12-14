-- Xóa ràng buộc khóa chính
ALTER TABLE [dbo].[DimWHO_Region]
DROP CONSTRAINT PK__DimWHO_R__3C0C97FD1B9DE537;

-- Xóa ràng buộc khóa ngoại
ALTER TABLE [dbo].[FactCovid]
DROP CONSTRAINT FK__FactCovid__WHO_R__6A30C649;

-- Thay đổi kiểu dữ liệu cột WHO_RegionID thành NVARCHAR(255)
ALTER TABLE [dbo].[DimWHO_Region]
ALTER COLUMN [WHO_RegionID] NVARCHAR(255) NOT NULL;

-- Tạo lại khóa chính cho cột WHO_RegionID
ALTER TABLE [dbo].[DimWHO_Region]
ADD CONSTRAINT PK__DimWHO_R__3C0C97FD1B9DE537 PRIMARY KEY (WHO_RegionID);


-- Xóa ràng buộc khóa chính trên cột WHO_RegionID trong bảng FactCovid
ALTER TABLE [dbo].[FactCovid]
DROP CONSTRAINT PK__FactCovi__CB6106083B624094;


-- Thay đổi kiểu dữ liệu cột WHO_RegionID trong bảng FactCovid để giống với DimWHO_Region
ALTER TABLE [dbo].[FactCovid]
ALTER COLUMN WHO_RegionID NVARCHAR(255) NOT NULL;

-- Khôi phục lại ràng buộc khóa chính trên cột WHO_RegionID trong bảng FactCovid
ALTER TABLE [dbo].[FactCovid]
ADD CONSTRAINT PK__FactCovi__CB6106083B624094 PRIMARY KEY (WHO_RegionID);

-- Tạo lại ràng buộc khóa ngoại liên kết với bảng DimWHO_Region
ALTER TABLE [dbo].[FactCovid]
ADD CONSTRAINT FK__FactCovid__WHO_R__6A30C649 FOREIGN KEY (WHO_RegionID)
REFERENCES [dbo].[DimWHO_Region](WHO_RegionID);


ALTER TABLE [dbo].[DimWHO_Region]
ALTER COLUMN [WHO_RegionID] NVARCHAR(255)

INSERT INTO DimWHO_Region (
	WHO_RegionID,
	WHORegion,
	ConfirmedLastWeek,
	OneWeekChange,
	OneWeekPercentIncrease
)
SELECT 
    CAST(WHO_RegionID AS nvarchar), 
    CAST(WHO_Region AS varchar),
    CAST([Confirmed last week] AS BIGINT),
    CAST([1 week change] AS BIGINT),
    CAST([1 week % increase] AS decimal)
from [dbo].[Sheet1$]

