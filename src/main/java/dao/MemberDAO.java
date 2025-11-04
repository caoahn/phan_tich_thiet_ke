package dao;
import dao.DAO;
import model.Member;
import model.Reader;
import model.Librarian;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO extends DAO {
    public Member login(String username, String password){
//        String sql = "SELECT * FROM Members WHERE username = ? AND password = ?";

        String sql = "SELECT m.username, m.password, m.address, m.birthday, m.email, m.phone, m.role, l.id, l.librarianCode "
                + "FROM member m "
                + "LEFT JOIN librarian l ON m.username = l.username "
                + "WHERE m.username = ? AND m.password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String role = rs.getString("role");

                // Nếu role là librarian, trả về đối tượng Librarian với đầy đủ thông tin
                if ("librarian".equals(role)) {
                    Librarian librarian = new Librarian();
                    librarian.setUsername(rs.getString("username"));
                    librarian.setPassword(rs.getString("password"));
                    librarian.setAddress(rs.getString("address"));
                    librarian.setBirthday(rs.getDate("birthday"));
                    librarian.setEmail(rs.getString("email"));
                    librarian.setPhone(rs.getString("phone"));
                    librarian.setRole(role);
                    librarian.setId(rs.getInt("id"));
                    librarian.setLibrarianCode(rs.getString("librarianCode"));

                    System.out.println("Librarian logged in: " + librarian.getId());
                    return librarian;
                } else {
                    // Các role khác (reader, manager) trả về Member thông thường
                    Member m = new Member();
                    m.setUsername(rs.getString("username"));
                    m.setPassword(rs.getString("password"));
                    m.setAddress(rs.getString("address"));
                    m.setBirthday(rs.getDate("birthday"));
                    m.setEmail(rs.getString("email"));
                    m.setPhone(rs.getString("phone"));
                    m.setRole(role);
                    return m;
                }
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