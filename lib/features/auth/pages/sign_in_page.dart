import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../l10n/app_strings.dart';
import '../../../shared/widgets/app_logo.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
        Text(s.t('Sign in'), style: AppTypography.title.copyWith(fontSize: 28)),
        const SizedBox(height: 24),
        AppTextField(controller: _email, label: s.t('Email'), hint: 'you@example.com'),
        const SizedBox(height: 12),
        AppTextField(
          controller: _password,
          label: s.t('Password'),
          obscureText: true,
          hint: '••••••••',
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => context.go(AppRoutes.requestResetPassword),
            child: Text(s.t('Forgot password?')),
          ),
        ),
        AppButton(
          label: s.t('Sign in'),
          expanded: true,
          onPressed: () {
            // TODO: implement sign-in logic
            context.go(AppRoutes.home);
          },
        ),
        const SizedBox(height: 12),
        AppButton(
          label: s.t('Continue with Google'),
          variant: AppButtonVariant.outlinedGreen,
          expanded: true,
          icon: Image.asset(AppAssets.google, width: 18, height: 18),
          onPressed: () {
            // TODO: implement Google OAuth
            context.go(AppRoutes.googleCallback);
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(s.t("Don't have an account?"), style: AppTypography.bodySecondary),
            TextButton(
              onPressed: () => context.go(AppRoutes.signUp),
              child: Text(s.t('Sign up')),
            ),
          ],
        ),
      ],
    );
  }
}
