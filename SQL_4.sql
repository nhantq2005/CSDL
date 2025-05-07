CREATE database ThucHanh

USE ThucHanh
GO


--1.	Viết lệnh SQL để tạo bảng Khoa: Khoa(MãKhoa(Char,4), TênKhoa(NVarChar,20, not null), NgàyThànhLập(Date), 
--NộiDungĐàoTạo(NVarChar, 200), GhiChú(NvarChar(Max)) ) 

CREATE TABLE KHOA (
	MaKhoa nvarchar(4) PRIMARY KEY,
	TenKhoa nvarchar(20) not null,
	NgayThanhLap date,
	NDDaoTao nvarchar(200),
	GhiChu nvarchar(max)
)

--2.	Viết lệnh SQL để tạo bảng Lớp: MãKhoa là khoá ngoại tham khảo đến Khoa.MãKhoa. 
--Lớp(MãLớp(Char, 6), TênLớp(NVarChar, 20, not null), 
--KhóaHọc(NVarChar, 4), GVCN(NVarChar, 50), MãKhoa(Char, 4), GhiChú(NvarChar(Max)) ) 

CREATE TABLE Lop(
	MaKhoa nvarchar(4),
	MaLop nvarchar(6) PRIMARY KEY,
	TenLop nvarchar(20) not null,
	KhoaHoc nvarchar(6),
	GVCN nvarchar(50),
	--MaKhoa char(4),
	GhiChu nvarchar(max),
	FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa)
)


--3.	Viết lệnh SQL để tạo bảng SinhViên: MãLớp là khoá ngoại tham khảo đến Lop.MaLop. 
--SinhViên(MãSV(Char, 8), HọSV(NVarChar, 50, not null),TênSV(Short Text, 20, not null), 
--GiớiTính(NVarChar, 4), NgàySinh(Date), QuêQuán(NVarChar, 200), ĐịaChỉ(NVarChar, 100), 
--MãLớp(Char, 6), GhiChú(NvarChar(Max)) ) 

CREATE TABLE SinhVien(
	MaLop nvarchar(6),
	MaSV char(8) PRIMARY KEY,
	HoSV nvarchar(50) not null,
	TenSV nvarchar(20) not null,
	GioiTinh nvarchar(4),
	NgaySinh date,
	QueQuan nvarchar(200),
	DiaChi nvarchar(100),
	--MaLop char(6),
	GhiChu nvarchar(max),
	FOREIGN KEY (MaLop) REFERENCES Lop(MaLop)
)

--4.	Viết lệnh SQL để tạo bảng Môn học: MãKhoa là khoá ngoại tham khảo đến Khoa.MãKhoa. 
--MônHọc(MãMH(Auto number), TênMH(NVarChar,20, not null), 
--NộiDungMH(NVarChar, 200), MãKhoa(Char, 4), SốTínChỉ(int), SốTíết(int), GhiChú(NvarChar(Max)) ) 

--CREATE TABLE MonHoc(
--	MaMH autonumber PRIMARY KEY,
--)

--5.	Viết lệnh SQL để tạo bảng Học: MãSV  là khoá ngoại tham khảo đến SinhVien.MaSV, MãMH là khoá ngoại tham 
--khảo đến MonHoc.MaMH. 
--Học(MãSV(Char, 8), MãMH(int), NgàyĐăngKý(Date), 
--NgàyThi(Date), ĐiểmTrungBình(decimal(8,2)), GhiChú(NvarChar(Max)) ) 



--6.	Viết lệnh SQL để thêm cột CMND (VarChar, 9) vào bảng SinhViên. 



--7.	Viết lệnh SQL để thêm cột DTDD (VarChar, 10) vào bảng SinhViên. 



--8.	Viết lệnh SQL để sửa thiết kế cột DTDD thành (VarChar, 12) của bảng SinhViên. 



--9.	Viết lệnh SQL để xoá cột DTDD của bảng SinhViên. 



--10.	Viết lệnh SQL để tạo index idxTênSV trong bảng SinhViên. 



--11.	Viết lệnh SQL để tạo index idxSoCMND (index không trùng dữ liệu) trong bảng SinhViên. 



--12.	Tạo các query dùng INSERT…VALUES… để thêm thông tin vào các bảng dữ liệu về cá nhân mình, lớp, khoa,
--môn học, học. Chú ý các thuộc tính not null và thứ tự chạy các câu query này. 



--13.	Viết lệnh SQL để xóa index idxTênSV trong bảng SinhViên. 



--14.	Tạo các query dùng DROP TABLE để xoá các bảng SinhViên, Lớp, Khoa, MônHọc,Học. Chú ý thứ tự thực hiện 
--câu lệnh và các ràng buộc khi xoá bảng. 
