package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Category1;
import model.Product1;

public class ProductDAO1 extends DAO {

    public ProductDAO1() {
        super();
    }

    /**
     * Tìm kiếm mặt hàng theo từ khóa tên
     * @param name từ khóa cần tìm
     * @return danh sách mặt hàng khớp từ khóa
     */
    public ArrayList<Product1> searchProduct(String name) {
        ArrayList<Product1> list = new ArrayList<>();
        String sql = "SELECT p.*, c.categoryCode, c.categoryName, c.description AS catDesc "
                   + "FROM tblProduct1 p "
                   + "LEFT JOIN tblCategory1 c ON p.categoryId = c.id "
                   + "WHERE p.productName LIKE ? "
                   + "ORDER BY p.id ASC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + (name == null ? "" : name.trim()) + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category1 cat = null;
                int catId = rs.getInt("categoryId");
                if (catId > 0) {
                    cat = new Category1(catId, rs.getString("categoryCode"), rs.getString("categoryName"), rs.getString("catDesc"));
                }
                Product1 p = new Product1(
                    rs.getInt("id"),
                    rs.getString("productCode"),
                    rs.getString("productName"),
                    rs.getDouble("price"),
                    rs.getString("unit"),
                    rs.getInt("stockQuantity"),
                    rs.getString("brand"),
                    rs.getInt("warrantyMonth"),
                    rs.getString("description"),
                    cat
                );
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy chi tiết mặt hàng theo ID
     * @param id mã ID của mặt hàng
     * @return đối tượng Product1 đầy đủ thông tin
     */
    public Product1 getProductById(int id) {
        Product1 p = null;
        String sql = "SELECT p.*, c.categoryCode, c.categoryName, c.description AS catDesc "
                   + "FROM tblProduct1 p "
                   + "LEFT JOIN tblCategory1 c ON p.categoryId = c.id "
                   + "WHERE p.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Category1 cat = null;
                int catId = rs.getInt("categoryId");
                if (catId > 0) {
                    cat = new Category1(catId, rs.getString("categoryCode"), rs.getString("categoryName"), rs.getString("catDesc"));
                }
                p = new Product1(
                    rs.getInt("id"),
                    rs.getString("productCode"),
                    rs.getString("productName"),
                    rs.getDouble("price"),
                    rs.getString("unit"),
                    rs.getInt("stockQuantity"),
                    rs.getString("brand"),
                    rs.getInt("warrantyMonth"),
                    rs.getString("description"),
                    cat
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }
}
