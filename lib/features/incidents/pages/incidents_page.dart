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

class IncidentsPage extends StatefulWidget {
  const IncidentsPage({super.key});

  @override
  State<IncidentsPage> createState() => _IncidentsPageState();
}

class _IncidentsPageState extends State<IncidentsPage> {
  String _query = '';
  String? _priority;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final filtered = MockData.incidents.where((i) {
      final q = _query.isEmpty || i.title.toLowerCase().contains(_query.toLowerCase());
      final p = _priority == null || _priority == 'all' || i.priority == _priority;
      return q && p;
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
                (s.t('Incidents'), null),
              ]),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: Text(s.t('Incidents'), style: AppTypography.title.copyWith(fontSize: 24))),
                  AppButton(
                    label: s.t('Create'),
                    size: AppButtonSize.small,
                    onPressed: () => context.go(AppRoutes.incidentsCreate),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => context.go(AppRoutes.incidentsMe),
                child: Text(s.t('My incidents')),
              ),
              AppTextField(
                hint: s.t('Search'),
                prefixIcon: const Icon(Icons.search, size: 18),
                onChanged: (v) => setState(() => _query = v),
              ),
              const SizedBox(height: 8),
              AppSelect<String>(
                label: s.t('Priority'),
                value: _priority ?? 'all',
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('All')),
                  DropdownMenuItem(value: 'critical', child: Text('Critical')),
                  DropdownMenuItem(value: 'high', child: Text('High')),
                  DropdownMenuItem(value: 'medium', child: Text('Medium')),
                  DropdownMenuItem(value: 'low', child: Text('Low')),
                ],
                onChanged: (v) => setState(() => _priority = v),
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
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return AppCard(
                      onTap: () => context.go(AppRoutes.incidentDetail(item.id)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(item.title, style: AppTypography.headline.copyWith(fontSize: 15)),
                              ),
                              StatusTag(status: item.status),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AppBadge(label: item.priority),
                          const SizedBox(height: 6),
                          Text(item.location, style: AppTypography.bodySecondary),
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

class IncidentCreatePage extends StatefulWidget {
  const IncidentCreatePage({super.key});

  @override
  State<IncidentCreatePage> createState() => _IncidentCreatePageState();
}

class _IncidentCreatePageState extends State<IncidentCreatePage> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _location = TextEditingController();
  String _priority = 'medium';

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
          (s.t('Incidents'), AppRoutes.incidents),
          (s.t('Create'), null),
        ]),
        const SizedBox(height: 12),
        Text(s.t('Report an incident'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        AppTextField(controller: _title, label: s.t('Title')),
        const SizedBox(height: 12),
        AppTextField(controller: _description, label: s.t('Description'), maxLines: 5),
        const SizedBox(height: 12),
        AppTextField(controller: _location, label: s.t('Location')),
        const SizedBox(height: 12),
        AppSelect<String>(
          label: s.t('Priority'),
          value: _priority,
          items: const [
            DropdownMenuItem(value: 'critical', child: Text('Critical')),
            DropdownMenuItem(value: 'high', child: Text('High')),
            DropdownMenuItem(value: 'medium', child: Text('Medium')),
            DropdownMenuItem(value: 'low', child: Text('Low')),
          ],
          onChanged: (v) => setState(() => _priority = v ?? 'medium'),
        ),
        const SizedBox(height: 12),
        Container(
          height: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderInput.withValues(alpha: 0.4)),
          ),
          child: Text('Image upload placeholder', style: AppTypography.caption),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: s.t('Submit'),
          expanded: true,
          onPressed: () {
            // TODO: implement incident create
            context.go(AppRoutes.incidents);
          },
        ),
      ],
    );
  }
}

class IncidentMePage extends StatelessWidget {
  const IncidentMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppBreadcrumbs(items: [
          (s.t('Incidents'), AppRoutes.incidents),
          (s.t('My incidents'), null),
        ]),
        const SizedBox(height: 12),
        Text(s.t('My incidents'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text(s.t('Title'))),
              DataColumn(label: Text(s.t('Status'))),
              DataColumn(label: Text(s.t('Priority'))),
              DataColumn(label: Text(s.t('Details'))),
            ],
            rows: [
              for (final i in MockData.incidents)
                DataRow(cells: [
                  DataCell(Text(i.title)),
                  DataCell(StatusTag(status: i.status)),
                  DataCell(Text(i.priority)),
                  DataCell(
                    TextButton(
                      onPressed: () => context.go(AppRoutes.incidentDetail(i.id)),
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

class IncidentDetailPage extends StatelessWidget {
  const IncidentDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final item = MockData.incidentById(id);
    if (item == null) return AppEmpty(message: s.t('No data'));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppBreadcrumbs(items: [
          (s.t('Incidents'), AppRoutes.incidents),
          (item.title, null),
        ]),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(AppAssets.reportTrash, height: 160, width: double.infinity, fit: BoxFit.cover),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: Text(item.title, style: AppTypography.title.copyWith(fontSize: 22))),
            StatusTag(status: item.status),
          ],
        ),
        const SizedBox(height: 8),
        AppBadge(label: item.priority),
        const SizedBox(height: 16),
        Text(s.t('Description'), style: AppTypography.headline.copyWith(fontSize: 16)),
        const SizedBox(height: 6),
        Text(item.description, style: AppTypography.bodySecondary),
        const SizedBox(height: 16),
        Text(s.t('Location'), style: AppTypography.headline.copyWith(fontSize: 16)),
        const SizedBox(height: 6),
        Text(item.location, style: AppTypography.bodySecondary),
        const SizedBox(height: 8),
        Text('Reporter: ${item.reporter}', style: AppTypography.caption),
      ],
    );
  }
}
