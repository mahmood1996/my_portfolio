import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppFonts.inter,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: AppFonts.plusJakartaSans,
          fontSize: 64,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
          letterSpacing: -1.28,
          height: 72 / 64,
        ),
        displayMedium: TextStyle(
          fontFamily: AppFonts.plusJakartaSans,
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
          letterSpacing: -0.8,
          height: 48 / 40,
        ),
        headlineMedium: TextStyle(
          fontFamily: AppFonts.plusJakartaSans,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
          height: 40 / 32,
        ),
        headlineSmall: TextStyle(
          fontFamily: AppFonts.plusJakartaSans,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
          height: 32 / 24,
        ),
        bodyLarge: TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceVariant,
          height: 28 / 18,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceVariant,
          height: 24 / 16,
        ),
        labelLarge: TextStyle(
          fontFamily: AppFonts.spaceGrotesk,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.secondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

