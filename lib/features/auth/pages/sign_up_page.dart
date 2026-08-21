import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/app_logo.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
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
        Text(s.t('Sign up'), style: AppTypography.title.copyWith(fontSize: 28)),
        const SizedBox(height: 24),
        AppTextField(controller: _name, label: s.t('Full name')),
        const SizedBox(height: 12),
        AppTextField(controller: _email, label: s.t('Email')),
        const SizedBox(height: 12),
        AppTextField(controller: _password, label: s.t('Password'), obscureText: true),
        const SizedBox(height: 12),
        AppTextField(controller: _confirm, label: s.t('Confirm password'), obscureText: true),
        const SizedBox(height: 20),
        AppButton(
          label: s.t('Sign up'),
          expanded: true,
          onPressed: () {
            // TODO: implement sign-up logic
            context.go(AppRoutes.authenticate);
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(s.t('Already have an account?'), style: AppTypography.bodySecondary),
            TextButton(
              onPressed: () => context.go(AppRoutes.signIn),
              child: Text(s.t('Sign in')),
            ),
          ],
        ),
      ],
    );
  }
}
