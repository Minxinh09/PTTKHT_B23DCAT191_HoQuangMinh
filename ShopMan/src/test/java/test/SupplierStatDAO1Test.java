package test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.junit.Before;
import org.junit.Test;

import dao.SupplierStatDAO1;
import model.SupplierStat1;

public class SupplierStatDAO1Test {

    private SupplierStatDAO1 statDAO;
    private SimpleDateFormat sdf;

    @Before
    public void setUp() {
        statDAO = new SupplierStatDAO1();
        sdf = new SimpleDateFormat("yyyy-MM-dd");
    }

    /**
     * Test thống kê với khoảng thời gian hợp lệ có dữ liệu nhập hàng (Tháng 09/2026)
     */
    @Test
    public void testGetSupplierStatValidPeriod() throws Exception {
        Date startDate = sdf.parse("2026-09-01");
        Date endDate = sdf.parse("2026-09-30");

        ArrayList<SupplierStat1> list = statDAO.getSupplierStat(startDate, endDate);
        assertNotNull("Danh sách thống kê không được null", list);
        assertTrue("Tháng 9/2026 phải có ít nhất 1 nhà cung cấp có hàng nhập", list.size() > 0);

        // Kiểm tra tính sắp xếp giảm dần theo tổng lượng hàng nhập
        for (int i = 0; i < list.size() - 1; i++) {
            assertTrue("Danh sách phải được sắp xếp theo tổng lượng nhập giảm dần",
                list.get(i).getTotalImportQuantity() >= list.get(i + 1).getTotalImportQuantity());
        }

        // Kiểm tra thứ hạng rank
        for (int i = 0; i < list.size(); i++) {
            assertEquals("Thứ hạng rank phải tăng liên tục từ 1", i + 1, list.get(i).getRank());
        }
    }

    /**
     * Test thống kê với khoảng thời gian trong quá khứ không có đợt nhập nào (Năm 2020)
     */
    @Test
    public void testGetSupplierStatNoDataPeriod() throws Exception {
        Date startDate = sdf.parse("2020-01-01");
        Date endDate = sdf.parse("2020-01-31");

        ArrayList<SupplierStat1> list = statDAO.getSupplierStat(startDate, endDate);
        assertNotNull("Danh sách thống kê không được null", list);
        assertEquals("Khoảng thời gian không có dữ liệu phải trả về danh sách rỗng", 0, list.size());
    }
}
