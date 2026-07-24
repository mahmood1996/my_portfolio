import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../l10n/app_localizations.dart';
import '../../../design_system/theme/app_colors.dart';
import 'footer_link_widget.dart';
import '../shared/responsive_section_widget.dart';

final class FooterSectionWidget extends StatelessWidget {
  final Function(String sectionKey) onNavSelected;

  const FooterSectionWidget({super.key, required this.onNavSelected});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop = sizingInformation.isDesktop;

        return ResponsiveSectionWidget(
          verticalPadding: 64,
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(top: BorderSide(color: AppColors.cardBorder)),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Brand
                  Expanded(
                    flex: isDesktop ? 4 : 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.footerRole,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppColors.onSurfaceVariant,
                                letterSpacing: 1.5,
                              ),
                        ),
                        const SizedBox(height: 12),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 320),
                          child: Text(
                            l10n.footerTagline,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Center Links (Desktop)
                  if (isDesktop)
                    Row(
                      children: [
                        FooterLinkWidget(title: l10n.socialLinkedIn, onTap: () {}),
                        const SizedBox(width: 24),
                        FooterLinkWidget(title: l10n.socialGitHub, onTap: () {}),
                        const SizedBox(width: 24),
                        FooterLinkWidget(title: l10n.socialGitLab, onTap: () {}),
                        const SizedBox(width: 24),
                        FooterLinkWidget(
                          title: l10n.navContact,
                          onTap: () => onNavSelected('contact'),
                        ),
                      ],
                    ),

                  // Right Copyright & Icons
                  if (isDesktop)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          l10n.footerCopyright,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.language,
                              color: AppColors.outlineVariant,
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.verified,
                              color: AppColors.outlineVariant,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),

              if (!isDesktop) ...[
                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FooterLinkWidget(title: l10n.socialLinkedIn, onTap: () {}),
                    FooterLinkWidget(title: l10n.socialGitHub, onTap: () {}),
                    FooterLinkWidget(title: l10n.socialGitLab, onTap: () {}),
                    FooterLinkWidget(
                      title: l10n.navContact,
                      onTap: () => onNavSelected('contact'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.footerCopyright,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
