import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/app_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return ListView(
      children: [
        _HeroSection(s: s),
        const SizedBox(height: 32),
        _ProblemAndSolution(s: s),
        const SizedBox(height: 32),
        _ForVolunteers(s: s),
        const SizedBox(height: 32),
        _CallToAction(s: s),
        const SizedBox(height: 24),
        const AppFooter(),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.s});
  final AppStrings s;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.backgroundPrimary, AppColors.backgroundSecondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('EcoLink', style: AppTypography.logo.copyWith(fontSize: 36)),
          const SizedBox(height: 12),
          Text(
            s.t('Connecting communities for a cleaner environment.'),
            style: AppTypography.title.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 12),
          Text(
            'Report incidents, join campaigns, and earn rewards for taking action.',
            style: AppTypography.bodySecondary,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AppButton(
                label: s.t('Explore campaigns'),
                onPressed: () => context.go(AppRoutes.campaigns),
              ),
              AppButton(
                label: s.t('Report an incident'),
                variant: AppButtonVariant.outlinedBrown,
                onPressed: () => context.go(AppRoutes.incidentsCreate),
              ),
            ],
          ),
          const SizedBox(height: 28),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AppAssets.hero,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProblemAndSolution extends StatelessWidget {
  const _ProblemAndSolution({required this.s});
  final AppStrings s;

  @override
  Widget build(BuildContext context) {
    final items = [
      (AppAssets.reportTrash, 'Report trash', 'Flag pollution hotspots in your neighborhood.'),
      (AppAssets.trackProgress, 'Track progress', 'Follow cleanup campaigns from start to finish.'),
      (AppAssets.supportMovement, 'Support movement', 'Join organizations and amplify impact.'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Problem & Solution', style: AppTypography.title.copyWith(fontSize: 24)),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(item.$1, width: 88, height: 88, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.$2, style: AppTypography.headline.copyWith(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(item.$3, style: AppTypography.bodySecondary),
                      ],
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

class _ForVolunteers extends StatelessWidget {
  const _ForVolunteers({required this.s});
  final AppStrings s;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('For Volunteers', style: AppTypography.title.copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            'Discover campaigns near you, complete tasks, and collect points.',
            style: AppTypography.bodySecondary,
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AppAssets.takeActionMobile,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _CallToAction extends StatelessWidget {
  const _CallToAction({required this.s});
  final AppStrings s;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundQuaternary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.t('Take action'),
            style: AppTypography.title.copyWith(color: AppColors.white, fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text(
            'Start with a campaign or report an environmental incident today.',
            style: AppTypography.body.copyWith(color: AppColors.white.withValues(alpha: 0.9)),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: s.t('Sign up'),
            variant: AppButtonVariant.brown,
            onPressed: () => context.go(AppRoutes.signUp),
          ),
        ],
      ),
    );
  }
}
