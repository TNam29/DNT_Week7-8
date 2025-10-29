# Dự án 9: Ứng dụng Nhắc nhở

## Mô tả
Ứng dụng lên lịch nhắc nhở với thông báo local.

## Tính năng
- ✅ Tạo nhắc nhở với tiêu đề và mô tả
- ✅ Chọn ngày và giờ
- ✅ Thông báo local
- ✅ Danh sách nhắc nhở
- ✅ Xóa nhắc nhở
- ✅ Hiển thị trạng thái đã qua/sắp tới

## Permissions
**Android (AndroidManifest.xml):**
```xml
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.USE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

## Cách chạy
```bash
flutter pub get
flutter run
```

## Kỹ thuật
- flutter_local_notifications
- timezone package
- DateTimePicker
- Scheduled notifications
- Background execution
