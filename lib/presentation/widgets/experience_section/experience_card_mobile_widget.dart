import 'package:flutter/material.dart';
import '../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/experience_entity.dart';

final class ExperienceCardMobileWidget extends StatelessWidget {
  final ExperienceEntity item;
  final IconData icon;

  const ExperienceCardMobileWidget({
    super.key,
    required this.item,
    required this.icon,
  });

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
