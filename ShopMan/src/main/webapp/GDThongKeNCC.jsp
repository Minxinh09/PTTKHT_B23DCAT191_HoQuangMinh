<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.SupplierStatDAO1" %>
<%@ page import="model.SupplierStat1" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    request.setCharacterEncoding("UTF-8");
    String startStr = request.getParameter("startDate");
    String endStr = request.getParameter("endDate");

    // Nếu quay lại từ trang chi tiết (lấy từ session)
    if (startStr == null || endStr == null) {
        startStr = (String) session.getAttribute("statStartDate");
        endStr = (String) session.getAttribute("statEndDate");
    }

    if (startStr == null || endStr == null) {
        response.sendRedirect("GDChonKhoangThoiGian.jsp");
        return;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");
    DecimalFormat df = new DecimalFormat("#,###");

    Date startDate = null;
    Date endDate = null;
    try {
        startDate = sdf.parse(startStr);
        endDate = sdf.parse(endStr);
        if (startDate.after(endDate)) {
            response.sendRedirect("GDChonKhoangThoiGian.jsp?error=invalid_date");
            return;
        }
    } catch (Exception e) {
        response.sendRedirect("GDChonKhoangThoiGian.jsp?error=invalid_date");
        return;
    }

    // Lưu vào session để khi quay lại không cần truy vấn lại CSDL
    session.setAttribute("statStartDate", startStr);
    session.setAttribute("statEndDate", endStr);

    SupplierStatDAO1 dao = new SupplierStatDAO1();
    ArrayList<SupplierStat1> listStat = dao.getSupplierStat(startDate, endDate);

    // Tính tổng cộng
    int sumQuantity = 0;
    double sumAmount = 0;
    for (SupplierStat1 s : listStat) {
        sumQuantity += s.getTotalImportQuantity();
        sumAmount += s.getTotalImportAmount();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thống Kê Nhà Cung Cấp Theo Lượng Hàng Nhập - ShopMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container" style="max-width: 1200px;">
        <div class="header">
            <h1>HỆ THỐNG QUẢN LÝ SIÊU THỊ ĐIỆN MÁY</h1>
            <div class="user-info">Quản lý: Nguyễn Văn Quản Lý</div>
        </div>

        <h2 class="sub-header">Màn Hình Thống Kê Nhà Cung Cấp Theo Lượng Hàng Nhập (GDThongKeNCC)</h2>

        <!-- Khung tóm tắt khoảng thời gian (chỉ hiển thị thông tin, không có nút đổi) -->
        <div style="background: #e8f5e9; border: 1px solid #c8e6c9; padding: 14px 20px; border-radius: 8px; margin-bottom: 20px; font-size: 14px;">
            Khoảng thời gian thống kê: Từ ngày <strong><%= sdfDisplay.format(startDate) %></strong> đến ngày <strong><%= sdfDisplay.format(endDate) %></strong>
        </div>

        <% if (listStat.isEmpty()) { %>
            <div class="alert alert-info">
                Không có dữ liệu nhập hàng nào trong khoảng thời gian từ <%= sdfDisplay.format(startDate) %> đến <%= sdfDisplay.format(endDate) %>.
            </div>
        <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 50px;" class="text-center">Hạng</th>
                        <th style="width: 100px;">Mã NCC</th>
                        <th>Tên Nhà Cung Cấp</th>
                        <th style="width: 110px;">Điện Thoại</th>
                        <th style="width: 100px;" class="text-center">Số Lần Nhập</th>
                        <th style="width: 150px;" class="text-right">Tổng Lượng Nhập (Cái/Bộ)</th>
                        <th style="width: 160px;" class="text-right">Tổng Tiền Nhập (VNĐ)</th>
                        <th style="width: 110px;" class="text-center">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (SupplierStat1 s : listStat) { %>
                    <tr>
                        <td class="text-center">
                            <% if (s.getRank() == 1) { %>
                                <span style="background: #ffd700; color: #333; font-weight: bold; padding: 3px 8px; border-radius: 50%;">🥇 1</span>
                            <% } else if (s.getRank() == 2) { %>
                                <span style="background: #c0c0c0; color: #333; font-weight: bold; padding: 3px 8px; border-radius: 50%;">🥈 2</span>
                            <% } else if (s.getRank() == 3) { %>
                                <span style="background: #cd7f32; color: #fff; font-weight: bold; padding: 3px 8px; border-radius: 50%;">🥉 3</span>
                            <% } else { %>
                                <%= s.getRank() %>
                            <% } %>
                        </td>
                        <td><strong><%= s.getSupplierCode() %></strong></td>
                        <td>
                            <a href="GDChiTietNCC.jsp?supplierId=<%= s.getId() %>" style="color: #0277bd; font-weight: 600; text-decoration: none;">
                                <%= s.getSupplierName() %>
                            </a>
                        </td>
                        <td><%= s.getPhone() %></td>
                        <td class="text-center"><%= s.getImportCount() %> đợt</td>
                        <td class="text-right" style="font-size: 15px; font-weight: bold; color: #2e7d32;">
                            <%= df.format(s.getTotalImportQuantity()) %>
                        </td>
                        <td class="text-right" style="font-weight: 600;">
                            <%= df.format(s.getTotalImportAmount()) %> đ
                        </td>
                        <td class="text-center">
                            <a href="GDChiTietNCC.jsp?supplierId=<%= s.getId() %>" class="btn btn-primary" style="padding: 5px 12px; font-size: 13px;">
                                Xem Chi Tiết
                            </a>
                        </td>
                    </tr>
                    <% } %>

                    <!-- Dòng Tổng Cộng -->
                    <tr class="total-row">
                        <td colspan="4" class="text-center" style="text-transform: uppercase;">TỔNG CỘNG HỆ THỐNG</td>
                        <td class="text-center"><%= listStat.size() %> NCC</td>
                        <td class="text-right" style="font-size: 16px;"><%= df.format(sumQuantity) %></td>
                        <td class="text-right" style="font-size: 16px;"><%= df.format(sumAmount) %> đ</td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        <% } %>

        <!-- Footer chỉ có duy nhất nút Quay lại màn hình trước đúng theo Sơ đồ tuần tự và Sơ đồ trạng thái -->
        <div class="footer-nav">
            <a href="GDChonKhoangThoiGian.jsp" class="btn btn-secondary">⬅ Quay lại</a>
        </div>
    </div>
</body>
</html>
