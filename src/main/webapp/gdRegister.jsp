<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>LibMan System - Đăng ký</title>
    <style>
        * {
            padding: 0;
            margin: 0;
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

        .register-container {
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
        }

        .logo {
            text-align: center;
            margin-bottom: 40px;
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

        .form-group label .required {
            color: #f44336;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 15px 18px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-group input::placeholder {
            color: #aaa;
        }

        .form-group small {
            display: block;
            color: #999;
            font-size: 12px;
            margin-top: 5px;
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

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .terms-agreement {
            margin-bottom: 30px;
        }

        .terms-agreement label {
            display: flex;
            align-items: flex-start;
            color: #555;
            font-size: 14px;
            cursor: pointer;
            font-weight: normal;
        }

        .terms-agreement input[type="checkbox"] {
            margin-right: 10px;
            margin-top: 3px;
            cursor: pointer;
            flex-shrink: 0;
        }

        .terms-agreement a {
            color: #667eea;
            text-decoration: none;
        }

        .terms-agreement a:hover {
            text-decoration: underline;
        }

        .btn-register {
            width: 100%;
            padding: 14px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
            background: #5568d3;
        }

        .btn-register:active {
            transform: translateY(0);
        }

        .btn-register:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
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

        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
            font-size: 14px;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .password-strength {
            height: 4px;
            background-color: #ddd;
            border-radius: 2px;
            margin-top: 8px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s, background-color 0.3s;
        }

        .password-strength-bar.weak {
            width: 33%;
            background-color: #f44336;
        }

        .password-strength-bar.medium {
            width: 66%;
            background-color: #ff9800;
        }

        .password-strength-bar.strong {
            width: 100%;
            background-color: #4CAF50;
        }
    </style>
    <script>
        function validatePassword() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const submitBtn = document.getElementById('submitBtn');
            const confirmInput = document.getElementById('confirmPassword');

            if (confirmPassword === '') {
                confirmInput.style.borderColor = '#ddd';
                submitBtn.disabled = false;
                return;
            }

            if (password !== confirmPassword) {
                confirmInput.style.borderColor = '#f44336';
                submitBtn.disabled = true;
            } else {
                confirmInput.style.borderColor = '#4CAF50';
                submitBtn.disabled = false;
            }
        }

        function handleSubmit(event) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                // Ngăn form submit
                event.preventDefault();
                // Có thể thêm thông báo lỗi ở đây
                document.getElementById('confirmPassword').style.borderColor = '#f44336';
                alert('Mật khẩu xác nhận không khớp. Vui lòng kiểm tra lại.');
            }
        }

        // Thêm hàm kiểm tra khi rời ô input (onblur)
        function validateConfirmOnBlur() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const confirmInput = document.getElementById('confirmPassword');

            if (confirmPassword !== '' && password !== confirmPassword) {
                confirmInput.style.borderColor = '#f44336'; // Báo lỗi
            } else if (confirmPassword !== '' && password === confirmPassword) {
                confirmInput.style.borderColor = '#4CAF50'; // Khớp
            } else {
                confirmInput.style.borderColor = '#ddd'; // Trở về mặc định
            }
        }
    </script>
</head>
<body>
<div class="register-container">
    <div class="logo">
        <h1>Đăng ký tài khoản</h1>
        <p>Hệ thống Quản lý Thư viện LibMan</p>
    </div>

    <c:if test="${not empty error}">
        <div class="error-message">
            ${error}
        </div>
    </c:if>

    <form action="auth" method="post" onsubmit="handleSubmit(event)">
        <input type="hidden" name="action" value="register">

        <div class="form-group">
            <label for="fullname">
                Họ và tên <span class="required">*</span>
            </label>
            <input type="text"
                   id="fullname"
                   name="fullname"
                   placeholder="Nhập họ và tên đầy đủ"
                   value="${fullname}"
                   required
                   autofocus>
        </div>

        <div class="form-group">
            <label for="email">
                Email <span class="required">*</span>
            </label>
            <input type="email"
                   id="email"
                   name="email"
                   placeholder="email@example.com"
                   value="${email}"
                   required>
        </div>

        <div class="form-group">
            <label for="role">
                Vai trò <span class="required">*</span>
            </label>
            <select id="role" name="role" required>
                <option value="" disabled selected>-- Chọn vai trò --</option>
                <option value="reader">Độc giả</option>
                <option value="librarian">Thủ thư</option>
                <option value="manager">Quản lý</option>
            </select>
            <small>Chọn loại tài khoản phù hợp với bạn.</small>
        </div>

        <div class="form-group">
            <label for="username">
                Tên đăng nhập <span class="required">*</span>
            </label>
            <input type="text"
                   id="username"
                   name="username"
                   placeholder="Chọn tên đăng nhập"
                   value="${username}"
                   minlength="3"
                   required>
            <small>Tối thiểu 3 ký tự, không dấu và khoảng trắng</small>
        </div>

        <div class="form-group">
            <label for="password">
                Mật khẩu <span class="required">*</span>
            </label>
            <input type="password"
                   id="password"
                   name="password"
                   placeholder="Nhập mật khẩu"
                   minlength="6"
                   oninput=" validatePassword();"
                   onblur="validateConfirmOnBlur();"
                   required>
            <small>Tối thiểu 6 ký tự, nên có chữ hoa, chữ thường và số</small>
        </div>

        <div class="form-group">
            <label for="confirmPassword">
                Xác nhận mật khẩu <span class="required">*</span>
            </label>
            <input type="password"
                   id="confirmPassword"
                   name="confirmPassword"
                   placeholder="Nhập lại mật khẩu"
                   oninput="validatePassword();"
                   onblur="validateConfirmOnBlur();"
                   required>
        </div>

        <button type="submit" id="submitBtn" class="btn-register">
            Đăng ký tài khoản
        </button>
    </form>

    <div class="divider">
        <span>hoặc</span>
    </div>

    <div class="login-link">
        Đã có tài khoản?
        <a href="auth?action=login">Đăng nhập ngay</a>
    </div>
</div>
</body>
</html>
