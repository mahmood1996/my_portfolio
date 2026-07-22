import 'package:flutter/material.dart';
import '../../design_system/theme/app_colors.dart';
import '../../domain/entities/skill_entity.dart';
import 'shared/hover_tracking.dart';

class SkillsSectionWidget extends StatelessWidget {
  final List<SkillEntity> skills;

  const SkillsSectionWidget({super.key, required this.skills});

  IconData _getIcon(String name) {
    switch (name) {
      case 'flutter':
        return Icons.flutter_dash;
      case 'architecture':
        return Icons.architecture;
      case 'rule':
        return Icons.rule;
      case 'hub':
        return Icons.hub;
      case 'build_circle':
      default:
        return Icons.build_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;
    final paddingHorizontal = isDesktop ? 64.0 : 20.0;

    return Container(
      color: AppColors.surfaceContainer,
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
                'METHODOLOGY',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Expertise in Strategic Engineering',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  'My toolkit is curated for high-impact enterprise solutions, focusing on reliability, speed, and long-term maintainability.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 48),

              // Skills Cards
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: skills.map((skill) {
                  return _SkillBadge(
                    skill: skill,
                    icon: _getIcon(skill.iconName),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillBadge extends StatefulWidget {
  final SkillEntity skill;
  final IconData icon;

  const _SkillBadge({required this.skill, required this.icon});

  @override
  State<_SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<_SkillBadge> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.skill.isSecondaryColor
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
              child: Icon(widget.icon, size: 36, color: color),
            ),
            const SizedBox(height: 16),
            Text(
              widget.skill.title,
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
