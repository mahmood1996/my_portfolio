import 'package:flutter/material.dart';

import '../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/project_entity.dart';

import 'project_card_widget.dart';
import '../shared/sliver_responsive_builder.dart';
import '../shared/sliver_responsive_section.dart';

final class SliverProjectsSection extends StatelessWidget {
  final List<ProjectEntity> projects;

  const SliverProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return SliverResponsiveSection(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.sectionBorder)),
      ),
      sliver: SliverMainAxisGroup(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Text(
              'PORTFOLIO',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.secondary,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: Text(
              'Featured Solutions',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'A selection of high-impact applications where architectural precision meets exceptional user experience.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 64)),

          // Cards Grid
          SliverResponsiveBuilder(
            builder: (context, sizingInformation) {
              final isDesktop = sizingInformation.isDesktop;
              final crossAxisCount = isDesktop ? 2 : 1;

              return SliverGrid.builder(
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
                    icon: _iconData(project.iconName),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _iconData(String name) =>
      name == 'account_balance' ? Icons.account_balance : Icons.insights;
}
