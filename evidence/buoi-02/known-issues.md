# Known Issues — Lab 02

Ghi các lỗi còn tồn tại nếu chưa xử lý xong.

| Lỗi | Ảnh hưởng | Cách xử lý dự kiến | Người phụ trách |
|---|---|---|---|
| Prism mock server đôi khi trả về response validation không đúng mong đợi khi request thiếu token | Một số test error case chưa phản ánh đúng business logic thực tế | Sẽ bổ sung custom validation và mock examples đầy đủ hơn ở Lab tiếp theo | Antony |
| PowerShell curl payload dễ lỗi escape JSON khi test POST request | Có thể gây Invalid JSON trong quá trình test mock server | Sử dụng --data-raw và format JSON một dòng để ổn định hơn | Antony |
| Chưa triển khai backend thật, hiện chỉ dùng Prism mock server | API hiện chưa có database và business logic thực tế | Sẽ triển khai service thật ở các Lab sau | Antony |
| Chưa bổ sung versioning strategy đầy đủ | Khó mở rộng API khi thay đổi schema trong tương lai | Hoàn thiện VERSIONING.md ở bài tập tiếp theo | Antony |