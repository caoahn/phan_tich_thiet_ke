package servlet;
import dao.ReaderDAO;
import model.Reader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        String readerCode = request.getParameter("readerCode");

        Reader reader = readerDAO.checkReaderExists(readerCode);

        String json = "";
        if (reader != null) {
            json = String.format(
                    "{\"success\": true,\"readerId\": \"%s\", \"readerCode\": \"%s\", \"username\": \"%s\", \"email\": \"%s\", \"phone\": \"%s\"}",
                    reader.getId(),
                    reader.getReaderCode(),
                    reader.getUsername(),
                    reader.getEmail(),
                    reader.getPhone()
            );
            System.out.println(json);
        } else {
            json = "{\"success\": false , \"message\": \"Reader not found.\"}";
            System.out.println(json);
        }

        response.getWriter().write(json);

    }
}

