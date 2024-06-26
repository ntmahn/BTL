USE [master]
GO
/****** Object:  Database [QlyCuaHangQuanAo]    Script Date: 6/8/2024 10:04:55 PM ******/
CREATE DATABASE [QlyCuaHangQuanAo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QlyCuaHangQuanAo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS03\MSSQL\DATA\QlyCuaHangQuanAo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QlyCuaHangQuanAo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS03\MSSQL\DATA\QlyCuaHangQuanAo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QlyCuaHangQuanAo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET ARITHABORT OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET  MULTI_USER 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET QUERY_STORE = ON
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QlyCuaHangQuanAo]
GO
/****** Object:  Table [dbo].[tbl_ChiTietHoaDonBan]    Script Date: 6/8/2024 10:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ChiTietHoaDonBan](
	[MaHDB] [char](10) NOT NULL,
	[MaQA] [char](10) NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [float] NULL,
	[TongTien] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ChiTietHoaDonNhap]    Script Date: 6/8/2024 10:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ChiTietHoaDonNhap](
	[MaHDN] [char](10) NOT NULL,
	[MaQA] [char](10) NOT NULL,
	[MaNCC] [char](10) NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [float] NULL,
	[TongTien] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_HoaDonBan]    Script Date: 6/8/2024 10:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_HoaDonBan](
	[MaHDB] [char](10) NOT NULL,
	[MaNV] [char](10) NULL,
	[MaKH] [char](10) NULL,
	[NgayBan] [date] NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHDB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_HoaDonNhap]    Script Date: 6/8/2024 10:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_HoaDonNhap](
	[MaHDN] [char](10) NOT NULL,
	[MaNV] [char](10) NULL,
	[NgayNhap] [date] NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHDN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_KhachHang]    Script Date: 6/8/2024 10:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_KhachHang](
	[MaKH] [char](10) NOT NULL,
	[TenKH] [varchar](50) NULL,
	[GioiTinh] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_NhaCungCap]    Script Date: 6/8/2024 10:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_NhaCungCap](
	[MaNCC] [char](10) NOT NULL,
	[TenNCC] [varchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_NhanVien]    Script Date: 6/8/2024 10:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_NhanVien](
	[MaNV] [char](10) NOT NULL,
	[TenNV] [varchar](50) NULL,
	[GioiTinh] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_TaiKhoan]    Script Date: 6/8/2024 10:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_TaiKhoan](
	[MaNV] [char](10) NOT NULL,
	[MatKhau] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ThongTinQuanAo]    Script Date: 6/8/2024 10:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ThongTinQuanAo](
	[MaQA] [char](10) NOT NULL,
	[TenQA] [varchar](50) NULL,
	[MaNCC] [char](10) NULL,
	[SoLuong] [int] NULL,
	[GiaBan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaQA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tbl_ChiTietHoaDonBan] ([MaHDB], [MaQA], [SoLuong], [DonGia], [TongTien]) VALUES (N'HDB001    ', N'M001      ', 2, 220000, 440000)
INSERT [dbo].[tbl_ChiTietHoaDonBan] ([MaHDB], [MaQA], [SoLuong], [DonGia], [TongTien]) VALUES (N'HDB001    ', N'M002      ', 10, 110000, 1100000)
INSERT [dbo].[tbl_ChiTietHoaDonBan] ([MaHDB], [MaQA], [SoLuong], [DonGia], [TongTien]) VALUES (N'HDB001    ', N'M004      ', 10, 165000, 1650000)
GO
INSERT [dbo].[tbl_ChiTietHoaDonNhap] ([MaHDN], [MaQA], [MaNCC], [SoLuong], [DonGia], [TongTien]) VALUES (N'HDN001    ', N'M001      ', N'NCC001    ', 10, 200000, 2000000)
INSERT [dbo].[tbl_ChiTietHoaDonNhap] ([MaHDN], [MaQA], [MaNCC], [SoLuong], [DonGia], [TongTien]) VALUES (N'HDN001    ', N'M002      ', N'NCC001    ', 1000, 150000, 150000000)
INSERT [dbo].[tbl_ChiTietHoaDonNhap] ([MaHDN], [MaQA], [MaNCC], [SoLuong], [DonGia], [TongTien]) VALUES (N'HDN002    ', N'M004      ', N'NCC003    ', 100, 100000, 10000000)
GO
INSERT [dbo].[tbl_HoaDonBan] ([MaHDB], [MaNV], [MaKH], [NgayBan], [DiaChi], [SDT]) VALUES (N'HDB001    ', N'NV001     ', N'KH001     ', CAST(N'2023-12-12' AS Date), N'Hà Nội', N'0129493854')
GO
INSERT [dbo].[tbl_HoaDonNhap] ([MaHDN], [MaNV], [NgayNhap], [DiaChi], [SDT]) VALUES (N'HDN001    ', N'NV001     ', CAST(N'2023-12-12' AS Date), N'Bắc Ninh', N'0987654321')
INSERT [dbo].[tbl_HoaDonNhap] ([MaHDN], [MaNV], [NgayNhap], [DiaChi], [SDT]) VALUES (N'HDN002    ', N'NV002     ', CAST(N'2023-10-10' AS Date), N'Hà Nội', N'032575648')
GO
INSERT [dbo].[tbl_KhachHang] ([MaKH], [TenKH], [GioiTinh], [DiaChi], [SDT]) VALUES (N'KH001     ', N'Nguyen Van An', N'Nam', N'Hà Nội', N'0129493854')
INSERT [dbo].[tbl_KhachHang] ([MaKH], [TenKH], [GioiTinh], [DiaChi], [SDT]) VALUES (N'KH003     ', N'Nguyen Thi Nguyet', N'Nữ', N'Nam Định', N'0984160942')
INSERT [dbo].[tbl_KhachHang] ([MaKH], [TenKH], [GioiTinh], [DiaChi], [SDT]) VALUES (N'KH004     ', N'Nguyen Van Linh', N'Nam', N'Hà Nam', N'0329568481')
GO
INSERT [dbo].[tbl_NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [SDT]) VALUES (N'NCC001    ', N'Thinh Phat', N'Bắc Ninh', N'0987654321')
INSERT [dbo].[tbl_NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [SDT]) VALUES (N'NCC002    ', N'An Nhan', N'Nam ĐỊnh', N'0967834512')
INSERT [dbo].[tbl_NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [SDT]) VALUES (N'NCC003    ', N'Long Biên', N'Hà Nội', N'032575648')
GO
INSERT [dbo].[tbl_NhanVien] ([MaNV], [TenNV], [GioiTinh], [DiaChi], [SDT]) VALUES (N'NV001     ', N'Nguyen Trong Nghia', N'Nam', N'Nam ĐỊnh', N'0328680646')
INSERT [dbo].[tbl_NhanVien] ([MaNV], [TenNV], [GioiTinh], [DiaChi], [SDT]) VALUES (N'NV002     ', N'Nguyen Trong Binh', N'Nam', N'Nam ĐỊnh', N'0982741172')
INSERT [dbo].[tbl_NhanVien] ([MaNV], [TenNV], [GioiTinh], [DiaChi], [SDT]) VALUES (N'NV003     ', N'Nguyen Kim Anh', N'Nữ', N'Hà Nội', N'0912837642')
GO
INSERT [dbo].[tbl_TaiKhoan] ([MaNV], [MatKhau]) VALUES (N'NV001     ', N'1234')
INSERT [dbo].[tbl_TaiKhoan] ([MaNV], [MatKhau]) VALUES (N'NV002     ', N'1234')
INSERT [dbo].[tbl_TaiKhoan] ([MaNV], [MatKhau]) VALUES (N'NV003     ', N'1234')
GO
INSERT [dbo].[tbl_ThongTinQuanAo] ([MaQA], [TenQA], [MaNCC], [SoLuong], [GiaBan]) VALUES (N'M001      ', N'Quan dui', N'NCC001    ', 100, 200000)
INSERT [dbo].[tbl_ThongTinQuanAo] ([MaQA], [TenQA], [MaNCC], [SoLuong], [GiaBan]) VALUES (N'M002      ', N'Quan dai', N'NCC001    ', 1100, 150000)
INSERT [dbo].[tbl_ThongTinQuanAo] ([MaQA], [TenQA], [MaNCC], [SoLuong], [GiaBan]) VALUES (N'M003      ', N'Quan bo', N'NCC002    ', 100, 100000)
INSERT [dbo].[tbl_ThongTinQuanAo] ([MaQA], [TenQA], [MaNCC], [SoLuong], [GiaBan]) VALUES (N'M004      ', N'Ao dai tay', N'NCC003    ', 200, 100000)
INSERT [dbo].[tbl_ThongTinQuanAo] ([MaQA], [TenQA], [MaNCC], [SoLuong], [GiaBan]) VALUES (N'M005      ', N'Ao ngan tay', N'NCC002    ', 100, 100000)
INSERT [dbo].[tbl_ThongTinQuanAo] ([MaQA], [TenQA], [MaNCC], [SoLuong], [GiaBan]) VALUES (N'M006      ', N'Áo len', N'NCC003    ', 100, 300000)
GO
ALTER TABLE [dbo].[tbl_ChiTietHoaDonBan]  WITH CHECK ADD FOREIGN KEY([MaHDB])
REFERENCES [dbo].[tbl_HoaDonBan] ([MaHDB])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_ChiTietHoaDonBan]  WITH CHECK ADD FOREIGN KEY([MaQA])
REFERENCES [dbo].[tbl_ThongTinQuanAo] ([MaQA])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_ChiTietHoaDonNhap]  WITH CHECK ADD FOREIGN KEY([MaHDN])
REFERENCES [dbo].[tbl_HoaDonNhap] ([MaHDN])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_ChiTietHoaDonNhap]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[tbl_NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[tbl_ChiTietHoaDonNhap]  WITH CHECK ADD FOREIGN KEY([MaQA])
REFERENCES [dbo].[tbl_ThongTinQuanAo] ([MaQA])
GO
ALTER TABLE [dbo].[tbl_HoaDonBan]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[tbl_KhachHang] ([MaKH])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_HoaDonBan]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[tbl_NhanVien] ([MaNV])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_HoaDonNhap]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[tbl_NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[tbl_TaiKhoan]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[tbl_NhanVien] ([MaNV])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_ThongTinQuanAo]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[tbl_NhaCungCap] ([MaNCC])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
USE [master]
GO
ALTER DATABASE [QlyCuaHangQuanAo] SET  READ_WRITE 
GO
