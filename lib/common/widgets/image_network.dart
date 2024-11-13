import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl ?? '',
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: frame == null ? 0 : 1,
          child: child,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.error,
          color: Colors.grey,
        );
      },
    );
  }
}
