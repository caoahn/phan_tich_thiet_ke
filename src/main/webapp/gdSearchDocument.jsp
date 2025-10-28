<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tìm kiếm Tài liệu - LibMan</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 30px;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #333;
            margin-bottom: 40px;
            text-align: center;
            font-size: 32px;
        }
        
        .search-form {
            display: flex;
            gap: 15px;
            margin-bottom: 40px;
            justify-content: center;
        }
        
        .search-input {
            flex: 1;
            max-width: 600px;
            padding: 15px 20px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        
        .search-input:focus {
            outline: none;
            border-color: #4CAF50;
        }
        
        .btn-search {
            padding: 15px 35px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        
        .btn-search:hover {
            background-color: #45a049;
        }
        
        .result-info {
            margin-bottom: 25px;
            padding: 15px 20px;
            background-color: #e7f3fe;
            border-left: 4px solid #2196F3;
            border-radius: 4px;
        }
        
        .document-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }
        
        .document-table th,
        .document-table td {
            padding: 18px 20px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .document-table th {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
        }
        
        .document-table tr:hover {
            background-color: #f5f5f5;
        }
        
        .document-table tr {
            cursor: pointer;
        }
        
        .no-result {
            text-align: center;
            padding: 60px;
            color: #666;
            font-size: 18px;
        }
        
        .link-detail {
            color: #2196F3;
            text-decoration: none;
            font-weight: bold;
        }
        
        .link-detail:hover {
            text-decoration: underline;
        }
        
        .btn-back {
            display: inline-block;
            padding: 12px 25px;
            background-color: #f44336;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 25px;
        }
        
        .btn-back:hover {
            background-color: #da190b;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔍 Tìm kiếm Tài liệu</h1>
        
        <!-- Form tìm kiếm -->
        <form action="document" method="get" class="search-form">
            <input type="hidden" name="action" value="search">
            <input type="text" 
                   name="keyword" 
                   class="search-input" 
                   placeholder="Nhập tên tài liệu cần tìm..."
                   value="${keyword}"
                   autofocus>
            <button type="submit" class="btn-search">Tìm kiếm</button>
        </form>
        
        <!-- Thông tin kết quả -->
        <c:if test="${searchPerformed}">
            <div class="result-info">
                <strong>Từ khóa:</strong> "${keyword}" - 
                <strong>Tìm thấy:</strong> ${documentList.size()} tài liệu
            </div>
        </c:if>
        
        <!-- Bảng kết quả -->
        <c:choose>
            <c:when test="${not empty documentList}">
                <table class="document-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên tài liệu</th>
                            <th>Tác giả</th>
                            <th>Năm xuất bản</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${documentList}" var="doc">
                            <tr onclick="window.location='document?action=detail&id=${doc.id}'">
                                <td>${doc.id}</td>
                                <td><strong>${doc.name}</strong></td>
                                <td>${doc.author}</td>
                                <td>${doc.publishedYear}</td>
                                <td>
                                    <a href="document?action=detail&id=${doc.id}" 
                                       class="link-detail"
                                       onclick="event.stopPropagation()">
                                        Xem chi tiết
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-result">
                    <p>😔 Không tìm thấy tài liệu nào!</p>
                    <c:if test="${searchPerformed}">
                        <p>Vui lòng thử từ khóa khác.</p>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
        
        <!-- Menu chính -->
        <a href="gdMainMenu.jsp" class="btn-back">Quay lại Menu</a>
    </div>
</body>
</html>