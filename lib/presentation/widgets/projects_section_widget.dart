import 'package:flutter/material.dart';
import 'shared/hover_tracking.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../design_system/asset_paths/app_assets.dart';
import '../../design_system/theme/app_colors.dart';
import '../../domain/entities/project_entity.dart';

class ProjectsSectionWidget extends StatelessWidget {
  final List<ProjectEntity> projects;

  const ProjectsSectionWidget({super.key, required this.projects});

  IconData _getIcon(String name) {
    if (name == 'account_balance') return Icons.account_balance;
    return Icons.insights;
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
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.sectionBorder)),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'PORTFOLIO',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.secondary,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Featured Solutions',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  'A selection of high-impact applications where architectural precision meets exceptional user experience.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 64),

              // Cards Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = isDesktop ? 2 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 32,
                      mainAxisSpacing: 32,
                      childAspectRatio: isDesktop ? 1.25 : 0.85,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return _ProjectCard(
                        project: project,
                        icon: _getIcon(project.iconName),
                      );
                    },
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

class _ProjectCard extends StatelessWidget {
  final ProjectEntity project;
  final IconData icon;

  const _ProjectCard({required this.project, required this.icon});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSecondary = project.category.contains('HealthTech');

    return HoverTracking(
      builder: (context, isHovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isHovered
              ? AppColors.surfaceContainerHigh
              : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isHovered
                ? (isSecondary
                      ? AppColors.secondary.withValues(alpha: 0.4)
                      : AppColors.primary.withValues(alpha: 0.4))
                : AppColors.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project.category.toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isSecondary
                            ? AppColors.secondary
                            : AppColors.primary,
                      ),
                    ),
                    Icon(
                      icon,
                      size: 32,
                      color: isSecondary
                          ? AppColors.secondary
                          : AppColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  project.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            // Download store links
            if (project.appStoreUrl.isNotEmpty ||
                project.googlePlayUrl.isNotEmpty)
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  if (project.appStoreUrl.isNotEmpty)
                    _StoreButton(
                      label: 'App Store',
                      iconAsset: AppAssets.appStore,
                      onTap: () => _launch(project.appStoreUrl),
                    ),

                  if (project.googlePlayUrl.isNotEmpty)
                    _StoreButton(
                      label: 'Play Store',
                      iconAsset: AppAssets.googlePlay,
                      onTap: () => _launch(project.googlePlayUrl),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _StoreButton extends StatelessWidget {
  final String label;
  final String iconAsset;
  final VoidCallback onTap;

  const _StoreButton({
    required this.label,
    required this.iconAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconAsset,
              width: 16,
              height: 16,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.shop, size: 16, color: AppColors.onSurface),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
