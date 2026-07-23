import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../design_system/theme/app_colors.dart';
import '../../domain/entities/project_entity.dart';
import 'project_card_widget.dart';
import 'shared/responsive_section_widget.dart';

final class ProjectsSectionWidget extends StatelessWidget {
  final List<ProjectEntity> projects;

  const ProjectsSectionWidget({super.key, required this.projects});

  IconData _getIcon(String name) =>
      name == 'account_balance' ? Icons.account_balance : Icons.insights;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSectionWidget(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.sectionBorder)),
      ),
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
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              final isDesktop = sizingInformation.isDesktop;
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
                  return ProjectCardWidget(
                    project: project,
                    icon: _getIcon(project.iconName),
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
