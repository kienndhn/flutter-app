# 🖼️ Hướng dẫn sử dụng Widget Hình ảnh trong Flutter

## 📋 Tổng quan

Dự án này cung cấp các widget tùy chỉnh để hiển thị hình ảnh trong Flutter với hỗ trợ cache, tương tự như FastImage trong React Native.

## 🚀 Cách sử dụng

### 1. Chạy ứng dụng demo

```bash
flutter run
```

Sau đó vào màn hình chính và nhấn vào nút "Images" để xem demo.

### 2. Sử dụng các widget

#### CachedImageWidget (Widget cơ bản)
```dart
import 'package:your_app/widgets/cached_image_widget.dart';

CachedImageWidget(
  imageUrl: 'https://example.com/image.jpg',
  width: 200,
  height: 150,
  fit: BoxFit.cover,
  placeholder: CircularProgressIndicator(),
  errorWidget: Icon(Icons.error),
)
```

#### CachedAvatar (Avatar tròn)
```dart
CachedAvatar(
  imageUrl: 'https://example.com/avatar.jpg',
  size: 60,
)
```

#### CachedImageGallery (Gallery lưới)
```dart
CachedImageGallery(
  imageUrls: [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
  ],
  crossAxisCount: 2,
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
)
```

#### CachedHeroImage (Hero animation)
```dart
CachedHeroImage(
  imageUrl: 'https://example.com/image.jpg',
  heroTag: 'unique_tag',
  width: 150,
  height: 100,
  onTap: () {
    // Xử lý khi nhấn vào hình ảnh
  },
)
```

## 🔧 Cài đặt CachedNetworkImage (Khuyến nghị)

Để có hiệu suất tốt nhất, hãy cài đặt package `cached_network_image`:

### 1. Thêm dependency
```yaml
# pubspec.yaml
dependencies:
  cached_network_image: ^3.3.0
```

### 2. Cài đặt
```bash
flutter pub get
```

### 3. Sử dụng thay thế
```dart
import 'package:cached_network_image/cached_network_image.dart';

CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
  fit: BoxFit.cover,
)
```

## 📊 So sánh với FastImage (React Native)

| Tính năng | FastImage (RN) | Flutter Widget | CachedNetworkImage |
|-----------|----------------|----------------|-------------------|
| **Cache tự động** | ✅ | ⚠️ (Basic) | ✅ |
| **Placeholder** | ✅ | ✅ | ✅ |
| **Error handling** | ✅ | ✅ | ✅ |
| **Progressive loading** | ✅ | ❌ | ❌ |
| **Priority loading** | ✅ | ❌ | ❌ |
| **Preloading** | ✅ | ❌ | ✅ |
| **Cache control** | ✅ | ⚠️ (Basic) | ✅ |

## 🎯 Best Practices

### 1. Sử dụng đúng widget cho từng trường hợp
```dart
// ✅ Avatar
CachedAvatar(imageUrl: userAvatarUrl, size: 50)

// ✅ Gallery
CachedImageGallery(imageUrls: productImages)

// ✅ Hero animation
CachedHeroImage(imageUrl: imageUrl, heroTag: 'product_$id')
```

### 2. Xử lý loading và error states
```dart
CachedImageWidget(
  imageUrl: imageUrl,
  placeholder: Container(
    color: Colors.grey[200],
    child: Center(child: CircularProgressIndicator()),
  ),
  errorWidget: Container(
    color: Colors.grey[200],
    child: Center(child: Icon(Icons.error)),
  ),
)
```

### 3. Tối ưu kích thước
```dart
CachedImageWidget(
  imageUrl: imageUrl,
  memCacheWidth: 300,  // Cache width
  memCacheHeight: 200, // Cache height
)
```

## 🔄 Migration từ Image.network

### Trước (Không có cache):
```dart
Image.network(
  'https://example.com/image.jpg',
  fit: BoxFit.cover,
)
```

### Sau (Có cache):
```dart
// Sử dụng widget tùy chỉnh
CachedImageWidget(
  imageUrl: 'https://example.com/image.jpg',
  fit: BoxFit.cover,
)

// Hoặc sử dụng CachedNetworkImage
CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  fit: BoxFit.cover,
)
```

## 📱 Ví dụ thực tế

### 1. User Profile
```dart
Row(
  children: [
    CachedAvatar(
      imageUrl: user.avatarUrl,
      size: 60,
    ),
    const SizedBox(width: 16),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.name, style: TextStyle(fontSize: 18)),
          Text(user.email, style: TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  ],
)
```

### 2. Product Gallery
```dart
CachedImageGallery(
  imageUrls: product.images,
  crossAxisCount: 2,
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
  itemWidth: 150,
  itemHeight: 150,
)
```

### 3. News Feed
```dart
ListView.builder(
  itemCount: posts.length,
  itemBuilder: (context, index) {
    final post = posts[index];
    return Card(
      child: Column(
        children: [
          CachedImageWidget(
            imageUrl: post.imageUrl,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(post.title),
          ),
        ],
      ),
    );
  },
)
```

## 🚨 Lưu ý quan trọng

1. **Widget tùy chỉnh hiện tại sử dụng Image.network** với cache parameters cơ bản
2. **Để có hiệu suất tốt nhất**, sử dụng `CachedNetworkImage` package
3. **Luôn xử lý error states** để tránh crash app
4. **Tối ưu kích thước hình ảnh** trước khi hiển thị
5. **Sử dụng placeholder** để cải thiện UX

## 🔗 Tài liệu tham khảo

- [Flutter Image Widget](https://api.flutter.dev/flutter/widgets/Image-class.html)
- [CachedNetworkImage Package](https://pub.dev/packages/cached_network_image)
- [Flutter Image Caching](https://flutter.dev/docs/development/ui/assets-and-images#caching)
- [FastImage (React Native)](https://github.com/DylanVann/fast-image)
