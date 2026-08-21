import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/app_logo.dart';

class GoogleCallbackPage extends StatelessWidget {
  const GoogleCallbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Column(
      children: [
        const AppLogo(height: 40),
        const SizedBox(height: 32),
        Text('Google OAuth callback', style: AppTypography.headline),
        const SizedBox(height: 8),
        Text(
          'Placeholder UI — no OAuth processing.',
          style: AppTypography.bodySecondary,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        AppButton(
          label: s.t('Back to home'),
          onPressed: () => context.go(AppRoutes.home),
        ),
      ],
    );
  }
}
