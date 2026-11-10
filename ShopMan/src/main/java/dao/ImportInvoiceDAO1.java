package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import model.Category1;
import model.ImportDetail1;
import model.ImportInvoice1;
import model.Product1;
import model.Supplier1;
import model.WarehouseStaff1;

public class ImportInvoiceDAO1 extends DAO {

    public ImportInvoiceDAO1() {
        super();
    }

    /**
     * Lấy danh sách các hóa đơn nhập của 1 nhà cung cấp trong khoảng thời gian
     * @param supplierId ID nhà cung cấp
     * @param startDate Ngày bắt đầu
     * @param endDate Ngày kết thúc
     * @return Danh sách các hóa đơn nhập
     */
    public ArrayList<ImportInvoice1> getImportInvoiceBySupplier(int supplierId, Date startDate, Date endDate) {
        ArrayList<ImportInvoice1> list = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String sql = "SELECT ii.*, s.supplierCode, s.supplierName, s.phone, s.email, s.address, "
                   + "       COALESCE(SUM(d.quantity * d.importPrice), 0) AS calculatedTotal "
                   + "FROM tblImportInvoice1 ii "
                   + "INNER JOIN tblSupplier1 s ON ii.supplierId = s.id "
                   + "LEFT JOIN tblImportDetail1 d ON ii.id = d.importInvoiceId "
                   + "WHERE ii.supplierId = ? AND DATE(ii.importDate) >= ? AND DATE(ii.importDate) <= ? "
                   + "GROUP BY ii.id, s.id "
                   + "ORDER BY ii.importDate DESC";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, supplierId);
            ps.setString(2, sdf.format(startDate));
            ps.setString(3, sdf.format(endDate));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Supplier1 sup = new Supplier1(
                    rs.getInt("supplierId"),
                    rs.getString("supplierCode"),
                    rs.getString("supplierName"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("address")
                );
                
                ImportInvoice1 inv = new ImportInvoice1(
                    rs.getInt("id"),
                    rs.getString("importCode"),
                    rs.getTimestamp("importDate"),
                    rs.getDouble("calculatedTotal"),
                    sup,
                    null
                );
                list.add(inv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy chi tiết hóa đơn nhập (gồm thông tin chung, người lập hóa đơn, nhà cung cấp và danh sách mặt hàng)
     * @param invoiceId ID hóa đơn nhập
     * @return ImportInvoice1 đầy đủ các ImportDetail1 và WarehouseStaff1
     */
    public ImportInvoice1 getInvoiceDetail(int invoiceId) {
        ImportInvoice1 invoice = null;

        // 1. Lấy thông tin hóa đơn, nhà cung cấp và nhân viên kho lập hóa đơn
        String sqlInvoice = "SELECT ii.*, s.supplierCode, s.supplierName, s.phone, s.email, s.address, "
                          + "       mem.name AS staffName, emp.employeeCode AS staffCode, emp.position AS staffPos, ws.warehouseDuty "
                          + "FROM tblImportInvoice1 ii "
                          + "INNER JOIN tblSupplier1 s ON ii.supplierId = s.id "
                          + "LEFT JOIN tblWarehouseStaff1 ws ON ii.warehouseStaffId = ws.id "
                          + "LEFT JOIN tblEmployee1 emp ON ws.employeeId = emp.id "
                          + "LEFT JOIN tblMember1 mem ON emp.memberId = mem.id "
                          + "WHERE ii.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sqlInvoice);
            ps.setInt(1, invoiceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Supplier1 sup = new Supplier1(
                    rs.getInt("supplierId"),
                    rs.getString("supplierCode"),
                    rs.getString("supplierName"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("address")
                );

                WarehouseStaff1 staff = null;
                String staffName = rs.getString("staffName");
                if (staffName != null) {
                    staff = new WarehouseStaff1();
                    staff.setName(staffName);
                    staff.setEmployeeCode(rs.getString("staffCode"));
                    staff.setPosition(rs.getString("staffPos"));
                    staff.setWarehouseDuty(rs.getString("warehouseDuty"));
                }

                invoice = new ImportInvoice1(
                    rs.getInt("id"),
                    rs.getString("importCode"),
                    rs.getTimestamp("importDate"),
                    0,
                    sup,
                    staff
                );

                // 2. Lấy danh sách các mặt hàng nhập trong hóa đơn
                String sqlDetail = "SELECT d.*, p.productCode, p.productName, p.unit, p.brand, p.warrantyMonth "
                                 + "FROM tblImportDetail1 d "
                                 + "INNER JOIN tblProduct1 p ON d.productId = p.id "
                                 + "WHERE d.importInvoiceId = ? "
                                 + "ORDER BY d.id ASC";

                PreparedStatement psDetail = con.prepareStatement(sqlDetail);
                psDetail.setInt(1, invoiceId);
                ResultSet rsDetail = psDetail.executeQuery();

                List<ImportDetail1> detailList = new ArrayList<>();
                double total = 0;
                while (rsDetail.next()) {
                    Product1 prod = new Product1();
                    prod.setId(rsDetail.getInt("productId"));
                    prod.setProductCode(rsDetail.getString("productCode"));
                    prod.setProductName(rsDetail.getString("productName"));
                    prod.setUnit(rsDetail.getString("unit"));
                    prod.setBrand(rsDetail.getString("brand"));
                    prod.setWarrantyMonth(rsDetail.getInt("warrantyMonth"));

                    ImportDetail1 detail = new ImportDetail1(
                        rsDetail.getInt("id"),
                        rsDetail.getInt("quantity"),
                        rsDetail.getDouble("importPrice"),
                        invoice,
                        prod
                    );
                    detailList.add(detail);
                    total += detail.getAmount();
                }
                invoice.setImportDetail(detailList);
                invoice.setTotalAmount(total);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return invoice;
    }
}
