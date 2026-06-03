# Phân tích yêu cầu — vai Provider

- Cặp đàm phán: Pair 04
- Product: A7
- Provider service: Notification (A7)
- Consumer service: Core Business (A6)
- Người viết: Nguyễn Thanh Danh
- Ngày: 27/05/2026

---

## 1. Resource chính

| Resource | Mô tả | Thuộc tính bắt buộc | Thuộc tính tùy chọn |
|---|---|---|---|
| Notification | Thông tin cảnh báo cần gửi | notificationId, title, message, channel, severity | metadata |
| Delivery Status | Trạng thái gửi cảnh báo | notificationId, status, timestamp | retryCount, deliveredAt |

---

## 2. Action/API dự kiến

| Method | Path | Mục đích | Consumer gọi khi nào? |
|---|---|---|---|
| POST | `/notifications` | Tạo và gửi notification mới | Khi hệ thống phát hiện alert |
| GET | `/notifications/{id}` | Lấy trạng thái notification | Khi cần kiểm tra kết quả gửi |

---

## 3. Error case

Tối thiểu 5 case.

| Status | Tình huống | Response body dự kiến |
|---:|---|---|
| 400 | Payload sai định dạng | `Problem` |
| 401 | Thiếu Bearer token | `Problem` |
| 403 | Token hợp lệ nhưng không có quyền | `Problem` |
| 404 | Resource không tồn tại | `Problem` |
| 409 | Xung đột nghiệp vụ | `Problem` |
| 422 | Dữ liệu đúng JSON nhưng vi phạm nghiệp vụ | `Problem` |

---

## 4. Giả định bổ sung

Ghi rõ những điểm user story chưa nói nhưng Provider cần giả định.

- Giả định 1: Notification service hoạt động trong mạng nội bộ.
- Giả định 2: Notification ID phải duy nhất.
- Giả định 3: Hệ thống hỗ trợ nhiều channel như email, sms, push.

---

## 5. Câu hỏi cho Consumer

1. Có cần retry tự động khi gửi thất bại không?
2. Consumer có yêu cầu priority cho notification không?
3. Có cần hỗ trợ gửi nhiều channel cùng lúc không?

---

## 6. Rủi ro tích hợp

| Rủi ro | Tác động | Đề xuất xử lý |
|---|---|---|
| Tên field không thống nhất | Consumer parse lỗi | Chốt naming trong `openapi.yaml` |
| Payload lớn | Timeout/mock lỗi | Thống nhất content-type và size limit |
| Duplicate request | Gửi trùng notification | Dùng idempotency key |
| Consumer gửi sai channel | Notification fail | Validate enum channel |
| Provider thay đổi response schema | Consumer lỗi parse | Version API rõ ràng |
