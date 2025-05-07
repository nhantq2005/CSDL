USE Northwind
GO

--MAKE-TABLE QUERY 
--1.	Tạo một query đặt tên là TimKhachHangMy (tìm khách hàng Mỹ). 
--Khi chạy, query này sẽ tạo ra một table mới có tên CacKhachHangMy, lấy tất cả các field của bảng Customers. 
SELECT * INTO CacKhachHangMy
FROM Customers
WHERE Country = 'USA'

--2.	Tạo một query đặt tên là Tim5NhanVienGioi (tìm 5 nhân viên giỏi). 
--Khi chạy, query này sẽ tạo ra một table mới có tên 5NhanVienGioi. Bảng này liệt kê danh sách 5 nhân viên phụ trách 
--nhiều đơn đặt hàng nhất. Các thông tin gồm: mã nhân viên, họ và tên nhân viên (1 cột), tổng số lượng 
--các đơn đặt hàng đã phụ trách. Danh sách sắp xếp giảm dần theo cột tổng số lượng các đơn đặt hàng đã phụ trách.
SELECT TOP 5 e.EmployeeID, CONCAT(e.FirstName,' ', e.LastName) as 'HoTen', Count(o.OrderID) 'SoLuongDonHang' INTO Top5NhanVienGioi
FROM Employees e, Orders o
WHERE e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, CONCAT(e.FirstName,' ', e.LastName)
ORDER BY 3 DESC

--3.	Tạo một query đặt tên là Tim10KhachHang (tìm 10 khách hàng). Khi chạy, query này sẽ tạo ra một table 
--mới có tên 10KhachHang. Bảng này liệt kê danh sách 10 khách hàng có nhiều đơn đặt hàng nhất. Các thông tin gồm: 
--mã khách hàng, tên công ty, địa chỉ đầy đủ (1 cột gồm địa chỉ, thành phố và quốc gia), và tổng số lượng các đơn đặt hàng đã đặt. 
--Danh sách sắp xếp giảm dần theo cột tổng số lượng các đơn đặt hàng đã đặt. 
SELECT TOP 10 c.CustomerID, c.CompanyName, CONCAT(c.Address,', ',c.City,', ',c.Country) as 'Address', COUNT(o.OrderID) as 'SoLuongDon' INTO Tim10KhachHang
FROM Customers c, Orders o
WHERE c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName, CONCAT(c.Address,', ',c.City,', ',c.Country)
ORDER BY 4 DESC

--4.	Tạo một query đặt tên là TimTop5QGMuaHang (tìm top 5 quốc gia mua hàng). Khi chạy, query này sẽ tạo ra một table 
--mới có tên Top5QGMuaHang. Bảng này liệt kê danh sách top 5 quốc gia có khách hàng mua nhiều sản phẩm nhất. Gợi ý:  
--(Count(ProductID). 
--SELECT TOP 5 * INTO Top5QGMuaHang
--FROM Orders o, [Order Details] d

--5.	Tạo một query đặt tên là Tim5QGItMuaHang (tìm 5 quốc gia ít mua hàng). Khi chạy, query này sẽ tạo ra một table mới 
--có tên NamQGItMuaHang. Bảng này liệt kê danh sách 5 quốc gia có khách hàng mua ít sản phẩm nhất. Gợi ý: (Count(ProductID). 

-- 	1). APPEND QUERY THÊM 1 HÀNG DỮ LIỆU 
--1.	Tạo một Append Query đặt tên là Them1LoaiSPa. Khi chạy query mới này thì ta thêm một record vào table Categories. Thông tin thêm vào là: 
--	   	CategoryName: Văn phòng phẩm 
--	   	Description: Sách, vở, giấy, bút, mực 
--Mở bảng Categories để xem các thay đổi sau khi ta chạy query. 

INSERT INTO Categories(CategoryName,Description)
VALUES(N'Văn phòng phẩm', N'Sách, vở, giấy, bút, mực')

SELECT * FROM Categories

--4.	Hãy tạo một query đặt tên là ThemMotNhanVien (thêm một nhân viên). 
--Khi chạy, query này sẽ thêm một record vào table Employees với các thông tin cá nhân của các anh chị.
INSERT INTO Employees(FirstName,LastName,City)
VALUES('NHAN','TRAN QUOC','HCM')
SELECT * FROM Employees

--2). APPEND QUERY THÊM NHIỀU HÀNG DỮ LIỆU 
--Copy thiết kế (khơng lấy dữ liệu) bảng Customers v lưu thành bảng KhachHang 
--6.	Hãy tạo một query đặt tên là LayDLKhachHangMy (lấy dữ liệu khách hàng Mỹ). 
--Khi chạy, query này sẽ thêm một số record là khách hàng Mỹ từ bảng Custmers vào bảng KhachHang. 
SELECT * INTO KhacHang
FROM Customers
DELETE FROM KhacHang
INSERT INTO KhacHang
SELECT *
FROM Customers
WHERE Country='USA'
SELECT * FROM KhacHang

--7.	Hãy tạo một query đặt tên là LayDLKhachHangQuy (lấy dữ liệu khách hàng quý). 
--Khi chạy, query này sẽ thêm khoảng 10 record là khách hàng có nhiều đơn hàng nhất từ 
--bảng Custmers vào bảng KhachHang. 

INSERT INTO KhacHang
SELECT *
FROM Customers cs
WHERE cs.CustomerID in ( SELECT TOP 10 c.CustomerID
					FROM Customers c, Orders o
					WHERE c.CustomerID = o.CustomerID
					GROUP BY c.CustomerID
					ORDER BY COUNT(o.OrderID) DESC
					)
SELECT * FROM KhacHang


--CROSS-TAB QUERY 
--1.	Hãy tạo một query đặt tên là ThongKeSPTheoNam (thống kê sản phẩm theo năm). 
--Khi chạy, query sẽ hỏi năm bắt đầu thống kê, năm kết thúc thống kê sau đó lập 
--một danh sách trong đó: Các hàng là tên các sản phẩm, các cột là lần lượt các năm liên tiếp 
--trong khoảng các năm vừa nhập, giá trị trong các ô là số lượng sản phẩm đã bán được. 
SELECT ProductName, [1996], [1997], [1998]
FROM
	(
	SELECT ProductName, Year(OrderDate) Nam, Quantity SL
	FROM Products p, [Order Details] d, Orders o
	WHERE p.ProductID=d.ProductID and o.OrderID=d.OrderID
	and YEAR(OrderDate) in (1996,1997,1998)
	)B
pivot
(
	Sum(SL) for Nam in ([1996], [1997], [1998])
)P

--5.	Tạo query crosstab thống kê doanh số của từng khách hàng của UK theo từng quý trong năm 1997. 
--Kết quả có dạng: (trong đó doanh số = UnitPrice*Quantity) 
SELECT CompanyName,Total = ISNULL([1],0)+ISNULL([2],0)+ISNULL([3],0)+ISNULL([4],0), [1] as Qtr1, [2] as Qtr2, [3] as Qtr3, [4] as Qtr4
FROM
	(
	SELECT CompanyName, DATEPART(QUARTER,o.OrderDate) Quy,  Tong = Quantity* UnitPrice
	FROM Customers c, [Order Details] d, Orders o
	WHERE c.CustomerID=o.CustomerID and o.OrderID=d.OrderID
	and YEAR(OrderDate) = 1997 and Country = 'UK'
	)B
pivot
(
	SUM(Tong) for Quy in ([1], [2], [3], [4]) 
)P

--6.	Tạo query crostab thống kê doanh số của của từng nhóm hàng (Category Name) theo từng quý trong một năm nào đó. 
--Kết quả có dạng (thí dụ nhập năm 1997): 
SELECT CategoryName,Total = ISNULL([1],0)+ISNULL([2],0)+ISNULL([3],0)+ISNULL([4],0), [1] as Qtr1, [2] as Qtr2, [3] as Qtr3, [4] as Qtr4
FROM
	(
	SELECT c.CategoryName, DATEPART(QUARTER,o.OrderDate) Quy,  Tong = d.Quantity * d.UnitPrice
	FROM Products p, [Order Details] d, Categories c, Orders o
	WHERE p.ProductID=d.ProductID and o.OrderID=d.OrderID and c.CategoryID = p.CategoryID
	and YEAR(OrderDate) = 1997 
	)B
pivot
(
	SUM(Tong) for Quy in ([1], [2], [3], [4]) 
)P
 
--7.	Tạo query crostab thống kê doanh số theo từng quý của của từng sản phẩm của 1 nhóm hàng 
--nào đó trong một năm nào đó. Kết quả có dạng (thí dụ nhập loại hàng có mã (Category ID) là 1, năm 1997): 
DECLARE @Id INT = 1;

SELECT CategoryName,Total = ISNULL([1],0)+ISNULL([2],0)+ISNULL([3],0)+ISNULL([4],0), 
[1] as Qtr1, [2] as Qtr2, [3] as Qtr3, [4] as Qtr4
FROM
	(
	SELECT c.CategoryName, DATEPART(QUARTER,o.OrderDate) Quy,  Tong = d.Quantity * d.UnitPrice
	FROM Products p, [Order Details] d, Categories c, Orders o
	WHERE p.ProductID=d.ProductID and o.OrderID=d.OrderID and c.CategoryID = p.CategoryID
	and YEAR(OrderDate) = 1997 and c.CategoryID = @Id
	)B
pivot
(
	SUM(Tong) for Quy in ([1], [2], [3], [4]) 
)P