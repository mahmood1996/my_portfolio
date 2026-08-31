import 'package:flutter/material.dart';

final class ProjectCoverImage extends StatelessWidget {
  const ProjectCoverImage({
    super.key,
    required this.url,
    required this.isHovered,
  });

  final String url;

  final bool isHovered;

  String get _formattedUrl {
    if (url.contains('lh3.googleusercontent.com/d/') && !url.contains('=')) {
      return '$url=w600';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AnimatedScale(
          scale: isHovered ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: Image.network(
            _formattedUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.broken_image_outlined, size: 80),
          ),
        ),
      ),
    );
  }
}
