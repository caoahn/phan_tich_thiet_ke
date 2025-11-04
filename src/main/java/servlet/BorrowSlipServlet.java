package servlet;

import dao.DocumentCopyDAO;
import dao.BorrowSlipDAO;
import model.DocumentCopy;
import model.BorrowSlip;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "BorrowSlipServlet", urlPatterns = {"/borrowSlip"})
public class BorrowSlipServlet extends HttpServlet {
    private DocumentCopyDAO documentCopyDAO;
    private BorrowSlipDAO borrowSlipDAO;

    @Override
    public void init() throws ServletException {
        this.documentCopyDAO = new DocumentCopyDAO();
        this.borrowSlipDAO = new BorrowSlipDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action){
            case "create":
                request.getRequestDispatcher("gdCreateBorrowSlip.jsp").forward(request, response);
                break;
            case "checkExistDocumentCopy":
                checkExistDocumentCopy(request, response);
                break;
            default:
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action){
            case "createBorrowSlip":
                createBorrowSlip(request, response);
                break;
            default:
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

    private void createBorrowSlip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        try {
            // Đọc JSON từ request body
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            String jsonString = sb.toString();
            System.out.println("Received JSON: " + jsonString);

            // Parse JSON thủ công (không dùng thư viện)
            int readerId = parseIntFromJson(jsonString, "readerId");
            List<Integer> copyIds = parseArrayFromJson(jsonString, "copyIds");

            // Lấy librarianId từ session
            HttpSession session = request.getSession();
            Integer librarianId = (Integer) session.getAttribute("librarianId");

            // Nếu chưa đăng nhập, dùng giá trị mặc định (tạm thời cho testing)
            if (librarianId == null) {
                librarianId = 1;
            }
            System.out.println("Reader ID: " + readerId);
            System.out.println("Librarian ID: " + librarianId);
            System.out.println("Document Copy IDs: " + copyIds);

            // Gọi DAO để tạo phiếu mượn với transaction
            BorrowSlip borrowSlip = borrowSlipDAO.createBorrowSlip(
                readerId,
                copyIds,
                librarianId
            );

            String jsonResponse;

            if (borrowSlip != null) {
                jsonResponse = String.format(
                    "{\"success\": true, \"slipId\": %d, \"message\": \"Tạo phiếu mượn thành công!\"}",
                    borrowSlip.getId()
                );
                System.out.println("TẠO PHIẾU MƯỢN THÀNH CÔNG");
            } else {
                jsonResponse = "{\"success\": false, \"error\": \"Không thể tạo phiếu mượn. Vui lòng thử lại!\"}";
                System.err.println("TẠO PHIẾU MƯỢN THẤT BẠI");
            }

            try (PrintWriter out = response.getWriter()) {
                out.print(jsonResponse);
                out.flush();
            }

        } catch (Exception e) {
            e.printStackTrace();
            String jsonResponse = String.format(
                "{\"success\": false, \"error\": \"Lỗi hệ thống: %s\"}",
                e.getMessage().replace("\"", "\\\"")
            );

            try (PrintWriter out = response.getWriter()) {
                out.print(jsonResponse);
                out.flush();
            }
        }
    }

    // Hàm parse JSON thủ công
    private int parseIntFromJson(String json, String key) {
        String pattern = "\"" + key + "\"\\s*:\\s*\"?(\\d+)\"?";
        java.util.regex.Pattern p = java.util.regex.Pattern.compile(pattern);
        java.util.regex.Matcher m = p.matcher(json);
        if (m.find()) {
            return Integer.parseInt(m.group(1));
        }
        return 0;
    }

    // Parse array dạng [1, 2, 3] hoặc ["1", "2"]
    private List<Integer> parseArrayFromJson(String json, String key) {
        List<Integer> result = new ArrayList<>();
        String pattern = "\"" + key + "\"\\s*:\\s*\\[([^\\]]*)\\]";
        java.util.regex.Pattern p = java.util.regex.Pattern.compile(pattern);
        java.util.regex.Matcher m = p.matcher(json);
        if (m.find()) {
            String arrayContent = m.group(1).trim();
            if (!arrayContent.isEmpty()) {
                String[] items = arrayContent.split(",");
                for (String item : items) {
                    item = item.trim().replaceAll("\"", ""); // bỏ dấu ngoặc kép nếu có
                    if (!item.isEmpty()) {
                        result.add(Integer.parseInt(item));
                    }
                }
            }
        }
        return result;
    }
}
