import 'package:flutter/material.dart';
import '../../../design_system/theme/app_colors.dart';
import '../shared/hover_tracking.dart';

final class NavLinkWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const NavLinkWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverTracking(
      builder: (context, isHovered) => GestureDetector(
        onTap: onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: isHovered ? AppColors.onSurface : AppColors.onSurfaceVariant,
            fontWeight: isHovered ? FontWeight.w600 : FontWeight.w400,
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
