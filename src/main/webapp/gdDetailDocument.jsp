<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>LibMan System - Chi tiết Tài liệu</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
            padding: 30px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header {
            background: #667eea;
            color: white;
            padding: 40px 50px;
        }

        .header h1 {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .header .subtitle {
            font-size: 15px;
            opacity: 0.9;
        }

        .content {
            padding: 30px 50px;
        }

        .document-detail {
            margin-bottom: 25px;
        }

        .detail-row {
            display: flex;
            margin-bottom: 12px;
            padding: 12px 18px;
            background-color: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #667eea;
            align-items: flex-start;
            transition: all 0.3s;
        }

        .detail-row:hover {
            background-color: #e9ecef;
            transform: translateX(5px);
        }

        .detail-label {
            font-weight: bold;
            color: #555;
            min-width: 150px;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .detail-value {
            color: #333;
            flex: 1;
            line-height: 1.6;
        }

        .detail-value strong {
            font-size: 18px;
            color: #667eea;
        }

        .description-box {
            background-color: #fff;
            padding: 18px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            margin-top: 10px;
            line-height: 1.8;
            white-space: pre-wrap;
            color: #555;
        }

        .tag {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        /* Thống kê bản sao */
        .stats-section {
            margin: 20px 0;
            padding: 20px;
            background: #f0f4ff;
            border-radius: 12px;
        }

        .stats-section h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .stat-card.total {
            border-top: 4px solid #6c757d;
        }

        .stat-card.available {
            border-top: 4px solid #28a745;
        }

        .stat-card.borrowed {
            border-top: 4px solid #ffc107;
        }

        .stat-card.damaged {
            border-top: 4px solid #dc3545;
        }

        .stat-card.lost {
            border-top: 4px solid #6c757d;
        }

        .stat-number {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-card.total .stat-number {
            color: #6c757d;
        }

        .stat-card.available .stat-number {
            color: #28a745;
        }

        .stat-card.borrowed .stat-number {
            color: #ffc107;
        }

        .stat-card.damaged .stat-number {
            color: #dc3545;
        }

        .stat-card.lost .stat-number {
            color: #6c757d;
        }

        .stat-label {
            font-size: 13px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
        }

        /* Bảng danh sách bản sao */
        .copies-section {
            margin: 20px 0;
        }

        .copies-section h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .copies-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .copies-table thead {
            background: #667eea;
            color: white;
        }

        .copies-table th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
        }

        .copies-table td {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
        }

        .copies-table tbody tr {
            transition: background 0.2s;
        }

        .copies-table tbody tr:hover {
            background: #f8f9fa;
        }

        .copies-table tbody tr:last-child td {
            border-bottom: none;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-available {
            background: #d4edda;
            color: #155724;
        }

        .status-borrowed {
            background: #fff3cd;
            color: #856404;
        }

        .status-damaged {
            background: #f8d7da;
            color: #721c24;
        }

        .status-lost {
            background: #d6d8db;
            color: #383d41;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .button-group {
            margin-top: 20px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            padding-top: 15px;
            border-top: 2px solid #e9ecef;
        }

        .btn {
            padding: 12px 28px;
            text-decoration: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back {
            background-color: #6c757d;
            color: white;
        }

        .btn-back:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
        }

        .btn-borrow {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
        }

        .btn-borrow:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
        }

        .btn-borrow:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-warning {
            background: #fff3cd;
            color: #856404;
            border-left: 4px solid #ffc107;
        }

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border-left: 4px solid #17a2b8;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 22px;
            }

            .content {
                padding: 20px;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .detail-row {
                flex-direction: column;
            }

            .detail-label {
                min-width: auto;
                margin-bottom: 8px;
            }

            .copies-table {
                font-size: 14px;
            }

            .copies-table th,
            .copies-table td {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <c:if test="${not empty document}">
        <!-- Header -->
        <div class="header">
            <h1>LibMan System - Chi tiết Tài liệu</h1>
            <div class="subtitle">Xem thông tin đầy đủ về tài liệu</div>
        </div>

        <div class="content">
            <!-- Thông tin cơ bản -->
            <div class="document-detail">
                <div class="detail-row">
                    <div class="detail-label">
                        Mã tài liệu:
                    </div>
                    <div class="detail-value">
                        <span class="tag">#${document.id}</span>
                    </div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">
                        Tên tài liệu:
                    </div>
                    <div class="detail-value">
                        <strong>${document.name}</strong>
                    </div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">
                        Tác giả:
                    </div>
                    <div class="detail-value">${document.author}</div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">
                        Năm xuất bản:
                    </div>
                    <div class="detail-value">${document.publishedYear}</div>
                </div>

                <div class="detail-row" style="display: block;">
                    <div class="detail-label">
                        Mô tả chi tiết:
                    </div>
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

            <!-- Danh sách bản sao chi tiết -->
            <c:if test="${not empty copies}">
                <div class="copies-section">
                    <h2> Danh sách các bản sao</h2>
                    <table class="copies-table">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>Mã bản sao</th>
                            <th>Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="copy" items="${copies}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><strong>${copy.documentCode}</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${copy.status == 'available'}">
                                            <span class="status-badge status-available"> Có sẵn</span>
                                        </c:when>
                                        <c:when test="${copy.status == 'borrowed'}">
                                            <span class="status-badge status-borrowed"> Đang mượn</span>
                                        </c:when>
                                        <c:when test="${copy.status == 'damaged'}">
                                            <span class="status-badge status-damaged"> Hỏng</span>
                                        </c:when>
                                        <c:when test="${copy.status == 'lost'}">
                                            <span class="status-badge status-lost"> Mất</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- Nút hành động -->
            <div class="button-group">
                <a href="document?action=search" class="btn btn-back">
                    Quay lại tìm kiếm
                </a>
            </div>
        </div>
    </c:if>

    <c:if test="${empty document}">
        <div class="header">
            <h1>Không tìm thấy tài liệu</h1>
        </div>
        <div class="content">
            <div class="empty-state">
                <h2>Tài liệu không tồn tại</h2>
                <p style="margin-top: 10px; margin-bottom: 20px;">
                    Tài liệu không tồn tại hoặc đã bị xóa khỏi hệ thống.
                </p>
                <a href="document?action=search" class="btn btn-back">
                    Quay lại tìm kiếm
                </a>
            </div>
        </div>
    </c:if>
</div>

</body>
</html>
