import 'package:flutter/material.dart';
import 'shared/hover_tracking.dart';
import '../../design_system/asset_paths/app_assets.dart';
import '../../design_system/theme/app_colors.dart';
import '../../domain/entities/reading_entity.dart';

class ReadingsSectionWidget extends StatelessWidget {
  final List<ReadingEntity> readings;

  const ReadingsSectionWidget({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;
    final paddingHorizontal = isDesktop ? 64.0 : 20.0;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 96,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INTELLECTUAL GROWTH',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.secondary,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Curated Professional Readings',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 64),

              // Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = isDesktop
                      ? 4
                      : (MediaQuery.of(context).size.width >= 500 ? 2 : 1);
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: readings.length,
                    itemBuilder: (context, index) {
                      return _BookCard(reading: readings[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookCard extends StatefulWidget {
  final ReadingEntity reading;

  const _BookCard({required this.reading});

  @override
  State<_BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<_BookCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return HoverTracking(
      builder: (context, isHovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.outlineVariant,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Aspect Ratio Container
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ColorFiltered(
                  colorFilter: isHovered
                      ? const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.dst,
                        )
                      : const ColorFilter.matrix(<double>[
                          0.2126,
                          0.7152,
                          0.0722,
                          0,
                          0,
                          0.2126,
                          0.7152,
                          0.0722,
                          0,
                          0,
                          0.2126,
                          0.7152,
                          0.0722,
                          0,
                          0,
                          0,
                          0,
                          0,
                          1,
                          0,
                        ]),
                  child: Image.asset(
                    widget.reading.imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        AppAssets.bookPlaceholder,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Book Title
            Text(
              widget.reading.title,
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
              widget.reading.author,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
