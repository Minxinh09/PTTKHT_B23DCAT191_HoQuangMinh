<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO1" %>
<%@ page import="model.Product1" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    request.setCharacterEncoding("UTF-8");
    String idStr = request.getParameter("id");
    Product1 product = null;
    DecimalFormat df = new DecimalFormat("#,###");

    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            int id = Integer.parseInt(idStr);
            ProductDAO1 dao = new ProductDAO1();
            product = dao.getProductById(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Mặt Hàng - ShopMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>SIÊU THỊ ĐIỆN MÁY SHOPMAN</h1>
            <div class="user-info">Thông tin chi tiết mặt hàng</div>
        </div>

        <h2 class="sub-header">Màn Hình Chi Tiết Mặt Hàng (GDChiTietMatHang)</h2>

        <% if (product == null) { %>
            <div class="alert alert-danger">
                Không tìm thấy thông tin mặt hàng với mã ID đã chọn! Vui lòng quay lại danh sách tìm kiếm.
            </div>
        <% } else { %>
            <div class="info-card">
                <div class="info-row">
                    <div class="info-label">Mã Mặt Hàng:</div>
                    <div class="info-value"><strong><%= product.getProductCode() %></strong></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Tên Mặt Hàng:</div>
                    <div class="info-value" style="font-size: 17px; font-weight: bold; color: #0277bd;">
                        <%= product.getProductName() %>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-label">Danh Mục:</div>
                    <div class="info-value">
                        <%= (product.getCategory() != null) ? product.getCategory().getCategoryName() : "Không xác định" %>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-label">Hãng Sản Xuất (Thương hiệu):</div>
                    <div class="info-value"><strong><%= product.getBrand() %></strong></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Đơn Giá Niêm Yết:</div>
                    <div class="info-value" style="font-size: 18px; color: #d32f2f; font-weight: bold;">
                        <%= df.format(product.getPrice()) %> VNĐ / <%= product.getUnit() %>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-label">Thời Hạn Bảo Hành:</div>
                    <div class="info-value"><%= product.getWarrantyMonth() %> tháng chính hãng</div>
                </div>
                <div class="info-row">
                    <div class="info-label">Số Lượng Còn Trong Kho:</div>
                    <div class="info-value" style="color: #2e7d32; font-weight: 600;">
                        <%= product.getStockQuantity() %> <%= product.getUnit() %>
                    </div>
                </div>
                <div class="info-row" style="margin-top: 15px; border-top: 1px dashed #cfd8dc; padding-top: 15px;">
                    <div class="info-label">Mô Tả Kỹ Thuật & Tính Năng:</div>
                    <div class="info-value" style="white-space: pre-line; line-height: 1.7;">
                        <%= product.getDescription() %>
                    </div>
                </div>
            </div>
        <% } %>

        <!-- Footer chỉ có duy nhất nút Quay lại màn hình trước đúng theo Sơ đồ tuần tự và Sơ đồ trạng thái -->
        <div class="footer-nav">
            <a href="GDTimKiem.jsp" class="btn btn-secondary">⬅ Quay lại</a>
        </div>
    </div>
</body>
</html>
