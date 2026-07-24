import 'package:flutter/material.dart';
import '../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/skill_entity.dart';
import '../shared/hover_tracking.dart';

final class SkillBadgeWidget extends StatelessWidget {
  final SkillEntity skill;
  final IconData icon;

  const SkillBadgeWidget({super.key, required this.skill, required this.icon});

  @override
  Widget build(BuildContext context) {
    final color = skill.isSecondaryColor
        ? AppColors.secondary
        : AppColors.primary;

    return HoverTracking(
      builder: (context, isHovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 180,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? color.withValues(alpha: 0.5)
                : AppColors.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            AnimatedScale(
              scale: isHovered ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Icon(icon, size: 36, color: color),
            ),
            const SizedBox(height: 16),
            Text(
              skill.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
