# Dự án 3: Ứng dụng Đọc tin tức

## Mô tả
Ứng dụng đọc tin tức với khả năng lấy dữ liệu từ NewsAPI.org, tìm kiếm và xem chi tiết bài viết.

## Tính năng
- ✅ Lấy tin tức từ REST API (NewsAPI.org)
- ✅ Hiển thị danh sách tin tức với hình ảnh
- ✅ Tìm kiếm tin tức
- ✅ Xem chi tiết bài viết
- ✅ Pull to refresh
- ✅ Xử lý lỗi và loading states
- ✅ FutureBuilder pattern

## Cách thiết lập
1. Đăng ký tài khoản miễn phí tại [newsapi.org](https://newsapi.org)
2. Lấy API key
3. Thay thế `YOUR_API_KEY` trong file `main.dart` bằng API key của bạn
4. Chạy ứng dụng

**Lưu ý:** Ứng dụng hiện sử dụng dữ liệu demo. Để sử dụng API thực, hãy thêm API key và uncomment các dòng code API thực.

## Cách chạy
```bash
flutter pub get
flutter run
```

## Kỹ thuật sử dụng
- http package
- FutureBuilder
- RefreshIndicator
- JSON parsing
- Error handling
- Navigator và routing
