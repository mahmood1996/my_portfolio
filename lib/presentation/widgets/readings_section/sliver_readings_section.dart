import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../l10n/app_localizations.dart';

import '../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/reading_entity.dart';

import 'book_card_widget.dart';
import '../shared/sliver_responsive_builder.dart';
import '../shared/sliver_responsive_section.dart';

final class SliverReadingsSection extends StatelessWidget {
  final List<ReadingEntity> readings;

  const SliverReadingsSection({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SliverResponsiveSection(
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              l10n.readingsSectionTag,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.secondary,
                letterSpacing: 2.0,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          SliverToBoxAdapter(
            child: Text(
              l10n.readingsSectionTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 64)),

          // Grid
          SliverResponsiveBuilder(
            builder: (context, sizingInformation) {
              final crossAxisCount = getValueForScreenType<int>(
                context: context,
                mobile: 2,
                tablet: 3,
                desktop: 5,
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
