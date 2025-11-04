/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;
import dao.DocumentCopyDAO;
import model.Document;
import dao.DocumentDAO;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet xử lý các request liên quan đến Document
 */
@WebServlet(name = "DocumentServlet", urlPatterns = {"/document"})
public class DocumentServlet extends HttpServlet {
    
    private DocumentDAO documentDAO;
    private DocumentCopyDAO documentCopyDAO;
    
    @Override
    public void init() throws ServletException {
        // Khởi tạo DAO khi servlet được tạo
        documentDAO = new DocumentDAO();
        documentCopyDAO = new DocumentCopyDAO();
    }
    
    /**
     * Xử lý GET request
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding để hỗ trợ tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // Lấy action từ request
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "search":
                searchDocument(request, response);
                break;
            case "detail":
                viewDetail(request, response);
                break;
            case "list":
            default:
                listAllDocuments(request, response);
                break;
        }
    }
    
    /**
     * Tìm kiếm tài liệu
     */
    private void searchDocument(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy từ khóa tìm kiếm
        String keyword = request.getParameter("keyword");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            // Nếu không có từ khóa, hiển thị tất cả
            listAllDocuments(request, response);
            return;
        }
        
        // Gọi DAO để tìm kiếm
        List<Document> documentList = documentDAO.getListDocument(keyword);
        
        // Đưa dữ liệu vào request
        request.setAttribute("documentList", documentList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("searchPerformed", true);
        
        // Forward đến trang JSP
        request.getRequestDispatcher("gdSearchDocument.jsp").forward(request, response);
    }
    
    /**
     * Xem chi tiết tài liệu
     */
    private void viewDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy ID tài liệu
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("document?action=list");
            return;
        }
        
        try {
            int documentId = Integer.parseInt(idParam);

            // Lấy thông tin tài liệu (đã bao gồm danh sách bản sao)
            Document document = documentDAO.getDetailDocument(documentId);

            request.setAttribute("document", document);
            request.setAttribute("copies", document.getCopies());

            request.getRequestDispatcher("gdDetailDocument.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("document?action=list&error=invalid");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("document?action=list&error=system");
        }
    }
    
    /**
     * Hiển thị tất cả tài liệu
     */
    private void listAllDocuments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy tất cả tài liệu
        List<Document> documentList = documentDAO.getAllDocuments();
        
        // Đưa dữ liệu vào request
        request.setAttribute("documentList", documentList);
        
        // Forward đến trang JSP
        request.getRequestDispatcher("gdSearchDocument.jsp").forward(request, response);
    }
    
    @Override
    public void destroy() {
        // Đóng kết nối khi servlet bị hủy
        if (documentDAO != null) {
            documentDAO.closeConnection();
        }
    }
}