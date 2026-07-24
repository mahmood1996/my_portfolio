import 'package:flutter/material.dart';

import '../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/experience_entity.dart';

import 'experience_card_mobile_widget.dart';
import 'experience_content_widget.dart';
import '../shared/sliver_responsive_builder.dart';
import '../shared/sliver_responsive_section.dart';

final class SliverExperienceSection extends StatelessWidget {
  final List<ExperienceEntity> experiences;

  const SliverExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    return SliverResponsiveSection(
      sliver: SliverMainAxisGroup(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Text(
              'MY JOURNEY',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primary,
                letterSpacing: 2.0,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          SliverToBoxAdapter(
            child: Text(
              'Professional Impact & Evolution',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 64)),

          // Timeline List
          SliverResponsiveBuilder(
            builder: (context, sizingInformation) {
              final isDesktop = sizingInformation.isDesktop;

              return SliverList.separated(
                itemCount: experiences.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 48),
                itemBuilder: (context, index) {
                  final item = experiences[index];
                  final isEven = index.isEven;

                  if (!isDesktop) {
                    // Mobile / Tablet Layout: left-bordered card
                    return ExperienceCardMobileWidget(
                      item: item,
                      icon: _iconData(item.iconName),
                    );
                  }

                  // Desktop Timeline Layout
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left Side
                      Expanded(
                        child: isEven
                            ? ExperienceContentWidget(
                                item: item,
                                alignRight: true,
                              )
                            : const SizedBox(),
                      ),

                      // Timeline Center Node
                      Container(
                        width: 48,
                        height: 48,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: item.isHighlight
                                ? AppColors.secondary
                                : (index == 1
                                      ? AppColors.primary
                                      : AppColors.outline),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          _iconData(item.iconName),
                          size: 20,
                          color: item.isHighlight
                              ? AppColors.secondary
                              : (index == 1
                                    ? AppColors.primary
                                    : AppColors.onSurfaceVariant),
                        ),
                      ),

                      // Right Side
                      Expanded(
                        child: !isEven
                            ? ExperienceContentWidget(
                                item: item,
                                alignRight: false,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _iconData(String name) => switch (name) {
    'corporate_fare' => Icons.business,
    'rocket_launch' => Icons.rocket_launch,
    _ => Icons.devices,
  };
}
