import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../l10n/app_strings.dart';
import '../../../mock/mock_data.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  bool _showFilters = true;
  bool _showSos = false;
  String? _statusFilter = 'all';
  final _sosNote = TextEditingController();

  @override
  void dispose() {
    _sosNote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Stack(
      children: [
        FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(10.7769, 106.7009),
            initialZoom: 12,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.ecolink.ecolink_mobile',
            ),
            MarkerLayer(
              markers: [
                for (final incident in MockData.incidents)
                  Marker(
                    point: LatLng(
                      10.7769 + (incident.id.hashCode % 50) / 1000,
                      106.7009 + (incident.id.hashCode % 40) / 1000,
                    ),
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () => context.go(AppRoutes.incidentDetail(incident.id)),
                      child: const Icon(Icons.location_on, color: AppColors.error, size: 32),
                    ),
                  ),
              ],
            ),
          ],
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Material(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  child: IconButton(
                    onPressed: () => context.go(AppRoutes.home),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                const Spacer(),
                Material(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  child: IconButton(
                    onPressed: () => setState(() => _showFilters = !_showFilters),
                    icon: const Icon(Icons.filter_list),
                  ),
                ),
                const SizedBox(width: 8),
                AppButton(
                  label: s.t('SOS'),
                  variant: AppButtonVariant.brown,
                  size: AppButtonSize.small,
                  onPressed: () => setState(() => _showSos = true),
                ),
              ],
            ),
          ),
        ),
        if (_showFilters)
          Positioned(
            top: 88,
            left: 12,
            right: 12,
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(s.t('Filter'), style: AppTypography.headline.copyWith(fontSize: 15)),
                    const SizedBox(height: 8),
                    AppSelect<String>(
                      label: s.t('Status'),
                      value: _statusFilter,
                      items: const [
                        DropdownMenuItem(value: 'all', child: Text('All')),
                        DropdownMenuItem(value: 'open', child: Text('Open')),
                        DropdownMenuItem(value: 'in_progress', child: Text('In progress')),
                        DropdownMenuItem(value: 'resolved', child: Text('Resolved')),
                      ],
                      onChanged: (v) => setState(() => _statusFilter = v),
                    ),
                    const SizedBox(height: 8),
                    AppButton(
                      label: s.t('Apply filters'),
                      size: AppButtonSize.small,
                      onPressed: () {
                        // TODO: implement map filter logic
                        setState(() => _showFilters = false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (_showSos)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.white,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(s.t('SOS'), style: AppTypography.title.copyWith(fontSize: 22)),
                        const SizedBox(height: 8),
                        Text(
                          'Describe the emergency. Location uses map center (mock).',
                          style: AppTypography.bodySecondary,
                        ),
                        const SizedBox(height: 12),
                        AppTextField(controller: _sosNote, label: s.t('Description'), maxLines: 4),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                label: s.t('Cancel'),
                                variant: AppButtonVariant.outlinedBrown,
                                onPressed: () => setState(() => _showSos = false),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AppButton(
                                label: s.t('Submit'),
                                onPressed: () {
                                  // TODO: implement SOS submit
                                  setState(() => _showSos = false);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
