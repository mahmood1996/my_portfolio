import 'package:flutter/material.dart';
import '../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/experience_entity.dart';

final class ExperienceContentWidget extends StatelessWidget {
  final ExperienceEntity item;
  final bool alignRight;

  const ExperienceContentWidget({
    super.key,
    required this.item,
    required this.alignRight,
  });

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
