package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.Reader;

@WebServlet(name = "BorrowSlipServlet", urlPatterns = {"/borrowSlip"})
public class BorrowSlipServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action){
            case "create":
                // Handle login action
                request.getRequestDispatcher("gdCreateBorrowSlip.jsp").forward(request, response);
                break;
            default:
                // Handle default action
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action){
            case "checkReader":
                checkReader(request, response);
                break;
            default:
                // Handle default action
                break;
        }
    }

    private void checkReader(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
    }
}
