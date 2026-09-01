import 'package:flutter/material.dart';

/**
 * Show image from internet URL
 * 1. Pending: Show indicator loading
 * 2. failed to load: show another icon
 */
class FlowerNetworkImages extends StatelessWidget {
  const FlowerNetworkImages({
    super.key,
    required this.imageUrl,
    required this.fallbackIcon,
    required this.fallbackColor,
    required this.fit,
  });

  final String imageUrl;
  final IconData fallbackIcon;
  final Color fallbackColor;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      // Loading indicator that will run repeatedly as the image still in download process from the internet
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _Placeholder(
          color: fallbackColor,
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: fallbackColor,
              // if flutter know the total size of the file then it will count the process of image download 
              // if flutter doesn't know the total of the file size then it will return null
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      // errorBuilder that will be called if the process above (image loading) all failed totally
      errorBuilder: (context, error, stackTrace) {
        return _Placeholder(
          color: fallbackColor,
          child: Icon(fallbackIcon, size: 48, color: fallbackColor,),
        );
      },
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withValues(alpha: 0.18),
      alignment: Alignment.center,
      child: child,
    );
  }
}
