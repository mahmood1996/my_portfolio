import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../design_system/theme/app_colors.dart';
import '../../domain/entities/reading_entity.dart';

import 'book_card_widget.dart';
import 'shared/sliver_responsive_builder.dart';
import 'shared/sliver_responsive_section.dart';

final class SliverReadingsSection extends StatelessWidget {
  final List<ReadingEntity> readings;

  const SliverReadingsSection({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    return SliverResponsiveSection(
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              'INTELLECTUAL GROWTH',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.secondary,
                letterSpacing: 2.0,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 12)),

          SliverToBoxAdapter(
            child: Text(
              'Curated Professional Readings',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 64)),

          // Grid
          SliverResponsiveBuilder(
            builder: (context, sizingInformation) {
              final crossAxisCount = getValueForScreenType<int>(
                context: context,
                mobile: 1,
                tablet: 2,
                desktop: 4,
              );

              return SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.65,
                ),
                itemCount: readings.length,
                itemBuilder: (context, index) =>
                    BookCardWidget(reading: readings[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
