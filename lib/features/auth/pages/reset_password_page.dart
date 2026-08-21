import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/app_logo.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppLogo(height: 40),
        const SizedBox(height: 24),
        Text(s.t('Reset password'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 24),
        AppTextField(controller: _password, label: s.t('Password'), obscureText: true),
        const SizedBox(height: 12),
        AppTextField(controller: _confirm, label: s.t('Confirm password'), obscureText: true),
        const SizedBox(height: 20),
        AppButton(
          label: s.t('Save'),
          expanded: true,
          onPressed: () {
            // TODO: implement reset password
            context.go(AppRoutes.signIn);
          },
        ),
      ],
    );
  }
}
