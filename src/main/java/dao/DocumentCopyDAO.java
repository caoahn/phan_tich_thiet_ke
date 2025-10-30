package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.DocumentCopy;

public class DocumentCopyDAO extends  DAO{
    public List<DocumentCopy> getDocumentCopies(int documentId) {
        List<DocumentCopy> copies = new ArrayList<>();
        String sql = "SELECT id, document_code, status, created_at " +
                "FROM document_copy " +
                "WHERE document_id = ? " +
                "ORDER BY document_code";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, documentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DocumentCopy copy = new DocumentCopy();
                copy.setId(rs.getInt("id"));
                copy.setDocumentCode(rs.getString("document_code"));
                copy.setStatus(rs.getString("status"));
                copies.add(copy);
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách bản sao!");
            e.printStackTrace();
        }
        return copies;
    }

    public DocumentCopy checkDocumentCopyExists(String documentCode) {
        DocumentCopy copy = null;
        String sql = "SELECT dc.id AS copyId, dc.document_code AS documentCode, d.name AS bookName, dc.status " +
                "FROM document_copy dc " +
                "JOIN document d ON dc.document_id = d.id " +
                "WHERE dc.document_code = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, documentCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    copy = new DocumentCopy();
                    copy.setId(rs.getInt("copyId"));
                    copy.setDocumentCode(rs.getString("documentCode"));
                    copy.setBookName(rs.getString("bookName"));
                    copy.setStatus(rs.getString("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return copy;
    }

}
