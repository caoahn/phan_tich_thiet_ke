package servlet;

import dao.DocumentCopyDAO;
import model.DocumentCopy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;

@WebServlet(name = "BorrowSlipServlet", urlPatterns = {"/borrowSlip"})
public class BorrowSlipServlet extends HttpServlet {
    private DocumentCopyDAO documentCopyDAO;

    @Override
    public void init() throws ServletException {
        this.documentCopyDAO = new DocumentCopyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action){
            case "create":
                // Handle login action
                request.getRequestDispatcher("gdCreateBorrowSlip.jsp").forward(request, response);
                break;
            case "checkExistDocumentCopy":
                checkExistDocumentCopy(request, response);
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
            default:
                // Handle default action
                break;
        }
    }

    private void checkExistDocumentCopy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        String documentCode = request.getParameter("documentCode");

        DocumentCopy doc = documentCopyDAO.checkDocumentCopyExists(documentCode);

        String json;
        if (doc != null) {
            String status = doc.getStatus();
            boolean isAvailable = status.equalsIgnoreCase("available");
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
                    // available thì không có lỗi
                    break;
            }
            if (isAvailable) {
                json = String.format(
                        "{ \"success\": true, \"copyId\": %d, \"copyCode\": \"%s\", \"bookName\": \"%s\", \"status\": \"%s\" }",
                        doc.getId(),
                        doc.getDocumentCode(),
                        doc.getBookName().replace("\"", "\\\""),
                        doc.getStatus()
                );
            } else {
                json = String.format(
                        " { \"success\": false, \"error\": \"%s\", \"status\": \"%s\" }",
                        errorMessage.replace("\"", "\\\""),
                        doc.getStatus()
                );
            }
        } else {
            json = String.format(
                    "{ \"success\": false, \"error\": \"Không tìm thấy bản sao sách này! (Mã: %s)\", \"status\": \"not_found\" }",
                    documentCode
            );
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(json);
            out.flush();
        }

        System.out.println("Response JSON: " + json);
    }

}
