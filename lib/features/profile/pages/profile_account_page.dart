import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../l10n/app_strings.dart';
import '../../../mock/mock_data.dart';

class ProfileAccountPage extends StatefulWidget {
  const ProfileAccountPage({super.key});

  @override
  State<ProfileAccountPage> createState() => _ProfileAccountPageState();
}

class _ProfileAccountPageState extends State<ProfileAccountPage> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _address;

  @override
  void initState() {
    super.initState();
    final u = MockData.currentUser;
    _name = TextEditingController(text: u.fullName);
    _email = TextEditingController(text: u.email);
    _address = TextEditingController(text: u.address ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(s.t('Account'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        Center(
          child: CircleAvatar(
            radius: 48,
            backgroundImage: const AssetImage(AppAssets.profile),
            backgroundColor: AppColors.backgroundSecondary,
          ),
        ),
        const SizedBox(height: 20),
        Text(s.t('General information'), style: AppTypography.headline.copyWith(fontSize: 16)),
        const SizedBox(height: 12),
        AppTextField(controller: _name, label: s.t('Full name')),
        const SizedBox(height: 12),
        AppTextField(controller: _email, label: s.t('Email')),
        const SizedBox(height: 20),
        Text(s.t('Location'), style: AppTypography.headline.copyWith(fontSize: 16)),
        const SizedBox(height: 12),
        AppTextField(controller: _address, label: s.t('Location'), maxLines: 2),
        const SizedBox(height: 12),
        Container(
          height: 140,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('Map picker placeholder', style: AppTypography.caption),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: s.t('Save'),
          expanded: true,
          onPressed: () {
            // TODO: implement profile update
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('TODO: save profile')),
            );
          },
        ),
      ],
    );
  }
}

class ProfileNotificationsPage extends StatefulWidget {
  const ProfileNotificationsPage({super.key});

  @override
  State<ProfileNotificationsPage> createState() => _ProfileNotificationsPageState();
}

class _ProfileNotificationsPageState extends State<ProfileNotificationsPage> {
  bool _campaigns = true;
  bool _incidents = true;
  bool _gifts = false;
  bool _system = true;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(s.t('Notification settings'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 12),
        SwitchListTile(
          title: Text(s.t('Campaigns')),
          value: _campaigns,
          activeThumbColor: AppColors.backgroundQuaternary,
          onChanged: (v) => setState(() => _campaigns = v),
        ),
        SwitchListTile(
          title: Text(s.t('Incidents')),
          value: _incidents,
          activeThumbColor: AppColors.backgroundQuaternary,
          onChanged: (v) => setState(() => _incidents = v),
        ),
        SwitchListTile(
          title: Text(s.t('Gifts')),
          value: _gifts,
          activeThumbColor: AppColors.backgroundQuaternary,
          onChanged: (v) => setState(() => _gifts = v),
        ),
        SwitchListTile(
          title: const Text('System'),
          value: _system,
          activeThumbColor: AppColors.backgroundQuaternary,
          onChanged: (v) => setState(() => _system = v),
        ),
        const SizedBox(height: 12),
        AppButton(
          label: s.t('Save'),
          onPressed: () {
            // TODO: implement notification settings save
          },
        ),
      ],
    );
  }
}

class ProfilePointsPage extends StatelessWidget {
  const ProfilePointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(s.t('My points'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            children: [
              Text('${MockData.currentUser.points}', style: AppTypography.titleLarge),
              Text(s.t('Points'), style: AppTypography.bodySecondary),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(s.t('Transaction history'), style: AppTypography.headline.copyWith(fontSize: 16)),
        const SizedBox(height: 8),
        for (final tx in MockData.transactions)
          AppCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tx.title, style: AppTypography.body.copyWith(fontWeight: FontWeight.w500)),
                      Text(tx.date, style: AppTypography.caption),
                    ],
                  ),
                ),
                Text(
                  tx.points > 0 ? '+${tx.points}' : '${tx.points}',
                  style: AppTypography.headline.copyWith(
                    fontSize: 16,
                    color: tx.points > 0 ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class ProfileOrdersPage extends StatelessWidget {
  const ProfileOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    if (MockData.orders.isEmpty) {
      return AppEmpty(message: s.t('No data'));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(s.t('Orders'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        for (final order in MockData.orders)
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(order.giftName, style: AppTypography.headline.copyWith(fontSize: 15)),
                    ),
                    StatusTag(status: order.status),
                  ],
                ),
                const SizedBox(height: 6),
                Text('${order.points} ${s.t('Points')} · ${order.date}', style: AppTypography.caption),
              ],
            ),
          ),
      ],
    );
  }
}
