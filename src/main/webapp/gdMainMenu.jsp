<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>LibMan - Hệ thống Quản lý Thư viện</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            width: 100%;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.3);
        }

        /* Header Section */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .header-left h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 5px;
        }

        .subtitle {
            color: #666;
            font-size: 16px;
        }

        .header-right {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
        }

        .user-name {
            color: #333;
            font-weight: 600;
            font-size: 16px;
        }

        .user-role {
            color: #999;
            font-size: 13px;
        }

        .logout-btn {
            background: #ff4757;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .logout-btn:hover {
            background: #e84118;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 71, 87, 0.3);
        }

        /* Welcome Box */
        .welcome-box {
            background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
            border-left: 5px solid #667eea;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .welcome-box h3 {
            color: #667eea;
            margin-bottom: 10px;
            font-size: 20px;
        }

        .user-info {
            color: #555;
            font-size: 15px;
            line-height: 1.6;
        }

        /* Menu Grid */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .menu-item {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 20px;
            border-radius: 15px;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
        }

        .menu-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            transition: all 0.3s;
        }

        .menu-item:hover::before {
            left: 100%;
        }

        .menu-item:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.5);
        }

        .menu-item .icon {
            font-size: 52px;
            margin-bottom: 15px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }

        .menu-item .title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .menu-item .description {
            font-size: 13px;
            opacity: 0.95;
            line-height: 1.4;
        }

        /* Disabled menu item */
        .menu-item.disabled {
            background: linear-gradient(135deg, #95a5a6 0%, #7f8c8d 100%);
            cursor: not-allowed;
            opacity: 0.6;
        }

        .menu-item.disabled:hover {
            transform: none;
            box-shadow: 0 5px 20px rgba(149, 165, 166, 0.3);
        }

        /* Stats Section */
        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            border: 2px solid #e9ecef;
        }

        .stat-card .stat-number {
            font-size: 28px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }

        .stat-card .stat-label {
            font-size: 13px;
            color: #666;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 25px;
            }

            .header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }

            .header-right {
                flex-direction: column;
            }

            .menu-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Header với thông tin user và nút logout -->
    <div class="header">
        <div class="header-left">
            <h1>📚 LibMan System</h1>
            <p class="subtitle">Hệ thống Quản lý Thư viện Đại học</p>
        </div>
        <div class="header-right">
            <div class="user-avatar">
                ${sessionScope.username != null ? sessionScope.member.username.substring(0,1).toUpperCase() : 'U'}
            </div>
            <div>
                <div class="user-name">${sessionScope.member.username != null ? sessionScope.member.username : 'Guest'}</div>
                <div class="user-role">${sessionScope.member.role != null ? sessionScope.member.role : 'Khách'}</div>
            </div>
            <a href="auth?action=logout" class="logout-btn">
                🚪 Đăng xuất
            </a>
        </div>
    </div>

    <!-- Welcome Box -->
    <div class="welcome-box">
        <h3>👋 Xin chào, ${sessionScope.member.username != null ? sessionScope.member.username : 'Bạn đọc'}!</h3>
        <p class="user-info">
            Chào mừng bạn đến với hệ thống quản lý thư viện.
            Hệ thống cung cấp các dịch vụ tra cứu, mượn trả tài liệu và quản lý thông tin bạn đọc.
            Vui lòng chọn chức năng bên dưới để tiếp tục.
        </p>
    </div>

    <!-- Menu Grid -->
    <div class="menu-grid">
        <!-- Tìm kiếm tài liệu -->
        <a href="document?action=list" class="menu-item">
            <div class="icon">🔍</div>
            <div class="title">Tìm kiếm Tài liệu</div>
            <div class="description">Tìm kiếm và xem thông tin tài liệu trong thư viện</div>
        </a>

        <!-- Mượn tài liệu -->
        <a href="borrow?action=create" class="menu-item">
            <div class="icon">📖</div>
            <div class="title">Mượn Tài liệu</div>
            <div class="description">Đăng ký mượn tài liệu trực tuyến</div>
        </a>
    </div>
</div>

<script>
    // Hiển thị thông báo nếu có
    <% if(request.getParameter("message") != null) { %>
    alert('<%= request.getParameter("message") %>');
    <% } %>

</script>
</body>
</html>