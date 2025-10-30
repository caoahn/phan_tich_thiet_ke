package dao;

import model.Reader;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReaderDAO extends DAO{
    public Reader checkReaderExists(String readerCode) {
        Reader reader = null;
        String sql = "SELECT r.id, r.readerCode, r.username, m.email, m.phone " +
                "FROM reader r " +
                "JOIN member m ON r.username = m.username " +
                "WHERE r.readerCode = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, readerCode);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                reader = new Reader();
                reader.setId(rs.getInt("id"));
                reader.setReaderCode(rs.getString("readerCode"));
                reader.setUsername(rs.getString("username"));
                reader.setEmail(rs.getString("email"));
                reader.setPhone(rs.getString("phone"));
            }
            rs.close();
            ps.close();
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return  reader;
    }
}
