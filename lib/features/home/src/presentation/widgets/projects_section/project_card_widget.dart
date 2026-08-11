import 'package:flutter/material.dart';

import '../../../../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/project_entity.dart';
import '../shared/hover_tracking.dart';
import 'in_progress_label.dart';
import 'project_cover_image.dart';
import 'stores_buttons.dart';

final class ProjectCardWidget extends StatelessWidget {
  final ProjectEntity project;
  final IconData icon;

  const ProjectCardWidget({
    super.key,
    required this.project,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isSecondary = project.category.contains('HealthTech');

    return HoverTracking(
      builder: (context, isHovered) {
        return Container(
          padding: const EdgeInsets.all(20),
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
            children: [
              Expanded(
                child: ProjectCoverImage(
                  url: project.coverImage,
                  isHovered: isHovered,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    project.category.toUpperCase(),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isSecondary
                          ? AppColors.secondary
                          : AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    icon,
                    size: 24,
                    color: isSecondary
                        ? AppColors.secondary
                        : AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                project.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                project.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),

              // Download store links or In Progress label
              project.isInProduction
                  ? StoresButtons(project: project)
                  : const Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: InProgressLabel(),
                    ),
            ],
          ),
        );
      },
    );
  }
}
