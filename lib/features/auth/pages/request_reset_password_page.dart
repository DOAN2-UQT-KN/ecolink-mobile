import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/app_logo.dart';

class RequestResetPasswordPage extends StatefulWidget {
  const RequestResetPasswordPage({super.key});

  @override
  State<RequestResetPasswordPage> createState() => _RequestResetPasswordPageState();
}

class _RequestResetPasswordPageState extends State<RequestResetPasswordPage> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
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
        Text(s.t('Request reset password'), style: AppTypography.title.copyWith(fontSize: 24)),
        const SizedBox(height: 8),
        Text(
          'Enter your email and we will send a reset link.',
          style: AppTypography.bodySecondary,
        ),
        const SizedBox(height: 24),
        AppTextField(controller: _email, label: s.t('Email')),
        const SizedBox(height: 20),
        AppButton(
          label: s.t('Submit'),
          expanded: true,
          onPressed: () {
            // TODO: implement request reset password
            context.go(AppRoutes.resetPassword);
          },
        ),
        TextButton(
          onPressed: () => context.go(AppRoutes.signIn),
          child: Text(s.t('Sign in')),
        ),
      ],
    );
  }
}
