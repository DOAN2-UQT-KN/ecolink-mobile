import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../l10n/app_strings.dart';
import '../../../mock/mock_data.dart';
import '../../../shared/widgets/app_header.dart';

class CampaignsPage extends StatefulWidget {
  const CampaignsPage({super.key});

  @override
  State<CampaignsPage> createState() => _CampaignsPageState();
}

class _CampaignsPageState extends State<CampaignsPage> with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  String _query = '';
  String? _status;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final filtered = MockData.campaigns.where((c) {
      final matchQuery = _query.isEmpty || c.title.toLowerCase().contains(_query.toLowerCase());
      final matchStatus = _status == null || _status == 'all' || c.status == _status;
      return matchQuery && matchStatus;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBreadcrumbs(items: [
                (s.t('Homepage'), AppRoutes.home),
                (s.t('Campaigns'), null),
              ]),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: Text(s.t('Campaigns'), style: AppTypography.title.copyWith(fontSize: 24))),
                  AppButton(
                    label: s.t('Create'),
                    size: AppButtonSize.small,
                    onPressed: () => context.go(AppRoutes.campaignsCreate),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TabBar(
                controller: _tabs,
                labelColor: AppColors.backgroundQuaternary,
                tabs: [
                  Tab(text: s.t('Explore campaigns')),
                  Tab(text: s.t('My campaigns')),
                ],
                onTap: (i) {
                  if (i == 1) context.go(AppRoutes.campaignsMe);
                },
              ),
              const SizedBox(height: 12),
              AppTextField(
                hint: s.t('Search'),
                prefixIcon: const Icon(Icons.search, size: 18),
                onChanged: (v) => setState(() => _query = v),
              ),
              const SizedBox(height: 8),
              AppSelect<String>(
                label: s.t('Status'),
                value: _status ?? 'all',
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('All')),
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'pending', child: Text('Pending')),
                  DropdownMenuItem(value: 'completed', child: Text('Completed')),
                ],
                onChanged: (v) => setState(() => _status = v),
              ),
            ],
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? AppEmpty(message: s.t('No data'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final c = filtered[index];
                    return AppCard(
                      onTap: () => context.go(AppRoutes.campaignDetail(c.id)),
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              AppAssets.bannerDefault,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(c.title, style: AppTypography.headline.copyWith(fontSize: 16)),
                                    ),
                                    StatusTag(status: c.status),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(c.organization, style: AppTypography.caption),
                                const SizedBox(height: 4),
                                Text(c.location, style: AppTypography.bodySecondary),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class CampaignCreatePage extends StatefulWidget {
  const CampaignCreatePage({super.key});

  @override
  State<CampaignCreatePage> createState() => _CampaignCreatePageState();
}

class _CampaignCreatePageState extends State<CampaignCreatePage> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _location = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppBreadcrumbs(items: [
          (s.t('Campaigns'), AppRoutes.campaigns),
          (s.t('Create'), null),
        ]),
        const SizedBox(height: 12),
        Text(s.t('Create'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        AppTextField(controller: _title, label: s.t('Title')),
        const SizedBox(height: 12),
        AppTextField(controller: _description, label: s.t('Description'), maxLines: 5),
        const SizedBox(height: 12),
        AppTextField(controller: _location, label: s.t('Location')),
        const SizedBox(height: 12),
        Container(
          height: 140,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderInput.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: Text('Banner upload placeholder', style: AppTypography.caption),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: s.t('Submit'),
          expanded: true,
          onPressed: () {
            // TODO: implement campaign create
            context.go(AppRoutes.campaigns);
          },
        ),
      ],
    );
  }
}

class CampaignMePage extends StatelessWidget {
  const CampaignMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppBreadcrumbs(items: [
          (s.t('Campaigns'), AppRoutes.campaigns),
          (s.t('My campaigns'), null),
        ]),
        const SizedBox(height: 12),
        Text(s.t('My campaigns'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text(s.t('Title'))),
              DataColumn(label: Text(s.t('Status'))),
              DataColumn(label: Text(s.t('Organization'))),
              DataColumn(label: Text(s.t('Details'))),
            ],
            rows: [
              for (final c in MockData.campaigns)
                DataRow(cells: [
                  DataCell(Text(c.title)),
                  DataCell(StatusTag(status: c.status)),
                  DataCell(Text(c.organization)),
                  DataCell(
                    TextButton(
                      onPressed: () => context.go(AppRoutes.campaignDetail(c.id)),
                      child: Text(s.t('Details')),
                    ),
                  ),
                ]),
            ],
          ),
        ),
      ],
    );
  }
}

class CampaignDetailPage extends StatefulWidget {
  const CampaignDetailPage({super.key, required this.id});
  final String id;

  @override
  State<CampaignDetailPage> createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final campaign = MockData.campaignById(widget.id);
    if (campaign == null) {
      return AppEmpty(message: s.t('No data'));
    }

    return NestedScrollView(
      headerSliverBuilder: (context, _) => [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.bannerDefault,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBreadcrumbs(items: [
                      (s.t('Campaigns'), AppRoutes.campaigns),
                      (campaign.title, null),
                    ]),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: Text(campaign.title, style: AppTypography.title.copyWith(fontSize: 24))),
                        StatusTag(status: campaign.status),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(campaign.organization, style: AppTypography.bodySecondary),
                    const SizedBox(height: 12),
                    AppButton(
                      label: s.t('Join'),
                      onPressed: () {
                        // TODO: implement join campaign
                      },
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabs,
                labelColor: AppColors.backgroundQuaternary,
                tabs: [
                  Tab(text: s.t('Overview')),
                  Tab(text: s.t('Tasks')),
                  Tab(text: s.t('Members')),
                ],
              ),
            ],
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabs,
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(s.t('Description'), style: AppTypography.headline.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              Text(campaign.description, style: AppTypography.bodySecondary),
              const SizedBox(height: 16),
              Text(s.t('Location'), style: AppTypography.headline.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              Text(campaign.location, style: AppTypography.bodySecondary),
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final task in ['Setup collection points', 'Volunteer briefing', 'Cleanup shift A'])
                AppCard(
                  child: Row(
                    children: [
                      const Icon(Icons.check_box_outlined, size: 18),
                      const SizedBox(width: 10),
                      Expanded(child: Text(task)),
                    ],
                  ),
                ),
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (var i = 0; i < 5; i++)
                ListTile(
                  leading: const CircleAvatar(backgroundImage: AssetImage(AppAssets.defaultAvatar)),
                  title: Text('Volunteer ${i + 1}'),
                  subtitle: Text(i == 0 ? 'Organizer' : 'Member'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
