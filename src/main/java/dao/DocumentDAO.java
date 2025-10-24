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
                doc.setPublishedYear(rs.getString("published_year"));
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
        
        String sql = "SELECT * FROM document WHERE id = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, idDocument);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                document = new Document();
                document.setId(rs.getInt("id"));
                document.setName(rs.getString("name"));
                document.setAuthor(rs.getString("author"));
                document.setPublishedYear(rs.getString("published_year"));
                document.setDescription(rs.getString("description"));
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy chi tiết tài liệu!");
            e.printStackTrace();
        }
        
        return document;
    }
    public List<Document> getAllDocuments() {
        List<Document> documentList = new ArrayList<>();
        
        String sql = "SELECT * FROM document ORDER BY name";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Document doc = new Document();
                doc.setId(rs.getInt("id"));
                doc.setName(rs.getString("name"));
                doc.setAuthor(rs.getString("author"));
                doc.setPublishedYear(rs.getString("published_year"));
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