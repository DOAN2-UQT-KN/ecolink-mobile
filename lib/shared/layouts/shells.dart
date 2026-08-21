import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_strings.dart';
import '../widgets/app_header.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: child,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backgroundQuaternary,
        foregroundColor: AppColors.white,
        tooltip: 'AI Chat',
        onPressed: () {
          // TODO: implement AI chat widget
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('TODO: AI chat')),
          );
        },
        child: const Icon(Icons.chat_bubble_outline),
      ),
      bottomNavigationBar: const _MainBottomNav(),
    );
  }
}

class _MainBottomNav extends StatelessWidget {
  const _MainBottomNav();

  int _indexForLocation(String location) {
    if (location.startsWith('/campaigns')) return 1;
    if (location.startsWith('/incidents')) return 2;
    if (location.startsWith('/organizations')) return 3;
    if (location.startsWith('/gifts') || location.startsWith('/profile')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final location = GoRouterState.of(context).uri.toString();
    final index = _indexForLocation(location);

    return NavigationBar(
      selectedIndex: index,
      backgroundColor: AppColors.white,
      indicatorColor: AppColors.backgroundSecondary,
      onDestinationSelected: (i) {
        switch (i) {
          case 0:
            context.go(AppRoutes.home);
          case 1:
            context.go(AppRoutes.campaigns);
          case 2:
            context.go(AppRoutes.incidents);
          case 3:
            context.go(AppRoutes.organizations);
          case 4:
            context.go(AppRoutes.profileAccount);
        }
      },
      destinations: [
        NavigationDestination(icon: const Icon(Icons.home_outlined), label: s.t('Homepage')),
        NavigationDestination(icon: const Icon(Icons.flag_outlined), label: s.t('Campaigns')),
        NavigationDestination(icon: const Icon(Icons.warning_amber_outlined), label: s.t('Incidents')),
        NavigationDestination(icon: const Icon(Icons.apartment_outlined), label: s.t('Organizations')),
        NavigationDestination(icon: const Icon(Icons.person_outline), label: s.t('Profile')),
      ],
    );
  }
}

class AuthShell extends StatelessWidget {
  const AuthShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      body: Row(
        children: [
          if (wide)
            Expanded(
              flex: 6,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/auth-bg.jpeg',
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withValues(alpha: 0.25)),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        s.t('Connecting communities for a cleaner environment.'),
                        style: AppTypography.title.copyWith(color: AppColors.white, fontSize: 28),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            flex: 4,
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: _LanguageSwitcher(),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'en', label: Text('EN')),
        ButtonSegment(value: 'vi', label: Text('VI')),
      ],
      selected: {strings.locale.languageCode},
      onSelectionChanged: (set) {
        strings.onLocaleChanged(Locale(set.first));
      },
    );
  }
}

class ProfileShell extends StatelessWidget {
  const ProfileShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final location = GoRouterState.of(context).uri.path;
    final wide = MediaQuery.sizeOf(context).width >= 800;

    final tabs = [
      (AppRoutes.profileAccount, s.t('Account'), Icons.person_outline),
      (AppRoutes.profileNotifications, s.t('Notification settings'), Icons.notifications_outlined),
      (AppRoutes.profilePoints, s.t('My points'), Icons.monetization_on_outlined),
      (AppRoutes.profileOrders, s.t('Orders'), Icons.shopping_bag_outlined),
    ];

    final nav = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final tab in tabs)
          ListTile(
            selected: location == tab.$1,
            selectedTileColor: AppColors.backgroundSecondary.withValues(alpha: 0.5),
            leading: Icon(tab.$3, size: 20),
            title: Text(tab.$2, style: AppTypography.body),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onTap: () => context.go(tab.$1),
          ),
      ],
    );

    if (wide) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 220, child: nav),
            const SizedBox(width: 16),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              for (final tab in tabs)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(tab.$2),
                    selected: location == tab.$1,
                    onSelected: (_) => context.go(tab.$1),
                  ),
                ),
            ],
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}

class MapsShell extends StatelessWidget {
  const MapsShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}
