<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi tiết Tài liệu - LibMan</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #333;
            margin-bottom: 10px;
            border-bottom: 3px solid #4CAF50;
            padding-bottom: 10px;
        }
        
        .document-detail {
            margin-top: 30px;
        }
        
        .detail-row {
            display: flex;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
            border-left: 4px solid #4CAF50;
            align-items: flex-start; /* Canh lề cho nội dung */
        }
        
        .detail-label {
            font-weight: bold;
            color: #555;
            min-width: 150px;
            flex-shrink: 0;
        }
        
        .detail-value {
            color: #333;
            flex: 1;
            line-height: 1.6;
        }
        
        .description-box {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-top: 10px;
            line-height: 1.8;
            /* Thêm để giữ định dạng xuống dòng từ database */
            white-space: pre-wrap; 
        }
        
        .button-group {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            display: inline-block;
            text-align: center;
        }
        
        .btn-back {
            background-color: #f44336;
            color: white;
        }
        
        .btn-back:hover {
            background-color: #da190b;
        }
        
        .btn-borrow {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-borrow:hover {
            background-color: #45a049;
        }
        
        .btn-search {
            background-color: #2196F3;
            color: white;
        }
        
        .btn-search:hover {
            background-color: #0b7dda;
        }
        
        .tag {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📚 Chi tiết Tài liệu</h1>
        
        <c:if test="${not empty document}">
            <div class="document-detail">
                <div class="detail-row">
                    <div class="detail-label">Mã tài liệu:</div>
                    <div class="detail-value">
                        <span class="tag">#${document.id}</span>
                    </div>
                </div>
                
                <div class="detail-row">
                    <div class="detail-label">Tên tài liệu:</div>
                    <div class="detail-value">
                        <strong style="font-size: 18px; color: #2196F3;">
                            ${document.name}
                        </strong>
                    </div>
                </div>
                
                <div class="detail-row">
                    <div class="detail-label">Tác giả:</div>
                    <div class="detail-value">${document.author}</div>
                </div>
                
                <div class="detail-row">
                    <div class="detail-label">Năm xuất bản:</div>
                    <div class="detail-value">${document.publishedYear}</div>
                </div>
                
                <div class="detail-row" style="display: block;"> <div class="detail-label">Mô tả chi tiết:</div>
                    <div class="description-box">
                        <c:choose>
                            <c:when test="${not empty document.description}">
                                ${document.description}
                            </c:when>
                            <c:otherwise>
                                <em style="color: #999;">Chưa có mô tả chi tiết</em>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <div class="button-group">
                <a href="document?action=search" class="btn btn-back">
                    Quay lại tìm kiếm
                </a>
<!--                <a href="document?action=list" class="btn btn-search">
                    Danh sách tài liệu
                </a>
                <button class="btn btn-borrow" onclick="alert('Chức năng mượn tài liệu sẽ được phát triển!')">
                    Mượn tài liệu này
                </button>-->
            </div>
        </c:if>
        
        <c:if test="${empty document}">
            <div style="text-align: center; padding: 40px; color: #666;">
                <h2>Không tìm thấy tài liệu</h2>
                <p style="margin-top: 10px;">Tài liệu không tồn tại hoặc đã bị xóa.</p>
                <a href="document?action=search" class="btn btn-back" style="margin-top: 20px;">
                   Quay lại tìm kiếm
                </a>
            </div>
        </c:if>
        
    </div> </body>
</html>