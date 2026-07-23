import 'package:flutter/material.dart';
import '../../design_system/theme/app_colors.dart';
import 'shared/hover_tracking.dart';

final class FooterLinkWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const FooterLinkWidget({super.key, required this.title, required this.onTap});

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
