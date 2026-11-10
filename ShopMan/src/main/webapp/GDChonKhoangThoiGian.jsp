<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chọn Khoảng Thời Gian Thống Kê - ShopMan</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        function validateForm() {
            var startDate = document.getElementById("startDate").value;
            var endDate = document.getElementById("endDate").value;
            var errorDiv = document.getElementById("clientError");

            if (!startDate || !endDate) {
                errorDiv.innerText = "Vui lòng chọn đầy đủ cả Ngày bắt đầu và Ngày kết thúc!";
                errorDiv.style.display = "block";
                return false;
            }

            if (startDate > endDate) {
                errorDiv.innerText = "Ngày bắt đầu không được lớn hơn Ngày kết thúc!";
                errorDiv.style.display = "block";
                return false;
            }

            errorDiv.style.display = "none";
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>HỆ THỐNG QUẢN LÝ SIÊU THỊ ĐIỆN MÁY</h1>
            <div class="user-info">Quản lý: Nguyễn Văn Quản Lý</div>
        </div>

        <h2 class="sub-header">Màn Hình Chọn Khoảng Thời Gian (GDChonKhoangThoiGian)</h2>
        <p style="margin-bottom: 25px; color: #555;">
            Chọn khoảng thời gian nhập hàng để tính toán lượng hàng và chi phí nhập từ các nhà cung cấp:
        </p>

        <!-- Thông báo lỗi (nếu có từ server hoặc client) -->
        <div id="clientError" class="alert alert-danger" style="display: none;"></div>
        <% if ("invalid_date".equals(error)) { %>
            <div class="alert alert-danger">
                Khoảng thời gian không hợp lệ! Ngày bắt đầu không thể sau ngày kết thúc. Vui lòng chọn lại.
            </div>
        <% } %>

        <div class="filter-box">
            <form action="GDThongKeNCC.jsp" method="GET" onsubmit="return validateForm();">
                <div class="form-group" style="justify-content: flex-start; gap: 25px;">
                    <div>
                        <label for="startDate" style="display: block; margin-bottom: 6px;">Từ Ngày (Ngày Bắt Đầu):</label>
                        <input type="date" id="startDate" name="startDate" value="2026-09-01" required>
                    </div>

                    <div>
                        <label for="endDate" style="display: block; margin-bottom: 6px;">Đến Ngày (Ngày Kết Thúc):</label>
                        <input type="date" id="endDate" name="endDate" value="2026-09-30" required>
                    </div>

                    <div style="align-self: flex-end;">
                        <button type="submit" class="btn btn-primary" style="padding: 10px 24px;">
                            📊 Xem Thống Kê
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <div style="background: #fffde7; border-left: 4px solid #fbc02d; padding: 15px; border-radius: 4px; font-size: 13px; color: #5d4037;">
            💡 <em>Gợi ý test dữ liệu:</em> Cơ sở dữ liệu mẫu đã có sẵn các đợt nhập hàng trong tháng <strong>09/2026</strong> (từ 01/09/2026 đến 30/09/2026).
        </div>

        <div class="footer-nav">
            <a href="GDChonLoaiTK.jsp" class="btn btn-secondary">⬅ Quay lại Chọn Loại Thống Kê</a>
        </div>
    </div>
</body>
</html>
