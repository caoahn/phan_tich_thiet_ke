package dao;
import dao.DAO;
import model.Member;
import model.Reader;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO extends DAO {
    public Member login(String username, String password){
//        String sql = "SELECT * FROM Members WHERE username = ? AND password = ?";

        String sql = "SELECT username, password, address, birthday, email, phone, role "
                + "FROM member WHERE username = ? AND password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Member m = new Member();
                m.setUsername(rs.getString("username"));
                m.setPassword(rs.getString("password"));
                m.setAddress(rs.getString("address"));
                m.setBirthday(rs.getDate("birthday"));
                m.setEmail(rs.getString("email"));
                m.setPhone(rs.getString("phone"));
                m.setRole(rs.getString("role"));
                return m;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean registerReader(Reader reader) {

        String readerCode = "RD" + (1000000 + new java.util.Random().nextInt(9000000));

        String sqlMember = "INSERT INTO member (username, password, email, phone, address, birthday, role) " +
                "VALUES (?, ?, ?, ?, ?, ?, 'reader')";

        String sqlReader = "INSERT INTO reader (readerCode, username) " +
                "VALUES (?, ?)";

        try {
            connection.setAutoCommit(false);

            // INSERT VÀO MEMBER
            try (PreparedStatement psMember = connection.prepareStatement(sqlMember)) {
                psMember.setString(1, reader.getUsername());
                psMember.setString(2, reader.getPassword());
                psMember.setString(3, reader.getEmail());
                psMember.setString(4, reader.getPhone());
                psMember.setString(5, reader.getAddress());
                psMember.setDate(6,(reader.getBirthday() != null) ? new java.sql.Date(reader.getBirthday().getTime()) : null);

                psMember.executeUpdate();
            }

            // INSERT VÀO READER
            try (PreparedStatement psReader = connection.prepareStatement(sqlReader)) {
                psReader.setString(1, readerCode);
                psReader.setString(2, reader.getUsername());

                psReader.executeUpdate();
            }

            // COMMIT TRANSACTION
            connection.commit();
            return true;

        } catch (SQLException e) {
            System.err.println("Transaction bị Rollback!");
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}