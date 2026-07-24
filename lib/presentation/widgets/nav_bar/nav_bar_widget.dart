import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../l10n/app_localizations.dart';
import '../../../design_system/theme/app_colors.dart';
import '../../../design_system/theme/app_fonts.dart';
import '../../bloc/portfolio_bloc.dart';
import '../../bloc/portfolio_event.dart';
import 'nav_link_widget.dart';

final class NavBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Function(String sectionKey) onNavSelected;

  const NavBarWidget({super.key, required this.onNavSelected});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop = sizingInformation.isDesktop;
        final paddingHorizontal = getValueForScreenType<double>(
          context: context,
          mobile: 20.0,
          tablet: 32.0,
          desktop: 64.0,
        );

        return Container(
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.85),
            border: const Border(
              bottom: BorderSide(color: AppColors.navBarBorder, width: 1),
            ),
          ),
          child: SafeArea(
            child: Container(
              height: 72,
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      l10n.authorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.gold,
                        fontFamily: AppFonts.allura,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        shadows: [
                          const Shadow(color: AppColors.gold, blurRadius: 30),
                        ],
                      ),
                    ),
                  ),

                  // Desktop Links
                  if (isDesktop)
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            NavLinkWidget(
                              title: l10n.navAbout,
                              onTap: () => onNavSelected('about'),
                            ),
                            const SizedBox(width: 24),
                            NavLinkWidget(
                              title: l10n.navExperience,
                              onTap: () => onNavSelected('experience'),
                            ),
                            const SizedBox(width: 24),
                            NavLinkWidget(
                              title: l10n.navProjects,
                              onTap: () => onNavSelected('projects'),
                            ),
                            const SizedBox(width: 24),
                            NavLinkWidget(
                              title: l10n.navSkills,
                              onTap: () => onNavSelected('skills'),
                            ),
                            const SizedBox(width: 24),
                            NavLinkWidget(
                              title: l10n.navReadings,
                              onTap: () => onNavSelected('readings'),
                            ),
                            const SizedBox(width: 24),
                            NavLinkWidget(
                              title: l10n.navContact,
                              onTap: () => onNavSelected('contact'),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Download CV Button
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<PortfolioBloc>().add(DownloadCVEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onPrimary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          l10n.downloadCv,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      if (!isDesktop)
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.menu, color: AppColors.onSurface),
                          color: AppColors.surfaceContainerHigh,
                          onSelected: onNavSelected,
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'about',
                              child: Text(l10n.navAbout),
                            ),
                            PopupMenuItem(
                              value: 'experience',
                              child: Text(l10n.navExperience),
                            ),
                            PopupMenuItem(
                              value: 'projects',
                              child: Text(l10n.navProjects),
                            ),
                            PopupMenuItem(
                              value: 'skills',
                              child: Text(l10n.navSkills),
                            ),
                            PopupMenuItem(
                              value: 'readings',
                              child: Text(l10n.navReadings),
                            ),
                            PopupMenuItem(
                              value: 'contact',
                              child: Text(l10n.navContact),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
