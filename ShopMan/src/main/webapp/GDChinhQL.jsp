<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ Quản Lý - ShopMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>HỆ THỐNG QUẢN LÝ SIÊU THỊ ĐIỆN MÁY</h1>
            <div class="user-info">Quản lý: Nguyễn Văn Quản Lý (Admin)</div>
        </div>

        <h2 class="sub-header">Màn Hình Chính Quản Lý (GDChinhQL)</h2>
        <p style="margin-bottom: 25px; color: #555;">
            Chào mừng bạn đến với bảng điều khiển quản trị cửa hàng. Vui lòng chọn chức năng nghiệp vụ cần thực hiện:
        </p>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; margin-bottom: 30px;">
            <div style="background: #fdfdfd; border: 1px solid #cfd8dc; padding: 25px; border-radius: 8px; text-align: center;">
                <div style="font-size: 40px; margin-bottom: 10px;">📈</div>
                <h3 style="color: #0288d1; margin-bottom: 10px;">Báo Cáo & Thống Kê</h3>
                <p style="font-size: 13px; color: #607d8b; margin-bottom: 20px;">Xem thống kê nhà cung cấp theo lượng hàng nhập, doanh thu...</p>
                <a href="GDChonLoaiTK.jsp" class="btn btn-primary" style="width: 100%;">📊 Xem Báo Cáo / Thống Kê</a>
            </div>

            <div style="background: #fdfdfd; border: 1px solid #cfd8dc; padding: 25px; border-radius: 8px; text-align: center; opacity: 0.7;">
                <div style="font-size: 40px; margin-bottom: 10px;">📦</div>
                <h3 style="color: #546e7a; margin-bottom: 10px;">Quản Lý Kho Hàng</h3>
                <p style="font-size: 13px; color: #607d8b; margin-bottom: 20px;">Quản lý nhập kho, xuất kho, kiểm kê mặt hàng điện máy.</p>
                <button class="btn btn-secondary" style="width: 100%;" disabled>Chức năng khác</button>
            </div>
        </div>

        <div class="footer-nav">
            <a href="index.jsp" class="btn btn-secondary">⬅ Về Trang Lựa Chọn Phân Hệ</a>
        </div>
    </div>
</body>
</html>
