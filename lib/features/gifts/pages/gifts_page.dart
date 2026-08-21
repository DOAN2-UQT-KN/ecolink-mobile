import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../l10n/app_strings.dart';
import '../../../mock/mock_data.dart';
import '../../../shared/widgets/app_header.dart';

class GiftsPage extends StatelessWidget {
  const GiftsPage({super.key});

  Future<void> _showRedeemDialog(BuildContext context, MockGift gift) async {
    final s = AppStrings.of(context);
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.t('Redeem')),
        content: Text('Redeem "${gift.name}" for ${gift.pointsCost} ${s.t('Points')}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.t('Cancel')),
          ),
          AppButton(
            label: s.t('Redeem'),
            size: AppButtonSize.small,
            onPressed: () {
              // TODO: implement gift redeem
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('TODO: redeem gift')),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppBreadcrumbs(items: [
          (s.t('Homepage'), AppRoutes.home),
          (s.t('Gifts'), null),
        ]),
        const SizedBox(height: 12),
        Text(s.t('Gifts'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          '${s.t('My points')}: ${MockData.currentUser.points}',
          style: AppTypography.bodySecondary,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: MockData.gifts.length,
          gridDelegate: const SpacedGridDelegate(),
          itemBuilder: (context, index) {
            final gift = MockData.gifts[index];
            return AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: AppColors.backgroundSecondary,
                      child: Image.asset(AppAssets.supportMovement, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(gift.name, style: AppTypography.headline.copyWith(fontSize: 14)),
                        const SizedBox(height: 4),
                        Text('${gift.pointsCost} ${s.t('Points')}', style: AppTypography.caption),
                        const SizedBox(height: 8),
                        AppButton(
                          label: s.t('Redeem'),
                          size: AppButtonSize.small,
                          expanded: true,
                          onPressed: () => _showRedeemDialog(context, gift),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class SpacedGridDelegate extends SliverGridDelegateWithFixedCrossAxisCount {
  const SpacedGridDelegate()
      : super(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.72,
        );
}
