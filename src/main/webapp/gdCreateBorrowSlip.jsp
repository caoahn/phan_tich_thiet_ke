<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        #docError, #readerError { margin-top: 15px; padding: 12px 16px; color: #dc2626; background: #fee2e2; border: 2px solid #ef4444; border-radius: 8px; font-weight: 600; animation: shake 0.3s ease; }
        fieldset { border: 2px dashed #dee2e6; border-radius: 12px; padding: 0; margin: 0; }
        fieldset:disabled { opacity: 0.6; background: #f8f9fa; }
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
            padding: 20px;
            background: #e6f7ff;
            border: 2px solid #096dd9;
            border-radius: 10px;
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
            grid-template-columns: 140px 1fr;
            gap: 12px;
            align-items: center;
        }

        .reader-info-grid strong {
            color: #096dd9;
            font-weight: 600;
        }

        .reader-info-grid span {
            color: #333;
            font-weight: 500;
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

    <div class="top-row-grid">
        <div class="section">
            <h3>1. Thông tin Độc giả</h3>
            <div class="form-group">
                <label for="readerCodeInput">Mã Độc Giả (VD: 'DGR_12345')</label>
                <input type="text" id="readerCodeInput" placeholder="Quét mã thẻ độc giả hoặc nhập thủ công...">
            </div>
            <button id="checkReaderBtn" class="btn btn-primary">Kiểm tra</button>
            <div id="readerError" style="display:none;"></div>
            <div id="readerInfo" style="display:none;"></div>
        </div>

        <fieldset id="doc-fieldset" disabled>
            <div class="section">
                <h3>2. Thêm Tài Liệu</h3>
                <div class="form-group">
                    <label for="documentCodeInput">Mã Tài Liệu (VD: 'DOC-1-1', 'DOC-1-2')</label>
                    <input type="text" id="documentCodeInput" placeholder="Quét mã vạch sách hoặc nhập thủ công...">
                </div>
                <button id="addDocBtn" class="btn btn-primary">+ Thêm vào giỏ</button>
                <div id="docError" style="display:none;"></div>
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
            <button id="submitSlipBtn" class="btn btn-primary" disabled>In Phiếu</button>
        </div>
    </div>
</div>

<%--<script>--%>
<%--    // Biến lưu trữ trạng thái của phiên mượn--%>
<%--    let currentReaderId = null;--%>
<%--    let borrowCart = []; // Mảng lưu các đối tượng { copyId, code, name }--%>

<%--    // --- MÔ PHỎNG BACKEND (HARD CODE) -----%>
<%--    // Dữ liệu đã được cập nhật để khớp với Database của bạn--%>

<%--    /**--%>
<%--     * Mô phỏng việc kiểm tra mã độc giả.--%>
<%--     * Sẽ trả về dữ liệu dựa trên schema (reader, member, library_card)--%>
<%--     */--%>
<%--    function fakeCheckReader(readerCode) {--%>
<%--        return new Promise((resolve, reject) => {--%>
<%--            setTimeout(() => {--%>
<%--                // Mã này khớp với ví dụ "DGR_12345" bạn từng đưa ra--%>
<%--                if (readerCode.toUpperCase() === 'DGR_12345') {--%>
<%--                    resolve({--%>
<%--                        success: true,--%>
<%--                        readerId: 45, // Từ bảng reader--%>
<%--                        readerCode: 'DGR_12345',--%>
<%--                        username: 'nguyenvana', // Từ bảng member--%>
<%--                        email: 'vana@example.com', // Từ bảng member--%>
<%--                        phone: '0987654321', // Từ bảng member--%>
<%--                        cardStatus: 'active', // Từ bảng library_card--%>
<%--                        cardExpiry: '2026-10-28' // Từ bảng library_card--%>
<%--                    });--%>
<%--                } else {--%>
<%--                    resolve({ success: false, error: "Thẻ không hợp lệ hoặc đã hết hạn!" });--%>
<%--                }--%>
<%--            }, 500);--%>
<%--        });--%>
<%--    }--%>

<%--    /**--%>
<%--     * Mô phỏng việc kiểm tra mã tài liệu.--%>
<%--     * Dữ liệu khớp với bảng document_copy bạn đã cung cấp--%>
<%--     */--%>
<%--    function fakeCheckDocument(docCode) {--%>
<%--        return new Promise((resolve, reject) => {--%>
<%--            docCode = docCode.toUpperCase();--%>

<%--            // Dữ liệu mẫu từ DB của bạn--%>
<%--            const copyDatabase = {--%>
<%--                'DOC-1-1': { success: true, copyId: 1, copyCode: 'DOC-1-1', bookName: 'Clean Code: A Handbook of Agile Software Craftsmanship', status: 'available' },--%>
<%--                'DOC-1-2': { success: false, error: "Sách này đã được mượn! (Mã: DOC-1-2)", status: 'borrowed' },--%>
<%--                'DOC-2-1': { success: true, copyId: 4, copyCode: 'DOC-2-1', bookName: 'Design Patterns: Elements of Reusable Object-Oriented Software', status: 'available' },--%>
<%--                'DOC-2-3': { success: false, error: "Sách này bị hỏng, không thể mượn. (Mã: DOC-2-3)", status: 'damaged' },--%>
<%--                'DOC-7-2': { success: false, error: "Sách này đã bị báo mất. (Mã: DOC-7-2)", status: 'lost' },--%>
<%--                'DOC-14-3': { success: false, error: "Sách này đã được mượn! (Mã: DOC-14-3)", status: 'borrowed' }--%>
<%--            };--%>

<%--            setTimeout(() => {--%>
<%--                const result = copyDatabase[docCode];--%>
<%--                if (result) {--%>
<%--                    resolve(result);--%>
<%--                } else {--%>
<%--                    resolve({ success: false, error: `Không tìm thấy tài liệu với mã '${docCode}'.`, status: "notfound" });--%>
<%--                }--%>
<%--            }, 500);--%>
<%--        });--%>
<%--    }--%>

<%--    // Hàm fakeSubmitSlip giữ nguyên như cũ--%>
<%--    function fakeSubmitSlip(readerId, cart) {--%>
<%--        return new Promise((resolve, reject) => {--%>
<%--            setTimeout(() => {--%>
<%--                console.log("ĐANG GỬI LÊN SERVER:", { readerId, cart });--%>
<%--                resolve({ success: true, slipId: 101 });--%>
<%--            }, 1000);--%>
<%--        });--%>
<%--    }--%>

<%--    // --- LOGIC CỦA GIAO DIỆN -----%>
<%--    document.addEventListener('DOMContentLoaded', () => {--%>

<%--        // Lấy các phần tử DOM--%>
<%--        const readerCodeInput = document.getElementById('readerCodeInput');--%>
<%--        const checkReaderBtn = document.getElementById('checkReaderBtn');--%>
<%--        const readerInfoDiv = document.getElementById('readerInfo');--%>
<%--        const readerErrorDiv = document.getElementById('readerError');--%>
<%--        const docFieldset = document.getElementById('doc-fieldset');--%>
<%--        const documentCodeInput = document.getElementById('documentCodeInput');--%>
<%--        const addDocBtn = document.getElementById('addDocBtn');--%>
<%--        const docErrorDiv = document.getElementById('docError');--%>
<%--        const cartBody = document.getElementById('cartBody');--%>
<%--        const submitSlipBtn = document.getElementById('submitSlipBtn');--%>

<%--        // --- BƯỚC 1: XỬ LÝ KIỂM TRA ĐỘC GiẢ -----%>
<%--        checkReaderBtn.addEventListener('click', handleCheckReader);--%>
<%--        readerCodeInput.addEventListener('keypress', (e) => {--%>
<%--            if (e.key === 'Enter') handleCheckReader();--%>
<%--        });--%>

<%--        async function handleCheckReader() {--%>
<%--            const readerCode = readerCodeInput.value;--%>
<%--            if (!readerCode) return;--%>

<%--            // **THAY THẾ CHỖ NÀY BẰNG `fetch`**--%>
<%--            const data = await fakeCheckReader(readerCode);--%>

<%--            if (data.success) {--%>
<%--                currentReaderId = data.readerId;--%>

<%--                // **SỬA ĐỔI: Tạo DOM elements thay vì innerHTML để tránh lỗi encoding**--%>
<%--                readerInfoDiv.innerHTML = ''; // Xóa nội dung cũ--%>

<%--                const infoGrid = document.createElement('div');--%>
<%--                infoGrid.className = 'reader-info-grid';--%>

<%--                // Mã độc giả--%>
<%--                const lblCode = document.createElement('strong');--%>
<%--                lblCode.textContent = 'Mã Độc Giả:';--%>
<%--                const valCode = document.createElement('span');--%>
<%--                valCode.textContent = data.readerCode;--%>

<%--                // Tên tài khoản--%>
<%--                const lblUsername = document.createElement('strong');--%>
<%--                lblUsername.textContent = 'Tên tài khoản:';--%>
<%--                const valUsername = document.createElement('span');--%>
<%--                valUsername.textContent = data.username;--%>

<%--                // Email--%>
<%--                const lblEmail = document.createElement('strong');--%>
<%--                lblEmail.textContent = 'Email:';--%>
<%--                const valEmail = document.createElement('span');--%>
<%--                valEmail.textContent = data.email;--%>

<%--                // Điện thoại--%>
<%--                const lblPhone = document.createElement('strong');--%>
<%--                lblPhone.textContent = 'Điện thoại:';--%>
<%--                const valPhone = document.createElement('span');--%>
<%--                valPhone.textContent = data.phone;--%>

<%--                // Trạng thái thẻ--%>
<%--                const lblStatus = document.createElement('strong');--%>
<%--                lblStatus.textContent = 'Trạng thái thẻ:';--%>
<%--                const valStatus = document.createElement('span');--%>
<%--                valStatus.className = (data.cardStatus === 'active') ? 'status-active' : 'status-expired';--%>
<%--                valStatus.textContent = data.cardStatus.toUpperCase();--%>

<%--                // Hạn thẻ--%>
<%--                const lblExpiry = document.createElement('strong');--%>
<%--                lblExpiry.textContent = 'Hạn thẻ:';--%>
<%--                const valExpiry = document.createElement('span');--%>
<%--                valExpiry.textContent = new Date(data.cardExpiry).toLocaleDateString('vi-VN');--%>

<%--                // Thêm tất cả vào grid--%>
<%--                infoGrid.appendChild(lblCode);--%>
<%--                infoGrid.appendChild(valCode);--%>
<%--                infoGrid.appendChild(lblUsername);--%>
<%--                infoGrid.appendChild(valUsername);--%>
<%--                infoGrid.appendChild(lblEmail);--%>
<%--                infoGrid.appendChild(valEmail);--%>
<%--                infoGrid.appendChild(lblPhone);--%>
<%--                infoGrid.appendChild(valPhone);--%>
<%--                infoGrid.appendChild(lblStatus);--%>
<%--                infoGrid.appendChild(valStatus);--%>
<%--                infoGrid.appendChild(lblExpiry);--%>
<%--                infoGrid.appendChild(valExpiry);--%>

<%--                readerInfoDiv.appendChild(infoGrid);--%>
<%--                readerInfoDiv.style.display = 'block';--%>
<%--                readerErrorDiv.style.display = 'none';--%>

<%--                // Kích hoạt bước 2 và 3--%>
<%--                docFieldset.disabled = false;--%>
<%--                submitSlipBtn.disabled = false;--%>
<%--                documentCodeInput.focus();--%>
<%--            } else {--%>
<%--                currentReaderId = null;--%>
<%--                readerInfoDiv.style.display = 'none';--%>
<%--                readerErrorDiv.textContent = data.error;--%>
<%--                readerErrorDiv.style.display = 'block';--%>

<%--                // Vô hiệu hóa bước 2 và 3--%>
<%--                docFieldset.disabled = true;--%>
<%--                submitSlipBtn.disabled = true;--%>
<%--            }--%>
<%--        }--%>

<%--        // --- BƯỚC 2: XỬ LÝ THÊM TÀI LIỆU -----%>
<%--        addDocBtn.addEventListener('click', handleAddDocument);--%>
<%--        documentCodeInput.addEventListener('keypress', (e) => {--%>
<%--            if (e.key === 'Enter') handleAddDocument();--%>
<%--        });--%>

<%--        async function handleAddDocument() {--%>
<%--            const docCode = documentCodeInput.value;--%>
<%--            if (!docCode) return;--%>

<%--            // Kiểm tra trùng lặp trong giỏ--%>
<%--            if (borrowCart.find(item => item.copyCode.toUpperCase() === docCode.toUpperCase())) {--%>
<%--                docErrorDiv.textContent = "Tài liệu này đã có trong giỏ!";--%>
<%--                docErrorDiv.style.display = 'block';--%>
<%--                documentCodeInput.value = '';--%>
<%--                return;--%>
<%--            }--%>

<%--            // **THAY THẾ CHỖ NÀY BẰNG `fetch`**--%>
<%--            const data = await fakeCheckDocument(docCode);--%>

<%--            if (data.success && data.status === 'available') {--%>
<%--                borrowCart.push({--%>
<%--                    copyId: data.copyId,--%>
<%--                    copyCode: data.copyCode,--%>
<%--                    bookName: data.bookName--%>
<%--                });--%>

<%--                updateCartTable();--%>
<%--                docErrorDiv.style.display = 'none';--%>
<%--                documentCodeInput.value = '';--%>
<%--                documentCodeInput.focus();--%>
<%--            } else {--%>
<%--                docErrorDiv.textContent = data.error;--%>
<%--                docErrorDiv.style.display = 'block';--%>
<%--            }--%>
<%--        }--%>

<%--        // --- CÁC HÀM TIỆN ÍCH (Giữ nguyên) -----%>

<%--        function updateCartTable() {--%>
<%--            cartBody.innerHTML = '';--%>
<%--            if (borrowCart.length === 0) {--%>
<%--                cartBody.innerHTML = '<tr><td colspan="3" class="empty-cart">📭 Chưa có tài liệu nào</td></tr>';--%>
<%--                return;--%>
<%--            }--%>
<%--            borrowCart.forEach((item, index) => {--%>
<%--                const row = document.createElement('tr');--%>

<%--                // Tạo cell cho mã sách--%>
<%--                const codeCell = document.createElement('td');--%>
<%--                codeCell.textContent = item.copyCode;--%>

<%--                // Tạo cell cho tên sách--%>
<%--                const nameCell = document.createElement('td');--%>
<%--                nameCell.textContent = item.bookName;--%>

<%--                // Tạo cell cho nút xóa--%>
<%--                const actionCell = document.createElement('td');--%>
<%--                actionCell.style.textAlign = 'center';--%>

<%--                const removeBtn = document.createElement('button');--%>
<%--                removeBtn.className = 'btn btn-danger remove-btn';--%>
<%--                removeBtn.setAttribute('data-index', index);--%>
<%--                removeBtn.textContent = 'Xóa';--%>

<%--                actionCell.appendChild(removeBtn);--%>

<%--                row.appendChild(codeCell);--%>
<%--                row.appendChild(nameCell);--%>
<%--                row.appendChild(actionCell);--%>

<%--                cartBody.appendChild(row);--%>
<%--            });--%>
<%--        }--%>

<%--        cartBody.addEventListener('click', (e) => {--%>
<%--            if (e.target.classList.contains('remove-btn')) {--%>
<%--                const indexToRemove = parseInt(e.target.dataset.index, 10);--%>
<%--                borrowCart.splice(indexToRemove, 1);--%>
<%--                updateCartTable();--%>
<%--            }--%>
<%--        });--%>

<%--        submitSlipBtn.addEventListener('click', handleSubmitSlip);--%>

<%--        async function handleSubmitSlip() {--%>
<%--            if (borrowCart.length === 0) {--%>
<%--                alert("Giỏ mượn đang rỗng. Vui lòng thêm tài liệu.");--%>
<%--                return;--%>
<%--            }--%>
<%--            if (!currentReaderId) {--%>
<%--                alert("Chưa xác nhận độc giả. Vui lòng quay lại Bước 1.");--%>
<%--                return;--%>
<%--            }--%>

<%--            const copyIds = borrowCart.map(item => item.copyId);--%>

<%--            // **THAY THẾ CHỖ NÀY BẰNG `fetch` POST**--%>
<%--            const data = await fakeSubmitSlip(currentReaderId, borrowCart);--%>

<%--            if (data.success) {--%>
<%--                alert(`Tạo phiếu mượn #${data.slipId} thành công!`);--%>
<%--                // window.open(`printServlet?slipId=${data.slipId}`, '_blank');--%>
<%--                resetForm();--%>
<%--            } else {--%>
<%--                alert("Lỗi: " + data.error);--%>
<%--            }--%>
<%--        }--%>

<%--        function resetForm() {--%>
<%--            currentReaderId = null;--%>
<%--            borrowCart = [];--%>
<%--            updateCartTable();--%>
<%--            readerCodeInput.value = '';--%>
<%--            readerInfoDiv.style.display = 'none';--%>
<%--            readerErrorDiv.style.display = 'none';--%>
<%--            documentCodeInput.value = '';--%>
<%--            docErrorDiv.style.display = 'none';--%>
<%--            docFieldset.disabled = true;--%>
<%--            submitSlipBtn.disabled = true;--%>
<%--        }--%>

<%--    });--%>
<%--</script>--%>
</body>
</html>
