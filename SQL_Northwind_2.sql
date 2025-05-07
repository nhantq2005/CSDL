--17.	Lập danh sách các Order có ngày đặt hàng trong tháng 4 hàng năm. 
--Danh sách gồm: Order ID, Order Date, Customer, Employee trong đó Customer là Company Name của khách hàng, 
--Employee lấy Last Name 

SELECT OrderID, OrderDate, c.CompanyName, e.LastName
FROM Orders o, Customers c, Employees e
WHERE o.CustomerID=c.CustomerID and e.EmployeeID = o.EmployeeID and MONTH(OrderDate)=4

--18.	Lập danh sách các Order có ngày đặt hàng các năm chẳn. Danh sách gồm: 
--Order ID, Order Date, Customer, Employee trong đó Customer là Company Name của khách hàng, Employee lấy Last Name 

SELECT OrderID, OrderDate, c.CompanyName, e.LastName
FROM Orders o, Customers c, Employees e
WHERE o.CustomerID=c.CustomerID and e.EmployeeID = o.EmployeeID and YEAR(OrderDate)%2=0

--19.	Lập danh sách các Order có ngày đặt hàng là 5, 13, 14, 23. 
--Danh sách gồm: Order ID, Order Date, Customer, Employee trong đó Customer là Company Name của khách hàng, 
--Employee lấy Last Name 

SELECT OrderID, OrderDate, c.CompanyName, e.LastName
FROM Orders o, Customers c, Employees e
WHERE o.CustomerID=c.CustomerID and e.EmployeeID = o.EmployeeID and DAY(OrderDate) in (5,13,14,23)

--20.	Người ta muốn có danh sách chi tiết các hoá đơn (Order Details) trong năm 1997. 
--Danh sách gồm các thông tin: Order ID, ProductName, Unit Price, Quantity, ThanhTien, Discount, 
--TienGiamGia, TienPhaiTra trong đó: ThanhTien = UnitPrice*Quantity, TienGiamGia = ThanhTien *Discount, 
--TienPhaiTra = ThanhTien – TienGiamGia 

SELECT d.OrderID, ProductName, d.UnitPrice, Quantity, ThanhTien = d.UnitPrice*Quantity, TienGiamGia = d.UnitPrice*Quantity*Discount,
TienPhaiTra = d.UnitPrice*Quantity*(1-Discount)
FROM [Order Details] d, Products p, Orders o
WHERE p.ProductID = d.ProductID and o.OrderID=d.OrderID and YEAR(OrderDate)=1997

--21.	Tương tự như câu 20 nhưng chỉ lấy các record có Discount >0 và có TienPhaiTra <50 

SELECT d.OrderID, ProductName, d.UnitPrice, Quantity, ThanhTien = d.UnitPrice*Quantity, TienGiamGia = d.UnitPrice*Quantity*Discount,
TienPhaiTra = d.UnitPrice*Quantity*(1-Discount)
FROM [Order Details] d, Products p, Orders o
WHERE p.ProductID = d.ProductID and o.OrderID=d.OrderID and YEAR(OrderDate)=1997 and Discount>0 
and d.UnitPrice*Quantity*(1-Discount) > 50

--22.	Từ Table Product, đếm số sản phẩm, đơn giá cao nhất, thấp nhất và đơn giá trung bình cuả tất cả sản phẩm 

SELECT COUNT(ProductID) SO_SP, MAX(UnitPrice) GIA_CAO_NHAT, Min(UnitPrice) GIA_THAP_NHAT, AVG(UnitPrice) TRUNG_BINH
FROM Products

--23.	Như câu 22 nhưng được nhóm theo loại sản phẩm (Category ID) 
SELECT CategoryID,COUNT(ProductID) SO_SP, MAX(UnitPrice) GIA_CAO_NHAT, Min(UnitPrice) GIA_THAP_NHAT, AVG(UnitPrice) TRUNG_BINH
FROM Products
GROUP BY CategoryID

--24.	Đếm số đơn đặt hàng cuả các Order có Ship Country là Belgium, Canada, UK

SELECT Count(ShipCountry) SL_DON
FROM Orders
WHERE ShipCountry in ('Belgium', 'Canada', 'UK')

--25.	Lập danh sách các loại sản phẩm có đơn giá trung bình lớn hơn 30 



--26.	Tính đơn giá trung bình cuả các sản phẩm có đơn giá lớn hơn 30, nhóm theo loại sản phẩm 

SELECT ProductName, AVG(UnitPrice) Gia_trung_binh
FROM Products
WHERE UnitPrice>30
GROUP BY ProductName


--27.	Thiết kế query tính doanh số của từng loại sản phẩm (Category) trong năm 1996. 
--Danh sách gồm 2 cột: Category Name, Sales; trong đó SalesTotal = UnitPrice*Quantity*(1-Discount) 

SELECT CategoryName, 'SalesTotal' = SUM(p.UnitPrice*Quantity*(1-Discount))
FROM Categories c, Products p, [Order Details] d, Orders o
WHERE c.CategoryID = p.CategoryID and  p.ProductID = d.ProductID and o.OrderID = d.OrderID
and YEAR(OrderDate) = 1996
GROUP BY CategoryName

--28.	Thiết kế query tính tỉ lệ tiền cước mua hàng (Freight) của từng khách hàng trong năm 1997. 
--Danh sách gồm các cột: Company Name (của Customer), Freight, SalesTotal = UnitPrice * Quantity*(1-Discount), 
--Percent= Freight/SalesTotal 

SELECT CompanyName, Freight, 'SalesTotal' = SUM(p.UnitPrice*Quantity*(1-Discount)), 'Percent' = SUM(Freight/(p.UnitPrice*Quantity*(1-Discount)))
FROM Orders o, [Order Details] d, Products p, Customers c
WHERE o.CustomerID = c.CustomerID and d.ProductID = p.ProductID and o.OrderID = d.OrderID and YEAR(OrderDate) = 1997
GROUP BY CompanyName, Freight

-------BT Tham khảo thêm-------
--29.	Lập danh sách Customer có Company Name bắt đầu là 1 chữ nào đó được nhập từ bàn phím. 
--Danh sách gồm: Customer ID, CompanyName, ContactName, Address, City, Country, Phone, Fax 

declare @kytu char(1)
set @kytu = 'a'

SELECT CustomerID, CompanyName, ContactName, Address, City, Country, Phone, Fax
FROM Customers
WHERE ContactName like @kytu+'%'

--30.	Lập danh sách các Order có Order Date trong 1 khoảng thời gian nào đó. Tham số nhập: “From date:” và “To:”. 
--Danh sách gồm: Order ID, Customer, ShipCountry, OrderDate 

set dateformat dmy
declare @ngayBD datetime, @ngayKT datetime

set @ngayBD='1/1/1997'
set @ngayKT= '30/6/1997'

SELECT OrderID, CustomerID, ShipCity, OrderDate
FROM Orders
WHERE OrderDate between @ngayBD and @ngayKT

--31.	Người ta muốn có danh sách các Order của một quốc gia nào đó của khách hàng trong một năm mua hàng 
--nào đó được nhập từ bàn phím. Anh chị hãy thực hiện Query này. Danh sách gồm các cột như trên.

declare @country char(10)

set @country = 'UK'

SELECT *
FROM Orders
WHERE ShipCountry=@country


--32.	Tạo danh sách các Product thuộc một loại nào đó khi nhập Category ID từ bàn phím. 
--Danh sách gồm: Product Name, Unit Price, Supplier

declare @id int
set @id =1

SELECT *
FROM Products
WHERE ProductID = @id


--33.	Người ta muốn biết trong một ngày nào đó có số lượng đơn đặt hàng theo 
--từng khách hàng cần phải hoàn tất hay không? (theo Required Date). Anh Chị hãy tạo query để thực hiện điều này. 
--Thí dụ nhập ngày 28/9/95 thì ra kết quả sau: 

declare @ngay datetime
set @ngay= '28/9/1995'

SELECT c.CompanyName as Customer, Count(o.OrderID) as CountOfOrderId
FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID and OrderDate = @ngay
GROUP BY c.CompanyName



--34.	Thông thường các khách hàng muốn biết thông tin về đơn hàng của họ đã đặt hàng vào một ngày nào đó. 
--(Khách hàng sẽ báo tên công ty và ngày đặt hàng). Thông tin gồm tất cả các cột của table Order. 
--Anh chị hãy thiết kế query để thực hiện điều này. 

declare @ngayDat datetime
set @ngayDat = '1/1/97'

SELECT *
FROM Orders
WHERE OrderDate = @ngayDat

--35.	Tương tự nhưng năm được nhập từ bàn phím; trong đó nếu không nhập năm mà chỉ Enter thì sẽ lấy năm hiện tại để tính. 

declare @ngayB datetime, @ngayE datetime
set @ngayB = '1/1/97'
set @ngayE ='5/5/97'

if @ngayB is null or @ngayB = ''
	set @ngayB = GETDATE()

if @ngayE is null or @ngayE = ''
	set @ngayE = GETDATE()

SELECT *
FROM Orders
WHERE OrderDate between @ngayB and @ngayE

--36.	Người ta muốn biết trong một ngày nào đó (nếu chỉ Enter là ngày hiện tại) tổng số đơn đặt hàng và doanh số cuả các đơn hàng 
--đó là bao nhiêu. Thí dụ nhập 7 thang 4 nam 1998 thì kết quả sẽ là: 

declare @ngay1 datetime
set @ngay1 = '7/4/1998'

if @ngay1 is null or @ngay1=''
	set @ngay1=GETDATE()

SELECT Count(o.OrderID) 'Số lượng đơn', Round(Sum(d.UnitPrice*d.Quantity*(1-d.Discount)),3) 'Doanh số' 
FROM Orders o, [Order Details] d
WHERE o.OrderID=d.OrderID and o.OrderDate = @ngay1
