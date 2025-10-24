# TÀI LIỆU MÔ TẢ CÁC MODEL - HỆ THỐNG QUẢN LÝ THƯ VIỆN

## 📋 TỔNG QUAN

Hệ thống gồm 8 model chính với các mối quan hệ kế thừa và tham chiếu:

### Sơ đồ phân cấp kế thừa:
```
Member (Class cha)
├── Manager (Quản lý)
├── Librarian (Thủ thư)
└── Reader (Độc giả)
```

---

## 1️⃣ MEMBER (Thành viên - Lớp cha)

### 📝 Mô tả:
Lớp cha đại diện cho tất cả người dùng trong hệ thống (Quản lý, Thủ thư, Độc giả).

### 🔑 Thuộc tính:

| Tên thuộc tính | Kiểu dữ liệu | Mô tả |
|---------------|--------------|-------|
| `username` | String | Tên đăng nhập (Khóa chính) |
| `password` | String | Mật khẩu |
| `address` | String | Địa chỉ |
| `birthday` | Date | Ngày sinh |
| `email` | String | Email liên hệ |
| `phone` | String | Số điện thoại |
| `role` | String | Vai trò (manager/librarian/reader) |
| `managerId` | int | ID tham chiếu đến Manager (nếu là manager) |
| `librarianId` | int | ID tham chiếu đến Librarian (nếu là librarian) |
| `readerId` | int | ID tham chiếu đến Reader (nếu là reader) |

### 🔗 Mối quan hệ:
- **Kế thừa**: Lớp cha của Manager, Librarian, Reader
- **Tham chiếu**: Chứa các ID tham chiếu đến các lớp con tương ứng

### 💡 Lưu ý:
- Username là khóa chính (unique identifier)
- Dựa vào `role` để xác định loại người dùng
- Chỉ 1 trong 3 ID (managerId, librarianId, readerId) sẽ có giá trị, 2 ID còn lại = 0

---

## 2️⃣ MANAGER (Quản lý)

### 📝 Mô tả:
Kế thừa từ Member, đại diện cho quản lý thư viện.

### 🔑 Thuộc tính riêng:

| Tên thuộc tính | Kiểu dữ liệu | Mô tả |
|---------------|--------------|-------|
| `id` | int | ID quản lý (Khóa chính) |
| `managerCode` | String | Mã quản lý |

### 🔗 Mối quan hệ:
- **Kế thừa**: Extends Member
- **Liên kết ngược**: Member.managerId → Manager.id

### 👤 Vai trò:
- Quản lý toàn bộ hệ thống thư viện
- Có quyền cao nhất trong hệ thống

---

## 3️⃣ LIBRARIAN (Thủ thư)

### 📝 Mô tả:
Kế thừa từ Member, đại diện cho thủ thư thư viện.

### 🔑 Thuộc tính riêng:

| Tên thuộc tính | Kiểu dữ liệu | Mô tả |
|---------------|--------------|-------|
| `id` | int | ID thủ thư (Khóa chính) |
| `librarianCode` | String | Mã thủ thư |

### 🔗 Mối quan hệ:
- **Kế thừa**: Extends Member
- **Liên kết ngược**: Member.librarianId → Librarian.id
- **Tham chiếu**: BorrowSlipDetail.librarianId → Librarian.id

### 👤 Vai trò:
- Xử lý việc mượn/trả sách
- Quản lý chi tiết phiếu mượn (BorrowSlipDetail)

---

## 4️⃣ READER (Độc giả)

### 📝 Mô tả:
Kế thừa từ Member, đại diện cho độc giả mượn sách.

### 🔑 Thuộc tính riêng:

| Tên thuộc tính | Kiểu dữ liệu | Mô tả |
|---------------|--------------|-------|
| `id` | int | ID độc giả (Khóa chính) |
| `readerCode` | String | Mã độc giả |
| `readerStatisticsId` | int | ID thống kê độc giả |

### 🔗 Mối quan hệ:
- **Kế thừa**: Extends Member
- **Liên kết ngược**: Member.readerId → Reader.id
- **Tham chiếu từ**: 
  - BorrowSlip.readerId → Reader.id (1-nhiều)
  - LibraryCard.readerId → Reader.id (1-1 hoặc 1-nhiều)

### 👤 Vai trò:
- Mượn và trả sách
- Sở hữu thẻ thư viện
- Có thống kê hoạt động mượn sách

---

## 5️⃣ DOCUMENT (Tài liệu/Sách)

### 📝 Mô tả:
Đại diện cho tài liệu/sách trong thư viện.

### 🔑 Thuộc tính:

| Tên thuộc tính | Kiểu dữ liệu | Mô tả |
|---------------|--------------|-------|
| `id` | int | ID tài liệu (Khóa chính) |
| `name` | String | Tên tài liệu/sách |
| `author` | String | Tác giả |
| `publishedYear` | String | Năm xuất bản |
| `description` | String | Mô tả chi tiết |

### 🔗 Mối quan hệ:
- **Tham chiếu từ**: BorrowSlipDetail.documentId → Document.id

### 📚 Chức năng:
- Lưu trữ thông tin sách/tài liệu
- Có thể được mượn thông qua BorrowSlipDetail

---

## 6️⃣ BORROW_SLIP (Phiếu mượn)

### 📝 Mô tả:
Đại diện cho một phiếu mượn sách của độc giả.

### 🔑 Thuộc tính:

| Tên thuộc tính | Kiểu dữ liệu | Mô tả |
|---------------|--------------|-------|
| `id` | int | ID phiếu mượn (Khóa chính) |
| `borrowDate` | Date | Ngày mượn |
| `returnDate` | Date | Ngày trả (dự kiến hoặc thực tế) |
| `status` | String | Trạng thái (đang mượn, đã trả, quá hạn,...) |
| `readerId` | int | ID độc giả (Khóa ngoại) |

### 🔗 Mối quan hệ:
- **Tham chiếu đến**: Reader.id (nhiều-1)
- **Tham chiếu từ**: BorrowSlipDetail.borrowSlipId → BorrowSlip.id (1-nhiều)

### 📋 Chức năng:
- Quản lý thông tin chung của một lần mượn sách
- Một phiếu mượn có thể chứa nhiều tài liệu (qua BorrowSlipDetail)

---

## 7️⃣ BORROW_SLIP_DETAIL (Chi tiết phiếu mượn)

### 📝 Mô tả:
Chi tiết từng tài liệu trong phiếu mượn, xử lý bởi thủ thư.

### 🔑 Thuộc tính:

| Tên thuộc tính | Kiểu dữ liệu | Mô tả |
|---------------|--------------|-------|
| `id` | int | ID chi tiết phiếu mượn (Khóa chính) |
| `description` | String | Mô tả/Ghi chú |
| `borrowTaskDetailId` | int | ID chi tiết nhiệm vụ mượn |
| `borrowSlipId` | int | ID phiếu mượn (Khóa ngoại) |
| `documentId` | int | ID tài liệu (Khóa ngoại) |
| `librarianId` | int | ID thủ thư xử lý (Khóa ngoại) |

### 🔗 Mối quan hệ:
- **Tham chiếu đến**:
  - BorrowSlip.id (nhiều-1)
  - Document.id (nhiều-1)
  - Librarian.id (nhiều-1)

### 📋 Chức năng:
- Liên kết giữa Phiếu mượn và Tài liệu (bảng trung gian)
- Lưu thông tin thủ thư xử lý
- Ghi chú chi tiết về từng tài liệu được mượn

---

## 8️⃣ LIBRARY_CARD (Thẻ thư viện)

### 📝 Mô tả:
Thẻ thư viện của độc giả, cho phép mượn sách.

### 🔑 Thuộc tính:

| Tên thuộc tính | Kiểu dữ liệu | Mô tả |
|---------------|--------------|-------|
| `id` | int | ID thẻ (Khóa chính) |
| `startDate` | Date | Ngày bắt đầu hiệu lực |
| `expiryDate` | Date | Ngày hết hạn |
| `status` | String | Trạng thái (active, expired, suspended,...) |
| `readerId` | int | ID độc giả (Khóa ngoại) |

### 🔗 Mối quan hệ:
- **Tham chiếu đến**: Reader.id (nhiều-1 hoặc 1-1)

### 📋 Chức năng:
- Quản lý quyền mượn sách của độc giả
- Kiểm soát thời hạn sử dụng thư viện

---

## 🔄 SƠ ĐỒ QUAN HỆ TỔNG THỂ

```
┌─────────────────────────────────────────────┐
│              MEMBER (Base)                  │
│  - username, password, role                 │
│  - managerId, librarianId, readerId         │
└──────────────┬──────────────────────────────┘
               │ (Inheritance)
       ┌───────┼────────┐
       │       │        │
┌──────▼─┐ ┌──▼──────┐ ┌▼─────────┐
│ MANAGER│ │LIBRARIAN│ │  READER  │
│  - id  │ │  - id   │ │  - id    │
│  -code │ │  -code  │ │  -code   │
└────────┘ └────┬────┘ └────┬─────┘
                │           │
                │           │ (1-nhiều)
                │      ┌────▼───────────┐
                │      │  BORROW_SLIP   │
                │      │  - borrowDate  │
                │      │  - returnDate  │
                │      │  - status      │
                │      └────┬───────────┘
                │           │ (1-nhiều)
                │      ┌────▼─────────────────┐
                │      │ BORROW_SLIP_DETAIL   │
                └──────┤  - description       │
                       │  - borrowSlipId      │
                       │  - documentId        │
                       │  - librarianId       │
                       └────┬─────────────────┘
                            │ (nhiều-1)
                       ┌────▼─────────┐
                       │   DOCUMENT   │
                       │  - name      │
                       │  - author    │
                       │  - year      │
                       └──────────────┘

        READER (1-nhiều hoặc 1-1)
           │
           └────► LIBRARY_CARD
                  - startDate
                  - expiryDate
                  - status
```

---

## 🎯 CÁC LUỒNG NGHIỆP VỤ CHÍNH

### 1. Đăng ký thành viên:
```
User → Member (với role) → Tạo Manager/Librarian/Reader tương ứng
```

### 2. Mượn sách:
```
Reader → Tạo BorrowSlip → Thủ thư tạo BorrowSlipDetail cho từng Document
```

### 3. Trả sách:
```
BorrowSlip (status update) → BorrowSlipDetail (librarian xử lý)
```

### 4. Quản lý thẻ:
```
Reader → LibraryCard (kiểm tra status & expiryDate) → Cho phép/Từ chối mượn
```

---

## 📊 PHÂN TÍCH THIẾT KẾ

### ✅ Ưu điểm:
1. **Kế thừa rõ ràng**: Member là lớp cha, tái sử dụng code tốt
2. **Phân tách trách nhiệm**: Mỗi model có mục đích riêng biệt
3. **Linh hoạt**: Có thể mở rộng thêm loại tài liệu, loại thành viên

### ⚠️ Điểm cần lưu ý:
1. **Member design**: Chứa 3 ID (managerId, librarianId, readerId) - chỉ 1 ID có giá trị, 2 ID còn lại thừa
2. **Khóa chính**: Member dùng username làm khóa chính thay vì ID số
3. **BorrowSlipDetail.borrowTaskDetailId**: Thuộc tính này chưa rõ mục đích sử dụng

### 💡 Gợi ý cải tiến:
1. Xem xét thêm trường `memberType` trong Member thay vì 3 ID riêng biệt
2. Thêm validation cho ngày (returnDate >= borrowDate, expiryDate > startDate)
3. Thêm các index cho các khóa ngoại để tối ưu query

---

## 📝 VÍ DỤ SỬ DỤNG

### Tạo độc giả mới:
```java
// Tạo Member với role = "reader"
Member member = new Member("user123", "pass", "123 Street", 
    new Date(), "user@email.com", "0123456789", "reader", 0, 0, 1);

// Tạo Reader tương ứng
Reader reader = new Reader(1, "RD001", 0, "user123", "pass", 
    "123 Street", new Date(), "user@email.com", "0123456789", 
    "reader", 0, 0, 1);
```

### Tạo phiếu mượn:
```java
// Reader mượn sách
BorrowSlip slip = new BorrowSlip(1, new Date(), futureDate, "borrowing", 1);

// Thủ thư xử lý từng sách
BorrowSlipDetail detail = new BorrowSlipDetail(1, "Good condition", 
    0, 1, 101, 1); // borrowSlipId=1, documentId=101, librarianId=1
```

---

**Ngày tạo**: 24/10/2025  
**Phiên bản**: 1.0  
**Hệ thống**: Library Management System

