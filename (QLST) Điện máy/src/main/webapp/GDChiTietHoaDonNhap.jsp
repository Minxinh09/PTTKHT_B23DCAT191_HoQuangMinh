<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ImportInvoiceDAO1" %>
<%@ page import="model.ImportInvoice1" %>
<%@ page import="model.ImportDetail1" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    request.setCharacterEncoding("UTF-8");
    String invIdStr = request.getParameter("invoiceId");
    ImportInvoice1 invoice = null;
    DecimalFormat df = new DecimalFormat("#,###");
    SimpleDateFormat sdfDateTime = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    if (invIdStr != null && !invIdStr.trim().isEmpty()) {
        try {
            int invoiceId = Integer.parseInt(invIdStr);
            ImportInvoiceDAO1 dao = new ImportInvoiceDAO1();
            invoice = dao.getInvoiceDetail(invoiceId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Hóa Đơn Nhập Hàng - ShopMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container" style="max-width: 1100px;">
        <div class="header">
            <h1>HỆ THỐNG QUẢN LÝ SIÊU THỊ ĐIỆN MÁY</h1>
            <div class="user-info">Quản lý: Nguyễn Văn Quản Lý</div>
        </div>

        <h2 class="sub-header">Màn Hình Chi Tiết Hóa Đơn Nhập Hàng (GDChiTietHoaDonNhap)</h2>

        <% if (invoice == null) { %>
            <div class="alert alert-danger">
                Không tìm thấy thông tin hóa đơn nhập hàng với mã ID đã chọn!
            </div>
        <% } else { %>
            <!-- Khung thông tin chung của Hóa đơn -->
            <div class="info-card">
                <div class="info-row">
                    <div class="info-label">Mã Hóa Đơn Nhập:</div>
                    <div class="info-value"><strong style="color: #0277bd; font-size: 16px;"><%= invoice.getImportCode() %></strong></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Thời Gian Nhập Kho:</div>
                    <div class="info-value"><%= sdfDateTime.format(invoice.getImportDate()) %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Người Lập Hóa Đơn:</div>
                    <div class="info-value">
                        <% if (invoice.getWarehouseStaff() != null) { %>
                            <strong style="color: #37474f;"><%= invoice.getWarehouseStaff().getName() %></strong>
                            <span style="color: #607d8b;">(Mã NV: <%= invoice.getWarehouseStaff().getEmployeeCode() %> - Vị trí: <%= invoice.getWarehouseStaff().getPosition() %>)</span>
                        <% } else { %>
                            <span style="color: #78909c;">Thủ kho chính</span>
                        <% } %>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-label">Nhà Cung Cấp:</div>
                    <div class="info-value">
                        <strong><%= (invoice.getSupplier() != null) ? invoice.getSupplier().getSupplierName() : "" %></strong>
                        (<%= (invoice.getSupplier() != null) ? invoice.getSupplier().getSupplierCode() : "" %>)
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-label">Địa Chỉ Nhà Cung Cấp:</div>
                    <div class="info-value"><%= (invoice.getSupplier() != null) ? invoice.getSupplier().getAddress() : "" %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Tổng Giá Trị Hóa Đơn:</div>
                    <div class="info-value" style="font-size: 18px; color: #d32f2f; font-weight: bold;">
                        <%= df.format(invoice.getTotalAmount()) %> VNĐ
                    </div>
                </div>
            </div>

            <h3 style="color: #455a64; margin-bottom: 12px; font-size: 16px;">
                Danh sách các mặt hàng trong hóa đơn nhập (<%= invoice.getImportDetail().size() %> mặt hàng):
            </h3>

            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 50px;" class="text-center">STT</th>
                        <th style="width: 120px;">Mã Hàng</th>
                        <th>Tên Mặt Hàng Điện Máy</th>
                        <th style="width: 100px;">Hãng SX</th>
                        <th style="width: 100px;" class="text-center">Đơn Vị</th>
                        <th style="width: 110px;" class="text-center">Số Lượng</th>
                        <th style="width: 150px;" class="text-right">Đơn Giá Nhập (VNĐ)</th>
                        <th style="width: 170px;" class="text-right">Thành Tiền (VNĐ)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int stt = 1;
                        int totalQty = 0;
                        for (ImportDetail1 d : invoice.getImportDetail()) {
                            totalQty += d.getQuantity();
                    %>
                    <tr>
                        <td class="text-center"><%= stt++ %></td>
                        <td><strong><%= (d.getProduct() != null) ? d.getProduct().getProductCode() : "" %></strong></td>
                        <td><%= (d.getProduct() != null) ? d.getProduct().getProductName() : "" %></td>
                        <td><%= (d.getProduct() != null) ? d.getProduct().getBrand() : "" %></td>
                        <td class="text-center"><%= (d.getProduct() != null) ? d.getProduct().getUnit() : "Cái" %></td>
                        <td class="text-center" style="font-weight: bold; color: #0277bd;"><%= d.getQuantity() %></td>
                        <td class="text-right"><%= df.format(d.getImportPrice()) %> đ</td>
                        <td class="text-right" style="font-weight: 600; color: #2e7d32;"><%= df.format(d.getAmount()) %> đ</td>
                    </tr>
                    <% } %>

                    <!-- Dòng Tổng Cộng -->
                    <tr class="total-row">
                        <td colspan="5" class="text-center" style="text-transform: uppercase;">TỔNG CỘNG HÓA ĐƠN</td>
                        <td class="text-center" style="font-size: 15px;"><%= totalQty %></td>
                        <td></td>
                        <td class="text-right" style="font-size: 16px;"><%= df.format(invoice.getTotalAmount()) %> đ</td>
                    </tr>
                </tbody>
            </table>
        <% } %>

        <!-- Footer chỉ có duy nhất nút Quay lại màn hình trước đúng theo Sơ đồ tuần tự và Sơ đồ trạng thái -->
        <div class="footer-nav">
            <% if (invoice != null && invoice.getSupplier() != null) { %>
                <a href="GDChiTietNCC.jsp?supplierId=<%= invoice.getSupplier().getId() %>" class="btn btn-secondary">
                    ⬅ Quay lại
                </a>
            <% } else { %>
                <a href="GDThongKeNCC.jsp" class="btn btn-secondary">⬅ Quay lại</a>
            <% } %>
        </div>
    </div>
</body>
</html>
