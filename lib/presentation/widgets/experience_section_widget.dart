import 'package:flutter/material.dart';
import '../../design_system/theme/app_colors.dart';
import '../../domain/entities/experience_entity.dart';

class ExperienceSectionWidget extends StatelessWidget {
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
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 48),
                itemBuilder: (context, index) {
                  final item = experiences[index];
                  final isEven = index.isEven;

                  if (!isDesktop) {
                    // Mobile Layout: simple left-bordered card
                    return _ExperienceCardMobile(
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
                            ? _ExperienceContent(item: item, alignRight: true)
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
                            ? _ExperienceContent(item: item, alignRight: false)
                            : const SizedBox(),
                      ),
                    ],
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

class _ExperienceContent extends StatelessWidget {
  final ExperienceEntity item;
  final bool alignRight;

  const _ExperienceContent({required this.item, required this.alignRight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignRight
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          item.period,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: item.isHighlight ? AppColors.secondary : AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.title,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
        const SizedBox(height: 12),
        Text(
          item.description,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
      ],
    );
  }
}

class _ExperienceCardMobile extends StatelessWidget {
  final ExperienceEntity item;
  final IconData icon;

  const _ExperienceCardMobile({required this.item, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.period,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: item.isHighlight
                      ? AppColors.secondary
                      : AppColors.primary,
                ),
              ),
              Icon(icon, size: 20, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 12),
          Text(item.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(item.description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
