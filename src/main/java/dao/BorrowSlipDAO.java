package dao;

import model.BorrowSlip;
import model.BorrowSlipDetail;
import model.Reader;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.Date;
import java.util.List;
import java.util.ArrayList;

public class BorrowSlipDAO extends DAO {
    public BorrowSlip createBorrowSlip(int readerId, List<Integer> documentCopyIds, int librarianId,
                                       String borrowDateStr, String returnDateStr) {
        BorrowSlip borrowSlip = null;

        try {
            // Bắt đầu transaction
            connection.setAutoCommit(false);
            System.out.println("readerId: " + readerId);

            String sqlSlip = "INSERT INTO borrow_slip (borrowDate, returnDate, status, readerId) VALUES (?, ?, 'borrowing', ?)";

            PreparedStatement psSlip = connection.prepareStatement(sqlSlip, Statement.RETURN_GENERATED_KEYS);
            psSlip.setDate(1, Date.valueOf(borrowDateStr));
            psSlip.setDate(2, Date.valueOf(returnDateStr));
            psSlip.setInt(3, readerId);

            int rowsAffected = psSlip.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Tạo phiếu mượn thất bại, không có row nào được insert.");
            }

            ResultSet rs = psSlip.getGeneratedKeys();
            int slipId = 0;
            if (rs.next()) {
                slipId = rs.getInt(1);
            } else {
                throw new SQLException("Tạo phiếu mượn thất bại, không lấy được ID.");
            }
            rs.close();
            psSlip.close();


            String sqlDetail = "INSERT INTO borrow_slip_detail (borrowSlipId, documentCopyId, librarianId) VALUES (?, ?, ?)";
            PreparedStatement psDetail = connection.prepareStatement(sqlDetail);

            for (Integer copyId : documentCopyIds) {
                psDetail.setInt(1, slipId);
                psDetail.setInt(2, copyId);
                psDetail.setInt(3, librarianId);
                psDetail.executeUpdate();
            }
            psDetail.close();

            String sqlUpdate = "UPDATE document_copy SET status = 'borrowed' WHERE id = ?";
            PreparedStatement psUpdate = connection.prepareStatement(sqlUpdate);

            for (Integer copyId : documentCopyIds) {
                psUpdate.setInt(1, copyId);
                int updated = psUpdate.executeUpdate();
                if (updated == 0) {
                    throw new SQLException("Không thể cập nhật trạng thái cho document_copy_id = " + copyId);
                }
                System.out.println("Cập nhật trạng thái 'borrowed' cho document_copy_id = " + copyId);
            }
            psUpdate.close();

            connection.commit();

            borrowSlip = new BorrowSlip();
            borrowSlip.setId(slipId);
            borrowSlip.setReaderId(readerId);
            borrowSlip.setStatus("borrowing");

        } catch (SQLException e) {
            try {
                if (connection != null) {
                    connection.rollback();
                    System.err.println("ROLLBACK: Giao dịch bị hủy do có lỗi!");
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            borrowSlip = null;

        } finally {
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

    public BorrowSlip getBorrowSlipDetail(int slipId) {
        BorrowSlip borrowSlip = null;

        try {
            String sql = "SELECT " +
                        "bs.id AS slipId, bs.borrowDate, bs.returnDate, bs.status, " +
                        "r.id AS readerId, r.readerCode, r.username, " +
                        "m.email, m.phone, " +
                        "bsd.id AS detailId, bsd.documentCopyId, " +
                        "d.name AS bookName " +
                        "FROM borrow_slip bs " +
                        "JOIN reader r ON bs.readerId = r.id " +
                        "JOIN member m ON r.username = m.username " +
                        "LEFT JOIN borrow_slip_detail bsd ON bs.id = bsd.borrowSlipId " +
                        "LEFT JOIN document_copy dc ON bsd.documentCopyId = dc.id " +
                        "LEFT JOIN document d ON dc.document_id = d.id " +
                        "WHERE bs.id = ?";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, slipId);
            ResultSet rs = ps.executeQuery();

            List<BorrowSlipDetail> details = new ArrayList<>();

            while (rs.next()) {
                if (borrowSlip == null) {
                    borrowSlip = new BorrowSlip();
                    borrowSlip.setId(rs.getInt("slipId"));
                    borrowSlip.setBorrowDate(rs.getDate("borrowDate"));
                    borrowSlip.setReturnDate(rs.getDate("returnDate"));
                    borrowSlip.setStatus(rs.getString("status"));

                    Reader reader = new Reader();
                    reader.setId(rs.getInt("readerId"));
                    reader.setReaderCode(rs.getString("readerCode"));
                    reader.setUsername(rs.getString("username"));
                    reader.setEmail(rs.getString("email"));
                    reader.setPhone(rs.getString("phone"));
                    borrowSlip.setReader(reader);
                }

                int detailId = rs.getInt("detailId");

                if (detailId != 0) {
                    BorrowSlipDetail detail = new BorrowSlipDetail();
                    detail.setId(detailId);
                    detail.setDocumentCopyId(rs.getInt("documentCopyId"));
                    detail.setBookName(rs.getString("bookName"));
                    details.add(detail);
                }
            }

            if (borrowSlip != null) {
                borrowSlip.setDetails(details);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return borrowSlip;
    }
}
