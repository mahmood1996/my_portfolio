import 'package:flutter/material.dart';

import '../../../design_system/asset_paths/app_assets.dart';
import '../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/reading_entity.dart';

final class BookCardWidget extends StatelessWidget {
  final ReadingEntity reading;

  const BookCardWidget({super.key, required this.reading});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Aspect Ratio Container
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                reading.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppAssets.bookPlaceholder,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Book Title
          Text(
            reading.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),

          // Author
          Text(
            reading.author,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
