import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_strings.dart';
import 'app_logo.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return AppBar(
      titleSpacing: 16,
      title: GestureDetector(
        onTap: () => context.go(AppRoutes.home),
        child: const AppLogo(height: 32),
      ),
      actions: [
        IconButton(
          tooltip: s.t('Maps'),
          onPressed: () => context.go(AppRoutes.maps),
          icon: const Icon(Icons.map_outlined),
        ),
        IconButton(
          tooltip: s.t('Notifications'),
          onPressed: () {
            // TODO: implement notifications menu
          },
          icon: const Icon(Icons.notifications_outlined),
        ),
        PopupMenuButton<String>(
          tooltip: s.t('Menu'),
          onSelected: (value) => context.go(value),
          itemBuilder: (context) => [
            PopupMenuItem(value: AppRoutes.campaigns, child: Text(s.t('Campaigns'))),
            PopupMenuItem(value: AppRoutes.incidents, child: Text(s.t('Incidents'))),
            PopupMenuItem(value: AppRoutes.organizations, child: Text(s.t('Organizations'))),
            PopupMenuItem(value: AppRoutes.gifts, child: Text(s.t('Gifts'))),
            PopupMenuItem(value: AppRoutes.profileAccount, child: Text(s.t('Profile'))),
            PopupMenuItem(value: AppRoutes.signIn, child: Text(s.t('Sign in'))),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.backgroundSecondary,
              backgroundImage: const AssetImage(AppAssets.defaultAvatar),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      color: AppColors.backgroundQuaternary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppLogo(height: 28),
          const SizedBox(height: 12),
          Text(
            s.t('Connecting communities for a cleaner environment.'),
            style: AppTypography.body.copyWith(color: AppColors.white.withValues(alpha: 0.9)),
          ),
          const SizedBox(height: 16),
          Text(
            '© ${DateTime.now().year} EcoLink',
            style: AppTypography.caption.copyWith(color: AppColors.white.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}

class AppBreadcrumbs extends StatelessWidget {
  const AppBreadcrumbs({super.key, required this.items});

  final List<(String label, String? path)> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text('/', style: AppTypography.caption),
            ),
          GestureDetector(
            onTap: items[i].$2 == null ? null : () => context.go(items[i].$2!),
            child: Text(
              items[i].$1,
              style: AppTypography.caption.copyWith(
                color: i == items.length - 1
                    ? AppColors.foregroundPrimary
                    : AppColors.backgroundQuaternary,
                fontWeight: i == items.length - 1 ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
