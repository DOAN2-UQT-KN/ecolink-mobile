import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EcoLinkApp());
}

class EcoLinkApp extends StatefulWidget {
  const EcoLinkApp({super.key});

  @override
  State<EcoLinkApp> createState() => _EcoLinkAppState();
}

class _EcoLinkAppState extends State<EcoLinkApp> {
  Locale _locale = const Locale('en');
  late final _router = createAppRouter();

  @override
  Widget build(BuildContext context) {
    return AppStrings(
      locale: _locale,
      onLocaleChanged: (locale) => setState(() => _locale = locale),
      child: MaterialApp.router(
        title: 'EcoLink',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        locale: _locale,
        supportedLocales: const [Locale('en'), Locale('vi')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: _router,
      ),
    );
  }
}
