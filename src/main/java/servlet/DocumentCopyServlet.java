package servlet;
import dao.DocumentCopyDAO;
import model.DocumentCopy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DocumentCopyServlet", urlPatterns = {"/documentCopy"})
public class DocumentCopyServlet extends HttpServlet{
    private DocumentCopyDAO documentCopyDAO;

    @Override
    public void init() {
        this.documentCopyDAO = new DocumentCopyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("checkExistDocumentCopy".equals(action)) {
            checkExistDocumentCopy(request, response);
        }
    }

    private void checkExistDocumentCopy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String documentCode = request.getParameter("documentCode");

        DocumentCopy doc = documentCopyDAO.checkDocumentCopyExists(documentCode);

        if (doc != null) {
            String status = doc.getStatus();
            boolean isAvailable = status.equalsIgnoreCase("available");

            if (isAvailable) {
                request.setAttribute("success", true);
                request.setAttribute("documentCopy", doc);
            } else {
                String errorMessage = "";
                switch (status.toLowerCase()) {
                    case "borrowed":
                        errorMessage = String.format("Sách này đã được mượn! (Mã: %s)", doc.getDocumentCode());
                        break;
                    case "damaged":
                        errorMessage = String.format("Sách này bị hỏng, không thể mượn. (Mã: %s)", doc.getDocumentCode());
                        break;
                    case "lost":
                        errorMessage = String.format("Sách này đã bị báo mất. (Mã: %s)", doc.getDocumentCode());
                        break;
                    default:
                        errorMessage = String.format("Sách này không khả dụng. (Mã: %s)", doc.getDocumentCode());
                        break;
                }
                request.setAttribute("success", false);
                request.setAttribute("errorMessage", errorMessage);
            }
        } else {
            request.setAttribute("success", false);
            request.setAttribute("errorMessage", "Không tìm thấy bản sao sách này! (Mã: " + documentCode + ")");
        }

        // gửi đi giao diện
        request.getRequestDispatcher("librarian/gdCreateBorrowSlip.jsp").forward(request, response);
    }
}
