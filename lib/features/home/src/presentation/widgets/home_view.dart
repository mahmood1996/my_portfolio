import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../design_system/theme/app_colors.dart';

import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';

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
  final ScrollController _scrollController = ScrollController();

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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        alignment: 1.0,
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
      body: BlocConsumer<PortfolioBloc, PortfolioState>(
        listener: (context, state) {
          if (state.toastNotification != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.toastNotification!),
                backgroundColor: AppColors.surfaceContainerHigh,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
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
            controller: _scrollController,
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

              KeyedSubtree(
                key: _experienceKey,
                child: SliverExperienceSection(experiences: data.experiences),
              ),

              KeyedSubtree(
                key: _projectsKey,
                child: SliverProjectsSection(projects: data.projects),
              ),

              KeyedSubtree(
                key: _skillsKey,
                child: SliverToBoxAdapter(
                  child: SkillsSectionWidget(skills: data.skills),
                ),
              ),

              KeyedSubtree(
                key: _readingsKey,
                child: SliverReadingsSection(readings: data.readings),
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
    );
  }
}
