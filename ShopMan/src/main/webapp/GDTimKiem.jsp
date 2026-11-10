<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO1" %>
<%@ page import="model.Product1" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    request.setCharacterEncoding("UTF-8");
    String keyword = request.getParameter("tuKhoa");
    if (keyword == null) {
        keyword = "";
    }
    
    ProductDAO1 productDAO = new ProductDAO1();
    ArrayList<Product1> listProduct = productDAO.searchProduct(keyword);
    DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm Kiếm Mặt Hàng - ShopMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>SIÊU THỊ ĐIỆN MÁY SHOPMAN</h1>
            <div class="user-info">Phân hệ Khách hàng</div>
        </div>

        <h2 class="sub-header">Màn Hình Tìm Kiếm Mặt Hàng (GDTimKiem)</h2>

        <!-- Form nhập từ khóa tìm kiếm -->
        <div class="search-box">
            <form action="GDTimKiem.jsp" method="GET">
                <div class="form-group">
                    <label for="tuKhoa">Nhập từ khóa tìm kiếm:</label>
                    <input type="text" id="tuKhoa" name="tuKhoa" value="<%= keyword %>" placeholder="Ví dụ: Tivi, Samsung, LG, Inverter..." style="flex: 1; min-width: 280px;">
                    <button type="submit" class="btn btn-primary">🔍 Tìm Kiếm</button>
                    <a href="GDTimKiem.jsp" class="btn btn-secondary">Làm mới</a>
                </div>
            </form>
        </div>

        <!-- Bảng danh sách kết quả -->
        <h3 style="color: #455a64; margin-bottom: 10px; font-size: 16px;">
            Kết quả tìm kiếm: <strong><%= listProduct.size() %></strong> mặt hàng
        </h3>

        <% if (listProduct.isEmpty()) { %>
            <div class="alert alert-info">
                Không tìm thấy mặt hàng nào phù hợp với từ khóa "<strong><%= keyword %></strong>". Vui lòng thử lại với từ khóa khác!
            </div>
        <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 50px;" class="text-center">STT</th>
                        <th style="width: 120px;">Mã Hàng</th>
                        <th>Tên Mặt Hàng Điện Máy</th>
                        <th style="width: 150px;">Danh Mục</th>
                        <th style="width: 110px;">Hãng SX</th>
                        <th style="width: 130px;" class="text-right">Đơn Giá (VNĐ)</th>
                        <th style="width: 90px;" class="text-center">Tồn Kho</th>
                        <th style="width: 120px;" class="text-center">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int stt = 1;
                        for (Product1 p : listProduct) {
                    %>
                    <tr>
                        <td class="text-center"><%= stt++ %></td>
                        <td><strong><%= p.getProductCode() %></strong></td>
                        <td><%= p.getProductName() %></td>
                        <td><%= (p.getCategory() != null) ? p.getCategory().getCategoryName() : "Khác" %></td>
                        <td><%= p.getBrand() %></td>
                        <td class="text-right" style="color: #b71c1c; font-weight: 600;"><%= df.format(p.getPrice()) %> đ</td>
                        <td class="text-center"><%= p.getStockQuantity() %> <%= p.getUnit() %></td>
                        <td class="text-center">
                            <a href="GDChiTietMatHang.jsp?id=<%= p.getId() %>" class="btn btn-primary" style="padding: 5px 12px; font-size: 13px;">
                                Chi Tiết
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>

        <div class="footer-nav">
            <a href="GDChinhKH.jsp" class="btn btn-secondary">⬅ Quay lại Trang Chủ KH</a>
        </div>
    </div>
</body>
</html>
