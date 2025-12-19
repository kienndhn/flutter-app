# Flutter Template App

Một template Flutter app với cấu trúc cơ bản bao gồm màn hình đăng nhập và 3 tab chính.

## Cấu trúc App

### Màn hình chính:
1. **Màn hình đăng nhập** - Form đăng nhập với validation
2. **Tab Trang chủ** - Dashboard với các thao tác nhanh
3. **Tab Tìm kiếm** - Tìm kiếm với search bar và kết quả
4. **Tab Cá nhân** - Thông tin user và các tùy chọn

## Tính năng

### Authentication
- Đăng nhập với email và password
- Lưu trữ token an toàn với flutter_secure_storage
- Quản lý trạng thái đăng nhập với Provider
- Đăng xuất và chuyển về màn hình login

### Navigation
- Sử dụng go_router cho navigation
- Bottom navigation với 3 tab
- IndexedStack để giữ trạng thái các tab

### UI/UX
- Material Design 3
- Responsive design
- Loading states
- Error handling
- SnackBar notifications

## Cài đặt

### Yêu cầu
- Flutter SDK >= 3.0.0
- Dart >= 3.0.0

### Các bước cài đặt

1. Clone project:
```bash
git clone <repository-url>
cd flutter_template_app
```

2. Cài đặt dependencies:
```bash
flutter pub get
```

3. Chạy app:
```bash
flutter run
```

## Cấu trúc thư mục

```
lib/
├── main.dart                 # Entry point
├── constants/                # Constants và configurations
├── models/                   # Data models
├── screens/                  # UI screens
│   ├── login_screen.dart
│   ├── main_tab_screen.dart
│   ├── home_screen.dart
│   ├── search_screen.dart
│   └── profile_screen.dart
├── services/                 # Business logic và API calls
│   └── auth_service.dart
├── utils/                    # Utility functions
└── widgets/                  # Reusable widgets
```

## Demo

### Đăng nhập
- Email: Bất kỳ email hợp lệ (ví dụ: user@demo.com)
- Password: Bất kỳ password có ít nhất 6 ký tự

### Tính năng demo
- Tìm kiếm: Nhập bất kỳ từ khóa để xem kết quả
- Các button và menu: Hiển thị SnackBar thông báo
- Đăng xuất: Xóa token và chuyển về màn hình login

## Tùy chỉnh

### Thêm màn hình mới
1. Tạo file trong `lib/screens/`
2. Thêm route trong `main.dart`
3. Cập nhật navigation nếu cần

### Thêm service mới
1. Tạo file trong `lib/services/`
2. Thêm vào Provider trong `main.dart`

### Thay đổi theme
Chỉnh sửa `ThemeData` trong `main.dart`

## Build

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

## License

MIT License
