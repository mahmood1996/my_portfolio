import 'package:flutter/material.dart';

import 'shared/hover_tracking.dart';
import '../../design_system/theme/app_colors.dart';

class FooterSectionWidget extends StatelessWidget {
  final Function(String sectionKey) onNavSelected;

  const FooterSectionWidget({super.key, required this.onNavSelected});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 768;
    final paddingHorizontal = isDesktop ? 64.0 : 20.0;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 64,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.cardBorder)),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
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
                          'SENIOR FLUTTER ARCHITECT',
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
                            'Building the future of enterprise mobile development through strategic engineering.',
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
                        _FooterLink(title: 'LinkedIn', onTap: () {}),
                        const SizedBox(width: 24),
                        _FooterLink(title: 'GitHub', onTap: () {}),
                        const SizedBox(width: 24),
                        _FooterLink(title: 'GitLab', onTap: () {}),
                        const SizedBox(width: 24),
                        _FooterLink(
                          title: 'Contact',
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
                          '© 2024 Senior Flutter Architect. All rights reserved.',
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
                    _FooterLink(title: 'LinkedIn', onTap: () {}),
                    _FooterLink(title: 'GitHub', onTap: () {}),
                    _FooterLink(title: 'GitLab', onTap: () {}),
                    _FooterLink(
                      title: 'Contact',
                      onTap: () => onNavSelected('contact'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  '© 2024 Senior Flutter Architect. All rights reserved.',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FooterLink({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return HoverTracking(
      builder: (context, isHovered) => GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isHovered ? AppColors.secondary : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
