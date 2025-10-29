# Dự án 10: Đăng nhập Firebase

## Mô tả
Ứng dụng đăng nhập/đăng ký với Firebase Authentication.

## Tính năng
- ✅ Đăng ký tài khoản mới
- ✅ Đăng nhập email/password
- ✅ Đăng xuất
- ✅ StreamBuilder cho auth state
- ✅ Hiển thị thông tin người dùng
- ✅ Email verification
- ✅ Error handling

## Cách thiết lập Firebase
1. Tạo project tại [Firebase Console](https://console.firebase.google.com/)
2. Thêm app Android/iOS
3. Tải file `google-services.json` (Android) và `GoogleService-Info.plist` (iOS)
4. Đặt vào thư mục tương ứng
5. Enable Email/Password authentication trong Firebase Console

## Cách chạy
```bash
flutter pub get
flutter run
```

## Kỹ thuật
- firebase_core
- firebase_auth
- StreamBuilder
- Authentication state management
- Form validation
- Error handling
