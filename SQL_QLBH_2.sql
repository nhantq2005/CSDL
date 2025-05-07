use QuanLyBanHang
go

--11.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, 
--địa chỉ khách hàng và số điện thoại của những hóa đơn trong tháng 6/2010.
set dateformat dmy
SELECT h.MAHD, h.NGAY, k.TENKH, k.DIACHI, k.DT 
FROM HoaDon h, KhachHang k
WHERE h.MAKH = k.MAKH and h.NGAY between '1/6/2010' and '30/6/2010'

--12.	Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong tháng 6/2010. 
SELECT k.TENKH, k.DIACHI, k.DT 
FROM HoaDon h, KhachHang k
WHERE h.MAKH = k.MAKH and h.NGAY between '1/6/2010' and '30/6/2010'

--13.	Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2010 
--gồm các thông tin tên khách hàng, địa chỉ, số điện thoại. 
--14.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, 
--giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng). 
SELECT c.MAHD, c.MAVT, v.TENVT, v.DVT, c.GIABAN, v.GIAMUA, c.SL, 'TRIGIAMUA'=v.GIAMUA*c.SL, 'TRIGIABAN' = c.GIABAN*c.SL
FROM CTHD c, VatTu v
WHERE c.MAVT = v.MAVT

--15.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, 
--đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) 
--mà có giá bán lớn hơn hoặc bằng giá mua. 
SELECT c.MAHD, c.MAVT, v.TENVT, v.DVT, c.GIABAN, v.GIAMUA, c.SL, 'TRIGIAMUA'=v.GIAMUA*c.SL, 'TRIGIABAN' = c.GIABAN*c.SL
FROM CTHD c, VatTu v
WHERE c.MAVT = v.MAVT and c.GIABAN>=v.GIAMUA


--16.	Lấy ra các thông tin gồm mã hóa đơn, mã vật tư, tên vật tư, 
--đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) 
--và cột khuyến mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lớn hơn 100. 
SELECT c.MAHD, c.MAVT, v.TENVT, v.DVT, c.GIABAN, v.GIAMUA, c.SL, 'TRIGIAMUA'=v.GIAMUA*c.SL, 'TRIGIABAN' = c.GIABAN*c.SL,
'KHUYENMAI'= case
when c.SL>100 then 0.1*c.SL*C.GIABAN
else 0
end
FROM CTHD c, VatTu v
WHERE c.MAVT = v.MAVT

--17.	Tìm ra những mặt hàng chưa bán được.
SELECT *
FROM VatTu v
WHERE v.MAVT not in ( SELECT distinct c.MAVT
					FROM CTHD c)

--SELECT *

--18.	Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, 
--địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán.
SELECT c.MAHD,h.NGAY,k.TENKH, k.DT, v.TENVT, v.DVT, c.GIABAN, v.GIAMUA, c.SL, 
'TRIGIAMUA'=v.GIAMUA*c.SL, 'TRIGIABAN' = c.GIABAN*c.SL
FROM VatTu v, CTHD c, KhachHang k, HoaDon h
WHERE v.MAVT=c.MAVT and c.MAHD=h.MAHD and h.MAKH=k.MAKH

--19.	Tạo bảng tổng hợp tháng 5/2010 gồm các thông tin: 
--mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, 
--đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán.  
SELECT c.MAHD,h.NGAY,k.TENKH, k.DT, v.TENVT, v.DVT, c.GIABAN, v.GIAMUA, c.SL, 
'TRIGIAMUA'=v.GIAMUA*c.SL, 'TRIGIABAN' = c.GIABAN*c.SL
FROM VatTu v, CTHD c, KhachHang k, HoaDon h
WHERE v.MAVT=c.MAVT and c.MAHD=h.MAHD and h.MAKH=k.MAKH and MONTH(NGAY)=5 and YEAR(NGAY)=2010

--20.	Tạo bảng tổng hợp quý 1 – 2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, 
--tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
SELECT c.MAHD,h.NGAY,k.TENKH, k.DT, v.TENVT, v.DVT, c.GIABAN, v.GIAMUA, c.SL, 
'TRIGIAMUA'=v.GIAMUA*c.SL, 'TRIGIABAN' = c.GIABAN*c.SL
FROM VatTu v, CTHD c, KhachHang k, HoaDon h
WHERE v.MAVT=c.MAVT and c.MAHD=h.MAHD and h.MAKH=k.MAKH and DATEPART(q,NGAY)=2

--21.	Lấy ra danh sách các hóa đơn gồm các thông tin: Số hóa đơn, ngày, tên khách hàng, 
--địa chỉ khách hàng, tổng trị giá của hóa đơn. 
SELECT h.MAHD, h.NGAY, k.TENKH, k.DIACHI, SUM(c.SL*c.GIABAN) 'TONG TRI GIA'
FROM CTHD c, KhachHang k, HoaDon h
GROUP BY h.MAHD, h.NGAY, k.TENKH, k.DIACHI

--22.	Lấy ra hóa đơn có tổng trị giá lớn nhất gồm các thông tin: 
--Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
SELECT TOP 1 h.MAHD, h.NGAY, k.TENKH, k.DIACHI, SUM(c.SL*c.GIABAN) 'TONG TRI GIA'
FROM CTHD c, KhachHang k, HoaDon h
GROUP BY h.MAHD, h.NGAY, k.TENKH, k.DIACHI

--23.	Lấy ra hóa đơn có tổng trị giá lớn nhất trong tháng 5/2010 gồm các thông tin: 
--Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn. 
SELECT TOP 1 h.MAHD, h.NGAY, k.TENKH, k.DIACHI, SUM(c.SL*c.GIABAN) 'TONG TRI GIA'
FROM CTHD c, KhachHang k, HoaDon h
WHERE YEAR(NGAY)=2010 and MONTH(NGAY)=5
GROUP BY h.MAHD, h.NGAY, k.TENKH, k.DIACHI
ORDER BY [TONG TRI GIA] DESC

--24.	Đếm xem mỗi khách hàng có bao nhiêu hóa đơn. 
SELECT k.TENKH, COUNT(h.MAHD) 'SL DON'
FROM KhachHang k, HoaDon h
WHERE k.MAKH=h.MAKH
GROUP BY TENKH

--25.	Đếm xem mỗi khách hàng, mỗi tháng có bao nhiêu hóa đơn.
SELECT k.MAKH,MONTH(NGAY) as 'Thang', COUNT(h.MAHD) 'SL DON'
FROM KhachHang k, HoaDon h
WHERE k.MAKH=h.MAKH
GROUP BY k.MAKH, MONTH(NGAY)

--26.	Lấy ra các thông tin của khách hàng có số lượng hóa đơn mua hàng nhiều nhất. 
SELECT TOP 1 k.TENKH,k.DIACHI,k.DT,k.EMAIL, COUNT(h.MAHD) 'SL DON'
FROM KhachHang k, HoaDon h
WHERE k.MAKH=h.MAKH
GROUP BY TENKH, k.DIACHI,k.DT,k.EMAIL
ORDER BY 5 DESC
--27.	Lấy ra các thông tin của khách hàng có số lượng hàng mua nhiều nhất.
SELECT TOP 1 k.TENKH, k.DIACHI, k.DT, SUM(c.SL) 'TONG SL'
FROM VatTu v, CTHD c, KhachHang k, HoaDon h
WHERE v.MAVT=c.MAVT and c.MAHD=h.MAHD and h.MAKH=k.MAKH
GROUP BY k.TENKH, k.DIACHI, k.DT
ORDER BY 4 DESC

--28.	Lấy ra các thông tin về các mặt hàng mà được bán trong nhiều hóa đơn nhất.
SELECT v.TENVT, COUNT(c.MAHD) 'SLHD'
FROM VatTu v, CTHD c
WHERE c.MAVT=v.MAVT
GROUP BY TENVT
ORDER BY 2 DESC

--29.	Lấy ra các thông tin về các mặt hàng mà được bán nhiều nhất. 
SELECT Top 1 v.TENVT, SUM(c.SL) 'TSL'
FROM VatTu v, CTHD c
WHERE v.MAVT = c.MAVT
GROUP BY v.TENVT
ORDER BY 2 DESC
--30.	Lấy ra danh sách tất cả các khách hàng gồm Mã khách hàng, tên khách hàng, 
--địa chỉ, số lượng hóa đơn đã mua (nếu khách hàng đó chưa mua hàng thì cột số lượng hóa đơn để trống)
SELECT k.MAKH, k.TENKH,k.DIACHI,'SLHD DA MUA' = case
when COUNT(h.MAHD) = 0 then 0
else COUNT(h.MAHD)
end
FROM KhachHang k LEFT JOIN HoaDon h on k.MAKH=h.MAKH
GROUP BY k.MAKH, k.TENKH,k.DIACHI
