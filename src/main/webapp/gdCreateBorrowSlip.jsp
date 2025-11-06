<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>LibMan System - Tạo Phiếu Mượn</title>
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

        .container {
            max-width: 1600px;
            width: 95%;
            margin: 0 auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            padding: 50px 60px;
            animation: fadeIn 0.5s ease;
        }

        h1 { color: #333; font-size: 32px; margin-bottom: 10px; padding-bottom: 20px; border-bottom: 3px solid #667eea; display: flex; align-items: center; justify-content: space-between; }
        h1::before { font-size: 36px; margin-right: 12px; }
        .section { padding: 35px; background: #f8f9fa; border-radius: 12px; border: 2px solid #e9ecef; transition: all 0.3s; }
        .section:hover { border-color: #667eea; box-shadow: 0 5px 20px rgba(102, 126, 234, 0.1); }
        .section h3 { margin: 0 0 20px 0; color: #667eea; font-size: 20px; display: flex; align-items: center; gap: 10px; padding-bottom: 15px; border-bottom: 2px solid #e9ecef; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 8px; color: #495057; font-size: 14px; }
        .form-group input { width: 100%; padding: 14px 16px; border-radius: 8px; border: 2px solid #dee2e6; font-size: 15px; transition: all 0.3s; }
        .form-group input:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1); }
        .btn { padding: 12px 24px; border: none; border-radius: 8px; cursor: pointer; font-weight: 600; font-size: 15px; transition: all 0.3s; display: inline-flex; align-items: center; gap: 8px; }
        .btn-primary { background: #667eea; color: white; }
        .btn-primary:hover { background: #5568d3; }
        .btn-danger { background: #dc3545; color: white; padding: 8px 16px; font-size: 13px; }
        .btn-danger:hover { background: #c82333; }
        .btn-back { background-color: #6c757d; color: white; text-decoration: none; margin-left: auto; }
        .btn-back:hover { background-color: #5a6268; text-decoration: none; }
        #docError, #readerError {
            margin-top: 20px;
            padding: 16px 0;
            padding-left: 20px;
            color: #dc2626;
            background: transparent;
            border: none;
            border-left: 4px solid #dc3545;
            font-weight: 500;
            font-size: 15px;
            animation: shake 0.3s ease;
        }
        fieldset { border: none; padding: 0; margin: 0; }
        fieldset:disabled { opacity: 0.6; }
        fieldset:disabled .section { background: #f1f3f5; }
        table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 20px; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        th, td { padding: 16px 20px; text-align: left; border-bottom: 1px solid #e9ecef; }
        th { background: #667eea; color: white; font-weight: 600; font-size: 14px; text-transform: uppercase; letter-spacing: 0.5px; }
        tbody tr { background: white; transition: all 0.2s; }
        tbody tr:hover { background: #f8f9fa; transform: scale(1.01); }
        tbody tr:last-child td { border-bottom: none; }
        .empty-cart { text-align: center; color: #adb5bd; padding: 40px 20px; font-style: italic; }
        #submitSlipBtn {
            width: auto;
            min-width: 250px;
            padding: 14px 28px;
            font-size: 16px;
            background: #28a745;
            box-shadow: 0 2px 8px rgba(40, 167, 69, 0.2);
        }
        #submitSlipBtn:disabled { background: #d1d5db; cursor: not-allowed; box-shadow: none; }
        #submitSlipBtn:not(:disabled):hover { background: #218838; box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3); }

        .top-row-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 50px;
            margin-top: 40px;
            margin-bottom: 40px;
        }

        #readerInfo {
            margin-top: 20px;
            padding: 20px 0;
            border-left: 4px solid #667eea;
            padding-left: 20px;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .reader-info-grid {
            display: grid;
            grid-template-columns: 130px 1fr;
            gap: 16px 20px;
            align-items: center;
        }

        .reader-info-grid strong {
            color: #495057;
            font-weight: 600;
            font-size: 14px;
        }

        .reader-info-grid span {
            color: #212529;
            font-weight: 500;
            font-size: 15px;
            padding: 6px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .status-active {
            font-weight: bold;
            color: #28a745;
            background: #d1fae5;
            padding: 3px 8px;
            border-radius: 5px;
            display: inline-block;
        }

        .status-expired {
            font-weight: bold;
            color: #dc3545;
            background: #fee2e2;
            padding: 3px 8px;
            border-radius: 5px;
            display: inline-block;
        }

        .submit-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 25px;
        }

        /* Toast Notification Styles */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .toast {
            background: #28a745;
            color: white;
            padding: 16px 24px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 300px;
            animation: slideInRight 0.3s ease, fadeOut 0.3s ease 2.7s;
            font-weight: 500;
            font-size: 15px;
        }

        .toast-success {
            background: #28a745;
        }

        .toast-error {
            background: #dc3545;
        }

        .toast-icon {
            display: none;
        }

        @keyframes slideInRight {
            from {
                transform: translateX(400px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes fadeOut {
            from {
                opacity: 1;
            }
            to {
                opacity: 0;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>
        LibMan System - Tạo Phiếu Mượn Tài Liệu
        <a href="gdMainMenu.jsp" class="btn btn-back">
            Quay lại Menu
        </a>
    </h1>

    <div class="toast-container" id="toastContainer"></div>
    <div class="top-row-grid">
        <div class="section">
            <h3>1. Thông tin Độc giả</h3>
            <form id="readerForm" action="reader" method="GET">
                <input type="hidden" name="action" value="checkReader">
                <div class="form-group">
                    <label for="readerCodeInput">Mã Độc Giả (VD: 'DGR_12345')</label>
                    <input type="text" id="readerCodeInput" name="readerCode"
                           value="${sessionScope.currentReader != null ? sessionScope.currentReader.readerCode : (param.action == 'checkReader' ? param.readerCode : '')}"
                           placeholder="Quét mã thẻ độc giả hoặc nhập thủ công...">
                </div>
                <button type="submit" id="checkReaderBtn" class="btn btn-primary">
                    ${sessionScope.currentReader != null ? 'Kiểm tra lại' : 'Kiểm tra'}
                </button>
            </form>

            <c:if test="${param.action == 'checkReader' && success == false}">
                <div id="readerError" style="display:block;">${errorMessage}</div>
            </c:if>

            <c:if test="${sessionScope.currentReader != null}">
                <div id="readerInfo" style="display:block;">
                    <div class="reader-info-grid">
                        <strong>Mã Độc Giả:</strong>
                        <span>${sessionScope.currentReader.readerCode}</span>

                        <strong>Tên tài khoản:</strong>
                        <span>${sessionScope.currentReader.username}</span>

                        <strong>Email:</strong>
                        <span>${sessionScope.currentReader.email}</span>

                        <strong>Điện thoại:</strong>
                        <span>${sessionScope.currentReader.phone}</span>
                    </div>
                </div>
            </c:if>

            <c:if test="${param.action != 'checkReader' || success != false}">
                <div id="readerError" style="display:none;"></div>
            </c:if>
            <c:if test="${sessionScope.currentReader == null}">
                <div id="readerInfo" style="display:none;"></div>
            </c:if>
        </div>

        <fieldset id="doc-fieldset" ${sessionScope.currentReader != null ? '' : 'disabled'}>
            <div class="section">
                <h3>2. Thêm Tài Liệu</h3>
                <form id="documentForm" action="documentCopy" method="GET">
                    <input type="hidden" name="action" value="checkExistDocumentCopy">

                    <div class="form-group">
                        <label for="documentCodeInput">Mã Tài Liệu (VD: 'DOC-1-1', 'DOC-1-2')</label>
                        <input type="text" id="documentCodeInput" name="documentCode"
                               placeholder="Quét mã vạch sách hoặc nhập thủ công...">
                    </div>
                    <button type="submit" id="addDocBtn" class="btn btn-primary">Thêm</button>
                </form>

                <c:if test="${param.action == 'checkExistDocumentCopy' && success == false}">
                    <div id="docError" style="display:block;">${errorMessage}</div>
                </c:if>

                <c:if test="${param.action != 'checkExistDocumentCopy' || success != false}">
                    <div id="docError" style="display:none;"></div>
                </c:if>
            </div>
        </fieldset>
    </div>

    <div class="section">
        <h3>3. Danh sách tài liệu mượn</h3>
        <table>
            <thead>
            <tr>
                <th>Mã Sách</th>
                <th>Tên Sách</th>
                <th style="width: 100px; text-align: center;">Hành động</th>
            </tr>
            </thead>
            <tbody id="cartBody">
            <tr>
                <td colspan="3" class="empty-cart">Chưa có tài liệu nào</td>
            </tr>
            </tbody>
        </table>

        <div class="submit-container">
            <button id="submitSlipBtn" class="btn btn-primary" ${sessionScope.currentReader != null ? '' : 'disabled'}>Tạo phiếu mượn</button>
        </div>
    </div>

    <!-- Hidden form for submitting borrow slip -->
    <form id="submitSlipForm" action="borrowSlip" method="POST" style="display: none;">
        <input type="hidden" name="action" value="createBorrowSlip">
        <input type="hidden" name="readerId" id="hiddenReaderId">
        <input type="hidden" name="copyIds" id="hiddenCopyIds">
    </form>
</div>

<script>
    // Khai báo các biến global
    let currentReaderId = ${sessionScope.currentReader != null ? sessionScope.currentReader.id : 'null'};
    let borrowCart = [];

    // LOGIC CỦA GIAO DIỆN ---
    document.addEventListener('DOMContentLoaded', () => {

        // Lấy các phần tử DOM
        const readerCodeInput = document.getElementById('readerCodeInput');
        const readerForm = document.getElementById('readerForm');
        const docFieldset = document.getElementById('doc-fieldset');
        const documentCodeInput = document.getElementById('documentCodeInput');
        const documentForm = document.getElementById('documentForm');
        const addDocBtn = document.getElementById('addDocBtn');
        const docErrorDiv = document.getElementById('docError');
        const cartBody = document.getElementById('cartBody');
        const submitSlipBtn = document.getElementById('submitSlipBtn');
        const toastContainer = document.getElementById('toastContainer');
        const submitSlipForm = document.getElementById('submitSlipForm');
        const hiddenReaderId = document.getElementById('hiddenReaderId');
        const hiddenCopyIds = document.getElementById('hiddenCopyIds');

        const savedCart = sessionStorage.getItem('borrowCart');
        if (savedCart) {
            borrowCart = JSON.parse(savedCart);
            updateCartTable();
        }

        function showToast(message, type = 'success') {
            const toast = document.createElement('div');
            toast.className = `toast toast-\${type}`;
            const text = document.createElement('span');
            text.textContent = message;
            toast.appendChild(text);
            toastContainer.appendChild(toast);
            setTimeout(() => {
                toast.remove();
            }, 3000);
        }

        readerCodeInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                readerForm.submit();
            }
        });

        if (currentReaderId) {
            documentCodeInput.focus();
        }

        documentCodeInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                handleAddDocument();
            }
        });

        documentForm.addEventListener('submit', (e) => {
            e.preventDefault();
            handleAddDocument();
        });

        function handleAddDocument() {
            const docCode = documentCodeInput.value.trim();
            if (!docCode) return;
            // Kiểm tra trùng lặp trong giỏ
            if (borrowCart.find(item => item.copyCode.toUpperCase() === docCode.toUpperCase())) {
                docErrorDiv.textContent = "Tài liệu này đã có trong giỏ!";
                docErrorDiv.style.display = 'block';
                documentCodeInput.value = '';
                return;
            }

            // Lưu giỏ hàng và submit form
            sessionStorage.setItem('borrowCart', JSON.stringify(borrowCart));
            documentForm.submit();
        }

        // Xử lý khi thêm tài liệu thành công từ server
        <c:if test="${param.action == 'checkExistDocumentCopy' && success == true && documentCopy != null}">
            // Thêm vào giỏ hàng
            const newItem = {
                copyId: ${documentCopy.id},
                copyCode: "${documentCopy.documentCode}",
                bookName: "${documentCopy.bookName}".replace(/&#034;/g, '"')
            };

            borrowCart.push(newItem);
            sessionStorage.setItem('borrowCart', JSON.stringify(borrowCart));
            updateCartTable();

            // Hiển thị thông báo thành công
            showToast("Đã thêm: " + newItem.bookName);

            // Focus lại vào ô nhập
            documentCodeInput.focus();
        </c:if>

        // --- CÁC HÀM TIỆN ÍCH ---
        function updateCartTable() {
            cartBody.innerHTML = '';
            if (borrowCart.length === 0) {
                cartBody.innerHTML = '<tr><td colspan="3" class="empty-cart">Chưa có tài liệu nào</td></tr>';
                return;
            }
            borrowCart.forEach((item, index) => {
                const row = document.createElement('tr');

                // Tạo cell cho mã sách
                const codeCell = document.createElement('td');
                codeCell.textContent = item.copyCode;

                // Tạo cell cho tên sách
                const nameCell = document.createElement('td');
                nameCell.textContent = item.bookName;

                // Tạo cell cho nút xóa
                const actionCell = document.createElement('td');
                actionCell.style.textAlign = 'center';

                const removeBtn = document.createElement('button');
                removeBtn.className = 'btn btn-danger remove-btn';
                removeBtn.setAttribute('data-index', index);
                removeBtn.textContent = 'Xóa';
                removeBtn.type = 'button';

                actionCell.appendChild(removeBtn);

                row.appendChild(codeCell);
                row.appendChild(nameCell);
                row.appendChild(actionCell);

                cartBody.appendChild(row);
            });
        }

        cartBody.addEventListener('click', (e) => {
            if (e.target.classList.contains('remove-btn')) {
                const indexToRemove = parseInt(e.target.dataset.index, 10);
                borrowCart.splice(indexToRemove, 1);
                sessionStorage.setItem('borrowCart', JSON.stringify(borrowCart));
                updateCartTable();
            }
        });

        submitSlipBtn.addEventListener('click', () => {
            if (borrowCart.length === 0) {
                alert("Phiếu mượn đang rỗng. Vui lòng thêm tài liệu.");
                return;
            }
            if (!currentReaderId) {
                alert("Chưa xác nhận độc giả. Vui lòng quay lại Bước 1.");
                return;
            }

            const confirmCreate = confirm("Bạn có chắc chắn muốn tạo phiếu mượn không?");
            if (confirmCreate) {
                // Điền thông tin vào form ẩn
                hiddenReaderId.value = currentReaderId;
                hiddenCopyIds.value = JSON.stringify(borrowCart.map(item => item.copyId));
                submitSlipForm.submit();
            }
        });

        // Xử lý khi tạo phiếu mượn thành công
        <c:if test="${createSuccess == true && borrowSlip != null}">
            sessionStorage.removeItem('borrowCart');
            alert("${message}");
            window.location.href = "borrowSlip?action=viewDetail&slipId=${borrowSlip.id}";
        </c:if>
    });
</script>
</body>
</html>
