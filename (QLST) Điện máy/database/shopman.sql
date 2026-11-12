-- ========================================================
-- CƠ SỞ DỮ LIỆU: HỆ THỐNG QUẢN LÝ SIÊU THỊ ĐIỆN MÁY (SHOPMAN)
-- Đề tài PTTKHTTT - PTIT
-- Sinh viên: B23DCAT191 - Nhóm 11
-- ========================================================

CREATE DATABASE IF NOT EXISTS shopman CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shopman;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS tblImportDetail1;
DROP TABLE IF EXISTS tblImportInvoice1;
DROP TABLE IF EXISTS tblSupplier1;
DROP TABLE IF EXISTS tblProduct1;
DROP TABLE IF EXISTS tblCategory1;
DROP TABLE IF EXISTS tblManager1;
DROP TABLE IF EXISTS tblWarehouseStaff1;
DROP TABLE IF EXISTS tblEmployee1;
DROP TABLE IF EXISTS tblCustomer1;
DROP TABLE IF EXISTS tblMember1;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Bảng Thành viên (Member)
CREATE TABLE tblMember1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    email VARCHAR(100),
    tel VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Bảng Khách hàng (Customer) kế thừa Member
CREATE TABLE tblCustomer1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customerCode VARCHAR(20) NOT NULL UNIQUE,
    memberId INT NOT NULL,
    CONSTRAINT fk_cust_member FOREIGN KEY (memberId) REFERENCES tblMember1(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Bảng Nhân viên (Employee) kế thừa Member
CREATE TABLE tblEmployee1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeCode VARCHAR(20) NOT NULL UNIQUE,
    position VARCHAR(50),
    department VARCHAR(50),
    salary DOUBLE,
    memberId INT NOT NULL,
    CONSTRAINT fk_emp_member FOREIGN KEY (memberId) REFERENCES tblMember1(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Bảng Quản lý (Manager) kế thừa Employee
CREATE TABLE tblManager1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    managementLevel VARCHAR(50),
    employeeId INT NOT NULL,
    CONSTRAINT fk_mgr_emp FOREIGN KEY (employeeId) REFERENCES tblEmployee1(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Bảng Nhân viên kho (WarehouseStaff)
CREATE TABLE tblWarehouseStaff1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    warehouseDuty VARCHAR(100),
    employeeId INT NOT NULL,
    CONSTRAINT fk_wh_emp FOREIGN KEY (employeeId) REFERENCES tblEmployee1(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Bảng Danh mục mặt hàng (Category)
CREATE TABLE tblCategory1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoryCode VARCHAR(20) NOT NULL UNIQUE,
    categoryName VARCHAR(100) NOT NULL,
    description TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. Bảng Mặt hàng điện máy (Product)
CREATE TABLE tblProduct1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(20) NOT NULL UNIQUE,
    productName VARCHAR(200) NOT NULL,
    price DOUBLE NOT NULL,
    unit VARCHAR(20) NOT NULL,
    stockQuantity INT DEFAULT 0,
    brand VARCHAR(50),
    warrantyMonth INT DEFAULT 12,
    description TEXT,
    categoryId INT,
    CONSTRAINT fk_prod_cat FOREIGN KEY (categoryId) REFERENCES tblCategory1(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. Bảng Nhà cung cấp (Supplier)
CREATE TABLE tblSupplier1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    supplierCode VARCHAR(20) NOT NULL UNIQUE,
    supplierName VARCHAR(200) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9. Bảng Hóa đơn nhập (ImportInvoice)
CREATE TABLE tblImportInvoice1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    importCode VARCHAR(30) NOT NULL UNIQUE,
    importDate DATETIME NOT NULL,
    totalAmount DOUBLE DEFAULT 0,
    supplierId INT NOT NULL,
    warehouseStaffId INT,
    CONSTRAINT fk_inv_sup FOREIGN KEY (supplierId) REFERENCES tblSupplier1(id),
    CONSTRAINT fk_inv_staff FOREIGN KEY (warehouseStaffId) REFERENCES tblWarehouseStaff1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 10. Bảng Chi tiết hóa đơn nhập (ImportDetail)
CREATE TABLE tblImportDetail1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL,
    importPrice DOUBLE NOT NULL,
    importInvoiceId INT NOT NULL,
    productId INT NOT NULL,
    CONSTRAINT fk_dtl_inv FOREIGN KEY (importInvoiceId) REFERENCES tblImportInvoice1(id) ON DELETE CASCADE,
    CONSTRAINT fk_dtl_prod FOREIGN KEY (productId) REFERENCES tblProduct1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========================================================
-- NẠP DỮ LIỆU MẪU ĐỂ TEST 2 MODULE
-- ========================================================

-- Nạp Thành viên & Nhân viên quản lý
INSERT INTO tblMember1 (id, username, password, name, dob, email, tel) VALUES
(1, 'admin', '123456', 'Nguyễn Văn Quản Lý', '1985-05-15', 'admin@shopman.vn', '0912345678'),
(2, 'kho01', '123456', 'Trần Văn Kho', '1992-08-20', 'kho01@shopman.vn', '0987654321'),
(3, 'khach01', '123456', 'Lê Thị Thu', '2000-01-10', 'thule@gmail.com', '0901234567');

INSERT INTO tblEmployee1 (id, employeeCode, position, department, salary, memberId) VALUES
(1, 'NV01', 'Quản lý cửa hàng', 'Ban Quản trị', 25000000, 1),
(2, 'NV02', 'Thủ kho', 'Bộ phận Kho vận', 12000000, 2);

INSERT INTO tblManager1 (id, managementLevel, employeeId) VALUES
(1, 'Cấp cao', 1);

INSERT INTO tblWarehouseStaff1 (id, warehouseDuty, employeeId) VALUES
(1, 'Quản lý kho chính', 2);

INSERT INTO tblCustomer1 (id, customerCode, memberId) VALUES
(1, 'KH001', 3);

-- Nạp Danh mục
INSERT INTO tblCategory1 (id, categoryCode, categoryName, description) VALUES
(1, 'CAT_TV', 'Tivi & Âm thanh', 'Smart TV 4K, 8K, Loa thanh soundbar, Loa bluetooth'),
(2, 'CAT_TL', 'Tủ lạnh & Tủ đông', 'Tủ lạnh Inverter, Tủ lạnh Side by Side, Tủ đông mini'),
(3, 'CAT_MG', 'Máy giặt & Sấy', 'Máy giặt lồng ngang, máy giặt lồng đứng, máy sấy quần áo'),
(4, 'CAT_DH', 'Điều hòa & Làm mát', 'Điều hòa 1 chiều, 2 chiều Inverter tiết kiệm điện'),
(5, 'CAT_DT', 'Điện thoại & Tablet', 'Smartphone cao cấp, máy tính bảng');

-- Nạp Mặt hàng điện máy (cho Module 1: Tìm kiếm)
INSERT INTO tblProduct1 (id, productCode, productName, price, unit, stockQuantity, brand, warrantyMonth, description, categoryId) VALUES
(1, 'TV_SN_01', 'Smart Tivi Sony 4K 55 inch KD-55X75K', 13990000, 'Chiếc', 25, 'Sony', 24, 'Độ phân giải 4K sắc nét, bộ xử lý X1 4K HDR, Google TV thông minh, loa X-Balanced', 1),
(2, 'TV_SS_02', 'Smart Tivi Samsung Crystal UHD 4K 65 inch 65AU7002', 12490000, 'Chiếc', 18, 'Samsung', 24, 'Thiết kế 3 cạnh không viền, công nghệ PurColor hiển thị màu sắc chân thực, Q-Symphony', 1),
(3, 'TL_PN_01', 'Tủ lạnh Panasonic Inverter 322 lít NR-BV360QSVN', 14500000, 'Chiếc', 12, 'Panasonic', 24, 'Ngăn đông mềm diệt khuẩn Prime Fresh+, công nghệ Nanoe-X, Econavi tiết kiệm điện', 2),
(4, 'TL_LG_02', 'Tủ lạnh LG Inverter Side by Side 519 lít GR-B256BL', 16990000, 'Chiếc', 10, 'LG', 24, 'Hệ thống làm lạnh đa chiều, kháng khuẩn khử mùi, công nghệ Smart Inverter vận hành êm', 2),
(5, 'MG_LG_01', 'Máy giặt LG AI DD Inverter 10 kg FV1410S4P', 10290000, 'Chiếc', 30, 'LG', 24, 'Động cơ truyền động trực tiếp AI DD bảo vệ sợi vải, giặt hơi nước Steam diệt khuẩn 99.9%', 3),
(6, 'MG_EL_02', 'Máy giặt Electrolux UltimateCare 9 kg EWF9024D3WB', 9490000, 'Chiếc', 15, 'Electrolux', 24, 'Công nghệ UltraMix hòa tan nước giặt hoàn toàn, giặt hơi nước Hygienic Care', 3),
(7, 'DH_DK_01', 'Điều hòa Daikin Inverter 1 HP FTKB25WMVMV', 10990000, 'Bộ', 40, 'Daikin', 12, 'Mắt thần thông minh, luồng gió Coanda dễ chịu, phin lọc Enzyme Blue diệt khuẩn, chống ẩm mốc', 4),
(8, 'DH_PN_02', 'Điều hòa Panasonic Inverter 1.5 HP CU/CS-PU12XKH-8M', 13490000, 'Bộ', 22, 'Panasonic', 12, 'Công nghệ Nanoe-G lọc bụi mịn PM2.5, chế độ Eco tích hợp AI tiết kiệm điện năng', 4),
(9, 'DT_SS_01', 'Điện thoại Samsung Galaxy S24 Ultra 256GB', 28990000, 'Chiếc', 14, 'Samsung', 12, 'Khung viền Titanium đẳng cấp, bút S-Pen tích hợp, chip Snapdragon 8 Gen 3 for Galaxy, Galaxy AI', 5),
(10, 'DT_AP_02', 'Điện thoại iPhone 15 Pro Max 256GB', 29990000, 'Chiếc', 16, 'Apple', 12, 'Khung vỏ Titanium chuẩn hàng không vũ trụ, chip A17 Pro mạnh mẽ, camera tiềm vọng zoom quang 5x', 5);

-- Nạp Nhà cung cấp (cho Module 2: Thống kê)
INSERT INTO tblSupplier1 (id, supplierCode, supplierName, phone, email, address) VALUES
(1, 'NCC_SS', 'Công ty TNHH Điện tử Samsung Vina', '02839157310', 'contact@samsungvina.com', 'Tầng 25, Bitexco Financial Tower, Số 2 Hải Triều, Q.1, TP.HCM'),
(2, 'NCC_LG', 'Công ty TNHH LG Electronics Việt Nam', '02439345151', 'b2b@lge.com', 'Tầng 35, Keangnam Hanoi Landmark Tower, Phạm Hùng, Cầu Giấy, Hà Nội'),
(3, 'NCC_SONY', 'Công ty TNHH Sony Electronics Việt Nam', '02838456777', 'sales@sony.com.vn', 'Tầng 6, Tòa nhà President Place, 93 Nguyễn Du, Bến Nghé, Q.1, TP.HCM'),
(4, 'NCC_PANA', 'Công ty TNHH Panasonic Việt Nam', '02439550111', 'support@panasonic.com.vn', 'Lô J1-J2, KCN Thăng Long, Đông Anh, Hà Nội'),
(5, 'NCC_DAIKIN', 'Công ty Cổ phần Daikin Air Conditioning VN', '02862505555', 'info@daikin.com.vn', 'Tầng 12, Tòa nhà Viettel, 285 Cách Mạng Tháng 8, P.12, Q.10, TP.HCM');

-- Nạp Hóa đơn nhập hàng (tháng 9/2026 và 10/2026 để test thống kê theo khoảng thời gian)
-- 1. Các hóa đơn của Samsung (NCC 1)
INSERT INTO tblImportInvoice1 (id, importCode, importDate, totalAmount, supplierId, warehouseStaffId) VALUES
(1, 'HDN_SS_20260905', '2026-09-05 09:30:00', 350000000, 1, 1),
(2, 'HDN_SS_20260920', '2026-09-20 14:15:00', 480000000, 1, 1);

INSERT INTO tblImportDetail1 (id, quantity, importPrice, importInvoiceId, productId) VALUES
(1, 20, 10000000, 1, 2),  -- 20 Tivi Samsung x 10tr = 200tr
(2, 6, 25000000, 1, 9),   -- 6 ĐT Samsung S24 x 25tr = 150tr
(3, 15, 10000000, 2, 2),  -- 15 Tivi Samsung x 10tr = 150tr
(4, 13, 25000000, 2, 9);  -- 13 ĐT Samsung S24 x 25tr = 325tr -> tổng = 54 cái

-- 2. Các hóa đơn của LG (NCC 2)
INSERT INTO tblImportInvoice1 (id, importCode, importDate, totalAmount, supplierId, warehouseStaffId) VALUES
(3, 'HDN_LG_20260910', '2026-09-10 10:00:00', 360000000, 2, 1),
(4, 'HDN_LG_20260925', '2026-09-25 15:45:00', 280000000, 2, 1);

INSERT INTO tblImportDetail1 (id, quantity, importPrice, importInvoiceId, productId) VALUES
(5, 15, 14000000, 3, 4),  -- 15 Tủ lạnh LG x 14tr = 210tr
(6, 18, 8000000, 3, 5),   -- 18 Máy giặt LG x 8tr = 144tr
(7, 20, 8000000, 4, 5),   -- 20 Máy giặt LG x 8tr = 160tr
(8, 8, 14000000, 4, 4);   -- 8 Tủ lạnh LG x 14tr = 112tr -> tổng = 61 cái

-- 3. Hóa đơn của Panasonic (NCC 4)
INSERT INTO tblImportInvoice1 (id, importCode, importDate, totalAmount, supplierId, warehouseStaffId) VALUES
(5, 'HDN_PN_20260912', '2026-09-12 11:20:00', 320000000, 4, 1);

INSERT INTO tblImportDetail1 (id, quantity, importPrice, importInvoiceId, productId) VALUES
(9, 12, 12000000, 5, 3),  -- 12 Tủ lạnh Panasonic x 12tr = 144tr
(10, 16, 11000000, 5, 8); -- 16 Điều hòa Panasonic x 11tr = 176tr -> tổng = 28 cái

-- 4. Hóa đơn của Sony (NCC 3)
INSERT INTO tblImportInvoice1 (id, importCode, importDate, totalAmount, supplierId, warehouseStaffId) VALUES
(6, 'HDN_SN_20260918', '2026-09-18 16:00:00', 275000000, 3, 1);

INSERT INTO tblImportDetail1 (id, quantity, importPrice, importInvoiceId, productId) VALUES
(11, 25, 11000000, 6, 1); -- 25 Tivi Sony x 11tr = 275tr -> tổng = 25 cái

-- 5. Hóa đơn của Daikin (NCC 5)
INSERT INTO tblImportInvoice1 (id, importCode, importDate, totalAmount, supplierId, warehouseStaffId) VALUES
(7, 'HDN_DK_20260922', '2026-09-22 08:30:00', 180000000, 5, 1);

INSERT INTO tblImportDetail1 (id, quantity, importPrice, importInvoiceId, productId) VALUES
(12, 20, 9000000, 7, 7);  -- 20 Điều hòa Daikin x 9tr = 180tr -> tổng = 20 cái
