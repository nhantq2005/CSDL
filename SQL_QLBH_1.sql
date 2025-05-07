use QuanLyBanHang
go

--1.	Hiển thị danh sách các khách hàng có địa chỉ là “Tân Bình” gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
SELECT *
from KhachHang
where DIACHI like N'%Tân Bình%'

--2.	Hiển thị danh sách các khách hàng gồm các thông tin mã khách hàng, tên khách hàng, địa chỉ 
--và địa chỉ E-mail của những khách hàng chưa có số điện thoại. 
SELECT *
from KhachHang
where DT is null

--3.	Hiển thị danh sách các khách hàng chưa có số điện thoại và 
--cũng chưa có địa chỉ Email gồm mã khách hàng, tên khách hàng, địa chỉ. 
SELECT *
from KhachHang
where DT is null and EMAIL is null
--4.	Hiển thị danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail 
--gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail. 
SELECT *
from KhachHang
where DT is not null and EMAIL is not null

--5.	Hiển thị danh sách các vật tư có đơn vị tính là “Cái” gồm mã vật tư, tên vật tư và giá mua. 
SELECT *
from VatTu
where DVT = N'Cái'

--6.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua trên 25000. 
SELECT MAVT, TENVT, DVT, GIAMUA
from VatTu
where GIAMUA>25000

--7.	Hiển thị danh sách các vật tư là “Gạch” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua. 
SELECT MAVT,TENVT,DVT,GIAMUA
from VatTu
where TENVT like N'Gạch%'

--8.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000. 
SELECT MAVT,TENVT,GIAMUA
from VatTu
where GIAMUA between 20000 and 40000

--9.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại. 
SELECT MAHD, NGAY, TENKH, DIACHI, DT
FROM HoaDon, KhachHang
WHERE HoaDon.MAKH = KhachHang.MAKH

--10.	Lấy ra các thông tin gồm Mã hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2010. 
set dateformat dmy
SELECT MAHD, TENKH, DIACHI, DT
FROM HoaDon, KhachHang
WHERE NGAY='25/5/2010' and HoaDon.MAKH = KhachHang.MAKH

--11.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, 
--địa chỉ khách hàng và số điện thoại của những hóa đơn trong tháng 6/2010.
SELECT MAHD, NGAY, TENKH, DIACHI, DT
FROM HoaDon
JOIN KhachHang KH ON KH.MAKH = HoaDon.MAKH
WHERE NGAY BETWEEN '1/6/2010' AND '30/6/2010'

