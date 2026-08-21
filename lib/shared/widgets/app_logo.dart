import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_typography.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 36, this.showText = true});

  final double height;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(AppAssets.logo, height: height),
        if (showText) ...[
          const SizedBox(width: 8),
          Text('EcoLink', style: AppTypography.logo.copyWith(fontSize: height * 0.7)),
        ],
      ],
    );
  }
}
