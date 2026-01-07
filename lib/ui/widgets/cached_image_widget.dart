import 'package:flutter/material.dart';

/// Widget tùy chỉnh để hiển thị hình ảnh với cache
/// Tương tự FastImage trong React Native
class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final bool useOldImageOnUrlChange;

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.fadeOutDuration = const Duration(milliseconds: 300),
    this.memCacheWidth,
    this.memCacheHeight,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.useOldImageOnUrlChange = false,
  });

  @override
  Widget build(BuildContext context) {
    // Sử dụng Image.network với cache parameters
    // Trong thực tế, bạn sẽ sử dụng CachedNetworkImage
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: memCacheWidth,
        cacheHeight: memCacheHeight,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ?? _buildDefaultPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildDefaultErrorWidget();
        },
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: fadeInDuration,
            curve: Curves.easeInOut,
            child: child,
          );
        },
      ),
    );
  }

  Widget _buildDefaultPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Widget _buildDefaultErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              'Lỗi tải hình ảnh',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget Avatar với cache
class CachedAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CachedAvatar({
    super.key,
    required this.imageUrl,
    this.size = 50,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedImageWidget(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: placeholder ?? _buildAvatarPlaceholder(),
        errorWidget: errorWidget ?? _buildAvatarErrorWidget(),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      width: size,
      height: size,
      color: Colors.grey[300],
      child: Icon(
        Icons.person,
        color: Colors.grey[600],
        size: size * 0.5,
      ),
    );
  }

  Widget _buildAvatarErrorWidget() {
    return Container(
      width: size,
      height: size,
      color: Colors.grey[300],
      child: Icon(
        Icons.person,
        color: Colors.grey[600],
        size: size * 0.5,
      ),
    );
  }
}

/// Widget Gallery với lazy loading
class CachedImageGallery extends StatelessWidget {
  final List<String> imageUrls;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double? itemWidth;
  final double? itemHeight;
  final BorderRadius? borderRadius;

  const CachedImageGallery({
    super.key,
    required this.imageUrls,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.itemWidth,
    this.itemHeight,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: itemWidth != null && itemHeight != null
            ? itemWidth! / itemHeight!
            : 1.0,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          child: CachedImageWidget(
            imageUrl: imageUrls[index],
            width: itemWidth,
            height: itemHeight,
            fit: BoxFit.cover,
            placeholder: _buildGalleryPlaceholder(),
            errorWidget: _buildGalleryErrorWidget(),
          ),
        );
      },
    );
  }

  Widget _buildGalleryPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Widget _buildGalleryErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 24,
        ),
      ),
    );
  }
}

/// Widget Hero Image với cache
class CachedHeroImage extends StatelessWidget {
  final String imageUrl;
  final String heroTag;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const CachedHeroImage({
    super.key,
    required this.imageUrl,
    required this.heroTag,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: CachedImageWidget(
              imageUrl: imageUrl,
              width: width,
              height: height,
              fit: fit,
              placeholder: _buildHeroPlaceholder(),
              errorWidget: _buildHeroErrorWidget(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Widget _buildHeroErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              'Lỗi tải hình ảnh',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
