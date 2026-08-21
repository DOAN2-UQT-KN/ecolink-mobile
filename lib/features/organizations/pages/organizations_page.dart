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

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final filtered = MockData.organizations
        .where((o) => _query.isEmpty || o.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBreadcrumbs(items: [
                (s.t('Homepage'), AppRoutes.home),
                (s.t('Organizations'), null),
              ]),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(s.t('Organizations'), style: AppTypography.title.copyWith(fontSize: 24)),
                  ),
                  AppButton(
                    label: s.t('Create'),
                    size: AppButtonSize.small,
                    onPressed: () => context.go(AppRoutes.organizationsCreate),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => context.go(AppRoutes.organizationsMe),
                child: Text(s.t('My organizations')),
              ),
              AppTextField(
                hint: s.t('Search'),
                prefixIcon: const Icon(Icons.search, size: 18),
                onChanged: (v) => setState(() => _query = v),
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
                    final org = filtered[index];
                    return AppCard(
                      onTap: () => context.go(AppRoutes.organizationDetail(org.slug)),
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              AppAssets.collectTrash,
                              height: 110,
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
                                      child: Text(org.name, style: AppTypography.headline.copyWith(fontSize: 16)),
                                    ),
                                    StatusTag(status: org.status),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text('${org.memberCount} ${s.t('Members')}', style: AppTypography.caption),
                                Text(org.location, style: AppTypography.bodySecondary),
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

class OrganizationCreatePage extends StatefulWidget {
  const OrganizationCreatePage({super.key});

  @override
  State<OrganizationCreatePage> createState() => _OrganizationCreatePageState();
}

class _OrganizationCreatePageState extends State<OrganizationCreatePage> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _location = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
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
          (s.t('Organizations'), AppRoutes.organizations),
          (s.t('Create'), null),
        ]),
        const SizedBox(height: 12),
        Text(s.t('Create'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        AppTextField(controller: _name, label: 'Name'),
        const SizedBox(height: 12),
        AppTextField(controller: _description, label: s.t('Description'), maxLines: 5),
        const SizedBox(height: 12),
        AppTextField(controller: _location, label: s.t('Location')),
        const SizedBox(height: 20),
        AppButton(
          label: s.t('Submit'),
          expanded: true,
          onPressed: () {
            // TODO: implement organization create
            context.go(AppRoutes.organizations);
          },
        ),
      ],
    );
  }
}

class OrganizationMePage extends StatelessWidget {
  const OrganizationMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppBreadcrumbs(items: [
          (s.t('Organizations'), AppRoutes.organizations),
          (s.t('My organizations'), null),
        ]),
        const SizedBox(height: 12),
        Text(s.t('My organizations'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        for (final org in MockData.organizations)
          AppCard(
            onTap: () => context.go(AppRoutes.organizationDetail(org.slug)),
            child: Row(
              children: [
                Expanded(child: Text(org.name, style: AppTypography.headline.copyWith(fontSize: 15))),
                StatusTag(status: org.status),
              ],
            ),
          ),
      ],
    );
  }
}

class OrganizationDetailPage extends StatefulWidget {
  const OrganizationDetailPage({super.key, required this.slug});
  final String slug;

  @override
  State<OrganizationDetailPage> createState() => _OrganizationDetailPageState();
}

class _OrganizationDetailPageState extends State<OrganizationDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

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
    final org = MockData.organizationBySlug(widget.slug);
    if (org == null) return AppEmpty(message: s.t('No data'));

    return NestedScrollView(
      headerSliverBuilder: (context, _) => [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppAssets.collectTrash, height: 150, width: double.infinity, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBreadcrumbs(items: [
                      (s.t('Organizations'), AppRoutes.organizations),
                      (org.name, null),
                    ]),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: Text(org.name, style: AppTypography.title.copyWith(fontSize: 24))),
                        StatusTag(status: org.status),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(org.description, style: AppTypography.bodySecondary),
                    const SizedBox(height: 12),
                    AppButton(
                      label: s.t('Join'),
                      onPressed: () {
                        // TODO: implement join organization
                      },
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabs,
                labelColor: AppColors.backgroundQuaternary,
                tabs: [
                  Tab(text: s.t('Campaigns')),
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
              for (final c in MockData.campaigns)
                AppCard(
                  onTap: () => context.go(AppRoutes.campaignDetail(c.id)),
                  child: Text(c.title),
                ),
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (var i = 0; i < org.memberCount.clamp(0, 8); i++)
                ListTile(
                  leading: const CircleAvatar(backgroundImage: AssetImage(AppAssets.defaultAvatar)),
                  title: Text('Member ${i + 1}'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
