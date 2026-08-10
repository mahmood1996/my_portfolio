import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

import '../../../../../design_system/theme/app_colors.dart';

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
    GlobalKey? targetKey;
    switch (sectionKey) {
      case 'about':
        targetKey = _aboutKey;
        break;
      case 'experience':
        targetKey = _experienceKey;
        break;
      case 'projects':
        targetKey = _projectsKey;
        break;
      case 'skills':
        targetKey = _skillsKey;
        break;
      case 'readings':
        targetKey = _readingsKey;
        break;
      case 'contact':
        targetKey = _contactKey;
        break;
    }

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
      appBar: NavBarWidget(onNavSelected: _scrollToSection),
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
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

          if (state.errorMessage != null && state.data == null) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = state.data;

          if (data == null) return const SizedBox.shrink();

          return CustomScrollView(
            slivers: [
              KeyedSubtree(
                key: _aboutKey,
                child: SliverToBoxAdapter(
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
                    child: KeyedSubtree(
                      key: _experienceKey,
                      child: SizedBox(height: 1),
                    ),
                  ),

                  SliverExperienceSection(experiences: data.experiences),
                ],
              ),

              SliverMainAxisGroup(
                slivers: [
                  KeyedSubtree(key: _projectsKey, child: SliverToBoxAdapter()),

                  SliverProjectsSection(projects: data.projects),
                ],
              ),

              KeyedSubtree(
                key: _skillsKey,
                child: SliverToBoxAdapter(
                  child: SkillsSectionWidget(skills: data.skills),
                ),
              ),

              SliverMainAxisGroup(
                slivers: [
                  KeyedSubtree(key: _readingsKey, child: SliverToBoxAdapter()),

                  SliverReadingsSection(readings: data.readings),
                ],
              ),

              KeyedSubtree(
                key: _contactKey,
                child: SliverToBoxAdapter(
                  child: ContactSectionWidget(contactInfo: data.contact),
                ),
              ),

              SliverToBoxAdapter(
                child: FooterSectionWidget(onNavSelected: _scrollToSection),
              ),
            ],
          );
        },
      ),
    ),
  );
}
}
