<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng nhập - LibMan</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #e9ecef;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .login-container {
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 520px;
        }

        .logo {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo .icon {
            font-size: 72px;
            margin-bottom: 15px;
        }

        .logo h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 8px;
        }

        .logo p {
            color: #666;
            font-size: 15px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            color: #555;
            font-weight: bold;
            margin-bottom: 10px;
            font-size: 15px;
        }

        .form-group input {
            width: 100%;
            padding: 15px 18px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-group input::placeholder {
            color: #aaa;
        }

        .error-message {
            background-color: #ffebee;
            color: #c62828;
            padding: 15px 18px;
            border-radius: 8px;
            margin-bottom: 25px;
            border-left: 4px solid #c62828;
            font-size: 14px;
        }

        .success-message {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 15px 18px;
            border-radius: 8px;
            margin-bottom: 25px;
            border-left: 4px solid #2e7d32;
            font-size: 14px;
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            font-size: 14px;
        }

        .remember-forgot label {
            display: flex;
            align-items: center;
            color: #555;
            cursor: pointer;
        }

        .remember-forgot input[type="checkbox"] {
            margin-right: 8px;
            cursor: pointer;
        }

        .remember-forgot a {
            color: #667eea;
            text-decoration: none;
        }

        .remember-forgot a:hover {
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
        }

        .divider::before {
            content: "";
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background-color: #ddd;
        }

        .divider span {
            background-color: white;
            padding: 0 15px;
            color: #999;
            position: relative;
            font-size: 14px;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
            font-size: 14px;
        }

        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .input-icon {
            position: relative;
        }

        .input-icon input {
            padding-left: 40px;
        }

        .input-icon::before {
            content: attr(data-icon);
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #999;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="logo">
        <div class="icon">📚</div>
        <h1>LibMan System</h1>
        <p>Hệ thống Quản lý Thư viện</p>
    </div>

    <!-- Hiển thị thông báo lỗi -->
    <c:if test="${not empty error}">
        <div class="error-message">
            ❌ ${error}
        </div>
    </c:if>

    <!-- Hiển thị thông báo thành công -->
    <c:if test="${not empty success}">
        <div class="success-message">
            ✅ ${success}
        </div>
    </c:if>

    <form action="auth" method="post">
        <input type="hidden" name="action" value="login">

        <div class="form-group">
            <label for="username">Tên đăng nhập</label>
                <input type="text"
                       id="username"
                       name="username"
                       placeholder="Nhập tên đăng nhập"
                       value="${username}"
                       required
                       autofocus>
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu</label>
                <input type="password"
                       id="password"
                       name="password"
                       placeholder="Nhập mật khẩu"
                       required>
        </div>

        <div class="remember-forgot">
<%--            <label>--%>
<%--                <input type="checkbox" name="remember" value="true">--%>
<%--                Ghi nhớ đăng nhập--%>
<%--            </label>--%>
            <a href="#" onclick="alert('Chức năng đang phát triển!'); return false;">
                Quên mật khẩu?
            </a>
        </div>

        <button type="submit" class="btn-login">
            Đăng nhập
        </button>
    </form>

    <div class="divider">
        <span>hoặc</span>
    </div>

    <div class="register-link">
        Chưa có tài khoản?
        <a href="auth?action=register">Đăng ký ngay</a>
    </div>
</div>
</body>
</html>