/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Document;
import model.DocumentCopy;

public class DocumentDAO extends DAO {
    
    public List<Document> getListDocument(String nameDocument) {
        List<Document> documentList = new ArrayList<>();
        
        String sql = "SELECT * FROM document WHERE name LIKE ? ORDER BY name";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + nameDocument + "%");
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Document doc = new Document();
                doc.setId(rs.getInt("id"));
                doc.setName(rs.getString("name"));
                doc.setAuthor(rs.getString("author"));
                doc.setPublishedYear(rs.getString("publishedYear"));
                doc.setDescription(rs.getString("description"));
                
                documentList.add(doc);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm tài liệu!");
            e.printStackTrace();
        }
        
        return documentList;
    }

    public Document getDetailDocument(int idDocument) {
        Document document = null;

        String sql = "SELECT d.id, d.name, d.author, d.publishedYear, d.description, " +
                     "dc.id AS copy_id, dc.document_code, dc.status " +
                     "FROM document d " +
                     "LEFT JOIN document_copy dc ON d.id = dc.document_id " +
                     "WHERE d.id = ? " +
                     "ORDER BY dc.document_code";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idDocument);

            try (ResultSet rs = ps.executeQuery()) {
                List<DocumentCopy> copies = new ArrayList<>();

                while (rs.next()) {
                    if (document == null) {
                        document = new Document();
                        document.setId(rs.getInt("id"));
                        document.setName(rs.getString("name"));
                        document.setAuthor(rs.getString("author"));
                        document.setPublishedYear(rs.getString("publishedYear"));
                        document.setDescription(rs.getString("description"));
                    }
                    if (rs.getObject("copy_id") != null) {
                        DocumentCopy copy = new DocumentCopy();
                        copy.setId(rs.getInt("copy_id"));
                        copy.setDocumentCode(rs.getString("document_code"));
                        copy.setStatus(rs.getString("status"));
                        copies.add(copy);
                    }
                }
                if (document != null) {
                    document.setCopies(copies);
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy chi tiết tài liệu!");
            e.printStackTrace();
        }

        return document;
    }

    public List<Document> getAllDocuments() {
        List<Document> documentList = new ArrayList<>();
        
        String sql = "SELECT * FROM document";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Document doc = new Document();
                doc.setId(rs.getInt("id"));
                doc.setName(rs.getString("name"));
                doc.setAuthor(rs.getString("author"));
                doc.setPublishedYear(rs.getString("publishedYear"));
                doc.setDescription(rs.getString("description"));
                
                documentList.add(doc);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách tài liệu!");
            e.printStackTrace();
        }
        
        return documentList;
    }
}