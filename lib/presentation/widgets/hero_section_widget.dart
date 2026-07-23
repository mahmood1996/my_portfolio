import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../design_system/asset_paths/app_assets.dart';
import '../../design_system/theme/app_colors.dart';
import 'shared/responsive_section_widget.dart';

final class HeroSectionWidget extends StatelessWidget {
  final VoidCallback onExploreWork;
  final VoidCallback onPartnerWithMe;

  const HeroSectionWidget({
    super.key,
    required this.onExploreWork,
    required this.onPartnerWithMe,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop = sizingInformation.isDesktop;
        final verticalPadding = isDesktop ? 96.0 : 48.0;

        return ResponsiveSectionWidget(
          verticalPadding: verticalPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Content
              Expanded(
                flex: isDesktop ? 7 : 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tagline
                    Text(
                      'STRATEGIC MOBILE ENGINEERING',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.gold,
                        letterSpacing: 2.0,
                        shadows: [
                          const Shadow(color: AppColors.gold, blurRadius: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Main Headline
                    RichText(
                      text: TextSpan(
                        style: isDesktop
                            ? Theme.of(context).textTheme.displayLarge
                            : Theme.of(context).textTheme.displayMedium,
                        children: const [
                          TextSpan(text: 'Building High-Performance '),
                          TextSpan(
                            text: 'Mobile Experiences',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Bio Text
                    Text(
                      'I specialize in architecting resilient, scalable Flutter applications for enterprise ecosystems. My approach bridges executive vision with high-fidelity technical execution.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 36),

                    // Action Buttons
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ElevatedButton(
                          onPressed: onExploreWork,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Explore My Work',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: onPartnerWithMe,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.onSurface,
                            side: const BorderSide(
                              color: AppColors.outlineVariant,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Partner With Me',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (isDesktop) const SizedBox(width: 48),

              // Right Image (Desktop)
              if (isDesktop)
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.outlineVariant.withValues(
                            alpha: 0.3,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            blurRadius: 100,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          AppAssets.heroProfile,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.surfaceContainer,
                              child: const Icon(
                                Icons.person,
                                size: 80,
                                color: AppColors.onSurfaceVariant,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
