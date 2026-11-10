<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chọn Loại Báo Cáo - ShopMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>HỆ THỐNG QUẢN LÝ SIÊU THỊ ĐIỆN MÁY</h1>
            <div class="user-info">Quản lý: Nguyễn Văn Quản Lý</div>
        </div>

        <h2 class="sub-header">Màn Hình Chọn Loại Báo Cáo Thống Kê (GDChonLoaiTK)</h2>
        <p style="margin-bottom: 20px; color: #555;">
            Vui lòng chọn loại báo cáo thống kê bạn muốn trích xuất dữ liệu:
        </p>

        <table class="data-table">
            <thead>
                <tr>
                    <th style="width: 60px;" class="text-center">STT</th>
                    <th>Tên Loại Báo Cáo / Thống Kê</th>
                    <th style="width: 320px;">Mô Tả Nghiệp Vụ</th>
                    <th style="width: 140px;" class="text-center">Lựa Chọn</th>
                </tr>
            </thead>
            <tbody>
                <tr style="background-color: #e8f5e9;">
                    <td class="text-center"><strong>1</strong></td>
                    <td>
                        <strong style="color: #2e7d32; font-size: 15px;">
                            Thống kê nhà cung cấp theo lượng hàng nhập
                        </strong>
                        <span style="display: block; font-size: 12px; color: #d32f2f; font-weight: 600;">(Chức năng đề tài số 35)</span>
                    </td>
                    <td>Thống kê tổng số lượng hàng hóa và tổng tiền nhập từ các đối tác cung cấp theo thời gian.</td>
                    <td class="text-center">
                        <a href="GDChonKhoangThoiGian.jsp" class="btn btn-success" style="padding: 7px 16px;">
                            Chọn Xem 👉
                        </a>
                    </td>
                </tr>
                <tr style="opacity: 0.7;">
                    <td class="text-center">2</td>
                    <td>Thống kê mặt hàng bán chạy theo doanh thu</td>
                    <td>Báo cáo doanh số bán các dòng tivi, máy giặt, điều hòa...</td>
                    <td class="text-center"><span class="btn btn-secondary" style="padding: 5px 12px; font-size: 12px;">Chưa kích hoạt</span></td>
                </tr>
                <tr style="opacity: 0.7;">
                    <td class="text-center">3</td>
                    <td>Thống kê khách hàng theo doanh số mua hàng</td>
                    <td>Xếp hạng khách hàng tiềm năng, khách hàng thân thiết.</td>
                    <td class="text-center"><span class="btn btn-secondary" style="padding: 5px 12px; font-size: 12px;">Chưa kích hoạt</span></td>
                </tr>
            </tbody>
        </table>

        <div class="footer-nav">
            <a href="GDChinhQL.jsp" class="btn btn-secondary">⬅ Quay lại Màn Hình Chính QL</a>
        </div>
    </div>
</body>
</html>
