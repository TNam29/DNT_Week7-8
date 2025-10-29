# Dự án 4: Clone Giao diện Chat

## Mô tả
Giao diện chat giống Messenger/WhatsApp với danh sách cuộc hội thoại và màn hình chat chi tiết.

## Tính năng
- ✅ Danh sách cuộc hội thoại
- ✅ Hiển thị trạng thái online/offline
- ✅ Số tin nhắn chưa đọc
- ✅ Bong bóng tin nhắn (message bubbles)
- ✅ Gửi tin nhắn
- ✅ Hiển thị thời gian
- ✅ Trạng thái đã đọc (checkmarks)
- ✅ Avatar và thông tin người dùng

## Cách chạy
```bash
flutter pub get
flutter run
```

## Kỹ thuật sử dụng
- ListView.builder() cho danh sách cuộc hội thoại
- Row, Column cho layout bong bóng chat
- Stack cho badge online
- TextField cho nhập tin nhắn
- Custom widgets (MessageBubble, ConversationTile)
- Scroll reverse cho chat
