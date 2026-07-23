import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../design_system/theme/app_colors.dart';
import '../../domain/entities/reading_entity.dart';
import 'book_card_widget.dart';
import 'shared/responsive_section_widget.dart';

final class ReadingsSectionWidget extends StatelessWidget {
  final List<ReadingEntity> readings;

  const ReadingsSectionWidget({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSectionWidget(
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
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              final crossAxisCount = getValueForScreenType<int>(
                context: context,
                mobile: 1,
                tablet: 2,
                desktop: 4,
              );

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
                  return BookCardWidget(reading: readings[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
