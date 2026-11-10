package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import model.SupplierStat1;

public class SupplierStatDAO1 extends DAO {

    public SupplierStatDAO1() {
        super();
    }

    /**
     * Thống kê nhà cung cấp theo lượng hàng nhập trong khoảng thời gian
     * @param startDate Ngày bắt đầu
     * @param endDate Ngày kết thúc
     * @return Danh sách SupplierStat1 sắp xếp theo tổng số lượng nhập giảm dần
     */
    public ArrayList<SupplierStat1> getSupplierStat(Date startDate, Date endDate) {
        ArrayList<SupplierStat1> list = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        String sql = "SELECT s.id, s.supplierCode, s.supplierName, s.phone, s.email, s.address, "
                   + "       COUNT(DISTINCT ii.id) AS importCount, "
                   + "       COALESCE(SUM(idtl.quantity), 0) AS totalImportQuantity, "
                   + "       COALESCE(SUM(idtl.quantity * idtl.importPrice), 0) AS totalImportAmount "
                   + "FROM tblSupplier1 s "
                   + "INNER JOIN tblImportInvoice1 ii ON s.id = ii.supplierId "
                   + "INNER JOIN tblImportDetail1 idtl ON ii.id = idtl.importInvoiceId "
                   + "WHERE DATE(ii.importDate) >= ? AND DATE(ii.importDate) <= ? "
                   + "GROUP BY s.id, s.supplierCode, s.supplierName, s.phone, s.email, s.address "
                   + "ORDER BY totalImportQuantity DESC";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, sdf.format(startDate));
            ps.setString(2, sdf.format(endDate));
            ResultSet rs = ps.executeQuery();
            
            int rank = 1;
            while (rs.next()) {
                SupplierStat1 stat = new SupplierStat1(
                    rs.getInt("id"),
                    rs.getString("supplierCode"),
                    rs.getString("supplierName"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getInt("totalImportQuantity"),
                    rs.getDouble("totalImportAmount"),
                    rs.getInt("importCount"),
                    rank++
                );
                list.add(stat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
