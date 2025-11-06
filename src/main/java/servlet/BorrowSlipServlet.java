package servlet;

import dao.BorrowSlipDAO;
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
    private BorrowSlipDAO borrowSlipDAO;

    @Override
    public void init() throws ServletException {
        this.borrowSlipDAO = new BorrowSlipDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action){
            case "create":
                HttpSession session = request.getSession(false);
                if (session != null && session.getAttribute("currentReader") != null) {
                    session.removeAttribute("currentReader");
                }
                request.getRequestDispatcher("gdCreateBorrowSlip.jsp").forward(request, response);
                break;
            case "viewDetail":
                viewBorrowSlipDetail(request, response);
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

    private void createBorrowSlip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy dữ liệu từ form parameters
            String readerIdStr = request.getParameter("readerId");
            String copyIdsJson = request.getParameter("copyIds");

            int readerId = Integer.parseInt(readerIdStr);

            // Parse JSON array của copyIds - format: [1,2,3]
            List<Integer> copyIds = new ArrayList<>();
            String arrayContent = copyIdsJson.replaceAll("[\\[\\]\\s]", ""); // Bỏ [ ] và khoảng trắng
            if (!arrayContent.isEmpty()) {
                String[] items = arrayContent.split(",");
                for (String item : items) {
                    copyIds.add(Integer.parseInt(item.trim()));
                }
            }

            // Lấy librarianId từ session
            HttpSession session = request.getSession();
            Integer librarianId = (Integer) session.getAttribute("librarianId");

            // Nếu chưa đăng nhập, dùng giá trị mặc định (tạm thời cho testing)
            if (librarianId == null) {
                librarianId = 1;
            }

            // Gọi DAO để tạo phiếu mượn với transaction
            BorrowSlip borrowSlip = borrowSlipDAO.createBorrowSlip(
                readerId,
                copyIds,
                librarianId
            );

            if (borrowSlip != null) {
                // Xóa session reader
                session.removeAttribute("currentReader");

                // Set attributes để hiển thị thông báo thành công
                request.setAttribute("createSuccess", true);
                request.setAttribute("borrowSlip", borrowSlip);
                request.setAttribute("message", "Tạo phiếu mượn thành công!");

                // Forward về trang tạo phiếu mượn với thông báo
                request.getRequestDispatcher("gdCreateBorrowSlip.jsp").forward(request, response);
            } else {
                response.sendRedirect("borrowSlip?action=create&error=Không thể tạo phiếu mượn");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("borrowSlip?action=create&error=" + e.getMessage());
        }
    }

    private void viewBorrowSlipDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String slipIdParam = request.getParameter("slipId");

        if (slipIdParam == null || slipIdParam.trim().isEmpty()) {
            response.sendRedirect("borrowSlip?action=create");
            return;
        }

        try {
            int slipId = Integer.parseInt(slipIdParam);
            BorrowSlip borrowSlip = borrowSlipDAO.getBorrowSlipDetail(slipId);

            if (borrowSlip != null) {
                request.setAttribute("borrowSlip", borrowSlip);
                request.getRequestDispatcher("gdBorrowSlipDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("borrowSlip?action=create&error=notfound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("borrowSlip?action=create&error=invalid");
        }
    }
}
