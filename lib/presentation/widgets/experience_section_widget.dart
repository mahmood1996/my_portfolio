import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../design_system/theme/app_colors.dart';
import '../../domain/entities/experience_entity.dart';
import 'experience_card_mobile_widget.dart';
import 'experience_content_widget.dart';
import 'shared/responsive_section_widget.dart';

final class ExperienceSectionWidget extends StatelessWidget {
  final List<ExperienceEntity> experiences;

  const ExperienceSectionWidget({super.key, required this.experiences});

  IconData _getIconData(String name) {
    switch (name) {
      case 'corporate_fare':
        return Icons.business;
      case 'rocket_launch':
        return Icons.rocket_launch;
      case 'devices':
      default:
        return Icons.devices;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSectionWidget(
      child: Column(
        children: [
          // Header
          Text(
            'MY JOURNEY',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.primary,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Professional Impact & Evolution',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),

          // Timeline List
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              final isDesktop = sizingInformation.isDesktop;

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                      icon: _getIconData(item.iconName),
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
                          _getIconData(item.iconName),
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
}
