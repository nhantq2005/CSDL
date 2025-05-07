use Northwind
go

--2.	Lập danh sách các Customer ở thành phố London hoặc ở nước Pháp (France). 
--Danh sách gồm: Customer ID, Company Name, Contact Name, Address, City 

SELECT CustomerID,CompanyName,ContactName,Address,City
from Customers
where City='London' or Country='France'

--3.	Lập danh sách các Customer là Sales Manager của nước Mỹ (USA) hoặc là Owner của Mexico. 
--Danh sách gồm như trên, thêm cột Contact Title 

SELECT CustomerID,CompanyName,ContactName,Address,City, ContactTitle
from Customers
where (ContactTitle like 'Sales Manager')and(Country='USA' or Country='Mexico')

--4.	Lập danh sách các Customer là Manager của nước Mỹ (USA) hoặc: không phải là Owner của Mexico. 
--Danh sách gồm các fields như trên 

SELECT CustomerID,CompanyName,ContactName,Address,City, ContactTitle
from Customers
where (ContactTitle like '%Manager' and Country='USA')or( ContactTitle != 'Owner' and Country='Mexico')

--5.	Lập danh sách các Order có ngày đặt hàng trong 6 tháng đầu năm 1997. Danh sách gồm: 
--Order ID, Order Date, CustomerID

set dateformat dmy
SELECT OrderID,OrderDate,CustomerID
from Orders
where  OrderDate between '1/1/1997' and '30/6/1997'

--6.	Lập danh sách các Order có ngày đặt hàng trong tháng 2 năm 1997. Danh sách gồm: Order ID, Order Date, 
--CustomerID, EmployeeID.

SELECT OrderID, OrderDate, CustomerID, EmployeeID
from Orders
where MONTH(OrderDate)=2 and YEAR(OrderDate)=1997

--7.	Danh sách các Order có Ship Country là UK do nhân viên có mã là 2 phụ trách trong năm 1997. 
--Danh sách gồm:   Order ID, Order Date, Freight 

SELECT OrderID,OrderDate,Freight
from Orders
where (ShipCountry='UK')and(EmployeeID=2)and(YEAR(OrderDate)=1997)

--8.	Người ta muốn biết danh sách các sản phẩm có tên bắt đầu là Ch. Anh chi hãy lập danh sách này, 
--gồm các cột: Product ID, Product Name.

SELECT ProductID, ProductName
from Products
where ProductName like 'Ch%'

--9.	Lập danh sách các sản phẩm không còn tiếp tục cung cấp nữa (trường Discontinued) 
--và có số lượng tồn kho (trường Unit In stock) lớn hơn không. Danh sách gồm: Product ID, 
--Unit Price, Unit In Stock.

SELECT ProductID, UnitPrice, UnitsInStock
from Products
where Discontinued = 0 and UnitsInStock > 0

--10.	Lập danh sách các khách hàng không thuộc nước Mỹ. Danh sách gồm: Company Name, Contact Name, 
--Country, Phone, Fax 

SELECT CompanyName, ContactName, Country, Phone, Fax
from Customers
where Country != 'USA'

--11.	Lập danh sách các khách hàng không thuộc các nước Brazil, Italy, Spain, Venezuela và UK. 
--Danh sách gồm: Company Name, Contact Name, Country, Phone, Fax 

SELECT CompanyName, ContactName, Country, Phone, Fax
from Customers
where Country not in ('Brazil', 'Italy', 'Spain', 'Venezuela', 'UK')

--12.	Lập danh sách các đơn đặt hàng có Ship country là USA và có Freight > 300 hoặc các đơn có 
--Ship Country là Argentina và Freight <5. 
--Danh sách gồm: Order ID, Customer, Employee, Order date, Ship Country, Ship date, Freight 

SELECT *
from Orders
where ShipCountry='USA' and Freight > 300 or ShipCountry = 'Argentina' and Freight<5

--14.	Lập danh sách các đơn hàng trong tháng 4/97 gồm các 
--thông tin sau: Order ID, Order Date, Customer, Employee, Freight, New-Freight trong đó 
--New-Freight =110% Freight. 

set dateformat dmy

SELECT OrderID,OrderDate,CustomerID,EmployeeID,Freight, Freight*1.1 AS NewFreight
from Orders
where OrderDate between '1/4/1997' and '30/4/1997'

--15.	Lập danh sách trị giá tồn kho các Product không còn tiếp tục cung cấp nữa (trường 
--Discontinued là Yes). Danh sách gồm: Product ID, Product Name, Supplier Name, 
--UnitPrice, 	UintsInStock, 	Total, 	Supplier 	Fax, 	trong 	đó 	Total 	= UnitPrice*UnitsInStock 

SELECT ProductID,ProductName, CompanyName, UnitPrice, UnitsInStock, UnitPrice*UnitsInStock AS Total, Fax
from Products
join Suppliers S ON Products.SupplierID = S.SupplierID
where Discontinued = 1

--16.	Lập danh sách nhân viên (Table Employee) có hire date từ năm 1993 trở về trước. 
--Danh sách gồm: Name, Hire date, Title, BirthDate, Home Phone, 
--trong đó trường Name ghép từ các trường: TitleOfCourstesy, chữ đầu trường LastName và trường FirstName 

SELECT LastName+' '+FirstName +' '+ TitleOfCourtesy AS Name, HireDate, Title, BirthDate, HomePhone
from Employees
where YEAR(HireDate)<=1993

