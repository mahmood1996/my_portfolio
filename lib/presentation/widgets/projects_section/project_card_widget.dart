import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../l10n/app_localizations.dart';

import '../../../design_system/asset_paths/app_assets.dart';
import '../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/project_entity.dart';

import 'store_button_widget.dart';

final class ProjectCardWidget extends StatelessWidget {
  final ProjectEntity project;
  final IconData icon;

  const ProjectCardWidget({
    super.key,
    required this.project,
    required this.icon,
  });

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isSecondary = project.category.contains('HealthTech');

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: (isSecondary
              ? AppColors.secondary.withValues(alpha: 0.4)
              : AppColors.primary.withValues(alpha: 0.4)),
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
                  StoreButtonWidget(
                    label: l10n.appStore,
                    iconAsset: AppAssets.appStore,
                    onTap: () => _launch(project.appStoreUrl),
                  ),

                if (project.googlePlayUrl.isNotEmpty)
                  StoreButtonWidget(
                    label: l10n.playStore,
                    iconAsset: AppAssets.googlePlay,
                    onTap: () => _launch(project.googlePlayUrl),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
