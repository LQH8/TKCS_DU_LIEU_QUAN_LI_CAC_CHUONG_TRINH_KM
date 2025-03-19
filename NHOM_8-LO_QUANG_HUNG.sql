-- Tạo Database
CREATE DATABASE QuanLyKhuyenMai;
GO

-- Sử dụng Database
USE QuanLyKhuyenMai;
GO

-- Tạo bảng tblLoaiKhuyenMai
CREATE TABLE tblLoaiKhuyenMai (
    sMaLoaiKhuyenMai VARCHAR(20) PRIMARY KEY,
    sTenLoaiKhuyenMai NVARCHAR(50) NOT NULL
);

-- Tạo bảng tblKhuyenMai
CREATE TABLE tblKhuyenMai (
    sMaKhuyenMai VARCHAR(20) PRIMARY KEY,
    sTenKhuyenMai NVARCHAR(100) NOT NULL,
    dNgayBatDau DATE NOT NULL,
    dNgayKetThuc DATE NOT NULL,
    fMucGiamGia FLOAT NOT NULL,
    sMaLoaiKhuyenMai VARCHAR(20) NOT NULL,
    FOREIGN KEY (sMaLoaiKhuyenMai) REFERENCES tblLoaiKhuyenMai(sMaLoaiKhuyenMai)
);

-- Tạo bảng tblSanPham
CREATE TABLE tblSanPham (
    sMaSanPham VARCHAR(20) PRIMARY KEY,
    sTenSanPham NVARCHAR(100) NOT NULL,
    fGiaBan FLOAT NOT NULL,
    sMoTa NVARCHAR(255)
);

-- Tạo bảng tblKhachHang
CREATE TABLE tblKhachHang (
    sMaKhachHang VARCHAR(20) PRIMARY KEY,
    sTenKhachHang NVARCHAR(100) NOT NULL,
    sDienThoai VARCHAR(15),
    sEmail VARCHAR(50)
);

-- Tạo bảng tblChiTietKhuyenMai
CREATE TABLE tblChiTietKhuyenMai (
    sMaChiTietKhuyenMai VARCHAR(20) PRIMARY KEY,
    sMaKhuyenMai VARCHAR(20) NOT NULL,
    sMaSanPham VARCHAR(20) NOT NULL,
    sMaKhachHang VARCHAR(20) NOT NULL,
    iSoLuong INT NOT NULL,
    fTongTien FLOAT NOT NULL,
    FOREIGN KEY (sMaKhuyenMai) REFERENCES tblKhuyenMai(sMaKhuyenMai),
    FOREIGN KEY (sMaSanPham) REFERENCES tblSanPham(sMaSanPham),
    FOREIGN KEY (sMaKhachHang) REFERENCES tblKhachHang(sMaKhachHang)
);

-- Chèn dữ liệu vào bảng tblLoaiKhuyenMai
INSERT INTO tblLoaiKhuyenMai (sMaLoaiKhuyenMai, sTenLoaiKhuyenMai)
VALUES 
('LKM001', N'Giảm giá trực tiếp'),
('LKM002', N'Tặng quà'),
('LKM003', N'Tích điểm'),
('LKM004', N'Giảm giá theo hóa đơn'),
('LKM005', N'Khuyến mãi combo');

-- Chèn dữ liệu vào bảng tblKhuyenMai
INSERT INTO tblKhuyenMai (sMaKhuyenMai, sTenKhuyenMai, dNgayBatDau, dNgayKetThuc, fMucGiamGia, sMaLoaiKhuyenMai)
VALUES 
('KM001', N'Khuyến mãi Black Friday', '2023-11-20', '2023-11-25', 20, 'LKM001'),
('KM002', N'Tặng quà đặc biệt', '2023-12-01', '2023-12-31', 0, 'LKM002'),
('KM003', N'Tích điểm đổi quà', '2023-10-01', '2023-12-31', 0, 'LKM003'),
('KM004', N'Giảm giá cuối năm', '2023-12-15', '2023-12-31', 15, 'LKM004'),
('KM005', N'Combo mua 2 tặng 1', '2023-11-01', '2023-11-30', 0, 'LKM005');

-- Chèn dữ liệu vào bảng tblSanPham
INSERT INTO tblSanPham (sMaSanPham, sTenSanPham, fGiaBan, sMoTa)
VALUES 
('SP001', N'Laptop Dell XPS 13', 25000000, N'Laptop cao cấp'),
('SP002', N'iPhone 15 Pro Max', 30000000, N'Điện thoại thông minh'),
('SP003', N'Samsung Galaxy S23', 20000000, N'Điện thoại Android'),
('SP004', N'Apple Watch Series 8', 10000000, N'Đồng hồ thông minh'),
('SP005', N'AirPods Pro 2', 5000000, N'Tai nghe không dây');

-- Chèn dữ liệu vào bảng tblKhachHang
INSERT INTO tblKhachHang (sMaKhachHang, sTenKhachHang, sDienThoai, sEmail)
VALUES 
('KH001', N'Nguyễn Văn A', '0912345678', 'nguyenvana@gmail.com'),
('KH002', N'Trần Thị B', '0987654321', 'tranthib@gmail.com'),
('KH003', N'Lê Văn C', '0901234567', 'levanc@gmail.com'),
('KH004', N'Phạm Thị D', '0978123456', 'phamthid@gmail.com'),
('KH005', N'Hoàng Văn E', '0965432187', 'hoangvane@gmail.com');

-- Chèn dữ liệu vào bảng tblChiTietKhuyenMai
INSERT INTO tblChiTietKhuyenMai (sMaChiTietKhuyenMai, sMaKhuyenMai, sMaSanPham, sMaKhachHang, iSoLuong, fTongTien)
VALUES 
('CTKM001', 'KM001', 'SP001', 'KH001', 1, 20000000),
('CTKM002', 'KM002', 'SP002', 'KH002', 2, 60000000),
('CTKM003', 'KM003', 'SP003', 'KH003', 1, 20000000),
('CTKM004', 'KM004', 'SP004', 'KH004', 3, 25500000),
('CTKM005', 'KM005', 'SP005', 'KH005', 2, 10000000);

-- In dữ liệu từ các bảng
SELECT * FROM tblLoaiKhuyenMai;
SELECT * FROM tblKhuyenMai;
SELECT * FROM tblSanPham;
SELECT * FROM tblKhachHang;
SELECT * FROM tblChiTietKhuyenMai;

-- Tạo các view
-- 1. Lấy danh sách tất cả các chương trình khuyến mãi
CREATE VIEW vw_AllPromotions AS
SELECT * FROM tblKhuyenMai;

-- 2. Lấy danh sách sản phẩm có giá bán lớn hơn 15,000,000 VNĐ
CREATE VIEW vw_HighPriceProducts AS
SELECT * FROM tblSanPham
WHERE fGiaBan > 15000000;

-- 3. Lấy thông tin khách hàng có email là "doquockhanh@gmail.com"
CREATE VIEW vw_CustomerByEmail AS
SELECT * FROM tblKhachHang
WHERE sEmail = 'doquockhanh@gmail.com';

-- 4. Đếm số lượng chương trình khuyến mãi đang diễn ra
CREATE VIEW vw_ActivePromotionsCount AS
SELECT COUNT(*) AS SoLuongKhuyenMaiDangDienRa
FROM tblKhuyenMai
WHERE dNgayBatDau <= GETDATE() AND dNgayKetThuc >= GETDATE();

-- 5. Lấy danh sách chi tiết khuyến mãi kèm tên sản phẩm và tên khách hàng
CREATE VIEW vw_PromotionDetails AS
SELECT CT.sMaChiTietKhuyenMai, SP.sTenSanPham, KH.sTenKhachHang
FROM tblChiTietKhuyenMai CT
JOIN tblSanPham SP ON CT.sMaSanPham = SP.sMaSanPham
JOIN tblKhachHang KH ON CT.sMaKhachHang = KH.sMaKhachHang;

-- 6. Tính tổng số tiền khuyến mãi của từng chương trình
CREATE VIEW vw_TotalDiscountByPromotion AS
SELECT KM.sMaKhuyenMai, KM.sTenKhuyenMai, SUM(CT.fTongTien) AS TongTienKhuyenMai
FROM tblKhuyenMai KM
JOIN tblChiTietKhuyenMai CT ON KM.sMaKhuyenMai = CT.sMaKhuyenMai
GROUP BY KM.sMaKhuyenMai, KM.sTenKhuyenMai;

-- 7. Lấy danh sách khách hàng tham gia chương trình khuyến mãi "Black Friday"
CREATE VIEW vw_CustomersInBlackFriday AS
SELECT KH.sTenKhachHang, KH.sDienThoai
FROM tblKhachHang KH
JOIN tblChiTietKhuyenMai CT ON KH.sMaKhachHang = CT.sMaKhachHang
JOIN tblKhuyenMai KM ON CT.sMaKhuyenMai = KM.sMaKhuyenMai
WHERE KM.sTenKhuyenMai = N'Khuyến mãi Black Friday';

-- 8. Cập nhật mức giảm giá của chương trình khuyến mãi "Black Friday" lên 25%
UPDATE tblKhuyenMai
SET fMucGiamGia = 25
WHERE sTenKhuyenMai = N'Khuyến mãi Black Friday';

-- 9. Xóa các chi tiết khuyến mãi có tổng tiền nhỏ hơn 10,000,000 VNĐ
DELETE FROM tblChiTietKhuyenMai
WHERE fTongTien < 10000000;

-- 10. Lấy danh sách sản phẩm chưa tham gia bất kỳ chương trình khuyến mãi nào
CREATE VIEW vw_ProductsNotInPromotion AS
SELECT SP.sMaSanPham, SP.sTenSanPham
FROM tblSanPham SP
LEFT JOIN tblChiTietKhuyenMai CT ON SP.sMaSanPham = CT.sMaSanPham
WHERE CT.sMaSanPham IS NULL;

-- Tạo các procedure
-- 1. Lấy danh sách chương trình khuyến mãi đang diễn ra
CREATE PROCEDURE sp_GetActivePromotions
AS
BEGIN
    SELECT * FROM tblKhuyenMai
    WHERE dNgayBatDau <= GETDATE() AND dNgayKetThuc >= GETDATE();
END;

-- 2. Lấy thông tin chi tiết khuyến mãi theo mã khuyến mãi
CREATE PROCEDURE sp_GetPromotionDetails
    @MaKhuyenMai VARCHAR(20)
AS
BEGIN
    SELECT CT.*, SP.sTenSanPham, KH.sTenKhachHang
    FROM tblChiTietKhuyenMai CT
    JOIN tblSanPham SP ON CT.sMaSanPham = SP.sMaSanPham
    JOIN tblKhachHang KH ON CT.sMaKhachHang = KH.sMaKhachHang
    WHERE CT.sMaKhuyenMai = @MaKhuyenMai;
END;

-- 3. Thêm mới một chương trình khuyến mãi
CREATE PROCEDURE sp_AddPromotion
    @MaKhuyenMai VARCHAR(20),
    @TenKhuyenMai NVARCHAR(100),
    @NgayBatDau DATE,
    @NgayKetThuc DATE,
    @MucGiamGia FLOAT,
    @MaLoaiKhuyenMai VARCHAR(20)
AS
BEGIN
    INSERT INTO tblKhuyenMai (sMaKhuyenMai, sTenKhuyenMai, dNgayBatDau, dNgayKetThuc, fMucGiamGia, sMaLoaiKhuyenMai)
    VALUES (@MaKhuyenMai, @TenKhuyenMai, @NgayBatDau, @NgayKetThuc, @MucGiamGia, @MaLoaiKhuyenMai);
END;

-- 4. Cập nhật mức giảm giá của chương trình khuyến mãi
CREATE PROCEDURE sp_UpdatePromotionDiscount
    @MaKhuyenMai VARCHAR(20),
    @MucGiamGia FLOAT
AS
BEGIN
    UPDATE tblKhuyenMai
    SET fMucGiamGia = @MucGiamGia
    WHERE sMaKhuyenMai = @MaKhuyenMai;
END;

-- 5. Xóa một chương trình khuyến mãi
CREATE PROCEDURE sp_DeletePromotion
    @MaKhuyenMai VARCHAR(20)
AS
BEGIN
    DELETE FROM tblKhuyenMai
    WHERE sMaKhuyenMai = @MaKhuyenMai;
END;

-- 6. Tính tổng số tiền khuyến mãi của một khách hàng
CREATE PROCEDURE sp_GetTotalDiscountByCustomer
    @MaKhachHang VARCHAR(20)
AS
BEGIN
    SELECT KH.sTenKhachHang, SUM(CT.fTongTien) AS TongTienKhuyenMai
    FROM tblChiTietKhuyenMai CT
    JOIN tblKhachHang KH ON CT.sMaKhachHang = KH.sMaKhachHang
    WHERE KH.sMaKhachHang = @MaKhachHang
    GROUP BY KH.sTenKhachHang;
END;

-- 7. Lấy danh sách sản phẩm tham gia khuyến mãi
CREATE PROCEDURE sp_GetProductsInPromotion
    @MaKhuyenMai VARCHAR(20)
AS
BEGIN
    SELECT SP.sMaSanPham, SP.sTenSanPham
    FROM tblSanPham SP
    JOIN tblChiTietKhuyenMai CT ON SP.sMaSanPham = CT.sMaSanPham
    WHERE CT.sMaKhuyenMai = @MaKhuyenMai;
END;

-- 8. Đếm số lượng khách hàng tham gia khuyến mãi
CREATE PROCEDURE sp_CountCustomersInPromotion
    @MaKhuyenMai VARCHAR(20)
AS
BEGIN
    SELECT COUNT(DISTINCT sMaKhachHang) AS SoLuongKhachHang
    FROM tblChiTietKhuyenMai
    WHERE sMaKhuyenMai = @MaKhuyenMai;
END;

-- 9. Lấy danh sách khuyến mãi theo loại
CREATE PROCEDURE sp_GetPromotionsByType
    @MaLoaiKhuyenMai VARCHAR(20)
AS
BEGIN
    SELECT * FROM tblKhuyenMai
    WHERE sMaLoaiKhuyenMai = @MaLoaiKhuyenMai;
END;

-- 10. Tính tổng doanh thu từ khuyến mãi
CREATE PROCEDURE sp_GetTotalRevenueFromPromotions
AS
BEGIN
    SELECT SUM(fTongTien) AS TongDoanhThu
    FROM tblChiTietKhuyenMai;
END;

-- Tạo các trigger
-- 1. Kiểm tra ngày kết thúc khuyến mãi phải lớn hơn ngày bắt đầu
CREATE TRIGGER trg_CheckPromotionDate
ON tblKhuyenMai
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE dNgayKetThuc <= dNgayBatDau)
    BEGIN
        RAISERROR('Ngày kết thúc phải lớn hơn ngày bắt đầu.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- 2. Tự động cập nhật tổng tiền khi thêm chi tiết khuyến mãi
CREATE TRIGGER trg_UpdateTotalAmount
ON tblChiTietKhuyenMai
FOR INSERT
AS
BEGIN
    UPDATE CT
    SET fTongTien = SP.fGiaBan * CT.iSoLuong * (1 - KM.fMucGiamGia / 100)
    FROM tblChiTietKhuyenMai CT
    JOIN tblSanPham SP ON CT.sMaSanPham = SP.sMaSanPham
    JOIN tblKhuyenMai KM ON CT.sMaKhuyenMai = KM.sMaKhuyenMai
    WHERE CT.sMaChiTietKhuyenMai IN (SELECT sMaChiTietKhuyenMai FROM inserted);
END;

-- 3. Ngăn chặn xóa chương trình khuyến mãi đang diễn ra
CREATE TRIGGER trg_PreventDeleteActivePromotion
ON tblKhuyenMai
FOR DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM deleted WHERE dNgayBatDau <= GETDATE() AND dNgayKetThuc >= GETDATE())
    BEGIN
        RAISERROR('Không thể xóa chương trình khuyến mãi đang diễn ra.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- 4. Kiểm tra số lượng sản phẩm khi thêm chi tiết khuyến mãi
CREATE TRIGGER trg_CheckProductQuantity
ON tblChiTietKhuyenMai
FOR INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE iSoLuong <= 0)
    BEGIN
        RAISERROR('Số lượng sản phẩm phải lớn hơn 0.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- 5. Tự động cập nhật số lượng khách hàng tham gia khuyến mãi
CREATE TRIGGER trg_UpdateCustomerCount
ON tblChiTietKhuyenMai
FOR INSERT, DELETE
AS
BEGIN
    UPDATE KM
    SET iSoLuongKhachHang = (SELECT COUNT(DISTINCT sMaKhachHang) FROM tblChiTietKhuyenMai WHERE sMaKhuyenMai = KM.sMaKhuyenMai)
    FROM tblKhuyenMai KM
    WHERE KM.sMaKhuyenMai IN (SELECT sMaKhuyenMai FROM inserted UNION SELECT sMaKhuyenMai FROM deleted);
END;

-- 6. Kiểm tra email khách hàng hợp lệ
CREATE TRIGGER trg_ValidateCustomerEmail
ON tblKhachHang
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE sEmail NOT LIKE '%_@__%.__%')
    BEGIN
        RAISERROR('Email không hợp lệ.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- 7. Tự động ghi log khi thêm chương trình khuyến mãi
CREATE TABLE tblLogKhuyenMai (
    sMaLog VARCHAR(20) PRIMARY KEY,
    sMaKhuyenMai VARCHAR(20),
    sTenKhuyenMai NVARCHAR(100),
    dNgayTao DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_LogPromotionInsert
ON tblKhuyenMai
FOR INSERT
AS
BEGIN
    INSERT INTO tblLogKhuyenMai (sMaLog, sMaKhuyenMai, sTenKhuyenMai)
    SELECT NEWID(), sMaKhuyenMai, sTenKhuyenMai FROM inserted;
END;

-- 8. Ngăn chặn cập nhật mã khuyến mãi
CREATE TRIGGER trg_PreventUpdatePromotionID
ON tblKhuyenMai
FOR UPDATE
AS
BEGIN
    IF UPDATE(sMaKhuyenMai)
    BEGIN
        RAISERROR('Không thể cập nhật mã khuyến mãi.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- 9. Tự động cập nhật mô tả sản phẩm khi giá thay đổi
CREATE TRIGGER trg_UpdateProductDescription
ON tblSanPham
FOR UPDATE
AS
BEGIN
    IF UPDATE(fGiaBan)
    BEGIN
        UPDATE SP
        SET sMoTa = N'Sản phẩm có giá mới: ' + CAST(i.fGiaBan AS NVARCHAR)
        FROM tblSanPham SP
        JOIN inserted i ON SP.sMaSanPham = i.sMaSanPham;
    END
END;

-- 10. Kiểm tra loại khuyến mãi tồn tại khi thêm chương trình khuyến mãi
CREATE TRIGGER trg_CheckPromotionType
ON tblKhuyenMai
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE sMaLoaiKhuyenMai NOT IN (SELECT sMaLoaiKhuyenMai FROM tblLoaiKhuyenMai))
    BEGIN
        RAISERROR('Loại khuyến mãi không tồn tại.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- Phân quyền và bảo vệ cơ sở dữ liệu
-- Tạo các tài khoản người dùng
CREATE LOGIN QuanLy WITH PASSWORD = 'QuanLy@123';
CREATE USER QuanLy FOR LOGIN QuanLy;

CREATE LOGIN NhanVien WITH PASSWORD = 'NhanVien@123';
CREATE USER NhanVien FOR LOGIN NhanVien;

CREATE LOGIN KhachHang WITH PASSWORD = 'KhachHang@123';
CREATE USER KhachHang FOR LOGIN KhachHang;

-- Phân quyền cho Tài khoản Quản lý
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP ON DATABASE::QuanLyKhuyenMai TO QuanLy;

-- Phân quyền cho Tài khoản Nhân viên
GRANT SELECT ON SCHEMA::dbo TO NhanVien;
GRANT INSERT, UPDATE ON tblChiTietKhuyenMai TO NhanVien;
GRANT INSERT, UPDATE ON tblKhachHang TO NhanVien;

-- Phân quyền cho Tài khoản Khách hàng
GRANT SELECT ON tblKhuyenMai TO KhachHang;
GRANT SELECT ON tblSanPham TO KhachHang;
GRANT SELECT ON tblLoaiKhuyenMai TO KhachHang;

-- Thu hồi quyền
REVOKE INSERT, UPDATE ON tblChiTietKhuyenMai FROM NhanVien;
REVOKE SELECT ON tblKhuyenMai FROM KhachHang;

-- Kiểm tra quyền
SELECT * FROM fn_my_permissions(NULL, 'DATABASE') WHERE grantee_principal_id = USER_ID('QuanLy');
SELECT * FROM fn_my_permissions(NULL, 'DATABASE') WHERE grantee_principal_id = USER_ID('NhanVien');
SELECT * FROM fn_my_permissions(NULL, 'DATABASE') WHERE grantee_principal_id = USER_ID('KhachHang');

-- Ví dụ về phân quyền chi tiết
GRANT UPDATE (iSoLuong) ON tblChiTietKhuyenMai TO NhanVien;

CREATE VIEW vw_ActivePromotions AS
SELECT * FROM tblKhuyenMai
WHERE dNgayBatDau <= GETDATE() AND dNgayKetThuc >= GETDATE();

GRANT SELECT ON vw_ActivePromotions TO KhachHang;