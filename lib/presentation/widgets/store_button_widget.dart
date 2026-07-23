import 'package:flutter/material.dart';
import '../../design_system/theme/app_colors.dart';

final class StoreButtonWidget extends StatelessWidget {
  final String label;
  final String iconAsset;
  final VoidCallback onTap;

  const StoreButtonWidget({
    super.key,
    required this.label,
    required this.iconAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconAsset,
              width: 16,
              height: 16,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.shop, size: 16, color: AppColors.onSurface),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
