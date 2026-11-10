<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ImportInvoiceDAO1" %>
<%@ page import="model.ImportInvoice1" %>
<%@ page import="model.Supplier1" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    request.setCharacterEncoding("UTF-8");
    String supIdStr = request.getParameter("supplierId");
    String startStr = (String) session.getAttribute("statStartDate");
    String endStr = (String) session.getAttribute("statEndDate");

    if (supIdStr == null || startStr == null || endStr == null) {
        response.sendRedirect("GDThongKeNCC.jsp");
        return;
    }

    int supplierId = Integer.parseInt(supIdStr);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfDateTime = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");
    DecimalFormat df = new DecimalFormat("#,###");

    Date startDate = sdf.parse(startStr);
    Date endDate = sdf.parse(endStr);

    ImportInvoiceDAO1 dao = new ImportInvoiceDAO1();
    ArrayList<ImportInvoice1> listInvoice = dao.getImportInvoiceBySupplier(supplierId, startDate, endDate);

    Supplier1 supplier = null;
    double totalAllInvoices = 0;
    if (!listInvoice.isEmpty()) {
        supplier = listInvoice.get(0).getSupplier();
        for (ImportInvoice1 inv : listInvoice) {
            totalAllInvoices += inv.getTotalAmount();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Các Lần Nhập Hàng - ShopMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container" style="max-width: 1100px;">
        <div class="header">
            <h1>HỆ THỐNG QUẢN LÝ SIÊU THỊ ĐIỆN MÁY</h1>
            <div class="user-info">Quản lý: Nguyễn Văn Quản Lý</div>
        </div>

        <h2 class="sub-header">Màn Hình Chi Tiết Các Lần Nhập Hàng Của Nhà Cung Cấp (GDChiTietNCC)</h2>

        <!-- Thẻ thông tin Nhà Cung Cấp -->
        <% if (supplier != null) { %>
            <div class="info-card">
                <div class="info-row">
                    <div class="info-label">Nhà Cung Cấp:</div>
                    <div class="info-value" style="font-size: 17px; font-weight: bold; color: #0277bd;">
                        <%= supplier.getSupplierName() %> (<%= supplier.getSupplierCode() %>)
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-label">Số Điện Thoại / Email:</div>
                    <div class="info-value"><%= supplier.getPhone() %> | <%= supplier.getEmail() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Địa Chỉ Trụ Sở:</div>
                    <div class="info-value"><%= supplier.getAddress() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Khoảng Thời Gian Thống Kê:</div>
                    <div class="info-value">Từ ngày <strong><%= sdfDisplay.format(startDate) %></strong> đến ngày <strong><%= sdfDisplay.format(endDate) %></strong></div>
                </div>
            </div>
        <% } %>

        <h3 style="color: #455a64; margin-bottom: 12px; font-size: 16px;">
            Danh sách các hóa đơn / đợt nhập hàng (<%= listInvoice.size() %> lần nhập):
        </h3>

        <% if (listInvoice.isEmpty()) { %>
            <div class="alert alert-info">
                Không có hóa đơn nhập nào của nhà cung cấp này trong khoảng thời gian đã chọn.
            </div>
        <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 50px;" class="text-center">STT</th>
                        <th style="width: 180px;">Mã Hóa Đơn Nhập</th>
                        <th style="width: 200px;">Thời Gian Nhập Hàng</th>
                        <th class="text-right">Tổng Tiền Hóa Đơn (VNĐ)</th>
                        <th style="width: 140px;" class="text-center">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int stt = 1;
                        for (ImportInvoice1 inv : listInvoice) {
                    %>
                    <tr>
                        <td class="text-center"><%= stt++ %></td>
                        <td><strong><%= inv.getImportCode() %></strong></td>
                        <td><%= sdfDateTime.format(inv.getImportDate()) %></td>
                        <td class="text-right" style="font-weight: 600; color: #2e7d32;">
                            <%= df.format(inv.getTotalAmount()) %> đ
                        </td>
                        <td class="text-center">
                            <a href="GDChiTietHoaDonNhap.jsp?invoiceId=<%= inv.getId() %>" class="btn btn-primary" style="padding: 5px 12px; font-size: 13px;">
                                Xem Chi Tiết
                            </a>
                        </td>
                    </tr>
                    <% } %>

                    <!-- Dòng Tổng Cộng -->
                    <tr class="total-row">
                        <td colspan="3" class="text-center" style="text-transform: uppercase;">TỔNG TIỀN TẤT CẢ CÁC ĐỢT NHẬP CỦA NCC</td>
                        <td class="text-right" style="font-size: 16px;"><%= df.format(totalAllInvoices) %> đ</td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        <% } %>

        <!-- Footer chỉ có duy nhất nút Quay lại màn hình trước đúng theo Sơ đồ tuần tự và Sơ đồ trạng thái -->
        <div class="footer-nav">
            <a href="GDThongKeNCC.jsp" class="btn btn-secondary">⬅ Quay lại</a>
        </div>
    </div>
</body>
</html>
