<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.BorrowSlip" %>
<%@ page import="model.BorrowSlipDetail" %>
<%@ page import="model.Reader" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>LibMan System - Chi Tiết Phiếu Mượn</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #e9ecef;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .container {
            max-width: 900px;
            width: 100%;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            padding: 40px 50px;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .main-title {
            text-align: center;
            color: #333;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 3px solid #667eea;
        }

        .header {
            text-align: center;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e9ecef;
        }

        .header h1 {
            color: #667eea;
            font-size: 24px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .header .slip-id {
            color: #495057;
            font-size: 16px;
            font-weight: 600;
        }

        .section {
            margin-bottom: 25px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .section h2 {
            color: #667eea;
            font-size: 18px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 160px 1fr;
            gap: 12px 15px;
            align-items: center;
        }

        .info-grid strong {
            color: #495057;
            font-weight: 600;
            font-size: 14px;
        }

        .info-grid span {
            color: #212529;
            font-size: 14px;
            padding: 6px 10px;
            background: white;
            border-radius: 6px;
            border: 1px solid #e9ecef;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 14px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-borrowing {
            background: #d1f2eb;
            color: #0a6847;
        }

        .status-returned {
            background: #d4edda;
            color: #155724;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 15px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        th {
            background: #667eea;
            color: white;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tbody tr {
            background: white;
            transition: all 0.2s;
        }

        tbody tr:hover {
            background: #f8f9fa;
            transform: scale(1.01);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .stt-column {
            width: 80px;
            text-align: center;
            font-weight: 600;
            color: #667eea;
        }

        .actions {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 2px solid #e9ecef;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            text-decoration: none;
        }

        .btn-primary {
            background: #667eea;
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            flex: 1;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
        }

        .btn-success {
            background: #28a745;
            color: white;
            flex: 1;
        }

        .btn-success:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }

        .empty-list {
            text-align: center;
            color: #adb5bd;
            padding: 30px 20px;
            font-style: italic;
        }

        @media print {
            body {
                background: white;
                padding: 0;
            }

            .container {
                box-shadow: none;
                padding: 20px;
            }

            .actions {
                display: none;
            }
        }
    </style>
</head>
<body>
    <%
        BorrowSlip borrowSlip = (BorrowSlip) request.getAttribute("borrowSlip");
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

        if (borrowSlip == null) {
    %>
        <div class="container">
            <div class="main-title">LibMan System</div>
            <div class="header">
                <h1>Không tìm thấy phiếu mượn</h1>
            </div>
            <div class="actions">
                <a href="borrowSlip?action=create" class="btn btn-primary">Quay lại tạo phiếu mượn</a>
            </div>
        </div>
    <%
        } else {
            Reader reader = borrowSlip.getReader();
            String statusText = "";
            String statusClass = "";

            if ("borrowing".equalsIgnoreCase(borrowSlip.getStatus())) {
                statusText = "Đang mượn";
                statusClass = "status-borrowing";
            } else if ("returned".equalsIgnoreCase(borrowSlip.getStatus())) {
                statusText = "Đã trả";
                statusClass = "status-returned";
            } else {
                statusText = borrowSlip.getStatus();
                statusClass = "status-borrowing";
            }
    %>
    <div class="container">
        <div class="main-title">LibMan System</div>

        <div class="header">
            <h1>Chi Tiết Phiếu Mượn</h1>
            <div class="slip-id">Mã phiếu: #<%= borrowSlip.getId() %></div>
        </div>

        <!-- Thông tin người mượn -->
        <div class="section">
            <h2>Thông tin người mượn</h2>
            <div class="info-grid">
                <strong>Mã độc giả:</strong>
                <span><%= reader != null ? reader.getReaderCode() : "N/A" %></span>

                <strong>Tên tài khoản:</strong>
                <span><%= reader != null ? reader.getUsername() : "N/A" %></span>

                <strong>Email:</strong>
                <span><%= reader != null ? reader.getEmail() : "N/A" %></span>

                <strong>Điện thoại:</strong>
                <span><%= reader != null ? reader.getPhone() : "N/A" %></span>
            </div>
        </div>

        <!-- Thông tin phiếu mượn -->
        <div class="section">
            <h2>Thông tin phiếu mượn</h2>
            <div class="info-grid">
                <strong>Ngày mượn:</strong>
                <span><%= borrowSlip.getBorrowDate() != null ? dateFormat.format(borrowSlip.getBorrowDate()) : "N/A" %></span>

                <strong>Ngày trả dự kiến:</strong>
                <span><%= borrowSlip.getReturnDate() != null ? dateFormat.format(borrowSlip.getReturnDate()) : "N/A" %></span>

                <strong>Trạng thái:</strong>
                <span><span class="status-badge <%= statusClass %>"><%= statusText %></span></span>
            </div>
        </div>

        <!-- Danh sách tài liệu mượn -->
        <div class="section">
            <h2>Danh sách tài liệu mượn (Số lượng: <%= borrowSlip.getDetails() != null ? borrowSlip.getDetails().size() : 0 %>)</h2>
            <table>
                <thead>
                    <tr>
                        <th class="stt-column">STT</th>
                        <th>Tên Tài Liệu</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (borrowSlip.getDetails() != null && !borrowSlip.getDetails().isEmpty()) {
                            int stt = 1;
                            for (BorrowSlipDetail detail : borrowSlip.getDetails()) {
                    %>
                    <tr>
                        <td class="stt-column"><%= stt++ %></td>
                        <td><%= detail.getBookName() != null ? detail.getBookName() : "N/A" %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="2" class="empty-list">Không có tài liệu nào</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Các nút hành động -->
        <div class="actions">
            <a href="borrowSlip?action=create" class="btn btn-secondary">Tạo phiếu mới</a>
            <button id="btn-print" class="btn btn-success">In phiếu</button>
            <a href="gdMainMenu.jsp" class="btn btn-primary">Về Menu chính</a>
        </div>
    </div>
    <%
        }
    %>
</body>
<script>
   const printBtn = document.getElementById('btn-print');
   printBtn.addEventListener('click', () => {
       alert('In phiếu mượn thành công!')
   });
</script>

</html>
