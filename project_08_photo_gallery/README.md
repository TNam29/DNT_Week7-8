# Dự án 8: Thư viện ảnh

## Mô tả
Ứng dụng chụp ảnh và hiển thị trong thư viện dạng lưới.

## Tính năng
- ✅ Chụp ảnh bằng camera
- ✅ Chọn ảnh từ thư viện
- ✅ Chọn nhiều ảnh cùng lúc
- ✅ Hiển thị GridView
- ✅ Xem ảnh full screen
- ✅ Zoom ảnh (InteractiveViewer)
- ✅ Xóa ảnh
- ✅ Hero animation

## Permissions cần thiết
**Android (AndroidManifest.xml):**
```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

**iOS (Info.plist):**
```xml
<key>NSCameraUsageDescription</key>
<string>Cần quyền truy cập camera để chụp ảnh</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Cần quyền truy cập thư viện ảnh</string>
```

## Cách chạy
```bash
flutter pub get
flutter run
```

## Kỹ thuật
- image_picker package
- GridView
- Hero animation
- InteractiveViewer
- File handling
