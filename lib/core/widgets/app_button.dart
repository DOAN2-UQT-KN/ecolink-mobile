import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

enum AppButtonVariant { green, brown, outlinedGreen, outlinedBrown, text }

enum AppButtonSize { large, medium, small }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.green,
    this.size = AppButtonSize.medium,
    this.icon,
    this.expanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Widget? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final padding = switch (size) {
      AppButtonSize.large => const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      AppButtonSize.medium => const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      AppButtonSize.small => const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    };

    final (bg, fg, border) = switch (variant) {
      AppButtonVariant.green => (AppColors.backgroundQuaternary, AppColors.white, null),
      AppButtonVariant.brown => (AppColors.buttonAccent, AppColors.white, null),
      AppButtonVariant.outlinedGreen => (
          Colors.transparent,
          AppColors.backgroundQuaternary,
          AppColors.backgroundQuaternary,
        ),
      AppButtonVariant.outlinedBrown => (
          Colors.transparent,
          AppColors.buttonAccent,
          AppColors.buttonAccent,
        ),
      AppButtonVariant.text => (Colors.transparent, AppColors.backgroundQuaternary, null),
    };

    final child = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[icon!, const SizedBox(width: 8)],
        Text(label, style: AppTypography.button.copyWith(color: fg)),
      ],
    );

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(AppTheme.radius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppTheme.radius),
        child: Container(
          width: expanded ? double.infinity : null,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radius),
            border: border != null ? Border.all(color: border) : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
