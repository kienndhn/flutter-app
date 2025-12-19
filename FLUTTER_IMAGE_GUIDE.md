# 🖼️ Hướng dẫn Hiển thị Hình ảnh trong Flutter

## 📋 Mục lục
1. [Các loại hình ảnh](#các-loại-hình-ảnh)
2. [Widget Image cơ bản](#widget-image-cơ-bản)
3. [Cache hình ảnh](#cache-hình-ảnh)
4. [So sánh với FastImage (React Native)](#so-sánh-với-fastimage)
5. [Best Practices](#best-practices)
6. [Ví dụ thực tế](#ví-dụ-thực-tế)

---

## 🎯 Các loại hình ảnh

### **1. Hình ảnh từ Assets (Local)**
```dart
Image.asset('assets/images/logo.png')
```

### **2. Hình ảnh từ Network (URL)**
```dart
Image.network('https://example.com/image.jpg')
```

### **3. Hình ảnh từ Memory (Bytes)**
```dart
Image.memory(bytes)
```

### **4. Hình ảnh từ File**
```dart
Image.file(File('path/to/image.jpg'))
```

---

## 🧩 Widget Image cơ bản

### **Cú pháp cơ bản:**
```dart
Image.asset(
  'assets/images/image.png',
  width: 200,
  height: 150,
  fit: BoxFit.cover,
  color: Colors.blue,
  colorBlendMode: BlendMode.modulate,
)
```

### **Các thuộc tính quan trọng:**

| Thuộc tính | Mô tả | Ví dụ |
|------------|-------|-------|
| `fit` | Cách hiển thị hình ảnh | `BoxFit.cover`, `BoxFit.contain` |
| `width/height` | Kích thước cố định | `width: 200, height: 150` |
| `color` | Tô màu cho hình ảnh | `color: Colors.blue` |
| `colorBlendMode` | Chế độ blend màu | `BlendMode.modulate` |
| `alignment` | Căn chỉnh hình ảnh | `Alignment.center` |
| `repeat` | Lặp lại hình ảnh | `ImageRepeat.noRepeat` |
| `filterQuality` | Chất lượng lọc | `FilterQuality.high` |

### **Các giá trị BoxFit:**

```dart
BoxFit.cover      // Phủ toàn bộ, có thể cắt
BoxFit.contain    // Hiển thị đầy đủ, có thể có khoảng trống
BoxFit.fill       // Kéo giãn để vừa khít
BoxFit.fitWidth   // Vừa khít chiều rộng
BoxFit.fitHeight  // Vừa khít chiều cao
BoxFit.none       // Không thay đổi kích thước
BoxFit.scaleDown  // Thu nhỏ nếu cần
```

---

## 💾 Cache hình ảnh

### **1. Image.network (Không có cache)**
```dart
Image.network(
  'https://example.com/image.jpg',
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return CircularProgressIndicator();
  },
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error);
  },
)
```

### **2. CachedNetworkImage (Có cache)**
```yaml
# pubspec.yaml
dependencies:
  cached_network_image: ^3.3.0
```

```dart
import 'package:cached_network_image/cached_network_image.dart';

CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
  fit: BoxFit.cover,
  width: 200,
  height: 150,
)
```

### **3. CachedNetworkImage với các tùy chọn nâng cao:**
```dart
CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  placeholder: (context, url) => Container(
    color: Colors.grey[200],
    child: Center(child: CircularProgressIndicator()),
  ),
  errorWidget: (context, url, error) => Container(
    color: Colors.grey[200],
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red),
          Text('Lỗi tải hình ảnh'),
        ],
      ),
    ),
  ),
  fadeInDuration: Duration(milliseconds: 300),
  fadeOutDuration: Duration(milliseconds: 300),
  memCacheWidth: 300,  // Cache width
  memCacheHeight: 200, // Cache height
  maxWidthDiskCache: 300,
  maxHeightDiskCache: 200,
)
```

---

## 🔄 So sánh với FastImage (React Native)

| Tính năng | FastImage (RN) | Flutter Image | CachedNetworkImage |
|-----------|----------------|---------------|-------------------|
| **Cache tự động** | ✅ | ❌ | ✅ |
| **Placeholder** | ✅ | ✅ | ✅ |
| **Error handling** | ✅ | ✅ | ✅ |
| **Progressive loading** | ✅ | ❌ | ❌ |
| **Priority loading** | ✅ | ❌ | ❌ |
| **Preloading** | ✅ | ❌ | ✅ |
| **Cache control** | ✅ | ❌ | ✅ |

### **FastImage equivalent trong Flutter:**
```dart
// React Native FastImage
<FastImage
  source={{ uri: 'https://example.com/image.jpg' }}
  style={{ width: 200, height: 150 }}
  resizeMode={FastImage.resizeMode.cover}
/>

// Flutter equivalent
CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  width: 200,
  height: 150,
  fit: BoxFit.cover,
)
```

---

## 🚀 Best Practices

### **1. Sử dụng đúng loại hình ảnh:**
```dart
// ✅ Tốt - Hình ảnh local
Image.asset('assets/images/logo.png')

// ✅ Tốt - Hình ảnh network với cache
CachedNetworkImage(imageUrl: 'https://example.com/image.jpg')

// ❌ Không tốt - Hình ảnh network không cache cho UI tĩnh
Image.network('https://example.com/logo.png')
```

### **2. Xử lý loading và error:**
```dart
CachedNetworkImage(
  imageUrl: imageUrl,
  placeholder: (context, url) => Container(
    color: Colors.grey[200],
    child: Center(
      child: CircularProgressIndicator(strokeWidth: 2),
    ),
  ),
  errorWidget: (context, url, error) => Container(
    color: Colors.grey[200],
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red),
          Text('Không thể tải hình ảnh'),
        ],
      ),
    ),
  ),
)
```

### **3. Tối ưu kích thước:**
```dart
// ✅ Tốt - Chỉ định kích thước cache
CachedNetworkImage(
  imageUrl: imageUrl,
  memCacheWidth: 300,
  memCacheHeight: 200,
  maxWidthDiskCache: 300,
  maxHeightDiskCache: 200,
)

// ✅ Tốt - Sử dụng cacheWidth/cacheHeight cho Image.network
Image.network(
  imageUrl,
  cacheWidth: 300,
  cacheHeight: 200,
)
```

### **4. Preloading hình ảnh:**
```dart
// Preload hình ảnh
CachedNetworkImageProvider('https://example.com/image.jpg')
  .resolve(ImageConfiguration.empty)
  .addListener(ImageStreamListener((info, _) {
    print('Image preloaded: ${info.image}');
  }));
```

---

## 📱 Ví dụ thực tế

### **1. Avatar với fallback:**
```dart
Widget buildAvatar(String imageUrl, {double size = 50}) {
  return ClipOval(
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: size,
        height: size,
        color: Colors.grey[300],
        child: Icon(Icons.person, color: Colors.grey[600]),
      ),
      errorWidget: (context, url, error) => Container(
        width: size,
        height: size,
        color: Colors.grey[300],
        child: Icon(Icons.person, color: Colors.grey[600]),
      ),
    ),
  );
}
```

### **2. Gallery với lazy loading:**
```dart
class ImageGallery extends StatelessWidget {
  final List<String> imageUrls;
  
  const ImageGallery({required this.imageUrls});
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: imageUrls[index],
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[200],
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }
}
```

### **3. Hero animation với cache:**
```dart
// Màn hình danh sách
CachedNetworkImage(
  imageUrl: imageUrl,
  fit: BoxFit.cover,
  placeholder: (context, url) => Container(color: Colors.grey[200]),
  errorWidget: (context, url, error) => Container(
    color: Colors.grey[200],
    child: Icon(Icons.error),
  ),
)

// Màn hình chi tiết
Hero(
  tag: imageUrl,
  child: CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.contain,
    placeholder: (context, url) => Container(color: Colors.grey[200]),
    errorWidget: (context, url, error) => Container(
      color: Colors.grey[200],
      child: Icon(Icons.error),
    ),
  ),
)
```

---

## 🔧 Cấu hình Cache

### **1. Cấu hình cache size:**
```dart
// Trong main.dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cấu hình cache size
  PaintingBinding.instance.imageCache.maximumSize = 1000;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20; // 50MB
  
  runApp(MyApp());
}
```

### **2. Clear cache:**
```dart
// Clear memory cache
PaintingBinding.instance.imageCache.clear();
PaintingBinding.instance.imageCache.clearLiveImages();

// Clear disk cache (CachedNetworkImage)
await CachedNetworkImage.evictFromCache(imageUrl);
```

---

## 📊 Performance Tips

1. **Sử dụng CachedNetworkImage** cho hình ảnh network
2. **Chỉ định kích thước cache** phù hợp
3. **Preload hình ảnh** quan trọng
4. **Sử dụng placeholder** để cải thiện UX
5. **Xử lý error** một cách graceful
6. **Tối ưu kích thước hình ảnh** trước khi hiển thị

---

## 🎯 Kết luận

Flutter cung cấp nhiều cách hiển thị hình ảnh với các tính năng khác nhau:

- **Image.asset**: Cho hình ảnh local
- **Image.network**: Cho hình ảnh network (không cache)
- **CachedNetworkImage**: Cho hình ảnh network với cache (tương tự FastImage)

Để có trải nghiệm tốt nhất, nên sử dụng **CachedNetworkImage** cho hình ảnh từ network và luôn xử lý loading/error states.
