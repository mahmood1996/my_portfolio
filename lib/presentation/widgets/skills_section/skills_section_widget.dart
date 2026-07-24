import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/skill_entity.dart';
import '../shared/responsive_section_widget.dart';
import 'skill_badge_widget.dart';

final class SkillsSectionWidget extends StatelessWidget {
  final List<SkillEntity> skills;

  const SkillsSectionWidget({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveSectionWidget(
      backgroundColor: AppColors.surfaceContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.skillsSectionTag,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.primary,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.skillsSectionTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              l10n.skillsSectionSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 48),

          // Skills Cards
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: skills.map((skill) {
              return SkillBadgeWidget(
                skill: skill,
                icon: _iconData(skill.iconName),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _iconData(String name) => switch (name) {
    'flutter' => Icons.flutter_dash,
    'architecture' => Icons.architecture,
    'rule' => Icons.rule,
    'hub' => Icons.hub,
    'build_circle' => Icons.build_circle,
    _ => Icons.build,
  };
}
