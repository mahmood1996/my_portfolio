import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
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
      textTheme: TextTheme(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 64,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
          letterSpacing: -1.28,
          height: 72 / 64,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
          letterSpacing: -0.8,
          height: 48 / 40,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
          height: 40 / 32,
        ),
        headlineSmall: GoogleFonts.plusJakartaSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
          height: 32 / 24,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceVariant,
          height: 28 / 18,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceVariant,
          height: 24 / 16,
        ),
        labelLarge: GoogleFonts.spaceGrotesk(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.secondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
