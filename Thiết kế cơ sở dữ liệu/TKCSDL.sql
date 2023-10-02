create database QLMANTA
create table KM(
	Makhuyenmai char(15) primary key,
	Tenkhuyenmai nvarchar(20))

create table CH(
	MaCH char(10) primary key,
	TenCH nvarchar(20),
	Diachi nvarchar(30),
	Dienthoai int,
	Email varchar(15),
	MaKM char(15) foreign key references KM(Makhuyenmai))

create table NCC(
	MaNCC char(10) primary key,
	TenNCC nvarchar(20),
	Diachi nvarchar(30),
	Sodienthoai int,
	Email varchar(15))

create table NhanVien(
	MaNV char(10) primary key,
	TenNV nvarchar(20),
	Diachi nvarchar(30),
	Ngaysinh date,
	Gioitinh int,
	Luong money,
	Sodienthoai int,
	MaCuaHang char(10) foreign key references CH(MaCH))

create table KH(
	MaKH char(10) primary key,
	TenKH nvarchar(20),
	Ngaysinh date,
	Gioitinh int,
	Sodienthoai int,
	Duong nvarchar(20),
	Quan nvarchar(20),
	Thanh_pho nvarchar(20),
	Diemtichluy float)

create table Hoadonban(
	MaHD char(15) primary key,
	Tongtien money,
	Ngaygiothanhtoan datetime,
	Hinhthuctt nvarchar(15),
	MaNV char(10) foreign key references NhanVien(MaNV),
	MaKH char(10) foreign key references KH(MaKH),
	Makhuyenmai char(15) foreign key references KM(Makhuyenmai))

create table SP(
	MaSP char(10) primary key,
	TenSP nvarchar(20),
	Mausac nvarchar(10),
	SLHT int,
	Donvitinh char(10),
	IDhoadon char(15) foreign key references Hoadonban(MaHD))

create table Chucvu(
	Machucvu char(10) primary key,
	Tenchucvu nvarchar(10),
	NgayNhanChuc date,
	MaNV char(10) foreign key references NhanVien(MaNV))

create table Phieuxuat(
	Sophieuxuat char(15) primary key,
	Donvitinh char(10),
	Ngayxuat date,
	Tongtien money)

create table chitietphieuxuat(
	Sophieuxuat char(15) foreign key references Phieuxuat(Sophieuxuat), 
	MaSP char(10) primary key,
	SL int,
	Giaxuat money)

create table Phieunhap(
	Sophieunhap char(15) primary key,
	MaNCC char(10) foreign key references NCC(MaNCC),
	Donvitinh char(10),
	Tongtien money,
	Ngaynhap date)

create table Chitietphieunhap(
	Sophieunhap char(15) foreign key references Phieunhap(Sophieunhap),
	MaSP char(10) primary key,
	Soluongnhap int,
	Gianhap money)

create table chitiethoadonban(
	MaHD char(15) foreign key references Hoadonban(MaHD),
	MaSP char(10) primary key,
	Dongia money,
	Soluong int)

create table Cuahang_KM(
	MaCH char(10) foreign key references CH(MaCH),
	MaKH char(10) foreign key references KH(MaKH),
	Ngaybd date,
	NgayKT date)






		