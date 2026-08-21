import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static const radius = 10.0;

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundPrimary,
      colorScheme: ColorScheme.light(
        primary: AppColors.backgroundQuaternary,
        secondary: AppColors.buttonAccent,
        surface: AppColors.backgroundPrimary,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.foregroundPrimary,
        error: AppColors.error,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.beVietnamProTextTheme(base.textTheme).apply(
        bodyColor: AppColors.foregroundPrimary,
        displayColor: AppColors.foregroundPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundPrimary,
        foregroundColor: AppColors.foregroundPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: AppColors.backgroundTertiary.withValues(alpha: 0.35)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColors.borderInput),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: AppColors.borderInput.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColors.ring, width: 1.5),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.backgroundTertiary.withValues(alpha: 0.5),
        thickness: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.backgroundSecondary,
        labelStyle: GoogleFonts.beVietnamPro(fontSize: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
