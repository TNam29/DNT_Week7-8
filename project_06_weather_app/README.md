# Dự án 6: Ứng dụng Thời tiết

## Mô tả
Ứng dụng hiển thị thời tiết dựa trên vị trí địa lý của người dùng.

## Tính năng
- ✅ Lấy vị trí người dùng
- ✅ Hiển thị thời tiết hiện tại
- ✅ Nhiệt độ, độ ẩm, tốc độ gió
- ✅ Icon thời tiết động
- ✅ Pull to refresh
- ✅ Giao diện gradient đẹp mắt

## Cách thiết lập
1. Đăng ký API key tại [openweathermap.org](https://openweathermap.org/api)
2. Thay thế `YOUR_API_KEY` trong main.dart
3. Thêm permissions trong AndroidManifest.xml và Info.plist

## Cách chạy
```bash
flutter pub get
flutter run
```

## Kỹ thuật
- geolocator package
- http package
- FutureBuilder
- JSON parsing
- Location permissions
