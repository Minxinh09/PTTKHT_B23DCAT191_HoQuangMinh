package test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Before;
import org.junit.Test;

import dao.ProductDAO1;
import model.Product1;

public class ProductDAO1Test {

    private ProductDAO1 productDAO;

    @Before
    public void setUp() {
        productDAO = new ProductDAO1();
    }

    /**
     * Test tìm kiếm với từ khóa có trong CSDL ('Tivi')
     */
    @Test
    public void testSearchProductValid() {
        String keyword = "Tivi";
        ArrayList<Product1> list = productDAO.searchProduct(keyword);
        assertNotNull("Danh sách kết quả không được null", list);
        assertTrue("Phải tìm thấy ít nhất 1 sản phẩm Tivi", list.size() > 0);
        for (Product1 p : list) {
            assertTrue("Tên sản phẩm phải chứa từ khóa tìm kiếm",
                p.getProductName().toLowerCase().contains(keyword.toLowerCase()));
        }
    }

    /**
     * Test tìm kiếm với từ khóa không tồn tại ('SanPhamKhongTonTai999')
     */
    @Test
    public void testSearchProductNotFound() {
        String keyword = "SanPhamKhongTonTai999";
        ArrayList<Product1> list = productDAO.searchProduct(keyword);
        assertNotNull("Danh sách kết quả không được null", list);
        assertEquals("Không được tìm thấy sản phẩm nào", 0, list.size());
    }

    /**
     * Test tìm kiếm với chuỗi rỗng (phải trả về toàn bộ sản phẩm)
     */
    @Test
    public void testSearchProductEmpty() {
        ArrayList<Product1> list = productDAO.searchProduct("");
        assertNotNull("Danh sách kết quả không được null", list);
        assertTrue("Chuỗi rỗng phải trả về tất cả sản phẩm trong kho", list.size() >= 5);
    }

    /**
     * Test lấy chi tiết mặt hàng với ID hợp lệ (ID = 1)
     */
    @Test
    public void testGetProductByIdValid() {
        int validId = 1;
        Product1 product = productDAO.getProductById(validId);
        assertNotNull("Mặt hàng ID = 1 phải tồn tại trong CSDL", product);
        assertEquals("ID trả về phải khớp với ID yêu cầu", validId, product.getId());
        assertEquals("Mã sản phẩm phải là TV_SN_01", "TV_SN_01", product.getProductCode());
    }

    /**
     * Test lấy chi tiết mặt hàng với ID không tồn tại (ID = 999999)
     */
    @Test
    public void testGetProductByIdNotFound() {
        int invalidId = 999999;
        Product1 product = productDAO.getProductById(invalidId);
        assertNull("Mặt hàng với ID không tồn tại phải trả về null", product);
    }
}
