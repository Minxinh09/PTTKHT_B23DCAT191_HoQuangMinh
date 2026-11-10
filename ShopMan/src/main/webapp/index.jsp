<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hệ Thống Quản Lý Siêu Thị Điện Máy (ShopMan)</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .portal-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-top: 30px;
        }
        .portal-card {
            border: 1px solid #b3e5fc;
            background: #fdfdfd;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .portal-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(2, 136, 209, 0.15);
        }
        .portal-icon {
            font-size: 50px;
            margin-bottom: 15px;
        }
        .portal-card h2 {
            color: #0277bd;
            margin-bottom: 10px;
        }
        .portal-card p {
            color: #546e7a;
            margin-bottom: 25px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>HỆ THỐNG QUẢN LÝ SIÊU THỊ ĐIỆN MÁY (SHOPMAN)</h1>
            <div class="user-info">PTTKHTTT - PTIT (Đề số 35)</div>
        </div>

        <p style="text-align: center; color: #555; font-size: 15px; margin-top: 10px;">
            Chào mừng bạn đến với hệ thống mẫu chạy thực tế cho 2 module trọng tâm của bài tập lớn. Vui lòng chọn phân hệ:
        </p>

        <div class="portal-grid">
            <!-- Module 1 Portal -->
            <div class="portal-card">
                <div class="portal-icon">🛒</div>
                <h2>Phân Hệ Khách Hàng</h2>
                <p>Module 1: Khách hàng tìm kiếm & xem chi tiết mặt hàng điện máy.</p>
                <a href="GDChinhKH.jsp" class="btn btn-primary" style="padding: 12px 30px; font-size: 15px;">Truy cập GD Khách Hàng</a>
            </div>

            <!-- Module 2 Portal -->
            <div class="portal-card">
                <div class="portal-icon">📊</div>
                <h2>Phân Hệ Quản Lý</h2>
                <p>Module 2: Quản lý xem thống kê nhà cung cấp theo lượng hàng nhập.</p>
                <a href="GDChinhQL.jsp" class="btn btn-success" style="padding: 12px 30px; font-size: 15px;">Truy cập GD Quản Lý</a>
            </div>
        </div>

        <div style="margin-top: 40px; text-align: center; font-size: 13px; color: #90a4ae; border-top: 1px solid #eee; padding-top: 20px;">
            Sinh viên thực hiện: B23DCAT191 - Nhóm 11
        </div>
    </div>
</body>
</html>
