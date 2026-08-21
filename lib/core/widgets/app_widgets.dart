import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

class AppSelect<T> extends StatelessWidget {
  const AppSelect({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hint,
  });

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTypography.body.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
        ],
        DropdownButtonFormField<T>(
          key: ValueKey(value),
          initialValue: value,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(hintText: hint),
          borderRadius: BorderRadius.circular(AppTheme.radius),
        ),
      ],
    );
  }
}

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.background = AppColors.backgroundSecondary,
    this.foreground = AppColors.foregroundPrimary,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: AppTypography.caption.copyWith(color: foreground, fontWeight: FontWeight.w600)),
    );
  }
}

class StatusTag extends StatelessWidget {
  const StatusTag({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final lower = status.toLowerCase();
    final (bg, fg) = switch (lower) {
      'active' || 'approved' || 'completed' || 'open' => (
          const Color(0xFFD1FADF),
          AppColors.success,
        ),
      'pending' || 'in_progress' || 'review' => (
          const Color(0xFFFEF0C7),
          const Color(0xFFB54708),
        ),
      'rejected' || 'closed' || 'cancelled' => (
          const Color(0xFFFEE4E2),
          AppColors.error,
        ),
      _ => (AppColors.backgroundSecondary, AppColors.foregroundSecondary),
    };
    return AppBadge(label: status, background: bg, foreground: fg);
  }
}

class AppEmpty extends StatelessWidget {
  const AppEmpty({super.key, this.message = 'No data', this.icon});

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? Icons.inbox_outlined, size: 48, color: AppColors.foregroundTertiary),
            const SizedBox(height: 12),
            Text(message, style: AppTypography.bodySecondary, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({super.key, this.height = 16, this.width, this.radius = 8});

  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.onTap, this.padding});

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
