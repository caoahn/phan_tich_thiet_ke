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

@WebServlet(name = "DocumentServlet", urlPatterns = {"/document"})
public class DocumentServlet extends HttpServlet {
    
    private DocumentDAO documentDAO;
    private DocumentCopyDAO documentCopyDAO;
    
    @Override
    public void init() throws ServletException {
        documentDAO = new DocumentDAO();
        documentCopyDAO = new DocumentCopyDAO();
    }
    
    /**
     * Xử lý GET request
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
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
    
    private void searchDocument(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            listAllDocuments(request, response);
            return;
        }
        
        List<Document> documentList = documentDAO.getListDocument(keyword);
        
        request.setAttribute("documentList", documentList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("searchPerformed", true);
        
        // Forward đến trang JSP
        request.getRequestDispatcher("reader/gdSearchDocument.jsp").forward(request, response);
    }
    
    private void viewDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("document?action=list");
            return;
        }
        
        try {
            int documentId = Integer.parseInt(idParam);

            Document document = documentDAO.getDetailDocument(documentId);

            request.setAttribute("document", document);
            request.setAttribute("copies", document.getCopies());

            request.getRequestDispatcher("reader/gdDetailDocument.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("document?action=list&error=invalid");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("document?action=list&error=system");
        }
    }
    
    private void listAllDocuments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Document> documentList = documentDAO.getAllDocuments();
        
        request.setAttribute("documentList", documentList);
        
        request.getRequestDispatcher("reader/gdSearchDocument.jsp").forward(request, response);
    }
    
    @Override
    public void destroy() {
        if (documentDAO != null) {
            documentDAO.closeConnection();
        }
    }
}