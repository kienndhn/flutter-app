import 'package:flutter/material.dart';
import '../widgets/cached_image_widget.dart';

class ImageDemoScreen extends StatelessWidget {
  const ImageDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Hiển thị Hình ảnh'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. Hình ảnh từ Assets (Local)'),
            const SizedBox(height: 16),
            _buildLocalImageSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('2. Hình ảnh từ Network (URL)'),
            const SizedBox(height: 16),
            _buildNetworkImageSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('3. Hình ảnh với Cache (CachedNetworkImage)'),
            const SizedBox(height: 16),
            _buildCachedImageSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('4. Hình ảnh với Placeholder & Error'),
            const SizedBox(height: 16),
            _buildImageWithPlaceholderSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('5. Widget tùy chỉnh với cache'),
            const SizedBox(height: 16),
            _buildCustomWidgetsSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('6. Hình ảnh với các thuộc tính khác'),
            const SizedBox(height: 16),
            _buildImagePropertiesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildLocalImageSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hình ảnh từ thư mục assets:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            // Lưu ý: Cần thêm hình ảnh vào thư mục assets/images/
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/sample_image.jpg', // Thay đổi tên file theo thực tế
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image_not_supported,
                                size: 40, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Không tìm thấy hình ảnh',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Code:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Image.asset(\n  "assets/images/sample_image.jpg",\n  fit: BoxFit.cover,\n)',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkImageSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hình ảnh từ URL (không có cache):',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://picsum.photos/200/150?random=1',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error, size: 40, color: Colors.red),
                            SizedBox(height: 8),
                            Text('Lỗi tải hình ảnh',
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Code:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Image.network(\n  "https://picsum.photos/200/150",\n  fit: BoxFit.cover,\n  loadingBuilder: (context, child, progress) {\n    // Hiển thị loading\n  },\n  errorBuilder: (context, error, stack) {\n    // Hiển thị lỗi\n  },\n)',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCachedImageSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hình ảnh với cache (CachedNetworkImage):',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.download_done, size: 40, color: Colors.blue),
                        SizedBox(height: 8),
                        Text('Cần cài đặt\ncached_network_image',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Để sử dụng cache, cần thêm dependency:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'dependencies:\n  cached_network_image: ^3.3.0\n\n# Sử dụng:\nCachedNetworkImage(\n  imageUrl: "https://example.com/image.jpg",\n  placeholder: (context, url) => CircularProgressIndicator(),\n  errorWidget: (context, url, error) => Icon(Icons.error),\n)',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWithPlaceholderSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hình ảnh với placeholder và error handling:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('Loading State:',
                          style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      const Text('Error State:',
                          style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.error,
                                  color: Colors.red, size: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Code với placeholder và error:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Image.network(\n  imageUrl,\n  loadingBuilder: (context, child, progress) {\n    if (progress == null) return child;\n    return Center(child: CircularProgressIndicator());\n  },\n  errorBuilder: (context, error, stack) {\n    return Center(child: Icon(Icons.error));\n  },\n)',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePropertiesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Các thuộc tính quan trọng:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            _buildPropertyItem('fit',
                'BoxFit.cover, BoxFit.contain, BoxFit.fill, BoxFit.fitWidth, BoxFit.fitHeight'),
            _buildPropertyItem(
                'width & height', 'Kích thước cố định cho hình ảnh'),
            _buildPropertyItem(
                'color & colorBlendMode', 'Tô màu và blend mode'),
            _buildPropertyItem(
                'repeat', 'ImageRepeat.noRepeat, ImageRepeat.repeat'),
            _buildPropertyItem(
                'alignment', 'Alignment.center, Alignment.topLeft, etc.'),
            _buildPropertyItem(
                'filterQuality', 'FilterQuality.low, FilterQuality.high'),
            _buildPropertyItem('cacheWidth & cacheHeight',
                'Kích thước cache cho network images'),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomWidgetsSection() {
    final sampleImageUrls = [
      'https://picsum.photos/200/200?random=1',
      'https://picsum.photos/200/200?random=2',
      'https://picsum.photos/200/200?random=3',
      'https://picsum.photos/200/200?random=4',
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Các widget tùy chỉnh với cache:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            // Avatar
            const Text('1. CachedAvatar:',
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              children: [
                CachedAvatar(
                  imageUrl: sampleImageUrls[0],
                  size: 60,
                ),
                const SizedBox(width: 16),
                const CachedAvatar(
                  imageUrl: 'https://invalid-url.com/image.jpg',
                  size: 60,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Gallery
            const Text('2. CachedImageGallery:',
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: CachedImageGallery(
                imageUrls: sampleImageUrls,
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                itemWidth: 100,
                itemHeight: 100,
              ),
            ),
            const SizedBox(height: 16),

            // Hero Image
            const Text('3. CachedHeroImage:',
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            CachedHeroImage(
              imageUrl: sampleImageUrls[0],
              heroTag: 'demo_hero',
              width: 150,
              height: 100,
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                // Có thể mở màn hình chi tiết với Hero animation
                print('Hero image tapped');
              },
            ),
            const SizedBox(height: 16),

            const Text(
              'Code sử dụng:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '// Avatar\nCachedAvatar(imageUrl: url, size: 60)\n\n// Gallery\nCachedImageGallery(imageUrls: urls)\n\n// Hero Image\nCachedHeroImage(imageUrl: url, heroTag: "tag")',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyItem(String property, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              property,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
