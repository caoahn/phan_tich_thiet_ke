package servlet;
import dao.ReaderDAO;
import model.Reader;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ReaderServlet", urlPatterns = {"/reader"})
public class ReaderServlet extends HttpServlet {
    private ReaderDAO readerDAO;

    @Override
    public void init() throws ServletException {
        this.readerDAO = new ReaderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        String action = request.getParameter("action");

        if("checkReader".equals(action)){
            checkReader(request, response);
        }
    }

    private void checkReader(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        String readerCode = request.getParameter("readerCode");

        Reader reader = readerDAO.checkReaderExists(readerCode);

        if (reader != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentReader", reader);
            request.setAttribute("success", true);
        } else {
            request.setAttribute("success", false);
            request.setAttribute("errorMessage", "Không tìm thấy độc giả với mã: " + readerCode);
        }

        // Forward về lại trang tạo phiếu mượn
        request.getRequestDispatcher("librarian/gdCreateBorrowSlip.jsp").forward(request, response);
    }
}
