import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static TextStyle get logo => GoogleFonts.instrumentSerif(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: AppColors.foregroundPrimary,
      );

  static TextStyle get title => GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.foregroundPrimary,
      );

  static TextStyle get titleLarge => GoogleFonts.playfairDisplay(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: AppColors.foregroundPrimary,
      );

  static TextStyle get headline => GoogleFonts.beVietnamPro(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.foregroundPrimary,
      );

  static TextStyle get body => GoogleFonts.beVietnamPro(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.foregroundPrimary,
      );

  static TextStyle get bodySecondary => GoogleFonts.beVietnamPro(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.foregroundSecondary,
      );

  static TextStyle get caption => GoogleFonts.beVietnamPro(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.foregroundTertiary,
      );

  static TextStyle get button => GoogleFonts.beVietnamPro(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );
}
