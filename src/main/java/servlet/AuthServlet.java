package servlet;
import dao.MemberDAO;
import model.Member;
import model.Reader;
import model.Librarian;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name="AuthServlet", urlPatterns={"/auth"})
public class AuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action){
            case "login":
                // Handle login action
                request.getRequestDispatcher("gdLogin.jsp").forward(request, response);
                break;
            case "logout":
                // Handle logout action
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate(); // hủy toàn bộ session
                }
                request.getRequestDispatcher("gdLogin.jsp").forward(request, response);
                break;
            case "register":
                // Handle register action
                request.getRequestDispatcher("gdRegister.jsp").forward(request, response);
                break;
            default:
                // Handle default action
                break;
        }
    }

    @Override
    protected  void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");

        switch (action){
            case "login":
                login(request, response);
                break;
            case "register":
                register(request, response);
                break;
            default:
                // Handle default action
                break;
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Implement login logic here
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        MemberDAO dao = new MemberDAO();
        Member member = dao.login(username, password);
        System.out.println(member);

        if(member != null){
            HttpSession session = request.getSession();
            session.setAttribute("member", member);

            // Nếu là librarian, lưu thêm librarianId vào session
            if(member instanceof Librarian){
                Librarian librarian = (Librarian) member;
                session.setAttribute("librarianId", librarian.getId());
            }

            response.sendRedirect("gdMainMenu.jsp");
        }
        else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("gdLogin.jsp").forward(request, response);
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Implement registration logic here
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = "reader"; // Default role

        Reader newMember = new Reader(
            username,
            password,
            null,
            null,
            email,
            null,
            role,
            0,
            null,
            0,
            username
        );
        MemberDAO dao = new MemberDAO();
        boolean isRegistered = dao.registerReader(newMember);

        if(isRegistered){
            response.sendRedirect("gdLogin.jsp");
        }
        else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("gdRegister.jsp").forward(request, response);
        }
    }
}