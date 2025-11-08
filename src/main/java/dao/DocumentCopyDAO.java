package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.DocumentCopy;

public class DocumentCopyDAO extends  DAO{
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
