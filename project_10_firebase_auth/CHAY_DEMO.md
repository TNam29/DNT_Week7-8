# 🚀 HƯỚNG DẪN CHẠY DEMO MODE (Không cần Firebase)

## Cách chạy giao diện demo với dữ liệu giả:

### **Bước 1: Tạm thời tắt Firebase packages**

Mở file `pubspec.yaml` và comment các dòng Firebase:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  # firebase_core: ^2.24.0     # ← Comment dòng này
  # firebase_auth: ^4.15.0     # ← Comment dòng này
```

### **Bước 2: Chạy flutter pub get**

```powershell
cd d:\Flutter-app\btweek\project_10_firebase_auth
flutter pub get
```

### **Bước 3: Chạy file demo**

```powershell
flutter run -t lib/main_demo.dart -d chrome
```

---

## ✅ Tính năng trong Demo Mode:

- ✅ Giao diện giống hệt main.dart
- ✅ Đăng nhập/Đăng ký với dữ liệu giả
- ✅ 3 tài khoản demo có sẵn:
  - `demo@example.com` / `123456` (đã verify)
  - `user@test.com` / `password`
  - `admin@demo.com` / `admin123`
- ✅ Có thể đăng ký tài khoản mới (lưu trong memory)
- ✅ Hiển thị thông tin user
- ✅ Đăng xuất

---

## 🔄 Để quay lại dùng Firebase thực:

1. Uncomment các dòng Firebase trong `pubspec.yaml`
2. Chạy `flutter pub get`
3. Cấu hình Firebase theo hướng dẫn trong file `web/index.html`
4. Chạy `flutter run -d chrome` (không cần -t)

---

## 📝 So sánh 2 mode:

| Tính năng | main.dart (Firebase) | main_demo.dart (Demo) |
|-----------|---------------------|----------------------|
| Cần setup Firebase | ✅ Có | ❌ Không |
| Lưu dữ liệu thật | ✅ Cloud | ❌ Memory |
| Giao diện | 100% giống nhau | 100% giống nhau |
| Tài khoản demo | ❌ Không | ✅ 3 accounts |
| Phù hợp cho | Production | Testing/Demo |

---

## 💡 Tip:

Nút **"Điền tài khoản demo"** trên màn hình login sẽ tự động điền:
- Email: demo@example.com
- Password: 123456

Rất tiện để test nhanh! 🚀
