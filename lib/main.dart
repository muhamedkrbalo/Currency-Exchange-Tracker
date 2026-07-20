import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/di/injection.dart';
import 'core/localization/app_localization.dart';
import 'core/localization/locale_keys.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: AppLocalization.supported,
      path: AppLocalization.path,
      fallbackLocale: AppLocalization.fallback,
      child: const CurrencyExchangeApp(),
    ),
  );
}

class CurrencyExchangeApp extends StatelessWidget {
  const CurrencyExchangeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LocaleKeys.app_title.tr(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Currency Exchange Tracker'),
        ),
      ),
    );
  }
}
