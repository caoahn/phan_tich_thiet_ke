package dao;

import model.BorrowSlip;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.List;

public class BorrowSlipDAO extends DAO {

    public BorrowSlip createBorrowSlipWithTransaction(int readerId, List<Integer> documentCopyIds, int librarianId) {
        BorrowSlip borrowSlip = null;

        try {
            // Bắt đầu transaction
            connection.setAutoCommit(false);

            System.out.println("readerId: " + readerId);

            // Tạo borrow_slip
            String sqlSlip = "INSERT INTO borrow_slip (borrowDate, returnDate, status, readerId) " +
                           "VALUES (CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'borrowing', ?)";

            PreparedStatement psSlip = connection.prepareStatement(sqlSlip, Statement.RETURN_GENERATED_KEYS);
            psSlip.setInt(1, readerId);

            int rowsAffected = psSlip.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Tạo phiếu mượn thất bại, không có row nào được insert.");
            }

            // Lấy ID của phiếu mượn vừa tạo
            ResultSet rs = psSlip.getGeneratedKeys();
            int slipId = 0;
            if (rs.next()) {
                slipId = rs.getInt(1);
            } else {
                throw new SQLException("Tạo phiếu mượn thất bại, không lấy được ID.");
            }
            rs.close();
            psSlip.close();

            System.out.println("✓ BƯỚC A: Tạo phiếu mượn thành công với ID: " + slipId);

            // Tạo borrow_slip_detail cho từng document_copy
            String sqlDetail = "INSERT INTO borrow_slip_detail (borrowSlipId, documentCopyId, librarianId) " +
                             "VALUES ( ?, ?, ?)";
            PreparedStatement psDetail = connection.prepareStatement(sqlDetail);

            for (Integer copyId : documentCopyIds) {
                psDetail.setInt(1, slipId);
                psDetail.setInt(2, copyId);
                psDetail.setInt(3, librarianId);
                psDetail.executeUpdate();
                System.out.println("✓ BƯỚC B: Thêm chi tiết cho document_copy_id = " + copyId);
            }
            psDetail.close();

            // Cập nhật trạng thái document_copy thành 'borrowed'
            String sqlUpdate = "UPDATE document_copy SET status = 'borrowed' WHERE id = ?";
            PreparedStatement psUpdate = connection.prepareStatement(sqlUpdate);

            for (Integer copyId : documentCopyIds) {
                psUpdate.setInt(1, copyId);
                int updated = psUpdate.executeUpdate();
                if (updated == 0) {
                    throw new SQLException("Không thể cập nhật trạng thái cho document_copy_id = " + copyId);
                }
                System.out.println("✓ BƯỚC C: Cập nhật trạng thái 'borrowed' cho document_copy_id = " + copyId);
            }
            psUpdate.close();

            // COMMIT giao dịch
            connection.commit();
            System.out.println("COMMIT: Transaction thành công!");

            // Tạo đối tượng BorrowSlip để trả về
            borrowSlip = new BorrowSlip();
            borrowSlip.setId(slipId);
            borrowSlip.setReaderId(readerId);
            borrowSlip.setStatus("borrowed");

        } catch (SQLException e) {
            try {
                if (connection != null) {
                    connection.rollback();
                    System.err.println("✗✗✗ ROLLBACK: Giao dịch bị hủy do có lỗi!");
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            System.err.println("Lỗi khi tạo phiếu mượn: " + e.getMessage());
            borrowSlip = null;

        } finally {
            // Khôi phục chế độ auto-commit
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return borrowSlip;
    }
}
