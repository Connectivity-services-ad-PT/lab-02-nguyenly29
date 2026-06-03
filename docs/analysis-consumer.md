# Phân tích yêu cầu — vai Consumer

- Cặp đàm phán: Pair 04
- Product: A6
- Consumer service: Core Business (A6)
- Provider service: Notification (A7)
- Người viết: Trần Công Thưởng
- Ngày: 27/05/2026

---

## 1. Resource Consumer cần nhận/gửi

| Resource | Consumer dùng để làm gì? | Field bắt buộc với Consumer | Field có thể tùy chọn |
|---|---|---|---|
| `Alert Notification` | Gửi cảnh báo đến Notification service | alertId, title, channel, severity | metadata |
| `Delivery Status` | Theo dõi trạng thái gửi cảnh báo | notificationId, status, timestamp | retryCount |

---

## 2. API Consumer cần gọi

| Method | Path | Lúc nào gọi? | Kỳ vọng response |
|---|---|---|---|
| POST | `/notifications` | khi có cảnh báo cần gửi | 202 Accepted |
| GET | `/notifications/{id}` | khi cần kiểm tra trạng thái gửi | 200 OK |

---

## 3. Error case Consumer cần xử lý

Tối thiểu 5 case.

| Status | Consumer hiểu là gì? | Consumer sẽ xử lý thế nào? |
|---:|---|---|
| 400 | Request sai schema | Sửa payload/log lỗi |
| 401 | Thiếu token | Refresh/cấu hình token |
| 403 | Không đủ quyền | Báo lỗi quyền truy cập |
| 404 | Không tìm thấy resource | Hiển thị trạng thái không tồn tại |
| 409 | Xung đột nghiệp vụ | Retry hoặc yêu cầu thao tác lại |
| 422 | Vi phạm rule nghiệp vụ | Hiển thị lý do cụ thể |

---

## 4. Giả định bổ sung

- Giả định 1: Notification service luôn khả dụng nội bộ.
- Giả định 2: Message phải có severity hợp lệ.
- Giả định 3: Notification ID là duy nhất.

---

## 5. Câu hỏi cho Provider

1. Notification có hỗ trợ retry tự động không?
2. Có giới hạn số lượng request mỗi phút không?
3. Có hỗ trợ nhiều channel cùng lúc không?

---

## 6. Rủi ro tích hợp

| Rủi ro | Tác động | Đề xuất xử lý |
|---|---|---|
| Provider đổi schema | Consumer parse lỗi | Version API rõ ràng |
| Notification gửi chậm | Mất realtime | Timeout + retry |
| Thiếu trạng thái delivery | Khó tracking | Chuẩn hóa response |
| Duplicate event | Gửi trùng cảnh báo | Dùng idempotency key |
| Provider đổi kiểu dữ liệu | Consumer parse lỗi | Chốt type/format/pattern |
| Provider thiếu mã lỗi | Consumer khó xử lý lỗi | Chuẩn hóa Problem Details |