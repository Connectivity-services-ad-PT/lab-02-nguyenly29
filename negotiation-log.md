# Biên bản đàm phán hợp đồng API

- Cặp đàm phán:  Pair 04
- Product: A
- Provider: Notification (A7)
- Consumer: Core Business (A6)
- Phiên: v1.0
- Ngày: 27/05/2026

---

## Issue #1

- Raised by: Consumer
- Endpoint: `POST /notifications`
- Concern: Consumer cần biết notification đã được nhận hay chưa
- Proposal: Provider trả về `202 Accepted` kèm notificationId
- Resolution: Accepted
- Rationale: Giảm thời gian chờ và hỗ trợ async processing
- Impact: Consumer có thể tracking notification

---

## Issue #2

- Raised by: Provider
- Endpoint: `POST /notifications`
- Concern: Payload có thể thiếu severity
- Proposal: severity là field bắt buộc
- Resolution: Accepted
- Rationale: Cần phân loại mức độ cảnh báo
- Impact: Consumer phải validate trước khi gửi

---

## Issue #3

- Raised by: Consumer
- Endpoint: `GET /notifications/{id}`
- Concern: Cần kiểm tra trạng thái gửi notification
- Proposal: Trả về status gồm pending, sent, failed
- Resolution: Accepted
- Rationale: Giúp Consumer theo dõi delivery status
- Impact: Provider cần lưu trạng thái notification

---

## Issue #4

- Raised by: Provider
- Endpoint: `POST /notifications`
- Concern: Request gửi trùng notification
- Proposal: Dùng idempotency key
- Resolution: Accepted
- Rationale: Tránh duplicate notification
- Impact: Consumer phải gửi unique request id

---

## Issue #5

- Raised by: Consumer
- Endpoint: `POST /notifications`
- Concern: Channel gửi không hợp lệ
- Proposal: Provider validate enum channel
- Resolution: Accepted
- Rationale: Tránh lỗi runtime
- Impact: Chỉ chấp nhận email, sms, push

---

## Issue #6

- Raised by: Provider
- Endpoint: `GET /notifications/{id}`
- Concern: Notification không tồn tại
- Proposal: Trả về `404 Problem`
- Resolution: Accepted
- Rationale: Chuẩn hóa error response
- Impact: Consumer cần xử lý trường hợp missing resource

---

# Chốt hợp đồng v1.0

Provider sign-off:  
Consumer sign-off:  
Witness (GV/TA):    
Date:               

---

## Ghi chú warning nếu Spectral còn cảnh báo

| Warning | Lý do chấp nhận tạm thời | Kế hoạch sửa |
|---|---|---|
| operation-description | Chưa bổ sung mô tả đầy đủ | Hoàn thiện sau |
| operation-operationId | Thiếu operationId ở một số endpoint | Bổ sung trong bản tiếp theo |
