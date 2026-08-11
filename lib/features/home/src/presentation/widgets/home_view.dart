import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../design_system/theme/app_colors.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';
import '../cubit/download_cv_cubit.dart';
import '../cubit/download_cv_state.dart';
import 'contact_section/contact_section_widget.dart';
import 'experience_section/sliver_experience_section.dart';
import 'footer_section/footer_section_widget.dart';
import 'hero_section/hero_section_widget.dart';
import 'nav_bar/nav_bar_widget.dart';
import 'projects_section/sliver_projects_section.dart';
import 'readings_section/sliver_readings_section.dart';
import 'skills_section/skills_section_widget.dart';

final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

final class _HomeViewState extends State<HomeView> {
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _readingsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    context.read<PortfolioBloc>().add(LoadPortfolioDataEvent());
  }

  void _scrollToSection(String sectionKey) {
    final targetKey = switch (sectionKey) {
      'about' => _aboutKey,
      'skills' => _skillsKey,
      'contact' => _contactKey,
      'readings' => _readingsKey,
      'projects' => _projectsKey,
      'experience' => _experienceKey,
      _ => null,
    };

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: BlocListener<DownloadCVCubit, DownloadCVState>(
        listener: (context, state) {
          if (state.status == DownloadCVStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.surfaceContainerHigh,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },

        child: BlocBuilder<PortfolioBloc, PortfolioState>(
          builder: (context, state) {
            return switch ((state.isLoading, state.errorMessage, state.data)) {
              (true, _, _) => const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),

              (false, String errorMessage, null) => Center(
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

              (false, null, PortfolioData data) => CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: 72,
                    collapsedHeight: 72,
                    backgroundColor: AppColors.background,
                    surfaceTintColor: AppColors.background,
                    flexibleSpace: NavBarWidget(
                      onNavSelected: _scrollToSection,
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      key: _aboutKey,
                      child: HeroSectionWidget(
                        about: data.about,
                        onExploreWork: () => _scrollToSection('projects'),
                        onPartnerWithMe: () => _scrollToSection('contact'),
                      ),
                    ),
                  ),

                  SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(key: _experienceKey, height: 1),
                      ),

                      SliverExperienceSection(experiences: data.experiences),
                    ],
                  ),

                  SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(key: _projectsKey, height: 1),
                      ),

                      SliverProjectsSection(projects: data.projects),
                    ],
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      key: _skillsKey,

                      child: SkillsSectionWidget(skills: data.skills),
                    ),
                  ),

                  SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(key: _readingsKey, height: 1),
                      ),

                      SliverReadingsSection(readings: data.readings),
                    ],
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      key: _contactKey,
                      child: ContactSectionWidget(contactInfo: data.contact),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: FooterSectionWidget(onNavSelected: _scrollToSection),
                  ),
                ],
              ),

              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
